Return-Path: <linux-pm+bounces-963-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8627280EDD9
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 14:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2C21B20C88
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 13:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046F761FDE;
	Tue, 12 Dec 2023 13:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aHPFE7nE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DEEB3
	for <linux-pm@vger.kernel.org>; Tue, 12 Dec 2023 05:43:00 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5cece20f006so57291897b3.3
        for <linux-pm@vger.kernel.org>; Tue, 12 Dec 2023 05:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702388580; x=1702993380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mAQFb+6ron76LUgdpTUJdx32df8simBAK0E2prt6OcE=;
        b=aHPFE7nESu5i/mqtkdu6aRJrm0wAys7lpXwZq/CMQOHv1PPG8h+aGOFRxI6xlKSZtP
         FwMceeo6+RouBRWmT4KwrtfudYLJGAwEOKyJzdNHY4WrRAcFTVzvt2IzEuD8ZROTA8Wq
         Od0MUAtn0q3va7CJIcUkggMLioHzGG0lVP+Ii3/VMOnYAfi9p2cL/B9pEyVx/jySdSfV
         Dn3u47GZPYwf4HEReeIh/gwjengXjXSY04kB9BQ1V1/zGIDuGAYu3IXpCsBY7giVxA7B
         ETy52oblViDI82IKzS3gOdvLu43jzzXNs0WiH3SHednniVbM2hsulJ1x4MT59xsWcrTo
         Wl5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702388580; x=1702993380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mAQFb+6ron76LUgdpTUJdx32df8simBAK0E2prt6OcE=;
        b=YNTwg+u1wyo844EBY0fahLZkLde16Q6J4sB3KmtDCPpm2FTfWK08JMuU33zzcAWHY9
         0io6WH6LsIBGQkiXOzyyv6z0YbAfO12jv6jHuiPCLlwBCt99B8GGAbf0ddQFTXkD1CJ0
         /kppMtYS7jkbne7f6+qKxFdePRpptD4XpaYy8WrwbeZfqqbT8UMF7nHYoLH8Zn9cWejm
         zra0gwcuDqJd2q1vgeBHY9wcWC2R5aJW4h/BmwL5oo7yCl3sKExvkd9q7MG7F5I3Jp+3
         UXaJTBesxuq5+nE9CJpuGQtOxVi6rjnW9GOsZEobYhQuPxhLexpuhqUuxk0aNjKNlmbr
         oBeQ==
X-Gm-Message-State: AOJu0YwDs2ruzl29TvrEJ0v9EQ1Bm7VabplIRF9fLqtCnPIeamNfSIZ4
	kOA2FNE2xo3FnWnwPDOwJkD1Xcqhb3LM6NPVTTJPqA==
X-Google-Smtp-Source: AGHT+IGXI8MTlNXqp44K40z930LaIgojX2yvlOPjKoe0EJGLkACdmwfiHtJzUo62FGKni7DyMbfQiKk9Ir0r32fZwYk=
X-Received: by 2002:a05:690c:318d:b0:5df:2830:967b with SMTP id
 fd13-20020a05690c318d00b005df2830967bmr3728505ywb.54.1702388579889; Tue, 12
 Dec 2023 05:42:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127151931.47055-1-ulf.hansson@linaro.org>
 <CAJZ5v0jXRNDV7AhZPkrDvMtrk6cYeMJ+HuUs0kJ=kjbQ-YiyVA@mail.gmail.com>
 <CAPDyKFpJ6_+nF8q3L4Tg1E9St3stgJ06se0t=FLHkx4_36OJNA@mail.gmail.com> <CAJZ5v0jxMjb-bUbJiHgehe5xJ6cwspvsRp5P_2N6FyvRFshJQA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jxMjb-bUbJiHgehe5xJ6cwspvsRp5P_2N6FyvRFshJQA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 12 Dec 2023 14:42:23 +0100
Message-ID: <CAPDyKFobQ7dYb6SBD5tmxcK-u0w1mdQxBhY10GVNVgHj3aYNGA@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: Drop the unused pm_genpd_opp_to_performance_state()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 12 Dec 2023 at 12:59, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Dec 12, 2023 at 11:37=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.=
org> wrote:
> >
> > On Mon, 11 Dec 2023 at 21:44, Rafael J. Wysocki <rafael@kernel.org> wro=
te:
> > >
> > > On Mon, Nov 27, 2023 at 4:19=E2=80=AFPM Ulf Hansson <ulf.hansson@lina=
ro.org> wrote:
> > > >
> > > > Since commit 7c41cdcd3bbe ("OPP: Simplify the over-designed pstate =
<->
> > > > level dance"), there is no longer any users of the
> > > > pm_genpd_opp_to_performance_state() API. Let's therefore drop it an=
d its
> > > > corresponding ->opp_to_performance_state() callback, which also no =
longer
> > > > has any users.
> > > >
> > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > >
> > > I can take this in principle, but I'm wondering if you'd prefer to
> > > apply patches modifying domain.c yourself?  They are definitely
> > > related to the pmdomain tree.
> >
> > Yes, it makes sense for me to pick the genpd core patches through the
> > pmdomain tree. In some cases there may be overlapping patches that are
> > more generic and not only limited to genpd, but I guess we can decide
> > on a case by case basis for those ones.
> >
> > I can add the pmdomain tree to the GENERIC PM DOMAINS section in the
> > MAINTAINERS file to reflect this, if you think this is a good idea?
>
> Yes, please.
>
> What about moving drivers/base/power/domain.c to drivers/pmdomain/ ?

Yes, it seems reasonable to do that too. I will send a patch for you
to have a look at shortly.

Kind regards
Uffe

