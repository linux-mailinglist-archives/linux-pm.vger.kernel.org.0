Return-Path: <linux-pm+bounces-15554-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1293C99ACC7
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 21:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62D30B2845C
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 19:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36F61D0DFC;
	Fri, 11 Oct 2024 19:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKd1jqeS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47DD1D0DF2;
	Fri, 11 Oct 2024 19:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728675246; cv=none; b=XqVKoPNBBlIcD9syEOHezzjsqT845Smf/3iJCJkxMMnVSjCSqDFfPSlOGp8QTJz/IPE4LPzBw8/yrSo0CLcd7aAoRFRmt+fGpeL86NFb+j5f6p/Rfji07zb4yKrsIc2K7CKLD/JeCMoXC52YUI+Cf72RCBQlnj0hvthmCv4hI2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728675246; c=relaxed/simple;
	bh=SjeP1aXWu6ge1TnNzMaI8t0kB1KyKBRs66QZ0qOrMWY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Hnv0/wosSBTUJoNsP/HE/88PRx+iKjokkFOtS6eSk60ygg58IhMouAz1odiqdKxGs1WTwRe2R0ZkqhY4sPRVrqDF6ojRSMBxq0BN+0eVxDpdwvYY5pw8P6UvVLWa9ZAMihcYol5kwoG02uzhGT6ZIJg2bJloIMZrabfo8XHr/IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKd1jqeS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97AA2C4CEC3;
	Fri, 11 Oct 2024 19:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728675246;
	bh=SjeP1aXWu6ge1TnNzMaI8t0kB1KyKBRs66QZ0qOrMWY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JKd1jqeS/1O1urzboEocLZIHR+O7QQZcpJX88WR34TRnSHjqPW5hwzXW1wI1IxE+h
	 uquWaObwfbuKCHCcLjv7LKW8CrmvpNmr+ZXDB3HYTgHdlStEUPrDy+dM8ySu4OYsyU
	 qecVuOxc2+vNpg0S0Oimh+w7Yqa2/D1kCw+/44TSzZRw4WhYVSmIXo/iddLbCHelr2
	 nxsm/heYtPVLdRv+AH0MA5bu1KTLQiVoMzVJFam0vs4iuFhLaMcGWKoG8rMdvlclXv
	 6sYghBZu0zxTdFc8Z3VNlmvhfM3O9enoslfoSpfeXNw3ki4d3jhaRVhCM0N57FHe53
	 Jn5MZ3Bk9J56w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B6238363FB;
	Fri, 11 Oct 2024 19:34:12 +0000 (UTC)
Subject: Re: [GIT PULL] Power management updates for v6.12-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jRZ1yVkn_pa=aY616QNiOe7P2C0RdOG+oRwQ7sH-6w3Q@mail.gmail.com>
References: <CAJZ5v0jRZ1yVkn_pa=aY616QNiOe7P2C0RdOG+oRwQ7sH-6w3Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jRZ1yVkn_pa=aY616QNiOe7P2C0RdOG+oRwQ7sH-6w3Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.12-rc3
X-PR-Tracked-Commit-Id: 3fb0eea8a1c4be5884e0731ea76cbd3ce126e1f3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e643edac700637dbfb13d8cafd5754898486e666
Message-Id: <172867525117.2975359.16312048396320793413.pr-tracker-bot@kernel.org>
Date: Fri, 11 Oct 2024 19:34:11 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 11 Oct 2024 17:39:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.12-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e643edac700637dbfb13d8cafd5754898486e666

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

