Return-Path: <linux-pm+bounces-34699-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54356B5875B
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 00:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A52211B251DB
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 22:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E252C08AF;
	Mon, 15 Sep 2025 22:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efVWpWPg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B20E280A5A;
	Mon, 15 Sep 2025 22:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757974766; cv=none; b=hNFvaL9KOcuVe9VpXAwZT68DPZ1usKXWjBOXeUhAgbsUN6gNL3Nxb1u038CWIJ7hnNKiARmX3/eYdsS3DyJrVjfGEHa7kMqsOWqSmxVzkS5GzLeaHANFm1deOvxcq4YpvTAo7rgxfHjaYlgryKqsmr1rHr9g1RseKq012C9Cp44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757974766; c=relaxed/simple;
	bh=34Vi4P29yE5fu1FJ5lJQa77B+2N9IFaosJUaQoyLeQc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GIUPdkYpPCSs/baru1XSP+E9hQWYWDsmlwVDqWgqOyCO2DC3OXgFtCtEAM5l5HlqylRiiLA8WHb99FKzJxqmk1ytmJd1w0HRGc2mdeqROciezX+7oEfu5RgtzB3lLj2gGLfktb6mJacLXXy7J62H8hfwG4ydyz8c1VGPcezIVaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efVWpWPg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A2CC4CEF1;
	Mon, 15 Sep 2025 22:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757974766;
	bh=34Vi4P29yE5fu1FJ5lJQa77B+2N9IFaosJUaQoyLeQc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=efVWpWPgVyQHZd4VcErJ9IelaX0BJBPGifL/8wxU3NaS5u8S2PgqGvaftO0QAq8dR
	 k1UoJmhJ3WEPrAqBbQuCoGMi40ksKLdsMX100mEPWolRY+zX2/bsRw18J56YXjKHG4
	 pUxKy+TtmBlMmSfVQSz9aR5AJIv6t5isbQHA6UtxJqepIt/bJMjnaUB00YwFX/TMQQ
	 QwnbAOZix2KzygVylO8nrD1tGJJsqtEZuVPP8JhmBslxjginpBjIq/2sOV9h2yguQI
	 0A9RNe+Xd6rTjl27jbrAXRTsoansOfvcunTDZ1BOM4zTAe3aT6+kfARAifmXpZhUtS
	 PVFR+jmw2czeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE00439D0C18;
	Mon, 15 Sep 2025 22:19:28 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 6.17-rc
From: pr-tracker-bot@kernel.org
In-Reply-To: <otvgknffk3ba7hzploodbvs5cbj2axb25wz2nelewlbmye4iag@ooi26edepadg>
References: <otvgknffk3ba7hzploodbvs5cbj2axb25wz2nelewlbmye4iag@ooi26edepadg>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <otvgknffk3ba7hzploodbvs5cbj2axb25wz2nelewlbmye4iag@ooi26edepadg>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.17-rc
X-PR-Tracked-Commit-Id: 1e451977e1703b6db072719b37cd1b8e250b9cc9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 46a51f4f5edade43ba66b3c151f0e25ec8b69cb6
Message-Id: <175797476739.139860.10495164474144733988.pr-tracker-bot@kernel.org>
Date: Mon, 15 Sep 2025 22:19:27 +0000
To: Sebastian Reichel <sre@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Sep 2025 16:55:28 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.17-rc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/46a51f4f5edade43ba66b3c151f0e25ec8b69cb6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

