Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D11E7132CC
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2019 19:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbfECRD3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 May 2019 13:03:29 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32881 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbfECRD3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 May 2019 13:03:29 -0400
Received: by mail-pf1-f195.google.com with SMTP id z28so3189087pfk.0;
        Fri, 03 May 2019 10:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zFUNV+6rErv9SNLZ0jEAtycql+KYTWK7jUCuIeGUSuQ=;
        b=Jf6G9yGKlK6WIV3+2cNCmDHbbK6SEnHDZJXSxkq3G3aL6YC0mJhQhUpc4jDe6ez8iP
         3Cfs/M1f7Y1AJOYaeaVq/ItniYNAA+4rNJhBJ/OJzekEQxn82TZvUs6H4LJMZuv6JnbU
         QaiJnYPSFG47H9yWce2ysNsuse1H/opXJTMdgwAHIyAWO0/v4OzrddtmE0hxPa96KLQD
         EwPMjX/K8Em22e5GOGXolIxGK+9XDdgCWdwKWI2dIj+KNkjlltxi+ya/6pxzgIm2jN+g
         qYGVjBfqdrqzE4WpUR4T9jqgYPmZSdsvTsKAd4GaaowRKhjkH9r2LA+wzws64uZDDDQv
         7oFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zFUNV+6rErv9SNLZ0jEAtycql+KYTWK7jUCuIeGUSuQ=;
        b=Ea02StMT3eEFCcmh4neyoGNu4+yPUcxNpTHQlz+MsMv7LOi554ZZnRWrs5KJjwmTS+
         mTF/ZxAeFC2S/k/NBBBQwYCrX7GJbN4uONY3B3M+2ObWBttch1iJLVZJ2fjvR/UTcoPA
         apzs8TaLIW78Nvbj9n7CYsA7GKuz2761HDFaIl2uIG/hWnPR00TmhE3P0Epho37AuytF
         9pvaw8HY3wrPQ9jDQa9GJSnaAQl4qZ78SOXfeqL299gUSM2QzLP9IOjrukopup9qt5Ys
         0iL1nHFmPBS8bqRTV/TCEom2XdaqpyhkVXzuC/U7UotBLIqoNdX/OtOmx++iPydgkREI
         kgQQ==
X-Gm-Message-State: APjAAAU7mD5e6G9L1vJaMaq2KbXp6ACTgKft5Nmdo9axtjIiRelHQv7G
        i/W9e00ZardziCmNEOAcVUk=
X-Google-Smtp-Source: APXvYqwRBpm/v5Rtg+7z/fBbBBm+bfY4ZHO6oWCnoPgfxqk4GFQgCOhxavDyGIOurpZ0Jeg7UAYrZA==
X-Received: by 2002:a63:1701:: with SMTP id x1mr11706802pgl.153.1556903008631;
        Fri, 03 May 2019 10:03:28 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z9sm3185923pgi.74.2019.05.03.10.03.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 10:03:27 -0700 (PDT)
Date:   Fri, 3 May 2019 10:03:26 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo Serra <enric.balletbo@collabora.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/3] dt-bindings: power: supply: Add bindings for
 Microchip UCS1002
Message-ID: <20190503170326.GB32529@roeck-us.net>
References: <20190503170042.19334-1-andrew.smirnov@gmail.com>
 <20190503170042.19334-4-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503170042.19334-4-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 03, 2019 at 10:00:42AM -0700, Andrey Smirnov wrote:
> Add bindings for Microchip UCS1002 Programmable USB Port Power
> Controller with Charger Emulation.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Reviewed-by: Rob Herring <robh+dt@kernel.org>
> Cc: Enric Balletbo Serra <enric.balletbo@collabora.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> ---
>  .../power/supply/microchip,ucs1002.txt        | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt b/Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt
> new file mode 100644
> index 000000000000..1d284ad816bf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt
> @@ -0,0 +1,27 @@
> +Microchip UCS1002 USB Port Power Controller
> +
> +Required properties:
> +- compatible		: Should be "microchip,ucs1002";
> +- reg			: I2C slave address
> +
> +Optional properties:
> +- interrupts		: A list of interrupts lines present (could be either
> +			  corresponding to A_DET# pin, ALERT# pin, or both)
> +- interrupt-names	: A list of interrupt names. Should contain (if
> +			  present):
> +			  - "a_det" for line connected to A_DET# pin
> +			  - "alert" for line connected to ALERT# pin
> +			  Both are expected to be IRQ_TYPE_EDGE_BOTH
> +Example:
> +
> +&i2c3 {
> +	charger@32 {
> +		compatible = "microchip,ucs1002";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_ucs1002_pins>;
> +		reg = <0x32>;
> +		interrupts-extended = <&gpio5 2 IRQ_TYPE_EDGE_BOTH>,
> +				      <&gpio3 21 IRQ_TYPE_EDGE_BOTH>;

interrupts ?

> +		interrupt-names = "a_det", "alert";
> +	};
> +};
> -- 
> 2.21.0
> 
