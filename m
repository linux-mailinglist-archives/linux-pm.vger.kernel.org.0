Return-Path: <linux-pm+bounces-27201-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9603AB8996
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 16:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E59B4C0BA4
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 14:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2591E5B71;
	Thu, 15 May 2025 14:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZpSVj3+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24171A0B08;
	Thu, 15 May 2025 14:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747319943; cv=none; b=ZZUOWhdrzkoSZbbhVdx060nHuEveDxxs7mHw4Iv9aSbRsIHBw0xbcRatpUwpp4z2qyurirt+tRSz9SL5wrxcnMCAC3mUvXkt+HribhqZHbWUxgFbfzDisIHiv7u+J0XG5JyH9rS0DFa3tDf3qw4aHhJdDGsEekbSWP9/s8D1FHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747319943; c=relaxed/simple;
	bh=8HdHeR5svw2nUYbwNcqVtEE5lNBi5P5E/RkmrTDiKg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AqbRBWJHZy4eIZmb69Iqf9pa9IKjEWWJqAjgpgG8MZcxf0SfZEarMtWmybH0CPO0klc0F26Sts9JesIRm71JKQiVVyx+tXNYZfZHYnqmqmYGVeHRxojw0OqMG5bydyOKgZx9lyRv45ei94ef0fiyeJYKBRTh3HxsgMhP1JVxMFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZpSVj3+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0EDC4CEF0;
	Thu, 15 May 2025 14:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747319943;
	bh=8HdHeR5svw2nUYbwNcqVtEE5lNBi5P5E/RkmrTDiKg8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eZpSVj3+2HBZVDbCSL+iYHVv3uYkuOVcuExv2cD69mEl92imlawReF2S2Jop1P2hC
	 I7Bxk+G1qFPR/wDxfZfbwiJ40R8Jv7EQCWg/GFJDM8NB8oHNJuf54bynkftN6U++x6
	 PGwGZavXXb3KCYocheOwj2H1KBBwhC8PgNNMADFPM9EQ0SXZJrGXpNsn/09/A0dXO2
	 lw7IUFGdwPtrKm1ynPg1dknrs4dKV+3Lqk+VCV/J4Y4r80LX0i5Hd+iq5iBFGkA6/q
	 IYX/H558qLf3YSkXc4r3zT8JyEWvS9xFPXEspefnYHGdDjT4bSB4wJ0OB2OEufnzTk
	 W3lX7LT0xbKlg==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-60402c94319so734778eaf.1;
        Thu, 15 May 2025 07:39:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWkMpOtprVc0ihV/OR8H3gEnRjf0bR4ttkK3Zf89AepCPMXtQBLqHeN96HAKT+FFA0tnL752U4mDOBDDBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfvNsbWL9yw48KLz8g5A1hEErU+xI0412UL2BQeTOFlT7oUuRi
	Nfw9pF0TGg7txRvpADMzjUpDa77St/oGCR3HPD4xtXtrNBavO3IOGTWXXR2Be8L294RtDVRnJDf
	CPnNXiZN7OhEP+hFAvboy0Y9fg6s=
X-Google-Smtp-Source: AGHT+IEhDUauHair1atNRWVPxkYGy3fD9e9nNUADIDmdFiE9TEaCAIXaHatxtZWiPgGEU72oC8vGfEHYSV0tjXlKNpg=
X-Received: by 2002:a05:6820:4cca:b0:606:462:5d1a with SMTP id
 006d021491bc7-609df158b5amr3851174eaf.2.1747319942698; Thu, 15 May 2025
 07:39:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515143100.17849-1-chanwoo@kernel.org>
In-Reply-To: <20250515143100.17849-1-chanwoo@kernel.org>
From: Chanwoo Choi <chanwoo@kernel.org>
Date: Thu, 15 May 2025 23:38:25 +0900
X-Gmail-Original-Message-ID: <CAGTfZH3pmi_466aEMBeskZBc9-m2tqk3Tg=Zt6GxZO1R3jTAYg@mail.gmail.com>
X-Gm-Features: AX0GCFseTeEF_xNY1-AmUcOrYcGAVTYS3elXTQhk8Y7Pdg5BMbjUJ1UVeutbtcs
Message-ID: <CAGTfZH3pmi_466aEMBeskZBc9-m2tqk3Tg=Zt6GxZO1R3jTAYg@mail.gmail.com>
Subject: Re: [PATCH] PM / devfreq: Fix a index typo in trans_stat
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: cw00.choi@samsung.com, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, 
	pls <pleasurefish@126.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied it.

On Thu, May 15, 2025 at 11:31=E2=80=AFPM <chanwoo@kernel.org> wrote:
>
> From: Chanwoo Choi <cw00.choi@samsung.com>
>
> Fixes: 4920ee6dcfaf ("PM / devfreq: Convert to use sysfs_emit_at() API")
> Signed-off-by: pls <pleasurefish@126.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 46f3a8053197..c5f5960e643b 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -1733,7 +1733,7 @@ static ssize_t trans_stat_show(struct device *dev,
>         for (i =3D 0; i < max_state; i++) {
>                 if (len >=3D PAGE_SIZE - 1)
>                         break;
> -               if (df->freq_table[2] =3D=3D df->previous_freq)
> +               if (df->freq_table[i] =3D=3D df->previous_freq)
>                         len +=3D sysfs_emit_at(buf, len, "*");
>                 else
>                         len +=3D sysfs_emit_at(buf, len, " ");
> --
> 2.25.1
>
>


--=20
Best Regards,
Chanwoo Choi
Samsung Electronics

