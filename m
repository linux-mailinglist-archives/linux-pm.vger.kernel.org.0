Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC124D1FB5
	for <lists+linux-pm@lfdr.de>; Tue,  8 Mar 2022 19:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238847AbiCHSKO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Mar 2022 13:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241141AbiCHSKO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Mar 2022 13:10:14 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0543E4ECF1
        for <linux-pm@vger.kernel.org>; Tue,  8 Mar 2022 10:09:15 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DE45E3F79A
        for <linux-pm@vger.kernel.org>; Tue,  8 Mar 2022 18:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646762953;
        bh=HQ+AlAxOvin8Z7RnFZllWIX2zdkr8lWtXui3jEa4PvY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=H7OIoA0OAP8YUGoVOH+BtTb9Vey0BY5RT1b+8ZmypG677iIk4GXQhamwcAk7sMmJ1
         F3H9ZnVR+5hCs4wpKCj+kub81VoejzPGqlYwbMnPoyGv0ZhOgwTaffsty2Te2ThYFP
         ELP7JpGnK5duhaIfAy3qrrzNpFazilfH0au7ZnO8yYQxCdns5LSBMUWoNTRe/7lPb/
         DUFsX+KRijW1bQh9y+1Isj/1ZrTAD0R3fRQ23AUfaSF0gpVuy8NJmmBz652+ideFsK
         3xDlgK/ixL/S/1J5FJ65+d+MMFyq10O1aFdOqvBwSYLhVRrteTLdTCJs5mAiyG0Tyi
         tWHL8c5S4/vrA==
Received: by mail-ed1-f70.google.com with SMTP id s7-20020a508dc7000000b0040f29ccd65aso11057184edh.1
        for <linux-pm@vger.kernel.org>; Tue, 08 Mar 2022 10:09:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HQ+AlAxOvin8Z7RnFZllWIX2zdkr8lWtXui3jEa4PvY=;
        b=4aS+dVWbR7XCaZiylNAYXMt+O8Fewdn+FD4mQ5koSTcU4jWoubPYnZfEbWmRR8JYB7
         sraLjZEW9PqzR8UGvIs+F08pim63E/HSq43ksKWJOMec+KDZgfiRNDtncNtRzNaS2HXA
         XGXuubXmb5VHh7EhV62+yA5fht9z6y3r9vlW2QA9BAUuw1P7/KtJi/i8FQmE9Vqjwo8h
         ui+jrqjl9hy9pZWi3R83f7pOGWzBoiP7rVb6G4Snv+wbhygpG/yrHJXTI42VHmj1TvbK
         rd1RmYOMALNU+LYBm3Me2yWbZVwSpcyyuDyPVAOmmuj2ea2L1uyjnKl4PSwuVQP9yfgW
         PRdA==
X-Gm-Message-State: AOAM532TaYmvNta9nOOMX1kNwXp3FwqPvB0cXPO+rFGdCYH9AMcCLkMS
        IU5pv+yE+E4rFisWvmKqySJLGfPDj6oLbzN3fixcS0wJE9+rsWPNY8bhQkIPx6fiMuL1ZF0a18r
        pTIkgT8TrP/NQqv+VqaV/SCzitevuQzQ70iut
X-Received: by 2002:a17:906:6144:b0:6cf:bb2e:a2e1 with SMTP id p4-20020a170906614400b006cfbb2ea2e1mr14517505ejl.299.1646762953183;
        Tue, 08 Mar 2022 10:09:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxPCRvAFRNuiWIjRNsm0bW5FihvdxlTfCRotQpM3ip6wvmg1l+ish0iIhGP3Q3PTtKYKZzEkg==
X-Received: by 2002:a17:906:6144:b0:6cf:bb2e:a2e1 with SMTP id p4-20020a170906614400b006cfbb2ea2e1mr14517473ejl.299.1646762952927;
        Tue, 08 Mar 2022 10:09:12 -0800 (PST)
Received: from [192.168.0.144] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id z5-20020a1709063a0500b006da8fa9526esm6111715eje.178.2022.03.08.10.09.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 10:09:12 -0800 (PST)
Message-ID: <612d1ee6-aa25-20f8-081a-e6cdfeeafce0@canonical.com>
Date:   Tue, 8 Mar 2022 19:09:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 04/15] dt-bindings: devfreq: rk3399_dmc: Specify idle
 params in nanoseconds
Content-Language: en-US
To:     Brian Norris <briannorris@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Lin Huang <hl@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
        Derek Basehore <dbasehore@chromium.org>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>
References: <20220308000945.706701-1-briannorris@chromium.org>
 <20220307160918.v3.4.I01c6a2b2db578136686b42d463af985cfdff2fd9@changeid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220307160918.v3.4.I01c6a2b2db578136686b42d463af985cfdff2fd9@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08/03/2022 01:09, Brian Norris wrote:
> It's inefficient to use the same number of cycles for all OPPs, since
> lower frequencies make for longer idle times. Let's specify the idle
> time instead, so software can pick the optimal number of cycles on its
> own.
> 
> NB: these bindings aren't used anywhere yet.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> 
> Changes in v3:
>  * Add Reviewed-by
> 
> Changes in v2:
>  * New patch
> 
>  .../bindings/devfreq/rk3399_dmc.yaml          | 50 +++++++++++++++++--
>  1 file changed, 45 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml
> index 2904ae4115f3..6a33a7b44741 100644
> --- a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml
> +++ b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml
> @@ -56,42 +56,52 @@ properties:
>        being used.
>  
>    rockchip,pd_idle:
> +    deprecated: true
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description:
>        Configure the PD_IDLE value. Defines the power-down idle period in which
>        memories are placed into power-down mode if bus is idle for PD_IDLE DFI
>        clock cycles.
> +      See also rockchip,pd-idle-ns.
>  
>    rockchip,sr_idle:
> +    deprecated: true
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description:
>        Configure the SR_IDLE value. Defines the self-refresh idle period in
>        which memories are placed into self-refresh mode if bus is idle for
>        SR_IDLE * 1024 DFI clock cycles (DFI clocks freq is half of DRAM clock).
>        Default value is "0".
> +      See also rockchip,sr-idle-ns.
>  
>    rockchip,sr_mc_gate_idle:
> +    deprecated: true
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description:
>        Defines the memory self-refresh and controller clock gating idle period.
>        Memories are placed into self-refresh mode and memory controller clock
>        arg gating started if bus is idle for sr_mc_gate_idle*1024 DFI clock
>        cycles.
> +      See also rockchip,sr-mc-gate-idle-ns.
>  
>    rockchip,srpd_lite_idle:
> +    deprecated: true
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description:
>        Defines the self-refresh power down idle period in which memories are
>        placed into self-refresh power down mode if bus is idle for
>        srpd_lite_idle * 1024 DFI clock cycles. This parameter is for LPDDR4
>        only.
> +      See also rockchip,srpd-lite-idle-ns.
>  
>    rockchip,standby_idle:
> +    deprecated: true
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description:
>        Defines the standby idle period in which memories are placed into
>        self-refresh mode. The controller, pi, PHY and DRAM clock will be gated
>        if bus is idle for standby_idle * DFI clock cycles.
> +      See also rockchip,standby-idle-ns.
>  
>    rockchip,dram_dll_dis_freq:
>      deprecated: true
> @@ -260,6 +270,36 @@ properties:
>        When the DRAM type is LPDDR4, this parameter defines the PHY side ODT
>        strength. Default value is 60.
>  
> +  rockchip,pd-idle-ns:
> +    description:
> +      Configure the PD_IDLE value in nanoseconds. Defines the power-down idle
> +      period in which memories are placed into power-down mode if bus is idle
> +      for PD_IDLE nanoseconds.
> +
> +  rockchip,sr-idle-ns:
> +    description:
> +      Configure the SR_IDLE value in nanoseconds. Defines the self-refresh idle
> +      period in which memories are placed into self-refresh mode if bus is idle
> +      for SR_IDLE nanoseconds. Default value is "0".

Use "default: 0".



Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
