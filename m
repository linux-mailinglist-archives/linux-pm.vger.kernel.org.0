Return-Path: <linux-pm+bounces-24257-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD19A67AA5
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 18:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9100D7AC672
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 17:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3981820E6F9;
	Tue, 18 Mar 2025 17:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tuMY49yo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127721AB50D;
	Tue, 18 Mar 2025 17:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318345; cv=none; b=bBwVMBgUFdW1uTCwSje8T36imMhCcITckVrKMl8fMcl2UxSLPfxrfU+rq0hF6GWWegkgkiCYf04ZqmPcQP7hMbjToiQl5k/ggajAsh/PyIYachqHC5dPFGOtrIQXYHmb0UbL8hABi8ehjK497j+4bjmMnbPUFUV/xXIhrbg/9+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318345; c=relaxed/simple;
	bh=8Z7SgxoCJA+GSUt4Ui7Aw65TeOzoEivKQZ1WDkvRvq8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gBcxRLYe4LyRo6KfIKBHXlGC5a+Hp1aI+kQJ43jm1O/9TlTgwpOSbfQioIUjXV5b9y6uv5zHaYNmdJdzRG+cPS3vZvaFLK0ojomJMYMC+Jo5h2JBgrXUPoFjSVNZ60+4xq7XgD+CrFsqF4wNsNFuTwH5XtrYasoO04FzhWwPj9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tuMY49yo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78397C4CEDD;
	Tue, 18 Mar 2025 17:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742318344;
	bh=8Z7SgxoCJA+GSUt4Ui7Aw65TeOzoEivKQZ1WDkvRvq8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tuMY49yoMizIEu9aK2Tyhr8gCdqWPR1hhVEOR4FQDntvgHuD4zDRIu6g2z3U5HYdL
	 U2Aw2T4c014FyFUi4V6XXcKFtQgyCcJz6m4UKEdVY/+7t+uoo37PlWThXntAGDKw+C
	 OXn6GfzpHvHrZJ/MAPSUoD67CZEiveSe5ivMSLE74uaQGH+hO5HnEBHuYq9so0VYHH
	 KOEBWZmolp9zQYlOn5/HCp6N18porp4Q1I05HoMYuOPXJeYoHPff8XFtot3QT+gUkM
	 3DZByPRj9bQRClpcfszVU9hGNLYjoNuCZ6H/YNjJcbHSCXpAhUwz5krArWvXsnaoH/
	 aSRzwszjPvk/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F11380DBE8;
	Tue, 18 Mar 2025 17:19:41 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain fixes for v6.14-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250318122548.1328552-1-ulf.hansson@linaro.org>
References: <20250318122548.1328552-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20250318122548.1328552-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.14-rc4
X-PR-Tracked-Commit-Id: ef17b519088ee0c167cf507820609732ec8bad1a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 81e4f8d68c66da301bb881862735bd74c6241a19
Message-Id: <174231837963.393299.6404503405685975618.pr-tracker-bot@kernel.org>
Date: Tue, 18 Mar 2025 17:19:39 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 18 Mar 2025 13:25:48 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.14-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/81e4f8d68c66da301bb881862735bd74c6241a19

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

