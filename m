Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66352311159
	for <lists+linux-pm@lfdr.de>; Fri,  5 Feb 2021 20:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbhBER4L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Feb 2021 12:56:11 -0500
Received: from mga05.intel.com ([192.55.52.43]:31350 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229866AbhBEP1c (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Feb 2021 10:27:32 -0500
IronPort-SDR: q5GHhLrWQSYKcsaufTqixzTrY8sshMfaXLy4AJKeojhVHzM2Uj4jsR1xJnzY8v5n2AVY37KSMO
 Jpy2/ct0YhAQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="266289190"
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="266289190"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 09:07:58 -0800
IronPort-SDR: Evp/LZjirJESAh4bToG6XDcjTyJiAbjSo6oAMspH01d1s37pZtHEmgs+9pe1bPns072osBdVvv
 t+xDubBHmA8g==
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="416264267"
Received: from mjwilkin-mobl.amr.corp.intel.com ([10.212.80.131])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 09:07:57 -0800
Message-ID: <8c46da48f82963da2cfb08b1f488de8a6d2b0608.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] powercap/intel_rapl: Use topology interface in
 rapl_init_domains()
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        "Zhang, Rui" <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        hushiyuan@huawei.com, hewenliang4@huawei.com, caihongda@huawei.com
Date:   Fri, 05 Feb 2021 09:07:56 -0800
In-Reply-To: <CAJZ5v0jOwfau2dPVnrAjv01dOGY+8i8o-2gr72fNa0Fug1CV=w@mail.gmail.com>
References: <20210123100608.2349629-1-yeyunfeng@huawei.com>
         <20210123100608.2349629-2-yeyunfeng@huawei.com>
         <CAJZ5v0jOwfau2dPVnrAjv01dOGY+8i8o-2gr72fNa0Fug1CV=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2021-02-05 at 13:46 +0100, Rafael J. Wysocki wrote:
> On Sat, Jan 23, 2021 at 11:07 AM Yunfeng Ye <yeyunfeng@huawei.com>
> wrote:
> > It's not a good way to access the phys_proc_id of cpuinfo directly.
> > So using topology_physical_package_id(cpu) instead.
> > 
> > Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> 
> Srinivas, Rui, any concerns?
Looks good.

Thanks,
Srinivas

> 
> > ---
> >  drivers/powercap/intel_rapl_common.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/powercap/intel_rapl_common.c
> > b/drivers/powercap/intel_rapl_common.c
> > index 5f3d39b8212a..8888adcb3927 100644
> > --- a/drivers/powercap/intel_rapl_common.c
> > +++ b/drivers/powercap/intel_rapl_common.c
> > @@ -547,7 +547,7 @@ static void rapl_init_domains(struct
> > rapl_package *rp)
> > 
> >                 if (i == RAPL_DOMAIN_PLATFORM && rp->id > 0) {
> >                         snprintf(rd->name, RAPL_DOMAIN_NAME_LENGTH,
> > "psys-%d",
> > -                               cpu_data(rp-
> > >lead_cpu).phys_proc_id);
> > +                               topology_physical_package_id(rp-
> > >lead_cpu));
> >                 } else
> >                         snprintf(rd->name, RAPL_DOMAIN_NAME_LENGTH,
> > "%s",
> >                                 rapl_domain_names[i]);
> > --
> > 2.27.0
> > 

