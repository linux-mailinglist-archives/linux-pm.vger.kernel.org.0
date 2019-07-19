Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C40B76E28E
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2019 10:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfGSIa1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Jul 2019 04:30:27 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:42369 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfGSIa1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jul 2019 04:30:27 -0400
Received: from 79.184.255.39.ipv4.supernova.orange.pl (79.184.255.39) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 5c4dc224526c469e; Fri, 19 Jul 2019 10:30:24 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [Fwd: Commit 555c45fe0d0 ("int340X/processor_thermal_device: add support for MMIO RAPL") boot failure]
Date:   Fri, 19 Jul 2019 10:30:24 +0200
Message-ID: <1780736.Kzs3HF7DM6@kreacher>
In-Reply-To: <alpine.DEB.2.21.1907182308321.2769@hp-x360>
References: <alpine.DEB.2.21.1907181955330.2769@hp-x360> <1563514893.2433.3.camel@intel.com> <alpine.DEB.2.21.1907182308321.2769@hp-x360>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday, July 19, 2019 8:13:22 AM CEST Kenneth R. Crudup wrote:
> 
> On Fri, 19 Jul 2019, Zhang Rui wrote:
> 
> > Are you using the latest Linus' tree today?
> 
> Yeah, Linus' master tree, as of the time of this E-mail (no new commits since
> mid-afternoon Thursday PDT).
> 
> "lspci --vvnn" is attached.

Also please let me know if the appended patch helps.

---
 drivers/thermal/intel/int340x_thermal/processor_thermal_device.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux-pm/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ linux-pm/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -487,6 +487,7 @@ static int proc_thermal_rapl_add(struct
 				rapl_mmio_cpu_online, rapl_mmio_cpu_down_prep);
 	if (ret < 0) {
 		powercap_unregister_control_type(rapl_mmio_priv.control_type);
+		rapl_mmio_priv.control_type = NULL:
 		return ret;
 	}
 	rapl_mmio_priv.pcap_rapl_online = ret;
@@ -496,6 +497,9 @@ static int proc_thermal_rapl_add(struct
 
 static void proc_thermal_rapl_remove(void)
 {
+	if (IS_ERR_OR_NULL(rapl_mmio_priv.control_type))
+		return;
+
 	cpuhp_remove_state(rapl_mmio_priv.pcap_rapl_online);
 	powercap_unregister_control_type(rapl_mmio_priv.control_type);
 }



