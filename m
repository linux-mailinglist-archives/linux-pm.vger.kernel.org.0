Return-Path: <linux-pm+bounces-26905-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6CBAB0552
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 23:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66B839E7304
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 21:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1246B221260;
	Thu,  8 May 2025 21:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjzvKKU/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEFE220F55
	for <linux-pm@vger.kernel.org>; Thu,  8 May 2025 21:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746739404; cv=none; b=akosBbj+mfEAVhG9ptIibYTe/xamE/ziSX2vJNxDfig0+5LlYwGbJMPzKLATtcTpySgVZVksBkjopNMcvxnNoR2VyEP21mBbsXRdvTMWBWDftgfUikx+x+L8NukXEULLm+/6FQRuJeWoNM8ZE2lcpf4TUFsOU4jgq0NaN89zT/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746739404; c=relaxed/simple;
	bh=y2FiVyK6gqiua8RgprU8srqoXGUsEh+JuvVGP3JuWwo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=VZkmQEIXd/Gxr8bYSS4lfEWbZQ8HASZfVoVwcv/LlpvF/yaoxRj9HVHvT2tRkHcsOYakSALzFitbgGHqz7YlsqGRkEflogV9C35ANmSNg9iKVXLI+Z5AnDMr07GCZEPbDrldpZJPR0pPjTqRzI1BilhKofYH4a4dzz65f+SLKuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjzvKKU/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32799C4CEE7;
	Thu,  8 May 2025 21:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746739403;
	bh=y2FiVyK6gqiua8RgprU8srqoXGUsEh+JuvVGP3JuWwo=;
	h=Date:To:Cc:From:Subject:From;
	b=OjzvKKU/g+xLAJr1QxSq+1MOkxXCbGwh96Hthe3d1/lz62QyAJFhPmdcFwUJu7cyQ
	 Bu0TjEdZko8vTvyGBQ+IJmUI0NxCjXQhF9UeRJ2MtOlBAAXDW83R8ANH5sH+VRRcFt
	 Cqq4eygXe2n/ofTqSwqceDxBtD+jwuDUr06/XxgsjmUPL4qH0ctomKjWTZMP+fOpPk
	 Sqy4bRJsRFzgxUWJLvRe/OdTo5Fyt/Hqa8wfiUwMK6wiscJSaD2mvuVHkyCid/LKYx
	 TR7I+Q/dxIL8TiAOoBmbcTGiNo0TNFa1tzVtSAPZ5I3ZcnfKxjthWhnxy2UjPy33wM
	 YRtCdZGKF5gfQ==
Message-ID: <5524b46b-88c4-46f6-ab12-96c6a10d84dc@kernel.org>
Date: Thu, 8 May 2025 16:23:22 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
From: Mario Limonciello <superm1@kernel.org>
Subject: [GIT PULL] amd-pstate content for 6.16 (5/8/25)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The following changes since commit 9c32cda43eb78f78c73aee4aa344b777714e259b:

   Linux 6.15-rc3 (2025-04-20 13:43:47 -0700)

are available in the Git repository at:

  
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git 
tags/amd-pstate-v6.16-2025-05-08

for you to fetch changes up to d26d16438bc5fd5524121244cc133f9872a63210:

   amd-pstate-ut: Reset amd-pstate driver mode after running selftests 
(2025-05-05 12:07:42 -0500)

----------------------------------------------------------------
amd-pstate content for 6.16 (5/8/25)

Add support for a new feature on some BIOS that allows setting
"lowest CPU minimum frequency".

Fix the amd-pstate-ut unit tests to restore system settings when done.

----------------------------------------------------------------
Dhananjay Ugwekar (3):
       cpufreq/amd-pstate: Move max_perf limiting in amd_pstate_update
       cpufreq/amd-pstate: Add offline, online and suspend callbacks for 
amd_pstate_driver
       cpufreq/amd-pstate: Add support for the "Requested CPU Min 
frequency" BIOS option

Swapnil Sapkal (1):
       amd-pstate-ut: Reset amd-pstate driver mode after running selftests

  drivers/cpufreq/amd-pstate-ut.c |  19 ++++++++++++-------
  drivers/cpufreq/amd-pstate.c    | 113 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------
  drivers/cpufreq/amd-pstate.h    |   3 +++
  3 files changed, 103 insertions(+), 32 deletions(-)

