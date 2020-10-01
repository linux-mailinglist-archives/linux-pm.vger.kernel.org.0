Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83CF5280074
	for <lists+linux-pm@lfdr.de>; Thu,  1 Oct 2020 15:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732139AbgJANt3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Oct 2020 09:49:29 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44334 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732018AbgJANt3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Oct 2020 09:49:29 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 091DnBcd031514;
        Thu, 1 Oct 2020 08:49:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601560151;
        bh=S5NFF8KJqQaTuxofx9Ycqx+dj7/l5jmjBAMCgF3qoiU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=gFDIBft3Ac5O8KzTokCSNDE93ZTW/osJtg/RcWhQy26L7p/VyyzkKNjIsHRCIgSEE
         Lf06/F8j1apCU+0zoDn59eZdFJ8ff1dswG1CEc1z1+ZHOQ2q1+h6LP9BGFBDwCpTvc
         EHxb42DLEw75t1w3oM6SwjXIOcMvexnqh3S2RToI=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 091DnBXj123125
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Oct 2020 08:49:11 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 1 Oct
 2020 08:49:11 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 1 Oct 2020 08:49:11 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 091Dn799125769;
        Thu, 1 Oct 2020 08:49:07 -0500
Subject: Re: Slow booting on x15
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tony Lindgren <tony@atomide.com>,
        Saravana Kannan <saravanak@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
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
 <CAMuHMdUmX+i+FcScCT-_g20cBECU8J57zc0RpprT2sp+BpTprQ@mail.gmail.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <68f54d65-8b50-9124-ef6e-163342de549a@ti.com>
Date:   Thu, 1 Oct 2020 16:49:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUmX+i+FcScCT-_g20cBECU8J57zc0RpprT2sp+BpTprQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

hi Geert,

On 01/10/2020 16:11, Geert Uytterhoeven wrote:
> Hi Grygorii et al,
> 
> On Thu, Oct 1, 2020 at 2:56 PM Grygorii Strashko
> <grygorii.strashko@ti.com> wrote:
>> On 01/10/2020 11:22, Laurent Pinchart wrote:
>>> On Thu, Oct 01, 2020 at 11:17:48AM +0300, Tony Lindgren wrote:
>>>>>> -rc7 spends most of it's time:
>>>>>> [    7.635530] Micrel KSZ9031 Gigabit PHY 48485000.mdio:01: attached PHY driver [Micrel KSZ9031 Gigabit PHY] (mii_bus:phy_addr=48485000.mdio:01, irq=POLL)
>>>>>> [   14.956671] cpsw 48484000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
>>>>>> [   15.005211] IP-Config: Complete:
> 
> 1. Is irq=POLL normal behavior for your board?
> 2. As this is a Micrel PHY, perhaps you are affected by the changes in
>     the configuration defaults in commit bcf3440c6dd78bfe ("net: phy:
>     micrel: add phy-mode support for the KSZ9031 PHY")?
> 
> See also the performance drop figures in the description of quick fix
> 9b23203c32ee02cd ("ravb: Mask PHY mode to avoid inserting delays twice")
> (and better solution
>   https://lore.kernel.org/linux-renesas-soc/20201001101008.14365-1-geert+renesas@glider.be)


It's not about Ethernet PHY and I've tried different board am571x-idk.

The boot delay introduced first very early during boot:

>> [    1.729201] calling  omap_l3_init+0x0/0x10 @ 1
>> [    1.733791] initcall omap_l3_init+0x0/0x10 returned 0 after 0 usecs
>> [    1.740314] calling  gate_vma_init+0x0/0x70 @ 1
>> [    1.744976] initcall gate_vma_init+0x0/0x70 returned 0 after 0 usecs
>> [    1.751522] calling  customize_machine+0x0/0x30 @ 1
>> [    3.823114] initcall customize_machine+0x0/0x30 returned 0 after 2011718 usecs
>> [    3.830566] calling  init_atags_procfs+0x0/0xec @ 1
>> [    3.835583] No ATAGs?
> 
> And the long time above with customize_machine() ends up being
> pdata_quirks_init() calling of_platform_populate().

And was narrowed down to ^ of_platform_populate() - above customize_machine() costs 2sec.

related discussion https://lkml.org/lkml/2020/6/17/452

-- 
Best regards,
grygorii
