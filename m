Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93AF737683E
	for <lists+linux-pm@lfdr.de>; Fri,  7 May 2021 17:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbhEGPsE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 May 2021 11:48:04 -0400
Received: from mga18.intel.com ([134.134.136.126]:53033 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229558AbhEGPsE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 7 May 2021 11:48:04 -0400
IronPort-SDR: O/r2sU2ZvHh5GtHOZjPZukt0DOptT070YwjvCVLy5cIfq5/E4MFy0mzYbX1J11L5T77cuXtate
 nYP7vxjfgQ5Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9977"; a="186208722"
X-IronPort-AV: E=Sophos;i="5.82,281,1613462400"; 
   d="scan'208";a="186208722"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 08:47:03 -0700
IronPort-SDR: FPD2n4C6plbXklYbIuphJWt1mFA6mQggaAkcquAlhYntoTEVSs2uaeGcOfEhh94S70Zd3Gz2fC
 XTWOIuitoLBg==
X-IronPort-AV: E=Sophos;i="5.82,281,1613462400"; 
   d="scan'208";a="465470980"
Received: from uverma1-mobl2.amr.corp.intel.com ([10.209.135.101])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 08:47:01 -0700
Message-ID: <335740e398b96b438153f8e6ea27eaa40a12c324.camel@linux.intel.com>
Subject: Re: [PATCH] ACPI: DPTF: Add battery participant for Intel SoCs
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 07 May 2021 08:46:57 -0700
In-Reply-To: <20210507145819.22608-1-sumeet.r.pawnikar@intel.com>
References: <20210507145819.22608-1-sumeet.r.pawnikar@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2021-05-07 at 20:28 +0530, Sumeet Pawnikar wrote:
> Add ACPI Device ID for DPTF battery participant for the Intel
> Jasper Lake (INT3532) and Tiger Lake (INTC1050) SoC based platforms.
> 

You need to copy to linux-acpi@vger.kernel.org


> Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
> ---
>  drivers/acpi/dptf/int340x_thermal.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/acpi/dptf/int340x_thermal.c
> b/drivers/acpi/dptf/int340x_thermal.c
> index d14025a85ce8..da5d5f0be2f2 100644
> --- a/drivers/acpi/dptf/int340x_thermal.c
> +++ b/drivers/acpi/dptf/int340x_thermal.c
> @@ -24,6 +24,7 @@ static const struct acpi_device_id
> int340x_thermal_device_ids[] = {
>         {"INT3409"},
>         {"INT340A"},
>         {"INT340B"},
> +       {"INT3532"},
>         {"INTC1040"},
>         {"INTC1041"},
>         {"INTC1043"},
> @@ -33,6 +34,7 @@ static const struct acpi_device_id
> int340x_thermal_device_ids[] = {
>         {"INTC1047"},
>         {"INTC1048"},
>         {"INTC1049"},
> +       {"INTC1050"},
>         {"INTC1060"},
>         {"INTC1061"},
>         {""},


