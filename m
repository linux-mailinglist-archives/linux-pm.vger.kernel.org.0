Return-Path: <linux-pm+bounces-41794-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id HLlADyPzfGknPgIAu9opvQ
	(envelope-from <linux-pm+bounces-41794-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 19:06:27 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 842AFBD953
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 19:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4930300A8F0
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 18:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8292B36AB67;
	Fri, 30 Jan 2026 18:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sX8MgBmf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F32634B68C
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 18:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769796379; cv=none; b=EzGO/mXtb92bdUJ/hYNSTG0CfEeUVUFMrt5Ez4iFXBX1hkZVSZDFHpZXeiGBLlVLEabYm3P8pVg4ZYBmFWSR1bV+cD9ID41gYVohhF+4cM/9C8MYdldqiyqxdqGXqI0VuICRscF5NiC5U9kXO+V7KLNE5+ZuQDormrb457YHfco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769796379; c=relaxed/simple;
	bh=37JUwfVpd4Lk9aAw14uwtg5TuP+MmJ/ezw9vcRAdgnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pzFjZyzoSX+eDSuvDY1omvWoYwEcZEnlp/zcmlunxDc4KXViYnkTF52u1uxdpb4oXl7leZo2uKpTie6YIfMcZfg1dYqiFUiNVd9qiz6aAmfZpbSfPcChTWsOHfCgPRFqv+zK9HI52wRIDneMCm72xuANMCsYYay/XRKlp8P5/0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sX8MgBmf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1963DC2BCAF
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 18:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769796379;
	bh=37JUwfVpd4Lk9aAw14uwtg5TuP+MmJ/ezw9vcRAdgnA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sX8MgBmfi3NaKs4KqjT1WjbDxQc5t7aI9lp6OSmnAKvSRGS3pnnu4Z6KWvQe0yDtW
	 U8rCPgTU04zV1B+G3HWwiOfasXL8EIwWp9CDBFCKszEP+N7gkViEioeD6Z/JY342Ja
	 9MPJBmEC+1MIU92IjZgLpECoZY3BGTLWoUAzd8zTo/MwDFY3rWDzGth0w4p6Zx1XAi
	 LaDGmA1tDZov2DhnQPl9MMsKNJyUSKqaxnFzXff6ykn8VlGe6Is5CU4/f3GzJa3MA1
	 wlkPa5Ax3FqnhKOtANdkTF1aAOl0WwkSNXZG+gZ2qi1OaX/Z6uR+T2BrCFi9PBGfo3
	 hEnVc5OCXv9jg==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-663097987f6so1111657eaf.0
        for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 10:06:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXj6G1BaSfDjAufA3bPwPhoj/tsXkr6Jn38aQB43BozjPIT+2grb3wsVM83iM5catYp9mZh99QqSA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRKSs/oIt2UvXC0gxPh89M668mPV2CEwBxEDX5/TrwjMbIgOnA
	yGcyPMHICuB01p6mqUYq0TJiaVzq0id3IlExeEUYLloVYsatgtokZXrB4DmFifjsujUGZ3RaSs5
	TXYTm1IcYUrFkk2lMrXC91Botxa6YlTk=
X-Received: by 2002:a05:6820:3092:b0:662:f91f:4a98 with SMTP id
 006d021491bc7-6630f35f83cmr1948636eaf.41.1769796378114; Fri, 30 Jan 2026
 10:06:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130-thermal-lmh-oneshot-v1-1-9b132204ef1b@kernel.org>
In-Reply-To: <20260130-thermal-lmh-oneshot-v1-1-9b132204ef1b@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 30 Jan 2026 19:06:06 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h5CKydWU-o-Zu2z6mCtEcCszkfpL4Vuz_VmSqhxKbozg@mail.gmail.com>
X-Gm-Features: AZwV_QhZv8dzwjIKW9UAMgugXl7oMW9qsbcLz1NQ1NxfYuOCVrGBs67fMK1ovqc
Message-ID: <CAJZ5v0h5CKydWU-o-Zu2z6mCtEcCszkfpL4Vuz_VmSqhxKbozg@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/qcom/lmh: Remove spurious IRQF_ONESHOT
To: Mark Brown <broonie@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Aishwarya TCV <Aiswarya.TCV@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,intel.com,arm.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-41794-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 842AFBD953
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 5:55=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> The lmh driver triggers a WARN_ON() due to requesting an interrupt with
> IRQF_ONESHOT without a threaded handler:
>
> [   17.414825] WARNING: kernel/irq/manage.c:1502 at __setup_irq+0xd0/0x7a=
0, CPU#7: (udev-worker)/154
>
> ...
>
>  2361 18:49:55.941384  <4>[   17.415074]  __setup_irq+0xd0/0x7a0 (P)
>  2362 18:49:55.981820  <4>[   17.415085]  request_threaded_irq+0xec/0x1a4
>  2363 18:49:55.982122  <4>[   17.415095]  devm_request_threaded_irq+0x80/=
0x134
>  2364 18:49:55.982365  <4>[   17.415103]  lmh_probe+0x31c/0x4c8 [lmh]
>  2365 18:49:55.982594  <4>[   17.415118]  platform_probe+0x5c/0x98
>
> This warning is there because IRQF_ONESHOT is only meaningful when there =
is
> a threaded interrupt handler and this driver does not register one. Just
> remove IRQF_ONESHOT, it wasn't doing anything.
>
> Reported-by: Aishwarya TCV <Aiswarya.TCV@arm.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Daniel, do you want me to pick up this one?  I can still push it for
6.19 as a fix.

> ---
>  drivers/thermal/qcom/lmh.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
> index ddadcfada513..b6b7f1193c44 100644
> --- a/drivers/thermal/qcom/lmh.c
> +++ b/drivers/thermal/qcom/lmh.c
> @@ -220,8 +220,7 @@ static int lmh_probe(struct platform_device *pdev)
>         /* Disable the irq and let cpufreq enable it when ready to handle=
 the interrupt */
>         irq_set_status_flags(lmh_data->irq, IRQ_NOAUTOEN);
>         ret =3D devm_request_irq(dev, lmh_data->irq, lmh_handle_irq,
> -                              IRQF_ONESHOT | IRQF_NO_SUSPEND,
> -                              "lmh-irq", lmh_data);
> +                              IRQF_NO_SUSPEND, "lmh-irq", lmh_data);
>         if (ret) {
>                 dev_err(dev, "Error %d registering irq %x\n", ret, lmh_da=
ta->irq);
>                 irq_domain_remove(lmh_data->domain);
>
> ---

