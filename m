Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679A13930CA
	for <lists+linux-pm@lfdr.de>; Thu, 27 May 2021 16:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236511AbhE0OZP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 May 2021 10:25:15 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:43583 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236487AbhE0OZP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 May 2021 10:25:15 -0400
Received: by mail-ot1-f49.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso339959otu.10;
        Thu, 27 May 2021 07:23:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=7Xzx1Ap7uXPfBOML/npjPvMW+NbvnTtd/CjxfaN9vTA=;
        b=SfM7NLo/1JzdFVAm1j/cJAAqJeNNgk557IUbO/Rf0+B4jDeOR5S1xJzNwykRF/SeaY
         LO2Yj3Dyh9yNT2wAoPg06kSSuGCcDQAeHdKY1aCEcEkfzWCL0Itq7nj4Bly6nN5QooXG
         q7qJc5i/AlIWBwephzeUSKNq1iMZpSAOWsCKvOiwYBjEqcNxGPFOb6HNFV2QzMuOUbXx
         nd/IP4UglyA0u+0Bl62O8Wwl1tl3zagnnv6lagJc8RCVYu3Rf1OWizwZ+dvVOkqjwzzZ
         ei87tbiWxVbkJeqiKgHOqI9F7SERn2f9UIOiePQaNU8r6eozJ+tnfE6BOUsGMnzlvS11
         lisg==
X-Gm-Message-State: AOAM5339R+Z17H0EfLEtZp1TZAgVweaw0JOEqL2Scb3X9IWtZel60GOA
        Hfzv1Ul2z4yn4RLegcx0NiKcCVga+A==
X-Google-Smtp-Source: ABdhPJwO2qAwq+BaudGS4ht+Bx73RKcqrrecFHKoaEyr8S5895gmNT2goxvjFlZuQbC+7IirZ/hhDA==
X-Received: by 2002:a9d:37b6:: with SMTP id x51mr2887336otb.159.1622125421118;
        Thu, 27 May 2021 07:23:41 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k7sm451709ood.36.2021.05.27.07.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 07:23:38 -0700 (PDT)
Received: (nullmailer pid 731792 invoked by uid 1000);
        Thu, 27 May 2021 14:23:27 -0000
From:   Rob Herring <robh@kernel.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     devicetree@vger.kernel.org, ulf.hansson@linaro.org,
        linux-kernel@vger.kernel.org, viresh.kumar@linaro.org,
        bjorn.andersson@linaro.org, swboyd@chromium.org,
        robh+dt@kernel.org, linux-pm@vger.kernel.org, rojay@codeaurora.org,
        linux-arm-msm@vger.kernel.org
In-Reply-To: <1622095949-2014-2-git-send-email-rnayak@codeaurora.org>
References: <1622095949-2014-1-git-send-email-rnayak@codeaurora.org> <1622095949-2014-2-git-send-email-rnayak@codeaurora.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: power: Introduce 'assigned-performance-states' property
Date:   Thu, 27 May 2021 09:23:27 -0500
Message-Id: <1622125407.790558.731791.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 27 May 2021 11:42:27 +0530, Rajendra Nayak wrote:
> While most devices within power-domains which support performance states,
> scale the performance state dynamically, some devices might want to
> set a static/default performance state while the device is active.
> These devices typically would also run off a fixed clock and not support
> dynamically scaling the device's performance, also known as DVFS techniques.
> Add a property 'assigned-performance-states' which client devices can
> use to set this default performance state on their power-domains.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  .../devicetree/bindings/power/power-domain.yaml    | 50 ++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/power/power-domain.yaml:72:8: [warning] wrong indentation: expected 6 but found 7 (indentation)

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/power/power-domain.example.dt.yaml:0:0: /example-3/power-controller@43210000/opp-table: failed to match any schema with compatible: ['operating-points-v2']

See https://patchwork.ozlabs.org/patch/1484441

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

