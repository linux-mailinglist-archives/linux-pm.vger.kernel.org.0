Return-Path: <linux-pm+bounces-40142-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87094CEF535
	for <lists+linux-pm@lfdr.de>; Fri, 02 Jan 2026 21:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E97903032721
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jan 2026 20:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AB22D594F;
	Fri,  2 Jan 2026 20:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrtDjxPN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6E82D3737;
	Fri,  2 Jan 2026 20:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767386355; cv=none; b=It02kGU4ABs7cGpEJ5Hxfd8ViZd77yr+rw2uXXpXS32cXGHYUn39oTC71uZ9uZWiWFcEiIxgCIADq1LfXdOku8Bd+cESWsHUTbo399N29t3QVIa3iKK84sU8EryK7I1SSgoozEE+8JykgOkc3ulxI12dhN8p2Uxqtvtuk0MD71Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767386355; c=relaxed/simple;
	bh=FN67mz/Y24hR+jZleem3nbvPTwV6UGhpZeJmKAvV/MA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=X8dBU60U2lS9dWO8uNTX9YtrC0HCLGN4HfRdI7KB/f480Bx7vPQeM75DAmYHOzH+H8jGghpHZ+TH9lpxl5j5/WzxGHxuLGz+QC0y42gA0ng4GG10AFZ9OqtQUZsSLCgARlGbe5xgz3d8+9mFDNiaucj36kfeCeC2NQkG9Te8hiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrtDjxPN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C2DC116B1;
	Fri,  2 Jan 2026 20:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767386355;
	bh=FN67mz/Y24hR+jZleem3nbvPTwV6UGhpZeJmKAvV/MA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZrtDjxPNJfDP6eq0N1GRtptPshm4E9BFoYRLYE5geTYjRCh5LPmvT4azdAS4sHtvz
	 2pha0UIaoCqOn1SXpbm3jizkxAPaAIVA4aIn5spy1KkRPkq21oLfFcy5ISWr64XYPs
	 l9TMIR63iVosv2oEhoqC8vLW1NZPSv/d+663yf+epegw7ePfkuT6JCSXInbfdhSgi8
	 +w1Sopyz+ggmQ9YWZRjblGtJNOOD+KEtbpM8trU7GSNOgSF1A7PAjYNym15NvybwOY
	 c5QhT4HakWP6GXB92N4HCEc1TZmq4hrD1s2JZCki0uaJuwSOaDrlWR2JCRaHXKPQta
	 CIOIlIuNEdcfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 787D4380A962;
	Fri,  2 Jan 2026 20:35:56 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fix for v6.19-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gjWY+0MY4sJ1=jHcDzAkCEPtDROrZMdqtx2Qws54svQQ@mail.gmail.com>
References: <CAJZ5v0gjWY+0MY4sJ1=jHcDzAkCEPtDROrZMdqtx2Qws54svQQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gjWY+0MY4sJ1=jHcDzAkCEPtDROrZMdqtx2Qws54svQQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.19-rc4
X-PR-Tracked-Commit-Id: 684d3b2670a26313bbb99de6d66f384ac0e31c9b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bbbc721033c076bad736c48a2b9f75bee4003607
Message-Id: <176738615509.4003266.99125597035645268.pr-tracker-bot@kernel.org>
Date: Fri, 02 Jan 2026 20:35:55 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 2 Jan 2026 20:31:14 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.19-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bbbc721033c076bad736c48a2b9f75bee4003607

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

