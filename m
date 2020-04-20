Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A25D1B1827
	for <lists+linux-pm@lfdr.de>; Mon, 20 Apr 2020 23:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgDTVOv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Apr 2020 17:14:51 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35566 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgDTVOv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Apr 2020 17:14:51 -0400
Received: by mail-oi1-f194.google.com with SMTP id o7so8402990oif.2;
        Mon, 20 Apr 2020 14:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D1tmHbhZ2ad6HfaZfQo7QhxzoWrXJ0tmAqtcSp3UnAM=;
        b=nH2CRbxkPXWfzz/GD0YxPC1D5NVg+i1GZyQ4lxy8WGFT291+CSHqW7A8tTi9mKqQCt
         GpAOW/e/gnOoZCCiyt8PqbWL7josMstTBisC9xE4mh2wU73DfhXWC+PCotOQ3yBL+aLG
         /CI/0QWzI3CVsp2cGRrrJ5bWgFZ+xrrRjyNVzvUU3TSerugE9fqkEWYAUSHnSRk98jFl
         hV/xeddpa0MK86mqGMScVaTNFpcPNFKJvVUI02k7aM6hfJczSO+0aA0RbBWUljFib8PP
         ez5gzBWPY82Ct9OiFSEue3o3Fn8OzSIF26xu4eBOqBijscaheuni52aGptwfUYICy6d6
         JVgg==
X-Gm-Message-State: AGi0PubSfp80f2ce4WZaQikFgBoFFApHB/DdYozJ78txfwYD5K/cH5W0
        BxW3D2IVOaZXJ+uM7Q0ag3blN8o=
X-Google-Smtp-Source: APiQypIkgLf6iD08sZH0/MtRvDvHFkYHoX7Vn2cb2zxQrUsjpbFpA36SjP9PNXqkcKUzsyvr79uq9A==
X-Received: by 2002:aca:c495:: with SMTP id u143mr1065353oif.72.1587417289983;
        Mon, 20 Apr 2020 14:14:49 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t9sm154233oie.24.2020.04.20.14.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 14:14:49 -0700 (PDT)
Received: (nullmailer pid 16562 invoked by uid 1000);
        Mon, 20 Apr 2020 21:14:48 -0000
Date:   Mon, 20 Apr 2020 16:14:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     daniel.lezcano@linaro.org, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, Mark Rutland <mark.rutland@arm.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] dt-bindings: thermal: Add the idle cooling device
Message-ID: <20200420211448.GA16458@bogus>
References: <20200414220837.9284-1-daniel.lezcano@linaro.org>
 <20200414220837.9284-2-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414220837.9284-2-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 15 Apr 2020 00:08:31 +0200, Daniel Lezcano wrote:
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
>  - V3:
>    - Removed extra line with tab inside
>  - V2:
>    - Fixed comment type
>    - Added dual license
>    - Fixed description s/begins to/should/
>    - Changed name s/duration/duration-us/
>    - Changed name s/latency/exit-latency-us/
>    - Removed types for latency / duration
>    - Fixed s/idle-thermal/thermal-idle/
> ---
>  .../bindings/thermal/thermal-idle.yaml        | 145 ++++++++++++++++++
>  1 file changed, 145 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/thermal-idle.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
