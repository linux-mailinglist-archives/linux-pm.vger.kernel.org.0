Return-Path: <linux-pm+bounces-24426-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6E6A6CA76
	for <lists+linux-pm@lfdr.de>; Sat, 22 Mar 2025 15:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58D2616CE4A
	for <lists+linux-pm@lfdr.de>; Sat, 22 Mar 2025 14:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF74722424D;
	Sat, 22 Mar 2025 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LtbQ2tGf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C19136E3F;
	Sat, 22 Mar 2025 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742652529; cv=none; b=ZNNbun64xPAWfz3Z7bwhdoGvsgZTNFlJcqtC3rjatv1pcxWiVmeq94z4Hd9oVHIg3vc3M2FimN/rY8ICv65mi8hEwRtelhW5+xZgKVDPOLj2886ZjkQc9N5LfIyPQYlDSTjRPOEbfLWA5UXbY3R3q/3sXCb39V09MF4K8MbVGGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742652529; c=relaxed/simple;
	bh=UPyBpCOWjm/FS1Xt3gE2s1PNYp+YG301nB1MfAKOL5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aA6GP7TVOcvVD73emBal1ltkmIxnYA/oEZjSDfOlfgk5ATRCHRJ65isgMbgAr0a24wGTBgS+a01cc4QnakEHUBCgKNJninXp5jIfXXcg07KWr+CzK55CX1w9jMHoikE+RUTwgZDL4nIhUS6A6Svsgt06Z03H/VJMxaZ58YdHMjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LtbQ2tGf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B5B1C4CEEF;
	Sat, 22 Mar 2025 14:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742652529;
	bh=UPyBpCOWjm/FS1Xt3gE2s1PNYp+YG301nB1MfAKOL5c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LtbQ2tGfS/qFX4RDMarzf6IaBFU5+4H4rKrRLtCsK7a3TMEE5mRCRwTn3ubnp4MLJ
	 gv07XjN+7N0usk6S15rV+GmWiIgp5dsA5+KF67LQcKYlMuGm923p9ZRYLYP83jebG2
	 O/jMvrwvzH7zKGLAreys/nNZ9p7xM5EQyowknbF6oXIVq9FQZ95KM5q9dETUx8C/N7
	 E9/toNs59qgdypXEkQilDeZ/A0ETv3KQZXYVZX9VgfOsJG9TTY9/+/CMx1AIUTPoQY
	 lBntJMyI5xxrsrm+SuOLf7rM897b2UIGbcM7zv+aM+FjVD3kFd8VgnQTqM3ufGEhxm
	 sPCAgmPFKPKVw==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2c239771aeaso1564282fac.0;
        Sat, 22 Mar 2025 07:08:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVNbRxWGgbB/B674Pprcg4AWm68EoPx0fn6Yk/qsrnhEbzd9MbbwGDJgz1Pcul31+AqL4ozTkPpsnOdmhWF@vger.kernel.org, AJvYcCXBdLkGlDyOu8/LnAJoS3x+A3u25AWjgcxLc/+lK/tCZ46hvbTm0HHym4EB5aOwzXmm+POBSVVc6V0=@vger.kernel.org, AJvYcCXp2TpccaEl1nhfkPkdxik9Fy966xffVblGiCxRNOJq6lczL9+Dqg8qT0f1L/7JWDJKeVhCryj2v7Q2seswo3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWMGmTUFs1fS6GMX4TKvHqdvdEjNdJoGwsNIxkQ4QJ5WkVhMEI
	zemIFYkwRvuqBqDqN5VhxlFRfs7NXNRviz3ycTtd5+BrH/Ju0RQeWg5vaI5yHz5rsTlDU2mT8dc
	bGMj/8rI/6TZved68pD7BUF6j5XI=
X-Google-Smtp-Source: AGHT+IES+M/gjJlLwL1WKnI+mUUdyNPBme5LxRjvL71HviRwsC4pon9Lk8wDI39I6mFqjecCjnMbVqB0GPd00BllLqE=
X-Received: by 2002:a05:6870:2102:b0:2c1:4090:9263 with SMTP id
 586e51a60fabf-2c78054a98dmr5431053fac.35.1742652528282; Sat, 22 Mar 2025
 07:08:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319114324.791829-1-colin.i.king@gmail.com>
In-Reply-To: <20250319114324.791829-1-colin.i.king@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 22 Mar 2025 15:08:28 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j6W5j=t7MrXhwNCpgyzSU6CWvwmMMqkrcvwtBJcvbKzw@mail.gmail.com>
X-Gm-Features: AQ5f1JogXZ8FhOFKdvPEe-JYR1bB-SdOrlk4tytB_UQTzadiW_CQulWHishPOe0
Message-ID: <CAJZ5v0j6W5j=t7MrXhwNCpgyzSU6CWvwmMMqkrcvwtBJcvbKzw@mail.gmail.com>
Subject: Re: [PATCH][next] PM: sleep: Fix bit masking operation
To: Colin Ian King <colin.i.king@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, 
	Pavel Machek <pavel@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	Ulf Hansson <ulf.hansson@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 12:44=E2=80=AFPM Colin Ian King <colin.i.king@gmail=
.com> wrote:
>
> The mask operation link->flags | DL_FLAG_PM_RUNTIME is always true which
> is incorrect. The mask operation should be using the bit-wise &
> operator. Fix this.
>
> Fixes: bca84a7b93fd ("PM: sleep: Use DPM_FLAG_SMART_SUSPEND conditionally=
")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/base/power/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index ad50018b8047..ac2a197c1234 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1836,7 +1836,7 @@ static bool device_prepare_smart_suspend(struct dev=
ice *dev)
>         idx =3D device_links_read_lock();
>
>         list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_nod=
e) {
> -               if (!(link->flags | DL_FLAG_PM_RUNTIME))
> +               if (!(link->flags & DL_FLAG_PM_RUNTIME))
>                         continue;
>
>                 if (!dev_pm_smart_suspend(link->supplier) &&
> --

Ouch, thanks for the fix!

Applied.

