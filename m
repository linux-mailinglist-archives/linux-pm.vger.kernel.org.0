Return-Path: <linux-pm+bounces-17278-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 499EA9C31D3
	for <lists+linux-pm@lfdr.de>; Sun, 10 Nov 2024 12:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E5871C208E5
	for <lists+linux-pm@lfdr.de>; Sun, 10 Nov 2024 11:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0821B155C83;
	Sun, 10 Nov 2024 11:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5X/0ZOb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54825D2FA;
	Sun, 10 Nov 2024 11:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731238979; cv=none; b=s4oApTA43hyfuCD+zMwQkpcKfYduKKKtiYVnqIuzCj/osL1oYGk4H4XFQ1Q2wr7xbshnFFcY6oxirGXK3XbFNzWcVaAUhpe/6tO4WgFi/t8fveumvuqMwlb0LdnjcHQ0C1zYpXPS1fk3aeVIt01R8KThJeVK7HQzhc8bpRkGsVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731238979; c=relaxed/simple;
	bh=edHqBeuazC7savw2xRfuCinqUK1Wn7+euXOOOo70ubo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WmdObf8MrmkrazSztLIib69d4i8B8P6MnOTCVJRx1gAe+JFoeZpVfzzLxBzDRNLVuJT9olVXVFB8kxi01pfulgXWKCmnFtIUNzr8iwCL8pBTZ7s8NdhudAyAdhum/eFgvGZdfPa20Q1rsah33ILruZ8ceE3vcM23TiFKXa+UNWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5X/0ZOb; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c941623a5aso8215661a12.0;
        Sun, 10 Nov 2024 03:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731238975; x=1731843775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4kkuPDOO/3WKsglZ4wrSF/jnvWBXQ+SYAYfz/uqq4o=;
        b=O5X/0ZObosIOVlsNxacODHoRSouqwaei8jTInbo+rSp1xIFC1VGebtEo1slCvMJ2zC
         s82axNkuOg18aygaoRe6ao4EdiJy7JFH0KqhEzTmblYaGDLtYxWJICXwwM/bC/dkRcKx
         EHfQ0qUNYh1iKjrcwpmfqY4IGJbCHKVk0z7WFUq8Qo5wxDWLgVFQSA8tGsmSTMDxoKmB
         DszBBL+pmXVBzXMREX6Uhw7vfuKAStFGiWNxkUhz5lFbhUu9gL0rN6H8gfpqiShTrWii
         qYjOfOCf5zH9M2IhJmFBZhiuorMznNCXUPhgzdDYIHx61MOI8mivQbtphXEW05+HZcwb
         x/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731238975; x=1731843775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S4kkuPDOO/3WKsglZ4wrSF/jnvWBXQ+SYAYfz/uqq4o=;
        b=LZQunwUo2exCBtq/V8vceyHB27kwnK+dHmLTqQXvkYFMxPqjRdMCju59iZLMvHQkQL
         wmyTI228BTQ08TKzHEopIzzao2jh7xiiPs+aDKhIftZnagwsSPQ+h1Ur5fMB9MUHC4ks
         +HAo0KeAFoiC0eQSRfL92s70C9scNGCPQTddkMnYBAXsBSgbeqj8f4tXkNB4EH0yZoOn
         zZ9NV+YstGKSHVquPivGeRdbR81SmYIJK4C46z99E2gCY/xT3xiT5wxhLE54U1TlHUaD
         OwA05357G3KIW0GbH55SZAyjNGX8+7kF2/iJ/+hZxIP9oF5xXTbgpp4bIa8/i6VheiIJ
         tOAw==
X-Forwarded-Encrypted: i=1; AJvYcCUHMB96Y2bN40qgShwVsr6ScIoirBqfplShdzUpxMc6KNMnhKZWdPppcmtnMKdBzEIDOSjm8dhMYEiNhpzb4UjOCp/PKQ==@vger.kernel.org, AJvYcCXwC+QP1pM2rP6rdqce09ey5MlN08Rac/WEOvT73F3F3MqnhQzLGk4EMMy8nIaCnOAOUf6hPgk3DQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPV3CMz4k/EJ9TA7Zl+eYaawcPC9sP17CiCVmnpvdECa6VLWOK
	MtO0amf/U6eKvmzTTP4VOpvYAyWGe7kRSM8z1MM5QmfBlhjAndF+DmgWCdc58psHGr3w50yyD08
	hCXkvzUxNUxYDdV+n7UEZFgtP7Tw=
X-Google-Smtp-Source: AGHT+IHVFHhUUaLil21QTfeZfYcZ0hEZnph8wlttmquEGWl7OC5MSKnrl7EoNXEOAoPbeod2nYs7q9igchb3U5JnSds=
X-Received: by 2002:a17:906:4fd4:b0:a9e:e1a5:755f with SMTP id
 a640c23a62f3a-a9eec767f2emr893325066b.1.1731238975327; Sun, 10 Nov 2024
 03:42:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108232438.269156-1-hdegoede@redhat.com> <20241108232438.269156-2-hdegoede@redhat.com>
 <CAHp75VfxCEk1OhQZX8SEk8Enyf6mz1Tt0qxsTX9Xfouw8WOL-g@mail.gmail.com> <2ae4400b-fa14-4292-af41-9ad091a0c1ce@redhat.com>
In-Reply-To: <2ae4400b-fa14-4292-af41-9ad091a0c1ce@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 10 Nov 2024 13:42:18 +0200
Message-ID: <CAHp75VcwO7p--dvaJ5jcxT91qqBmWFcnnZM87Pk3Z5X6WP6TPg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] power: supply: power_supply_show_enum_with_available():
 Replace spaces with '_'
To: Hans de Goede <hdegoede@redhat.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Sebastian Reichel <sre@kernel.org>, platform-driver-x86@vger.kernel.org, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Jelle van der Waa <jelle@vdwaa.nl>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 9, 2024 at 12:52=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
> On 9-Nov-24 5:30 AM, Andy Shevchenko wrote:
> > On Sat, Nov 9, 2024 at 1:24=E2=80=AFAM Hans de Goede <hdegoede@redhat.c=
om> wrote:

...

> >> +static void power_supply_escape_spaces(const char *str, char *buf, si=
ze_t bufsize)
> >> +{
> >> +       strscpy(buf, str, bufsize);
> >> +       strreplace(buf, ' ', '_');
> >> +}
> >
> > The bufsize in all cases here is sizeof(buf), making the above to be a
> > macro we may switch to 2-argument strscpy(). FTR, it embeds the check
> > that buf is an array.
>
> I did think about this already, but using a macro makes this harder
> to read just to save 2 sizeof() calls. So I prefer doing things
> this way.

...

> >> +       char escaped_label[32];
> >
> > Even more, the but size seems also the same, can we have buf defined
> > inside the above?
>
> No not really, its address would need to be returned then, requiring
> it to be static, at which point we get race conditions when multiple
> threads use the same function at the same time.

I meant a macro case, but it's not a big deal after all. Perhaps we
can evolve a macro in the generic headers if there are enough users,
like
#define str_copy_and_replace(...) ...

--=20
With Best Regards,
Andy Shevchenko

