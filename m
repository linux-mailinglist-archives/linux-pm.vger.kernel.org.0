Return-Path: <linux-pm+bounces-29989-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B221AF61D8
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 20:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79AA84E755E
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 18:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780142BE636;
	Wed,  2 Jul 2025 18:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+BdkLx4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5126E2BE626;
	Wed,  2 Jul 2025 18:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751482325; cv=none; b=mAtVuAjGIDvNdePe1bqY9HgpuBzZMDcqIpEF2X+dZrMOjwRQoB8HCYWPqoBpU6cwvQJuYVeQoUswQSCa/7dG9+2GmznPodb4eWovrv1sH7Zhhf5s9J1z4wZTASXtpxfLBuR/uL4E67irgH1onIMdfovEoZgAe+lem4UQuQ0X3GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751482325; c=relaxed/simple;
	bh=Tr/jSXt2sR6pI5xPiIGtAmoJPkl4Wo3HBvqjjFVXZfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SIX/IvCbauxVy9s5kz1lmZUOWIYs2LmgxFP/4Pz6dcSz19Lu05LuM3fS5PNZxQDFJfFBMvzaZ2ynydcB/2w/2H8l7MRSEghN6BUpm289RnpDzjI12M2GjB4thP9nBtGMzvRMIcxYXJ4+jb8030hZG/aRrmZJqzc+no9T1LHwOV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+BdkLx4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A46C4CEF1;
	Wed,  2 Jul 2025 18:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751482324;
	bh=Tr/jSXt2sR6pI5xPiIGtAmoJPkl4Wo3HBvqjjFVXZfQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M+BdkLx4YPOcgIaiuCVDnMOBOMAs/aCYb82Lj+MpStd0wBlQ3qxzDg99aEu7RmYsy
	 OzXtU/jgkgP4AKqA6iw2WBBlJKeE5F6QlVO9uU6d/wrPhDUbfisxobQ7KGqWOviAoq
	 XflmtdRDoWmOWdEMqO8mX9C4u+7RmFUuiI/jHipcs4GnznpOIoVxz7r68uMMCGJR+D
	 D8SiU10aXFxeoYPlFNRMbb5HUkwOtJSsQh1wchcUrPDE37bF0ueHur5nNQ+YOyOe18
	 XsdBAcoNevCYKrwCcy2FEhv8b/ptCl7MQLYGlLq8Y70ljDONAs6edt9TcrR1ppkNzD
	 8uyiOVU09NOMw==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6119b103132so154906eaf.1;
        Wed, 02 Jul 2025 11:52:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVqbLztcohxjXI4AMU7XwHfNo3SQ4FAwDyblIx3b9U75dmXYDyawsEh/rZuI/zTxKL15vmY4PMujvlD20Q=@vger.kernel.org, AJvYcCX6+pDwWPxRB+4NsCeRE51ivHLck9n2FgPbRueP+maOnYuiw/jV9ON/NJ5TkICsh/1TYiVBmDpkbBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCDygjqyRMZilSxD2Fp616vXrV5Tvu+XIXkE8DMWRs6ey/GqhA
	tP3Xqe7YtBNyU8iHpPPOQ1Xu2ERGfoBwH3ldiJeLCTWbXLwKFSpn5AWMrVXVsdaAgDFdou3+ojt
	srAWiOqA+3AcbrhnQ772FYYN/8vSBwhg=
X-Google-Smtp-Source: AGHT+IHOMCJ8yeX1yw8ax6BvbRw3cnCHOoxVsmjjHb+MatlzhLVOWeGSgmW8oA7g4HuSXgc5iHRb2RrrWCm0EyUYu0U=
X-Received: by 2002:a05:6820:1996:b0:611:a5f4:42c0 with SMTP id
 006d021491bc7-6137e88b272mr531992eaf.2.1751482323932; Wed, 02 Jul 2025
 11:52:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530100036.11954-1-zhangzihuan@kylinos.cn>
In-Reply-To: <20250530100036.11954-1-zhangzihuan@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 2 Jul 2025 20:51:52 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h1xAx7HRRgH_7=D8U71j3yU1qji_5vYyt0ym+Hnrne6g@mail.gmail.com>
X-Gm-Features: Ac12FXwke7zsok5_lzNB9WRmt9X-rHv5pRzyuLS3JSRQQeV1Gyp9a_hxRVbSC2A
Message-ID: <CAJZ5v0h1xAx7HRRgH_7=D8U71j3yU1qji_5vYyt0ym+Hnrne6g@mail.gmail.com>
Subject: Re: [PATCH v1] PM: hibernate: Avoid redundant resume_device
 assignment in resume_store()
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: rafael@kernel.org, pavel@kernel.org, len.brown@intel.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 12:00=E2=80=AFPM Zihuan Zhang <zhangzihuan@kylinos.=
cn> wrote:
>
> In resume_store(), if the device number written to /sys/power/resume
> is the same as the current swsusp_resume_device, we can skip reassignment=
.
> This avoids unnecessary locking and improves efficiency slightly.
>
> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
> ---
>  kernel/power/hibernate.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 519fb09de5e0..504a1c2465ce 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -1291,6 +1291,9 @@ static ssize_t resume_store(struct kobject *kobj, s=
truct kobj_attribute *attr,
>         if (error)
>                 return error;
>
> +       if (dev =3D=3D swsusp_resume_device)
> +               return n;
> +

The main purpose of this function is to run software_resume(), not to
set swsusp_resume_device.  You're breaking it with this change.

>         sleep_flags =3D lock_system_sleep();
>         swsusp_resume_device =3D dev;
>         unlock_system_sleep(sleep_flags);
> --
> 2.25.1
>

