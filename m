Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492D03A9513
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 10:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbhFPIdT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 04:33:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:39356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232206AbhFPIdR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 16 Jun 2021 04:33:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B0B06101A;
        Wed, 16 Jun 2021 08:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623832269;
        bh=UY51MrQ+7PPY4RnoKcsQcpGXMInc7A+QcmPfyyAzw3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SbDXOT7GkL04NdZGvjRJw/+CD4tZ6qelZ0jlhyFNXW3dJA6DJ5UZ3Sj0PH+juMdzf
         dh5WrJ/5yAxtlgHq6kW+QuDxuGExgqdvbBrFs9xpImyLUc/4fRCx1+ggTO66DVjttQ
         isLE+ofTmEq243pk2L8fwhWjbd5JIMlYWk/mbVws=
Date:   Wed, 16 Jun 2021 10:31:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/3] arch_topology: Avoid use-after-free for
 scale_freq_data
Message-ID: <YMm2y6vvLpsIkXPT@kroah.com>
References: <cover.1623825725.git.viresh.kumar@linaro.org>
 <9dba462b4d09a1a8a9fbb75740b74bf91a09a3e1.1623825725.git.viresh.kumar@linaro.org>
 <YMmu3bS3Q6avUfEW@kroah.com>
 <20210616081859.idzpwzdyeu666xpz@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616081859.idzpwzdyeu666xpz@vireshk-i7>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 16, 2021 at 01:48:59PM +0530, Viresh Kumar wrote:
> On 16-06-21, 09:57, Greg Kroah-Hartman wrote:
> > On Wed, Jun 16, 2021 at 12:18:08PM +0530, Viresh Kumar wrote:
> > > Currently topology_scale_freq_tick() may end up using a pointer to
> > > struct scale_freq_data, which was previously cleared by
> > > topology_clear_scale_freq_source(), as there is no protection in place
> > > here. The users of topology_clear_scale_freq_source() though needs a
> > > guarantee that the previous scale_freq_data isn't used anymore.
> > > 
> > > Since topology_scale_freq_tick() is called from scheduler tick, we don't
> > > want to add locking in there. Use the RCU update mechanism instead
> > > (which is already used by the scheduler's utilization update path) to
> > > guarantee race free updates here.
> > > 
> > > Cc: Paul E. McKenney <paulmck@kernel.org>
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > 
> > So this is a bugfix for problems in the current codebase?  What commit
> > does this fix?  Should it go to the stable kernels?
> 
> There is only one user of topology_clear_scale_freq_source()
> (cppc-cpufreq driver, which is already reverted in pm/linux-next). So
> in the upcoming 5.13 kernel release, there will be no one using this
> API and so no one will break.
> 
> And so I skipped the fixes tag, I can add it though.

It would be nice to have to answer this type of question, otherwise you
will have automated scripts trying to backport this to kernels where it
does not belong :)

thanks,

greg k-h
