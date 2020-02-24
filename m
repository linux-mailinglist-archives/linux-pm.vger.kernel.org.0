Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA02816AF63
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 19:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgBXSkG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Feb 2020 13:40:06 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34622 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbgBXSkG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Feb 2020 13:40:06 -0500
Received: by mail-ot1-f66.google.com with SMTP id j16so9680542otl.1;
        Mon, 24 Feb 2020 10:40:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bmMsO8zlhfDBXeD1Ui5z4nfH2lAIx0D2PEMJ+/JnHXU=;
        b=ih0HDgQ7SByC9FkVNsyAS/Zpkj8okRneRRAARWBM0x0nbWuRWieOrYs2uUVbRuiTV7
         sAdXE/4cAvg6iKYiHvv/9t/GnUdwP3GfECBgJCw6fpaLTkLaSUp2ihQKam2nTZNi7GxN
         Bv2UzxENuIm/ejbsIZ+oKjl/X3AbdCpyFTAkh9B5OzXtaxuLH5H2yVYiE2K6/6MWts69
         4kUfXRwbreZunazIAKRXeYh5T2/1FyI3MPlQ7XM/wxvG/6POffoNdVksx2LgmREPhnXD
         GZ9WEgQ8WCpfZyjXZMNMukAcWgzYDrzfOzc3ip3RHOfL2Ts5ywyk3Idnt7YaPIXqEhrV
         JOqQ==
X-Gm-Message-State: APjAAAXAJYARRfDBUSKFV0+DB49f27xCyM5mvTBmRSri7KiT8i1DmArh
        ytIccxiiRS2lwO834laQDQ==
X-Google-Smtp-Source: APXvYqyG6ueUZmR3C1vGNtlbivBqFpkBHQuuCOLIGlv1vRi+ocXBU3uxirn1DsXLCV/bF2L7rqDPag==
X-Received: by 2002:a05:6830:139a:: with SMTP id d26mr42724177otq.75.1582569604945;
        Mon, 24 Feb 2020 10:40:04 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m19sm4737721otn.47.2020.02.24.10.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 10:40:04 -0800 (PST)
Received: (nullmailer pid 4013 invoked by uid 1000);
        Mon, 24 Feb 2020 18:40:03 -0000
Date:   Mon, 24 Feb 2020 12:40:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, mka@chromium.org, daniel.lezcano@linaro.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [RFC PATCH v1 3/3] dt-bindings: thermal: Add yaml bindings for
 thermal zones
Message-ID: <20200224184003.GA3607@bogus>
References: <cover.1582528977.git.amit.kucheria@linaro.org>
 <59d24f8ec98e29d119c5cbdb2abe6d4644cc51cf.1582528977.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59d24f8ec98e29d119c5cbdb2abe6d4644cc51cf.1582528977.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 24 Feb 2020 12:55:37 +0530, Amit Kucheria wrote:
> As part of moving the thermal bindings to YAML, split it up into 3
> bindings: thermal sensors, cooling devices and thermal zones.
> 
> The thermal-zone binding is a software abstraction to capture the
> properties of each zone - how often they should be checked, the
> temperature thresholds (trips) at which mitigation actions need to be
> taken and the level of mitigation needed at those thresholds.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  .../bindings/thermal/thermal-zones.yaml       | 302 ++++++++++++++++++
>  1 file changed, 302 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-zones.example.dt.yaml: thermal-sensor@c263000: interrupt-names: ['uplow'] is too short
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-zones.example.dt.yaml: thermal-sensor@c263000: interrupts: [[0, 506, 4]] is too short
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-zones.example.dt.yaml: thermal-sensor@c265000: interrupt-names: ['uplow'] is too short
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-zones.example.dt.yaml: thermal-sensor@c265000: interrupts: [[0, 507, 4]] is too short

See https://patchwork.ozlabs.org/patch/1242847
Please check and re-submit.
