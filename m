Return-Path: <linux-pm+bounces-19641-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A92E9FA20E
	for <lists+linux-pm@lfdr.de>; Sat, 21 Dec 2024 19:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB851889AD1
	for <lists+linux-pm@lfdr.de>; Sat, 21 Dec 2024 18:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D8C189BB6;
	Sat, 21 Dec 2024 18:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPvwAEmn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC39189B91;
	Sat, 21 Dec 2024 18:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734807399; cv=none; b=XoxMC/1vkNh5HvrDAlHqRGLbAbDU/f67jvAUwMWyUjFMad0Mh0+yoZ8w7rqx8EVNfM2R3zUqP+E9ZPmWY2prxhCYKZHUzU34HoNJ+X8yp39ITAqMZPWUhf1kPtjtwX6Rj36PwamNjGfZhcNA1z7aO/+1Bh38wuKQsxxEL0CMQXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734807399; c=relaxed/simple;
	bh=l5juxElCoo7uouH7vuFYwA/WETl0I+fUO4xGQG+C4vw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YUd4LnSlJNyALeAEMd78WxC1ygEauq4A7aYgh2P7TEZTbnrtULrtI0HqRHjpBCLOakbvQ7whnws7op9JaOYepthM8yMZ6JYrRAf2eTTeGWErUFIe7HLYsYcTT89ChA1Vo/xB3T+4bc+KSDtrMvnGBHz/3kcNQyDQl63O/pGZ8GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPvwAEmn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98407C4CEDD;
	Sat, 21 Dec 2024 18:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734807398;
	bh=l5juxElCoo7uouH7vuFYwA/WETl0I+fUO4xGQG+C4vw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TPvwAEmnpYSw3ISvSpRp4LJJxdsTqqUMzIUkAvdkGOghkn79alSWlViWQmI96Suh5
	 FgydJDF+5c1pdXJmkvSl2OlBOa4ILOZ5387D1P1Uq+UTXt0ScOdo1BjYgWkgIVibZ6
	 RBNFyJA35CDu32JevASZl0Kzu4C10Oq8d3iklL2wrGd7jwEINOXNNaO0qQ8mEwA8Kh
	 EHPteinYII/nJFrqvKtnPYeSaEeIat4V/Y8CTMNZ/EwbupQOi8qvBYgXPS5IxmVRBH
	 YOTQG5h6trb9x5j2ZIwbUa0NCmcc6gpqjjOyDnW93j9LWNxiX/8ar3WG1X2ngVCm5b
	 JhGRU2E/kCxRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACC73806656;
	Sat, 21 Dec 2024 18:56:57 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v6.13-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jK7mjw1tO3NWcAOesheWJtKjpk3vsdDc_iYwR4u0wXWA@mail.gmail.com>
References: <CAJZ5v0jK7mjw1tO3NWcAOesheWJtKjpk3vsdDc_iYwR4u0wXWA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jK7mjw1tO3NWcAOesheWJtKjpk3vsdDc_iYwR4u0wXWA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.13-rc4
X-PR-Tracked-Commit-Id: 05648c2f58b3da82d304e7a449101a4545472836
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 78b1346123bbd66060432994c28a7ca390b7e0cd
Message-Id: <173480741662.3207643.6111357874083937442.pr-tracker-bot@kernel.org>
Date: Sat, 21 Dec 2024 18:56:56 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 20 Dec 2024 21:49:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.13-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/78b1346123bbd66060432994c28a7ca390b7e0cd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

