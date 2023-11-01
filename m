Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2707DDAA5
	for <lists+linux-pm@lfdr.de>; Wed,  1 Nov 2023 02:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbjKABi5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Oct 2023 21:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347113AbjKABi4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Oct 2023 21:38:56 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E48F1;
        Tue, 31 Oct 2023 18:38:52 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d9c7bba32beso5939226276.1;
        Tue, 31 Oct 2023 18:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698802731; x=1699407531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfdFhhcZh0XNUSFxOHIIYroGz/KpzxQNSvIELIQ4a8I=;
        b=d3xnm8JM7WySLawL3v/g5Ua9p4sC59rAC5ERU1HdWXJ2jSdq8BMCjqLNGLKwYLDEAZ
         pJxwLNfQx1zunCFwtODjR84oqYwxut2xJe4bqSknuPWrtDgTq6hclby9Q95X6LCGZ780
         BXg8W0dEBR5woIJnmSkU94B1KDMjxTyVoYIgEHZFpl9n/3TSEBFvFxvPxb8lVgSVAxCb
         Y947U9kjohh4GuKX0AGr6rIv+Rh8cB0LlOgS1Y4lIxEA3PN9eUcNk4MUf/yZC69SnM+q
         o+x3rzqTAuuWp7cWCl0iUTKl0/KhBqbe8RiN9B34Rnmxsv/Y3qX/dKsAg1nkZ4JkTphy
         74Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698802731; x=1699407531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QfdFhhcZh0XNUSFxOHIIYroGz/KpzxQNSvIELIQ4a8I=;
        b=g1nGNPhriwhoiRKHMrIX7DJTLTSxK0Td/6TiiUQIOCP5tN9E2ImLqUV8MbxnytISKP
         fDoujuPPccC5G8qWApVMSXl8Zl2r/KboVPeo7SE+XGZQ2TyZKRB2DXV2DByWX+Kh7D8h
         MTSH7esS5jt9Jy0KgFpg7lcKRkv6B7/oC4njbZcYgUb/l54Gid5PBwObMP/z+/I8dhav
         HeHN9uvG5NOJDzr97F1EtG4PyFfANkrZTBqpu0YUvVjpozL0QGgi5+qcL8cFG1sr2DJb
         fHuqjrgxv6a/UePdqdsrcYR61TrqcpdZY0UMkscT3hSxvZedkd6iX6OZO7EQ7XMi+uy0
         Hxag==
X-Gm-Message-State: AOJu0YxBrghKb3glYyPFJEvydnWX7WEGX4yOHhVdusCykbvko56fLFvm
        u7ue8OFeLsIfxX15mueBB9Y2YIKbYYXLaWU8ZfE=
X-Google-Smtp-Source: AGHT+IE5QNgYVhASEwlIN4zeo846ftPgjgWyiyvur7YKctM92yabJQEqAGLhi4n12YjsVydrMXrTzTjRTaWNOtx6/Vw=
X-Received: by 2002:a25:2305:0:b0:da0:659f:c4fe with SMTP id
 j5-20020a252305000000b00da0659fc4femr14692512ybj.8.1698802730891; Tue, 31 Oct
 2023 18:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1698743706.git.zhoubinbin@loongson.cn> <944559ea3bf7ba0a1540f831ccd7d33591622b22.1698743706.git.zhoubinbin@loongson.cn>
 <20231031-negative-giveaway-6191a2da0cd5@spud>
In-Reply-To: <20231031-negative-giveaway-6191a2da0cd5@spud>
From:   Binbin Zhou <zhoubb.aaron@gmail.com>
Date:   Wed, 1 Nov 2023 07:38:39 +0600
Message-ID: <CAMpQs4+3T9RATpJ5VycnEzkOTx_M2vdt6WPJv_B1Efy81RzCjA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: thermal: loongson,ls2k-thermal: Fix
 binding check issues
To:     Conor Dooley <conor@kernel.org>
Cc:     Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        loongson-kernel@lists.loongnix.cn, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Yinbo Zhu <zhuyinbo@loongson.cn>,
        WANG Xuerui <git@xen0n.name>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 31, 2023 at 10:58=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Tue, Oct 31, 2023 at 07:05:49PM +0800, Binbin Zhou wrote:
> > Add the missing 'thermal-sensor-cells' property which is required for
> > every thermal sensor as it's used when using phandles.
> > And add the thermal-sensor.yaml reference.
> >
> > Fixes: 72684d99a854 ("thermal: dt-bindings: add loongson-2 thermal")
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > ---
> >  .../bindings/thermal/loongson,ls2k-thermal.yaml        | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/thermal/loongson,ls2k-th=
ermal.yaml b/Documentation/devicetree/bindings/thermal/loongson,ls2k-therma=
l.yaml
> > index 7538469997f9..b634f57cd011 100644
> > --- a/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.y=
aml
> > +++ b/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.y=
aml
> > @@ -10,6 +10,9 @@ maintainers:
> >    - zhanghongchen <zhanghongchen@loongson.cn>
> >    - Yinbo Zhu <zhuyinbo@loongson.cn>
> >
> > +allOf:
> > +  - $ref: /schemas/thermal/thermal-sensor.yaml#
> > +
> >  properties:
> >    compatible:
> >      oneOf:
> > @@ -26,12 +29,16 @@ properties:
> >    interrupts:
> >      maxItems: 1
> >
> > +  '#thermal-sensor-cells':
> > +    const: 1
> > +
> >  required:
> >    - compatible
> >    - reg
> >    - interrupts
> > +  - '#thermal-sensor-cells'
>
> Why does it need to be a required property now though?
> Adding new required properties is technically an ABI break.

Hi Conor:

I don't think it makes sense to have a separate thermal sensor
definition, it needs thermal-zones to describe specific behaviors,
e.g. cpu-thermal, so we need '#thermal-sensor-cells' to specify the
reference.
And the Loongson-2K1000 has 4 sets of control registers, we need to
specify the id when referencing it.

Thanks.
Binbin
>
> Cheers,
> Conor.
>
> >
> > -additionalProperties: false
> > +unevaluatedProperties: false
> >
> >  examples:
> >    - |
> > @@ -41,4 +48,5 @@ examples:
> >          reg =3D <0x1fe01500 0x30>;
> >          interrupt-parent =3D <&liointc0>;
> >          interrupts =3D <7 IRQ_TYPE_LEVEL_LOW>;
> > +        #thermal-sensor-cells =3D <1>;
> >      };
> > --
> > 2.39.3
> >
