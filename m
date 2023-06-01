Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF2871988B
	for <lists+linux-pm@lfdr.de>; Thu,  1 Jun 2023 12:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbjFAKLc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jun 2023 06:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbjFAKKh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jun 2023 06:10:37 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744A310D8
        for <linux-pm@vger.kernel.org>; Thu,  1 Jun 2023 03:09:56 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f3bb61f860so704898e87.3
        for <linux-pm@vger.kernel.org>; Thu, 01 Jun 2023 03:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685614195; x=1688206195;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YjmDK1b+XgS1XoK0ZAhZVvk8JhEZlZQYOJoJbk6aMT0=;
        b=MuvRCjFr01vo+CuxKOXEZNxBxAoboas5MWksj7h4GcC3kKcjl8lnSbwOp1HbUzqcQt
         gQRhXHnc8oYeAbrbQkcZcrpLCwAWGD/r6nqP30VX0mWx4ZBxloTNiK/47eyiLS48XX5v
         NgdPV8a38GGe5BQnip98I+qV5aMK7qjE+gOpVYvTfHL2JEsjoBIeRAnGiaBhgW1vYVjw
         GRaMXaI6nfekIB7GBZ7sGQ3mlPH3oYvuD/otjy2mUGDqDix63ZWmFsAnfAyQeFy+Btjf
         mwniab+uHPcwDqh0MFpB6i8GEmXS5PntomDTWcDSFcjTswOHA/keVHbdKae2sLbUR6dO
         tJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685614195; x=1688206195;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YjmDK1b+XgS1XoK0ZAhZVvk8JhEZlZQYOJoJbk6aMT0=;
        b=B5ksScxbd8gB2HyRPrR+oImM0nvTVYSXiat65CyiQvmD+UDKvjcmQop5FGA0Hlaa9C
         7nrk0HqhozVuMmXT7n7UKBXN/iVwleK78G+4LUYAG2jv3I+HCiM1REMaSyEIkYPcrV00
         JfXnIJG5l5a4BmXbSBYVL0iNLAQsfnm4F+/eItbhehDKK4M5odgphQpvk0qSydw64Rok
         moSDWl51fCAwu+Bzl14eW9BeSGdiEr8BVweTEtK3rTBn/y6O0OrxJPrFu8mc86ffvGfi
         mQkEF2tn+1yPiYGtKvzBnQjTeaU/gYQ7pYJN5wuRIrRWMfWUgAFj28dmLFuKDDGUWvHl
         p1zA==
X-Gm-Message-State: AC+VfDw3FcsPwEf5v7x9U237Mp27ZgpoWeB6JFsQsKnc9dfZtEdjKCa1
        SjSGM2PRzhfSA5yVPC91CcmonA==
X-Google-Smtp-Source: ACHHUZ7wxjgqTSQ2q1mTGKeArEjxyfrGjPY2wTE8udgediz4XJ1hoFe5fDIy0v8ItqjNxXdBvNXQoQ==
X-Received: by 2002:ac2:4435:0:b0:4f3:b4ab:d0ee with SMTP id w21-20020ac24435000000b004f3b4abd0eemr924066lfl.42.1685614194676;
        Thu, 01 Jun 2023 03:09:54 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id m3-20020a056512014300b004f517c21ef0sm669797lfo.82.2023.06.01.03.09.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 03:09:54 -0700 (PDT)
Message-ID: <1eab0512-5120-9dd5-30e9-1e8f0c2f541f@linaro.org>
Date:   Thu, 1 Jun 2023 13:09:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 14/20] interconnect: qcom: msm8939: Hook up RPM bus clk
 definitions
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
 <20230526-topic-smd_icc-v1-14-1bf8e6663c4e@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v1-14-1bf8e6663c4e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30/05/2023 13:20, Konrad Dybcio wrote:
> Assign the necessary definitions to migrate to the new bus clock
> handling mechanism.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/interconnect/qcom/msm8939.c | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

