<template>
	<div id="app">
		<div class="add-container">
			<form id="add-form" v-on:submit.prevent="checkForm">
				<label for="name">Add Task</label>
					<input id="name" v-model="title" type="text" name="title">
				<button>Add Task</button>
			</form>
		</div>
		<div class="items-container" v-for="status in todosStatuses" :key="status.label">
			<p class="items-label">{{status.label}}</p>
			<div class="item-container" v-for="todo in getTasks(status.done)" :key="todo.title">
				<span class="item-title">{{todo.title}}</span>
				<button class="item-action" v-on:click="todo.done = !todo.done">
					{{todo.done ? "Undo" : "Done"}}
				</button>
			</div>
			<p class="no-items-msg" v-if="!getTasks(status.done).length">No items</p>
		</div>
	</div>
</template>

<script lang="ts">
	import { Component, Vue } from 'vue-property-decorator';
	import { IToDo } from '@/models/todos.model';

	@Component
	export default class App extends Vue {
		public title = '';
		public todosStatuses = [
			{ label: 'ToDo', done: false },
			{ label: 'Done', done: true },
		];
		public dataSet: IToDo[] = [
			{ id: 1, title: 'Create Vue simple app', done: true },
			{ id: 2, title: 'Dockerize the app', done: true },
			{ id: 3, title: 'Start a new challenges', done: false },
		];

		public getTasks(isDone: boolean): IToDo[] {
			return this.dataSet.filter(item => item.done === isDone);
		}

		public checkForm(): void {
			if (this.title.length) {
				this.addTodo(this.title);
				this.title = '';
			}
		}

		private addTodo(title: string): void {
			this.dataSet.push({ id: this.dataSet.length, title: title, done: false  });
		}

	}
</script>

<style lang="scss">
	body {
		margin: 0;
		padding: 0;
	}
	#app {
		height: calc(100vh - 2px);
		width: 450px;
		margin: 0 auto;
		font-family: Avenir, Helvetica, Arial, sans-serif;
		-webkit-font-smoothing: antialiased;
		-moz-osx-font-smoothing: grayscale;
		border: 1px solid #2c3e50;
		border-radius: 5px;
		color: #2c3e50;
		overflow: auto;
	}
	.add-container {
		text-align: center;
		padding: 10px;

		label {
			margin-right: 5px;
		}
	}
	.items {
		&-container {
			margin: 5px;

			&:first-child {
				border-bottom: 1px solid #2c3e50;
			}
		}
		&-label {
			font-weight: 500;
		}
	}
	.item {
		&-container {
			padding: 8px;
		}
		&-action {
			float: right;
		}
	}
	.no-items-msg {
		text-align: center;
	}

	@media (max-width: 452px) {
		#app {
			width: 100%;
			margin: 0;
		}
	}
</style>
