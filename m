Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8612339A2C
	for <lists+linux-pm@lfdr.de>; Sat, 13 Mar 2021 00:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235803AbhCLXxK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 18:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235690AbhCLXxB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 18:53:01 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0572C061574;
        Fri, 12 Mar 2021 15:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=PyYSziSvb4CbAQOs+YzAOIzweinnSghlNEf/rKo2Ts4=; b=PQL/uvuGcCnjoakkeUNEap8YbX
        Xy8KLQ5UyP/cE7TmrA9Zew7qRbzuIdH+6Xy8Rx1byc/nsjI7l/rZm9zPYhn+KTOpST6+lg3MwZ8MB
        sbvWUS0IESwBHHMQ1WSztlkpJf4U6QtB4kWEhqk+05uNEbaFSO/i+o3+bL3a5GtHLsUrtAHK+8v2Y
        MzzP5j0ptRDvy+dFqG+XDfxMVg0BjKk1ma8/cd1B7CSN93F/NECgCB0/mP1bmxNPG8h8RE0cUZiJm
        w/rne8RXF9C0gs9qwY9lkCDCQf70m9wbE1DZln8ngec+DsZbxHB2QhhuhCQ0/GUy/oN8cPr+rcvCG
        z2Jkr5xw==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKraT-0016Ht-LK; Fri, 12 Mar 2021 23:52:58 +0000
Subject: Re: [PATCH] cpufreq: Rudimentary typos fix in the file
 s5pv210-cpufreq.c
To:     Tom Saeger <tom.saeger@oracle.com>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210312120817.12604-1-unixbhaskar@gmail.com>
 <4c0c0738-72c3-7704-500a-28cb1a068aa1@kernel.org> <YEv2RDAdeJEU75ib@Gentoo>
 <20210312233802.bzriltvej5gccsdp@brm-x62-17.us.oracle.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <56934ae8-d9f6-360f-241d-8e8aee448b7d@infradead.org>
Date:   Fri, 12 Mar 2021 15:52:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210312233802.bzriltvej5gccsdp@brm-x62-17.us.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/12/21 3:38 PM, Tom Saeger wrote:
> On Sat, Mar 13, 2021 at 04:46:20AM +0530, Bhaskar Chowdhury wrote:
>> On 15:01 Fri 12 Mar 2021, Krzysztof Kozlowski wrote:
>>> On 12/03/2021 13:08, Bhaskar Chowdhury wrote:
>>>>
>>>> s/untile/until/
>>>> s/souce/source/
>>>> s/divier/divider/
>>>>

> 
> May as well roll in few more?
> 
> Regards,
> 
> --Tom
> 
> diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
> index a186c0d8a290..6ecef301bd40 100644
> --- a/drivers/cpufreq/s5pv210-cpufreq.c
> +++ b/drivers/cpufreq/s5pv210-cpufreq.c
> @@ -91,7 +91,7 @@ static DEFINE_MUTEX(set_freq_lock);
>  /* Use 800MHz when entering sleep mode */
>  #define SLEEP_FREQ     (800 * 1000)
> 
> -/* Tracks if cpu freqency can be updated anymore */
> +/* Tracks if cpu frequency can be updated anymore */
>  static bool no_cpufreq_access;
> 
>  /*
> @@ -190,7 +190,7 @@ static u32 clkdiv_val[5][11] = {
> 
>  /*
>   * This function set DRAM refresh counter
> - * accoriding to operating frequency of DRAM
> + * according to operating frequency of DRAM
>   * ch: DMC port number 0 or 1
>   * freq: Operating frequency of DRAM(KHz)
>   */
> @@ -320,7 +320,7 @@ static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)
> 
>                 /*
>                  * 3. DMC1 refresh count for 133Mhz if (index == L4) is
> -                * true refresh counter is already programed in upper
> +                * true refresh counter is already programmed in upper
>                  * code. 0x287@83Mhz
>                  */
>                 if (!bus_speed_changing)
> 

LGTM.
Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
~Randy

