Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBFF3AD18F
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jun 2021 19:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbhFRR46 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Jun 2021 13:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234687AbhFRR45 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Jun 2021 13:56:57 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D613C06175F
        for <linux-pm@vger.kernel.org>; Fri, 18 Jun 2021 10:54:47 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id m137so11414534oig.6
        for <linux-pm@vger.kernel.org>; Fri, 18 Jun 2021 10:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5oh/1ZLh42AYk2P4TsRS4SjWxZLplR+HO5fqto1uLzs=;
        b=zHVb98aPddS/STxZ6A48pGMwaFX7GNVnhmQQieYPTVopIRZPwNSKg30zJzPPTiL2EY
         X8fPZeJGbTAc3XL1M96Xvj4dj6MSAX0vKqWxSTKPOKc46euCjRORfE1do23Bl9f0VGWJ
         4cSe6U1ayyZXa17XSNgBadGkL+QxsC0k4CZ2r829fvr4kPCRmKzwBNosGpbZfo8ubQLK
         ffWiKdwM3751PBAtsy0YlXwHc0KQtPgT2YmJffiMgpL4uM8kI6v+9gE6TX6HrPsb/89W
         0CkGkkjFoG0DgKvvXckIwNjcTSN50aXk1GK5Rj56DbpQP0Tv0Z/KcvFJou6eAFd4UwqG
         DUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5oh/1ZLh42AYk2P4TsRS4SjWxZLplR+HO5fqto1uLzs=;
        b=kiVJXjkqlNIg6tiui4P2Zl9UhhEQpLPb94LXbTCGIbhirASQC8/tPzlJw1zt+ESJpE
         kUYCey36fuD/7DqlqL7puHqIk+UrcGTyxmiAU/mQPcEYdXTzo0prtOBuzOK7fhZuBUTA
         R6a4nNtvkvuK/GStjIvY1HldRYiUaoI8eOsK2QaWfBqPNbKSFPYZxUqCY0czlsp2rVwP
         T9BSwEIgiYmEQ63U+BBb1IMnPBd6QV35osTEcHtCRRkeTkvuwZq7uJKr0xZj13ixbnpx
         LZhJMtMu3QohiWv2mEbEU5KRR45TzPU8yd8qDnI88Kf2nm7ZDo4mNkimCJUDH34RgoMC
         /dig==
X-Gm-Message-State: AOAM53395WYGY36zAj0kGCXg6R2THS37SJxTZSKt4ZAsRPFbkCvxXyHm
        EGOqzUuxVJMcDJq0qT3fcTZ4KA==
X-Google-Smtp-Source: ABdhPJzuySRyk/ihyzd1bxyZ7kih5vVebf3rT8wObyqtHflCwKFYj5FH6LRegSCxUP5SMimmF5Odsw==
X-Received: by 2002:aca:b682:: with SMTP id g124mr8107800oif.138.1624038886344;
        Fri, 18 Jun 2021 10:54:46 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id z5sm2168454oth.6.2021.06.18.10.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 10:54:45 -0700 (PDT)
Date:   Fri, 18 Jun 2021 12:54:44 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     agross@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rjw@rjwysocki.net, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/5] thermal: qcom: Add support for LMh driver
Message-ID: <YMzd5OEhG4PYYv+E@builder.lan>
References: <20210608222926.2707768-1-thara.gopinath@linaro.org>
 <20210608222926.2707768-3-thara.gopinath@linaro.org>
 <YMfBtSap7fR3rdku@builder.lan>
 <4996de55-daa9-18a4-3c03-cf194d85500e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4996de55-daa9-18a4-3c03-cf194d85500e@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon 14 Jun 20:38 CDT 2021, Thara Gopinath wrote:
> On 6/14/21 4:53 PM, Bjorn Andersson wrote:
> > On Tue 08 Jun 17:29 CDT 2021, Thara Gopinath wrote:
> > > diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
[..]
> > > +static irqreturn_t lmh_handle_irq(int hw_irq, void *data)
> > > +{
> > > +	struct lmh_hw_data *lmh_data = data;
> > > +	int irq = irq_find_mapping(lmh_data->domain, 0);
> > > +
> > > +	/*
> > > +	 * Disable interrupt and call the cpufreq driver to handle the interrupt
> > > +	 * cpufreq will enable the interrupt once finished processing.
> > > +	 */
> > > +	disable_irq_nosync(lmh_data->irq);
> > 
> > The contract between this driver's disabling of the IRQ and the
> > cpufreq-hw driver's enabling it when we're done polling does worry me.
> > 
> > In the case of EPSS, don't we disable the interrupt during the polling
> > there as well? If that's the case wouldn't it be better to implement
> > irq_chip->irq_disable and have the cpufreq-hw driver do the disable in
> > both cases?
> 
> Yes. You are right. In case of EPSS, the cpufreq-hw will have to disable the
> interrupt. I did think of the approach you suggested here. My only issue is
> that we will dispatch the interrupt to cpufreq-hw without it disabling it
> and hence the interrupt could fire again, right ?
> 

Does it fire again before you INTR_CLK it?

Regards,
Bjorn
