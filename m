Return-Path: <linux-pm+bounces-29359-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A364AE48A6
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 17:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF2503BD451
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 15:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F8A299A82;
	Mon, 23 Jun 2025 15:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ptpTP9LJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC53A279DA1;
	Mon, 23 Jun 2025 15:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750692487; cv=none; b=l2wXOh5DsPdkmrJEwIgSrzXjnFO4zVlUkLc11LQKW/iL8AUNet0bj//XXYybl4dEsU8sHzPIIiAEw0bT35OqFEW/pYAxganhdyPNrPlNBsCr0DPvxcIEAJQmDExBL6B6RJt6f6CFNJx4VXvHTBR9+oWpm+/nTYEoQKGRJpo5+co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750692487; c=relaxed/simple;
	bh=PbLngc0T4LjjEXy8D0cjm20DavMaQXHVUpPSY+TIs7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S/s3w4ufRvxK0nwXZH5mNgboyQ83cuVL8AGLsEhkXvEWxzHx+L/ud1EVNhes1cnYQXVr+JbHD/BLY8xhLj1oBmN+16I/kkuEkMcWbq/56eDsq9QtbxVv42v7LhDw7k04AjZ5lVLuYsxDA4OpB20wsYOluhLuxuZ2JxY8JYs+PM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ptpTP9LJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50070C4CEF1;
	Mon, 23 Jun 2025 15:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750692487;
	bh=PbLngc0T4LjjEXy8D0cjm20DavMaQXHVUpPSY+TIs7A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ptpTP9LJ2fsScdJ+6/KY6IUvnwLL0SQ2To0PP0sRnCxtlgVq0311jb3WzQXwaXLip
	 aMOqpsgIVbgIW4WNQuAcRdHFi3LFPiNNT2i5+giDPeRCLD3XJ/JzGMjSPPvqhsO6eZ
	 I5YA1pOVEKjwyrOh5F8YVGPyVM43VI9f/Q8w86YkzUz2g+YLJVKuUXs3cKDw26ZDpw
	 TNyoFvI/3N/MLSnLlOKyoOycB3s4EF3f7erWWn/QY8Y/q4zORslfgxNdD7VP8ByhGG
	 f/82C+cQQH3J/J5sOGzH2sAAh00AE6e4jU0V6yJtpEgzHmxrSHZEnXZsUFF+xC7Hfv
	 b8MJ84iIqGGDg==
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-735b9d558f9so1035461a34.2;
        Mon, 23 Jun 2025 08:28:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU6TXW6TG1hVCS3FaHegn5OrHh4uA+ZzbM92voZpiyAUqen4UwqO0h/wir1MMXG90IIOKYbK5y/NW52VvA=@vger.kernel.org, AJvYcCV/Y4/ttWWxIIvoxwq2v3mjJsv/5u76pCLDJ7F8DUz5cRKLr4Mj1ADqBvcL1lW9WGWxt6quaqtJ5xw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt8KpV4Xvrerovq+bNuuK15V0afbAdydBCep00Z5CySfO1Y9DS
	uRxyxg5/H8Dag2HxWASZmn1n2loaexzYZaD3Vanijp860OLrvXRAZz9y/k/A6KM5oNmKnUu9BHK
	0uYMBPQ3ahvn8J61ubeG7NQkHrjlSkgo=
X-Google-Smtp-Source: AGHT+IHmxTQKSnWdT13aT/MOq6wfqAFXLCcLtDfPnHV7PVnD3GZb1jZ/tlQenxePqUUaix+F3UtUa3AaEAbKB3FTP/c=
X-Received: by 2002:a05:6871:3404:b0:2c2:3e54:553 with SMTP id
 586e51a60fabf-2eeee5627ddmr8336812fac.28.1750692486571; Mon, 23 Jun 2025
 08:28:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623133402.3120230-1-zhenglifeng1@huawei.com> <20250623133402.3120230-2-zhenglifeng1@huawei.com>
In-Reply-To: <20250623133402.3120230-2-zhenglifeng1@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 23 Jun 2025 17:27:54 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hnb3q1bdsgKDL+E0QG92ju8DoEU-=Rk9cfu7Q8QEBB8Q@mail.gmail.com>
X-Gm-Features: AX0GCFtnobN5J0PI_gQNSZctS_hx6Bi7fEvMzL02skIhgem8JN2FRfJqubfODUY
Message-ID: <CAJZ5v0hnb3q1bdsgKDL+E0QG92ju8DoEU-=Rk9cfu7Q8QEBB8Q@mail.gmail.com>
Subject: Re: [PATCH 1/7] cpufreq: Disable cpufreq-based invariance when fail
 to register driver
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, ionela.voinescu@arm.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, lihuisong@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 3:34=E2=80=AFPM Lifeng Zheng <zhenglifeng1@huawei.c=
om> wrote:
>
> The cpufreq-based invariance is enabled in cpufreq_register_driver(), but
> never disabled after that when fail. Add a
> static_branch_disable_cpuslocked() to do that as
> cpufreq_unregister_driver() does.

What about moving the invariance initialization to the point when 0 is
going to be returned?

> Fixes: 874f63531064 ("cpufreq: report whether cpufreq supports Frequency =
Invariance (FI)")
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>  drivers/cpufreq/cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index d7426e1d8bdd..1bc665b5bba8 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2991,6 +2991,7 @@ int cpufreq_register_driver(struct cpufreq_driver *=
driver_data)
>  err_boost_unreg:
>         remove_boost_sysfs_file();
>  err_null_driver:
> +       static_branch_disable_cpuslocked(&cpufreq_freq_invariance);
>         write_lock_irqsave(&cpufreq_driver_lock, flags);
>         cpufreq_driver =3D NULL;
>         write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> --

