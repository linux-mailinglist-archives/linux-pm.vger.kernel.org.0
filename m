Return-Path: <linux-pm+bounces-31543-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F72B148B1
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jul 2025 08:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B685B4E49FC
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jul 2025 06:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C467426FD9D;
	Tue, 29 Jul 2025 06:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZya7MPi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFCA26FA76;
	Tue, 29 Jul 2025 06:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753771808; cv=none; b=n8bKBKtji44Xs12uu1w+opxZMfN92HMNoFzQhvZpfm6/uBmXd8ZYxboILsfGFad6CUTDdOdLPMdXGsXvGnQPz9FK+/Qw0dWaUPQvDGSKcnQfUKC9upNh8RYaDY4bPAa5Dg7vZtg/XByJM3pdDYnGW3Sq5f/ErOhnRIhsSEnWeGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753771808; c=relaxed/simple;
	bh=wzmj2mycP5ENimRD6vscOKFgTMlVcVpsK0i2ZGSAfEE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EG8Khy7sGCixODAGt7I5tjGARXYCjUOCfoQTvcG9YUs0kDQdfXFdK9YeSrA3Lj+MGXnx1ad2lPHX6jjbAlcozKPVfZmKfpPGZfnOcoPBa+oUEFnACOVRwLT9kHLn6GzhNIihI448MRfH0/+dXNfSgBQFA/eb819WYvc4fP0CjkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZya7MPi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739C8C4CEF7;
	Tue, 29 Jul 2025 06:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753771808;
	bh=wzmj2mycP5ENimRD6vscOKFgTMlVcVpsK0i2ZGSAfEE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fZya7MPivgWScH7eccdHKCeUee2P+0psauzKZT2XUUVK0KRCB36Vw3SyoTmJh4Txk
	 p2jXMR9xm/DBm9hUbHySOW5HPHuVmAAoASUffGbugYksmSnkW8WqR9YTyZSj+Z7zX6
	 urGxPmX+XkeLWVVQjEPTyKZ6VtXHVPsiU8/fRefH+BNr6ihCB1gsEAyVS8Syp8HK9H
	 hD9hLTelSpd4SXKuPstsKW6B88BUf+D3xCPpysK9onvn5BNGmR+FU5WS/ekJXuI5cm
	 KSuwz4F9QXpPaNQOwFOWSd+XYbWpnDCgAylJ8c4e7x/7pO7Di0KqUjdQNvTRJUoAuU
	 6zdr88pkyDsMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 29DBB383BF60;
	Tue, 29 Jul 2025 06:50:26 +0000 (UTC)
Subject: Re: [GIT PULL] power sequencing updates for v6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250728102030.44816-1-brgl@bgdev.pl>
References: <20250728102030.44816-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250728102030.44816-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-updates-for-v6.17-rc1
X-PR-Tracked-Commit-Id: 07d59dec6795428983a840de85aa02febaf7e01b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ffec878fa5fba8c527cbbb006b0522ae0d6599ce
Message-Id: <175377182499.1356386.1088153129172640565.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 06:50:24 +0000
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Jul 2025 12:20:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-updates-for-v6.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ffec878fa5fba8c527cbbb006b0522ae0d6599ce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

