Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418E73A1AC3
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jun 2021 18:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbhFIQTP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Jun 2021 12:19:15 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:46802 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237541AbhFIQTE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Jun 2021 12:19:04 -0400
Received: by mail-oi1-f169.google.com with SMTP id c13so20050333oib.13;
        Wed, 09 Jun 2021 09:16:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=QqWyDoHhoXoYqgs2T5kEgvQV6Y0xJvZ2rX9HVCOuEYs=;
        b=Q2sQVy2i3XXbHm5UreuDl3jwFgT5Q5ylXYXljYKZu8sF+iZ78jk131BeHXlM/0aiI0
         88/3B3rewxcPR+Ces8MRUnU++36ImLQ4p9cgxcKjvdejqlwBwYij2cF2am3Bztpj2fyx
         j5SXqMxQ5Rr0nY9f0NoFCnbhqBVoVf21PBUBaPi2L5CVtzQuZVQ8bUDjvPV/PDjPk2E7
         dr9LDryIYut6cA1lDzRfSNUQCRXFpSDZiIAuLalQq/HLzFIU+RLU/sUnUiNKQEvJkMw/
         ekaFNzn8H2PdLvS4TFSC5eAVKXVRp1S3d2KqQtZ8JRRV8RZjSYyysG6oqm9JNcpqPHc+
         tvDA==
X-Gm-Message-State: AOAM532wAz6waOWqHHrhg4czqZhqMIaWsI823/WKNmlcQZPNIe4rceJu
        oPnlR4FuU2MVquJEBEEBSiemLWDNMw==
X-Google-Smtp-Source: ABdhPJzsAd6hH99fyWkSdFSubrSBtcEU6Syfei/UK9V4M+8nsK/xgWCP3h2i6sLExsfayBEMCekg5w==
X-Received: by 2002:aca:3e06:: with SMTP id l6mr270687oia.147.1623255412952;
        Wed, 09 Jun 2021 09:16:52 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i15sm86906ots.39.2021.06.09.09.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 09:16:52 -0700 (PDT)
Received: (nullmailer pid 3763296 invoked by uid 1000);
        Wed, 09 Jun 2021 16:16:43 -0000
From:   Rob Herring <robh@kernel.org>
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-riscv@lists.infradead.org,
        Sandeep Tripathy <milun.tripathy@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Atish Patra <atish.patra@wdc.com>, linux-pm@vger.kernel.org,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liush <liush@allwinnertech.com>, Pavel Machek <pavel@ucw.cz>
In-Reply-To: <20210609122715.3389-8-anup.patel@wdc.com>
References: <20210609122715.3389-1-anup.patel@wdc.com> <20210609122715.3389-8-anup.patel@wdc.com>
Subject: Re: [PATCH v6 7/8] dt-bindings: Add common bindings for ARM and RISC-V idle states
Date:   Wed, 09 Jun 2021 11:16:43 -0500
Message-Id: <1623255403.618479.3763295.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 09 Jun 2021 17:57:14 +0530, Anup Patel wrote:
> The RISC-V CPU idle states will be described in under the
> /cpus/idle-states DT node in the same way as ARM CPU idle
> states.
> 
> This patch adds common bindings documentation for both ARM
> and RISC-V idle states.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/{arm => cpu}/idle-states.yaml    | 228 ++++++++++++++++--
>  .../devicetree/bindings/riscv/cpus.yaml       |   6 +
>  2 files changed, 217 insertions(+), 17 deletions(-)
>  rename Documentation/devicetree/bindings/{arm => cpu}/idle-states.yaml (74%)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:

\ndoc reference errors (make refcheckdocs):
Warning: Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt references a file that doesn't exist: Documentation/devicetree/bindings/arm/idle-states.yaml
Warning: Documentation/devicetree/bindings/arm/psci.yaml references a file that doesn't exist: Documentation/devicetree/bindings/arm/idle-states.yaml
Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt: Documentation/devicetree/bindings/arm/idle-states.yaml
Documentation/devicetree/bindings/arm/psci.yaml: Documentation/devicetree/bindings/arm/idle-states.yaml

See https://patchwork.ozlabs.org/patch/1489849

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

