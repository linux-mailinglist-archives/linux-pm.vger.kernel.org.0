Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA03744C948
	for <lists+linux-pm@lfdr.de>; Wed, 10 Nov 2021 20:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbhKJTr2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Nov 2021 14:47:28 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:42974 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbhKJTrO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Nov 2021 14:47:14 -0500
Received: by mail-oi1-f182.google.com with SMTP id n66so7243201oia.9;
        Wed, 10 Nov 2021 11:44:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=PWYGAVGAa4OmQjHBrfYueh1qVok7v9Q7bchlBqeE0Is=;
        b=q+VWBQhPNtv81R0awcP6wjA6rCBV1bYxIrCz3Kt9Arma5C5O4dPynvBpDzVJphh+lQ
         /2uIxLK5BesRXDvXBFBAGj2X+QJ/clEPnqGu0qqKafcDNfyF5KVhVBJX5eIS5TecxDk/
         S6YcHeeBQ5l+cA5u1uD3hsBLKH4w1cHi2cRYpgMDr7IL2xTjetTkSwd3Ud02vG6jNXtp
         P1v8WkwmQxWTg5+Es9K+234yynWdQiNwwl2qaen1wzBvsMrhzDUE6+n/svC4iakuqQ/P
         KYlpb2bSLiYA0mQLb5qrjoSJRsO7MTBdjx+6dOyjNG79+SFu6/BuhXXSdbQDY5RUMF91
         z3Kw==
X-Gm-Message-State: AOAM53206cFAlTC666uoge4Buh40++SJsLZrfHeh7cvpYasZJOYPqvZc
        IoB1W9P1s3DIhPBkek+fRg==
X-Google-Smtp-Source: ABdhPJx5hf7+JaWUtnKl1lTMYWOOqV0Ndfp17JshlWQb6ln0RW7bmree3bBTV0pVVk8UJ71HplKHhg==
X-Received: by 2002:a05:6808:1641:: with SMTP id az1mr14582249oib.67.1636573465825;
        Wed, 10 Nov 2021 11:44:25 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id n189sm94013oif.33.2021.11.10.11.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 11:44:25 -0800 (PST)
Received: (nullmailer pid 1783739 invoked by uid 1000);
        Wed, 10 Nov 2021 19:44:20 -0000
From:   Rob Herring <robh@kernel.org>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20211110120716.6401-6-shawn.guo@linaro.org>
References: <20211110120716.6401-1-shawn.guo@linaro.org> <20211110120716.6401-6-shawn.guo@linaro.org>
Subject: Re: [PATCH 5/6] dt-bindings: interconnect: Add Qualcomm QCM2290 NoC support
Date:   Wed, 10 Nov 2021 13:44:20 -0600
Message-Id: <1636573460.901134.1783738.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 10 Nov 2021 20:07:15 +0800, Shawn Guo wrote:
> Add bindings for Qualcomm QCM2290 Network-On-Chip interconnect devices.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  .../bindings/interconnect/qcom,qcm2290.yaml   | 117 ++++++++++++++++++
>  .../dt-bindings/interconnect/qcom,qcm2290.h   |  94 ++++++++++++++
>  2 files changed, 211 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml
>  create mode 100644 include/dt-bindings/interconnect/qcom,qcm2290.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/interconnect/qcom,qcm2290.example.dts:20:18: fatal error: dt-bindings/clock/qcom,gcc-qcm2290.h: No such file or directory
   20 |         #include <dt-bindings/clock/qcom,gcc-qcm2290.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:385: Documentation/devicetree/bindings/interconnect/qcom,qcm2290.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1441: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1553401

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

