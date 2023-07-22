Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD5775DB76
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jul 2023 11:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjGVJkr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 22 Jul 2023 05:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjGVJkq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 22 Jul 2023 05:40:46 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E89AB
        for <linux-pm@vger.kernel.org>; Sat, 22 Jul 2023 02:40:43 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbc77e76abso22413195e9.1
        for <linux-pm@vger.kernel.org>; Sat, 22 Jul 2023 02:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690018842; x=1690623642;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xVvfPKzKcVpH1QI0csRcWXxVggvuQ6kRzOg+ZisbYTE=;
        b=Q7CO1h4q8n2TRKOtekDzx5eLhCfgNlPO28K68CQZU3y8GiG6UNolrcefO64AH5kG7E
         afp52OcpYW7EXp1ut+7fV5maT0O9zlJHqYfXTt+tkHTa0mN3oqbSD11WnOCZUKtDgZU6
         QO7/r37xHHOMkAiXGjVw4Qd8PY6eD0iBlp0dGACwL4nlxvJAXSmCtVYgWQjsEtNJ+JWn
         cS/Cva+Zm7QvdLFITiyCB/GCJLxPbd4WTapTR23vw5BstGx8XRlm1bozaBB3czz+gjJk
         Lu9BKEdoG8HZkUBE9lxhQNduRRIWs6CvE/Too0X0xkZpYD0nHli5TSrJ5CGOuqF1WiDy
         QfsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690018842; x=1690623642;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xVvfPKzKcVpH1QI0csRcWXxVggvuQ6kRzOg+ZisbYTE=;
        b=Ob0HWZj3hZ/bgAO8kqHzDtWYkp1eJkVHKO8WarORLyCVvm4t4pwwvMI1QPEWAp4dhS
         tnNmQePm6TQtJekaxgq0K2w1Uvt2TE01/uIZy/mcxYJ9OfzkXWL0DjufnwXe+Xv0Bdx0
         esw1r415wVf1J3abdxfcwAOLxauNcp9tTcr5NKhwaA/2+Qw1alOJxTJMhb7ZdVLVqAa4
         tSXk+iQxrEFakZQ8V8VU4Mr6IXFQ32p2RKg8ofv+s9JiDFQRzA+XDm6jgQzhDPOjMSTM
         /1TrInakEs5y53kaPlqEGQuAR4vHHNlHipSYOwszZe2KGjnsaPFQFDmkNuUwGvizHSaJ
         Gv4g==
X-Gm-Message-State: ABy/qLZLEy45c5aXqoyON1LJR8cxS44LiPwd6LpZZWqLRAYrN9KDqIO2
        85vcUlM+z8Cx3kCOqOQeZNl2Kg==
X-Google-Smtp-Source: APBJJlHI5yXhsp3L7DFOZwhHFHT2Jtn8D1u4C1uU1SHS2dWNL8s1Jo6yY1vVSWkoZ2N2CtQtKB04Cw==
X-Received: by 2002:adf:e852:0:b0:313:f1a4:4112 with SMTP id d18-20020adfe852000000b00313f1a44112mr2637672wrn.33.1690018842189;
        Sat, 22 Jul 2023 02:40:42 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id o26-20020a5d58da000000b0030ae499da59sm6436715wrf.111.2023.07.22.02.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jul 2023 02:40:41 -0700 (PDT)
Message-ID: <3c83f4af-3512-2def-0532-1d8c34ee6fcb@linaro.org>
Date:   Sat, 22 Jul 2023 11:40:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/7] dt-bindings: interconnect: qcom: Fix and separate out
 QCS404
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230721-topic-icc_bindings-v1-0-93e2bc728fb7@linaro.org>
 <20230721-topic-icc_bindings-v1-4-93e2bc728fb7@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230721-topic-icc_bindings-v1-4-93e2bc728fb7@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21/07/2023 15:54, Konrad Dybcio wrote:
> Separate out QCS404 icc bindings from the common file and fix the
> clocks description by removing the wrong internal RPM bus clock
> representation that we've been carrying for years.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/interconnect/qcom,qcs404.yaml         | 52 ++++++++++++++++++++++
>  .../devicetree/bindings/interconnect/qcom,rpm.yaml |  6 ---
>  2 files changed, 52 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,qcs404.yaml b/Documentation/devicetree/bindings/interconnect/qcom,qcs404.yaml
> new file mode 100644
> index 000000000000..aff2daa55802
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,qcs404.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interconnect/qcom,qcs404.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm QCS404 Network-On-Chip interconnect
> +
> +maintainers:
> +  - Konrad Dybcio <konradybcio@kernel.org>
> +
> +description: |
> +  The Qualcomm QCS404 interconnect providers support adjusting the
> +  bandwidth requirements between the various NoC fabrics.
> +
> +allOf:
> +  - $ref: qcom,rpm-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,qcs404-bimc
> +      - qcom,qcs404-pcnoc
> +      - qcom,qcs404-snoc

I am not sure it is reasonable to keep such short bindings each in its
own file. Maybe 8916 and qcs404 should be left in common file?

> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,rpmcc.h>
> +
> +    snoc: interconnect@580000 {
> +        compatible = "qcom,qcs404-snoc";
> +        reg = <0x00580000 0x23080>;
> +        #interconnect-cells = <1>;
> +    };
> +
> +    pcnoc: interconnect@500000 {
> +        compatible = "qcom,qcs404-pcnoc";
> +        reg = <0x00500000 0x15080>;
> +        #interconnect-cells = <1>;
> +    };
> +
> +    bimc: interconnect@400000 {
> +        compatible = "qcom,qcs404-bimc";
> +        reg = <0x00400000 0x80000>;
> +        #interconnect-cells = <1>;
> +    };

Keep only one example.

Best regards,
Krzysztof

