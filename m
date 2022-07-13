Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0349E572D81
	for <lists+linux-pm@lfdr.de>; Wed, 13 Jul 2022 07:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbiGMFmM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Jul 2022 01:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbiGMFly (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jul 2022 01:41:54 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F3D2659
        for <linux-pm@vger.kernel.org>; Tue, 12 Jul 2022 22:40:28 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id a184so9808004vsa.1
        for <linux-pm@vger.kernel.org>; Tue, 12 Jul 2022 22:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mxd6fF/X1Ur+T+IrYqysa9WFiYiRwcyC9Oo1dC8zTkc=;
        b=kzjjWIOImgWc02VlKrN3u+XMYt5cyG3BKjJ5QvjsnH6M8ExUdJw9pFuLQ/stTLsdx7
         2pooghQkcdClAMMNMGuEoHYOR1sPc7SbQRezE/bfmy2NbfyFj8M2KHDTZiogT7jY0HZ5
         76LuyM4hjUQTT9nxXogNSYt4uv6F5UDgE6rYrU4A8fUf+PIuaYwUv3kPpAgufGmfVi0T
         hx/JzGlREJQXHhlk/sPoXqRM9d5/9N2vnTqpuFRJPJpCYmJMTAEY/3jkzeGVe0H24PYu
         Q8osxZai16iaAvkxmJZOra0xVcE6USTOA2a3FMdKquQYlt8CmZQ0MX0eSY5T8pgLESGJ
         FyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mxd6fF/X1Ur+T+IrYqysa9WFiYiRwcyC9Oo1dC8zTkc=;
        b=HuGWIUAeDw5K+rXbH05xqcMkaeVnXM+ZKLejfqzOqL1Per6JEK+2hMlutiRm6w50ws
         eJM5RMP5A52ajiO4vNHT7OE3a6iGCqH6nEDrDqQLcgiTrzWkr1DMfPRsDrqgii/OQ7nw
         5/ax45f17USNO5YGmI1kMuqZxAVIp2iFBbDaiA9x27F/U0yOghCAYmd11tdBbpxd/ouf
         fLO53W4y9xIr2JwEDd0KakoYJHYT3hLigXSe2z1VXhQdio07yfT24J4BOC1kQ6hYd9o9
         8OjwStn3OaN+oKpSDUM9O4tE7foKxQGqeLQkWR8K+tcYxuc0I/tC24zrY+DOShmjT0PI
         ni1w==
X-Gm-Message-State: AJIora++menHZK6CkqHgm99pAu0hv3GR5F7QwkDOaow2EjYlJtlohq6s
        n+xZUoEQ22u5FKpLZSBvesoknZSoIOA7KN8aD94/fQ==
X-Google-Smtp-Source: AGRyM1tbfSxhI6hN959fnDuXsUf5sxFkJhhZa6wobkH3cjsYiZx53U9Z+ls08De6yAm6U+nRv6jwxw56Yv7Y67ZWclg=
X-Received: by 2002:a67:cf48:0:b0:357:158a:7654 with SMTP id
 f8-20020a67cf48000000b00357158a7654mr603497vsm.0.1657690826992; Tue, 12 Jul
 2022 22:40:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220309151541.139511-1-manivannan.sadhasivam@linaro.org> <20220309151541.139511-3-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20220309151541.139511-3-manivannan.sadhasivam@linaro.org>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Wed, 13 Jul 2022 11:10:14 +0530
Message-ID: <CAKohponOKCNFXUi6cyTOMV8Gd_erm4=2L9sFjgTs0+n0x5EmxQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: cpufreq: cpufreq-qcom-hw: Convert to
 YAML bindings
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     rafael@kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        bjorn.andersson@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        angelogioacchino.delregno@somainline.org,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 9 Mar 2022 at 20:45, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> +    soc {
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +
> +      cpufreq@17d43000 {
> +        compatible = "qcom,cpufreq-hw";
> +        reg = <0x17d43000 0x1400>, <0x17d45800 0x1400>;
> +        reg-names = "freq-domain0", "freq-domain1";
> +
> +        clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
> +        clock-names = "xo", "alternate";
> +
> +        #freq-domain-cells = <1>;
> +      };
> +    };

Why didn't we migrate to #performance-domain-cells here ? We can keep
the kernel backward compatible to support old DT definitions, but won't it be
better to move to a more generic solution, now that we have one ?
