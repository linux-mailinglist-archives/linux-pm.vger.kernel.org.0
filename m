Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20EF844BE43
	for <lists+linux-pm@lfdr.de>; Wed, 10 Nov 2021 11:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbhKJKKW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Nov 2021 05:10:22 -0500
Received: from uho.ysoft.cz ([81.19.3.130]:18961 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229831AbhKJKKV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Nov 2021 05:10:21 -0500
Received: from [10.0.29.210] (unknown [10.0.29.210])
        by uho.ysoft.cz (Postfix) with ESMTP id 0A381A0753;
        Wed, 10 Nov 2021 11:07:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1636538852;
        bh=dd4tweGuclD5iB1Lg5dfzSruG+i/XLfegDyheWwHhSE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LFZeOvbiVMfXPvItc40LgittKMeQljGiubYm5zvEVqxxCfcDoemPzcsrEMUipFshv
         mSAl2Pfw0mnGkege/Q+S1mmN7dZ8HJUVT7OpNKgYcAhpnuS6Cehe/tgKAM2mH4+28o
         Oa2Q88yz+My1z8ntDZxAmZ7T5bekDfbIRSdIKmNc=
Subject: Re: [PATCH v2] thermal: imx: implement runtime PM support
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Amit Kucheria <amitk@kernel.org>, linux-kernel@vger.kernel.org,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Zhang Rui <rui.zhang@intel.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Petr Benes <petrben@gmail.com>
References: <20211019130809.21281-1-o.rempel@pengutronix.de>
 <20211020050459.GE16320@pengutronix.de>
 <CAPwXO5b=z1nhQCo55A_XuK-Es2o7TrL2Vj6AkRSXa3Wxh0s8sA@mail.gmail.com>
 <20211021172048.GE2298@pengutronix.de>
 <CAPwXO5bWoAvZgQLQHa6CsFmZ2bcUQ9pJQBBL3F+goppMeAKkFQ@mail.gmail.com>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Message-ID: <8692108c-1b46-3d3d-6911-300ac27c2980@ysoft.com>
Date:   Wed, 10 Nov 2021 11:07:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAPwXO5bWoAvZgQLQHa6CsFmZ2bcUQ9pJQBBL3F+goppMeAKkFQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25. 10. 21 13:06, Petr Benes wrote:
> Hi Oleksij,
> 
> On Thu, 21 Oct 2021 at 19:21, Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>>
>> Hi Petr,
>>
>> On Wed, Oct 20, 2021 at 05:53:03PM +0200, Petr Benes wrote:
>>> On Wed, 20 Oct 2021 at 07:05, Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>>>>
>>>> Hi Petr and Michal,
>>>>
>>>> I forgot to add you for v2 in CC. Please test/review this version.
>>>
>>> Hi Oleksij,
>>>
>>> It works good. with PM as well as without PM. The only minor issue I found is,
>>> that the first temperature reading (when the driver probes) fails. That is
>>> (val & soc_data->temp_valid_mask) == 0) holds true. How does
>>> pm_runtime_resume_and_get() behave in imx_thermal_probe()?
>>> Does it go through imx_thermal_runtime_resume() with usleep_range()?
>>
>> How exactly did you reproduce it? Even more or less understanding how
> 
> I just placed my debug print into get_temp()
> 
>      if ((val & soc_data->temp_valid_mask) == 0) {
>          dev_dbg(&tz->device, "temp measurement never finished\n");
>          printk("Wrong temperature reading!!!!!!\n");
>          return -EAGAIN;
>      }
> 
>> this can potentially happen, i never had this issue on my HW. Is it something
>> HW specific?
> 
> IMHO it is just product of the following sequence:
> 
> pm_runtime_set_active(&pdev->dev);
> pm_runtime_enable(data->dev);
> pm_runtime_resume_and_get(data->dev);
> thermal_zone_device_enable(data->tz);
> 
> With assumption imx_thermal_runtime_resume() didn't run,
> hence the sensor didn't get enough time to come up.
> 
> I didn't have time to spend it on and you have better knowledge of the
> area. If it is not that straightforward I can try to diagnose it better.
>
Hi Oleksij,
Did you manage to further debug and reproduce this problem?
Do you plan to send the v3?

Regarding your question about the HW - this problem occured once we
upgraded the SoC on our SBC from i.MX6DL to i.MX6Q/QP. With the DualLite
we never had this problem but the Quad is getting hot quite fast.
We have pretty limited cooling options so the core is operated at its
upper temperature limits when fully loaded.

Best regards,
Michal


