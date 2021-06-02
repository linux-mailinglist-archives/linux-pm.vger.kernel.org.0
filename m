Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E2F3985CA
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jun 2021 12:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhFBKCf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Jun 2021 06:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbhFBKCf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jun 2021 06:02:35 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86154C06174A
        for <linux-pm@vger.kernel.org>; Wed,  2 Jun 2021 03:00:52 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id f1so956695uaj.10
        for <linux-pm@vger.kernel.org>; Wed, 02 Jun 2021 03:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kYQ8JYBEy7lvKWQDIggyE7Q8g8ZfvSMvIgvFNwg3PWA=;
        b=E7Y13F9E1P6m6uPrdeFtPtTyYgp71GUHcDG9b9SG8pVTvWIHYbMnx/rfh4IhUwekXb
         kgTN/r9RzgHk0eTXxUfuovQCmUIyHmpwSR5akNx2dGwSuRMgIkLlQ9PRoG2X7j7Tr/87
         U/oT823NKr5UYBcq/D8JtV4dVXpXHAPfb1FWslbbRW5msN9zrWv8K7ELqb6ILqKpN2s4
         ViMW9C02GJ53Ojoc4SlzfIMuldlbTQ7gqqUmeEnyScTop1AJMBRpdAoY5QBn0OqjyQp5
         9sKPPbvXSrlKMxZvV/V/13nUFxAVVYBxNvLW3+gTus1I4ECirhL2p2o/2tM2DLSKhkMR
         Rbew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kYQ8JYBEy7lvKWQDIggyE7Q8g8ZfvSMvIgvFNwg3PWA=;
        b=X7KMRNV//pM8hqbw+fcMfL22Jf3Lw03PvPqJxKYCqqvm5yeG3hFnIXL7ensCm0NO9g
         ywSOzywn1SS2tidO6QWH0stss07ffR+CRXXcSSRUt5njOkg2jYMFB0zsPHkFjm6vM8SE
         I6PXeJrIQHkGYK4WvzE+HkKAR3bgwwMIwpScQTxZ1IcAmw73R7Dblit0uocCImoyttus
         1/sjarZUUv8owH5pYcYe96Zxlh3ZQSwXUeG+pLfg7vOwhkoIcW79VcxOxWx27pEyLZpg
         ccvl4iAGryOiBETR/rDGsnkN/ifW3S9A0b2s3mBmV7ae3qNTpcqF2hu4aH4eUJRf1Q1w
         fxbw==
X-Gm-Message-State: AOAM531K5z4atjUbS5lzVpsjZowS6qKCLN58L5WmN+Vgza6OYBNI0PTg
        RKy6NLNs0xAxsgvVrW8e4T+/g0rozwoDzk7FvuOK+F6aau/5rw==
X-Google-Smtp-Source: ABdhPJz+fWUP1yrioI1DOXyLCqHIl9Xjim3WV7PVlH8e8dZ1YoqCIkdxvp3qv5nY5bNL/sVkprcAt/yj67IgR33BiIA=
X-Received: by 2002:a9f:35b3:: with SMTP id t48mr20019416uad.129.1622628051636;
 Wed, 02 Jun 2021 03:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210601231003.9845-1-digetx@gmail.com> <YLdK6jp0Ybtzdstv@orome.fritz.box>
In-Reply-To: <YLdK6jp0Ybtzdstv@orome.fritz.box>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 2 Jun 2021 12:00:15 +0200
Message-ID: <CAPDyKFogXwT_C+hP8mW4EdoXnsiXCuF2m3cjURO6ijuUsV0sXQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] NVIDIA Tegra core power domain follow up
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2 Jun 2021 at 11:08, Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Wed, Jun 02, 2021 at 02:10:01AM +0300, Dmitry Osipenko wrote:
> > Remove the lockdep_set_class(), which Ulf Hansson asked for. And
> > prevent core domain syncing if domain node is missing in device-tree,
> > which I accidentally missed to add after squashing the standalone
> > domain driver into the PMC driver.
> >
> > Dmitry Osipenko (2):
> >   soc/tegra: pmc: Don't sync core domain if it's missing in device-tree
> >   soc/tegra: pmc: Remove usage of lockdep_set_class()
> >
> >  drivers/soc/tegra/pmc.c | 21 +++++++++++----------
> >  1 file changed, 11 insertions(+), 10 deletions(-)
>
> I've squashed these into the corresponding patches of you v6 series and
> added Ulf's reviewed-by to them.
>
> Ulf, let me know if I misinterpreted the discussion and your reviewed-by
> didn't extend to the original patches.

Nope, looks good to me! Thanks!

Kind regards
Uffe
