Return-Path: <linux-pm+bounces-35649-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC8CBB18F1
	for <lists+linux-pm@lfdr.de>; Wed, 01 Oct 2025 21:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65EC04C34FD
	for <lists+linux-pm@lfdr.de>; Wed,  1 Oct 2025 19:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE967283FDA;
	Wed,  1 Oct 2025 19:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G46p9OW8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D69213E89;
	Wed,  1 Oct 2025 19:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759345457; cv=none; b=NsKNbOE1vg3/iojg/XjkwzBWAe1nOJpbIAn9IuOCFjmCZd1TrztJToxjE4Kno8BzPA7QSZqy6OsBZexaWeriNfZ/IfXoNZz5fJk7DeLJ2KaBmsuMi9pjnocZdrtw32F9kz0n9JnBWRNKj4Rwtdz5MxvaNkyk2n4NLDQuqqMFSos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759345457; c=relaxed/simple;
	bh=ZzWQQ23t+Oh41+lJWDrZci6bgWU9+Kedo327I1QB3Q8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SK9mDPTT+O2oJyoNyGYnJ7h0o1m2OVonxDkveIk7Ln+6uFmbuK4BbWy35RVCtih18T7WOAVYHB6V6QaPB+s4BC0DMOiiWiN5uBxZyzp3sxQq1hkpCmherjg0/lqZkaHx9lpofAAEWftD9R789N8TpGXbNDoAQKqqS1QYNGxgv+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G46p9OW8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7937EC4CEF1;
	Wed,  1 Oct 2025 19:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759345457;
	bh=ZzWQQ23t+Oh41+lJWDrZci6bgWU9+Kedo327I1QB3Q8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=G46p9OW8VhysssJ+WxIWQOwC7YG1ifdirgLwDhZOnmOnRfL/yQoaBj3jdvsWqGkZF
	 Af7Il9wSSPhtriGMYI67wE2zN66THvbAo2eIj3FZ8iV/6qxTmnRdq4I5v0qssVgMYF
	 XzUAT0cGoZe9PMm9DBG5JaLrtr/o4lCIFjBfHE4W+QJqxPFrf2uG4+z3Le76pdWqZu
	 tOWv3dhiOmatk/MX7bdxvn5CyXNzT7x1LgHdtCPXAkIF/qYrJmihPlN6oh/+mTLeg5
	 Js0gKFBrRTunwLO9Pe2i1wslJFPdmaZ7HGE70ZsyEGPneZbfWXIyTT9KPMwrK6wg5v
	 TX0bLdbFBQ0Vg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3356839D0C3F;
	Wed,  1 Oct 2025 19:04:11 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain updates for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250929114655.226466-1-ulf.hansson@linaro.org>
References: <20250929114655.226466-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250929114655.226466-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.18
X-PR-Tracked-Commit-Id: bbc3110823eca23b066e75a920bdc8118adda0d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e93bcbaa71f47bcee4972ae3b2ddb5964238bb96
Message-Id: <175934544970.2583066.11245987367020611745.pr-tracker-bot@kernel.org>
Date: Wed, 01 Oct 2025 19:04:09 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 29 Sep 2025 13:46:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e93bcbaa71f47bcee4972ae3b2ddb5964238bb96

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

