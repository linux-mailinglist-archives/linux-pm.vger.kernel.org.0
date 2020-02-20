Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0A6B166868
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 21:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbgBTUer (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 15:34:47 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39428 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbgBTUer (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 15:34:47 -0500
Received: by mail-ot1-f65.google.com with SMTP id 77so4951157oty.6;
        Thu, 20 Feb 2020 12:34:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HkO4EbLE6vSF3rVACMoGd9OQqI3Lp6oEscG+dy8NDxw=;
        b=Hv2c1hY8K3HGQgOP0HvHa6OSmgQKqi1YEdm84FvQBEuz/vqdJlZ7EssRY4ltLSBDtD
         woNEYTCKeWrBpMserKOmcFpD/IaT/neZdKvdCJQgeoEeOBwM456txa40s2lRDYEtV2kj
         72rjh1yFVzd+34XzxmWRxZ+si2BAZXfJRNP5MLqtoKXV77QPyJmj2yOt/uMXZu5W2wG3
         eV4nW2MSjKr95hRNs9HNsQxAb7ho4luhRqRs4gTsB0zoFE53zzI8bGcW0JBIR5I7VLwS
         nkxoVdGuBpa5rYNkHNDTjzjUWqP4EVp5Gn2dApvnttWCytrCaNaFTSDRZjjbXU1k7N90
         aKrg==
X-Gm-Message-State: APjAAAUnv0/N6PSBf9ToNhY+6nVqbcXEUXiLg3hyxtwVPfn9+sPSTrXE
        g/1H/d87ZYpZHP7Pj8nIrg==
X-Google-Smtp-Source: APXvYqwJjInOWLpyeDUL/N/WJQNVacbR2Zz5eGti5BN0+Wkm5NOH7GKHc1ZLWuA1Aes7JnP1cVGmEQ==
X-Received: by 2002:a9d:6b91:: with SMTP id b17mr23741274otq.235.1582230885833;
        Thu, 20 Feb 2020 12:34:45 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c21sm130245oiy.11.2020.02.20.12.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 12:34:45 -0800 (PST)
Received: (nullmailer pid 14557 invoked by uid 1000);
        Thu, 20 Feb 2020 20:34:44 -0000
Date:   Thu, 20 Feb 2020 14:34:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com,
        Sebastian Reichel <sre@kernel.org>,
        "GitAuthor: Matti Vaittinen" <matti.vaittinen@fi.rohmeurope.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Laine <markus.laine@fi.rohmeurope.com>,
        Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>
Subject: Re: [RFC PATCH v3 2/8] dt_bindings: ROHM BD99954 Charger
Message-ID: <20200220203444.GA13946@bogus>
References: <cover.1582182989.git.matti.vaittinen@fi.rohmeurope.com>
 <f82f140cd758d435a1ab4e45fef4e17a5af2db5c.1582182989.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f82f140cd758d435a1ab4e45fef4e17a5af2db5c.1582182989.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 20 Feb 2020 09:35:10 +0200, Matti Vaittinen wrote:
> The ROHM BD99954 is a Battery Management LSI for 1-4 cell Lithium-Ion
> secondary battery. Intended to be used in space-constraint equipment such
> as Low profile Notebook PC, Tablets and other applications. BD99954
> provides a Dual-source Battery Charger, two port BC1.2 detection and a
> Battery Monitor.
> 
> Document the DT bindings for BD99954
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>  .../bindings/power/supply/rohm,bd9995x.yaml   | 153 ++++++++++++++++++
>  1 file changed, 153 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/rohm,bd9995x.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
Documentation/devicetree/bindings/power/supply/rohm,bd9995x.example.dts:21.17-29: Warning (reg_format): /example-0/i2c/charger@9:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/power/supply/rohm,bd9995x.example.dt.yaml: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/power/supply/rohm,bd9995x.example.dts:17.5-28.11: Warning (i2c_bus_bridge): /example-0/i2c: incorrect #address-cells for I2C bus
Documentation/devicetree/bindings/power/supply/rohm,bd9995x.example.dts:17.5-28.11: Warning (i2c_bus_bridge): /example-0/i2c: incorrect #size-cells for I2C bus
Documentation/devicetree/bindings/power/supply/rohm,bd9995x.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/power/supply/rohm,bd9995x.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'i2c_bus_bridge'
Documentation/devicetree/bindings/power/supply/rohm,bd9995x.example.dt.yaml: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/power/supply/rohm,bd9995x.example.dts:18.23-27.15: Warning (avoid_default_addr_size): /example-0/i2c/charger@9: Relying on default #address-cells value
Documentation/devicetree/bindings/power/supply/rohm,bd9995x.example.dts:18.23-27.15: Warning (avoid_default_addr_size): /example-0/i2c/charger@9: Relying on default #size-cells value

See https://patchwork.ozlabs.org/patch/1241291
Please check and re-submit.
