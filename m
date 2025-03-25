Return-Path: <linux-pm+bounces-24500-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7FAA70CE0
	for <lists+linux-pm@lfdr.de>; Tue, 25 Mar 2025 23:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01425189C4D3
	for <lists+linux-pm@lfdr.de>; Tue, 25 Mar 2025 22:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D0A269D18;
	Tue, 25 Mar 2025 22:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcWEUss3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2200269D04;
	Tue, 25 Mar 2025 22:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742941643; cv=none; b=X8yK2TLKjiYFqPuN6L5qvgNS6cpMtLBKSla/qvO9D2eY5AKqr4Xoy+k2kAe4+dQiUpZ0ziXIbuOUixot3uEE8E1CjpXZxIuT+8g9BEqzkAcLWs8DmJC7AK3Y3QMjcqGSLaE1xU64LpNKwGGa81jSCQKdZqaS9LYiqQEflyBbWtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742941643; c=relaxed/simple;
	bh=CjhTi+TCLM66pen4h3uAMenY0PpRUjXiB10TSDhkPjo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VmuTBu/lFewRdXnrLSmrbId7ST5QAvF1w5Pk9fgitNd7TW5WfAXxi2kv5aIEuSFnEAJpXnqWAv7NBH93T7j2LRfJke4kvY3e3X7M1MtLd0Sr+LuNW7rA0O956FQSTBb/OCpmaug+HT+OMMtIKBSulFU6PhCQfMwWpooF8nm/CBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcWEUss3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59BCC4CEE4;
	Tue, 25 Mar 2025 22:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742941643;
	bh=CjhTi+TCLM66pen4h3uAMenY0PpRUjXiB10TSDhkPjo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OcWEUss3sAXYW6VG2hooA8s+qYcKI3fdt9EnNrVcv2N4/9qX76eU8shHMRX4uXSxM
	 OalIbZFd5ILginOU1AVMb3yjAj7SDrCywGvEx4LfIj3ssufFNN3ZiAQHhEcHxi9zdM
	 +VL1rsha4mQnLt2xblAOxqX7MgRMRYMHozLaaZy6HQMYHMGyLVzxVZsW9Kmpyh54rB
	 G8b+m2RjVrvrlR71GyZHK+L6TIeg2Rk+Adwm4o+nBCvpLvzeHZtturY15t3S37K7JM
	 z+aXCWmW0xu4f/JkyONBGm6Ql4IKJgViiisbeYYpyuA5h5nmgznT8EB55LX2RyZ3h6
	 /r6Kp94czaGag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D72380DBFC;
	Tue, 25 Mar 2025 22:28:01 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control updates for v6.15-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gsHdE+Mt+8vMbUJMRuTUdiBTnUTonaGM_41EpPt9wS5g@mail.gmail.com>
References: <CAJZ5v0gsHdE+Mt+8vMbUJMRuTUdiBTnUTonaGM_41EpPt9wS5g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gsHdE+Mt+8vMbUJMRuTUdiBTnUTonaGM_41EpPt9wS5g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.15-rc1
X-PR-Tracked-Commit-Id: c3b659b74541f4564f9f5a39f65e625c47e77e21
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b3c623b9a94f7f798715c87e7a75ceeecf15292f
Message-Id: <174294167970.756596.8448296515241254975.pr-tracker-bot@kernel.org>
Date: Tue, 25 Mar 2025 22:27:59 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 24 Mar 2025 17:33:56 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b3c623b9a94f7f798715c87e7a75ceeecf15292f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

