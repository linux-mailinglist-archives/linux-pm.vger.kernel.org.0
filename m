Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F29261288
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 16:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbgIHOUv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 10:20:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729721AbgIHOPu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Sep 2020 10:15:50 -0400
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86E1E21D90
        for <linux-pm@vger.kernel.org>; Tue,  8 Sep 2020 12:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599567012;
        bh=lq9eTjrWEGZEa2yiJKmSBpUchaqnuHBGfVpng6L9Aqc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2JBREKU6JRgGxsJ1r8Ce2Iju6vIu8ns/qPUApwNkh+GlxhyVWmZki8K1pkhPaBIMI
         oIjpxoan1Owvg0lws/TNOUleSTdKu7+AxYmUfIWC1QVQyHVnrSntCmcm31oOP9BeIn
         XhujwMCmWKaMS2a2Z8abpw9lH+pT866FkY6uho3Y=
Received: by mail-ua1-f53.google.com with SMTP id e41so4960511uad.6
        for <linux-pm@vger.kernel.org>; Tue, 08 Sep 2020 05:10:12 -0700 (PDT)
X-Gm-Message-State: AOAM533CR5QcDejYbod0ttkwfG+qCN7ECE+cJiArEIgyZWPDZkfzd2Jx
        r2CbvILAW2eJJE56eL8v/Zwv5zs52pBaH1K2H1McaA==
X-Google-Smtp-Source: ABdhPJzVyQm6/6q5OjrV7nqU3MI7oMJGT7K1lFXypEJBdr8i/tOI9S8ZGFWCl5CSa7p27tf/aSMle29PYGnK5195eZQ=
X-Received: by 2002:ab0:384a:: with SMTP id h10mr5065875uaw.77.1599567011727;
 Tue, 08 Sep 2020 05:10:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200908075716.30357-1-manivannan.sadhasivam@linaro.org> <20200908075716.30357-7-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20200908075716.30357-7-manivannan.sadhasivam@linaro.org>
From:   Amit Kucheria <amitk@kernel.org>
Date:   Tue, 8 Sep 2020 17:40:00 +0530
X-Gmail-Original-Message-ID: <CAHLCerNaf6hdC5etZoiq2pvvRt85CpD0yEW5_pcfpQKDjHk5Fw@mail.gmail.com>
Message-ID: <CAHLCerNaf6hdC5etZoiq2pvvRt85CpD0yEW5_pcfpQKDjHk5Fw@mail.gmail.com>
Subject: Re: [PATCH 6/7] cpufreq: qcom-hw: Add cpufreq support for SM8250 SoC
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Taniya Das <tdas@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 8, 2020 at 1:27 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> SM8250 SoC uses EPSS block for carrying out the cpufreq duties. Hence, add
> support for it in the driver with relevant of_match data.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Amit Kucheria <amitk@kernel.org>


> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index de816bcafd33..c3c397cc3dc6 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -285,8 +285,17 @@ static const struct qcom_cpufreq_soc_data qcom_soc_data = {
>         .lut_row_size = 32,
>  };
>
> +static const struct qcom_cpufreq_soc_data sm8250_soc_data = {
> +       .reg_enable = 0x0,
> +       .reg_freq_lut = 0x100,
> +       .reg_volt_lut = 0x200,
> +       .reg_perf_state = 0x320,
> +       .lut_row_size = 4,
> +};
> +
>  static const struct of_device_id qcom_cpufreq_hw_match[] = {
>         { .compatible = "qcom,cpufreq-hw", .data = &qcom_soc_data },
> +       { .compatible = "qcom,sm8250-epss", .data = &sm8250_soc_data },
>         {}
>  };
>  MODULE_DEVICE_TABLE(of, qcom_cpufreq_hw_match);
> --
> 2.17.1
>
