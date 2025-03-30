Return-Path: <linux-pm+bounces-24609-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C92BA75864
	for <lists+linux-pm@lfdr.de>; Sun, 30 Mar 2025 04:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2FC6188F22F
	for <lists+linux-pm@lfdr.de>; Sun, 30 Mar 2025 02:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87E8487BE;
	Sun, 30 Mar 2025 02:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bI9+2f1V"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DB73D3B8;
	Sun, 30 Mar 2025 02:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743302296; cv=none; b=BDQyYs+npAHrOgupPVWJvd4MT1K0b6yhPDAgTkFnzgIR7RpBdOjAdIK3H/ETEg8JlmCnR/l6OG9smCJPtcjx2tPlB9FYv2yj8/RpedMjGceSaXVU+eNq45KZH2JcSsKV1RYNwwfhx3xQ/rU6bgachU2yIJha1e3YPtGcSfe8DK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743302296; c=relaxed/simple;
	bh=B+2L8TIuKJDiyMpTPtwBakSI6kSRyVHLEwUBKHcKmR8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=C6LN12Ndt8DmELmTQJUECrNQtR9HQYexJkYE2Swb4AhicpgqoiYW9EVxod8imsCA63b5hbqrlnAkke3TYLMpkjaiKRkPExWs/4ZdUGe/17SkADThnrvBu6e2BKuue7JVQL4WQpYUL/mXMmNpADQDryAekouH0FEFVHdfDXoi5ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bI9+2f1V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6B4C4CEEA;
	Sun, 30 Mar 2025 02:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743302296;
	bh=B+2L8TIuKJDiyMpTPtwBakSI6kSRyVHLEwUBKHcKmR8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bI9+2f1VR29h7encvrj3ybyJX/eIx/brfqgwk4vmwP4L5tp93YBKK2YbtSDaLbJVH
	 KlRRO4VY5sTCZ037enzt1U0JJ5njnYEx3Fx6H6LW3F3W7IrQRWoFLNTHMadzlIpWK1
	 D92gKKMzz1lvamfgDnbChlHtvqBIvgxETiw8Cs4h6B2A3whUmcvyA1RHgSIYPX5L1D
	 e12e5utatpGP/atkvo0yDCge8UK+U5g4Hg0dyAB1wzs3/ItISs+DLUG6p0BODnbzY7
	 xZxq0W56SrQBtgi75Vals7zN9zt5WZ/XkprZRxTGxDcSCY2YfhDq9FodaFkLLtfI3Z
	 lnvwEsgJ0MCZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CF0380AA7A;
	Sun, 30 Mar 2025 02:38:54 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <45zu47bzlzyh726zsf3wfi7xqxvsg3fkhmfqm6ejfyqm76rnp4@ddilazwcs566>
References: <45zu47bzlzyh726zsf3wfi7xqxvsg3fkhmfqm6ejfyqm76rnp4@ddilazwcs566>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <45zu47bzlzyh726zsf3wfi7xqxvsg3fkhmfqm6ejfyqm76rnp4@ddilazwcs566>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.15
X-PR-Tracked-Commit-Id: 0b8d073f6c66d7110ac9fab1f13a09337e03f1b6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 556f1b4874ca87feede736e1b2b4d11bc76f5bb9
Message-Id: <174330233284.3338213.10095649526426750231.pr-tracker-bot@kernel.org>
Date: Sun, 30 Mar 2025 02:38:52 +0000
To: Sebastian Reichel <sre@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 29 Mar 2025 01:26:37 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/556f1b4874ca87feede736e1b2b4d11bc76f5bb9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

