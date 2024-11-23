Return-Path: <linux-pm+bounces-17975-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 732C39D6776
	for <lists+linux-pm@lfdr.de>; Sat, 23 Nov 2024 05:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D043EB20E73
	for <lists+linux-pm@lfdr.de>; Sat, 23 Nov 2024 04:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6B017E8E2;
	Sat, 23 Nov 2024 04:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7PVDCVt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2632817D346;
	Sat, 23 Nov 2024 04:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732335034; cv=none; b=ms+yYdMrIxdWxg+FgnS8a4tfICSgJOitEPWmBOvq8Z4R5aYmiI2NovnCXPfzD2X69M16py5rqeNn8e/KnEws3Yyix3XvuKqSUiOMCqmq6eKw8WdC4EI6EhozeaW49RnwtoZl7O7Q9a2/UnIV4sq0IoO8LEEpNNLAdPRNbQz2Mnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732335034; c=relaxed/simple;
	bh=s098uqvEAZadXswS2n1Wxi26ahv8VpS8qDeJcJ1fzf0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=l2qragueRaaoitSBu5vbVjMHHwsrWlXFPTY8GABg3wUp2Ga/BbbwP7NhuB4A/SIv3SMhhc1zj7OlaeTESGq2YwqcRfFMPxfqwa7JH82ZJWQbA6fMNZWCibD4MtyuxFp4GJA6lXR4NvnRCpsaZoppx/kcsYSgYt3JT4ezdWIBNQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7PVDCVt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6DDAC4CED2;
	Sat, 23 Nov 2024 04:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732335033;
	bh=s098uqvEAZadXswS2n1Wxi26ahv8VpS8qDeJcJ1fzf0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=n7PVDCVtLAWv4QFJeirFJbSXo+gFeL3xnd46gWeeKKFodR2gxVW9YqMHLDyYtNKXW
	 cjaVPcJHA9ilKEn1qEzI9yAbTRVDxDJKwq1QjIyNAL3rar8ykXzDe2OdRawDT8Nf5u
	 ll+See4hX6omnhi/rCHAHJwv6ey+sihU8sCD2JG5sygw7xOSXwN04Agmjwm0dZCWTg
	 a05W/noGoy9qOw6AWBEwPOQfxvj6ue6LpLTx6gCxYyfYuStMSoSk4PE/Bxiiepg91s
	 lwIntRprtIQ1SN6uMHVDn5b7lSgJRaqrvOiVFckhMLrrXwPR4c8liFZP7uJQP0faam
	 vZO9VN92z566A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FF453809A02;
	Sat, 23 Nov 2024 04:10:47 +0000 (UTC)
Subject: Re: [GIT PULL] More thermal control updates for v6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gm1JRjTCqNSmjTJ_xXhXMLyk4BJc97SxbAeopocDqc5A@mail.gmail.com>
References: <CAJZ5v0gm1JRjTCqNSmjTJ_xXhXMLyk4BJc97SxbAeopocDqc5A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gm1JRjTCqNSmjTJ_xXhXMLyk4BJc97SxbAeopocDqc5A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.13-rc1-2
X-PR-Tracked-Commit-Id: fef664fd73c12c11a4c4a40bd38beb8542505573
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eb78332b1067776ca4a474ccfd92460014e8d8e3
Message-Id: <173233504609.2897203.1379926696948987156.pr-tracker-bot@kernel.org>
Date: Sat, 23 Nov 2024 04:10:46 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 22 Nov 2024 21:28:32 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.13-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eb78332b1067776ca4a474ccfd92460014e8d8e3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

