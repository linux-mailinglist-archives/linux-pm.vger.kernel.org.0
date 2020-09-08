Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F98261D95
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 21:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730187AbgIHTjX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 15:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730329AbgIHPzg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2020 11:55:36 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F511C061A1C
        for <linux-pm@vger.kernel.org>; Tue,  8 Sep 2020 08:29:57 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id jw11so2311438pjb.0
        for <linux-pm@vger.kernel.org>; Tue, 08 Sep 2020 08:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NfYkZqMIYJWE0D6hAZLp/L+b7/9lJ1uqdfG5LMXNgTI=;
        b=j7xh1mezDjKnq8jlEyx3H7PuoKGQjIYYsw35I2dMoIM1UN9WYzIjFvAn03GXXuq9yJ
         mqhaMLnzZT38dHrvFh+bK60nqJ/8lpK15o+FGGp+4i2JqPBztH9gy1AtLWpd5GTs63T3
         n9+m9g3wrBRCi9s3EuhzbkZkrvLTU1GQBmyhB9jwGAHGyIEMUCwOQAwxjxt+ncA7Hp+i
         MUGb3ghi19LyECNbZeYA5fh311uFHZNyRgajh3nuFepjp4xfUzVfKeXJkU6HiR4QAAZQ
         emdqELmuOR1N0AnYwTsV2PpATECgkYBSgk+7ONtkvWJew8lQh/RusK6saWuItXajVSit
         JiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NfYkZqMIYJWE0D6hAZLp/L+b7/9lJ1uqdfG5LMXNgTI=;
        b=BrYkYMl2NmOtFO9+D6NiEUT6oSuOb0FoOWtlwYLANxLcIc6H5hG9N/AZekLQ9mWePx
         xFJJ1lBYlEeeiRM8ApWTaXaQ71eDfob0dwRhKe5y7AvBMqftyPwQUdJQ+0t9+otCpF1U
         PomFe+xz4ed9xWzP1Rr6Xe9Y3dLMRbce6z0CHE3pFO9lOhVAJIHJFjQ/r7d2IEy6zgpA
         s7B99qqN0xcAAaE27026dKIa72TmOYgMV8dt1vMp4vr86VkO2Base/dQ+tTeMUGK1fP7
         G/jV3MbzgJfDToQeMOuHlAp8sxtA406STy2knZO3Qwiu2fSOGRqtGaEBD4oQmqucJru7
         t3Ug==
X-Gm-Message-State: AOAM532pQ450CI4r3FxObzXCfO1PV4a9dxeHdprBS/JrqocnUZLYNSF6
        AztB75DjFx6FCdDXfGySnxL7
X-Google-Smtp-Source: ABdhPJwvA55i99BI5DTakOAt3ONRK/7kr2GEgohy/WyiAcHOxFtI1VU+SLt/pjiJAsV6uwWlM4oDEQ==
X-Received: by 2002:a17:90a:fe04:: with SMTP id ck4mr4687810pjb.210.1599578996799;
        Tue, 08 Sep 2020 08:29:56 -0700 (PDT)
Received: from mani-NUC7i5DNKE ([2409:4072:6213:6149:94b7:eeb3:82a5:2b53])
        by smtp.gmail.com with ESMTPSA id c199sm19091498pfc.128.2020.09.08.08.29.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Sep 2020 08:29:56 -0700 (PDT)
Date:   Tue, 8 Sep 2020 20:59:47 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, robh+dt@kernel.org,
        agross@kernel.org, amitk@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmitry.baryshkov@linaro.org,
        tdas@codeaurora.org
Subject: Re: [PATCH 6/7] cpufreq: qcom-hw: Add cpufreq support for SM8250 SoC
Message-ID: <20200908152926.GD2352@mani-NUC7i5DNKE>
References: <20200908075716.30357-1-manivannan.sadhasivam@linaro.org>
 <20200908075716.30357-7-manivannan.sadhasivam@linaro.org>
 <20200908152217.GO3715@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908152217.GO3715@yoga>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 0908, Bjorn Andersson wrote:
> On Tue 08 Sep 02:57 CDT 2020, Manivannan Sadhasivam wrote:
> 
> > SM8250 SoC uses EPSS block for carrying out the cpufreq duties. Hence, add
> > support for it in the driver with relevant of_match data.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> > ---
> >  drivers/cpufreq/qcom-cpufreq-hw.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> > index de816bcafd33..c3c397cc3dc6 100644
> > --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> > +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> > @@ -285,8 +285,17 @@ static const struct qcom_cpufreq_soc_data qcom_soc_data = {
> >  	.lut_row_size = 32,
> >  };
> >  
> > +static const struct qcom_cpufreq_soc_data sm8250_soc_data = {
> 
> Could it be that this is the "epss_soc_data" (i.e. not sm8250 specific)?
> (We should still use/include the platform specific compatible though).
> 

Hmm, makes sense. Will change it.

Thanks,
Mani

> Regards,
> Bjorn
> 
> > +	.reg_enable = 0x0,
> > +	.reg_freq_lut = 0x100,
> > +	.reg_volt_lut = 0x200,
> > +	.reg_perf_state = 0x320,
> > +	.lut_row_size = 4,
> > +};
> > +
> >  static const struct of_device_id qcom_cpufreq_hw_match[] = {
> >  	{ .compatible = "qcom,cpufreq-hw", .data = &qcom_soc_data },
> > +	{ .compatible = "qcom,sm8250-epss", .data = &sm8250_soc_data },
> >  	{}
> >  };
> >  MODULE_DEVICE_TABLE(of, qcom_cpufreq_hw_match);
> > -- 
> > 2.17.1
> > 
