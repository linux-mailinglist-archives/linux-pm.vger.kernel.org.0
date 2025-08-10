Return-Path: <linux-pm+bounces-32085-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABDFB1F8A1
	for <lists+linux-pm@lfdr.de>; Sun, 10 Aug 2025 08:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 574CC3BD5EA
	for <lists+linux-pm@lfdr.de>; Sun, 10 Aug 2025 06:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B1E225403;
	Sun, 10 Aug 2025 06:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqUR0lSi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A13221C190;
	Sun, 10 Aug 2025 06:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754808008; cv=none; b=kpGt6FBhlUsud+2fVU8c7VqlEVoQWxQJF3wMYP32JZYFqr/mGN48+vU/7NI22eHWzpguLGxRbuL6lD4i0t7xaWy01v3PA1swc5v/zSUxOY6mWWkPbfoRfTX2DaWscU/EwDROZwzHWyLLTYjDpMLlzcNM4h125mND1Mx8A45rZ60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754808008; c=relaxed/simple;
	bh=xS7tcMNTNfLGEd2QLFy7zN1O9tPPhyR/q5B25vKVhr8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SXPb5O9BMmFfJ0zuUlWAXw4B9pmnjWvCg7k8Ls7WP5tjeCArYC9Qhjtt9ih1ctCcKKuPh4+zuQmXUkDkbV2PGVS4gioYGJ+IQT3L6E7w7pO7eLBYHQq7MZGqN0tLxkOTidy7JRHgN56gZweU/ezTBsqtHW1F897gTd9WRelZISE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqUR0lSi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394AAC4CEEB;
	Sun, 10 Aug 2025 06:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754808008;
	bh=xS7tcMNTNfLGEd2QLFy7zN1O9tPPhyR/q5B25vKVhr8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BqUR0lSiOKQHoFm0DjLvqYT02pSC+KDIZfc5A6zjAfu8313huOwH7LvstXiIHQV3L
	 Pm/qJ/pPGpvB81rGePjSq++F5wcwySJ9FOszkIwNRw8TLcx+bis2yxlUT1WTS8K4kJ
	 2G0nUxC2su0NeIs6G7ZKRUammYo349eJTpB3MKH/pCsISmKxc+R3QmLETg0Dx8rQ9t
	 58tnQJvL3HzeNjv6mcSqGOQJzVQC/lYGrl8jMiBAtHpxThlE3wGSOkHZ24+t05QYJY
	 XvGbnqWpvXekcmBliRH2k4OMszzBWIB7IuORdb/4YUYdgGZcopz4HD++xXVp9H0By+
	 DsUfHagaq7xBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FBC383BF5A;
	Sun, 10 Aug 2025 06:40:22 +0000 (UTC)
Subject: Re: [GIT PULL] turbostat v2025.09.09 for Upstream Linux
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJvTdKmaTvaQiRjgz_Pr6a+XEkLzEnedujV=vqwv5thEE63fdg@mail.gmail.com>
References: <CAJvTdKmaTvaQiRjgz_Pr6a+XEkLzEnedujV=vqwv5thEE63fdg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJvTdKmaTvaQiRjgz_Pr6a+XEkLzEnedujV=vqwv5thEE63fdg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git tags/turbostat-2025.09.09
X-PR-Tracked-Commit-Id: 5e98a5e73edcc4114c5ad10596db87e24f50ee4d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2b38afce25c4e1b8f943ff4f0a2b51d6c40f2ed2
Message-Id: <175480802073.685752.11911141219322023531.pr-tracker-bot@kernel.org>
Date: Sun, 10 Aug 2025 06:40:20 +0000
To: Len Brown <lenb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 9 Aug 2025 21:37:16 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git tags/turbostat-2025.09.09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2b38afce25c4e1b8f943ff4f0a2b51d6c40f2ed2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

