Return-Path: <linux-pm+bounces-8672-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DD98FD9E8
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 00:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D69A1F2492C
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 22:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6581C160794;
	Wed,  5 Jun 2024 22:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bt9px87O"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C03916078F;
	Wed,  5 Jun 2024 22:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717626931; cv=none; b=GcihGUBeHh9dzo+2lqP+AhwVOC492SJiWJkn49gPpaHMAqNUuBxd/kj2kcpta3gTDiMHuR5PRmcGxL3KSobMsaWitydZndi23yFks/0LZ0JSa7xA9nS1Rx/pXtpXcvZAJEAfM2qd9AfnBnpcpmEilfXfMKbm3VaCT1bxfLWKTro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717626931; c=relaxed/simple;
	bh=barkOXjjJg6QDRR/1TEF5LF2AKkFw09Z3p4De6bKHhE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LNHjzaWfaqz4wn/OcKk/fLUOYpDmvapI6mS0bMRhzEkJ6fjP5W2shEuuORB/92OPuSL9S9dP7Z2HuxdL0OVut3whHLu4uBnnQ9sGPR6EkSn276acNuciJkNZOI7EvhlQs7l4/50NRF7mKYYkQTgyRPyfiA+tVJLF7f1eIdWf5Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bt9px87O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2222C4AF08;
	Wed,  5 Jun 2024 22:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717626930;
	bh=barkOXjjJg6QDRR/1TEF5LF2AKkFw09Z3p4De6bKHhE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bt9px87OzJu2uV4BdpDhKi3wnKouR5CzZ8GwLtpxpTzny4TBjLxw0DIgRzAoFV5Ir
	 8CMstupLxjZxAiisolY2FNObYDcpWeRNMXI4fXwIVXD/WYPuLL/sIyn1WWkEPG5yoq
	 XKU26CFMZTH2PlPQP7qq7Skm+U4Huf8uuqaY2+m/QIvKBFAgv46C4Xp3nZXlEf5aiY
	 DvePtx/81PStMw5Bwkau27nBBvi1DkGppG6/ZQitanlFDkFmERE6CU2NwHIn4RIF9y
	 RO/88iMmUEvJprX5nlRjCnj/uKu4IcxAcBLdAosmEV88MwtmwJ4Zf2ldUbbGY6szlg
	 uHYbyikaCq65Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9BDBAD3E997;
	Wed,  5 Jun 2024 22:35:30 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fixes for v6.10-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jzcHmN-B3z1pajYi-NhD=igUi=RYrU9dkvBgoy6ZRdiQ@mail.gmail.com>
References: <CAJZ5v0jzcHmN-B3z1pajYi-NhD=igUi=RYrU9dkvBgoy6ZRdiQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jzcHmN-B3z1pajYi-NhD=igUi=RYrU9dkvBgoy6ZRdiQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.10-rc3
X-PR-Tracked-Commit-Id: ae2170d6ea96e652c7fb5689f1980986bf48b7b8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2df0193e62cf887f373995fb8a91068562784adc
Message-Id: <171762693063.28636.8082236676136108318.pr-tracker-bot@kernel.org>
Date: Wed, 05 Jun 2024 22:35:30 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 5 Jun 2024 19:59:48 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.10-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2df0193e62cf887f373995fb8a91068562784adc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

