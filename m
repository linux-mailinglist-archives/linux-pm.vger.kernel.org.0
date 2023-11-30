Return-Path: <linux-pm+bounces-583-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C1B7FFF64
	for <lists+linux-pm@lfdr.de>; Fri,  1 Dec 2023 00:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61871B21003
	for <lists+linux-pm@lfdr.de>; Thu, 30 Nov 2023 23:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B1B59533;
	Thu, 30 Nov 2023 23:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdHemeiD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E264C59530
	for <linux-pm@vger.kernel.org>; Thu, 30 Nov 2023 23:24:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B384C433C8;
	Thu, 30 Nov 2023 23:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701386674;
	bh=nvvbPETKardh7d1tAn3mdJvk/G0HxoiSnunSAWYJf+g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bdHemeiDxPzrEMdUT8RZQjE4FrwbB67z0PH+3YNIWDMiped4u8ZEvJ9vg88IkQgdG
	 WpUn5RdaTNGKGfoK1kAGab/LTFOTyorpMTasy/GXYSrCYdhulDxLeGedcJoLc+BlGm
	 B4H57X5vIG74NxbM3g0x5D4qDikVWcRmXqYL2tUvOoTpqqVP8TZYfXEP0lKTs6+9Co
	 3gxsGofo2XxZhRMyfeMnYVjtgacgU3KXt5dA2u8wFIzih6aDB+QPU7bsCRi8HfXN4Q
	 phuqe1lOZxQXlPiR8swNbv9Z23qCMF+qtIUSrVJVdTkGf1/GVeZbuGSgR5OOPi261g
	 f7CBNtj+Gf/Dw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5909ADFAA82;
	Thu, 30 Nov 2023 23:24:34 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain fixes for v6.7-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231130112928.64992-1-ulf.hansson@linaro.org>
References: <20231130112928.64992-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231130112928.64992-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.7-rc2
X-PR-Tracked-Commit-Id: 0cb19e50a911aaadf49eed120392e429d6e1fa0c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e8f60209d6cf652a9cfda64371acea69f62770aa
Message-Id: <170138667435.16887.9779453877181969899.pr-tracker-bot@kernel.org>
Date: Thu, 30 Nov 2023 23:24:34 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 30 Nov 2023 12:29:28 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.7-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e8f60209d6cf652a9cfda64371acea69f62770aa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

