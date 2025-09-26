Return-Path: <linux-pm+bounces-35499-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED30CBA51E4
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 22:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEC8B561D01
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 20:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA67298CC4;
	Fri, 26 Sep 2025 20:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwjjsIoD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92322286424;
	Fri, 26 Sep 2025 20:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758919462; cv=none; b=cFoIW/YO5xUXomz+4VkVj0Jxddr0m+TtyBU7+WQlMLrwLdE0JIqZRbG8inqakUpgoG0cNw+VtmEEjY487mJhTIclHmKOax1TYrPlVHhKTTYL12AxkFCW/2dICah7eM6r8S1zTULhjsp1k0i8VzRPuNvUGy17iiAlu0dnSMQ6Yjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758919462; c=relaxed/simple;
	bh=gbih4vMxJwa0NyttLI9rVwuk5qr34L04OnrZlGsM3dg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=K7IlJt0LFi979dUf0t/U42NFeAEPdWIsq6AElEc7vGyigouRpTusEcu0RKkELeGW/7AXHGyu0qRRz72IeXEaZwrgbDq6MrQ2oqlK6SIjSweqTQneZxUf9AmS37d8aXczSohG6Jp0pvGHabBSiQtZqRyAO1KZtn11XT9im55PRGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwjjsIoD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7399BC4CEF4;
	Fri, 26 Sep 2025 20:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758919462;
	bh=gbih4vMxJwa0NyttLI9rVwuk5qr34L04OnrZlGsM3dg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YwjjsIoD4jPmkhi8AgTdhzQGK+X0fNbSDKJy4Nk6E1A6yOrgwnO/sq01F4Z0IloF8
	 LYPeTA0mqFq4jfvPs4wPANjCG0fIoxpNV0+5i/H3uR3LG9ICTgB7IVS/PRTvyXMKZ+
	 477F8MJNzQ1XN6TyxAOcsHujLEYitV+mofzTYZ55m99KGCvRlH9/KSrgPIjIWBLV5p
	 AZT/rrFVkPSEtrX0vJQqWXPgUWKJeLw1ELRpDHleBZjCoIbx5Lxd/MPl/2lgv39PTe
	 Vr44Z/FbFm8dhTsxJN0vvsiOt/O/eFFd7iJMV9A3rGSbDRWdhx4wlKFwtVl1ooqShm
	 f15jg66QZx+nQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD5339D0C3F;
	Fri, 26 Sep 2025 20:44:18 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain fixes for v6.17-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250926124327.212581-1-ulf.hansson@linaro.org>
References: <20250926124327.212581-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250926124327.212581-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.17-rc2-2
X-PR-Tracked-Commit-Id: 5fc4ab3269dea6a0b00c7256cb6f6c0101b6a44b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0d97ef77425e591669111ebf819ceb5d5e2dc329
Message-Id: <175891945757.51956.2518306762590478395.pr-tracker-bot@kernel.org>
Date: Fri, 26 Sep 2025 20:44:17 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Sep 2025 14:43:27 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.17-rc2-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0d97ef77425e591669111ebf819ceb5d5e2dc329

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

