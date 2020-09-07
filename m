Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF8F25F8B5
	for <lists+linux-pm@lfdr.de>; Mon,  7 Sep 2020 12:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbgIGKoZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Sep 2020 06:44:25 -0400
Received: from foss.arm.com ([217.140.110.172]:60618 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728406AbgIGKoX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 7 Sep 2020 06:44:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12B48106F;
        Mon,  7 Sep 2020 03:44:23 -0700 (PDT)
Received: from bogus (unknown [10.57.10.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 471233F66E;
        Mon,  7 Sep 2020 03:44:20 -0700 (PDT)
Date:   Mon, 7 Sep 2020 11:44:18 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/3] cpufreq: arm_scmi: Constify scmi_perf_ops pointers
Message-ID: <20200907104418.GC17330@bogus>
References: <20200906230452.33410-1-rikard.falkeborn@gmail.com>
 <20200906230452.33410-2-rikard.falkeborn@gmail.com>
 <20200907102200.GB17330@bogus>
 <20200907102551.3f7zwrmd3uqthaxs@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907102551.3f7zwrmd3uqthaxs@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 07, 2020 at 03:55:51PM +0530, Viresh Kumar wrote:
> On 07-09-20, 11:22, Sudeep Holla wrote:
> > Hi Viresh,
> >
> > On Mon, Sep 07, 2020 at 01:04:50AM +0200, Rikard Falkeborn wrote:
> > > The perf_ops are not modified through this pointer. Make them const to
> > > indicate that. This is in preparation to make the scmi-ops pointers in
> > > scmi_handle const.
> > >
> >
> > Your ack needed to take this as series via {arm-,}soc
>
> Can I just pick the first patch and you do the rest ? Will it result
> in any warnings at either end ?
>

Initially I thought out suggesting the same, but then I realised(not
checked though), without this change in arm-soc the scmi-cpufreq driver
might produce warnings as the const value gets assigned to non const.
No ?

--
Regards,
Sudeep
