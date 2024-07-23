Return-Path: <linux-pm+bounces-11349-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E450893A4A8
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 19:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49CEDB22F57
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 17:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288D415821A;
	Tue, 23 Jul 2024 17:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqdBRFv6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00594156C74;
	Tue, 23 Jul 2024 17:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721754290; cv=none; b=sr/eEvETxLTG3tx3UgtfqFIEpNejziZaMXaRPNMnrOSjti3A4O8OcWUInvfJxObroYsl3D5O32k9mNPOBtW8beDrGdDdDBrA5oQe5aSjclGs9CMQ1PPsH5VjymxEVDwQrPmoMU14cwzM9K8lW8ck05x1rzb0zPGF/KdXeJj5sKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721754290; c=relaxed/simple;
	bh=DdJT2BT/Q+H+OV+YMqJeHQbRQ4d/px1raPMIrf53wpI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=S4agG5dxFgcjHN+vkeLVQBWcf76LI/qStEzf/qZ4f1CNDwHGBW5Syg9SiJz0AvEu6PMMRQ1qFFRORFmgUjf436h+Sr8O7HVGLrI3TbOJLAxncNmgXmZZ98GuZjcos6KJXnGfLfoaXgXC/oIZbvZhR+X84883HBvhO9og247jgDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqdBRFv6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8B53C4AF0C;
	Tue, 23 Jul 2024 17:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721754289;
	bh=DdJT2BT/Q+H+OV+YMqJeHQbRQ4d/px1raPMIrf53wpI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=iqdBRFv6xeCkMBE2YFDXT4OWIAUQ27i84OLV/8si1A6hvDUXsyq674D7Cgtzl+ToH
	 INvqJxSMZzjdbkMDCWvDCFCRlTMpNFCSezpJ5FbIHiclNLUTs9iuTiMzQqdalOKSfC
	 lp8oyGDL0AJ8H0s+wIpPY3OH8vUGR3nn4R2gartJ5gC+xK/h68TpH1TMj3PhkaYm2v
	 0o/imVAn4Zpd3p4tLznNcK03C6sRyaofi0uAwtVk8+reYh1jovf03/F3q4jZ64yU52
	 lH7bvpibsWFWLqQycHGu0eQcClZQKqejzos1WIUmOZIfVdNC9DjTK27Hyq/tlNDrBk
	 LIzKzk4DCx7KQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C8B9DC43443;
	Tue, 23 Jul 2024 17:04:49 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <sk3tppb46bmrbk6x67lzrrqmuu45jhfxlb7tazol36av7i6ozr@pdmyqxobq3yj>
References: <sk3tppb46bmrbk6x67lzrrqmuu45jhfxlb7tazol36av7i6ozr@pdmyqxobq3yj>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <sk3tppb46bmrbk6x67lzrrqmuu45jhfxlb7tazol36av7i6ozr@pdmyqxobq3yj>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.11
X-PR-Tracked-Commit-Id: be6299c6e55e971ffc060495708740a59aa0e45b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fd71b9a07b6327bed6ef9d572b9cede98c868baf
Message-Id: <172175428981.5236.18211319172091514242.pr-tracker-bot@kernel.org>
Date: Tue, 23 Jul 2024 17:04:49 +0000
To: Sebastian Reichel <sre@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 22 Jul 2024 23:10:23 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fd71b9a07b6327bed6ef9d572b9cede98c868baf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

