Return-Path: <linux-pm+bounces-11512-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAA993E8E4
	for <lists+linux-pm@lfdr.de>; Sun, 28 Jul 2024 20:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 952AE281E93
	for <lists+linux-pm@lfdr.de>; Sun, 28 Jul 2024 18:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2663474055;
	Sun, 28 Jul 2024 18:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJ5QmEkg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30E16F31E;
	Sun, 28 Jul 2024 18:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722192367; cv=none; b=joCO0PA4UcPFhhwikwu7fisKaEE5JBHmlb806uy0KAl1kxMr9bcK1dh60mLhnyFReBdrQM1HKs8UqkRKkG4yJNc7t6cBdFs1fq9gLqIf6THujGAscugwxtRtLcZ1kEmPOyuhFc+YF2GoJxzPQZ+xDJiCkjY/jzEmJkDL0yZaK7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722192367; c=relaxed/simple;
	bh=tCvNJ6KKyM7w6aV5KecIo7dwVPW2Z1X0QK7bKDPUEtA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=sREu8c6PU7niFl6hDdHu4nz0eSL5p+K1HDoJtskZDsnwgmTUQR86HmsT9AYzXFm57zQVvxI5QH/iGPydYhd5JLNWgAF2L1Ts0FPrFX2NhoppQeXscs9iWNWOHC+iqCooOuJKrFbUNc8qol5AtRTOYmWw3u3ul0lexbzP5FSNIQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJ5QmEkg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2B9DC4AF10;
	Sun, 28 Jul 2024 18:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722192366;
	bh=tCvNJ6KKyM7w6aV5KecIo7dwVPW2Z1X0QK7bKDPUEtA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SJ5QmEkgs2Z7lpLgZkBmIlRueo9MUIQ4mI1mjHI8P65t5EM5G+wsqgKOhTjrGbs31
	 WSTW3Up2e8Y5WlBNjJA9Vmdip2XybpsAzBtmtNvsJiyftiilPNLV3ZQTabdI2YCYmE
	 pIpCeJoalwh7pp9/9H1SNl5EGXFClMz18xFHPlF//0pZwJIJYZnLv37fdrbv9LmpoS
	 czKSHOH4hYTJbnorGkF7XhuhIMTIJGhl7Ap8OTmQpryExSM43F/UiksXINwc+sJ43q
	 55jam0rCmFC+f6w2EqST++k5DrLSHqs/B4mfQLJoBjnf/6Y+F4WTDH1eUdbRkLoqK7
	 H7dNtztkFyZ+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BE954C4332F;
	Sun, 28 Jul 2024 18:46:06 +0000 (UTC)
Subject: Re: [GIT PULL] turbostat-2024.07.26 for Linux-6.11-merge
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJvTdK=eR67WE6e9YDZKoVTStoeTMPaJ2D-2=_agwU1tjFbu1g@mail.gmail.com>
References: <CAJvTdK=eR67WE6e9YDZKoVTStoeTMPaJ2D-2=_agwU1tjFbu1g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJvTdK=eR67WE6e9YDZKoVTStoeTMPaJ2D-2=_agwU1tjFbu1g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git tags/v6.11-merge
X-PR-Tracked-Commit-Id: 866d2d36b81d7d0e6d91423b6dd9b1bcfd0510dd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e172f1e9068807a336c0429b6c57d29bded8d891
Message-Id: <172219236677.25784.3933180568660631085.pr-tracker-bot@kernel.org>
Date: Sun, 28 Jul 2024 18:46:06 +0000
To: Len Brown <lenb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 27 Jul 2024 15:11:30 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git tags/v6.11-merge

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e172f1e9068807a336c0429b6c57d29bded8d891

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

