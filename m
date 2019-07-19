Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4536E805
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2019 17:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbfGSPfT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Jul 2019 11:35:19 -0400
Received: from mga06.intel.com ([134.134.136.31]:52050 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbfGSPfT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Jul 2019 11:35:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jul 2019 08:35:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,282,1559545200"; 
   d="scan'208";a="195982586"
Received: from jiajial1-mobl1.ccr.corp.intel.com ([10.255.30.115])
  by fmsmga002.fm.intel.com with ESMTP; 19 Jul 2019 08:35:17 -0700
Message-ID: <1563550515.2455.3.camel@intel.com>
Subject: Re: [Fwd: Commit 555c45fe0d0 ("int340X/processor_thermal_device:
 add support for MMIO RAPL") boot failure]
From:   Zhang Rui <rui.zhang@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Kenneth R. Crudup" <kenny@panix.com>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Date:   Fri, 19 Jul 2019 23:35:15 +0800
In-Reply-To: <1780736.Kzs3HF7DM6@kreacher>
References: <alpine.DEB.2.21.1907181955330.2769@hp-x360>
         <1563514893.2433.3.camel@intel.com>
         <alpine.DEB.2.21.1907182308321.2769@hp-x360> <1780736.Kzs3HF7DM6@kreacher>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 五, 2019-07-19 at 10:30 +0200, Rafael J. Wysocki wrote:
> On Friday, July 19, 2019 8:13:22 AM CEST Kenneth R. Crudup wrote:
> > 
> > 
> > On Fri, 19 Jul 2019, Zhang Rui wrote:
> > 
> > > 
> > > Are you using the latest Linus' tree today?
> > Yeah, Linus' master tree, as of the time of this E-mail (no new
> > commits since
> > mid-afternoon Thursday PDT).
> > 
> > "lspci --vvnn" is attached.
> Also please let me know if the appended patch helps.
> 
this patch is still helpful although it does not fix the problem on
hand.
> ---
>  drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> Index: linux-
> pm/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> ===================================================================
> --- linux-
> pm.orig/drivers/thermal/intel/int340x_thermal/processor_thermal_devic
> e.c
> +++ linux-
> pm/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> @@ -487,6 +487,7 @@ static int proc_thermal_rapl_add(struct
>  				rapl_mmio_cpu_online,
> rapl_mmio_cpu_down_prep);
>  	if (ret < 0) {
>  		powercap_unregister_control_type(rapl_mmio_priv.cont
> rol_type);
> +		rapl_mmio_priv.control_type = NULL:
s/:/;

thanks,
rui
>  		return ret;
>  	}
>  	rapl_mmio_priv.pcap_rapl_online = ret;
> @@ -496,6 +497,9 @@ static int proc_thermal_rapl_add(struct
>  
>  static void proc_thermal_rapl_remove(void)
>  {
> +	if (IS_ERR_OR_NULL(rapl_mmio_priv.control_type))
> +		return;
> +
>  	cpuhp_remove_state(rapl_mmio_priv.pcap_rapl_online);
>  	powercap_unregister_control_type(rapl_mmio_priv.control_type
> );
>  }
> 
> 
> 
