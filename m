Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21207398DF3
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jun 2021 17:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhFBPJ4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Jun 2021 11:09:56 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:40820 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbhFBPJz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jun 2021 11:09:55 -0400
Received: by mail-wr1-f47.google.com with SMTP id z17so2652445wrq.7
        for <linux-pm@vger.kernel.org>; Wed, 02 Jun 2021 08:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vs3Wh4eIvni5P/DPP9QB7KFgHPP2DPvUYXX2oG5ziD8=;
        b=Jv8riBA6hdAzuqqKPOkSJ02ahdlNA9yVktgdWbigMUOdm6bpxDApG6IxbmI1fsDrV0
         od+qctz8WdJpLMlg/dh65H26zKlKq18C9r5Id/gmGsm86frMckOC7EoWbt0ijn0eL0JF
         V2eoz1XbjOwarwofM8JZQSrsAfYcO3xSQaU0PbsEdI7qs5udvqBh0EPPIt9kv0811yzh
         Y1ACLtstrLSq5QF+c1a7+IJpO2MbffII4oH2s6027S/4EDlqAHuOV2aC7HPIfRM+H8i3
         rqVEckU/2Srs13LwwfmSQVfXeu/H9S/Z6a100JTKutK+gu0RXflckQNcpZ0l/fPiK0Hv
         oNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vs3Wh4eIvni5P/DPP9QB7KFgHPP2DPvUYXX2oG5ziD8=;
        b=KLhCVHKqof33chtqwck6s9eE6q+L9O280TBJkhCBd7gdTNkOjpUQMnN8AS87PLx+nE
         Qq63fzfyYiVuF/dFIFMCyA8dQ2Izsws6QsAk10np0tXLbpaQtEwoxZR+BDTHqpUc62jE
         RVv/FL4APCOFySDnPhUxZchFGc9Eva5e1Abo0c07EWs05P3qQeXtRw/MrYLFoSkxmRVZ
         41Ic+BPA175X+7a6ZktFWiaqQZf2JUqibjGHC4wLR/IN24dsHEuskqVJoHW6aVGV42H2
         amXnWh3iuZSvRxxJ3ynP1JGOQxp8Sel90EK+MRZBNUHlrC0pOahnymRCaTgEnVp5l4rI
         q8BA==
X-Gm-Message-State: AOAM531Q8PTxRnwCdc1eXmTffboKo9MpoZNazqRipKi0AOwj7fu0lTQn
        96b8ZayqskRc72hPyH2E2g4nk36t8GzsgYbJuUTRPg==
X-Google-Smtp-Source: ABdhPJwg13/gEhL01WTUQpFs1K3FGrC8NR1Evds3qUYUCeEJOMNXDkC3cHVMY2cPzMBS6YuglZja7OitSEjs3ENc/Bs=
X-Received: by 2002:a5d:58f6:: with SMTP id f22mr21961347wrd.128.1622646431784;
 Wed, 02 Jun 2021 08:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210602112321.2241566-1-anup.patel@wdc.com> <20210602112321.2241566-6-anup.patel@wdc.com>
 <CAPDyKFq2tvvAD=2RiePZzce=+OsDaxLWqz+90pTKjTTzqVqcHQ@mail.gmail.com>
In-Reply-To: <CAPDyKFq2tvvAD=2RiePZzce=+OsDaxLWqz+90pTKjTTzqVqcHQ@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 2 Jun 2021 20:36:59 +0530
Message-ID: <CAAhSdy0jN1urNFu_mqqg2jbqzsfztQUJN62oB9dhDTH=RgLR-g@mail.gmail.com>
Subject: Re: [PATCH v5 5/8] cpuidle: Factor-out power domain related code from
 PSCI domain driver
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
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
        DTML <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 2, 2021 at 6:47 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 2 Jun 2021 at 13:24, Anup Patel <anup.patel@wdc.com> wrote:
> >
> > The generic power domain related code in PSCI domain driver is largely
> > independent of PSCI and can be shared with RISC-V SBI domain driver
> > hence we factor-out this code into dt_idle_genpd.c and dt_idle_genpd.h.
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> A small nitpick below.
>
> [...]
>
> > +EXPORT_SYMBOL_GPL(dt_idle_pd_free);
>
> Do we really need to export this symbol? Looks like there are only
> built-in cpuidle drivers that are going to use it. At least for now.
>
> As a matter of fact, the same comment applies to all cases of
> EXPORT_SYMBOL_GPL from $subject patch. Can we drop all of them?

I had kept the EXPORT_SYMBOL_GPL() to be in-sync with the
dt_idle_states.c but in this case I agree we don't need to export.

I will drop all EXPORT_SYMBOL_GPL() in the next patch revision.

Regards,
Anup

>
> [...]
>
> Kind regards
> Uffe
