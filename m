Return-Path: <linux-pm+bounces-27026-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A548AB2A83
	for <lists+linux-pm@lfdr.de>; Sun, 11 May 2025 21:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85BE616FA76
	for <lists+linux-pm@lfdr.de>; Sun, 11 May 2025 19:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6D22571AC;
	Sun, 11 May 2025 19:38:21 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21711A08A6;
	Sun, 11 May 2025 19:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746992301; cv=none; b=diDgWhYDy4JIDfMhwPxGup8T4Dkdc/3LTy695v+AI4ZM3WONyHfFDaxe4GWK3jz4hKoJFp9M0oBr3UVyQTOedOKR1/xBbtmgxOJnuqilWZs/0fC1oxUBcqb/f/J/8iiiPFbmeidApwiH0rTkEmUQIDW42j96l3wHhPz1bhikRwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746992301; c=relaxed/simple;
	bh=qKF7marocN1HQTzN56LGTxIuZmKwoVL2Tnbrdro+ig4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sa2ZCUN/mXnjApJOuVnkQKsaEyYV6XdgKvCajg0jeLlmxbmI/lwWmNnfwYTNrGTtxSZX1iuIbsCbgU69paG9Ehk1vHrUsRc1RvBDUAmc1hrjWVJSlc3mbnBPrPy/i/BuQ278hhAyyYZK55fQnFu4Ee+H4xXLQskEUr7K5nqmBVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.107] (p57bd968f.dip0.t-ipconnect.de [87.189.150.143])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5343761E647B1;
	Sun, 11 May 2025 21:37:53 +0200 (CEST)
Message-ID: <77eaf638-924a-4cd2-a578-c932e5cf1765@molgen.mpg.de>
Date: Sun, 11 May 2025 21:37:52 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM: thaw_processes: Rewrite restarting tasks log to
 remove stray *done.*
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250506155659.95212-1-pmenzel@molgen.mpg.de>
 <CAJZ5v0h0tc=5oJ5KsqyvXT6w64tztL8cy-iNF+=8xa2ncAwQ6w@mail.gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CAJZ5v0h0tc=5oJ5KsqyvXT6w64tztL8cy-iNF+=8xa2ncAwQ6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Raphael,


Am 09.05.25 um 18:48 schrieb Rafael J. Wysocki:
> On Tue, May 6, 2025 at 5:57 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>>
>> `pr_cont()` unfortunately does not work here, as other parts of the
>> Linux kernel log between the two log lines:
>>
>>      [18445.295056] r8152-cfgselector 4-1.1.3: USB disconnect, device number 5
>>      [18445.295112] OOM killer enabled.
>>      [18445.295115] Restarting tasks ...
>>      [18445.295185] usb 3-1: USB disconnect, device number 2
>>      [18445.295193] usb 3-1.1: USB disconnect, device number 3
>>      [18445.296262] usb 3-1.5: USB disconnect, device number 4
>>      [18445.297017] done.
>>      [18445.297029] random: crng reseeded on system resumption
>>
>> `pr_cont()` also uses the default log level, normally warning, if the
>> corresponding log line is interrupted.
>>
>> Therefore, replace the `pr_cont()`, and explicitly log it as a separate
>> line with log level info:
>>
>>      Restarting tasks ...
>>      […]
>>      Done restarting tasks.
>>
>> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
>> ---
>>   kernel/power/process.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/power/process.c b/kernel/power/process.c
>> index 66ac067d9ae6..92daf1dce8c3 100644
>> --- a/kernel/power/process.c
>> +++ b/kernel/power/process.c
>> @@ -189,7 +189,7 @@ void thaw_processes(void)
>>
>>          oom_killer_enable();
>>
>> -       pr_info("Restarting tasks ... ");
>> +       pr_info("Restarting tasks ...\n");
> 
> I would prefer something like
> 
> pr_info("Restarting tasks: Starting\n");
> 
>>
>>          __usermodehelper_set_disable_depth(UMH_FREEZING);
>>          thaw_workqueues();
>> @@ -208,7 +208,7 @@ void thaw_processes(void)
>>          usermodehelper_enable();
>>
>>          schedule();
>> -       pr_cont("done.\n");
>> +       pr_info("Done restarting tasks.\n");
> 
> And
> 
> pr_info("Restarting tasks: Done\n");
> 
> here so the messages are more visually similar.
> 
> Otherwise this change is fine by me.
> 
> Thanks!
> 
>>          trace_suspend_resume(TPS("thaw_processes"), 0, false);
>>   }

Thank you for your review. I sent v2 [1].


Kind regards,

Paul


[1]: 
https://lore.kernel.org/linux-pm/20250511174648.950430-1-pmenzel@molgen.mpg.de/T/#u

