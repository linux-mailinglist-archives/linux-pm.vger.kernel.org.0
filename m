Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A78B3F5E89
	for <lists+linux-pm@lfdr.de>; Tue, 24 Aug 2021 15:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237385AbhHXNCr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Aug 2021 09:02:47 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:37777 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbhHXNCr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Aug 2021 09:02:47 -0400
Received: by mail-ot1-f46.google.com with SMTP id i3-20020a056830210300b0051af5666070so36032765otc.4;
        Tue, 24 Aug 2021 06:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nq2TKOIgSc69+0//LnVTCDD2FbA4UcryAVmsJE5h7s8=;
        b=nxnBRF2fdY+3EK2ES/77KqQyIITS8FQKnCW2Dofs7MyBWfbTpBaCXKV/0NGyJAy7M5
         gmKHmHYcWdByAxhc6azB2LHPW1eOCrh60prR2QpdvxJU+463qFBVbL7BGvceZQWHBWzp
         P0olzLZPaUMVP0Lz5ltanTz3bawJwAHnBxYk7NRsKSqX5UtMiV9/cL72cD7UuYETcbFn
         NndCwSvyA/4xm2TJU7cc5CSwtYqdHM4COhdz3XWQNCZjly0+NhseRCPnqS9mnqO0NRRn
         kXT8zY4kMP9ei6L3fkVkqaA3OroRmTKbIZ0WkkVI32PisHHEqTVQUMSoG7otALpHuw9a
         IqLA==
X-Gm-Message-State: AOAM530n9lAcdEV7lSZsjXvq0E2XDFjOCRbC87hBCmj1vBM+DzEo1QU4
        Z5xx5DBZpwr7slK10Y8sLQ==
X-Google-Smtp-Source: ABdhPJwnmxSukvhOAW9b3+6xtREiix/Q5FnkejDGu9qUaLQHsZtTCoLYU1gYyvvySs8tiyqvh5F4pA==
X-Received: by 2002:a9d:222c:: with SMTP id o41mr31671166ota.100.1629810120582;
        Tue, 24 Aug 2021 06:02:00 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id r25sm3980754oos.24.2021.08.24.06.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 06:01:59 -0700 (PDT)
Received: (nullmailer pid 115306 invoked by uid 1000);
        Tue, 24 Aug 2021 13:01:58 -0000
Date:   Tue, 24 Aug 2021 08:01:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        devicetree@vger.kernel.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: devfreq: event: convert Samsung
 Exynos NoCP to dtschema
Message-ID: <YSTtxgAV1W1Yf8wZ@robh.at.kernel.org>
References: <20210820150353.161161-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820150353.161161-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 20 Aug 2021 17:03:50 +0200, Krzysztof Kozlowski wrote:
> Convert Samsung Exynos NoC Probe bindings to DT schema format using
> json-schema.
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
>  .../bindings/devfreq/event/exynos-nocp.txt    | 26 ----------
>  .../devfreq/event/samsung,exynos-nocp.yaml    | 48 +++++++++++++++++++
>  2 files changed, 48 insertions(+), 26 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/devfreq/event/exynos-nocp.txt
>  create mode 100644 Documentation/devicetree/bindings/devfreq/event/samsung,exynos-nocp.yaml
> 

Applied, thanks!
