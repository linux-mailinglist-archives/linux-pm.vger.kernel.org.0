Return-Path: <linux-pm+bounces-7915-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C14758C7A3E
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 18:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77CF6284850
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 16:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B72014D702;
	Thu, 16 May 2024 16:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qBkReIvR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98EB2421A;
	Thu, 16 May 2024 16:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715876618; cv=none; b=gwzEpshjPgdTuHi16zSx26CryqBpA0+OIg3c8ANKDEx/3kts8fsGW5ezJ2dT4HdGGA7AMoXbIIBSdQnHwmdCIKP5rltKezVgAodaKvUSolDGod3D5JakPna1aTHRzv3am84tQMsvRjD+0uiroAoJrDcmRvyNGNauLvwlEwWCf6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715876618; c=relaxed/simple;
	bh=QEXCd+EEwZK5HxuxafBC1wjlYbtMv0VzrW3TDtC5Jsw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qXsNh87JAwgZZsSfVlcIw3kEp8GdETnKV/F70YZUhe+lMOiPd1PLh+AjCuCiBr1Nz2OjNVTUJYXV1G+2CKjkeUaXICfnsa0vUj6DgGlqnAxPMrELasgAFOBA9Hza+/KWFuGejHsSYEMbngixvlB4W3tGwVAUuj5UrU2N4YK2oJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qBkReIvR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC8EBC32781;
	Thu, 16 May 2024 16:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715876617;
	bh=QEXCd+EEwZK5HxuxafBC1wjlYbtMv0VzrW3TDtC5Jsw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qBkReIvR3Rzrt52L7GRtEzLGwcwqMiVcH+2MYk1ea/e17DdG81tKhxoY0QQ1jdJGp
	 tDw1T4BCpVQ/9yMIdVoomi4Sdg+qUGFbeylUaPwwVrla/ergTJuoT9h0ODCu/jJxPy
	 zKFS5TOaPz9RXtZsU779/U7be1GGoFtl5gd0z9Y70iH0P4Gmw6bHs2o6wOE3GKG92R
	 +KnymrP2G7LjdTN1q9dVyAE0vUtabkSUIoqqQ9b9qIk7lH1jyEzfLsz8K4xb59Z5f9
	 Op/fZ8fZAknlEtRrfE/jjWv5MYe3yn08PFrjkGQSu26eTcuZi4KFwAgJ2hPkfhjIct
	 68rHmXtWMWcqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C3962C43339;
	Thu, 16 May 2024 16:23:37 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain/cpuidle-psci updates for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240516124417.22410-1-ulf.hansson@linaro.org>
References: <20240516124417.22410-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240516124417.22410-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.10
X-PR-Tracked-Commit-Id: d88ea30340963d87c267cf1c7ebb2a205ef04e25
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8b35a3bb33b57bc2cb2694a50e49e0ea01b9ff6f
Message-Id: <171587661778.28916.7510017887116485169.pr-tracker-bot@kernel.org>
Date: Thu, 16 May 2024 16:23:37 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 16 May 2024 14:44:17 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8b35a3bb33b57bc2cb2694a50e49e0ea01b9ff6f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

