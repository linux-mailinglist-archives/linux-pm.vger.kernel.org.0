Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26887550190
	for <lists+linux-pm@lfdr.de>; Sat, 18 Jun 2022 03:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383658AbiFRBJM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jun 2022 21:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383829AbiFRBJJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2022 21:09:09 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B428F6A03F
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2022 18:09:07 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id f65so5367117pgc.7
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2022 18:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Y/sXQWT5BsOx0+lYreaxv2glXoiotZ6zf4S9n+k5qKU=;
        b=JrLZ9pLFPeh8ddh+VgG2EGuZ4cT93HOJR6xM2D/hqz/Hiem9+ErEGgdxdJubgmPBLX
         OXRvPqpw43C1niYJxYwSvtVaHDtOB5Q6aeGDNHow0pNkGxy7NyYRIzcaiYOLwj1McRgZ
         QXccfO6JRJJJoOi2cwX/aK6WIzf8D6FfmJRlsX2Q7CziO/6gEO1fKAfn2GJsTCUY0J8P
         G/1ttc7j5riAsttuQPj6Up/dLHXByAwl30JhD2AUWfXe7YI/NZ4mCOEFRKYRRSuWlPrH
         ti436/NnhutVignEsUOIjlujqtidERwSyQzIVerdFAnY7jxVpw8tjPSb0htLBQKMdxn4
         ZxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Y/sXQWT5BsOx0+lYreaxv2glXoiotZ6zf4S9n+k5qKU=;
        b=7oJR/uS7hmQpA1zNRnF3TgRAcEVUJdsH1Gu8g3SUMrQ6Ry6nz/wQCApAq0MD+pWdQ1
         QnbHaqzfyRzVyXxnnBHBH8l7EMnEvjPeH9fQM5rON1TwE6w1dXQnsBIpzZIwhdzhPeXA
         KPxtnJvRecTGIrJZVOktI5G0JhIJB3+i6c9eBYS6MAJZGyQhF7wCLKLSC556MCCcHwdx
         V+1VTwk8QafxGZf3OAz4SkwJNW15qr2OUEFbE9fRBloV6uOeKOOjQjROC2bb53n5t6fb
         7v4kkcA9JP0d66n5c44gYBhbeqA/8l1ttutnbSjTFAHD0NS3IVBF9KNrJMXvh+rWvRu1
         4xbA==
X-Gm-Message-State: AJIora+BGeA7xp3aA05h6GeDq5CUc5afGFcgyQisQOyliAxXNVt4LW2M
        cK9n+/DIVkFNRS6HMwzkigyNcg==
X-Google-Smtp-Source: AGRyM1tyEZPhWFvFb4IzigfXk6EigMC2xvSu50DoFQTjPL6/JPrAMoE9RAPJMW9hkVK7Yd4+3AbnYw==
X-Received: by 2002:aa7:8ec6:0:b0:51b:c6ec:5ff5 with SMTP id b6-20020aa78ec6000000b0051bc6ec5ff5mr12662727pfr.5.1655514547136;
        Fri, 17 Jun 2022 18:09:07 -0700 (PDT)
Received: from [172.31.235.92] ([216.9.110.6])
        by smtp.gmail.com with ESMTPSA id x11-20020a1709027c0b00b0015e8d4eb208sm2039633pll.82.2022.06.17.18.09.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 18:09:06 -0700 (PDT)
Message-ID: <91b7b3d4-dd15-93a4-999c-5976afef78b2@linaro.org>
Date:   Fri, 17 Jun 2022 18:09:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220617074220.GA187629@francesco-nb.int.toradex.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17/06/2022 00:42, Francesco Dolcini wrote:
> Hello Jacky,
> 
> On Fri, Jun 17, 2022 at 07:31:25AM +0000, Jacky Bai wrote:
>>> Subject: [RESEND PATCH v2 0/9] imx: thermal: Allow trip point configuration
>>> from DT
>>>
>>> This series allows to specify the imx thermal drivers trip point from the device
>>> tree, without this change the threshold are hard-coded and this might not be
>>> correct given the thermal design of the final system.
>>>
>>
>> The threshold is set dynamically based on the part market temp grade.
>> I am little confused why need to specify it in DT?  I saw in 'PATCH
>> 5/9', you provide a threshold table based temp grade, why not use the
>> threshold from ' imx_init_temp_grade'?
> 
> The problem with the existing temperature thresholds is that they are
> hard-coded into the driver, there is no way to change those to match the
> actual final system thermal design.
> 
> After various discussions [1][2] with Marco, Daniel and Lucas it was agreed
> that the actual trip is indeed a system property and therefore should be
> described in the device tree. This series make it possible in a
> backward compatible way, this new possibility is than used to override the
> threshold in some system-specific dts (see patches 6,7,8 and 9).
> 
> Francesco
> 
> [1] https://lore.kernel.org/all/20220420091300.179753-1-francesco.dolcini@toradex.com/
> [2] https://lore.kernel.org/all/20220516190001.147919-1-francesco.dolcini@toradex.com/
> 

As I responded to your v2, thermal is not really special and other types
of devices and other SoCs might be affected as well.

Best regards,
Krzysztof
