Return-Path: <linux-pm+bounces-17838-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 699289D434D
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2024 22:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29A39284650
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2024 21:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAC41BD516;
	Wed, 20 Nov 2024 21:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orMUxJTg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C151CA84;
	Wed, 20 Nov 2024 21:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732136411; cv=none; b=cfFeVFUI2RY5W0IH5ERQLdLS1iTnskxUMgZ4/hhAZmXA2FX9veDRT3DcLZHUrODsRYSg7rQxK+RGLkDbYY0g+B/C8qL7d7M8q/rZt3z3iFRmL5BZpDVLz9Ov+fn14/R/z1ho8X4aeXTWzUWnUQh38aqtf7mh+LiTe6EaEBFVmig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732136411; c=relaxed/simple;
	bh=3RIFMsOqPkP2bZImzv5qRU08VG8rBnqGsLvYzygZYEI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lfCWd1CEfQN0s/e2MlpcCZl1OXRa8CY0zDwqs4HjEo96zB1NqbK2DKH8OK3Pz/fe/IFoo4e/Wh4a5ZotiQhMWbMTTvt9FpjOA9hPOglPayocvYleO3vPAZdIc0PO/pu07cwT4YiHS+IwLi/ZNaADtWC8Ab5vlK7Voi9m4lQzoi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orMUxJTg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31CF2C4CECD;
	Wed, 20 Nov 2024 21:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732136411;
	bh=3RIFMsOqPkP2bZImzv5qRU08VG8rBnqGsLvYzygZYEI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=orMUxJTgsBoJy/ZypNE0lX0rV1FmrIBVP+pphsMtX8Y9TGo4v6f/MDLC/0SfARbJ4
	 wKj/PaUfqbaUnwllrxcKnabCFLTyjSBa5SkybobXe3XfOv+jBK7NAa/AE91gD1ovN5
	 RZJR7TkQ/COs+qzLu1ra82wDlhwhB7JVMI5bCyWUl88xcCH6ryE7nqDuw8yAD4Lbea
	 Ra2vxIeNgOHDIl8IOdwZljdO5y3j69JoibCvf6h0i+tczeBga0TUOC1Ox3BtkkLA4b
	 SVUYyYN0fYJNJH9Skwbiw5aJ260/Q6XZwt1Jw4hwwpF4w/dxb2kfqfc9GgMtgtEugx
	 dwMT0WmxbfCNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 342C63809A80;
	Wed, 20 Nov 2024 21:00:24 +0000 (UTC)
Subject: Re: [GIT PULL] power sequencing updates for v6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241118132124.52994-1-brgl@bgdev.pl>
References: <20241118132124.52994-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241118132124.52994-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-updates-for-v6.13-rc1
X-PR-Tracked-Commit-Id: bd4c8bafcf50b6bd415c8bf04e98ebfba78071f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0cea11025519f8f658963d8e835c7234450500bf
Message-Id: <173213642272.1349927.6110709493041040481.pr-tracker-bot@kernel.org>
Date: Wed, 20 Nov 2024 21:00:22 +0000
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 14:21:24 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-updates-for-v6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0cea11025519f8f658963d8e835c7234450500bf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

