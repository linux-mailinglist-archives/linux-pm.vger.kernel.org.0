Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD9B56FFFD
	for <lists+linux-pm@lfdr.de>; Mon, 11 Jul 2022 13:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbiGKLQ5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Jul 2022 07:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiGKLQ2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jul 2022 07:16:28 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800706456
        for <linux-pm@vger.kernel.org>; Mon, 11 Jul 2022 03:38:33 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id u13so7977166lfn.5
        for <linux-pm@vger.kernel.org>; Mon, 11 Jul 2022 03:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NQoLzRBeO+sL0DWQtHTbM5QZDiRRY6R4q4RQs20xXvA=;
        b=VuG4aVjx+zQiHH6/kPNj8R2eOimlBGti8XEdbUYQ2Vzl8PAd+e6IKmdsu/22AD/P9J
         GBLC8aPdQl4arslGU3tOOFwPWIDP2UMS/J8MIRBRf4cndEtQQkmEmPGM7T0hqSHMpkrF
         tAtnCKNGdc6oKwIdwA36bJn4wyo5/LkekRWOLymdOn1fWMrn2XtvywH5xvHp1TrP/avW
         iX6YLCwq8rCRB9v8xv2rY6x8nhXIQGklitoDpL3NYTrSeVbbkvGJDJJoKWomVVeE5Mvl
         AiUG7/szAUZVaOF6hGneN2SDoMLOqoB9Dx+8uw4kNZge2pcZ2lc5Knd6JVVSpI+bj4Yy
         +aFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NQoLzRBeO+sL0DWQtHTbM5QZDiRRY6R4q4RQs20xXvA=;
        b=bMwdige1T3p5dFVyeZf6mXu7k9L1gsOqDZwuiix3JlUZxbVzppGeI948XslR+0ptQS
         NdI57ZgXlo3KTBjwkGVZLG82tl6gfK4GxUYTB457R62I8ZWQ0lmYTXgqDJDT23x9FhNc
         KNQnkpMnEqnFJyxJqtiEfMB4UrEmKXGo6lDbvSsMMAbVLyiR6Xpf2upfNaN7K6ePa2uE
         FJpU0/yTT26oeKSzIlJc9d8DFm5sZKwx20okUw3YeoAUt/ZzSMo1oWnBN/CcdbCDLiEv
         QJUGOh+Up/aHHiyXnayJ0m3NXfBHHqrttnkr6w5hW+ZlxJ1jh5LzGPwvNhAFpycSHP0X
         QNzg==
X-Gm-Message-State: AJIora9Wz1OBcWmbHQea5s9dWle4ktsAejDRUg04Lvrkc+Fkmzx2ASaq
        yhodbFc1GvE5sWcSMpUNZdzWyA==
X-Google-Smtp-Source: AGRyM1tquCCB6Z0O+3aVgYSykP26Ez+/mnUfsPpGejuwSkfD9boKKoCZ6uAeHfwKQYC2bBpSQDcrLQ==
X-Received: by 2002:a05:6512:1151:b0:481:1675:f343 with SMTP id m17-20020a056512115100b004811675f343mr10988046lfg.280.1657535911823;
        Mon, 11 Jul 2022 03:38:31 -0700 (PDT)
Received: from [10.0.0.8] (fwa5cab-55.bb.online.no. [88.92.171.55])
        by smtp.gmail.com with ESMTPSA id p13-20020a2e804d000000b0025a885a135csm1665054ljg.119.2022.07.11.03.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 03:38:31 -0700 (PDT)
Message-ID: <c68e4ae9-c435-c74e-91cd-b153be6de92f@linaro.org>
Date:   Mon, 11 Jul 2022 12:38:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 2/3] dt-binding: power: power-domain: add
 power-supply-needs-irq
Content-Language: en-US
To:     Martin Kepplinger <martin.kepplinger@puri.sm>, rafael@kernel.org,
        khilman@kernel.org, ulf.hansson@linaro.org, robh@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        pavel@ucw.cz
Cc:     kernel@puri.sm, linux-imx@nxp.com, broonie@kernel.org,
        l.stach@pengutronix.de, aford173@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220711094549.3445566-1-martin.kepplinger@puri.sm>
 <20220711094549.3445566-2-martin.kepplinger@puri.sm>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220711094549.3445566-2-martin.kepplinger@puri.sm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/07/2022 11:45, Martin Kepplinger wrote:
> Add the power-supply-needs-irq board description property for power domains.

Where is a board description here? I think you just meant
"power-supply-needs-irq property"?
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  .../devicetree/bindings/power/power-domain.yaml        | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/power-domain.yaml b/Documentation/devicetree/bindings/power/power-domain.yaml
> index 889091b9814f..e82c2f7ccb97 100644
> --- a/Documentation/devicetree/bindings/power/power-domain.yaml
> +++ b/Documentation/devicetree/bindings/power/power-domain.yaml
> @@ -70,6 +70,16 @@ properties:
>        by the given provider should be subdomains of the domain specified
>        by this binding.
>  
> +  power-supply: true

This is a new property not described in the commit msg.

> +
> +  power-supply-needs-irq:
> +    type: boolean
> +    description:
> +      A power-supply can link for example to a regulator controlled via
> +      i2c or otherwise needing interrupts enabled to be able to enable and
> +      disable. 

Not really a property of power domain. How the regulator supply works is
entirely up to regulator. Otherwise such property should appear for
every device.

> This property makes various callbacks usually run in the
> +      noirq phase, being run when interrupts are available.

Last sentence does not fit - you embed Linux implementation into DT
bindings. noirq phase is Linux specific.

> +
>  required:
>    - "#power-domain-cells"
>  


Best regards,
Krzysztof
