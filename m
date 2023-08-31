Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6A778E58D
	for <lists+linux-pm@lfdr.de>; Thu, 31 Aug 2023 07:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241174AbjHaFBQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Aug 2023 01:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240287AbjHaFBQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Aug 2023 01:01:16 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9477FFB
        for <linux-pm@vger.kernel.org>; Wed, 30 Aug 2023 22:01:12 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bf5c314a57so2749525ad.1
        for <linux-pm@vger.kernel.org>; Wed, 30 Aug 2023 22:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693458072; x=1694062872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LG57Ipqd8qnPkHXmEM2qU3rXEf7cPd3YjyUXTm2SJUY=;
        b=ZW7uzyAA3Mj4dWvC2R0TadSaGLhea/1SJyIyxX1ek9CNtwKfUFk1/EVyLrKPT1pAr3
         y5J0UEF8eSaWE+KjtBFWZ8hjCARAFpy7phcCrj/HG//iXJX3TJ+/lx88DvOnsaY42rXd
         cq0EzWV3FvR8Z/0wtPxW256BQXfFoCNSByabYVlQOIpAU3UfkQW7LGvGpCHw53p1UraX
         gcZEtgEkbkaY591Jd7nVKwKVRC8jyWh9/y79UMHhzX9eSjWLwTmjcXAfYhKLqSynZRyw
         O31PiLfPEWxOJp7j+uy1Xp30ytdc+hhvZQwmGTTrS36vkgoPZtqTzqo3PL/ozt4B8RbV
         GMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693458072; x=1694062872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LG57Ipqd8qnPkHXmEM2qU3rXEf7cPd3YjyUXTm2SJUY=;
        b=k/TEWk87CpRd3TkRVyIP9hHhyW4vjqVV5UvEdFWzXqp6qI85yBGtyQvRtthnpAbGDY
         1lMR164zNxQDwrZ3xSKtER0prTvee5dugs8VxXwKgE/aXQdApEJe91njfZHLK8n71I/0
         0/YLWhpnG1TTZuqT7QnriRSiH8IDhiOF+n3smtbggn7uVDt3fTPouQSHx8mdbjQilTA5
         p1LISek/rQLYp/Iwk2j6yagv+YzuSNllK6XUUDahNl10hPHpgp7qPuVgObIRwUQ4tABU
         1Z9N4aLoyLuWEw8EWoZjyouJtWQQ67tw48OlUnBqzRfQXaHF31+lnL0frxwdVWV22JEv
         VYXg==
X-Gm-Message-State: AOJu0Yx4VRHeVOx8f2VB8m2pxZ+VxyY/Zp6oDw1xW+Cibg5FN6OeS1+T
        AwNWditvSQRygbtcdC+QmZUQvA==
X-Google-Smtp-Source: AGHT+IFQZQgyo7Kbxxv4n+DzGhsaV/YCZE33tGBr+rqZ2mBEdrv8HmDOp79McCilJd8OH8ltr0xGIg==
X-Received: by 2002:a17:902:c409:b0:1bc:6266:d0e4 with SMTP id k9-20020a170902c40900b001bc6266d0e4mr5133728plk.69.1693458072003;
        Wed, 30 Aug 2023 22:01:12 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id i2-20020a170902eb4200b001bf2dcfe352sm370068pli.234.2023.08.30.22.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 22:01:11 -0700 (PDT)
Date:   Thu, 31 Aug 2023 10:31:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 09/11] cpufreq: Add QCM6490 to cpufreq-dt-platdev
 blocklist
Message-ID: <20230831050108.yt7obgdqmcz73brn@vireshk-i7>
References: <20230830-fp5-initial-v1-0-5a954519bbad@fairphone.com>
 <20230830-fp5-initial-v1-9-5a954519bbad@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830-fp5-initial-v1-9-5a954519bbad@fairphone.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30-08-23, 11:58, Luca Weiss wrote:
> The Qualcomm QCM6490 platform uses the qcom-cpufreq-hw driver, so add it
> to the cpufreq-dt-platdev driver's blocklist.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index fb2875ce1fdd..02ec58a8603b 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -145,6 +145,7 @@ static const struct of_device_id blocklist[] __initconst = {
>  	{ .compatible = "qcom,msm8996", },
>  	{ .compatible = "qcom,msm8998", },
>  	{ .compatible = "qcom,qcm2290", },
> +	{ .compatible = "qcom,qcm6490", },
>  	{ .compatible = "qcom,qcs404", },
>  	{ .compatible = "qcom,qdu1000", },
>  	{ .compatible = "qcom,sa8155p" },

Applied. Thanks.

-- 
viresh
