Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A4B2C8B4D
	for <lists+linux-pm@lfdr.de>; Mon, 30 Nov 2020 18:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387750AbgK3Rg5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Nov 2020 12:36:57 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:40487 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387637AbgK3Rg4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2020 12:36:56 -0500
Received: by mail-il1-f196.google.com with SMTP id g1so12089534ilk.7;
        Mon, 30 Nov 2020 09:36:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YuxRGNlv6QYt4AK3oJIWSaBLT8dt75Vrt5dYo5MWBhg=;
        b=uf63ef0Yx+AG4wDCTULpHspe34X+mISGy/VIHRiP3C0JlSo/gyDpEHhiYu3DMYLEOy
         baow4d/tqFeC6pNJU6X/ggr3djko2vUmDz4YQV37dbYbpeUoiy4FMtud43QhA7ac08zo
         xhHKGywk2PspLdoUC6ioML0VD+XpkXrKVvAwfrQnvQpcXndlXXmtKDlhQPdN43AwepBx
         0D5rvMgJRsqWjWrIWPB6PCLCIOx5rxiDBgATDPngE5gEWOBBKJ2lHwr2OpGHZMJQzSAc
         AzWdm5QYBZtPbOiqRP9npiIFYUTMqboYAp+Tmv8UdntVqeAjZja6DHmLwxMR0gztBE/l
         V5/w==
X-Gm-Message-State: AOAM5338unJbgWvD2uku9jVpbQCdLmXAPymIXPJV8i8DwbwhfeVDYcu2
        RYRCT8nwHtDclZjq9pa+2Q==
X-Google-Smtp-Source: ABdhPJyo4ZN8rI5Ly+F9Z0ZjEj3ZWTEVZuPTRCBjJKgbwZEAYb38kcRggMqNsU01kSmfvhdLrMJKwg==
X-Received: by 2002:a05:6e02:ca5:: with SMTP id 5mr18434270ilg.183.1606757775075;
        Mon, 30 Nov 2020 09:36:15 -0800 (PST)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id q140sm7696530iod.43.2020.11.30.09.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 09:36:14 -0800 (PST)
Received: (nullmailer pid 2683006 invoked by uid 1000);
        Mon, 30 Nov 2020 17:36:11 -0000
Date:   Mon, 30 Nov 2020 10:36:11 -0700
From:   Rob Herring <robh@kernel.org>
To:     gao.yunxiao6@gmail.com
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, zhang.lyra@gmail.com,
        "jeson.gao" <jeson.gao@unisoc.com>, orsonzhai@gmail.com,
        rui.zhang@intel.com, amitk@kernel.org, kernel-team@android.com,
        linux-pm@vger.kernel.org, javi.merino@kernel.org,
        daniel.lezcano@linaro.org
Subject: Re: [RFC 1/2] dt-bindings: thermal: sprd: Add virtual thermal
 documentation
Message-ID: <20201130173611.GA2680517@robh.at.kernel.org>
References: <1606466112-31584-1-git-send-email-gao.yunxiao6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606466112-31584-1-git-send-email-gao.yunxiao6@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 27 Nov 2020 16:35:12 +0800, gao.yunxiao6@gmail.com wrote:
> From: "jeson.gao" <jeson.gao@unisoc.com>
> 
> virtual thermal node definition description in dts file
> 
> Signed-off-by: jeson.gao <jeson.gao@unisoc.com>
> ---
>  .../thermal/sprd-virtual-thermal.yaml         | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/sprd-virtual-thermal.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/thermal/sprd-virtual-thermal.example.dts:21.11-21: Warning (reg_format): /example-0/virtual-sensor@1:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/thermal/sprd-virtual-thermal.example.dt.yaml: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/thermal/sprd-virtual-thermal.example.dt.yaml: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/thermal/sprd-virtual-thermal.example.dt.yaml: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/thermal/sprd-virtual-thermal.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/thermal/sprd-virtual-thermal.example.dt.yaml: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/sprd-virtual-thermal.example.dt.yaml: example-0: virtual-sensor@1:reg:0: [1] is too short
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml


See https://patchwork.ozlabs.org/patch/1407041

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

