Return-Path: <linux-pm+bounces-20821-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6DBA198F3
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 20:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF85716CC53
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 19:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFE6215776;
	Wed, 22 Jan 2025 19:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6DaP7uJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F6F2153F1;
	Wed, 22 Jan 2025 19:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737572766; cv=none; b=BHEcUMrkXICtA1R0wAqW2gGyqKS9LC8rPK66BJxYOgpG6hZlsf2DhdzKInpTtFTcotpY3jkU+2YTmzKCn3caPO+z64g2b7ZMdfeCGMNuSA6EbaTn7xhB9CQyYJl4zO47tEMxW2Hc7vwOCUhG07rsFJ5l6ThoDt3SAcXte6esNks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737572766; c=relaxed/simple;
	bh=SSebesQfrbsuKVP3SfirCw7VxKIfvub7De6+8NFrYvE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=iNDVjIIBN8cBOY3wqgQfbVTQPh7Kv+K+wx0eihDTH9smdYEmN+0NseSax39WUayibjdAhiYltLsoBst/kh6JE5VVg7HgY+tAetJ9d3I8VRO0UtLzIG1I8nOqbX1ORpRfuRUbsF3eQ4iqRkZSncACzna3Pth4t4ykDzMxxscYB70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6DaP7uJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347DAC4CED2;
	Wed, 22 Jan 2025 19:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737572766;
	bh=SSebesQfrbsuKVP3SfirCw7VxKIfvub7De6+8NFrYvE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=t6DaP7uJvqvxMeGKAjNEdQyo9CoodY3BbcHIrC1SCqaE58BoNyNXt7m1I30daAtLp
	 2xSqS2BqRiyjKEhJcCqgcP8VsVpLGvTGQHgntUrqh9wtad+N26++XfG5VsEMvKS769
	 2PrM4OpqUzxkYLYUZJxZkcgd3LtIfW5r19Juvv7Zz82k45sBXgOV/QziNJ7a6ynV6A
	 UGRbi/Phx4kv+aEsodwiec7EvDyl3YIfRr34waFe5Dc5Y4aA3m78U2+RBbDbXIj7bH
	 G+4AoYyN+EVLpDMVkpJWDEJJPNv6u4jQQgkD9+AVmPuiEuAQhIxUNbb8UIwYbmENjn
	 VlXyI63Ipo9Lg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACC9380AA62;
	Wed, 22 Jan 2025 19:06:31 +0000 (UTC)
Subject: Re: [GIT PULL] pwrseq updates for v6.14-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250120142251.330065-1-brgl@bgdev.pl>
References: <20250120142251.330065-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250120142251.330065-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-updates-for-v6.14-rc1
X-PR-Tracked-Commit-Id: 29da3e8748f97dcf01498b00d42a3e7574ece80b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0c9343150cfebe4bda9339670ab423e330fb5224
Message-Id: <173757279045.783272.17408039042351816788.pr-tracker-bot@kernel.org>
Date: Wed, 22 Jan 2025 19:06:30 +0000
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 20 Jan 2025 15:22:51 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-updates-for-v6.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0c9343150cfebe4bda9339670ab423e330fb5224

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

