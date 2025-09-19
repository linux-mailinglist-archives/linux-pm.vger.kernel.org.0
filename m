Return-Path: <linux-pm+bounces-35077-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D8AB8B0F5
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 21:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 976B7A0470A
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 19:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6FC286421;
	Fri, 19 Sep 2025 19:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUs1oLsD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4AF2848BE;
	Fri, 19 Sep 2025 19:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758309092; cv=none; b=kYTIYSVJySXhlG+peYkgcQhpjZPV+cnyGRabHK/d+AXLryZZ/AlDPDllW+iILhTq12I5ye9WS1D8ti+BziV5Sapb5xT3sXYeumjRau+O28CUn6h60tSy+z1LSr6Mj3WnF7P7XqSKin0/Uhbm7kEBrCgc4Ybv3jOIY3WC3a78r9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758309092; c=relaxed/simple;
	bh=VA957fqzlDUIJlLOTxEp72yvsjTf9q7cFUI/AjmEfG0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UARQYVw2XHtWt9BdcUmBNwTmdjMhRYiXdnv/usKlaH8hN5SLsVQr9KxSKE00BNLXEGlcDSl8yiIAWVLfTRHI983AnmYZ87S75YZNoMcQTAVKqxEeNV0tPllhLqTmo/a0mDASdWpTLlA1kgpEHkZkMKQbpTtIGU+8TsiG73NeWmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUs1oLsD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57AF7C4CEF0;
	Fri, 19 Sep 2025 19:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758309091;
	bh=VA957fqzlDUIJlLOTxEp72yvsjTf9q7cFUI/AjmEfG0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mUs1oLsDhZr2QPdPuNJZ2Oyqzt1nwopOjtz5r0UkIOd+YFq8ODtBlLj3ZULm5z0T7
	 7ddXNXFp26bWmICTSql9YcHjZZ6K/u/5ZEwBYlsyVqHhIDHXXybUpL4oZUjCQweKQu
	 5DGp7UXWH9EOCrVcuKVUMQzHBq3UdeZ/r/OWQxC/fiSej+B5LLh1cAzl32LejtLoWA
	 tdBTvMn2dg7GovsYI893FFzN70DS1yrYKdOZh4IBuNEfadfy3b4/ZZnIRgWWbJWeDI
	 olLLwBUiDClEeEhTaVy9OZMKHLc4DxgOsxgz5n2+Hbp8RLYB4J/5bpuZf/AOkgPo8M
	 7kJ37OjW8iTRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADB539D0C20;
	Fri, 19 Sep 2025 19:11:31 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain fixes for v6.17-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250919102829.151957-1-ulf.hansson@linaro.org>
References: <20250919102829.151957-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20250919102829.151957-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.17-rc2
X-PR-Tracked-Commit-Id: 303010f4658cb134eb27cee88026fb5d065a48cd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 46d2affdfbb92c383325dec35cef9abe844eda05
Message-Id: <175830909046.3669786.15257917459583423602.pr-tracker-bot@kernel.org>
Date: Fri, 19 Sep 2025 19:11:30 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 19 Sep 2025 12:28:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.17-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/46d2affdfbb92c383325dec35cef9abe844eda05

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

