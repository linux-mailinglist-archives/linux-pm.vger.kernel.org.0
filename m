Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D84C6D50CF
	for <lists+linux-pm@lfdr.de>; Mon,  3 Apr 2023 20:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbjDCSiN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Apr 2023 14:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbjDCSiM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Apr 2023 14:38:12 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB16126B9
        for <linux-pm@vger.kernel.org>; Mon,  3 Apr 2023 11:37:59 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id er13so80114929edb.9
        for <linux-pm@vger.kernel.org>; Mon, 03 Apr 2023 11:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680547078;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aBrToP8ip8ocuqQF5W3QQfJWFoKsm6DBA26HLC3P3NY=;
        b=jH3iD00emCIeIOQAy/2nwD+lALHu/U3KzksgBkyiZTqngR4P5+z0T6Gdvia/0QPjFj
         xWRmH5Ly+OrRaA4xl1BrbIaJS0ZIMUxGGXOaX8k3lKlNaiNhEY4fc3R/h66sIn/qK0AI
         Jh5gjyYgdlN/ZEohhKH+bLPaqmTcdiXDtj4m+28dXNwNt8k1PnHm3HIRGJqsqd1Heehr
         SfPD/xqYnu4Uw4Rlv1wHjnaRsYPpS0plbmbA0tqewf2yKYaQCwoarKqMjE+6XoXQW2Mo
         Y0JJKxoLE/a15nR5PbP7DpLpMrZFfsb3J4osANE31UFmylgSUgRr+dE2C2+l4kULkWuz
         bdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680547078;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aBrToP8ip8ocuqQF5W3QQfJWFoKsm6DBA26HLC3P3NY=;
        b=nmirWRrY8CBXUyFHxitRKLAtPFbmeW5OI29okOB9pkpuO/h690CcjVp2Jctw2SkH8V
         fWNCSYWBZjc187rR0uDQvQX7iY7HrqsFO7IK3a/VgQsHe/v3hkcLhSV1P6PiDMXqbHW8
         XyywWTvPimHjOtg6qaQ6K/ET7K1PxvhuRaIzZnVCDZ133CEZj/O1UDHDY85aC/eN9mXQ
         fUtZFJogbtzC41R8XjhK8vz7Rc+P5XXPb6boInNs7y4oiFJ6xXbvsvVzPKZ7SpDWagQN
         SqcithiBsfmwlZexck41e6uVeLrehZ1q9YYbl/aMIE6n4g5QS2c+UEc4VHPQ8WCkEEMU
         SLJQ==
X-Gm-Message-State: AAQBX9fXic3FNsWWeAXjjhGIk5TyrBQ0CaXS3YWVPxDp8QCegzyXA3pR
        b+uZ+reaG4DFaIcqzdg1H3WTug==
X-Google-Smtp-Source: AKy350aXsD3/6dOMyV0mSeSV3/PpyXT4CKhCn/SEkoN08la6HF6ZObp6PbZ7cMouaDVeBQU++4SuUQ==
X-Received: by 2002:a17:906:9f19:b0:93c:847d:a456 with SMTP id fy25-20020a1709069f1900b0093c847da456mr40363176ejc.22.1680547078135;
        Mon, 03 Apr 2023 11:37:58 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ae90:d80:1069:4805? ([2a02:810d:15c0:828:ae90:d80:1069:4805])
        by smtp.gmail.com with ESMTPSA id 20-20020a170906101400b00947732c6521sm4905391ejm.79.2023.04.03.11.37.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 11:37:57 -0700 (PDT)
Message-ID: <bce9adba-d08c-78a1-5949-85155802c9a6@linaro.org>
Date:   Mon, 3 Apr 2023 20:37:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH RFC 15/20] dt-bindings: gpio: gpio_oxnas: remove obsolete
 bindings
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Sebastian Reichel <sre@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mtd@lists.infradead.org, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230331-topic-oxnas-upstream-remove-v1-0-5bd58fd1dd1f@linaro.org>
 <20230331-topic-oxnas-upstream-remove-v1-15-5bd58fd1dd1f@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230331-topic-oxnas-upstream-remove-v1-15-5bd58fd1dd1f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 31/03/2023 10:34, Neil Armstrong wrote:
> Due to lack of maintainance and stall of development for a few years now,
> and since no new features will ever be added upstream, remove the
> OX810 and OX820 gpio bindings.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

