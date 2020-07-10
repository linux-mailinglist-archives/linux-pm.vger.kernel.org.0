Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3FE821B754
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 15:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgGJN6N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 09:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgGJN6M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2020 09:58:12 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF3FC08C5CE;
        Fri, 10 Jul 2020 06:58:12 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l17so6291842wmj.0;
        Fri, 10 Jul 2020 06:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rFeUaiviFA43oUAWOSP16FbhvRxDnaaNa57FTdxWXIQ=;
        b=FuxVkXnj4j0bqqNMYJa5KKPvEmhjjAi4TZ5MoxjxQIjmWK9OVlOQIgDp932SjuHDr+
         lH4V1dc0SGx5xJe0t3StiB/BH/jIab0VsVNBbGnk5de+rlWiCbKwAujyJmLsZX8cnXjY
         WTMYsiX70wL4TFQ46Pdq50QLU8katOWrofsvO2FcToGCpjY8aYP5el0UxVIETXlFh7xQ
         ZuwwI1vPCuO+dk+Mvah6lY1/YrOfh1Pw1orhEhX/MEPkQuK+3e+KeqJHpBPd+E/JxgW2
         6QkZvrTqCRsQbo2G0pUiqHLFTMlh5RM0O8Q70ohRVf+fVrJKX2LZ9F0Ge17ZHMwHqOlu
         mTNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rFeUaiviFA43oUAWOSP16FbhvRxDnaaNa57FTdxWXIQ=;
        b=feUj9TE0yJlWsDX62vobdLso3B8YPZ1pNFb6RK/N49iNdPc7O09me1Lk5hD8SDK6f9
         mzrF8u5ra/WCmCQKaldPRicSABtqLcqzydK20itZg8n4Kw2bmX12k2PrW0iZPMjQR69r
         gmVkAAA5V5iLgioy8Mx7gaq26CgeLLXhDGd8cRYWhoB7A1OEinWSjzIzhZanUzcb0295
         vQXnSXffie92g7BfIu1rIlx1NTufA9svqTJxJ1iB3L6KUsmNH5oj6Aah/YIzABy7+P66
         w2xyYhJvM4IG01KCJXIa0K5l31vvzbWtlZIWYsdfjngDr4G+fT6mgqeIT1Ms2VCfIroB
         a7yg==
X-Gm-Message-State: AOAM532o7bCFwKude38lsyuDL/XSdm6W2PgNUpGJVNk0RiG3QrFITiBT
        wSePfjppnt5vr+YhMF9Qqu2p6Pp08js=
X-Google-Smtp-Source: ABdhPJwAnPyWA75gjJ0MUJJA5Fa4VwezmNZwmDXmU7nC2ZapiXTGID33S9gCzWnZJWIXHBxOK5MSzg==
X-Received: by 2002:a1c:ed0b:: with SMTP id l11mr5236550wmh.121.1594389490961;
        Fri, 10 Jul 2020 06:58:10 -0700 (PDT)
Received: from ziggy.stardust ([213.195.114.245])
        by smtp.gmail.com with ESMTPSA id v18sm11155377wrv.49.2020.07.10.06.58.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 06:58:10 -0700 (PDT)
Subject: Re: [PATCH] Revert "thermal: mediatek: fix register index error"
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Collabora Kernel ML <kernel@collabora.com>, drinkcat@chromium.org,
        hsinyi@chromium.org, Michael Kao <michael.kao@mediatek.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
References: <20200707103412.1010823-1-enric.balletbo@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <98369dbc-2e2a-a1bd-f3cd-68f33f66b882@gmail.com>
Date:   Fri, 10 Jul 2020 15:58:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200707103412.1010823-1-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 07/07/2020 12:34, Enric Balletbo i Serra wrote:
> This reverts commit eb9aecd90d1a39601e91cd08b90d5fee51d321a6
> 
> The above patch is supposed to fix a register index error on mt2701. It
> is not clear if the problem solved is a hang or just an invalid value
> returned, my guess is the second. The patch introduces, though, a new
> hang on MT8173 device making them unusable. So, seems reasonable, revert
> the patch because introduces a worst issue.
> 
> The reason I send a revert instead of trying to fix the issue for MT8173
> is because the information needed to fix the issue is in the datasheet
> and is not public. So I am not really able to fix it.
> 
> Fixes the following bug when CONFIG_MTK_THERMAL is set on MT8173
> devices.
> 
> [    2.222488] Unable to handle kernel paging request at virtual address ffff8000125f5001
> [    2.230421] Mem abort info:
> [    2.233207]   ESR = 0x96000021
> [    2.236261]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    2.241571]   SET = 0, FnV = 0
> [    2.244623]   EA = 0, S1PTW = 0
> [    2.247762] Data abort info:
> [    2.250640]   ISV = 0, ISS = 0x00000021
> [    2.254473]   CM = 0, WnR = 0
> [    2.257544] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000041850000
> [    2.264251] [ffff8000125f5001] pgd=000000013ffff003, pud=000000013fffe003, pmd=000000013fff9003, pte=006800001100b707
> [    2.274867] Internal error: Oops: 96000021 [#1] PREEMPT SMP
> [    2.280432] Modules linked in:
> [    2.283483] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.7.0-rc6+ #162
> [    2.289914] Hardware name: Google Elm (DT)
> [    2.294003] pstate: 20000005 (nzCv daif -PAN -UAO)
> [    2.298792] pc : mtk_read_temp+0xb8/0x1c8
> [    2.302793] lr : mtk_read_temp+0x7c/0x1c8
> [    2.306794] sp : ffff80001003b930
> [    2.310100] x29: ffff80001003b930 x28: 0000000000000000
> [    2.315404] x27: 0000000000000002 x26: ffff0000f9550b10
> [    2.320709] x25: ffff0000f9550a80 x24: 0000000000000090
> [    2.326014] x23: ffff80001003ba24 x22: 00000000610344c0
> [    2.331318] x21: 0000000000002710 x20: 00000000000001f4
> [    2.336622] x19: 0000000000030d40 x18: ffff800011742ec0
> [    2.341926] x17: 0000000000000001 x16: 0000000000000001
> [    2.347230] x15: ffffffffffffffff x14: ffffff0000000000
> [    2.352535] x13: ffffffffffffffff x12: 0000000000000028
> [    2.357839] x11: 0000000000000003 x10: ffff800011295ec8
> [    2.363143] x9 : 000000000000291b x8 : 0000000000000002
> [    2.368447] x7 : 00000000000000a8 x6 : 0000000000000004
> [    2.373751] x5 : 0000000000000000 x4 : ffff800011295cb0
> [    2.379055] x3 : 0000000000000002 x2 : ffff8000125f5001
> [    2.384359] x1 : 0000000000000001 x0 : ffff0000f9550a80
> [    2.389665] Call trace:
> [    2.392105]  mtk_read_temp+0xb8/0x1c8
> [    2.395760]  of_thermal_get_temp+0x2c/0x40
> [    2.399849]  thermal_zone_get_temp+0x78/0x160
> [    2.404198]  thermal_zone_device_update.part.0+0x3c/0x1f8
> [    2.409589]  thermal_zone_device_update+0x34/0x48
> [    2.414286]  of_thermal_set_mode+0x58/0x88
> [    2.418375]  thermal_zone_of_sensor_register+0x1a8/0x1d8
> [    2.423679]  devm_thermal_zone_of_sensor_register+0x64/0xb0
> [    2.429242]  mtk_thermal_probe+0x690/0x7d0
> [    2.433333]  platform_drv_probe+0x5c/0xb0
> [    2.437335]  really_probe+0xe4/0x448
> [    2.440901]  driver_probe_device+0xe8/0x140
> [    2.445077]  device_driver_attach+0x7c/0x88
> [    2.449252]  __driver_attach+0xac/0x178
> [    2.453082]  bus_for_each_dev+0x78/0xc8
> [    2.456909]  driver_attach+0x2c/0x38
> [    2.460476]  bus_add_driver+0x14c/0x230
> [    2.464304]  driver_register+0x6c/0x128
> [    2.468131]  __platform_driver_register+0x50/0x60
> [    2.472831]  mtk_thermal_driver_init+0x24/0x30
> [    2.477268]  do_one_initcall+0x50/0x298
> [    2.481098]  kernel_init_freeable+0x1ec/0x264
> [    2.485450]  kernel_init+0x1c/0x110
> [    2.488931]  ret_from_fork+0x10/0x1c
> [    2.492502] Code: f9401081 f9400402 b8a67821 8b010042 (b9400042)
> [    2.498599] ---[ end trace e43e3105ed27dc99 ]---
> [    2.503367] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> [    2.511020] SMP: stopping secondary CPUs
> [    2.514941] Kernel Offset: disabled
> [    2.518421] CPU features: 0x090002,25006005
> [    2.522595] Memory Limit: none
> [    2.525644] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]--
> 
> Cc: Michael Kao <michael.kao@mediatek.com>
> Fixes: eb9aecd90d1a ("thermal: mediatek: fix register index error")
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

Daniel, Zhang, Amit: can you take this as a bugfix for v5.8 please? We waited 
long enough to get a proper fix for the driver, but nothing was posted on the 
mailinglist. Also we don't know if this will break mt2701 or not, we prefer to 
have a working mt8173 as this is actually a SoC that is available to the general 
public (as a chromebook product).

I propose to take this revert for now and hope that MediaTek will fix the driver 
for good in the near future.

Regards,
Matthias

> ---
> 
>   drivers/thermal/mtk_thermal.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> index 6b7ef1993d7e..42c9cd0e5f77 100644
> --- a/drivers/thermal/mtk_thermal.c
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -594,8 +594,7 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
>   	u32 raw;
>   
>   	for (i = 0; i < conf->bank_data[bank->id].num_sensors; i++) {
> -		raw = readl(mt->thermal_base +
> -			    conf->msr[conf->bank_data[bank->id].sensors[i]]);
> +		raw = readl(mt->thermal_base + conf->msr[i]);
>   
>   		temp = raw_to_mcelsius(mt,
>   				       conf->bank_data[bank->id].sensors[i],
> @@ -736,8 +735,7 @@ static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
>   
>   	for (i = 0; i < conf->bank_data[num].num_sensors; i++)
>   		writel(conf->sensor_mux_values[conf->bank_data[num].sensors[i]],
> -		       mt->thermal_base +
> -		       conf->adcpnp[conf->bank_data[num].sensors[i]]);
> +		       mt->thermal_base + conf->adcpnp[i]);
>   
>   	writel((1 << conf->bank_data[num].num_sensors) - 1,
>   	       controller_base + TEMP_MONCTL0);
> 
