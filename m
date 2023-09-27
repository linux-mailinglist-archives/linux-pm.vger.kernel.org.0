Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952547AFBB8
	for <lists+linux-pm@lfdr.de>; Wed, 27 Sep 2023 09:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjI0HNG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 27 Sep 2023 03:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI0HNE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2023 03:13:04 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0DD10E
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 00:13:02 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-59f4bc88f9fso98526807b3.2
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 00:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695798782; x=1696403582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S+bbVFytZ41e9lUv+Wxsk6ddySSnKMOncFN3cH7+dQI=;
        b=G9SzKCDVl5xVJTrk1cY6R7c1XBt/jHqIJleQuB5ri8NSVQFSIiXrZip7hsuli6B8GH
         ilPapH4C7+RZ9GzuKlUI4R0+BFe1CEEDC0QHxjJ9B3uDQycuK6yP8m8SeOFVVrMTgDRl
         qxUyz0WsoKVSm0D4+QYKv0b7FefQ/8akGFBoixnpky9D74+PNt3jr72XgvyHzQD3QWrn
         ZQQa0LdccGpypkOVbSNh641aCFpW2Pc326u6Or+T+24tHpp6WJXPSOFKwjmfs+OBTGXJ
         z7XCV1/J1j+FrECXjpklDL4swmhyt81H6UOPFRbtcS6l6YH2qNlobZd3c/PjFFNT2+Wf
         TU+w==
X-Gm-Message-State: AOJu0YyQPrZAKY7wUrsRGnRPCnvcrCL9WeJXBsXVdwxQ1/yUeIbLMFjS
        fr6OdI4P72+RmPF9lnySMMUi/yx7GGCsHw==
X-Google-Smtp-Source: AGHT+IFRqHyiEy0Ufva7Ww7LZ+yAwPwRRMjwIASPZSzFaWeEUo9IKiAyX8fQYy0OQclaA8DR6s+TOg==
X-Received: by 2002:a81:7786:0:b0:579:f5c2:b16e with SMTP id s128-20020a817786000000b00579f5c2b16emr1465750ywc.31.1695798781861;
        Wed, 27 Sep 2023 00:13:01 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id z5-20020a81a245000000b00583e52232f1sm3521101ywg.112.2023.09.27.00.13.00
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 00:13:00 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-59f4bc88f9fso98526097b3.2
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 00:13:00 -0700 (PDT)
X-Received: by 2002:a0d:d90b:0:b0:59f:69e6:18c5 with SMTP id
 b11-20020a0dd90b000000b0059f69e618c5mr1515077ywe.11.1695798779861; Wed, 27
 Sep 2023 00:12:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230913-bloomers-scorebook-fb45e0a2aa19@spud>
 <20230913-grumbly-rewrite-34c85539f2ed@spud> <CAMuHMdXmNCXvFj8gF0COQrvhbRuugrJN0sM_DL1vDE=4EU0bEA@mail.gmail.com>
 <ada7a449-cc23-84e2-0d7f-5b90c4f07ded@starfivetech.com>
In-Reply-To: <ada7a449-cc23-84e2-0d7f-5b90c4f07ded@starfivetech.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 27 Sep 2023 09:12:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVi+bCV2_mb=j0rxtpwjp-dZjfmaBC0gyStzoZbAsvQCg@mail.gmail.com>
Message-ID: <CAMuHMdVi+bCV2_mb=j0rxtpwjp-dZjfmaBC0gyStzoZbAsvQCg@mail.gmail.com>
Subject: Re: [GIT PULL 2/5] dt-bindings: power: Add power-domain header for JH7110
To:     Changhuang Liang <changhuang.liang@starfivetech.com>
Cc:     Conor Dooley <conor@kernel.org>, ulf.hansson@linaro.org,
        Conor Dooley <conor.dooley@microchip.com>, arnd@arndb.de,
        jiajie.ho@starfivetech.com, linux-pm@vger.kernel.org,
        linux-riscv@lists.infradead.org, robh@kernel.org,
        walker.chen@starfivetech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Changhuang,

On Wed, Sep 27, 2023 at 3:25 AM Changhuang Liang
<changhuang.liang@starfivetech.com> wrote:
> On 2023/9/26 18:55, Geert Uytterhoeven wrote:
> > On Wed, Sep 13, 2023 at 3:58 PM Conor Dooley <conor@kernel.org> wrote:
> >> From: Changhuang Liang <changhuang.liang@starfivetech.com>
> >>
> >> Add power-domain header for JH7110 SoC, it can use to operate dphy
> >> power.
> >>
> >> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> >> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> >
> > Thanks for your patch, which is now commit 41b66b54a72bd796
> > ("dt-bindings: power: Add power-domain header for JH7110")
> > in pmdomain/next.
>
> Where is the website link for the pmdomain/next?

As per https://elixir.bootlin.com/linux/v6.6-rc3/source/MAINTAINERS#L8729
it can be found at
https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git/log/?h=next

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
