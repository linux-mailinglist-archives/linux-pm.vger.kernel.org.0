Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45BD8364A61
	for <lists+linux-pm@lfdr.de>; Mon, 19 Apr 2021 21:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241511AbhDSTTb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Apr 2021 15:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239191AbhDSTTb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Apr 2021 15:19:31 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00723C06138A
        for <linux-pm@vger.kernel.org>; Mon, 19 Apr 2021 12:18:59 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id g4-20020a9d6b040000b029029debbbb3ecso655553otp.7
        for <linux-pm@vger.kernel.org>; Mon, 19 Apr 2021 12:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rnkHoMyyrqXTtZmadAmUe+XXEr7XS5f+Ds2frEajC4I=;
        b=xqW8IYtHKXWmi4K+DMTB4ieQZmBejmCNxO1xUxe73JOc/4Tt1r+G/ZGTK4BDA+wgat
         FVzSMS8xL16y65JWzI+AKsW+tmTaBBWo84TqMaap2drMmDNRSBLUggDnSDeZ4AlggaAn
         F+QfAJ6iq4nI0EhPkSccIzKiNm31BaFae1pTEdynW2IQCFVoGKey82myrktbmeR/Mwnm
         vOfQvyCM3Du8s9T+GG+KqRydniGwwjIvL8Vx0q2uhgZHXkJdbWLTV3akww3JyaE5O1zc
         WJIhhgzgruuKtirL0hxUMYKhhKWsqrve/qER7HaGQFYC+KhmOufq6MF3pS6rs9aUeFha
         R6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rnkHoMyyrqXTtZmadAmUe+XXEr7XS5f+Ds2frEajC4I=;
        b=pmoMjLbDoX21hbHLj8q4ipGjYaJ/kYS15He6/Z2XgVVQUwo3LWn3tnRXxVVrY3G2uP
         M36v30OhOFYbd8NcjfUhQechHcHfAziWYvSBIKKjJm0gCrFQ8Dgznt3ur79M92JkBaQk
         vAenzg4GFa9jMmB0L/TC2YBhepXV5G7buBwG0uaKZlMmezwLITYU+mRJtXeCMPtSriaU
         faShB8b5AaM2YwUaPEII3/K7FlHa339E9JR/p7+RFNcwdDCQXFXoh8my1KjZWBtdCLaG
         kVFTEifhjCDMuEz1rSFGE/rW7tURJeDQatoXyhurj9isc8efOzcp328rfkTr1rCEyNxp
         hwVQ==
X-Gm-Message-State: AOAM533GPfEKFzLAWEfstf6CaU09tCcZnY0lquiEgoT5qMoLZklEYumK
        xpUfGdf5xQJadhXnuUtK2VnnRg==
X-Google-Smtp-Source: ABdhPJxYYFJA565Ah2IFbsorqtKthIYSeywb13B1yALFRrr4n+LvjBR6Ofv+FW/1z6RK1YCETQC0MQ==
X-Received: by 2002:a9d:1b70:: with SMTP id l103mr16249994otl.203.1618859939302;
        Mon, 19 Apr 2021 12:18:59 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id w66sm2916867otb.69.2021.04.19.12.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 12:18:58 -0700 (PDT)
Date:   Mon, 19 Apr 2021 14:18:56 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     viresh.kumar@linaro.org, agross@kernel.org, rjw@rjwysocki.net,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        amit.kucheria@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jeffrey.l.hugo@gmail.com
Subject: Re: [PATCH v4 2/7] cpufreq: blacklist MSM8998 in cpufreq-dt-platdev
Message-ID: <20210419191856.GU1538589@yoga>
References: <20210119174557.227318-1-angelogioacchino.delregno@somainline.org>
 <20210119174557.227318-3-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119174557.227318-3-angelogioacchino.delregno@somainline.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue 19 Jan 11:45 CST 2021, AngeloGioacchino Del Regno wrote:

> Add the MSM8998 to the blacklist since the CPU scaling is handled
> out of this.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Although I presume this could be squashed with the previous patch...

Regards,
Bjorn

> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index f82f4ec17ff2..061de3031787 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -133,6 +133,7 @@ static const struct of_device_id blacklist[] __initconst = {
>  
>  	{ .compatible = "qcom,apq8096", },
>  	{ .compatible = "qcom,msm8996", },
> +	{ .compatible = "qcom,msm8998", },
>  	{ .compatible = "qcom,qcs404", },
>  	{ .compatible = "qcom,sc7180", },
>  	{ .compatible = "qcom,sdm630", },
> -- 
> 2.30.0
> 
