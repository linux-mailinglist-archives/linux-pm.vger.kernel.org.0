Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22D87B2ECA
	for <lists+linux-pm@lfdr.de>; Fri, 29 Sep 2023 11:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjI2JCY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Sep 2023 05:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbjI2JCW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Sep 2023 05:02:22 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77931A8
        for <linux-pm@vger.kernel.org>; Fri, 29 Sep 2023 02:02:19 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40572aeb6d0so105376555e9.1
        for <linux-pm@vger.kernel.org>; Fri, 29 Sep 2023 02:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695978138; x=1696582938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TQw+ZAMqlftuckLRitJgjf++YRzCOpCpcgRGGPh5T6s=;
        b=av/xc0yNym2owDI0QzpcQL8PPwqHK/Ly8B7vzA1+GHljHhUfh7gUFhbfgdvF1Hu4Xe
         h4Rl/VQ5v7AQRaNuv5J2/bpD4Kclwdf4ThHXrYltgabaa5pTuOmPBl0gkJgZ6ThLV/vy
         QUjluJ0bOh24ktNy8xVLglCDIdaFW2zYR86W8UK8O/+DdnFYSdAURrNm7l67kmsW+Ntt
         fdfU0wT4kn7xcCUTMd2k3eMF0zB/rf2Xi3OYXuyQYT0e+olFxVffA2htN4stwCCU2i3r
         g1cTufgWtdLx3NBGlcQHbrgEyjdMgDvIwYOq4YjxqrTLmq/jrfWXjCBQ8TVAUdtQ9Ue1
         HXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695978138; x=1696582938;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TQw+ZAMqlftuckLRitJgjf++YRzCOpCpcgRGGPh5T6s=;
        b=jmSHRjtDmJMOXuGf91EprCvwYs1qDPnGYXbj2vP5JprWz8q0pPRFlPSTBVzX3z/yvY
         4f8uKRaOTJPWRKe4fT3HtDUJgW2VYgRv9bPg44SFWgIGvthebuqtXbMoXDiqVt/QicZh
         ciGlHNuq9CJZUlhVAY4uo6HIszbeeNr5dSqd/AJpUaNPCULKwSwj/elJcoonDsK7F3j4
         6WRucejIbQ9VOVx1EJIiXcXiGzV35QUWA1efh7h24VDPo+o3dIv78EbsLoTpP7pgDwsu
         dTBQZmwaZUBi/URO4APQYHHedEpa90YHmBHDz7b+G6o9JeQHIVUz0ngE6tzDFNJDPuj6
         Lhww==
X-Gm-Message-State: AOJu0YxKJDtMbL2wAufwJ9k+2VHznrHaxC4DNSizRILXRVDxRzGTQdNl
        cNdpHCyIP565CSDZDNP/FFxQQg==
X-Google-Smtp-Source: AGHT+IFPLKjQaIsyW64BO9dLilNP/IcoX4nLkuiTxU375hcJNp1GRtnx7HtOH6n/o4cuI1EpZJ5thQ==
X-Received: by 2002:a7b:c448:0:b0:401:bd2e:49fc with SMTP id l8-20020a7bc448000000b00401bd2e49fcmr3482822wmi.24.1695978138163;
        Fri, 29 Sep 2023 02:02:18 -0700 (PDT)
Received: from [192.168.27.65] (home.beaume.starnux.net. [82.66.176.246])
        by smtp.gmail.com with ESMTPSA id p16-20020a1c7410000000b00402ff8d6086sm977137wmc.18.2023.09.29.02.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 02:02:17 -0700 (PDT)
Message-ID: <0b31dee8-a3bc-50a2-a7bb-9183370b5dce@linaro.org>
Date:   Fri, 29 Sep 2023 11:02:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] thermal: amlogic: Fix build failure after conversion to
 .remove_new()
Content-Language: en-GB
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc:     kernel@pengutronix.de, Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        kernel test robot <lkp@intel.com>
References: <20230929061305.2351953-1-u.kleine-koenig@pengutronix.de>
From:   Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <20230929061305.2351953-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Le 29/09/2023 à 08:13, Uwe Kleine-König a écrit :
> Commit 88af8b66ffed ("thermal: amlogic: Convert to platform remove
> callback returning void") converted amlogic_thermal_disable() to return
> no value but missed that amlogic_thermal_suspend() makes use of the int
> returned by this function. As amlogic_thermal_disable() returned zero
> unconditionally before, add a return 0 to get the same behaviour as
> before the offending commit.
> 
> Fixes: 88af8b66ffed ("thermal: amlogic: Convert to platform remove callback returning void")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309291214.Hjn3gJ94-lkp@intel.com/
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> sorry for not catching that before sending. I don't understand yet what
> was wrong with my testing; I would have bet the series was tested with
> an ARCH=arm64 allmodconfig build. :-\
> 
> If you prefer it, feel free to squash this patch into the offending
> commit.
> 
> Best regards, sorry and thanks,
> Uwe
> 
>   drivers/thermal/amlogic_thermal.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
> index 1426f1eb4ac6..562f63b7bf27 100644
> --- a/drivers/thermal/amlogic_thermal.c
> +++ b/drivers/thermal/amlogic_thermal.c
> @@ -300,7 +300,9 @@ static int __maybe_unused amlogic_thermal_suspend(struct device *dev)
>   {
>   	struct amlogic_thermal *data = dev_get_drvdata(dev);
>   
> -	return amlogic_thermal_disable(data);
> +	amlogic_thermal_disable(data);
> +
> +	return 0;
>   }
>   
>   static int __maybe_unused amlogic_thermal_resume(struct device *dev)

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
