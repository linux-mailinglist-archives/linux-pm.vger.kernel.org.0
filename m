Return-Path: <linux-pm+bounces-11975-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9989694AE96
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2024 19:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46AD11F22155
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2024 17:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0484413B7BE;
	Wed,  7 Aug 2024 17:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gW5I16uL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C887D3F5;
	Wed,  7 Aug 2024 17:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723050119; cv=none; b=XaeJ3MCOCjGAs0Stwng7t3A7NoF3SIgQ8PmW37vLmFAd0oB5RYK+i9a6/kiQSQ0bJeIcreqmhUomsLxsHHk+pMvWJlwKIPEuPNSdwlHooYOQBDTqMlwrlm1qqY1civpGfYGU/MJJGf1Pw6fhA3V4P4EbScnyKq+/9oGQEdXiflU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723050119; c=relaxed/simple;
	bh=kQtPVAkjPZUzKkRDH0jSGffwo6O7V62ke2tvI6az7hM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Qll58yLxQhdrxwYqdIZ/Vn2GuAI/AEwEgjJjd6Pgf33yWVvk/OXe9jF/ehCNEW8cDSWsefiwk4y5nTOv+FdWiwc/cdULor9JXPLekPn6I0LVHAauvLNsdyG95J5/0QuuSqEcO2QKl4BBXGS5i8OwvwzLmgaO/gUtMy9/mAidrX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gW5I16uL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3A7C32781;
	Wed,  7 Aug 2024 17:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723050119;
	bh=kQtPVAkjPZUzKkRDH0jSGffwo6O7V62ke2tvI6az7hM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gW5I16uL/SKOvPebLBRNgjbb1QbiQNbWXpyRayxvMS0P97ujuT9f+P7alWEpy4pTL
	 p09L88rfJGXKuTdes1GhjLeqs/UCqafdNs169b1aqZz//UHr2uhfZi1Ftf5TyT6uMv
	 FSMyLGxFw3VvE012FXgopSG0HVMc59zKKEDD1sEuU8Ei0tsdxW4T0XRKd+qXtr2mOw
	 rHmXgMAdDuv1xvpUymIQsSKYysHTliajooQV8KQAPCdzWqDpdItoKcxQ3J0czkyjP6
	 LqXqpMjU0LeawnGu8A5QfnPZwzlnXLee9B6jEmfrtYQo5EsicQuqxEu+UYqYw5twtq
	 f2mLBvxkeFYfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1353822D3A;
	Wed,  7 Aug 2024 17:01:59 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 6.11-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <uw3qk5vbjkonzirjhsrjlkq34sj73g5dtf4uw4yhprf6y6dn3e@umuf6mghw3f6>
References: <uw3qk5vbjkonzirjhsrjlkq34sj73g5dtf4uw4yhprf6y6dn3e@umuf6mghw3f6>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <uw3qk5vbjkonzirjhsrjlkq34sj73g5dtf4uw4yhprf6y6dn3e@umuf6mghw3f6>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.11-rc
X-PR-Tracked-Commit-Id: d6cca7631a4b54a8995e3bc53e5afb11d3b0c8ff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 94a8ee195daf9b2d081a573d740993cef4a64a20
Message-Id: <172305011834.2608521.8628569186990592218.pr-tracker-bot@kernel.org>
Date: Wed, 07 Aug 2024 17:01:58 +0000
To: Sebastian Reichel <sre@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 6 Aug 2024 23:35:01 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.11-rc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/94a8ee195daf9b2d081a573d740993cef4a64a20

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

