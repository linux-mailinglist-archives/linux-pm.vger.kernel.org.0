Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551F94212A6
	for <lists+linux-pm@lfdr.de>; Mon,  4 Oct 2021 17:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbhJDPaO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Oct 2021 11:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbhJDPaO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Oct 2021 11:30:14 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43462C061745;
        Mon,  4 Oct 2021 08:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=s7NZ7E3PI4Zsi+Hk9Jgv2Mz0SRxrTaSZ+M7CVvLomVU=; b=It0zxgyKd+0NBpQv4BLdI65mV1
        2Gs5Jz/qiIVNKX3J2SQTIMLdOiYY4t5FtfW/v49IexG2s7Rea+jK39G2FTn8VtYW985N21W8odFQ+
        1dTWWBb7uBmH88jPcHf+W8zj3SgQ/JmKP8C7z5w4N1u6iAXBfmx4gIhG35sIkILIkVFBEn4o9IQNN
        TF/zocH396jjjvrE39l3dQN6t0y83liFwQrXg4q6fFtD+X9gIxv/bEPOmmKi96qwXy0rIKQHekPEd
        j2IdoydVOYOSrAruB4luX0isKTRx/iOxvDNr347Ol5Rwyi3p7zRtc5PT7/0ZfHuipzJQ/JPJCXQaw
        YFFMs4oA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXPtA-006u0w-4p; Mon, 04 Oct 2021 15:28:24 +0000
Subject: Re: [PATCH 2/2] power: supply: max77976: add Maxim MAX77976 charger
 driver
To:     Luca Ceresoli <luca@lucaceresoli.net>, linux-pm@vger.kernel.org
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211004130732.950512-1-luca@lucaceresoli.net>
 <20211004130732.950512-2-luca@lucaceresoli.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a6ea9a21-e9df-b596-eb80-4df4b8d8115e@infradead.org>
Date:   Mon, 4 Oct 2021 08:28:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211004130732.950512-2-luca@lucaceresoli.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/4/21 6:07 AM, Luca Ceresoli wrote:
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index ad93b3550d6d..622d690c883a 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -557,6 +557,17 @@ config CHARGER_MAX77693
>   	help
>   	  Say Y to enable support for the Maxim MAX77693 battery charger.
>   
> +config CHARGER_MAX77976
> +	tristate "Maxim MAX77976 battery charger driver"
> +	depends on REGMAP_I2C
> +	help
> +	  The Maxim MAX77976 is a 19 Vin, 5.5A 1-Cell Li+ Battery Charger
> +	  USB OTG support. It has an I2C interface for configuration.
> +
> +	  Say Y to enable support for the Maxim MAX77976 battery charger.
> +	  This driver can also be built as a module. If so, the module will be
> +	  called max77976_charger.

REGMAP_I2C is not a user-settable config option, so drivers should not
"depend on" it. This should be more like:

	depends on I2C
	select REGMAP_I2C

-- 
~Randy
