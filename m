Return-Path: <linux-pm+bounces-4900-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB4487B23A
	for <lists+linux-pm@lfdr.de>; Wed, 13 Mar 2024 20:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C1AD1F22B33
	for <lists+linux-pm@lfdr.de>; Wed, 13 Mar 2024 19:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27E23FB1C;
	Wed, 13 Mar 2024 19:47:54 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5151F1A38D7
	for <linux-pm@vger.kernel.org>; Wed, 13 Mar 2024 19:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710359274; cv=none; b=TBrd7fVJNU0BUbMYJylR4O9zDEb4ziN0ERHF18ZUyaUqV1WpdrVRFgCSagLpIyz1parpUKItsasWOKJCrPckqzTlrSThFKe00oJ7reEplzPjX3dhVKSpjX8LlmSmleJQ9GORAXLY0K2csuZ7nGx2S5R5cEIbHJuPTRVX62WnUM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710359274; c=relaxed/simple;
	bh=KO1YkFM8cNL7s5rnCiYaAwRyw/nqRU0fO7k284koYNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YAPvU1tUONobi+ytU4JyBOGG0aVhh1Rv+dxZpOWSJAbUSuhJ+VXKCxSst4GNFoovxY9KQlPIuG/4vPYt4XJtsHBmu5e3/kllkiqkr31nFB9EDTHPHjGmd5zJINo0UQUmXoc0mYJzgMdl8zMf90VBZ2Rc+rD3tSi8PgM37m/Su9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-220ce420472so63696fac.1
        for <linux-pm@vger.kernel.org>; Wed, 13 Mar 2024 12:47:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710359272; x=1710964072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KO1YkFM8cNL7s5rnCiYaAwRyw/nqRU0fO7k284koYNk=;
        b=tLyXiiQQ7mX7XWoYEecRJ+siVTVrZ9LHONY0pLyhzWSRGr+DKce7nApnuue4YZBbqi
         RnN3n1jo1MsFJC5E2tGK+EW1coQ2tujA2PM4s0Ih6hdrOfryna0X5xgl/yQ3//yZqZ54
         b02dUzd0jIDVkXqImcM09UPb2pIy9UKlIGnLXyoqpooNweglcttBGDtbimATKC3+OaOd
         oBypbPO5zk9ntUlWd+NSN6s+sD3xROHQl8eESsb1E0OBj2QVeu87YyDdBQCW3Dhl4vkY
         4K+JnpmwDgLJSZGDwzTxX5raXJXymknQCKjwj+pNmajKIOxlohyCSIdkTu6T6viSVcsv
         +FJA==
X-Forwarded-Encrypted: i=1; AJvYcCVGrWpgd0LcdxNY3Z0RH17xlwvhLVd7+r4R5azkh0t44N1ffJxqXKWKf6kpiiI7ulj+HM9V7CfbhtIsyZmAbg9+pPr+sdOd9wc=
X-Gm-Message-State: AOJu0Yw+E/vVTArKTB7OhWpFlnG1O/ZdcV1ZC/v4+BFzWtC0fczZjxQs
	pyK06Je99PgaB3F3B+R7GupkOLte7Rt5GqjzmylSa1DfFUliYWGLvGLtk8gG/pM4syDby2mn0cu
	+GTNteYM0n4wBCYz5gumoXYiY6NppXM92
X-Google-Smtp-Source: AGHT+IE6R8FRiDPyixGCaAjOmdTGdr0FVYIBEgh/n/HWURMrY8n7mrwfIj+IZjYN2ZBb9FsTQnuwv4qbxaweNnh5aYM=
X-Received: by 2002:a05:6871:294:b0:21f:cd7d:9904 with SMTP id
 i20-20020a056871029400b0021fcd7d9904mr2889251oae.4.1710359272482; Wed, 13 Mar
 2024 12:47:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <98afe4627bcfbddedfa36fb5631bb47913f5fa94.1709886922.git.u.kleine-koenig@pengutronix.de>
 <82b55fc7b94fe96e41e3b907a72c85523f15e745.camel@intel.com> <q4sturvyzq6fgy7juycu3tcd4rym6zeyx66jvfy7rtlmdyr5bw@7bvefe24phkr>
In-Reply-To: <q4sturvyzq6fgy7juycu3tcd4rym6zeyx66jvfy7rtlmdyr5bw@7bvefe24phkr>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 13 Mar 2024 20:47:40 +0100
Message-ID: <CAJZ5v0icu-PXCneqk2WsMd7Lf18KFaeaGdgOmUu4JwD-bp6RaQ@mail.gmail.com>
Subject: Re: [PATCH] powercap: intel_rapl: Convert to platform remove callback
 returning void
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, "rafael@kernel.org" <rafael@kernel.org>, 
	"kernel@pengutronix.de" <kernel@pengutronix.de>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 10, 2024 at 2:59=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> On Sun, Mar 10, 2024 at 01:16:03PM +0000, Zhang, Rui wrote:
> > On Fri, 2024-03-08 at 09:51 +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > base-commit: 8ffc8b1bbd505e27e2c8439d326b6059c906c9dd
> >
> > This "base-commit" is not an upstream commit, which makes it more
> > confusing.
>
> FTR, 8ffc8b1bbd505e27e2c8439d326b6059c906c9dd =3D next-20240308.
> You're the first to claim having troubles with using next as base in my
> career so far.
>
> > Seems that the base support is added by commit 5c5a7680e67b ("platform:
> > Provide a remove callback that returns no value"). IMO, it would be
> > better to refer that in the changelog. But anyway, the patch LGTM.
>
> Yeah, ok. I normally mention this commit in the cover letter if there
> are several drivers to convert in a subsystem.
>
> Given that 5c5a7680e67b is contained in v6.3-rc1 I'd expect that there
> is no need to explicitly point it out as a dependency.
>
> > Reviewed-by: Zhang Rui <rui.zhang@intel.com>

Applied as 6.9-rc material, thanks!

