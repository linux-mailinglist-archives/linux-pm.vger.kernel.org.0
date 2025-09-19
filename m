Return-Path: <linux-pm+bounces-35079-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C55DB8B502
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 23:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 656F51C8299B
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 21:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B99283FE6;
	Fri, 19 Sep 2025 21:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkPkluym"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D8A35942
	for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 21:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758316718; cv=none; b=Akz2yBeAXZIB9mY0L4ltH57ba4wOy1gfjP2RZZ0nA8GMdlAijQvehIwtT2oPuL3PIuma9uRIxwR7JPPWaTd3kCb1QMzkhbFAvhrtlMZltO5vntX9pmfujklulQZ+mXDvmheAbP7s4O6AJpE1N1X+q8I2P3Ili0wZIaaxoJ1XGJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758316718; c=relaxed/simple;
	bh=VWhVVsKPXQmKSTE/YpJOpJ4/wxJWWS1WWkQWAjV/pgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BUBx2eSPzLXsjwFJivsWeNaN8t1DOLn5aQCGL6YebD9KUWz+dcwoWcHhw+XkDQ82Gw5htd/h4TLvWlZZ6WFdp1hq+njkguwFgzY9F12hA5WGPyM9OhzUt/zOdEk4RFRA5ThYnUMWEsZWCGPEyZWz9jA5ERQAoTT1nyxImrQyfGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkPkluym; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6E2C4CEFD
	for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 21:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758316718;
	bh=VWhVVsKPXQmKSTE/YpJOpJ4/wxJWWS1WWkQWAjV/pgQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XkPkluymf4/RnWnwk4NluJMKaeo32Zahupxjh5qWxznfhVhbsaJunCTW+FJABvEZh
	 t4GBlV75jUUvrQV/Mh8WAZ+MkAzlgViyI/TmAgiq1yhCeHaP9DoIy+gOL21wBCHJOa
	 rhJHrfiQI0docUehM0+yCUq+FmmsnnJu7bqlh+omUtQIjJ6pWSbExz9Gnv0lPNB/UX
	 nGxkVO0RRgVn4TMenpbeIyZNN9yx/uJdTaak1xvMfZ6PWj8cEafe+OWu3suZDYdvkv
	 baOEOOb9gOlvQM8DuihsVG4L0FH5Yef3mVOaoEKgn8OTXI/rKca8wkN0vfKFH/q/Up
	 bmvpIG96xRpbQ==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-31d75b4d485so1472476fac.0
        for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 14:18:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVb+Xuq7TETRro82HU0xYVexO5i8rf65/EJJW/U0/i6vx+ruB1QaGZlSXwjR4WtUEZy6712pAd5qg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvU3D2XyFNtIzsNp6G8dFmjY0Bm8ImBo0yqGOXM71Goan/rR7Q
	UXdh3NTK7N2lathrXPuiEiqMMJjyuA1b41kgbrm71hUEiJPMAJu6bUPM9Ika3tq7U6j8k0x5pTH
	PMJOcI/iRFIIu6uoF4avzJdTOctbOVQw=
X-Google-Smtp-Source: AGHT+IHOcRkStXEvU/UDmJJ0KW1jphVIgoFFDb68U8uwojftCCW7Ubd8b32AMvWaONyE5WoAyPpMPTJOMCuyqXnRUJU=
X-Received: by 2002:a05:6808:11cd:b0:43d:2454:b69f with SMTP id
 5614622812f47-43d6c115e33mr2383359b6e.10.1758316717432; Fri, 19 Sep 2025
 14:18:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915070250.416423-1-zhangzihuan@kylinos.cn>
In-Reply-To: <20250915070250.416423-1-zhangzihuan@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 19 Sep 2025 23:18:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i4V=ayEXRfJXduR-15jvVHgP_Cmc80WfhQoDv7N5xGjw@mail.gmail.com>
X-Gm-Features: AS18NWCv7xrYZHNlJnFt8d_URS0ZeCcGF5OtJtum09A_RS7WmlieUWXU1zfkwx4
Message-ID: <CAJZ5v0i4V=ayEXRfJXduR-15jvVHgP_Cmc80WfhQoDv7N5xGjw@mail.gmail.com>
Subject: Re: [PATCH v1] cpufreq: Replace pointer subtraction with iteration macros
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J . wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

In the subject, this is just one macro, not multiple macros.

On Mon, Sep 15, 2025 at 9:03=E2=80=AFAM Zihuan Zhang <zhangzihuan@kylinos.c=
n> wrote:
>
> The cpufreq documentation suggests avoiding direct pointer
> subtraction when working with entries in driver_freq_table, as
> it is relatively costly. Instead, the recommended approach is
> to use the provided iteration macros:
>
>   - cpufreq_for_each_valid_entry_idx()
>
> Update freq_table.c accordingly to replace pointer difference
> calculations with the proper macros.

And here too.

> This improves code clarity
> and follows the established cpufreq coding style.
>
> No functional change intended.
>
> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
> ---
>  drivers/cpufreq/freq_table.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> index d5111ee56e38..ca06a0236e70 100644
> --- a/drivers/cpufreq/freq_table.c
> +++ b/drivers/cpufreq/freq_table.c
> @@ -33,16 +33,17 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_po=
licy *policy)
>         struct cpufreq_frequency_table *pos, *table =3D policy->freq_tabl=
e;
>         unsigned int min_freq =3D ~0;
>         unsigned int max_freq =3D 0;
> +       unsigned int i =3D 0;

This initialization isn't necessary because
cpufreq_for_each_valid_entry_idx() will initialize i to 0 to start
with AFAICS.

>         unsigned int freq;
>
> -       cpufreq_for_each_valid_entry(pos, table) {
> +       cpufreq_for_each_valid_entry_idx(pos, table, i) {
>                 freq =3D pos->frequency;
>
>                 if ((!cpufreq_boost_enabled() || !policy->boost_enabled)
>                     && (pos->flags & CPUFREQ_BOOST_FREQ))
>                         continue;
>
> -               pr_debug("table entry %u: %u kHz\n", (int)(pos - table), =
freq);
> +               pr_debug("table entry %u: %u kHz\n", i, freq);
>                 if (freq < min_freq)
>                         min_freq =3D freq;
>                 if (freq > max_freq)
> --
> 2.25.1
>

