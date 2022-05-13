Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23295266FC
	for <lists+linux-pm@lfdr.de>; Fri, 13 May 2022 18:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiEMQZo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 May 2022 12:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbiEMQZo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 May 2022 12:25:44 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377C98E199
        for <linux-pm@vger.kernel.org>; Fri, 13 May 2022 09:25:42 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id h16so11423785wrb.2
        for <linux-pm@vger.kernel.org>; Fri, 13 May 2022 09:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pWKM0MBdI2EXI4pLoR/+4e311xPtdPa4XXrZxBV0DhU=;
        b=VI1nm+5Jsi+Be7G1b2OqP2KXMA+mCV/Sp8eFrKYLkVQaWFihr6IVX6ykzOm0+eZ1GY
         c+qR1DAiG9vnfUJnZui9Lyl1dEkJFtdQfFk4Qp68U8oJ3l7JP/sLcT2f1B1EAlzjPAPF
         L35otRSiesaaYb8l9ensh4v53OGAnHTRIchXmYDY55vKSOn3RWcHhcsgRtvWnPL5AhSM
         HNquXKKtsrQldmr3bvq/vccIQASyPvnSu3YJt4P5AcMQVyrdNzZuC0QjT1Tt7OI0/lBf
         hWKCQqrZbkgbIOaAFNbFtEjSAu5l7fSgXXOsXFSEJSEctF0CT3aSA6mY9MDrlDx1VY9W
         yLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pWKM0MBdI2EXI4pLoR/+4e311xPtdPa4XXrZxBV0DhU=;
        b=BVe84i4SN8BGNtRLl/RMlbpizi1o+OA05JUpe17nCekOteUdJEWZ6trMUwDQSGxGx+
         GS9p1Wl5Pqzr03zX8xpl2X2CoNG2GyhNzNVh3zmyY++ZrlXw402+OI0ECL3OTcL4pjZv
         MTohuyot9ODZ60QyBmPNQhiY/sulPT5eJkYWGtxvEbQpax/g+EAZTJPF6zAK+tMDf/mx
         WkIAzIvd79RG2/+pz/GefiOYVGvx/ZXrJjGp1ZKyQTV7R4TuFt2SlT8gw83YSktbLVXd
         Yot82rzgKbSRPW5vJZXkoomeyNjVgChIN1s7noB+Bf2DK0ZQlvE5DHsLbTKDH9f3/f/T
         8lxQ==
X-Gm-Message-State: AOAM530Tdy+n1tHgR34iD9rO9u/MqDs6+/VdP/HS+MHNTGW7wS7PmJaS
        Kv+8EnMK9bTNoMs2uQpDV3139Q==
X-Google-Smtp-Source: ABdhPJxqfYPYfaiF6Ttkf9rjeedRQdbuPmmPibHhv95AmmQ7EooiJaPxsic0ElNHElUUfzJOkE4GYQ==
X-Received: by 2002:adf:f24d:0:b0:20c:f5a0:be7e with SMTP id b13-20020adff24d000000b0020cf5a0be7emr1261010wrp.344.1652459140704;
        Fri, 13 May 2022 09:25:40 -0700 (PDT)
Received: from [192.168.1.41] (static-176-182-171-101.ncc.abo.bbox.fr. [176.182.171.101])
        by smtp.googlemail.com with ESMTPSA id r64-20020a1c2b43000000b003942a244edbsm3926858wmr.32.2022.05.13.09.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 09:25:40 -0700 (PDT)
Message-ID: <4de41b5e-1fa6-ece4-9d9a-2656d399b452@linaro.org>
Date:   Fri, 13 May 2022 18:25:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v1] thermal: imx: Update critical temp threshold
Content-Language: en-US
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, linux-pm@vger.kernel.org,
        Tim Harvey <tharvey@gateworks.com>,
        Amit Kucheria <amitk@kernel.org>,
        Jon Nettleton <jon@solid-run.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <20220420091300.179753-1-francesco.dolcini@toradex.com>
 <486c5c72-812a-d4ea-0c5a-49783bdc4a1f@linaro.org>
 <20220512073600.GA36153@francesco-nb.int.toradex.com>
 <6918b1a7ba401cd4db2db0601137766acd93bc63.camel@pengutronix.de>
 <20220512102454.GA39979@francesco-nb.int.toradex.com>
 <7f5a919c-2fa1-a463-1f6b-6b531d5ee27d@linaro.org>
 <20220512135653.GB39979@francesco-nb.int.toradex.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220512135653.GB39979@francesco-nb.int.toradex.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/05/2022 15:56, Francesco Dolcini wrote:
> On Thu, May 12, 2022 at 12:52:46PM +0200, Daniel Lezcano wrote:
>> On 12/05/2022 12:24, Francesco Dolcini wrote:
>>> Hello Lucas,
>>>
>>> On Thu, May 12, 2022 at 12:08:08PM +0200, Lucas Stach wrote:
>>>> Am Donnerstag, dem 12.05.2022 um 09:36 +0200 schrieb Francesco Dolcini:
>>
>> [ ... ]
>>
>>> Anyway, would it be fine to have a patch that make the critical
>>> threshold write-able (in my initial message I mentioned this as my
>>> preferred solution also)? If anybody has a pointer on how
>>> to do it, it would be great, I'm not familiar with that code.
>>
>> What about a module param ?
> 
> I would be happy to just be able to write to the `critical`
> trip_point_temp file in sysfs, however the thermal
> framework seems to enforce the critical threshold being read only (only
> `get_trip_temp` callback available). Is there any way to change this?

No, critical trip point is not a system setting but a hardware setting.

It should be set via the DT or a module parameter.


> # cat /sys/class/thermal/thermal_zone0/trip_point_1_type
> critical
> # ls -l /sys/class/thermal/thermal_zone0/trip_point_1_temp
> -r--r--r-- 1 root root 4096 May  6 14:33 /sys/class/thermal/thermal_zone0/trip_point_1_temp





-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
