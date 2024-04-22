Return-Path: <linux-pm+bounces-6790-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B04738ACB9A
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 13:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 418F41F23CC3
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 11:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1947A145FFF;
	Mon, 22 Apr 2024 11:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkWZPYdo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FBD145FF9;
	Mon, 22 Apr 2024 11:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713783886; cv=none; b=jVRhLmR0Ry+DTswFA1A4JKLhod14PW/cWSDFQQLvZIVAmfj149Pbyavo9LFf+LSFJiRnlYQL5hAR14B1PsN7s1uvZ6sfB1kjMQZRPCIEjWELh+keVrJQSRiG6V9Rwq9AByrqodX1vz37PRrjiOppXiiX5mOxNMh0HV8egHdGrfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713783886; c=relaxed/simple;
	bh=JXm16zia0YU1+Iyv4sWJ/YcpjrXxKfv23uz2LVLhOJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fB5w6D8oyQR9z/laWWbQ4GUlbXfAKxOxoNWwoc5TTmxknhRBwuCW6YeapniVyNufx6494TvJ2RY5swCbqUSuItEtT6xCZhuT369A84iKq8IZK5N3YJCAYx+u03MPdnUphxhj5FA0VgWS4hLY8ZmIJOIW0jEuUDABm0Z3Ur52z4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkWZPYdo; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6150670d372so37347737b3.1;
        Mon, 22 Apr 2024 04:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713783882; x=1714388682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6BTTO2yQGavTdTVfo1GBEafZqwKHuqYzmiVDOWg2UY=;
        b=GkWZPYdoWgHniuTP6ULDgufMYFXLRTCqPkm4VSjA2QCveF2b40tuqL2D02dSnpe4lU
         dUb6WzmsgT3WNyH0Jc1eHRF3+ZgJBD5Ne0uaCGs5xxfw63Rs2Y+CIiCQObvhUJJA/E7y
         V3iiGSiCc5BcMixSS6tq6d1b+vKnjACE0CV3LSScwCrTTf922m7j7sLmY0q6cnpf0WA9
         xvacddlRAXCaHUtGyelW+E4rlbd6Bn359uOx8tPPPaKQ8jzIOPMsPUT4SKl10s6iz1T+
         0gUg9v8KuwC+dmoc5Jx/OBmxTTbmTC/xJ5ztBQU9gZEjWPdNouWZAVLOOHfAZCATDwKG
         Thzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713783882; x=1714388682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6BTTO2yQGavTdTVfo1GBEafZqwKHuqYzmiVDOWg2UY=;
        b=AnwWMy5+LCvWmRW1GhHLl5VgnRVSFDHyZ982sgr/My9/MmSPt2qn+xUwWNtwK3m3Ke
         MsC7ACjSgiOrxb/3LpOgogGmqfIvKeIEH6o2p6omFBDPlei4CrwaZqgFG0Vk2XzXdVbb
         BzJcuYgBnYoQkdk2iG+hhnd848ESNsjUF0zxLTgngxzJsGsQryb74zdUVkVq7+cMJZDz
         87TJFaK4V26B0JrMc0PBzZRtqvmJA91V6r4oTvv7yI9y60f0mmnMk3pS1Lf9/dUzGIqs
         CNvRNz0/bc//6jThI4x6SWJkKoLMafXv1bg2RlTcaz1GKwCQdDr1VCXJ8fw2Ua0oVI8A
         rQ+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPdTQIFjVkF10HqkTDzH1Ie6cYqOjrlIJfNYctXgTLLDkdtkCQ17TDgvXywZ/M+vprqh4SYOycKGrJFMqNU5j91c6A9uPuGIxIkD251xoeD+ang5ocHWQekIWkxYGOupSNwHqH
X-Gm-Message-State: AOJu0YwEyfHcfb8SexSiv7K3pIqbUD4NDL5aQNqmRkA2LeNC/oQyZyqI
	cHVBHvN7VPJlWFHFzhSdbBQ+9gAQ6Ba/L5VpDMWQL77+5zmi3Yuqn6NJUNpNeBdGDxcbK/f5+ya
	RxxKEQDcGj0kgGUPbzukZYMIWHt8=
X-Google-Smtp-Source: AGHT+IGveC/J65PgWtnx+selqqsT+dy8tuTanqgztq6SLmxMWWHSinBBaF2mUzxy5QdluHtHp25UD+yBpLy4mHAP6qE=
X-Received: by 2002:a05:690c:6f85:b0:618:1ce6:b618 with SMTP id
 je5-20020a05690c6f8500b006181ce6b618mr10180692ywb.12.1713783882560; Mon, 22
 Apr 2024 04:04:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713509889.git.zhoubinbin@loongson.cn> <58c3a812746affb331147d0d9f2f5b8f62f120cf.1713509889.git.zhoubinbin@loongson.cn>
 <e2cd6b13-62ca-415a-a015-0bf30e77535c@linaro.org>
In-Reply-To: <e2cd6b13-62ca-415a-a015-0bf30e77535c@linaro.org>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Mon, 22 Apr 2024 19:04:31 +0800
Message-ID: <CAMpQs4JPuECothtpTgOQhKvttOcGQHQWeZ0TcZVdm8vf8EEcuQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] thermal: loongson2: Trivial code style adjustment
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongson-kernel@lists.loongnix.cn, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	Yinbo Zhu <zhuyinbo@loongson.cn>, WANG Xuerui <git@xen0n.name>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 5:44=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 20/04/2024 03:45, Binbin Zhou wrote:
> > Here are some minor code style adjustment. Such as fix whitespace code
> > style; align function call arguments to opening parenthesis, and add
> > devm_thermal_add_hwmon_sysfs() return value checking.
> >
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > Acked-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
>
> [ ... ]
>
> >       }
> >
> >       ret =3D devm_request_threaded_irq(dev, irq, NULL, loongson2_therm=
al_irq_thread,
> > -                     IRQF_ONESHOT, "loongson2_thermal", tzd);
> > +                                     IRQF_ONESHOT, "loongson2_thermal"=
, tzd);
> >       if (ret < 0)
> >               return dev_err_probe(dev, ret, "failed to request alarm i=
rq\n");
> >
> > -     devm_thermal_add_hwmon_sysfs(dev, tzd);
> > -
> > -     return 0;
> > +     return devm_thermal_add_hwmon_sysfs(dev, tzd);
>
> You may not want to do this change. If the devm_thermal_add_hwmon_sysfs
> function fails, that does not jeopardize the initialization of this drive=
r.
>
Hi Daniel:

Okay, it would seem to make more sense not to make the change.
I'll remove the change in the next version.

Thanks.
Binbin
>
> >   }
> >
> >   static const struct loongson2_thermal_chip_data loongson2_thermal_ls2=
k1000_data =3D {
> > @@ -167,4 +167,5 @@ static struct platform_driver loongson2_thermal_dri=
ver =3D {
> >   module_platform_driver(loongson2_thermal_driver);
> >
> >   MODULE_DESCRIPTION("Loongson2 thermal driver");
> > +MODULE_AUTHOR("Loongson Technology Corporation Limited");
> >   MODULE_LICENSE("GPL");
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>

