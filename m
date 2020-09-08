Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EACB9261C06
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 21:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731207AbgIHTNc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 15:13:32 -0400
Received: from foss.arm.com ([217.140.110.172]:56774 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731161AbgIHQFH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Sep 2020 12:05:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CA921682;
        Tue,  8 Sep 2020 07:09:03 -0700 (PDT)
Received: from bogus (unknown [10.57.10.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4059F3F73C;
        Tue,  8 Sep 2020 07:09:01 -0700 (PDT)
Date:   Tue, 8 Sep 2020 15:08:51 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Amit Kucheria <amitk@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH 5/7] cpufreq: qcom-hw: Use regmap for accessing hardware
 registers
Message-ID: <20200908140842.GA17621@bogus>
References: <20200908075716.30357-1-manivannan.sadhasivam@linaro.org>
 <20200908075716.30357-6-manivannan.sadhasivam@linaro.org>
 <20200908103444.5e526uawa45om6lt@vireshk-i7>
 <20200908111141.GB23095@mani>
 <20200908111813.bbgfxo5v7qt6ujpc@vireshk-i7>
 <CAHLCerMndYeEBOxtj8mV7OdOP9pufx+C7n1F9m+CFAneuh8DnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHLCerMndYeEBOxtj8mV7OdOP9pufx+C7n1F9m+CFAneuh8DnA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 08, 2020 at 05:18:35PM +0530, Amit Kucheria wrote:
> On Tue, Sep 8, 2020 at 4:48 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 08-09-20, 16:41, Manivannan Sadhasivam wrote:
> > > On 0908, Viresh Kumar wrote:
> > > > On 08-09-20, 13:27, Manivannan Sadhasivam wrote:
> > > > > Use regmap for accessing cpufreq registers in hardware.
> > > >
> > > > Why ? Please mention why a change is required in the log.
> > > >
> > >
> > > Only because it is recommended to use regmap for abstracting the hw access.
> >
> > Yes it can be very useful in abstracting the hw access in case of
> > busses like SPI/I2C, others, but in this case there is only one way of
> > doing it with the exact same registers. I am not sure it is worth it
> > here. FWIW, I have never played with regmaps personally, and so every
> > chance I can be wrong here.
> 
> One could handle the reg offsets through a struct initialisation, but
> then you end up with lots of #defines for bitmasks and bits for each
> version of the IP. And the core code becomes a bit convoluted IMO,
> trying to handle the differences.
> 
> regmap hides the differences of the bit positions and register offsets
> between several IP versions.
> 
> > > Moreover it handles the proper locking for us in the core (spinlock vs mutex).
> >
> > What locking do you need here ?
> 
> Right, locking isn't the main reason here.

If that is the case, IMO it is better to set disable_lock or something
in config especially as this regmap_write is used in qcom_cpufreq_hw_fast_switch

-- 
Regards,
Sudeep
