Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A08221140BB
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 13:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbfLEMTy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 07:19:54 -0500
Received: from mga06.intel.com ([134.134.136.31]:55825 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729096AbfLEMTy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Dec 2019 07:19:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2019 04:19:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,281,1571727600"; 
   d="scan'208";a="236652298"
Received: from yuanwan1-mobl.ccr.corp.intel.com ([10.249.174.225])
  by fmsmga004.fm.intel.com with ESMTP; 05 Dec 2019 04:19:52 -0800
Message-ID: <d00ea4a1636cd0cfb8c672ef0edc260e7a4759c3.camel@intel.com>
Subject: Re: [PATCH] thermal: Add Daniel Lezcano as the thermal maintainer
From:   Zhang Rui <rui.zhang@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Date:   Thu, 05 Dec 2019 20:19:51 +0800
In-Reply-To: <CAPDyKFqFswOjqNn0s7Y3BAeYuVr+z2NrX3fbn+yu+O1vgWb8tA@mail.gmail.com>
References: <20191205115150.18836-1-rui.zhang@intel.com>
         <CAPDyKFqFswOjqNn0s7Y3BAeYuVr+z2NrX3fbn+yu+O1vgWb8tA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2019-12-05 at 13:03 +0100, Ulf Hansson wrote:
> On Thu, 5 Dec 2019 at 12:52, Zhang Rui <rui.zhang@intel.com> wrote:
> > 
> > Add Daniel Lezcano as the co-maintainer of thermal subsystem.
> > 
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  MAINTAINERS | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index c8abdb50af79..0efadb61fe8b 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -16287,7 +16287,7 @@ F:      drivers/media/radio/radio-
> > raremono.c
> > 
> >  THERMAL
> >  M:     Zhang Rui <rui.zhang@intel.com>
> > -R:     Daniel Lezcano <daniel.lezcano@linaro.org>
> > +M:     Daniel Lezcano <daniel.lezcano@linaro.org>
> >  R:     Amit Kucheria <amit.kucheria@verdurent.com>
> >  L:     linux-pm@vger.kernel.org
> >  T:     git
> > git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git
> 
> Great!
> 
> Did you guys also agree on how to work with the git tree? There is
> one
> common git, maintained by Rui?

we have a shared tree where both Daniel and I are maintaining.
https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/

thermal/linux-next branch contains all the upstream candidate, and it
is included in linux-next for testing.
Daniel and I will cherry-pick the patches from thermal/linux-next to
thermal/fixes or thermal/next branch, where thermal/fixes are materials
for next -rc and thermal/next are materials for next merge window.

Daniel and I will sync privately to check who will send the PR.

thanks,
rui

> 
> Just to let people aware of the workflow...
> 
> Kind regards
> Ulf Hansson

