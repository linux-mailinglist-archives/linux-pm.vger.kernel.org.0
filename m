Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40DAD281AEC
	for <lists+linux-pm@lfdr.de>; Fri,  2 Oct 2020 20:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgJBSgK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Oct 2020 14:36:10 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36698 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgJBSgK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Oct 2020 14:36:10 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 092IZtGh100976;
        Fri, 2 Oct 2020 13:35:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601663755;
        bh=Q/b213DN9pBG8z9P9f7LUhk6lPocLe7B6VcQLRWIdks=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=VzvxoywLNUA8MtX6cuP4S5nxPIvKc9NrKOf2UagtGDr1A+g6+vhTBpf+LVDFmdXox
         UAtL/lNSNJac2oZk+EnEELRX2c5Cyv2lE471hBe5scPa1kXnIOwDZ4bJTS7iFnkP/r
         EhpeyBj0qnSjJaWZSfVum1lTl3Bxe7wFp9OSoHJ4=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 092IZtA1104544
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 2 Oct 2020 13:35:55 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 2 Oct
 2020 13:35:55 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 2 Oct 2020 13:35:55 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 092IZom0128432;
        Fri, 2 Oct 2020 13:35:51 -0500
Subject: Re: [PATCH v1] of: platform: Batch fwnode parsing in the
 init_machine() path
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Saravana Kannan <saravanak@google.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CAGETcx8owDP_Bu4oNCyHEsME8XpKygxghm8+yNc2RyMA4wyjCA@mail.gmail.com>
 <20201001225952.3676755-1-saravanak@google.com>
 <CAL_JsqKOUkKBKyxPtZ+BFXPiOfm2uPXhgJPxKP=WS-qX6kSB0w@mail.gmail.com>
 <CAGETcx-tq446JQN0RpKhtyCXB+Y_PUePN_tBZsUmtpO7othm4g@mail.gmail.com>
 <20201002175423.GE3933@pendragon.ideasonboard.com>
 <CAGETcx-7nJaU6pDo_KL-nKmCaxv57C5aaXq-pvo4XiN=N0K5Jg@mail.gmail.com>
 <20201002182712.GF3933@pendragon.ideasonboard.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <11018e7e-a6a1-2df6-5639-821a7c0cb68b@ti.com>
Date:   Fri, 2 Oct 2020 21:35:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201002182712.GF3933@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

hi Saravana,

On 02/10/2020 21:27, Laurent Pinchart wrote:
> Hi Saravana,
> 
> On Fri, Oct 02, 2020 at 10:58:55AM -0700, Saravana Kannan wrote:
>> On Fri, Oct 2, 2020 at 10:55 AM Laurent Pinchart wrote:
>>> On Fri, Oct 02, 2020 at 10:51:51AM -0700, Saravana Kannan wrote:
>>>> On Fri, Oct 2, 2020 at 7:08 AM Rob Herring <robh+dt@kernel.org> wrote:
>>>>> On Thu, Oct 1, 2020 at 5:59 PM Saravana Kannan <saravanak@google.com> wrote:
>>>>>>
>>>>>> When commit 93d2e4322aa7 ("of: platform: Batch fwnode parsing when
>>>>>> adding all top level devices") optimized the fwnode parsing when all top
>>>>>> level devices are added, it missed out optimizing this for platform
>>>>>> where the top level devices are added through the init_machine() path.
>>>>>>
>>>>>> This commit does the optimization for all paths by simply moving the
>>>>>> fw_devlink_pause/resume() inside of_platform_default_populate().
>>>>>>
>>>>>> Reported-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>>>>>> Signed-off-by: Saravana Kannan <saravanak@google.com>
>>>>>> ---
>>>>>>   drivers/of/platform.c | 19 +++++++++++++++----
>>>>>>   1 file changed, 15 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
>>>>>> index 071f04da32c8..79972e49b539 100644
>>>>>> --- a/drivers/of/platform.c
>>>>>> +++ b/drivers/of/platform.c
>>>>>> @@ -501,8 +501,21 @@ int of_platform_default_populate(struct device_node *root,
>>>>>>                                   const struct of_dev_auxdata *lookup,
>>>>>>                                   struct device *parent)
>>>>>>   {
>>>>>> -       return of_platform_populate(root, of_default_bus_match_table, lookup,
>>>>>> -                                   parent);
>>>>>> +       int ret;
>>>>>> +
>>>>>> +       /*
>>>>>> +        * fw_devlink_pause/resume() are only safe to be called around top
>>>>>> +        * level device addition due to locking constraints.
>>>>>> +        */
>>>>>> +       if (!root)
>>>>>> +               fw_devlink_pause();
>>>>>> +
>>>>>> +       ret = of_platform_populate(root, of_default_bus_match_table, lookup,
>>>>>> +                                  parent);
>>>>>
>>>>> of_platform_default_populate() vs. of_platform_populate() is just a
>>>>> different match table. I don't think the behavior should otherwise be
>>>>> different.
>>>>>
>>>>> There's also of_platform_probe() which has slightly different matching
>>>>> behavior. It should not behave differently either with respect to
>>>>> devlinks.
>>>>
>>>> So I'm trying to do this only when the top level devices are added for
>>>> the first time. of_platform_default_populate() seems to be the most
>>>> common path. For other cases, I think we just need to call
>>>> fw_devlink_pause/resume() wherever the top level devices are added for
>>>> the first time. As I said in the other email, we can't add
>>>> fw_devlink_pause/resume() by default to of_platform_populate().
>>>>
>>>> Do you have other ideas for achieving "call fw_devlink_pause/resume()
>>>> only when top level devices are added for the first time"?
>>>
>>> I'm not an expert in this domain, but before investigating it, would you
>>> be able to share a hack patch that implements this (in the most simple
>>> way) to check if it actually fixes the delays I experience on my system
>>> ?
>>
>> So I take it the patch I sent out didn't work for you? Can you tell me
>> what machine/DT you are using?
> 
> I've replied to the patch:
> 
> Based on v5.9-rc5, before the patch:
> 
> [    0.652887] cpuidle: using governor menu
> [   12.349476] No ATAGs?
> 
> After the patch:
> 
> [    0.650460] cpuidle: using governor menu
> [   12.262101] No ATAGs?
> 
> I'm using an AM57xx EVM, whose DT is not upstream, but it's essentially
> a am57xx-beagle-x15-revb1.dts (it includes that DTS) with a few
> additional nodes for GPIO keys, LCD panel, backlight and touchscreen.
> 

hope you are receiving my mails as I've provided you with all required information already [1]

with below diff:
[    4.177231] Freeing unused kernel memory: 1024K
[    4.181892] Run /sbin/init as init process

The best time with [2] is
[    3.100483] Run /sbin/init as init process

Still 1 sec lose.

Pls understand an issue - requirements here are like 500ms boot with can, Ethernet, camera and display on ;(

[1] https://lore.kernel.org/patchwork/patch/1316134/#1511276
[2] https://lore.kernel.org/patchwork/patch/1316134/#1511435

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 2a4fe3e68b82..ac1ab8928190 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -591,7 +591,9 @@ void __init pdata_quirks_init(const struct of_device_id *omap_dt_match_table)
         if (of_machine_is_compatible("ti,omap3"))
                 omap3_mcbsp_init();
         pdata_quirks_check(auxdata_quirks);
+       fw_devlink_pause();
         of_platform_populate(NULL, omap_dt_match_table,
                              omap_auxdata_lookup, NULL);
+       fw_devlink_resume();
         pdata_quirks_check(pdata_quirks);
  }


-- 
Best regards,
grygorii
