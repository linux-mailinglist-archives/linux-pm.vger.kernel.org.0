Return-Path: <linux-pm+bounces-17839-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 679A49D434F
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2024 22:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 029D1B273CD
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2024 21:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B08A1C3F14;
	Wed, 20 Nov 2024 21:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Et6MnjgT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754321BC9EC;
	Wed, 20 Nov 2024 21:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732136413; cv=none; b=BWlRTQS9edD4RpenoPUTrnIp6jfYmW4tZPXsDJfETMfO82lph7vZ2vlUwW0qCCzoYOSH/vcv2pHTB/4GkCmO1e4coynXaNbN9zjuE2asPkypWKmwMY3iQ8Siu540zS/Mz1VXpvAeZOhBNcSXKnq6ZHs8eifKC5ihA1AfmQJnwTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732136413; c=relaxed/simple;
	bh=y6HZq1ASKdRiQIiK9lhiC246T7SS/jKVyLkAt9HO3PE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=a98n7C5vPoP0lfJ7q8CaauwAJII21vyXxx1A9JpMbB0E8p9BPN3489Bz6ro1JjgigXN/6xl5oBQkpi/5Nu05wNH4k9ptXv8xAgXzakwOcPManj42M0f0MFH/u1+s3inGsYjZKptEE61dJhyIl8q5ZJnxMbN24bXwIK16J/Gf01o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Et6MnjgT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF06C4CECD;
	Wed, 20 Nov 2024 21:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732136413;
	bh=y6HZq1ASKdRiQIiK9lhiC246T7SS/jKVyLkAt9HO3PE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Et6MnjgT+l9neKdY8QttN3V2HDyLawsxWDBLmv6gVfHikF2b+axtFqOtgcp+ZF0eb
	 zecJD34INrsJvoayfBMizt+OoANOd+kXy2pIUT6eqDIExZJj9HtoS9oZLnqAadBv9s
	 /Xzv3nKy5Da+7zYrcoT4Y267qfdyCskuzoheX27kgdOU35GsoTGWj4EHwQhkMs9KTg
	 L6gPU8dDiWqasIIJ6mE2UldJiZSF/HRI5w1EELT91qMMlsseF7DKp95qWuDlRb3hgi
	 xdNwi865H9VaDfLsYXKlRvlIRiZXgzHAzivGeT0biRDEi0iPOcMZ1pWfVtN2cbRfwo
	 T4TcQN5oowKqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB5683809A80;
	Wed, 20 Nov 2024 21:00:25 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain updates for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241118160444.161917-1-ulf.hansson@linaro.org>
References: <20241118160444.161917-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241118160444.161917-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.13
X-PR-Tracked-Commit-Id: 5812b95b7ff47d2ccc07b8f050652604ac54cdcf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 75f2b37dd0a0eab8e6b179d745d79824893f39fa
Message-Id: <173213642453.1349927.18421320316689819118.pr-tracker-bot@kernel.org>
Date: Wed, 20 Nov 2024 21:00:24 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 17:04:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/75f2b37dd0a0eab8e6b179d745d79824893f39fa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

