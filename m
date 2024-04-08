Return-Path: <linux-pm+bounces-6059-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A03A89C7D4
	for <lists+linux-pm@lfdr.de>; Mon,  8 Apr 2024 17:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA94528467D
	for <lists+linux-pm@lfdr.de>; Mon,  8 Apr 2024 15:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D1613F421;
	Mon,  8 Apr 2024 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4oRDvXD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE6C1E4AF
	for <linux-pm@vger.kernel.org>; Mon,  8 Apr 2024 15:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712588993; cv=none; b=gvBNflyaRMU7kPSbPJT/AuxbORKOB2jikAf2Lzf32mxx2BwvMRO2Kq6ejo2NIRZVEBMp9CKzYkb3Rdv4GxK9h1TRUIUA2mL9vLDpEl+ZOJrNLk+KZM9KCTdHCKNYuMjnMJQOR7TC3s80y0cscY7aOvPqJjJ+Z5KoMomhnh2lO8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712588993; c=relaxed/simple;
	bh=hJKYlVdf/q/VjMZd1nMh+Q3xNnPz7wn88AsUlxAwrTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LM7qXurKxms3v59dkL8nnyKLYrdgYrwoDKd9RUUU76/3hKBf2PUacy7dmbojBN32vJTaAQKHlct8DqkW39E8pMLNBApiXdsBI2mqDag8CQxP1oB47+2u8DcaCQT/SfsE5HfbfeJSLHl61tHNBWYe8YCH8M1dofnGBvhDn6ax1vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4oRDvXD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12C7C433C7
	for <linux-pm@vger.kernel.org>; Mon,  8 Apr 2024 15:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712588992;
	bh=hJKYlVdf/q/VjMZd1nMh+Q3xNnPz7wn88AsUlxAwrTY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=i4oRDvXDJcPww9y2vY9mSNfP8uOXQjI6q/piWS2plAY69KaZBhQwB3bIPlnI3NzSU
	 ePEiDVfXgdiLf3QMoyPvDa2fE+jQDOvmzqmeYaUGXPPxJCTBd+bxhvuVoRQAROlQAX
	 +2dhNxdJdaRpzkfJJTCwaNjgqOx9dJ27gMSoRZ+qxjt2+DKze09GcwjutDFUW/GVgf
	 5E1gq6GcSoh8aHsycQ6cKgxKmboRaE3GPt5UV2TeqfWJvY2o1enouroDAGNNnEy7fT
	 4jrJ+UBe736EUqkdfYNkD9zwyGSHTvhg2LURiveyxH7hm6JmmyC8r6BdGzzdxAZs+D
	 1tAnp7QtHKLMA==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-22ea60e145dso33433fac.0
        for <linux-pm@vger.kernel.org>; Mon, 08 Apr 2024 08:09:52 -0700 (PDT)
X-Gm-Message-State: AOJu0YzUkQC7MfCGxT7N1Rs6UvYcKszm+dxSwkJ8t9n/iEjh7GOG9FHh
	XlWh6xFsQVELD7qpXe4IU7zelCdW7arEWZlrvhByYSw3arfS45wOtScOzCN8PRhEsQxCQzKs+fM
	hakduWfeXEY6BOp7HYQq4xOmJfG0=
X-Google-Smtp-Source: AGHT+IEyp4wCCYLyMhBVkIeUbB9PQn6s2tPCaPPAnudG1QZmbM3xQx79lZVoKXRUcuQaGD4DsYRuNAWLWxY/rba1Cos=
X-Received: by 2002:a05:6870:1651:b0:220:bd4d:674d with SMTP id
 c17-20020a056870165100b00220bd4d674dmr9276795oae.5.1712588992219; Mon, 08 Apr
 2024 08:09:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2aaa9ba442f027fd9d1011c5fb30adea9bd1b799.1712344255.git.len.brown@intel.com>
In-Reply-To: <2aaa9ba442f027fd9d1011c5fb30adea9bd1b799.1712344255.git.len.brown@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Apr 2024 17:09:40 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gFqeHabWTrBfDyKzYpsy4qEgM=VO3P3T72xmTz_QzByQ@mail.gmail.com>
Message-ID: <CAJZ5v0gFqeHabWTrBfDyKzYpsy4qEgM=VO3P3T72xmTz_QzByQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] pm: Take advantage of %ps to simplify debug output
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 9:13=E2=80=AFPM Len Brown <lenb@kernel.org> wrote:
>
> From: Len Brown <len.brown@intel.com>
>
> initcall_debug previous and new output:
>
> ...PM: calling pci_pm_suspend+0x0/0x1b0 @ 3233, parent: pci0000:00
>
> ...PM: calling pci_pm_suspend @ 3233, parent: pci0000:00
>
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  drivers/base/power/main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index f85f3515c258..de581c33095f 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -209,7 +209,7 @@ static ktime_t initcall_debug_start(struct device *de=
v, void *cb)
>         if (!pm_print_times_enabled)
>                 return 0;
>
> -       dev_info(dev, "calling %pS @ %i, parent: %s\n", cb,
> +       dev_info(dev, "calling %ps @ %i, parent: %s\n", cb,
>                  task_pid_nr(current),
>                  dev->parent ? dev_name(dev->parent) : "none");
>         return ktime_get();
> @@ -224,7 +224,7 @@ static void initcall_debug_report(struct device *dev,=
 ktime_t calltime,
>                 return;
>
>         rettime =3D ktime_get();
> -       dev_info(dev, "%pS returned %d after %Ld usecs\n", cb, error,
> +       dev_info(dev, "%ps returned %d after %Ld usecs\n", cb, error,
>                  (unsigned long long)ktime_us_delta(rettime, calltime));
>  }
>
> @@ -1963,7 +1963,7 @@ EXPORT_SYMBOL_GPL(dpm_suspend_start);
>  void __suspend_report_result(const char *function, struct device *dev, v=
oid *fn, int ret)
>  {
>         if (ret)
> -               dev_err(dev, "%s(): %pS returns %d\n", function, fn, ret)=
;
> +               dev_err(dev, "%s(): %ps returns %d\n", function, fn, ret)=
;
>  }
>  EXPORT_SYMBOL_GPL(__suspend_report_result);
>
> --

Applied as 6.10 material, thanks!

