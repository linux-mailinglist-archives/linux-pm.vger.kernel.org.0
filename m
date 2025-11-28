Return-Path: <linux-pm+bounces-38895-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F2BC9296B
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 17:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0761E4E2FF6
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 16:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F83626D4CA;
	Fri, 28 Nov 2025 16:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7Tq6jos"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4492E264F81;
	Fri, 28 Nov 2025 16:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764347745; cv=none; b=ZNwhGDFJksziySrLmbkluyjlIMFK3OILswoPYZr2BqlC4hUMxIGCz9Y3fxOwid4WRDNhcruPPlVtmJax4sVfx/p/o5o0yp0veVduBvqetaMo2++WJkBzdkQEkyCc7tppHwKQzojZR4oPWQnR8ynmXNKMYKw91Vidcr2ZgHZhY1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764347745; c=relaxed/simple;
	bh=8AglEL5IwEX/vkqGIeaiCAxI21pxttwEglvsC78jOSs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tc9GJXpOLFAuKD7jdLkjQaMlGCNB16PuY/FFCTFOIAoHurNIbjx0CP/5JwGfAaevxDnjqcuotPxsx1QLL9WDWmgaA5HTHzclBLMqbu+40mFqQoQc2wmIBkQ0z+/l/YIIHVmBurTXEG/dVjFGEgv+gBKWE2H7oMNpqsO9Z4rMO6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7Tq6jos; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5191C4CEF1;
	Fri, 28 Nov 2025 16:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764347744;
	bh=8AglEL5IwEX/vkqGIeaiCAxI21pxttwEglvsC78jOSs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=O7Tq6josgtJI+PxZngNkQko/k0MtUDmdouXTAbpLHFxHqQg5WuORNOv6H4ZoHIVkt
	 b6Z4bciQuhg6XNI4vi3WvEHShKcGdb740D05ouMN93RNm+kKSm7CNKZwjMbNL5gniI
	 IUJfTjgbZOBPKPqZ9HAWShjlezLtZnybdp2eZRErZSxSClMSLIt3/Cndh2xD0WSZCR
	 1wPvgwrYOm4W1oQNTh4TJUnXXTzrN6AUSWu/zolu+rujDr1MZ7VjMmv3Oq9jK9AxrF
	 RUokBV0LzoVnNxCPtWwlSbZlwATxgF2nt4Z94ntu5NTb8FYpstQLsj5m2WKYCsFpgZ
	 xTTnYhOiIfWWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2AAB3806929;
	Fri, 28 Nov 2025 16:32:47 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain fixes for v6.18-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251128131049.7584-1-ulf.hansson@linaro.org>
References: <20251128131049.7584-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251128131049.7584-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.18-rc6
X-PR-Tracked-Commit-Id: c98c99d5dbdf9fb0063650594edfd7d49b5f4e29
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f849f26f77205e25f6ad0b9011b1b68a560d35ff
Message-Id: <176434756651.719139.9248716127967964483.pr-tracker-bot@kernel.org>
Date: Fri, 28 Nov 2025 16:32:46 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Nov 2025 14:10:49 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.18-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f849f26f77205e25f6ad0b9011b1b68a560d35ff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

