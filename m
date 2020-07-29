Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CED1232205
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 17:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgG2P4C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 11:56:02 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60826 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgG2P4C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jul 2020 11:56:02 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06TFu00U004597;
        Wed, 29 Jul 2020 10:56:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1596038160;
        bh=dErOzIho34fxvJcb68vhO2ZIVDb37+iIzl5rCrT1rGU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=dAg2f074lHJEzqnf7SuTzPpJnsRcs1+O9lTJgE88Wp/dKdfxLv8sZOQCHD3CRtbp+
         sKJOfC5RVJfCgg2XBspNiTRn1N7sMebq8Zgm5LDtpZ6DLe/sDQ8ezgGyIiiFrxkUFI
         rAGkTJoBx7cp/KsOcO7/XVpB22HIVND6y/aLEzX0=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06TFu03E058504;
        Wed, 29 Jul 2020 10:56:00 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 29
 Jul 2020 10:56:00 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 29 Jul 2020 10:56:00 -0500
Received: from [10.250.35.195] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06TFtxOX006537;
        Wed, 29 Jul 2020 10:55:59 -0500
Subject: Re: [PATCH v5 2/4] power: supply: bq27xxx_battery: Add the BQ27z561
 Battery monitor
To:     <sre@kernel.org>, <afd@ti.com>, <pali@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>
References: <20200729120609.22427-1-dmurphy@ti.com>
 <20200729120609.22427-2-dmurphy@ti.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <a757fcf1-0215-3926-f74c-22183457be3e@ti.com>
Date:   Wed, 29 Jul 2020 10:55:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200729120609.22427-2-dmurphy@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello

On 7/29/20 7:06 AM, Dan Murphy wrote:
> Add the Texas Instruments BQ27z561 battery monitor.  The register address
> map is laid out the same as compared to other devices within the file.
> The battery status register has differing bits to determine if the
> battery is full, discharging or dead.
>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>   drivers/power/supply/bq27xxx_battery.c     | 69 +++++++++++++++++++++-
>   drivers/power/supply/bq27xxx_battery_i2c.c |  2 +
>   include/linux/power/bq27xxx_battery.h      |  1 +
>   3 files changed, 71 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> index acaafed037be..a858e3b2a0ee 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -18,6 +18,7 @@
>    * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
>    *
>    * Datasheets:
> +<<<<<<< HEAD

Need to remove this artifact from a rebase.

Not sure how this got here as it does not appear in my source.

Dan


