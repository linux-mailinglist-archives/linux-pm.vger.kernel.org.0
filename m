Return-Path: <linux-pm+bounces-8031-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2EF8CB3DE
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2024 20:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B54D1F221C8
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2024 18:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC97143C50;
	Tue, 21 May 2024 18:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqTLrPGL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D3017722;
	Tue, 21 May 2024 18:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716317581; cv=none; b=avA6/9JMpzX4iBkcGHvg42HxbB4iT14auh4S1MEe6FwhMiyyyfg29Oej6nzHhgy+dzxrs22p43jr4ipB7L1B7w1S478LZQ4Qrdm9XzPqH0QIBA5sYxngSQxbl9spSvtKKRaxbf/K6L2yxjd+oulL+zjglpeoVjBb8eRRDqHQGS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716317581; c=relaxed/simple;
	bh=ofoPVojAEEGXCDIfysPq6EMp5+ubc07xrIM7NcEjCEs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UAJkaAeY5wiWxXS80gsQBjzl48nSd8dTS8oBbxKv7MVBYVSDuKWe6zf2V+z7MaXbxJWB/CCe2WkKNMNXuDYWqTNDIcih/WOL7CI3T0sccGRU7mXdcoA7iG21/Wj4MpO2VnGzbh1HVP5nPXCX8FzYlm6ru+lOO4UwY3JAOExenR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqTLrPGL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70312C2BD11;
	Tue, 21 May 2024 18:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716317581;
	bh=ofoPVojAEEGXCDIfysPq6EMp5+ubc07xrIM7NcEjCEs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LqTLrPGL8T4khyTNwQVljmBjBpe1fHJPXb79/Jesp+0kxxecTaVMJJNmF72AirW2q
	 0wPTKPXIJz9YPV/lrajWHCf+9ehjSnh5SL11aWtRHuTxRo8iIvg0LfDEmI1ZMfZvgf
	 fi77eGH1BZ1Farnpb+EPHiYtd3hiLB0pkHZPNLYOPm4Q7s8uwXmCaAGzIwYqqoX+S9
	 6tI4RBRPCmhFOaW6tb1JxTnTUBA8UKdW6AFhD8iLMDbrbSp2aUBodKK7XysqILYd+F
	 3HaGjS4bnvYhhYCJhBGwswnPzV+eu/prJydlIpjkB6b+2HumlE15IbilsdHUxJX6T3
	 rvVvRFzpNqHjw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 630B0C4936D;
	Tue, 21 May 2024 18:53:01 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fixes for v6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jui_HzdbhQ+F6_4aLAWb6LnhT9yEnBX82-LuZ40CcF0w@mail.gmail.com>
References: <CAJZ5v0jui_HzdbhQ+F6_4aLAWb6LnhT9yEnBX82-LuZ40CcF0w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jui_HzdbhQ+F6_4aLAWb6LnhT9yEnBX82-LuZ40CcF0w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.10-rc1-2
X-PR-Tracked-Commit-Id: 8c69a777e480174b1fdd75dab5ad584454dd6555
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5b5a5ad5a5cc587544341051ae9cd591c98f8d37
Message-Id: <171631758140.16717.14107095855942405328.pr-tracker-bot@kernel.org>
Date: Tue, 21 May 2024 18:53:01 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 21 May 2024 11:33:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.10-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5b5a5ad5a5cc587544341051ae9cd591c98f8d37

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

