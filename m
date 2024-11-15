Return-Path: <linux-pm+bounces-17649-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BB99CF4BD
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 20:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FBD9B2BE64
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 18:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCC81E104C;
	Fri, 15 Nov 2024 18:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WG9QKv8c"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371851D9663;
	Fri, 15 Nov 2024 18:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731697145; cv=none; b=muBAtsakTTn6EF2xW4yBNTGKd36eVPBYZ++HRQauIfIEj2zgizR9yCzT5LXcjdfCdaryJESNEckIXo1m+eq/EnBWpj17aYDV3S0YI0C00YlQ+HPioKp4nNc85RgD2ctaSeCe0oL+q/igH+Cqdj80GKfKm8zVjKJnro5wMT5sHx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731697145; c=relaxed/simple;
	bh=VoL9QAjzZoyo11W7X2QGJX+KFhZqxNNuuyRX7ng7k04=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hOqnNH0/f/N5MqDv2T0OQTlOEhYZPN7a1XDSRbBsVJ3oNcrDudx/KyTM8TyIoIWZH6WrtjbnnAwkMMvT62Bs40UVr3USn2C5KrQcXbLCJamjVPBnvCT2/Kndu71JAjn2NjzOJ/+OSd2lbmnReswO9IZ1tTAlp1g9pOcd4bqNCrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WG9QKv8c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB91CC4CECF;
	Fri, 15 Nov 2024 18:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731697144;
	bh=VoL9QAjzZoyo11W7X2QGJX+KFhZqxNNuuyRX7ng7k04=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WG9QKv8cNDA1LQvELcFsog+ELv6JKPodpjEjjwrXqhmMbK8jeX6S8CPbXODrwKtJe
	 jz3Etfy7Qc3YZIH/Xr+ltq7XQ6YpJasF1m7rg/zPLGcj3TwuSDv328uc/Y3XNyat3l
	 mqtTW9/3QsbtGS2ld2crVBT76xhzdh2IpX5VFkfg0+/e3MzHIsMzXsvfxHuEuO9Yuq
	 RaLgJZGYh7Bg8I5uw6T54axdNrcNugmYIJ3S5SJQwy5PTOtb8d6AvJTAoxwE/DCwjd
	 OtsQno3Zg4e/F98hbaxRaa8XSQ18np0YgAMvb3aSS3pUIsFjOQDat3PWU6H0fARJYU
	 Enzr2a2MPKZpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE903809A80;
	Fri, 15 Nov 2024 18:59:16 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain/arm_scmi fixes for v6.12-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241115104029.119226-1-ulf.hansson@linaro.org>
References: <20241115104029.119226-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20241115104029.119226-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.12-rc1-2
X-PR-Tracked-Commit-Id: d2fab3fc27cbca7ba65c539a2c5fc7f941231983
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1b597e1cf0a226ff1a3b0e117238cfe6c5168de9
Message-Id: <173169715530.2685462.6684041644643108974.pr-tracker-bot@kernel.org>
Date: Fri, 15 Nov 2024 18:59:15 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 Nov 2024 11:40:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.12-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1b597e1cf0a226ff1a3b0e117238cfe6c5168de9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

