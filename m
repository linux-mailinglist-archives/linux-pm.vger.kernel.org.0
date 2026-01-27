Return-Path: <linux-pm+bounces-41566-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHpGAT/meGlwtwEAu9opvQ
	(envelope-from <linux-pm+bounces-41566-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 17:22:23 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BF497AEE
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 17:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A0246300C01E
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 16:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2E935EDC8;
	Tue, 27 Jan 2026 16:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZ6cy/Vc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362173033D7
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 16:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769530938; cv=none; b=hMx9Isrp85hROfaZy2w7Bo48/NB2FibHT+YiNr4pnRPTvYESI1J5iMaxZxzry1Eqdz0La9BUZmMJJl7XoT6XEJ+hUznR55KDY3hD2MezK7MUj9NfhQaio624AjDUs3iVYZpmNzr+F6T1FCcbxnjM2uxOj+FmJf4RrtxvU08U0eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769530938; c=relaxed/simple;
	bh=R4PzQLDXG/kGH7iVPP/yoUnX9v6iffw8okOFs6JFep4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nNoKXaLzVlz+XIyfjX6nc7yGK1vNhyzOAY0gsGGybftTPSo3RHwfc5llEKnm0xN2sBaoMGk6lot4ePd4EUrF2MlFb3tupBq1uYzg9Dcozq0UTVSDWJxpVYMYZXySUAQVmM5HBIbbEUjmWD1wSFow6ra/pTupTaeK7dl5g4HXH5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZ6cy/Vc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F17E4C2BC86
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 16:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769530938;
	bh=R4PzQLDXG/kGH7iVPP/yoUnX9v6iffw8okOFs6JFep4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fZ6cy/Vca2Actu8DwEDIqyxOgC0zsvylMhi4qOAlnHsdU+u8tnPJJXmnJxTHF4Fks
	 KjaquSSHA3OQOj0bCxkTrb4Rd0Ja9VgECKMcXXHrKB52Ea6hJIUC4JLOHhTe+EyfbU
	 5ixSkH1IiOGHzbNwETE7g5e9tR7ZXL1aB4c9HrqF1NHz3e0CptNu9PFLxziWZHRpZJ
	 vgbm4m1pJeIKzSMrYYoNrjwJeV0xyO1IOk4JGNLuwfEjSOVZqG8kSNXsZzh5QMYGUA
	 9Iy1XlzV27PjyZQ8pN6wLVc1lW1cAXlj45DaLe1z+Ask/ei51jFUwxFnIxB/43aCPC
	 I2iSl1FMJsIPw==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-40438e0cba6so3522419fac.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 08:22:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXYyfJ4vdX9Yb2nTlN2P3X33v7+J8jz03WUIITPBtvscU7CH35lJk6RwtDB9OKrMXDJNC4mhx6GYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvuvaJBZRzmDfT4kBae8en/7COng+giEbP3WFB/UwLwqdEHexT
	yqk/wBjBL+Y7VJ/ILEOuhFsQIW7DCqETAyLs2cWL6lNgGA5THMwjJ0cUeQzr+fIQH0lRE3+ZT+V
	XkHW00MXO6tM1Ksy+vYmfhVXFhbquXBs=
X-Received: by 2002:a05:6820:809:b0:65f:6759:992c with SMTP id
 006d021491bc7-662f2128629mr1148946eaf.81.1769530937024; Tue, 27 Jan 2026
 08:22:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260124-thermal_of-v1-1-54d3416948cf@gmail.com>
In-Reply-To: <20260124-thermal_of-v1-1-54d3416948cf@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Jan 2026 17:22:06 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gL92f3g4oj47jaYQKG_V6vd_oBawbwQVWjUP7u9QKS7g@mail.gmail.com>
X-Gm-Features: AZwV_Qjrv2jMygFXNf-USXQ284qkegUsvrv878exqJSNrCWardbmW9FSfHy-SK4
Message-ID: <CAJZ5v0gL92f3g4oj47jaYQKG_V6vd_oBawbwQVWjUP7u9QKS7g@mail.gmail.com>
Subject: Re: [PATCH] thermal/of: Fix reference leak in thermal_of_cm_lookup()
To: Felix Gu <ustc.gu@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Lukasz Luba <lukasz.luba@arm.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Yu-Che Cheng <giver@chromium.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41566-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linaro.org,arm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A3BF497AEE
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 8:06=E2=80=AFPM Felix Gu <ustc.gu@gmail.com> wrote:
>
> In thermal_of_cm_lookup(), tr_np is obtained via of_parse_phandle(). But
> it never be released.
> Use the __free(device_node) cleanup attribute to automatically release
> the node and fix the leak.
>
> Fixes: 423de5b5bc5b ("thermal/of: Fix cdev lookup in thermal_of_should_bi=
nd()")
>
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> ---
>  drivers/thermal/thermal_of.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 1a51a4d240ff..b6d0c92f5522 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -280,10 +280,10 @@ static bool thermal_of_cm_lookup(struct device_node=
 *cm_np,
>                                  struct cooling_spec *c)
>  {
>         for_each_child_of_node_scoped(cm_np, child) {
> -               struct device_node *tr_np;
>                 int count, i;
>
> -               tr_np =3D of_parse_phandle(child, "trip", 0);
> +               struct device_node *tr_np __free(device_node) =3D
> +                       of_parse_phandle(child, "trip", 0);
>                 if (tr_np !=3D trip->priv)
>                         continue;
>
>
> ---

This looks good to me.

Lukasz, Daniel?

