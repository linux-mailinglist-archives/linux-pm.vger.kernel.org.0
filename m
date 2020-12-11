Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A28222D79F4
	for <lists+linux-pm@lfdr.de>; Fri, 11 Dec 2020 16:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388722AbgLKPwm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 11 Dec 2020 10:52:42 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41969 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388637AbgLKPwe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Dec 2020 10:52:34 -0500
Received: by mail-wr1-f66.google.com with SMTP id a12so9502291wrv.8;
        Fri, 11 Dec 2020 07:52:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=J7fcE0FENj78WD0WD0FAW2QvhAhKSbHLyC4gTCtkJlw=;
        b=Dnv0/f0W92D/tj1hHIMIlhCVF5erZIEWcz2BDHVkwc6FgcJhejKsI1dYYSvNNMA6TR
         UN0RWihNcxItvlA5Iqfm2ar2yShM3RMbK/JMGk6gImEm5N4Hwj1WrBnHqEX+RpIbNFLc
         IXmcDaOhFzga5VRfYX+mVhgXRPvk/qoSE/5OAekMqDHk0dx50lU/xvjLDU8D+LoyR7En
         VBZswG7Q8WPd7r2k334SfXCaSmIxM8JF/mQWPRy08cimjchRTH/rv2J9pxFkzAGzdRtT
         wFPZetq2b81dfMZIEMaVKLgtOTB78XWD37fTnWhPKWjzpzOf7PA4wxcMXxGydjlt9XSi
         +KwA==
X-Gm-Message-State: AOAM533b1MeAVzeZ4faYynEsTdmriql1g5M/AFBjXfpJDMAfVKoV5dlM
        vFiKNRcaaDXFMMd6P/JV3Bk=
X-Google-Smtp-Source: ABdhPJz7D8U+j4gEfci2HdyqdoNrhC+P/LecmgdYR4fAygHIEvJvMXFU+xo1bWvYdsuq5i6Z4xJvgQ==
X-Received: by 2002:adf:f94b:: with SMTP id q11mr14872438wrr.351.1607701910528;
        Fri, 11 Dec 2020 07:51:50 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id h2sm15998667wme.45.2020.12.11.07.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 07:51:49 -0800 (PST)
Date:   Fri, 11 Dec 2020 16:51:47 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Iskren Chernev <iskren.chernev@gmail.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
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
        linux-rtc@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Angus Ainslie <angus@akkea.ca>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [RFC 18/18] power: supply: max17040: Do not enforce (incorrect)
 interrupt trigger type
Message-ID: <20201211155147.GA9732@kozik-lap>
References: <20201210212534.216197-1-krzk@kernel.org>
 <20201210212534.216197-18-krzk@kernel.org>
 <20201211074755.GA4346@kozik-lap>
 <6f1cd4f0-21a7-ed8c-aafa-ba217c05ea5f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <6f1cd4f0-21a7-ed8c-aafa-ba217c05ea5f@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Dec 11, 2020 at 05:44:26PM +0200, Iskren Chernev wrote:
> 
> On 12/11/20 9:47 AM, Krzysztof Kozlowski wrote:
> > On Thu, Dec 10, 2020 at 10:25:34PM +0100, Krzysztof Kozlowski wrote:
> >> Interrupt line can be configured on different hardware in different way,
> >> even inverted.  Therefore driver should not enforce specific trigger
> >> type - edge falling - but instead rely on Devicetree to configure it.
> >>
> >> The Maxim 14577/77836 datasheets describe the interrupt line as active
> >> low with a requirement of acknowledge from the CPU therefore the edge
> >> falling is not correct.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >>
> >> ---
> >>
> >> This patch should wait till DTS changes are merged, as it relies on
> >> proper Devicetree.
> >> ---
> >> .../devicetree/bindings/power/supply/max17040_battery.txt       | 2 +-
> >> drivers/power/supply/max17040_battery.c                         | 2 +-
> >>  2 files changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git
> a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
> b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
> >> index c802f664b508..194eb9fe574d 100644
> >> --- a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
> >> +++ b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
> >> @@ -39,7 +39,7 @@ Example:
> >>          reg = <0x36>;
> >>          maxim,alert-low-soc-level = <10>;
> >>          interrupt-parent = <&gpio7>;
> >> -        interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
> >> +        interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
> >>          wakeup-source;
> >>      };
> >>
> >> diff --git a/drivers/power/supply/max17040_battery.c
> b/drivers/power/supply/max17040_battery.c
> >> index d956c67d5155..f737de0470de 100644
> >> --- a/drivers/power/supply/max17040_battery.c
> >> +++ b/drivers/power/supply/max17040_battery.c
> >> @@ -367,7 +367,7 @@ static int max17040_enable_alert_irq(struct
> max17040_chip *chip)
> >>
> >>      flags = IRQF_TRIGGER_FALLING | IRQF_ONESHOT;
> >
> > This has to be removed. I will fix it in v2.
> >
> > Best regards,
> > Krzysztof
> 
> I removed the IRQF_TRIGGER_FALLING, tweaked the DT as per the DT patch, and
> it worked on the samsung klte.
> 
> I don't understand how the DT irq flag ends up being used by the kernel. It
> is never explicitly read from DT or passed to interrupt API, only i2c->irq,
> which is a pure int.

The core __setup_irq() calls irqd_get_trigger_type() on IRQ data
matching the IRQ.

Best regards,
Krzysztof
