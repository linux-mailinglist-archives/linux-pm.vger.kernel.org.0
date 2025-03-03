Return-Path: <linux-pm+bounces-23309-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48160A4C246
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 14:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C679F3A501D
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 13:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CB7212B0A;
	Mon,  3 Mar 2025 13:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oum4DxEG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A71433AD;
	Mon,  3 Mar 2025 13:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741009476; cv=none; b=IBCk9FY4/EoZgwPJAAB9pWoLLIhHFulzGUhXiOoCmPPFPB16j+myJ9R+quADt0S9Y84tg/825xuMoNkDsYuHoJMqOh6STf+4VlqPcAFf5MJO0PLjxLe+1Uss6NQ/FJ3zpmjZXxDdE6JBLDxk044nVFG5X665gX1QV6ySMv7qUwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741009476; c=relaxed/simple;
	bh=jqfOiRqnAXplxdji1HrpGQSwrxDKjUaXrPc3szCmQa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LIr76QWXFHiKit6v1bGYlMjfBGmJkk3++j8r5NuoVjuVImSNkin9sFrgUa+g2UNp1s8v0BFKIkTQZdTjZPgyIJrLyVzDETCNznJKC+slwm9utI4GBZyBNB64PuG6xz6r4LivG4j+ZGiVPPca88JJMVj1ktFPvbFMwtAR7l6Ap/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oum4DxEG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60540C4CEE9;
	Mon,  3 Mar 2025 13:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741009475;
	bh=jqfOiRqnAXplxdji1HrpGQSwrxDKjUaXrPc3szCmQa0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oum4DxEGA23Ji3l9PGJoX+hetDFdP8pxRiw/01i3Pm7dAKdAV3GVqAgVjcFtZCKso
	 lIhbJe38IDq39u7PADiw+rISxbEZUl+X30lsE8fMUfpxpBw0MJIVuH6eMzzICUXVjP
	 +D5pQZ2BfeiCAKIrEH9aTOaon8qDJAycl7S69yhVoidDd3Ilxzf7HXlDyQkMJf3PQe
	 IO41crZ7BPtIey2Sm+nilftDdAZfMLoCAxMtRR5fMwRI0J5KpWnGoa0CDIu2KURclx
	 gQVL1yayPwsC+uwfbLjfpV5zVvLod47TPdbe55h9Y49ay6w7UpTRT6NeaEBI4l6nCu
	 sx5WNuJbtVIRA==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6001126782fso287415eaf.2;
        Mon, 03 Mar 2025 05:44:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV6S/+tfH/6a/PO3Sk0cxP9M2/yzHzd20yggzrIXaeC6gDOCc3F5/+3YpBtfBUEwpO9pP5Ml6rJ1KZ+PmL3@vger.kernel.org, AJvYcCVD3mGWdLBoK28yzkhQViKa/yvO3UulAI3EcS6iKtHeeR4WRYiDKh8/oIPfSYCzol/7B8xPglhQQzM=@vger.kernel.org, AJvYcCWIXk1ccEDMD/22Zgwb/EECika5MxT7bHOfQsxze4f/lW0XrXrpZgJ0N9tPHSleqr7jUmRK+cwAy1vhp2n3+04=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJTETqijOnjfojyMgOEM0CE/I37xiGsAdpD/bmNpKKElvcKLgl
	4SZjeH7jC8N4Y6RRCT5ydM2FBJxTOSy5oP1A3NRboymIUJ+xhmrb8ILit/4li+kQXfRmchQ/3En
	wjQkNBvYY93zFYUYjAbxkWE0bS8Y=
X-Google-Smtp-Source: AGHT+IHKNAsvrzUN5/D3Oec6lBmqniTtsZ1eC6Gc9PfhKYulRj8KWLyG0IpHqpe1LiC5jsXNbRAU3QgEieX1TzaEmQQ=
X-Received: by 2002:a05:6820:1690:b0:5fe:9dd0:b9f5 with SMTP id
 006d021491bc7-5feb35e7343mr8718596eaf.6.1741009474727; Mon, 03 Mar 2025
 05:44:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227224006.660164-1-colin.i.king@gmail.com>
In-Reply-To: <20250227224006.660164-1-colin.i.king@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 3 Mar 2025 14:44:22 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i7XyP6gRaSf60pzG2eSjFWVgMzhxkz-BVsGM8DzRT8LQ@mail.gmail.com>
X-Gm-Features: AQ5f1JqRSXd5ved2nOIwbYdoVZXe62gNWNwALmByeSCpjwB5ouH_k3yJmmh2NbU
Message-ID: <CAJZ5v0i7XyP6gRaSf60pzG2eSjFWVgMzhxkz-BVsGM8DzRT8LQ@mail.gmail.com>
Subject: Re: [PATCH][next] thermal: core: Fix spelling mistake "Occurences" -> "Occurrences"
To: Colin Ian King <colin.i.king@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 11:40=E2=80=AFPM Colin Ian King <colin.i.king@gmail=
.com> wrote:
>
> There is a spelling mistake in a seq_puts string. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/thermal/thermal_debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/thermal_debugfs.c b/drivers/thermal/thermal_=
debugfs.c
> index c800504c3cfe..0cf26ea63370 100644
> --- a/drivers/thermal/thermal_debugfs.c
> +++ b/drivers/thermal/thermal_debugfs.c
> @@ -319,7 +319,7 @@ static int cdev_tt_seq_show(struct seq_file *s, void =
*v)
>         int i =3D *(loff_t *)v;
>
>         if (!i)
> -               seq_puts(s, "Transition\tOccurences\n");
> +               seq_puts(s, "Transition\tOccurrences\n");
>
>         list_for_each_entry(entry, &transitions[i], node) {
>                 /*
> --

Applied as 6.15 material, thanks!

