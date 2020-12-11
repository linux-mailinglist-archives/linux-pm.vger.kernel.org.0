Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38372D79C7
	for <lists+linux-pm@lfdr.de>; Fri, 11 Dec 2020 16:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404258AbgLKPpq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Dec 2020 10:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392880AbgLKPpR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Dec 2020 10:45:17 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD73FC0613D3;
        Fri, 11 Dec 2020 07:44:36 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id d3so7921165wmb.4;
        Fri, 11 Dec 2020 07:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=v5cXYQILfnMHNvpFqTQn3B13Z49i+J1ZD2Gy+OjLwW0=;
        b=cBW7dYnRqr2KiZlAo7TrB5HR0S1Biw2Aati+xIgnpHfN3F29hnkY7O+vloGkLR3Uo1
         9ss+gy9oqE2PKLgf4e+UF9KtFVNmb5/mANcxBtPBS8GneKu7/A5zTtORSL6BADFg8uyD
         3MB7PtSDerWhoEOTpcIYiDuVAxa8hoXiQDb3L0gM1oJsvGfWtExSsrNalhyRzW6iJAaH
         UXyyNG7HdAoqfiAiyHWS4ASpxEql9FTMG9dOr8+QlA96P7pZlNisf8uTDPeeZ/ik2bWW
         WEcZAhp7sLWM5zh+uB/uB20IgYqX5Y4o81HeCazA8yxtrfeXGFH5QCZpqzVX39f2Cq0H
         br1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=v5cXYQILfnMHNvpFqTQn3B13Z49i+J1ZD2Gy+OjLwW0=;
        b=latfkfGDo0chUuHRYHzFRvXf3BMZssDv+i+65frUfWAm1dN9AcS3mCLW79pjPW58kP
         0g3J3gR1iS8aNrELmqSV43MpXilL8eanhfAtn8aqlDGSNrzz7xLl2gtrXZjqb/0wMi9z
         BhbbEWbVjKhnENkHSBY2vdRe52qbe5NwlXUPHSymInoBNajq4mLMeo1Ce2Tg4rRUgGBH
         2IiMwS0pdFePuop6dTEYSNCyEGLNCicPk8Hkd3O7cellG7tAcfTFmYo9MbB4cvic0ZzT
         puvk6IcHwJu8oiFxZjytixupN0ZDOydGCnOQS+2k2K7qVoF21hNfF8dT6x/7KTFc2pIA
         RhjQ==
X-Gm-Message-State: AOAM531GwyIgYhDTZjQnjug0JqtDt6I5DamLlpwvsPsR/G5W/6RCFT+8
        zPsPeuI07RsZZFqTs28OFVo=
X-Google-Smtp-Source: ABdhPJylueTC7ej3OslEg3zXXg2wVzPO9AwSCsWBO68ammTS0LUxWj1xDM+NBqsZhD3mTRjcAE99dA==
X-Received: by 2002:a1c:8115:: with SMTP id c21mr14186830wmd.1.1607701475497;
        Fri, 11 Dec 2020 07:44:35 -0800 (PST)
Received: from [192.168.74.106] (178-169-161-196.razgrad.ddns.bulsat.com. [178.169.161.196])
        by smtp.gmail.com with ESMTPSA id r13sm14955470wrs.6.2020.12.11.07.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Dec 2020 07:44:34 -0800 (PST)
Subject: Re: [RFC 18/18] power: supply: max17040: Do not enforce (incorrect)
 interrupt trigger type
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
 <20201210212534.216197-18-krzk@kernel.org> <20201211074755.GA4346@kozik-lap>
From:   Iskren Chernev <iskren.chernev@gmail.com>
Message-ID: <6f1cd4f0-21a7-ed8c-aafa-ba217c05ea5f@gmail.com>
Date:   Fri, 11 Dec 2020 17:44:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201211074755.GA4346@kozik-lap>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 12/11/20 9:47 AM, Krzysztof Kozlowski wrote:
 > On Thu, Dec 10, 2020 at 10:25:34PM +0100, Krzysztof Kozlowski wrote:
 >> Interrupt line can be configured on different hardware in different way,
 >> even inverted.  Therefore driver should not enforce specific trigger
 >> type - edge falling - but instead rely on Devicetree to configure it.
 >>
 >> The Maxim 14577/77836 datasheets describe the interrupt line as active
 >> low with a requirement of acknowledge from the CPU therefore the edge
 >> falling is not correct.
 >>
 >> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
 >>
 >> ---
 >>
 >> This patch should wait till DTS changes are merged, as it relies on
 >> proper Devicetree.
 >> ---
 >> .../devicetree/bindings/power/supply/max17040_battery.txt       | 2 +-
 >> drivers/power/supply/max17040_battery.c                         | 2 +-
 >>  2 files changed, 2 insertions(+), 2 deletions(-)
 >>
 >> diff --git 
a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt 
b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
 >> index c802f664b508..194eb9fe574d 100644
 >> --- 
a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
 >> +++ 
b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
 >> @@ -39,7 +39,7 @@ Example:
 >>          reg = <0x36>;
 >>          maxim,alert-low-soc-level = <10>;
 >>          interrupt-parent = <&gpio7>;
 >> -        interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
 >> +        interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 >>          wakeup-source;
 >>      };
 >>
 >> diff --git a/drivers/power/supply/max17040_battery.c 
b/drivers/power/supply/max17040_battery.c
 >> index d956c67d5155..f737de0470de 100644
 >> --- a/drivers/power/supply/max17040_battery.c
 >> +++ b/drivers/power/supply/max17040_battery.c
 >> @@ -367,7 +367,7 @@ static int max17040_enable_alert_irq(struct 
max17040_chip *chip)
 >>
 >>      flags = IRQF_TRIGGER_FALLING | IRQF_ONESHOT;
 >
 > This has to be removed. I will fix it in v2.
 >
 > Best regards,
 > Krzysztof

I removed the IRQF_TRIGGER_FALLING, tweaked the DT as per the DT patch, and
it worked on the samsung klte.

I don't understand how the DT irq flag ends up being used by the kernel. It
is never explicitly read from DT or passed to interrupt API, only i2c->irq,
which is a pure int.

Fixing the DT and the drivers will hopefully set a precedent, so future
drivers (when copied/tweaked from existing drivers) will do it right.

Acked-by: Iskren Chernev <iskren.chernev@gmail.com>

 >>      ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
 >> -                    max17040_thread_handler, flags,
 >> +                    max17040_thread_handler, IRQF_ONESHOT,
 >>                      chip->battery->desc->name, chip);
 >>
 >>      return ret;
 >> --
 >> 2.25.1
 >>

