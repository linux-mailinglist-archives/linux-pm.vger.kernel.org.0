Return-Path: <linux-pm+bounces-15986-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF7E9A45C6
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 20:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A9F11C21969
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 18:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A92206E66;
	Fri, 18 Oct 2024 18:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLVgnsl5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10447204093;
	Fri, 18 Oct 2024 18:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729275732; cv=none; b=uB+mWogMbgfNcMZL3WfPOeS211OeMxkcXOvju54dUIMSYn7ZxBhIW0j+ws6N8VjFLDwADoZ8wOjQzuYzbxLzXGldNlH2QuqFQOBMAQlUHOvIzM172eTNeZy5hMf5QK0ndfddRnhzjx9w30jyeMm2wzUQmglm23YBECcRxbDc4tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729275732; c=relaxed/simple;
	bh=pywa4KdgO+trGpQ8uLA8WXbVUylAxnug6plq2lulXKI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=k1ZMql738FxFf+v9CPGUST79F+KKLx4S9Uo53GkPz9T/KRGO5jfA581PRR5weRfVVPD8cY17qNw0LDWQTkU96HfXWslJmiKS7XphSCGHUmRX7SWgl4mwfM8fpjif2sho9HTRq+xjda2v1THxT5jfcYAIgC/idWTtaX+fw5OXqv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLVgnsl5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D96C4CEC7;
	Fri, 18 Oct 2024 18:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729275731;
	bh=pywa4KdgO+trGpQ8uLA8WXbVUylAxnug6plq2lulXKI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PLVgnsl5w+1KObDpvz1FuLVmsrNXVs98jU+JDK0TwFXD/YcYfdfRw0LTtOd/NqpGn
	 rWXDLFIQqvx8TwRyVuzxPeIF1NYWokoEH2Fy2QgishRrhL0Ym78kadvaZGy0NQmbBu
	 pXzsDb+OXOghwUQB5UkMS2EJPFFlubxWA+T4qR+fYZyuhLi+OeL5F9519Uq5IY6l1i
	 OkHBT0OQ0nIpjipH4s7OKjPTn9l5KxpTV+QYLUGgl1fc3QvsxKSQJTUGH+a49/Ke43
	 iaCWayYTTcVMm6P0eM5l5BjXrsku6B8447zVOJCvo5SrEwn8ZAhitGvjIttug/oZmN
	 fVSm9cbKNp7QA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF0C3805CC0;
	Fri, 18 Oct 2024 18:22:18 +0000 (UTC)
Subject: Re: [GIT PULL] Power management updates for v6.12-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hPF1RTBQiuY3NcG+qnbOKhEZQq4CyWoDSzdsJMTG5PJg@mail.gmail.com>
References: <CAJZ5v0hPF1RTBQiuY3NcG+qnbOKhEZQq4CyWoDSzdsJMTG5PJg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hPF1RTBQiuY3NcG+qnbOKhEZQq4CyWoDSzdsJMTG5PJg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.12-rc4
X-PR-Tracked-Commit-Id: cf8679bb77e99682a5a5806cc86554235fa56233
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5e9ab267bec1cf6d1127a7fabd7d7108865bb0fb
Message-Id: <172927573716.3196569.1969107036149606712.pr-tracker-bot@kernel.org>
Date: Fri, 18 Oct 2024 18:22:17 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 18 Oct 2024 18:30:37 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.12-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5e9ab267bec1cf6d1127a7fabd7d7108865bb0fb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

