Return-Path: <linux-pm+bounces-38004-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0820AC5AD18
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 01:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 934EB3AF1A4
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 00:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5F92882A6;
	Fri, 14 Nov 2025 00:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfmA/gYc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BF12874FF;
	Fri, 14 Nov 2025 00:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763080896; cv=none; b=MBqNyBEmr4y9FcOt6rCu4UnU4bCfiGYRjCTLGMvJf1GcsLGVYWXzkQEKWsQ8LvvElPZqDonozOl/LGYCL2tubZCuyKm4rM6Ap7Vt+rpz5fbfCHG9qvNGB85VDd5tSepDiMmbCYblmZWpuKRqqok49gteGURqh7F1uOj6QI/z8eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763080896; c=relaxed/simple;
	bh=m7bdsZXZmilqvpKRn8XyXIQ6Cx8HJlS9MXVOqA6YYWc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JDoJGr3Ejbo0NV0G3Vj7UKZNjIdpPypM53rij/vigT8YFvq4S4Bp6r8fKzm1UeMVaigR2Kf0eyhreGBA6rxkWQToFDuyNlLJQ0zfmkkeDdqdGFI0vfoos7lY9OjLTgWv2Lcv2TR2Ip0Je3J6ZW9wRMY7ryadmbv0wPxq/eru7yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfmA/gYc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E44C4CEF5;
	Fri, 14 Nov 2025 00:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763080896;
	bh=m7bdsZXZmilqvpKRn8XyXIQ6Cx8HJlS9MXVOqA6YYWc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kfmA/gYc9HtRXKEduWWe6JU8qQQXc/pPLIAI2vSpeLl3jMn47lfvRq34iHqnETbDW
	 MTtWCXS2njVCq8QBBco3zssHY0nKs+ZXz7Mc1nRAnQrc3pzs45bxE4PIRP5pT354qn
	 tDJC9lgLclbI8HuUIAH4J5dH+nt7sQcqHqMT8kEqSdhKEMF9EQDquNCP8YZKfk77bW
	 /QewiCLdarX3TVb3B3qxx2zoVUFe71xH+4JvVDCvy6hHsclpOnZq/Z9y64qTOAjFix
	 gbRKeWJSJz2La5LyWW9esoeJnPdkcoqnuh4xtm3oWcCIMNvM+KXcM9ZHXgEEt0qKSP
	 kDchPp4HuAlgQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C933A55EFF;
	Fri, 14 Nov 2025 00:41:06 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v6.18-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0ijgzoEZZvPwBG7wYxst+WYuJWZdaOGCF1Y-a7rn51bjQ@mail.gmail.com>
References: <CAJZ5v0ijgzoEZZvPwBG7wYxst+WYuJWZdaOGCF1Y-a7rn51bjQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0ijgzoEZZvPwBG7wYxst+WYuJWZdaOGCF1Y-a7rn51bjQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.18-rc6
X-PR-Tracked-Commit-Id: 161284b26fb17093bad3c7b25d76459e11d3142f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aecba2e013ab79dde441dfc81a32792ced229539
Message-Id: <176308086511.1063025.2914566136382666227.pr-tracker-bot@kernel.org>
Date: Fri, 14 Nov 2025 00:41:05 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 13 Nov 2025 21:15:39 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.18-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aecba2e013ab79dde441dfc81a32792ced229539

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

