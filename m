Return-Path: <linux-pm+bounces-27751-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2659AC6F62
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 19:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD99D4A5B2D
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 17:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6BF28DF21;
	Wed, 28 May 2025 17:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GykcIT1l"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4FF38B;
	Wed, 28 May 2025 17:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748453373; cv=none; b=McbOyQH37y2X4zTIAFsa1MYfN3vzBAC2xUnujNEP4h4ZFFfwPQKyujgiifHYcCii6WtMwk1S5+eJEQNeYTWJ8p2veZFp8x7eiFqsofwtQS2cJ9uugPFnWVIvAxOylvr7062HCzcPlBjrCBXWWL5QiksTwSsvGVhoncXomq57ajg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748453373; c=relaxed/simple;
	bh=73UTn5zY0Ma+9HSZwcpINlS8OsmErek97WGREM5hkbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CAgvWGm34vdCT4lX8tLbvf95KjcmTc3kKHgRV1CynLplBWZ0YBtx0W8gfCZF/OegoBmIgQ3nqK7ZynGR/UwiX5+f01WOdlD8cVDjpoCTNvfe8YwoQ6nbzlsZ4Swea6vrUVO6nnAHb8+Cm9OP4lrkqV+S7JdVEgJ0vZ3+48QILlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GykcIT1l; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54afb5fcebaso6114319e87.3;
        Wed, 28 May 2025 10:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748453369; x=1749058169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73UTn5zY0Ma+9HSZwcpINlS8OsmErek97WGREM5hkbg=;
        b=GykcIT1lvYeIzcUJaRqn91x3B1EdSAI5PMTv4si0q9pWATJvG/AcTnPt96hd2y28F6
         ZBO4UGxQtTxpLqzvkezCT3Zj+K1/WoU22YHsfYeR2Wen5on+bVrhl63HhQUlLH40OGzt
         Jgs2ddqmpyXv+ix8g/1JY14YfEp1OJycz8GhHmqNVN1JlFEz/1wNUjHyOE75BTUjHyQ3
         Se5hg4HUnGkpBY0GbwHkhhMiN+A2sWBOT2AWWTYpAHOFO6zOMx+51/Sav1830/IvpLMZ
         7q708FAM6GtF1iLwzLMWdOG/DUjkVyTiO4Tz6gP0q2WeKSJvevk7s4Q4uVuJLqN5ahkq
         fwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748453369; x=1749058169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=73UTn5zY0Ma+9HSZwcpINlS8OsmErek97WGREM5hkbg=;
        b=IpWmJlex4Di5uKWNgXcUNoTzdkbVPCHnv9Wm0vP2yUBh/TEDsU1geefqPQuLbTQ0Rk
         FYtC98g9a12oV0ehtew17hF5mWTlkHH7qXuiXAjBjHbhv6QBZsALMcDzyg1U1F+gKRnH
         rXu3eDls/GIKY7nEXrv9qdVoLj0kkzJYWZyuMAh+7NL+n5RqBkISPaYw+T4BmqHKC+d2
         /hi5FtEKu00c8YSLWVx21vVnv3nr77a7QN7MoZqtyyRPjptvrbsk9E8p6V/5tGeWrO0m
         Wa0htmQUDwY2+qjb8x3SGqFGIYwleP08Ir10lro7g76aC/KIizY0vW23quwuLDWPHmRF
         HllQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/pMiEaUJJY2wo3bpcLN1Xdy6BGWuy+4kS8CG8ztlXLX99vEya4ex02iNI5Q8ocBquxE3CJzNVqXeaLI8=@vger.kernel.org, AJvYcCWZc0reH1uBGhWVABLmPi9EWCjXCvO5XK/cpdfAyTphC0H3MsmCy/cXiiREe5NSA9RIKz6S+iaa5aU=@vger.kernel.org, AJvYcCXPFsCs3EDggjb9+3MGWwqKwa3Ek8iz05EUevxYEBPCP9aU9rk3HcIUqj+WrxGHeQ17ZR2cjGvKeba/NPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFCYsalcCHrNkoUtRQljy/xxEv2jzlcBcJ2J6IeTcyY04St1/g
	fzbLDRnhfBN1To4hvpx42KbyrNsX7usi0tHH2FRnCWIf04tdvfCx8ocajcep/ea4YzO1kN9ZTum
	WnviD+e5T2561ogMNpF8L7UpVpoOM2dk=
X-Gm-Gg: ASbGncth6OL+8BfZTDgmlhWbj3y56n+0dp+vyvtf+WPYMdYZNq2R1ED/MRYezH4Wigv
	51M68DnW6TnbUTmeFNr1yHTp8V7Zh0bH7SOJUbSq5FeQ0Qo3x48ns5KLqwU+xKHJew5vPZS7EJ5
	PGLruKcVrrU+2yOF+NMk/sJVurx5AMK9hl
X-Google-Smtp-Source: AGHT+IGeLxSaCCmOZYrOhpS4fQYrJKlAb1hOVaUvdIZMARS0JybXByMBW34nalQnpHzL7W3y9vXGkwkkk83WEtarRdA=
X-Received: by 2002:a05:6512:4152:b0:553:2357:288c with SMTP id
 2adb3069b0e04-5532357294emr3106825e87.17.1748453369179; Wed, 28 May 2025
 10:29:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508-tegra124-cpufreq-v4-0-d142bcbd0234@gmail.com>
 <20250508-tegra124-cpufreq-v4-1-d142bcbd0234@gmail.com> <040b0d8b-e862-48dd-9b77-9266a5194f99@nvidia.com>
 <20250519101725.k644wzizjwygtwa7@vireshk-i7> <49e7d006-e9cb-49da-a4cb-b73a08f6b792@nvidia.com>
 <20250520100218.te5i5ltrx43zjsq6@vireshk-i7>
In-Reply-To: <20250520100218.te5i5ltrx43zjsq6@vireshk-i7>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Wed, 28 May 2025 12:29:16 -0500
X-Gm-Features: AX0GCFuz-ai7H74ZpiHER5h5FZpctpdNrW6hh5LPSHxVFGPBRpq8sIb3pPiD9gQ
Message-ID: <CALHNRZ_NtdiOek_bEABYpkW+p=c2RgCC4o9EXmqmAkdv3o9i6A@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] cpufreq: tegra124: Remove use of disable_cpufreq
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jon Hunter <jonathanh@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 5:02=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> On 20-05-25, 10:53, Jon Hunter wrote:
> > I understand, but this seems odd. It would be odd that the device may j=
ust
> > disappear after resuming from suspend if it fails to resume. I have not=
 seen
> > this done for other drivers that fail to resume. Presumably this is not=
 the
> > only CPU Freq driver that could fail to resume either?
> >
> > It makes the code messy because now we have more than one place where t=
he
> > device could be unregistered.
>
> Fair enough.
>
> This driver, along with other cpufreq drivers, can fail at multiple
> places during suspend/resume (and other operations). If something goes
> wrong, we print an error to inform the user. Should we avoid doing
> anything else (like everyone else) ? i.e. Just remove the call to
> disable_cpufreq(), as all later calls will fail anyway.
>
> This is the only driver that behaves differently on failures.
>
> --
> viresh

Is there any consensus on the best way to handle this? I'd like to
keep the series moving.

Sincerely,
Aaron

