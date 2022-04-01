Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EECB4EFCBE
	for <lists+linux-pm@lfdr.de>; Sat,  2 Apr 2022 00:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349992AbiDAWXn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Apr 2022 18:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236004AbiDAWXm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Apr 2022 18:23:42 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5611FD2D1
        for <linux-pm@vger.kernel.org>; Fri,  1 Apr 2022 15:21:52 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so4220298fac.7
        for <linux-pm@vger.kernel.org>; Fri, 01 Apr 2022 15:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1hnBwQmiOTGzWufUkZl5IK4YopIj4LHeJAPlfyA6BCQ=;
        b=Tm5UGe2mSpAfGWM3R4xXYsCvsiQjuEkMR8F6pf782f94IFIBHsBNd4kUV+NFbN/CMv
         9hyOCiaovmUnCXCQYM8ECV4XP+36s4qv1byUpjuyEhRM1gr39PHlIffE/3wy3EWu50/A
         8IrUMTGa74+4FDnNWhdALsM4hm9GDbks7s5xZHgnBtMLkFt/heFcwf/s0FfHkArWnBd1
         zHpdsb1+yLvynGsRPswBu++vx/3jqfTFFwCYTKTLYvP2oVfbLiUihTZssKV5zmpq3pRi
         8+LxV4+VwvYgQwHKyFc8bw0zWrL6HfyxEeLo83DtO0zRvEDEVYyBA14MWI1jaAnIsWzR
         /taw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1hnBwQmiOTGzWufUkZl5IK4YopIj4LHeJAPlfyA6BCQ=;
        b=vhsyrSPGDmLjTsoJ9O7Jgv4q75vzB6dq//n80VSKQ8t4w7PzIGlyKhVP0WlnKVQKjX
         WGviT1nAMLkSZMbbPAh5x0YMQPLwN8/eaqdu20Rtyoli4piQdLAIujzB8IY7xuQvurPW
         xv1ab+tsHWoGTeQU2ynhqz362zOZu8x0wpU+GiH8EOxXQxjb4UJ5StYwvuBcKHQJ4/ii
         yZj7h/dRsFS0zDVsgyYtaixO7/w1Wqc7fTFhgjDGMtrzKS8qQEYaZSBcz0U7Md4KuYUP
         S5DbdpMmPG9QBpv/6cWtTMX0uDCYgC6DxUO9/VZ9DSY2qwpiv3eQKvhTqzzMPKg3xapN
         bTeQ==
X-Gm-Message-State: AOAM530w/gwkIWIROERSHvGFxaffrcrdIN40CDAVoljnh6X9RQY7uEM+
        nX+cdqc6cp6Jxiv1rSM3tMT3Dg==
X-Google-Smtp-Source: ABdhPJw0lKGiFa251bil9ocsdJS6UVvAKqIkdfeOCqKCy95PIzCOpSijrQ1ExW/6FmegoRtIR3xh/w==
X-Received: by 2002:a05:6870:e408:b0:de:b929:5206 with SMTP id n8-20020a056870e40800b000deb9295206mr6091717oag.71.1648851711800;
        Fri, 01 Apr 2022 15:21:51 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id s10-20020a4a3b0a000000b0032486bc11d0sm1625192oos.39.2022.04.01.15.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 15:21:50 -0700 (PDT)
Date:   Fri, 1 Apr 2022 15:24:19 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] cpufreq: qcom-cpufreq-hw: Clear dcvs interrupts
Message-ID: <Ykd7kwxwTxFjiNT0@ripper>
References: <20220401071424.2869057-1-vladimir.zapolskiy@linaro.org>
 <20220401071424.2869057-2-vladimir.zapolskiy@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401071424.2869057-2-vladimir.zapolskiy@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri 01 Apr 00:14 PDT 2022, Vladimir Zapolskiy wrote:

> It's noted that dcvs interrupts are not self-clearing, thus an interrupt
> handler runs constantly, which leads to a severe regression in runtime.
> To fix the problem an explicit write to clear interrupt register is
> required.
> 
> Fixes: 275157b367f4 ("cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support")
> Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> ---
> Changes from v1 to v2:
> * added a check for pending interrupt status before its handling,
>   thanks to Bjorn for review
> 
>  drivers/cpufreq/qcom-cpufreq-hw.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index f9d593ff4718..e17413a6f120 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -24,6 +24,8 @@
>  #define CLK_HW_DIV			2
>  #define LUT_TURBO_IND			1
>  
> +#define GT_IRQ_STATUS			BIT(2)
> +
>  #define HZ_PER_KHZ			1000
>  
>  struct qcom_cpufreq_soc_data {
> @@ -31,6 +33,8 @@ struct qcom_cpufreq_soc_data {
>  	u32 reg_dcvs_ctrl;
>  	u32 reg_freq_lut;
>  	u32 reg_volt_lut;
> +	u32 reg_intr_clr;
> +	u32 reg_intr_status;
>  	u32 reg_current_vote;
>  	u32 reg_perf_state;
>  	u8 lut_row_size;
> @@ -345,11 +349,19 @@ static void qcom_lmh_dcvs_poll(struct work_struct *work)
>  static irqreturn_t qcom_lmh_dcvs_handle_irq(int irq, void *data)
>  {
>  	struct qcom_cpufreq_data *c_data = data;
> +	u32 val;
> +
> +	val = readl_relaxed(c_data->base + c_data->soc_data->reg_intr_status);

Seems reasonable to read the INTR_STATUS register and bail early if
there's no interrupt.

> +	if (!(val & GT_IRQ_STATUS))
> +		return IRQ_HANDLED;

But if we in the interrupt handler realize that there's no interrupt
pending for us, shouldn't we return IRQ_NONE?

>  
>  	/* Disable interrupt and enable polling */
>  	disable_irq_nosync(c_data->throttle_irq);
>  	schedule_delayed_work(&c_data->throttle_work, 0);
>  
> +	writel_relaxed(GT_IRQ_STATUS,
> +		       c_data->base + c_data->soc_data->reg_intr_clr);

And in OSM (i.e. not epss_soc_data), both reg_intr_status and
reg_intr_clr will be 0, so we end up reading and writing the wrong
register.

You need to do:
	if (c_data->soc_data->reg_intr_clr)
		writel_relaxed(..., reg_intr_clr);

But according to the downstream driver, this is supposed to be done in
the polling function, right before you do enable_irq().

Regards,
Bjorn

> +
>  	return IRQ_HANDLED;
>  }
>  
> @@ -368,6 +380,8 @@ static const struct qcom_cpufreq_soc_data epss_soc_data = {
>  	.reg_dcvs_ctrl = 0xb0,
>  	.reg_freq_lut = 0x100,
>  	.reg_volt_lut = 0x200,
> +	.reg_intr_clr = 0x308,
> +	.reg_intr_status = 0x30c,
>  	.reg_perf_state = 0x320,
>  	.lut_row_size = 4,
>  };
> -- 
> 2.33.0
> 
