Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9DAA4BEFD6
	for <lists+linux-pm@lfdr.de>; Tue, 22 Feb 2022 04:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbiBVDEH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Feb 2022 22:04:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbiBVDEG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Feb 2022 22:04:06 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF2625E89
        for <linux-pm@vger.kernel.org>; Mon, 21 Feb 2022 19:03:41 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id m1-20020a17090a668100b001bc023c6f34so987848pjj.3
        for <linux-pm@vger.kernel.org>; Mon, 21 Feb 2022 19:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q1rax7G4k5CCLSu09IqEgCbCj8ZVR2NTHSH1BgrxHe0=;
        b=PsL08C81Kelj7c9r8L29y7wGb0vEXUN5Yj445KMSVmi2wK6HbjzM/Tc27bBhLH3Puv
         aeEYS0SCq8aZgZC2Ii+ivfgo88TwtACOBCdKHiDRdhjKtDXwSS2bGfdZi9V/VCrv5QNF
         w3Tgdx1lOdq3kATph5xRTiwzd1Pw8aCsKJ+RYZ4ofn4Epzr8hk8IMlCtti6Bcc9Z6TmX
         ys4rVayLhwcPhJVrAaQzCo6LfcN+tzi2yS0J3SA7TQaUydbWo/IiYo6BuMLfvEBqOu2E
         pKSxWZSYJmn4iJmEUfBtEKzthDOgr1zjD21wHFoipzCE6lngjoRztn0keTGsr21Pn1Gw
         zYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q1rax7G4k5CCLSu09IqEgCbCj8ZVR2NTHSH1BgrxHe0=;
        b=N1P6CWPGH3LojGDPyzPaJOVuujmXvVepAujc1rWaMPkKOOOdAA9AvQcPA4mz+Ep2Yh
         qvVZnpHpVJPhuekq9KTHPvgWCiP7yCMN7OqVu2/TVXL5qAVMGe3g+NkjNUsq84PvZj4x
         Dnw2vToFj0qukWHF2fmaJ+jRC8LA5UJbyozQjJa3M+oYIJyDbdtoOjNqQAk3P2+IvGZm
         fjCu8fe7l3KEWDxf0R3aWKYwl6QJwbvcaXjRBKn5Vu3ZBbIzZBMMt0R4JZJMZypGaCjU
         3JCP7wb0Br5vocR9w10H7cRAIf0iUGKyixR80OqYlKd7jCkddZi5wwqedalSfvq3CJ7u
         t/Mg==
X-Gm-Message-State: AOAM533PamyyisCRATDkRf7c+8cPyxbL2doknHWfh/Y3sZiE0Z0nZcp6
        DlZT3dkJFEswhpjdl6EEzfF6RA==
X-Google-Smtp-Source: ABdhPJzAdoixanI42+eSMtqelZAuLWBoMV4auYmoFJWOKzOZ+LBVbKYHRC4IjUCViPcUfLAG7Mjdeg==
X-Received: by 2002:a17:90a:67cd:b0:1bc:4437:df27 with SMTP id g13-20020a17090a67cd00b001bc4437df27mr1940741pjm.112.1645499021302;
        Mon, 21 Feb 2022 19:03:41 -0800 (PST)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id il4sm641203pjb.28.2022.02.21.19.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 19:03:40 -0800 (PST)
Date:   Tue, 22 Feb 2022 08:33:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, nm@ti.com,
        sboyd@kernel.org, mka@chromium.org, dianders@chromium.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [RFC][PATCH 1/2] dt-bindings: power: add Energy Model bindings
Message-ID: <20220222030337.ijnfrh367illmidr@vireshk-i7>
References: <20220221225131.15836-1-lukasz.luba@arm.com>
 <20220221225131.15836-2-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221225131.15836-2-lukasz.luba@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21-02-22, 22:51, Lukasz Luba wrote:
> Add DT bindings for the Energy Model information.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  .../bindings/power/energy-model.yaml          | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/energy-model.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/energy-model.yaml b/Documentation/devicetree/bindings/power/energy-model.yaml
> new file mode 100644
> index 000000000000..804a9b324925
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/energy-model.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/energy-model.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Energy Model Bindings
> +
> +maintainers:
> +  - Lukasz Luba <lukasz.luba@arm.com>
> +
> +description: |+
> +  Devices work at specific performance states (frequencies). The power which
> +  is used at a given performance state is an important information. A framework
> +  which maintains this information is Energy Model. This document defines
> +  bindings for these Energy Model performance states applicable across wide
> +  range of devices. For illustration purpose, this document uses GPU as a device.
> +
> +  This binding only supports frequency-power pairs.
> +
> +select: true
> +
> +properties:
> +  operating-points:
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    items:
> +      items:
> +        - description: Frequency in kHz
> +        - description: Power in uW
> +
> +
> +additionalProperties: true
> +examples:
> +    {
> +       gpu_energy_model: energy-model {
> +               compatible = "energy-model";
> +               energy-model-entries = <
> +                               200000 300000
> +                               297000 500000
> +                               400000 800000
> +                               500000 1400000
> +                               600000 2000000
> +                               800000 2800000
> +                               >;
> +       };
> +    };
> +
> +    &gpu {
> +       energy-model = <&gpu_energy_model>;
> +    };

What about getting this from the OPP table instead? There is no point adding
similar tables for a device.

-- 
viresh
