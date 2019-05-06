Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 306F914A32
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2019 14:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbfEFMuZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 May 2019 08:50:25 -0400
Received: from mga03.intel.com ([134.134.136.65]:34370 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbfEFMuZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 6 May 2019 08:50:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 05:50:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,438,1549958400"; 
   d="scan'208";a="168404200"
Received: from lilitang-mobl.ccr.corp.intel.com ([10.249.168.111])
  by fmsmga002.fm.intel.com with ESMTP; 06 May 2019 05:50:22 -0700
Message-ID: <1557147020.2456.5.camel@intel.com>
Subject: Re: [PATCH] drivers: thermal: processor_thermal: Downgrade error
 message
From:   Zhang Rui <rui.zhang@intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        edubezval@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 06 May 2019 20:50:20 +0800
In-Reply-To: <20190430034213.40028-1-srinivas.pandruvada@linux.intel.com>
References: <20190430034213.40028-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 一, 2019-04-29 at 20:42 -0700, Srinivas Pandruvada wrote:
> Downgrade "Unsupported event" message from dev_err to dev_dbg.
> Otherwise it
> floods with this message one some platforms.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.c
> om>
> ---
>  .../thermal/intel/int340x_thermal/processor_thermal_device.c    | 2
> +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git
> a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> index 4b206b594825..436c256f111d 100644
> ---
> a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> +++
> b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> @@ -275,7 +275,7 @@ static void proc_thermal_notify(acpi_handle
> handle, u32 event, void *data)
>  				THERMAL_DEVICE_POWER_CAPABILITY_CHAN
> GED);
>  		break;
>  	default:
> -		dev_err(proc_priv->dev, "Unsupported event
> [0x%x]\n", event);
> +		dev_dbg(proc_priv->dev, "Unsupported event
> [0x%x]\n", event);
>  		break;
>  	}
>  }

a similar patch has been applied, the only difference is that I'm using
dev_notice instead.
https://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git/commit
/?h=next&id=3c7110fab805766450c5d2eac1c994d4c8c230d3

thanks,
rui
