Return-Path: <linux-pm+bounces-11127-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C64931E24
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 02:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1149B218D6
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 00:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D08946B8;
	Tue, 16 Jul 2024 00:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAwdGo3b"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D3212B72;
	Tue, 16 Jul 2024 00:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721091113; cv=none; b=rp+0MELjQlKlTs/vHeEoR+tu3k6QvmMBcyXe418o3i/1M72EA1rpziv487/MgVj7xId4JK/ZLZcMn6gP+pB8E59wi7MC6PmCF6Nqu7GuDtlbZv1C5yg+rJw8zsLZeWvCXRizJ05MIzDQmiD7I1pki9gz/Y7Dadbi73a2TpoJvEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721091113; c=relaxed/simple;
	bh=rd+HEVAFjkN/SsY5zUJ5lQMMMCG1/WJIapcEJ194g64=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DH8jMV8IP7umQI9ouSwNy84eqSp13Rv1PoBnha5k2Xwn4lIC9vOQOVNv9t1++TdQjcKMA5+y+ikVcYIw74/z2/5g78cqp9yjCEd7rz1600++amnVv9jGnwU3YPWf1jFnHuKr9836BIUELR8AJY1MdogDOlYCapbgK9vzg/x1ON0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAwdGo3b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22F7EC32782;
	Tue, 16 Jul 2024 00:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721091113;
	bh=rd+HEVAFjkN/SsY5zUJ5lQMMMCG1/WJIapcEJ194g64=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MAwdGo3bmklvlylXtAPwAIV+NsBa51iBVJvA05qzlDNeOONs4lFD7wy5SLzKZfSZb
	 qgjs+djQlELkCZUDgTEtexBEJPWYZoPHJG7EqTBV3uE+ST2hb9JVfxKePalSvmMPV8
	 dfThX7GgnxzyZnZsEH5xYuK992zFLL3sIAB/yXDKBFrDiWKhN5uQvrYoq+D759nlb4
	 ynnIvDCDo1adMSdG4nYUm11amp1lRoDZL7u0UiLBjRxe4rqkIcOtwK3QpTT3X+8ggO
	 rqmJd5dzAQxVaP/gHYLVQ5O2gEJU97yRvJuspf2K0Owy/Z027Lk7Jf2uyfuGUMnKYL
	 qZ/vyw/I4bw5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 180BEC43443;
	Tue, 16 Jul 2024 00:51:53 +0000 (UTC)
Subject: Re: [GIT PULL] power sequencing updates for v6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240712091008.14815-1-brgl@bgdev.pl>
References: <20240712091008.14815-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-arm-msm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240712091008.14815-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-updates-for-v6.11-rc1
X-PR-Tracked-Commit-Id: 50b040ef373293b4ae2ecdc5873daa4656724868
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e763c9ec71dd462337d0b671ec5014b737c5342e
Message-Id: <172109111309.26590.5027468631355280964.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jul 2024 00:51:53 +0000
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Krzysztof Kozlowski <krzk@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jul 2024 11:10:08 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-updates-for-v6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e763c9ec71dd462337d0b671ec5014b737c5342e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

