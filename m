Return-Path: <linux-pm+bounces-13031-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEAD962673
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 13:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7332284B17
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 11:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C41E16D4EE;
	Wed, 28 Aug 2024 11:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="b7VBHZZ8"
X-Original-To: linux-pm@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD3C16BE35;
	Wed, 28 Aug 2024 11:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724846361; cv=none; b=b9WFhnLyZ7V0dD/V3C13zo71u9w5q2/saWWoFfG/PVpSGWYUVPrrfRdBvSKcl/rzZo/UQnH5WZhPqJ4wcD7XGuyCcykieCWYtIP+O6pXivzpmDllRPYkiRTviJ4TDkt+4kFh5OGu8mUh3UmwIIDdEVjw9G8njC5hBcAOIsCqfSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724846361; c=relaxed/simple;
	bh=rsEkCSbL+6t9wAmS7k0WRYrB5VkHidRUySmabKRT7D0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VHJ7IWXkjUGjUhFEx5jT78LL6z+HAzTZAsiOjZ/8y+dbRAZHQsKSF7/hzjEQHDd/6lMYozYrMuKUqygxu1U9wOr4lizX3tOodv/DB+tkp+VfZ7jR1QjegSNat4dnburKL+ivc0Gxa1F1gzNJ+myfvc/phDAlGotJgk0jvG4BprY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=b7VBHZZ8; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1724846351;
	bh=rsEkCSbL+6t9wAmS7k0WRYrB5VkHidRUySmabKRT7D0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=b7VBHZZ8AV2Z+TORXpcjY1MAedDxebAyWOXRnpWEgBqiR3VjGKH8LvcU8/YUsFO98
	 oo7exZT+Qqg/RVx9TuhdxC3rv6DcpuIMmZShBHZTYgvtLH6Nvxc3EoKpdId52crDpY
	 wdlbzFqEAKAZcim2S947V/CCXefMEXTcDjbRUdi4=
Received: from [192.168.124.6] (unknown [113.200.174.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 801EA6656F;
	Wed, 28 Aug 2024 07:59:08 -0400 (EDT)
Message-ID: <affff6410e681152c3fdcf3512df76d734f29aeb.camel@xry111.site>
Subject: Re: [PATCH] cpufreq: loongson3: Use raw_smp_processor_id() in
 do_service_request()
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@loongson.cn>, "Rafael J . Wysocki"
	 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Huacai Chen
	 <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang
	 <jiaxun.yang@flygoat.com>, Binbin Zhou <zhoubinbin@loongson.cn>
Date: Wed, 28 Aug 2024 19:59:04 +0800
In-Reply-To: <20240828062459.1853837-1-chenhuacai@loongson.cn>
References: <20240828062459.1853837-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-28 at 14:24 +0800, Huacai Chen wrote:
> Use raw_smp_processor_id() instead of plain smp_processor_id() in
> do_service_request(), otherwise we may get some errors with the driver
> enabled:
>=20
> =C2=A0BUG: using smp_processor_id() in preemptible [00000000] code: (udev=
-
> worker)/208
> =C2=A0caller is loongson3_cpufreq_probe+0x5c/0x250 [loongson3_cpufreq]
>=20
> Reported-by: Xi Ruoyao <xry111@xry111.site>
> Tested-by: Binbin Zhou <zhoubinbin@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Tested-by: Xi Ruoyao <xry111@xry111.site>

After this patch the BUG() message is gone, but I still get

[    6.610357] loongson3_cpufreq loongson3_cpufreq: probe with driver loong=
son3_cpufreq failed with error -1

-1 is EPERM and there are several "return -EPERM;" in the code.  Not
sure which one.

Do I need to modify some firmware setting to make it work?

FWIW I'm building it as a module.  Should I try building it as a part of
vmlinux?

> ---
> =C2=A0drivers/cpufreq/loongson3_cpufreq.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/cpufreq/loongson3_cpufreq.c
> b/drivers/cpufreq/loongson3_cpufreq.c
> index 5f79b6de127c..6b5e6798d9a2 100644
> --- a/drivers/cpufreq/loongson3_cpufreq.c
> +++ b/drivers/cpufreq/loongson3_cpufreq.c
> @@ -176,7 +176,7 @@ static DEFINE_PER_CPU(struct loongson3_freq_data
> *, freq_data);
> =C2=A0static inline int do_service_request(u32 id, u32 info, u32 cmd, u32
> val, u32 extra)
> =C2=A0{
> =C2=A0	int retries;
> -	unsigned int cpu =3D smp_processor_id();
> +	unsigned int cpu =3D raw_smp_processor_id();
> =C2=A0	unsigned int package =3D cpu_data[cpu].package;
> =C2=A0	union smc_message msg, last;
> =C2=A0

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

