Return-Path: <linux-pm+bounces-19640-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2AE9FA20C
	for <lists+linux-pm@lfdr.de>; Sat, 21 Dec 2024 19:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 338451889952
	for <lists+linux-pm@lfdr.de>; Sat, 21 Dec 2024 18:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D172B187870;
	Sat, 21 Dec 2024 18:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qBnQUYRA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A45187342;
	Sat, 21 Dec 2024 18:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734807397; cv=none; b=Fefl2JThKhFhcXXBaBc2rPWyl+By5cpivyUhBZsHeqUwjn+ZZNpI+NsQhmB7W+us3T5lJOvx6RiUwUlAfYddi0775595f0Hsyeo2RnMGSxWhXfCCRZo3h8xNc/JE1dzvruymXeELlXEFmtw8cVLIaCgjCVXp+KaWHi2PkRImYuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734807397; c=relaxed/simple;
	bh=jHpy02FBU0kWBDZEqnJKMRcMbRmqduNEhx0i53fgWkg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bVARsYIZ+iKv46RVA4zGx87858w3O2ZMNbzJoLmQZG2+ZpAuWrT4kI68ZGlntw64jYqIHx9uOCZgAc5KPzyWEPb4n7nCPS5IOYZMfZuqZtFYMJ6yhPynk9+tlOwqhN5AzuU0oy9Tp9Dpm5zu6dzlhVHwHqa9VoSxR+kRHof2xoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qBnQUYRA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333B8C4CECE;
	Sat, 21 Dec 2024 18:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734807397;
	bh=jHpy02FBU0kWBDZEqnJKMRcMbRmqduNEhx0i53fgWkg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qBnQUYRAkN7RrVqpKYmLxBnRduf/EGpGy6mkd51okz4wsEhOwFD3CtiwZEuXPxKYT
	 TKbSsTzTeRwo8KlfYXkE4dCJolM3aujXtUY/N4gmQffLPh6jAN+A+3cPkXXkMj3R4n
	 g84votOsq+JczTp6Gm57hUhKp8T9yjpaGcftOvhFAnVNG4j+osHc8gzz6vcdHjEUBZ
	 75GW+OCMYmr6HvuUXs7Oy/udXKfHqLL6aTaJTRFLsvYSrqJxrM0tK3zdnCaOkJ2Oo8
	 sKKGqgsgOOUmZIgnT5vsLCTdVQiZnQJ+iWroWi0LAjOUkXYog5lfnLICep/AAYWfj7
	 DOcAwFXkI7H3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E0F3806656;
	Sat, 21 Dec 2024 18:56:56 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fixes for v6.13-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0g2kY7UQKcZVCE19mKKfL1muw+Qnj_Wq4GBwtuFmvgMxg@mail.gmail.com>
References: <CAJZ5v0g2kY7UQKcZVCE19mKKfL1muw+Qnj_Wq4GBwtuFmvgMxg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0g2kY7UQKcZVCE19mKKfL1muw+Qnj_Wq4GBwtuFmvgMxg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.13-rc4
X-PR-Tracked-Commit-Id: 4feaedf7d243f1a9af36dfb2711a5641fe3559dc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: be6bb3619eeda0cd3a52ead9e63c5795ac87f0c5
Message-Id: <173480741512.3207643.14408947881660009170.pr-tracker-bot@kernel.org>
Date: Sat, 21 Dec 2024 18:56:55 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 20 Dec 2024 21:47:30 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.13-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/be6bb3619eeda0cd3a52ead9e63c5795ac87f0c5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

