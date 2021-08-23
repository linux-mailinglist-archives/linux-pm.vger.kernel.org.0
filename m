Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126FC3F43CB
	for <lists+linux-pm@lfdr.de>; Mon, 23 Aug 2021 05:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbhHWDSL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Aug 2021 23:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbhHWDSK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Aug 2021 23:18:10 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC281C061756
        for <linux-pm@vger.kernel.org>; Sun, 22 Aug 2021 20:17:28 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id x1so6761555plg.10
        for <linux-pm@vger.kernel.org>; Sun, 22 Aug 2021 20:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qBOogX3XB4mHC8GpV87UjjRCgHNuTvok/Zf+qYgDrJU=;
        b=rnynb/BFuTERp3DG5b3HDTRYOODWJFs8FUmWZEHn7kdOXK+v9GxGmvo0OZFlxH1mH9
         bUV4VDB7HNP/BmT8ZUsmRKGWfDaRPpP10ne9zXhvr6lvIo5xTb0qCuDHcFMIlKp3a6Y+
         nIuje/j7f6we6kMd+YnHIJVmTdwK689j91h0HLlrgmNhJ6PUODi/Ayd/enZltherbOOu
         4Ohs97FD2bGwzi1sugYy35jgXHJGxs3UH591RdTa/peLxvB5t8u4UCzaTBSxqAfHe6Jb
         MsNXRH6SgO+PT99HXwQny/85q88UbIrMeKN3rtZMifRcpsenyRmHRFWTJfK1hNio+M01
         G3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qBOogX3XB4mHC8GpV87UjjRCgHNuTvok/Zf+qYgDrJU=;
        b=MBkEkALLPyvwB8xFb3ZLreUncwr6NQITKCcf0GjFYny6neOg/gkKerHQcXz/5r5BfI
         1ZdDF9OYHj10y5xrxvPY1Vu+Zd3OTg7/jlp3fwspbfG3WASyiTlNzgC290xN1j28xCFd
         WIDp6NUbC8PQgW+l5GyiUxlqY7OLSQqT4qAlPzXgB4GN104NSYZq7U4CE+KeyfvmJgZB
         awrDOwzH825K0VtJEqmxDUKH7euaz3t5/3CsEbNVG8jtjl0g2aPln5EjAPjBtWWtpv+h
         Rv1rCmj7mADQgsBCWveTCp7j/UhZg2NBvIs53IoF6suESgEeYwD8JmeFhOeNrU6d1e81
         0UYA==
X-Gm-Message-State: AOAM532WnqFBrJl+kILse4K+udkGSBoWWSpssVlW0q2soFeCNC2L7VRa
        ytIc+XElfRKw36jk4XTzso3b2g==
X-Google-Smtp-Source: ABdhPJzqg3ToMHCG7N81BJvsddQsivBmCGSHavIG0r6EDRSWDesCvSDugU108BZ4HKtVDXXBfvuzKQ==
X-Received: by 2002:a17:90b:4b84:: with SMTP id lr4mr17964004pjb.32.1629688648248;
        Sun, 22 Aug 2021 20:17:28 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id h9sm10922286pjg.9.2021.08.22.20.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 20:17:27 -0700 (PDT)
Date:   Mon, 23 Aug 2021 08:47:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Subject: Re: [PATCH] cpufreq: blocklist more Qualcomm platforms in
 cpufreq-dt-platdev
Message-ID: <20210823031717.hh3pn4d2c4sughem@vireshk-i7>
References: <20210820215700.130575-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820215700.130575-1-bjorn.andersson@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-08-21, 14:57, Bjorn Andersson wrote:
> The Qualcomm sa8155p, sm6350, sm8250 and sm8350 platforms also uses the
> qcom-cpufreq-hw driver, so add them to the cpufreq-dt-platdev driver's
> blocklist.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 231e585f6ba2..ca1d103ec449 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -137,11 +137,15 @@ static const struct of_device_id blocklist[] __initconst = {
>  	{ .compatible = "qcom,apq8096", },
>  	{ .compatible = "qcom,msm8996", },
>  	{ .compatible = "qcom,qcs404", },
> +	{ .compatible = "qcom,sa8155p" },
>  	{ .compatible = "qcom,sc7180", },
>  	{ .compatible = "qcom,sc7280", },
>  	{ .compatible = "qcom,sc8180x", },
>  	{ .compatible = "qcom,sdm845", },
> +	{ .compatible = "qcom,sm6350", },
>  	{ .compatible = "qcom,sm8150", },
> +	{ .compatible = "qcom,sm8250", },
> +	{ .compatible = "qcom,sm8350", },
>  
>  	{ .compatible = "st,stih407", },
>  	{ .compatible = "st,stih410", },

Applied. Thanks.

-- 
viresh
