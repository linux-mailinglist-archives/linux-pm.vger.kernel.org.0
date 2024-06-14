Return-Path: <linux-pm+bounces-9206-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD3C9090FF
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 19:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F5FE1F228A6
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 17:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C50519EECB;
	Fri, 14 Jun 2024 17:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqo98rhG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E629919DF7C;
	Fri, 14 Jun 2024 17:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718384713; cv=none; b=U7TUtDGvTnTWftNXfgGCe9ElAK8NZbqN+FGRE3X0RgESeXY7B+qTyjR6B5jrX6v6zuhFnwO8GCQBQTRDQxoc/1zNkLkMEy6t9LJj2DeEZ4IjLu31FJvWojaCIVkfjecjWQQfRa4sJTNaYAazRy+EDuXEiB6E4zcZh+uCzAermxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718384713; c=relaxed/simple;
	bh=b+P4tgeuThb86gcQHiQdlCCwCx9rMvMFZCIEQv0vkfc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=uFsmqhCdsde6RR2Bi8YQGYmPsVarW06jdXkwrl1P6EbMXfmTV9Sivp3ruQZD0JtBeIaxVle7kU2K9r5pNkfRqsIZExk+Ou5Kcm8ZAysNj9vykRi/0mpxKP/oD+EHIX+ZH7aqk1QIHFHTvyGGygQR9P/TtOfRl8+4GgJdu7kvTTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqo98rhG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4DE2C4AF1D;
	Fri, 14 Jun 2024 17:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718384712;
	bh=b+P4tgeuThb86gcQHiQdlCCwCx9rMvMFZCIEQv0vkfc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rqo98rhGPRLgyuZxySElAdX7LkRX4OeZtbzTGSmoGLl/3itRrhy50815RBu2m2mRe
	 fNq91zPdQiQ+PCr3o+Z9UGSPzXVtrj9WXFGcekZ4Bs/B/vtNnx4Phvz9SpKC0NcNhH
	 mXOMHPSVZleTrEz6d++9pem6C2I7bSzg++/wlCPdgDJI996gO6+AM75VlBSJmpLlVV
	 sGv0YIGsv0TNUbVfX5A668IRmaC3bcca027B51lL2V42L0eNXB1GW34fxUlZptIZk6
	 cDZaVFB/Ko9LQFN0+1krqtwFXjYM/8of4VShJ98TmvZylM7D4jVkx9a84j4Izg77EQ
	 et3EpLys2Dy6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B4AB8C4332D;
	Fri, 14 Jun 2024 17:05:12 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fix for v6.10-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0husVUEZJUJzumfmB-18v2R5RuQbxTpxwRx1q1oVtLn3w@mail.gmail.com>
References: <CAJZ5v0husVUEZJUJzumfmB-18v2R5RuQbxTpxwRx1q1oVtLn3w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0husVUEZJUJzumfmB-18v2R5RuQbxTpxwRx1q1oVtLn3w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.10-rc4
X-PR-Tracked-Commit-Id: 350cbb5d2f676bff22c49e5e81764c3b8da342a9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0cac73eb3875f6ecb6105e533218dba1868d04c9
Message-Id: <171838471273.1909.17386664521903807015.pr-tracker-bot@kernel.org>
Date: Fri, 14 Jun 2024 17:05:12 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Jun 2024 15:31:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.10-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0cac73eb3875f6ecb6105e533218dba1868d04c9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

