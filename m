Return-Path: <linux-pm+bounces-11490-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 275C993E0C5
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 22:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF92D1F21900
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 20:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6558939856;
	Sat, 27 Jul 2024 20:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ji4B/Cvm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E32138F91;
	Sat, 27 Jul 2024 20:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722110839; cv=none; b=hxbiWnl6M+4sdoKMfuuxu9epMIi4Jiu5M9Qp4QQZiA+bM82rDRGFDYAFCtE6+JcVHmk0Mge0JuYTfZnnpCnIC7JnQyOnrdpL24bjVdRrUwWs4LiAW7u+RsPkMMIzvA+Gw6s2V+LcQsK+ctU37/sr8JDqDbtCCpeJgJxdfadzi/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722110839; c=relaxed/simple;
	bh=V1fdxBWJU+SBQCXxpwIZw6+1ah9cH0StnTwjidYksPE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=uVDI5m84AP+sCDco4hkY2eCM4uuaJUrbvPY5sFY1orFyHbGOg8IQQWdVZsF5zzowhXcy5pdk9iVYS+WgeZJg74CcKlS3tHAVE2HbPLT92n2IIF3m4s4enILVnhdkrOG1k8ZRWOuiLNRlllkTvNlvTRWxz1oqf1jbP2fuHxQlUSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ji4B/Cvm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16CC4C4AF0F;
	Sat, 27 Jul 2024 20:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722110839;
	bh=V1fdxBWJU+SBQCXxpwIZw6+1ah9cH0StnTwjidYksPE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Ji4B/CvmzAR0GKhOXvTsXmRwO8TbYt6sEj+MXOyGGM45X0ds65Nk50ymdReg2KgF4
	 tggKnSftISmgL/+MeJ2AtxE6lWppqf6lXNqdrEVW85M2zQjtyTcBKKR9Sl4hva35Mx
	 9yN4lFujOVvKzs/ahbc/6/RQnSJLcTU0cZsVCRRoQosRY5oPwIaGfNYsAXUzesp9R8
	 bt7JxJqq+Gz09DnqOcFmOqMt2PK/qL577A0IkJ9xtNIeeJoPyFLkKaT8B2mG8zGA8u
	 2dm0fXb0QH5rRqdDoCc1a4qJ7EkGYtRx2l5awUBLoF9dFbDdJ0eQCHlxZLH3vSeM9v
	 CM3xjwRo5T85g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 06CE8C43601;
	Sat, 27 Jul 2024 20:07:19 +0000 (UTC)
Subject: Re: [GIT PULL] One more thermal control fix for v6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0j+Dvk43LpnPiLbVELAXCLBRJgKhOAvWzmOJC4QAcFY3A@mail.gmail.com>
References: <CAJZ5v0j+Dvk43LpnPiLbVELAXCLBRJgKhOAvWzmOJC4QAcFY3A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0j+Dvk43LpnPiLbVELAXCLBRJgKhOAvWzmOJC4QAcFY3A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.11-rc1-3
X-PR-Tracked-Commit-Id: f7c1b0e4ae47e67c6f9af84568a5f4a80638ccd8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1fcaa5db40f960e58f47050337db54eb087fb62a
Message-Id: <172211083902.16614.7848790602487438150.pr-tracker-bot@kernel.org>
Date: Sat, 27 Jul 2024 20:07:19 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Jul 2024 13:08:09 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.11-rc1-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1fcaa5db40f960e58f47050337db54eb087fb62a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

