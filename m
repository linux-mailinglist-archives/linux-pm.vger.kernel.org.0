Return-Path: <linux-pm+bounces-43371-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLXUKY6zo2luKQUAu9opvQ
	(envelope-from <linux-pm+bounces-43371-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 01 Mar 2026 04:33:34 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5E91CE6DB
	for <lists+linux-pm@lfdr.de>; Sun, 01 Mar 2026 04:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 168583028347
	for <lists+linux-pm@lfdr.de>; Sun,  1 Mar 2026 03:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF56F311975;
	Sun,  1 Mar 2026 03:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SNdPxCyE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4004930F934
	for <linux-pm@vger.kernel.org>; Sun,  1 Mar 2026 03:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772336007; cv=none; b=MAbcajXXEtvJ6t3UlGwy3QNuBGa7cOLD49nl7qp+EXlHDuMcVBNLe3/ztUcG4ZA6GloXdgHewqwIs+wYusFPy+yK2qppiIVC+5PxPItnxhoUuFTrLyfwD6k2CseWEwffLXw5JJ89CAJsdOWqkmWvKBvNC5htPp89Cd3avLBjZ3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772336007; c=relaxed/simple;
	bh=ayLAhF7pHHy+DRWLU0LDkHIehJneX3wR7Rs2/wiMYj4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hxhMvKt6Uxw2iVL1h3Ym13swgmt6mekxNQVdH7I+W8I5Xm84gBzQg8B6JfSXUj3KVYcBFM0wRx4g9iz35OsLODlEqzLoC508yq/0h/EAVVlvomlLiWKz16r1Y66cOGXfedaQyL2FfFadIg04M/Dm7IO0fHiAY/YPWtOZUg/Nnhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SNdPxCyE; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4376de3f128so2248293f8f.0
        for <linux-pm@vger.kernel.org>; Sat, 28 Feb 2026 19:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772336004; x=1772940804; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGUtErtO1WheKt0/0USuDzWLghEWqZdNvFs6ivnvkR0=;
        b=SNdPxCyEn5zgt4YjRqNG62ApPSNudN9p6fa7NrUAyyLF7z7Ym5Ij2D0eQCNN/sWkIP
         uaCDPvL4UpOj6DoXdwU9ocfFknQ4Kf150mlSIx6VB50n2UoaKEidajHxtl8YM/wLyq+a
         yG8N3umw31HDo9sXc38ASNgJr/qxixial3FHHl6RNgaudBAotsaunsQRaL3yg6sNaOIs
         aj0O34ahYEU016z1/46A8egdec83HuYss3h2G4iQrELseAzTI8irsqYSkkIOcWVAFUw9
         p/MeJfdqnlCcBBWFWnnK1lokBF1n36H2m2tdMAkFXAd738Cm1B2C0uBskraxom1Nt3b1
         Z4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772336004; x=1772940804;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oGUtErtO1WheKt0/0USuDzWLghEWqZdNvFs6ivnvkR0=;
        b=WwdPfl7z0r5DuvrynabgyTW92EgFiGkhZ5CqQuzZ7l8rCH+w50DfK6En/lh7s5B8SC
         o/PwCBHtHUH55llqE5AnlfTDhAAEc8So+aKxCG2mV5pRREyTnYwfKq/nnuF2W7PqZwUS
         dZEGYE/ZFQIhIUtVg1u/WfBxOcDofU6Nu3a5mYAXQ83NXEHmxdnzKifmnH8tqSDoHjZ0
         nVITXxR2dWteyiRnUOpxb6nT0OAq4Pc54wRjkU7XiBjvTYlGetxTKo7lIea4No7q4wKu
         9RNxKSPbfwhrzjcN4Trk77cA7vZTyGorpV5GLUabifKKwXy5dJvh8mnNSopcKSO7gnY8
         730A==
X-Forwarded-Encrypted: i=1; AJvYcCUMn+Ai+Vdt8YANUTbubALQYnYym2MP5KSbl8ODQ7YfLxIHW2uVrhuWSThBXYr4dQ5GPKs5hAcOIw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtOjiprPaBBUcuZaqVKWUNO47U7hQQdKrxRDr08gIjtY56uet4
	4ukOQij2roCi8XjUohOD2uwkcbIleEwgzl5c4kFE+nROlwO13XGfZnE1lbK15GO01dI=
X-Gm-Gg: ATEYQzwDOfl2a0UGcVXg77mV+xIUeaW4i45ryJyyFnD6kQSNFBSp9GepIDmYPflyKbf
	PoFL957KTlg9ofXn0k/ThPLNnSpwc0vrz+nuHV9bO1Du26xJwySABiAOnxwplvNXD2kKLNNO8ZI
	khjTLot0a9kp08zHo8Y++oj1kTOLngdd0KN/ab0qy1+ieDuE0Gtda95aloRM/PRFntJ7bV2rklp
	DSSaPmKbp8T4rCwbH2Vi16P/AFHsZ3G4c1WaLVAdOseQcpgLWWfI1RZJCmjrPhZym7EBYdDCPqZ
	eVuHGufCW0G58eHEI+EIYUzpzxu9x4ty4Dafwrz32jUtIukxHFKd0i7dgcLLLeB06Yf6b7XSZtz
	ASBKPoPV2TlAB6ZtsyM4cqXPkpb6XJlOZKC1GWp4PMx6Ji0R83FW0K27zixc8Jx57rp7lYBDva7
	qR+aPxWVYcpOFUgtFz8GfZCeAwuaj20AAACxO6pHvHGo0eyepxnX2NFgvFr00Rq2N2yWoLTFrgj
	G4iIPw+bbDb5VeTtA==
X-Received: by 2002:a05:6000:2dc6:b0:437:6963:a115 with SMTP id ffacd0b85a97d-4399de2ca49mr12536069f8f.42.1772336004517;
        Sat, 28 Feb 2026 19:33:24 -0800 (PST)
Received: from localhost ([2a02:c7c:5e34:8000:6ece:b3d1:ab81:6eaf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b03db76bsm2970858f8f.18.2026.02.28.19.33.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Feb 2026 19:33:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 01 Mar 2026 03:33:23 +0000
Message-Id: <DGR4OFNJXOI2.3QACIHMM1V429@linaro.org>
Cc: <willmcvicker@google.com>, <jyescas@google.com>, <shin.son@samsung.com>,
 <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v2 4/7] thermal: samsung: Add support for GS101 TMU
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Tudor Ambarus" <tudor.ambarus@linaro.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Daniel Lezcano" <daniel.lezcano@linaro.org>, "Zhang
 Rui" <rui.zhang@intel.com>, "Lukasz Luba" <lukasz.luba@arm.com>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzk@kernel.org>, "Alim Akhtar" <alim.akhtar@samsung.com>, "Bartlomiej
 Zolnierkiewicz" <bzolnier@gmail.com>, "Kees Cook" <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, "Peter Griffin"
 <peter.griffin@linaro.org>, =?utf-8?q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>
X-Mailer: aerc 0.20.0
References: <20260119-acpm-tmu-v2-0-e02a834f04c6@linaro.org>
 <20260119-acpm-tmu-v2-4-e02a834f04c6@linaro.org>
In-Reply-To: <20260119-acpm-tmu-v2-4-e02a834f04c6@linaro.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43371-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[linaro.org,kernel.org,intel.com,arm.com,samsung.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexey.klimov@linaro.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:mid,linaro.org:dkim,linaro.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EF5E91CE6DB
X-Rspamd-Action: no action

On Mon Jan 19, 2026 at 12:08 PM GMT, Tudor Ambarus wrote:
> Add the thermal driver for the Google GS101 SoC.

Is this driver for GS101 platforms only or for all Exynos-based
platforms where we have deal with thermal unit via ACPM?

> The GS101 TMU utilizes a hybrid management model shared between the
> Application Processor (AP) and the ACPM (Alive Clock and Power Manager)
> firmware. The driver maintains direct memory-mapped access to the TMU
> interrupt pending registers to identify thermal events, while delegating
> functional tasks - such as sensor initialization, threshold configuration=
,
> and temperature acquisition - to the ACPM firmware via the ACPM IPC
> protocol.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/thermal/samsung/Kconfig    |  16 +
>  drivers/thermal/samsung/Makefile   |   2 +
>  drivers/thermal/samsung/acpm-tmu.c | 643 +++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 661 insertions(+)
>
> diff --git a/drivers/thermal/samsung/Kconfig b/drivers/thermal/samsung/Kc=
onfig
> index f4eff5a41a84ce02b12abb85d6a0f8818031d0dc..5679dfa85f4079c7d40317ac2=
31bd6a1af93c7e7 100644
> --- a/drivers/thermal/samsung/Kconfig
> +++ b/drivers/thermal/samsung/Kconfig
> @@ -9,3 +9,19 @@ config EXYNOS_THERMAL
>  	  the TMU, reports temperature and handles cooling action if defined.
>  	  This driver uses the Exynos core thermal APIs and TMU configuration
>  	  data from the supported SoCs.
> +
> +config EXYNOS_ACPM_THERMAL
> +	tristate "Exynos ACPM thermal management unit driver"
> +	depends on THERMAL_OF
> +	depends on EXYNOS_ACPM_PROTOCOL || (COMPILE_TEST && !EXYNOS_ACPM_PROTOC=
OL)
> +	help
> +	  Support for the Thermal Management Unit (TMU) on Google GS101 SoC.
> +
> +	  The TMU on GS101 is managed through a hybrid architecture. This drive=
r
> +	  handles direct register access for thermal interrupt status monitorin=
g
> +	  and communicates with the Alive Clock and Power Manager (ACPM)
> +	  firmware via the ACPM IPC protocol for functional sensor control and
> +	  configuration.
> +
> +	  Select this if you want to monitor device temperature and enable
> +	  thermal mitigation on GS101 based devices.

I don't understand this. What this driver actually supports/implements?
Dealing with TMU over ACPM firmware is not exclusive to Google GS101 SoC,
some other Exynos-based systems has this as well. However, it names
the config option EXYNOS_ACPM_THERMAL but a lot of other things say that
it is only for GS101, isn't it?
Does it implement the generic layer dealing with TMU via ACPM (hence the na=
me)
and adds specific things to support gs101?

Should it be something like this (feel free to correct):
Support for the Thermal Management Unit (TMU) exported via ACPM.

This driver handles direct register access for thermal interrupt
status monitoring and communicates with the Alive Clock and Power
Manager (ACPM) firmware via the ACPM IPC protocol for functional
sensor control and configuration.

Select this if you want to monitor device temperature and enable
thermal mitigation on Exynos-based devices that implement dealing
with TMU via ACPM, for instance, GS101-based devices.

?

[...]
Best regards,
Alexey

