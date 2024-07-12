Return-Path: <linux-pm+bounces-11061-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 754889300BA
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 21:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 298691F23235
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 19:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAC020DC5;
	Fri, 12 Jul 2024 19:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cu0Y8vE1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D769208D1;
	Fri, 12 Jul 2024 19:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720811559; cv=none; b=cwcghaRRl51NBfe5SZqL8yxsYo8SiuH+mvOvUwM4u9RYIhI5I37TCEsp+BPZrF4uMXCUIN3okW2LVkgPRj+us1d6sHVjU40F9Rlk+aU3e/GeuOZ5QVjBxnlrb81z+dQUZSwwIgjTim6bw0EDVfj+2S1CsgxC1LKbA6ojlJJ0laQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720811559; c=relaxed/simple;
	bh=Qyma/5Xi60KYMm5aYtUxK3M3vz5z2tPN+RndzefWIjE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Tce+u+Z+PYPh7DFt7Pzl42iAZIXiM1H+cw4hJiKQ7xijxk6MlNU1okmt2Z2QcSljL448zJXW2jaM828yjCNmtjaSnvYkmRsVtlawTt41y5nQbIJJ8eJiwwkXwP+cegldCC9QvfEoiVg11rapjx2sphmIufkal/VGQWS2GIkgoc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cu0Y8vE1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95781C32782;
	Fri, 12 Jul 2024 19:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720811558;
	bh=Qyma/5Xi60KYMm5aYtUxK3M3vz5z2tPN+RndzefWIjE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cu0Y8vE1FcWK5DWFB1WRjjT+y2OsQzXGNwbLJjgEUgOx1XlvesblyNjvdQeLnnfp4
	 FNL2NdCOZziAeXtDoDBTtQpa1mwXexNGvgALrUb1K3YFGwZIbr5Akg8/WsxjpGTBxE
	 33rU2hDoHCgEK0+NKa/+F6prB9Oc5X4B7AWuGwL9f06joaprtCfHHUk4eyRL7Fei9Y
	 m/CrsuSZV6si4BBvctSpqC8mHAsw1s1xh/23njwkONjx+2iw2OHxuv5qA2GIzWPENz
	 EfBkMejJgDdz0dJAmhT+fqda74jC60Mj3UCBzNbrc43M5FDStagCxBQOqM9bCgr8pg
	 mc3EOsvKqcVag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 88395C43468;
	Fri, 12 Jul 2024 19:12:38 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain fixes for v6.10-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240712145131.169802-1-ulf.hansson@linaro.org>
References: <20240712145131.169802-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20240712145131.169802-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.10-rc2
X-PR-Tracked-Commit-Id: ddab91f4b2de5c5b46e312a90107d9353087d8ea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ac6a9e07a7b644d1cde22cc2d2d3d386f421a523
Message-Id: <172081155854.20584.10862324341166131957.pr-tracker-bot@kernel.org>
Date: Fri, 12 Jul 2024 19:12:38 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jul 2024 16:51:31 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.10-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ac6a9e07a7b644d1cde22cc2d2d3d386f421a523

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

