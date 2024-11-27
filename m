Return-Path: <linux-pm+bounces-18186-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF70B9DAF94
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 00:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94F652822B4
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 23:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB24204F62;
	Wed, 27 Nov 2024 22:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEHRXY/t"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41392040BD;
	Wed, 27 Nov 2024 22:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732748355; cv=none; b=f12d7syMhifU3VoYWiBi3fcCL9b9u2zIyK7sWzZ7i8QpE6qpfsix8D43oBTs4FeZ987JJBzCSA5IHpkEzTgYqFyeoBEMXXX1m8685JOyjJLtDJYW1num/toXmgnRDpVqbePa94IodW3rb2glSMj0jpfVZGgU1vrw1zJylBqMC+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732748355; c=relaxed/simple;
	bh=B8lkb2gctRjsM6WjlOrsDvQeslhxeaYhEApqRLTV1ek=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cVIwKEwro1GVDsFMiVHCHWUSQRePTHX3wURrel+M+QiCmSQl7WdgdGp+tMpCeBCfaz7EqoviAjB28mpwDjfo3zPyTa8yZnhp+P3ul8R5ghJ0YoPg+EmrRibFghF1XbvrtpCrlB7wGTdKJt4TzG2K1wIocK4ZEzgndOIYVZkP1T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEHRXY/t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B8AC4CECC;
	Wed, 27 Nov 2024 22:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732748354;
	bh=B8lkb2gctRjsM6WjlOrsDvQeslhxeaYhEApqRLTV1ek=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QEHRXY/tQLrr8IdDir6WjjrOc0jTDR4BbxkdZsiCKqTQoK8Y83rPZOL+CPw89cI3f
	 vBGyoOiz4U19ojNn3qN9Q94ucnaYd+Y05tXpnm2DPlEGkOGbZSD3IRUy4CviEAGG0A
	 Y0UX0ssK3xGPkbv/f4V7ZXsOGYJp2BpSufXu8pQ4nWzJCnOD8F28VG2JgxA1UfjoI+
	 Hw8KQuft2tcTDqvbuJSbAnZT+oSl5H153Uxcv2LUR8pY1htwUV6Mjx34uKWq1w6sWH
	 0gJczeJwVmqbWgjVU9gYFNnUdZK5CRBgD70EJg0JoUXYnHtZVz0X4adg6Tj1AnodAw
	 5+BoxEGpbMMyQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F94380A944;
	Wed, 27 Nov 2024 22:59:28 +0000 (UTC)
Subject: Re: [GIT PULL] Additional power management updates for v6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jCibaDF1vZPDTs2YfJM-XK3O-S_si_xJSsZApEomPpvQ@mail.gmail.com>
References: <CAJZ5v0jCibaDF1vZPDTs2YfJM-XK3O-S_si_xJSsZApEomPpvQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jCibaDF1vZPDTs2YfJM-XK3O-S_si_xJSsZApEomPpvQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.13-rc1-3
X-PR-Tracked-Commit-Id: 07d66acad26bad33defbf26516d0a84261ae6adc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 79525e24af2f3046a5b4ed39a0ac6d0c00aa0892
Message-Id: <173274836707.1238022.16508845320317469985.pr-tracker-bot@kernel.org>
Date: Wed, 27 Nov 2024 22:59:27 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 27 Nov 2024 19:36:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.13-rc1-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/79525e24af2f3046a5b4ed39a0ac6d0c00aa0892

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

