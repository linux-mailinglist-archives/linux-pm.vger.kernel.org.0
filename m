Return-Path: <linux-pm+bounces-18304-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2379DF46D
	for <lists+linux-pm@lfdr.de>; Sun,  1 Dec 2024 03:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B32E0280551
	for <lists+linux-pm@lfdr.de>; Sun,  1 Dec 2024 02:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE3D18654;
	Sun,  1 Dec 2024 02:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4VTyhXb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76EA182D2;
	Sun,  1 Dec 2024 02:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733020894; cv=none; b=kHcr147ppxX4EuPPsvPpbU6XU0tfc14u04cuwk9BFjnc6c2Shitnl5mgzNwq+wyGoVx2OuwZTguQ4Q0gHEoxCU2jSoAkFH3dWtthQTKVVk6PH77KziVRRsNro5/HhVo6h4qYOUbt3brOGbORRozV9Wl9mhG7UvaWysD1SU11y3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733020894; c=relaxed/simple;
	bh=wbHzn+JtLEweMYmJIjC3bprmkfkOLI+TFhLalueOekQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=L0hROrTnkxI3sDJkQKPyfRpc0dNyQFtOjE/XPgtX8qUqM7c/iUYcC0yEJsL8fr7VkcgunjN/+kpz5JC4wB5Vh4zxG/xqVYmZyUy2WGeXqz5m4+LbUQCYUHU7LqMFF7lPdn0qcFLnhfd+PNGp+0EkcP04ym6OTh2o4gLfmaTB93k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4VTyhXb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B60D5C4CECC;
	Sun,  1 Dec 2024 02:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733020894;
	bh=wbHzn+JtLEweMYmJIjC3bprmkfkOLI+TFhLalueOekQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=S4VTyhXbfYY5SxvznKjX3C75l1q9m+8XrxZ9LKAo2iokXdud5rHG6uM0kbHZSMLmH
	 plRMqTtK8dO0+EMPpJ4wt3Jjwzb1ZSSgE2oXSOmHHgGUETDmr/IH9R+gE+g2VAy/eJ
	 5GBb7YT43pFZHJj3YTKo6PlcuJ8+47tkVzszkEZbgy965x5f8I8zOPpFX50zr89xN7
	 rap8KDlKBtufUgIEf/oSFPHw7V+e2jLfyp3H+SBRKvG8x+2DQYqRXtwhtHBcC90lVL
	 dBDEa2fhb+C8rSnt+gNk/yjcl7Bc/m8yvPPCLWfBp3POmwxQ8boUmeCiPvwmvjmq+6
	 DoUb4b40TakLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEA3E380A944;
	Sun,  1 Dec 2024 02:41:49 +0000 (UTC)
Subject: Re: [GIT PULL] turbostat 2024.11.30 for Linux 6.13-merge
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJvTdKmFGmc2EDJHVRUg8rz9Z7zRw2sruB2rofJuf_aVk9HPOg@mail.gmail.com>
References: <CAJvTdKmFGmc2EDJHVRUg8rz9Z7zRw2sruB2rofJuf_aVk9HPOg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJvTdKmFGmc2EDJHVRUg8rz9Z7zRw2sruB2rofJuf_aVk9HPOg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git tags/turbostat-2024.11.30
X-PR-Tracked-Commit-Id: 86d237734091201d2ab2c1d2e1063893621c770f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bcc8eda6d34934d80b96adb8dc4ff5dfc632a53a
Message-Id: <173302090816.2541785.2514532496190182538.pr-tracker-bot@kernel.org>
Date: Sun, 01 Dec 2024 02:41:48 +0000
To: Len Brown <lenb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 30 Nov 2024 17:00:51 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git tags/turbostat-2024.11.30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bcc8eda6d34934d80b96adb8dc4ff5dfc632a53a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

