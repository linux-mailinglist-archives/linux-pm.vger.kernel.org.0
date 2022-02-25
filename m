Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9C64C3D58
	for <lists+linux-pm@lfdr.de>; Fri, 25 Feb 2022 05:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbiBYEj4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Feb 2022 23:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbiBYEjz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Feb 2022 23:39:55 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9863C085F
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 20:39:19 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 139so3625852pge.1
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 20:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0MkRkwcwqSIw76W0kGp9jsiG1YZzvjUDyBXAvufBt6Q=;
        b=Jo4hdm5S8ktpsY8uQcvL5J854WyEBBxNr4DuT5KjgJUt0gezqlFH9VyNzbrjivq5/V
         dncqWapzCbFAxY8+VWyLNPFCrLeg2fkVy4GI6dR0sQQqFtQGP1AKvma/MHRtUlnrKHa6
         Vuk9GYTXzF2WfI8peWACFVt3JtWa1OHrLYajA5tRpfp+VZIesgEpD3r5/0+6Dtd85XXB
         fjn6JyxxFUhVWl+hpgEYoV5FygU98F4Nn27Rksw22fKVJBGxB/5Oce8UW5MI1zxR4nC7
         t4++wkOa2S3LQSF8iAAIx4lLQgRcwEYoY58DeGG4Cv4TyosEdj1cFauvAkopq0tC6Zx3
         OZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0MkRkwcwqSIw76W0kGp9jsiG1YZzvjUDyBXAvufBt6Q=;
        b=e3aGUstJgCS1Oocc535dmoo6piOOGIlCI2wz3/T6j/ekZGlJh0Vixvw6Q69OTKNxwS
         y1IZPO5RohbIz6l6gZGqG8Z8mTWiFxRwFjUL5Fr6PmHJzJq0EFCmThriptPk8KOuByUA
         e1r6XNlaayl3WGiD/fKxsWWfWwfX4nRVfPJs4YSsh7Uemu0lNDWafLbz0MoKNBw+sxvF
         Pqxm1apliaV1l7RhlAQwBPjOoUB8fyviJO1sliScuJAnzXx18YDEGz3SCLheLjwK14KZ
         2jDY1EukIH5z9r2BauwjcqgeBsPN0sy5TGvAGwQCr/Hyjq8Te6GI6xSyDkDvJR1iIOIv
         D4CQ==
X-Gm-Message-State: AOAM533LkzYwMdosofpd3ygQof32zZ4fghgnJpgKgDLvIzGK9ooqLMBA
        Sap/JMiwOXAv54nJ7s/Vh28Odw==
X-Google-Smtp-Source: ABdhPJy/q9pLknniCQQ53iYNmVKVkY+ZzIEvqpOsUAydrckSVpPxH3yjAhrdFsDIEE/sJgvX6hOdxA==
X-Received: by 2002:a63:c61:0:b0:370:592b:3ad1 with SMTP id 33-20020a630c61000000b00370592b3ad1mr4731929pgm.240.1645763959405;
        Thu, 24 Feb 2022 20:39:19 -0800 (PST)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id q2-20020a056a00088200b004ce1838b223sm1225545pfj.94.2022.02.24.20.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 20:39:18 -0800 (PST)
Date:   Fri, 25 Feb 2022 10:09:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: blocklist Qualcomm sc8280xp and sa8540p in
 cpufreq-dt-platdev
Message-ID: <20220225043916.urj6gdxvqlkaar7o@vireshk-i7>
References: <20220225035706.2294842-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225035706.2294842-1-bjorn.andersson@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24-02-22, 19:57, Bjorn Andersson wrote:
> The Qualcomm sc8280xp and sa8540p platforms also uses the
> qcom-cpufreq-hw driver, so add them to the cpufreq-dt-platdev driver's
> blocklist.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 6b808f805eab..96de1536e1cb 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -139,9 +139,11 @@ static const struct of_device_id blocklist[] __initconst = {
>  	{ .compatible = "qcom,msm8996", },
>  	{ .compatible = "qcom,qcs404", },
>  	{ .compatible = "qcom,sa8155p" },
> +	{ .compatible = "qcom,sa8540p" },
>  	{ .compatible = "qcom,sc7180", },
>  	{ .compatible = "qcom,sc7280", },
>  	{ .compatible = "qcom,sc8180x", },
> +	{ .compatible = "qcom,sc8280xp", },
>  	{ .compatible = "qcom,sdm845", },
>  	{ .compatible = "qcom,sm6350", },
>  	{ .compatible = "qcom,sm8150", },

Applied. Thanks.

-- 
viresh
