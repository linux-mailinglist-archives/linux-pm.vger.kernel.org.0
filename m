Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB426F824E
	for <lists+linux-pm@lfdr.de>; Fri,  5 May 2023 13:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjEELvw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 May 2023 07:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjEELvv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 May 2023 07:51:51 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F36F3C29
        for <linux-pm@vger.kernel.org>; Fri,  5 May 2023 04:51:46 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-559e2051d05so23473487b3.3
        for <linux-pm@vger.kernel.org>; Fri, 05 May 2023 04:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683287505; x=1685879505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+erYGuzVel6Wt0GXIzw1tiExd3TT8UKse0/nxpknnw=;
        b=EekaU10y4mPaDuwkIsS+ze7K2LN+h46tvg0V5OHhGTeO7KmtTDKMkkCdIH1ptIrMhk
         Vadr1560duuxogcdD7Y5Xvm2CUAY1fFRMaFx/Sv0/4kcSLG/cYNoC1hMEjhqo40f4SPe
         PjjO8F2PcunZER2BHewKHIsWmdtJJHvQ7BlgLlfKRHKd4JclX0IfkfT8DYV6BHXxOvfq
         XJEIhLbQ0189I4pRlf3WohiZoYxYx+zlWr5oVYw6Zhl2EQzTFhsiEqLE6adAXD69UJ6T
         Mzity5p4MbDJh26qyVQNAoyb252ewbu9/UP7xC9J/gdwlpAA1ivddTk3iaoHLSOep3jA
         0oRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683287505; x=1685879505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K+erYGuzVel6Wt0GXIzw1tiExd3TT8UKse0/nxpknnw=;
        b=cyIRGGZVqdJmbDMY1I7Ndr8NkYrmVhlOH0v/AI6PhvgJE71hoTD3nSkOQ4oWD8janS
         L03Rpf+UeK5fbTVogFo9ErXn4DAWSHXpgLFOa/3LFQQnLbQPupLq4wVkuBFAN7fsyAMp
         PQSMP4Roogumg/cfmTJGX30CH3DDGV7Q7qpRXbwKrSNhLxpBsEnGMlNbd8aeo5j/xDN5
         6SzLjrCYu9EjNzDUyZTxzADLY+iZJGrET9PQw3icecXtYBTfT/sKFunwmbOmmgU06CWa
         SmenE4fl7pHLQvpIsIXCsTOsJc3X5F9e0IjVAVGWrPmBMnZoqVHWREw52io32T4IAYPT
         DcCg==
X-Gm-Message-State: AC+VfDySIWqyEb8W6Igpt7tmYlncBUbWtBRUFyhl5q8evzPZ3q8wWsz1
        iWPeUWot4uriZrXluAXQgbbg1F63xmOLSjFmB4zzlA==
X-Google-Smtp-Source: ACHHUZ72VZFro+QtTbr7MzxxcYK8XCqJtk/0gqzbSspfOgrWdA9IaMs98R7MewYhJdrzh0UgXP7iKkPM25YuT7m+nAg=
X-Received: by 2002:a81:5456:0:b0:55a:5ce4:aff2 with SMTP id
 i83-20020a815456000000b0055a5ce4aff2mr1302691ywb.39.1683287505527; Fri, 05
 May 2023 04:51:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1682636929.git.jahau@rocketmail.com> <0070da504581081906a30d1095b104c4c2930e86.1682636929.git.jahau@rocketmail.com>
In-Reply-To: <0070da504581081906a30d1095b104c4c2930e86.1682636929.git.jahau@rocketmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 5 May 2023 13:51:34 +0200
Message-ID: <CACRpkdYrCtSmuQmg5qbeXfgHGwsMxyfyB=95SGZ33QB6fh=Utg@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] power: supply: rt5033_charger: Add RT5033 charger
 device driver
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 28, 2023 at 1:30=E2=80=AFAM Jakob Hauser <jahau@rocketmail.com>=
 wrote:

> This patch adds device driver of Richtek RT5033 PMIC. The driver supports
> switching charger. rt5033 charger provides three charging modes. The char=
ging
> modes are pre-charge mode, fast charge mode and constant voltage mode. Th=
ey
> vary in charge rate, the charge parameters can be controlled by i2c inter=
face.
>
> Cc: Beomho Seo <beomho.seo@samsung.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Tested-by: Raymond Hackley <raymondhackley@protonmail.com>
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

> +       ret =3D power_supply_get_battery_info(charger->psy, &info);
> +       if (ret) {
> +               dev_err(charger->dev, "failed to get battery info\n");
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       /* Assign data. Validity will be checked in the init functions. *=
/
> +       chg->pre_uamp =3D info->precharge_current_ua;
> +       chg->fast_uamp =3D info->constant_charge_current_max_ua;
> +       chg->eoc_uamp =3D info->charge_term_current_ua;
> +       chg->pre_uvolt =3D info->precharge_voltage_max_uv;
> +       chg->const_uvolt =3D info->constant_charge_voltage_max_uv;

Code reuse, exactly how it should be! :)

Yours,
Linus Walleij
