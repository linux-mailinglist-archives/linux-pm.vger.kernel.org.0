Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B4B6E8C1F
	for <lists+linux-pm@lfdr.de>; Thu, 20 Apr 2023 10:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbjDTIGG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Apr 2023 04:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbjDTIGE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Apr 2023 04:06:04 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EEB30F9
        for <linux-pm@vger.kernel.org>; Thu, 20 Apr 2023 01:06:02 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-54ee0b73e08so31826017b3.0
        for <linux-pm@vger.kernel.org>; Thu, 20 Apr 2023 01:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681977961; x=1684569961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nF73EW7KaLWEV4V1D9aiONML0yXojDyO7zMClWna/aU=;
        b=bPDfI9eRhpTNkbg+3/X/aaxLsgYj6teALIjvGi9ObRhXZPvFCl6lyTe1DZ3qQC0L45
         ECFekxHa3S97BYyAuS7L3y0xSf2vRarM1ctf7LcyrTNSUFsKPwcunKO/2tWZzE1Qw8p7
         OnViZZbQayG8mhN8tObaFmv8pDkTKXxVuBTUO2kdNiyv4AYrER1uiCKX34QWVDdSh2Tp
         d8mZ2ciqd6KiT3mTPmTmY7cCSbcjm4RrAJAPCNB7Uazw8x0v2ihiYzU/xDXzePcXwqhF
         gOHWU9T7E4AxPRf9J3cguv996TKbrJBzjCYmPFygn0fdY/2ERO/0ocCxw2A7MQhV90Wp
         Usvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681977961; x=1684569961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nF73EW7KaLWEV4V1D9aiONML0yXojDyO7zMClWna/aU=;
        b=Nul1pnwHiA/eNtYirRJpcME47IOKL30IU2uL91JnxTdiXIOijFxzltAOzXazx/FEDO
         Ig+tonTsw4CtHQkOeRAmUEk5sJKPspnyXd3FG2UIlqvsZkVh6OH0BsZXOunj3NvCJnoE
         xN/bcKmLn7DvI35JwPeoduilhDEKb5sQt5wx9wWZzRrV2uE6bh912DUJnH8lsPIbtva8
         br/Iz7isRGgDlfp/eHwRbsM+H3B4yMkEAyjlw27pAYG+cMEw1e3NyM1h85n2fHZxMB0v
         y0ZSf/pAm1+r18sI9s9bFatxgN6iL5u6tHuK5krFCSQ8e6OGZRrpgSSXAJ9Z+zs9Yha7
         ouIw==
X-Gm-Message-State: AAQBX9dKVT/T7s2Bm7KxMilW8XTMZg6m9KQuNgXVj/rzJE//TfOrrBkx
        yzuTCjY++Dl/yNIVeJgBujQH3SET83vEVbDr1hndJA==
X-Google-Smtp-Source: AKy350Z6rGVhE3LnUUSr7NOdP5BTmzad2DawgJPMUQQYlYN51tsbOtHoOOvrQqh26AmqagNeb++cEGWuoshHZqyLJOk=
X-Received: by 2002:a81:7489:0:b0:552:b9db:f4b7 with SMTP id
 p131-20020a817489000000b00552b9dbf4b7mr247442ywc.3.1681977961239; Thu, 20 Apr
 2023 01:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1681646904.git.jahau@rocketmail.com> <a03e3939d733098a40c2ea0522da4e0bae9b2cb8.1681646904.git.jahau@rocketmail.com>
In-Reply-To: <a03e3939d733098a40c2ea0522da4e0bae9b2cb8.1681646904.git.jahau@rocketmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 Apr 2023 10:05:50 +0200
Message-ID: <CACRpkda4JPe-XE-_m4w_HbBBXrv4nkUtY_HJbexs+LCzcDu1-g@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] mfd: rt5033: Drop rt5033-battery sub-device
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
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Lee Jones <lee.jones@linaro.org>
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

On Sun, Apr 16, 2023 at 2:45=E2=80=AFPM Jakob Hauser <jahau@rocketmail.com>=
 wrote:

> From: Stephan Gerhold <stephan@gerhold.net>
>
> The fuel gauge in the RT5033 PMIC (rt5033-battery) has its own I2C bus
> and interrupt lines. Therefore, it is not part of the MFD device
> and needs to be specified separately in the device tree.
>
> Cc: Beomho Seo <beomho.seo@samsung.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Fixes: 0b271258544b ("mfd: rt5033: Add Richtek RT5033 driver core.")
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>

Looks correct,
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
