Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933B13F5E90
	for <lists+linux-pm@lfdr.de>; Tue, 24 Aug 2021 15:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237228AbhHXNDW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Aug 2021 09:03:22 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:40671 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbhHXNDW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Aug 2021 09:03:22 -0400
Received: by mail-ot1-f44.google.com with SMTP id x9-20020a056830278900b0051b8be1192fso25075196otu.7;
        Tue, 24 Aug 2021 06:02:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9VWjrEJ3/Xa2p+Cprxr7GKsxNrb6LxrOwwoVXbs42sE=;
        b=tdNGSY99W3gALjxNDynWTyFXRtfIpEQSNMRhLlbXjYe+VSmTOFbq0yHta4AtoLbg5q
         1PITSwGQZXzqyeyQXtBb9KU+TrVyQccSWUXyAZpv4gHMI5Raw6bQPh4grK/husJEs4mf
         xBd0Tf6FXrPAxek94dY3XyN5xQfcKBuX5Ftpzd7DbtbRu+H4xdByRaUOCkuIJwxf2skY
         f03OmTcTPMehTECMt2lCKcD0jJ0wtQdPox+RApfzPj8+td8bPLyG3mp6F3x+7hi69iZ7
         nMLq0C9OW3eGW3uEeSpveSHKuJgDXxUKbL2Cb1IsUkb11Ak9aRwQp8kcp4kBzfYG/Xeg
         eQ1g==
X-Gm-Message-State: AOAM530FLd8jTLhZdgKXiBwhJNTZNrKsygut7Wt8zoeYhou2nPgr/1go
        rNfGI6gWjPYi1kLnzGj/TdxRkwigbg==
X-Google-Smtp-Source: ABdhPJxzwPQIJdxG9G43iauhYy2EROKwV/KvICmrw72FrW3H0mVF2bQE/lHfRazN3bsmDnABxF6jNw==
X-Received: by 2002:aca:1e05:: with SMTP id m5mr2703366oic.29.1629810139988;
        Tue, 24 Aug 2021 06:02:19 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id y138sm4356945oie.22.2021.08.24.06.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 06:02:18 -0700 (PDT)
Received: (nullmailer pid 116039 invoked by uid 1000);
        Tue, 24 Aug 2021 13:02:17 -0000
Date:   Tue, 24 Aug 2021 08:02:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-pm@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: devfreq: event: convert Samsung
 Exynos PPMU to dtschema
Message-ID: <YSTt2d5uIfXhjuQd@robh.at.kernel.org>
References: <20210820150353.161161-1-krzysztof.kozlowski@canonical.com>
 <20210820150353.161161-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820150353.161161-2-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 20 Aug 2021 17:03:51 +0200, Krzysztof Kozlowski wrote:
> Convert Samsung Exynos PPMU bindings to DT schema format using
> json-schema.  The example is quite different due to the nature of
> dtschema examples parsing (no overriding via-label allowed).
> 
> New bindings contain copied description from previous bindings document,
> therefore the license is set as GPL-2.0-only.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> ---
> 
> Changes since v1:
> 1. New patch
> ---
>  .../bindings/devfreq/event/exynos-ppmu.txt    | 169 -----------------
>  .../devfreq/event/samsung,exynos-ppmu.yaml    | 174 ++++++++++++++++++
>  2 files changed, 174 insertions(+), 169 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
>  create mode 100644 Documentation/devicetree/bindings/devfreq/event/samsung,exynos-ppmu.yaml
> 

Applied, thanks!
