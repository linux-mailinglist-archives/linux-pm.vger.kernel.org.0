Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A6F6EA602
	for <lists+linux-pm@lfdr.de>; Fri, 21 Apr 2023 10:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjDUIkG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Apr 2023 04:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjDUIkF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Apr 2023 04:40:05 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3227DA8
        for <linux-pm@vger.kernel.org>; Fri, 21 Apr 2023 01:40:04 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-b990eb5dc6bso717059276.3
        for <linux-pm@vger.kernel.org>; Fri, 21 Apr 2023 01:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682066404; x=1684658404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qL0okSa4fl6lT5SbV7TFqePH64FBhd3DGjES0eamFSE=;
        b=Qpk8ZataXeh6Lpruso/poC5TcoVd23rkjv2FDUCwLKKOaGiBPrraz+DGZJTQLmPHF4
         kh1vXa72yCScc0w2DXOlfD7lgiK+PCUX+iAutpv+qs+S2PytpXj7yTymonyhnrqa6rvk
         uIGDTGh09p0Fq38xmoHCQ9dMQ0r9pHpRM72+l5AQpHMecBIPq8FNaGFMKFzTdcswPcxg
         zrB8W/H9o70fbwgZxuZGX8xDhf3jUgsHCPolhK89i7joS6jtq/xlf4RNl687/bIOC1py
         7PX245qgUmJS0jpwOmDR+nFjFTyn9VIAIfwAsVlBTXNSWmnEMZZt365hqt/hrQC6rj/c
         VAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682066404; x=1684658404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qL0okSa4fl6lT5SbV7TFqePH64FBhd3DGjES0eamFSE=;
        b=lT2x0mqO8+sczhn0OAAYs46UGE6Mr0hF/w1V91UD/YezdGwGF1HqzAun0wHyCyxUUE
         T/yH8KmfA/JYYztmHZCTZFCEcpf6k30bexP24riRug6qmyaEw4V4R4PFeNmo6c2dhD+C
         WXF6+xBk9BzXiXBauk72Jek6P8TNdnN9qb9JsYc+vPeMsy6fya7hNwOUO7/iQwCCos+G
         GG6BNapiqPLbjAYSq3Ndr1MMVpszEUmN8E8A3mPDP/Wp8vge+3LIIgnkryjLFJyNP5oy
         TpZr3QuI5+anhQv9QbmBmtLPrySbgQtuukALM35ZV9TuTUFiwxb4TPYA72a0sSXIvUbf
         d7Rg==
X-Gm-Message-State: AAQBX9eTWkamjjqu/sCHLs3StEYSIpnCf9VEAGILmqOjTXXeHAN6YswM
        hoTeMTCkuFtakVU7SOdtpan+H9v7+D+0TRD16suqUQ==
X-Google-Smtp-Source: AKy350b4e4o4eZVGwhgIvELH9pcw0I+hmwxNQXjNUszL4CT4NIjib5Vxc6Jiqvkv09xn6Vn6K67K0jnv1GMQZ970m7A=
X-Received: by 2002:a25:da0e:0:b0:b96:d843:33a with SMTP id
 n14-20020a25da0e000000b00b96d843033amr1683140ybf.54.1682066404106; Fri, 21
 Apr 2023 01:40:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230415160734.70475-1-hdegoede@redhat.com> <20230415160734.70475-2-hdegoede@redhat.com>
In-Reply-To: <20230415160734.70475-2-hdegoede@redhat.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Apr 2023 10:39:53 +0200
Message-ID: <CACRpkdYxvhWjC_OiZSNaPqW1b52=yYT0iOLmGf+_OY4A97Xm-g@mail.gmail.com>
Subject: Re: [PATCH 1/6] power: supply: ab8500: Fix external_power_changed race
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        laji Xiao <3252204392abc@gmail.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Apr 15, 2023 at 6:07=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:

> ab8500_btemp_external_power_changed() dereferences di->btemp_psy,
> which gets sets in ab8500_btemp_probe() like this:
>
>         di->btemp_psy =3D devm_power_supply_register(dev, &ab8500_btemp_d=
esc,
>                                                    &psy_cfg);
>
> As soon as devm_power_supply_register() has called device_add()
> the external_power_changed callback can get called. So there is a window
> where ab8500_btemp_external_power_changed() may get called while
> di->btemp_psy has not been set yet leading to a NULL pointer dereference.
>
> Fixing this is easy. The external_power_changed callback gets passed
> the power_supply which will eventually get stored in di->btemp_psy,
> so ab8500_btemp_external_power_changed() can simply directly use
> the passed in psy argument which is always valid.
>
> And the same applies to ab8500_fg_external_power_changed().
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Oh sweet!
Thanks for fixing this Hans.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
