Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF6D2C90B1
	for <lists+linux-pm@lfdr.de>; Mon, 30 Nov 2020 23:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbgK3WLQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Nov 2020 17:11:16 -0500
Received: from mout01.posteo.de ([185.67.36.65]:35178 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbgK3WLQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 30 Nov 2020 17:11:16 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id AFCE616005F
        for <linux-pm@vger.kernel.org>; Mon, 30 Nov 2020 23:10:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1606774217; bh=F6mfedeTyY5JpbZmBBvv69fCVPsTOTeqTf5Lez9t52g=;
        h=Subject:To:Cc:From:Date:From;
        b=ie4Mb3W83FAID/O3CslM8NUGj8FzCeexA8e8Zk/bR8KTofZCor41xDN9Xd1b1axrq
         5LheOTuq/UHEkjOwyKwJnT+e7XrVX+Ds5Kty/9XS2pcCSJASpsPOzA/jt6AdB5Q21f
         k5XOAn2vbWTSZ1GCkjX84NO/7i7JpbwrHaD8h9DVO1kpLk6WpdsN6l7C6wy04XgxQM
         24wT3TPbotFEKCgUU4azKXZ0Odr4OA4xMXm1RjQOBDflFXVIlJd/ub4wsRhqOjEIgk
         T8PV8XBffF/URULI9NIB02V38fDzDpm6taH0TQR7o8EpIGUnJnOwUZ7mZAatgheU+T
         PfYJCoX+AWviQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4ClKD81wrfz6tm8;
        Mon, 30 Nov 2020 23:10:16 +0100 (CET)
Subject: Re: question: interconnect: changes in 5.10 / imx8mq ?
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Leonard Crestez <cdleonard@gmail.com>, akashast@codeaurora.org,
        Shawn Guo <shawnguo@kernel.org>, kernel@pengutronix.de
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>
References: <c110af2f-635a-71f5-735c-1346b7af0ef9@posteo.de>
 <bae4ae77-4d4d-6298-0af7-1d8db7dc7afe@linaro.org>
From:   Martin Kepplinger <martink@posteo.de>
Message-ID: <95ae2a9e-f0f7-fcfb-b113-c69286e85bad@posteo.de>
Date:   Mon, 30 Nov 2020 23:10:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <bae4ae77-4d4d-6298-0af7-1d8db7dc7afe@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30.11.20 22:18, Georgi Djakov wrote:
> On 30.11.20 22:34, Martin Kepplinger wrote:
>> hi,
>>
>> what I've used on v5.9 on imx8mq in order to hook up dram frequency to 
>> interconnect (via mxsfb/lcdif) - and has worked fine - is:
>>
>> * add the NOC node description with "#interconnect-cells = <1>;"
>> https://source.puri.sm/martin.kepplinger/linux-next/-/commit/8a6b8486a3e94e2886bde01000f9532e03d243a4 
>>
>> (original author is Leonard. I'll preserve authorship when submitting)
>>
>> * add "interconnects = <&noc IMX8MQ_ICM_LCDIF &noc IMX8MQ_ICS_DRAM>;
>> " to lcdif:
>> https://source.puri.sm/martin.kepplinger/linux-next/-/commit/6c4bbcdc315da01a9dc8bbda36290587ce1ed33a 
> 
> [..]
>>
>>   node                                  tag          avg         peak
>> --------------------------------------------------------------------
>> NOC                                          2147483647   2147483647
>>    30320000.lcd-controller                0            0            0
>> DRAM                                         2147483647   2147483647
>>    30320000.lcd-controller                0            0            0
>> (...)
>>
>>
>>
>> what am I doing wrong on recent kernels?
> 
> Hi Martin,
> This looks related to sync_state. Please try the change below.
> It would be nice to get these DT patches merged into mainline.

that's the plan. I'll send them soon.

> 
> Thanks,
> Georgi
> 
> diff --git a/drivers/interconnect/imx/imx8mq.c 
> b/drivers/interconnect/imx/imx8mq.c
> index ba43a15aefec..9bb951b075e9 100644
> --- a/drivers/interconnect/imx/imx8mq.c
> +++ b/drivers/interconnect/imx/imx8mq.c
> @@ -94,6 +94,7 @@ static struct platform_driver imx8mq_icc_driver = {
>       .remove = imx8mq_icc_remove,
>       .driver = {
>           .name = "imx8mq-interconnect",
> +        .sync_state = icc_sync_state,
>       },
>   };

that's exactly it. thanks a lot!

                            martin
