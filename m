Return-Path: <linux-pm+bounces-13816-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 353D296FBDA
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 21:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEFF21F22881
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 19:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9801E1C86FB;
	Fri,  6 Sep 2024 19:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVYzwTEv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718461B85D5;
	Fri,  6 Sep 2024 19:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725649939; cv=none; b=FrzAj4yk24cK0pbQLFiIUJidilwhWtSDPbK4UWlXOB5fp9uVZL2p7X1zrtpZjRLWdbIpHwsKMcxtFpcqP6c/cuvA/mJlbEuzRgxB8w3i0r1BwsUp5w+V5dc9qUr7hWUzKcYG1ucg9nCIF0q/Dnl269D3umAGJYYw86eQggDo8Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725649939; c=relaxed/simple;
	bh=yGdn6spQhEZ4GsQh18Ddlv0dzTH2nAYO/b0/onImV9g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=J7MAUfRnNlTtogOr+oPEgUWFbUu0sIdox408sW5kYjE37qdlWvj8Q4OHMRgiTO/UZt3z0U7B4k91GUjZYG4v8ikSc81UK2PpfT3Njw/H90LDq7BmMM46w8/jhNLIiFlibqUk12WoB2XuK0QJ1CH3IqubmiubRC6xz6+aW+PTWKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVYzwTEv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A954C4CEC4;
	Fri,  6 Sep 2024 19:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725649939;
	bh=yGdn6spQhEZ4GsQh18Ddlv0dzTH2nAYO/b0/onImV9g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VVYzwTEvlI5J83EOatuJlfqtHuMnHxufrhi8OGZLEik+klWwLeX5LFyF/p14wLpKf
	 lnY28TCJ7tlp6d7uzUiMx3r2x4wZj1p5vRxZP6uIoRT6cngVOCUm03DGRTV/jFuVtO
	 BO6nFPS5WlcZUUEgQvnIhue1BXmmTuuayNMAnwHi1MP8V8sTjcC6na9oFuVKcen0H/
	 Mrdd3+OA5xS41C276bzdXlhBUcbeYIx9AuiudFaqxrZflHGBmAxO4TXCtFNMJV+h/J
	 a3y2c92eIs9XGeVVqPTdYMSQJ7hQnW32SP+9fFTHTvGpre4qiXePgQt6Pz8b0XDjLA
	 oDqfWVFtFF9KQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7125D3806644;
	Fri,  6 Sep 2024 19:12:21 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain fixes for v6.11-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240906091425.194581-1-ulf.hansson@linaro.org>
References: <20240906091425.194581-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240906091425.194581-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.11-rc2-2
X-PR-Tracked-Commit-Id: 9ec87c5957ea9bf68d36f5e098605b585b2571e4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2125a725545fbfcbda3f99d4bb4849a04e7c07a9
Message-Id: <172564994003.2497610.12313622511252522447.pr-tracker-bot@kernel.org>
Date: Fri, 06 Sep 2024 19:12:20 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  6 Sep 2024 11:14:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.11-rc2-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2125a725545fbfcbda3f99d4bb4849a04e7c07a9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

