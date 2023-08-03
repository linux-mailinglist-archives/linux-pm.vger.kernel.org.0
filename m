Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A4E76DFE3
	for <lists+linux-pm@lfdr.de>; Thu,  3 Aug 2023 07:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjHCFtn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Aug 2023 01:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbjHCFtm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Aug 2023 01:49:42 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB7A2D43
        for <linux-pm@vger.kernel.org>; Wed,  2 Aug 2023 22:49:40 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-583f036d50bso5592797b3.3
        for <linux-pm@vger.kernel.org>; Wed, 02 Aug 2023 22:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691041779; x=1691646579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kfTUi7xflA+MwfHSQqcAtzP6pql4voH5e7kvmJj7QUs=;
        b=FnQp7K+goL5kX5YrNjoKe7RMe9oWsPBKNrqPHgFNhF3SoHfOH9xNzAX6lBHYZVXETK
         ZLbwfN6PBwwbZgZ/VFljDwBmSqtTjVZchhSdiB+sYRwl1E+8NZ0yrUxkexmdtzCSLjeB
         eQepK/Co4MpNaNGvZ9NG6Dhp2aJY8f1RJgNhk2x3PbIS4fhEpgPbRvW1hDMtbzh4dG2M
         1a/DKUBjQo+rtiMCqciXA4IKmNzLvbcB2EOmhVq1S7gFZjtjb4H2lxhouJAoSVeC3uFC
         F38QQCZjxfeksLovgnDZV7iDEJmi9J6HndbV48/lDnzFYJZZfwOPSRgGZF8YMfWKSau6
         k3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691041779; x=1691646579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfTUi7xflA+MwfHSQqcAtzP6pql4voH5e7kvmJj7QUs=;
        b=cT662eCdUQ1ArwPM3AsmBJtQozjmxqSrlHEFoLuV9ydVVNk1ZVOflDSq41D4LLaoov
         muEZIH8TugJxnP+nXXHmwpYGknDKkTmB9KxtWfinYUJRXmKpiBAAlxQcM1v6EjVZfulK
         QKNJVlE/37LJtu1tR77cqoI2/mcqy/4rJGCabI6GRbSWAHj5cS/Q7iKkqo7a/unG9EI/
         YBuGftEfHTwbhxf7LxL1C5woR2C2IHetNRmD2dEGhhX7GSHzuQP/tQEgxm166Vhdpu1P
         zsVi620a7qHbeUDG0qPMnbC9Fg9l6pAxPUaIotwRSBCcw7GxgipALSJrbP/Dum4cc2CE
         2KOw==
X-Gm-Message-State: ABy/qLZqsc4X3fz1bUFXAFumI1F37cAofxVlOVv3WuvGhhKNZh30HaWk
        ShYT8IL2/CfD/Zk51S8CO8RUOg==
X-Google-Smtp-Source: APBJJlFcSTIQ6AYzinujNeqC/VSvrhCiCIXIw1zsLOZIFkGtr7963td1ne5jUS+/eqdVRHBhyxIGXw==
X-Received: by 2002:a81:5cc1:0:b0:56f:ff55:2b7d with SMTP id q184-20020a815cc1000000b0056fff552b7dmr20769766ywb.17.1691041779473;
        Wed, 02 Aug 2023 22:49:39 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id hx11-20020a17090b440b00b00267a487f01bsm1881080pjb.48.2023.08.02.22.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 22:49:38 -0700 (PDT)
Date:   Thu, 3 Aug 2023 11:19:35 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: Re: [PATCH v13 01/10] cpufreq: blocklist MSM8998 in
 cpufreq-dt-platdev
Message-ID: <20230803054935.y36bjdxed4yvitev@vireshk-i7>
References: <20230217-topic-cpr3h-v13-0-d01cff1c54cf@linaro.org>
 <20230217-topic-cpr3h-v13-1-d01cff1c54cf@linaro.org>
 <CUI2S5IGZEHC.P7MUFZVOHCYR@lion.caleb.rex.connolly.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CUI2S5IGZEHC.P7MUFZVOHCYR@lion.caleb.rex.connolly.tech>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02-08-23, 13:58, Caleb Connolly wrote:
> On Wed Aug 2, 2023 at 1:37 PM BST, Konrad Dybcio wrote:
> > From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> >
> > Add the MSM8998 to the blocklist since the CPU scaling on this platform
> > is handled by a separate driver.
> >
> > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> > Tested-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> 
> // Caleb (they/them)
> 
> > ---
> >  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> > index e2b20080de3a..adb3579a1fee 100644
> > --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> > +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> > @@ -143,6 +143,7 @@ static const struct of_device_id blocklist[] __initconst = {
> >  
> >  	{ .compatible = "qcom,apq8096", },
> >  	{ .compatible = "qcom,msm8996", },
> > +	{ .compatible = "qcom,msm8998", },
> >  	{ .compatible = "qcom,qcs404", },
> >  	{ .compatible = "qcom,sa8155p" },
> >  	{ .compatible = "qcom,sa8540p" },

Applied patch 1/10.

-- 
viresh
