Return-Path: <linux-pm+bounces-24504-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2BFA70FC1
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 05:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1282D19A0C7E
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 04:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF171885B4;
	Wed, 26 Mar 2025 03:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awi9WUYj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0765318787A;
	Wed, 26 Mar 2025 03:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742961568; cv=none; b=WK5gTATaxHKAZt2w4MLvo/pBg2+Hc2nwiY7vGcUIa+8AgcipntfbZcVlVbaAAMX8sY5IsmIjQU2Y1KVZ9/iVLpUcCZjQXf8QxDdT1qWgYTlClFnNOVgB7ADn4Nqyz2V/rKUnruAXoJVi7BERsyXEbDGhgSo7LRAnKjNhfAhZjoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742961568; c=relaxed/simple;
	bh=/Hb2X44wCGlpqWtNyNnpAgAmYAQM4rIbH22zKTGwyUU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UX6uSztyibi0SiAMC7A075E+wLx1aAh/jE3/4j78IQTXzOWbRKYoqinFDZ1zMkmvKicTkN8/lQm9vqyBy4HXEK5/8eCYdxAkA168Ty/lCTP42rqoPSZhm6WupdaXASTD/mQXwd7YME14wtC6txULSh92ad5qiCgRppd+Fd5ju5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awi9WUYj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF8FC4CEE2;
	Wed, 26 Mar 2025 03:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742961567;
	bh=/Hb2X44wCGlpqWtNyNnpAgAmYAQM4rIbH22zKTGwyUU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=awi9WUYj7LbgW9dv14eLJTfP71YHNErrgaEqNXQS8z6naZY4Z7UkbehhcW+/7DCsR
	 j/s7Z6+AB1k6Ddpkx3beluyTd5x/jAUpDeRYWLwK3co6AwegYZt8I+Iq25bqgLi6W/
	 Q8caYl9Oa6Uk4ud7F+J4J9QD4O9lJisWv0pvnnLz/B6AipmUInw9PpZm/GMvd9ePKW
	 7urBJWNCejZMQ20R6IDOCks+CJwX08b5/AY52Ft+QP1hbi4X0Qh3Y6R60znsKsai0G
	 cXWE2USWAO6/6h5PqvWTWlOOPzgOqoWLQyh9A1/ozWc1zemEmo6d+H8a5SjDgIQSFV
	 HRWSuu6H3K0fg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E16380DBFD;
	Wed, 26 Mar 2025 04:00:05 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain/cpuidle-psci updates for v6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250325121455.36031-1-ulf.hansson@linaro.org>
References: <20250325121455.36031-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250325121455.36031-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.15
X-PR-Tracked-Commit-Id: 51f0b8911ec4355cea07b180f6569cc52f65aaa8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2a2274e90a76c24a03287e386f1ad128a8cc3b67
Message-Id: <174296160392.837738.15080100171525024181.pr-tracker-bot@kernel.org>
Date: Wed, 26 Mar 2025 04:00:03 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 25 Mar 2025 13:14:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2a2274e90a76c24a03287e386f1ad128a8cc3b67

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

