Return-Path: <linux-pm+bounces-40946-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E31A9D28536
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 21:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 871B6300462C
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 20:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64052E8B66;
	Thu, 15 Jan 2026 20:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjsOvo46"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928B125F798
	for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 20:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768507790; cv=none; b=PCo5Zy6GnyQu3h1kRv49b5qeS+qwWIXQht0rM+Tx/5N987/DKySyaPb2NX47kGsWz1nDJ347UkFqjY61jd0nXgsx2ZrLcurCyXy68/sZTv1DvG1ZRNaiK3Xg8KQLq4WIpClY7aEHNkoaEIv8LzcWVDWQMhq3XezmqB+cn1AynKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768507790; c=relaxed/simple;
	bh=nSLdmEb1wYlK1jIKOA4jfzRWroTIx6lhfY6ZWT0lOWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bexqRx/I2+jpomkHqaxDYi0iFbCNL5sLE5rSZ5fP9Nq8UJdRfq0EtNbZLX/spkNn3h+G5wZI5hiL05yNDatVZw+KK0m3NS/joREwojjuFQTwnRt74xj76h5zdqmE462nRbPPCHjwEKa/qOiAo10YMze/KvoyV+3ZWhnuRBWowZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjsOvo46; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BCC8C19423
	for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 20:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768507790;
	bh=nSLdmEb1wYlK1jIKOA4jfzRWroTIx6lhfY6ZWT0lOWQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LjsOvo466lX2R98uQQqR7/IpA2KCZv21gqmegt4tqr/TPGMQ08OIxU87ksWcVEYNX
	 W+XRggB/QZRlVzLzupVBfIdPPhZj+CJp0GwPh1ZzMXm2unTIpQXA3YZF1viYbtHS1s
	 TOaRE0vtKKH8YvqYiaiV9TiUZtzM0XyFoFxTHh6GjhvsPtriHgPPFAd8VtqFClcIc/
	 nb1d2XNqyLy57oflsnPNeKHxd285Ua6OHsIsCny5a+us36JM3gHgrUdkRSys1SnWYy
	 3YDLc4ICXhs4e2tsYt1t9uODeKT+iLDfVhK5F2C/eEF4QzHnty2k1V+iUWQXdOIn9G
	 xXWkzbAJDFkKw==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-65f66a770cbso732627eaf.1
        for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 12:09:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWmqdOqobwJGtNccR2KhJ8Lsru0F85IBiDRzyNnYzoIE/S0rHyqLwIhFp9V1x4g4i80JAGPyAVSGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCfoQkjRYDHN8Mki5w31DlbGIyevahLWfz0TlwiFqOPtRxRt1m
	b9PIGs8j7+P5VjQC2XlyMIHBbSQVxnIS1FiFIb+s7Di1ibd7IkhS5tuETwC+U22W0XzVgZjMKGx
	XcWqkPh+Sk3pN3mDZ57vK5hVZGUtr8h4=
X-Received: by 2002:a05:6820:1ca1:b0:65f:6794:9e6f with SMTP id
 006d021491bc7-66117972949mr419266eaf.24.1768507789522; Thu, 15 Jan 2026
 12:09:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112174901.767434-1-thorsten.blum@linux.dev>
In-Reply-To: <20260112174901.767434-1-thorsten.blum@linux.dev>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 15 Jan 2026 21:09:37 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jfQjCUip1R5RCCyB0BaTfhJ1nqQ0x7Qg5kMjdCJB+FTQ@mail.gmail.com>
X-Gm-Features: AZwV_QhStZo-Bo0knqIyjS5U_bu7dEKtNea3B78IKSr-gH4cn3j_p9KTqKbby1M
Message-ID: <CAJZ5v0jfQjCUip1R5RCCyB0BaTfhJ1nqQ0x7Qg5kMjdCJB+FTQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: sysfs: Replace snprintf with strscpy in policy_store
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 6:49=E2=80=AFPM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> There is no need to use snprintf with a format specifier to copy 'buf'
> to 'name'; use strscpy() directly instead.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/thermal/thermal_sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sy=
sfs.c
> index d80612506a33..e9580ddf4882 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -199,7 +199,7 @@ policy_store(struct device *dev, struct device_attrib=
ute *attr,
>         char name[THERMAL_NAME_LENGTH];
>         int ret;
>
> -       snprintf(name, sizeof(name), "%s", buf);
> +       strscpy(name, buf);
>
>         ret =3D thermal_zone_device_set_policy(tz, name);
>         if (!ret)
> --

Applied as 6.20 material, thanks!

