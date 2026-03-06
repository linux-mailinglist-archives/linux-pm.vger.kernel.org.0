Return-Path: <linux-pm+bounces-43853-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGSBKuv5qmmcZAEAu9opvQ
	(envelope-from <linux-pm+bounces-43853-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 16:59:39 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 291332246BA
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 16:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7167E303F064
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 15:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4818D3E51F9;
	Fri,  6 Mar 2026 15:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jJN1hOtd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31B836C58A
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 15:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772812304; cv=pass; b=YY4RHM11eShjri5a1m/B+N87wBxHrj+PV8upbzXqpU/9a/9W748IJaqqFy9RVnK2fEYGAsaMs8mClqQoCFmTSeM+gngn4HboR60641DYaCz+sqlI1daDx+q1S08Y2jGKabbOUFKCUTLXvXuLFs//0rUX33CwRck4xUsUibwfAXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772812304; c=relaxed/simple;
	bh=zt/0UNt3uP18aJxtk0eoO7x0Py6Ek1ZFUdGvve+hz54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QakIGHwS9pR0zqTaGxc2RtSeOMeDJOuetDYYkxQi6dq/ELxyXsbKcKWpitN5pg9ff0h+8Gwre+CFtl90Mt5JLvVLDE4V9i8S/etLP60VWHaMVApdou3idf/l+TtA0ayPN18K5uQPrEGkLKXeXyQCpeFKVxnLeOUju9I2KdrRNG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jJN1hOtd; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6610bd5f322so5000232a12.1
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 07:51:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772812301; cv=none;
        d=google.com; s=arc-20240605;
        b=Ha402MU02pxlSG4T1E9sVO73br4kHf2Ls4fDSSBTJyWFkYDYyQqdj2bUhfwZH6DGzi
         dBvZZ9EHCkYcPwUIGyX5dEC+lTUKA9yWGd4BawaUfeXn1YeBvOBcJyZuLrE4auhcJxNo
         kRpPu4ai7QJQcsgEnGQ1oxCEOWkG+Rao0gDIwFiimcPCRAGcl5eyvCrAYaaT8tR4mUzO
         Z0zJ/xjq2eLOkD6isGhX7k/hJz2ht1ygf+kxPxjinBBG0+nI7hpOWK5HSW7ZQsBpOpDz
         NHYKZdkzXNfRuOuOeKhYGyO05C1jw4368OvhrmQuIwzhJt40XmFYdsUhffEmbaG7a7o5
         x9vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xzcKbGMLVorHlsZLyV1rvqs6i8R7J8sRM6aIMH0+nN8=;
        fh=R4pr5pDjkNrsx/g+eFc9fmXtaMnLxXGKHSK9YYDqZkc=;
        b=XxIBVMXEIbu5B7gcEFn925ZsxNbhjVU4m3kkGco7EQEFxorzi0jZ2ChSMdL5xnbzEY
         fgAWFjj8S0PwLBAkEKIlgYxmq1r8mqIMngOR0dPst6SqqQni0diJUhxUNRiSiF7UphD8
         7UXOeYv6X0/MJfQlXHv3zhc6UZw+t4HzNkasPAFhRUqb/gHakI8cOYAyIgIAyE4pTZeR
         N7mdlKITfdRGgILvXWaaa8fdYRRrn0O3pa+j5Y1n8WNXbfwbQWMX54qwsrhca7DR6nej
         eeHpUSSE1ds+l8iRLnD/n2juaBLYtx91ML9948dJYxUQtg29zlXmdQ4m4PT0pilmNLWx
         /k4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772812301; x=1773417101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzcKbGMLVorHlsZLyV1rvqs6i8R7J8sRM6aIMH0+nN8=;
        b=jJN1hOtdwsskWc1pefnfQcjLiGmjUKNymGSXkMS2DHIWWFDik2mp7S6FwL709lcD6L
         eMeMJBQDT0wtlGsDv5f8F49DsbENS1Opqgw53IG0OVKThm515JIcdl6oyJTftzgaJAK3
         eOJF/TWqggjJm4GLS0g7KI7BvMKGDWP1q1Sg/jfUy01z1RpaT56xlp0FBkDJUwo0t2Ba
         HrPG0/QvWEnDvrkdMmzKFSocqXwg7c8RrBZWOa1AE+r1hpt1zBDPUykT0wqh4t3yTvDf
         LOJWgdtin9gyfeivQ1lWmTM+fq7uamU+J5+Z7W13xEX2I70ywKrS4kNL6p5lwkbIilfC
         +XYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772812301; x=1773417101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xzcKbGMLVorHlsZLyV1rvqs6i8R7J8sRM6aIMH0+nN8=;
        b=sYIG/eFRO06QA7Ypz/S70J3MsE92/tq4bu//fffOtaZfPVsHiSg5illWjnna+RaJf6
         iOhQHkU+eySdhtn1Blrb8Oo1CsuaDRwgzIwJHcv65MkYmagbXJBoy7mShQ8k/gh9Vv2p
         QjzowZe77l2CuDMy8/yDEJkp1L20C3r0/mhNIk2XdMqAvaqJhQRhVypGCbGtcI43qhEV
         tBL22DRXLm85X/Zq1veSXScxtTLtZVdrN6WfSYYNB6TPL9TK1a2Z3/3+SbCgUOn/4VyS
         9Cck+uL06BA44wVaI/RHFOxXqQ4qd3ijlRwbqHAzWOx4T3zRx0HV3fkFYrbzEpdK8Nuo
         ph2w==
X-Forwarded-Encrypted: i=1; AJvYcCUo7YwvSpKnLNl8/xfDVDYtKMWH84VjwPyTHSgGMM0EK3qhyl8i/ChsdWGmfU0pkEM/+oroFn9zXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQFD4kg3Fbt6f2/34uMuR69E5Zp0vfsPCOt0b6P2cmUzud6yMj
	2Rbcy/tfCHT/RSOO1R7ZSoJdcYn5ygWoye2hohlL1bkFCE3hdsG5GN7j0cs8Bf92ja75NG4L0/P
	AAdn+FDei2heNRPGioIXVAZJiI6huGn9JI7uMAGAbag==
X-Gm-Gg: ATEYQzwT90bewTA5v+HekPnJ2UFx/cZSD6FmTC5EKxPEb65tv6iIf0aDFoFhjnteKIC
	uoYkOQFHiShY/VoxGe6hnX5pUo4X6+b5FkFfUFHcKiys0YqQiWL///vGDJtVtdnxXjZpiQf86Zf
	njLYYe6EgbpJeF3h3cWiFGGZaBOPqMHdSkYUAsU7pulrNqPHDnBlNzRcm6U9sv3j70RkP1QFyNG
	oy5BEEhdyK+SW4mLaI1jkPcbwjn0sMDETawNgAalF8AgAPbLisdRbl+9ADO1MVvMddA9ntBwvr8
	+GhDdYlAyy7jCGL4lE3NAw3lhEkSqdRBRqHJQx7txg==
X-Received: by 2002:a05:6402:440b:b0:65c:354e:94f0 with SMTP id
 4fb4d7f45d1cf-6619d467bf2mr1553000a12.8.1772812301052; Fri, 06 Mar 2026
 07:51:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306-gs101-pd-v7-0-03f7c7965ba5@linaro.org> <20260306-gs101-pd-v7-6-03f7c7965ba5@linaro.org>
In-Reply-To: <20260306-gs101-pd-v7-6-03f7c7965ba5@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 6 Mar 2026 15:51:29 +0000
X-Gm-Features: AaiRm50XSyJAhZxudj29YJ-AfLARk18pjf_9-ZTH2qd-aJZzO76tWKTXAR6KLlw
Message-ID: <CADrjBPqB60UtWpZjBdsGtijw+OSq76vfBaiKoJg8We2na-ixhQ@mail.gmail.com>
Subject: Re: [PATCH v7 06/10] pmdomain: samsung: don't hard-code offset for
 registers to 0 and 4
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 291332246BA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43853-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[kernel.org,samsung.com,linaro.org,gmail.com,google.com,android.com,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peter.griffin@linaro.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-0.992];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,linaro.org:email,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,samsung.com:email]
X-Rspamd-Action: no action

On Fri, 6 Mar 2026 at 10:29, Andr=C3=A9 Draszik <andre.draszik@linaro.org> =
wrote:
>
> On platforms such as Google gs101, direct mmio register access to the
> PMU registers doesn't necessarily work and access must happen via a
> regmap created by the PMU driver instead.
>
> When such a regmap is used it will cover the complete PMU memory region
> rather than individual power domains. This means the register offsets
> for the configuration and status registers will have to take the power
> domain offsets into account, rather than unconditionally hard-coding 0
> and 4 respectively.
>
> Update the code to allow that.
>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

>  drivers/pmdomain/samsung/exynos-pm-domains.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdom=
ain/samsung/exynos-pm-domains.c
> index 3bcba7d38ac1..8df46b41f9bc 100644
> --- a/drivers/pmdomain/samsung/exynos-pm-domains.c
> +++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
> @@ -30,6 +30,8 @@ struct exynos_pm_domain {
>         struct regmap *regmap;
>         struct generic_pm_domain pd;
>         u32 local_pwr_cfg;
> +       u32 configuration_reg;
> +       u32 status_reg;
>  };
>
>  static int exynos_pd_power(struct generic_pm_domain *domain, bool power_=
on)
> @@ -41,7 +43,7 @@ static int exynos_pd_power(struct generic_pm_domain *do=
main, bool power_on)
>         pd =3D container_of(domain, struct exynos_pm_domain, pd);
>
>         pwr =3D power_on ? pd->local_pwr_cfg : 0;
> -       err =3D regmap_write(pd->regmap, 0, pwr);
> +       err =3D regmap_write(pd->regmap, pd->configuration_reg, pwr);
>         if (err) {
>                 pr_err("Regmap write for power domain %s %sable failed: %=
d\n",
>                        domain->name, power_on ? "en" : "dis", err);
> @@ -53,7 +55,7 @@ static int exynos_pd_power(struct generic_pm_domain *do=
main, bool power_on)
>         while (timeout-- > 0) {
>                 unsigned int val;
>
> -               err =3D regmap_read(pd->regmap, 0x4, &val);
> +               err =3D regmap_read(pd->regmap, pd->status_reg, &val);
>                 if (err || ((val & pd->local_pwr_cfg) !=3D pwr)) {
>                         cpu_relax();
>                         usleep_range(80, 100);
> @@ -164,6 +166,8 @@ static int exynos_pd_probe(struct platform_device *pd=
ev)
>         pd->pd.power_off =3D exynos_pd_power_off;
>         pd->pd.power_on =3D exynos_pd_power_on;
>         pd->local_pwr_cfg =3D pm_domain_cfg->local_pwr_cfg;
> +       pd->configuration_reg +=3D 0;
> +       pd->status_reg +=3D 4;
>
>         /*
>          * Some Samsung platforms with bootloaders turning on the splash-=
screen
> @@ -174,7 +178,7 @@ static int exynos_pd_probe(struct platform_device *pd=
ev)
>             of_device_is_compatible(np, "samsung,exynos4210-pd"))
>                 exynos_pd_power_off(&pd->pd);
>
> -       ret =3D regmap_read(pd->regmap, 0x4, &val);
> +       ret =3D regmap_read(pd->regmap, pd->status_reg, &val);
>         if (ret)
>                 return dev_err_probe(dev, ret, "failed to read status");
>
>
> --
> 2.53.0.473.g4a7958ca14-goog
>

