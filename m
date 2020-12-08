Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2D42D2E8C
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 16:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbgLHPoj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 10:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730081AbgLHPoj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2020 10:44:39 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875D0C0613D6
        for <linux-pm@vger.kernel.org>; Tue,  8 Dec 2020 07:43:53 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id t3so12477912pgi.11
        for <linux-pm@vger.kernel.org>; Tue, 08 Dec 2020 07:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1uYwNMg3VaPCTPb4giCP6mlC6goqoTuQxz4+TJa6DII=;
        b=LZ3rU7bT0SNeAFj110ey/Y+6g/QerjpNhZJ/9hoM3vGiWPRIaBgRkxe/FLiICQqV0O
         KsuE0exXVbrKZeXb+wBnbsipG71kxWQLmZpzSGgG5Q7EHf5okhA+dFTuGL54SOMAzGgh
         4fo9KN1rYTjYRHEN0JLLz058EHB2Wvi0DNjmKruw/kWIaZXHH15P5aqq6vE3XPIikfOi
         +btvbAbFFQeXV+AxBR34XKbpbmbMRp36aPyN8bc3uGOoLSO6jpBcBvOmyPP78iT8rqew
         5qsAg/oDFSKzudPW20rWdtiuAjTAV/hre48i0piUwgLz+fqyFl3WaV4jUvtYHuCIomRd
         2fKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1uYwNMg3VaPCTPb4giCP6mlC6goqoTuQxz4+TJa6DII=;
        b=mzQQt0prmL1ictbGKElsjXukD6YxiYjqv3K9XxUwdkD4lTPiMYWob+hneKWtfsmdEa
         6CYg1ALm0RunpjLydkNgpSQVKXLLycjMq16uL5qvpSGp7SwO5Dc18jknWdV/l0Hktcyh
         unBJJuvad1RU5D3TONhDK6jOGyvAg42HJsuZ0x83Hv3/Emv0/cdOE6xAFlp+SaYGmExS
         pKQGGfz6KYbjnJVwXPggbxXEpEhlmqnN/wXuhGavbkFIgp/JyJsQZQqR/iCrveLOvYzt
         Z/SyXIn76Wp/XzG8tMbTO2GAA7BTIEL9AQYZcYbO/hJb26ADudbSHocEUrZ301xR4+5k
         2QhA==
X-Gm-Message-State: AOAM533TKqMoDOImuh3IZg8zw5eDui1cB/MEiRBaRuP8FnzOYrY4vcBl
        IT1e7LZzz/oy3wApey2mpJGc
X-Google-Smtp-Source: ABdhPJxlqOc1kAoYByDL+H9WYOs/3/RDuI5QKTDGgB2DxSnSpDWuQytXOJoRMmGnI/TEjRb22H0x5Q==
X-Received: by 2002:a17:90a:902:: with SMTP id n2mr4823317pjn.126.1607442232989;
        Tue, 08 Dec 2020 07:43:52 -0800 (PST)
Received: from work ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id y15sm3744383pju.13.2020.12.08.07.43.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Dec 2020 07:43:52 -0800 (PST)
Date:   Tue, 8 Dec 2020 21:13:46 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Hector Yuan <hector.yuan@mediatek.com>, rjw@rjwysocki.net,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: cpus: Document
 'qcom,freq-domain' property
Message-ID: <20201208154346.GD9925@work>
References: <20201020153944.18047-1-manivannan.sadhasivam@linaro.org>
 <1603247803.20224.5.camel@mtkswgap22>
 <20201021095916.GA3334@Mani-XPS-13-9360>
 <20201021105037.vrqgmvbxxhccch33@vireshk-i7>
 <20201028154637.GB4065833@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028154637.GB4065833@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 28, 2020 at 10:46:37AM -0500, Rob Herring wrote:
> On Wed, Oct 21, 2020 at 04:20:37PM +0530, Viresh Kumar wrote:
> > On 21-10-20, 15:29, Manivannan Sadhasivam wrote:
> > > Hi,
> > > 
> > > On Wed, Oct 21, 2020 at 10:36:43AM +0800, Hector Yuan wrote:
> > > > Hi, Manivannan
> > > > 
> > > > On Tue, 2020-10-20 at 21:09 +0530, Manivannan Sadhasivam wrote:
> > > > > Add devicetree documentation for 'qcom,freq-domain' property specific
> > > > > to Qualcomm CPUs. This property is used to reference the CPUFREQ node
> > > > > along with Domain ID (0/1).
> > > > > 
> > > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/arm/cpus.yaml | 6 ++++++
> > > > >  1 file changed, 6 insertions(+)
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
> > > > > index 1222bf1831fa..f40564bf004f 100644
> > > > > --- a/Documentation/devicetree/bindings/arm/cpus.yaml
> > > > > +++ b/Documentation/devicetree/bindings/arm/cpus.yaml
> > > > > @@ -290,6 +290,12 @@ properties:
> > > > >  
> > > > >        * arm/msm/qcom,kpss-acc.txt
> > > > >  
> > > > > +  qcom,freq-domain:
> > > > Do you mind to change "qcom, freq-domain" to common naming? or drop the
> > > > prefix. So that we can use this CPU node and map it to each freq-domain.
> > > > Thanks a lot. 
> > > 
> > > I can do that but did the domain value match for other platforms as well?
> > 
> > I am not sure if you can. The code needs to be backward compatible so it can
> > support all devices shipped with older bootloaders and latest kernels. And so
> > changing the bindings isn't a good idea normally.
> 
> It can be done. We'd need to do the following:
> 
> - schema defines the common property/binding.
> - The kernel supports both names and that is backported to stable.
> - Update all the Qcom dts files to the new binding
> 
> Whether we actually do that or not, I'd like to keep the option open. 
> Aligning the current proposals should be possible. My concern is more 
> about what's the next addition and non-cpu device support.
> 

In the meantime can we get this series merged?

Thanks,
Mani

> Rob
