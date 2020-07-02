Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEEE9212E44
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jul 2020 22:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgGBUxX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jul 2020 16:53:23 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44792 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGBUxX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jul 2020 16:53:23 -0400
Received: by mail-io1-f66.google.com with SMTP id i4so30313875iov.11;
        Thu, 02 Jul 2020 13:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oh0ojXSvKscMca+XjhHcGyOP8dOhT/m5i/K/haYmk+E=;
        b=SrRb5TxnF/+5ymNYfOOnVnRO2RSJ+vFc9VO7FkVIb0yhYfU/lrGT0k12BZyK4RyLxo
         n4cljSB1DUngJolj8G18QVMKZOgWMFc+3l/Yi6zsJ6mcU7R7oXKrsJ/Av3bsFSdtY2Na
         2/Sla6pc1Yzt7neyfMkPlTbvqe9yxrhwaD3J1ahR8caTIrBlhsXGvu0O6jyyIeqAyRd3
         6QsdC2iFv06qsvtiR8TWNDhcahI2/rWKg1pYyU7zUpzxhcp1QUNZ9YKL2XWv4EXY0mw+
         hqW9oLFcJA3rrl+AFi3qR6z1mvD91l34rmIS0psnQ7jsrYWOQGXVdjIVOtnKSwglK+MH
         5h+Q==
X-Gm-Message-State: AOAM5326aZSayDwIb5sMaeiRd4KDP0VyCSNC6i+HYDMlzvbLLAr/Hw0W
        riueVWxx3Y6UI6kny44Xhg==
X-Google-Smtp-Source: ABdhPJx/TmnR0LTk/pC3KSj9IjuHHg3LMmIVMg2xX2biyKHnhrUV9Nv30tL/EfzFIU3xAf94ER1kDA==
X-Received: by 2002:a5e:9309:: with SMTP id k9mr9038052iom.135.1593723201897;
        Thu, 02 Jul 2020 13:53:21 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id l10sm5458644ilc.52.2020.07.02.13.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 13:53:21 -0700 (PDT)
Received: (nullmailer pid 1674380 invoked by uid 1000);
        Thu, 02 Jul 2020 20:53:20 -0000
Date:   Thu, 2 Jul 2020 14:53:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Cc:     pali@kernel.org, linux-pm@vger.kernel.org, sspatil@android.com,
        linux-kernel@vger.kernel.org, afd@ti.com, dmurphy@ti.com,
        sre@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v15 2/4] dt-bindings: power: Convert battery.txt to
 battery.yaml
Message-ID: <20200702205320.GA1672139@bogus>
References: <20200701211044.18590-1-r-rivera-matos@ti.com>
 <20200701211044.18590-3-r-rivera-matos@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701211044.18590-3-r-rivera-matos@ti.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 01 Jul 2020 16:10:42 -0500, Ricardo Rivera-Matos wrote:
> From: Dan Murphy <dmurphy@ti.com>
> 
> Convert the battery.txt file to yaml and fix up the examples.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  .../bindings/power/supply/battery.txt         |  86 +---------
>  .../bindings/power/supply/battery.yaml        | 157 ++++++++++++++++++
>  2 files changed, 158 insertions(+), 85 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/battery.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Unknown file referenced: [Errno 2] No such file or directory: '/usr/local/lib/python3.6/dist-packages/dtschema/schema/types.yaml'
Documentation/devicetree/bindings/Makefile:20: recipe for target 'Documentation/devicetree/bindings/power/supply/battery.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/power/supply/battery.example.dts] Error 255
make[1]: *** Waiting for unfinished jobs....
Makefile:1347: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1320813

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

