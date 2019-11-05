Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF9A2EF315
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2019 02:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbfKEB6a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 20:58:30 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45505 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729597AbfKEB6a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Nov 2019 20:58:30 -0500
Received: by mail-ot1-f65.google.com with SMTP id 77so11838125oti.12;
        Mon, 04 Nov 2019 17:58:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gmYraXUwBZGb7SjnYfb7LVvYyu+EbS6Dq6WsiW6ugLQ=;
        b=W+gLolNegV0kBHweDucIh4cXTdNJN24nGK2Doc2xWFKEPfP4O9lJ36H32wPa+s7qne
         QOCzejraKrhq4LspATp6iB/6J3GNw+yCu6xGF0QMsdy7xaPYO1zn/nDEorGUG9cBMmlN
         NyvG1JxsKEjqlVW4tUVBTdXFKyb+LiEA27d8HGog2vpQrf4f8pki788HcTaRQ1lExfJu
         JQnemhX2RnECz0giB7nvT2YoYHBVU2XPiFvJ3aw4smzdhPFl5QglhFtzgfl3OAIbDP94
         P2mJPKNuzcnYSox2exJHoSoi6kSogRsXpn1RxB7TUlXbRQcXHNdsqnmyouka71mVzXje
         aRzw==
X-Gm-Message-State: APjAAAVjSeGhkDs0nuLNRfapBmvF3krFBSAf+TKqpKkctPIgCKG+aecb
        J4JaohYmxqjMUIS/ipQblw==
X-Google-Smtp-Source: APXvYqx9fT0D63eHAknVkyowX+0cfZhjqiWWNlSNjVlzbGr8k08aYwX9ohraNUzyt9RHvzcqojdddQ==
X-Received: by 2002:a9d:1c8f:: with SMTP id l15mr16727710ota.313.1572919109034;
        Mon, 04 Nov 2019 17:58:29 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q82sm513021oif.11.2019.11.04.17.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 17:58:28 -0800 (PST)
Date:   Mon, 4 Nov 2019 19:58:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     sre@kernel.org, krzk@kernel.org, mark.rutland@arm.com,
        cw00.choi@samsung.com, b.zolnierkie@samsung.com,
        lee.jones@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] dt-bindings: power: supply: Max17040: Add low
 level SOC alert threshold
Message-ID: <20191105015827.GA332@bogus>
References: <CAJKOXPdCtbsPaAgYp5iVBhkAsjXzOYWwttQBptgiUgzhbKi09w@mail.gmail.com>
 <20191031184134.30621-1-matheus@castello.eng.br>
 <20191031184134.30621-3-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031184134.30621-3-matheus@castello.eng.br>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 31, 2019 at 03:41:32PM -0300, Matheus Castello wrote:
> For configure low level state of charge threshold alert signaled from
> max17040 we add "maxim,alert-low-soc-level" property.

This doesn't match the change. You're adding a whole new device binding.

> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  .../power/supply/max17040_battery.txt         | 33 +++++++++++++++++++

Part of an MFD? The MFD binding should reference this file then.

>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/max17040_battery.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
> new file mode 100644
> index 000000000000..f2d0b22b5f79
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
> @@ -0,0 +1,33 @@
> +max17040_battery
> +~~~~~~~~~~~~~~~~
> +
> +Required properties :
> + - compatible : "maxim,max17040" or "maxim,max77836-battery"
> + - reg: i2c slave address
> +
> +Optional properties :
> +- maxim,alert-low-soc-level :	The alert threshold that sets the state of
> + 				charge level (%) where an interrupt is
> +				generated. Can be configured from 1 up to 32
> +				(%). If skipped the power up default value of
> +				4 (%) will be used.

Seems like something that should be a common battery property.

> +- interrupts : 			Interrupt line see Documentation/devicetree/
> +				bindings/interrupt-controller/interrupts.txt
> +- wakeup-source :		This device has wakeup capabilities. Use this
> +				property to use alert low SOC level interrupt
> +				as wake up source.
> +
> +Optional properties support interrupt functionality for alert low state of
> +charge level, present in some ICs in the same family, and should be used with
> +compatible "maxim,max77836-battery".
> +
> +Example:
> +
> +	battery-fuel-gauge@36 {
> +		compatible = "maxim,max77836-battery";
> +		reg = <0x36>;
> +		maxim,alert-low-soc-level = <10>;
> +		interrupt-parent = <&gpio7>;
> +		interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
> +		wakeup-source;
> +	};
> --
> 2.24.0.rc2
> 
