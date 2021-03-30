Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E99034DF8E
	for <lists+linux-pm@lfdr.de>; Tue, 30 Mar 2021 05:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhC3DrX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Mar 2021 23:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbhC3DrU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Mar 2021 23:47:20 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE73C061762
        for <linux-pm@vger.kernel.org>; Mon, 29 Mar 2021 20:47:18 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id c17so11233029pfn.6
        for <linux-pm@vger.kernel.org>; Mon, 29 Mar 2021 20:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=FVRmLiWdAw/CCW46qV2/87Kd0uZ4yjbtVU6KpzNizvQ=;
        b=Fam5KFwNZXaBR6EBzlNCdGCmupCWzYIdAhaFbtg8lqn8A8RnrJOlB+NXFAer2fPigX
         4GPiuHuflbxM1tMhZPgmr4LhPPdbjbO9gqo471BkoPaABUqfw5RTVeGpTEa31yoIsdfP
         RoctZcD/WyqQA44/V7dWLmrSFr42GbZOsU8hk86JKvE8mGiKsICbz+t0b/ik+4ufOwgK
         k/JB8WFQJGTkU8RNeDTEz+h7aRJi8vZUFrhAPeRfkRcdxdva+Q8BpITmM3oRaalfAIpp
         Z+D7IQOdWi3HX9eEyUN8RjdH53dRFnP3n6aUlojqPoyH4P/x9hoGS0Eh+hpnGIRxlCN4
         B3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=FVRmLiWdAw/CCW46qV2/87Kd0uZ4yjbtVU6KpzNizvQ=;
        b=kDnaaULxszG6M1LDe4r6eCkVmGHakJZpLxqS5dzr9LEYSv+gM+kPKjxiP8sIYzPBAA
         6v4WnYbqbQ+XKn/fW/lLpw7VDWup+Px2b1eROf7Pm7S+1k1RHvnvwJrkw2vUoIZaV8eJ
         XlmblqtmcdkO6QFZNPG8QL2vC/pEOAKD4D3Db9cQcQsD04SfgyacWhOCGavIGosp7nsD
         a2vU9/YfKhYGRiM6qM+g/b/NHazAYoIEJ2bq9+dJBr+PfuZYLYORQdZAiivtN/9DY9DF
         fB2Gt7wCCsDk2AJpM3ZNTe3WOjMzZeV76OGkokGXzqtZulAkQ66G9ND3rT/eeAslOxKu
         POkQ==
X-Gm-Message-State: AOAM531O73UxGGOhB4EjAKg4bvFaytysROfyh08Vt+czMpw+7/EOtcQr
        IyDlcR6WdOxl9OxBDLllJnvqx6arzRKDbDHK
X-Google-Smtp-Source: ABdhPJxG6ydVyCtfRloPrtYcUqpO0nRb6iP1CHJ6jWHcW6mPx07HxHZPtSiApJ14KwNtLXMwYfzu+w==
X-Received: by 2002:a63:6683:: with SMTP id a125mr26049696pgc.382.1617076038040;
        Mon, 29 Mar 2021 20:47:18 -0700 (PDT)
Received: from MacBook-Pro.local ([122.10.101.134])
        by smtp.gmail.com with ESMTPSA id r16sm18609266pfq.211.2021.03.29.20.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 20:47:17 -0700 (PDT)
Subject: Re: [PATCH 1/2] cpupower: fix amd cpu (family < 0x17) active state
 issue
To:     Thomas Renninger <trenn@suse.com>, linux@dominikbrodowski.net,
        sherry.hurwitz@amd.com, linux-pm@vger.kernel.org
Cc:     lishujin@kuaishou.com, xufuhai <xufuhai@kuaishou.com>
References: <20210324082838.41462-1-xufuhai1992@gmail.com>
 <5120169.VkIDyNCUOm@c100>
From:   xufuhai <xufuhai1992@gmail.com>
Message-ID: <a1dd4790-7308-4bfc-bd13-4341812a10ca@gmail.com>
Date:   Tue, 30 Mar 2021 11:47:10 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <5120169.VkIDyNCUOm@c100>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

hi Thomas,

Thanks for your reply

I believe the only way that pci_read_byte can return 0xff is no permission to 
access the pci_dev read function. Because for pci_read_byte, the pos offset is
0x15c that the offset has excessed the capacity of pci_dev cache_len, so can't
get val via memcpy from cache. 

And then for read callback function, I think that is read val from pci_dev 0x15c 
register. I have looked up the amd family 0x15 code, the 0x15c register is called
"Core Performance Boost Control Register" and this register base addr is D18F4x15C.
We just concern the lower 8bit of D18F4x15C register, the detailed as below: 

Quote from https://chromium.googlesource.com/chromiumos/third_party/coreboot/+/796af1
7f18554380a49d69d7768ac18ee039d711/src/vendorcode/amd/agesa/f15/Proc/CPU/Family/0x15/cpuF15PowerMgmt.h

/* Core Performance Boost Control Register D18F4x15C */
#define CPB_CTRL_REG 0x15C
#define CPB_CTRL_PCI_ADDR (MAKE_SBDFO (0, 0, 0x18, FUNC_4, CPB_CTRL_REG))
/// Core Performance Boost Control Register of Family 15h common aceess
typedef struct {
  UINT32 BoostSrc:2;                 ///< Boost source
  UINT32 NumBoostStates:3;           ///< Number of boosted states
  UINT32 :2;                         ///< Reserved
  UINT32 ApmMasterEn:1;              ///< APM master enable
  UINT32 :23;                        ///< Reserved
  UINT32 BoostLock:1;                ///<
} F15_CPB_CTRL_REGISTER;

the amd 0x15 family specification pdf:
https://www.amd.com/system/files/TechDocs/42301_15h_Mod_00h-0Fh_BKDG.pdf

so I believe that val is nealy impossible to return 0xff unless no permisson to access read callback.

what do you think? Thomas

And at last I have a new doubt why the amd_pci_get_num_boost_states about setting "*active=1"
condition is "val & 3", should not be "val & 1"? I accidently found that "00b Boosting disabled / 01b Boosting enabled / 1*b Reserved" 
via above amd specification about D18F4x15C register description.
I am just curious about this point, maybe I am wrong~ : 

	if (val & 3)
		*active = 1;
	else
		*active = 0;

Thanks for your reading, Thomas

在 2021/3/29 下午7:10, Thomas Renninger 写道:
> Hi,
> 
> Am Mittwoch, 24. März 2021, 09:28:37 CEST schrieb xufuhai:
>> From: xufuhai <xufuhai@kuaishou.com>
>>
>> For the old  AMD processor (family < 0x17), cpupower will call the
>> amd_pci_get_num_boost_states function, but for the non-root user
>> pci_read_byte function (implementation comes from the psutil library),
>> val will be set to 0xff, indicating that there is no read function
>> callback. At this time, the original logic will set the cpupower turbo
>> active state to yes. This is an obvious issue~
>>
>> Reproduce procedure:
>> 	cpupower frequency-info
>>
>> Signed-off-by: xufuhai <xufuhai@kuaishou.com>
>> ---
>>  tools/power/cpupower/utils/helpers/amd.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/tools/power/cpupower/utils/helpers/amd.c
>> b/tools/power/cpupower/utils/helpers/amd.c index 97f2c857048e..6f9504906afa
>> 100644
>> --- a/tools/power/cpupower/utils/helpers/amd.c
>> +++ b/tools/power/cpupower/utils/helpers/amd.c
>> @@ -137,6 +137,13 @@ int amd_pci_get_num_boost_states(int *active, int
>> *states) return -ENODEV;
>>
>>  	val = pci_read_byte(device, 0x15c);
>> +
>> +	/* If val is 0xff, meaning has no permisson to
>> +	 * get the boost states, return -1
>> +	 */
>> +	if (val == 0xff)
>> +		return -1;
>> +
> There is certainly a cleaner way to do this.., theoretically
> pci_read_byte can return 0xff in other cases?
> 
> But I guess this is a sufficient way to handle this for now.
> 
> Reviewed-by: Thomas Renninger <trenn@suse.de>
> 
> Thanks,
> 
>         Thomas
> 
> 
