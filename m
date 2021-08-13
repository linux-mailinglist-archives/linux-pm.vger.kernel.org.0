Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B373EBA5E
	for <lists+linux-pm@lfdr.de>; Fri, 13 Aug 2021 18:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhHMQuR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Aug 2021 12:50:17 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:43719 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhHMQuQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Aug 2021 12:50:16 -0400
Received: by mail-ot1-f46.google.com with SMTP id r16-20020a0568304190b02904f26cead745so12731503otu.10;
        Fri, 13 Aug 2021 09:49:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=tEn4MVEzF0W4BZNXTcFcLsDZ9oqFF1sqQqH38Cw3xN0=;
        b=tD7ZVXCnWWkV0PKItk2VYkuebsq0BQiaw91blGm+H2K9A9ZZwf6zo2vDO/tWQYwM/F
         NdBZ2HmqmdABne+IOZ6AwkbW89PEkqZ5CzKr9rD+cGIldN6v4vJEp1pr7x5Ky6ho22rV
         lKHTL4RACtUDRAeJN4j+q35sDxmfQ/J3HFtQKB9vDt0Q5p124C4iGGDv0vzMPwo6/KrA
         xjl8zwn02wVnyng96UTHz2NU/YRvEMipej3tjfUyEofllrzd7YLcoT01/hbCW2yKszs+
         tX7PP4EPvD8lBajBvF9ZSa+itQDZcMb7zF0QcuGydA1iCb/aBDiSzaLdhWo1rog6Fqu2
         g+4w==
X-Gm-Message-State: AOAM532UY7jggkO8/f1TJSxRu+MMc1rsOfpFC6cDpAsd3pPjasS1Nyh4
        KM1oXx3AkY0+jn527EWOhg==
X-Google-Smtp-Source: ABdhPJw60rnLvC2U06XFlPJd8fNDGFWvujytEhbYfBqUwRO06HTfZZ5hFfWSedttOheOvqon9OcLrQ==
X-Received: by 2002:a05:6830:18fc:: with SMTP id d28mr2874300otf.359.1628873388801;
        Fri, 13 Aug 2021 09:49:48 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s21sm346415ooh.44.2021.08.13.09.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 09:49:47 -0700 (PDT)
Received: (nullmailer pid 3650551 invoked by uid 1000);
        Fri, 13 Aug 2021 16:49:46 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20210813125414.104467-1-krzysztof.kozlowski@canonical.com>
References: <20210813125414.104467-1-krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH] dt-bindings: memory: convert Samsung Exynos DMC to dtschema
Date:   Fri, 13 Aug 2021 11:49:46 -0500
Message-Id: <1628873386.475685.3650550.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 13 Aug 2021 14:54:14 +0200, Krzysztof Kozlowski wrote:
> Convert Samsung Exynos5422 SoC frequency and voltage scaling for
> Dynamic Memory Controller to DT schema format using json-schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../memory-controllers/exynos5422-dmc.txt     |  84 -----------
>  .../samsung,exynos5422-dmc.yaml               | 137 ++++++++++++++++++
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 138 insertions(+), 85 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/samsung,exynos5422-dmc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/memory-controllers/samsung,exynos5422-dmc.example.dt.yaml:0:0: /example-0/ppmu@10d00000: failed to match any schema with compatible: ['samsung,exynos-ppmu']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1516650

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

