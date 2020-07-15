Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F36F22071F
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 10:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgGOI1o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 04:27:44 -0400
Received: from mga07.intel.com ([134.134.136.100]:41250 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbgGOI1n (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Jul 2020 04:27:43 -0400
IronPort-SDR: ESfhtG135gxq2CEs2vGLLJRd7PVjIWaMsyWKJ5c8ucru3O93/oEhG4XD1DkTaZpWB7dBZoSYZh
 3MhsQr8M5VHg==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="213876760"
X-IronPort-AV: E=Sophos;i="5.75,354,1589266800"; 
   d="scan'208";a="213876760"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 01:27:37 -0700
IronPort-SDR: R2YkGjF0/a7Jh7EPsjLE55eWyoNz3iAYV26+kZVW+YaC8o8eWQDXB2vr9kw9bdtnyGyVvMFErL
 iPHarFRLMHLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,354,1589266800"; 
   d="scan'208";a="299812940"
Received: from yren3-mobl.ccr.corp.intel.com ([10.249.174.224])
  by orsmga002.jf.intel.com with ESMTP; 15 Jul 2020 01:27:35 -0700
Message-ID: <e078f9ebd3e8e440d5c04d2abac31201f5d3443d.camel@intel.com>
Subject: Re: [RFC PATCH 0/4] thermal: Introduce support for monitoring
 falling temperature
From:   Zhang Rui <rui.zhang@intel.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 15 Jul 2020 16:27:34 +0800
In-Reply-To: <5861acec-c49a-47cc-d7c6-ccef11dc1d58@linaro.org>
References: <20200710135154.181454-1-thara.gopinath@linaro.org>
         <7437ee89-e76d-0c82-9860-5c6076ad8a30@linaro.org>
         <b25d54d35cec777f0dcc5b2bcacce27321d9bd45.camel@intel.com>
         <5861acec-c49a-47cc-d7c6-ccef11dc1d58@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi, Thara,

On Tue, 2020-07-14 at 17:39 -0400, Thara Gopinath wrote:
> 
> > 
> > For example, to support this, we can
> > either
> > introduce both "cold" trip points and "warming devices", and
> > introduce
> > new logic in thermal framework and governors to handle them,
> > Or
> > introduce "cold" trip point and "warming" device, but only
> > semantically, and treat them just like normal trip points and
> > cooling
> > devices. And strictly define cooling state 0 as the state that
> > generates most heat, and define max cooling state as the state that
> > generates least heat. Then, say, we have a trip point at -10C, the
> > "warming" device is set to cooling state 0 when the temperature is
> > lower than -10C, and in most cases, this thermal zone is always in
> > a
> > "overheating" state (temperature higher than -10C), and the
> > "warming"
> > device for this thermal zone is "throttled" to generate as least
> > heat
> > as possible. And this is pretty much what the current code has
> > always
> > been doing, right?
> 
> 
> IMHO, thermal framework should move to a direction where the term 
> "mitigation" is used rather than cooling or warming. In this case 
> "cooling dev" and "warming dev" should will become 
> "temp-mitigating-dev". So going by this, I think what you mention as 
> option 1 is more suitable where new logic is introduced into the 
> framework and governors to handle the trip points marked as "cold".
> 
> Also in the current set of requirements, we have a few power domain 
> rails and other resources that are used exclusively in the thermal 
> framework for warming alone as in they are not used ever for cooling 
> down a zone. But then one of the requirements we have discussed is
> for cpufreq and gpu scaling to be behave as warming devices where
> the minimum operating point/ voltage of the relevant cpu/gpu is
> restricted.
> So in this case, Daniel had this suggestion of introducing negative 
> states for presently what is defined as cooling devices. So cooling
> dev 
> / temp-mitigation-dev states can range from say -3 to 5 with 0 as
> the 
> good state where no mitigation is happening. This is an interesting
> idea 
> though I have not proto-typed it yet.

Agreed. If some devices support both "cooling" and "warning", we should
have only one "temp-mitigating-dev" instead.
> 
> > 
> > I can not say which one is better for now as I don't have the
> > background of this requirement. It's nice that Thara sent this RFC
> > series for discussion, but from upstream point of view, I'd prefer
> > to
> > see a full stack solution, before taking any code.
> 
> We had done a session at ELC on this requirement. Here is the link
> to 
> the presentation. Hopefully it gives you some back ground on this.

yes, it helps. :)
> 
> 
https://elinux.org/images/f/f7/ELC-2020-Thara-Ram-Linux-Kernel-Thermal-Warming.pdf
> 
> I have sent across some patches for introducing a generic power
> domain 
> warming device which is under review by Daniel.
> 
> So how do you want to proceed on this? Can you elaborate a bit more
> on 
> what you mean by a full stack solution.

I mean, the patches, and the idea look good to me, just with some minor
comments. But applying this patch series, alone, does not bring us
anything because we don't have a thermal zone driver that supports cold
trip point, right?
I'd like to see this patch series together with the support in
thermal_core/governors and real users like updated/new thermal
zone/cdev drivers that supports the cold trip point and warming
actions.
Or else I've the concern that this piece of code may be changed back
and forth when prototyping the rest of the support.

thanks,
rui

