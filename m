Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA61D13DC70
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2020 14:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgAPNxO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 08:53:14 -0500
Received: from mga09.intel.com ([134.134.136.24]:43661 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbgAPNxO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Jan 2020 08:53:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2020 05:53:14 -0800
X-IronPort-AV: E=Sophos;i="5.70,326,1574150400"; 
   d="scan'208";a="373316388"
Received: from dlneuman-mobl1.amr.corp.intel.com ([10.254.178.157])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2020 05:53:13 -0800
Message-ID: <2a5e9df32e2df27297149a577512f6b1557de241.camel@linux.intel.com>
Subject: Re: [PATCH] thermal: intel_pch_thermal: Add PCI ids for Lewisburg
 PCH.
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Andres Freund <andres@anarazel.de>,
        Tushar Dave <tushar.n.dave@intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 16 Jan 2020 05:53:13 -0800
In-Reply-To: <20200115184415.1726953-1-andres@anarazel.de>
References: <20200115184415.1726953-1-andres@anarazel.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2020-01-15 at 10:44 -0800, Andres Freund wrote:
> I noticed that I couldn't read the PCH temperature on my workstation
> (C620 series chipset, w/ 2x Xeon Gold 5215 CPUs) directly, but had to
> go
> through IPMI. Looking at the data sheet, it looks to me like the
> existing intel PCH thermal driver should work without changes for
> Lewisburg.
Does the temperature reading match with what you read via IPMI?

The patch looks fine to me otherwise.

Thanks,
Srinivas

> 
> I suspect there's some other PCI id's missing. But I hope somebody at
> Intel would have an easier time figuring that out than I...
> 
> Signed-off-by: Andres Freund <andres@anarazel.de>
> ---
>  drivers/thermal/intel/intel_pch_thermal.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/thermal/intel/intel_pch_thermal.c
> b/drivers/thermal/intel/intel_pch_thermal.c
> index 4f0bb8f502e1..1f3ff0d489ef 100644
> --- a/drivers/thermal/intel/intel_pch_thermal.c
> +++ b/drivers/thermal/intel/intel_pch_thermal.c
> @@ -23,6 +23,7 @@
>  #define PCH_THERMAL_DID_SKL_H	0xA131 /* Skylake PCH 100
> series */
>  #define PCH_THERMAL_DID_CNL	0x9Df9 /* CNL PCH */
>  #define PCH_THERMAL_DID_CNL_H	0xA379 /* CNL-H PCH */
> +#define PCH_THERMAL_DID_LWB	0xA1B1 /* Lewisburg PCH */
>  
>  /* Wildcat Point-LP  PCH Thermal registers */
>  #define WPT_TEMP	0x0000	/* Temperature */
> @@ -272,6 +273,7 @@ enum board_ids {
>  	board_wpt,
>  	board_skl,
>  	board_cnl,
> +	board_lwb,
>  };
>  
>  static const struct board_info {
> @@ -294,6 +296,10 @@ static const struct board_info {
>  		.name = "pch_cannonlake",
>  		.ops = &pch_dev_ops_wpt,
>  	},
> +	[board_lwb] = {
> +		.name = "pch_lewisburg",
> +		.ops = &pch_dev_ops_wpt,
> +	},
>  };
>  
>  static int intel_pch_thermal_probe(struct pci_dev *pdev,
> @@ -398,6 +404,8 @@ static const struct pci_device_id
> intel_pch_thermal_id[] = {
>  		.driver_data = board_cnl, },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_CNL_H),
>  		.driver_data = board_cnl, },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_LWB),
> +		.driver_data = board_lwb, },
>  	{ 0, },
>  };
>  MODULE_DEVICE_TABLE(pci, intel_pch_thermal_id);

