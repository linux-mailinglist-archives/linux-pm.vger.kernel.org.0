Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8782EBDDE
	for <lists+linux-pm@lfdr.de>; Wed,  6 Jan 2021 13:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbhAFMuh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Jan 2021 07:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbhAFMuh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Jan 2021 07:50:37 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B850BC061357
        for <linux-pm@vger.kernel.org>; Wed,  6 Jan 2021 04:49:56 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id c124so2332704wma.5
        for <linux-pm@vger.kernel.org>; Wed, 06 Jan 2021 04:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=/TFNqMpjunBcCKiBrnJeP1y//MIqYHWIDR79kkwgfkE=;
        b=sfyGdo3EWT8gzyt2KwZFAV2LDV/McqqryurFOfjaIbHKRCP4fQb27tRRH8M23FaAhE
         945R71c4322OL7XhYfrbBQEZ05JUrtgPLRjK9bhbeH+MK1jFGCpMkMlqBiuVNO9r6iZo
         Zri8qk+Z/hYPnRDL6f8me30sUXLW962btc9aBcbe2ao6+x11LVZsXRAkqmqR540gGF9N
         RHw8emMoe+c1RLAiRGOgF/TyNaFiMeXTTAiF/2yt5vWy1NIrFd3rsdkuqSYAWaf0zs1/
         mFWC0Ut+kYnKqdD4VdQbsX+UAAh7wwSzHOYJC8az9BMCrdTfdj/5QJOAN2bZKV9Y5z5c
         ZsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/TFNqMpjunBcCKiBrnJeP1y//MIqYHWIDR79kkwgfkE=;
        b=pL+7sgVbVvfVqKt+iXJEBgofjsBnWPOzPgNDGy4wwKfVvZ1hCKtEjUpcMN6FJ3fDL5
         GAiVTL0cxSn0hUWdfJn/H9SsPtbpzVWmBbwqFVtNHgW2UcEqvssyL6UBNVrQtVB2JjoD
         xwjRafU7bXC/3TnPW+4jGM3AjS+MgjeLvNFN2MSXewe2wyGsjgcWnLzfpN7sEF0FwNA6
         XkVVnjDkbuxC0IUFYcuPQ30eYIQHkQVmtvt1r+Vv2LaUIcgxtrQuMrPre0YGPZEXODL4
         OeWZo7tpD7XJgQgESTsktGLXwROxUay0wUMOuTz1wXS8K1ra8Np+MJRO3yZpdfFZYLIW
         2qmA==
X-Gm-Message-State: AOAM5315dRGPHzFm3jWwAhdJ4FHCXEwu7i6CxGHpm98gOKaTXjAbS2/+
        UjLO5jjkPpGlVIZSUE/jib1DS5uDGqXJVA==
X-Google-Smtp-Source: ABdhPJyALikTC19hcprzApRUBK4PYCJ8dtTZah4EqhL5+ULtjNc3izsNuUYa1xkbqfRLADF5kGFFdQ==
X-Received: by 2002:a1c:7716:: with SMTP id t22mr3526846wmi.126.1609937395097;
        Wed, 06 Jan 2021 04:49:55 -0800 (PST)
Received: from MacBook-Pro.local ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id z6sm2990551wrw.58.2021.01.06.04.49.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jan 2021 04:49:54 -0800 (PST)
Subject: Re: [PATCH V6 08/13] interconnect: mediatek: Add interconnect
 provider driver
To:     =?UTF-8?B?SGVucnlDIENoZW4gKOmZs+W7uuixqik=?= 
        <HenryC.Chen@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        =?UTF-8?B?RmFuIENoZW4gKOmZs+WHoSk=?= <fan.chen@mediatek.com>,
        =?UTF-8?B?SmFtZXNKSiBMaWFvICjlu5blu7rmmbop?= 
        <jamesjj.liao@mediatek.com>,
        =?UTF-8?B?QXJ2aW4gV2FuZyAo546L5b+X6YqYKQ==?= 
        <Arvin.Wang@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <1608790134-27425-1-git-send-email-henryc.chen@mediatek.com>
 <1608790134-27425-9-git-send-email-henryc.chen@mediatek.com>
 <c8b951b0-6412-d905-99e1-6350283b57c1@linaro.org>
 <1609918232.23066.5.camel@mtksdaap41>
 <a416a55c-0a7e-6505-ef53-b03f5dbc6cdc@linaro.org>
 <c9b360dcb17e452595f45adb51dd4c31@mtkmbs02n1.mediatek.inc>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Message-ID: <88d123cf-c69e-dc7f-ddf1-f9ade47d33fc@linaro.org>
Date:   Wed, 6 Jan 2021 14:49:51 +0200
MIME-Version: 1.0
In-Reply-To: <c9b360dcb17e452595f45adb51dd4c31@mtkmbs02n1.mediatek.inc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 6.01.21 12:44, HenryC Chen (陳建豪) wrote:
>> -----Original Message-----
>> From: Georgi Djakov [mailto:georgi.djakov@linaro.org]
>> Sent: Wednesday, January 06, 2021 4:14 PM
>> To: HenryC Chen (陳建豪)
>> Cc: Rob Herring; Matthias Brugger; Stephen Boyd; Ryan Case; Mark Brown; Mark
>> Rutland; Nicolas Boichat; Fan Chen (陳凡); JamesJJ Liao (廖建智); Arvin Wang
>> (王志銘); devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>> linux-mediatek@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
>> pm@vger.kernel.org
>> Subject: Re: [PATCH V6 08/13] interconnect: mediatek: Add interconnect
>> provider driver
>> 
>> On 1/6/21 09:30, Henry Chen wrote:
>> > On Mon, 2021-01-04 at 20:36 +0200, Georgi Djakov wrote:
>> >> On 12/24/20 08:08, Henry Chen wrote:
>> >>> Introduce Mediatek MT6873/MT8183/MT8192 specific provider driver
>> >>> using the interconnect framework.
>> >>>
>> >>>                ICC provider         ICC Nodes
>> >>>                                 ----          ----
>> >>>                ---------       |CPU |   |--- |VPU |
>> >>>       -----   |         |-----  ----    |     ----
>> >>>      |DRAM |--|DRAM     |       ----    |     ----
>> >>>      |     |--|scheduler|----- |GPU |   |--- |DISP|
>> >>>      |     |--|(EMI)    |       ----    |     ----
>> >>>      |     |--|         |       -----   |     ----
>> >>>       -----   |         |----- |MMSYS|--|--- |VDEC|
>> >>>                ---------        -----   |     ----
>> >>>                  /|\                    |     ----
>> >>>                   |change DRAM freq     |--- |VENC|
>> >>>                ----------               |     ----
>> >>>               |  DVFSR   |              |
>> >>>               |          |              |     ----
>> >>>                ----------               |--- |IMG |
>> >>>                                         |     ----
>> >>>                                         |     ----
>> >>>                                         |--- |CAM |
>> >>>                                               ----
>> >>>
>> >>> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
>> >>> ---
>> >>>    drivers/interconnect/Kconfig            |   1 +
>> >>>    drivers/interconnect/Makefile           |   1 +
>> >>>    drivers/interconnect/mediatek/Kconfig   |  13 ++
>> >>>    drivers/interconnect/mediatek/Makefile  |   3 +
>> >>>    drivers/interconnect/mediatek/mtk-emi.c | 330
>> ++++++++++++++++++++++++++++++++
>> >>>    5 files changed, 348 insertions(+)
>> >>>    create mode 100644 drivers/interconnect/mediatek/Kconfig
>> >>>    create mode 100644 drivers/interconnect/mediatek/Makefile
>> >>>    create mode 100644 drivers/interconnect/mediatek/mtk-emi.c
>> >>>
>> >>> diff --git a/drivers/interconnect/Kconfig
>> >>> b/drivers/interconnect/Kconfig index 5b7204e..e939f5a 100644
>> >>> --- a/drivers/interconnect/Kconfig
>> >>> +++ b/drivers/interconnect/Kconfig
>> >>> @@ -13,5 +13,6 @@ if INTERCONNECT
>> >>>
>> >>>    source "drivers/interconnect/imx/Kconfig"
>> >>>    source "drivers/interconnect/qcom/Kconfig"
>> >>> +source "drivers/interconnect/mediatek/Kconfig"
>> >>
>> >> Sort alphabetically please.
>> > Ok
>> >>
>> >>>
>> >>>    endif
>> >>> diff --git a/drivers/interconnect/Makefile
>> >>> b/drivers/interconnect/Makefile index d203520..0643a24 100644
>> >>> --- a/drivers/interconnect/Makefile
>> >>> +++ b/drivers/interconnect/Makefile
>> >>> @@ -6,3 +6,4 @@ icc-core-objs:= core.o bulk.o
>> >>>    obj-$(CONFIG_INTERCONNECT)+= icc-core.o
>> >>>    obj-$(CONFIG_INTERCONNECT_IMX)+= imx/
>> >>>    obj-$(CONFIG_INTERCONNECT_QCOM)+= qcom/
>> >>> +obj-$(CONFIG_INTERCONNECT_MTK)+= mediatek/
>> >>
>> >> Ditto.
>> > Ok
>> >>
>> >>> diff --git a/drivers/interconnect/mediatek/Kconfig
>> >>> b/drivers/interconnect/mediatek/Kconfig
>> >>> new file mode 100644
>> >>> index 0000000..972d3bb
>> >>> --- /dev/null
>> >>> +++ b/drivers/interconnect/mediatek/Kconfig
>> >>> @@ -0,0 +1,13 @@
>> >>> +config INTERCONNECT_MTK
>> >>> +bool "Mediatek Network-on-Chip interconnect drivers"
>> >>> +depends on ARCH_MEDIATEK
>> >>> +help
>> >>> +  Support for Mediatek's Network-on-Chip interconnect hardware.
>> >>> +
>> >>> +config INTERCONNECT_MTK_EMI
>> >>> +tristate "Mediatek EMI interconnect driver"
>> >>> +depends on INTERCONNECT_MTK
>> >>> +depends on (MTK_DVFSRC && OF)
>> >>
>> >> Would it be possible to enable COMPILE_TEST?
>> > Do you means change to "depends on (MTK_DVFSRC && OF) || COMPILE_TEST" ?
>> 
>> Yeah, there is a stub for mtk_dvfsrc_send_request(). Maybe we could even
>> change it for INTERCONNECT_MTK to something like:
>> depends on ARCH_MEDIATEK || COMPILE_TEST Will this work?
> Hi Georgi,
> 
> So..only change to as following?
> 
> config INTERCONNECT_MTK
> bool "Mediatek Network-on-Chip interconnect drivers"
> depends on ARCH_MEDIATEK || COMPILE_TEST
> help
>    Support for Mediatek's Network-on-Chip interconnect hardware.

I would say to add COMPILE_TEST for both INTERCONNECT_MTK and
INTERCONNECT_MTK_EMI, unless there is some dependency which does
not allow us to do so.

Thanks,
Georgi

