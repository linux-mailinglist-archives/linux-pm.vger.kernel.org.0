Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B39F422796
	for <lists+linux-pm@lfdr.de>; Tue,  5 Oct 2021 15:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbhJENRb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Oct 2021 09:17:31 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:40403 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234919AbhJENRb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Oct 2021 09:17:31 -0400
Received: from [185.56.157.72] (port=34808 helo=[192.168.101.73])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1mXkIF-00GPVT-64; Tue, 05 Oct 2021 15:15:39 +0200
Subject: Re: [PATCH 2/2] power: supply: max77976: add Maxim MAX77976 charger
 driver
To:     Randy Dunlap <rdunlap@infradead.org>, linux-pm@vger.kernel.org
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211004130732.950512-1-luca@lucaceresoli.net>
 <20211004130732.950512-2-luca@lucaceresoli.net>
 <a6ea9a21-e9df-b596-eb80-4df4b8d8115e@infradead.org>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <cce10251-c092-c06b-dbc4-d257bb7aa305@lucaceresoli.net>
Date:   Tue, 5 Oct 2021 15:15:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <a6ea9a21-e9df-b596-eb80-4df4b8d8115e@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Randy,

On 04/10/21 17:28, Randy Dunlap wrote:
> On 10/4/21 6:07 AM, Luca Ceresoli wrote:
>> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
>> index ad93b3550d6d..622d690c883a 100644
>> --- a/drivers/power/supply/Kconfig
>> +++ b/drivers/power/supply/Kconfig
>> @@ -557,6 +557,17 @@ config CHARGER_MAX77693
>>       help
>>         Say Y to enable support for the Maxim MAX77693 battery charger.
>>   +config CHARGER_MAX77976
>> +    tristate "Maxim MAX77976 battery charger driver"
>> +    depends on REGMAP_I2C
>> +    help
>> +      The Maxim MAX77976 is a 19 Vin, 5.5A 1-Cell Li+ Battery Charger
>> +      USB OTG support. It has an I2C interface for configuration.
>> +
>> +      Say Y to enable support for the Maxim MAX77976 battery charger.
>> +      This driver can also be built as a module. If so, the module
>> will be
>> +      called max77976_charger.
> 
> REGMAP_I2C is not a user-settable config option, so drivers should not
> "depend on" it. This should be more like:
> 
>     depends on I2C
>     select REGMAP_I2C

Ouch, thanks for spotting, will fix in v2.

-- 
Luca
