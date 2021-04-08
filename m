Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C6A357A45
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 04:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbhDHCW1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Apr 2021 22:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhDHCW1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Apr 2021 22:22:27 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF4AC061760
        for <linux-pm@vger.kernel.org>; Wed,  7 Apr 2021 19:22:15 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id b8-20020a17090a5508b029014d0fbe9b64so2298743pji.5
        for <linux-pm@vger.kernel.org>; Wed, 07 Apr 2021 19:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=IJsCbMw65Xyqo3bsXDr/ch5nbI7w8AXbryyL2x45JqY=;
        b=ONg6vRj9DrvkPcUGmzgAB72VLbnrL/wLL4g3UpTW5xopQyuQWqsDu8H9mhhOVUw2qv
         A7c3Mfr8YUzghkeVaV92Qx8inOKyas4944e58KtfnG0NhIml15lXqFn/U1Nw0t5OK2A2
         HUkIzabCYejpgIWDq65UKr4C+HILmJUnXiuhsFSCOZ0Bzg5ePvKaiPhus6v/CCGy/RXZ
         hGdZZcvlPzF0BbALjXHMv9VGZUVK7fgaStFsqDnQ0Sr5x6Cn6+edQCI5sJn5Oz81oUb4
         6pSz+0RQ1Kbs1hUGsKfyeDQ+OEeTL7XiuUO9UR83nri3jLFYpTJC7sBzBdzc7j3t4nVr
         XIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=IJsCbMw65Xyqo3bsXDr/ch5nbI7w8AXbryyL2x45JqY=;
        b=grVvAATozUaZbKMh3tInWWsvtoO/PvmfbtnsriRK5ywY6rVkspsmEU5fP5dzCX7Dj/
         DiJCWMyjqKBdrpTesa4caFZLltjotiNNo9kfr36c9TDubPT2hWkZe+bQcmuEoYuVhR4q
         JMM54dKZ06wmg7MsuO1wRwr/w4x02A+9JVrBQwqbTKcDKX+wkMxkPwUwigr4BiymDgEc
         f1HN5IVGtzu/mazuXT0l0+BfK9JZvGRTBxhhNRwazpcAuo4N01rOKwk64EtseqgMA/eU
         USSYKdMdvEjMFFc5mpZE5rhVnW3+n73EKjoJIAns5J5agHtokyqZQbrtpXnYuFtoQvQc
         T4Zg==
X-Gm-Message-State: AOAM533jd8ABrZbQcK8qpceWxWyhZ5oSYYHq0c+ZYO3AscgSOBgTNyTg
        3P5PzoK1ZJzTL5PoMmeoej8=
X-Google-Smtp-Source: ABdhPJwS3Im1Ww4P1MKwbgxcU5BBxYxJDuka4TX5ieNFZ0iKb0e5EY+GfRkY3BnBrHFhs6agWQOEcg==
X-Received: by 2002:a17:90a:4498:: with SMTP id t24mr6143987pjg.78.1617848535606;
        Wed, 07 Apr 2021 19:22:15 -0700 (PDT)
Received: from MacBook-Pro.local ([103.112.79.203])
        by smtp.gmail.com with ESMTPSA id p10sm130727pfn.109.2021.04.07.19.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 19:22:15 -0700 (PDT)
Subject: Re: [PATCH 1/2] cpupower: fix amd cpu (family < 0x17) active state
 issue
From:   xufuhai <xufuhai1992@gmail.com>
To:     Thomas Renninger <trenn@suse.com>, linux@dominikbrodowski.net,
        sherry.hurwitz@amd.com, linux-pm@vger.kernel.org
Cc:     lishujin@kuaishou.com, xufuhai <xufuhai@kuaishou.com>
References: <20210324082838.41462-1-xufuhai1992@gmail.com>
 <5120169.VkIDyNCUOm@c100> <a1dd4790-7308-4bfc-bd13-4341812a10ca@gmail.com>
Message-ID: <aa314acd-1d13-c970-7e8a-0fce48215ee4@gmail.com>
Date:   Thu, 8 Apr 2021 10:22:11 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <a1dd4790-7308-4bfc-bd13-4341812a10ca@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Any reply? Thomas

在 2021/3/30 上午11:47, xufuhai 写道:
> hi Thomas,
> 
> Thanks for your reply
> 
> I believe the only way that pci_read_byte can return 0xff is no permission to 
> access the pci_dev read function. Because for pci_read_byte, the pos offset is
> 0x15c that the offset has excessed the capacity of pci_dev cache_len, so can't
> get val via memcpy from cache. 
> 
> And then for read callback function, I think that is read val from pci_dev 0x15c 
> register. I have looked up the amd family 0x15 code, the 0x15c register is called
> "Core Performance Boost Control Register" and this register base addr is D18F4x15C.
> We just concern the lower 8bit of D18F4x15C register, the detailed as below: 
> 
> Quote from https://chromium.googlesource.com/chromiumos/third_party/coreboot/+/796af1
> 7f18554380a49d69d7768ac18ee039d711/src/vendorcode/amd/agesa/f15/Proc/CPU/Family/0x15/cpuF15PowerMgmt.h
> 
> /* Core Performance Boost Control Register D18F4x15C */
> #define CPB_CTRL_REG 0x15C
> #define CPB_CTRL_PCI_ADDR (MAKE_SBDFO (0, 0, 0x18, FUNC_4, CPB_CTRL_REG))
> /// Core Performance Boost Control Register of Family 15h common aceess
> typedef struct {
>   UINT32 BoostSrc:2;                 ///< Boost source
>   UINT32 NumBoostStates:3;           ///< Number of boosted states
>   UINT32 :2;                         ///< Reserved
>   UINT32 ApmMasterEn:1;              ///< APM master enable
>   UINT32 :23;                        ///< Reserved
>   UINT32 BoostLock:1;                ///<
> } F15_CPB_CTRL_REGISTER;
> 
> the amd 0x15 family specification pdf:
> https://www.amd.com/system/files/TechDocs/42301_15h_Mod_00h-0Fh_BKDG.pdf
> 
> so I believe that val is nealy impossible to return 0xff unless no permisson to access read callback.
> 
> what do you think? Thomas
> 
> And at last I have a new doubt why the amd_pci_get_num_boost_states about setting "*active=1"
> condition is "val & 3", should not be "val & 1"? I accidently found that "00b Boosting disabled / 01b Boosting enabled / 1*b Reserved" 
> via above amd specification about D18F4x15C register description.
> I am just curious about this point, maybe I am wrong~ : 
> 
> 	if (val & 3)
> 		*active = 1;
> 	else
> 		*active = 0;
> 
> Thanks for your reading, Thomas
> 
> 在 2021/3/29 下午7:10, Thomas Renninger 写道:
>> Hi,
>>
>> Am Mittwoch, 24. März 2021, 09:28:37 CEST schrieb xufuhai:
>>> From: xufuhai <xufuhai@kuaishou.com>
>>>
>>> For the old  AMD processor (family < 0x17), cpupower will call the
>>> amd_pci_get_num_boost_states function, but for the non-root user
>>> pci_read_byte function (implementation comes from the psutil library),
>>> val will be set to 0xff, indicating that there is no read function
>>> callback. At this time, the original logic will set the cpupower turbo
>>> active state to yes. This is an obvious issue~
>>>
>>> Reproduce procedure:
>>> 	cpupower frequency-info
>>>
>>> Signed-off-by: xufuhai <xufuhai@kuaishou.com>
>>> ---
>>>  tools/power/cpupower/utils/helpers/amd.c | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/tools/power/cpupower/utils/helpers/amd.c
>>> b/tools/power/cpupower/utils/helpers/amd.c index 97f2c857048e..6f9504906afa
>>> 100644
>>> --- a/tools/power/cpupower/utils/helpers/amd.c
>>> +++ b/tools/power/cpupower/utils/helpers/amd.c
>>> @@ -137,6 +137,13 @@ int amd_pci_get_num_boost_states(int *active, int
>>> *states) return -ENODEV;
>>>
>>>  	val = pci_read_byte(device, 0x15c);
>>> +
>>> +	/* If val is 0xff, meaning has no permisson to
>>> +	 * get the boost states, return -1
>>> +	 */
>>> +	if (val == 0xff)
>>> +		return -1;
>>> +
>> There is certainly a cleaner way to do this.., theoretically
>> pci_read_byte can return 0xff in other cases?
>>
>> But I guess this is a sufficient way to handle this for now.
>>
>> Reviewed-by: Thomas Renninger <trenn@suse.de>
>>
>> Thanks,
>>
>>         Thomas
>>
>>
