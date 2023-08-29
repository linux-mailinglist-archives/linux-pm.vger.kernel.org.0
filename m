Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6929978BCB9
	for <lists+linux-pm@lfdr.de>; Tue, 29 Aug 2023 04:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbjH2CP4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Aug 2023 22:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235419AbjH2CPv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Aug 2023 22:15:51 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81614110;
        Mon, 28 Aug 2023 19:15:45 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-58fc4eaa04fso45410467b3.0;
        Mon, 28 Aug 2023 19:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693275344; x=1693880144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97srBsNV6oTrIvKBviaQ5sS5qJluzTDai93bJAqC3xc=;
        b=CjfX2IRlNx5394bDi7rz+7QpV9VWWGB1DtyK+uN95y5wzfJNWfoGL7aq62qjK8P7I6
         +gS3KzL6HehcW4vSN+OY69pr3NRCiCJCt04Aj8+w5aPSYqm3wX9nbtYoTJAQ82RIus+i
         C56wU7U3xCmn7iiuGo6bRV5hidabNFptuXT65RwtEZU+12H03ygGf1jWqiQgyzrlK5bq
         98wYhrK9g1XxlQIroqqDSX+Sygk0Xjgyzxf74Grl1rOWul3BkR4TV0lKJY3MegRDZSzQ
         Egeeqm8cWEW0sPwlD6qUPDoanqdq8KnOqbz+G7V1Yn1o+rgzJ/oxFlVBUavbSoxp41ZQ
         jqHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693275344; x=1693880144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97srBsNV6oTrIvKBviaQ5sS5qJluzTDai93bJAqC3xc=;
        b=Xboww10xCQFvNDRTEnKArjoiHH97Hu+GUojtLotEutpAWGRdrqtbgI1P8TyZ6iKhsv
         wgLskYGfFeWcPfKFK8cvNLCtjhVNMtWhUmJopVhg+8OF87bbs4s04aRNXyEKYjDq6Idj
         GsCSsvYbBaNZfSCmOfAR9pQQSTET0/k77hHwmPsPZbr1ttGJUMUo02P5kZfc+jEpWBf4
         jLxcBiK0V6EL07o9ScVKC+Ryn1tcGY42rEqV5nISRrfrn2gPEWAbxB4D1ly0sY1W5co+
         yk9cSUHFYyDRNrpIgUoL5ixxwe+IWLVkL0U53KcfaP/thKPmpWklR+XhY2jI2Y3HBatC
         e91Q==
X-Gm-Message-State: AOJu0YxADt+vH0U2ax1OO/T11PItq16cJAIg6Q/XEKvw9OxB0WbyyzLw
        qTe+NtThuGtreOxX7BsE3lfVk1HaA9QkzRlsZW4=
X-Google-Smtp-Source: AGHT+IGKUHiiGwHxPNHo2fHKNZYJMJ1G7S9OpNgtuN5xsv5YUPl+cpDee1drXnh3czmUXCFMI7zeKCYkBj0y43qin3g=
X-Received: by 2002:a0d:f585:0:b0:589:f7ad:7702 with SMTP id
 e127-20020a0df585000000b00589f7ad7702mr29701494ywf.36.1693275344686; Mon, 28
 Aug 2023 19:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693218539.git.zhoubinbin@loongson.cn> <2bec39b1001732de60c1521d78e44a45ff94d6b6.1693218539.git.zhoubinbin@loongson.cn>
 <18b8b8b8-7f42-8e8c-1bfd-36d04eba7c40@linaro.org>
In-Reply-To: <18b8b8b8-7f42-8e8c-1bfd-36d04eba7c40@linaro.org>
From:   Binbin Zhou <zhoubb.aaron@gmail.com>
Date:   Tue, 29 Aug 2023 10:15:32 +0800
Message-ID: <CAMpQs4+X+e301CHkrtDQj9A=nTxUFQJPOuqJnPc+ViDcNZBgDQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] dt-bindings: soc: loongson,ls2k-pmc: Allow
 syscon-reboot/syscon-poweroff as child
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

Hi Krzysztof:

Thanks for your reply.

On Tue, Aug 29, 2023 at 1:17=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 28/08/2023 14:38, Binbin Zhou wrote:
> > The reboot and poweroff features are actually part of the Power
> > Management Unit system controller, thus allow them as its children,
> > instead of specifying as separate device nodes with syscon phandle.
> >
>
> >  required:
> >    - compatible
> >    - reg
> > @@ -44,10 +56,25 @@ examples:
> >    - |
> >      #include <dt-bindings/interrupt-controller/irq.h>
> >
> > -    power-management@1fe27000 {
> > +    pmc: power-management@1fe27000 {
>
> Drop the label.
OK...
>
> >          compatible =3D "loongson,ls2k1000-pmc", "syscon";
> >          reg =3D <0x1fe27000 0x58>;
> >          interrupt-parent =3D <&liointc1>;
> >          interrupts =3D <11 IRQ_TYPE_LEVEL_LOW>;
> >          loongson,suspend-address =3D <0x0 0x1c000500>;
> > +
> > +        syscon-reboot {
> > +            compatible =3D"syscon-reboot";
> > +            regmap =3D <&pmc>;
>
> No, why? It does not make much sense and is deprecated.

Oh, sorry, I should have been more careful, I'll delete it.
>
> > +            offset =3D <0x30>;
> > +            mask =3D <0x1>;
> > +        };
> > +
> > +        syscon-poweroff {
> > +            compatible =3D"syscon-poweroff";
>
> Missing space.
I will fix it.

Thanks.
Binbin
>
> Best regards,
> Krzysztof
>
