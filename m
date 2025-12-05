Return-Path: <linux-pm+bounces-39225-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08930CA5BD8
	for <lists+linux-pm@lfdr.de>; Fri, 05 Dec 2025 01:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E6EE31A97BD
	for <lists+linux-pm@lfdr.de>; Fri,  5 Dec 2025 00:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F71207A38;
	Fri,  5 Dec 2025 00:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFXVgDPn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD8D1E5B70;
	Fri,  5 Dec 2025 00:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764893849; cv=none; b=T6PvUw4wUzEsyy44+/IsK5R+Jk20xJgwyojHYJ9kX6rVjiLXE1KQQR6RFiGO7O/9xqv8n1Iwykr4LGE/UFyd4NBoJPe4liwf3M4tMtZieVr6ezRCLeEyJxqmHvhp5+uDOc/rfHq+yNQZnsq8ip5HpSCXZHtjhAVsB3e2SYKRivc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764893849; c=relaxed/simple;
	bh=V5J41ZxniHrC90cPOl79BPpuhBIbt16HGzp9uIYvpPw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LXYjnIVlDOzxMvr6rhEgxH2oODrIPIjIaKY5MXUGcWPTIOKWcv6PhCM9smLEkHIJeZvDId49Ozf5ZGtbX6dld/wY2umoOnhsRftwyWuxaTj7D2FHsJdtagD8vvPN6Dqlh/JNINQo5j+KLsoQCvnutZLtyAJ4Dx8QH6GPcn0prls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFXVgDPn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E5BC4CEFB;
	Fri,  5 Dec 2025 00:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764893849;
	bh=V5J41ZxniHrC90cPOl79BPpuhBIbt16HGzp9uIYvpPw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kFXVgDPnGaIMKLHy8t5ChuHTzmBKREzdPQcYNKW+pFCqT/9cQh5qhoxlbjEZp6p41
	 vJHtHAnRDpRKiupxEoPeFsdCmiVdBOqZigBeJOdzU7dbSmYLZiV/N0QosfXmNxACY6
	 DPbaEqO/3lsWhxHJIlgGCbYJhl9ac6SD5BAzLriR37gofinODZNjIPmcXwuC2A2ubk
	 1qS1CPtI4ZoCHVHM+yPoZd9WcPfDRHC6gh8GWMX0fy31QnQ4MM9yYnSoQCgCQDdc1w
	 YQxn463AORo2/ustyHI74LnU8204O7YcrdbEgZgxcT8yznwXbvgbFZ91hlV2yQ0bkR
	 AQ26/OWgB9ScQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B61373AA9A85;
	Fri,  5 Dec 2025 00:14:28 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 6.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <rxziuamy4owgazy3oqvawwyxyih4fylzg7jselbubo666ofhid@orwemcdl2bx5>
References: <rxziuamy4owgazy3oqvawwyxyih4fylzg7jselbubo666ofhid@orwemcdl2bx5>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <rxziuamy4owgazy3oqvawwyxyih4fylzg7jselbubo666ofhid@orwemcdl2bx5>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.19
X-PR-Tracked-Commit-Id: 8e8856396b54bea5c00a7ae88d87c6254aef2d94
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b0206c4eb6375155b9d50cad1500d2bca5cc8b3f
Message-Id: <176489366734.1032351.17650460692157773727.pr-tracker-bot@kernel.org>
Date: Fri, 05 Dec 2025 00:14:27 +0000
To: Sebastian Reichel <sre@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 4 Dec 2025 22:58:18 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b0206c4eb6375155b9d50cad1500d2bca5cc8b3f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

