Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F16E299EC
	for <lists+linux-pm@lfdr.de>; Fri, 24 May 2019 16:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403984AbfEXOT1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 May 2019 10:19:27 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43968 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403917AbfEXOT1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 May 2019 10:19:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B02EA78;
        Fri, 24 May 2019 07:19:27 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CB713F575;
        Fri, 24 May 2019 07:19:24 -0700 (PDT)
Date:   Fri, 24 May 2019 15:19:19 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, james.quinlan@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CPU FREQUENCY SCALING FRAMEWORK" 
        <linux-pm@vger.kernel.org>,
        "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH RFC] firmware: arm_scmi: Allow for better protocol
 extensibility
Message-ID: <20190524141918.GA4408@e107155-lin>
References: <20190521200110.8309-1-f.fainelli@gmail.com>
 <f9403e7e-1b87-dc46-dfc5-62227c659e7c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9403e7e-1b87-dc46-dfc5-62227c659e7c@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 23, 2019 at 10:17:50AM -0700, Florian Fainelli wrote:
> On 5/21/19 1:01 PM, Florian Fainelli wrote:
> > The SCMI specific allows implementors to define their custom protocols
> > in the 0x80-0xFF space. The current scmi_handle structure requires us to
> > extend the structure with a set of operations and associated private
> > data in a way that is not quite scaling well.
> > 
> > Create a 255 bytes structure that contains an opaque pointer to a set of
> > operations and private data and create two helper functions to retrieve
> > those based on the protocol identifier. Several options were considered,
> > like using a linked list but since we could be performance sensitive in
> > some paths, using an array was faster and simpler.
> > 
> > Convert all call sites to use either scmi_protocol_get_ops() or
> > scmi_protocol_get_info().
> > 
> > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> On second thought, what I really need is private storage to the scmi_dev
> (the consumer side), and not so much the protocol (provider) side.
> Therefore using dev_{set,get}_drvadata() against scmi_device::dev should
> be working just fine, and if we are concerned about another part of the
> SCMI stack making use of that storage, we can always extend struct
> scmi_device with a private cookie.

Sorry, I haven't looked into the original patch in detail yet. But I
always have rejected to add support for just infrastructure to add
vendor specific protocols both internally @ARM and to some private
emails I have received. I prefer to merge it with the first reference
vendor specific protocol so that the users of this infrastructure gets
a fair idea on how to use the same.

I will look at the RFC next week.

--
Regards,
Sudeep
