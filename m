Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC5C314D049
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2020 19:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbgA2SSU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jan 2020 13:18:20 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41667 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbgA2SSU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jan 2020 13:18:20 -0500
Received: by mail-pg1-f193.google.com with SMTP id x8so192120pgk.8
        for <linux-pm@vger.kernel.org>; Wed, 29 Jan 2020 10:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f7H8V33x8TSaOVVVtMrepShUU/hwcU6izxAXRT/mzfw=;
        b=Vqr407+sv8WoZA1hzU5mx0uQKQWeEp/YlSdH1oWaQDmhjqHhxJIIfJOA/76vIGcYsU
         v9lMc8lNDWj3kScIP4wQyHM8vvhSsGhdGhsnCqwRmBC2eRPg9JWFto0TAy1RHnGlaNMr
         X2FaZkAIJyYtpCubCxug3D9XiHEOQr9QUg4To=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f7H8V33x8TSaOVVVtMrepShUU/hwcU6izxAXRT/mzfw=;
        b=l6QE+hH75b4lSTTrv82GX/ZUOI5NUjVYHwYSAPxp6Xhk7+041aRFirwbHD5j9SXkci
         ybkBB1mra9HGSR/wHpG0m7S33Jr40zbjhc6efdmJaWJMdBcRlGxE5OL9oavE3IA9E46+
         jnHUqr3lPFz5N3v3abwfA6XxOmPG+AwKULSdUMwNotdi05MTotK+LiYlN/qP3KI4OYUm
         2+SkJYoTCwKP58F1hOoJOT/nW6BNzIFp7GTXA4NE12KMydPvWygpQuoZjnzaHPV+vFVs
         XJ1GecjbrRSsm/MbD9adY1/8bmqkyKlBnIW/BQroqaloq3k85y5aK+METE5kRHIBWSC6
         sUgQ==
X-Gm-Message-State: APjAAAXUE9NZlIFS836Wb64Vs6B63bq1xsfkig2am2A01oEcD53QQYXq
        j8QUTbqkM0ay6OZVv9iWohTuQw==
X-Google-Smtp-Source: APXvYqx20g2qD4qMi2aZtS1b5wov2GagAFH0c6dk7k38lCVp0fm4wKaqKecYBrirjd8drUcktw0P5A==
X-Received: by 2002:a65:66c8:: with SMTP id c8mr335019pgw.161.1580321899818;
        Wed, 29 Jan 2020 10:18:19 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id m71sm6735468pje.0.2020.01.29.10.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 10:18:19 -0800 (PST)
Date:   Wed, 29 Jan 2020 10:18:17 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, saravanak@google.com, nm@ti.com,
        bjorn.andersson@linaro.org, agross@kernel.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        vincent.guittot@linaro.org, amit.kucheria@linaro.org,
        ulf.hansson@linaro.org
Subject: Re: [RFC v3 09/10] arm64: dts: qcom: sdm845: Add cpu OPP tables
Message-ID: <20200129181817.GA71044@google.com>
References: <20200127200350.24465-1-sibis@codeaurora.org>
 <20200127200350.24465-10-sibis@codeaurora.org>
 <20200129012411.GI46072@google.com>
 <4f2b98a1dae3bc737a43a1e46255657b@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4f2b98a1dae3bc737a43a1e46255657b@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sibi,

On Wed, Jan 29, 2020 at 07:35:21PM +0530, Sibi Sankar wrote:
> Hey Matthias,
> 
> Thanks for the review!
> 
> On 2020-01-29 06:54, Matthias Kaehlcke wrote:
> > Hi Sibi,
> > 
> > On Tue, Jan 28, 2020 at 01:33:49AM +0530, Sibi Sankar wrote:
> > > Add OPP tables required to scale DDR/L3 per freq-domain on SDM845
> > > SoCs.
> > > 
> > > Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 453
> > > +++++++++++++++++++++++++++
> > >  1 file changed, 453 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > index c036bab49fc03..8cb976118407b 100644
> > > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > @@ -199,6 +199,12 @@
> > >  			qcom,freq-domain = <&cpufreq_hw 0>;
> > >  			#cooling-cells = <2>;
> > >  			next-level-cache = <&L2_0>;
> > > +			operating-points-v2 = <&cpu0_opp_table>,
> > > +					      <&cpu0_ddr_bw_opp_table>,
> > > +					      <&cpu0_l3_bw_opp_table>;
> > > +			interconnects = <&gladiator_noc MASTER_APPSS_PROC &mem_noc
> > > SLAVE_EBI1>,
> > > +					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
> > 
> > This apparently depends on the 'Split SDM845 interconnect nodes and
> > consolidate RPMh support' series
> > (https://patchwork.kernel.org/project/linux-arm-msm/list/?series=226281),
> > which isn't mentioned in the cover letter.
> > 
> > I also couldn't find a patch on the lists that adds the 'osm_l3'
> > interconnect node for SDM845. The same is true for SC7180 (next
> > patch of this series). These patches may be available in custom trees,
> > but that isn't really helpful for upstream review.
> 
> yeah I missed adding the interconnect
> refactor dependency and the nodes.
> 
> > 
> > I would suggest to focus on landing the dependencies of this series,
> > before proceding with it (or at least most of them), there are plenty
> > and without the dependencies this series isn't going to land, it also
> > makes it hard for testers and reviewers to get all the pieces
> 
> yes I understand but wanted the series
> out asap because since there are a few
> points where we still havn't reached
> a consensus on.

Ok, I just wanted to make sure we are not burning the limited
maintainer/reviewer bandwidth on code with hard dependencies on
things that aren't moving forward.

> > together. In particular the last post of the series 'Add
> > required-opps support to devfreq passive gov'
> > (https://patchwork.kernel.org/cover/11055499/) is from July 2019 ...
> 
> https://lore.kernel.org/lkml/CAGTfZH37ALwUHd8SpRRrBzZ6x1-++YtzS60_yRQvN-TN6rOzaA@mail.gmail.com/
> 
> The pending patch for lazy linking
> was posted a while back. Now that
> it has a tested-by, majority of the
> series should go in since the devfreq
> maintainers wanted the series pulled
> in.

Thanks for the clarification. For reference the post is
https://patchwork.kernel.org/patch/11048277/#23020727

It sems the series will require at least another re-spin:

  "So once that's (lazy linking) added, I should be able to drop a few
  patches in this series, do some minor updates and then this will be
  good to go."

  https://patchwork.kernel.org/cover/11055499/#23001445

So it looks like we are waiting for the lazy linking patch to
land in the PM/Linus' tree and then a re-spin of the 'Add
required-opps support to devfreq passive gov' series.
