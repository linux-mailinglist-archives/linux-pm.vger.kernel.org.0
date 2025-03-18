Return-Path: <linux-pm+bounces-24260-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A70F6A67CD0
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 20:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B3AD883D46
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 19:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0D7211710;
	Tue, 18 Mar 2025 19:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXO4j6NJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9616C207E0B;
	Tue, 18 Mar 2025 19:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742324892; cv=none; b=iIXe7KL+MXkVOn1sSj5x6k+bxjAoc9Krayy5JgUR+2IYJ8aLNJeYN7oDAiDbjo/A149ZaThLxRBL8ZN7En6lqLoDOJki484H6HSCzOhHW+3qkzF1fdRF5RKvGM6ZXYm29MCweVSW8ajt1AOzGqJvwiY2ylE4cDDd1mLCYT+sIk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742324892; c=relaxed/simple;
	bh=zmCOsIsvqLsx8VBzBWEd/PA9y+XA7jvel8W1/F9OkEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zkive3hyfNoqTpmgEnfflmMg2fSBqrQF90T/OLaAlfR7OUlTHscxaACXZjYlQI1A7U+sL/7h2JzkxiHBMz6enmPNV8RjfwgTDCg83QGZkoiVZIkLVc+IzEAtdCLuHZq7wtE5byDJ4xGNLif2Lv1wHU7AqoDXpSViNQD5t+uE8M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXO4j6NJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748F8C4CEDD;
	Tue, 18 Mar 2025 19:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742324892;
	bh=zmCOsIsvqLsx8VBzBWEd/PA9y+XA7jvel8W1/F9OkEs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JXO4j6NJMFlUigtn4wguGWB0tOhS5UONyratg3MiTNbPbwc6Cp9NDBtcd4G8xssQx
	 /6N8qj+XxtICOuZXQfjp2r0dG+eqNQFn2Utwsgm9WJ7X6A90KiWecwGcoqsmeZYvR2
	 SJ2/bWqH1brvBS/tECz2uoYnW4LvgS63lgI34mqyuTJZgp/+kTYsp5WWMsTNDvwEa4
	 cWlXZpKofyKep9prg/EEOPHiggijHFzG4HOjrTaUBnTLzh718m7MlHTg+ufHOzTy0a
	 ne6HAn0H01qWk7kNKX62IdAxfRI0BS1OP2tOeml/B7boAEh/P0SoOartiel8a7UZx6
	 l98/xzNSJvEbg==
Message-ID: <87d34e74-46e3-45c3-8f17-baf2feb50506@kernel.org>
Date: Tue, 18 Mar 2025 14:08:10 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] cpufreq/amd-pstate: Add dynamic energy performance
 preference
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250304152327.1561017-1-superm1@kernel.org>
 <20250304152327.1561017-2-superm1@kernel.org>
 <182723d8-73b2-45b8-bd86-9ffdbee7130c@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <182723d8-73b2-45b8-bd86-9ffdbee7130c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/11/2025 01:34, Dhananjay Ugwekar wrote:
> On 3/4/2025 8:53 PM, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> Dynamic energy performance preference will change the EPP profile
>> based on whether the machine is running on AC or DC power.
>>
>> A notification chain from the power supply core is used to adjust
>> EPP values on plug in or plug out events.
>>
>> For non-server systems:
>>      * the default EPP for AC mode is `performance`.
>>      * the default EPP for DC mode is `balance_performance`.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v1->v2:
>>   * Change defaults to performance (AC) and balance_performance (DC)
>>   * Default Kconfig to disabled for now
>>   * Rebase on latest branch
>> ---
>>   Documentation/admin-guide/pm/amd-pstate.rst |  18 ++-
>>   drivers/cpufreq/Kconfig.x86                 |  12 ++
>>   drivers/cpufreq/amd-pstate.c                | 129 ++++++++++++++++++--
>>   drivers/cpufreq/amd-pstate.h                |   5 +-
>>   4 files changed, 155 insertions(+), 9 deletions(-)
>>
> [Snip]
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index e98ef41083ba1..f00fb4ba9f26e 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -36,6 +36,7 @@
>>   #include <linux/io.h>
>>   #include <linux/delay.h>
>>   #include <linux/uaccess.h>
>> +#include <linux/power_supply.h>
>>   #include <linux/static_call.h>
>>   #include <linux/topology.h>
>>   
>> @@ -86,6 +87,7 @@ static struct cpufreq_driver amd_pstate_driver;
>>   static struct cpufreq_driver amd_pstate_epp_driver;
>>   static int cppc_state = AMD_PSTATE_UNDEFINED;
>>   static bool amd_pstate_prefcore = true;
>> +static bool dynamic_epp = CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP;
> 
> Is there an #ifdef needed here? I see build error when X86_AMD_PSTATE_DYNAMIC_EPP is not set in config
> 

Ah yeah, I see the same too when I check that config.  Not sure why 
build robot didn't catch this.

Will add this for next version.

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index dcf6e36d693f8..824756ac0010e 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -87,7 +87,11 @@ static struct cpufreq_driver amd_pstate_driver;
  static struct cpufreq_driver amd_pstate_epp_driver;
  static int cppc_state = AMD_PSTATE_UNDEFINED;
  static bool amd_pstate_prefcore = true;
+#ifdef CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP
  static bool dynamic_epp = CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP;
+#else
+static bool dynamic_epp = false;
+#endif
  static struct quirk_entry *quirks;

  /*

