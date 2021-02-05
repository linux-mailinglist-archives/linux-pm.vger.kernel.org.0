Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0798631115E
	for <lists+linux-pm@lfdr.de>; Fri,  5 Feb 2021 20:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbhBER55 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Feb 2021 12:57:57 -0500
Received: from mga11.intel.com ([192.55.52.93]:3071 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233238AbhBEP1Q (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Feb 2021 10:27:16 -0500
IronPort-SDR: DBWi9nnisSoA8Cdvker+OvShWDgaPtMv0Jwpi8AQhzj/Ly7SSvlMl+ZAOuOsdgSEWN4CXgQMPU
 Ep1HDkmi/vRQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="177955330"
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="177955330"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 09:07:37 -0800
IronPort-SDR: mGPnbtVPmJJg3NoDEko5zdYAU1Mj7/ClAx+9ByIq3ztejbmWSU/Op+By5NXQ/Xnnb32UcH1EmV
 HSs71W5HB+0g==
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="393939598"
Received: from mjwilkin-mobl.amr.corp.intel.com ([10.212.80.131])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 09:07:36 -0800
Message-ID: <0f63aaa63cb4217f772aa702fac5c44a3ac110b6.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] powercap/intel_rapl: Use topology interface in
 rapl_add_package()
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        "Zhang, Rui" <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        hushiyuan@huawei.com, hewenliang4@huawei.com, caihongda@huawei.com
Date:   Fri, 05 Feb 2021 09:07:28 -0800
In-Reply-To: <CAJZ5v0hNryYqKfTZfRjN+KJVgw973G+vi9SrT4mGTPz_TTT2ng@mail.gmail.com>
References: <20210123100608.2349629-1-yeyunfeng@huawei.com>
         <CAJZ5v0hNryYqKfTZfRjN+KJVgw973G+vi9SrT4mGTPz_TTT2ng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2021-02-05 at 13:45 +0100, Rafael J. Wysocki wrote:
> On Sat, Jan 23, 2021 at 11:07 AM Yunfeng Ye <yeyunfeng@huawei.com>
> wrote:
> > It's not a good way to access phys_proc_id and cpu_die_id directly.
> > So using topology_physical_package_id(cpu) and topology_die_id(cpu)
> > instead.
> > 
> > Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> 
> Srinivas, Rui, any concerns?
Looks good.

Thanks,
Srinivas

> 
> > ---
> >  drivers/powercap/intel_rapl_common.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/powercap/intel_rapl_common.c
> > b/drivers/powercap/intel_rapl_common.c
> > index c9e57237d778..5f3d39b8212a 100644
> > --- a/drivers/powercap/intel_rapl_common.c
> > +++ b/drivers/powercap/intel_rapl_common.c
> > @@ -1309,7 +1309,6 @@ struct rapl_package *rapl_add_package(int
> > cpu, struct rapl_if_priv *priv)
> >  {
> >         int id = topology_logical_die_id(cpu);
> >         struct rapl_package *rp;
> > -       struct cpuinfo_x86 *c = &cpu_data(cpu);
> >         int ret;
> > 
> >         if (!rapl_defaults)
> > @@ -1326,10 +1325,11 @@ struct rapl_package *rapl_add_package(int
> > cpu, struct rapl_if_priv *priv)
> > 
> >         if (topology_max_die_per_package() > 1)
> >                 snprintf(rp->name, PACKAGE_DOMAIN_NAME_LENGTH,
> > -                        "package-%d-die-%d", c->phys_proc_id, c-
> > >cpu_die_id);
> > +                        "package-%d-die-%d",
> > +                        topology_physical_package_id(cpu),
> > topology_die_id(cpu));
> >         else
> >                 snprintf(rp->name, PACKAGE_DOMAIN_NAME_LENGTH,
> > "package-%d",
> > -                        c->phys_proc_id);
> > +                        topology_physical_package_id(cpu));
> > 
> >         /* check if the package contains valid domains */
> >         if (rapl_detect_domains(rp, cpu) || rapl_defaults-
> > >check_unit(rp, cpu)) {
> > --
> > 2.27.0
> > 

