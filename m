Return-Path: <linux-pm+bounces-12812-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D48E95C996
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 11:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD48DB22684
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 09:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34CF14F9F5;
	Fri, 23 Aug 2024 09:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUzgCZOS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA4914B97A;
	Fri, 23 Aug 2024 09:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724406551; cv=none; b=GDwHUfyWf2YLk/HTAz36nKVDO4di6p7fTrfnc7nRGIftuwufoS182Rdf4u9SVpbQb9xu8z4Yr2bVynGTav7/G0R19UO+lkPSwyh6uz1s21M54VINDjBNlZFtoV01AOk/PwAZL/vIuFy4s6X10yApjGXMZ6XgYAe0nj38JbpD55s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724406551; c=relaxed/simple;
	bh=xzk/tux8c65oFWbTd7cQ9aAw0uviTwKltcWP4X6864s=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BSOS5UKP7QzIuTAkIp8bQ5llZ2zRMdrLRY3xx578dsRJhiWsqVQYArAdj5UUX8UsFMBVV03Aq1YXkjJI8VdJBZNpomWRs4eFljMs2skaRY15tlAbiP69kU7UaI8nu1mCz1dSmLst89TORlkhzR+Ug6lgEum48Lkd8hzBmxgIY5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUzgCZOS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B147C32786;
	Fri, 23 Aug 2024 09:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724406551;
	bh=xzk/tux8c65oFWbTd7cQ9aAw0uviTwKltcWP4X6864s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XUzgCZOSoANUX9jnRTujNy2Q3kONnE3Io7IthrQQB0ZpMtVUDhfLcC35GzmzwZi2S
	 UmIDWxGhMskhHAfXJ1rmnuiw6LSl/ZIOMHbhZQEECsmjwH2VLtmdzXvG6aqm8tKVyE
	 5XzPBHe4yZlyDDXOMlwBmutNOqGh/SolZ3XPsjHMOP2R45AnYSAoNCvNutP5nQNc8p
	 h4JTwhTMA1zzwJilA9WRLiLJ10MC9C/NVWejKkQLuBNr1fl6ugjsQGkMJv0jZIZIBa
	 mk7hEyu3V5WGYe67TEJxaexX8oWQDSglfmP9MjkpsVVqSoMOXnqhuzM5VLUYab6V31
	 qHhEVxXRy9BMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E473804CB0;
	Fri, 23 Aug 2024 09:49:12 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain fixes for v6.11-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240823091059.389173-1-ulf.hansson@linaro.org>
References: <20240823091059.389173-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240823091059.389173-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.11-rc2
X-PR-Tracked-Commit-Id: 52dd070c62e4ae2b5e7411b920e3f7a64235ecfb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3902f60b58101b67e01072f561d4e85eed8e47a1
Message-Id: <172440655096.2912816.12622941348702821284.pr-tracker-bot@kernel.org>
Date: Fri, 23 Aug 2024 09:49:10 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 23 Aug 2024 11:10:59 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.11-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3902f60b58101b67e01072f561d4e85eed8e47a1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

