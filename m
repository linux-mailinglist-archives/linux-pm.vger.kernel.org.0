Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4165B58352
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2019 15:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfF0NVg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 09:21:36 -0400
Received: from mga09.intel.com ([134.134.136.24]:37794 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbfF0NVg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 27 Jun 2019 09:21:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2019 06:21:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,423,1557212400"; 
   d="scan'208";a="167427271"
Received: from luyang-mobl.ccr.corp.intel.com ([10.249.174.5])
  by orsmga006.jf.intel.com with ESMTP; 27 Jun 2019 06:21:33 -0700
Message-ID: <1561641692.2096.3.camel@intel.com>
Subject: Re: [PATCH 1/2] thermal/drivers/core: Add init section table for
 self-encapsulation
From:   Zhang Rui <rui.zhang@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        amit.kucheria@linaro.org
Date:   Thu, 27 Jun 2019 21:21:32 +0800
In-Reply-To: <b6bbd5f4-a86a-d649-e3c0-2156f7975291@linaro.org>
References: <20190612201325.1150-1-daniel.lezcano@linaro.org>
         <b6bbd5f4-a86a-d649-e3c0-2156f7975291@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 一, 2019-06-24 at 09:32 +0200, Daniel Lezcano wrote:
> Any chance this patch gets merged for v5.4?
> 
> Thanks
>   -- Daniel
> 

have you run compile test for the patch?
I got the following errors when compiling.

In file included from drivers/thermal/fair_share.c:16:0:
drivers/thermal/thermal_core.h:23:3: error: expected identifier or ‘(’
before ‘static’
  (static typeof(name) *__thermal_table_entry_##name \
   ^
drivers/thermal/thermal_core.h:26:40: note: in expansion of macro
‘THERMAL_TABLE_ENTRY’
 #define THERMAL_GOVERNOR_DECLARE(name) THERMAL_TABLE_ENTRY(governor,
name)
                                        ^
drivers/thermal/fair_share.c:120:1: note: in expansion of macro
‘THERMAL_GOVERNOR_DECLARE’
 THERMAL_GOVERNOR_DECLARE(thermal_gov_fair_share);
 ^
drivers/thermal/fair_share.c:116:32: warning: ‘thermal_gov_fair_share’
defined but not used [-Wunused-variable]
 static struct thermal_governor thermal_gov_fair_share = {
                                ^
make[2]: *** [drivers/thermal/fair_share.o] Error 1
make[2]: *** Waiting for unfinished jobs....
In file included from drivers/thermal/gov_bang_bang.c:14:0:
drivers/thermal/thermal_core.h:23:3: error: expected identifier or ‘(’
before ‘static’
  (static typeof(name) *__thermal_table_entry_##name \
   ^
drivers/thermal/thermal_core.h:26:40: note: in expansion of macro
‘THERMAL_TABLE_ENTRY’
 #define THERMAL_GOVERNOR_DECLARE(name) THERMAL_TABLE_ENTRY(governor,
name)
                                        ^
drivers/thermal/gov_bang_bang.c:119:1: note: in expansion of macro
‘THERMAL_GOVERNOR_DECLARE’
 THERMAL_GOVERNOR_DECLARE(thermal_gov_bang_bang);
 ^
drivers/thermal/gov_bang_bang.c:115:32: warning:
‘thermal_gov_bang_bang’ defined but not used [-Wunused-variable]
 static struct thermal_governor thermal_gov_bang_bang = {
                                ^
make[2]: *** [drivers/thermal/gov_bang_bang.o] Error 1
make[1]: *** [drivers/thermal] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [drivers] Error 2

Fix the problem by removing the round brackets
of THERMAL_TABLE_ENTRY(), and applied.

thanks,
rui
> On 12/06/2019 22:13, Daniel Lezcano wrote:
> > 
> > Currently the governors are declared in their respective files but
> > they
> > export their [un]register functions which in turn call the
> > [un]register
> > governors core's functions. That implies a cyclic dependency which
> > is
> > not desirable. There is a way to self-encapsulate the governors by
> > letting
> > them to declare themselves in a __init section table.
> > 
> > Define the table in the asm generic linker description like the
> > other
> > tables and provide the specific macros to deal with.
> > 
> > Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > ---
> >  drivers/thermal/thermal_core.h    | 15 +++++++++++++++
> >  include/asm-generic/vmlinux.lds.h | 11 +++++++++++
> >  2 files changed, 26 insertions(+)
> > 
> > diff --git a/drivers/thermal/thermal_core.h
> > b/drivers/thermal/thermal_core.h
> > index 0df190ed82a7..be901e84aa65 100644
> > --- a/drivers/thermal/thermal_core.h
> > +++ b/drivers/thermal/thermal_core.h
> > @@ -15,6 +15,21 @@
> >  /* Initial state of a cooling device during binding */
> >  #define THERMAL_NO_TARGET -1UL
> >  
> > +/* Init section thermal table */
> > +extern struct thermal_governor *__governor_thermal_table[];
> > +extern struct thermal_governor *__governor_thermal_table_end[];
> > +
> > +#define THERMAL_TABLE_ENTRY(table, name)			\
> > +	(static typeof(name) *__thermal_table_entry_##name	
> > \
> > +	__used __section(__##table##_thermal_table) = &name)
> > +
> > +#define THERMAL_GOVERNOR_DECLARE(name)	THERMAL_TABLE_ENTRY(
> > governor, name)
> > +
> > +#define for_each_governor_table(__governor)		\
> > +	for (__governor = __governor_thermal_table;	\
> > +	     __governor < __governor_thermal_table_end;	\
> > +	     __governor++)
> > +
> >  /*
> >   * This structure is used to describe the behavior of
> >   * a certain cooling device on a certain trip point
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-
> > generic/vmlinux.lds.h
> > index f8f6f04c4453..8312fdc2b2fa 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -239,6 +239,16 @@
> >  #define ACPI_PROBE_TABLE(name)
> >  #endif
> >  
> > +#ifdef CONFIG_THERMAL
> > +#define THERMAL_TABLE(name)					
> > 	\
> > +	. = ALIGN(8);						
> > 	\
> > +	__##name##_thermal_table = .;				
> > 	\
> > +	KEEP(*(__##name##_thermal_table))				
> > \
> > +	__##name##_thermal_table_end = .;
> > +#else
> > +#define THERMAL_TABLE(name)
> > +#endif
> > +
> >  #define KERNEL_DTB()						
> > 	\
> >  	STRUCT_ALIGN();						
> > 	\
> >  	__dtb_start = .;						
> > \
> > @@ -609,6 +619,7 @@
> >  	IRQCHIP_OF_MATCH_TABLE()					
> > \
> >  	ACPI_PROBE_TABLE(irqchip)					
> > \
> >  	ACPI_PROBE_TABLE(timer)					
> > 	\
> > +	THERMAL_TABLE(governor)					
> > 	\
> >  	EARLYCON_TABLE()						
> > \
> >  	LSM_TABLE()
> >  
> > 
> 
