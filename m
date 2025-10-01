Return-Path: <linux-pm+bounces-35652-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E05CBB20A3
	for <lists+linux-pm@lfdr.de>; Thu, 02 Oct 2025 01:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48766488194
	for <lists+linux-pm@lfdr.de>; Wed,  1 Oct 2025 23:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4C931326A;
	Wed,  1 Oct 2025 23:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWem3NXf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760BF311C2A;
	Wed,  1 Oct 2025 23:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759359652; cv=none; b=alDKJLMeEq2J8H6HiEE+q1lDYZD3cqqMZoCGHJW6mJSrEudW6H09xo0ZKM3bDBcJ+Z0KJs5EATwNKZEMsK3UqxvUr+ehUAVNlrJAL635e+iwVDVjDVTrQXp355Gj4dzWvUinn07rw+zab/7frL2T1LBYQsdqLUtkDJdRseWLgxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759359652; c=relaxed/simple;
	bh=vQ2dRn9G2+i+CuKYiFX/MF+1U+tSiUPJXbtjAQ15ifo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QqmwwbUfj0MHdADpfc6pfp0vA2i4PPTRtOWH6S3uC8JPIzSnwqvNHaBO0/Xbr0Eji+f09tlKiRDV509xve3HzVqFLsO1ZLo492XrUD5dK0fK6PGyL29vpirqUSoCtacnpYd8TvsWKJLZ3yQCuQ+GoN5mPMbDWAMrM7meEdcqAzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWem3NXf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59332C4CEF1;
	Wed,  1 Oct 2025 23:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759359652;
	bh=vQ2dRn9G2+i+CuKYiFX/MF+1U+tSiUPJXbtjAQ15ifo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eWem3NXfJbQx4FPtTxDAZ2+z/EtL2CMZ7KKLC5NTNimE84RsFV7cNSJH/7W75OFPh
	 mZSxbifXEbD59lqI/uf4TRc6fYxYQ/FL2gYuMTKa1JmQddFhj6ZnoPcnPcCvIJJq5X
	 BhNUodKTgBHwoh1451senkx5Z80lYjn1ZMt0jSC8+Wnf9IIXgOus3XfwuRttspIk8B
	 1hFNV8frACbl/HtOh/QLdpDknUCSqFTNPTJhZfQq9aRfbqmBwHDb1eqgLPsoHSqG9O
	 rOIRlziuCvufcYsTPPNHje3tVpGmKO82+6snCv5SuUyI+toIajzfQHtqTRaKF+1AUa
	 sPNG8m215cQww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEDD39EF947;
	Wed,  1 Oct 2025 23:00:45 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <vflh2stqeaa6rnwipi77v2k6cb3jynzja7qf2iznttqz26zbfg@7snfbz5gjdlz>
References: <vflh2stqeaa6rnwipi77v2k6cb3jynzja7qf2iznttqz26zbfg@7snfbz5gjdlz>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <vflh2stqeaa6rnwipi77v2k6cb3jynzja7qf2iznttqz26zbfg@7snfbz5gjdlz>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.18
X-PR-Tracked-Commit-Id: 41307ec7df057239aae3d0f089cc35a0d735cdf8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3ee22ad492a49303f54d4e1c5168327742ac7aaf
Message-Id: <175935964457.2650940.3105933798914105304.pr-tracker-bot@kernel.org>
Date: Wed, 01 Oct 2025 23:00:44 +0000
To: Sebastian Reichel <sre@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 1 Oct 2025 02:04:08 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3ee22ad492a49303f54d4e1c5168327742ac7aaf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

