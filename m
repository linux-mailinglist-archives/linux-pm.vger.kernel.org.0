Return-Path: <linux-pm+bounces-41445-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGX4CgzfdmmhYAEAu9opvQ
	(envelope-from <linux-pm+bounces-41445-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 04:27:08 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A1E83AAE
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 04:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAF313011596
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 03:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7F129A33E;
	Mon, 26 Jan 2026 03:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJ7hWuwn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0FE20B810
	for <linux-pm@vger.kernel.org>; Mon, 26 Jan 2026 03:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769397880; cv=pass; b=d7K3c1qWL4/8dSvIi9D3hVUy7ha9pU0LVuCk4j8J0hGTM8s7pR4Vk9kb1hMo7KY/txIQQVRjLLV6ff7SfPDEra1QWYDfJnZCZsrYQzP/jGRbbchI6GS2CwNiZ5VSNGuKcr606GwuuyM/PJOPuDOadM5N0LvA9JcZxEf5IYEUOeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769397880; c=relaxed/simple;
	bh=zPt4PvjEbR6Y/mBabitOBE/A3gpn81xz7OpyApOSNm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=USmdipN+Jn0Qn4AkeDGO73Y584gwICmFL0hzVg/TU1GxqDUEogE6TJ9uc550oS2/Cm04/ygAAQU7bWZxLPTxHEO7Khb083p4umcUeFH0X0q4WLEZMtIqiBLlwX0f4UZ2C6xCfZrEGlLALAGLDpq1pkzhZ5RGuBTMoT7IkdGQvBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJ7hWuwn; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-502b0aa36feso54691831cf.1
        for <linux-pm@vger.kernel.org>; Sun, 25 Jan 2026 19:24:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769397877; cv=none;
        d=google.com; s=arc-20240605;
        b=JtYi6wF7ftB1iqmG3UwuDhmB2RjA6EW0wYnN3pgBP3zUoG+twUDOT/Up35uHnqflc/
         a7oBKybWZIp5KKo0zVvzGUl5asXi4R7Ot4o0xmt4FdrbgNm/RXf78CAU+YgQwu0ZFFK1
         /RssIYGYLvLW1x0QTeTKGt51/qpKsTQjjQNcTZDIver9nZe1NoXyQ+6n6YndyMqtqrNs
         QqquuIk6cKs5gcIgMKrY9Q49TTpQGYXrz1LNLwiQ7ErYe/xEalNdu4z4N0E4lYJRyGLb
         3+sxFoFE5581QCbqphYfaxzu++1uCfeV2ynMFgW4GFuSb6UjKegZkymcEHGl8v1fN4d0
         f3QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MjadraffcjHnZ1omdwki/WlhIF+4AlEylTjfkcUTkLQ=;
        fh=Nh0G1nkpSeZQjeEcKRDZH9m7m6VrnMp+FvsPE+noYJk=;
        b=Bq8ciP1Vhfcm2oW3gQyWZ+tP1F+tfxIUmLOKIKIOFSDz/E0t0WUJVI38LO2aDqT4uD
         xqz8YtW7kXGoz1mvFkyM2cMI0UH5qIaDjMnUajehLlkkaabrcnLwP6k2SqbYXPL/AIGP
         d8O1D3jz7KSstGw3oaryMnfPIDG2wGhIrytEoBNq4Jwhr0vDkleZDeMyN/dVljS8cQYI
         0P5oslbuhc5L+TN4vs226os+n3EHL62XKv98PH0VD6ZtjQ45V3skR38K1DR9oqfbY3T7
         zAExd2jhGFd5t+5823DtbV4UVWxemFiWp8D+6cKwrLtCkWHkgi4kiQjJGiO5IBs/pGbQ
         dWPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769397877; x=1770002677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MjadraffcjHnZ1omdwki/WlhIF+4AlEylTjfkcUTkLQ=;
        b=lJ7hWuwnahUUBuYFOBGYnJyVZAauA3+UzCSGKQty0DQUgC2h2ezXaHseEfZUvaJQNc
         A6FMxjjTAzVdZGKEQt23JoZ/RmPlNMiBkEh90JiSQyambY8iJnBdWi7rVyTdXUEzvDOq
         hO9CWpC0YkjLlxWqszgkXiYIF1ydHKwQ5kYUsDnw5cXha7KF7KZ4eMAgpsWmVdNNMjFA
         vZl2JjNrmdUm0f929hOxHGJNMA3GGKQvbyBVRRCvGV2qVJF3T0aXzwF9JTyNzGfMk2yM
         JNhWKjntZNwDYphkcxHSONWqyXYoPdZAxONgV1aYm5A+jJSYQ6rd62np+LHLsbCNVcRW
         raOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769397877; x=1770002677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MjadraffcjHnZ1omdwki/WlhIF+4AlEylTjfkcUTkLQ=;
        b=qzXCC08zkbw8mTtwe/hWWxDzuwE2EbrY2GNAGRrg1g8UPQPJDLcUumkfB9MCNs31Eo
         gyMV50XWnNrWMBY6ru4vMbncMxVLtvaaqXOSXM4Z/n852hxJIQZkBc758SUtyYOdfIVE
         BobjrJOMcfTUwahfPdR+/55uX/8u1Vq+DXTSEKI2u+0Qbak7ZGv0NG4vTquPJ0XYCHRW
         oMZSS5g2YT2+2JnMB6+XtDdfgIjZNGWXWfMFM0zUuiUbbnLK5jXcRspVXgszGx6h7Iip
         hUzVbnhZShEoQc387kQzGQMAArWmfta6MHozY53plq/pA9WjSalby6pJz5ViDAjBCWFJ
         suNA==
X-Forwarded-Encrypted: i=1; AJvYcCXb8hBSRUd7RHnH3aVHksoSGHf9FzrbJuhZ+9iWVp+dWeFWxofxKDi2clV5GPU0VHzcKmK/vsr4nA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMPgJ2GaGzFXebaNW2R+0P7VXAT7hXRyotiGxPo0sVodTyK93X
	oi388fhoaVaEvFl9bwdtlAk3qjH1dT03Mdz9cJYa9nDxxyIPMCYdBTNg8pHMeituRpe07KKLM1u
	Ije1D+fheLMq6QVEEp0PFPaW1Lsg0jX9RtVrm
X-Gm-Gg: AZuq6aLJWxxOfl1rM8e2vOg3rrGGVZ6Eggw0Vnme221r49oR+NZs9ljj3TRE7QnDXXr
	okFk+yEX0voKV9MRJtul1y+cBees4b1W6yzUgjFmNHl9Yi31EOx6I7VdX++Kjk0a8fZbAHAoCf6
	nKSdp26GkChiyjXNPkAmpmveznGb20V8viQC6KFHC7uit2L4u7r7alJUiZu5UjvCOy5XO/Mh9Up
	gtHBs3+VnaELAZXLgCmi6nwkuvThmPy1Y5uYcdKSRtqQq2wV2XX019pbAhLcIt90Z2koJQK
X-Received: by 2002:ac8:59c9:0:b0:4ee:26e9:98ac with SMTP id
 d75a77b69052e-50314bdef26mr44186471cf.16.1769397877475; Sun, 25 Jan 2026
 19:24:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119015803.183-1-xuewen.yan@unisoc.com>
In-Reply-To: <20260119015803.183-1-xuewen.yan@unisoc.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Mon, 26 Jan 2026 11:24:26 +0800
X-Gm-Features: AZwV_QilCwCMV4HcK90wSEd0i-RKu0XqxXOPIZ5GC-lAKdqkxFKMlAgS_yLOJIs
Message-ID: <CAB8ipk93vxpuSF3msuryedefJ8v_4ZMrk56MFaGp8+Mh-EqnSA@mail.gmail.com>
Subject: Re: [RFC PATCH] thermal: power_allocator: Ignore cutoff when integral
 is less than zero
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: lukasz.luba@arm.com, rafael@kernel.org, daniel.lezcano@linaro.org, 
	rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com, jeson.gao@unisoc.com, di.shen@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-41445-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuewenyan94@gmail.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,unisoc.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 74A1E83AAE
X-Rspamd-Action: no action

Hi lukasz,

Do you have any comments on this patch?

Thanks!

On Mon, Jan 19, 2026 at 10:00=E2=80=AFAM Xuewen Yan <xuewen.yan@unisoc.com>=
 wrote:
>
> From: Jeson Gao <jeson.gao@unisoc.com>
>
> The cutoff means threshold below which the error is no longer accumulated=
.
> However, in some scenarios, this may cause performance degradation.
>
> For example:
> the control-temp is 85, the cutoff is 0 or other small value:
>
> If the current temperature frequently exceeds the set temperature,
> the negative integral will continuously accumulate.
> Over an extended period, this will result in a significantly
> large negative integral value, the positive integral can=E2=80=99t build =
up
> because of the cutoff. This makes the power_range very low,
> even if the temperature is already under the control target.
>
> So, if the err_integral is negative, ignore the cutoff to force
> add the positive integral.
>
> Co-developed-by: Di Shen <di.shen@unisoc.com>
> Signed-off-by: Di Shen <di.shen@unisoc.com>
> Signed-off-by: Jeson Gao <jeson.gao@unisoc.com>
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>  drivers/thermal/gov_power_allocator.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_=
power_allocator.c
> index 0d9f636c80f4..404ae1d75612 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -263,7 +263,8 @@ static u32 pid_controller(struct thermal_zone_device =
*tz,
>          */
>         i =3D mul_frac(tz->tzp->k_i, params->err_integral);
>
> -       if (err < int_to_frac(tz->tzp->integral_cutoff)) {
> +       if (err < int_to_frac(tz->tzp->integral_cutoff) ||
> +           (err > 0 && params->err_integral < 0)) {
>                 s64 i_next =3D i + mul_frac(tz->tzp->k_i, err);
>
>                 if (abs(i_next) < max_power_frac) {
> --
> 2.25.1
>

