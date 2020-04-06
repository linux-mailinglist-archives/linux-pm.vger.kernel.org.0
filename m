Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FADE19F171
	for <lists+linux-pm@lfdr.de>; Mon,  6 Apr 2020 10:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgDFISL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Apr 2020 04:18:11 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55244 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbgDFISL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Apr 2020 04:18:11 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0368HUvb124787;
        Mon, 6 Apr 2020 03:17:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1586161050;
        bh=dBNRdO4qjuUg0RS1p/z67TE2khhRn2hu1uvilxmf+c0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=e+t0jx7+2BdPzDD4c47L46lozlZZaC6OkEtj7jZUFAFnIPnRjvA0pHPGSmJv0jA2t
         tolAaqWvl4UhUHzaIardb8IELE8ZbCfwEFoBcCnuszVl4SkYKtJpnPN8K1ko4R+dS9
         xODVjfifgPDKo+MIQt52PzzLlCguJKaWHHWh9M/g=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0368HUom120221;
        Mon, 6 Apr 2020 03:17:30 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 6 Apr
 2020 03:17:29 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 6 Apr 2020 03:17:29 -0500
Received: from [10.250.133.125] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0368HMcQ118835;
        Mon, 6 Apr 2020 03:17:23 -0500
Subject: Re: [PATCH] thermal: Delete an error message in four functions
To:     Amit Kucheria <amit.kucheria@verdurent.com>,
        Markus Elfring <Markus.Elfring@web.de>
CC:     Linux PM list <linux-pm@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-omap@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Allison Randal <allison@lohutok.net>,
        Clark Williams <williams@redhat.com>,
        Colin Ian King <colin.king@canonical.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Pascal Paillet <p.paillet@st.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Tang Bin <tangbin@cmss.chinamobile.com>
References: <05f49ae7-5cc7-d6a0-fc3d-abaf2a0b373c@web.de>
 <CAHLCerMS5ghVXhOD7RAd5unxEe7w1W4_8hBP5Tf9HvuMEh5Lqg@mail.gmail.com>
From:   "J, KEERTHY" <j-keerthy@ti.com>
Message-ID: <ac59c663-18a5-5bbf-09da-2cd8d034138c@ti.com>
Date:   Mon, 6 Apr 2020 13:47:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAHLCerMS5ghVXhOD7RAd5unxEe7w1W4_8hBP5Tf9HvuMEh5Lqg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 4/6/2020 1:00 PM, Amit Kucheria wrote:
> On Sun, Apr 5, 2020 at 10:21 PM Markus Elfring <Markus.Elfring@web.de> wrote:
>>
>> From: Markus Elfring <elfring@users.sourceforge.net>
>> Date: Sun, 5 Apr 2020 18:35:16 +0200
>>
>> The function “platform_get_irq” can log an error already.
>> Thus omit redundant messages for the exception handling in the
>> calling functions.
>>
>> This issue was detected by using the Coccinelle software.
>>
>> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Reviewed-by: Keerthy <j-keerthy@ti.com>

> 
> Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
> 
>> ---
>>   drivers/thermal/rockchip_thermal.c          | 4 +---
>>   drivers/thermal/st/st_thermal_memmap.c      | 4 +---
>>   drivers/thermal/st/stm_thermal.c            | 4 +---
>>   drivers/thermal/ti-soc-thermal/ti-bandgap.c | 5 ++---
>>   4 files changed, 5 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
>> index 7c1a8bccdcba..15a71ecc916c 100644
>> --- a/drivers/thermal/rockchip_thermal.c
>> +++ b/drivers/thermal/rockchip_thermal.c
>> @@ -1241,10 +1241,8 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
>>                  return -ENXIO;
>>
>>          irq = platform_get_irq(pdev, 0);
>> -       if (irq < 0) {
>> -               dev_err(&pdev->dev, "no irq resource?\n");
>> +       if (irq < 0)
>>                  return -EINVAL;
>> -       }
>>
>>          thermal = devm_kzalloc(&pdev->dev, sizeof(struct rockchip_thermal_data),
>>                                 GFP_KERNEL);
>> diff --git a/drivers/thermal/st/st_thermal_memmap.c b/drivers/thermal/st/st_thermal_memmap.c
>> index a824b78dabf8..a0114452d11f 100644
>> --- a/drivers/thermal/st/st_thermal_memmap.c
>> +++ b/drivers/thermal/st/st_thermal_memmap.c
>> @@ -94,10 +94,8 @@ static int st_mmap_register_enable_irq(struct st_thermal_sensor *sensor)
>>          int ret;
>>
>>          sensor->irq = platform_get_irq(pdev, 0);
>> -       if (sensor->irq < 0) {
>> -               dev_err(dev, "failed to register IRQ\n");
>> +       if (sensor->irq < 0)
>>                  return sensor->irq;
>> -       }
>>
>>          ret = devm_request_threaded_irq(dev, sensor->irq,
>>                                          NULL, st_mmap_thermal_trip_handler,
>> diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
>> index 9314e3df6a42..331e2b768df5 100644
>> --- a/drivers/thermal/st/stm_thermal.c
>> +++ b/drivers/thermal/st/stm_thermal.c
>> @@ -385,10 +385,8 @@ static int stm_register_irq(struct stm_thermal_sensor *sensor)
>>          int ret;
>>
>>          sensor->irq = platform_get_irq(pdev, 0);
>> -       if (sensor->irq < 0) {
>> -               dev_err(dev, "%s: Unable to find IRQ\n", __func__);
>> +       if (sensor->irq < 0)
>>                  return sensor->irq;
>> -       }
>>
>>          ret = devm_request_threaded_irq(dev, sensor->irq,
>>                                          NULL,
>> diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
>> index 263b0420fbe4..ab19ceff6e2a 100644
>> --- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
>> +++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
>> @@ -772,10 +772,9 @@ static int ti_bandgap_talert_init(struct ti_bandgap *bgp,
>>          int ret;
>>
>>          bgp->irq = platform_get_irq(pdev, 0);
>> -       if (bgp->irq < 0) {
>> -               dev_err(&pdev->dev, "get_irq failed\n");
>> +       if (bgp->irq < 0)
>>                  return bgp->irq;
>> -       }
>> +
>>          ret = request_threaded_irq(bgp->irq, NULL,
>>                                     ti_bandgap_talert_irq_handler,
>>                                     IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
>> --
>> 2.26.0
>>
