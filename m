Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A033E1B31
	for <lists+linux-pm@lfdr.de>; Thu,  5 Aug 2021 20:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhHESZ4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Aug 2021 14:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241174AbhHESZw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Aug 2021 14:25:52 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96184C0613D5
        for <linux-pm@vger.kernel.org>; Thu,  5 Aug 2021 11:25:37 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id q6so8553335oiw.7
        for <linux-pm@vger.kernel.org>; Thu, 05 Aug 2021 11:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=gbLW+QJDyMH5Sf+1Cq2rIN5slJ0ZGcO1ZiPIvxeYo5w=;
        b=edHXr9Em2Ae1iDzPPrZwEFUi2pZrq6mEx+CwbOtGzU/xz69mA/UXUkPeRrtIVdw/H7
         Rg7Kz3vsJUP4zuvaBGEJXuRbBfQvE5waRO06uyVUVpNvUfN5tuHtDpT5uJrKvPWIkHy4
         HyizBwDg/4vL19+901+B/P+dH7mPCyiPprMpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=gbLW+QJDyMH5Sf+1Cq2rIN5slJ0ZGcO1ZiPIvxeYo5w=;
        b=FP55nOFTLmsWbEhoEjGKbSY5w8Wc6lMxs+39zSwTMNiY7C2aYN+Btmwyq2Iyfa0pb3
         M7FRfdWZNcvyTqtqmypWUSW0TsUwqszLWrfKdsMkYHBa+3BzQuJit260D5pmJzjYNmFT
         174QmKOeucpp86ceaezqP+J6LcnvopJuCBDA5ICiBjsDShwgPLD1yy2lglXTak32A/ie
         0retmzyEeuymf9QpfvK0EOd7a76pI9AcdcYCuDHUrtFTvHMDBQ+pF/l9plKBIdW2lJBa
         bzLTIXUpVX72Xp72TOzCc9O5PRuL4hwhEtE2VcqZJsUzyZJqUxRkv3gFL8cWiQ4L2Goe
         mVEQ==
X-Gm-Message-State: AOAM532IE0ANkEo/a9ylRpUNORL4Utg85U/UiqjyVz9Bz8/mu9uDP8XF
        hS2hk9TMcqqOHYT+6s3XBB1YWDZXhqzsjXb0fnRjoQ==
X-Google-Smtp-Source: ABdhPJyccareZr9XYB2TNH6O7ILoE1pab7v0BuEsi+iAsQ3sDIOPWDdP+Rr3mQqXnnLWw+u1pFTieFO8dUukUSequwg=
X-Received: by 2002:a54:468d:: with SMTP id k13mr12082607oic.125.1628187936930;
 Thu, 05 Aug 2021 11:25:36 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Aug 2021 11:25:36 -0700
MIME-Version: 1.0
In-Reply-To: <352d549f40dfa2ae51589649652d2e97@codeaurora.org>
References: <1627581885-32165-1-git-send-email-sibis@codeaurora.org>
 <1627581885-32165-3-git-send-email-sibis@codeaurora.org> <CAE-0n53cH749NC9JPqJvMZGBQf47AZ3qY66eoqk2CiQHvuumkg@mail.gmail.com>
 <352d549f40dfa2ae51589649652d2e97@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 5 Aug 2021 11:25:36 -0700
Message-ID: <CAE-0n53b2M7hAw=NnUDW1_EG2N-521K=URQHmARH0DmLf7hwhA@mail.gmail.com>
Subject: Re: [PATCH 2/4] cpufreq: qcom: Re-arrange register offsets to support
 per core L3 DCVS
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, mka@chromium.org, robh+dt@kernel.org,
        viresh.kumar@linaro.org, agross@kernel.org, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dianders@chromium.org, tdas@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Sibi Sankar (2021-08-05 10:47:20)
> Stephen,
>
> Thanks for taking time to review
> the series.
>
> On 2021-08-05 00:31, Stephen Boyd wrote:
> > Quoting Sibi Sankar (2021-07-29 11:04:43)
> >> Qualcomm SoCs (starting with SM8350) support per core voting for L3
> >> cache
> >> frequency.
> >
> > And the L3 cache frequency voting code can't be put into this cpufreq
> > driver?
>
> Yes, it could have gone either into
> the cpufreq driver or l3 interconnect
> provider driver. Taniya/Odelu preferred
> the latter, because of the need for other
> clients to vote for l3 frequencies in
> the future.

What other clients are those?

> The other option to prevent
> register re-arrangement would involve
> using syscons from the cpufreq node, which
> really wasn't necessary since there
> wasn't any register overlap between the
> two drivers.

Let's not do that.

>
> >
> >> So, re-arrange the cpufreq register offsets to allow access for
> >> the L3 interconnect to implement per core control. Also prevent
> >> binding
> >> breakage caused by register offset shuffling by using the
> >> SM8250/SM8350
> >> EPSS compatible.
> >>
> >> Fixes: 7dbd121a2c58 ("arm64: dts: qcom: sc7280: Add cpufreq hw node")
> >> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> >> ---
> >>  drivers/cpufreq/qcom-cpufreq-hw.c | 23 +++++++++++++++++++----
> >>  1 file changed, 19 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c
> >> b/drivers/cpufreq/qcom-cpufreq-hw.c
> >> index f86859bf76f1..74ef3b38343b 100644
> >> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> >> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> >> @@ -28,6 +28,7 @@ struct qcom_cpufreq_soc_data {
> >>         u32 reg_volt_lut;
> >>         u32 reg_perf_state;
> >>         u8 lut_row_size;
> >> +       bool skip_enable;
> >>  };
> >>
> >>  struct qcom_cpufreq_data {
> >> @@ -257,19 +258,31 @@ static const struct qcom_cpufreq_soc_data
> >> qcom_soc_data = {
> >>         .reg_volt_lut = 0x114,
> >>         .reg_perf_state = 0x920,
> >>         .lut_row_size = 32,
> >> +       .skip_enable = false,
> >>  };
> >>
> >>  static const struct qcom_cpufreq_soc_data epss_soc_data = {
> >> +       .reg_freq_lut = 0x0,
> >> +       .reg_volt_lut = 0x100,
> >> +       .reg_perf_state = 0x220,
> >> +       .lut_row_size = 4,
> >> +       .skip_enable = true,
> >> +};
> >> +
> >> +static const struct qcom_cpufreq_soc_data epss_sm8250_soc_data = {
> >>         .reg_enable = 0x0,
> >>         .reg_freq_lut = 0x100,
> >>         .reg_volt_lut = 0x200,
> >>         .reg_perf_state = 0x320,
> >>         .lut_row_size = 4,
> >> +       .skip_enable = false,
> >>  };
> >>
> >>  static const struct of_device_id qcom_cpufreq_hw_match[] = {
> >>         { .compatible = "qcom,cpufreq-hw", .data = &qcom_soc_data },
> >>         { .compatible = "qcom,cpufreq-epss", .data = &epss_soc_data },
> >> +       { .compatible = "qcom,sm8250-cpufreq-epss", .data =
> >> &epss_sm8250_soc_data },
> >> +       { .compatible = "qcom,sm8350-cpufreq-epss", .data =
> >> &epss_sm8250_soc_data },
> >>         {}
> >>  };
> >>  MODULE_DEVICE_TABLE(of, qcom_cpufreq_hw_match);
> >> @@ -334,10 +347,12 @@ static int qcom_cpufreq_hw_cpu_init(struct
> >> cpufreq_policy *policy)
> >>         data->res = res;
> >>
> >>         /* HW should be in enabled state to proceed */
> >
> > It looks odd that we're no longer making sure that the clk domain is
> > enabled when we probe the driver. Why is that OK?
>
> On newer EPSS hw it's no longer
> required to perform the additional
> hw enable check. IIRC we don't do
> that on corresponding downstream
> kernels as well.

It's fairly clear that we no longer perform the additional check. The
question is why that's OK.
