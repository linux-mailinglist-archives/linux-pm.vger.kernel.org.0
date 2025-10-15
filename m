Return-Path: <linux-pm+bounces-36184-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 844D0BDEBD6
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 15:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E76AB19C552C
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 13:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7191EB195;
	Wed, 15 Oct 2025 13:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9Naz3CK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E551DF75A
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 13:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760534682; cv=none; b=fq6LuVEDIE9Gj85Z5GPgnHnJydyNhR36ezGlJL+LNX+uShmpIjA0UdyGjgtGY5Ggnf23mdGjDgK7YqrOY2tGcZOg51ciHOy74RzYl3pEhY2fA+gD5937dG8LGfZBXGvw1bB5eGGrGyMCVUVAuehIAowxRWqtFfbH61vQAg4dp9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760534682; c=relaxed/simple;
	bh=YuoWXRCvsDAX2fg2yfutxwVyBMODdnOMG0lz8k93aRk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=CGDBF1vDuaQig7GBP7kB+5b5RMPfwO62RcSny2rtaqBiPKCFu9bWqYv2HseqdkG014jKOZn5qiWAHmNTEi3GRmodxFi4DB2epmQcjC9IabzfOaOfElV7yvR/bZKte6QSrLsToWldGYOz8VgQPnw/G7cRsdGhvBC55Ib5BP8AwGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9Naz3CK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9640C4CEF8;
	Wed, 15 Oct 2025 13:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760534682;
	bh=YuoWXRCvsDAX2fg2yfutxwVyBMODdnOMG0lz8k93aRk=;
	h=Date:To:Cc:From:Subject:From;
	b=Z9Naz3CKWYup4jrtVZffv2C3sZ1U2xHGRUU3MW77cfBGENa/fYywFPw7YMfHNMNB5
	 dNKfOS8tv/kLVZX/rXt+SK2yWh6uDN3v/+oIIOxu94ojluhovh3o8Ol5itn+3w1tTN
	 0TN97LrZVbkihWNBfa042A7bbJ4Zw53u2Q746uHIKuO8Uo4w4e8gEjpH+tyceF+C+1
	 rbg8oDddunnFvxDWJVtG1+Q+3sb/ktSizsJMlEoD6Wjn/hR07hx3UZdy15vBLrF3IX
	 RTIWkx76J6jrq69j6ryP2V+S/WSKQw+VAtMnYgLRJFRR0hoTHAfFU8DDaJA1hsz0uV
	 H10Cusz+weNoQ==
Message-ID: <84493df4-850d-42f6-8adc-b45ae743c5f3@kernel.org>
Date: Wed, 15 Oct 2025 08:24:41 -0500
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
Subject: [GIT PULL] amd-pstate 6.18 content 10/15/25
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

   Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git 
tags/amd-pstate-v6.18-2025-10-15

for you to fetch changes up to 85d7dda5a9f665ea579741ec873a8841f37e8943:

   cpufreq/amd-pstate: Fix a regression leading to EPP 0 after hibernate 
(2025-10-15 08:21:16 -0500)

----------------------------------------------------------------
amd-pstate 6.18 content 10/15/25

Fix for EPP value in wrong state after S4

----------------------------------------------------------------
Mario Limonciello (AMD) (1):
       cpufreq/amd-pstate: Fix a regression leading to EPP 0 after hibernate

  drivers/cpufreq/amd-pstate.c | 6 +++++-
  1 file changed, 5 insertions(+), 1 deletion(-)

