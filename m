Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9D44B3505
	for <lists+linux-pm@lfdr.de>; Sat, 12 Feb 2022 13:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbiBLMuD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 12 Feb 2022 07:50:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234917AbiBLMuC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 12 Feb 2022 07:50:02 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF98626137
        for <linux-pm@vger.kernel.org>; Sat, 12 Feb 2022 04:49:58 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id f41so14379548lfv.12
        for <linux-pm@vger.kernel.org>; Sat, 12 Feb 2022 04:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=idWS+dy/9zcAHhOmUKByw810+cre1HyYia7KtD9MJdE=;
        b=J7ZSlDBaOxGSKMrZf0Pc7V6AlASUvZJmt3m2fxlRMAaWwjlrr1h2gdgmKl4Rnx2dSm
         IfmWMj9Dc858vbexwMx0tLWVbdzgodTOTiYxhpCOpvTsTaO8XL1MpX8pToBRfgox5nB7
         6aqOSyrSo4nycHtj99MRQ1Uxnd2BXMW3SVTStB35tLc5KQa2DnL3DxqE29h26CFk1bQO
         Jn8MOivWUIokAnvury7OjQMa+1RaxZk3uSX1NpJ3+ib031eOMJVAFDhXh1Ifssb6azz/
         X0Z2Nucf3B2ww7UsNN2kc2wp8nG2AXJ8paGqnnBPuAOUrpi2avcR+xBe651OFQlzOI2w
         cgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=idWS+dy/9zcAHhOmUKByw810+cre1HyYia7KtD9MJdE=;
        b=TkxVRxszRMjpQpEnG6/VmJwOgiJ9rOxk3bQWJxJrzrM6YDjD/yEiJ/wwAnLqC4lcS5
         5Ep0LFoA9kkdmCD+esnY7QrmQ1JOvz21DAT0uAaYs8oeAPJTfGJNbeppBnujyc5KK2Jx
         /N8pyBIgC6jvvPfZpdPMXTwb+/mwyUHGDthDJ/RNVqVyStR4U+Oq+3fgrXZJFM+oQmKI
         bb6QyMHBqDrF75h/oo/EXiZ61oOGfFoc4Ub+xVsxqDxD/vpshvuHyJRIgsYlttOfc2p3
         GyfcaOsALRC5MQbkYlDewDB9oyN5fS/wsb8dYb/c8wEWTOvRaheFo1xQ5KucJ3mHVZnC
         /uUA==
X-Gm-Message-State: AOAM5307wYlaJFpX3ZycaGUielLaeion03irvSaxz/yvSFbU2kJ2B8G5
        jy7QgoCpPC6DldTfNdamSvPbJEjPPGd/6y66iyTPMQ==
X-Google-Smtp-Source: ABdhPJzeHH07yDCVZVPUyyeoJRx73u7xqaZhnqbnL0ultgwjz50bXvR8YJh2OO11LoYsIZl66imqJHcVEOKUk0SGq3M=
X-Received: by 2002:a05:6512:33c8:: with SMTP id d8mr4325765lfg.41.1644670197034;
 Sat, 12 Feb 2022 04:49:57 -0800 (PST)
MIME-Version: 1.0
References: <20220210054947.170134-1-apatel@ventanamicro.com>
 <20220210054947.170134-2-apatel@ventanamicro.com> <20220212114355.GF20866@duo.ucw.cz>
In-Reply-To: <20220212114355.GF20866@duo.ucw.cz>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Sat, 12 Feb 2022 18:19:46 +0530
Message-ID: <CAK9=C2VzzT=GDyuptuxQj0y++Rb0SaZXCuoL1+ncpGWcYHqr1g@mail.gmail.com>
Subject: Re: [PATCH v11 1/8] RISC-V: Enable CPU_IDLE drivers
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Sandeep Tripathy <milun.tripathy@gmail.com>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Liush <liush@allwinnertech.com>,
        Anup Patel <anup@brainfault.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kvm-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Feb 12, 2022 at 5:13 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > From: Anup Patel <anup.patel@wdc.com>
> >
> > We force select CPU_PM and provide asm/cpuidle.h so that we can
> > use CPU IDLE drivers for Linux RISC-V kernel.
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > Signed-off-by: Anup Patel <apatel@vetanamicro.com>
>
> This is quite... interesting. Normally we have one signoff per
> person...

I was working for Western Digital (WDC) when I first submitted this
series and recently I joined Ventana Micro Systems.

Regards,
Anup

>
> Best regards,
>                                                         Pavel
> --
> http://www.livejournal.com/~pavelmachek
