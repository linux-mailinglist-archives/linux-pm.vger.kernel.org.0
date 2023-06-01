Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3211B719859
	for <lists+linux-pm@lfdr.de>; Thu,  1 Jun 2023 12:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbjFAKHQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jun 2023 06:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbjFAKGp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jun 2023 06:06:45 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9499C10C8
        for <linux-pm@vger.kernel.org>; Thu,  1 Jun 2023 03:04:32 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f3bb61f860so697462e87.3
        for <linux-pm@vger.kernel.org>; Thu, 01 Jun 2023 03:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685613871; x=1688205871;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WeHc+jG+m56fAT2cyxvpIH0tMCx5a8BOREVUFG4XTMI=;
        b=INxaPgpCe9KuJsQOnoJz+VFNdPcccZJ2DFxXWrTF6SeXGpiNH+lt/wIkU4wAnKNG/o
         1wBX2RjxsP4mjU39DHUugIHjM9gbzto6nUhCgCTvCD/wJI8m4vNw31An3MFUtnq6tYwT
         mIZMkAsOM5jbSo1rDFY6Tvx7BcR5RBpAHT0eEmFx1ITB62QX4kvtlz5K7lmV2aT9zLRI
         zXycqtqbKzoIg+uBuAN8snyPn3CZ2tbqz6zYOEOzzP5l6SKU08lQK6GdnIGIEVviQp4y
         Jkm5QK3EMykN+IdwQ4kwu8vsk2QmhenIvcx1634A7htRRous9UMYXZfp2wwu5XDva/X+
         9tUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685613871; x=1688205871;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WeHc+jG+m56fAT2cyxvpIH0tMCx5a8BOREVUFG4XTMI=;
        b=aAlOvVzYW86k2qcUj8AivhWGaLIoUYYDrDyJOBui2SwRuhQXxK/ZGGqyJirQVfJbJN
         K645/uoik2S9KEty9BO2CEM7ucBUqbudEwCThlMLVVyNdnSP7VTghhJJLrVte321nllU
         yxATN6UOqjrVWmLSCZIblClYsBcq4OQbo96/TrION4YulW4ujZYS/Cdl0Yfuw3SMKNm6
         88zlGIBGWJKD3nH6BBDi/YiXYJnWjhAM3ykiLuNA5OWQulkX6qqQZd5GaHfU4VTgsm0N
         omGEHxQ8h6raskBgmcHcww7wqeuYOFCL0hxg8WbHc+eTVPf/hREaJ1FRdGBVDs2/gl+I
         UjzQ==
X-Gm-Message-State: AC+VfDz6TQ+uda5Xm6NkdELjmlzqyLRgm7oCHGWpPTs1N39G+ed7u89/
        Rev6KzXTZJ84GTtgYDOGsPgM5Q==
X-Google-Smtp-Source: ACHHUZ4Pr9WOKQ79SOiXxrjrbMqiiA08wotLBujtnD2APInyfPz0DOIOsx2r+C/yaAEfhnZ5X1KR5w==
X-Received: by 2002:a05:6512:38c7:b0:4dd:9f86:859d with SMTP id p7-20020a05651238c700b004dd9f86859dmr1105152lft.13.1685613870855;
        Thu, 01 Jun 2023 03:04:30 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id x22-20020ac24896000000b004f37aac79f4sm1023147lfc.185.2023.06.01.03.04.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 03:04:30 -0700 (PDT)
Message-ID: <04ca2cc4-6084-723d-e783-34b3db469271@linaro.org>
Date:   Thu, 1 Jun 2023 13:04:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 10/20] interconnect: qcom: Define RPM bus clocks
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, Evan Green <evgreen@chromium.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
 <20230526-topic-smd_icc-v1-10-1bf8e6663c4e@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v1-10-1bf8e6663c4e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30/05/2023 13:20, Konrad Dybcio wrote:
> Add the definitions for RPM bus clocks that will be used by many
> different platforms.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/interconnect/qcom/Makefile         |  2 +-
>   drivers/interconnect/qcom/icc-rpm-clocks.c | 66 ++++++++++++++++++++++++++++++
>   drivers/interconnect/qcom/icc-rpm.h        | 13 ++++++
>   3 files changed, 80 insertions(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

