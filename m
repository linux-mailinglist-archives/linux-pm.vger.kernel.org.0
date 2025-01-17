Return-Path: <linux-pm+bounces-20646-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3A3A15A21
	for <lists+linux-pm@lfdr.de>; Sat, 18 Jan 2025 00:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C99031884AF1
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 23:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF111DEFC4;
	Fri, 17 Jan 2025 23:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiDVQqUi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8561DED68;
	Fri, 17 Jan 2025 23:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737157516; cv=none; b=mY6l/P786mGZ/WvrblFRxlMrw1hjzg3Y5t6ORTcRyB06T2/nqvDYMXCakJu+IIdv4Z+joi+jR1tCSvCZBDRagMQ8W/35cOO8pfD8VFCivn/+9WLp3u2SRlg8Le0jmkB1tTczbnIJq0syL79rZgHSldd37k/B+SSbbDsabx+SMXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737157516; c=relaxed/simple;
	bh=E9IrZCNW5TNGtWQecUFDDhNAWcarWOpqvBph1gyQE58=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nwogPCEePVanEDJwQ0F20idB5Nfes+xK0mi6cqb3PMcRb4SABAG8c9ZEGABlrU2142M0URsCes9GbGLkGia06ySK5vHow08pDMIPx+ruZNkyVUtAkHZiWLzsWUw2l8bxHG24xtr85xrgDt4rc/M6drDtvG3gVtbRvFmLcmd21c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oiDVQqUi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB3FC4CEDD;
	Fri, 17 Jan 2025 23:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737157515;
	bh=E9IrZCNW5TNGtWQecUFDDhNAWcarWOpqvBph1gyQE58=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oiDVQqUiYilFo9xcKPBPyxOXsMAlrWkAvKDbzguH8buHQykPC5S8FO098aef6DLZ5
	 A91GXVeRzAX7V06jFBPL/dwIv301VuMTpNsnQYOOwcXa6acsWX0RZLDq4Ep0mPANoY
	 xfoPwWtjTZ/rH9OSvrt1fzhUSu37ZsMAjnANuxZM4dHEFlofkSJ+kllRYilw8ayUoI
	 H0MJpBnHtTw0prOPUad5WsUtR28iFEFg0lXh6MyD/gVYViYWmkg2OoMe7ZcFotrgPF
	 Fp4dpK9k8FF2j3q4+EuvT4LYqZRwft3IixHalbQXQvGItpE4+IfM9Ky5BkvWY9iSAw
	 g+7tH22vGwAYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C19380AA62;
	Fri, 17 Jan 2025 23:45:40 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain fixes for v6.13-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250117115020.131731-1-ulf.hansson@linaro.org>
References: <20250117115020.131731-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250117115020.131731-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.13-rc2-2
X-PR-Tracked-Commit-Id: 726efa92e02b460811e8bc6990dd742f03b645ea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b040f0abe6d19a14306d276a26a033f5087f2fa
Message-Id: <173715753899.2291664.4937301036934590099.pr-tracker-bot@kernel.org>
Date: Fri, 17 Jan 2025 23:45:38 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 17 Jan 2025 12:50:20 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.13-rc2-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b040f0abe6d19a14306d276a26a033f5087f2fa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

