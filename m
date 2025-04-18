Return-Path: <linux-pm+bounces-25734-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3925AA93EE6
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 22:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0B6C1B65ABB
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 20:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A425253359;
	Fri, 18 Apr 2025 20:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZD5/sqN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336F1253351;
	Fri, 18 Apr 2025 20:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745008045; cv=none; b=WI2L2qsygEEQnq/U4hw2B4xi9j2WyL249mhXeH2y+tbvlZIVrFriaR9qaJppAlCvbj6po989oRlhQhSsxT1i6qwu2dK3m/eGeTAPKaD+QCYdXPZxDUr1a1PmkXe3kKtJ1y9gA9sOTB6dK4OiU3HcCjJzp738JvH1MvEc8BUkztc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745008045; c=relaxed/simple;
	bh=luQlpI4PLZdKoydu4//pLXFh6WzsyFeRDpngWlRqd4k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OCJZmOOj+DYumMaRNJHT8489lPlC5LJJweOFRYD5TAXR7pBcLr12E15if/tWpavegRIa7MMVkB3LHihM7zzJEbV9KNg6Xy+aMuIik/sY+gvBRbsr/hQjzAIXDalReTpSIiD8sxvlFe9MpUTiQdzIisiatv2UC7ei7PIsYaES5ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZD5/sqN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1040EC4CEE7;
	Fri, 18 Apr 2025 20:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745008045;
	bh=luQlpI4PLZdKoydu4//pLXFh6WzsyFeRDpngWlRqd4k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MZD5/sqNbTMiObaoNey8SJ3M2m4xDIPxrFjwCP7dao0dmw52nSHotgmpkhGJyTsfb
	 TJCQ1AAq/zFnRjFenUrP/xfoEQ1ju72mmgfAwgaOPJPkntKViXgEE2ri04sodeDCob
	 ZFa2puOt0IOqjbp/cOw4SKE6ANM5YuMbNN6wFEexbLR6rI9VJ0+I2yHglyz0T27gtN
	 fBtosAUhUEOcHeXiFH9dvtgAS2hXCc9j4+6AXMWPH7Wk3UwtqZhtYKF7JIHmZL94K7
	 6haF7z/2GhdjtjQXcANvT3g5R5DAiSn/b/H1DCtAfC4N1OUriHicaK6EiXSc5SjT+V
	 uPBCggceSiM2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E2C3822E09;
	Fri, 18 Apr 2025 20:28:04 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fixes for v6.15-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0imoR19gyH+DKR2CXtLeQEdbKYNWkur_7tjf4a4NQRLMg@mail.gmail.com>
References: <CAJZ5v0imoR19gyH+DKR2CXtLeQEdbKYNWkur_7tjf4a4NQRLMg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0imoR19gyH+DKR2CXtLeQEdbKYNWkur_7tjf4a4NQRLMg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.15-rc3
X-PR-Tracked-Commit-Id: 00c5ff5e9a55dca2e7ca29af4e5f8708731faf11
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fe65616bf8bc1041ead8cae9edc982f62d2c120a
Message-Id: <174500808302.316726.5049161169303778036.pr-tracker-bot@kernel.org>
Date: Fri, 18 Apr 2025 20:28:03 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 18 Apr 2025 21:34:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.15-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fe65616bf8bc1041ead8cae9edc982f62d2c120a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

