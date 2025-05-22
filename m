Return-Path: <linux-pm+bounces-27536-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F221BAC18D1
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 02:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9F631C06C93
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 00:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428A528A1EC;
	Thu, 22 May 2025 23:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMN4/M0u"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1916F24DCF6;
	Thu, 22 May 2025 23:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747958305; cv=none; b=i4DyHMuutysbQ5f/b7eYjrgkT8j27T5TuJ+JRogVMWfh3aaG2dCnqVIDGiIrdxJN+M6ZLmgeVlPhIplwp+uGz0u5nJyOdw5hIw/EhWtP1CAZFVTHVQLP+W6KLGFNh6Dgk12BQUT3+wlAvdk5Pyowg3aeJorrTyHpKTKVD2m3RJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747958305; c=relaxed/simple;
	bh=dV3C3FSrxga/xMlaTuycKD+t44FmP/fFjl0D/jaskrI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XdkVx+qR+/waux6U92fJHZuqK7+HRYGG0pGWbQTu2ai+WpbPrGAevbUyLm0rffwSX/2JxpkSG/JYQ7GcPtPwd2fKvSEeD12godE3AaRxEbprGI6I++8pqQMGHi2+L9/jh06Hv9v7bMmufkJLrWIVLJ/l3G4vaGGalQ1a6fv1LV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMN4/M0u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 851CAC4CEE4;
	Thu, 22 May 2025 23:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747958304;
	bh=dV3C3FSrxga/xMlaTuycKD+t44FmP/fFjl0D/jaskrI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cMN4/M0uuru6Q0ypAj2/G1GQUL0nJHe940pvPoPvRbBLxllEspVn6vzqTI+Nh40Ac
	 aBesyPoA/iDAau2AaqX3ERK2eFldtXEP9MZouZVX20JzQuNYskF6e4oYLpXtgZ+j2Q
	 jVxqn5MaqMO/g3cNbovljVniBl2UQdEZG2Xe9gL1O1hr7WZsee2tfhm8lDTg3jRHEM
	 ATPGK/xmp3Sl1mnOUTI6NeRLyJI+pKx0HIi6lpnhRC+dXnKFBtd+QcSUmrFWxyXklR
	 JpYKZz3Mdfcpr1GawBrPkGwPO9YitIsGMi+T6ZdtiB2KsqrKaUWo+9LDak41jKlZaK
	 b3QYLbJR0EyQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C303805D89;
	Thu, 22 May 2025 23:59:01 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain fixes for v6.15-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250522223843.171621-1-ulf.hansson@linaro.org>
References: <20250522223843.171621-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250522223843.171621-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.15-rc3
X-PR-Tracked-Commit-Id: 0f5757667ec0aaf2456c3b76fcf0c6c3ea3591fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 94305e83eccb3120c921cd3a015cd74731140bac
Message-Id: <174795833977.3061927.107906031204643619.pr-tracker-bot@kernel.org>
Date: Thu, 22 May 2025 23:58:59 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 23 May 2025 00:38:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.15-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/94305e83eccb3120c921cd3a015cd74731140bac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

