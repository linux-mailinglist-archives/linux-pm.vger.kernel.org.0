Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD735792EF
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jul 2022 08:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235951AbiGSGBI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jul 2022 02:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236951AbiGSGBH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jul 2022 02:01:07 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01833AE4F
        for <linux-pm@vger.kernel.org>; Mon, 18 Jul 2022 23:01:06 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id b10so2855789pjq.5
        for <linux-pm@vger.kernel.org>; Mon, 18 Jul 2022 23:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8FOmmkRLa+DJG4lkbyiSOLBY/xgDe5vy13tV6Ea0Wh4=;
        b=qBiMQYrI8W369RhcE1uydNAY829/seyDgxPdzrxQsak5rRCheZx/uYXdfz2/TxM9It
         4/J5l0QT8/37DRw/DXZotR4ljeJ558gPFqV1V2i8c7L2Vie+EjG+S5QgpexXP/z7I4Oo
         pRm5Ct9dzbbPjp4pEoHUU8MbPyYhQgDf/5uHQQB8+qDRfaPcpdiRaDV3/bXYJaTxpgmI
         xBAWkBwELnlSPteXfiOmfJBO5t2D9gl/JX+cy1b3fLfV6aRqW0GG2hqqCj76pJ5J1dgK
         MQZbbJJ4PC6ChqvFxrfjc2p4DTCRK0DGnKOQ6ZAr5eSTFu6f3R6R5wuh78LCKMe2T9wJ
         Idqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8FOmmkRLa+DJG4lkbyiSOLBY/xgDe5vy13tV6Ea0Wh4=;
        b=i0FgSY56XmQV3cwxcTTYnqymMU7PsmlzKLfsc0xR69XPL0q1Q0Ms5CQe/njRCmV6wp
         Y0G9wJuW4beTTcQ1TNvTKIl+SP/q2MyrtQ0hJqoxN5wNswUGw/OMZYU9agoSFKcIZj9K
         puJGLJLz+fCEsIh/qXwP9qnxW+oPmCTkTtKL6M0pH3GqdUTvFqhWRVFQVIS0cTgrLegU
         cP//MEzwu+2O9iyysI7Z1LeZThyzNs+NwY08a8VVooJ357qwe/vQkXWndwhf0EV6MHKO
         MBb3lK2uSBlwyrnlPxLb/Ekh8oRsfoEZewx1N80zq4142Oy9DpBJHSm5BJPDNm0U+9Ql
         JFVw==
X-Gm-Message-State: AJIora8jdaPWs8xHcoJi2/6PzONhwiuzKBWtFUi3OHh88XqWfiW5r/r9
        h6x+MDF6J2baqFKzRHUZqv/rYw==
X-Google-Smtp-Source: AGRyM1t1QzTh/NTNjbzGXmKqC+y7MJUnrpF0+c980bsWyQtAkB8xpzCHGSV43taFYVm1+FfXaRPt2Q==
X-Received: by 2002:a17:903:10a:b0:16c:5efb:df49 with SMTP id y10-20020a170903010a00b0016c5efbdf49mr30724826plc.172.1658210465974;
        Mon, 18 Jul 2022 23:01:05 -0700 (PDT)
Received: from ?IPV6:2401:4900:1f3b:709e:6fec:df37:6562:5a80? ([2401:4900:1f3b:709e:6fec:df37:6562:5a80])
        by smtp.gmail.com with ESMTPSA id u1-20020a170902bf4100b0016a058b7547sm10534257pls.294.2022.07.18.23.01.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 23:01:05 -0700 (PDT)
Message-ID: <a9cf93ea-c2f3-2a33-6522-ad44d0e17f89@linaro.org>
Date:   Tue, 19 Jul 2022 11:31:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] thermal/drivers/qcom/spmi-adc-tm5: register thermal
 zones as hwmon sensors
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
References: <20220719054940.755907-1-dmitry.baryshkov@linaro.org>
 <20220719054940.755907-2-dmitry.baryshkov@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <20220719054940.755907-2-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 7/19/22 11:19 AM, Dmitry Baryshkov wrote:
> Register thermal zones as hwmon sensors to let userspace read
> temperatures using standard hwmon interface.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> index d9c9c975f931..073943cbcc2b 100644
> --- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> +++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> @@ -20,6 +20,8 @@
>   #include <linux/thermal.h>
>   #include <asm-generic/unaligned.h>
>   
> +#include "../thermal_hwmon.h"
> +
>   /*
>    * Thermal monitoring block consists of 8 (ADC_TM5_NUM_CHANNELS) channels. Each
>    * channel is programmed to use one of ADC channels for voltage comparison.
> @@ -687,6 +689,9 @@ static int adc_tm5_register_tzd(struct adc_tm5_chip *adc_tm)
>   			return PTR_ERR(tzd);
>   		}
>   		adc_tm->channels[i].tzd = tzd;
> +		if (devm_thermal_add_hwmon_sysfs(tzd))
> +			dev_warn(adc_tm->dev,
> +				 "Failed to add hwmon sysfs attributes\n");
>   	}
>   
>   	return 0;

LGTM, so:

Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>


