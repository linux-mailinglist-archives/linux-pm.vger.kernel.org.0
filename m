Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8556283D58
	for <lists+linux-pm@lfdr.de>; Mon,  5 Oct 2020 19:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgJERdS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Oct 2020 13:33:18 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53196 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbgJERdS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Oct 2020 13:33:18 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 095HXFUn041529;
        Mon, 5 Oct 2020 12:33:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601919195;
        bh=6ETL33FBIngVUOzEHYnY66O2QOkqaMTE7Ld41zHA9VM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=d47Zo6Ofqi2KI9vdg/kNBJGF16iMi1jSlRw5VI9eXWwZZWMtQJ0dz5GxRagZsqFd4
         8A6AO7Hx86K+9R8OoMg6/mDs/RpYr/GzQ/mQ0kQWA6v4HXOMXLVpUu1a9GqlM0IzaR
         dmJ1Q9f5Qq5iv3gxdTa8hwN68SW4ABDZpoZ2E1N0=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 095HXF8d024532
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Oct 2020 12:33:15 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 5 Oct
 2020 12:33:14 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 5 Oct 2020 12:33:14 -0500
Received: from [10.250.79.43] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 095HXEmo008422;
        Mon, 5 Oct 2020 12:33:14 -0500
Subject: Re: [EXTERNAL] Re: [PATCH v5 2/2] power: supply: bq256xx: Introduce
 the BQ256XX charger driver
To:     Sebastian Reichel <sre@kernel.org>
CC:     <robh+dt@kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmurphy@ti.com>
References: <20201001214034.5925-1-r-rivera-matos@ti.com>
 <20201001214034.5925-3-r-rivera-matos@ti.com>
 <20201003105448.eqeyfpr7dugsp4in@earth.universe>
From:   Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Message-ID: <8ff0ba7b-d310-f7e3-bfcb-3bb2079344d2@ti.com>
Date:   Mon, 5 Oct 2020 12:33:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201003105448.eqeyfpr7dugsp4in@earth.universe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sebastian,

On 10/3/20 5:54 AM, Sebastian Reichel wrote:
> Hi Ricardo,
>
> On Thu, Oct 01, 2020 at 04:40:34PM -0500, Ricardo Rivera-Matos wrote:
>> The BQ256XX family of devices are highly integrated buck chargers
>> for single cell batteries.
>>
>> Signed-off-by: Ricardo Rivera-Matos <r-rivera-matos@ti.com>
>>
>> v5 - adds power_supply_put_battery_info() and devm_add_action_or_reset() calls
>> ---
> changes look good, but you are still missing
> usb_unregister_notifier() calls on drival removal.
ACK, I will add a driver removal function and make the appropriate 
usb_unregister_notifier() calls.
>
> -- Sebastian
Ricardo

