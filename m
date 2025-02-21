Return-Path: <linux-pm+bounces-22594-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 803B8A3EA9B
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 03:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA73D19C363D
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 02:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1999F1D63F8;
	Fri, 21 Feb 2025 02:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScdMywpS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E288B1D63F2;
	Fri, 21 Feb 2025 02:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740103947; cv=none; b=rQiDesrrzDxwDwnHUYNLSOE/bxNbyAkFnkjbLLbhK2KVmW8lvtXDNMvOe/im5FsIePok3skqBQ8A5iLVyKdvHWWTmyJN0QZSeE/4dG3AQ7eM8gmhWnScteIJBMwaNFbzi1UOJHHaKHNy58m3v9b/w/+2VCH/OoudYpxj9HDFQ90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740103947; c=relaxed/simple;
	bh=zWG4BFYzQyItSLuM0QZPIiavJC+sGBG+6J1oP6G41Hs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=u4NToeMJ/khG/j+uwL7MgxRw5ZyVTb9oIxI/isM4ls+FTYcvoK6shAbX7G3O8WPlk3gne40Km0zuFUnuCXVXYwTzqxVmHGRz6V2XBAEDb4w9jUuVI47tbYWknprOYw9es3zu6ZGlg3XJMcrGprTvZLIjVW5I68hIejvVDb+AyV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScdMywpS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6917DC4CEE2;
	Fri, 21 Feb 2025 02:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740103946;
	bh=zWG4BFYzQyItSLuM0QZPIiavJC+sGBG+6J1oP6G41Hs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ScdMywpSavg1dcTqXXYR14/9w/MTfMaCB3FjqUG6ZYbS2iANjrf7Q+s+B4OdDfACc
	 rP7Lefw6+i63g1hWmpX2o1ddVCU5/T4k8zCNonMb/mlDy9YJbKoZohBvDCs/DPllvO
	 adMiR7PL5QW4fwEg26AhdJQHJzAXljwpPTYmWPfgXLpfxQxjWZZbzgn/5Jq9GPJyz4
	 WnF4vdeSGthAJNam35z4O5BzaYxGsYWUUcqWuULDlwqF8f7cvFyezpNwTEjYu/IVEr
	 2gh2uIJamQOGPbTN58aPjD5jfQyywiUvLsTNWHQ54rmz+UkXD1XZlsHUtvRU6fHCrw
	 pxRsmAuim+MUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71B943806641;
	Fri, 21 Feb 2025 02:12:58 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply fixes for 6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <73672ehjkrjavtqe3uw3vlpriqclihn3y2k2snrf3qc3ovah7y@jvt2c3vrlnro>
References: <73672ehjkrjavtqe3uw3vlpriqclihn3y2k2snrf3qc3ovah7y@jvt2c3vrlnro>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <73672ehjkrjavtqe3uw3vlpriqclihn3y2k2snrf3qc3ovah7y@jvt2c3vrlnro>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.14-rc
X-PR-Tracked-Commit-Id: 98380110bd48fbfd6a798ee11fffff893d36062c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 334426094588f8179fe175a09ecc887ff0c75758
Message-Id: <174010397710.1552538.8374208410048912217.pr-tracker-bot@kernel.org>
Date: Fri, 21 Feb 2025 02:12:57 +0000
To: Sebastian Reichel <sre@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 21 Feb 2025 02:46:17 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.14-rc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/334426094588f8179fe175a09ecc887ff0c75758

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

