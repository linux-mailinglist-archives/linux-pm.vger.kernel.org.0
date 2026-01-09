Return-Path: <linux-pm+bounces-40576-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 129FFD0C37D
	for <lists+linux-pm@lfdr.de>; Fri, 09 Jan 2026 21:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A469E3016367
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jan 2026 20:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC2A2BE655;
	Fri,  9 Jan 2026 20:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQRdFgfK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B840729BD95
	for <linux-pm@vger.kernel.org>; Fri,  9 Jan 2026 20:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767992059; cv=none; b=MxQpohEVAvjKTcjchrY4RoaMBW6coYxBLOTRoWRljtJVQxT/aPy4v/CefXwirUsWn0hLDuMNGvoTDPmwaILVfeQcHPQm47EOIEuE3c0zsi4DcS1Co97WkgrdKTRbE9zMNg/wzbxCELARHeRHgz5seyaLLNIZIIgkaQaonpY/5G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767992059; c=relaxed/simple;
	bh=gw3bfShxoWnzan+sPdo1g+W62tWHdKkWDOx20qUStQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fq277h4TyaAwlnV7uBti9ZNrwkQql8Z2q4lyAR2xJ4avnNLIY2EaqNy6CNwkFciU0OZMzTbJf6L1Xovf7cjkY1UuxSx8BwCiObzVgkHIhPcwOaDIm/NjvWwUyNHLoJhZZsJvviswIWUPqrCBYTqjWycVAp6K25XugKgNpaklXUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQRdFgfK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE75C19423
	for <linux-pm@vger.kernel.org>; Fri,  9 Jan 2026 20:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767992059;
	bh=gw3bfShxoWnzan+sPdo1g+W62tWHdKkWDOx20qUStQs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AQRdFgfKn5Jph3mByonZ1vOcqMjMYupo09ACGw2E1lHsuL5Wh6SFQWcahP2qRSdTf
	 yTtogBdzx70GlNgmmPFqqDyqEHwWNp6yaGKlxa0T5Of+lHKOMWsi8IOX1B2PGsNcmW
	 FcpMBgqw1DA5nFgeb+jhhfBltQzzJcJ+OVGQiybX4MU5qv89Z4KYFgzxYwx3bH5xPi
	 cYq6B3cq9JNcNiNpwlgLS3Vkav6CG0gXnTJ3cuwChIk+oUiQGpmr685HxkFInBXmZo
	 8TnPmZcrlaLBdyKDqIgy5KJygNFLB2Vuz+otjkMTuezn16xYE29wOh4xESiWAyWo5q
	 epIHla+N8Vk/A==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-3fa11ba9ed5so3337047fac.0
        for <linux-pm@vger.kernel.org>; Fri, 09 Jan 2026 12:54:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW0uYZKd2bjHxwL4X+rPDOe/ESj219FtDmpaFnB072PfSpcoamgcdNQOCd2V4yo56lN+io5krIf5w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxac0Tra7d9ICePQtSIiUsmllWMNon4GhfSqeEKQTOwutKTJnqz
	SM4xp0KGfnXqvdrlCQ2QiyYaMW0hhlP44/PDLJ5nJZkb9F8qHUzbZNLaoPdhYcm7vDGAfb18Drx
	brWC+c1Ymo9jnQxx/ChvvSfOKS+fHAXw=
X-Google-Smtp-Source: AGHT+IH/294bpsC9Lq1PdpN77JFT03sHqX7BdkZB6DnkpML6K8tYbdVNQUtTTXoZfUopOcgGYZJojfEs9gppEp0UcMU=
X-Received: by 2002:a05:6870:e0d1:b0:3e8:98d7:72e5 with SMTP id
 586e51a60fabf-3ffc0bd60d8mr6505103fac.46.1767992058706; Fri, 09 Jan 2026
 12:54:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105-annotated_idle-v1-1-10ddf0771b58@debian.org>
In-Reply-To: <20260105-annotated_idle-v1-1-10ddf0771b58@debian.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 9 Jan 2026 21:54:07 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h2iu9V4DiW8XSmEykw-w7dowdc_=4H2w6OrbBYn1wRWQ@mail.gmail.com>
X-Gm-Features: AQt7F2oNCztb4pJCIl6dZpdFcw46RcyHGtkOYy0AdozQVMS11nLXzppvanugauk
Message-ID: <CAJZ5v0h2iu9V4DiW8XSmEykw-w7dowdc_=4H2w6OrbBYn1wRWQ@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: menu: Remove incorrect unlikely() annotation
To: Breno Leitao <leitao@debian.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 3:38=E2=80=AFPM Breno Leitao <leitao@debian.org> wro=
te:
>
> The unlikely() annotation on the early-return condition in menu_select()
> is incorrect on systems with only one idle state (e.g., ARM64 servers
> with a single ACPI LPI state). Branch profiling shows 100% misprediction
> on such systems since drv->state_count <=3D 1 is always true.
>
> On platforms where only state0 is available, this path is the common
> case, not an unlikely edge case. Remove the misleading annotation to
> let the branch predictor learn the actual behavior.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/cpuidle/governors/menu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors=
/menu.c
> index 64d6f7a1c776..ef9c5a84643e 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -271,7 +271,7 @@ static int menu_select(struct cpuidle_driver *drv, st=
ruct cpuidle_device *dev,
>                 data->bucket =3D BUCKETS - 1;
>         }
>
> -       if (unlikely(drv->state_count <=3D 1 || latency_req =3D=3D 0) ||
> +       if (drv->state_count <=3D 1 || latency_req =3D=3D 0 ||
>             ((data->next_timer_ns < drv->states[1].target_residency_ns ||
>               latency_req < drv->states[1].exit_latency_ns) &&
>              !dev->states_usage[0].disable)) {
>
> ---

Applied as 6.20 material, thanks!

