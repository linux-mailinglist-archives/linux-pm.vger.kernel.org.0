Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2846B408C13
	for <lists+linux-pm@lfdr.de>; Mon, 13 Sep 2021 15:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235901AbhIMNJW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Sep 2021 09:09:22 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:33226
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235976AbhIMNHi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Sep 2021 09:07:38 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9E4C73F091
        for <linux-pm@vger.kernel.org>; Mon, 13 Sep 2021 13:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631538381;
        bh=snqO+zpJPkBw6zZQNVMY27Q3942wUhbd/kP+elYWU54=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=hQTpWxCeeh5J29mXlTU3P8KIYs/Hl90OezAM8s30s93yiVe0+i7uVXmrV0haJHKIz
         niPM2FuT7LZSrdhJMo6v0DdQgB9Ml1Prs9kYI5OUzfZDSLRSDBDGMuEORHr8lv6N2O
         3R9gPnvH1GfUienuOA2ruqI5cl2MHmB55roRg9EQbgl3+tIhbu2lXoeJMXILmTGu12
         P57LI5/Y4uXmHNn/mOIuzZ11zyE7RdESRXlhHbH1yyctQ808PYDt2D/ZlP0zafJCst
         aHQEWex8YA1KxxgmJJCYfNDRNSydTmmcdPPbIR8okYFwHMIu2sJ2ObJvRnE1YjgTmq
         70umV3SuuPwKg==
Received: by mail-wr1-f70.google.com with SMTP id r9-20020a5d4989000000b0015d0fbb8823so2449902wrq.18
        for <linux-pm@vger.kernel.org>; Mon, 13 Sep 2021 06:06:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=snqO+zpJPkBw6zZQNVMY27Q3942wUhbd/kP+elYWU54=;
        b=zFIGxPdhFtDl1sMfUdWi2r8rK9TaTDxiXKEgZbZDTn4CJpc8eIypIVJWIinj2Qh0+1
         OaAL8j37ctj2Yy7WzAatI7vjP7K2LsON2kaVv9Kqlx/Ja0rIBqcJw3/gGhjvA9M0XFWy
         yHOjmDgxwWyP/39s99Q3nWuPoW/ZLoplA/C89EXtEOBSIPRS8L9UPZOImTbro4rdW9DT
         GM+CBltdcoaO2Ykms4daZve2WiS45DcuQEKGQjXrWOL7Ym8n1fl0G/OXZBEz8uohkkgj
         5EjJw92dj++prQ4OxYj4wNf/UBZ2OWXCkRMyiXW+g6rn+y03ArhCf/S/4T9qqEvmV2Vp
         72/A==
X-Gm-Message-State: AOAM532vdlb0I2grssNuhlEOjs/v4JOrvNREEYvRYeQA3jWXeFvnNfZZ
        iaK+4CKeS/T0m1gkw/b0mvOyrraelrSoQRU2UDK00nRD8tfS4aZalPGgtDZTYanf4hia9cQmRkJ
        clGWNgkHqqSa12OU7HS7wpq6XNvMPn1pbm3Oq
X-Received: by 2002:adf:e684:: with SMTP id r4mr5333346wrm.229.1631538381350;
        Mon, 13 Sep 2021 06:06:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZCAKv3LrA50Rb+by2GgKgOyXFwxTRdJSEvJrd5FXZ6CkqcBwZDGtn7VCCfAd3pQp2D81heQ==
X-Received: by 2002:adf:e684:: with SMTP id r4mr5333323wrm.229.1631538381171;
        Mon, 13 Sep 2021 06:06:21 -0700 (PDT)
Received: from [192.168.3.211] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id q19sm2279358wmq.29.2021.09.13.06.05.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 06:06:00 -0700 (PDT)
Subject: Re: [PATCH 2/2] power: supply: max17042_battery: Prevent int
 underflow in set_soc_threshold
To:     Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Anton Vorontsov <anton.vorontsov@linaro.org>,
        Ramakrishna Pallala <ramakrishna.pallala@intel.com>,
        Dirk Brandewie <dirk.brandewie@gmail.com>,
        stable@vger.kernel.org
References: <20210912205402.160939-1-sebastian.krzyszkowiak@puri.sm>
 <20210912205402.160939-2-sebastian.krzyszkowiak@puri.sm>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <82021f13-f535-1535-4af9-80bef81fbde5@canonical.com>
Date:   Mon, 13 Sep 2021 15:05:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210912205402.160939-2-sebastian.krzyszkowiak@puri.sm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/09/2021 22:54, Sebastian Krzyszkowiak wrote:
> Fixes: e5f3872d2044 ("max17042: Add support for signalling change in SOC")

You need commit and bug description.

> Cc: <stable@vger.kernel.org>
> Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
> ---
>  drivers/power/supply/max17042_battery.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
> index c53980c8432a..caf83b4d622f 100644
> --- a/drivers/power/supply/max17042_battery.c
> +++ b/drivers/power/supply/max17042_battery.c
> @@ -857,7 +857,8 @@ static void max17042_set_soc_threshold(struct max17042_chip *chip, u16 off)
>  	regmap_read(map, MAX17042_RepSOC, &soc);
>  	soc >>= 8;
>  	soc_tr = (soc + off) << 8;
> -	soc_tr |= (soc - off);
> +	if (off < soc)
> +		soc_tr |= soc - off;
>  	regmap_write(map, MAX17042_SALRT_Th, soc_tr);
>  }
>  
> 


Best regards,
Krzysztof
