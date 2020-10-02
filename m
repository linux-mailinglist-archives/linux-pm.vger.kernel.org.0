Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858D9281AA4
	for <lists+linux-pm@lfdr.de>; Fri,  2 Oct 2020 20:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387602AbgJBSLn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Oct 2020 14:11:43 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59866 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBSLm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Oct 2020 14:11:42 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 092IBSqr092465;
        Fri, 2 Oct 2020 13:11:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601662288;
        bh=FrG+09mt+C6MwBdbdxNRK4ndGXEpqzZKrDi9Tb3hMr4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=idPX+SntM348a4zjFy3y23URBnUA3fN5DgNzf35MZqeH5/ImNtli4IFyIVy8s5rPX
         QytTtST7OVYXmQvNkH/ullG5IdtdHa0O1WOR7qfmtkqZwqMD/vXrc5/6ug+1pA3YO0
         zOJ1A43sA3T5jEszN2giQy6h4qOQGxBqyxCmlw30=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 092IBSj5031587
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 2 Oct 2020 13:11:28 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 2 Oct
 2020 13:11:28 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 2 Oct 2020 13:11:28 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 092IBN8W122280;
        Fri, 2 Oct 2020 13:11:24 -0500
Subject: Re: [PATCH v1] of: platform: Batch fwnode parsing in the
 init_machine() path
To:     Saravana Kannan <saravanak@google.com>
CC:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <CAGETcx8owDP_Bu4oNCyHEsME8XpKygxghm8+yNc2RyMA4wyjCA@mail.gmail.com>
 <20201001225952.3676755-1-saravanak@google.com>
 <20201001231922.GG3722@pendragon.ideasonboard.com>
 <17bdc3f0-d816-151a-fef2-88cd38fc8621@ti.com>
 <e0ef8816-11ea-3a1a-cac6-14b9f6c92bcf@ti.com>
 <CAGETcx-wkZZQyfnkc59e2ECg_kho-O_c2ms4OOtM4=-Hd125+Q@mail.gmail.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <65bfd5be-8a10-4575-41a5-94e2f4ca2729@ti.com>
Date:   Fri, 2 Oct 2020 21:11:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAGETcx-wkZZQyfnkc59e2ECg_kho-O_c2ms4OOtM4=-Hd125+Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 02/10/2020 20:48, Saravana Kannan wrote:
> On Fri, Oct 2, 2020 at 8:03 AM 'Grygorii Strashko' via kernel-team
> <kernel-team@android.com> wrote:
>>
>>
>>
>> On 02/10/2020 14:40, Grygorii Strashko wrote:
>>>
>>>
>>> On 02/10/2020 02:19, Laurent Pinchart wrote:
>>>> Hi Saravana,
>>>>
>>>> Thank you for the patch.
>>>>
>>>> On Thu, Oct 01, 2020 at 03:59:51PM -0700, Saravana Kannan wrote:
>>>>> When commit 93d2e4322aa7 ("of: platform: Batch fwnode parsing when
>>>>> adding all top level devices") optimized the fwnode parsing when all top
>>>>> level devices are added, it missed out optimizing this for platform
>>>>> where the top level devices are added through the init_machine() path.
>>>>>
>>>>> This commit does the optimization for all paths by simply moving the
>>>>> fw_devlink_pause/resume() inside of_platform_default_populate().
>>>>
>>>> Based on v5.9-rc5, before the patch:
>>>>
>>>> [    0.652887] cpuidle: using governor menu
>>>> [   12.349476] No ATAGs?
>>>>
>>>> After the patch:
>>>>
>>>> [    0.650460] cpuidle: using governor menu
>>>> [   12.262101] No ATAGs?
>>>>
>>>> :-(
>>>
>>> This is kinda expected :( because omap2 arch doesn't call of_platform_default_populate()
>>>
>>> Call path:
>>> board-generic.c
>>>    DT_MACHINE_START()
>>>      .init_machine    = omap_generic_init,
>>>
>>>    omap_generic_init()
>>>      pdata_quirks_init(omap_dt_match_table);
>>>           of_platform_populate(NULL, omap_dt_match_table,
>>>                    omap_auxdata_lookup, NULL);
>>>
>>> Other affected platforms
>>> arm: mach-ux500
>>> some mips
>>> some powerpc
>>>
>>> there are also case when a lot of devices placed under bus node, in such case
>>>    of_platform_populate() calls from bus drivers will also suffer from this issue.
>>>
>>> I think one option could be to add some parameter to _populate() or introduce new api.
>>>
>>> By the way, is there option to disable this feature at all?
>>> Is there Kconfig option?
>>> Is there any reasons why such complex and time consuming code added to the kernel and not implemented on DTC level?
>>>
>>>
>>> Also, I've came with another diff, pls check.
>>>
>>> [    0.000000] Booting Linux on physical CPU 0x0
>>> [    0.000000] Linux version 5.9.0-rc6-01791-g9acba6b38757-dirty (grygorii@grygorii-XPS-13-9370) (arm-linux-gnueabihf-gcc (GNU Toolcha0
>>> [    0.000000] CPU: ARMv7 Processor [412fc0f2] revision 2 (ARMv7), cr=10c5387d
>>> [    0.000000] CPU: div instructions available: patching division code
>>> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
>>> [    0.000000] OF: fdt: Machine model: TI AM5718 IDK
>>> ...
>>> [    0.053443] cpuidle: using governor ladder
>>> [    0.053470] cpuidle: using governor menu
>>> [    0.089304] No ATAGs?
>>> ...
>>> [    3.092291] devtmpfs: mounted
>>> [    3.095804] Freeing unused kernel memory: 1024K
>>> [    3.100483] Run /sbin/init as init process
>>>
>>>
>>>
>>> ------ >< ---
>>> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
>>> index 071f04da32c8..4521b26e7745 100644
>>> --- a/drivers/of/platform.c
>>> +++ b/drivers/of/platform.c
>>> @@ -514,6 +514,12 @@ static const struct of_device_id reserved_mem_matches[] = {
>>>           {}
>>>    };
>>>
>>> +static int __init of_platform_fw_devlink_pause(void)
>>> +{
>>> +       fw_devlink_pause();
>>> +}
>>> +core_initcall(of_platform_fw_devlink_pause);
>>> +
>>>    static int __init of_platform_default_populate_init(void)
>>>    {
>>>           struct device_node *node;
>>> @@ -538,9 +544,7 @@ static int __init of_platform_default_populate_init(void)
>>>           }
>>>
>>>           /* Populate everything else. */
>>> -       fw_devlink_pause();
>>>           of_platform_default_populate(NULL, NULL, NULL);
>>> -       fw_devlink_resume();
>>>
>>>           return 0;
>>>    }
>>> @@ -548,6 +552,7 @@ arch_initcall_sync(of_platform_default_populate_init);
>>>
>>>    static int __init of_platform_sync_state_init(void)
>>>    {
>>> +       fw_devlink_resume();
>>
>> ^ it seems has to be done earlier, like
>> +static int __init of_platform_fw_devlink_resume(void)
>> +{
>> +       fw_devlink_resume();
>> +       return 0;
>> +}
>> +device_initcall_sync(of_platform_fw_devlink_resume);
> 
> This will mean no device will probe until device_initcall_sync().
> Unfortunately, I don't think we can make such a sweeping assumption.

Could you answer below questions, pls?
>>> By the way, is there option to disable this feature at all?
>>> Is there Kconfig option?

-- 
Best regards,
grygorii
