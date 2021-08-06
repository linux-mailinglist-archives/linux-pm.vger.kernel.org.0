Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904683E2366
	for <lists+linux-pm@lfdr.de>; Fri,  6 Aug 2021 08:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbhHFGnB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Aug 2021 02:43:01 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:53363 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbhHFGnB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Aug 2021 02:43:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628232165; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=d+wULbWjBRllkEa5XIMxDJfmrRItDoUDZncVMJPdisU=;
 b=jf62UsVVwMOVC/L7tRf2Wz8oKChBDGMzKmaJhxeL+PYKVaQONNYEBShQ4vxQnUq81d6J7S0N
 IPZ+z+WG0fdfM5Bk05M0+kiUesJnsgFgeBcWfSay55J+P0ZaYGfMFGG1drERX0LwHvFoX2Ab
 gRMU8sREmAqqpOgI5g83GjqfJlU=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 610cd9e48c78eaf808be871a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 06 Aug 2021 06:42:44
 GMT
Sender: sibis=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BFDA8C433D3; Fri,  6 Aug 2021 06:42:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 19E5BC433F1;
        Fri,  6 Aug 2021 06:42:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 06 Aug 2021 12:12:42 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     bjorn.andersson@linaro.org, mka@chromium.org, robh+dt@kernel.org,
        viresh.kumar@linaro.org, agross@kernel.org, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dianders@chromium.org, tdas@codeaurora.org
Subject: Re: [PATCH 2/4] cpufreq: qcom: Re-arrange register offsets to support
 per core L3 DCVS
In-Reply-To: <CAE-0n53b2M7hAw=NnUDW1_EG2N-521K=URQHmARH0DmLf7hwhA@mail.gmail.com>
References: <1627581885-32165-1-git-send-email-sibis@codeaurora.org>
 <1627581885-32165-3-git-send-email-sibis@codeaurora.org>
 <CAE-0n53cH749NC9JPqJvMZGBQf47AZ3qY66eoqk2CiQHvuumkg@mail.gmail.com>
 <352d549f40dfa2ae51589649652d2e97@codeaurora.org>
 <CAE-0n53b2M7hAw=NnUDW1_EG2N-521K=URQHmARH0DmLf7hwhA@mail.gmail.com>
Message-ID: <da0ea9c90d93e9e5f94e9cdb426e304b@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021-08-05 23:55, Stephen Boyd wrote:
> Quoting Sibi Sankar (2021-08-05 10:47:20)
>> Stephen,
>> 
>> Thanks for taking time to review
>> the series.
>> 
>> On 2021-08-05 00:31, Stephen Boyd wrote:
>> > Quoting Sibi Sankar (2021-07-29 11:04:43)
>> >> Qualcomm SoCs (starting with SM8350) support per core voting for L3
>> >> cache
>> >> frequency.
>> >
>> > And the L3 cache frequency voting code can't be put into this cpufreq
>> > driver?
>> 
>> Yes, it could have gone either into
>> the cpufreq driver or l3 interconnect
>> provider driver. Taniya/Odelu preferred
>> the latter, because of the need for other
>> clients to vote for l3 frequencies in
>> the future.
> 
> What other clients are those?

https://lore.kernel.org/lkml/20190814152116.GB28465@jcrouse1-lnx.qualcomm.com/

GPU was supposed to be one of the
other clients that would vote for
l3.

> 
>> The other option to prevent
>> register re-arrangement would involve
>> using syscons from the cpufreq node, which
>> really wasn't necessary since there
>> wasn't any register overlap between the
>> two drivers.
> 
> Let's not do that.
> 
>> 
>> >
>> >> So, re-arrange the cpufreq register offsets to allow access for
>> >> the L3 interconnect to implement per core control. Also prevent
>> >> binding
>> >> breakage caused by register offset shuffling by using the
>> >> SM8250/SM8350
>> >> EPSS compatible.
>> >>
>> >> Fixes: 7dbd121a2c58 ("arm64: dts: qcom: sc7280: Add cpufreq hw node")
>> >> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> >> ---
>> >>  drivers/cpufreq/qcom-cpufreq-hw.c | 23 +++++++++++++++++++----
>> >>  1 file changed, 19 insertions(+), 4 deletions(-)
>> >>
>> >> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c
>> >> b/drivers/cpufreq/qcom-cpufreq-hw.c
>> >> index f86859bf76f1..74ef3b38343b 100644
>> >> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
>> >> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
>> >> @@ -28,6 +28,7 @@ struct qcom_cpufreq_soc_data {
>> >>         u32 reg_volt_lut;
>> >>         u32 reg_perf_state;
>> >>         u8 lut_row_size;
>> >> +       bool skip_enable;
>> >>  };
>> >>
>> >>  struct qcom_cpufreq_data {
>> >> @@ -257,19 +258,31 @@ static const struct qcom_cpufreq_soc_data
>> >> qcom_soc_data = {
>> >>         .reg_volt_lut = 0x114,
>> >>         .reg_perf_state = 0x920,
>> >>         .lut_row_size = 32,
>> >> +       .skip_enable = false,
>> >>  };
>> >>
>> >>  static const struct qcom_cpufreq_soc_data epss_soc_data = {
>> >> +       .reg_freq_lut = 0x0,
>> >> +       .reg_volt_lut = 0x100,
>> >> +       .reg_perf_state = 0x220,
>> >> +       .lut_row_size = 4,
>> >> +       .skip_enable = true,
>> >> +};
>> >> +
>> >> +static const struct qcom_cpufreq_soc_data epss_sm8250_soc_data = {
>> >>         .reg_enable = 0x0,
>> >>         .reg_freq_lut = 0x100,
>> >>         .reg_volt_lut = 0x200,
>> >>         .reg_perf_state = 0x320,
>> >>         .lut_row_size = 4,
>> >> +       .skip_enable = false,
>> >>  };
>> >>
>> >>  static const struct of_device_id qcom_cpufreq_hw_match[] = {
>> >>         { .compatible = "qcom,cpufreq-hw", .data = &qcom_soc_data },
>> >>         { .compatible = "qcom,cpufreq-epss", .data = &epss_soc_data },
>> >> +       { .compatible = "qcom,sm8250-cpufreq-epss", .data =
>> >> &epss_sm8250_soc_data },
>> >> +       { .compatible = "qcom,sm8350-cpufreq-epss", .data =
>> >> &epss_sm8250_soc_data },
>> >>         {}
>> >>  };
>> >>  MODULE_DEVICE_TABLE(of, qcom_cpufreq_hw_match);
>> >> @@ -334,10 +347,12 @@ static int qcom_cpufreq_hw_cpu_init(struct
>> >> cpufreq_policy *policy)
>> >>         data->res = res;
>> >>
>> >>         /* HW should be in enabled state to proceed */
>> >
>> > It looks odd that we're no longer making sure that the clk domain is
>> > enabled when we probe the driver. Why is that OK?
>> 
>> On newer EPSS hw it's no longer
>> required to perform the additional
>> hw enable check. IIRC we don't do
>> that on corresponding downstream
>> kernels as well.
> 
> It's fairly clear that we no longer perform the additional check. The
> question is why that's OK.

Taniya probably would know more
about the history behind the change.
I'll dig up more info regarding ^^
and update the thread.


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
