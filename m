Return-Path: <linux-pm+bounces-29352-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 700FFAE4804
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 17:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D050167CDB
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 15:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA7427604E;
	Mon, 23 Jun 2025 15:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="G7dTtAD4"
X-Original-To: linux-pm@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BF725BEE2;
	Mon, 23 Jun 2025 15:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750691315; cv=none; b=QA0wAazh7PYLnB3s4HRMhcvrv1Te1m4WBFkI+fQ4K+x5kq13YLO6+2M1L0OgLBGd8qS96T2ebbQs1ume/lgD7SBGH1mmLWQWLm4v8ynQzzP5XXfs33zldE7g/aqxPDG1zfsL3oflUJ1Bn/4K43RGdia2ZGK1qWy8mScXgHtPahs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750691315; c=relaxed/simple;
	bh=a71/2Ue33rw39RNd+lnzupReDwpTHqZ0pqweFgks0U8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WNYKoJ7d+CeUYIibeFkoyzFbbnz9Uscb7Av/idozSQU/eeqDyzoffI8SD+/+/KJ8TKqgLY5CpuBUny0hIB7NfXHyU4g36RxTHP93vgTYEf8Zwz1ZwZ/Qs39Vr5/CTQW1LnDEbbaIU4T4BqBRg8nutGvgy0UUKuwPBvHRqGpoqhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=G7dTtAD4; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1750690805;
	bh=jLvrxNOLfc3fbfwBKLMN+s9XeJSBspgyoztJCta+7KA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=G7dTtAD4paR3Aidw88ZgTEGiysPNxyQQXKctAEaPLfZxvlwHO7cGpnWKpdUBnWpAM
	 6vzcFS99bQeYkfMVlW0g+8hNJ5v1ucv0o4Eh6B74fR+25YwgjNdBgmMEQbCu0Lbr98
	 Glur/qvFbunCzQHlj4derg77OyhNbX1HLyIOm8rA=
Received: from [IPv6:2409:8a4c:e21:5211::e90] (unknown [IPv6:2409:8a4c:e21:5211::e90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id A708A65F62;
	Mon, 23 Jun 2025 10:59:58 -0400 (EDT)
Message-ID: <9246b226e356ea0db044a592fed8853dd593f7f7.camel@xry111.site>
Subject: Re: [PATCH] cpufreq: loongson3: Support older SMC firmware
From: Xi Ruoyao <xry111@xry111.site>
To: Yao Zi <ziyao@disroot.org>, Huacai Chen <chenhuacai@kernel.org>, WANG
 Xuerui <kernel@xen0n.name>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh
 Kumar	 <viresh.kumar@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Mingcong Bai <jeffbai@aosc.io>, 
 Kexy Biscuit <kexybiscuit@aosc.io>, loongarch@lists.linux.dev,
 linux-pm@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 23 Jun 2025 22:59:50 +0800
In-Reply-To: <20250623123321.5622-1-ziyao@disroot.org>
References: <20250623123321.5622-1-ziyao@disroot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-06-23 at 12:33 +0000, Yao Zi wrote:

/* snip */

> -static struct cpufreq_driver loongson3_cpufreq_driver =3D {
> +static struct cpufreq_driver loongson3_cpufreq_smc0_driver =3D {
> =C2=A0	.name =3D "loongson3",

How about using different names for the drivers?

> =C2=A0	.flags =3D CPUFREQ_CONST_LOOPS,
> -	.init =3D loongson3_cpufreq_cpu_init,
> +	.init =3D loongson3_cpufreq_cpu_smc0_init,
> =C2=A0	.exit =3D loongson3_cpufreq_cpu_exit,
> =C2=A0	.online =3D loongson3_cpufreq_cpu_online,
> =C2=A0	.offline =3D loongson3_cpufreq_cpu_offline,
> -	.get =3D loongson3_cpufreq_get,
> -	.target_index =3D loongson3_cpufreq_target,
> +	.target_index =3D loongson3_cpufreq_smc0_target,
> +	.verify =3D cpufreq_generic_frequency_table_verify,
> +	.suspend =3D cpufreq_generic_suspend,
> +};
> +
> +static struct cpufreq_driver loongson3_cpufreq_smc1_driver =3D {
> +	.name =3D "loongson3",

Tested on a 3A6000 laptop with the schedutil policy.  On idle one core
is at 2000MHz and other cores are at 250MHz, when building the kernel
all cores are at 2000MHz.

Tested-by: Xi Ruoyao <xry111@xry111.site>

--=20
Xi Ruoyao <xry111@xry111.site>

