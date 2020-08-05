Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A986F23CD12
	for <lists+linux-pm@lfdr.de>; Wed,  5 Aug 2020 19:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgHERTf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Aug 2020 13:19:35 -0400
Received: from foss.arm.com ([217.140.110.172]:33668 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728653AbgHERSG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Aug 2020 13:18:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F37F230E;
        Wed,  5 Aug 2020 05:36:48 -0700 (PDT)
Received: from bogus (unknown [10.37.12.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E18173FA1C;
        Wed,  5 Aug 2020 05:36:46 -0700 (PDT)
Date:   Wed, 5 Aug 2020 13:36:43 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, cristian.marussi@arm.com,
        Sudeep Holla <sudeep.holla@arm.com>, rjw@rjwysocki.net
Subject: Re: [PATCH 0/4] CPUFreq statistics retrieved by drivers
Message-ID: <20200805123643.GB4818@bogus>
References: <20200729151208.27737-1-lukasz.luba@arm.com>
 <20200730085333.qubrsv7ufqninihd@vireshk-mac-ubuntu>
 <20200730091014.GA13158@bogus>
 <3b3a56e9-29ec-958f-fb3b-c689a9389d2f@arm.com>
 <20200731155650.GC14529@bogus>
 <ae352c39-f7c4-c69e-0113-7c810c130ee0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae352c39-f7c4-c69e-0113-7c810c130ee0@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 04, 2020 at 10:19:23AM -0700, Florian Fainelli wrote:
>
>
> On 7/31/2020 8:56 AM, Sudeep Holla wrote:
> > On Thu, Jul 30, 2020 at 10:36:51AM +0100, Lukasz Luba wrote:
> >>
> >> In this case I think we would have to create debugfs.
> >> Sudeep do you think these debugfs should be exposed from the protocol
> >> layer:
> >> drivers/firmware/arm_scmi/perf.c
> >
> > I prefer above over cpufreq as we can support for all the devices not
> > just cpus which avoids adding similar support elsewhere(mostly devfreq)
> >
> >> or maybe from the cpufreq scmi driver? I would probably be safer to have
> >> it in the cpufreq driver because we have scmi_handle there.
> >>
> >
> > Cristian was thinking if we can consolidate all such debugfs under one
> > device may be and that should eliminate your handle restriction. I would
> > like to see how that works out in implementation but I don't have any
> > better suggestion ATM.
>
> debugfs is not enabled in production kernels, and especially not with
> Android kernels, so sticking those in sysfs like the existing cpufreq
> subsystem statistics may be a better choice.

Fair enough. I was suggesting that only if we can't push this into existing
sysfs support. If we can, then we need not worry about it. If not, I don't
want a user ABI just for SCMI for this firmware stats, I would rather keep
it in debugfs for debug purposes. This will be useless once we start seeing
AMU in the hardware and hence I was pushing for debugfs.

--
Regards,
Sudeep
