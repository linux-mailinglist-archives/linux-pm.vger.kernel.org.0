Return-Path: <linux-pm+bounces-31563-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B35D9B153C5
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jul 2025 21:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0FA65A2A31
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jul 2025 19:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F48256C9E;
	Tue, 29 Jul 2025 19:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeAO7L88"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7BF255F4C;
	Tue, 29 Jul 2025 19:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753818283; cv=none; b=u9T5e8Ku1YjnD+pOyoUOt5rXf3jU91ogpTPDF9+l+mm9H/KnkYytVBe9MpuewIizOiSut7ExJ5VMU7Qgldz+3CtbyD1ads9IP93XsvOhYLzZo7VQcuR+0FiD5BP+q2CtD/AQWiFDkIOzJ3KAICpb+1g0KGsfHPhcjCrNwRL008Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753818283; c=relaxed/simple;
	bh=tcDsuAoiaaM76wFOzY0SxBKTvoLfG7AMBnUMYwUV4O0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OL3LCbC0CI87LwIIe4AL1rE1TCPkDkISQTfhJyVhHePH421m1KonwMD8jwBD+/U0VHH3oJAhDJnYParkNEtalvpqUjcG0AGuwr5NQidewzXDWuxdnjchrhFGhEv7wVZbNgbjjrHQMklV0FWRuiOv5l2iYKpwmtH7pTyCnK28/5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JeAO7L88; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A76C4CEEF;
	Tue, 29 Jul 2025 19:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753818282;
	bh=tcDsuAoiaaM76wFOzY0SxBKTvoLfG7AMBnUMYwUV4O0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JeAO7L88FzPGI7BaY21czmYhqSf+u3bTcREGIZoPadRvepFiUp8sa/Qxb5LsljYC2
	 W6rE4j0NxTLAkwDh845cBFmDG+aGzHt3MpXM1eCYnH4Rv50mImaB0IksIfFY22vEKK
	 GFyKs5otNo1knw9SNA++V+titfbeS/YG6qP8Bw3x9ertLJ+ov2b9Aa26LOvgJRK36r
	 TIL0gLzP2y5BgykGTFpUKaHJKSNUC6yuAIQ+YS75N8cNlD+GRQr+fbnpp00mhfKEhO
	 V/uUJu+tBV/uFo+FS1G/qzsCotxDrkbIWIuImzBHdFxs64wV9et4WvWkTc8VgvdODm
	 mCcLM+Q3ERIkw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710C3383BF5F;
	Tue, 29 Jul 2025 19:45:00 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain/cpuidle-psci updates for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250729111743.14723-1-ulf.hansson@linaro.org>
References: <20250729111743.14723-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20250729111743.14723-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.17
X-PR-Tracked-Commit-Id: 05e35bd07d56780f0a5119973995b97a16843579
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fc8f5028eb0cc5aee0501a99f59a04f748fbff1c
Message-Id: <175381829885.1616007.17630324003432809799.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 19:44:58 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 29 Jul 2025 13:17:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fc8f5028eb0cc5aee0501a99f59a04f748fbff1c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

