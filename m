Return-Path: <linux-pm+bounces-31541-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 312F7B148A3
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jul 2025 08:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7A0417DC96
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jul 2025 06:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79861264F96;
	Tue, 29 Jul 2025 06:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8yW9KA0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511DD264615;
	Tue, 29 Jul 2025 06:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753771796; cv=none; b=GZhNCtk+m09DAJjn8NdtfLDDCRgoEfvd8pjnXX0qC977Lg+H7lCfWdC2lTEETDMKGNWBPpxS10ScOcfwCzK1X7v/W5fCI7E7FsGXcjUNP45yFPFobeFBeHuHV3BtvS7woYy6HGA3N9LhstLPTOTltQJIKO0UQ3vJxA3UsWy9VSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753771796; c=relaxed/simple;
	bh=fRqAcJEna3ezrfVho2gZ52wiKwo6baumOV25dyb9li0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PsPveK9mrNzcQl27KXg/r69HdvJb8X7GqTbm9lUxQlvxksf+cbhcP9x7wji6N5rsQ2Oq5NWcCi8vNRbS5cJj2qkcd1NaO+Cxp3lap85Nv77/7grLIt3loAVdq1X58Cly90iIikesWbooAvlChxrBhL8J944usPvQ3gtAembW1Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8yW9KA0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C984C4CEF7;
	Tue, 29 Jul 2025 06:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753771796;
	bh=fRqAcJEna3ezrfVho2gZ52wiKwo6baumOV25dyb9li0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=r8yW9KA05h76kcz/4h1xMlpKgCDXa2uFyBN3JKC+rsY4PUIu57E8YDTLOFVUgRVF8
	 wn3qQ/nPU9ABLUYFlFMQoarGuyE9Sgz6prEDZrPbLR+N0/QUnUmfz4F3sRDn1mzuDt
	 ILLXVbomk5izPiXpbjVgVKpzLJgx94G0Ob1eRJx1kYaP5hyWBGr30EGmbE6vEsPWjc
	 WWEmmsG1pJ5tdhpV9ujlxqMPXSgnldClmMEjJfS/T3apC85499E2xMPApZHdg5kXqm
	 YryDAyfHs+Gh9dyrF4lcs+yVRvV+p7xgEjXTiso8urngAaF2wYTDEFd38GNxYTG9OO
	 wSSTCbrLN1CXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 6DED6383BF60;
	Tue, 29 Jul 2025 06:50:13 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control updates for v6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gTixsgeM7svDVJnjpGV4PG-hxOmZpUGxhdqTeo4bbU4w@mail.gmail.com>
References: <CAJZ5v0gTixsgeM7svDVJnjpGV4PG-hxOmZpUGxhdqTeo4bbU4w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gTixsgeM7svDVJnjpGV4PG-hxOmZpUGxhdqTeo4bbU4w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.17-rc1
X-PR-Tracked-Commit-Id: 1e94cb6c2ae1c2660ed406669f12b90c7052d2b9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e30fc090828e5761defe345b7bfb61bfc46be5bd
Message-Id: <175377181232.1356386.12413021372082639564.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 06:50:12 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 24 Jul 2025 14:40:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e30fc090828e5761defe345b7bfb61bfc46be5bd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

