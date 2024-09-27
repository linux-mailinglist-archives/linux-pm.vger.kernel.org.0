Return-Path: <linux-pm+bounces-14851-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFF6987D9E
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2024 06:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94F4E285001
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2024 04:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED31B16E863;
	Fri, 27 Sep 2024 04:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W5WMGoGb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF73EEAA
	for <linux-pm@vger.kernel.org>; Fri, 27 Sep 2024 04:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727411930; cv=none; b=WtkWybiZH6qsMXJ3hHdF5rcc5K7thG7pkKSM0sP4rAAfnisHm1EfbIRDG6kEBFNrUEINKgsQKA+yjd04Ks1Z8VSQe3tM6WVs2W1FOr6Tnkydlgxsc0T6RCp619Bl7zrFUe9fHWws//XQwGhKLB+/ab/ndkP6i4KHioN3KybqRv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727411930; c=relaxed/simple;
	bh=XnZrFknTED31CpFW1xavqyjmQ1RP1hTTwJB5JF3Tth8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U/uOGFL+r304BU2f2ebh5OOi+OKTqDlDGQv0Hitie76v+ihPDzl/nPmvjXe2+za5xYMgqmCb5YHKPzCytXjwjtgbpGrR1+jWYt6PA+o7aiO6i50vMb0kXcAjet8PYL/pQJAiJ6aO82M29Y61Z5lb7REa2S6mvbgyMEQGLX1jhzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W5WMGoGb; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5365aa568ceso2072608e87.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2024 21:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727411927; x=1728016727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/P54adq5wqPeVhdzqGMRKbTP9qOT4nAYJ2m7pC5TLg=;
        b=W5WMGoGbjzxR4OZua5UMBbYrGfebKWOsMKPHeWxlRVh8ZX1w06+/KxGXYsWMJvyUwv
         O7zD4KYpHyQSj3fGhmcvyW/RmwG5KaP8XqbD/BKd4hSf7+b8HmAK6YJCXTfEeOgO2Wlt
         /HIDH5gkJFduGJl/HBAsFRmAn+eL6AuZ8C4d4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727411927; x=1728016727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h/P54adq5wqPeVhdzqGMRKbTP9qOT4nAYJ2m7pC5TLg=;
        b=hr+PqgR6VesEyOWQ69jpwGIwFQ8L90rQS2s1tr13S+TpQcKrlOdIriLsV20pJqV/P9
         PH6LUimG1r5j/E1W/HUhW+E40sYrkgjA6ubSvEGxIpNv8zP/x2j+OFxe4/c/QVTfCkzL
         r/9HgaeOtVXTV77FcJHjX1ddxQtdCuh8yTmznpFS0yU/swfOakq5Q80x0HWh43EPSN6Q
         tW21nwfH/+/d6xHPaMJc7SOsGj7xaYIuzqzUoCEyGa5U/Jydz86JK5elRqYpqlXN/5UN
         RYGxOcLaoSCYrIbKMK/lql+sBwDHrVp/qlqHHMlBnOi6cO89z9INBLfkcNyzrXjyGdDs
         SkPg==
X-Forwarded-Encrypted: i=1; AJvYcCU0vqLb3tqYCyvtB2yM0JCqqR/2AknSwD9mRQFL5aimAKD4S4TAFzy50XS9AE+/X6f48WZ1O5ovyA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxISUHJzt7ps7nWzjTnyn043z6T6q3fxibfJl5GjGDiXtVIkOb2
	2UU+clSecTfkHs5gzs6fEJ6pgbRg6XyaEj5tUk+AMDo9QeUCUgCKKFNe8KSoSlJe4a7Sp7hzrVp
	pLpZ7uBQ/OilZQLPHO1+sP1sqbEQ3enQe8z2Q
X-Google-Smtp-Source: AGHT+IEuKMKaL9pm5ASOI7F2wVDmv6urgJgoH8ydyHLtVrSS2VSiUn0vrSHcCfRK5Gdvnw9KKS+IW86HHLQ+3e6fKoQ=
X-Received: by 2002:a05:6512:3e05:b0:52c:cd77:fe03 with SMTP id
 2adb3069b0e04-5389fc3bd31mr1339969e87.14.1727411927087; Thu, 26 Sep 2024
 21:38:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925093807.1026949-1-wenst@chromium.org> <20240925093807.1026949-3-wenst@chromium.org>
 <ZvPscRdWlFPmtCyR@smile.fi.intel.com> <CAGXv+5Gf9+rc+vLcr-JFhO561G8dw38ksV3drat+DyCfWEVakQ@mail.gmail.com>
 <ZvVS7ITg2t-RIh8C@smile.fi.intel.com>
In-Reply-To: <ZvVS7ITg2t-RIh8C@smile.fi.intel.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 27 Sep 2024 12:38:35 +0800
Message-ID: <CAGXv+5EV4nNiAneajqr4VBkX4TO3zV76yqBM_u81ZMNjU52Bvw@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] regulator: Add devres version of of_regulator_get_optional()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Mark Brown <broonie@kernel.org>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, 
	Johan Hovold <johan@kernel.org>, Pablo Sun <pablo.sun@mediatek.com>, 
	Macpaul Lin <macpaul.lin@mediatek.com>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 8:26=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Sep 26, 2024 at 04:43:52PM +0800, Chen-Yu Tsai wrote:
> > On Wed, Sep 25, 2024 at 6:56=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Wed, Sep 25, 2024 at 05:38:05PM +0800, Chen-Yu Tsai wrote:
>
> ...
>
> > > > +#if IS_ENABLED(CONFIG_OF)
> > >
> > > Do we really need this?
> >
> > What's the point of going through devres_* stuff if we already know
> > _of_regulator_get() is going to fail anyway?
>
> With devm_add_action*() this will be other way around and there are plent=
y of
> APIs done this way. The ifdeffery is simply ugly in the code.

It's still extra code that doesn't get compiled out.

> > Also, _of_regulator_get() does not have a stub version for !CONFIG_OF.
>
> So, what prevents us from adding it?

Because there's no need if the only internal user isn't using it.

I could also move them over to of_regulator.c.

_of_regulator_get() stays internal to that file, and devm_regulator_release=
()
gets exposed instead.

Does that sound better?

> > > > +static struct regulator *_devm_of_regulator_get(struct device *dev=
, struct device_node *node,
> > > > +                                             const char *id, int g=
et_type)
> > > > +{
> > > > +     struct regulator **ptr, *regulator;
> > > > +
> > > > +     ptr =3D devres_alloc(devm_regulator_release, sizeof(*ptr), GF=
P_KERNEL);
> > > > +     if (!ptr)
> > > > +             return ERR_PTR(-ENOMEM);
> > > > +
> > > > +     regulator =3D _of_regulator_get(dev, node, id, get_type);
> > > > +     if (!IS_ERR(regulator)) {
> > > > +             *ptr =3D regulator;
> > > > +             devres_add(dev, ptr);
> > > > +     } else {
> > > > +             devres_free(ptr);
> > > > +     }
> > > > +
> > > > +     return regulator;
> > >
> > > Why not using devm_add_action() / devm_add_action_or_reset()
> > > (whichever suits better here)?
> >
> > Cargo cult from _devm_regulator_get() in this file. However since this =
is
> > meant to share the same release function, both functions need to use th=
e
> > same mechanism.
> >
> > I could also argue that this is not an action, but an allocation, and s=
o
> > devres_alloc() seems to make more sense.
>
> It's rather matter of the naming of the devm_add_action*() APIs, but agai=
n,
> we have plenty of APIs using it when it's allocation and not strictly spe=
aking
> an action.

OK. Still the mechanism used needs to match that of the existing API.
So devres_add() it is for now.

> > > > +}
> > >
> > > > +#endif
>
> ...
>
> > > > +static inline struct regulator *__must_check devm_of_regulator_get=
_optional(struct device *dev,
> > > > +                                                                  =
       struct device_node *node,
> > > > +                                                                  =
       const char *id)
> > >
> > > I don't know the conventions here, but I find better to have it as
> > >
> > > static inline __must_check struct regulator *
> > > devm_of_regulator_get_optional(struct device *dev, struct device_node=
 *node, const char *id)
> > >
> > > Similar to other stubs and declarations.
> >
> > I don't think there are any conventions. This file already has three ty=
pes:
> >
> > 1. Wrap the line with the function name on the second line
> > 2. Wrap the arguments; wrapped arguments aligned to the left parenthesi=
s.
> > 3. Wrap the arguments; wrapped arguments aligned with aribtrary number =
of
> >    tabs.
> >
> > I prefer the way I have put them.
>
> The way you put it despite relaxed limit is slightly harder to read.
> I don't remember many headers that do so-o indented parameters. Besides
> your way defers the burden of resplit to the future in case one more para=
meter
> needs to be added which will excess the 100 limit.
>
> Also __must_check is somehow misplaced in my opinion (talking from my
> experience and this can be simply checked by grepping other headers).

Seems correct to me. It's between the return type and the function name.
From the coding style doc:

 __init void * __must_check action(enum magic value, size_t size, u8 count,
                                   char *fmt, ...) __printf(4, 5) __malloc;

The preferred order of elements for a function prototype is:

- storage class (below, ``static __always_inline``, noting that
``__always_inline``
  is technically an attribute but is treated like ``inline``)
- storage class attributes (here, ``__init`` -- i.e. section
declarations, but also
  things like ``__cold``)
- return type (here, ``void *``)
- return type attributes (here, ``__must_check``)
- function name (here, ``action``)
- function parameters (here, ``(enum magic value, size_t size, u8
count, char *fmt, ...)``,
  noting that parameter names should always be included)
- function parameter attributes (here, ``__printf(4, 5)``)
- function behavior attributes (here, ``__malloc``)


> That said, I prefer the way I suggested or something alike.

Two people arguing over style that is not clearly specified in the coding
style doc is probably wasting time. I'll use what `clang-format` gave:

static inline struct regulator *__must_check of_regulator_get_optional(
       struct device *dev, struct device_node *node, const char *id)
static inline struct regulator *__must_check devm_of_regulator_get_optional=
(
       struct device *dev, struct device_node *node, const char *id)


ChenYu

