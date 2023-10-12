Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540497C703F
	for <lists+linux-pm@lfdr.de>; Thu, 12 Oct 2023 16:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbjJLO1w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Oct 2023 10:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbjJLO1v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Oct 2023 10:27:51 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC04BE
        for <linux-pm@vger.kernel.org>; Thu, 12 Oct 2023 07:27:49 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31f71b25a99so981185f8f.2
        for <linux-pm@vger.kernel.org>; Thu, 12 Oct 2023 07:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697120868; x=1697725668; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z35x2KMCJCXsBIbmy9n6f3au11P/WJPEJir5cY6NYBA=;
        b=cpEcuOqtZeBLV93szk1EtBzLksMPNyNvY1ONY2CJISb+/iYT++Uu3Vp2JwzXpqLTxq
         BiuvAoogMVaofvPfvgdelErAt0LX2LSxKAarHJcUeOVkARPOrSBjSozPON3YqvNw1VyH
         NyS39Kq8Usu+ub3nriwTX6LnK4+B8ZhJA6GDRRkxibPUpqG6qycYrg/4R6liC8fae/QW
         4mC8JDEewYMZmG2hKX8XeaDEyfKNdOWnZ7wYWoeaVPk8MfHUEBywh1V1HHbSBrDaX1wZ
         4do8+S9ioLEMs2e+3Ls0s5EHs9qn6XH96LgS1BFGbSYyAQGWVgMDN6CnpBTx3qIQKey+
         IoRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697120868; x=1697725668;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z35x2KMCJCXsBIbmy9n6f3au11P/WJPEJir5cY6NYBA=;
        b=CfJizRwD/fXaOuDUDHupB+pOXO+agHGuCajP+GnWuv274zhX2XbqPMSYxV9h7eJBDQ
         hCHycx/jcHbqDxRYPRTLJKTTfwxqZQmsoIS6KlUT5+cCoxen1ign4nArZ8eS51cao4dm
         WxN3ChHC5lFu4EJxFaB9cGRrlGMDhIMRF6A86wZXvbcXPtDx2OLiAn3vHPwOc2wv/ZZE
         3mrsa6UTpVINf/zk/dJLK29u1yPWyTdg1xvAIUsFuTfHxRQqLVoAzRyIv1H7dG+QgpmM
         Qg7PCMCxio5CGrh0+jVLe0J+qqotSLP0Dk6jxbnKnLUVaTS4kUnacu+dOe9WhdXR3uPZ
         rn1Q==
X-Gm-Message-State: AOJu0Yy5Lt+3f8q4IR+ZqSiCjmm5LQi1tWHIWHcBmc/vSjMuhxYToUFh
        8hU0DiivMIGBpqq8fCiQ7oz3Bc/dV1CkmlGQDM4=
X-Google-Smtp-Source: AGHT+IFD4a3WZd0zpYx192NfjOK9B5wAOPso8bC8/zQTNhtWjwd2SDA5n8vga56vCN0MrttiyJtvVg==
X-Received: by 2002:a5d:654e:0:b0:31d:db92:31ae with SMTP id z14-20020a5d654e000000b0031ddb9231aemr22318455wrv.44.1697120867810;
        Thu, 12 Oct 2023 07:27:47 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id j13-20020adfe50d000000b003196b1bb528sm18458016wrm.64.2023.10.12.07.27.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 07:27:47 -0700 (PDT)
Message-ID: <d2d6fae5-ace7-4b94-9354-a01cd6a7e343@linaro.org>
Date:   Thu, 12 Oct 2023 16:27:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/6] thermal: trip: Simplify computing trip indices
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>
References: <13365827.uLZWGnKmhe@kreacher> <3256881.aeNJFYEL58@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3256881.aeNJFYEL58@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06/10/2023 19:40, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> A trip index can be computed right away as a difference between the
> value of a trip pointer pointing to the given trip object and the
> start of the trips[] table in the thermal zone containing the trip, so
> change thermal_zone_trip_id() accordingly.
> 
> No intentional functional impact (except for some speedup).
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/thermal_trip.c |   13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_trip.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_trip.c
> +++ linux-pm/drivers/thermal/thermal_trip.c
> @@ -175,14 +175,11 @@ int thermal_zone_set_trip(struct thermal
>   int thermal_zone_trip_id(struct thermal_zone_device *tz,
>   			 const struct thermal_trip *trip)
>   {
> -	int i;
> -
>   	lockdep_assert_held(&tz->lock);
>   
> -	for (i = 0; i < tz->num_trips; i++) {
> -		if (&tz->trips[i] == trip)
> -			return i;
> -	}
> -
> -	return -ENODATA;
> +	/*
> +	 * Assume the trip to be located within the bounds of the thermal
> +	 * zone's trips[] table.
> +	 */
> +	return trip - tz->trips;

Shouldn't be divided by sizeof(*trip) ?

>   }
> 
> 
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

