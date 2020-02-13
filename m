Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E19215CC8E
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 21:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgBMUrl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Feb 2020 15:47:41 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42736 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbgBMUrk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Feb 2020 15:47:40 -0500
Received: by mail-oi1-f196.google.com with SMTP id j132so7206670oih.9;
        Thu, 13 Feb 2020 12:47:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z3dk5qxcEVX9/dZvrNaONjzVzfrEpAE56fEOJ9OyDRY=;
        b=FSnfpqIZN3arayi8/cjP1yKVv5k8Y+fvQdTaETBz/WEwkFtS4ZbSG++V2Ihgz2k0UG
         /qFlyxcmmHHcDl/FgXm4+Tserz8lfy1bLSim7x0kebFs7hRBJVc0YFNxa/jFwgJrqO6C
         oOuxB3IF90cwnHC00WGp/xBsmhFMkr54qlBWmeq8XAWlESReP0si53SEwtmlK/c1vf27
         5/+Q92M85gAaWm6NP/B+MRebo+1N/Sd4E579epmxTbt+nJAiWo3TFG7ev2mEQMffmC+q
         wpFY61FTsNW5fwo+s14skRFgNl6BMlqoyPCqqQ2J3oB8PSKNN9GdcS0x2B7aE+XVKzqx
         UQiA==
X-Gm-Message-State: APjAAAWCuY48j3pOyyD0D7dWvs5vfLvX4TboeiCH9Q2s0aJaAMsdHE5r
        BhJ5HB3uDFunLckgJBA1xA==
X-Google-Smtp-Source: APXvYqzQA7r7V4YoQpEtQwWPfWwQz5RkPdR405hNAG7fAhbJpVu3jI2rmNBq0FR14AcPd35Qq8d0MA==
X-Received: by 2002:aca:ddc2:: with SMTP id u185mr4359191oig.24.1581626859710;
        Thu, 13 Feb 2020 12:47:39 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f1sm1173808otq.4.2020.02.13.12.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 12:47:39 -0800 (PST)
Received: (nullmailer pid 3866 invoked by uid 1000);
        Thu, 13 Feb 2020 20:47:38 -0000
Date:   Thu, 13 Feb 2020 14:47:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Keerthy <j-keerthy@ti.com>
Cc:     rui.zhang@intel.com, robh+dt@kernel.org, daniel.lezcano@linaro.org,
        j-keerthy@ti.com, amit.kucheria@verdurent.com, t-kristo@ti.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        mark.rutland@arm.com
Subject: Re: [PATCH 1/4] dt-bindings: thermal: k3: Add VTM bindings
 documentation
Message-ID: <20200213204738.GA2973@bogus>
References: <20200213102440.20539-1-j-keerthy@ti.com>
 <20200213102440.20539-2-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213102440.20539-2-j-keerthy@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 13 Feb 2020 15:54:37 +0530, Keerthy wrote:
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
>  .../bindings/thermal/ti,am654-thermal.yaml    | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

warning: no schema found in file: Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml: ignoring, error parsing file
Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
Traceback (most recent call last):
  File "/usr/local/bin/dt-doc-validate", line 35, in check_doc
    testtree = dtschema.load(filename, line_number=line_number, duplicate_keys=False)
  File "/usr/local/lib/python3.6/dist-packages/dtschema/lib.py", line 513, in load
    return yaml.load(f.read())
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/main.py", line 343, in load
    return constructor.get_single_data()
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 111, in get_single_data
    node = self.composer.get_single_node()
  File "_ruamel_yaml.pyx", line 718, in _ruamel_yaml.CParser.get_single_node
ruamel.yaml.composer.ComposerError: expected a single document in the stream
  in "<unicode string>", line 2, column 1
but found another document
  in "<unicode string>", line 4, column 1

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/usr/local/bin/dt-doc-validate", line 74, in <module>
    ret = check_doc(args.yamldt)
  File "/usr/local/bin/dt-doc-validate", line 40, in check_doc
    print(filename + ":", exc.path[-1], exc.message)
AttributeError: 'ComposerError' object has no attribute 'path'
Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/thermal/ti,am654-thermal.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/thermal/ti,am654-thermal.example.dts] Error 1
Makefile:1263: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1237405
Please check and re-submit.
