Return-Path: <linux-pm+bounces-197-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 110067F8577
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 22:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE03428278E
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 21:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77273BB38;
	Fri, 24 Nov 2023 21:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvFZYmdU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9544E3BB26;
	Fri, 24 Nov 2023 21:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33638C433CA;
	Fri, 24 Nov 2023 21:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700861411;
	bh=xNFatYW7Klitan3TPTfOIFcpeJBq8AsTeuOZwKJDmu4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YvFZYmdUNbHgCh+FMF7Zy4DCRj0kcoT/z6B4UyHWk52nf4buzZMS6GK2vDYzNCGfJ
	 lgW+TlfRtZ9dWtAKIqXPktIGx6TQ/NaEJX287y9MRTwCbMJsqdYaLA/gNmwBcxQPQP
	 5mdA6JtQhnlRVNwoM2HD/GSMjYtQALb/fi1DeaBOJfLE8PouHPE68dYDNi+cyRnxM5
	 FGnzcHEy3ud8fa30sVpYXxOvkLNc+MjgJZE9p9NLq2SMlLtp90JuHWUYZCc4tSQQjL
	 Drsq+54R0ux8DELrhWSxkDdpJsUOnVWcjxfXlv4kPqkAj/P30TN4a1pdKQf9BBpCIz
	 iphsdBJrb/rfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0DF41E29F40;
	Fri, 24 Nov 2023 21:30:11 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v6.7-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0ikr8Z8KJxqfVzEmCwW4FTg+xLgVKO33D8vqd1XA8+58w@mail.gmail.com>
References: <CAJZ5v0ikr8Z8KJxqfVzEmCwW4FTg+xLgVKO33D8vqd1XA8+58w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0ikr8Z8KJxqfVzEmCwW4FTg+xLgVKO33D8vqd1XA8+58w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.7-rc3
X-PR-Tracked-Commit-Id: e37470624e008579fec020c6be062dd200877129
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1bcc689719473873e961ed91df7e929fae71cbbb
Message-Id: <170086141105.4355.10891182634922555920.pr-tracker-bot@kernel.org>
Date: Fri, 24 Nov 2023 21:30:11 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 24 Nov 2023 19:24:39 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.7-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1bcc689719473873e961ed91df7e929fae71cbbb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

