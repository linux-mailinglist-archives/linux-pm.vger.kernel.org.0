Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D23713D4B2
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2020 07:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgAPGyi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 01:54:38 -0500
Received: from mga09.intel.com ([134.134.136.24]:43921 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbgAPGyh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Jan 2020 01:54:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2020 22:54:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,325,1574150400"; 
   d="scan'208";a="256949741"
Received: from wanglin3-mobl.ccr.corp.intel.com ([10.255.31.165])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jan 2020 22:54:34 -0800
Message-ID: <8c1a2a53c5350faa12906a104e9863371973c908.camel@intel.com>
Subject: Re: [PATCH v1] thermal/intel: intel_pch_thermal: Add Comet Lake
 (CML) platform support
From:   Zhang Rui <rui.zhang@intel.com>
To:     Gayatri Kammela <gayatri.kammela@intel.com>,
        linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, charles.d.prestopine@intel.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Date:   Thu, 16 Jan 2020 14:55:06 +0800
In-Reply-To: <20191211200043.4985-1-gayatri.kammela@intel.com>
References: <20191211200043.4985-1-gayatri.kammela@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2019-12-11 at 12:00 -0800, Gayatri Kammela wrote:
> Add Comet Lake to the list of the platforms to support
> intel_pch_thermal
> driver.
> 
> Cc: Zhang rui <rui.zhang@intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>

Acked-by: Zhang Rui <rui.zhang@intel.com>

> ---
>  drivers/thermal/intel/intel_pch_thermal.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/thermal/intel/intel_pch_thermal.c
> b/drivers/thermal/intel/intel_pch_thermal.c
> index 4f0bb8f502e1..9356f3a7f961 100644
> --- a/drivers/thermal/intel/intel_pch_thermal.c
> +++ b/drivers/thermal/intel/intel_pch_thermal.c
> @@ -23,6 +23,7 @@
>  #define PCH_THERMAL_DID_SKL_H	0xA131 /* Skylake PCH 100
> series */
>  #define PCH_THERMAL_DID_CNL	0x9Df9 /* CNL PCH */
>  #define PCH_THERMAL_DID_CNL_H	0xA379 /* CNL-H PCH */
> +#define PCH_THERMAL_DID_CML_H	0X06F9 /* CML-H PCH */
>  
>  /* Wildcat Point-LP  PCH Thermal registers */
>  #define WPT_TEMP	0x0000	/* Temperature */
> @@ -272,6 +273,7 @@ enum board_ids {
>  	board_wpt,
>  	board_skl,
>  	board_cnl,
> +	board_cml,
>  };
>  
>  static const struct board_info {
> @@ -294,6 +296,10 @@ static const struct board_info {
>  		.name = "pch_cannonlake",
>  		.ops = &pch_dev_ops_wpt,
>  	},
> +	[board_cml] = {
> +		.name = "pch_cometlake",
> +		.ops = &pch_dev_ops_wpt,
> +	}
>  };
>  
>  static int intel_pch_thermal_probe(struct pci_dev *pdev,
> @@ -398,6 +404,8 @@ static const struct pci_device_id
> intel_pch_thermal_id[] = {
>  		.driver_data = board_cnl, },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_CNL_H),
>  		.driver_data = board_cnl, },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_CML_H),
> +		.driver_data = board_cml, },
>  	{ 0, },
>  };
>  MODULE_DEVICE_TABLE(pci, intel_pch_thermal_id);

