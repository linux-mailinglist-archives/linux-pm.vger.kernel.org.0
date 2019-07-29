Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3996F79A9D
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 23:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbfG2VJF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 17:09:05 -0400
Received: from mga03.intel.com ([134.134.136.65]:19268 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbfG2VJF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 29 Jul 2019 17:09:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jul 2019 14:09:04 -0700
X-IronPort-AV: E=Sophos;i="5.64,324,1559545200"; 
   d="scan'208";a="171681418"
Received: from afuhr-mobl.amr.corp.intel.com ([10.255.94.250])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jul 2019 14:09:03 -0700
Message-ID: <42db46c33466a12221e0968e82c4c4ee17b0341d.camel@linux.intel.com>
Subject: Re: [PATCH][V2] drivers: thermal: processor_thermal_device: fix
 missing bitwise-or operators
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Colin King <colin.king@canonical.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 29 Jul 2019 14:09:00 -0700
In-Reply-To: <20190729120323.15838-1-colin.king@canonical.com>
References: <20190729120323.15838-1-colin.king@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2019-07-29 at 13:03 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable val is having the top 8 bits cleared and then the
> variable is being
> re-assinged and setting just the top 8 bits.  I believe the intention
> was bitwise-or
> in the top 8 bits.  Fix this by replacing the = operators with &= and
> |= instead.
> 
> Addresses-Coverity: ("Unused value")
> Fixes: b0c74b08517e ("drivers: thermal: processor_thermal_device:
> Export sysfs inteface for TCC offset")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> 
> V2: Add in &= operator missing from V1. Doh.
> 
> ---
>  .../thermal/intel/int340x_thermal/processor_thermal_device.c  | 4
> ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git
> a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> index 6f6ac6a8e82d..97333fc4be42 100644
> ---
> a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> +++
> b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> @@ -163,8 +163,8 @@ static int tcc_offset_update(int tcc)
>  	if (err)
>  		return err;
>  
> -	val = ~GENMASK_ULL(31, 24);
> -	val = (tcc & 0xff) << 24;
> +	val &= ~GENMASK_ULL(31, 24);
> +	val |= (tcc & 0xff) << 24;
>  
>  	err = wrmsrl_safe(MSR_IA32_TEMPERATURE_TARGET, val);
>  	if (err)

