Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2AF4364A3A
	for <lists+linux-pm@lfdr.de>; Mon, 19 Apr 2021 21:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239826AbhDSTHY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Apr 2021 15:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239447AbhDSTHX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Apr 2021 15:07:23 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C12C061763
        for <linux-pm@vger.kernel.org>; Mon, 19 Apr 2021 12:06:53 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id g4-20020a9d6b040000b029029debbbb3ecso619235otp.7
        for <linux-pm@vger.kernel.org>; Mon, 19 Apr 2021 12:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nS6lVdjAQFuFmi8OcV/NWRT3J31GQHJ6x1DbiIVFs9c=;
        b=BPS3XGyjmuDU202kT6j+i4GUG7bH0/UX6id7ANkMV4j6krFsStfFOmpSp1GowHtFqs
         e+bUAwvY3QxQO1YyLyH69dbyH3NyOXU3oJ+GMp6XG8jvwXdEkmOnrCXZ5jMU9TVDhovZ
         aE1yuktnSwTYK06qRFKjU5MQ6mLf0UO420Q7FASQEjvUNPtQ/uHChVwio8CoM+EolYX7
         fkkhhel/1cjHRpx8+jDLmsU0+5YNsad5K05glfAL9ZQisVQF9qiJSFMW8nv1F1mUohLT
         nc9nsFQjMdgDVRHNURGoBPaMlmkTRKiVAv8rz8heuq/d6zwIDVHb/DDTl/ZfCER06ZJV
         X2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nS6lVdjAQFuFmi8OcV/NWRT3J31GQHJ6x1DbiIVFs9c=;
        b=tWKH20UUbyXVPdVkT3SO/QHiT0Qa2h+tJVDSTtk1V5UuYwcSmconBpO5YTb9TGUkye
         mFPccjjDCExpgyvD0/L316HQMf44L+PlBuqvCYqUbSTPkJzq65rcmPcmBLJ2QDnvBqh8
         9P8YZnKktz7foycGBck6v5Pr4+GdsIjIijwoe6qkbUFTqzy92op7dn/QEsss4zGyMk4K
         uKwHMjPbyt1mBnxuqFLzUDEQ5JJzZOZ3sC51rK16zXnPI8UNSY9vCYiVdyY/JpwPSV8V
         aV2KG8BXKSKb/Oebj4CVjkvthVV7IyyoPDKkGp7PinLlsYTOi9nt0ZKVRVsCeeOQFa/m
         +fsg==
X-Gm-Message-State: AOAM5307USdvfKUCfi5TZidp7/+z0pnma+1shw+kg6eWsfM0ESQIvcYP
        JNkUD1feL4z1FRAHBuQz6qCbJA==
X-Google-Smtp-Source: ABdhPJxLe1/3CzYqXXwB0vxZ7+8+NQMslhHXoPfV20wEMFYc4HCiSCuaa98SjiWVXIrgij/eVTVZZg==
X-Received: by 2002:a9d:4808:: with SMTP id c8mr15759494otf.115.1618859212509;
        Mon, 19 Apr 2021 12:06:52 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id h81sm1642638oif.53.2021.04.19.12.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 12:06:51 -0700 (PDT)
Date:   Mon, 19 Apr 2021 14:06:49 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>, agross@kernel.org,
        rjw@rjwysocki.net, devicetree@vger.kernel.org, robh+dt@kernel.org,
        amit.kucheria@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jeffrey.l.hugo@gmail.com
Subject: Re: [PATCH v4 5/7] cpufreq: qcom-hw: Implement CPRh aware OSM
 programming
Message-ID: <20210419190649.GR1538589@yoga>
References: <20210119174557.227318-1-angelogioacchino.delregno@somainline.org>
 <20210119174557.227318-6-angelogioacchino.delregno@somainline.org>
 <c35bfd76-0d7e-d7bc-79ab-041b1074c1af@codeaurora.org>
 <YAh+9/IgRhI8M3ov@builder.lan>
 <92e465e4-a0d9-43eb-84f7-69fa355097a9@codeaurora.org>
 <20210413034940.o6uzjtnh2ylvikbf@vireshk-i7>
 <150e19b9-9ecf-7cac-8aa3-c7c4d7a11468@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <150e19b9-9ecf-7cac-8aa3-c7c4d7a11468@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed 14 Apr 20:31 CDT 2021, Taniya Das wrote:

> 
> On 4/13/2021 9:19 AM, Viresh Kumar wrote:
> > On 12-04-21, 15:01, Taniya Das wrote:
> > > Technically the HW we are trying to program here differs in terms of
> > > clocking, the LUT definitions and many more. It will definitely make
> > > debugging much more troublesome if we try to accommodate multiple versions of
> > > CPUFREQ-HW in the same code.
> > > 
> > > Thus to keep it simple, easy to read, debug, the suggestion is to keep it
> > > with "v1" tag as the OSM version we are trying to put here is from OSM1.0.
> > 
> > That is a valid point and is always a case with so many drivers. What
> > I am concerned about is how much code is common across versions, if it
> > is 5-70%, or more, then we should definitely share, arrange to have
> > callbacks or ops per version and call them in a generic fashion instead
> > of writing a new driver. This is what's done across
> > drivers/frameworks, etc.
> > 
> 
> The code sharing here between versions should be very minimal as most
> portion of the code here in V1 would focus on programming to prepare the LUT
> to be further read by the driver, the programming in itself is huge for v1.
> I am okay if you move the v1 in a different file and invoke based on
> version.
> 

The initialization of the hardware certainly is a large chunk of code,
but once initialized it's the same driver. Your argument that this new
code makes it harder to debug things doesn't seem relevant, as the old
support doesn't seem to affect the code paths used on the modern
version.

Creating a new driver and picking it by compatible is certainly possible
to do, but looking at Angelo's patch it seems like it would contain 100%
of what's in qcom-cpufreq-hw today.

As such, I like the approach suggested in this series.

Regards,
Bjorn
