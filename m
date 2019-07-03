Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92F125DFAF
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2019 10:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfGCIXW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jul 2019 04:23:22 -0400
Received: from mga04.intel.com ([192.55.52.120]:12513 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727045AbfGCIXW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Jul 2019 04:23:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2019 01:23:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,446,1557212400"; 
   d="scan'208";a="169055077"
Received: from zhongyan-mobl.ccr.corp.intel.com ([10.249.170.124])
  by orsmga006.jf.intel.com with ESMTP; 03 Jul 2019 01:23:19 -0700
Message-ID: <1562142196.3256.15.camel@intel.com>
Subject: Re: [PATCH 09/13] intel_rapl: abstract RAPL common code
From:   Zhang Rui <rui.zhang@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Date:   Wed, 03 Jul 2019 16:23:16 +0800
In-Reply-To: <CAJZ5v0gEW_9UaZDnJdz60e6baEYQOuG-SdZu54tswho6J+zYkQ@mail.gmail.com>
References: <1561701029-3415-1-git-send-email-rui.zhang@intel.com>
         <1561701029-3415-10-git-send-email-rui.zhang@intel.com>
         <CAJZ5v0gEW_9UaZDnJdz60e6baEYQOuG-SdZu54tswho6J+zYkQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 二, 2019-07-02 at 23:59 +0200, Rafael J. Wysocki wrote:
> On Fri, Jun 28, 2019 at 7:50 AM Zhang Rui <rui.zhang@intel.com>
> wrote:
> > 
> > 
> > Split intel_rapl.c to intel_rapl_common.c and intel_rapl.c, where
> > intel_rapl_common.c contains the common code that can be used by
> > both MSR
> > and MMIO interface.
> > intel_rapl.c still contains the implementation of RAPL MSR
> > interface.
> > 
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/powercap/Kconfig             |   11 +-
> >  drivers/powercap/Makefile            |    1 +
> >  drivers/powercap/intel_rapl.c        | 1427 +---------------------
> > -----------
> >  drivers/powercap/intel_rapl_common.c | 1468
> > ++++++++++++++++++++++++++++++++++
> intel_rapl_common.c and intel_rapl_msr.c, please.
> 
I kept the MSR RAPL interface in intel_rapl.c for compatibility reason,
and that was made when the module autoloading issue is not fixed, so
people can still use "modprobe intel_rapl" manually to get the MSR RAPL
interface.

Now given that the MSR RAPL interface driver can be autoloaded, I think
it is okay to use intel_rapl_msr.c and intel_rapl_common.c.
Srinivas, is there anything else prevents us from using a new module
name for MSR RAPL interface?

thanks,
rui
