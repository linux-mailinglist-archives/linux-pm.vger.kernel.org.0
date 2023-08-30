Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A82178DAA2
	for <lists+linux-pm@lfdr.de>; Wed, 30 Aug 2023 20:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237771AbjH3Sgp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 30 Aug 2023 14:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243729AbjH3Lha (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Aug 2023 07:37:30 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AB0132;
        Wed, 30 Aug 2023 04:37:27 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-56e280cc606so1017378eaf.1;
        Wed, 30 Aug 2023 04:37:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693395446; x=1694000246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTUTk3Lpl4gCYLJGqC5JIdp0R+/wUxfLNRvC3Bl9Oyk=;
        b=jhSZsFHE1kFOc0j1/toHudDJb6A7vxAO3UejrRlgnexvSWNyXc5CbsOR6B5BAwggWP
         2467VSyHgHfre3dHGAJ3TDQ2LEOZ+GURza/oF/7dGF/9dEtzyfjD8wAYWUBdJWhD3Ch1
         z0FGTJOd7tt4GtbEMDMtPR/6FFS/PoNP4QAESV7rZPncaKTuBGgm+pqb+pCqAQ9jvC4/
         tZlmv0GYRF+pauAl8A4ejl64tieRxn7cf3g203c444OS+OvSQaxuHsnlSfHznitEyfde
         btHfZk7pD1MR6Xwt1SJR+Sa0z/8vCiA6eSLtDI/RMDJom/YJf9eBnTjiTK2rEvjLJskT
         DIwg==
X-Gm-Message-State: AOJu0Yxia1ABGbxpB8ayzaj45wclJYC3cc2MCrulsm+wf1JQajpIvV5f
        +6OGfE9ixRCgjsY7YRFBq0knawv9T9otPMuf5Ec=
X-Google-Smtp-Source: AGHT+IHlZDA3G7SJoNMRKYpaeAV/6Lb95d8hTyk9qyO1+USsAQrDYFoAiH1VHloRlIw4UEENBIq6t9KXXKo2c8zhXcU=
X-Received: by 2002:a4a:a302:0:b0:573:764b:3b8d with SMTP id
 q2-20020a4aa302000000b00573764b3b8dmr1759783ool.0.1693395446528; Wed, 30 Aug
 2023 04:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230829194200.1901988-1-festevam@gmail.com>
In-Reply-To: <20230829194200.1901988-1-festevam@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 30 Aug 2023 13:37:15 +0200
Message-ID: <CAJZ5v0hZR3WD+wMA6c-Gt86hM5oCRZDcSsYF4SrYTvT2HtQ=fQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] dt-bindings: thermal-zones: Document critical-action
To:     Fabio Estevam <festevam@gmail.com>
Cc:     daniel.lezcano@linaro.org, rafael@kernel.org, amitk@kernel.org,
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

On Tue, Aug 29, 2023 at 9:42 PM Fabio Estevam <festevam@gmail.com> wrote:
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
>
> The bootloader may also benefit from this new property as it can check
> the SoC temperature and in case the temperature is above the critical
> point, it can trigger a shutdown or reboot accordingly.
>
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> Changes since v4:
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

I'm wondering if this should be a bool property called
"critical-reboot", say, which when present would mean to carry out a
reboot instead of a shutdown in an emergency.

As defined above, the "shutdown" value is simply redundant, because
the code will effectively convert any other value to "shutdown"
anyway.
