Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A42F01632EF
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2020 21:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgBRUUw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Feb 2020 15:20:52 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41463 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgBRUUw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Feb 2020 15:20:52 -0500
Received: by mail-oi1-f194.google.com with SMTP id i1so21428759oie.8;
        Tue, 18 Feb 2020 12:20:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qa4vyumhFAkQGXRJF5uIdfvI1ZiDY0SQJcSr0dyAsZg=;
        b=gySFLoMxo+LWI3rBU4fvMF/4QeVmmIgK67AiGtQNAqVYDIBRozPJo5VMyckYjFK1Sw
         /lYz74IGZWhq0th03l6w1q5oJeYQhD+xYlRRdlgyTaj84TtPZkroxy4ilSBf5fB8m5JT
         +avycCULmgSHthadj0HwNY96KpcyycHimizafcMT41Ou/3mLrP/Kkxy76FUTQfcYbkYu
         kyn+GQ4I2YQTibm7Hvhf8d3Fs1h61nhYB4xwrBR8X2qcmmhXz1Ql14Sy27DgKVOMDO+p
         u1FFiTNzGNtSneevmqw+0jA91Bzh7rpmgeWk0SYnHoLTMnI4tq/LctHc/D8gdQngNgLo
         Njtg==
X-Gm-Message-State: APjAAAUtyk52GWBQMR+53ivoN/ChatpWG5IDXPzeRj2TqeOwjDyPBt6v
        wVsjqWJcWrHE6Ouo89wR+Q==
X-Google-Smtp-Source: APXvYqz+hvCSGzimhcRi7sOlVXHxj49AXLEsI2ig9xrGPNOybrxt90gohVGm2u83Ki65qYkzBoWeTw==
X-Received: by 2002:a05:6808:64e:: with SMTP id z14mr2303530oih.79.1582057250315;
        Tue, 18 Feb 2020 12:20:50 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j24sm1711288otk.7.2020.02.18.12.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 12:20:49 -0800 (PST)
Received: (nullmailer pid 460 invoked by uid 1000);
        Tue, 18 Feb 2020 20:20:48 -0000
Date:   Tue, 18 Feb 2020 14:20:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Keerthy <j-keerthy@ti.com>
Cc:     rui.zhang@intel.com, robh+dt@kernel.org, daniel.lezcano@linaro.org,
        j-keerthy@ti.com, amit.kucheria@verdurent.com, t-kristo@ti.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        mark.rutland@arm.com
Subject: Re: [PATCH v2 1/4] dt-bindings: thermal: k3: Add VTM bindings
 documentation
Message-ID: <20200218202048.GA32279@bogus>
References: <20200214063443.23589-1-j-keerthy@ti.com>
 <20200214063443.23589-2-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214063443.23589-2-j-keerthy@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 14 Feb 2020 12:04:40 +0530, Keerthy wrote:
> Add VTM bindings documentation. In the Voltage Thermal
> Management Module(VTM), K3 AM654 supplies a voltage
> reference and a temperature sensor feature that are gathered in the band
> gap voltage and temperature sensor (VBGAPTS) module. The band
> gap provides current and voltage reference for its internal
> circuits and other analog IP blocks. The analog-to-digital
> converter (ADC) produces an output value that is proportional
> to the silicon temperature.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
> 
> Changes in v2:
> 
>   * Fixed make dt_binding_check errors.
> 
>  .../bindings/thermal/ti,am654-thermal.yaml    | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
Error: Documentation/devicetree/bindings/thermal/ti,am654-thermal.example.dts:21.41-42 syntax error
FATAL ERROR: Unable to parse input tree
scripts/Makefile.lib:300: recipe for target 'Documentation/devicetree/bindings/thermal/ti,am654-thermal.example.dt.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/thermal/ti,am654-thermal.example.dt.yaml] Error 1
Makefile:1263: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1237882
Please check and re-submit.
