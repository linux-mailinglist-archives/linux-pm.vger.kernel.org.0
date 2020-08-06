Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA93723DFF0
	for <lists+linux-pm@lfdr.de>; Thu,  6 Aug 2020 19:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgHFRzl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Aug 2020 13:55:41 -0400
Received: from foss.arm.com ([217.140.110.172]:45010 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728118AbgHFQ2v (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 6 Aug 2020 12:28:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE883113E;
        Thu,  6 Aug 2020 06:37:41 -0700 (PDT)
Received: from bogus (unknown [10.37.12.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A6EA3F7D7;
        Thu,  6 Aug 2020 06:37:39 -0700 (PDT)
Date:   Thu, 6 Aug 2020 14:37:31 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, cristian.marussi@arm.com,
        rjw@rjwysocki.net, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 0/4] CPUFreq statistics retrieved by drivers
Message-ID: <20200806133731.GA4104@bogus>
References: <20200729151208.27737-1-lukasz.luba@arm.com>
 <a3354ae8-f40f-83f2-d6eb-7f588af75e97@gmail.com>
 <119ce268-18dc-7a4c-b0b2-3a66ff9ff4b0@arm.com>
 <20200805130436.3d2g7z2rsdoesuuk@vireshk-mac-ubuntu>
 <20200805160312.GC4818@bogus>
 <4962aa3c-2b56-5232-c5d7-286ca1363446@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4962aa3c-2b56-5232-c5d7-286ca1363446@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 05, 2020 at 10:33:02AM -0700, Florian Fainelli wrote:
>
>
> On 8/5/2020 9:03 AM, Sudeep Holla wrote:
> > On Wed, Aug 05, 2020 at 06:34:36PM +0530, Viresh Kumar wrote:
> >> On 05-08-20, 12:04, Lukasz Luba wrote:
> >>> I know that Viresh is going to develop patches and improve these
> >>> cpufreq stats framework. Maybe he also had this 'aggregation' in mind.
> >>> I will leave it him.
> >>
> >> I am only going to look at cpufreq's view of stats independently from
> >> the firmware.
> >>
> >
> > +1, I agree with that. Kernel must avoid any logic to aggregate or
> > interpret the data in a generic way. The userspace tools can manage that
> > especially if this tend to be platform specific.
>
> We can probably standardize on how to expose the firmware maintained
> statistics such that these tools do not have to widely vary from
> platform to platform, right?

Ofcourse. I just don't want any logic that interpret/analyse the stats
comparing with the in-kernel stats or otherwise.

--
Regards,
Sudeep
