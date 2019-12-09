Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 292221178D8
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 22:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfLIVvC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 16:51:02 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:55408 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfLIVu7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Dec 2019 16:50:59 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB9Low0i005349;
        Mon, 9 Dec 2019 15:50:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575928258;
        bh=lUSdxRhD6XTC7WhbY0PYaGuAAuVAsloAEADwb1YGU8w=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=YG2txRg5aS6wPIGElxOMo+yKk+nel+Uqz2sJ8oERHhEWqhkRKE/hnhpvgdUvLlnNj
         s3MeHF+KKqrQo0qRVK0N5meBLuDmfmZD3/4XO9D1z5Xru3pnLl5hcxXKQs4UvHtXC6
         8pnvXC2ZBMH8TlY2rMwUiZStmlA18Vfx3rgP80RI=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB9Low3I114613;
        Mon, 9 Dec 2019 15:50:58 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 9 Dec
 2019 15:50:57 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 9 Dec 2019 15:50:57 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB9LovU2107056;
        Mon, 9 Dec 2019 15:50:57 -0600
Subject: Re: [PATCH v2 1/3] power_supply: Add additional health properties to
 the header
To:     <sre@kernel.org>, <linux-pm@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>
References: <20191029200201.24483-1-dmurphy@ti.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <b1a00b89-b091-4526-fbd4-d42261f0d287@ti.com>
Date:   Mon, 9 Dec 2019 15:48:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191029200201.24483-1-dmurphy@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Bump

On 10/29/19 3:01 PM, Dan Murphy wrote:
> Add HEALTH_WARM, HEALTH_COOL and HEALTH_HOT to the health enum.
>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>
> v2 - No changes
>
>   include/linux/power_supply.h | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 28413f737e7d..bd0d3225f245 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -61,6 +61,9 @@ enum {
>   	POWER_SUPPLY_HEALTH_WATCHDOG_TIMER_EXPIRE,
>   	POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE,
>   	POWER_SUPPLY_HEALTH_OVERCURRENT,
> +	POWER_SUPPLY_HEALTH_WARM,
> +	POWER_SUPPLY_HEALTH_COOL,
> +	POWER_SUPPLY_HEALTH_HOT,
>   };
>   
>   enum {
