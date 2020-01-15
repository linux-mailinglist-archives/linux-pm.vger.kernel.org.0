Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23ADB13B764
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2020 03:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbgAOCCB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jan 2020 21:02:01 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42574 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728834AbgAOCB6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jan 2020 21:01:58 -0500
Received: by mail-oi1-f195.google.com with SMTP id 18so13923731oin.9
        for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2020 18:01:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TXUKuJW35exIxCuuFGP0F9ChBxkOTZKYHQSXMibvkgw=;
        b=nUkyT/ijOi3VK9e1RQyZAzvs5JUJ6L1GCDq4twHqMeCzz6UlppHsU340j+ezcJISSY
         un9aWNDzMn3esKJLFuMFHQuOQz5BTyoZBmzbK7AdgPdlrGh2flo9Qj/PhmVBDuQsm42H
         izTrDks/qEbQQitPxJqtVmtGntnfgwBVNutmF3SPos1nU2FugN81V/src+9YCW1oWJMo
         qMGvCadC2hRdm4ruMxPCiJO6JZWjW4HH+tp/L8XQhnroclZvQD/+ARDKAjo0U/vSl+jz
         GAvdNc6kefCvG1yGqVQmpDhww3kBzaABdepmgMvqDovlhAN7O6ptOay3xz3yhtNhwh43
         +YMw==
X-Gm-Message-State: APjAAAXtZOKWyuk1pcofPYCGeONALXADYFD9li5dRdW+Suea0LBp9s+G
        KYkJJFLnWbzX4PhHf1867OT+tWY=
X-Google-Smtp-Source: APXvYqyucWFFBLFhaJFYVvJ5RXdndfU+JCYMCSsBC0LpcU1W73LhFGpimlHOSUcit0DOkISne7VCXw==
X-Received: by 2002:aca:2b0a:: with SMTP id i10mr19628724oik.137.1579053717329;
        Tue, 14 Jan 2020 18:01:57 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p24sm6038221oth.28.2020.01.14.18.01.56
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 18:01:56 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220a2e
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Tue, 14 Jan 2020 20:01:55 -0600
Date:   Tue, 14 Jan 2020 20:01:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND 2/2] dt-bindings: power: supply: cw2015_battery: add
 device tree binding documentation
Message-ID: <20200115020155.GA7802@bogus>
References: <20200109113955.2882-1-t.schramm@manjaro.org>
 <20200109113955.2882-3-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109113955.2882-3-t.schramm@manjaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 09, 2020 at 12:39:55PM +0100, Tobias Schramm wrote:
> This patch adds the ds binding document for the cw2015 Fuel Gauge.

ds?

> 
> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
> ---
>  .../bindings/power/supply/cw2015_battery.txt  | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/cw2015_battery.txt

Please make this a DT schema. See 
Documentation/devicetree/writing-schema.rst.

> 
> diff --git a/Documentation/devicetree/bindings/power/supply/cw2015_battery.txt b/Documentation/devicetree/bindings/power/supply/cw2015_battery.txt
> new file mode 100644
> index 000000000000..e847391268f3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/cw2015_battery.txt
> @@ -0,0 +1,37 @@
> +cw2015_battery
> +~~~~~~~~~~~~~~~~
> +
> +The cellwise CW2015 is a shuntless single/multi-cell battery fuel gauge.
> +
> +Required properties :
> + - compatible : "cellwise,cw2015"
> + - cellwise,bat-config-info : Binary battery info blob
> +
> +Optional properties :
> + - cellwise,monitor-interval : Measurement interval in seconds

Use standard unit suffix.

> + - cellwise,voltage-divider : Voltage divider for multi-cell packs,
> +   specified as two integer values <high side>, <low side> in ohms.

Use standard unit suffix (-ohms).

> + - cellwise,virtual-power : Default to disconnected battery state (gauge in pack mode)
> + - cellwise,design-capacity : Design capacity of the battery cell in milliampere hours

I think we have a standard property for this. Properties of the battery 
should be in a battery node.

> + - cellwise,alert-level : Low battery alarm level in percent
> +
> +Example:
> +	cw2015@62 {
> +		status = "okay";

Don't show status in examples.

> +		compatible = "cellwise,cw201x";
> +		reg = <0x62>;
> +		cellwise,bat-config-info = <
> +			0x17 0x67 0x80 0x73 0x6E 0x6C 0x6B 0x63
> +			0x77 0x51 0x5C 0x58 0x50 0x4C 0x48 0x36
> +			0x15 0x0C 0x0C 0x19 0x5B 0x7D 0x6F 0x69
> +			0x69 0x5B 0x0C 0x29 0x20 0x40 0x52 0x59
> +			0x57 0x56 0x54 0x4F 0x3B 0x1F 0x7F 0x17
> +			0x06 0x1A 0x30 0x5A 0x85 0x93 0x96 0x2D
> +			0x48 0x77 0x9C 0xB3 0x80 0x52 0x94 0xCB
> +			0x2F 0x00 0x64 0xA5 0xB5 0x11 0xF0 0x11
> +		>;
> +		cellwise,monitor-interval = <5>;
> +		cellwise,virtual-power;
> +		cellwise,design-capacity = <9800>;
> +		power-supplies = <&mains_charger>, <&usb_charger>;

Not documented.

> +	}
> -- 
> 2.24.1
> 
