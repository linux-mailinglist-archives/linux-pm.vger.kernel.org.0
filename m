Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9196EF4B
	for <lists+linux-pm@lfdr.de>; Sat, 20 Jul 2019 14:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbfGTMLb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Sat, 20 Jul 2019 08:11:31 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:42311 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728196AbfGTMLb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 20 Jul 2019 08:11:31 -0400
Received: from 79.184.255.39.ipv4.supernova.orange.pl (79.184.255.39) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 7b0812f9f5397da5; Sat, 20 Jul 2019 14:11:29 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     "Kenneth R. Crudup" <kenny@panix.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [Fwd: Commit 555c45fe0d0 ("int340X/processor_thermal_device: add support for MMIO RAPL") boot failure]
Date:   Sat, 20 Jul 2019 14:11:29 +0200
Message-ID: <6471701.An9MrXWVRN@kreacher>
In-Reply-To: <1563550515.2455.3.camel@intel.com>
References: <alpine.DEB.2.21.1907181955330.2769@hp-x360> <1780736.Kzs3HF7DM6@kreacher> <1563550515.2455.3.camel@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday, July 19, 2019 5:35:15 PM CEST Zhang Rui wrote:
> On 五, 2019-07-19 at 10:30 +0200, Rafael J. Wysocki wrote:
> > On Friday, July 19, 2019 8:13:22 AM CEST Kenneth R. Crudup wrote:
> > > 
> > > 
> > > On Fri, 19 Jul 2019, Zhang Rui wrote:
> > > 
> > > > 
> > > > Are you using the latest Linus' tree today?
> > > Yeah, Linus' master tree, as of the time of this E-mail (no new
> > > commits since
> > > mid-afternoon Thursday PDT).
> > > 
> > > "lspci --vvnn" is attached.
> > Also please let me know if the appended patch helps.
> > 
> this patch is still helpful although it does not fix the problem on
> hand.
> > ---
> >  drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> > |    4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > Index: linux-
> > pm/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> > ===================================================================
> > --- linux-
> > pm.orig/drivers/thermal/intel/int340x_thermal/processor_thermal_devic
> > e.c
> > +++ linux-
> > pm/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> > @@ -487,6 +487,7 @@ static int proc_thermal_rapl_add(struct
> >  				rapl_mmio_cpu_online,
> > rapl_mmio_cpu_down_prep);
> >  	if (ret < 0) {
> >  		powercap_unregister_control_type(rapl_mmio_priv.cont
> > rol_type);
> > +		rapl_mmio_priv.control_type = NULL:
> s/:/;

OK, I'll fix it up and resend it next week then.

Thanks!



