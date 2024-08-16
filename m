Return-Path: <linux-pm+bounces-12375-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80165955118
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 20:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B956B23931
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 18:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FE91C3F02;
	Fri, 16 Aug 2024 18:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7D4G88n"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3952BB0D;
	Fri, 16 Aug 2024 18:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723834409; cv=none; b=LgtY6CTaB++9tLLs9myeyp5kO0098+VWfarQMOwwISdhRFMAZnVtQZwVt470TCMTU573FBzhHxd5pHhkWLKQixE099VxiyWm8h/sMaKuPcVPRUXazawyOtkbN46At7sgvBEw6vA1CX73ryOarI/wkLsYcrqBc52arb3+FaadgAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723834409; c=relaxed/simple;
	bh=9lUZSA8unwQY5Mnoaivg+qYRSI4C7G9UDbZUZrXxJpQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ty2ZGPwm5+dgZVDEeDgXewrpgkc7mVilC5Z+asV95+5GTaLxfZepMIPcKvlKmqblcuPZpFf0bVQ1VXYNmEKjLkpnn0pbFh/4Ol4HdQRAVPvRA3Xp7UCFKg/+fgrdm5f3vqNalKsc6Xvz3LqotQvykGHv6Oi9cnXmGXUA+BdEPCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7D4G88n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A06C32782;
	Fri, 16 Aug 2024 18:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723834409;
	bh=9lUZSA8unwQY5Mnoaivg+qYRSI4C7G9UDbZUZrXxJpQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=G7D4G88n1uhQz88ymP6TouIizDdniSrNwSPdXtfj9CQPX/eikTqV2IwuUh134iOTa
	 tgS01csXouvejctR+U4mcu7avjBW52BufjhWr8yxhm4Px1mcddgGvuznunn6OaSZV6
	 hG1J2u3uBoR5+FJ9JULbyifCIZJIlQbagtaHT8WtlGU1qLzGzBMJfqueVnYj08m7Oz
	 BoKTtlBnNtWOJyAeFRFcVMnyHs5WxlKsW8Uo30ipaK3aTlRJgKNpkd1hBVhALezjK0
	 qPehmxZ8FbhprA6qwRInLO4SAqnByn0hDh0oIvqW5AgO47VPA2mY6H5I5Xq6ftPsjf
	 nTyY0vIJfsGOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC5A38232A9;
	Fri, 16 Aug 2024 18:53:29 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fix for v6.11-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gVtyuMaB=XafJy8dUtaMvDD=5aQkaUgPsF0B7KtQQa7Q@mail.gmail.com>
References: <CAJZ5v0gVtyuMaB=XafJy8dUtaMvDD=5aQkaUgPsF0B7KtQQa7Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gVtyuMaB=XafJy8dUtaMvDD=5aQkaUgPsF0B7KtQQa7Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.11-rc4
X-PR-Tracked-Commit-Id: 6e6f58a170ea98e44075b761f2da42a5aec47dfb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 296c871d2904cff2b4742702ef94512ab467a8e3
Message-Id: <172383440864.3603929.17236250111640308766.pr-tracker-bot@kernel.org>
Date: Fri, 16 Aug 2024 18:53:28 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 16 Aug 2024 19:37:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.11-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/296c871d2904cff2b4742702ef94512ab467a8e3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

