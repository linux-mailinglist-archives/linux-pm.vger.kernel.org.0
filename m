Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B6D6E8BF6
	for <lists+linux-pm@lfdr.de>; Thu, 20 Apr 2023 09:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbjDTH74 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Apr 2023 03:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbjDTH7t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Apr 2023 03:59:49 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B373213F
        for <linux-pm@vger.kernel.org>; Thu, 20 Apr 2023 00:59:47 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-54fb615ac3dso30906347b3.2
        for <linux-pm@vger.kernel.org>; Thu, 20 Apr 2023 00:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681977587; x=1684569587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BI1AiAelLJ4HxelpOqQEAAWAkBpG6hkIUKnSQUWohZk=;
        b=wwQp1VQvTD/FDhRTbzZ1RrVypby8Y5AGsbDYqpJ+LuDak82YVXfbcVccxsIBMApyKn
         7BUqc1l513A9tDM5JVFjExEXFfvaXVuOUlURA+zBNKAuXGihcPGZhM+hhUxa6fpH0N0w
         gX3t2Of9WyaPs19d+L774nPOmBo5O1Ccj6OpzOuFd6i1bMddsYJcxR3ChHrJrP4ziPPa
         Dpl2qgLW1OfRaUOXB+mTI3HZQN+koHmaFxGppaH1BGwbpwp2KSQJ4TLuF+LJA+7By2Sv
         HFEgKKPAUiCsp2hbvYNy085rQrPBUxmJY09ttws4p38lyLmGd+lmwsew8i2xHe/E5ljd
         Eemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681977587; x=1684569587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BI1AiAelLJ4HxelpOqQEAAWAkBpG6hkIUKnSQUWohZk=;
        b=k/uB/eaWb2THHgGHBejuYUdz3ITg9HwAuS6K/WGd5bmyAtMtmLJerEi/m7BlIfrlA9
         0SBEMQ6PSP3Mvm8BIGCkl5sHEHuZazIpal+gAn4oscYjSEn2MeCQyRVDOYuNr+aiBq4o
         IafV05xHMdd+mEGTnEgUwBS00wVojOxNl16868F8Bu2oI99WPEWYD9Xu1bOnxoyftGjW
         I549yytU7HFHQRxmIcotEQsY0HR6EE09ydCnM47lctG0Ow74iVhFrICe7VLPw69CyoTr
         1zHGy5fDKFtsl99r+ug7dRbMsdIwgU0iZWQo4wju8HqL/3SzjhZdBo92qSbmSXwUioGz
         y+hA==
X-Gm-Message-State: AAQBX9dsFItlgZ0vUvhD20qt7X7XiCnSCEPZAkJQNheq++f4sBeSkJfu
        2wTCwQR9+3HQKmkavzlUd53g/Aok2JCbzvceQfBr9w==
X-Google-Smtp-Source: AKy350b/JXxWETBVLrEIcsjgS/yhHIo2IhkhWY/nknLfE8eSOzWrdPKzZATMHuHvpcsIcGNCF6cxbTFugew+ByBGoJ0=
X-Received: by 2002:a0d:e5c4:0:b0:54f:8af6:bb13 with SMTP id
 o187-20020a0de5c4000000b0054f8af6bb13mr228370ywe.3.1681977586772; Thu, 20 Apr
 2023 00:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1681646904.git.jahau@rocketmail.com> <9275af790e6e21b5cf661a2444effe4caf2be02e.1681646904.git.jahau@rocketmail.com>
In-Reply-To: <9275af790e6e21b5cf661a2444effe4caf2be02e.1681646904.git.jahau@rocketmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 Apr 2023 09:59:35 +0200
Message-ID: <CACRpkdZEtG=OjTECDO=SvFk89MqL10sKKMOABPEs-xxYv1hmqw@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] dt-bindings: Add documentation for rt5033 mfd,
 regulator and charger
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Axel Lin <axel.lin@ingics.com>,
        ChiYuan Huang <cy_huang@richtek.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Jakob,

thanks for your patch!

The following caught my eye:

On Sun, Apr 16, 2023 at 2:50=E2=80=AFPM Jakob Hauser <jahau@rocketmail.com>=
 wrote:

> Add device tree binding documentation for rt5033 multifunction device, vo=
ltage
> regulator and battery charger.
>
> Cc: Beomho Seo <beomho.seo@samsung.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> ---
> The patch is based on linux-next (tag "next-20230413").
(...)
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charg=
er.yaml
(...)
> +  richtek,pre-microamp:
> +    description:
> +      Current of pre-charge mode. The pre-charge current levels are 350 =
mA to
> +      650 mA programmed by I2C per 100 mA.
> +    maxItems: 1
> +
> +  richtek,fast-microamp:
> +    description:
> +      Current of fast-charge mode. The fast-charge current levels are 70=
0 mA
> +      to 2000 mA programmed by I2C per 100 mA.
> +    maxItems: 1
> +
> +  richtek,eoc-microamp:
> +    description:
> +      This property is end of charge current. Its level ranges from 150 =
mA to
> +      600 mA. Between 150 mA and 300 mA in 50 mA steps, between 300 mA a=
nd 600 mA
> +      in 100 mA steps.
> +    maxItems: 1
> +
> +  richtek,pre-threshold-microvolt:
> +    description:
> +      Voltage of pre-charge mode. If the battery voltage is below the pr=
e-charge
> +      threshold voltage, the charger is in pre-charge mode with pre-char=
ge current.
> +      Its levels are 2.3 V to 3.8 V programmed by I2C per 0.1 V.
> +    maxItems: 1
> +
> +  richtek,const-microvolt:
> +    description:
> +      Battery regulation voltage of constant voltage mode. This voltage =
levels from
> +      3.65 V to 4.4 V by I2C per 0.025 V.
> +    maxItems: 1

These are very generic currents and voltages, and their usage is well known
and generic. So they should not be prefixed "richtek,".

Use the properties already defined in
Documentation/devicetree/bindings/power/supply/battery.yaml
for these:

precharge-current-microamp
constant-charge-current-max-microamp
charge-term-current-microamp
precharge-upper-limit-microvolt
constant-charge-voltage-max-microvolt

Please double-check, I think those are the ones you need.

Perhaps it is possible to just $ref these properties directly and add
the additional restrictions on top.

Yours,
Linus Walleij
