Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23AEB2807F0
	for <lists+linux-pm@lfdr.de>; Thu,  1 Oct 2020 21:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732836AbgJATn3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Oct 2020 15:43:29 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37884 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730045AbgJATn3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Oct 2020 15:43:29 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 091JhCiJ014918;
        Thu, 1 Oct 2020 14:43:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601581392;
        bh=nqtAx6Mhg7NhyL/pO4+WLVrjEpwXgfVnbvVZF9kQQZE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=q6d3G3+mtGZ+FaGTvphW/ZHIp3G3d+ECA4z8QCUVgMzK0Q7Ri6dxLiAE26pCHHN01
         MRljEcpUMYpwWpkBRBzekXMmqdAzOjZCp7eVjZukSByoLzpjCH+cmS8ssHpoCpn8p6
         urCL2mX0ubliITvp3GIU7UB7MXXpvMRLO056GNPs=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 091JhC2L098318
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Oct 2020 14:43:12 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 1 Oct
 2020 14:43:11 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 1 Oct 2020 14:43:11 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 091Jh8ks007384;
        Thu, 1 Oct 2020 14:43:09 -0500
Subject: Re: Slow booting on x15
To:     Saravana Kannan <saravanak@google.com>
CC:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tony Lindgren <tony@atomide.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <20200924055313.GC9471@atomide.com>
 <fe0a4fa8-53fc-d316-261f-52f631f12469@ti.com>
 <20200924060826.GE9471@atomide.com>
 <20200924133049.GH3968@pendragon.ideasonboard.com>
 <20200925115147.GM9471@atomide.com>
 <20200925115817.GB3933@pendragon.ideasonboard.com>
 <20200930052057.GP9471@atomide.com>
 <d8d81891-7e22-81a2-19df-6e9a5f8679c4@ti.com>
 <20201001075344.GU9471@atomide.com> <20201001081748.GW9471@atomide.com>
 <20201001082256.GA3722@pendragon.ideasonboard.com>
 <60ea4b42-fbc2-2b80-7eab-8a236581d4c9@ti.com>
 <CAGETcx-aiW251dhEXT1GNb9bi6YcX8W=jLBrro5CnPuEjGL09g@mail.gmail.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <28aeeefa-fb4d-99fb-40bf-0d2747a9cac1@ti.com>
Date:   Thu, 1 Oct 2020 22:43:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAGETcx-aiW251dhEXT1GNb9bi6YcX8W=jLBrro5CnPuEjGL09g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 01/10/2020 21:24, Saravana Kannan wrote:
> On Thu, Oct 1, 2020 at 5:56 AM Grygorii Strashko
> <grygorii.strashko@ti.com> wrote:
>>
>>
>>
>> On 01/10/2020 11:22, Laurent Pinchart wrote:
>>> Hi Tony,
>>>
>>> On Thu, Oct 01, 2020 at 11:17:48AM +0300, Tony Lindgren wrote:
>>>> * Tony Lindgren <tony@atomide.com> [201001 07:53]:
>>>>> * Peter Ujfalusi <peter.ujfalusi@ti.com> [200930 12:41]:
>>>>>> Fwiw on my beagle x15
>>>>>>
>>>>>> v5.8
>>>>>> [    9.908787] Run /sbin/init as init process
>>>>>>
>>>>>> v5.9-rc7
>>>>>> [   15.085373] Run /sbin/init as init process
>>>>>>
>>>>>>
>>>>>> It appears to be 'fixed' in next-20200928: the board does not even boot.
>>>>>
>>>>> Yeah so it seems :(
>>>>>
>>>>>> next-20200928 on omap5
>>>>>> [    9.936806] Run /sbin/init as init process
>>>>>>
>>>>>>
>>>>>> -rc7 spends most of it's time:
>>>>>> [    7.635530] Micrel KSZ9031 Gigabit PHY 48485000.mdio:01: attached PHY driver [Micrel KSZ9031 Gigabit PHY] (mii_bus:phy_addr=48485000.mdio:01, irq=POLL)
>>>>>> [   14.956671] cpsw 48484000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
>>>>>> [   15.005211] IP-Config: Complete:
>>>>>
>>>>> Booting with initcall_debug I see this with current Linux next:
>>>>>
>>>>> ...
>>>>> [    1.697313] cpuidle: using governor menu
>>>>> [    1.701353] initcall init_menu+0x0/0xc returned 0 after 0 usecs
>>>>> [    1.707458] calling  gpmc_init+0x0/0x10 @ 1
>>>>> [    1.711784] initcall gpmc_init+0x0/0x10 returned 0 after 0 usecs
>>>>> [    1.717974] calling  omap3_l3_init+0x0/0x10 @ 1
>>>>> [    1.722653] initcall omap3_l3_init+0x0/0x10 returned 0 after 0 usecs
>>>>> [    1.729201] calling  omap_l3_init+0x0/0x10 @ 1
>>>>> [    1.733791] initcall omap_l3_init+0x0/0x10 returned 0 after 0 usecs
>>>>> [    1.740314] calling  gate_vma_init+0x0/0x70 @ 1
>>>>> [    1.744976] initcall gate_vma_init+0x0/0x70 returned 0 after 0 usecs
>>>>> [    1.751522] calling  customize_machine+0x0/0x30 @ 1
>>>>> [    3.823114] initcall customize_machine+0x0/0x30 returned 0 after 2011718 usecs
>>>>> [    3.830566] calling  init_atags_procfs+0x0/0xec @ 1
>>>>> [    3.835583] No ATAGs?
>>>>
>>>> And the long time above with customize_machine() ends up being
>>>> pdata_quirks_init() calling of_platform_populate().
>>>
>>> That's what the delay is for me (I think I've reported that initially).
>>>
>>>>> Laurent & Tomi, care to check what you guys see in the slow booting case
>>>>> after booting with initcall_debug?
>>>>
>>>> But maybe the long delay is something else for you guys so please check.
>>>
>>
>> It's all devlink :( Looks like sometimes, improvements (PM) could became so complicated
>> that time required to execute such algorithms may completely eliminate all expected benefits.
>> Will not be surprised if PM consumption also increased instead of decreasing in some cases.
>>
>> not sure if it's 100% correct, but below diff reduces boot time
>> from 7.6sec to 3.7sec :P
>>
>> before:
>> [    0.053870] cpuidle: using governor menu
>> [    2.505971] No ATAGs?
>> ...
>> [    7.562317] Freeing unused kernel memory: 1024K
>>
>> after:
>> [    0.053800] cpuidle: using governor menu
>> [    0.136853] No ATAGs?
>> [    3.716218] devtmpfs: mounted
>> [    3.719628] Freeing unused kernel memory: 1024K
>> [    3.724266] Run /sbin/init as init process
>>
>> ----
>> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
>> index 071f04da32c8..e0cc37ed46ca 100644
>> --- a/drivers/of/platform.c
>> +++ b/drivers/of/platform.c
>> @@ -481,6 +481,7 @@ int of_platform_populate(struct device_node *root,
>>           pr_debug(" starting at: %pOF\n", root);
>>
>>           device_links_supplier_sync_state_pause();
>> +       fw_devlink_pause();
>>           for_each_child_of_node(root, child) {
>>                   rc = of_platform_bus_create(child, matches, lookup, parent, true);
>>                   if (rc) {
>> @@ -488,6 +489,7 @@ int of_platform_populate(struct device_node *root,
>>                           break;
>>                   }
>>           }
>> +       fw_devlink_resume();
>>           device_links_supplier_sync_state_resume();
>>
>>           of_node_set_flag(root, OF_POPULATED_BUS);
>> @@ -538,9 +540,7 @@ static int __init of_platform_default_populate_init(void)
>>           }
>>
>>           /* Populate everything else. */
>> -       fw_devlink_pause();
>>           of_platform_default_populate(NULL, NULL, NULL);
>> -       fw_devlink_resume();
> 
> Your analysis is right, but this change is not safe. You'll get an
> unlocked linked list trampling if you call it outside of where it's
> called now. That's explicitly why I didn't do it the way this patch
> does it.
> 
> To explain more, if you call fw_devlink_pause/resume() inside
> of_platform_populate() you can end up calling it in the context of
> another device's probe function. When a device's probe function is
> called, a has a bunch of other locks held and you'll cause a deadlock.
> To avoid that, I had to use defer_fw_devlink_lock to manage the list
> used by fw_devlink_pause/resume().
> 
> I'll add more details later. But yeah, this patch isn't safe as is.

I assume you going to fix it your way, right?

Just FYI. On ARM main DT population path is:

arch_initcall(customize_machine)
	machine_desc->init_machine();
		of_platform_default_populate();
		-- or --
		of_platform_populate();

the of_platform_default_populate_init() called later due to make/linker dependencies.

As result, existing pause/resume optimizations don't fully working.

Thank you.

-- 
Best regards,
grygorii
