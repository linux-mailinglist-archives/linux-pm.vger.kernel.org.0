Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEF91C1FB2
	for <lists+linux-pm@lfdr.de>; Fri,  1 May 2020 23:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgEAVfn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 17:35:43 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40302 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgEAVfm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 May 2020 17:35:42 -0400
Received: by mail-ot1-f65.google.com with SMTP id i27so3664416ota.7;
        Fri, 01 May 2020 14:35:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L7Pjlj+bds8pkUkLj6i4yY9snS8jpLg7qkPY4JTHgEQ=;
        b=GEECfWiyicKbw05rfUnN7ZaIMVhlK72Lt8GLny5jfw2EPLNmr+8yyKDxCJwekdGyyb
         kAR9S4sHWsLmvyy1sTjNtx0OhVWZeev/4EkF1iN71n60Ovcai42kcgSQ7d075ZoP2hzS
         iGRNIRIv0UUPtc/+21S4VOsoJb80UoDBpFDC7QLtVdQeYTjF+tFq/gSSVzm7ThBMC1kF
         The8M1qljArYzBmNuV/OtR0w1eDs6QtwF/iZviwgjvC1wk0eDAVQtuCdX2kW8LEEBY/P
         77s6ZFeHMI/DGy/LJ2iW7iFiffXA7JJzuyD7609FJQSMAHnPUVhHIFWTXPNzURrbu2SG
         PEzA==
X-Gm-Message-State: AGi0PuYse/GE+tbQxD0WKgoD0ItLes8WYbriQIep6y/y+emq1+StwZYX
        TF+51y4vtFR43xydm3rY2m0vKOQ=
X-Google-Smtp-Source: APiQypIcS4ZldtIHDn1qsuo/ZwhYHO44SNWEmJ0QrB++gTcgGWj4b0A/SY9x+Mc7/f+BhQfvihMVFA==
X-Received: by 2002:a9d:107:: with SMTP id 7mr5574092otu.48.1588368941638;
        Fri, 01 May 2020 14:35:41 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a7sm1110562otr.15.2020.05.01.14.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 14:35:41 -0700 (PDT)
Received: (nullmailer pid 16259 invoked by uid 1000);
        Fri, 01 May 2020 21:35:40 -0000
Date:   Fri, 1 May 2020 16:35:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Subject: Re: [PATCH v5 2/3] Add the bindings for the bq25150 and bq25155
 500mA charging ICs from Texas Instruments.
Message-ID: <20200501213540.GA15569@bogus>
References: <20200501175118.26226-1-dmurphy@ti.com>
 <20200501175118.26226-3-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501175118.26226-3-dmurphy@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 1 May 2020 12:51:17 -0500, Dan Murphy wrote:
> From: Ricardo Rivera-Matos <r-rivera-matos@ti.com>
> 
> Description:
> The BQ2515X family of devices are highly integrated battery management
> ICs that integrate the most common functions for wearbale devices
> namely a charger, an output voltage rail, ADC for battery and system
> monitoring, and a push-button controller.
> 
> Datasheets:
> http://www.ti.com/lit/ds/symlink/bq25150.pdf
> http://www.ti.com/lit/ds/symlink/bq25155.pdf
> 
> CC: Rob Herring <robh@kernel.org>
> Signed-off-by: Ricardo Rivera-Matos <r-rivera-matos@ti.com>
> ---
>  .../bindings/power/supply/bq2515x.yaml        | 99 +++++++++++++++++++
>  1 file changed, 99 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/bq2515x.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/power/supply/bq2515x.yaml:  while scanning a block scalar
  in "<unicode string>", line 81, column 5
found a tab character where an indentation space is expected
  in "<unicode string>", line 96, column 1
Documentation/devicetree/bindings/Makefile:11: recipe for target 'Documentation/devicetree/bindings/power/supply/bq2515x.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/power/supply/bq2515x.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/supply/bq2515x.yaml: ignoring, error parsing file
warning: no schema found in file: Documentation/devicetree/bindings/power/supply/bq2515x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/supply/bq2515x.yaml: ignoring, error parsing file
warning: no schema found in file: Documentation/devicetree/bindings/power/supply/bq2515x.yaml
Makefile:1300: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1281414

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
