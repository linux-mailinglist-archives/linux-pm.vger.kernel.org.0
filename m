Return-Path: <linux-pm+bounces-19785-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA969FD77C
	for <lists+linux-pm@lfdr.de>; Fri, 27 Dec 2024 20:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27A29162A75
	for <lists+linux-pm@lfdr.de>; Fri, 27 Dec 2024 19:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096671F9413;
	Fri, 27 Dec 2024 19:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXZLSyON"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43631F940F;
	Fri, 27 Dec 2024 19:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735327331; cv=none; b=MDjhTPQD+YmAsHilneaf7UvQ5oi/k0+2rdkJhF+WiFto4rCUuCBDdd5ShM9RdSTPgRTlIwAtSQ5R3tKm7Zw4LkY/6sU0ijoTmb7FRHs832GZx9pAcf8pmbljrek+TRJT0Wx7GqOBbLtFAqSAC1C2dnsCpheUBT4LPpOKlLIX5Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735327331; c=relaxed/simple;
	bh=tJLQb6Z6Jvff5qSjn8eGX+HS57ANx7TLDrhwWH1K2U4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=uNfbbynAuGGQCTzkjmqdwRlp2neJeGjgVqVxiQfD4TNQprARi84MsokGk+eR0HnMhgzEBB7aDaXKjYgVHp0F/w3Y8ICKn0Z6CV7Qd8q667FhZ8tcnuLNqvgetytasRP+SQRRHoIV2xTeiUkrfA2+w2kNvbpRl+R3JUiYX+lUApI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXZLSyON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54C5C4CED0;
	Fri, 27 Dec 2024 19:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735327331;
	bh=tJLQb6Z6Jvff5qSjn8eGX+HS57ANx7TLDrhwWH1K2U4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YXZLSyONuasdhBS70TzlhO3Af2ka2GT8pR/9OFVP1WvetIWq2Wz2rWc0ULqQ3RuhK
	 w61wDNFTDcmBtuIfMZrDSDh8hhY2zJ4F/I/TQNCTcCYDPCpLNDCsZGjdBmGfD+vhes
	 B5sPu2A/T3RoeqRPhNABBQvNlmlesS85jYU2u+W10j/i7tDJh0qX1WIgtczVfbZ49w
	 tkNEI6aza3F8C9vo83+Q+oevCbOV24FBzTVfPdMJjz0+BxvYEc/EXV+9FySCF9zSU6
	 vX7b8YJ0E9/apnY6dfGi3VwRu6PSWCJu1UTPGipL5AzW5Eb3MGYMK5tZTcrxUd5wwx
	 t7GVJZqaDTFIQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C4D380A955;
	Fri, 27 Dec 2024 19:22:32 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 6.13-rc
From: pr-tracker-bot@kernel.org
In-Reply-To: <ynsgbm7pdff4ywjkzrdqcr5zdpiexuvg7zalj3atxiryegbuel@yrxewux2mt6j>
References: <ynsgbm7pdff4ywjkzrdqcr5zdpiexuvg7zalj3atxiryegbuel@yrxewux2mt6j>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ynsgbm7pdff4ywjkzrdqcr5zdpiexuvg7zalj3atxiryegbuel@yrxewux2mt6j>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.13-rc
X-PR-Tracked-Commit-Id: b3ded6072c5600704cfa3ce3a8dc8718d34bda66
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8379578b11d5e073792b5db2690faa12effce8e0
Message-Id: <173532735069.574555.11968387953154085091.pr-tracker-bot@kernel.org>
Date: Fri, 27 Dec 2024 19:22:30 +0000
To: Sebastian Reichel <sre@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 27 Dec 2024 15:36:26 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.13-rc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8379578b11d5e073792b5db2690faa12effce8e0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

