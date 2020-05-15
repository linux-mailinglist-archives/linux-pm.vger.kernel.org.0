Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFC81D4D3E
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 14:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgEOMAz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 May 2020 08:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgEOMAz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 May 2020 08:00:55 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3418C061A0C;
        Fri, 15 May 2020 05:00:54 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id k6so2412304iob.3;
        Fri, 15 May 2020 05:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yYxgWvcJ8rrN6qfxnW2mlSqNc8IfTvO2QBvIRiKBE98=;
        b=TAUf1qdOEbF3duuSQazplZs2NAADUhUcfKqnmJtxmwGU5MMw/dwlM0IMlAWQAIJX7v
         GhWNPojZ4W9K7i9UspaaAwU2zTfCzr6x65rEcNexdVXEndz112MbSqZQPZ6RxPo5zllj
         v8pceFBybKceRLQySE910AEo65Jfey0I9F1k8Wj/Y9cwBcWCBqaXGJSeaRcaeH55KdLk
         HUZ3dPy852dM8kicfMhdnyT0WeYAWFooNd8HWLeSajeoUQ4/phgbb+Pf4P8ryWv9EeoH
         jNNB7iTlSFQZuek9+t27y0ULbTZPKdVP5Wgb+54pgKHdBdcCE5209jATfKo6zqar0uYU
         dhog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yYxgWvcJ8rrN6qfxnW2mlSqNc8IfTvO2QBvIRiKBE98=;
        b=NelTxw4FqtNPWz/6JjYPFt+4Uer+lA65SQJJ4A/4lPbyY6c2URPCpuDU5ncCAFj5rk
         9P7wOptWCRZQoBpxTf5HcRwcsUZwPFJJWEGRvdlxHIY7n6E+BO2SVW8AgE2tZRI9FUqK
         sLorXcnJiJ/s1N4gRJbRjHMuL6ZtyFIRGWC075i7ipdIcAykYHUEiW1391tRcoibNHYc
         GY8e040HxEfz2Pn79YbbiKC0TQrTDtyU89yvtm+cMFtRQTrpJ4RShyh9liKppXStVdwU
         4+LrvfsWcom0RIMbgkHeyojLhvJ8cmtfeRWA+uGAs40tjBgMsJauJYX75tD2fgeYaEUU
         Q9dQ==
X-Gm-Message-State: AOAM530ITKdMapP1GHUo76tVKxQJIED1h/KWtsX52GStRbXiRJq7xzlo
        35DxhENIE8AG3iykBokilP+wJjyN+wuEmr7ah42cptNA
X-Google-Smtp-Source: ABdhPJyscAOeMTHnpUYFEpvWOFvtaX4XmX+fEDzqMgO4hSAwAvVPP/zBFr4agXyags8j+2o8bmw9E1q7F2JcXarQ17Y=
X-Received: by 2002:a02:3b4b:: with SMTP id i11mr2962189jaf.16.1589544053459;
 Fri, 15 May 2020 05:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1589528491.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1589528491.git.viresh.kumar@linaro.org>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Fri, 15 May 2020 14:00:42 +0200
Message-ID: <CAJiuCceftArjKPyiEW8AnT5TtuCJFsRGGA-_8y2zG5GDTxHO4Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] opp: core: add regulators enable and disable
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     k.konieczny@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        "open list:ALLWINNER CPUFREQ DRIVER" <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On Fri, 15 May 2020 at 09:57, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi,
>
> This series reintroduces the usage of regulator_enable/disable() to the
> OPP core after the previous attempt was reverted [1] shortly after gettin=
g
> applied. This time the regulator is enabled only after it is configured
> by the OPP core.
>
> Marek, Kamil and Cl=C3=A9ment: Can you guys please test this out and repo=
rt
> if this doesn't work as expected ?

I have reviewed the patch and it seems fine for my use case.
Unfortunately I can't test it until next week.

Acked-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>

Regards,
Clement


>
> --
> viresh
>
> [1] https://lore.kernel.org/lkml/20191017102758.8104-1-m.szyprowski@samsu=
ng.com/
>
> Kamil Konieczny (1):
>   opp: core: add regulators enable and disable
>
> Viresh Kumar (1):
>   opp: Reorder the code for !target_freq case
>
>  drivers/opp/core.c | 39 ++++++++++++++++++++++++++++++++++-----
>  drivers/opp/opp.h  |  2 ++
>  2 files changed, 36 insertions(+), 5 deletions(-)
>
> --
> 2.25.0.rc1.19.g042ed3e048af
>
