Return-Path: <linux-pm+bounces-38644-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A48F2C8673E
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 19:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA97D3A5FF4
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 18:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1179132C935;
	Tue, 25 Nov 2025 18:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THOemkFO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC6032C33D
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 18:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764094020; cv=none; b=lzpnYbwVuL5dXZUIJCJagBUUEUbp6JNxUfJyTNQqLhORvI5wyeSso9PPnTjZcQFaPomLU6AV+sAWYk0nmS0KprvoVcVwv8FvUH8Ty4xvAM6TVunpPjfhsxiwpmayIPBh4J4TxgkiKz5norRrxaOLKTp2/Z/w7c4QMoY+O04m/x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764094020; c=relaxed/simple;
	bh=wVVXmxCtxZPfITAYNAxYJrAzpH9MdShk+g7iDx/06hE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sYH/u6VmqYUVrCAia8dmGjw8FGyskPtpsqELx2i6q2YJBmC57HK5RNLWz8wcMskY7vfpTFzWjbZqy0mFdsJ5DDESkVgXnQjZ7gTi7DcirZBZvNmHbY4P9F6drg9rDNq6o5U8YKEbNVAOsUiZXRJeB3ZwCb4Repu2xKNisNCmNIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THOemkFO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD9DC19421
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 18:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764094019;
	bh=wVVXmxCtxZPfITAYNAxYJrAzpH9MdShk+g7iDx/06hE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=THOemkFOS7v3qT+XvdDunrQQuPeJncxyRVGmEkqJ4KpOr1qr14Ul6Og6xnKm9LjVI
	 bKKrlB+dqg8Vt9FF5aFWKGjk3gkHGkejYM0THvtyYuAbD+GgwMHDxqWOdQF1WqOric
	 TT5V/lCZhUA2EKo7ueNikD03sgXEebKbLmYZm2ah5+Yt/yzKwC5DgF3SeRzipyFM3K
	 uw/LoOwY0aSV8ZKM7akHoOU4mmY0AqCnPfmKrts/zh2wTkvFjyKZZBpFcOtIL9vn13
	 i5SjSM2CleiWxK9gobHSVeiRtX41ZYMJR0IEDgV3E/WvJmg3sp6dxCUDZcd5bsAswV
	 waTXWS0JSa9aw==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-3ec4d494383so3523444fac.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 10:06:59 -0800 (PST)
X-Gm-Message-State: AOJu0YzmmsVBgmsyt+wrHjXuKURGX7ehJqvNLObl44pLRcXpHrtDKiWT
	PeggZqehrZAiHxfVAemuFmx9zYg93TZ/lWcU3gb0ShfF2uJcZqRBkyxYV4hk7fkV3pDm4bK1bFD
	U5OPQ7Ig89ECims3EalNbgFUhQCO2BM0=
X-Google-Smtp-Source: AGHT+IHVSTMIFTNBA+7RKqDbkrhoXb5+mkZ4SaeKiint86k7CMJcA3rObesggFBcRJsHZ2J1QQcOojy1Wb0IvRYHEsw=
X-Received: by 2002:a05:6808:2225:b0:450:5aa0:3681 with SMTP id
 5614622812f47-4514e5fa49bmr1699398b6e.4.1764094018877; Tue, 25 Nov 2025
 10:06:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113191609.28574-1-ehemily@amazon.de>
In-Reply-To: <20251113191609.28574-1-ehemily@amazon.de>
From: Len Brown <lenb@kernel.org>
Date: Tue, 25 Nov 2025 13:06:47 -0500
X-Gmail-Original-Message-ID: <CAJvTdKnXwkXKqsDOy+tFh=nq+JBw2vTN7sVSVVOh=1-6bDt9TA@mail.gmail.com>
X-Gm-Features: AWmQ_blS3Awm6I0102BpSdTYUl8xsalmAjuJpSElqIW4r8qgTPZzvH7hN8IcGGk
Message-ID: <CAJvTdKnXwkXKqsDOy+tFh=nq+JBw2vTN7sVSVVOh=1-6bDt9TA@mail.gmail.com>
Subject: Re: [PATCH 1/2] tools/power/turbostat: Set per_cpu_msr_sum to NULL
 after free
To: Emily Ehlert <ehemily@amazon.de>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Emily Ehlert <ehemily@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

applied, thanks!

On Thu, Nov 13, 2025 at 2:16=E2=80=AFPM Emily Ehlert <ehemily@amazon.de> wr=
ote:
>
> From: Emily Ehlert <ehemily@amazon.com>
>
> Set per_cpu_msr_sum to NULL after freeing it in the error path
> of msr_sum_record() to prevent potential use-after-free issues.
>
> Signed-off-by: Emily Ehlert <ehemily@amazon.com>
> ---
>  tools/power/x86/turbostat/turbostat.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turb=
ostat/turbostat.c
> index 72a280e7a9d5..9a2be201a3a6 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -6673,6 +6673,7 @@ void msr_sum_record(void)
>         timer_delete(timerid);
>  release_msr:
>         free(per_cpu_msr_sum);
> +       per_cpu_msr_sum =3D NULL;
>  }
>
>  /*
> --
> 2.47.3
>
>
>
>
> Amazon Web Services Development Center Germany GmbH
> Tamara-Danz-Str. 13
> 10243 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Christof Hellmis
> Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
> Sitz: Berlin
> Ust-ID: DE 365 538 597
>


--=20
Len Brown, Intel Open Source Technology Center

