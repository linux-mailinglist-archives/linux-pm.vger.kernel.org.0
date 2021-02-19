Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1029B31FE76
	for <lists+linux-pm@lfdr.de>; Fri, 19 Feb 2021 19:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhBSSAn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Feb 2021 13:00:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:42204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbhBSSAm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Feb 2021 13:00:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 54ECE64DED;
        Fri, 19 Feb 2021 18:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613757602;
        bh=kqVxXeKoanAaf4lKZCg0WZf+Os3oG4slsz+NXtiCX9k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VdH47edSAw+qcJPQl5fzToN0GK+9trQofhHiKj41c6KvQSUZnc4arcx5N5g5KUkX/
         I6bWcxpi9j22wzGIC3ORCifeIHFRZ2PONF885XFhlQnTpCt2yKVYIn3xxVDYa50qmy
         SKsbR5BcmwN0naa7cXzyDRvf6rq/9qhm5ma4a2beS00wldWSwul3801FpmhGTiVJ7c
         4kK/MPOD/J4JS5GxsR1x7Op6BryCLY4q0jsT60vQM5271pEQn5lAKVPyS9uURsi4Vg
         jqV5xklrKu4iI/sxFBNQ9SfsT5f8HzvyFXUzohNR7rE8z/LGEmdwDTrXKg8vBNreED
         16Njh25CrntwQ==
Date:   Fri, 19 Feb 2021 23:29:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>, mani@kernel.org
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: cpufreq: cpufreq-qcom-hw: Document SM8350
 CPUfreq compatible
Message-ID: <20210219175958.GZ2774@vkoul-mobl.Dlink>
References: <20210216111251.1838149-1-vkoul@kernel.org>
 <20210218161158.GC5254@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218161158.GC5254@yoga>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-02-21, 10:11, Bjorn Andersson wrote:
> On Tue 16 Feb 05:12 CST 2021, Vinod Koul wrote:
> 
> > Add the CPUfreq compatible for SM8350 SoC along with note for using the
> > specific compatible for SoCs
> > 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> > index 9299028ee712..3eb3cee59d79 100644
> > --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> > +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> > @@ -8,7 +8,9 @@ Properties:
> >  - compatible
> >  	Usage:		required
> >  	Value type:	<string>
> > -	Definition:	must be "qcom,cpufreq-hw" or "qcom,cpufreq-epss".
> > +	Definition:	must be "qcom,cpufreq-hw" or "qcom,cpufreq-epss"
> > +			along with SoC specific compatible:
> > +			  "qcom,sm8350-cpufreq-epss", "qcom,cpufreq-epss"
> 
> Can you please extend this to add all the platforms that we currently
> support?
> 
> PS. Didn't we have someone working on converting this to yaml?

Yep, Mani seems to have done that, I will wait for that to get merged
and update this.. Thanks

-- 
~Vinod
