Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7C956C8CA
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2019 07:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfGRFhw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 01:37:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35412 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727621AbfGRFhw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 01:37:52 -0400
Received: by mail-pf1-f193.google.com with SMTP id u14so12053501pfn.2
        for <linux-pm@vger.kernel.org>; Wed, 17 Jul 2019 22:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cFuA1lpQLfGAEPl1nEFaxlniB911ulQvQm5uHCNrLKw=;
        b=as4v7Ko2dUT43t0bn5kPXJUfGkUB7NpfPcTN7tgnokmlLx/3EdGTCHuJm3sKWpNmS2
         kbBsLklLEan+12lI+V2S5klivUMFkoIZ/tNKIFSYoV1CdA76e56BKRqMVM0xxscnzEa2
         1rHeYh1gA7y9Hn+3maWN4q/wcLSRsTSAXfsfr5vo6FHq/54OBRud8F/jInlN3eQh5FLB
         dZbGpoQDbsTDb+ZiZf6S2dYbdJ0+AeoGnCdVQXbdIMRVv0imbJqP/PwZc17AKH69+Zeo
         ICwewFJnq6v7AqWr23fFwWwoCf0VK8imyXGlcm0s8l00RFXeRe/EvD83iea4mmQbOzoB
         rzfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cFuA1lpQLfGAEPl1nEFaxlniB911ulQvQm5uHCNrLKw=;
        b=nOfc82szNzx+nW9qvScBf56oSmE0nv77U4gqTWcsuQ0tlckeitdvRpfRPKPzs60Q28
         zoaWoAzEnM7licQO6UdtOPz5QBOH3Dl1otpsvzg/24J178X7p4PycRWuJmjoKeRcv797
         tiKydEoGaVuwhGdQZUPMONuXCl/qZ6iGnVUiZO50b/qMPGHRztUcRnpiX/tKT+uE78En
         yboc2QI89tdsXGMhswMZz9VcOCN8aGjRTotZ8L/4v1YQRmDkpCJjxm2BjK8ctBDC7sD9
         r5IthMFz6TWknxNa73phbqKyzpR+Yv7llWzM3qlo7s3Ua2ZBoIqxghOQyiMT8KPP5xLV
         Ix9g==
X-Gm-Message-State: APjAAAX+9rs+wsJUEyWpkIkm6mg6cAy7wJqt5LAV2jxfpId8rW+OfnPC
        FGmwFaWXHuo0y8m46QIfe4EUng==
X-Google-Smtp-Source: APXvYqwdjuF+Axdpruw+kIQpC0dUpNr8vbQzGxEG5BFvLwzw25Cuao2XGx28aKvAMXE1Hnsfh1IJmw==
X-Received: by 2002:a17:90a:1c17:: with SMTP id s23mr49192637pjs.108.1563428270862;
        Wed, 17 Jul 2019 22:37:50 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id y128sm40860470pgy.41.2019.07.17.22.37.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 22:37:49 -0700 (PDT)
Date:   Thu, 18 Jul 2019 11:07:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Sweeney, Sean" <seansw@qti.qualcomm.com>,
        daidavid1@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/6] Introduce Bandwidth OPPs for interconnect paths
Message-ID: <20190718053746.64drmonk72vwnt4s@vireshk-i7>
References: <20190703011020.151615-1-saravanak@google.com>
 <20190717103220.f7cys267hq23fbsb@vireshk-i7>
 <CAGETcx-tbjVzRKW8D-564zgNOhrA_z-NC1q5U70bhoUDBhp6VA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx-tbjVzRKW8D-564zgNOhrA_z-NC1q5U70bhoUDBhp6VA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

I know you have explained lots of things earlier as well, but they are
available over multiple threads and I don't know where to reply now :)

Lets have proper discussion (once again) here and be done with it.
Sorry for the trouble of explaining things again.

On 17-07-19, 13:34, Saravana Kannan wrote:
> On Wed, Jul 17, 2019 at 3:32 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 02-07-19, 18:10, Saravana Kannan wrote:
> > > gpu_cache_opp_table: gpu_cache_opp_table {
> > >       compatible = "operating-points-v2";
> > >
> > >       gpu_cache_3000: opp-3000 {
> > >               opp-peak-KBps = <3000>;
> > >               opp-avg-KBps = <1000>;
> > >       };
> > >       gpu_cache_6000: opp-6000 {
> > >               opp-peak-KBps = <6000>;
> > >               opp-avg-KBps = <2000>;
> > >       };
> > >       gpu_cache_9000: opp-9000 {
> > >               opp-peak-KBps = <9000>;
> > >               opp-avg-KBps = <9000>;
> > >       };
> > > };
> > >
> > > gpu_ddr_opp_table: gpu_ddr_opp_table {
> > >       compatible = "operating-points-v2";
> > >
> > >       gpu_ddr_1525: opp-1525 {
> > >               opp-peak-KBps = <1525>;
> > >               opp-avg-KBps = <452>;
> > >       };
> > >       gpu_ddr_3051: opp-3051 {
> > >               opp-peak-KBps = <3051>;
> > >               opp-avg-KBps = <915>;
> > >       };
> > >       gpu_ddr_7500: opp-7500 {
> > >               opp-peak-KBps = <7500>;
> > >               opp-avg-KBps = <3000>;
> > >       };
> > > };
> >
> > Who is going to use the above tables and how ?
> 
> In this example the GPU driver would use these. It'll go through these
> and then decide what peak and average bw to pick based on whatever
> criteria.

Are you saying that the GPU driver will decide which bandwidth to
choose while running at a particular frequency (say 2 GHz) ? And that
it can choose 1525 or 3051 or 7500 from the ddr path ?

Will it be possible to publicly share how we derive to these decisions
?

The thing is I don't like these separate OPP tables which will not be
used by anyone else, but just GPU (or a single device). I would like
to put this data in the GPU OPP table only. What about putting a
range in the GPU OPP table for the Bandwidth if it can change so much
for the same frequency.

> > These are the maximum
> > BW available over these paths, right ?
> 
> I wouldn't call them "maximum" because there can't be multiple
> maximums :) But yes, these are the meaningful bandwidth from the GPU's
> perspective to use over these paths.
> 
> >
> > > gpu_opp_table: gpu_opp_table {
> > >       compatible = "operating-points-v2";
> > >       opp-shared;
> > >
> > >       opp-200000000 {
> > >               opp-hz = /bits/ 64 <200000000>;
> > >       };
> > >       opp-400000000 {
> > >               opp-hz = /bits/ 64 <400000000>;
> > >       };
> > > };
> >
> > Shouldn't this link back to the above tables via required-opp, etc ?
> > How will we know how much BW is required by the GPU device for all the
> > paths ?
> 
> If that's what the GPU driver wants to do, then yes. But the GPU
> driver could also choose to scale the bandwidth for these paths based
> on multiple other signals. Eg: bus port busy percentage, measure
> bandwidth, etc.

Lets say that the GPU is running at 2 GHz right now and based on above
inputs it wants to increase the bandwidth to 7500 for ddr path, now
does it make sense to run at 4 GHz instead of 2 so we utilize the
bandwidth to the best of our ability and waste less power ?

If something like that is acceptable, then what about keeping the
bandwidth fixed for frequencies and rather scale the frequency of the
GPU on the inputs your provided (like bus port busy percentage, etc).

The current proposal makes me wonder on why should we try to reuse OPP
tables for providing these bandwidth values as the OPP tables for
interconnect paths isn't really a lot of data, only bandwidth all the
time and there is no linking from the device's OPP table as well.

-- 
viresh
