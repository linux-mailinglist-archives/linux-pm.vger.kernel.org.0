Return-Path: <linux-pm+bounces-40549-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6E0D0B571
	for <lists+linux-pm@lfdr.de>; Fri, 09 Jan 2026 17:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A7E893012ABF
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jan 2026 16:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB08364E8F;
	Fri,  9 Jan 2026 16:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X13Uq/Kj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A391364E81;
	Fri,  9 Jan 2026 16:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767977013; cv=none; b=RSli4y2aRaDN2VUCi/VTrA5fpXqJlyhI0s61U/KBHxwijzyfmWpC35RRpLMAz4Rrfl/LaxUoQNkFDHcVYFYLACUBG4H6a2/LCyjtwoHem/e0G02upitJQyZsAh4aDQNkLfoDc2zBA31Fc7UIzOMrT1OTkLlLD6hyGx/vlgW095g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767977013; c=relaxed/simple;
	bh=FwXPp+bJ3pqBCc/sIOES2+FR5ZykMREhYqdlNfgN2qY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VkW/m1P4SWUxqTTyb+ASNpd3AY+v6ykC/3ANTK1UkCIjBdeO9LLgTGoDFbxQgQz0YjkuyyUhgh9HWJFroYmhBJhrIZfq/WUM9O1PoWQ2XXXJdhGN6O/00ktTRnf4JrDQ5LI1Fq1ZDt/X9hvyG7FJG74cl1yeVDzvPNcHDbp1qCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X13Uq/Kj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B2AC19422;
	Fri,  9 Jan 2026 16:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767977013;
	bh=FwXPp+bJ3pqBCc/sIOES2+FR5ZykMREhYqdlNfgN2qY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=X13Uq/Kjy9a4sVwjfIZOl6FN4ajcSWocWS3A6IIkJ3xq054+V4UgfSMn0e4qzIXRJ
	 0laAWkPvxAjjiZouc13AFRv+Qn8IajWzLqpzafgZU/99I61OUi2mDX++6OCU8rM9m9
	 vbCpdyEfi3e3cuIcaBopL0X6t2rcdYB+5WHa6ZfCBR0+zgxVFXxLNDgqhTA6h+5Buc
	 BdJzmO42VIl7f/hzbzF2KSzwAjwO8I6Z5nteqGxYMlqJXvwfrdYTBPfp2Nx4vHroLS
	 W3ZQ8FBdfFKJCo6h75Hge8jQuYUW75HyGWAfTPbQwc9u7Kjq3TL3wfJXG/6y8LsTuM
	 1JxGLmrDF410Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3BA043AA9A96;
	Fri,  9 Jan 2026 16:40:10 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fix for v6.19-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hXqA+owjDVs+qZb8s4KddbxXda5_s59ito2YCJo-A_+A@mail.gmail.com>
References: <CAJZ5v0hXqA+owjDVs+qZb8s4KddbxXda5_s59ito2YCJo-A_+A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hXqA+owjDVs+qZb8s4KddbxXda5_s59ito2YCJo-A_+A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.19-rc5
X-PR-Tracked-Commit-Id: 7966cf0ebe32c981bfa3db252cb5fc3bb1bf2e77
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 81c5ffec9ece10079b8c6d944a754fcddfcd37da
Message-Id: <176797680950.322717.7358119772041508498.pr-tracker-bot@kernel.org>
Date: Fri, 09 Jan 2026 16:40:09 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 9 Jan 2026 16:23:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.19-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/81c5ffec9ece10079b8c6d944a754fcddfcd37da

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

