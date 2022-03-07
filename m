Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBCB4D0A28
	for <lists+linux-pm@lfdr.de>; Mon,  7 Mar 2022 22:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240305AbiCGVoT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Mar 2022 16:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242158AbiCGVoN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Mar 2022 16:44:13 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA641B786
        for <linux-pm@vger.kernel.org>; Mon,  7 Mar 2022 13:42:52 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CC0033F61D
        for <linux-pm@vger.kernel.org>; Mon,  7 Mar 2022 21:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646689367;
        bh=MhNMfDbHr8DyNFMUPNwO39VGUJ2PygUUS2WxU9QRbWs=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=X3IYl4HwkFhSuunCBe5htAwBsP0AIeAWDnP+EpaHzL315bXKeJuaa0+HJG3SzeL75
         8XNtDCDc/WLdGWgzV9lvsOHT1VQFzpQMahzK2n24xI2xeq54nbhfNOIB6LBBuChlIY
         3Y+On9GmUOiRSw0rB2PtiYDb8PTJxJUcH5tmjLDCEmXMWgw73C5Lk8z3Axr8jdnb8W
         8jzhAjJ2gvbspuENvyjfA/4fRuiNDC/Iw4xh0U1B5I4mR9aB+Gy45YQtVZcLia4WeC
         X7sSR1aXYgYB2706fJwGdKhZ/PjkMhHtnhJ6/Zx682nJDElqNqnL5WqfGErpuIcbj1
         6goEa6sEV6hWw==
Received: by mail-ed1-f72.google.com with SMTP id bq19-20020a056402215300b0040f276105a4so9395549edb.2
        for <linux-pm@vger.kernel.org>; Mon, 07 Mar 2022 13:42:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MhNMfDbHr8DyNFMUPNwO39VGUJ2PygUUS2WxU9QRbWs=;
        b=r1eu54X+EkTL5+8tMK9wT5nRMYkVoZKrTw5pdwlVaaf2/t+wp85KuwxJWsWsQMC/Az
         Lj1JuBnScMKYT0uaxBENaMnGl8vEpVlmBG0xrFrfIy0cJGv8X2DSEFurVUcCzbEBAkEv
         x4pN1LmHUkzsExitXJio7sLwzQlahelC4Cq0iWVHKR+5UGywerwYPV2FE36uKSHEH++b
         Dmv+YiTvBpP0sxST4xxR61S8aaL6C5l+KoIDmQKk6LT2o1B84OKOd67gUl+ETNq8uQbB
         5ETZ1iqM1pWI1rE6yoNxGns0TZvAQcJXrKBtIiDfcVLBWLTfAw0t7egdsrczSLhXUyww
         y1fw==
X-Gm-Message-State: AOAM5332Z2rpOZcB20gRj3i89NdE2IbzzDhQOcMC8IBTt9BCljhMcrqF
        UlwoYhaeWCnipU2zWn5kT5PXTMe6pDzAzcGKqp7TiaNyyzSzZ6+o4+qjtRI7T0Omk9hS3cYrtx5
        DGWlGX94L1pn55CkJgU+cu1AxpRqYBLlQnCLL
X-Received: by 2002:a17:907:60ca:b0:6da:8f25:7983 with SMTP id hv10-20020a17090760ca00b006da8f257983mr10532827ejc.106.1646689367158;
        Mon, 07 Mar 2022 13:42:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwYdGvNdcQTcQgY1xPFW9oHn64MaAA5xJnmohahgMntl3auBJxf8s7T1mVacTWUqEeHAeQ7HA==
X-Received: by 2002:a17:907:60ca:b0:6da:8f25:7983 with SMTP id hv10-20020a17090760ca00b006da8f257983mr10532814ejc.106.1646689366933;
        Mon, 07 Mar 2022 13:42:46 -0800 (PST)
Received: from [192.168.0.143] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id x1-20020a05640226c100b0041668b404basm234923edd.0.2022.03.07.13.42.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 13:42:45 -0800 (PST)
Message-ID: <bf418e08-2e32-5e61-abd8-abb0d8f5c080@canonical.com>
Date:   Mon, 7 Mar 2022 22:42:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/3] dt-bindings: devfreq: mediatek: add mtk cci devfreq
 dt-bindings
Content-Language: en-US
To:     Tim Chang <jia-wei.chang@mediatek.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        roger.lu@mediatek.com, Allen-yy.Lin@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        hsinyi@google.com,
        Jia-Wei Chang <jia-wei.chang@mediatek.corp-partner.google.com>
References: <20220307122513.11822-1-jia-wei.chang@mediatek.com>
 <20220307122513.11822-2-jia-wei.chang@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220307122513.11822-2-jia-wei.chang@mediatek.com>
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

On 07/03/2022 13:25, Tim Chang wrote:
> add devicetree binding of mtk cci devfreq on MediaTek SoC.

Start with capital letter.

> 
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.corp-partner.google.com>

This does not match your From. Please fix this in all your submissions.

> ---
>  .../devicetree/bindings/devfreq/mtk-cci.yaml  | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/mtk-cci.yaml
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/mtk-cci.yaml b/Documentation/devicetree/bindings/devfreq/mtk-cci.yaml
> new file mode 100644
> index 000000000000..e64ac4c56758
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/devfreq/mtk-cci.yaml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/devfreq/mtk-cci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek Cache Coherent Interconnect (CCI) Devfreq driver Device Tree Bindings

Similarly to your other patches - the title describes hardware. Please
fix it in all your submissions of all your series.

Remove "driver Device Tree Bindings". "Devfreq" is Linuxism, so this
maybe "bus frequency scaling"? Although later you call the device node
as cci.

> +
> +maintainers:
> +  - Jia-Wei Chang <jia-wei.chang@mediatek.com>
> +
> +description: |
> +  This module is used to create CCI DEVFREQ.
> +  The performance will depend on both CCI frequency and CPU frequency.
> +  For MT8186, CCI co-buck with Little core.
> +  Contain CCI opp table for voltage and frequency scaling.

Half of this description (first and last sentence) does not describe the
actual hardware. Please describe hardware, not driver.

> +
> +properties:
> +  compatible:
> +    const: "mediatek,mt8186-cci"

No need for quotes.

> +
> +  clocks:
> +    items:
> +      - description:
> +          The first one is the multiplexer for clock input of CPU cluster.
> +      - description:
> +          The other is used as an intermediate clock source when the original
> +          CPU is under transition and not stable yet.
> +
> +  clock-names:
> +    items:
> +      - const: "cci"
> +      - const: "intermediate"

No need for quotes.

> +
> +  operating-points-v2:
> +    description:
> +      For details, please refer to
> +      Documentation/devicetree/bindings/opp/opp-v2.yaml
> +
> +  opp-table: true

Same comments as your CPU freq bindings apply.

> +
> +  proc-supply:
> +    description:
> +      Phandle of the regulator for CCI that provides the supply voltage.
> +
> +  sram-supply:
> +    description:
> +      Phandle of the regulator for sram of CCI that provides the supply
> +      voltage. When present, the cci devfreq driver needs to do
> +      "voltage tracking" to step by step scale up/down Vproc and Vsram to fit
> +      SoC specific needs. When absent, the voltage scaling flow is handled by
> +      hardware, hence no software "voltage tracking" is needed.
> +
> +required:
> +  - compatible
> +  - clocks
> +  - clock-names
> +  - operating-points-v2
> +  - proc-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt8186-clk.h>
> +    cci: cci {

Node names should be generic and describe type of device. Are you sure
this is a CCI? Maybe "interconnect" suits it better?

> +      compatible = "mediatek,mt8186-cci";
> +      clocks = <&mcusys CLK_MCU_ARMPLL_BUS_SEL>, <&apmixedsys CLK_APMIXED_MAINPLL>;
> +      clock-names = "cci", "intermediate";
> +      operating-points-v2 = <&cci_opp>;
> +      proc-supply = <&mt6358_vproc12_reg>;
> +      sram-supply = <&mt6358_vsram_proc12_reg>;
> +    };


Best regards,
Krzysztof
