Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78BB51E1D8D
	for <lists+linux-pm@lfdr.de>; Tue, 26 May 2020 10:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730117AbgEZImz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 May 2020 04:42:55 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44897 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728837AbgEZImy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 May 2020 04:42:54 -0400
Received: by mail-oi1-f196.google.com with SMTP id y85so17930008oie.11;
        Tue, 26 May 2020 01:42:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mf9n/c3+Sw87fKL1kv03rUZHg5yRnCXilSstFGEhIYc=;
        b=SPlfGIbSp6wv+J3uR7V5tXUzlYNxplrVidYCnEP1AcUfrIkX78X5uubJu35ksyui1X
         AgtZ9FHxvLYO8hfeTaErCWZGUMl6h/hZucUcicyFr6znz2/y3XnDPl6fXwN2MN+b8Cm7
         kqNX7+RKgUeeA6csr4IR2v0uayGdsR+iqyBKjYqcvytAGsjkqYzesiaBqlf8VcGIDfAU
         lXu+DRH9AjKJae1TEGfRrm7nmGDO0PIn6YNqX6jtnu2ZfPYyIcezWZ4iQImwR4LkKI5F
         ypf0KNIlblTIaBfYHaFreD9078CfnNhGFSvycLO99rQyVUn9z3AeOT9+j66roDnvI10+
         O+yQ==
X-Gm-Message-State: AOAM531MdVq+EY7HS76CYESTq5vWD4YJLKtzDHnHR/KD7LPfyzuOaYPB
        vd4SZzJXLvyUh8On9fCpTDMew1HrekxPEC04q6uEdA==
X-Google-Smtp-Source: ABdhPJymivj3gwg+ofdgaI/9ikpUntsEfmDwX2LnnFp7voT387i9DjqiinnSGvpjcOnL95u1gkhLmMEUEEUYHguQQ2I=
X-Received: by 2002:a05:6808:486:: with SMTP id z6mr14094308oid.103.1590482573648;
 Tue, 26 May 2020 01:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200416085821.108778-1-stephan@gerhold.net> <CAPDyKFq0qFjS_VB7okPdXzc0DfWf8saNax7ZsuxeUWB6svRnhQ@mail.gmail.com>
In-Reply-To: <CAPDyKFq0qFjS_VB7okPdXzc0DfWf8saNax7ZsuxeUWB6svRnhQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 May 2020 10:42:41 +0200
Message-ID: <CAJZ5v0jJDd1wJ0qV-BnD0DOaNa0-4_C4sFH7K=HGVO08X0=bUQ@mail.gmail.com>
Subject: Re: [PATCH v2] cpuidle: Convert Qualcomm SPM driver to a generic
 CPUidle driver
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        ~postmarketos/upstreaming@lists.sr.ht, Luca Weiss <luca@z3ntu.xyz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 26, 2020 at 10:24 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 16 Apr 2020 at 10:59, Stephan Gerhold <stephan@gerhold.net> wrote:
> >
> > The Qualcomm SPM cpuidle driver seems to be the last driver still
> > using the generic ARM CPUidle infrastructure.
> >
> > Converting it actually allows us to simplify the driver,
> > and we end up being able to remove more lines than adding new ones:
> >
> >   - We can parse the CPUidle states in the device tree directly
> >     with dt_idle_states (and don't need to duplicate that
> >     functionality into the spm driver).
> >
> >   - Each "saw" device managed by the SPM driver now directly
> >     registers its own cpuidle driver, removing the need for
> >     any global (per cpu) state.
> >
> > The device tree binding is the same, so the driver stays
> > compatible with all old device trees.
> >
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
>
> Rafael, I think we all believed that you were intending to pick this up.

Oh, but nobody let me know that before. :-)

> Is there anything additional you need to make that happen?

Not really, thanks for letting me know that I was expected to take it.

> FYI, this allows further cleanup to be made on the ARM cpuidle code.
> Both in arch and cpuidle code.

Sure.

Thanks!
