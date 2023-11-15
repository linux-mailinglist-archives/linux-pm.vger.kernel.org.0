Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873197EBD3B
	for <lists+linux-pm@lfdr.de>; Wed, 15 Nov 2023 07:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbjKOGvD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Nov 2023 01:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234602AbjKOGu6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Nov 2023 01:50:58 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E45EB;
        Tue, 14 Nov 2023 22:50:54 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a7b91faf40so75248647b3.1;
        Tue, 14 Nov 2023 22:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700031053; x=1700635853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POR86ACWq50gnyaMlW3Qse0dtzLOhtouY3Pos+VsSEI=;
        b=aXebQ5bkyoFbSHg5SDogMSy4C4sKKIoOewXqPj45PpfKStbwv+Jeq8gk+iCkRcaySa
         SSKreVUDHpMVR6WdNOnnK6RfRy2hpbh2gwrriBxuGKzo7s8L8UOVLJIQ7CsqQnA5R1FO
         w1zQeatnbqPd04rDEb/+/sqXQnWIDd7QcXG261ucb6GomiufANQX5YYJEKOupVdnblsm
         zkyEBHY46NLtbD7wqRqnATLFEQV2VEBNg2GvIaTckX+AthzRZPm0+Oy7f4eBXQc5weVO
         z4NcJmKJWLN975su65y/kQ1UCRQdzpwWYRLrd78RG9X1ArSz6Y+kpmm9rWKSvyxEXRXR
         T0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700031053; x=1700635853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POR86ACWq50gnyaMlW3Qse0dtzLOhtouY3Pos+VsSEI=;
        b=I2qUf7TYurStwOYYbFNjxLWPsH8EuyScSR5/lQRikLBEeAwpKD7Lwn3WAyTF8PSU0X
         9K7ARqYzBGaMKyYbgqMHSLphLk2beC323bQo7jCpiKBfL5OhEYHP0FV/IXE8Qu28fUgZ
         6KKdWRMlq85OxobAyWifH7pXH6cD1RcqJYOCoF+oNjG69RwRYfmZZHNnrpD7fSY5uJZg
         9aSt1VLPl+L1QV+TTgClbUUw4ky8+m15WFl3RLv8I4PCzCbmMQ/X0T4JmnHApXIasdX4
         zI6QQS/Jj3v98ydwfoJbx87j0ZfpLH+xAkM6Vr5a2MRVD/HjcGjhh3O9Hqedicj4pktM
         ceMg==
X-Gm-Message-State: AOJu0YzMVSP+PP5uLD92sFl6kjLPSnRjSxwUDV8tuDgFSc3L86VlZHCM
        keqBZtpDmoYWLbeDsJ6/gns1QYKMkYMFhjMaK1tXlYpb7Z4=
X-Google-Smtp-Source: AGHT+IEvWU+xADG1vVrhuo05S5yemv8lG8npJc7Gem1sHpS7JujsnjhW9DN6x9wSerRwOITRWwumplSH2YEoe+kS57E=
X-Received: by 2002:a25:383:0:b0:da0:6257:8da4 with SMTP id
 125-20020a250383000000b00da062578da4mr9881399ybd.57.1700031053336; Tue, 14
 Nov 2023 22:50:53 -0800 (PST)
MIME-Version: 1.0
References: <cover.1698743706.git.zhoubinbin@loongson.cn> <944559ea3bf7ba0a1540f831ccd7d33591622b22.1698743706.git.zhoubinbin@loongson.cn>
 <20231031-negative-giveaway-6191a2da0cd5@spud> <CAMpQs4+3T9RATpJ5VycnEzkOTx_M2vdt6WPJv_B1Efy81RzCjA@mail.gmail.com>
 <20231101-clone-facsimile-fd4c37333842@spud>
In-Reply-To: <20231101-clone-facsimile-fd4c37333842@spud>
From:   Binbin Zhou <zhoubb.aaron@gmail.com>
Date:   Wed, 15 Nov 2023 12:50:41 +0600
Message-ID: <CAMpQs4L_85yPQXR4t=kaCEuwXK-Jr=L6G=omhAtrOn7CWUMCKw@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 1, 2023 at 1:59=E2=80=AFPM Conor Dooley <conor@kernel.org> wrot=
e:
>
> On Wed, Nov 01, 2023 at 07:38:39AM +0600, Binbin Zhou wrote:
> > On Tue, Oct 31, 2023 at 10:58=E2=80=AFPM Conor Dooley <conor@kernel.org=
> wrote:
> > >
> > > On Tue, Oct 31, 2023 at 07:05:49PM +0800, Binbin Zhou wrote:
> > > > Add the missing 'thermal-sensor-cells' property which is required f=
or
> > > > every thermal sensor as it's used when using phandles.
> > > > And add the thermal-sensor.yaml reference.
> > > >
> > > > Fixes: 72684d99a854 ("thermal: dt-bindings: add loongson-2 thermal"=
)
> > > > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > > > ---
> > > >  .../bindings/thermal/loongson,ls2k-thermal.yaml        | 10 ++++++=
+++-
> > > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/thermal/loongson,ls2=
k-thermal.yaml b/Documentation/devicetree/bindings/thermal/loongson,ls2k-th=
ermal.yaml
> > > > index 7538469997f9..b634f57cd011 100644
> > > > --- a/Documentation/devicetree/bindings/thermal/loongson,ls2k-therm=
al.yaml
> > > > +++ b/Documentation/devicetree/bindings/thermal/loongson,ls2k-therm=
al.yaml
> > > > @@ -10,6 +10,9 @@ maintainers:
> > > >    - zhanghongchen <zhanghongchen@loongson.cn>
> > > >    - Yinbo Zhu <zhuyinbo@loongson.cn>
> > > >
> > > > +allOf:
> > > > +  - $ref: /schemas/thermal/thermal-sensor.yaml#
> > > > +
> > > >  properties:
> > > >    compatible:
> > > >      oneOf:
> > > > @@ -26,12 +29,16 @@ properties:
> > > >    interrupts:
> > > >      maxItems: 1
> > > >
> > > > +  '#thermal-sensor-cells':
> > > > +    const: 1
> > > > +
> > > >  required:
> > > >    - compatible
> > > >    - reg
> > > >    - interrupts
> > > > +  - '#thermal-sensor-cells'
> > >
> > > Why does it need to be a required property now though?
> > > Adding new required properties is technically an ABI break.
> >
> > Hi Conor:
> >
> > I don't think it makes sense to have a separate thermal sensor
> > definition, it needs thermal-zones to describe specific behaviors,
> > e.g. cpu-thermal, so we need '#thermal-sensor-cells' to specify the
> > reference.
> > And the Loongson-2K1000 has 4 sets of control registers, we need to
> > specify the id when referencing it.
>
> Unfortunately, none of this is an answer to my question.

Hi Conor:

Sorry for my late reply.

Over the past few days, I've been communicating offline with Yinbo
(the driver author) about the use of the '#thermal-sensor-cells'
attribute. He retested the attribute and determined that it is
'required'.

We can see that the '#thermal-sensor-cells' attribute in the
dt-binding was dropped between the V12 patchset[1] and the V13
patchset[2]. Yinbo may have misunderstood Daniel's comment and removed
the '#thermal-sensor-cells' attribute from the dt-binding. But the
attribute was carelessly still left in the dts file, resulting in the
issue not being found during functional validation.

Indeed, re-adding the '#thermal-sensor-cells' attribute as "required"
is technically an ABI breakage, but the driver does not work properly
under the current dt-binding rules.
Also, the driver is only valid under LoongArch and will have no effect
on other architectures.

[1]=EF=BC=9Ahttps://lore.kernel.org/all/20221114024709.7975-2-zhuyinbo@loon=
gson.cn/
[2]=EF=BC=9Ahttps://lore.kernel.org/all/20230221095355.9799-2-zhuyinbo@loon=
gson.cn/

Thanks.
Binbin
