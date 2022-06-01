Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8CC539DED
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jun 2022 09:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350214AbiFAHMO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jun 2022 03:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350213AbiFAHMO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jun 2022 03:12:14 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733187981A
        for <linux-pm@vger.kernel.org>; Wed,  1 Jun 2022 00:12:12 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z7so872985edm.13
        for <linux-pm@vger.kernel.org>; Wed, 01 Jun 2022 00:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=trhwASX+lfcvBV60r3M43wKh+E4woS61gxL4WkTNutQ=;
        b=VsYG//kIrthv8XP+4a96/hG0sceqoJrsQgbNzhr3ch3jYwTr440p6rYIhEr25TiOXl
         oDghDolp1X46DwLfW6ETlPbgBR9uXI+JODIGEQoKaEWvXs0K0oGDH9fIp5RrH9puRTw8
         jQzoE9C+VlKj0JIgne7TaoRy0UEr97/7nMkblSVmQ+ERN7FOIJUFw3q6X9Ev4Gk/JK1O
         ms4hT2DPd6WeSkDJ4kAlGX0Rg8rhLwfXxDoh1wlhkFTNm4bbPcK0kMWmoP3Dse2g2dVk
         JuhTTXK8RcaLgbT2hcbyvp8IOWA3+doBvX8i7f2TnzMVKxMzfGLcCw2ErqxVCf1xQiMC
         Ck1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=trhwASX+lfcvBV60r3M43wKh+E4woS61gxL4WkTNutQ=;
        b=u0F+KpRFzyld1b0W+PnMHq9EPPXanf9y1OYfMYSi3eeVyH3eZRWJGkrxbGrvNEWCwv
         oi7hWSzn3ymaxrCDK2XeJMqLJiZ8l2EN3rY5tc3FPbifRf41oQen9JsKJ1AOph2eugry
         9Nr/+oFbcL7y4+923Pd6t8Yrd/DMpiE9FjlBHoY8r3fpFsshJmi8Dl3XOLOVv6jB+Hjh
         DVUU8JS0PFNDHmduUGWvMyqhqsJ7p450I9vR/eSbdYfBXY6uE3z+4MbaernNhY7pIPOm
         lmuIi8ndkSEnPL13kejC0yVttFIlIAT5DFakc90+xolv6SipLCpFm2AzTDnFNQ6LXtd3
         B6Qw==
X-Gm-Message-State: AOAM533tci8EqoSMQ7EN+/RYXM59rjqXc1VBBHdJy6Col5RPCmzuCUYV
        txfWbcOD/GoEQ2i0mbq36vkSfA==
X-Google-Smtp-Source: ABdhPJwqkfpw/36eeo4iKm/FtLUf93jLYEwb0D93rirRhTpoZezYM47nJJPfx729OU6HFBULnvyhAg==
X-Received: by 2002:a05:6402:3551:b0:42b:6d38:9485 with SMTP id f17-20020a056402355100b0042b6d389485mr49145090edd.234.1654067530663;
        Wed, 01 Jun 2022 00:12:10 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id pk16-20020a170906d7b000b006fee526ed72sm332280ejb.217.2022.06.01.00.12.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 00:12:10 -0700 (PDT)
Message-ID: <95bbe6b0-1c56-9be9-0343-a24fe1970705@linaro.org>
Date:   Wed, 1 Jun 2022 09:12:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 2/4] soc: qcom: icc-bwmon: Add bandwidth monitoring
 driver
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Thara Gopinath <thara.gopinath@linaro.org>
References: <20220531105137.110050-1-krzysztof.kozlowski@linaro.org>
 <20220531105137.110050-3-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220531105137.110050-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 31/05/2022 12:51, Krzysztof Kozlowski wrote:
> +	window = mult_frac(bwmon->sample_ms, HW_TIMER_HZ, MSEC_PER_SEC);
> +	/* Maximum sampling window: 0xfffff */
> +	writel_relaxed(window, bwmon->base + BWMON_SAMPLE_WINDOW);
> +
> +	bwmon_set_threshold(bwmon, BWMON_THRESHOLD_HIGH,
> +			    data->default_highbw_kbps);
> +	bwmon_set_threshold(bwmon, BWMON_THRESHOLD_MED,
> +			    data->default_medbw_kbps);
> +	bwmon_set_threshold(bwmon, BWMON_THRESHOLD_LOW,
> +			    data->default_lowbw_kbps);
> +
> +	thres_count = data->zone3_thres_count << BWMON_THRESHOLD_COUNT_ZONE3_SHIFT |
> +		      BWMON_THRESHOLD_COUNT_ZONE2_DEFAULT << BWMON_THRESHOLD_COUNT_ZONE2_SHIFT |
> +		      data->zone1_thres_count << BWMON_THRESHOLD_COUNT_ZONE1_SHIFT |
> +		      BWMON_THRESHOLD_COUNT_ZONE0_DEFAULT;
> +	writel_relaxed(thres_count, bwmon->base + BWMON_THRESHOLD_COUNT);
> +	writel_relaxed(BWMON_ZONE_ACTIONS_DEFAULT,
> +		       bwmon->base + BWMON_ZONE_ACTIONS);
> +
> +	/* Write barriers in bwmon_clear() */
> +	irq_enable = BIT(BWMON_IRQ_ENABLE_ZONE1_SHIFT) |
> +		     BIT(BWMON_IRQ_ENABLE_ZONE3_SHIFT);

Unusued variable, I will send a v4.



Best regards,
Krzysztof
