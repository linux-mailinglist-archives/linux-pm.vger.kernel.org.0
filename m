Return-Path: <linux-pm+bounces-943-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B54E380EB19
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 12:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F8351F21AEF
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 11:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCCB5E0A3;
	Tue, 12 Dec 2023 11:59:32 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE12D9;
	Tue, 12 Dec 2023 03:59:28 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3b9ed8c3472so762321b6e.0;
        Tue, 12 Dec 2023 03:59:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702382367; x=1702987167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2rCobFJUuKz3FJXg7Q8CIUv9LXIFa1ZDDGDNt6L6DlY=;
        b=PP7rmmSD5zQCoKF2OKWFfwGX+yh3SS5TstFmbfTRm37GgTUEkOInu6Yd7X2uYUZ9cj
         haieWd/YYG9YstU67YMP03mCSR58npQkovLdP4OUXUX3UQy96ctWR0frlKTPXlgZNvdR
         3W2a8YterMQh97T+wXze2pUb0FeoBMsmNLAXpOuYGmiqtA42sQObDSUxmTapo0xer+R8
         NEZp81C6hg+iWEWvCpHvM82aWYXn4ytxkATqXbIxD/mRtyIjN0SwFDWTWhvyL8TRFiql
         FvoRWen7tbM6QBqSk03XVtTE2UVWCSP39X/IlzC9pqWOdUM+dHqvjXuIfsicMMBC/OG9
         CMGw==
X-Gm-Message-State: AOJu0Yx76QS5QVVTvDjmHqWHWVOyVrXgx9u9W+VwHx+n/bVnZS3dcSa/
	CYkMDj3iathdbD/yqsir1UeWUi0fsf5RGX4T3jY=
X-Google-Smtp-Source: AGHT+IHayhFRjzODeFjXeZ0kn7mS1NSbOR+l88L1hIBaw/FDrsZJqTZp5zjmYKcxOzKwBBO+Y332ul6oLsGYrH1I6HI=
X-Received: by 2002:a05:6820:2a18:b0:590:9027:7ab0 with SMTP id
 dr24-20020a0568202a1800b0059090277ab0mr8867335oob.0.1702382367518; Tue, 12
 Dec 2023 03:59:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127151931.47055-1-ulf.hansson@linaro.org>
 <CAJZ5v0jXRNDV7AhZPkrDvMtrk6cYeMJ+HuUs0kJ=kjbQ-YiyVA@mail.gmail.com> <CAPDyKFpJ6_+nF8q3L4Tg1E9St3stgJ06se0t=FLHkx4_36OJNA@mail.gmail.com>
In-Reply-To: <CAPDyKFpJ6_+nF8q3L4Tg1E9St3stgJ06se0t=FLHkx4_36OJNA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Dec 2023 12:59:15 +0100
Message-ID: <CAJZ5v0jxMjb-bUbJiHgehe5xJ6cwspvsRp5P_2N6FyvRFshJQA@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: Drop the unused pm_genpd_opp_to_performance_state()
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Kevin Hilman <khilman@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 11:37=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
>
> On Mon, 11 Dec 2023 at 21:44, Rafael J. Wysocki <rafael@kernel.org> wrote=
:
> >
> > On Mon, Nov 27, 2023 at 4:19=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro=
.org> wrote:
> > >
> > > Since commit 7c41cdcd3bbe ("OPP: Simplify the over-designed pstate <-=
>
> > > level dance"), there is no longer any users of the
> > > pm_genpd_opp_to_performance_state() API. Let's therefore drop it and =
its
> > > corresponding ->opp_to_performance_state() callback, which also no lo=
nger
> > > has any users.
> > >
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >
> > I can take this in principle, but I'm wondering if you'd prefer to
> > apply patches modifying domain.c yourself?  They are definitely
> > related to the pmdomain tree.
>
> Yes, it makes sense for me to pick the genpd core patches through the
> pmdomain tree. In some cases there may be overlapping patches that are
> more generic and not only limited to genpd, but I guess we can decide
> on a case by case basis for those ones.
>
> I can add the pmdomain tree to the GENERIC PM DOMAINS section in the
> MAINTAINERS file to reflect this, if you think this is a good idea?

Yes, please.

What about moving drivers/base/power/domain.c to drivers/pmdomain/ ?

