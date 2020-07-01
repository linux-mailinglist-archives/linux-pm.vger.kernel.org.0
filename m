Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FACF2110DC
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jul 2020 18:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732378AbgGAQjn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 12:39:43 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:32958 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732255AbgGAQjm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2020 12:39:42 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 061GddNU031024;
        Wed, 1 Jul 2020 11:39:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593621579;
        bh=xbBcjsRuj6VdBiPscvdL+9rTLp0gEqf+2hxn3Z6d4tU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ePYUg6XTP+wPLfdwmIh9352+UIumOXtAnllySUpF0m2zqpdhwJFoFI33pQtH5ncpt
         8UB0DQSuAkJD+7vmhaH8JOSzBBY1Z6EklyEgSoRbT/zipSRwldcV1QVcfI+G3L/hC4
         qmLnj87An9WR1Y4+GzLy0MtZG486N1D4wOxDv1aE=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 061GddhM095151
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 1 Jul 2020 11:39:39 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 1 Jul
 2020 11:39:39 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 1 Jul 2020 11:39:39 -0500
Received: from [10.250.52.63] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 061GddEm060242;
        Wed, 1 Jul 2020 11:39:39 -0500
Subject: Re: [PATCH v14 1/4] power_supply: Add additional health properties to
 the header
To:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>, <sre@kernel.org>,
        <pali@kernel.org>, <robh@kernel.org>
CC:     <afd@ti.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <sspatil@android.com>, Guru Das Srinagesh <gurus@codeaurora.org>
References: <20200630215426.26450-1-r-rivera-matos@ti.com>
 <20200630215426.26450-2-r-rivera-matos@ti.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <938bd51f-0551-38f0-c17c-19c7b42ec411@ti.com>
Date:   Wed, 1 Jul 2020 11:39:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200630215426.26450-2-r-rivera-matos@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sebastian

On 6/30/20 4:54 PM, Ricardo Rivera-Matos wrote:
> From: Dan Murphy <dmurphy@ti.com>
>
> Add HEALTH_WARM, HEALTH_COOL and HEALTH_HOT to the health enum.
>
> HEALTH_WARM, HEALTH_COOL, and HEALTH_HOT properties are taken
> from JEITA specification JISC8712:2015
>
> Acked-by: Andrew F. Davis <afd@ti.com>
> Tested-by: Guru Das Srinagesh <gurus@codeaurora.org>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>   Documentation/ABI/testing/sysfs-class-power | 3 ++-
>   drivers/power/supply/power_supply_sysfs.c   | 3 +++
>   include/linux/power_supply.h                | 3 +++
>   3 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> index 216d61a22f1e..40213c73bc9c 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -205,7 +205,8 @@ Description:
>   		Valid values: "Unknown", "Good", "Overheat", "Dead",
>   			      "Over voltage", "Unspecified failure", "Cold",
>   			      "Watchdog timer expire", "Safety timer expire",
> -			      "Over current", "Calibration required"
> +			      "Over current", "Calibration required", "Warm",
> +			      "Cool", "Hot"
>   
>   What:		/sys/class/power_supply/<supply_name>/precharge_current
>   Date:		June 2017
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index bc79560229b5..4d6e1d5015d6 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -101,6 +101,9 @@ static const char * const POWER_SUPPLY_HEALTH_TEXT[] = {
>   	[POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE]   = "Safety timer expire",
>   	[POWER_SUPPLY_HEALTH_OVERCURRENT]	    = "Over current",
>   	[POWER_SUPPLY_HEALTH_CALIBRATION_REQUIRED]  = "Calibration required",
> +	[POWER_SUPPLY_HEALTH_WARM]		    = "Warm",
> +	[POWER_SUPPLY_HEALTH_COOL]		    = "Cool",
> +	[POWER_SUPPLY_HEALTH_HOT]		    = "Hot",
>   };
>   
>   static const char * const POWER_SUPPLY_TECHNOLOGY_TEXT[] = {
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index ac1345a48ad0..b5ee35d3c304 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -62,6 +62,9 @@ enum {
>   	POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE,
>   	POWER_SUPPLY_HEALTH_OVERCURRENT,
>   	POWER_SUPPLY_HEALTH_CALIBRATION_REQUIRED,
> +	POWER_SUPPLY_HEALTH_WARM,
> +	POWER_SUPPLY_HEALTH_COOL,
> +	POWER_SUPPLY_HEALTH_HOT,
>   };
>   
>   enum {


Can you apply this patch?

We have other charger drivers we want to submit for review but they all 
depend on this single patch.

If you do not want to apply this patch then please let us know how we 
can submit our other drivers so that build bots don't start spamming us 
with build failures

Dan

