Return-Path: <linux-pm+bounces-12711-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1B595B23A
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 11:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B3FC28639A
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 09:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384D1189F20;
	Thu, 22 Aug 2024 09:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HU95Pd/v"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1179A189BBF;
	Thu, 22 Aug 2024 09:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724319812; cv=none; b=o4sth4CcTbCiGsan7W8me29gQ6Yv1AGIfQQtz0xfnfXkJ5+fJNxNPypYrai/QLed7ENW52dbzAZqLSUq0LrpnaBzRq6N5EuxsQyM5B7tagLMTwSMgUoUJmSGNi0obGCMksEE5DajqC3hUKgbCO09/Lsjc6/2Z5vsf5hVLevT3ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724319812; c=relaxed/simple;
	bh=F7BUekgpSBz/vqVm7E/ihOaYYuVE6h06fv6UgNcQzaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eexSkxvR+kmTMkGlK3Gr3VoAi72HM93a8uc9Jaur7Q/zvsLz8jbZNGc8JV6I0LX8Yav1D48G9z3F7mIgG93A9SSP0OGxgitbvQw3SC/E4iJ2rqRXjAnVQE8SMwy7NqgBaS+XCmmZtShJbhKzd+4Gp0mqg8pHxR43nWLJyn3vI/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HU95Pd/v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0CDC4AF0B;
	Thu, 22 Aug 2024 09:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724319811;
	bh=F7BUekgpSBz/vqVm7E/ihOaYYuVE6h06fv6UgNcQzaw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HU95Pd/v0cv35pX8cVCMuZsYIAEygDKAzGPsXkpgHQ7S8J+wATftssj73mqUW/3A6
	 4p1X1xoofnNMmW531U1viGPGgKuuLNJ/4Vn/fmCaaGK/lPvJJ/r3GACksA1p9wemJR
	 mbhUI6so9As/Z/FnHAOr+CoZBYz6maPGvKrb8ddsvt6L24sZIIzS1zIJDJBIgfqboG
	 wi6gJyeeS5EadFHujLZ7jCDZMrd6lE/IgLgh98wLuxJMtgkv2Q4pf4vcxvkuwvAM8Z
	 lNjewUxc2oLcD1PiJ8k6nBJPsz+MkWJVjALMIObiPKBTBdSid9umW9C0J4fpUou7hq
	 fOpSEQJDGNC7Q==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-27028b2cf22so248162fac.1;
        Thu, 22 Aug 2024 02:43:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUEbMGsHijNAWzjYiz93GjjgbC5cxoxE1yfKmXH8xx20LI5AH5sYg960iAnOUYxCLmJamDA1iuRc90=@vger.kernel.org, AJvYcCWb1nVrCRzatt2p3LvMhovheTmvZUKAyrgtaSWK4fesE0s3Ed1d0ChetwLX6DVJgpLy4ZOpcaI8yeS04Tg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9TEtOwNce/M7qSJNNa7M22MCM4lOEVVd3QXe++IYucmgSRI6C
	IVzedfsBS7vgcCed6o7DW/ks+bPWgC1oQyb0U9nWN6AHhdpzMh4A94gKQyNpW9AAsPMY9xJoyLh
	9nQhXpzZCttSeefdF+SykyWXr8bA=
X-Google-Smtp-Source: AGHT+IG+OvYekMcBSrw29waillvHKP4F/lCraJ7EtDkhEiD/cMZ3SblaK6dpDvRVsqqiu/1MIpMGTpS9mRC2A8icwGM=
X-Received: by 2002:a05:6871:146:b0:268:a1e0:79db with SMTP id
 586e51a60fabf-273c8dd3b6dmr813230fac.14.1724319811080; Thu, 22 Aug 2024
 02:43:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822025931.3455-1-11162571@vivo.com>
In-Reply-To: <20240822025931.3455-1-11162571@vivo.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Aug 2024 11:43:19 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jq_2RoH8qJjKn3UUxLgNn4o4RqB=cfnT_pEFqtcMDdsw@mail.gmail.com>
Message-ID: <CAJZ5v0jq_2RoH8qJjKn3UUxLgNn4o4RqB=cfnT_pEFqtcMDdsw@mail.gmail.com>
Subject: Re: [PATCH v1] drivers:testing:Fix the NULL vs IS_ERR() bug for debugfs_create_dir()
To: Yang Ruibin <11162571@vivo.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 4:59=E2=80=AFAM Yang Ruibin <11162571@vivo.com> wro=
te:
>
> The debugfs_create_dir() function returns error pointers.
> It never returns NULL. So use IS_ERR() to check it.
>
> Signed-off-by: Yang Ruibin <11162571@vivo.com>
> ---
>  drivers/thermal/testing/zone.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/testing/zone.c b/drivers/thermal/testing/zon=
e.c
> index fcee12b152da..26f0f80a6a5d 100644
> --- a/drivers/thermal/testing/zone.c
> +++ b/drivers/thermal/testing/zone.c
> @@ -167,7 +167,7 @@ static void tt_add_tz_work_fn(struct work_struct *wor=
k)
>
>         snprintf(f_name, TT_MAX_FILE_NAME_LENGTH, "tz%d", tt_zone->id);
>         tt_zone->d_tt_zone =3D debugfs_create_dir(f_name, d_testing);
> -       if (!tt_zone->d_tt_zone) {
> +       if (IS_ERR(tt_zone->d_tt_zone)) {
>                 tt_zone_free(tt_zone);
>                 return;
>         }
> --

Thanks for catching this, but I'll just redo the patch while it is still fr=
esh.

