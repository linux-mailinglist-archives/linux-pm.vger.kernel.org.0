Return-Path: <linux-pm+bounces-32435-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE4BB28139
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 16:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04D227A991F
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 14:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BF51A262D;
	Fri, 15 Aug 2025 14:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGCV6epN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC29A926;
	Fri, 15 Aug 2025 14:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755266753; cv=none; b=edK7KA0wE1SBR0uZILM2OlncSIspU/5zA+4XXb6CTWU6P3K/uo03fSZHN41WzgfeN0fJS5d1c2uUUsYuELEgUHN5DY+YG6M7Um0vrRB+3Q00ByBzxDr3KeBZTnGljpQZeWOziXhtZID/2EgWMiSMUYg2qSRQK5Ji5TXi4nnpKSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755266753; c=relaxed/simple;
	bh=Qjn3miaSSWjGbZifrmCykBjvck0/NI6OeGEqHIax6Ok=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mzZm2Czk5pOQVw4oMyyjTU/TbSD4PJ9UyMMch/qv1kTkO1WHdngGjVr0qYsCbK0vhP9UIk2O/Lf+/HJjK7gMc/p03tXBwEVHYlNnDOwUCdL9iKWJpY2X3CPszVIN9Z2FBUu9K7gnJ4dvnL2q6lH5fJ7X5seNFs/oQS+BwMRm+5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGCV6epN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962B7C4CEEB;
	Fri, 15 Aug 2025 14:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755266753;
	bh=Qjn3miaSSWjGbZifrmCykBjvck0/NI6OeGEqHIax6Ok=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XGCV6epN6MWVCGkmFkMsW+z0RzvdYZBqdSHq3bgXBR/fhWVmsWDMXJxGA9qKE8gVT
	 rGKmP/gPYzt4Pjn1zukN09/LIDEYXwafhcE7EEPZoBsrQT9v4RwLa3MA5CdhidRcMX
	 LnULsQXMjgsdNQZCjznAb5j8nQIRPAh1rSMRdWae0VYIzC/WvXFIk9Wah2lRb994Gd
	 413alaTsJYvr/j/hnxiNEfMm2i2P6gF5adEmzKbRmo66C6b8VyJC+whwRNUGNS/67F
	 jVN9f6KUbBhFMQVuL7WFbi9m2QFeDdtL/4bqrnTlMungTpAdfMd5B61Hov/Me4Z/WD
	 vf8wTQiubB+bw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB40B39D0C3D;
	Fri, 15 Aug 2025 14:06:05 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain fixes for v6.17-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250815080816.282648-1-ulf.hansson@linaro.org>
References: <20250815080816.282648-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20250815080816.282648-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.17-rc1
X-PR-Tracked-Commit-Id: b6bcbce3359619d05bf387d4f5cc3af63668dbaa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 66ba63d4d87bb3b1c3b5f0f09610c4c16748bbf0
Message-Id: <175526676447.1083334.1395206172249648683.pr-tracker-bot@kernel.org>
Date: Fri, 15 Aug 2025 14:06:04 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 Aug 2025 10:08:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/66ba63d4d87bb3b1c3b5f0f09610c4c16748bbf0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

