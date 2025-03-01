Return-Path: <linux-pm+bounces-23211-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC28A4A897
	for <lists+linux-pm@lfdr.de>; Sat,  1 Mar 2025 05:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADBAF189B69E
	for <lists+linux-pm@lfdr.de>; Sat,  1 Mar 2025 04:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1998C1BCA1B;
	Sat,  1 Mar 2025 04:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkYQzOPk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4D11B87F3;
	Sat,  1 Mar 2025 04:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740803366; cv=none; b=j9cfz+Y0SmogGIzfghUWfZwgORaOCRW0vPKhOY8pE4tQSdah5uuqTMRxlbhXB1SlTpXRmXx9GlXjH8j314Y7yJcAW6aCdCpdWCxutzzXUItOPP9zHL3D4jNjogzYcc2cmopkVAURj7JLY5z57zcFFs2QPYsQpQDTNVo9s52adYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740803366; c=relaxed/simple;
	bh=XZG5q/eOrfttE+k7lXennuGSQKuW2UexC4Ankw9ct8I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=clFGRD6JO8ViHC2u/cXK3jXfFOxQtzeH28bwZ6WiD74SrnEjMC3BpBGNtMBuJEkHqN4sWEy7/9f8twu44D0wiuPyEi+W5xEqR3w+0ZL05KEPBPaddMQoDncQXR2ILFR9/cZaKez18/nZ6CPECEfhFzpoTko5zVQ700pchbETu04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkYQzOPk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05EFC4AF66;
	Sat,  1 Mar 2025 04:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740803365;
	bh=XZG5q/eOrfttE+k7lXennuGSQKuW2UexC4Ankw9ct8I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QkYQzOPkphOMDJq4GiD50MnF4xJl5VwU4KAPXkaSXriryRNDqBJ+HBKebr7bXn/d7
	 qponwUPuX3ptU3C2SH2UTyNiTG0AUA/kwUgxJa5ypgpDXki6rCsIaCLDXHtFt2jGKF
	 8jyQMGagXoKGZpfBfvApdUJ3Zl6Y5GB9Z0AjJc7QOJzljjYxcpeI4lkrk2gNb4GdS9
	 pq20LJtA9V2r7jl4IjoTT7gCvU0Mc1soShO4C8kVatRFAHbs/pEvVX96v/ic/H1Mp2
	 pkAzeC201NW9M4OgFVqAofpMKpuNJRFZsd85z99AcnhG2O0wgDF4tDWsTMKZNDdat5
	 JfYFoZ+FzLo1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C80380CFF1;
	Sat,  1 Mar 2025 04:29:59 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fixes for v6.14-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0h4D=-gGWPaVSFBAYinRpobVeX0owRX70jZ0vaS8V9pLg@mail.gmail.com>
References: <CAJZ5v0h4D=-gGWPaVSFBAYinRpobVeX0owRX70jZ0vaS8V9pLg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0h4D=-gGWPaVSFBAYinRpobVeX0owRX70jZ0vaS8V9pLg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.14-rc5
X-PR-Tracked-Commit-Id: 0cde378a10c1cbfaa8dd2b89672d42f36c2809c3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 03d38806a902b36bf364cae8de6f1183c0a35a67
Message-Id: <174080339786.2364407.15614534404433832947.pr-tracker-bot@kernel.org>
Date: Sat, 01 Mar 2025 04:29:57 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Feb 2025 22:17:05 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.14-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/03d38806a902b36bf364cae8de6f1183c0a35a67

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

