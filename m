Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E335298D6
	for <lists+linux-pm@lfdr.de>; Tue, 17 May 2022 06:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiEQEgo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 May 2022 00:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiEQEgm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 May 2022 00:36:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A794727FEC
        for <linux-pm@vger.kernel.org>; Mon, 16 May 2022 21:36:38 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nqowm-0006GK-1p; Tue, 17 May 2022 06:36:36 +0200
Message-ID: <a32a70be-699e-88ff-83ba-cdf96f9221a1@pengutronix.de>
Date:   Tue, 17 May 2022 06:36:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1] thermal: imx: Make trip point offset configurable
Content-Language: en-US
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, l.stach@pengutronix.de,
        linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Amit Kucheria <amitk@kernel.org>,
        Jon Nettleton <jon@solid-run.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        linux-arm-kernel@lists.infradead.org
References: <20220516190001.147919-1-francesco.dolcini@toradex.com>
 <92ae0fd5-f827-ae3c-bbef-d551c9fa5b76@pengutronix.de>
 <20220516191657.GA148058@francesco-nb.int.toradex.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20220516191657.GA148058@francesco-nb.int.toradex.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Francesco,

On 16.05.22 21:16, Francesco Dolcini wrote:
> On Mon, May 16, 2022 at 09:06:10PM +0200, Ahmad Fatoum wrote:
>> On 16.05.22 21:00, Francesco Dolcini wrote:
>>> Currently the imx thermal driver has a hardcoded critical temperature
>>> value offset of 5 Celsius degrees from the actual SoC maximum
>>> temperature.
>>>
>>> This affects applications and systems designed to be working on this close
>>> to the limit, but yet valid, temperature range.
>>>
>>> Given that there is no single value that will fit all the use cases make
>>> the critical trip point offset from the max temperature configurable
>>> using a newly added trip_offset module parameter, passive trip point is
>>> set to 5 Celsius degrees less than the critical. By default the
>>> system behaves exactly as before.
>>>
>>> Link: https://lore.kernel.org/all/20220420091300.179753-1-francesco.dolcini@toradex.com/
>>> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
>>> ---
>>>  drivers/thermal/imx_thermal.c | 12 ++++++++----
>>>  1 file changed, 8 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
>>> index 16663373b682..42d1f8a3eccb 100644
>>> --- a/drivers/thermal/imx_thermal.c
>>> +++ b/drivers/thermal/imx_thermal.c
>>> @@ -86,6 +86,10 @@ enum imx_thermal_trip {
>>>  #define TEMPMON_IMX6SX			2
>>>  #define TEMPMON_IMX7D			3
>>>  
>>> +static int trip_offset = 5;
>>> +module_param(trip_offset, int, 0444);
>>
>> Is this being r--r--r-- intended?
> 
> Yes, would you expect something more or less strict?
> 
> Daniel was pretty assertive that this is supposed to be a system
> property and not something that should be possible to mess around with
> [0]. Given this and that trip points are a+r in sysfs this was the most
> reasonable solution to me. Said that I do not mind changing
> this to 640 or 0440 or ...

I just found it odd, but with your explanation, it makes sense to have
this a read-only-after-init setting.

Thanks for the clarification,
Ahmad

> 
> [0] https://lore.kernel.org/all/4de41b5e-1fa6-ece4-9d9a-2656d399b452@linaro.org/
> 
> Francesco
> 
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
