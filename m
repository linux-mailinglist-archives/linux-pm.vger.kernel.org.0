Return-Path: <linux-pm+bounces-11060-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FF8930070
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 20:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C56AB22A39
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 18:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508BE1B978;
	Fri, 12 Jul 2024 18:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="MrzM5IsQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D1C18E1A
	for <linux-pm@vger.kernel.org>; Fri, 12 Jul 2024 18:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720808628; cv=none; b=H56bMfpL15GN3QEQXH4Ujrfxg1ONxfg6NfdfJDXUN0Ars0vX3J41fhgRinAe98c0z7WJMy9g5rsbDwKDXxo0KKlSyvtInOhArBr0AZx3XsGwXeft4U+HRnQW93zUB9ATCh58vDCskeZ2SWBgvigkgpTpbZ4nb/G51IWRDUeireQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720808628; c=relaxed/simple;
	bh=obQauV9WtpcWKNSkw+P6HBBIZeLyV+gz/HdZ8WNewKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ieuLRCuRbYE2by+H6+Kk0T2n9KtWpPSxMoyAdLUFVLJaKAAt+KgK46ootVte2YM1rl5C4UANkgQkwr9mTsdcKpSeljvcHyyDLaPqG+A5SzbdbQdcolSh9Ff8KAoYHy/uvHay24TfyU3TuQcYaISd1qPpSNC+dol60XZT9QNeIQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=MrzM5IsQ; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ee9b1b422fso29249161fa.0
        for <linux-pm@vger.kernel.org>; Fri, 12 Jul 2024 11:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720808623; x=1721413423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TeLZjX0XcIxy15WR6vzd+HbVbS4ez8SeQ29NDXBIAz0=;
        b=MrzM5IsQB4CXbPTKhcMpBbv5kKwuDYh/eiZqNipO1dC+SpbztkdHX5WQw7/qif95Gv
         PnsyvI6wriJqqRSIYAT7drBKzir/vLpd5HF7MQ0oVO2KxPu1bSM5LcK9A4LNOH0kHlfx
         NVf/lSyOL8wBj6+F+5SofAsR7lvUBSZxLcP2dRaKUTIP/BNqjvGqmkgLHuNc9C1vo4rZ
         /Z9D9qUp2TjaFg/Fr/94lXdwmAIFFTXrH94x4R9ZGbYbHfYarGfDM6R7Xc7K0gFpxU0N
         lYxbjti+ruEzUu1B4r+nHNQFjI0MA4vGQ0mp1QMTD+D1hgLdnUejJ2kA9h4+e78Gkjsx
         kp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720808623; x=1721413423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TeLZjX0XcIxy15WR6vzd+HbVbS4ez8SeQ29NDXBIAz0=;
        b=Wvv5f4eZxqvNEdWVm6vDU3ZdGOh/mxfO7KkxWBJrqJo1CqUEApocQmtWOVpetP7Czj
         B8tZrU2qRnBcn4VWgKH65yfguTTlPLrmqctEg3Lxnlmf2oVK+P5wsngUmuhvPgRlUdnl
         evmRWYbx5xw5QZsVbfyqESFzyuD8dsNA45qC/vlKLlRBXi03BpS7e7v3XJb6ocoGCac1
         ex4AdZlhzDW/wix4yMsfAjdQDXFID1ntSOkxzV0n+F1twqanMKtguB7Mag3dISwqKkoU
         RyTfNDL/EF20UYy4URKGeSOtUNCfBzK+7HvKM5fC8blIPeltN6PjuuiRUZILc4Qdw96+
         DxJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/7OmS1k4cTyq9Z91mbpNfVqX6vU3QWs2oVZqSHdnQPsJJGHF6OZ14BDeYwkK3ItBHvmtmEyjRFD+t7CY7flAMCrjezkJQ4sc=
X-Gm-Message-State: AOJu0Yx8s57RbvHkdrv8V02P2Gx2Jm8eAY+3asf3sksGHiCj+jkSXQhn
	IIENOSa8C8vv8UD1dOCJsjsN9dHbaQg081zxmmGACe9qnnerCQ7XKMUYLXcQ6CqYjAP/iAbIzvB
	eRwUVFQza0BHPyHKGvTS94tdA4129wM+onsEMeHKtNPfD3hPk
X-Google-Smtp-Source: AGHT+IFr1J1qlgrULvkxVx21H4No5aP9MUmcvCKCEVN949ifyzIDD6A8inKcM3O2Y/kzQx9Z7cwixXOfaJoOz3jcEBc=
X-Received: by 2002:a2e:984f:0:b0:2ee:4cb9:8057 with SMTP id
 38308e7fff4ca-2eed2a50be7mr9628351fa.23.1720808622312; Fri, 12 Jul 2024
 11:23:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712144546.222119-1-brgl@bgdev.pl> <7d7dcc46-2042-439b-a744-49ae4b507839@suswa.mountain>
 <CAMRc=MdqZZLJLrAb10amgZSz40k1qAVMohVeUvHqobEHR5qaZw@mail.gmail.com> <bf3f5a67-f6cf-44ed-a2d8-5722dcae9869@suswa.mountain>
In-Reply-To: <bf3f5a67-f6cf-44ed-a2d8-5722dcae9869@suswa.mountain>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 12 Jul 2024 20:23:31 +0200
Message-ID: <CAMRc=MfjZC1e84eHWaxPBK9Ui_CpeVDDaF+xrQxx3Q63nFr8uA@mail.gmail.com>
Subject: Re: [PATCH] power: sequencing: fix NULL-pointer dereference in error path
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 5:24=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> On Fri, Jul 12, 2024 at 05:02:25PM +0200, Bartosz Golaszewski wrote:
> > On Fri, Jul 12, 2024 at 4:59=E2=80=AFPM Dan Carpenter <dan.carpenter@li=
naro.org> wrote:
> > >
> > > On Fri, Jul 12, 2024 at 04:45:46PM +0200, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > >
> > > > We may call pwrseq_target_free() on a target without the final unit
> > > > assigned yet. In this case pwrseq_unit_put() will dereference
> > > > a NULL-pointer. Add a check to the latter function.
> > > >
> > > > Fixes: 249ebf3f65f8 ("power: sequencing: implement the pwrseq core"=
)
> > > > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > > Closes: https://lore.kernel.org/linux-pm/62a3531e-9927-40f8-b587-25=
4a2dfa47ef@stanley.mountain/
> > > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > > ---
> > > >  drivers/power/sequencing/core.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequen=
cing/core.c
> > > > index 9c32b07a55e7..fe07100e4b33 100644
> > > > --- a/drivers/power/sequencing/core.c
> > > > +++ b/drivers/power/sequencing/core.c
> > > > @@ -119,7 +119,8 @@ static void pwrseq_unit_release(struct kref *re=
f);
> > > >
> > > >  static void pwrseq_unit_put(struct pwrseq_unit *unit)
> > > >  {
> > > > -     kref_put(&unit->ref, pwrseq_unit_release);
> > > > +     if (unit)
> > >
> > > I was wondering where you would put the check.  But it needs to be:
> > >
> > >         if (!IS_ERR_OR_NULL(unit))
> > >
> > > regards,
> > > dan carpenter
> > >
> >
> > Am I missing something? pwrseq_unit_new() can only return NULL on error=
.
> >
>
> It's not pwrseq_unit_new() but pwrseq_unit_setup() that's the issue.
> The target->unit =3D pwrseq_unit_setup() assignment in
> pwrseq_do_setup_targets().
>
> regards,
> dan carpenter
>

Indeed. Thanks.

Bart

