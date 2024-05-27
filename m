Return-Path: <linux-pm+bounces-8185-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 777FA8D0637
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 17:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAA5E2A110E
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 15:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAF917E912;
	Mon, 27 May 2024 15:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RytYccsM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C1017E902;
	Mon, 27 May 2024 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716823808; cv=none; b=suVdkuQZZ8j536hUT+3xxZwJfQSGC7OIyp6j16QNVPW+j67sXHSncerTfaQaHiQljE7kXJmcrr1XKE35PP+ExddYeHER/zLl4P9W8BFIrrJCpIacXwzyhk1ThdAZ1xmdiZD2T2j9i14onCr3QwBWps3+kvyd4oHVdASmNjjPDI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716823808; c=relaxed/simple;
	bh=dpYFd0eLNJssQyvXkWcnz162ArZ8OnuRaPb+N2HO4MU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Zf/oG0toAPLRK/rYH6HGfOBEVCZ/BjY+FqjWOYyrlYWuO126NB4qZ61ibVpPb+XrQoo3mPMzNxoTGudZlXbAzq8EaEg9RkAGeGxz1uIsmwa/28vgPSWg9wJAtz/gdDzzGh0zvqd8UsumksMRaTx+zF8cvubwYj2nAYPdEXEYSw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RytYccsM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ADD25C32781;
	Mon, 27 May 2024 15:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716823807;
	bh=dpYFd0eLNJssQyvXkWcnz162ArZ8OnuRaPb+N2HO4MU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RytYccsMnTktlVLTYicnLbsy3KhvLY7H+bJNemgJ/KOSHCuMh0jRRopx+DTh/VWt0
	 6kPmigkaoN3ieqmWJp5n4K1WTnHcstwZ2QHythMATl4aellNS+UhFxoTfYQHbNaYs7
	 q8nwzw27EIzNMWtU4sxedNUbJi4VmnCJyKeisCUXw/viFWxO88zswheWh7i5kxfj2O
	 cNE4hT+PXlzJCHFTe72WcZrbT0Z813glJae9IvmeFdugtfaKxMeW2ckcZmA5O3OyYZ
	 godYv7alxKmlB2+0kUpWksv4Z0G4sc28PPoqsJVEcv2yTHYkkQM1s1lxAF4uXq5vjH
	 tUq/qs7RBKzpA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8D6D7CF21F8;
	Mon, 27 May 2024 15:30:07 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain fixes for v6.10-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240527144540.323019-1-ulf.hansson@linaro.org>
References: <20240527144540.323019-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240527144540.323019-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.10-rc1
X-PR-Tracked-Commit-Id: e8dc41afca161b988e6d462f4d0803d247e22250
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2bfcfd584ff5ccc8bb7acde19b42570414bf880b
Message-Id: <171682380757.26768.17969742048072521787.pr-tracker-bot@kernel.org>
Date: Mon, 27 May 2024 15:30:07 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 27 May 2024 16:45:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2bfcfd584ff5ccc8bb7acde19b42570414bf880b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

