Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F37451A4CE
	for <lists+linux-pm@lfdr.de>; Wed,  4 May 2022 18:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239187AbiEDQEO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 May 2022 12:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353063AbiEDQEE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 May 2022 12:04:04 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D637FDF44
        for <linux-pm@vger.kernel.org>; Wed,  4 May 2022 09:00:26 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d25so1468123pfo.10
        for <linux-pm@vger.kernel.org>; Wed, 04 May 2022 09:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TkWAh/zEKnD9qRinAOAqcRHDKnyhx2C9kbdq3Vzq1JU=;
        b=ewE0aA6uLeto/nVe/PJGDnD5Zb6f5fg9VvE+LN/Ks9woM1TP5xCQCC3v05q+On3t60
         XHP2UQSObCPMbVOFXr5nELPeB+f06tSvBK1d1RvfXEumgOTQa7eLJzIBgDcXhehLjUJJ
         HVyVzMi+3plLFQRKAKXVJruM7qnNIvyKe7sbgKaeg1lK/18b2D4hruZr8O4w/5qIJ16U
         fRPi5vo1SGiNrNPUgYx4WE3O7kE/x5WNqCBFx8dUgwUL4GYu2RrSMNr5T6fyFaOVNg5z
         gT4vuRIuXSQ3zXvaHLXUNjF0m20ZfUEE4/Lb0p5e072jD7XhxteMcS3mjSrtFVg6ZWla
         Psnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TkWAh/zEKnD9qRinAOAqcRHDKnyhx2C9kbdq3Vzq1JU=;
        b=lTKoDD1WiVZz5Q4XBb5xnlGixGggnMbmphzTP6rn2entzqpMwaehhathX586l8DUgf
         hEPn9P/qafyy7g8MGPdE+LVsHQa5kQ8FrCAI+vyDlbKb6SauRTPBiKTNHE0VqWdPR/R+
         oF3ixiVp8pAgf7yFyOTmm0/zq/Kbb9V1Gcgr3WI8PF50bjfCdcfnR53JAPVUOaQtW7ke
         Uem5PdC2CK11Sbr0UIHbJPU4yEDTCntSiJjuUR0kG1qn7GIw5h+KMRPSz0WlzljXvbGR
         Cy+m3IKKzfYb2eiTg6iQcjRi6UFHKyq2Nk+ItEp70W6B5dVIqyN/I2YTqWDA0CQbu02R
         NZtA==
X-Gm-Message-State: AOAM530G0KB98CuG31yLc2EV8wLiIGLeGxAJQigPlNOXc3AKXPSN/+bC
        iSE5v6SiqssAyaHGffG4BPok
X-Google-Smtp-Source: ABdhPJy9JetOr3XHoQXjint5jAscYPRn3DBeO/Mgpg4CnjM2dLrUuvZsZP/4GJjz1y6YrYXVCUiJDg==
X-Received: by 2002:a63:90ca:0:b0:3aa:fff3:6f76 with SMTP id a193-20020a6390ca000000b003aafff36f76mr18287435pge.206.1651680026330;
        Wed, 04 May 2022 09:00:26 -0700 (PDT)
Received: from thinkpad ([117.207.25.57])
        by smtp.gmail.com with ESMTPSA id v15-20020a62a50f000000b0050dc76281bdsm8383185pfm.151.2022.05.04.09.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 09:00:26 -0700 (PDT)
Date:   Wed, 4 May 2022 21:30:19 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Hector Martin <marcan@marcan.st>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Apple SoC cpufreq driver
Message-ID: <20220504160019.GB3507@thinkpad>
References: <20220504075153.185208-1-marcan@marcan.st>
 <20220504102745.fv5bl2cphq7ft4lm@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504102745.fv5bl2cphq7ft4lm@vireshk-i7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On Wed, May 04, 2022 at 03:57:45PM +0530, Viresh Kumar wrote:
> On 04-05-22, 16:51, Hector Martin wrote:
> > Hi folks,
> > 
> > Here's a second take on the cpufreq driver for Apple SoCs. This is a
> > complete rewrite using a stand-alone cpufreq driver instead of using the
> > cpufreq-dt infrastructure.
> > 
> > Since v1 we ran some experiments on the memory controller performance
> > switching and it turns out it doesn't make a huge difference, so it
> > makes sense to punt that feature to the future (perhaps once a proper
> > memory controller driver exists for other reasons, e.g. for error
> > handling).
> > 
> > One advantage of having a standalone cpufreq driver is that we can
> > support fast switching. This also means any future interaction with
> > the memory controller will probably use some bespoke mechanism instead
> > of the genpd infrastructure, so we can keep the fast path without
> > allowing sleeps/etc.
> > 
> > The driver is based on scpi-cpufreq.c, with some bits (e.g. the
> > apple,freq-domain stuff) inspired by how cpufreq-qcom-hw does it.
> > I'm not sure if that particular property should be described
> > in a binding, since it goes in the cpu nodes (qcom doesn't have it
> > anywhere...).
> 
> Hi Mani,
> 
> I can see that Rob asked you to add this somewhere, maybe in arm/cpu
> stuff, but I don't think you ever sent a patch with that. What
> happened ?
> 
> https://lore.kernel.org/lkml/20201013171800.GA3716411@bogus/
> 

Oops. Looks like that one slipped through the cracks. I did add it to my todo
list for qcom-cpufreq but missed it completely.

I will look into it.

Thanks,
Mani

> -- 
> viresh
