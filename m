Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223177BA923
	for <lists+linux-pm@lfdr.de>; Thu,  5 Oct 2023 20:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjJESby (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Oct 2023 14:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjJESbx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Oct 2023 14:31:53 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA11CE
        for <linux-pm@vger.kernel.org>; Thu,  5 Oct 2023 11:31:48 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3231df68584so1229835f8f.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Oct 2023 11:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696530707; x=1697135507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3oHq99QeF5JtNLpOndq/jeK1gHtPcoa92kZKu0RXp4=;
        b=xwacADu0EE2nLRE+LIPl3L0YI0xa35Xjl3UmQJWYOGtUpRZYAXF7niZeKZZdvBEskf
         n2rHdWQa38LsCxtZbUgh1oresvgZVQkTexz7KtRckZILxDheN8jLS/UOG0Syi45geZai
         YwSSKyFVKbqOot88TS+gRC89nKUAjB0mepjKG7gHuL9KeERfTKFIWO09MBb0EUMEbf/j
         u3TTFu64oJH2j/ErSEB+PwKqkYlKrHVUim7COOpDBOfewK43dgCzjGD2L8h2lxichuQ7
         2DO51hPaLbGFb63Bt/RcIpf9WLC9tboZRNZWpbruHzf2VmyvcJ4MjSjLpXQcZQNTZJJK
         zd5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696530707; x=1697135507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3oHq99QeF5JtNLpOndq/jeK1gHtPcoa92kZKu0RXp4=;
        b=pBJ57bA+6NXx5hotUlB83FS3OOJPOVBR2d8vK8E7ngWvs5gSJePViiMO4kIUBetnjC
         ol8jHu4+abIR3cONq36AV0VvjhHuncBdvVgT5kARd6dMCvrOBdNlPpCSDCn0wb9mM/oO
         8k6Hcz26DYwQr+4kX6UDVLWeyP6CagTLeBwPpyZrftd7yT4CUSfdxb5DQ7tXo7A4Wkqg
         wjGCRRNG6tV5JNudW+cxm6u4FeHVpjGaXCuNC7EXXwcy4dO4XgWUYkCHb2C0kWO68g4v
         nia8LWLtqrFSdwsf0ZXbTNF6b7/NXnGxG2d0lqS5e1nlaKVPdtHJwUfXU7xNst8zRQfq
         xH2Q==
X-Gm-Message-State: AOJu0YyH11jsQbl5xMonajz/7YDnv7NOjO5pjvrsR+dp8oIFMo2BltJk
        chyz2TVDzdunW4wLJgLHL6S0WtLUHz7jjYd18QTV9A==
X-Google-Smtp-Source: AGHT+IGjcp95cX6dB00l0Dlwo8I89MDeu9iDd7gxrJ6XWjmStfUtDvPIkS6czEb/hhrzPdEHuyeLenet0F0iLbILJfU=
X-Received: by 2002:adf:ce90:0:b0:321:cec8:e64d with SMTP id
 r16-20020adfce90000000b00321cec8e64dmr5676004wrn.62.1696530707248; Thu, 05
 Oct 2023 11:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231005-opp-of-wunsequenced-v1-1-778815980a8d@kernel.org>
In-Reply-To: <20231005-opp-of-wunsequenced-v1-1-778815980a8d@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 5 Oct 2023 11:31:32 -0700
Message-ID: <CAKwvOdmhtS6LAcckceXLftKeqxthdHEEi-zr8EiOW0hRYwsjEA@mail.gmail.com>
Subject: Re: [PATCH] OPP: Fix -Wunsequenced in _of_add_opp_table_v1()
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        ulf.hansson@linaro.org, trix@redhat.com, linux-pm@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 5, 2023 at 10:25=E2=80=AFAM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> Clang warns (or errors with CONFIG_WERROR=3Dy):
>
>   drivers/opp/of.c:1081:28: error: multiple unsequenced modifications to =
'val' [-Werror,-Wunsequenced]
>    1081 |                         .freq =3D be32_to_cpup(val++) * 1000,
>         |                                                 ^
>    1082 |                         .u_volt =3D be32_to_cpup(val++),
>         |                                                   ~~
>   1 error generated.
>
> There is no sequence point in a designated initializer. Move back to
> separate variables for the creation of the values, so that there are
> sequence points between each evaluation and increment of val.
>
> Closes: https://github.com/ClangBuiltLinux/linux/issues/1940
> Fixes: 75bbc92c09d8 ("OPP: Add dev_pm_opp_add_dynamic() to allow more fle=
xibility")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/opp/of.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index ade6d42cae46..ae5c405bbf9a 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -1077,9 +1077,11 @@ static int _of_add_opp_table_v1(struct device *dev=
, struct opp_table *opp_table)
>
>         val =3D prop->value;
>         while (nr) {
> +               unsigned long freq =3D be32_to_cpup(val++) * 1000;
> +               unsigned long volt =3D be32_to_cpup(val++);
>                 struct dev_pm_opp_data data =3D {
> -                       .freq =3D be32_to_cpup(val++) * 1000,
> -                       .u_volt =3D be32_to_cpup(val++),
> +                       .freq =3D freq,
> +                       .u_volt =3D volt,
>                 };
>
>                 ret =3D _opp_add_v1(opp_table, dev, &data, false);
>
> ---
> base-commit: 3c4746e28af13fdd134d3c4312169fda0a8abef0
> change-id: 20231005-opp-of-wunsequenced-a594ea4c053d
>
> Best regards,
> --
> Nathan Chancellor <nathan@kernel.org>
>


--=20
Thanks,
~Nick Desaulniers
