Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72D4F16AF5A
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 19:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgBXSjr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Feb 2020 13:39:47 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39045 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbgBXSjr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Feb 2020 13:39:47 -0500
Received: by mail-oi1-f195.google.com with SMTP id 18so6959773oij.6;
        Mon, 24 Feb 2020 10:39:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mJFZ+9Y1S3Z4K4VY5LKYC3aMRkdeTsjXfkgcvM8Uwqc=;
        b=QW+Nfskcw+tUK9RR6/XVvFiU30x5/22pC/Ze7PrrIVv3KWjHXCtsrPgeHUfuy/BPjp
         pWwsFpoNFo7e3hZIBCdm1qaX2vSE8gEmZjiXc+faGnet0NdCgQZ8NW44ATyS5btLzSSH
         VGUYWfG9yX7h/ZJVOkya33djL1wTHMYdEw3z9NS0NdhLbE5/hAYDPgmhp/j6lU8x1IWQ
         ySt2mC7KPsx+Pob6ZK+kdFypA8ZHkilsMc+wAAX9oMAaB9sk+jlJdEC9hpl3hwCzbnSm
         aviG4r58O8z/hMylJEBdm+QhdRzgAUpdZF/B8YBZmTgz8MiK8Mdg0aPpVh/8PGqRLoIj
         xfBQ==
X-Gm-Message-State: APjAAAWhHPC6xOwbdXIqkPStf7qvRR9+emKH6PVdf50A8eKX4ajrJ+cT
        hqMtH0I23NeZeOflE9hsyg==
X-Google-Smtp-Source: APXvYqz/hPnka3x3uNnqj0ZN65CwvYlszHLNQqni4E+Ly0QlI++rlZAIObzFHIExjC+HN53ZmD00wg==
X-Received: by 2002:a05:6808:b13:: with SMTP id s19mr318669oij.119.1582569585986;
        Mon, 24 Feb 2020 10:39:45 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s83sm4265727oif.33.2020.02.24.10.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 10:39:45 -0800 (PST)
Received: (nullmailer pid 3349 invoked by uid 1000);
        Mon, 24 Feb 2020 18:39:44 -0000
Date:   Mon, 24 Feb 2020 12:39:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, mka@chromium.org, daniel.lezcano@linaro.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/3] dt-bindings: thermal: Add yaml bindings for
 thermal sensors
Message-ID: <20200224183944.GA2201@bogus>
References: <cover.1582528977.git.amit.kucheria@linaro.org>
 <11f9128efef92b427d93a563d5b53b62c4c01888.1582528977.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11f9128efef92b427d93a563d5b53b62c4c01888.1582528977.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 24 Feb 2020 12:55:35 +0530, Amit Kucheria wrote:
> As part of moving the thermal bindings to YAML, split it up into 3
> bindings: thermal sensors, cooling devices and thermal zones.
> 
> The property #thermal-sensor-cells is required in each device that acts
> as a thermal sensor. It is used to uniquely identify the instance of the
> thermal sensor inside the system.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  .../bindings/thermal/thermal-sensor.yaml      | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/thermal-sensor.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-sensor.example.dt.yaml: thermal-sensor@c263000: interrupt-names: ['uplow'] is too short
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-sensor.example.dt.yaml: thermal-sensor@c263000: interrupts: [[0, 506, 4]] is too short
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-sensor.example.dt.yaml: thermal-sensor@c265000: interrupt-names: ['uplow'] is too short
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-sensor.example.dt.yaml: thermal-sensor@c265000: interrupts: [[0, 507, 4]] is too short

See https://patchwork.ozlabs.org/patch/1242845
Please check and re-submit.
