Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A76E78F75C
	for <lists+linux-pm@lfdr.de>; Fri,  1 Sep 2023 05:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242063AbjIADF3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Aug 2023 23:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234493AbjIADF2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Aug 2023 23:05:28 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19A3E7C;
        Thu, 31 Aug 2023 20:05:24 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-58dce1f42d6so36932727b3.0;
        Thu, 31 Aug 2023 20:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693537524; x=1694142324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzzhdRRz+84nDeWWLMEXfVPuhXA1oo9sQKDIU2jXLKE=;
        b=CRylxYQwCo1qajb4BmM8DvxCdKRc86kD74IFneentvisP6WQEsSeQuicJVxC0MW4nU
         NzODzQWTTqnWQFTMZhgMSxnn5D2C6Fwa8UlDPRGlECUSe/nmB3WgzAMhecwWaQbBMttB
         yT0mqSYOdTBmt5IDqXpVfeRj6CQE8+UVTocIuWB3awdELIdDYsgZLg/7all1it/2stqE
         7M7c/4Kth+AdwGDsfk9X5m1q02o3pNOB7icjw/4l2LGO7+qv/MOIxTYFXb9Ss3xZvTrG
         QqQTcDaODugrCn0+s0sub7uoZE8bBgbq2Ic7Heige+JNyfSCy/Ehu3MOtv2Np6nE3UdN
         yajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693537524; x=1694142324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CzzhdRRz+84nDeWWLMEXfVPuhXA1oo9sQKDIU2jXLKE=;
        b=TUQEKNxx8EOCDWHMRgTQQH8+Y8ndkC7NipqdDI/IYGVkz81LZY10pI6bT5Z70wNawr
         GXbNGO3DxDu6jcvmLyWNL+/ferduzeEKL0G67+ptswuMDh2+e4UIOseUOL0KrGoUNJM8
         C7UqNNJUqMVEs3H9A1kWJTLSoP+KrG3MNKXEx+6C3Sqo3GW4fmtBzgN+pPj5yhSf/KGI
         CUBwGzWz1PioLj4HRAzjPV42kBMLfEDf3ns6AYaz35Gm6uHmagmVUjcbNN4yXew/XRVT
         LzbhmnHxkp0Pr96WnOMgteaKowNEDQKiAa0fFkmooSStYL+1A8YkMicTlZNUjzSRws7E
         8xXQ==
X-Gm-Message-State: AOJu0YxGj4ASSs5ISCnJbUQIzZhXtQDvuazWQMH6t2CZS8HnYx44vQEG
        pc2Eq71c1E/QbAPsdBQnzKvAzBqk1Zri9NXtKpDapDxSLLkH6/2cL3w=
X-Google-Smtp-Source: AGHT+IEJQ/UnswWklefCzgEHvWHAJOerPe/H2CzyND+TNL/LPrnmDHwD+//eG8lI6MC/fhA9o6DMv8wR+lP5bYqvsro=
X-Received: by 2002:a0d:d605:0:b0:56c:f0c7:7d72 with SMTP id
 y5-20020a0dd605000000b0056cf0c77d72mr2225622ywd.4.1693537523953; Thu, 31 Aug
 2023 20:05:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693474728.git.zhoubinbin@loongson.cn> <bf09b11ec6a0102f85dc2b3289d003271304e24d.1693474728.git.zhoubinbin@loongson.cn>
 <20230831-ambition-refusing-08e63b345573@spud>
In-Reply-To: <20230831-ambition-refusing-08e63b345573@spud>
From:   Binbin Zhou <zhoubb.aaron@gmail.com>
Date:   Fri, 1 Sep 2023 11:05:12 +0800
Message-ID: <CAMpQs4JbUx9N4MmfM6vRsdQBHyUcU9UHGX23UewL5Matt6iXnQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] soc: loongson: loongson_pm2: Drop useless
 of_device_id compatible
To:     Conor Dooley <conor@kernel.org>
Cc:     Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        loongson-kernel@lists.loongnix.cn, soc@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Conor:

Thanks for your reply.

On Thu, Aug 31, 2023 at 11:15=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Thu, Aug 31, 2023 at 07:43:13PM +0800, Binbin Zhou wrote:
> > Now, "loongson,ls2k0500-pmc" is used as fallback compatible, so the
> > ls2k1000 compatible in the driver can be dropped directly.
> >
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > ---
> >  drivers/soc/loongson/loongson2_pm.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/soc/loongson/loongson2_pm.c b/drivers/soc/loongson=
/loongson2_pm.c
> > index 796add6e8b63..5ffb77afd9eb 100644
> > --- a/drivers/soc/loongson/loongson2_pm.c
> > +++ b/drivers/soc/loongson/loongson2_pm.c
> > @@ -197,7 +197,6 @@ static int loongson2_pm_probe(struct platform_devic=
e *pdev)
> >
> >  static const struct of_device_id loongson2_pm_match[] =3D {
> >       { .compatible =3D "loongson,ls2k0500-pmc", },
> > -     { .compatible =3D "loongson,ls2k1000-pmc", },
>
> What about older devicetrees that do not have the fallback? Aren't you
> going to remove support for those?

This driver was just merged in during the v6.6 window, and no release
will use it until now.

commit 67694c076bd7 soc: loongson2_pm: add power management support
commit 6054a676e969 soc: dt-bindings: add loongson-2 pm

Of course, it was our mistake not to make better use of fallback
compatible when submitting the driver, and we hope to fix this mistake
soon.
Also, this driver will only be used by the LoongArch architecture, no
need to worry about other architectures.

Thanks.
Binbin
>
> >       {},
> >  };
> >
> > --
> > 2.39.3
> >
