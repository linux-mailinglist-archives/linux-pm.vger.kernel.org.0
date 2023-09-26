Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456017AEAD5
	for <lists+linux-pm@lfdr.de>; Tue, 26 Sep 2023 12:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbjIZKzX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 26 Sep 2023 06:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbjIZKzW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Sep 2023 06:55:22 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC9295
        for <linux-pm@vger.kernel.org>; Tue, 26 Sep 2023 03:55:15 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-59c0b9ad491so101576147b3.1
        for <linux-pm@vger.kernel.org>; Tue, 26 Sep 2023 03:55:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695725714; x=1696330514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OvtTsf3vpAC3463ssznlJAFWAnBfRPI8L0YmeYOh6ic=;
        b=VMS5YXKkoO+brGkHH3H5ZDpmr67o7oewEVfZlw98428XWXRDI7/x8cXeR4MDUeJqHJ
         PtwAFeRrDS2ydrKx0+YOVvP9fEZWnaxOc6fERugGzYYqlJOhBqq1H9ZazAJHqq1LoZ+i
         3bh+kIWcso5gOos6denUfr/DxDC9TRx00vNGAyBTiy0pJkAQ2rhHvpLDFqDqP3bDDuGQ
         RTsRx8sDLmf6Ro8GPCz0eijImeZIh0VLo+ayIWLxAz3yH1ZQGqa2dWqONBAwN8UWZ7Z+
         McwVdtyMsl4nkpfkmEmixaaszX8uC0vjX2OLyw4RZGgcC3//NFDFcBhq2BpIahXwYU32
         7hRA==
X-Gm-Message-State: AOJu0YwdBo0AgA1YVFyCabkUClCgyej8K55MU7lCD2VbGyGx/qZSsZIv
        EUsWP361wt84OEpldM25yYTfk0sTO8qgGA==
X-Google-Smtp-Source: AGHT+IHMgxtPsmigztx0Hdn0UhqYx3a9U8YIcQgMPXz7FPzQdug8ixPgxd9+UW92M7ghiGfM/V439Q==
X-Received: by 2002:a81:5c54:0:b0:583:d9dd:37fd with SMTP id q81-20020a815c54000000b00583d9dd37fdmr8683026ywb.31.1695725714578;
        Tue, 26 Sep 2023 03:55:14 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id i6-20020a0dc606000000b0058427045833sm2923403ywd.133.2023.09.26.03.55.14
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 03:55:14 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-d849df4f1ffso9791027276.0
        for <linux-pm@vger.kernel.org>; Tue, 26 Sep 2023 03:55:14 -0700 (PDT)
X-Received: by 2002:a25:fc0e:0:b0:d4c:cbd2:f6f3 with SMTP id
 v14-20020a25fc0e000000b00d4ccbd2f6f3mr9064526ybd.53.1695725713917; Tue, 26
 Sep 2023 03:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230913-bloomers-scorebook-fb45e0a2aa19@spud> <20230913-grumbly-rewrite-34c85539f2ed@spud>
In-Reply-To: <20230913-grumbly-rewrite-34c85539f2ed@spud>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 26 Sep 2023 12:55:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXmNCXvFj8gF0COQrvhbRuugrJN0sM_DL1vDE=4EU0bEA@mail.gmail.com>
Message-ID: <CAMuHMdXmNCXvFj8gF0COQrvhbRuugrJN0sM_DL1vDE=4EU0bEA@mail.gmail.com>
Subject: Re: [GIT PULL 2/5] dt-bindings: power: Add power-domain header for JH7110
To:     Conor Dooley <conor@kernel.org>, changhuang.liang@starfivetech.com
Cc:     ulf.hansson@linaro.org, Conor Dooley <conor.dooley@microchip.com>,
        arnd@arndb.de, jiajie.ho@starfivetech.com,
        linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org,
        robh@kernel.org, walker.chen@starfivetech.com
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

Hi Conor, Changhuang,

On Wed, Sep 13, 2023 at 3:58 PM Conor Dooley <conor@kernel.org> wrote:
> From: Changhuang Liang <changhuang.liang@starfivetech.com>
>
> Add power-domain header for JH7110 SoC, it can use to operate dphy
> power.
>
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Thanks for your patch, which is now commit 41b66b54a72bd796
("dt-bindings: power: Add power-domain header for JH7110")
in pmdomain/next.

Conor: looks like you forgot to update the patch description, as promised in
https://lore.kernel.org/all/20230519-irk-dwelled-6a499c482e62@spud?

> --- a/include/dt-bindings/power/starfive,jh7110-pmu.h
> +++ b/include/dt-bindings/power/starfive,jh7110-pmu.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>  /*
> - * Copyright (C) 2022 StarFive Technology Co., Ltd.
> + * Copyright (C) 2022-2023 StarFive Technology Co., Ltd.
>   * Author: Walker Chen <walker.chen@starfivetech.com>
>   */
>  #ifndef __DT_BINDINGS_POWER_JH7110_POWER_H__
> @@ -14,4 +14,7 @@
>  #define JH7110_PD_ISP          5
>  #define JH7110_PD_VENC         6
>
> +#define JH7110_PD_DPHY_TX      0
> +#define JH7110_PD_DPHY_RX      1

These values are conflicting with similarly-named values above:

    #define JH7110_PD_SYSTOP        0
    #define JH7110_PD_CPU           1

Upon closer look, and diving into the driver, this header file contains
definitions for two separate number spaces: the first set is meant
to be used in PM Domain specifiers referring to a node compatible
with "starfive,jh7110-pmu", while the second set is meant to be
used in PM Domain specifiers referring to a node compatible with
"starfive,jh7110-aon-syscon".
I think it would be nice to have this reflected in the names of
the defines (e.g. JH7110_PD_AON_DPHY_TX), and/or to add comments
clearly delimiting the two separate number spaces, and explaining
where they apply to.

> +
>  #endif

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
