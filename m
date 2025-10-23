Return-Path: <linux-pm+bounces-36751-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EBCC02AD9
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 19:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D474E549187
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 17:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7D02D0620;
	Thu, 23 Oct 2025 17:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rjbEgSod"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4249023D7EC;
	Thu, 23 Oct 2025 17:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761239047; cv=none; b=JmL/UegYn+y3ncmzFRuW5mT3RptGmHFQ9ExSwv7UjyCdX9wcOVkNyUDpDegtwDApWnkrZQ6tyxnIRdr4wmaQlYGfkG9ECoR0R1WotRFEaWOmZ6wrau8evsG7t6/iDdgVuOvESg8DAPzSlwssIXJn4AUqP3ukxEzUV9/Q65wjb8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761239047; c=relaxed/simple;
	bh=gH3KkX1osZ5VEv12dqCzagnAt+lned/8aPvUKesKR94=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZVpgZS6xexQQwvH3EHoH5gIiiZUNVpFK0uoa4kuePpVsdCngSrPRn4XY6E5aboqYr0ifks9dW2M/Bca1zofOQS/AaH0goqJNraaoxLbEMzY0locimAeJxpUuBNkn1/XEGcjCBTIo2zLJoaj5t5bPIKfkz+i8nQYZ0oNchSdNUCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rjbEgSod; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2DCC4CEE7;
	Thu, 23 Oct 2025 17:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761239046;
	bh=gH3KkX1osZ5VEv12dqCzagnAt+lned/8aPvUKesKR94=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rjbEgSodCWz+GlXEFEUIVczGlKqdSOfs5fU1UFWwwX19UMQLWRL/remqaSREoYj+c
	 KjYL2u3hKMjtWNCLiryXI0HksITsuqb5W1PtEq0KprsJ3hKBaGVqDm7aL3HZdimRuN
	 j/jCnK43+4sWQ00ZfTSvegg2SWEtOQ9R4MFnUlLW/jx1nMYFIOPpcehDtztKMlSHQF
	 OS9PEwwmYZENzrujE+AbYbYa1Ca5meIiM1jQ8eA+74HCG9nl+VxG2cdDOGGvTCXTII
	 otxcj59j+CBJhI7jvgo6rs1mCX/649lyoxk2olnK2yhh9vPQN/22NFqCgo6ev4qrtL
	 fVzxGEw7ouGPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FE6380A94B;
	Thu, 23 Oct 2025 17:03:48 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v6.18-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iGoHmc0bV2WC-pvok6a-teOR76XnmSUu_LBromN-kFRQ@mail.gmail.com>
References: <CAJZ5v0iGoHmc0bV2WC-pvok6a-teOR76XnmSUu_LBromN-kFRQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iGoHmc0bV2WC-pvok6a-teOR76XnmSUu_LBromN-kFRQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.18-rc3
X-PR-Tracked-Commit-Id: b62bd2cf7e991efbc823665e54dd7d7d8372c33b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 85db0c0a971f8bb009452f1dc4267001f2cc7e86
Message-Id: <176123902688.3171289.17140096335110120680.pr-tracker-bot@kernel.org>
Date: Thu, 23 Oct 2025 17:03:46 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 23 Oct 2025 14:46:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.18-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/85db0c0a971f8bb009452f1dc4267001f2cc7e86

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

