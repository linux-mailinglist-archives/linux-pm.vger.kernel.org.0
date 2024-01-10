Return-Path: <linux-pm+bounces-2036-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B9D82917C
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jan 2024 01:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1100288291
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jan 2024 00:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A75838D;
	Wed, 10 Jan 2024 00:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLMr9745"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEC33214;
	Wed, 10 Jan 2024 00:36:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24551C433F1;
	Wed, 10 Jan 2024 00:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704847015;
	bh=FnDDfewETzAwBlXK7LM7K5bbAALtKYB+H9rurLVGMw8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XLMr9745e9l+xh++WO/IuZnjK7Hco+zJKHZg2CTDmDlRvdhm2Mad1++lVkZEWrAXA
	 ZYGOlUkW4TE+ma2wwkzLMFcnRQomUDLu64BETA18wuWqDl2N7zUic3wZ7n/oSxyBi1
	 +9fU3Y+iI8P6wVK8Iqs/CgUvMkrT52M+ouCxeFdFNbPMaOMWii1V17IHp/WNHIecNw
	 o0oZJI5mMjbdvNzFkko2j4xQmsWS6Wu9hoS2pTuXcdOOnwctmqQI6zVCJCKrrF6t/7
	 KmMg/qaXcL/z4qqcs9G7ymPIxAuNpiEXbjE/lxt6bFEnUnHadZKIGp8LSCoHeIJA3K
	 p1IuHcEsCKdCQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0737CC4167D;
	Wed, 10 Jan 2024 00:36:55 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI updates for v6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0j+EaUmMDibUUrY0hQmT457TqAf+39mLNO62sKWHDMfpw@mail.gmail.com>
References: <CAJZ5v0j+EaUmMDibUUrY0hQmT457TqAf+39mLNO62sKWHDMfpw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0j+EaUmMDibUUrY0hQmT457TqAf+39mLNO62sKWHDMfpw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.8-rc1
X-PR-Tracked-Commit-Id: e46201308a1e568059328e200282c8a62faa2f19
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bd012f3a5b02849d9acc85e2b8b71293ce072263
Message-Id: <170484701502.9066.13972797317189918618.pr-tracker-bot@kernel.org>
Date: Wed, 10 Jan 2024 00:36:55 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 8 Jan 2024 15:59:58 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bd012f3a5b02849d9acc85e2b8b71293ce072263

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

