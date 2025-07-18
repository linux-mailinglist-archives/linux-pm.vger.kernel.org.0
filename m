Return-Path: <linux-pm+bounces-31077-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AD7B0AA93
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 21:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AC175A4CA6
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 19:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16EF2E88A8;
	Fri, 18 Jul 2025 19:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="unzB9/qG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8CB2E88A1;
	Fri, 18 Jul 2025 19:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752866013; cv=none; b=Zosfm01IZzW/oriAwl8jxpo0dA2sLq7B28UNMAwOqHLkVE1oeLwn93j4i9pvHeWSc8J7nmT4yeWLcP73SGtRaK70i96VYeSgrGV4yL0TWahjLBkct/kHneyQzwfn99+V9hVkfho/mukatdL+1vSJ/RCpQ5SkIcXZR4ci/B0vmH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752866013; c=relaxed/simple;
	bh=WEJPoZzdxFI+5M0fe+AGUXYeK9JEwJbiABJ/YI+lrr8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HsDkjfsYf7yVGQS3jpfHA0JJM1M0pHxQq11qpoEOlyBawHFb1i6F4XaY+8GlkJyfxT9HPQ3ZsIBFu63XmFKa6yiO2ahCvcDIoHIACbOBLN/2/fbn7UoajjMNZHDNQXdkGClyyAZPMu72Zk6DVmz/9izCcYAxlXJr6g64ZI9v3yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=unzB9/qG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8905CC4CEF5;
	Fri, 18 Jul 2025 19:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752866013;
	bh=WEJPoZzdxFI+5M0fe+AGUXYeK9JEwJbiABJ/YI+lrr8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=unzB9/qGcHxp1a6jPZZlxEe4mphBQeo+m43Xni5m88Z6s+9fFJkDiD2/FGlag/v3w
	 0yjatYcYO6nCPB0ZLbXZvWpbKDR5o0UpchG4YcO3tOxrKnMmVIWW5hFPJT0skToyCv
	 D91HV+nDtVnGpnAzbJSJVlcyx/ZE02waq8PoVOec8KHUCY0ntZ55/cflHwy8H/v4pe
	 bSmO/dbk1lNmNG2r9J46NgYE23mttOXGHlg0Yfr3ZARUHFhE/9rO7W1dgM+jR/Ao19
	 haNFOi90QwOqgRFEa199a4pg7I6G56T8PkyDE08j1WqRd2NzpdbUZOA1LVIjZQDSLX
	 sd029BObUgIVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7104E383BA3C;
	Fri, 18 Jul 2025 19:13:54 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain/cpuidle-psci fixes for v6.16-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250718113501.80851-1-ulf.hansson@linaro.org>
References: <20250718113501.80851-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250718113501.80851-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.16-rc2
X-PR-Tracked-Commit-Id: 621a88dbfe9006c318a0cafbd12e677ccfe006e7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7abc678e308467ab60ffb8c31f4638a47ee3518c
Message-Id: <175286603301.2766060.11715333521087216502.pr-tracker-bot@kernel.org>
Date: Fri, 18 Jul 2025 19:13:53 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 18 Jul 2025 13:35:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.16-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7abc678e308467ab60ffb8c31f4638a47ee3518c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

