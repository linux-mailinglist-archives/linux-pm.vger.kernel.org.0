Return-Path: <linux-pm+bounces-30192-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BCFAF9CF2
	for <lists+linux-pm@lfdr.de>; Sat,  5 Jul 2025 02:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 125937A3517
	for <lists+linux-pm@lfdr.de>; Sat,  5 Jul 2025 00:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F8213AD3F;
	Sat,  5 Jul 2025 00:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bmfc3ox1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995CA13A244;
	Sat,  5 Jul 2025 00:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751675634; cv=none; b=r+Huk1rZK9kKutRFfnPXBTbNwlAVVwCSCwTzg+qOLA1EQZNNGHIx9kjyJuOs5ebqLclDwqjNIi3e4HTmRk+zee8QhmmAeqFsVxixdUWBJ5zrz4WHtAu+iR1vB/sCnDY8D820rbYTM8WeDig8n11nLBym39Xdq6ppYs2bfCZZNQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751675634; c=relaxed/simple;
	bh=2zG9aJfb8HiKOutYiPjM2ssna7g74IhXQJF97gl1VQA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KiSyPfLjoXzN9VFaAaGov0pDfBU8R7jzYsf17EbF2dRt1U3nGEf1m5sVcTMwL0wmZ0oU/Ysrb5bJhTSj/7Wofy0/UF6J/TgSgz3DDm+ZC4TJ2aOUPrQzSJyDrAL4AZv/ASZmHxQjmjFTRdXl8sRmqp8HFcS+K8uPaRUjY98kVUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bmfc3ox1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C58CC4CEEB;
	Sat,  5 Jul 2025 00:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751675634;
	bh=2zG9aJfb8HiKOutYiPjM2ssna7g74IhXQJF97gl1VQA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Bmfc3ox1nOogKOWucrvxBmdJkC4Pk21k05eiBwg4VvsOYJErbWZqKrAE3e3UB42nq
	 w6hNhyyMU/jWnQ4jRIVRqgQeaxxE1yCpkPqaVe0B7b3xuWnADdwv6NN8bzzv8hMe5G
	 vUdQ2x9LHScpwtEtsMEr726GwxVI3X0QgUhzRiYgpJzasf3wekANTQu0oDEXbEmCDe
	 bvCdaODXp9rF9NyPenW9CM5KhbHu2Rai16v30xVCKUrwNN/ZUm6dGT5KqxuYuHOFXm
	 007qH0l7AhfgOzpqH+atk5pKv0+Q9mu/5MhgoezQHbGr6GaBG+9L/WtgleQdG3hA2s
	 EMPRrW8b2H+/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CF4383BA01;
	Sat,  5 Jul 2025 00:34:19 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v6.16-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jCB4VoYh45gBmr_a_eh1tSXxu3Z5sDd4RQHzFf-Jht5Q@mail.gmail.com>
References: <CAJZ5v0jCB4VoYh45gBmr_a_eh1tSXxu3Z5sDd4RQHzFf-Jht5Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jCB4VoYh45gBmr_a_eh1tSXxu3Z5sDd4RQHzFf-Jht5Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.16-rc5
X-PR-Tracked-Commit-Id: 250d0579da5db2052cce2891a5eaa87450851354
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a79a588fc1761dc12a3064fc2f648ae66cea3c5a
Message-Id: <175167565788.2360325.9698940491783244799.pr-tracker-bot@kernel.org>
Date: Sat, 05 Jul 2025 00:34:17 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 4 Jul 2025 22:25:31 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.16-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a79a588fc1761dc12a3064fc2f648ae66cea3c5a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

