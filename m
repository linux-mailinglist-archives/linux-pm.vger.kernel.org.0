Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D895181F22
	for <lists+linux-pm@lfdr.de>; Wed, 11 Mar 2020 18:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730486AbgCKRVB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Mar 2020 13:21:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36505 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730211AbgCKRVB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Mar 2020 13:21:01 -0400
Received: by mail-wm1-f66.google.com with SMTP id g62so3044387wme.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2020 10:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SRfkpp8M+7DY995ACFm0LV6S5x+iBdswbTCPLyuUHNI=;
        b=gOSVv67gnHdiMys+M2xzhT5wvai2z320rCOPgcpkhbLpV97jJhkGTuNoAzU4NUZhAo
         D4palYQ2HwAZ0OS3zCphC/Z0UmVcpqQChJKRV5WtqbpmM2Kk7ou5Arh8pFC1dF14OA91
         YvbixzwQXk0u70G8Vh3zfpM+OulqR1vgcCxX7taDdz9nUBV0g31sMZ8Zdkh6mRxlcsTs
         k7ViITXmIF2ThUhrJgslCTsg0VI0hsyFU4EZ42e60p4lK9bRT13xdjNMu02BkpZZYGSu
         25CT18gafLV+OXQYAtWsVnW1Dg750/te3dKsDP4gIz5GRrHCxF6Gkn1WB+iu3pXgLxlZ
         kF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SRfkpp8M+7DY995ACFm0LV6S5x+iBdswbTCPLyuUHNI=;
        b=lI9SNDL1Mxly+P9rq+aVaSZw46s2y7R8aqxx+iTG+1AK0td0yFp2cUvszgX/Zj5MWZ
         06FSi5CilXXHfCzacqwjlUB1clZDdezyBiwjHbe4r+iKFeH9BuIBMvRKTAj0Av+gN5Ye
         MwD8yw307TYr6mvwgljDuR2fXAVzMEbSTSet4pwlNFqsZBrUezKeTulnj7kSooxK3tCG
         XKAKo64W2PFrBxQAujb1Wd5LokutNtnS2EJR4uBCr4C+0r8HrTHvz6vYC3V3D4E5LSEe
         id4NAHhE6QhcQXZsfpRSzqBTbRD0DRWtCrm1KL75ZeawxMzy7QXVMZ5HJOhwiAjSasrp
         m8iA==
X-Gm-Message-State: ANhLgQ2ymId3isdw3tbig/Ak4b7FiJJ5u20ngLDgKvHaTLDTjLAR/6qK
        VaEMfIZ3uSrU1+4y5Njc29rMxw==
X-Google-Smtp-Source: ADFU+vtyzrRH95ggJTx87H/Dqq0PyilzrpER8xm/uf21w2cDs3NqJfLQfLdt9s5fY783+V17fSdyig==
X-Received: by 2002:a1c:a78a:: with SMTP id q132mr4716824wme.107.1583947259380;
        Wed, 11 Mar 2020 10:20:59 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id d18sm8611115wrq.22.2020.03.11.10.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 10:20:58 -0700 (PDT)
Date:   Wed, 11 Mar 2020 17:20:56 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: power: supply: add cw2015_battery
 bindings
Message-ID: <20200311172056.wjn3574zrfqxipw6@holly.lan>
References: <20200311093043.3636807-1-t.schramm@manjaro.org>
 <20200311093043.3636807-3-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311093043.3636807-3-t.schramm@manjaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 11, 2020 at 10:30:42AM +0100, Tobias Schramm wrote:
> This patch adds the dts binding schema for the cw2015 fuel gauge.
> 
> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
> ---
>  .../bindings/power/supply/cw2015_battery.yaml | 83 +++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml b/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
> new file mode 100644
> index 000000000000..647dbc6e136e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/cw2015_battery.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Battery driver for CW2015 shuntless fule gauge by CellWise.

s/fule/fuel/


> +
> +maintainers:
> +  - Tobias Schramm <t.schramm@manjaro.org>
> +
> +description: |
> +  The driver can utilize information from a simple-battery linked via a
> +  phandle in monitored-battery. If specified the driver uses the
> +  charge-full-design-microamp-hours property of the battery.
> +
> +properties:
> +  compatible:
> +    const: cellwise,cw2015
> +
> +  reg:
> +    items:
> +      - description: i2c address
> +
> +  cellwise,battery-profile:
> +    description: |
> +      This property specifies characteristics of the battery used. The format
> +      of this binary blob is kept secret by CellWise. The only way to obtain
> +      it is to mail two batteries to a test facility of CellWise and receive
> +      back a test report with the binary blob.
> +    allOf:
> +      - $ref: /schemas/types.yaml#definitions/uint8-array
> +    items:
> +      - minItems: 64
> +        maxItems: 64
> +
> +  cellwise,monitor-interval-ms:
> +    description:
> +      Specifies the interval in milliseconds gauge values are polled at
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  power-supplies:
> +    description:
> +      Specifies supplies used for charging the battery connected to this gauge
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/phandle-array
> +      - minItems: 1
> +        maxItems: 8 # Should be enough

Is it necessary to set a maximum? power_supply.txt is still a text file
but there is no mention of a maximum there.


Daniel.
