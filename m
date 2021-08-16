Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F093ED077
	for <lists+linux-pm@lfdr.de>; Mon, 16 Aug 2021 10:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbhHPImj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Aug 2021 04:42:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55698 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234951AbhHPImi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Aug 2021 04:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629103326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4EFm6gVEreXk1Z8T6prMck0p8oHnL3WE32KdZ7f5jjo=;
        b=iAZlansawZhGxrKKSUi/mwiUYfR97NX8oBPGjeX02ja+7hRdBtNPxunBw+GPlgQDVBy6i0
        G4hILlUUIAoISRGAbgqgWuE/r1hDZ/c/kGJPc2KMMlTjarWAT8iy055VhM/L739LPWAi+8
        jHCjOezrUzXMIr57/CaJfJaLV22i5JA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-MDa8wu4JPyeRCGcfu6uudQ-1; Mon, 16 Aug 2021 04:42:03 -0400
X-MC-Unique: MDa8wu4JPyeRCGcfu6uudQ-1
Received: by mail-ej1-f70.google.com with SMTP id j10-20020a17090686cab02905b86933b59dso3927063ejy.18
        for <linux-pm@vger.kernel.org>; Mon, 16 Aug 2021 01:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4EFm6gVEreXk1Z8T6prMck0p8oHnL3WE32KdZ7f5jjo=;
        b=q6/PBMSjKCPV5kTa89rLw09ZEcYLAgPgK82xEl7gQZlGQtGoYM7PcN/sc9RWnj5NlI
         V707/WNDyMLXGd9n9FslF1aqo3SBV/Sitk0yBuvqDJi9xnzOebGBgQfooZQeakJe1vJ2
         zBuaR+7LOFXTI8bqv86Vfe8GhVPLOtzdv+NqgSf4JT+0+z0v23eZVyoRPIymTjEdvVmD
         71QPo7Byyvs7R74VLVaBsxWhkwnikqLZTiv39s1/mQwaS8ryfqOnjGRSneazp41LAjk2
         ANzGYaPSy2SsoTOfHhc7uDPCP5bhd/7Co973DfFzEzR0SzWfFbGOgWypNCq854ndOqMR
         KUqA==
X-Gm-Message-State: AOAM5300PLLgqePe9uHN+aZby/FchlppB2MNGz0G19XM062Bt9kW1uEt
        QhSGDh4PK/VAeMpsNLkRpu/lcB5CliiFHeSYeQA3qsYXcZU9msYWe8EYq45qV8etRvH7JfB6/dd
        mBLuvttGjPOoexjHxhIQ=
X-Received: by 2002:a17:907:6089:: with SMTP id ht9mr14319196ejc.422.1629103322109;
        Mon, 16 Aug 2021 01:42:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhMOzUyKSIFJf2ZL/Rg4zpaV6lNxzUjZedt8/SufJLv342AisfKH/2GBGZYRWCOz9DFVAUbQ==
X-Received: by 2002:a17:907:6089:: with SMTP id ht9mr14319179ejc.422.1629103321911;
        Mon, 16 Aug 2021 01:42:01 -0700 (PDT)
Received: from x1.localdomain ([81.30.35.201])
        by smtp.gmail.com with ESMTPSA id d22sm3453388ejj.47.2021.08.16.01.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 01:42:01 -0700 (PDT)
Subject: Re: [PATCH 1/3] power: supply: max17042: handle fails of reading
 status register
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        stable@vger.kernel.org
References: <20210816082716.21193-1-krzysztof.kozlowski@canonical.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <820c80fa-c412-dd71-62a4-0ba1e1a97820@redhat.com>
Date:   Mon, 16 Aug 2021 10:42:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210816082716.21193-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 8/16/21 10:27 AM, Krzysztof Kozlowski wrote:
> Reading status register can fail in the interrupt handler.  In such
> case, the regmap_read() will not store anything useful under passed
> 'val' variable and random stack value will be used to determine type of
> interrupt.
> 
> Handle the regmap_read() failure to avoid handling interrupt type and
> triggering changed power supply event based on random stack value.
> 
> Fixes: 39e7213edc4f ("max17042_battery: Support regmap to access device's registers")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Thanks, the entire series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

For the series.

Regards,

Hans

> ---
>  drivers/power/supply/max17042_battery.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
> index ce2041b30a06..858ae97600d4 100644
> --- a/drivers/power/supply/max17042_battery.c
> +++ b/drivers/power/supply/max17042_battery.c
> @@ -869,8 +869,12 @@ static irqreturn_t max17042_thread_handler(int id, void *dev)
>  {
>  	struct max17042_chip *chip = dev;
>  	u32 val;
> +	int ret;
> +
> +	ret = regmap_read(chip->regmap, MAX17042_STATUS, &val);
> +	if (ret)
> +		return IRQ_HANDLED;
>  
> -	regmap_read(chip->regmap, MAX17042_STATUS, &val);
>  	if ((val & STATUS_INTR_SOCMIN_BIT) ||
>  		(val & STATUS_INTR_SOCMAX_BIT)) {
>  		dev_info(&chip->client->dev, "SOC threshold INTR\n");
> 

