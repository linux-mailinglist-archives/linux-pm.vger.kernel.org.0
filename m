Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770C41FAC48
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jun 2020 11:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgFPJWc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jun 2020 05:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgFPJWI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jun 2020 05:22:08 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6D7C03E96A
        for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2020 02:22:05 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id s192so4633284vkh.3
        for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2020 02:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o6euDOY6oMlwJphirnftZK239m7I7dONOkGXOBDE+vU=;
        b=F6RGY3u1eJHXOCkxT4S6ZQmyRcayoZV15ojB+VbxpgXjmicLw4N5nTEFG5Bx6XxzkZ
         7C8vnOJlf6qDCgpmJaHxfQkxCcqyTvNp7+x95Eu4QAVHaYYPeSZ+LpmzXCbyiEi0No4V
         zgkZHksKMfvzTDB6/nuVoeB4mv2sE8q18LKEtBlApAp9q445UoZv0Um6Nu1PC4ZgB+VQ
         4gP2ZFLz5NJy0VqhK/DocxMwsOQ2g4K7/+UiGGWG3UHLQp5Pv2IvoWXZuOkETAADNLTk
         895z2Mlfwc+8uMDdvJlzda2sBIczZr3b9Gs3rd6DWajdl1YXr0a831Shx7Lqbpuck7fP
         6dWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o6euDOY6oMlwJphirnftZK239m7I7dONOkGXOBDE+vU=;
        b=U9UQMhNbG40GiHEqNJA4m9jLElJ9d3d9wwYvzsS92nfzxCI4TERRHREcI+dJQQprKl
         lLhRqsKfLLymmRqvF7Y0UIiBFYpQ9euHd6Pdmks05n/7+26HFmTcVwF4kHrEdpSvTBVg
         HLD2uiu5MybP8+V1nIdK1u4M5n61A0hBrN24eYKrUlmrcYUaqjGeEbvVACB4PSAQlqE1
         oL3qqTHETY2AeZLoapovf5hRRSHnIBWPpUN9JNV7H1V477YJjho51OTUrdCFOkpuyeZU
         L7HbqGmRoG+GQnLb1GFs0WSpc7zN7clnoPV7cwbNJib1adNgG+HcXHsaaFbOckmRxAwn
         dWoQ==
X-Gm-Message-State: AOAM532+6C97PRSU9ASjdiw2/qejg4YpHKkRkQc4pkhSW5PsueYf0FSb
        BnXuFJvDTGc6MVMQhzUZ2y95sAW4JYWl3Gxwn5tWzg==
X-Google-Smtp-Source: ABdhPJx4g5jlxzibMSqCinB5QGUdXtaI/4SZQcjRun7bXCIPO5lQ1nNKPjmPF9UNMEBAB+iY7EfUZtiooEYHoixTD2k=
X-Received: by 2002:a1f:c103:: with SMTP id r3mr822640vkf.25.1592299324309;
 Tue, 16 Jun 2020 02:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200604015317.31389-1-thara.gopinath@linaro.org> <20200604015317.31389-3-thara.gopinath@linaro.org>
In-Reply-To: <20200604015317.31389-3-thara.gopinath@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 16 Jun 2020 11:21:27 +0200
Message-ID: <CAPDyKFqxV20Fv2X7wJ5zKa_csDgSBL5KN9HtrA6+EFpgYPhxyg@mail.gmail.com>
Subject: Re: [PATCH v6 2/6] soc: qcom: rpmhpd: Introduce function to retrieve
 power domain performance state count
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, Rob Herring <robh@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 4 Jun 2020 at 03:53, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>
> Populate .get_performance_state_count in genpd ops to retrieve the count of
> performance states supported by a rpmh power domain.
>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/soc/qcom/rpmhpd.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
> index e72426221a69..a9c597143525 100644
> --- a/drivers/soc/qcom/rpmhpd.c
> +++ b/drivers/soc/qcom/rpmhpd.c
> @@ -362,6 +362,13 @@ static unsigned int rpmhpd_get_performance_state(struct generic_pm_domain *genpd
>         return dev_pm_opp_get_level(opp);
>  }
>
> +static int rpmhpd_performance_states_count(struct generic_pm_domain *domain)
> +{
> +       struct rpmhpd *pd = domain_to_rpmhpd(domain);
> +
> +       return pd->level_count;
> +}
> +
>  static int rpmhpd_update_level_mapping(struct rpmhpd *rpmhpd)
>  {
>         int i;
> @@ -450,6 +457,7 @@ static int rpmhpd_probe(struct platform_device *pdev)
>                 rpmhpds[i]->pd.power_on = rpmhpd_power_on;
>                 rpmhpds[i]->pd.set_performance_state = rpmhpd_set_performance_state;
>                 rpmhpds[i]->pd.opp_to_performance_state = rpmhpd_get_performance_state;
> +               rpmhpds[i]->pd.get_performance_state_count = rpmhpd_performance_states_count;
>                 pm_genpd_init(&rpmhpds[i]->pd, NULL, true);
>
>                 data->domains[i] = &rpmhpds[i]->pd;
> --
> 2.20.1
>
