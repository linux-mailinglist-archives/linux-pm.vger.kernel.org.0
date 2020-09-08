Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43335262082
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 22:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730596AbgIHUMR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 16:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730115AbgIHPLR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2020 11:11:17 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D630EC08E817
        for <linux-pm@vger.kernel.org>; Tue,  8 Sep 2020 08:11:08 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b124so11166456pfg.13
        for <linux-pm@vger.kernel.org>; Tue, 08 Sep 2020 08:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DqQzdsNyVZxQfTKZQ3YstL3rPQCUat0ck3Wbh+a/dRg=;
        b=A42L4iBc1CLoIwG4vjkgmHVXssQmnn3pAMqht8EDGn5jdLIp0DEMm5fr4fRpNNZ6GB
         cYpBWQkG770jRLy7OaKNz1ax7PjmhebIMH94oOt0oJsVF+Dwlh/vxyjmbAEUSlWYeX7j
         nrYDiolhDL3/k31KAqubdudhePJwyIK4M16TzYv5GMRUnXe56k6P77Mwl6Dvu7VEGcgq
         bEapsJBiR0hlNw0O9U16OsSNqLJc2hWQmHmQZyXyzvMHCvFZEJxBP9L4835Zv9l944bW
         h6pGAmzhouGRV/7qtqbJ86YEqHShEZKpc1wDIxcNthdw4Kb+uUMDhUZ4ixEXFRS0sHq7
         pWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DqQzdsNyVZxQfTKZQ3YstL3rPQCUat0ck3Wbh+a/dRg=;
        b=loZFphbe9yq2Dg4hOA7k58d8uiKJNwGio4aF38Xzr0wrFbG2DYy/OCfCx0ugBQ/Qnj
         Y2G9x1RFLgBd2SWJEkC94TEJPT4q/clDlRkv3VPAl0MmCSmkq7T9tbgSfNhJVOT7M/E4
         UBjSbPLY9lXEKaiSsW2toLup7SX2+fZIWSLb0lzLhYQx+Sw/jhnSxZ3qjXU49Nv4JyxT
         1b/KQMjv4KlhUb3Kp1SpWI71Qvti6lwJ7eFwix2Pyp+X7ZIO71oSiTa/t9kJqIhp5Hbz
         4QG30Kq3TBprSc+47R4XmL30wK9Js+ww4zSwCtDqsq11SZeDJtxmfS5Oy8sPlWL/ZtnA
         8cIA==
X-Gm-Message-State: AOAM530XJAUEdyQ05JB9YScv5luOyVn9TJHyI3jE405NBht06vU00D8C
        Tx9aCHqvSPUO+P3RBq7FG6iM
X-Google-Smtp-Source: ABdhPJygg2wc2pJ6EFNe7SN5QXwBrjuD9HtWHBZlXZcCYsz145npyX1ctKgCmabtN4zCr836QQoSxA==
X-Received: by 2002:aa7:9201:0:b029:13e:d13d:a10c with SMTP id 1-20020aa792010000b029013ed13da10cmr1456521pfo.40.1599577868308;
        Tue, 08 Sep 2020 08:11:08 -0700 (PDT)
Received: from mani-NUC7i5DNKE ([2409:4072:6213:6149:cb0:8a44:a6a5:e3bd])
        by smtp.gmail.com with ESMTPSA id t25sm15461220pgn.13.2020.09.08.08.11.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Sep 2020 08:11:07 -0700 (PDT)
Date:   Tue, 8 Sep 2020 20:40:58 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, robh+dt@kernel.org,
        agross@kernel.org, amitk@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmitry.baryshkov@linaro.org,
        tdas@codeaurora.org
Subject: Re: [PATCH 1/7] dt-bindings: cpufreq: cpufreq-qcom-hw: Document
 SM8250 compatible
Message-ID: <20200908151050.GC2352@mani-NUC7i5DNKE>
References: <20200908075716.30357-1-manivannan.sadhasivam@linaro.org>
 <20200908075716.30357-2-manivannan.sadhasivam@linaro.org>
 <20200908145819.GN3715@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908145819.GN3715@yoga>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 0908, Bjorn Andersson wrote:
> On Tue 08 Sep 02:57 CDT 2020, Manivannan Sadhasivam wrote:
> 
> > Document the SM8250 SoC specific compatible for Qualcomm Cpufreq HW. The
> > hardware block which carries out CPUFreq operations on SM8250 SoC is
> > called EPSS.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Please follow up, after this has been accepted, with a conversion of
> this binding to yaml.
> 

Sure.

Thanks,
Mani

> Regards,
> Bjorn
> 
> > ---
> >  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> > index 33856947c561..aea4ddb2b9e8 100644
> > --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> > +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> > @@ -8,7 +8,7 @@ Properties:
> >  - compatible
> >  	Usage:		required
> >  	Value type:	<string>
> > -	Definition:	must be "qcom,cpufreq-hw".
> > +	Definition:	must be "qcom,cpufreq-hw" or "qcom,sm8250-epss".
> >  
> >  - clocks
> >  	Usage:		required
> > -- 
> > 2.17.1
> > 
