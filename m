Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67EC43F4BBB
	for <lists+linux-pm@lfdr.de>; Mon, 23 Aug 2021 15:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236601AbhHWNa6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Aug 2021 09:30:58 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:38577 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236500AbhHWNa5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Aug 2021 09:30:57 -0400
Received: by mail-ot1-f52.google.com with SMTP id i8-20020a056830402800b0051afc3e373aso25030288ots.5;
        Mon, 23 Aug 2021 06:30:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=iiv72/nQWXCe/87w/Jb+2Fek9hSQXeEy+qB5a7fxLf4=;
        b=LFPi6jz5w1rh2TCXDp4kK9yFJdp+NUYaGAo733vBuQtW3HCmxhT6S0jnzSgvzCLTQs
         RLwxULZCaLDwt93YgrHVG4aGsoIQxV02EZYifvxrxHbbx3jONBOu5BROYD5w3e/4OXGX
         ixTAJHKTigDZ8K2K2D8vYir+bibn+TzUumSv/9Phn2cxUNW9dMd1r8OXcj5nVITrW67I
         6WuZbYGVEN2VUFkaPo2vKWm7kC3hQZjwrloJx6OGLIWZ/UU57y9pDbfjsNDFWEu0098z
         /ofAMhmvTeYXlaZk4HOihD4fbWtHEUaT2u/ohqOxQRzZw8mbmX+V7Vv2FJcXPklaihCU
         03zw==
X-Gm-Message-State: AOAM5303dvDpgGUO6DJ0sTXYXDBlBBq7l13xKwCFOGzbtPY5hGOB0GHJ
        dpNk74ABOi6aWs305FZw1Q==
X-Google-Smtp-Source: ABdhPJyM+8dFLWQ0QkebALBaF+uKzzamIDcL8Dd+q2yCTk6HOQAvDjc7ckjLv9M7qD2g044s27KsVw==
X-Received: by 2002:a9d:7653:: with SMTP id o19mr27659798otl.236.1629725414976;
        Mon, 23 Aug 2021 06:30:14 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id f3sm4051518otc.49.2021.08.23.06.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 06:30:14 -0700 (PDT)
Received: (nullmailer pid 1982765 invoked by uid 1000);
        Mon, 23 Aug 2021 13:30:13 -0000
From:   Rob Herring <robh@kernel.org>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20210823095603.5538-2-shawn.guo@linaro.org>
References: <20210823095603.5538-1-shawn.guo@linaro.org> <20210823095603.5538-2-shawn.guo@linaro.org>
Subject: Re: [PATCH 1/3] dt-bindings: interconnect: sdm660: Add missing a2noc qos clocks
Date:   Mon, 23 Aug 2021 08:30:13 -0500
Message-Id: <1629725413.492048.1982764.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 23 Aug 2021 17:56:01 +0800, Shawn Guo wrote:
> It adds the missing a2noc clocks required for QoS registers programming
> per downstream kernel[1].
> 
> [1] https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/arch/arm/boot/dts/qcom/sdm660-bus.dtsi?h=LA.UM.8.2.r1-04800-sdm660.0#n43
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  .../bindings/interconnect/qcom,sdm660.yaml    | 41 ++++++++++++++++++-
>  1 file changed, 39 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/interconnect/qcom,sdm660.example.dts:63.32-33 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:380: Documentation/devicetree/bindings/interconnect/qcom,sdm660.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1419: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1519617

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

