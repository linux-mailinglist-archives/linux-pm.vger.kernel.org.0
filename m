Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0550D13D4BE
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2020 07:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgAPG4l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 01:56:41 -0500
Received: from mga06.intel.com ([134.134.136.31]:57151 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbgAPG4k (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Jan 2020 01:56:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2020 22:56:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,325,1574150400"; 
   d="scan'208";a="425393870"
Received: from wanglin3-mobl.ccr.corp.intel.com ([10.255.31.165])
  by fmsmga006.fm.intel.com with ESMTP; 15 Jan 2020 22:56:38 -0800
Message-ID: <970ad09ea5ef05ca5bf158fdb9e5c9596e746fc5.camel@intel.com>
Subject: Re: [PATCH] thermal: intel: fix unmatched pci_release_region
From:   Zhang Rui <rui.zhang@intel.com>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 16 Jan 2020 14:57:10 +0800
In-Reply-To: <20191206075531.18637-1-hslester96@gmail.com>
References: <20191206075531.18637-1-hslester96@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2019-12-06 at 15:55 +0800, Chuhong Yuan wrote:
> The driver calls pci_request_regions() in probe and uses
> pci_release_regions() in probe failure.
> However, it calls pci_release_region() in remove, which does
> match the other two calls.
> Use pci_release_regions() instead to unify them.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Acked-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/thermal/intel/intel_pch_thermal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/intel/intel_pch_thermal.c
> b/drivers/thermal/intel/intel_pch_thermal.c
> index 4f0bb8f502e1..5f7798b8d35f 100644
> --- a/drivers/thermal/intel/intel_pch_thermal.c
> +++ b/drivers/thermal/intel/intel_pch_thermal.c
> @@ -365,7 +365,7 @@ static void intel_pch_thermal_remove(struct
> pci_dev *pdev)
>  	thermal_zone_device_unregister(ptd->tzd);
>  	iounmap(ptd->hw_base);
>  	pci_set_drvdata(pdev, NULL);
> -	pci_release_region(pdev, 0);
> +	pci_release_regions(pdev);
>  	pci_disable_device(pdev);
>  }
>  

