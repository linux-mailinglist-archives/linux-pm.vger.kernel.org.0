Return-Path: <linux-pm+bounces-19228-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 019CF9F1BEA
	for <lists+linux-pm@lfdr.de>; Sat, 14 Dec 2024 02:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77AA1188E4E0
	for <lists+linux-pm@lfdr.de>; Sat, 14 Dec 2024 01:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C033414A8B;
	Sat, 14 Dec 2024 01:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8DWZRFC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C171799F;
	Sat, 14 Dec 2024 01:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734140128; cv=none; b=X/HWo/mB1l9zehP5uRasACrKHEk+kwNKSf+9pabT5p1Imcw+uRK4wmL6mVpzzwl3chaSfS3dnRXctorCqjNM+b5UB25OVGVugv9rWe1nIVO2ahUswxbR8UsUzmZTbxNmQ+ukKt6I8peKSg+3Jg9thMns6/KDsakQL8ohuouxBR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734140128; c=relaxed/simple;
	bh=j5+FEc3Ev1nRCt1vpDiEgyXARNDEPQszvM7dYwJTBU0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VyE3gfDpGUH7HhkZVtOwWvQEGY0mYKbXFQyO+2LmEHfOYlH82ZWVXGDR94g3pXnDwDnYlEHonhq89wk3nf1zwh+499IeuAUkVmI0wCpqMmezGoULChHcxDj7+VHX/XUZRNmDOL/1UVNfmiAVKHJZUs1TVOBEZGWCnBX8Hcdy5YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8DWZRFC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 759FCC4CED0;
	Sat, 14 Dec 2024 01:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734140128;
	bh=j5+FEc3Ev1nRCt1vpDiEgyXARNDEPQszvM7dYwJTBU0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=H8DWZRFCYyRY2tWc5X2RYOJOyLLHLUEpDQIgiNRSoW9sJeUZV8DAE6x2+Ir6B1oUx
	 /zONVzr0tvVIUrIMhm2jyCWfpZhptM9KRVjuRoeO2THZqbbR5MM39aewZ1XqPMX9e8
	 2Ny99Syrl+oPl6Kss9bF5dN0XgIsKe2obttlnePLx9SS5ce+phgZ/zrYIOlknqgSm6
	 ZQz++IEC9yLbEGQoo5Q2kcBobjGIBU4uhMiib4ZXlzBLXBzxgGZEgMBrx4trH0q8Gk
	 DT0v8XLIBIBZhgxU/BXU4zCKo5dF/zX6HcffQ6p2dRvuPsRvYILBroEi7klheWcoT/
	 YABOWc87zlqRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C7B380A959;
	Sat, 14 Dec 2024 01:35:46 +0000 (UTC)
Subject: Re: [GIT PULL] Power management documentation fix for v6.13-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0g-ZThRsRm53qm=JvYdGsXxtMq1NkDrR5qd65qN8kjw_g@mail.gmail.com>
References: <CAJZ5v0g-ZThRsRm53qm=JvYdGsXxtMq1NkDrR5qd65qN8kjw_g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0g-ZThRsRm53qm=JvYdGsXxtMq1NkDrR5qd65qN8kjw_g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.13-rc3
X-PR-Tracked-Commit-Id: ccb84dc8f4a02e7d30ffd388522996546b4d00e1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 974acf99744ca5c0663d0864a1ff3a13491c4f4b
Message-Id: <173414014479.3218065.9286762846748840927.pr-tracker-bot@kernel.org>
Date: Sat, 14 Dec 2024 01:35:44 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 13 Dec 2024 22:01:14 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.13-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/974acf99744ca5c0663d0864a1ff3a13491c4f4b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

