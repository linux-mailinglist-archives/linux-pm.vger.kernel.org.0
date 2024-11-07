Return-Path: <linux-pm+bounces-17100-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CFE9C0307
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 11:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D05AAB20FB8
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 10:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930E61EF957;
	Thu,  7 Nov 2024 10:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9mJ+v0K"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3661EF0A2;
	Thu,  7 Nov 2024 10:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730976954; cv=none; b=eSzA6EhL1xEnAO55rwmrBUrOSGi6Z0FUeIooxVCeuXdnhQSFZK8XiYzGLAAdOm3JXE5oXKH3kAukLhtg7I9PDvY2337UsOxrjffSIQDOT46FkILIngfZ1YmrYWjEYBIzxNZNKaWw+8CHhvimz+ekgYgz8Q/EQWJ/LeN//eZ4DKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730976954; c=relaxed/simple;
	bh=ktYjhjMoBbMeWIVDuKN1MtIX9T7IVhDQA7MjkJwjB7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZsXkoXbV8CFujjllnN8SY5B7nlMxm1VR+SAD37223F7PH05gN8Z8NOuqbxP0XQcV04HikL5CWUhvA2hYOuVGmFps3coz4N3hSqvPG3VXejwKMokDQpsfQpnygYgNAbfyezB3cb5XNi3+dzu3VSo8iVnpDsR0AvQjjUCzzdqaI/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9mJ+v0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5F2C4CED2;
	Thu,  7 Nov 2024 10:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730976954;
	bh=ktYjhjMoBbMeWIVDuKN1MtIX9T7IVhDQA7MjkJwjB7I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=X9mJ+v0KH9iXj+w8Efakw8Z3/dirM4+zkLEc7txxIgJSYxDuCW4Gi93amCCJ5Z6iv
	 flYilMNI16kaMvJYFZKUbc2Z2Lw9Dj8nkNZhhS6nEvUxVNWOEha6umXDNyuMcxfvce
	 7MH9dGenHeObQzfWKkc4EO+UGACcaRrmFU4uUQq4m3ByuGZ/hVwwqIAZndiZgGg48z
	 /agYMr/Ta92hvvek2XOm6vC6IwcllgJ95VPILDlqgbAI/SstYLpfAO9/xFz31kCrnG
	 PlLww46IRZETUc9wSyFzQqXtxejshatRP+2JCMA4l49Y7HgVQacq1GZkvnd/v8m8wz
	 KAe044P1W45mA==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-290c69be014so370265fac.3;
        Thu, 07 Nov 2024 02:55:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV4LTfoig0/PjAj2aPum2204iF7f0mpVTE4t/oJCAmyS8OECmMix8M1nkwadkmSU78wh4OpyduZOFmN3zQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLzenfo79ua2oWsOHcqv/IBEPebbBgzPfJYBhtXa+m2lAt2f5o
	gmqtdcz5Zq6iMkmViyvthCirHIkRLlGiuw7ROZpeIAfkdiDLEVkWMtx/6Cw+lHMxds4J2LAoYiT
	rKwH9HzGo1G1Rb6a41ZtBJPYzYl0=
X-Google-Smtp-Source: AGHT+IGIxVPt1/6x6X/H66OvdlERmCn2bOiVRbjq2OC8sO/VXnsIlJjlcD8QCKHPAyjkRcjKWmACnYKQ3IR+FCVH9bU=
X-Received: by 2002:a05:6870:3043:b0:26f:ddfa:3564 with SMTP id
 586e51a60fabf-2949ed307damr23256360fac.6.1730976953266; Thu, 07 Nov 2024
 02:55:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107032626.16682-1-lihuisong@huawei.com> <20241107032626.16682-3-lihuisong@huawei.com>
In-Reply-To: <20241107032626.16682-3-lihuisong@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 7 Nov 2024 11:55:41 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hcEn_XhBPLstFyvqE=2iCG51wvcbGHf2nKaFJU5ynytQ@mail.gmail.com>
Message-ID: <CAJZ5v0hcEn_XhBPLstFyvqE=2iCG51wvcbGHf2nKaFJU5ynytQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] hwmon: (acpi_power_meter) Fix fail to load module
 on platform without _PMD method
To: Huisong Li <lihuisong@huawei.com>
Cc: linux-pm@vger.kernel.org, rafael@kernel.org, linux-kernel@vger.kernel.org, 
	liuyonglong@huawei.com, zhanjie9@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 4:37=E2=80=AFAM Huisong Li <lihuisong@huawei.com> wr=
ote:
>
> As ACPI spec said, _PMD method is optional. The acpi_power_meter
> shouldn't fail to load when the platform hasn't _PMD method.
>
> Signed-off-by: Huisong Li <lihuisong@huawei.com>

How exactly is this related to the first patch?

> ---
>  drivers/hwmon/acpi_power_meter.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_=
meter.c
> index 6c8a9c863528..2f1c9d97ad21 100644
> --- a/drivers/hwmon/acpi_power_meter.c
> +++ b/drivers/hwmon/acpi_power_meter.c
> @@ -680,8 +680,9 @@ static int setup_attrs(struct acpi_power_meter_resour=
ce *resource)
>  {
>         int res =3D 0;
>
> +       /* _PMD method is optional. */
>         res =3D read_domain_devices(resource);
> -       if (res)
> +       if (res !=3D -ENODEV)
>                 return res;
>
>         if (resource->caps.flags & POWER_METER_CAN_MEASURE) {
> --
> 2.22.0
>
>

