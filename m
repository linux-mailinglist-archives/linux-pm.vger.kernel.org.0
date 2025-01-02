Return-Path: <linux-pm+bounces-19914-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3A69FFECB
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 19:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8362162C5B
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 18:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EB91B4F14;
	Thu,  2 Jan 2025 18:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjUXmZAC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CB41B423F;
	Thu,  2 Jan 2025 18:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735843584; cv=none; b=K9xdB6qRj+Evd3PO8S1QqvCDChK0rXilO8aAikHHCIZc1H6d8zAGJl6lKsv5e0n8G9ADx3WcqsJ9FvBpjcGoqi0W3G1PP8dfhEit8DVpzbSi7thmtv8CbeMHSGG9cfQH/oHNeTDrOq3b19BX3S8n93xTvQVkSM4AXI9FUrAEzCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735843584; c=relaxed/simple;
	bh=ykkhehmAt/0FuI2f/nijeisMxPbnq2PSfkS31wojYAs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CsShHRJt4be5qwF8uCFZaAR7Sa22+cbOxJryNW05w8R5IEduuldrcMPiCpKa81Zxi25+D17Iij2TT3Mgw1mZb3TyUwFI62YGxHCLgl/XT2H06kvASDhuuU0hS0n/ryFIJiR0JzJCmm9EDiuHRQrWT3L6dekJ5DGbfAvViJ5+btg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjUXmZAC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9490BC4CED6;
	Thu,  2 Jan 2025 18:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735843583;
	bh=ykkhehmAt/0FuI2f/nijeisMxPbnq2PSfkS31wojYAs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hjUXmZACbja8RZyp4g084ol05j58yFUSdnJJMc27KXiDxJRKz/HXQ/H0Oa2XEpt9O
	 zWFljggk8nUPOa9RtFBf1rohPe3iUAswHUpO7bld+Urvo3OznY66SE3Cu/3tvEjBKS
	 uqAiCNR7dRS9JzdAQcOUvRmFjoL6qQvz/XzTnPuwh252/3S3HBNe/DnpHBFFyFprVv
	 zTKsYVlCU4zmLsSW7td+2tTo+r7/VWFgX+hdhklCyu2pn+7taaVMq90r8Qe9xOYp/k
	 TsarIvt0pc3FPN4eENEvPSf6SHQvdDuw55zFwlzXmysNY7DgyZWR/1ww8PZ0jiC5uF
	 z3JBDfagaQBGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B1E380A964;
	Thu,  2 Jan 2025 18:46:45 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain fixes for v6.13-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250102124753.50440-1-ulf.hansson@linaro.org>
References: <20250102124753.50440-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250102124753.50440-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.13-rc2
X-PR-Tracked-Commit-Id: f64f610ec6ab59dd0391b03842cea3a4cd8ee34f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e6b7c8c5a173c7c99ae2222f640e02b5fa822691
Message-Id: <173584360360.2004976.2151413910038737908.pr-tracker-bot@kernel.org>
Date: Thu, 02 Jan 2025 18:46:43 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  2 Jan 2025 13:47:53 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.13-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e6b7c8c5a173c7c99ae2222f640e02b5fa822691

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

