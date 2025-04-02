Return-Path: <linux-pm+bounces-24714-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A070A785F7
	for <lists+linux-pm@lfdr.de>; Wed,  2 Apr 2025 03:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 687DE16E0E6
	for <lists+linux-pm@lfdr.de>; Wed,  2 Apr 2025 01:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA031096F;
	Wed,  2 Apr 2025 01:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B95o++vg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328DCF9E8;
	Wed,  2 Apr 2025 01:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743555708; cv=none; b=RCxL2+jF+u/Dq5hgYfcg1qGMPSCrj7Z02ndN6LlWxIeQDiZJ79Taky9wLg0W3stdYynpb6bPCivYE+xaIgx7jcd2IXuL+ifx3eiMX8k9l7hA8kUDVppBwjC+hKoejx7i8Hsqb40pbVpbQRvgePCSu8KB00oHMX/kbeDi7Zz+VA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743555708; c=relaxed/simple;
	bh=/RDoEvzbnJmtSkLiqBjfh7A2x9BJ6j7hRAbPIPApz4o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=shku74k8FWk5rPUp40D0FHI2GK7NF2vL6ilz6XD3UwdBjXUxpSTDYEdQQAuHuVQhSQbiUGgFJBfOelYrxBZeM23mZ0FMTDb4Kjod5qLq4CW/MyrVw8TGgbfeVk294skjSOCS1/xZSSXf5mqryR4iJUc0+TyWrYEjdvqlYYB379g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B95o++vg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A64A8C4CEE4;
	Wed,  2 Apr 2025 01:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743555707;
	bh=/RDoEvzbnJmtSkLiqBjfh7A2x9BJ6j7hRAbPIPApz4o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=B95o++vgA+N5xSa5vwlKiTuKVQWVsMSy0Pu0wsIrEKRz4WaCmdJ1HHJm+I9/bjh7/
	 eyXoopbBqiqB3cZM5c6ARUbcVxyyflvhgsuB8jjykApmxOAPSsjcAFR8buE6DCbFDx
	 DS8ipoi52NafYkJZMaSl9Ws/xH/NELc14UvN7ytRDOwvnIkEYYdaBJKOZb3MFhPGiz
	 IA4Cj9ahp7H0cjPc5ufb9Pf7kLraWRY8ML5NFOlqsjP7IFvrPA+VOzC3ODq6f2Yo+g
	 zoJywgSgQiivCwstg177ItJzFFXXrRfo1p/e9GsDnyfjnZKmv7P+zHPI6sR+MF1zH+
	 6caRGsT1o+PNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD52380AAFA;
	Wed,  2 Apr 2025 01:02:25 +0000 (UTC)
Subject: Re: [GIT PULL] More thermal control updates for v6.15-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jZdrpxXC8e=-uiJaHx2irYAgkW=kZ6OqSfOK2Fxc6=JQ@mail.gmail.com>
References: <CAJZ5v0jZdrpxXC8e=-uiJaHx2irYAgkW=kZ6OqSfOK2Fxc6=JQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jZdrpxXC8e=-uiJaHx2irYAgkW=kZ6OqSfOK2Fxc6=JQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.15-rc1-2
X-PR-Tracked-Commit-Id: 12da0fee4543ffbd50ff01b16153cc6ca2f7453a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8868485d6b13e6e12b9a90fb5d8cb2f26eb1264e
Message-Id: <174355574414.978371.7734741341506300704.pr-tracker-bot@kernel.org>
Date: Wed, 02 Apr 2025 01:02:24 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 31 Mar 2025 21:41:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.15-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8868485d6b13e6e12b9a90fb5d8cb2f26eb1264e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

