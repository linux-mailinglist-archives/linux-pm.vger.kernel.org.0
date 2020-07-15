Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C922206D4
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 10:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbgGOIPW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 04:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgGOIPW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 04:15:22 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001CAC061755
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 01:15:21 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f18so1491834wrs.0
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 01:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=V6iOQn1Lci+q2i98jVN1XTnGz+Hdxpv3vM8VpJ0S+A4=;
        b=Eo5oREcFHhZXozrzcYRD2JWcOY62qWjJx/ikx+izFFRRQlFSm3LkxjcNRo7W4jftdw
         OT46EtdbcYELcxrrX4573eqhkuXexsQEidpGP0IqFGfV3QGzWWhlOv7B7xVTUXKYFEph
         ZbNl+aLguuorGcF2N2/Fk21KaYytnYjmzgOiKS6CkMtevjcWf/pdZq7CaHWvEcVFONFu
         GtSkZLE4zPAhj12kQBrIdXliiBDEWSoUCbUQuSgjdWJ/XjyCI2YoC0YMYUfLIPw7mZLv
         aR03zAHQgulnkuoYZCxoYXS/RqhyIRx8G6pkumIRMZeb9Ar5cf89hcp+Lv7zKTELW9Wz
         9Oow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=V6iOQn1Lci+q2i98jVN1XTnGz+Hdxpv3vM8VpJ0S+A4=;
        b=agYHwuJ4I6Q8gk0IFMeu8kX6El8QfpljKK4HZs+5tnAKYpPBItwYTNIiZmRU4EU8VZ
         NjvN8YQvAGidmhrwtKLwL+nQi7+U7X+kMYiNDS39GBNXkns9op2ggm8yc3tS6ex8gYYy
         1p3/Y6aUncitYUidebeSRzofFKs/W0J89S5lS5fSwudOEI+z2Z5X2sg1++AYI4fbeUGb
         gGyuWvfwnZfPjK8Yo21jfxz64Et+b7eFSX+Z0KULJMHT9TgCMm1J8AWZLUx34bgd2W4v
         BDD/OI4H8oAN3rez5jv509LPA+LqJW3gjwmDtat5w+lg4IeR8ysCD4P/Sb0CkzeEV73N
         aCCw==
X-Gm-Message-State: AOAM531qPBPIJLg1BaLt6BK5dgU4fNdWjrElQv/xUe6wDVmuAHb8HsJ+
        RVj6vsR7EqR6UuvTMhaQ9BemEDQXic8=
X-Google-Smtp-Source: ABdhPJwd+NKXVIjT54d4zwOzR0bqm0ITLJ5fYWXqUhjjUznee1tbkVt+fBHedhAAyIzddgA6Opsg+Q==
X-Received: by 2002:a5d:5441:: with SMTP id w1mr9526333wrv.381.1594800920670;
        Wed, 15 Jul 2020 01:15:20 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id t2sm2186116wma.43.2020.07.15.01.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 01:15:20 -0700 (PDT)
Date:   Wed, 15 Jul 2020 09:15:18 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Alexander Clouter <alex@digriz.org.uk>
Subject: Re: [PATCH 03/13] cpufreq: cpufreq_governor: Demote
 store_sampling_rate() header to standard comment block
Message-ID: <20200715081518.GA1398296@dell>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-4-lee.jones@linaro.org>
 <20200715025249.ukoqup4piqiz5lim@vireshk-i7>
 <20200715064539.GS1398296@dell>
 <20200715070836.l24lzkb6pgvqj26i@vireshk-i7>
 <20200715073150.GX1398296@dell>
 <20200715080236.n3gecwhidorn4rqq@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200715080236.n3gecwhidorn4rqq@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 15 Jul 2020, Viresh Kumar wrote:

> On 15-07-20, 08:31, Lee Jones wrote:
> > I'm not sure what you mean.  Kerneldoc headers are designed to be
> > extracted and converted into mediums which are easy to read/browse.
> > For example, see the online documentation for 'debug_object_init':
> > 
> >  https://www.kernel.org/doc/html/latest/core-api/debug-objects.html?highlight=debug_object_init#c.debug_object_init
> > 
> > They are generally meant to be referenced/consumed.  There is even a
> > script provided inside the kernel to find offending instances where
> > kerneldoc headers are provided, but not *yet* referenced:
> > 
> >  `scripts/find-unused-docs.sh`
> > 
> > HINT: There are many.
> > 
> > There *could* be and argument to use kerneldoc *just* so you can use
> > the kerneldoc checker `scripts/kernel-doc` (which is invoked by W=1
> > builds), in order to ensure the parameter descriptions are kept in
> > check.
> > 
> > However, in this case, there are no descriptions provided.  So, in
> > reference to my previous question, what are your reasons for wanting
> > to keep kerneldoc here?
> 
> I think the code did the right thing by keeping them as kernel doc
> type comments. What we missed then is getting them used in the *.rst
> documentation.
> 
> A simple way of doing that could be just adding this to the cpu-freq
> rst file, like:
> 
> -------------------------8<-------------------------
> Here are the bits from the in-source documentation:
> 
> .. kernel-doc:: include/linux/cpufreq.h
> .. kernel-doc:: drivers/cpufreq/cpufreq.c
> .. kernel-doc:: drivers/cpufreq/freq_table.c
> .. kernel-doc:: drivers/cpufreq/cpufreq_governor.c
> -------------------------8<-------------------------
> 
> This will make the script stop complaining about these.

This will stop `scripts/find-unused-docs.sh` from mentioning these
files as an offender, but `scripts/kernel-doc` and by extension W=1
builds (which is the point of this patch-set) will still complain.

Before you add the lines above, you need to provide descriptions for
each of the function parameters or else they will not reach the
required standards expected of kerneldoc.

My suggestion would be to take this (and the other) patch and
subsequently provide your own set i) providing the required parameter
descriptions ii) re-promoting the comment blocks to kerneldoc and iii)
adding the aforementioned lines to the *.rst file(s).

> But the layout of things wont' be very nice right now.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
