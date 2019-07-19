Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE0136E5C3
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2019 14:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbfGSMdh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 19 Jul 2019 08:33:37 -0400
Received: from mga05.intel.com ([192.55.52.43]:11560 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728130AbfGSMdh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Jul 2019 08:33:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jul 2019 05:33:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,282,1559545200"; 
   d="scan'208";a="170891730"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga003.jf.intel.com with ESMTP; 19 Jul 2019 05:33:36 -0700
Received: from fmsmsx114.amr.corp.intel.com (10.18.116.8) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 19 Jul 2019 05:33:35 -0700
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 FMSMSX114.amr.corp.intel.com (10.18.116.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 19 Jul 2019 05:33:35 -0700
Received: from shsmsx108.ccr.corp.intel.com ([169.254.8.174]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.3]) with mapi id 14.03.0439.000;
 Fri, 19 Jul 2019 20:33:33 +0800
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Kenneth R. Crudup" <kenny@panix.com>
CC:     Linux PM list <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: RE: [Fwd: Commit 555c45fe0d0 ("int340X/processor_thermal_device:
 add support for MMIO RAPL") boot failure]
Thread-Topic: [Fwd: Commit 555c45fe0d0 ("int340X/processor_thermal_device:
 add support for MMIO RAPL") boot failure]
Thread-Index: AQHVPfk4xv+J6oZLOE2BKIB9x1Q0cabRFlwAgAC3l4CAABIAEA==
Date:   Fri, 19 Jul 2019 12:33:32 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B909263775CFCCF@SHSMSX108.ccr.corp.intel.com>
References: <alpine.DEB.2.21.1907181955330.2769@hp-x360>
 <1563514893.2433.3.camel@intel.com>
 <alpine.DEB.2.21.1907182308321.2769@hp-x360> <1780736.Kzs3HF7DM6@kreacher>
 <744357E9AAD1214791ACBA4B0B909263775CFC4D@SHSMSX108.ccr.corp.intel.com>
In-Reply-To: <744357E9AAD1214791ACBA4B0B909263775CFC4D@SHSMSX108.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYjQzMDc1NmEtODY3OS00YTUzLWJhOWUtYzMxYzRjOWUwOWJjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoieE4zc0JJNzduVWJSTDFcL2ZlZ29KNnhURmdjVXdhMnVycW5UeThCelk3QXZkOWxBZU50aUFuTzg2TDNXV28yQmIifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



> -----Original Message-----
> From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
> owner@vger.kernel.org] On Behalf Of Zhang, Rui
> Sent: Friday, July 19, 2019 7:28 PM
> To: Rafael J. Wysocki <rjw@rjwysocki.net>; Kenneth R. Crudup
> <kenny@panix.com>
> Cc: Linux PM list <linux-pm@vger.kernel.org>; Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com>
> Subject: RE: [Fwd: Commit 555c45fe0d0 ("int340X/processor_thermal_device:
> add support for MMIO RAPL") boot failure]
> 
> 
> 
> > -----Original Message-----
> > From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
> > owner@vger.kernel.org] On Behalf Of Rafael J. Wysocki
> > Sent: Friday, July 19, 2019 4:30 PM
> > To: Kenneth R. Crudup <kenny@panix.com>
> > Cc: Zhang, Rui <rui.zhang@intel.com>; Linux PM list <linux-
> > pm@vger.kernel.org>; Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
> > Subject: Re: [Fwd: Commit 555c45fe0d0
> ("int340X/processor_thermal_device:
> > add support for MMIO RAPL") boot failure]
> > Importance: High
> >
> > On Friday, July 19, 2019 8:13:22 AM CEST Kenneth R. Crudup wrote:
> > >
> > > On Fri, 19 Jul 2019, Zhang Rui wrote:
> > >
> > > > Are you using the latest Linus' tree today?
> > >
> > > Yeah, Linus' master tree, as of the time of this E-mail (no new
> > > commits since mid-afternoon Thursday PDT).
> > >
> > > "lspci --vvnn" is attached.
> >
> > Also please let me know if the appended patch helps.
> >
> I can reproduce the issue with the config attached, and this patch does not
> help.
> I'm still working on it.
> 
This is an ordering issue, MMIO RAPL interface driver is registered before powercap sysfs class initialized.
I'm working at a fix now.

Thanks,
rui
> Thanks,
> rui
> > ---
> >  drivers/thermal/intel/int340x_thermal/processor_thermal_device.c |    4
> > ++++
> >  1 file changed, 4 insertions(+)
> >
> > Index: linux-
> > pm/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> >
> ================================================================
> > ===
> > --- linux-
> > pm.orig/drivers/thermal/intel/int340x_thermal/processor_thermal_device
> > .c
> > +++ linux-
> > pm/drivers/thermal/intel/int340x_thermal/processor_thermal_dev
> > +++ ice.c
> > @@ -487,6 +487,7 @@ static int proc_thermal_rapl_add(struct
> >  				rapl_mmio_cpu_online,
> > rapl_mmio_cpu_down_prep);
> >  	if (ret < 0) {
> >
> > 	powercap_unregister_control_type(rapl_mmio_priv.control_type);
> > +		rapl_mmio_priv.control_type = NULL:
> >  		return ret;
> >  	}
> >  	rapl_mmio_priv.pcap_rapl_online = ret; @@ -496,6 +497,9 @@
> static
> > int proc_thermal_rapl_add(struct
> >
> >  static void proc_thermal_rapl_remove(void)  {
> > +	if (IS_ERR_OR_NULL(rapl_mmio_priv.control_type))
> > +		return;
> > +
> >  	cpuhp_remove_state(rapl_mmio_priv.pcap_rapl_online);
> >  	powercap_unregister_control_type(rapl_mmio_priv.control_type);
> >  }
> >
> >

