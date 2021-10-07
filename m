Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D4D425981
	for <lists+linux-pm@lfdr.de>; Thu,  7 Oct 2021 19:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242565AbhJGRc4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Oct 2021 13:32:56 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:37501 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbhJGRc4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Oct 2021 13:32:56 -0400
Received: by mail-oi1-f171.google.com with SMTP id o83so2554411oif.4;
        Thu, 07 Oct 2021 10:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uoOCJc/OhL1VGTaVAt2b5BnE1dyTODrBWIacv8WKckE=;
        b=HLHpyzZ6tNkgpBEEZfVGewQxDzyXuEY8TVTPWVadbRfeMio7BRFXxtXdjNymvLv7Di
         D9GU3VditXTS0Pr4RJSW3W9HEd99NBrgCOt6hBCyT3j64CodtmyyNABvkpUC2B32iXt9
         DGa9PcMEB+D8Ewps8gK1x4gIgScj5jVWQPJZX31rp6fytS/nasX3K/jgPnMwLPDq/4II
         j5eg/C+nmSffW+4qk0Y4GM+TPy1P3jUhg4EgKFVT/+mk80WLRTRWcJ0SD8aIj2aUJezC
         IMltJEV/oFp7C2Xo19MtZ13uKXeu+nzIRsqNpeO1gnkKzPtuZtsPrKXhkHZpDEncWrkS
         eYsQ==
X-Gm-Message-State: AOAM530oYSZg8bOJWI+73RInAAGMo0Yxz+miohTxl8Vk7ntGoARBhqys
        rWtqKxTKNc2CJ3R2V2fXodmmZpV5HZ6Q0arWC+JsN8hM
X-Google-Smtp-Source: ABdhPJxmEJ1idd3/RB9cDqXJQoZPrBgqsPf63OwxW2T8mQSGPWgWmUQN/OaSKAS6S6GTQWoHfDDkrH6thKA1FO/RrXc=
X-Received: by 2002:a05:6808:1520:: with SMTP id u32mr4144304oiw.154.1633627860250;
 Thu, 07 Oct 2021 10:31:00 -0700 (PDT)
MIME-Version: 1.0
References: <864dd17a1bff58770b1c1dc0b430bd26b6d7fa01.1633595141.git.mchehab+huawei@kernel.org>
 <CAJZ5v0hj1jZtZ-cD_4jy94cjMbyix-=QcN2Qn9pkW7H1kn16LQ@mail.gmail.com> <581a7222-0a01-6292-5b14-ca0e4690bc67@linaro.org>
In-Reply-To: <581a7222-0a01-6292-5b14-ca0e4690bc67@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 7 Oct 2021 19:30:49 +0200
Message-ID: <CAJZ5v0g1bFdZsyTQYtUbFMRs_GDqRWCg=RnMnLx4kN1JWEW6Cw@mail.gmail.com>
Subject: Re: [PATCH v2] thermal: Move ABI documentation do Documentation/ABI
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 7, 2021 at 6:42 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 07/10/2021 18:39, Rafael J. Wysocki wrote:
> > On Thu, Oct 7, 2021 at 10:25 AM Mauro Carvalho Chehab
> > <mchehab+huawei@kernel.org> wrote:
> >>
> >> The thermal ABI is described, together with the internal
> >> development details at:
> >>
> >>         Documentation/driver-api/thermal/sysfs-api.rst
> >>
> >> Move the sysfs API description to Documentation/ABI,
> >> ensuring that scripts/get_abi.pl will properly parse it.
> >>
> >> While here, also update MAINTAINERS for it to point to
> >> the documentation.
> >>
> >> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> >
> > There is a typo in the subject, but I can fix it up.
> >
> > Daniel, would you mind if I applied this?
>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Applied as 5.16 material, thanks!
