Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62193F5E92
	for <lists+linux-pm@lfdr.de>; Tue, 24 Aug 2021 15:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbhHXNDY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Aug 2021 09:03:24 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:38752 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237417AbhHXNDY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Aug 2021 09:03:24 -0400
Received: by mail-ot1-f44.google.com with SMTP id i8-20020a056830402800b0051afc3e373aso34531925ots.5;
        Tue, 24 Aug 2021 06:02:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yPcEt7/cRX2jm750tfjRnbvG0G7G/qHfIydVdxz+S2Q=;
        b=nOgn7sQTb8xF/3pX4mW1NqRr9bTKkviEiuJIFnKod+8i+m3lm8BFz/04wJGF/FlnJN
         dRhtT/sfHGbnweRYXjG9gANMYBWUyI+1tjK3v3h44hSIy2aJXldSIVDDpf43BZad3+m+
         I5orE/jGyXf1iwKvXt8IKri0KUkB7d2zDvb8eYyBlnusoEVi/oHcD5TY566uG+Oj3vu4
         k9MHCWRwGho5aLLRjDm4cGUfoQXblU69L5BI64yZtFUOBSdDGVqyxt1guFEWyJKBpCr7
         HQv2XL6aaGBSPrlWoutSm7d2Z5Eng5qXKv8JJAWJQ5pjkI7gzKp5/8PoSMSighypHN7B
         2Dkg==
X-Gm-Message-State: AOAM530bwYG518/HYaHrro5l00PkvebBGx58LDLrPUwqM9N+FuRKpqyS
        osG1exAaPOUv86zI3nVPlw==
X-Google-Smtp-Source: ABdhPJy8Jsu7Ckl0+sjPP66tDsH2TxKk6kBNHxo3tlnXLFSL3QK2Yo5ABg9CKvsRr/wW8j7CTgeYxQ==
X-Received: by 2002:a05:6830:214c:: with SMTP id r12mr31867852otd.200.1629810159544;
        Tue, 24 Aug 2021 06:02:39 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 33sm4379993ott.19.2021.08.24.06.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 06:02:38 -0700 (PDT)
Received: (nullmailer pid 116827 invoked by uid 1000);
        Tue, 24 Aug 2021 13:02:37 -0000
Date:   Tue, 24 Aug 2021 08:02:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/4] dt-bindings: memory: convert Samsung Exynos DMC
 to dtschema
Message-ID: <YSTt7Q7Gfv/T9PeO@robh.at.kernel.org>
References: <20210820150353.161161-1-krzysztof.kozlowski@canonical.com>
 <20210820150353.161161-3-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820150353.161161-3-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 20 Aug 2021 17:03:52 +0200, Krzysztof Kozlowski wrote:
> Convert Samsung Exynos5422 SoC frequency and voltage scaling for
> Dynamic Memory Controller to DT schema format using json-schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Acked-by: Lukasz Luba <lukasz.luba@arm.com>
> 
> ---
> 
> Changes since v1:
> 1. Corrent PPMU event node name (remove underscore).
> 2. Add Ack.
> ---
>  .../memory-controllers/exynos5422-dmc.txt     |  84 -----------
>  .../samsung,exynos5422-dmc.yaml               | 137 ++++++++++++++++++
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 138 insertions(+), 85 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/samsung,exynos5422-dmc.yaml
> 

Applied, thanks!
