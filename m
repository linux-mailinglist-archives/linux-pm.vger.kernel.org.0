Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD976422661
	for <lists+linux-pm@lfdr.de>; Tue,  5 Oct 2021 14:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbhJEM2b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Oct 2021 08:28:31 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:46736 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbhJEM2a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Oct 2021 08:28:30 -0400
Received: by mail-ot1-f47.google.com with SMTP id u20-20020a9d7214000000b0054e170300adso549590otj.13;
        Tue, 05 Oct 2021 05:26:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Bkcz1hLoY5XJ4emiQPlbESOWdd3bR4m2XjTJGdTd4Jk=;
        b=WR+3t2X+Rgg+Q8m7G0t0np3j3OrSEBlFVjN4DUJ/KXPVF0Gf//5npCLuTo5SA3DPiS
         XDmhdS0RBRGz4ZjfbFRbA1++5qCxc5si1qBoYYG3xI6oCn3lr/1zZ9FdsZVaMQL99qWX
         q4LiDMBorfLkoqYMWrJElQFXFt6kHDNtF0HH8vGLt3D+TvRiH0N68WQM/mcUAiaQEoAZ
         H8SF+MMrV0bxCYlt+/ZHhbNsONXXqq1n7iYVRj/K3mh9ByH31p/jFxKsji59GD9oBXdV
         mwiJcqg3H0xJ7fyj3s4xRshUN/BWd/NWAzcL8Rkw5Ku3mQtxtg3z5PVLOZalmBoktdPr
         vlLA==
X-Gm-Message-State: AOAM531lyGqwIJbphYt1N4IplTuL0hNGVcH16mjhZHUXCQWkbTfHKpMN
        zHvOngRabvp003BX4odCSQ==
X-Google-Smtp-Source: ABdhPJxxZ69AeBAa1GXfiIelXxXU8mpzawyh0+vEkAqzE/fEZGAIAhXDY0vVImyI2MwuZnWezGvVbg==
X-Received: by 2002:a05:6830:4488:: with SMTP id r8mr7164613otv.274.1633436800032;
        Tue, 05 Oct 2021 05:26:40 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j4sm3290686oia.56.2021.10.05.05.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 05:26:39 -0700 (PDT)
Received: (nullmailer pid 3226793 invoked by uid 1000);
        Tue, 05 Oct 2021 12:26:38 -0000
From:   Rob Herring <robh@kernel.org>
To:     Keerthy <j-keerthy@ti.com>
Cc:     daniel.lezcano@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        kristo@kernel.org, rui.zhang@intel.com, amitk@kernel.org,
        linux-pm@vger.kernel.org
In-Reply-To: <20211004112550.27546-2-j-keerthy@ti.com>
References: <20211004112550.27546-1-j-keerthy@ti.com> <20211004112550.27546-2-j-keerthy@ti.com>
Subject: Re: [PATCH 1/4] dt-bindings: thermal: k3-j72xx: Add VTM bindings documentation
Date:   Tue, 05 Oct 2021 07:26:38 -0500
Message-Id: <1633436798.497006.3226792.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 04 Oct 2021 16:55:47 +0530, Keerthy wrote:
> Add VTM bindings documentation. In the Voltage Thermal
> Management Module(VTM), K3 J72XX supplies a voltage
> reference and a temperature sensor feature that are gathered in the band
> gap voltage and temperature sensor (VBGAPTS) module. The band
> gap provides current and voltage reference for its internal
> circuits and other analog IP blocks. The analog-to-digital
> converter (ADC) produces an output value that is proportional
> to the silicon temperature.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  .../bindings/thermal/ti,j72xx-thermal.yaml    | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.example.dt.yaml: example-0: wkup_vtm0@42040000:reg:0: [0, 1107558400, 0, 848] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.example.dt.yaml: example-0: wkup_vtm0@42040000:reg:1: [0, 1107623936, 0, 848] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.example.dt.yaml: example-0: wkup_vtm0@42040000:reg:2: [0, 1124074240, 0, 16] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.example.dt.yaml: wkup_vtm0@42040000: compatible: ['ti,j721e-vtm', 'ti,j7200-vtm'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.example.dt.yaml: wkup_vtm0@42040000: compatible: Additional items are not allowed ('ti,j7200-vtm' was unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.example.dt.yaml:0:0: /example-0/wkup_vtm0@42040000: failed to match any schema with compatible: ['ti,j721e-vtm', 'ti,j7200-vtm']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1536069

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

