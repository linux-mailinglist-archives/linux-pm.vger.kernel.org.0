Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5DBD7A1C79
	for <lists+linux-pm@lfdr.de>; Fri, 15 Sep 2023 12:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjIOKkJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Sep 2023 06:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjIOKkJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Sep 2023 06:40:09 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B401B98
        for <linux-pm@vger.kernel.org>; Fri, 15 Sep 2023 03:40:03 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-400a087b0bfso21308235e9.2
        for <linux-pm@vger.kernel.org>; Fri, 15 Sep 2023 03:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694774402; x=1695379202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wg4RGJGXJ83gUY3aUzka2t/lAD8v0ssdxmSTV1UhJTU=;
        b=eIxZwUs7BN00mH9i0BMvq1jlv3PQslM6mPcCJ8cwSFv3xyie5uKL5z3L0+FsKe0LB/
         2owrqMyCZ8NXj4btjcg7DFLJN3/R3WydNDyvzLQbRakzei8S76SM5g0ZqDfc9CF3FkMb
         h4VQd0mFM2d90HJmwPsq2w8417H73bx8hYCtMfot3nmun0PweR34lmf7mCntpuDWJpP5
         DjPqtJ7XFGQEHZcKIK6U4tH1C1hs0zJKCF3KATie7gXdj/C3lqPvU/Yc2I+Xpypmnph9
         oMUWi0KFn3eRazViztXwf6oX9urrc8sxOkNKjdC9SRN+dyOLpVMWsXFL0QcjKJoV7X46
         HBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694774402; x=1695379202;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wg4RGJGXJ83gUY3aUzka2t/lAD8v0ssdxmSTV1UhJTU=;
        b=qX5P2eJG7ABhQnNerM0a7DJnBkUes8us4kqybol/xnQr0w85UO/5eQsCogT1aLnvuf
         WWW+vUfK1EcrVYwSsDWIYAS7DxFd+oxNo7rbUq/32qbHxHbm9UFIDRgVoxD77hUIhhSW
         W+Kzq0cJI//qZZcx7WpNQXOWgUMTQo9Gf1Lg6X34K9HavWBnMCwMEqVZzqILxKFjYMcb
         /+UlGdDdCHoDHazSbH1wrbTm10/G2sm546GZ7aFxpDx7BOmyIXYOdVX7hkQnUkbUdwF+
         C10PbCSHTldGyWnkolp0fGX3CNXAaRfigDFHe9tiFKYu6UG6Nsq8X2XK+fAaUmsZYsle
         qeVQ==
X-Gm-Message-State: AOJu0YwR3YbHLFkLQvhTm6WCkFKoD/n3MZEbJmhupqZBOQnqdWn/fuSz
        MnfqvzhGMC8vtNNREMDI225jSw==
X-Google-Smtp-Source: AGHT+IEVHaZPwjMfzpRmIUehShY1icG9zi+gwSzKiSTLPWJUMBQfOp5Z2D/Bt6jniMMPJvQ+8WabWQ==
X-Received: by 2002:a05:6000:1f89:b0:31f:f72c:df95 with SMTP id bw9-20020a0560001f8900b0031ff72cdf95mr772619wrb.21.1694774402077;
        Fri, 15 Sep 2023 03:40:02 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id g13-20020a7bc4cd000000b003fc02e8ea68sm7152870wmk.13.2023.09.15.03.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 03:40:01 -0700 (PDT)
Message-ID: <a72a1fe1-78d3-6a9b-fd1a-be0f687e3234@linaro.org>
Date:   Fri, 15 Sep 2023 12:39:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 07/42] dt-bindings: power: reset: Add ep93xx reset
Content-Language: en-US
To:     nikita.shubin@maquefel.me, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
 <20230915-ep93xx-v4-7-a1d779dcec10@maquefel.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230915-ep93xx-v4-7-a1d779dcec10@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15/09/2023 10:10, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> Add YAML bindings for ep93xx reset.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  .../bindings/power/reset/cirrus,ep9301-reboot.yaml | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/cirrus,ep9301-reboot.yaml b/Documentation/devicetree/bindings/power/reset/cirrus,ep9301-reboot.yaml
> new file mode 100644
> index 000000000000..a5a718dec4b5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/cirrus,ep9301-reboot.yaml
> @@ -0,0 +1,34 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/reset/cirrus,ep9301-reboot.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus EP93xx SoC family reset controller
> +
> +maintainers:
> +  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
> +  - Nikita Shubin <nikita.shubin@maquefel.me>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: cirrus,ep9301-reboot
> +      - items:
> +          - enum:
> +              - cirrus,ep9302-reboot
> +              - cirrus,ep9307-reboot
> +              - cirrus,ep9312-reboot
> +              - cirrus,ep9315-reboot
> +          - const: cirrus,ep9301-reboot
> +
> +required:
> +  - compatible
> +

The binding looks fine except... that's not needed. See my comment in
next patches.

Best regards,
Krzysztof

