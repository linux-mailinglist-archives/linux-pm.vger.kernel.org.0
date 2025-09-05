Return-Path: <linux-pm+bounces-33897-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33202B44B45
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 03:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60FAA47E1A
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 01:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6881C7FBA1;
	Fri,  5 Sep 2025 01:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkOYLpZV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3859B10A1E
	for <linux-pm@vger.kernel.org>; Fri,  5 Sep 2025 01:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757036196; cv=none; b=jjfgXoqtAQHTZ2b/dRhJFLJ2eRsXydAaWsl/7n3oyzBnDEke0LZdsZBN9R7GnnL/miuaQPwYZttHddwCeP4Fy7tRLlNpcXggpUQceFWWqihTL7feq/Sner0x3P0nUIEswrRjBhwJuTGXmfDkI3ZM319RnnP0TA8EnfASQ6cO7XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757036196; c=relaxed/simple;
	bh=qjsNxRh3MEdU7ggZloJMOIvw9Xb/cSUcqGS6+ToHFwY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Qit1AlNVntXPOfWrLbRPS9yMKhkjEJOGNY75nHlmADS/jqZescYlGVK+OcvynTtKLb/Z6P6e35VuaoEG2BwSx1JGjDZqU9auUAR0+M+s6ruwGr4wj6qDErJQISztOWnvc8jl7X1INdII8fYaGKD/y5Qa6g+FEKukyNgRiEfo18Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkOYLpZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83558C4CEF0;
	Fri,  5 Sep 2025 01:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757036195;
	bh=qjsNxRh3MEdU7ggZloJMOIvw9Xb/cSUcqGS6+ToHFwY=;
	h=Date:To:Cc:From:Subject:From;
	b=nkOYLpZV2KrhYRh0DKzy1zvcufGK1owp1i5jAEQ+09/xrvYlZ8mpNQU1yRQ/7BMnz
	 3nhL+ZoNnY2Zc7aSUTKSf3XqC9Zic7xxA/MQmvsHRD9sN3u/k23l0JrzJh5oisf3EC
	 DMui1C/o292PzFeEYS25A+APqLu3UoDA9A+tLCasZaH+ejJ7w5ZiMYl/Nep8kVw4WU
	 /mswfwV0NglHO54LpCXJUjSxsIj10QL9r5hEEqHGPc71kK5PezEeWXZohP/YrQCItr
	 tuUwpvy5RXjEACS/2w4SIhJqY6bF83JDPbWHfyP8CKWoeR1ml0fORt2LjE3VKTVwk/
	 bsKVTzQAN+XiA==
Message-ID: <2ae3e51b-b6a1-49fe-8969-7cb60937215b@kernel.org>
Date: Thu, 4 Sep 2025 20:36:33 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
From: Mario Limonciello <superm1@kernel.org>
Subject: [GIT PULL] amd-pstate content for 6.17 (09/04/25)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

The following changes since commit c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9:

   Linux 6.17-rc2 (2025-08-17 15:22:10 -0700)

are available in the Git repository at:

ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git 
tags/amd-pstate-v6.17-2025-09-04

for you to fetch changes up to ba3319e5905710abe495b11a1aaf03ebb51d62e2:

   cpufreq/amd-pstate: Fix a regression leading to EPP 0 after resume 
(2025-09-03 09:17:34 -0500)

----------------------------------------------------------------
amd-pstate content for 6.17 (09/04/25)

Fixes for regressions found from refactor around
EPP handling at suspend/resume and minimum frequency
while using the performance governor.

----------------------------------------------------------------
Gautham R. Shenoy (1):
       cpufreq/amd-pstate: Fix setting of CPPC.min_perf in active mode 
for performance governor

Mario Limonciello (AMD) (1):
       cpufreq/amd-pstate: Fix a regression leading to EPP 0 after resume

  drivers/cpufreq/amd-pstate.c | 19 +++++++++++--------
  1 file changed, 11 insertions(+), 8 deletions(-)


