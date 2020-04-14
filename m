Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47DDF1A8DF7
	for <lists+linux-pm@lfdr.de>; Tue, 14 Apr 2020 23:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634109AbgDNVpU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Apr 2020 17:45:20 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43433 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2634106AbgDNVpM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Apr 2020 17:45:12 -0400
Received: by mail-ot1-f67.google.com with SMTP id g14so1294637otg.10;
        Tue, 14 Apr 2020 14:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Go4RGtgIqyKHKCRRcfy17L5oN8SY3r4Jf8gKD8EXnBo=;
        b=eX76WRCKBpppPEt1+rredZjszBhkGnJo0c5xNqOCBLK1dHSNhkf8Ft4lUqPwesFLsj
         39yUwM6027e5nKQQ/WnMuxvPm+/TL0vpsme86VYQJkSpL3Jt/vG0Zt38qUZEMlj8ywZg
         zPxWLLy6LH+wDNTmhOCDvkkxsRwfTx8FoZ/rR8D44wAH/wM6fERrEvXywAWwDGNGHyM+
         XMTG7o37yIj+FDTiz0M5EXV5erDsG8YNZ7RXJbVBj/tyt1C5hQD7MBiKfXy6bLCz8CG1
         NU4SqrSZarZk+0pL0J1/KXwTWAsuJCduqzPEmbegJ6yyErJoa/GgpojLJVAzwSiTYYAt
         frEw==
X-Gm-Message-State: AGi0PuZbTPDH1E4O63PMzdhYC8RR4SzeoS8gSKXD4Pw7qSUOrUFlqcZZ
        m2u1kFw4Aj0OjQ2C0q6B2w==
X-Google-Smtp-Source: APiQypLTtqcTnJWfsv36vUyoHTSuRXCgSB1Jwv9bbH0db5LUR+jzkUKlGIny0dvYJFig5ipNz4fcFg==
X-Received: by 2002:a9d:a0d:: with SMTP id 13mr9279315otg.222.1586900711492;
        Tue, 14 Apr 2020 14:45:11 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o26sm2206162otj.39.2020.04.14.14.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 14:45:10 -0700 (PDT)
Received: (nullmailer pid 11414 invoked by uid 1000);
        Tue, 14 Apr 2020 21:45:09 -0000
Date:   Tue, 14 Apr 2020 16:45:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     daniel.lezcano@linaro.org, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, Mark Rutland <mark.rutland@arm.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: thermal: Add the idle cooling device
Message-ID: <20200414214509.GA10673@bogus>
References: <20200414162634.1867-1-daniel.lezcano@linaro.org>
 <20200414162634.1867-2-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414162634.1867-2-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 14 Apr 2020 18:26:27 +0200, Daniel Lezcano wrote:
> Some devices are not able to cool down by reducing their voltage /
> frequency because it could be not available or the system does not
> allow voltage scaling. In this configuration, it is not possible to
> use this strategy and the idle injection cooling device can be used
> instead.
> 
> One idle cooling device is now present for the CPU as implemented by
> the combination of the idle injection framework belonging to the power
> capping framework and the thermal cooling device. The missing part is
> the DT binding providing a way to describe how the cooling device will
> work on the system.
> 
> A first iteration was done by making the cooling device to point to
> the idle state. Unfortunately it does not make sense because it would
> need to duplicate the idle state description for each CPU in order to
> have a different phandle and make the thermal internal framework
> happy.
> 
> It was proposed to add an cooling-cells to <3>, unfortunately the
> thermal framework is expecting a value of <2> as stated by the
> documentation and it is not possible from the cooling device generic
> code to loop this third value to the back end cooling device.
> 
> Another proposal was to add a child 'thermal-idle' node as the SCMI
> does. This approach allows to have a self-contained configuration for
> the idle cooling device without colliding with the cpufreq cooling
> device which is based on the CPU node. In addition, it allows to have
> the cpufreq cooling device and the idle cooling device to co-exist
> together as shown in the example.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  - V2:
>    - Fixed comment type
>    - Added dual license
>    - Fixed description s/begins to/should/
>    - Changed name s/duration/duration-us/
>    - Changed name s/latency/exit-latency-us/
>    - Removed types for latency / duration
>    - Fixed s/idle-thermal/thermal-idle/
> ---
>  .../bindings/thermal/thermal-idle.yaml        | 146 ++++++++++++++++++
>  1 file changed, 146 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/thermal-idle.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/thermal/thermal-idle.yaml:  while scanning a block scalar
  in "<unicode string>", line 39, column 20
found a tab character where an indentation space is expected
  in "<unicode string>", line 44, column 1
Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/thermal/thermal-idle.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/thermal/thermal-idle.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
warning: no schema found in file: Documentation/devicetree/bindings/thermal/thermal-idle.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-idle.yaml: ignoring, error parsing file
Makefile:1264: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1270492

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
