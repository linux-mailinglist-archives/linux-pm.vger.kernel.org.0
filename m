Return-Path: <linux-pm+bounces-18716-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 464AE9E79BD
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 21:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 076B5287EDF
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 20:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A7620458A;
	Fri,  6 Dec 2024 20:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDqE0swt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B73204582;
	Fri,  6 Dec 2024 20:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733515418; cv=none; b=ojaesHW7MMpHO3rLj0xtEToEVMbBDT6b41TBdHsV0Qcv+KGNPwOm3r0ngPG8PRHqzgGtBylIzpwNof04t/dtwzcY8aUZE1I8KZkHZVgPkGroPPEwDExCnq5/3kujwykiXVmVYDgj3QgDli86Lnywx3ayIiT9lsDRDizWpFwB7kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733515418; c=relaxed/simple;
	bh=r7ptKlFmA2ZVJjWRFUORfxleHTv707uFZT8qK+s5Xd0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Z+VzD/R2fh3oD5a+FrIldG7rHMr8dfBEyJnqeq+xCLfKH5GZ6yl6WW08xIj7+w5INBZklWwWcUGgK8KxYMMVcchOIkn175sc3V8C6D57BSt0JCBOKzPkve2CjXJcDtdX1qI2K14g2jGb2gd5Ez5HFR2TWslASxF6N/dmxCjUdto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDqE0swt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FB7C4CED1;
	Fri,  6 Dec 2024 20:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733515417;
	bh=r7ptKlFmA2ZVJjWRFUORfxleHTv707uFZT8qK+s5Xd0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CDqE0swtsh0x3JDKGSbqsK3LQEEoU6tAXTCb8DwzA+wApk1WPZyIsouIqoR7X8EIz
	 6D789QCW/1khOg8T2E4qMxTH2eI0ho8IvF80oYTX1eukrlAV/wUTeq3Razs3GvI3cy
	 MkYuSEeiAmdxs+ASOAKXyKtgxaTurB0STKhw33pITr+EGEt55GSdi+CUt+Lr0sjvvW
	 GnmIvz88IVz0GARB6OSRAnXnfA+7SzAyjn9G0eUUnjhJFhAbTtunVXU6Rpnz6zLStt
	 iGlVG06iXC0fQ4hiMyt1Ymjc0ab9zKWspMDleHqIFrSBlxstjfqrkAjv1RKXQJoICi
	 q0UCqWUEY0qjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB135380A95C;
	Fri,  6 Dec 2024 20:03:53 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain fixes for v6.13-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241206084031.119041-1-ulf.hansson@linaro.org>
References: <20241206084031.119041-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241206084031.119041-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.13-rc1
X-PR-Tracked-Commit-Id: 2379fb937de5333991c567eefd7d11b98977d059
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fa4c221fa153211d80acaf54fe5e5b1859c99796
Message-Id: <173351543257.2778953.46327491607829835.pr-tracker-bot@kernel.org>
Date: Fri, 06 Dec 2024 20:03:52 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  6 Dec 2024 09:40:31 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fa4c221fa153211d80acaf54fe5e5b1859c99796

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

