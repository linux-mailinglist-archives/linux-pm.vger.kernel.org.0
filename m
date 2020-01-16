Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88D2913F9AC
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2020 20:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgAPTlf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 14:41:35 -0500
Received: from mga04.intel.com ([192.55.52.120]:2591 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727023AbgAPTlf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Jan 2020 14:41:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2020 11:41:34 -0800
X-IronPort-AV: E=Sophos;i="5.70,327,1574150400"; 
   d="scan'208";a="373433720"
Received: from pkriegsm-mobl.amr.corp.intel.com ([10.251.131.105])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2020 11:41:34 -0800
Message-ID: <2de70e961f24592d2d157b8586526df2eaf0ae6e.camel@linux.intel.com>
Subject: Re: [PATCH] thermal: intel_pch_thermal: Add PCI ids for Lewisburg
 PCH.
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Andres Freund <andres@anarazel.de>
Cc:     Tushar Dave <tushar.n.dave@intel.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 16 Jan 2020 11:41:34 -0800
In-Reply-To: <20200116184250.qlvc3ilx2b42czqk@alap3.anarazel.de>
References: <20200115184415.1726953-1-andres@anarazel.de>
         <2a5e9df32e2df27297149a577512f6b1557de241.camel@linux.intel.com>
         <20200116184250.qlvc3ilx2b42czqk@alap3.anarazel.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2020-01-16 at 10:42 -0800, Andres Freund wrote:
> Hi,
> 
> On 2020-01-16 05:53:13 -0800, Srinivas Pandruvada wrote:
> > On Wed, 2020-01-15 at 10:44 -0800, Andres Freund wrote:
> > > I noticed that I couldn't read the PCH temperature on my
> > > workstation
> > > (C620 series chipset, w/ 2x Xeon Gold 5215 CPUs) directly, but
> > > had to
> > > go
> > > through IPMI. Looking at the data sheet, it looks to me like the
> > > existing intel PCH thermal driver should work without changes for
> > > Lewisburg.
> > Does the temperature reading match with what you read via IPMI?
> 
> It does:
> 
> root@awork3:~# ipmitool sdr|grep ^PCH
> PCH Temp         | 58 degrees C      | ok
> 
> andres@awork3:~$ cat /sys/class/thermal/thermal_zone0/type
> pch_lewisburg
> andres@awork3:~$ cat /sys/class/thermal/thermal_zone0/temp
> 58000
> 
> And if I generate some load, it rises for both:
> root@awork3:~# ipmitool sdr|grep ^PCH
> PCH Temp         | 60 degrees C      | ok
> andres@awork3:~$ cat /sys/class/thermal/thermal_zone0/temp
> 60000
> 
Thanks for the test.

Rui can add his ACK.


Thanks,
Srinivas

