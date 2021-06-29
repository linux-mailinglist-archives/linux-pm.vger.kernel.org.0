Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A263B6FD4
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jun 2021 11:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbhF2JFx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Jun 2021 05:05:53 -0400
Received: from foss.arm.com ([217.140.110.172]:46676 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232518AbhF2JFw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 29 Jun 2021 05:05:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B5ECD6E;
        Tue, 29 Jun 2021 02:03:25 -0700 (PDT)
Received: from bogus (unknown [10.57.78.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5932F3F694;
        Tue, 29 Jun 2021 02:03:23 -0700 (PDT)
Date:   Tue, 29 Jun 2021 10:02:38 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Hector Yuan <hector.yuan@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH v12 1/2] cpufreq: mediatek-hw: Add support for CPUFREQ HW
Message-ID: <20210629090238.n23zcttkiqvzpbb5@bogus>
References: <1622307153-3639-1-git-send-email-hector.yuan@mediatek.com>
 <1622307153-3639-2-git-send-email-hector.yuan@mediatek.com>
 <20210614104058.jdwb7godqzhf7rgd@vireshk-i7>
 <1624781848.1958.16.camel@mtkswgap22>
 <20210628072641.amqk5d3svwolvhic@vireshk-i7>
 <20210628090956.uwkrozdqvawsm3xp@bogus>
 <20210629024719.nmcygaigtx5wn7g5@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629024719.nmcygaigtx5wn7g5@vireshk-i7>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 29, 2021 at 08:17:19AM +0530, Viresh Kumar wrote:
> On 28-06-21, 10:09, Sudeep Holla wrote:
> > Probably in driver/cpufreq or some related headers if it needs to access
> > related_cpus and is more cpufreq related in that way ?
>
> It just needs to set a mask, so doesn't really depend on cpufreq. I
> was wondering if drivers/opp/of.c may be used for this, and I am not
> sure.
>

Sounds good to me.

--
Regards,
Sudeep
