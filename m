Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9C61DEC24
	for <lists+linux-pm@lfdr.de>; Fri, 22 May 2020 17:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbgEVPiX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 May 2020 11:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728433AbgEVPiW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 May 2020 11:38:22 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9092C061A0E;
        Fri, 22 May 2020 08:38:21 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id g12so9389266wrw.1;
        Fri, 22 May 2020 08:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=En8ZDEzcLbAeuTI5D0xEPaBrQHbpj1ERdOhqo1dr+r8=;
        b=Maet0jYB2Ziw+jAZixcFkMD7SlYDYi10f7LbCxcQyEVpW73PX3rTAtRn9pY/ATGuND
         CZrOiwD1w72ZEVA9FI1UMMz76MCqIEQb2creMzRyVznwM2DHdZoNFy+AmoZjtbcknaJJ
         YGQvBCyzQcwhaiPDnBXL2r4OvbcdmGZ5+sx2vTCn1xEVGpEZC2SVV1LS+BHkWqLMssIy
         a8Kq6NlUsYCHJvx7Yqf0YU9XjCgMlPLlUGcg65jKkrMcBcWHlxUiPTFFPYCORQvfULL6
         Cy/VVf/61vU5AwFmjfvoLollxiAObPQQRHIykOUM4RuTlofc+p6XRn9DwBcgEKDjA05c
         IemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=En8ZDEzcLbAeuTI5D0xEPaBrQHbpj1ERdOhqo1dr+r8=;
        b=bL6hetDM3TdG1lMuCWh7SdSQoPGxuiB8su5v1jmvyYn+48j/N8Y9sEcTU9uSzo7TRI
         RmvT1+wKUmZCTmG7Rcz3ugg7OWkZpJWjjG+1HTCcgcG8Yk2Js9UXJniC/7g+AqDUyQpT
         IkCa/ksyoVJhPfrOrxf1DGhU/oTFzhbOCZn8dr8dSdsbA+QvC5W6LpNxJaAzAHNjkA1p
         R/M+6NJ7FX8VSrm+KIf2zYAgs3LUrXpBJsUNFfvljtVxiHwowAdI8A5E9xrf6LZVYmc5
         bO2Vn3F/DCnjSPRQNWxm4vTONs7HQHF9Epk+IPgObNvwj6njAAhumRl94sGsE2t13sNu
         Nv/w==
X-Gm-Message-State: AOAM532WSf6S6LpjsNA5bbh4ZHaF6fylzqE0vAzLkvIzMpl1rolQFTKH
        BVwhHHMJik5u7DprU558ms4=
X-Google-Smtp-Source: ABdhPJx0CsXJEAx4ihSfjjcd18gWgluoE61/HcXLEiO24nOqUV2+UgcKmG9ekSVcZvUpfCDm8TEn8Q==
X-Received: by 2002:adf:f783:: with SMTP id q3mr3829441wrp.348.1590161900546;
        Fri, 22 May 2020 08:38:20 -0700 (PDT)
Received: from ziggy.stardust ([213.195.113.243])
        by smtp.gmail.com with ESMTPSA id e21sm9658808wme.34.2020.05.22.08.38.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 08:38:19 -0700 (PDT)
Subject: Re: [PATCH v8 3/3] PM / AVS: SVS: Introduce SVS engine
To:     Roger Lu <roger.lu@mediatek.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, Angus Lin <Angus.Lin@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>, Fan Chen <fan.chen@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20200518092403.22647-1-roger.lu@mediatek.com>
 <20200518092403.22647-4-roger.lu@mediatek.com>
 <CAFqH_527ZJEmsvrk-n-uNSc+Bx87ZVppn=rNKDWPGYUuf+gvPA@mail.gmail.com>
 <1590140434.4392.22.camel@mtksdaap41>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <3b810588-ac4a-7fec-2163-38555dd83928@gmail.com>
Date:   Fri, 22 May 2020 17:38:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1590140434.4392.22.camel@mtksdaap41>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 22/05/2020 11:40, Roger Lu wrote:
> 
> Hi Enric,
> 
> On Tue, 2020-05-19 at 17:30 +0200, Enric Balletbo Serra wrote:
>> Hi Roger,
>>
>> Thank you for your patch. I have the feeling that this driver is
>> complex and difficult to follow and I am wondering if it wouldn't be
>> better if you can send a version that simply adds basic functionality
>> for now. Some comments below.
> 
> Thanks for the advices. I'll submit SVS v9 with basic functionality
> patch + step by step functionalities' patches. 
> 
>>
>> Missatge de Roger Lu <roger.lu@mediatek.com> del dia dl., 18 de maig
>> 2020 a les 11:25:
>>>
>>> The SVS (Smart Voltage Scaling) engine is a piece
>>> of hardware which is used to calculate optimized
>>> voltage values of several power domains,
>>> e.g. CPU/GPU/CCI, according to chip process corner,
>>> temperatures, and other factors. Then DVFS driver
>>> could apply those optimized voltage values to reduce
>>> power consumption.
>>>
>>> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
>>> ---
>>>  drivers/power/avs/Kconfig     |   10 +
>>>  drivers/power/avs/Makefile    |    1 +
>>>  drivers/power/avs/mtk_svs.c   | 2119 +++++++++++++++++++++++++++++++++
>>>  include/linux/power/mtk_svs.h |   23 +
>>>  4 files changed, 2153 insertions(+)
>>>  create mode 100644 drivers/power/avs/mtk_svs.c
>>>  create mode 100644 include/linux/power/mtk_svs.h
>>>
>>> diff --git a/drivers/power/avs/Kconfig b/drivers/power/avs/Kconfig
>>> index cdb4237bfd02..67089ac6040e 100644
>>> --- a/drivers/power/avs/Kconfig
>>> +++ b/drivers/power/avs/Kconfig
>>> @@ -35,3 +35,13 @@ config ROCKCHIP_IODOMAIN
>>>           Say y here to enable support io domains on Rockchip SoCs. It is
>>>           necessary for the io domain setting of the SoC to match the
>>>           voltage supplied by the regulators.
>>> +
>>> +config MTK_SVS
>>> +       bool "MediaTek Smart Voltage Scaling(SVS)"
>>
>> Can't be this a module? Why? In such case, you should use tristate option
> 
> Generally, MTK_SVS is needed in MTK SoC(mt81xx) products. So, we don't provide
> module option in config. If, somehow, SVS isn't needed, we suggest
> CONFIG_MTK_SVS=n to be set.
> 

The question here is if it needs to be probed before we probe the modules. If
not, we should add a Kconfig option for MT81xx SoCs to select MTK_SVS.

>>
>>> +       depends on POWER_AVS && MTK_EFUSE && NVMEM
>>> +       help
>>> +         The SVS engine is a piece of hardware which is used to calculate
>>> +         optimized voltage values of several power domains, e.g.
>>> +         CPU clusters/GPU/CCI, according to chip process corner, temperatures,
>>> +         and other factors. Then DVFS driver could apply those optimized voltage
>>> +         values to reduce power consumption.
>>> diff --git a/drivers/power/avs/Makefile b/drivers/power/avs/Makefile
>>> index 9007d05853e2..231adf078582 100644
>>> --- a/drivers/power/avs/Makefile
>>> +++ b/drivers/power/avs/Makefile
>>> @@ -2,3 +2,4 @@
>>>  obj-$(CONFIG_POWER_AVS_OMAP)           += smartreflex.o
>>>  obj-$(CONFIG_QCOM_CPR)                 += qcom-cpr.o
>>>  obj-$(CONFIG_ROCKCHIP_IODOMAIN)                += rockchip-io-domain.o
>>> +obj-$(CONFIG_MTK_SVS)                  += mtk_svs.o
>>
>> Will this driver be SoC specific or the idea is to support different
>> SoCs? If the answer to the first question is yes, please name the file
>> with the SoC prefix (i.e mt8183_svs). However, If the answer to the
>> second question is yes, make sure you prefix common
>> functions/structs/defines with a generic prefix mtk_svs but use the
>> SoC prefix for the ones you expect will be different between SoC, i.e
>> mt8183_svs_. This helps the readability of the driver. Also, try to
>> avoid too generic names.
> 
> MTK_SVS is designed for supporting different MTK SoCs.Therefore, the answer is second
> question and thanks for the heads-up.
> 
>>
>>> diff --git a/drivers/power/avs/mtk_svs.c b/drivers/power/avs/mtk_svs.c
>>> new file mode 100644
>>> index 000000000000..a4083b3ef175
>>> --- /dev/null
>>> +++ b/drivers/power/avs/mtk_svs.c
>>> @@ -0,0 +1,2119 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>
>> I suspect you want this only GPLv2 compliant. Use GPL-2.0-only
> 
> OK. I'll use GPL-2.0-only.Thanks.
> 
>>
>>> +/*
>>> + * Copyright (C) 2020 MediaTek Inc.
>>> + */
>>> +
>>> +#define pr_fmt(fmt)    "[mtk_svs] " fmt
>>
>> I don't see any reason to use pr_fmt in this driver. Use dev_*
>> functions instead and remove the above.
> 
> Ok. I will remove it. Thanks.
> 
>>
>>> +
>>> +#include <linux/bits.h>
>>> +#include <linux/clk.h>
>>> +#include <linux/completion.h>
>>> +#include <linux/init.h>
>>> +#include <linux/interrupt.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/kthread.h>
>>> +#include <linux/module.h>
>>> +#include <linux/mutex.h>
>>> +#include <linux/nvmem-consumer.h>
>>> +#include <linux/of_address.h>
>>> +#include <linux/of_irq.h>
>>> +#include <linux/of_platform.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/pm_domain.h>
>>> +#include <linux/pm_opp.h>
>>> +#include <linux/pm_qos.h>
>>> +#include <linux/pm_runtime.h>
>>> +#include <linux/power/mtk_svs.h>
>>> +#include <linux/proc_fs.h>
>>> +#include <linux/regulator/consumer.h>
>>> +#include <linux/reset.h>
>>> +#include <linux/seq_file.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/spinlock.h>
>>> +#include <linux/thermal.h>
>>> +#include <linux/uaccess.h>
>>> +
>>> +/* svs 1-line sw id */
>>> +#define SVS_CPU_LITTLE                 BIT(0)
>>> +#define SVS_CPU_BIG                    BIT(1)
>>> +#define SVS_CCI                                BIT(2)
>>> +#define SVS_GPU                                BIT(3)
>>> +
>>> +/* svs bank mode support */
>>> +#define SVSB_MODE_ALL_DISABLE          (0)
>>
>> nit: SVS_BMODE_?
> 
> Oh. If we add bank wording like SVS_Bxxx, it might cause some confusion when B combines
> with other words. So, I'll keep SVSB for SVS Bank representation.
> E.g: SVS_BDC_SIGNED_BIT might lead to be explained differently ("SVS bank + DC_SIGNED_BIT" or "SVS + BDC_SIGNED_BIT")
>      - "SVS bank + DC_SIGNED_BIT" is what we want for naming SVS_BDC_SIGNED_BIT but it might be misunderstood.
> 
>>
>>> +#define SVSB_MODE_INIT01               BIT(1)
>>> +#define SVSB_MODE_INIT02               BIT(2)
>>> +#define SVSB_MODE_MON                  BIT(3)
>>> +
>>> +/* svs bank init01 condition */
>>> +#define SVSB_INIT01_VOLT_IGNORE                BIT(1)
>>> +#define SVSB_INIT01_VOLT_INC_ONLY      BIT(2)
>>> +
>>> +/* svs bank common setting */
>>> +#define HIGH_TEMP_MAX                  (U32_MAX)
>>
>> nit: SVS_*
> 
> ok. I will add SVS or SVSB when it refers to SVS BANK.
> 
>>
>>> +#define RUNCONFIG_DEFAULT              (0x80000000)
>>
>> Btw, there is any public datasheet where I can see those addresses and
>> registers and bit fields?
> 
> Excuse us, there is no public datasheet. We can reply it on patchwork. Thanks.
> 
>>
>>> +#define DC_SIGNED_BIT                  (0x8000)
>>> +#define INTEN_INIT0x                   (0x00005f01)
>>> +#define INTEN_MONVOPEN                 (0x00ff0000)
>>> +#define SVSEN_OFF                      (0x0)
>>> +#define SVSEN_MASK                     (0x7)
>>> +#define SVSEN_INIT01                   (0x1)
>>> +#define SVSEN_INIT02                   (0x5)
>>> +#define SVSEN_MON                      (0x2)
>>> +#define INTSTS_MONVOP                  (0x00ff0000)
>>> +#define INTSTS_COMPLETE                        (0x1)
>>> +#define INTSTS_CLEAN                   (0x00ffffff)
>>> +
>>> +#define proc_fops_rw(name) \
>>> +       static int name ## _proc_open(struct inode *inode,      \
>>> +                                     struct file *file)        \
>>> +       {                                                       \
>>> +               return single_open(file, name ## _proc_show,    \
>>> +                                  PDE_DATA(inode));            \
>>> +       }                                                       \
>>> +       static const struct proc_ops name ## _proc_fops = {     \
>>> +               .proc_open      = name ## _proc_open,           \
>>> +               .proc_read      = seq_read,                     \
>>> +               .proc_lseek     = seq_lseek,                    \
>>> +               .proc_release   = single_release,               \
>>> +               .proc_write     = name ## _proc_write,          \
>>> +       }
>>> +
>>> +#define proc_fops_ro(name) \
>>> +       static int name ## _proc_open(struct inode *inode,      \
>>> +                                     struct file *file)        \
>>> +       {                                                       \
>>> +               return single_open(file, name ## _proc_show,    \
>>> +                                  PDE_DATA(inode));            \
>>> +       }                                                       \
>>> +       static const struct proc_ops name ## _proc_fops = {     \
>>> +               .proc_open      = name ## _proc_open,           \
>>> +               .proc_read      = seq_read,                     \
>>> +               .proc_lseek     = seq_lseek,                    \
>>> +               .proc_release   = single_release,               \
>>> +       }
>>> +
>>> +#define proc_entry(name)       {__stringify(name), &name ## _proc_fops}
>>> +
>>
>> /proc is usually the old way of exporting files to userspace, so
>> unless you have a really good reason use sysfs instead, or even
>> better, if it is only for debug purposes use debugfs. Also, you should
>> document the entries in Documentation.
> 
> Ok. I'll change it to debugfs and could you give us an example about entries in documentation?
> We can follow them. Thanks.
> 
>>
>>> +static DEFINE_SPINLOCK(mtk_svs_lock);
>>> +struct mtk_svs;
>>> +
>>> +enum svsb_phase {
>>
>> nit: mtk_svs_bphase?
> 
> ditto
> 
>>
>>> +       SVSB_PHASE_INIT01 = 0,
>>
>> nit: SVS_BPHASE_?
> 
> ditto
> 
>>
>>> +       SVSB_PHASE_INIT02,
>>> +       SVSB_PHASE_MON,
>>> +       SVSB_PHASE_ERROR,
>>> +};
>>> +
>>> +enum reg_index {
>>
>> nit: svs_reg_index?
> 
> OK. Thanks.
> 
>>
>>> +       TEMPMONCTL0 = 0,
>>> +       TEMPMONCTL1,
>>> +       TEMPMONCTL2,
>>> +       TEMPMONINT,
>>> +       TEMPMONINTSTS,
>>> +       TEMPMONIDET0,
>>> +       TEMPMONIDET1,
>>> +       TEMPMONIDET2,
>>> +       TEMPH2NTHRE,
>>> +       TEMPHTHRE,
>>> +       TEMPCTHRE,
>>> +       TEMPOFFSETH,
>>> +       TEMPOFFSETL,
>>> +       TEMPMSRCTL0,
>>> +       TEMPMSRCTL1,
>>> +       TEMPAHBPOLL,
>>> +       TEMPAHBTO,
>>> +       TEMPADCPNP0,
>>> +       TEMPADCPNP1,
>>> +       TEMPADCPNP2,
>>> +       TEMPADCMUX,
>>> +       TEMPADCEXT,
>>> +       TEMPADCEXT1,
>>> +       TEMPADCEN,
>>> +       TEMPPNPMUXADDR,
>>> +       TEMPADCMUXADDR,
>>> +       TEMPADCEXTADDR,
>>> +       TEMPADCEXT1ADDR,
>>> +       TEMPADCENADDR,
>>> +       TEMPADCVALIDADDR,
>>> +       TEMPADCVOLTADDR,
>>> +       TEMPRDCTRL,
>>> +       TEMPADCVALIDMASK,
>>> +       TEMPADCVOLTAGESHIFT,
>>> +       TEMPADCWRITECTRL,
>>> +       TEMPMSR0,
>>> +       TEMPMSR1,
>>> +       TEMPMSR2,
>>> +       TEMPADCHADDR,
>>> +       TEMPIMMD0,
>>> +       TEMPIMMD1,
>>> +       TEMPIMMD2,
>>> +       TEMPMONIDET3,
>>> +       TEMPADCPNP3,
>>> +       TEMPMSR3,
>>> +       TEMPIMMD3,
>>> +       TEMPPROTCTL,
>>> +       TEMPPROTTA,
>>> +       TEMPPROTTB,
>>> +       TEMPPROTTC,
>>> +       TEMPSPARE0,
>>> +       TEMPSPARE1,
>>> +       TEMPSPARE2,
>>> +       TEMPSPARE3,
>>> +       TEMPMSR0_1,
>>> +       TEMPMSR1_1,
>>> +       TEMPMSR2_1,
>>> +       TEMPMSR3_1,
>>> +       DESCHAR,
>>> +       TEMPCHAR,
>>> +       DETCHAR,
>>> +       AGECHAR,
>>> +       DCCONFIG,
>>> +       AGECONFIG,
>>> +       FREQPCT30,
>>> +       FREQPCT74,
>>> +       LIMITVALS,
>>> +       VBOOT,
>>> +       DETWINDOW,
>>> +       CONFIG,
>>> +       TSCALCS,
>>> +       RUNCONFIG,
>>> +       SVSEN,
>>> +       INIT2VALS,
>>> +       DCVALUES,
>>> +       AGEVALUES,
>>> +       VOP30,
>>> +       VOP74,
>>> +       TEMP,
>>> +       INTSTS,
>>> +       INTSTSRAW,
>>> +       INTEN,
>>> +       CHKINT,
>>> +       CHKSHIFT,
>>> +       STATUS,
>>> +       VDESIGN30,
>>> +       VDESIGN74,
>>> +       DVT30,
>>> +       DVT74,
>>> +       AGECOUNT,
>>> +       SMSTATE0,
>>> +       SMSTATE1,
>>> +       CTL0,
>>> +       DESDETSEC,
>>> +       TEMPAGESEC,
>>> +       CTRLSPARE0,
>>> +       CTRLSPARE1,
>>> +       CTRLSPARE2,
>>> +       CTRLSPARE3,
>>> +       CORESEL,
>>> +       THERMINTST,
>>> +       INTST,
>>> +       THSTAGE0ST,
>>> +       THSTAGE1ST,
>>> +       THSTAGE2ST,
>>> +       THAHBST0,
>>> +       THAHBST1,
>>> +       SPARE0,
>>> +       SPARE1,
>>> +       SPARE2,
>>> +       SPARE3,
>>> +       THSLPEVEB,
>>> +       reg_num,
>>> +};
>>> +
>>> +static const u32 svs_regs_v2[] = {
>>
>> Is this SoC specific or shared between SoCs?
> 
> Shared between SoCs. Some SVS in MTK SoCs use v2 register map.
> 

And which silicon uses v1 then? Is v2 a MediaTek internal naming you want to keep?

>>
>>> +       [TEMPMONCTL0]           = 0x000,
>>> +       [TEMPMONCTL1]           = 0x004,
>>> +       [TEMPMONCTL2]           = 0x008,
>>> +       [TEMPMONINT]            = 0x00c,
>>> +       [TEMPMONINTSTS]         = 0x010,
>>> +       [TEMPMONIDET0]          = 0x014,
>>> +       [TEMPMONIDET1]          = 0x018,
>>> +       [TEMPMONIDET2]          = 0x01c,
>>> +       [TEMPH2NTHRE]           = 0x024,
>>> +       [TEMPHTHRE]             = 0x028,
>>> +       [TEMPCTHRE]             = 0x02c,
>>> +       [TEMPOFFSETH]           = 0x030,
>>> +       [TEMPOFFSETL]           = 0x034,
>>> +       [TEMPMSRCTL0]           = 0x038,
>>> +       [TEMPMSRCTL1]           = 0x03c,
>>> +       [TEMPAHBPOLL]           = 0x040,
>>> +       [TEMPAHBTO]             = 0x044,
>>> +       [TEMPADCPNP0]           = 0x048,
>>> +       [TEMPADCPNP1]           = 0x04c,
>>> +       [TEMPADCPNP2]           = 0x050,
>>> +       [TEMPADCMUX]            = 0x054,
>>> +       [TEMPADCEXT]            = 0x058,
>>> +       [TEMPADCEXT1]           = 0x05c,
>>> +       [TEMPADCEN]             = 0x060,
>>> +       [TEMPPNPMUXADDR]        = 0x064,
>>> +       [TEMPADCMUXADDR]        = 0x068,
>>> +       [TEMPADCEXTADDR]        = 0x06c,
>>> +       [TEMPADCEXT1ADDR]       = 0x070,
>>> +       [TEMPADCENADDR]         = 0x074,
>>> +       [TEMPADCVALIDADDR]      = 0x078,
>>> +       [TEMPADCVOLTADDR]       = 0x07c,
>>> +       [TEMPRDCTRL]            = 0x080,
>>> +       [TEMPADCVALIDMASK]      = 0x084,
>>> +       [TEMPADCVOLTAGESHIFT]   = 0x088,
>>> +       [TEMPADCWRITECTRL]      = 0x08c,
>>> +       [TEMPMSR0]              = 0x090,
>>> +       [TEMPMSR1]              = 0x094,
>>> +       [TEMPMSR2]              = 0x098,
>>> +       [TEMPADCHADDR]          = 0x09c,
>>> +       [TEMPIMMD0]             = 0x0a0,
>>> +       [TEMPIMMD1]             = 0x0a4,
>>> +       [TEMPIMMD2]             = 0x0a8,
>>> +       [TEMPMONIDET3]          = 0x0b0,
>>> +       [TEMPADCPNP3]           = 0x0b4,
>>> +       [TEMPMSR3]              = 0x0b8,
>>> +       [TEMPIMMD3]             = 0x0bc,
>>> +       [TEMPPROTCTL]           = 0x0c0,
>>> +       [TEMPPROTTA]            = 0x0c4,
>>> +       [TEMPPROTTB]            = 0x0c8,
>>> +       [TEMPPROTTC]            = 0x0cc,
>>> +       [TEMPSPARE0]            = 0x0f0,
>>> +       [TEMPSPARE1]            = 0x0f4,
>>> +       [TEMPSPARE2]            = 0x0f8,
>>> +       [TEMPSPARE3]            = 0x0fc,
>>> +       [TEMPMSR0_1]            = 0x190,
>>> +       [TEMPMSR1_1]            = 0x194,
>>> +       [TEMPMSR2_1]            = 0x198,
>>> +       [TEMPMSR3_1]            = 0x1b8,
>>> +       [DESCHAR]               = 0xc00,
>>> +       [TEMPCHAR]              = 0xc04,
>>> +       [DETCHAR]               = 0xc08,
>>> +       [AGECHAR]               = 0xc0c,
>>> +       [DCCONFIG]              = 0xc10,
>>> +       [AGECONFIG]             = 0xc14,
>>> +       [FREQPCT30]             = 0xc18,
>>> +       [FREQPCT74]             = 0xc1c,
>>> +       [LIMITVALS]             = 0xc20,
>>> +       [VBOOT]                 = 0xc24,
>>> +       [DETWINDOW]             = 0xc28,
>>> +       [CONFIG]                = 0xc2c,
>>> +       [TSCALCS]               = 0xc30,
>>> +       [RUNCONFIG]             = 0xc34,
>>> +       [SVSEN]                 = 0xc38,
>>> +       [INIT2VALS]             = 0xc3c,
>>> +       [DCVALUES]              = 0xc40,
>>> +       [AGEVALUES]             = 0xc44,
>>> +       [VOP30]                 = 0xc48,
>>> +       [VOP74]                 = 0xc4c,
>>> +       [TEMP]                  = 0xc50,
>>> +       [INTSTS]                = 0xc54,
>>> +       [INTSTSRAW]             = 0xc58,
>>> +       [INTEN]                 = 0xc5c,
>>> +       [CHKINT]                = 0xc60,
>>> +       [CHKSHIFT]              = 0xc64,
>>> +       [STATUS]                = 0xc68,
>>> +       [VDESIGN30]             = 0xc6c,
>>> +       [VDESIGN74]             = 0xc70,
>>> +       [DVT30]                 = 0xc74,
>>> +       [DVT74]                 = 0xc78,
>>> +       [AGECOUNT]              = 0xc7c,
>>> +       [SMSTATE0]              = 0xc80,
>>> +       [SMSTATE1]              = 0xc84,
>>> +       [CTL0]                  = 0xc88,
>>> +       [DESDETSEC]             = 0xce0,
>>> +       [TEMPAGESEC]            = 0xce4,
>>> +       [CTRLSPARE0]            = 0xcf0,
>>> +       [CTRLSPARE1]            = 0xcf4,
>>> +       [CTRLSPARE2]            = 0xcf8,
>>> +       [CTRLSPARE3]            = 0xcfc,
>>> +       [CORESEL]               = 0xf00,
>>> +       [THERMINTST]            = 0xf04,
>>> +       [INTST]                 = 0xf08,
>>> +       [THSTAGE0ST]            = 0xf0c,
>>> +       [THSTAGE1ST]            = 0xf10,
>>> +       [THSTAGE2ST]            = 0xf14,
>>> +       [THAHBST0]              = 0xf18,
>>> +       [THAHBST1]              = 0xf1c,
>>> +       [SPARE0]                = 0xf20,
>>> +       [SPARE1]                = 0xf24,
>>> +       [SPARE2]                = 0xf28,
>>> +       [SPARE3]                = 0xf2c,
>>> +       [THSLPEVEB]             = 0xf30,
>>> +};
>>> +
>>> +struct thermal_parameter {
>>
>> In general, not only in this struct, would be good have some
>> documentation to have a better undestanding of the fields. That makes
>> the job of the reviewer a bit easier.
> 
> Ok. Could you share a documentation example to us? We'll share the
> information as much as we can. Thanks a lot.
> 

you should find that in all drivers, eg:
https://elixir.bootlin.com/linux/latest/source/drivers/soc/mediatek/mtk-scpsys.c#L111


Regards,
Matthias
