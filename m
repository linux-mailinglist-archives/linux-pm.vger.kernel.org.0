Return-Path: <linux-pm+bounces-7976-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBD38C9613
	for <lists+linux-pm@lfdr.de>; Sun, 19 May 2024 21:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F351328116A
	for <lists+linux-pm@lfdr.de>; Sun, 19 May 2024 19:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19006F06B;
	Sun, 19 May 2024 19:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYIH4C9h"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968A86E61A;
	Sun, 19 May 2024 19:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716147417; cv=none; b=P+W60z/4QjuYafJB4+aKBuNIAMFeF/F0HcDtuYXplWTez1zoheYhwgOg77OH2iuri+6QEFVaLpyGPAGmRNQrKsFICrcgh5Lbl4dpnWyWFjMp8ruoMRKPZ7bp7awxhYecjlZgZQPWa4wT4pc55H/GVvRermPXu+qp+97TgXuM8xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716147417; c=relaxed/simple;
	bh=YEgeFgOE7zY5OBbYvBi1KKhLjKSOsdLUG+jQ+L5T8JM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hENhoSwY4+cQb7jiIZHbWSGEpSIvHbeNabW+VeIlPpoBtpoWdbRqdcpnPfxcsXJVW8yFAUI/UKMs1XhdRHDviwYbGKd8EYXXbYhyCQWT26XiS850z/gMAT9/j9t/YKXDhgZ8j5sf4qJDOeBEpjiFnhpJ4R+Mm5q5mp0i17NYYSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYIH4C9h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 777F0C4AF0F;
	Sun, 19 May 2024 19:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716147417;
	bh=YEgeFgOE7zY5OBbYvBi1KKhLjKSOsdLUG+jQ+L5T8JM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JYIH4C9hZXdxv9W554YKPwzDDtspYZb5DG2q651AqgKWXI2pldw24fsSQ2FklY9Iq
	 9U0WtyGDh7O+P7fjvbGQMBwPuRRQJjynx6xEEds7bIYzJe8Dd/qZiJs5Lm1DIjLEmw
	 YMnBqdyJ4hsAYgSuUi6lpzN9NzGE7UAuxxGVA6BXidR9EdkHWTJ/0osmNZlUYeMkEV
	 pAlDGbBCyAAjX460N1R+g0dgeGnRVVf/zOrehvWkVuvdg54hoEPtGeYtBht17vAXkt
	 NUFv9B87Wz+ZPtyrVUgdHL0QWZAoTNC4Hm7MEWAytbkyzm7QiNO/VEPf5oR2ovREKz
	 zciAcgi5XJjKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6EEBCC54BB2;
	Sun, 19 May 2024 19:36:57 +0000 (UTC)
Subject: Re: [GIT PULL] Turbostat 2024.05.10 for Linux-6.10-merge
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJvTdKmgOCBUX=O4VvuVZfnXVpZcm5vDU6DtAYykuhBH7+-7ow@mail.gmail.com>
References: <CAJvTdKmgOCBUX=O4VvuVZfnXVpZcm5vDU6DtAYykuhBH7+-7ow@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJvTdKmgOCBUX=O4VvuVZfnXVpZcm5vDU6DtAYykuhBH7+-7ow@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git tags/turbostat-for-Linux-6.10-merge-window
X-PR-Tracked-Commit-Id: 256d218ec6aea99855dc5c54af550fcff96fc732
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a90f1cd105c6c5c246f07ca371d873d35b78c7d9
Message-Id: <171614741745.6582.271007367077030497.pr-tracker-bot@kernel.org>
Date: Sun, 19 May 2024 19:36:57 +0000
To: Len Brown <lenb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 18 May 2024 11:56:57 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git tags/turbostat-for-Linux-6.10-merge-window

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a90f1cd105c6c5c246f07ca371d873d35b78c7d9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

