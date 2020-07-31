Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E221B2348A6
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jul 2020 17:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387468AbgGaPsp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Jul 2020 11:48:45 -0400
Received: from foss.arm.com ([217.140.110.172]:34682 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbgGaPsp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 31 Jul 2020 11:48:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DA061FB;
        Fri, 31 Jul 2020 08:48:45 -0700 (PDT)
Received: from bogus (unknown [10.37.12.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 51FEE3F66E;
        Fri, 31 Jul 2020 08:48:42 -0700 (PDT)
Date:   Fri, 31 Jul 2020 16:48:38 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>, rjw@rjwysocki.net,
        catalin.marinas@arm.com, will@kernel.org, linux@armlinux.org.uk,
        mingo@redhat.com, peterz@infradead.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] arch_topology: disable frequency invariance for
 CONFIG_BL_SWITCHER
Message-ID: <20200731154838.GB14529@bogus>
References: <20200722093732.14297-1-ionela.voinescu@arm.com>
 <20200722093732.14297-4-ionela.voinescu@arm.com>
 <20200730042423.4j22udejluis7blw@vireshk-mac-ubuntu>
 <1db4317a-0018-1590-f0ae-ed5e235b174f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1db4317a-0018-1590-f0ae-ed5e235b174f@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 30, 2020 at 12:29:52PM +0200, Dietmar Eggemann wrote:

[...]

>
> Are there still any users of CONFIG_BL_SWITCHER? I guess it's only
> limited to A15/A7 systems w/ vexpress-spc-cpufreq.c ... so probably only
> TC2?

I think so as no one shouted when I merged bL switcher driver into
vexpress-spc-cpufreq.c

-- 
Regards,
Sudeep
