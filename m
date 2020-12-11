Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D472D7926
	for <lists+linux-pm@lfdr.de>; Fri, 11 Dec 2020 16:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437892AbgLKP0B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Dec 2020 10:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437886AbgLKPZx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Dec 2020 10:25:53 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC564C0613CF;
        Fri, 11 Dec 2020 07:25:12 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id 3so8939154wmg.4;
        Fri, 11 Dec 2020 07:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=my0v3tsRd/Mz4EIypIj37zNMuhiMI5SF6h5TpgmxpB4=;
        b=UrzvvXJ0cz0zGNOSqpro4dW33KOVtYPq4hM2Aw+imIHgxrPqJSXTEIZSc8GjmEZ6Cl
         9ikTpG7cWdOnKFpctkZDvJbLYS13DDwDC4/Rar1X/To9YrL4IfK0q+UQpvTv6HklUzIz
         fiRD3G772ooaDOM2lnJ8LdsAT9gF3DcWZMPrwT2b1cZgCG3vpzQiuVs7cX7NrRnjDMEt
         9aPhBfxpqJ/D3DmxnJbBBH+ynO61KPPpZjRx+D99HTic9fG8e5v+KmQMrYNXdATGmArc
         5FgPiAZhUOtPK6xTTWmsB2zrqZnhL9sJL6eVj6cIqgDM4evCIOmvqkgo7neeZK92bIze
         bBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=my0v3tsRd/Mz4EIypIj37zNMuhiMI5SF6h5TpgmxpB4=;
        b=DDtwJ2cwffE70QgpDP7+qBaZQUYfQSzDp2twg587gSMqH9/cah7tftmvxLp96Fhtl4
         9SMiPGApIP3HRqlzrM1wlOBMmZxah4hFu2X1RyRUWQFSmAkpJilbikfo9JXF+50XA7gW
         WW8FBS0VhO/BswrIY74vfSa9D3CMrdm0IuHVGe9/xUMNmMSXK19uAh65meVO1WYsAbG3
         bYoFBLw/T0mQw/8UaAFPGPHET9fetXvAm8OPsaVFwPPhckd+f70/7zV8vvvHAX9oFQLZ
         +pbYEUtmR4HCbViTaVfHl1XKZk/s9OEWvyo4Ar0ecplkq6M6GF8vNldXjdpOwfapFvHs
         3fGw==
X-Gm-Message-State: AOAM531URbv4WN7p0ZHusto26W6O80IlWVcZBY3k6ah3uOTpVYrG1AuF
        2PzWoFRj6dN1IvipPvkMqq8=
X-Google-Smtp-Source: ABdhPJxfnTaSUGMt3qD4TxCyZ9BhVYl6DKFHubfh7itAEtAANKosHG7tXoFwD4N88bBatphcZVq9qw==
X-Received: by 2002:a1c:a344:: with SMTP id m65mr13965395wme.108.1607700311561;
        Fri, 11 Dec 2020 07:25:11 -0800 (PST)
Received: from [192.168.74.106] (178-169-161-196.razgrad.ddns.bulsat.com. [178.169.161.196])
        by smtp.gmail.com with ESMTPSA id b14sm15403083wrx.77.2020.12.11.07.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Dec 2020 07:25:10 -0800 (PST)
Subject: Re: [PATCH 12/18] ARM: dts: qcom: msm8974-samsung-klte: correct fuel
 gauge interrupt trigger level
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-rtc@vger.kernel.org
Cc:     Matheus Castello <matheus@castello.eng.br>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Angus Ainslie <angus@akkea.ca>,
        Hans de Goede <hdegoede@redhat.com>
References: <20201210212534.216197-1-krzk@kernel.org>
 <20201210212534.216197-12-krzk@kernel.org>
From:   Iskren Chernev <iskren.chernev@gmail.com>
Message-ID: <9a896342-cc0b-5cdf-aefd-6fe13c540c69@gmail.com>
Date:   Fri, 11 Dec 2020 17:25:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201210212534.216197-12-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 12/10/20 11:25 PM, Krzysztof Kozlowski wrote:
 > The Maxim fuel gauge datasheets describe the interrupt line as active
 > low with a requirement of acknowledge from the CPU.  The falling edge
 > interrupt will mostly work but it's not correct.
 >
 > Fixes: da8d46992e67 ("ARM: dts: qcom: msm8974-klte: Add fuel gauge")
 > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
 > ---
 >  arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts | 2 +-
 >  1 file changed, 1 insertion(+), 1 deletion(-)
 >
 > diff --git a/arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts 
b/arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts
 > index 97352de91314..64a3fdb79539 100644
 > --- a/arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts
 > +++ b/arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts
 > @@ -691,7 +691,7 @@ fuelgauge@36 {
 >              maxim,rcomp = /bits/ 8 <0x56>;
 >
 >              interrupt-parent = <&pma8084_gpios>;
 > -            interrupts = <21 IRQ_TYPE_EDGE_FALLING>;
 > +            interrupts = <21 IRQ_TYPE_LEVEL_LOW>;
 >
 >              pinctrl-names = "default";
 >              pinctrl-0 = <&fuelgauge_pin>;

After testing this patch + the rfc modifying 17040 driver I can confirm it
works on the klte. Also, according to the max17048 datasheet, the ALRT pin
is active low, so everything is in order.

Acked-By: Iskren Chernev <iskren.chernev@gmail.com>
Tested-By: Iskren Chernev <iskren.chernev@gmail.com>

