Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 611A2198001
	for <lists+linux-pm@lfdr.de>; Mon, 30 Mar 2020 17:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgC3PnS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Mar 2020 11:43:18 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46536 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728669AbgC3PnS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Mar 2020 11:43:18 -0400
Received: by mail-io1-f67.google.com with SMTP id i3so9070204ioo.13;
        Mon, 30 Mar 2020 08:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QZTacSjnasNg1ss/HrVdMsonrOQ5SdqkzGymGMFrIvk=;
        b=IWJdc6Iw0CF8+zFvuY5CMBBV0Vk7pD/hhWJ7NCqJ7KNbX3mJFx3FDfYQBCYX+Se0tc
         +e7sfvnAcqKy8CyJrU2Mx5DNgBCzZ6L4YsyJZrGH6dFkAkO0TfSNXyfG6ZLxCY4MHuXT
         Xg0xrmaeFk8Pi+oF7gIja8kTq52oyESZ2eMUDhJg0Pvw8ekFOOZ1P6P24IBrawvICJrv
         OiHDGXM8NUJ4nBoDKJ5qrLuSLV3bLoAmgH42hcsOsFKs1g3enm5xKhr+oxy3towwT/Mm
         lA0OHIKtAYBzE8d2nbIKzzwiDZLIu7gQCaEoDS4Yu4p7fCBauKhhgHC0N29lbcog8osk
         RrHg==
X-Gm-Message-State: ANhLgQ3Wv4n7AnjVDzQ5EH/iJ+cyeAlL77KWyGBt4iyZAthlcNoIE0v0
        gJncq5Bx6Nu5lAD1TgBZfw==
X-Google-Smtp-Source: ADFU+vtagkVVM5xB3qhxbp6YHISoiVCmO7s0zBShZgPAMIst11fqDk7nV5IgjtgFY3XrZiCTtdijqQ==
X-Received: by 2002:a5d:8d0e:: with SMTP id p14mr2838387ioj.0.1585582995052;
        Mon, 30 Mar 2020 08:43:15 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id b4sm5022641ilg.58.2020.03.30.08.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 08:43:14 -0700 (PDT)
Received: (nullmailer pid 26197 invoked by uid 1000);
        Mon, 30 Mar 2020 15:43:11 -0000
Date:   Mon, 30 Mar 2020 09:43:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [RFC] dt-bindings.yaml: power: supply: add bindings for TI
 bq24296/7
Message-ID: <20200330154311.GA24776@bogus>
References: <7d7602574b5eda80bd1d40f79854ba3670201c6e.1585510588.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d7602574b5eda80bd1d40f79854ba3670201c6e.1585510588.git.hns@goldelico.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 29 Mar 2020 21:36:29 +0200, "H. Nikolaus Schaller" wrote:
> This is an attempt to define a schema for the bq24296/7
> charger and power supply controllers with battery monitoring
> and OTG booster.
> 
> We model it as a dual regulator because it can generate
> a VSYS (with controllable voltage) and optionally an
> OTG voltage either from the battery or from external power
> supply.
> 
> This scheme works well with e.g. the dwc3 setup of the
> OMAP5 to turn on OTG regulator on demand.
> 
> The DT should provide a reference to a monitored battery
> description so that initial and operation parameters
> of the battery can be specified to control the charger
> parameters.
> 
> To support different initial charging current for USB
> and AC charger mode, an optional gpio should be provided
> that the driver can use to set defaults.
> 
> A driver is available and working for several years,
> but the bindings should be clarified first.
> 
> The example shows what we are successfully using for
> the working system.
> 
> Since the omap5 Pyra Handheld is not yet in the DTS tree,
> there would be no explicit user of this driver. So
> the plan is to submit a full patch set for the Pyra
> later.
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  .../bindings/power/supply/bq2429x.yaml        | 122 ++++++++++++++++++
>  1 file changed, 122 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/bq2429x.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/supply/bq2429x.yaml: properties:monitored-battery: [{'description': 'phandle to the battery node'}, {'allOf': [{'$ref': '/schemas/types.yaml#/definitions/phandle'}]}, {'enum': [{'voltage-max-design-microvolt': [{'default': 4200000}]}, {'voltage-min-design-microvolt': [{'default': 3200000}]}, {'constant-charge-current-max-microamp': [{'default': 'as defined by boot loader'}]}, {'precharge-current-microamp': [{'default': 128000}]}, {'charge-term-current-microamp': [{'default': 128000}]}]}] is not of type 'object', 'boolean'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/supply/bq2429x.yaml: properties:dc-det-gpios: {'items': [{'description': 'gpio for detecting two different DC sources'}, {'default': 'use usb-input-current-microamp only'}]} is not valid under any of the given schemas (Possible causes of the failure):
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/supply/bq2429x.yaml: properties:dc-det-gpios: 'maxItems' is a required property
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/supply/bq2429x.yaml: properties:dc-det-gpios:items: [{'description': 'gpio for detecting two different DC sources'}, {'default': 'use usb-input-current-microamp only'}] is not valid under any of the given schemas (Possible causes of the failure):
		/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/supply/bq2429x.yaml: properties:dc-det-gpios:items: [{'description': 'gpio for detecting two different DC sources'}, {'default': 'use usb-input-current-microamp only'}] is not of type 'object'
		/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/supply/bq2429x.yaml: properties:dc-det-gpios:items:1:default: 'use usb-input-current-microamp only' is not of type 'integer'


Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/power/supply/bq2429x.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/power/supply/bq2429x.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
warning: no schema found in file: Documentation/devicetree/bindings/power/supply/bq2429x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/supply/bq2429x.yaml: ignoring, error in schema: properties: monitored-battery
Makefile:1262: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1263547

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
