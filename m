Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6867AF3C8
	for <lists+linux-pm@lfdr.de>; Tue, 26 Sep 2023 21:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbjIZTGl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Sep 2023 15:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235768AbjIZTGk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Sep 2023 15:06:40 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB87139
        for <linux-pm@vger.kernel.org>; Tue, 26 Sep 2023 12:06:32 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4060b623e64so20092835e9.0
        for <linux-pm@vger.kernel.org>; Tue, 26 Sep 2023 12:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1695755191; x=1696359991; darn=vger.kernel.org;
        h=in-reply-to:references:message-id:to:from:subject:cc:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WhT3I1HoyzXvrF4bNIAgqqZZC+4W+J5yKlGXFNwrb0=;
        b=xT9mI7pRhQ0ktJdTvbx9kmBaq+XPr9CzwEeuIgFIXMyBB6xMOhnAYpFGPAcpFKdj4H
         C2u1hPJYYZbFxJmLPfgscZb0Q856XJ5tmRrFQnwTDMBIiCHsYGBaL4Zxy3ZBvW6bg+N+
         WdmaUAFZI+22Dxkw05dFh8kdhIJYGU6sBTaoVjKLvwQL0zx0D0IEJtOIRrnrqT/OcSCo
         UfWWOCIWYOQ51q8oRz0eezv5O+r2CPoXFWy7aifFkCfPpoEBINhrbXxCeTbWcs426ocT
         cgg/mjuV+UEhhmtn3hQ2hBmVYJIQBp5icgh1ACmxF/1nkvEOS1csavjMUZE3v8joeJoo
         /gAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695755191; x=1696359991;
        h=in-reply-to:references:message-id:to:from:subject:cc:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0WhT3I1HoyzXvrF4bNIAgqqZZC+4W+J5yKlGXFNwrb0=;
        b=G1aepQxggRq25Y0qK5czKP58HeUYQ3l+xyVEAiiYUNfD4K08QVrLojnQCIPdujqjAB
         pF9ksp6z3dHFJ6ygrXXkYL/nlys7qu9bNDozd5MrLkqsccAJ/nm9MpJR0fdeYZQbMvX5
         oefuLSIFdcNOTvnfWkCGEsyLXQpPiRiz7RV5tlkKK6Wx61amsY4AAjC0EVNA/dgx6mSJ
         Kqz97vlIl5kFalYQ5W+7DaV/olF8XhOAql+9hpBnlcX2N0KwhIqOI/yAaqEbu/V8Ao85
         oVK9Ug00YhKd3drWr3FiUMfmCyads9njHuG88c3OE1wi+cxpgBmNRb9KKbwbhffszNyy
         l66A==
X-Gm-Message-State: AOJu0YzkjyASCF2pgOOsc/G7ffadzAuh1Eyro4MOUckRfMVxln6N95OB
        SGD1YSYtlDu3bWB7v1v5owsayg==
X-Google-Smtp-Source: AGHT+IGaUXN/N9KEtl6bp24m+BoEu1jQER0zYBcCo8xTUVE52B6AjkzCayrdZDCq5883ChqfuRarjA==
X-Received: by 2002:a7b:ce0a:0:b0:3fe:1587:fdf3 with SMTP id m10-20020a7bce0a000000b003fe1587fdf3mr2743086wmc.14.1695755190970;
        Tue, 26 Sep 2023 12:06:30 -0700 (PDT)
Received: from localhost ([213.144.205.82])
        by smtp.gmail.com with ESMTPSA id q25-20020a7bce99000000b003fefcbe7fa8sm3624996wmj.28.2023.09.26.12.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 12:06:30 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 26 Sep 2023 21:06:30 +0200
Cc:     <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 5/7] dt-bindings: pinctrl: qcom,sc7280: Allow
 gpio-reserved-ranges
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Luca Weiss" <luca.weiss@fairphone.com>,
        <cros-qcom-dts-watchers@chromium.org>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Viresh Kumar" <viresh.kumar@linaro.org>
Message-Id: <CVT30PLQGDL5.3A3O07UX6YCL2@otso>
X-Mailer: aerc 0.15.2
References: <20230919-fp5-initial-v2-0-14bb7cedadf5@fairphone.com>
 <20230919-fp5-initial-v2-5-14bb7cedadf5@fairphone.com>
In-Reply-To: <20230919-fp5-initial-v2-5-14bb7cedadf5@fairphone.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue Sep 19, 2023 at 2:45 PM CEST, Luca Weiss wrote:
> Allow the gpio-reserved-ranges property on SC7280 TLMM.
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Hi Linus,

the rest of this series is merged so would be great if you could pick up
this patch (as you wrote in v1) :)

Regards
Luca

> ---
>  Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml | 4 +=
+++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctr=
l.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml
> index 368d44ff5468..c8735ab97e40 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml
> @@ -41,6 +41,10 @@ properties:
>    gpio-ranges:
>      maxItems: 1
> =20
> +  gpio-reserved-ranges:
> +    minItems: 1
> +    maxItems: 88
> +
>    gpio-line-names:
>      maxItems: 175
> =20

