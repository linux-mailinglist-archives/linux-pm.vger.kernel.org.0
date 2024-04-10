Return-Path: <linux-pm+bounces-6249-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1118A0123
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 22:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99DD51F24ED0
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 20:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEF3181BA0;
	Wed, 10 Apr 2024 20:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRSUZIj7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580DF181B96;
	Wed, 10 Apr 2024 20:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712780259; cv=none; b=TBV+IItBDx7l5LQsWTrMrBU/yAhT/9f8HFum8dsGORzoCU7Cqgy2n0TmgsZ0ZVSXCv/wN5Zq6hvDaMZ6dHxIg61lisAVQy2IBGeENxB+fc+siuqWG5pONQqE1CFGBUBnQTJRjPub4YW95gaPx/GP7V44yfLXJDFPsCROhY7CeOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712780259; c=relaxed/simple;
	bh=HwlGOSSpMmkjueXmrpePqQTV0X8zsip4d2r8sjMc3uo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LqObU8aZRhMCnpAKqNgplCXf40hjOGovYItD/65Af1M7kaAt1oyUkMh2nji59I+Otg1BmnCZlPo03x5EK8iSsVd9aiXW2izEupCqKiRmyfzNDMpHkW1eWD83fDZHM3Tb93X2O1wwgBUEopg590C/laEuxRUJKaE8M85wzTLAhNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRSUZIj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB8EFC43390;
	Wed, 10 Apr 2024 20:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712780258;
	bh=HwlGOSSpMmkjueXmrpePqQTV0X8zsip4d2r8sjMc3uo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lRSUZIj7q0vVDQYu3idOz0BwWN5cqzBDxbFPKEUxnVNNFmUbwyg5Ec06ZqysPT9LO
	 o+lECoatEFPKy7w9XEZwMp3vtKcLMxyJ7TKacfP9R/f7/gK3IWqDt4uK7cu6qMB2I8
	 1wpcNUIjczChcDpee8GJcGIoiZO9F2l9XN8rSuoV03Wg5GmdAhiOixKwnRJ/yhDEQf
	 bgAEYi33EZCNPS83Tc/GrI7a6tlzVPJIks4KiSXlpUkeBCyQcRheEavdC+d1iCBFGZ
	 EOdDC0vVmLptYwlonJz3C+Nr8jjO9Wq75nk+P82JbZCDPCzLeE/gdtbzNh6zUVnAFR
	 YuvL1s7ibARWA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9567D60311;
	Wed, 10 Apr 2024 20:17:38 +0000 (UTC)
Subject: Re: [GIT PULL] turbostat 2024.04.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJvTdKmK_U7nChpm=MzaDyw3T9V6hSua-6C89WCjo828vxm+yw@mail.gmail.com>
References: <CAJvTdKmK_U7nChpm=MzaDyw3T9V6hSua-6C89WCjo828vxm+yw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJvTdKmK_U7nChpm=MzaDyw3T9V6hSua-6C89WCjo828vxm+yw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git tags/turbostat-2024.04.10
X-PR-Tracked-Commit-Id: 3ab7296a7e6aa34634dcc2926af933107a117996
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a6189a7407795b3f5167ea532ac85931cd26083a
Message-Id: <171278025875.11836.1517064915703406253.pr-tracker-bot@kernel.org>
Date: Wed, 10 Apr 2024 20:17:38 +0000
To: Len Brown <lenb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 10 Apr 2024 09:24:19 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git tags/turbostat-2024.04.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a6189a7407795b3f5167ea532ac85931cd26083a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

