Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D78E23A8A4
	for <lists+linux-pm@lfdr.de>; Mon,  3 Aug 2020 16:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgHCOjr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Aug 2020 10:39:47 -0400
Received: from foss.arm.com ([217.140.110.172]:58496 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbgHCOjq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 3 Aug 2020 10:39:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EF2B30E;
        Mon,  3 Aug 2020 07:39:46 -0700 (PDT)
Received: from localhost (unknown [10.1.198.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D37E63F718;
        Mon,  3 Aug 2020 07:39:45 -0700 (PDT)
Date:   Mon, 3 Aug 2020 15:39:44 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>, rjw@rjwysocki.net,
        catalin.marinas@arm.com, will@kernel.org, linux@armlinux.org.uk,
        mingo@redhat.com, peterz@infradead.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] arch_topology: disable frequency invariance for
 CONFIG_BL_SWITCHER
Message-ID: <20200803143944.GA20312@arm.com>
References: <20200722093732.14297-1-ionela.voinescu@arm.com>
 <20200722093732.14297-4-ionela.voinescu@arm.com>
 <20200730042423.4j22udejluis7blw@vireshk-mac-ubuntu>
 <1db4317a-0018-1590-f0ae-ed5e235b174f@arm.com>
 <20200731154838.GB14529@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731154838.GB14529@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi guys,

On Friday 31 Jul 2020 at 16:48:38 (+0100), Sudeep Holla wrote:
> On Thu, Jul 30, 2020 at 12:29:52PM +0200, Dietmar Eggemann wrote:
> 
> [...]
> 
> >
> > Are there still any users of CONFIG_BL_SWITCHER? I guess it's only
> > limited to A15/A7 systems w/ vexpress-spc-cpufreq.c ... so probably only
> > TC2?
> 
> I think so as no one shouted when I merged bL switcher driver into
> vexpress-spc-cpufreq.c
> 

I think a good indication is also the fact that frequency invariance was
broken for a long time for bL_switcher_enabled systems and nobody
shouted.

A way to make this nicer is to fully remove BL_SWITCHER support. This
support was valuable at its time, but given that now there is proper
asymmetric CPU capacity support, is there any reason to hold on to this?

Thanks,
Ionela.

> -- 
> Regards,
> Sudeep
