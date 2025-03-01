Return-Path: <linux-pm+bounces-23210-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FC1A4A895
	for <lists+linux-pm@lfdr.de>; Sat,  1 Mar 2025 05:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED4607A7CC9
	for <lists+linux-pm@lfdr.de>; Sat,  1 Mar 2025 04:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1241B0F19;
	Sat,  1 Mar 2025 04:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHE3bw1i"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CF21ADC69;
	Sat,  1 Mar 2025 04:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740803364; cv=none; b=myvqB+0GWE+55P+/LgVEV1BV/BkRIJB6zsbnGkMZnESHux50v2iBhqjDKyhmS0cTZOIcG7NNvaneOemxPKnMejX7LK8OvumiRhBhbkXlZDhwwPpIedb7NJvpXfP0XzTrEvCgRr7pwdbzlQ1HYXF1c7Mq5yopbjFu7VEFj5i3wL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740803364; c=relaxed/simple;
	bh=QlMqZUF6PVsD/Q1uKf9ldioDq2PBkyyJ3o4p/4H4jrQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=U4DmqZ3hvdarllpievbhGQ1ThaJjwyTyW5EpbdkY4NKHUYpxHNmzzWPFwn9soW590z2RNEv7ijwHaOz3NziyfgFFtorC6hpUEschPLOLWmwkmO5CWwiXweea6sNBE9sIe+auJNDLnl2WiFQuqGt7KrgqvkK26A0VMoo994xFR/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHE3bw1i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31474C4AF53;
	Sat,  1 Mar 2025 04:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740803364;
	bh=QlMqZUF6PVsD/Q1uKf9ldioDq2PBkyyJ3o4p/4H4jrQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hHE3bw1ik51pzsdYnIbPDIJbP5zW+DQFIXXWkkHvjv5dOX/4GPimTK8dEpSNYuxRp
	 rSK/J+G3M6PFTs3i68XL0JNpPUseXZ30z+KIvbqLXRlsaWrRVu7lhxISlzczw/Onua
	 E8pYh2iixHIKXsWYAebEsM/chYKAocxQqXgLI4+8mdz8uVQUZltMB87dPoyBcsiXrt
	 D+TzojjlaodDiYjNYq4EIZM0Sl7uNKgHxYeCY6kcpM2/57ZBl/W5ApuPZl6+FhaZpL
	 PZZGNcBmZ1YFvzMP/ExthRWRbLFGWOVXq9HBX2kqdQnxUyGsag2Pqg56On/b+L3b5o
	 1qhuMdxU28PRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE72E380CFF1;
	Sat,  1 Mar 2025 04:29:57 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fix for v6.14-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0i5aHWRWPsvWvmqjgNZ5TXiECs47WH3X45+P-nJpLKwcw@mail.gmail.com>
References: <CAJZ5v0i5aHWRWPsvWvmqjgNZ5TXiECs47WH3X45+P-nJpLKwcw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0i5aHWRWPsvWvmqjgNZ5TXiECs47WH3X45+P-nJpLKwcw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.14-rc5
X-PR-Tracked-Commit-Id: c157d351460bcf202970e97e611cb6b54a3dd4a4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 14ebe69091935d65d9dc452c1bad8fed20d06c29
Message-Id: <174080339625.2364407.15929511270489736994.pr-tracker-bot@kernel.org>
Date: Sat, 01 Mar 2025 04:29:56 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Feb 2025 22:15:41 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.14-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/14ebe69091935d65d9dc452c1bad8fed20d06c29

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

