Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B5179E237
	for <lists+linux-pm@lfdr.de>; Wed, 13 Sep 2023 10:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238957AbjIMIfi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Sep 2023 04:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238880AbjIMIfh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Sep 2023 04:35:37 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09CAE73
        for <linux-pm@vger.kernel.org>; Wed, 13 Sep 2023 01:35:33 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9a9d6b98845so153575666b.0
        for <linux-pm@vger.kernel.org>; Wed, 13 Sep 2023 01:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1694594132; x=1695198932; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vzZ6MgD3pf8m+rx1Xv6RC5XGWASwhi1UIBmWgNbxJHM=;
        b=WiqwXqpCw5ZCaEqOwUSFTsfNpCtAmJ/kyuxym9ki+G6ezs+Jz+wxdVawpkPlg43+e8
         cF/OznCHufRkwjpKX5k2zxGz0bqDLbnclKoTBPtKQvIXnU8lekABqWnKjfkEGkxc30Oy
         HkuVqoxSYUo5XOpnE+8IksqyGNrrfmiSHJ8BZFCtTbNRcWeOuDfhwqEnM0k2vnWWbIlR
         kPTTysAppwaHdpmMVKbclk5QX+NYVyBrCupVPxJeN3gFHW0KnAlMERmOW9jylvlFFI7h
         X7UH/zD73yUD5avrjkopjm8Wd/hbazAAhl9D4O/pKXnhtQPCKd0+pTRUjWVEWV46D7Y0
         SeMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694594132; x=1695198932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzZ6MgD3pf8m+rx1Xv6RC5XGWASwhi1UIBmWgNbxJHM=;
        b=gdANC5r5MwHdUb9/OaUQfvTJ83fkFkqclqj+OHp0AcqRphCvgcsraB5vbisRIAjsvT
         DNGMLJQU29ex32DA5TwInG9npW+KPVEF7HWpHeRVzp7wawwoUyNlCegnhW9M6fYFWwcr
         UOpda8psQhj1zxKrGiSg0SZ+2LhzC8TnHryfhjumC4V2+Qo29VPAzxHQqeNZgVRstOSb
         j+wbgZpCMX7VQg4v5xVC4xbazIa1Dht1S9foks6hkl8f9w/QAbSkdGfuYMH0BQWik+f9
         ycu4dPKel0NrZ6CqMMlXzGL9uPUnqRn3QOYQGSebKIgSjZFmHajF/F6KV9H/fyG8nHm4
         fsWQ==
X-Gm-Message-State: AOJu0YybxaNepWueKJy+coU4pdsAXbAq/1H6ldW72HrdLOvdJiCXPO94
        UyE51dOQn4uL0JqYK13zXynv1Q==
X-Google-Smtp-Source: AGHT+IGZ4W6oHcVWa6n5e3HT26skU4k3V7FAnm2BWzLS+1RwRT1pMvQIlK0HWxcVOFIXwB+8acOF1Q==
X-Received: by 2002:a17:906:c112:b0:9a4:11a3:c32b with SMTP id do18-20020a170906c11200b009a411a3c32bmr7346391ejc.29.1694594132177;
        Wed, 13 Sep 2023 01:35:32 -0700 (PDT)
Received: from blmsp ([2001:4091:a246:82a0:6611:d59a:8ba3:9a66])
        by smtp.gmail.com with ESMTPSA id lz5-20020a170906fb0500b0098e78ff1a87sm7990464ejb.120.2023.09.13.01.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 01:35:30 -0700 (PDT)
Date:   Wed, 13 Sep 2023 10:35:29 +0200
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     linux-mediatek@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Golle <daniel@makrotopia.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] thermal/drivers/mediatek: Fix control buffer enablement
 on MT7896
Message-ID: <20230913083529.3bgjl6rvfmixgjnd@blmsp>
References: <20230907112018.52811-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230907112018.52811-1-linux@fw-web.de>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 07, 2023 at 01:20:18PM +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Reading thermal sensor on mt7986 devices returns invalid temperature:
> 
> bpi-r3 ~ # cat /sys/class/thermal/thermal_zone0/temp
>  -274000
> 
> Fix this by adding missing members in mtk_thermal_data struct which were
> used in mtk_thermal_turn_on_buffer after commit 33140e668b10.
> 
> Cc: stable@vger.kernel.org
> Fixes: 33140e668b10 ("thermal/drivers/mediatek: Control buffer enablement tweaks")
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>

Thanks for fixing!

Best,
Markus

> ---
>  drivers/thermal/mediatek/auxadc_thermal.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/thermal/mediatek/auxadc_thermal.c b/drivers/thermal/mediatek/auxadc_thermal.c
> index 843214d30bd8..967b9a1aead4 100644
> --- a/drivers/thermal/mediatek/auxadc_thermal.c
> +++ b/drivers/thermal/mediatek/auxadc_thermal.c
> @@ -690,6 +690,9 @@ static const struct mtk_thermal_data mt7986_thermal_data = {
>  	.adcpnp = mt7986_adcpnp,
>  	.sensor_mux_values = mt7986_mux_values,
>  	.version = MTK_THERMAL_V3,
> +	.apmixed_buffer_ctl_reg = APMIXED_SYS_TS_CON1,
> +	.apmixed_buffer_ctl_mask = GENMASK(31, 6) | BIT(3),
> +	.apmixed_buffer_ctl_set = BIT(0),
>  };
>  
>  static bool mtk_thermal_temp_is_valid(int temp)
> -- 
> 2.34.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
