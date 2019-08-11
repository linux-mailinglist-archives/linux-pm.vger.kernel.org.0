Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4F2A89261
	for <lists+linux-pm@lfdr.de>; Sun, 11 Aug 2019 17:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfHKPoC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Aug 2019 11:44:02 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36918 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfHKPoB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Aug 2019 11:44:01 -0400
Received: by mail-ot1-f68.google.com with SMTP id f17so15185008otq.4;
        Sun, 11 Aug 2019 08:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RgzDUY8iEdtjWOC/UcjlQu0YWYk/dEALxCJaSLPEEOM=;
        b=o+O/hv48sg3cHwHlW8B8v0viNUMFEX8D2CGWAPNzX9pjzuu/6K7dFO7SSRtt2y1bhV
         7jKQAk4MWx9nG/yoH+SE4caHw/uu9/DzLJy6fjcx0ZiKYbC7E8bWqkIeJPYHSsW5MvOK
         H298XXnhhFWqJ7Ywh1i6i7IaPm9io3SWKnbkSZUCJJiqcjHs9Iwn9wDdqsSnnR5u18Us
         yPwcZGmvwNxzPEDgvOKruL+EDjUeODouMUmA1RobQOVJwCfPqIvEr75T3kD7DKSAth42
         15cgsvRSL3VL1Y4NJI/ChaSumrxgEUXqmeRtgj1yrY4E4Ogo3XWGopCuM3sC623wBrEx
         xGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RgzDUY8iEdtjWOC/UcjlQu0YWYk/dEALxCJaSLPEEOM=;
        b=JOVYdsw7FVYaZpEMp5ldSWLRnmxAAXKAV48AF0by/RpYBpWt3hNlCAPlGZ0RzBJnEc
         yT0UrFzQV7TCiT44PyQYjOU44LXUTho/r05IVkXyJcjrSFj5MjWfwtvrihPNRdLTOsVD
         rFumdqFScDGgJBgvKcK4lFN4Wp0cjxFPSgh0fSbbOG5OCncwK0EH/oAYg1izYvO+8iip
         ZppkOcKmzizWB0CKtk8+8T7BULfwRxXVV4oxdZ0RDrDhlkMb043mPSr1oCECGLAlJPiX
         iwU0ed8D+2P+/trBJcbBIYdgqvdunlcOp0WDzwL0bWVLNp3nMq9X1sIsRBDNzdfxGuyo
         nfWQ==
X-Gm-Message-State: APjAAAXk6gazu/BsZoAeCuGlxPc1mjGU+BWnRid6nDV6SsqIn5u2qs32
        1W3VrlWFDt3ThMdtGOQVUQ97H7OIH8+Yo/hkX8hl/DVo
X-Google-Smtp-Source: APXvYqxWNrdwhdZjUN0E+QG+e/rP9vdmU9vDHg66HyoGvwKrC0kqPidAohwxJoPiEC9Es5jTZv3FayaUbUh8NtS3QYo=
X-Received: by 2002:a05:6830:1e5a:: with SMTP id e26mr11850575otj.96.1565538240642;
 Sun, 11 Aug 2019 08:44:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190806130506.8753-1-glaroque@baylibre.com> <20190806130506.8753-3-glaroque@baylibre.com>
In-Reply-To: <20190806130506.8753-3-glaroque@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 11 Aug 2019 17:43:49 +0200
Message-ID: <CAFBinCAMjtWTAvVEhMxDx1NPvCp9dU8HewxBxxp1TAtr3ZbKtw@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] thermal: amlogic: Add thermal driver to support
 G12 SoCs
To:     Guillaume La Roque <glaroque@baylibre.com>
Cc:     daniel.lezcano@linaro.org, khilman@baylibre.com,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Guillaume,

[...]
> +struct amlogic_thermal {
> +       struct platform_device *pdev;
> +       const struct amlogic_thermal_data *data;
> +       struct regmap *regmap;
> +       struct regmap *sec_ao_map;
> +       struct clk *clk;
> +       struct thermal_zone_device *tzd;
> +       u32 trim_info;
> +       void __iomem *base;
nit-pick: this is only used in _probe() so you could make it a local
variable there

[...]
> +static const struct of_device_id of_amlogic_thermal_match[] = {
> +       {
> +               .compatible = "amlogic,g12-ddr-thermal",
> +               .data = &amlogic_thermal_g12_ddr_param,
> +       },
> +       {
> +               .compatible = "amlogic,g12-cpu-thermal",
> +               .data = &amlogic_thermal_g12_cpu_param,
> +       },
I assume you are using "g12" to indicate that it's valid for both,
G12A and G12B?
meson-g12-common.dtsi currently does not use any other "amlogic,g12-*"
compatible string (there are some meson-axg-*, meson-gx-* and
meson-g12a-* ones, but no g12-*)
I would like to hear Kevin's and Neil's opinion on this one whether we
should introduce that "amlogic,g12-*" prefix or stick to
"amlogic,g12a-*"

[...]
> +       ret = amlogic_thermal_enable(pdata);
> +       if (ret)
> +               clk_disable_unprepare(pdata->clk);
amlogic_thermal_enable only returns an error-code if clk_prepare_enable() fails
in that case the clock is neither prepared nor enabled so we must not
call clk_disable_unprepare

apart from that it looks good to me (as someone who doesn't know the
thermal framework)


Martin
