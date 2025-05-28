Return-Path: <linux-pm+bounces-27708-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A11AC5E36
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 02:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63BB54C0C07
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 00:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B45F78F54;
	Wed, 28 May 2025 00:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mvt8V/XS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14742433A6;
	Wed, 28 May 2025 00:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748392148; cv=none; b=T08LCrzd2YCkBxDMkbgQcxDMMtaMOT49CvuqSPfXKmqEUPF3IBu4HEk87Pe5HE5e+d+q4BT9SDmA5Z1g5fibiuU7SE1FAgznzV7soYmL7djV1ghW1vabOekMS7tZiFXFhHkm/6DDaAUvfPNytz8xQ4CMBgmlu5tBHHQvx1hal1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748392148; c=relaxed/simple;
	bh=E0bPhgFZCMLFbSxypsa1RlNtcOqOpu3ifA2g26DwHNE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=sfrBTQuchdoItNCJBg2a5ckEhlg1SyLMeTPDN5JAXnbvRuaYTWJyGhG+2X3i49wRpsP7ES3QNZnA3LlyLST5ifKMdnfH9E5qM3JPxBPyQi2E4AmFPcpyd4XlZrWB90x7DeRY9WCSD8VnjVBDqmhNIGsbssvCfoV+bYDSV1P0RR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mvt8V/XS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87305C4CEED;
	Wed, 28 May 2025 00:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748392147;
	bh=E0bPhgFZCMLFbSxypsa1RlNtcOqOpu3ifA2g26DwHNE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Mvt8V/XSgOndO9JRXaat6YHE1t041IA5oMiHE63hpIoa4HsXn1/y4iq0b3Pe56mIy
	 lO2iUWG3j+2qOcsa7MgW8VWyi+zqbyDlWQ9popP4I4IoXFhTv1LJ1leKxMGueGsACH
	 3ohC8dYPNzX2D7nNWGZdAf8GsnniLBrrqNBOXM7oi7ssQKITdxkNraZDJM+UDRANP8
	 n9ME5QnqRBmmQv9moKmwXLsZdC0/T2v2Jo1K2pgbjzw51TtwwkcpBVF42zi9R9ig9+
	 ilSrNhgmY28dHR0G2dEhgaeVWnp3vsFe3lgWJg6Bkt6JceINQ/OeuTe9JnmzPThSrY
	 RvQ39MYOzLlGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB01D380AAE2;
	Wed, 28 May 2025 00:29:42 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain/cpuidle-psci updates for v6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250527104856.206797-1-ulf.hansson@linaro.org>
References: <20250527104856.206797-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20250527104856.206797-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.16
X-PR-Tracked-Commit-Id: 36795548dcc841c73f03793ed6cf741a88130922
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 418da6ee1ea62090f6b66d95b8fcf7db2f42c00f
Message-Id: <174839218144.1837144.13413788928509105361.pr-tracker-bot@kernel.org>
Date: Wed, 28 May 2025 00:29:41 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 27 May 2025 12:48:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/418da6ee1ea62090f6b66d95b8fcf7db2f42c00f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

