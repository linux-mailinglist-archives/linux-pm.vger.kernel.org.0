Return-Path: <linux-pm+bounces-25498-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F894A8A9CD
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 23:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 108FD3BE6D1
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 21:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD6F258CCE;
	Tue, 15 Apr 2025 21:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQy49/wI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0860E257AD1
	for <linux-pm@vger.kernel.org>; Tue, 15 Apr 2025 21:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744751097; cv=none; b=epFXXuHH2QfXlbzcrZAOiebhSSCkknd1NW0z3rNVb5SGz08qbwBEzYbKkRmuiZ1UYFDzYOBFmqr2A9KxzMN9/B++EITXbZOkh/yOB2aOcWE6rGh7msucbw/v2p37q+hPk31FiUiohTHYR0CbtSoVtEbBzPCGOA1sOwaW7JggT7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744751097; c=relaxed/simple;
	bh=2aYDfQixhcY+GELp+sRY6Ci4naefYsk4U0BlfJkdhWQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ikcGMpS+i825mRwId3LLmOjhAvYAat3KK+2BKJ0yr/8sh8Nu8rEPTyhnRW8dd94Xa9hYDGsQak7mJqEZdMvMuOWmT/4U9TddJKHsXGiqYR7zF3KsTXTDH6V6nSbwRSji3V5Q9Cim+0b8vQN/fhPtGYio/BaP0s7n2QoQLCHejuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQy49/wI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE2A5C4CEE7;
	Tue, 15 Apr 2025 21:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744751096;
	bh=2aYDfQixhcY+GELp+sRY6Ci4naefYsk4U0BlfJkdhWQ=;
	h=Date:To:Cc:From:Subject:From;
	b=qQy49/wIg/GY01zoPruyowLxw8mCRXDQN1cZupDSd5PYW2FsZxniwiwqYM+V+w0SQ
	 yBIvzY10gf8gUqi/8x/qrlSMPoQQwAzye76LkOhIvIXb3WHAQW16KEgOCM+rBaPnTR
	 3DxKJJRtTZTg3LU1JO4eJN4dm1thpfyYeIVNXOSubYUUIfajhZ2lWNippAgb36UDx0
	 Ruf8zCSZNfrLnMSbIT/JNoPMIfBqo+rY9JrkEj3lBxMEbkdwlgcvdaixkrE0+Oqc5b
	 WXvYCEmgz3KWCvhAHQGbLICZ9WC6ed5eirpWpOPbkdrctF7v8DZeKM6jiLdwIC5ZuZ
	 UU0nMmBPR4lyg==
Message-ID: <57a8a0a9-170a-439d-80f6-3351f0416eb2@kernel.org>
Date: Tue, 15 Apr 2025 16:04:53 -0500
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
Subject: [GIT PULL] amd-pstate content for 6.15 (4/15/25)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

   Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git 
tags/amd-pstate-v6.15-2025-04-15

for you to fetch changes up to d87e4026d1b20e4f237b29e0c956ad415f533de2:

   cpufreq/amd-pstate: Enable ITMT support after initializing core 
rankings (2025-04-11 12:49:57 -0500)

----------------------------------------------------------------
amd-pstate content for 6.15 (4/15/25)

Add a fix for X3D processors where depending upon what BIOS was
set initially rankings might be set improperly.

Add a fix for changing min/max limits while on the performance
governor.

----------------------------------------------------------------
Dhananjay Ugwekar (1):
       cpufreq/amd-pstate: Fix min_limit perf and freq updation for 
performance governor

K Prateek Nayak (1):
       cpufreq/amd-pstate: Enable ITMT support after initializing core 
rankings

  drivers/cpufreq/amd-pstate.c | 36 +++++++++++++++---------------------
  1 file changed, 15 insertions(+), 21 deletions(-)

