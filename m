Return-Path: <linux-pm+bounces-35297-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE56B9BAED
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 21:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B130B42775D
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 19:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C422E2286;
	Wed, 24 Sep 2025 19:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUnZZdtk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6AA263F3C;
	Wed, 24 Sep 2025 19:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758741785; cv=none; b=vGOhs+Z3ktBiqdoa/+SyeSULYoJBr1VL1IdPNC+kcV2wTWkaDgUUP0eTbSoDVO8eziub1GqIqkDJ04Ou/sqZppzpfO1TNW9/phDCGjO5s5O/XUVIpZ5NXzZMb3zqwHzyaGjFkfz9pQ6nQHiRX6xZH3frqAUh6GzM0tKW0Bp25b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758741785; c=relaxed/simple;
	bh=QnvursLoB/HoTPp7t8JpQEcUtxN7DGIbdTv5gTTgKl0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JABaj9rQTmvIXcHrENGSXuV5LIDvkGz/Jfen57BOmuEennOZCawebJRg1LqbTFv0f2/ga4Rr0q0o7bU0ir+bzlBY08Ci2luF9cymnNSguDQzKysfRNVLlu01Kj0O+iyuWPAxNbR7Aa5QAw/x2C213EbN3I5XjgjvZm74SRTgIFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUnZZdtk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16020C4CEE7;
	Wed, 24 Sep 2025 19:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758741785;
	bh=QnvursLoB/HoTPp7t8JpQEcUtxN7DGIbdTv5gTTgKl0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GUnZZdtkCdm9UdMx0U/Oy8j6DqHSSUqnCxG/8kiRgGWFaw1agOQWRtRN2RnmHDS+c
	 tPuprOuAs1Ziirzx//Gro64mEWgww3qYZwfrvl+FQR36mHREzzdhwNvum7Ovo06cSz
	 57s1ox9zn4+bz5ocNmEMOOI6Dyo4uJrlWqAQAp0acl11pAMznDSqfpCPFPsA2R+hDi
	 L9uMVOuTFQJj58SLujYVE2blPNRhc0gFrDSDtfyul/UB9keZiMMnmAHdzoBlW3qqUm
	 dVzpX7jJEATx+fVBNZhUXJ3x4vcBfN4YAkdPTMmiULeYGV3SroAh+XESw+G2f4gebS
	 vVC7lL/VyYmhQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE11A39D0C20;
	Wed, 24 Sep 2025 19:23:02 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fix for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jfvPV2cmk0=7G0LyAYvnKmYMG5fM6p_-oCYTgYTgN96Q@mail.gmail.com>
References: <CAJZ5v0jfvPV2cmk0=7G0LyAYvnKmYMG5fM6p_-oCYTgYTgN96Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jfvPV2cmk0=7G0LyAYvnKmYMG5fM6p_-oCYTgYTgN96Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.17-rc8
X-PR-Tracked-Commit-Id: 8ffe28b4e8d8b18cb2f2933410322c24f039d5d6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ea5af08590825c79ba2f146482ed54443e22c28
Message-Id: <175874178124.2659978.11129294582338399605.pr-tracker-bot@kernel.org>
Date: Wed, 24 Sep 2025 19:23:01 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 24 Sep 2025 14:38:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.17-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ea5af08590825c79ba2f146482ed54443e22c28

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

