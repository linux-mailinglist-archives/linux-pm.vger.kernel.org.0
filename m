Return-Path: <linux-pm+bounces-26601-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7691AA7BDE
	for <lists+linux-pm@lfdr.de>; Sat,  3 May 2025 00:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EDE91B6703C
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 22:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB5F215F6C;
	Fri,  2 May 2025 22:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvdU3dHZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E773019DF41;
	Fri,  2 May 2025 22:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746223367; cv=none; b=F3n2JHhTBQcOAq2ce4579o4gwdaveOmSD4RvX3FX7WIRo6DFUhY3GKUdLY5wSfGYVopDKqTHQrHIT+orHgylEuZkhO4DS8bGgt0EDLk4zOW6qFRydGnPq2B7/88tlqfg5m++3B4VWOmpXcqBt/+sYeGwUuqbeTPm7qvrfEqUrYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746223367; c=relaxed/simple;
	bh=3gzrjXiwOUYG+iV6LAkIh7EjiTurgAJ5IKVNmI3yevE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=faHxlaegKHkLH5QFDG/tn4xfOdOBXB3ZFivqlUin7xUQDuSg8Xd4F9Dm5wCYW974Fy0BQ9e8Ybh5z/ALcDGnHfccmkqW257NLi7L5jOdChr1GGj6EzMeU05MvmJHS1cct1/j/a4jxNRzK+S2vt0DP6D+GTk50A3rFlwwulbx24Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qvdU3dHZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F12C4CEE4;
	Fri,  2 May 2025 22:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746223366;
	bh=3gzrjXiwOUYG+iV6LAkIh7EjiTurgAJ5IKVNmI3yevE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qvdU3dHZNIKhDIXA5maclU2FaWAJH5RDtKqU1VARcmDU3dyRT7svgZSFIT3azVX/V
	 odysHjK4jJMHrY7AatMEiMLlvyxDB5GC+TdS1QnntWCQ9/yWBFJlebcY0hPMLyXc1v
	 pxTbmrGWftAfpCXLGdPZRFtAo2/3SvtZ/NfpES1S8cW9fyLFiH4rSQFbAaZpvv69J8
	 116Znngyqlhap0Gi+JIAdaE886EUD55l+i4uexksEd32ag/kw6EqopfJY4akwJ9zcD
	 XH6He0/DSBXnH6+jCEJAwASVVQxtQES5KGDqOaMUqUqN7Wvgh8yMf2jMHVrtxsvsx2
	 7a9veodjgVOlw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CA8380DBE9;
	Fri,  2 May 2025 22:03:27 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v6.15-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hWHUokQz-cU=W7+wY4-ZRWKnz4PvUSk17vsDoPb9oqXQ@mail.gmail.com>
References: <CAJZ5v0hWHUokQz-cU=W7+wY4-ZRWKnz4PvUSk17vsDoPb9oqXQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hWHUokQz-cU=W7+wY4-ZRWKnz4PvUSk17vsDoPb9oqXQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.15-rc5
X-PR-Tracked-Commit-Id: 23203ed263f0701368468952d5004e320e5af6db
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b6a218ff8b88d09f86a17167772e7aaff1724e54
Message-Id: <174622340593.3739591.333055363625407675.pr-tracker-bot@kernel.org>
Date: Fri, 02 May 2025 22:03:25 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Bard Liao <yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 2 May 2025 22:24:27 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.15-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b6a218ff8b88d09f86a17167772e7aaff1724e54

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

