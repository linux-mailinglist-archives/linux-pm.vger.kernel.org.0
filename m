Return-Path: <linux-pm+bounces-10944-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F4192D60D
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 18:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 550371C20D6B
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 16:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD25919539C;
	Wed, 10 Jul 2024 16:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="La7uQVCv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAEB194C92;
	Wed, 10 Jul 2024 16:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720628053; cv=none; b=ivv/HaWfA+gHHjzTgHSFO387NtSP2iacLvhykYNd26TOA618P+WJfQejfZykdrbXm/LuD0ZO+suuc7OZtYLkzNC7KR3aTJpL5kBdzBTNGmxQeQ9bfoYL5UIR18LsePizZbqVe7ZHtANL12ah3+FxQZ42aPSt+iktO2uv5EbgBwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720628053; c=relaxed/simple;
	bh=M0u8IREiqAQAuAJpZdF7zO83BLR7OwQzU108h/pxGpE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=U12VhRl8dHY9oluXswCPuuhHeUCZ4ZcEb6N+yzr3IJO9o0BF5+bFtVX4NXpdeUeTtga30Wy5SVs61SMftslR4g2632FhkbOinm2XYcVl9zWTZygqSP5RcbSUhAlmKewH17gbRVjPekrYZySZ3wxYutqjn9byIT7kot56yxHvwpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=La7uQVCv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19174C4AF07;
	Wed, 10 Jul 2024 16:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720628053;
	bh=M0u8IREiqAQAuAJpZdF7zO83BLR7OwQzU108h/pxGpE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=La7uQVCvug7mIXI4aBdqV0TF+EWEWKlEyVyWTBvfgXuZUCqDDfDXq2A0ZUT2q+96Z
	 U56nFCy26EF3Hn5qPoQtDyPGunIYwtgahucgo/TWqSptZR8gWzxV++Xzeg5P5ISeGq
	 q14pSbOOBGtyvj81lwjWsFvLC+lMVqPi2lzLU49LAx149dtM4D27aMRzxAWDDiKOh4
	 ENwFh1dW395Na56hnR8dOS6Gsfmp5Bpn4r2WFPX/Q6zUxjL0inmbyPtC70lLUAzNvY
	 5PXeG3d/xGpMg02toMcDndmH7Xln7x4vHKbl7PnuIHzYn39XP24CG5xkM/iqxyL3E1
	 GcevQBNYsHQjw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 05259C4332E;
	Wed, 10 Jul 2024 16:14:13 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fixes for v6.10-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iomX7aKU5c9-uBiRoVKonwRdCvoT9xNih8401ef7ShuQ@mail.gmail.com>
References: <CAJZ5v0iomX7aKU5c9-uBiRoVKonwRdCvoT9xNih8401ef7ShuQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iomX7aKU5c9-uBiRoVKonwRdCvoT9xNih8401ef7ShuQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.10-rc8
X-PR-Tracked-Commit-Id: 94eacc1c583dd2ba51a2158fb13285f5dc42714b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d045c46c52740b0d5e92d376f0b7843b0c0d935a
Message-Id: <172062805301.17113.12044194749938030822.pr-tracker-bot@kernel.org>
Date: Wed, 10 Jul 2024 16:14:13 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 10 Jul 2024 12:57:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.10-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d045c46c52740b0d5e92d376f0b7843b0c0d935a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

