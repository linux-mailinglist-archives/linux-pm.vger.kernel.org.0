Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E2E7AC7F3
	for <lists+linux-pm@lfdr.de>; Sun, 24 Sep 2023 14:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjIXMVW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 24 Sep 2023 08:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIXMVU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 24 Sep 2023 08:21:20 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4EF101;
        Sun, 24 Sep 2023 05:21:14 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d8181087dc9so5185133276.3;
        Sun, 24 Sep 2023 05:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695558073; x=1696162873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MTfZjqjMpvXRZj3b3a+JLvwqBqzdhBKsQPxsSKfm4jQ=;
        b=JmnRMdRUYmERcLwPlPVvJCbnxV/XbvmE+AMvSZTGztlVi2xyVEI4UKW7A6A9RLAYpU
         VHz4T8KFsIBDqUy0uSZ9nXZBZLJSyFyt7DvjgQuk5s4wnSFND1b38I4P4gEh+G+DQMtK
         bBcztbYiJZL4AES7RCXNRwCl4BzVS0a5YAWO566JJsINiLGTeJbUwiFWN0Kg6FhkdEG5
         ncjJLsx2cvxj54ueD0jEqcv1yGsdApj5W9+bkVhNwlUkYBrMLapxZl0VhL2fsWVOLkQg
         DilRj3XATDG8xPIfA/lFlBYhKdGwMjamLkR5rW1vR4SFNbAOFoj7JT/dvqKwOzzxA1QY
         WLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695558073; x=1696162873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MTfZjqjMpvXRZj3b3a+JLvwqBqzdhBKsQPxsSKfm4jQ=;
        b=B8CRQvCrAbD/VNKMpx/zQJ7Q0f0QyBeXxyWV/Xfs3aSd8a1or+I9IXJI3wnNg6smnt
         2o5E9NkMetE8Gr7g1uyt/LStQaxjTlKENrdOZEw694gzahMaI9mSCrVaVM4hkO4QHdAx
         gXNXTr/Y0vtVrcrtZmtH9rh4x69hyHIjy3Rhti0pksxFbut0Msn26Avcdy5BGn+OqqZ4
         3SfAbfNOha90wH+Y2Uemy0La+xByTpE89lcopte7VpY+7ZctxDiDzTBtacYq64RMnAcg
         Ez8xZwGqKzx8GswPWJAufQ/wJyWc73Nlpv2JULpEv+dUe1uKrwjuK51pNdiBUOkO4mVU
         yIFg==
X-Gm-Message-State: AOJu0YxRpsdfiSombxCZIEKH2JQrKGnPguOXOH49fMtj4oA25N5fzF//
        lPVQqfmAlfro//a+wTDS6q0LqpLrgSW0hVVFXG0=
X-Google-Smtp-Source: AGHT+IF2jNaWBk87Cb4LztG+3BYADZk5wQU4zwUp4/XjFmSp0zIWGQD+y5IecCnZhP1NNVheMxVGBydqfLx6BDN44Oo=
X-Received: by 2002:a25:a048:0:b0:d43:a84f:a6aa with SMTP id
 x66-20020a25a048000000b00d43a84fa6aamr3813704ybh.39.1695558073705; Sun, 24
 Sep 2023 05:21:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693623752.git.zhoubinbin@loongson.cn> <16a37f6ad3cc9417b6638c2cd532d88c79468eb1.1693623752.git.zhoubinbin@loongson.cn>
 <885eab85-2c11-cf20-9187-55cd647fbe9f@infradead.org> <c7604f6c-4da7-47c4-abe9-e626b3efc665@infradead.org>
 <20230919-9ce82588fccdd641574b468c@fedora> <CAAhV-H73kp8zWJD7AKUvknmxow=f_cPBw9jctpmced6o_QCF6w@mail.gmail.com>
 <ea9ee2dd-b71a-4c97-a347-20536d7ad424@app.fastmail.com>
In-Reply-To: <ea9ee2dd-b71a-4c97-a347-20536d7ad424@app.fastmail.com>
From:   Binbin Zhou <zhoubb.aaron@gmail.com>
Date:   Sun, 24 Sep 2023 20:21:02 +0800
Message-ID: <CAMpQs4Lp1y1=hp_Z7zRV7W0WCB047yDD5eqnuLHjdqHYZpchRQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] soc: loongson: loongson2_pm: Add dependency for INPUT
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        loongson-kernel@lists.loongnix.cn, soc@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev
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

On Fri, Sep 22, 2023 at 10:43=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrot=
e:
>
> On Tue, Sep 19, 2023, at 12:15, Huacai Chen wrote:
> > On Tue, Sep 19, 2023 at 11:48=E2=80=AFPM Conor Dooley <conor@kernel.org=
> wrote:
> >> On Tue, Sep 19, 2023 at 08:36:50AM -0700, Randy Dunlap wrote:
> >>
> >> Seemingly this was sent again in isolation 2 weeks ago, but neither th=
e
> >> maintainer (Huacai) nor soc@kernel.org were on cc:
> >>
> >> https://lore.kernel.org/all/20230905123629.4510-1-zhuyinbo@loongson.cn=
/
> > v3 indeed cc-ed soc@kernel.org. :)
> >
> > Arnd, could you please take this series to the soc tree? And also this
> > series:
> > https://lore.kernel.org/loongarch/cover.1693534134.git.zhoubinbin@loong=
son.cn/T/#t
>
> Sorry, I have been traveling and not pushed out the tree yet.
>
> Can you confirm that the input dependency is required for 6.6
> and the other series can wait until 6.7? When you send patches
> to soc@kernel.org, please always mention which tree you intend
> them for. I might disagree, but it's better than having to guess.
>
Hi Arnd:

Thanks for your reply.

As we know, this driver was just merged in during the v6.6 window, and
no release will use it until now:

commit 67694c076bd7 soc: loongson2_pm: add power management support
commit 6054a676e969 soc: dt-bindings: add loongson-2 pm

Now, since the Loongson-2K series SoCs are indifferent at the driver
level, we used fallback compatible and added
syscon-reboot/syscon-poweroff subnodes for power on/off functionality.
These somewhat break the original devicetree rules.
So, I think these patches need to be merged in before the v6.6 release
to avoid unnecessary compatibility issues.
Of course, I added the "Fixes:" tag in the corresponding patch.

Thanks.
Binbin

>      Arnd
