Return-Path: <linux-pm+bounces-39547-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CC0CBD7F2
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 12:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89C94300A9C3
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 11:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6189A226D00;
	Mon, 15 Dec 2025 11:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQUc1bAY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D336330335
	for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 11:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765798247; cv=none; b=DcGgiQCkZc3yp0asc5vt3b+TlBLwAKArYTQOJ+Vmq8kMFsvXXNbfxjR6kJceSswLMO0zagQhN5BvxSMsrgShtI81AThnBY/xsTR5ACMoiLAWata+lvY3JVgrdq5rG5UbTTfMBm+P0ME5xR8ZhGJTvxifUNt43ohkstZ4RHR4FFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765798247; c=relaxed/simple;
	bh=VU2yqacoYtj2ZkOYaLnttzBJQJ+wsMIBPabLCPdelFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9rU9iC/8Aes+QykOnZWztXptKoq2x8GvGinbC52rVyOYZz847M1/U6bGgZpTU6kAs4/wp3ZJ6SeVdPKRrpS+/fTYY+2YlspbrnZSGTH0mtEYJR/SWTD4tbTr2wVYEK/Nw8iryeJUCCgCwuxIpFKob9FFhGxedus4TpZSv/qNwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQUc1bAY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC04C4CEF5
	for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 11:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765798246;
	bh=VU2yqacoYtj2ZkOYaLnttzBJQJ+wsMIBPabLCPdelFM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WQUc1bAYp3nBD7rnbtx273eofrLNnbC9icYXAtOoJvFtI0XejV57/IlmU48NnvbGS
	 ADcC0oRVBXkCKGCDtNb18lZcf6+9KoGYQxZ+21DwckRPQxqSAQRHLclrvJZ9x/DMTW
	 lgHtjhXGcSaJP3fdzgezyK7agnWWzyJWbY7nZ5TOoE6wVEhNZsWfcWtNDrcU9xspNw
	 Jia6vX3pthFr3RESb9cgMf0ix5qua1wDCTTOKaxlz7BuZbY4oIeSQTzTQT6StXSzic
	 oR34U1EaY4HV1GWBr5NoNX275Hxn/Vm/WFDWkb+JatuQrPAk1xqSHXqdsN3fbTvhMp
	 dWWc4krmC9big==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-659848c994bso1871156eaf.3
        for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 03:30:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWuGvEA/Uwb4y7bbGLXGX1G+z1JazuM+Q5wEAngzECoPE1F78Q6PU64MGHpKNNJ6WqgG7vZli5OKA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd7YkerxARmBZaLDQn9TqnPJExLnta5M9nVlRDT7pSlWzOdP79
	2/5bKlHrq0ZIqQHnt949X75Hn5/7UbmUs/o+Tb0RnxBkaJtQIKFbHp6btvdNSly4aMahvXmtvya
	RjrmWVjY83jwyb82ZR2IQqfEyzKuojMA=
X-Google-Smtp-Source: AGHT+IHwt5ZtU13iMDV0bDZvIqqjQey8Z4wBWCg50d1hQCMeUyXNaC/2RNoufoulDvXO9VPD+JJqm0P8eZUnAHWXGJ4=
X-Received: by 2002:a05:6820:4c07:b0:657:5cc3:f38 with SMTP id
 006d021491bc7-65b44fe25d3mr4791510eaf.0.1765798246219; Mon, 15 Dec 2025
 03:30:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205190216.5032-1-sumeet4linux@gmail.com>
In-Reply-To: <20251205190216.5032-1-sumeet4linux@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 15 Dec 2025 12:30:35 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gURJwPXUiZGa=6Jp2LJ11g8OJf2QCJCXy7Oiof8aDMPw@mail.gmail.com>
X-Gm-Features: AQt7F2pdyk7zpOsBAaq0O7pHOHNW44DIqmIvIGCFlcpyUhRnr5HYZS5owoL_WE8
Message-ID: <CAJZ5v0gURJwPXUiZGa=6Jp2LJ11g8OJf2QCJCXy7Oiof8aDMPw@mail.gmail.com>
Subject: Re: [PATCH] powercap: fix race condition in register_control_type
To: Sumeet Pawnikar <sumeet4linux@gmail.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 8:02=E2=80=AFPM Sumeet Pawnikar <sumeet4linux@gmail.=
com> wrote:
>
> The device becomes visible to userspace via device_register()
> even before it fully initialized by idr_init(). If userspace
> or another thread tries to register a zone immediately after
> device_register(), the control_type_valid() will fail because
> the control_type is not yet in the list. The IDR is not yet
> initialized, so this race condition causes zone registration
> failure.
>
> Move idr_init() and list addition before device_register()
> fix the race condition.
>
> Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
> ---
>  drivers/powercap/powercap_sys.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_=
sys.c
> index 4112a0097338..bdc65e040d17 100644
> --- a/drivers/powercap/powercap_sys.c
> +++ b/drivers/powercap/powercap_sys.c
> @@ -625,17 +625,22 @@ struct powercap_control_type *powercap_register_con=
trol_type(
>         INIT_LIST_HEAD(&control_type->node);
>         control_type->dev.class =3D &powercap_class;
>         dev_set_name(&control_type->dev, "%s", name);
> -       result =3D device_register(&control_type->dev);
> -       if (result) {
> -               put_device(&control_type->dev);
> -               return ERR_PTR(result);
> -       }
>         idr_init(&control_type->idr);
>
>         mutex_lock(&powercap_cntrl_list_lock);
>         list_add_tail(&control_type->node, &powercap_cntrl_list);
>         mutex_unlock(&powercap_cntrl_list_lock);
>
> +       result =3D device_register(&control_type->dev);
> +       if (result) {
> +               mutex_lock(&powercap_cntrl_list_lock);
> +               list_del(&control_type->node);
> +               mutex_unlock(&powercap_cntrl_list_lock);
> +               idr_destroy(&control_type->idr);
> +               put_device(&control_type->dev);
> +               return ERR_PTR(result);
> +       }
> +
>         return control_type;
>  }
>  EXPORT_SYMBOL_GPL(powercap_register_control_type);
> --

Applied as 6.19-rc material, thanks!

