Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC65978BD36
	for <lists+linux-pm@lfdr.de>; Tue, 29 Aug 2023 05:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbjH2DWU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Aug 2023 23:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbjH2DVu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Aug 2023 23:21:50 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6545FB0;
        Mon, 28 Aug 2023 20:21:48 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5925e580f12so46084677b3.3;
        Mon, 28 Aug 2023 20:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693279307; x=1693884107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tznbSrqbTYrL6aa//PktqAGLJX0MgTHfaefFsG17/rg=;
        b=p+37/57y4irqBxJm+CPG9LwFyjB6Angk7FVp4duR1qrtwW8vwmEZDH/+10X21KweaI
         5y55jMEORmweAWCvAagRGrz1IqC86HMnbHF/QCU/kiQ1iCD+Xsv4GP/cvkRnsafcoIpz
         xTBzdqe0sZxqzV7UBTACSblr3WvXklh7Km7ZUpx2/Y7gvyumNWK8QwDlLvld3+MV2S5x
         YASf2I4JSr1urLhrXIyj2obm38vEDfOp2+XEj2H0fzu7GJgmQ8X+/PtPUbXXabDlIcLg
         ce+/C+RpwewsaV3Js7LWHTbuoXc8x12XVHLlDeXmoiE4vxVokNKRodZ59o6T4LNJNOsB
         KESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693279307; x=1693884107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tznbSrqbTYrL6aa//PktqAGLJX0MgTHfaefFsG17/rg=;
        b=ZdHpaaULvHVagDg5Mmi3Ln9pn+kvk9eCJfH1kd3snN3lKa+wYiR8XDZ354AgM7D5qD
         gjo3zbrrPcHzL9YL0oCnSUnefT9bDXkOQHyzjNkjlFlwaqMfXNnmJqthwmXulipBQzaa
         Eeyfg+m2JxHB8/WQXS9wpkRG5eOmohwH4X2i4ES1qUffeDK8KZ0+fnYD3Kr/JRbYXUuy
         OaYjG2t+TttsUStlkSC6q81uxIuzkpZKbZNzy7dgSWifsVTlNvucuftbdkpK5W3tp2rf
         rvxuHU5OWatOQYlVFdOevsaG963Ln4cEDq3tScmO2ao4Xj0rjcO/+Nq4N8IodVruav/3
         68gQ==
X-Gm-Message-State: AOJu0YwjzquCZHn9pJZSJ+wDr/VL+7m8xA5QGXI1hwRq6n8rjV+wrx0w
        zfqrEQVNP4Ld6Guleoadp5/p1fTLB4VLqQrCEqh3ZhwqW708xw==
X-Google-Smtp-Source: AGHT+IFZpzRf4VMB1cTbblua+7dBwI0HDUjSLrC3qyH8m2jI6R0UGvJmJIhosMVfA7a/iyAguUDqWCYFb2xb9X6fzmY=
X-Received: by 2002:a81:b661:0:b0:58c:676c:b3ef with SMTP id
 h33-20020a81b661000000b0058c676cb3efmr29077078ywk.6.1693279307612; Mon, 28
 Aug 2023 20:21:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693218539.git.zhoubinbin@loongson.cn> <54ee114c08f35ab8b5dc584fd76135ac9076f5a7.1693218539.git.zhoubinbin@loongson.cn>
 <20230828-shrewdly-payee-c5eb091a0417@spud>
In-Reply-To: <20230828-shrewdly-payee-c5eb091a0417@spud>
From:   Binbin Zhou <zhoubb.aaron@gmail.com>
Date:   Tue, 29 Aug 2023 11:21:35 +0800
Message-ID: <CAMpQs4Jp0rb8sbrLrPnNziLph4Ym4LxBsFt-00G69ecd8bUHNg@mail.gmail.com>
Subject: Re: [PATCH 2/5] dt-bindings: soc: loongson,ls2k-pmc: Add missing
 compatible for Loongson-2K2000
To:     Conor Dooley <conor@kernel.org>
Cc:     Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        loongson-kernel@lists.loongnix.cn, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>,
        loongarch@lists.linux.dev
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

HI Conor:

Thanks for your reply.

On Mon, Aug 28, 2023 at 11:49=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Mon, Aug 28, 2023 at 08:38:32PM +0800, Binbin Zhou wrote:
> > Document the Power Management Unit system controller compatible for
> > Loongson-2K2000.
> >
> > This is a missing compatible, now we add it.
> >
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > ---
> >  .../devicetree/bindings/soc/loongson/loongson,ls2k-pmc.yaml      | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/soc/loongson/loongson,ls=
2k-pmc.yaml b/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-=
pmc.yaml
> > index da2dcfeebf12..7473c5659929 100644
> > --- a/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pmc.=
yaml
> > +++ b/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pmc.=
yaml
> > @@ -15,6 +15,7 @@ properties:
> >        - enum:
> >            - loongson,ls2k0500-pmc
> >            - loongson,ls2k1000-pmc
> > +          - loongson,ls2k2000-pmc
>
> Same thing here as the driver patch, the pmc on this newly added SoC
> appears to use the same codepaths as the existing ones. Does it share a
> programming model & should there be a fallback compatible here?

I noticed the guideline about fallback compatible:

"DO use fallback compatibles when devices are the same as or a subset
of prior implementations."

But in fact, ls2k0500/ls2k1000/ls2k2000 are independent, there is no subset=
.
Can we define a "loongson,ls2k-pmc" superset for each ls2k SoC
compatible fallback.

Such as:

  compatible:
    oneOf:
      - enum:
          - loongson,ls2k0500-pmc
          - loongson,ls2k1000-pmc
          - loongson,ls2k2000-pmc
      - const: loongson,ls2k-pmc
      - const: syscon

Thanks.
Binbin

>
> >        - const: syscon
> >
> >    reg:
> > --
> > 2.39.3
> >
