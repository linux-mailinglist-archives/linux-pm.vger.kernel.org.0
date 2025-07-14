Return-Path: <linux-pm+bounces-30797-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A673B03ED3
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 14:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F22E53AC1E1
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 12:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D3124502D;
	Mon, 14 Jul 2025 12:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ns/X6vcH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6A220AF67
	for <linux-pm@vger.kernel.org>; Mon, 14 Jul 2025 12:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752496630; cv=none; b=eIqng21Y/k6ZN4cZEslP7YXKJW187IQC2snakq264B7d/3VQejJD1d8jbJ5UEtE0O2RP0urLmxXTQ6Rbc3HjdbGEVF6NhSYEk+mXmxlUHCaImmmAXT+TeiT+9vSLl/60EpzWKQ2OVdVxpfZ4haMeuD3gOnRWV326qDFJiQR/c+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752496630; c=relaxed/simple;
	bh=ze70y/U4LiuMguEZ/qbQTQRs/404X4FXJWc3lUugnLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xzu3SzGRWx55mLetHjc8Qoj+68eectJJrn5AksFemtpWQXb1MLg396G6+fuP3si6vkkAQdSvhR2eh+M5uOmjulkafBGXNbd8OkQX5orAD6N8twSghybNovyLbZPB0RoPCo+pKKD940SbwpTdrhQRZvAj4Ti/FJqAVAaSwn91Jx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ns/X6vcH; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae3b336e936so853469666b.3
        for <linux-pm@vger.kernel.org>; Mon, 14 Jul 2025 05:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752496627; x=1753101427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxQWwN5893QgqEKCT5i+8flzUyp8H+JAUyY8KUUtFSI=;
        b=ns/X6vcH7/a9HKPSi/1JrGtCGOmx66CKvjHInTAJv5EEUUOrBQPtUf2XUyQXEhKn13
         5x5SLN0Z1l6Vva4K1JJSb6ypwg+tEIc/QpMyYsPeHUs5EpgouXxcH0QXFlSuQ95OBCmn
         BMOdyvqWHxfgjaRoLL5+zA4nqRSEKwNLzL2+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752496627; x=1753101427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mxQWwN5893QgqEKCT5i+8flzUyp8H+JAUyY8KUUtFSI=;
        b=EDNuNgGty0BwnHnwmk6gFgDLu/1wpcIlw0C097V64HAeKucD9uzJdyjc2tEmmb13EW
         X9igiR6pUKztQOU7KTup3fTsojkxrNphL5tnR+AW54Re8LLPs0Vml5IT90OiydIS/j3B
         iSPC56fvdpoVC6yL/J8AGgk2W3KfYYPkXmGLPYaWnIyFz4tVWba46AhYN/gO5t3h7r0I
         Xi+MRcbXcU/UCoXNlbojYMv6qSgJAZxMWeGSgXvgYHmIS7RR9eADZJg6WWDJCo4fDqCM
         f4YIUt1mlCiFEFAmYlwM284UEsjY02fk/yatuJ1BflNOalQyJsOh4bN3+xMjAVmImKwf
         5axw==
X-Forwarded-Encrypted: i=1; AJvYcCXf876oXhcqgcYOyizb6Zg8TLVOX76m9O5MAxO6CYjNW+pH75QxhHhSNV25ecG2RmQD5R/3iJ79ew==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvNSets3l1MZ2+Pg8/4TU272KIZ88VUSSbSZU5xWbj3QSX466i
	Bwi0D/Z1FnR+bmVaRsTIeb+ZlMPpQ6LjWLN+8Jwqi08PhNXH9X4MbMEdV/b0GNoVhTwVVd4EtCC
	zjbY=
X-Gm-Gg: ASbGncvvx6PnrBGOQMweWW2C5QoNWzDwO3ZDvwi2fTr/8z5chl4u09TMO3ssl8M/jZh
	QcO/qR3sDYKgibfulgVk/s46E9b1gNP23ou8HKMX4jKrMheapSM47F2mpRPoNSYnj5HE+nulOLK
	g3lbb7eIqv41b7a+cNmyDcNsiNKr/H3mwbfkaLMv7aasuSOQsM1Q3FQoCqmWKlCjZy4/kKCMaFV
	g84OGFr8dOOocsVK+Myy9CeIfZAzwFQAhm88aMfgC+D0mllpK8l1XXJfccbGqfrayj9N//lRA37
	Mcd9EU0hgrmmp+gkVucUvojjv3hq/5QIm5eHPK6FzbkbDV09O7LgQiBPJAWjZOA3HPqe5w3cE4g
	+Nz1h3qF00gcGINWuW1qlhKKk6dejjsRgCQM4T71miFaOfq2pO1DhEVpb3+d7KWBO
X-Google-Smtp-Source: AGHT+IFE8FXFWfuew6TEL6/SQd+yG3iEkMN2dd2UOON8JQ8JVoletJ/Vik0lfI/7kGwzQzXCDKvSYg==
X-Received: by 2002:a17:907:841:b0:ae3:bb4a:91fb with SMTP id a640c23a62f3a-ae6fcc7e0f1mr1356404066b.59.1752496626560;
        Mon, 14 Jul 2025 05:37:06 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7eead92sm826564866b.63.2025.07.14.05.37.05
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 05:37:06 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-60b86fc4b47so13087a12.1
        for <linux-pm@vger.kernel.org>; Mon, 14 Jul 2025 05:37:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVZobgcjfDTZ4mi3R7ipRwMkszTtxh/Dl3bL8lQB8+HgSNozzM9KVzDNDpj6IqNY0Yd3/23RGZjlQ==@vger.kernel.org
X-Received: by 2002:a05:6402:5242:b0:60e:3d45:c65a with SMTP id
 4fb4d7f45d1cf-6120ca85d1cmr158081a12.5.1752496625328; Mon, 14 Jul 2025
 05:37:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707-trip-point-v1-1-8f89d158eda0@chromium.org> <2025071012-granola-daylong-9943@gregkh>
In-Reply-To: <2025071012-granola-daylong-9943@gregkh>
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Mon, 14 Jul 2025 20:36:29 +0800
X-Gmail-Original-Message-ID: <CAHc4DN+kb8w+VVX0XAfN5YVo9M+RBatKkv8-nOiOTA+7yZjmfA@mail.gmail.com>
X-Gm-Features: Ac12FXyVzm_ojEyrAQbgVa06K6s51wQivdJmMs1O_Fv6DwV3kcnfZgVpo_aFCek
Message-ID: <CAHc4DN+kb8w+VVX0XAfN5YVo9M+RBatKkv8-nOiOTA+7yZjmfA@mail.gmail.com>
Subject: Re: [PATCH 6.6] thermal/of: Fix mask mismatch when no trips subnode
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Hsin-Te Yuan <yuanhsinte@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amitk@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 9:33=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, Jul 07, 2025 at 06:27:10PM +0800, Hsin-Te Yuan wrote:
> > After commit 725f31f300e3 ("thermal/of: support thermal zones w/o trips
> > subnode") was backported on 6.6 stable branch as commit d3304dbc2d5f
> > ("thermal/of: support thermal zones w/o trips subnode"), thermal zones
> > w/o trips subnode still fail to register since `mask` argument is not
> > set correctly. When number of trips subnode is 0, `mask` must be 0 to
> > pass the check in `thermal_zone_device_register_with_trips()`.
> >
> > Set `mask` to 0 when there's no trips subnode.
> >
> > Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> > ---
> >  drivers/thermal/thermal_of.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.=
c
> > index 0f520cf923a1e684411a3077ad283551395eec11..97aeb869abf5179dfa512dd=
744725121ec7fd0d9 100644
> > --- a/drivers/thermal/thermal_of.c
> > +++ b/drivers/thermal/thermal_of.c
> > @@ -514,7 +514,7 @@ static struct thermal_zone_device *thermal_of_zone_=
register(struct device_node *
> >       of_ops->bind =3D thermal_of_bind;
> >       of_ops->unbind =3D thermal_of_unbind;
> >
> > -     mask =3D GENMASK_ULL((ntrips) - 1, 0);
> > +     mask =3D ntrips ? GENMASK_ULL((ntrips) - 1, 0) : 0;
>
> Meta-comment, I hate ? : lines in C, especially when they are not
> needed, like here.  Spell this out, with a real if statement please, so
> that we can read and easily understand what is going on.
>
I will change this in v2 if we end up going with this solution.

> That being said, I agree with Rafael, let's do whatever is in mainline
> instead.  Fix it the same way it was fixed there by backporting the
> relevant commits.
>
> thanks,
>
> greg k-h

`mask` is removed in 83c2d444ed9d ("thermal: of: Set
THERMAL_TRIP_FLAG_RW_TEMP directly"), which needs 5340f7647294
("thermal: core: Add flags to struct thermal_trip"). I think it's
beyond a fix to introduce this. Also, there were several conflicts
when I tried to cherry-pick 5340f7647294. Compared to a simple
solution like setting `mask` to 0, I don't think it's worthwhile and
safe to cherry-pick all the dependencies.

Regards,
Hsin-Te

