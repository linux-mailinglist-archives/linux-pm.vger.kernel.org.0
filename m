Return-Path: <linux-pm+bounces-14398-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D15C97B9AF
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 10:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FD3D1C23B9A
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 08:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15D8189B86;
	Wed, 18 Sep 2024 08:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knWWGEax"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B21F189B83;
	Wed, 18 Sep 2024 08:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726649835; cv=none; b=ty3+MvZvdhiGFuYG8d/eU0tiyzNJ3HOROekq/WwmhWA5nhQqkF5QKv44ryzEZIhZLHJWNhPolhHYodiCNPH/+z4lIBfQtUpvgoNmV0z4Ebun9k8oqRGBfwnFukC0wyn6FWB+iNGaR6QcgbL+QPiWInwxGzdt0KtvKHmhERmFOqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726649835; c=relaxed/simple;
	bh=5HtZEeeXlCsTNtrhhuj+f9mgODSHt9mobIS+VIlHcTU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=J78SvCxKaGm5Q2/8RiYNKFV2SDZKH9D7g3a1eW/NeJpy28KdZ4DWp+/FDrke3X1uMNCuou9ZQ1R5kzA4w0wrks6H3m8Fqh5ivPRoN/vBhWSNGOLCfUlE3r4lUDmrhghJhwF2Knbmq2RfXOKPrPOlV87UV3KvszmGRoXBrWL2Rtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knWWGEax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F58C4CED0;
	Wed, 18 Sep 2024 08:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726649835;
	bh=5HtZEeeXlCsTNtrhhuj+f9mgODSHt9mobIS+VIlHcTU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=knWWGEaxadKkdRHTROaGyo97JmUmQIBiPoDNVtlVM/LMx2GFtFmVlZAhnhJtWaImD
	 mdLSQ2iDkg75uqRLZQLDt6pDAYHEeNXpnnioZxEZWDHZvk8DL1VtG7W6iO1Lfl1Yp6
	 SAknxoZKjDobSxOJJRpZyYtLwieaERHteve3jzjRT+sj7QtXzVGqB1FYIL9TFEotER
	 vESFEenUrOGN8pP4LtS/f+9DfwOXZQOANXAQbuJWI+J0b/uQ/nTzEdETOfJY9L6Wx+
	 yT2D4wTYGMdCVSQsPxBF1eDRaOBXRNdxkvomdDjSsBaJVnjFRdVc1iRrhj6hEJbE+3
	 bZZa7fGazLJeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F853806655;
	Wed, 18 Sep 2024 08:57:18 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain/cpuidle-psci updates for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240917064653.4226-1-ulf.hansson@linaro.org>
References: <20240917064653.4226-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240917064653.4226-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.12
X-PR-Tracked-Commit-Id: c6ccb691d484544636bc4a097574c5c135ccccda
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 200289db261f0c8131a5756133e9d30966289c3b
Message-Id: <172664983689.725883.10324430223224514806.pr-tracker-bot@kernel.org>
Date: Wed, 18 Sep 2024 08:57:16 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 17 Sep 2024 08:46:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/200289db261f0c8131a5756133e9d30966289c3b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

