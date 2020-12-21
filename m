Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4150F2DFE99
	for <lists+linux-pm@lfdr.de>; Mon, 21 Dec 2020 18:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgLUQ75 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Dec 2020 11:59:57 -0500
Received: from mga02.intel.com ([134.134.136.20]:23397 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbgLUQ74 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 21 Dec 2020 11:59:56 -0500
IronPort-SDR: Y49g7h4xJ/w4cB6ObWDOO2D4rULBuj/B/ytOLPeLw23bzV9lfl2WSz0CRUETjNjGxny7Bp04y8
 aXeBIUGWjp6g==
X-IronPort-AV: E=McAfee;i="6000,8403,9842"; a="162806858"
X-IronPort-AV: E=Sophos;i="5.78,436,1599548400"; 
   d="scan'208";a="162806858"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 08:58:01 -0800
IronPort-SDR: TgzFwth1ugwhydGxdNVTmwehM+7Wj70wucCG+sssDT/DHxQfj7OIrKygbqf5rHepbHZmR0TRp4
 v372rRbU1ikw==
X-IronPort-AV: E=Sophos;i="5.78,436,1599548400"; 
   d="scan'208";a="355748092"
Received: from haberchr-mobl.amr.corp.intel.com ([10.212.196.73])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 08:57:55 -0800
Message-ID: <c436e4bc62605ed1f66f9b1196534f9a041c5b86.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] thermal: int340x: Add critical callback to override
 default shutdown behavior
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Zhang, Rui" <rui.zhang@intel.com>, amitk@kernel.org,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Matthew Garrett <mjg59@google.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Peter Kaestle <peter@piie.net>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Mon, 21 Dec 2020 08:57:51 -0800
In-Reply-To: <9e4dc22e-e912-8410-945c-f802f3959028@linaro.org>
References: <20201221135206.17671-1-kai.heng.feng@canonical.com>
         <20e74dc1-1f1d-6dee-19a7-e9a975b66606@linaro.org>
         <CAAd53p5WRVMgSquOC69Yq3DO+itSR44273bLWiF7wXUxFZMDhg@mail.gmail.com>
         <9e4dc22e-e912-8410-945c-f802f3959028@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2020-12-21 at 17:03 +0100, Daniel Lezcano wrote:
> On 21/12/2020 16:00, Kai-Heng Feng wrote:
> > On Mon, Dec 21, 2020 at 9:59 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> > > 
> > > On 21/12/2020 14:52, Kai-Heng Feng wrote:
> > > > We are seeing thermal shutdown on Intel based mobile
> > > > workstations, the
> > > > shutdown happens during the first trip handle in
> > > > thermal_zone_device_register():
> > > > kernel: thermal thermal_zone15: critical temperature reached
> > > > (101 C), shutting down
> > > > 
> > > > However, we shouldn't do a thermal shutdown here, since
> > > > 1) We may want to use a dedicated daemon, Intel's thermald in
> > > > this case,
> > > > to handle thermal shutdown.
> > > > 
> > > > 2) For ACPI based system, _CRT doesn't mean shutdown unless
> > > > it's inside
> > > > ThermalZone namespace. ACPI Spec, 11.4.4 _CRT (Critical
> > > > Temperature):
> > > > "... If this object it present under a device, the device’s
> > > > driver
> > > > evaluates this object to determine the device’s critical
> > > > cooling
> > > > temperature trip point. This value may then be used by the
> > > > device’s
> > > > driver to program an internal device temperature sensor trip
> > > > point."
> > > > 
> > > > So a "critical trip" here merely means we should take a more
> > > > aggressive
> > > > cooling method.
> > > > 
> > > > As int340x device isn't present under ACPI ThermalZone,
> > > > override the
> > > > default .critical callback to prevent surprising thermal
> > > > shutdown.
> > > > 
> > > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > 
> > > I'll submit those changes for v5.11-rc1 and change the subject
> > > by:
> > > 
> > > thermal: int340x: Fix unexpected shutdown at critical temperature
> > > thermal: pch: Fix unexpected shutdown at critical temperature
> > > 
> > > Sounds good ?
> > 
> > Sounds good to me. Thanks!
> > 
> > Kai-Heng
> 
> Rui, Srinivas? Are you ok with the changes ?
I have minor comment in one of the patch. But that is harmless.
So changes are fine.

Thanks,
Srinivas


> 
> 


