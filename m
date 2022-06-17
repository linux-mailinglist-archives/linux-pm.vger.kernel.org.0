Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA64C54F367
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jun 2022 10:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381268AbiFQIon (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jun 2022 04:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381272AbiFQIoh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2022 04:44:37 -0400
X-Greylist: delayed 491 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 17 Jun 2022 01:44:31 PDT
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528916970C;
        Fri, 17 Jun 2022 01:44:31 -0700 (PDT)
Received: from [10.1.8.252] (unknown [10.1.8.252])
        by uho.ysoft.cz (Postfix) with ESMTP id 3431AA02A1;
        Fri, 17 Jun 2022 10:36:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1655454977;
        bh=P9SsROK1piUBycTfz5CAL2bjuDVk9jOnqysDli5yILI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NKd47B8Nb5QPetXhvZ9t/FDQLHL72xPSR1aeGo2k8dc0d/sDRW6aj9Fts1APj0bU+
         a+0vfE0YsOmN25NoL7SUzd5xKrqSq3QWrVnWwJ0esR/fZm+WoDYq1tRHiX3zlYlDLt
         o2r1/WmPHiCUxEOIsPVoNukf8V3wJXNFqPAW7PUk=
Message-ID: <854d5705-93a3-18f2-a16d-b2245cf2c085@ysoft.com>
Date:   Fri, 17 Jun 2022 10:36:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RESEND PATCH v2 0/9] imx: thermal: Allow trip point
 configuration from DT
Content-Language: en-US
To:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Jacky Bai <ping.bai@nxp.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Anson Huang <Anson.Huang@nxp.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220617071411.187542-1-francesco.dolcini@toradex.com>
 <DB9PR04MB84123FC6272AF3C2DAE306D687AF9@DB9PR04MB8412.eurprd04.prod.outlook.com>
 <20220617074220.GA187629@francesco-nb.int.toradex.com>
 <DB9PR04MB84128DBB45B29B7BD6ED001287AF9@DB9PR04MB8412.eurprd04.prod.outlook.com>
 <20220617075533.GA190158@francesco-nb.int.toradex.com>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
In-Reply-To: <20220617075533.GA190158@francesco-nb.int.toradex.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Francesco,

On 17. 06. 22 9:55, Francesco Dolcini wrote:
> On Fri, Jun 17, 2022 at 07:51:53AM +0000, Jacky Bai wrote:
>>> On Fri, Jun 17, 2022 at 07:31:25AM +0000, Jacky Bai wrote:
>>>>> Subject: [RESEND PATCH v2 0/9] imx: thermal: Allow trip point
>>>>> configuration from DT
>>>>>
>>>>> This series allows to specify the imx thermal drivers trip point
>>>>> from the device tree, without this change the threshold are
>>>>> hard-coded and this might not be correct given the thermal design of the
>>> final system.
>>>>>
>>>>
>>>> The threshold is set dynamically based on the part market temp grade.
>>>> I am little confused why need to specify it in DT?  I saw in 'PATCH
>>>> 5/9', you provide a threshold table based temp grade, why not use the
>>>> threshold from ' imx_init_temp_grade'?
>>>
>>> The problem with the existing temperature thresholds is that they are
>>> hard-coded into the driver, there is no way to change those to match the
>>> actual final system thermal design.

AFAIK you can change the trip point from user space if you build
with THERMAL_WRITABLE_TRIPS so in fact you can adapt it to the final
system design.

We did exactly that when we swapped imx6 dual for imx6 quad but did not
have enough space for adequate heat sink.

I do not want to question usefulness of this series though, I agree with the idea.

Michal

