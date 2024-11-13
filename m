Return-Path: <linux-pm+bounces-17522-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF589C7DB1
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 22:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9754284FCD
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 21:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB6E18A6B6;
	Wed, 13 Nov 2024 21:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPWbV6k+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1D42309AC;
	Wed, 13 Nov 2024 21:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731533756; cv=none; b=ELql04ZdZFYh6rcW2QXUWmeWp0aWVXTBtIqFwXqDBjuQsBQ+MpJRXVuxygQMwJ9COzDo3opFbprNpsrHHTqj4/HkXxpbAwMPGtwcX55eZ1zGLIXkCjxNknZqa2CX+R3FmRlS3diPwsASeF6SF+7sOfBdI76+fIDt5KK5Wc/TssA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731533756; c=relaxed/simple;
	bh=5VMVIYVVcZHADAMlIA9JloTAFjHYzSKtyaglRHlqhkY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gyT9zhvDolDKRuFo24ataCC91fbqR2pb7UwcCeIMQ8BqrSdUbvvuAovlZdNCVW6GUGVA13bz35NYttJR8zL9qf99rtegiEZ98h781NJgBcvzKQ2UMQ3FIqk19KcShAkfVC0tOrSJm4W6GZjEI/9Y5FI39XnCrmfZkCo1EcnykZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPWbV6k+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87ADC4CEC3;
	Wed, 13 Nov 2024 21:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731533755;
	bh=5VMVIYVVcZHADAMlIA9JloTAFjHYzSKtyaglRHlqhkY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FPWbV6k+fdN2apaVtbXlVLxsNjiaPuc4vDNxJAyVTYbgWMbIJwF24U+gRzpj08Rli
	 sO0fge94CyHM7SoO52nEtE6hZpQTqM0Ph6B2Regr2TpymANKTiat4J2on/rduWmuS3
	 fvMdyh79DzfN8q1/mmwUOw66EUPpfsk7Mf2zrCh+aOQFZfZiF9kXWbD3OuyT4qe/Qw
	 2HDBb3kCRKTNCnuT/pm8xLKUHlvR4EeYp8cb/5Dn/GMf8iSEEUt+oH26ULHB9FxZ1n
	 cJcM0UDiWr8kBNJuzjPSq9n1vcOD/kYKYMucxz+4S9yARmbj4BlTUbomx9KzxYw6in
	 2cFRwkUczRyXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 718F73809A80;
	Wed, 13 Nov 2024 21:36:07 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fix for v6.12 (final)
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jF0bGP5Pb4s6gSiEmoUBNDqBLJMCpgNPmyQRxuO18C1g@mail.gmail.com>
References: <CAJZ5v0jF0bGP5Pb4s6gSiEmoUBNDqBLJMCpgNPmyQRxuO18C1g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jF0bGP5Pb4s6gSiEmoUBNDqBLJMCpgNPmyQRxuO18C1g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.12-rc8
X-PR-Tracked-Commit-Id: 1a1030d10a6335bb5e6cdb24fc9388d3d9bcc1ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0a9b9d17f3a781dea03baca01c835deaa07f7cc3
Message-Id: <173153376592.1393977.17487958971225413758.pr-tracker-bot@kernel.org>
Date: Wed, 13 Nov 2024 21:36:05 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 13 Nov 2024 21:14:02 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.12-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0a9b9d17f3a781dea03baca01c835deaa07f7cc3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

