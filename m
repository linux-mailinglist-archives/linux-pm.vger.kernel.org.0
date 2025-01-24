Return-Path: <linux-pm+bounces-20943-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D83B5A1B9A0
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 16:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77E697A4081
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 15:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C1316F8E9;
	Fri, 24 Jan 2025 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPQHM61F"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6143716DEDF;
	Fri, 24 Jan 2025 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737733642; cv=none; b=rVRAxRCpx7zYHMw4G2p6HsBejxISSovnmx7ZTYFkzvxrw2/rxHsnD6Be0QRSShfIQ6F4l/zHv0IgzjzfMt64erhU2iDOrcSJVG6fTjJ2/64i68TJNBzg4C7uXMH4sZF322II9JjjLWHVe8CMnrFjcCteS+srUoOMvXVhURUiWYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737733642; c=relaxed/simple;
	bh=qLAtR9FOE7rE55w/MOgIXJieoK9jo4797vMjVE6Ydzs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ofsfMrLN7NaqBIsTn1E+NoYcH/CReLkHIkF993hd//z/SfMYYkgKFHwhNh0JdWwCAX+MSt+TPNl5J6rx4OzEa8ulH4x0eqMBtMALQPuXigKBSJbufCJsK0VXxmYRuh964UQolb2SSGPdSCCwZmQxHIBbwmPC8se+tAiRdhfDpkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPQHM61F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3640BC4CEDD;
	Fri, 24 Jan 2025 15:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737733642;
	bh=qLAtR9FOE7rE55w/MOgIXJieoK9jo4797vMjVE6Ydzs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NPQHM61F9y9gK6zxxDmghn49+ecM9ly+UAPtvm43vnGY3+jbcFHaLtDhiMDk1+Vac
	 m1QDhNqMMx8qan9MpXFyd593m2mfYGcpMdxIDObAYVLt0VbB7b+yDf91oe2dYsHNl9
	 9nz9AiHmiV8I6wjfYxMjipSgW08/XzKHfHEDfBd7S3HnzWBW0wTvEawNkeuqG4sKfV
	 AnFvwyIEiUx27oliZimrG6fHZReEfhwj0jfaaMwY21JR7jnyNzoqC3Uz5VrM7hZlGV
	 iku60X8STttd2k26im1PshJfR/zE0RbOmQNNETRbMDGLxnZ742P5OrP5j8Qq9WFxoC
	 sHSld54YUfcTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3470F380AA79;
	Fri, 24 Jan 2025 15:47:48 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain/cpuidle-psci updates for v6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250123141540.265172-1-ulf.hansson@linaro.org>
References: <20250123141540.265172-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250123141540.265172-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.14
X-PR-Tracked-Commit-Id: 885f5669f2abd0db34c9832259f77240d5350e36
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 68732c0bf97cf946ad08660203e8eabfea11463e
Message-Id: <173773366681.2077644.4429059783175392610.pr-tracker-bot@kernel.org>
Date: Fri, 24 Jan 2025 15:47:46 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 23 Jan 2025 15:15:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/68732c0bf97cf946ad08660203e8eabfea11463e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

