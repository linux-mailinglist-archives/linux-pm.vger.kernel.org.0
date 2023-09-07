Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8391F7977DB
	for <lists+linux-pm@lfdr.de>; Thu,  7 Sep 2023 18:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239006AbjIGQgN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 7 Sep 2023 12:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239538AbjIGQgJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Sep 2023 12:36:09 -0400
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6A8B315;
        Thu,  7 Sep 2023 09:25:20 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-57328758a72so224402eaf.1;
        Thu, 07 Sep 2023 09:25:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694103843; x=1694708643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djjxBZJvLFYuSGFHtqKHA0M2l/8DSOfAUO36E6IvzQc=;
        b=b2bEdJlPUaBXxX0CsU7UWd90fm8+NgVB+XhTQLKQZIZGgfUFCxBA1Wd84FFfM76WMK
         BpjEpZEgIuYe/Hd69saOcAytbOUBaEMoBF/KvECUX6mpoQ8OR360QsJ97Zu0+Fz53OUK
         e46FUDluEqsszK8CQafr2C3h3/7W1Jbw4ocf1eRBDQoAMiHinVINweExh1EHkjY7vS7z
         TBL5vQgezaRf0bq6mgSMIO+Dk80F3UfWdWJjMmZpOG/NTVXFYF3xlPTjPNTD9yXE7W6k
         hlmyUXCCAw30DN55uuLxFRKIOsbYHR2djx5P6r9+TSIhqV95fgfokEVC+zARRHuDyYcS
         8WeA==
X-Gm-Message-State: AOJu0YzFqkRopEYnEGdwnPo4/AitnW00KflAzCmZcyPTJtenQPgoZoQZ
        BnbupM41reMuE07OnKK79vqF2HXqT6MHK64BbF4EwVb3
X-Google-Smtp-Source: AGHT+IHR09v57QqtLHy8GY8/Npb3e/xr1iqv9qut4yug6VWf84ldbAiGu6bbX0f9B2Tew6v/6BpdWhGHUy7ZIpnnlxc=
X-Received: by 2002:a4a:a602:0:b0:573:2a32:6567 with SMTP id
 e2-20020a4aa602000000b005732a326567mr96043oom.0.1694103842804; Thu, 07 Sep
 2023 09:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230831130242.2290502-1-festevam@gmail.com>
In-Reply-To: <20230831130242.2290502-1-festevam@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 7 Sep 2023 18:23:51 +0200
Message-ID: <CAJZ5v0jKmxxFMO5TkHujEtdSjeEqKqEOwRyXAXbaeRQUTythdg@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] dt-bindings: thermal-zones: Document critical-action
To:     Fabio Estevam <festevam@gmail.com>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@denx.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 31, 2023 at 3:02 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> Document the critical-action property to describe the thermal action
> the OS should perform after the critical temperature is reached.
>
> The possible values are "shutdown" and "reboot".
>
> The motivation for introducing the critical-action property is that
> different systems may need different thermal actions when the critical
> temperature is reached.
>
> For example, a desktop PC may want the OS to trigger a shutdown
> when the critical temperature is reached.
>
> However, in some embedded cases, such behavior does not suit well,
> as the board may be unattended in the field and rebooting may be a
> better approach.

So one more question here: Why is this a property of a thermal zone
and not the property of the whole system?

Presumably, on a system where the platform integrator prefers to
reboot on critical temperature, it would be necessary to add this
property to every thermal zone.

Also, what if this property has different values for different thermal zones?

> The bootloader may also benefit from this new property as it can check
> the SoC temperature and in case the temperature is above the critical
> point, it can trigger a shutdown or reboot accordingly.
>
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> Changes since v6:
> - None.
>
>  .../devicetree/bindings/thermal/thermal-zones.yaml       | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> index 4f3acdc4dec0..c2e4d28f885b 100644
> --- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> +++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> @@ -75,6 +75,15 @@ patternProperties:
>            framework and assumes that the thermal sensors in this zone
>            support interrupts.
>
> +      critical-action:
> +        $ref: /schemas/types.yaml#/definitions/string
> +        description:
> +          The action the OS should perform after the critical temperature is reached.
> +
> +        enum:
> +          - shutdown
> +          - reboot
> +
>        thermal-sensors:
>          $ref: /schemas/types.yaml#/definitions/phandle-array
>          maxItems: 1
> --
> 2.34.1
>
