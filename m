Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DAF3884ED
	for <lists+linux-pm@lfdr.de>; Wed, 19 May 2021 04:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237471AbhESCte (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 May 2021 22:49:34 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:38650 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237274AbhESCtd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 May 2021 22:49:33 -0400
Received: by mail-ot1-f49.google.com with SMTP id q7-20020a9d57870000b02902a5c2bd8c17so10502951oth.5;
        Tue, 18 May 2021 19:48:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Q4LcyG7TR1wlU65C0tMqAS7GQ9Qzklf/Ua5vm6bP0dY=;
        b=kBf1wdaFlurEs4ItIqW4b39n51OaGMkHtLJMebu0IxJq7Ut57VErSsUG2ImAr0/LkL
         6oJ7HtYP0dU4rCub5rs/M5BZeycN3Tpzh/yciz5eOModxUNQy1Fl6d/QTFtI0frRoq6O
         5NMPnUEutkw9rAQlr33955Qx4VKC4hPEuS5OGFA8kvobCVYuTgg8PMPGBZKSf7G5VBLe
         E79XFtV26uMb2VS6R4Yn/Rfs8gfdZv9dTa66gmsxmqNcvew9aWAckwWYXLXgKfSjGHHp
         Wxxhs2beVxG36oT6QQ9qCjPrbITriVuHuukEfB89wqAacMQwdCOIAo0tmfCTi9ZOtjOX
         ODew==
X-Gm-Message-State: AOAM532ozCSL+wHJ73O5OSfVQa6neqrUXXiWP47mpGA10axUxDnhUB69
        gDzTddJKsmRmHoW3z88y1A==
X-Google-Smtp-Source: ABdhPJx3BlvLuylgzd5eRpyEpXh47BO/eHtxDBU1//TMyqLZFNXTI3iRXR5JOdrQYhqAlyt6R2LmPw==
X-Received: by 2002:a9d:62d0:: with SMTP id z16mr559268otk.180.1621392493120;
        Tue, 18 May 2021 19:48:13 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x14sm3853076oic.3.2021.05.18.19.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 19:48:12 -0700 (PDT)
Received: (nullmailer pid 1905258 invoked by uid 1000);
        Wed, 19 May 2021 02:48:11 -0000
From:   Rob Herring <robh@kernel.org>
To:     Odelu Kukatla <okukatla@codeaurora.org>
Cc:     elder@linaro.org, bjorn.andersson@linaro.org,
        seansw@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org, devicetree@vger.kernel.org,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, sboyd@kernel.org,
        sibis@codeaurora.org, Andy Gross <agross@kernel.org>,
        evgreen@google.com, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm-owner@vger.kernel.org, linux-pm@vger.kernel.org
In-Reply-To: <1621359242-18641-2-git-send-email-okukatla@codeaurora.org>
References: <1621359242-18641-1-git-send-email-okukatla@codeaurora.org> <1621359242-18641-2-git-send-email-okukatla@codeaurora.org>
Subject: Re: [V2 1/3] dt-bindings: interconnect: Add EPSS L3 DT binding on SC7280
Date:   Tue, 18 May 2021 21:48:11 -0500
Message-Id: <1621392491.220233.1905257.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 18 May 2021 23:04:00 +0530, Odelu Kukatla wrote:
> Add Epoch Subsystem (EPSS) L3 interconnect provider binding on SC7280
> SoCs.
> 
> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
> ---
>  .../devicetree/bindings/interconnect/qcom,osm-l3.yaml          |  3 ++-
>  include/dt-bindings/interconnect/qcom,osm-l3.h                 | 10 +++++++++-
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.example.dt.yaml: interconnect@17d41000: reg: [[399773696, 5120]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml

See https://patchwork.ozlabs.org/patch/1480367

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

