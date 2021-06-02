Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6597C398A4A
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jun 2021 15:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhFBNUg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Jun 2021 09:20:36 -0400
Received: from mail-ua1-f42.google.com ([209.85.222.42]:44865 "EHLO
        mail-ua1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbhFBNUf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jun 2021 09:20:35 -0400
Received: by mail-ua1-f42.google.com with SMTP id 68so1247990uao.11
        for <linux-pm@vger.kernel.org>; Wed, 02 Jun 2021 06:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uH5yxU+BzRF90wWQwBO4VM5milL3akGJBti5j4uOIZE=;
        b=s6OLJzCVfowSoFK+Kn+Dhlq9dbdZvw299TRcMkIdw5Yuw3QzvKXt83rm00ZYmdAzHh
         /1dzY+TZZYI7BxQvrF0FDyUZF9EMiKzASt4L13dLl6SCkUavqGGqBrk3O90KyRB0h+lE
         5vqtpcRDiNuA4hyi2GEWpaPREnpTT8jFXAL3Ypr8EXcRsTLjM2LEkV+hLkRG4wNmfK+c
         hawPsG2yo23cDzABvRJQmn8X+GmEu9mJER+1cYC3lQAxQ/foh9xbWloSO7ggqM4k6Djv
         ehNToKgNW35e/8OEm0Hun2TjV2n0awAldfNx1NCqo7S6PU2Wlxzae8ooaKznyMLri193
         rSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uH5yxU+BzRF90wWQwBO4VM5milL3akGJBti5j4uOIZE=;
        b=ajSAw43O5Yjbhyh1qWG4Yfy/efV4Ozr12oAVo+XcHQB2Obt5dZl99bitDSRwsJTGqZ
         TH66bpdNxtKoeToKFZHESlr2QH7cEkyHMcCrbAoBTypRth82jZ7LBwMuDxLZIaB4VGJh
         94rw+jsXV2UbFaVXy+2iwuBC0Unm55Bbt5ZbkiJcGXACxp+SgtGUs7//mT8TpeT52il0
         3Sou3bcBbpW65+5KMd6kcj15q7n20bSQ9kMAu96TLGWk0/orQN4QAz9LxG1WfZhh2NyS
         pCB8crJJWr2oLJDlCPp9qsrgsw1/RJjW8/GofXSr6wpxFDkSf3wI9pkP4JhuEWW4bY9p
         P+Xg==
X-Gm-Message-State: AOAM533OqNTr0i4jIHNG1dzv3YujHt4Idl0KTF5KRppe7gcMzAOu6/sF
        6uzoHubcdCAV7gy2GsgAaWHr3jqznJgxYEaG1E/WDA==
X-Google-Smtp-Source: ABdhPJyvipLZfILhu87oS/az2/HBFVuElK4GQ6Srx/B1cgHvOyXaym3QLEigUlS/OUkA08r+m8+miEhdsQUfZ9i5/94=
X-Received: by 2002:ab0:100f:: with SMTP id f15mr21456136uab.100.1622639870335;
 Wed, 02 Jun 2021 06:17:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210602112321.2241566-1-anup.patel@wdc.com> <20210602112321.2241566-6-anup.patel@wdc.com>
In-Reply-To: <20210602112321.2241566-6-anup.patel@wdc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 2 Jun 2021 15:17:13 +0200
Message-ID: <CAPDyKFq2tvvAD=2RiePZzce=+OsDaxLWqz+90pTKjTTzqVqcHQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/8] cpuidle: Factor-out power domain related code from
 PSCI domain driver
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Sandeep Tripathy <milun.tripathy@gmail.com>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Liush <liush@allwinnertech.com>,
        Anup Patel <anup@brainfault.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2 Jun 2021 at 13:24, Anup Patel <anup.patel@wdc.com> wrote:
>
> The generic power domain related code in PSCI domain driver is largely
> independent of PSCI and can be shared with RISC-V SBI domain driver
> hence we factor-out this code into dt_idle_genpd.c and dt_idle_genpd.h.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

A small nitpick below.

[...]

> +EXPORT_SYMBOL_GPL(dt_idle_pd_free);

Do we really need to export this symbol? Looks like there are only
built-in cpuidle drivers that are going to use it. At least for now.

As a matter of fact, the same comment applies to all cases of
EXPORT_SYMBOL_GPL from $subject patch. Can we drop all of them?

[...]

Kind regards
Uffe
