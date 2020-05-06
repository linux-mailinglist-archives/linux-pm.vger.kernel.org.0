Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C2D1C7060
	for <lists+linux-pm@lfdr.de>; Wed,  6 May 2020 14:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbgEFMdg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 May 2020 08:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728004AbgEFMdf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 May 2020 08:33:35 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BAAC061A41
        for <linux-pm@vger.kernel.org>; Wed,  6 May 2020 05:33:35 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id p139so465516vkd.7
        for <linux-pm@vger.kernel.org>; Wed, 06 May 2020 05:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3bX4H3SHet9hEaEY2R/CcawnJOfM8m99AFlVmYLIN7Q=;
        b=bs2Q1swc0Z7CzycUADk1C52HoAOiFigeUgR6iRD/IaEVUpqskoK0XPgBV8BxU+JBpU
         uVAxQCebM/+qcl3U5WENV0wtVIrvgZ1X8HgaY3pCMVs3C4PhJnblGlb+yeHmWv+ng0DN
         zwEse5UtkB8MCvu3zF4Sei+D1Od9uLQ4UbBi+s8Xoxf7im9W7oqU++Fd3UpnFrA+5ir4
         N3pKmtFIeL9WLBz0y1HUFaR4k84UYpWHP8wRnvamIChXNQGrMf54fwOBdS6yHTiViZZT
         NZK8iqWatHq+qpWCuWWHNenAMA4k2nSTsMghX3gkzOeubeAx08olb/5gABkjPFSTLVOv
         JXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3bX4H3SHet9hEaEY2R/CcawnJOfM8m99AFlVmYLIN7Q=;
        b=tgawYQr7u9K+HC2b7qmmsIGyPE/CKsrYNLr9P+c2f+PZYNZTnVkR3p1DyYwsj4Aq/O
         RPAefsJUP0YxK99UKb1DGA4+eoIkPPAwvxP9e7HPi/G8ezjF8ldI7Lt8JbgMhapwwi0x
         8PTW35YPGxEduxJr9x6coPxxSi+XvXZsrDMcUBWEcVEIwJPXbZJf8nXX2eDq+4yGGKA/
         MO6lh+3vkUYu1W5WqxWghKPmBUzNVolMx0LchrdyoEBrvVELu/YKdKoMQQPAS2X1M/Sb
         JP/5HxR9Uu6zPQAKWldUrmFr1n9eGXXCIAY6YcrILSxJoH7s6A9pHx2ll7OQPvuuJOce
         2W1Q==
X-Gm-Message-State: AGi0Pua1KZfh2aQlPg5TDltYeph3RLAa23KzCTA/ZCp1rFtmQ8CAyApi
        YQB4+t344KVoYW2tCN0LH2vnjgq/vGZEtGW1uz7gKQ==
X-Google-Smtp-Source: APiQypJ8ySkE9MyP8aKuTdXnUNaUlx5nX44KM48t0myuuXVzfd9ErOa0ab3rJfFanLwy2XYmgWClPX7dMfg+uL2NO6g=
X-Received: by 2002:a1f:2a13:: with SMTP id q19mr6510137vkq.73.1588768414310;
 Wed, 06 May 2020 05:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200504202243.5476-1-sibis@codeaurora.org> <20200504202243.5476-3-sibis@codeaurora.org>
In-Reply-To: <20200504202243.5476-3-sibis@codeaurora.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 6 May 2020 18:02:59 +0530
Message-ID: <CAHLCerPb+xT7bEZj0f49LKUN60ToUFXEWcCc8K3-FmUXFzP_GQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/12] cpufreq: blacklist SDM845 in cpufreq-dt-platdev
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Nishanth Menon <nm@ti.com>, Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 5, 2020 at 1:54 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> Add SDM845 to cpufreq-dt-platdev blacklist since the actual scaling is
> handled by the 'qcom-cpufreq-hw' driver.
>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>


> ---
>
> v4:
>  * Updated commit message [Matthias]
>  * Picked up R-b from Matthias
>
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 5c8baf603e056..6ed68bc906f8d 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -131,6 +131,7 @@ static const struct of_device_id blacklist[] __initconst = {
>         { .compatible = "qcom,apq8096", },
>         { .compatible = "qcom,msm8996", },
>         { .compatible = "qcom,qcs404", },
> +       { .compatible = "qcom,sdm845", },
>
>         { .compatible = "st,stih407", },
>         { .compatible = "st,stih410", },
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
