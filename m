Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A85161E51F
	for <lists+linux-pm@lfdr.de>; Sun,  6 Nov 2022 18:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiKFRx2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Nov 2022 12:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiKFRx0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Nov 2022 12:53:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23BFFE0
        for <linux-pm@vger.kernel.org>; Sun,  6 Nov 2022 09:53:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE0F8B80C81
        for <linux-pm@vger.kernel.org>; Sun,  6 Nov 2022 17:53:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E6AC4347C
        for <linux-pm@vger.kernel.org>; Sun,  6 Nov 2022 17:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667757202;
        bh=0AAV8yRbWXNK762f2Vh4PIh5JtH9U7bj17L7WVrQWVQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EnbfRfU4vl1LbatZy/4TJho3j40YPPS1AytRxUVLDFQKbIh/6ivTobgRTP7ZTfWhP
         c6dICUlZfQLotsu9DVS2QacDART/VIMzs+jH+bW7hRZ7OdPfjLMNmC2KvVlqgIE4eW
         6m0PCo4kR+9XqOcfXYKME25yyDsJY41BRmcFLYXuTp8AVjijLN6lxspFTIxFO4fxBb
         3iNQ2eL6qOA5hG/8rzm8q+sH2ymezBF5nuMgYMm5BWfGtcT/LU/SPol7xR5B1lk2VM
         BCd8M+RFvxZDSDjVKCUDX27QX3Izy0Jfa2f6CpBdEurSVV5Kv4iQIwHlb/Tj6b7a8N
         dcsHat15sHucA==
Received: by mail-vk1-f172.google.com with SMTP id g16so5283755vkl.11
        for <linux-pm@vger.kernel.org>; Sun, 06 Nov 2022 09:53:22 -0800 (PST)
X-Gm-Message-State: ACrzQf200/+klJN9GInU1DNK3ASH6u8DCsIiSpocQTkBXeMEQ9mGXYaW
        rjjdnvW1SM88YvXvIKQ7S489l5GIVRwzcYPLz0/JHg==
X-Google-Smtp-Source: AMsMyM6G9xO4NOst7LlB8/PZAy/BIR4OySoo2K6mn1jYjSsUB9xgi27YniIedvBrDxi9OHM84Kbh5Zlo9YsX3BX/ez4=
X-Received: by 2002:a1f:a6d8:0:b0:3aa:65aa:a0d3 with SMTP id
 p207-20020a1fa6d8000000b003aa65aaa0d3mr23851035vke.14.1667757201273; Sun, 06
 Nov 2022 09:53:21 -0800 (PST)
MIME-Version: 1.0
References: <20221104162450.1982114-1-robh@kernel.org>
In-Reply-To: <20221104162450.1982114-1-robh@kernel.org>
From:   Amit Kucheria <amitk@kernel.org>
Date:   Sun, 6 Nov 2022 23:23:10 +0530
X-Gmail-Original-Message-ID: <CAHLCerM2SwQu3VAhZ6xrxu0-S06ubVDeEye78sF710jVKENRUA@mail.gmail.com>
Message-ID: <CAHLCerM2SwQu3VAhZ6xrxu0-S06ubVDeEye78sF710jVKENRUA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: thermal: cooling-devices: Add missing cache
 related properties
To:     Rob Herring <robh@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 4, 2022 at 9:55 PM Rob Herring <robh@kernel.org> wrote:
>
> The examples' cache nodes are incomplete as 'cache-unified' and
> 'cache-level' are required cache properties.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Amit Kucheria <amitk@kernel.org>

> ---
>  .../devicetree/bindings/thermal/thermal-cooling-devices.yaml  | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml b/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
> index 850a9841b110..7bb9327caa13 100644
> --- a/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
> +++ b/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
> @@ -76,9 +76,13 @@ examples:
>                      next-level-cache = <&L2_0>;
>                      L2_0: l2-cache {
>                              compatible = "cache";
> +                            cache-unified;
> +                            cache-level = <2>;
>                              next-level-cache = <&L3_0>;
>                              L3_0: l3-cache {
>                                      compatible = "cache";
> +                                    cache-unified;
> +                                    cache-level = <3>;
>                              };
>                      };
>            };
> --
> 2.35.1
>
