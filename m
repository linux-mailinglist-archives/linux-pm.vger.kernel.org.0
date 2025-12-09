Return-Path: <linux-pm+bounces-39369-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 110F6CB13DF
	for <lists+linux-pm@lfdr.de>; Tue, 09 Dec 2025 22:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5BF6E3024474
	for <lists+linux-pm@lfdr.de>; Tue,  9 Dec 2025 21:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE662DCF44;
	Tue,  9 Dec 2025 21:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ix7yeLZ4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BF11D27B6;
	Tue,  9 Dec 2025 21:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765317233; cv=none; b=gI2sNg6TlPFYhgFfua7eAebLlLlGI0LLOCB+X70EE96aeS4jMVje4n54ebVQhOR9NYNhVzwKCW4w1qmSSngvnY+V+YrBRvItl91+9BZEl0ivck3aTV0hCbocq/sk5PHwcQABmp64q71+zLTDmroxbz8ms4Cf98FY1aS7OLMr8do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765317233; c=relaxed/simple;
	bh=uJQ8APUIz2FBeU5b9eeF/oPO8aHEa9n/JCNMcAbxq6I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EZKfhC8rnDRpX1/bOE1vPAK2fctCzJF4VpHXcOPbSAqQX8WX67MzDNmFtudmvIpaq6aMBIrywl6AX8eLgFPyqQ71dNIPidQ2AXbZVID/65LQUjWXzPQQmp00ydEA3sCf9VKTkRDJNYhJ28rxnQ/oooZ1gJh41gRLL5PassWDp9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ix7yeLZ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122FAC4CEF5;
	Tue,  9 Dec 2025 21:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765317233;
	bh=uJQ8APUIz2FBeU5b9eeF/oPO8aHEa9n/JCNMcAbxq6I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ix7yeLZ4622gTQUzRSKpPb96Py5qL7A0e46Byrt5jAGucWD308fb4qsIYHtdgYiE+
	 btp3trvIdflRqkKSf1M0p3cvfKQ6D1Otz1J+q4hCm4N3vseRxF/RttAXjltyho4kuO
	 EPUN6ilEMlKJSYzBeI92iKGLl8wUKxy+IlHYtf0T9SjjNycrNvyGr0+PVUMDtFKJ3T
	 dtSI6c/5IZ83sPSUGflfZFXb0vzHODiDLTGaELAthSc+MsXUxJCWmbAHJVbn8h02No
	 aV9MatPDyWuFxS0qKswz32jnnY+jJ7zgbR7yC/8aTkvZ5hYXTMOu4mal+y2hOfNqHx
	 EdsfMMnpE8rpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B92B3808201;
	Tue,  9 Dec 2025 21:50:49 +0000 (UTC)
Subject: Re: [GIT PULL] More power management updates for v6.19-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hok19sojJzv6rScSxoVezJ4U815zmKXEX_c0jnK-09QQ@mail.gmail.com>
References: <CAJZ5v0hok19sojJzv6rScSxoVezJ4U815zmKXEX_c0jnK-09QQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hok19sojJzv6rScSxoVezJ4U815zmKXEX_c0jnK-09QQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.19-rc1-2
X-PR-Tracked-Commit-Id: 316f0b43fe0131af869a5a58e20ec6e0b6038fa8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9f20d9bad51635973fb1117544033bb03c4c3224
Message-Id: <176531704787.4145059.18046152225968355056.pr-tracker-bot@kernel.org>
Date: Tue, 09 Dec 2025 21:50:47 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 9 Dec 2025 12:35:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.19-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9f20d9bad51635973fb1117544033bb03c4c3224

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

