Return-Path: <linux-pm+bounces-35792-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D43BBC26A0
	for <lists+linux-pm@lfdr.de>; Tue, 07 Oct 2025 20:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3CF844F90DA
	for <lists+linux-pm@lfdr.de>; Tue,  7 Oct 2025 18:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4968A2E974A;
	Tue,  7 Oct 2025 18:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duMNvJgG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010072E92C0;
	Tue,  7 Oct 2025 18:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759862323; cv=none; b=IGx3E2pzLsQ19o1aEgg2FsBshuGQOtqkgoyPzpz/KyEtg5URee6JvEcfGM9rMtXXETM1HjdAZaIK+GW2GahqFMAp/0h3QVM5VQU0D53CCmytrxvvCchQ5ekKVX9aJGn5iXCh8sUPw+ZNPYsIuz22LYuyuXYBCmK3fadoY7yO8HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759862323; c=relaxed/simple;
	bh=v74Cttt2NFDssXbJ27Epbcgmrwt3TvfSFlZYyt2xGHg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Cz+HDMTzs2DWw4StgtL9dxB6bKP4EO5d9Vi3+jZwZ5rvXrNxCBjoXK05siVUdO5WYOdzDTZ80Xv5a4YeLIRswdozN7BJ0vuJOeJmNo+Ws/iY79Md9PRECI41BQNBRtTpaGm8GYPOwR0XSBx4x5QLv5NFsWRb0QtN/X2orrNQUmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duMNvJgG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01B5C4CEF1;
	Tue,  7 Oct 2025 18:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759862322;
	bh=v74Cttt2NFDssXbJ27Epbcgmrwt3TvfSFlZYyt2xGHg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=duMNvJgG2Obm+gEaMXH6v/o0TgZpFpXLgcWiBl8uFWdFvnJn2C6A/UWDig05nvKAP
	 FMGqO9NZEqMS60+JCOU1wKgLH58/9IvRzWHBAR1MjsCfUeTspKSiV/rJohedHawMBe
	 3aJfmESomrmVM3ywC4k4Kknv7Q2jXd4NyMXFB7m0AJCm+kf5tY4kgABWvpDcX/sJP8
	 s3Q+wLXoEMzU3v5dlnacFk7HTP420JpmVR4UqrGi3krQhAaciAMwX3owiFINiOV4A+
	 KbPBmqUqklosDqdrsDQYtIcLXM+O3D68WMJZ1FZcEOFlkBX+nQl3SBl5LX3UI9k5Ft
	 q+NnDu+XlkS7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FCF39FEB72;
	Tue,  7 Oct 2025 18:38:33 +0000 (UTC)
Subject: Re: [GIT PULL] More thermal control updates for v6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gbqcV1GzM6AKzt0kob8ZzuDYRRVyXCEMqD9kL_4ZPNOw@mail.gmail.com>
References: <CAJZ5v0gbqcV1GzM6AKzt0kob8ZzuDYRRVyXCEMqD9kL_4ZPNOw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gbqcV1GzM6AKzt0kob8ZzuDYRRVyXCEMqD9kL_4ZPNOw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.18-rc1-2
X-PR-Tracked-Commit-Id: dea00c204e7e99aca9a4cb8603174c4cd0051728
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 56019d4ff8dd5ef16915c2605988c4022a46019c
Message-Id: <175986231184.2733874.11615087675909545215.pr-tracker-bot@kernel.org>
Date: Tue, 07 Oct 2025 18:38:31 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 7 Oct 2025 13:33:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.18-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/56019d4ff8dd5ef16915c2605988c4022a46019c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

