Return-Path: <linux-pm+bounces-43640-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCqoIS/9qGmD0AAAu9opvQ
	(envelope-from <linux-pm+bounces-43640-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 04:49:03 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DED820AA96
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 04:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B5EC301809F
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 03:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A6E28506A;
	Thu,  5 Mar 2026 03:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gjkivRK4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744D1280014
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 03:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772682535; cv=none; b=WYIliBvhy8CGUBapiI2zdbpk75wu7PgOEIDkIzUmLGgBZZgyzxFRrKbW+JfxumB2DhlgZAyEZ6w1dguw4XhZFrLvNvvBSXSh/1SF5UyqgevZKSEPRZZKKl8IgckVc1nLuHqulxUX6UY7Dn0VeeKL+fM4YDtMq9o6LuwbnaNPzP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772682535; c=relaxed/simple;
	bh=jx3lwOAjNIKx1JbYIv0BtRGFivcMlAcPGHDzLTlQtjI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=pQSE6JaiC7xifpkATuRIb7hmK2qRx95z5LbGwpzKW6mkd3uqPv+TF41Ph8RtPEcm5egG9AAQuRFxqdJ0KBOrhCoRyofnZsGWr6hy5d8NXC4h0PLC6gFB6KS/jkqHlJyvT1N19UIsP8B9HclpJ0Bfb5gvKuHWL6stitKpaqpTRoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gjkivRK4; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4806bf39419so62342395e9.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 19:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772682532; x=1773287332; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/oY6Lj6y92CrkHBsRn24dqJ3yooac2+GrQjHYegtCQ=;
        b=gjkivRK45AnC9Igxx9p4UKj/JvRH2NABuOGwO1JRqKryKPTFUtSe3GgBRfcXfto3xz
         vtV9e/gYP+mfUsoxeRJHCHinrSINtxgicTgnExJLvP74okQV22U3K3HQETHR/nT7F2xc
         5Wfm+Nj+DMFqTAzAY1qgRwunnQOJKwPeaJ3K60xRu5bqIEodp5P8hLfuYsoYJP98PhA/
         eSxevyb6su59LR9lQtRKwH2OpTVNREfzXDo9sPI2qBbNLXITFFxEl5m+3FfMqMPiA/3C
         InYubynMqSHsoiDH7lti6q9DvCX0yg5VLOkvf9nLQQCI0kJhW72GVzgpwCEldzW4DwJI
         QX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772682532; x=1773287332;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m/oY6Lj6y92CrkHBsRn24dqJ3yooac2+GrQjHYegtCQ=;
        b=rz98udFfE2avlXMFyaTaRNQ+AF1I69Gmt5608uZBghzJpy4fd9P8Mh0jwV04IvwLYd
         9VBnkX4jVLstEXCES7FJyi9AkG6FLTC9EKpcoKDm3ALUsWE7CeB2+mYrZ2nDNa0SyLuo
         t/xnj0aSmfkL5wKqXnd81H4Il4s/Y94Na0cbq1ZyYZFMgBHGYI7Z4dcxZxLM2TmLwmcP
         pc5z9s5PK+7u4HtsoiEr5a9WQymn5TVYxlv+QUFhBBpxHKOE8bVXpLlE3sv63SjOjWr2
         hgMvtCV7wGNxfs/8rcBtEQ5QAzdshN8XuyMhFGFp8yXJaVZQ0meTw4MjJhDVZygmDQBr
         YAWg==
X-Forwarded-Encrypted: i=1; AJvYcCXu1ASQ2x5pEBaxFawkpGvmXvATXoh319EoPNbOvrFvHJfC3rfAreNsG5iloQ8yWVdevftW6rOPCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpooWpGaXVVlsRhgQBKzDYFOznUuAEIAg3CLoeq6DI046IOXAe
	a5V5mlHrkXUt3Mr4XZcNoKXjuywaIwQw5Lq9QFWOP0Auntnmb6R5J3JoTB7E70nRHag=
X-Gm-Gg: ATEYQzzpNnYUsBzuNTiUltvJ0nblWur2RS7nAIvC+J5/OsXmi7VY6+qQgVPzIqeZt65
	HEIyb2MH36rv5lmH6zn4bIwj+onWtTloLGsl747qxHdtAD6Dfe6tlZamr8SkqmWawPHxgKC7a/v
	4F3vZM/0t1/nnDng3Oxyw7AD3xobaLDIVJ4qi2MHWqgAk/pUf/79jdSwElugQfldIXuiHmVLuSr
	KSqtfTF4ld2xFHY8ir3ems7yLHbdM2lmb6bAN7vzNaO9jXcuoBKKUV8h0cVUNXrbbp4V7QCfZhv
	LEK/F/vqqrOVsmrjO7DnOA88VgAVjfPUo729D/pib7AjDBJeh1lJ1ArNyD7fBAflJGFqgRFPkYx
	JHzeZsMBjqWlC8VKfadHXz80DiTmSGf9oGiZxKTI+NaVLkr9B+gvUx8pClqRTp/WT4DFZKXn4hG
	DMAt/trjd/y6axlUWLAmKo4p1T8zBmGtVczMeUmQ5hDig/eokqS7wx3XKtU+O7ikMTG1/wbYT+z
	mFwtawyWG8r1wX5QA==
X-Received: by 2002:a05:600c:a08b:b0:479:13e9:3d64 with SMTP id 5b1f17b1804b1-4851eea3fd6mr10898135e9.15.1772682531768;
        Wed, 04 Mar 2026 19:48:51 -0800 (PST)
Received: from localhost ([2a02:c7c:5e34:8000:7406:79df:b00c:2c64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851fae02a8sm16711195e9.5.2026.03.04.19.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 19:48:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Mar 2026 03:48:49 +0000
Message-Id: <DGUJIFLIOK7Y.1Q4PZQU3MOWTT@linaro.org>
Cc: <willmcvicker@google.com>, <jyescas@google.com>, <shin.son@samsung.com>,
 <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v2 1/7] dt-bindings: thermal: Add Google GS101 TMU
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
 <20260119-acpm-tmu-v2-1-e02a834f04c6@linaro.org>
In-Reply-To: <20260119-acpm-tmu-v2-1-e02a834f04c6@linaro.org>
X-Rspamd-Queue-Id: 2DED820AA96
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
	TAGGED_FROM(0.00)[bounces-43640-lists,linux-pm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linaro.org:dkim,linaro.org:email,linaro.org:mid]
X-Rspamd-Action: no action

Hi Tudor,

On Mon Jan 19, 2026 at 12:08 PM GMT, Tudor Ambarus wrote:
> Document the Thermal Management Unit (TMU) found on the Google GS101 SoC.
>
> The GS101 TMU utilizes a hybrid control model shared between the
> Application Processor (AP) and the ACPM (Alive Clock and Power Manager)
> firmware.
>
> While the TMU is a standard memory-mapped IP block, on this platform

this ^^

> the AP's direct register access is restricted to the interrupt pending
> (INTPEND) registers for event identification. High-level functional
> tasks, such as sensor initialization, threshold programming, and
> temperature reads, are delegated to the ACPM firmware.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  .../bindings/thermal/google,gs101-tmu-top.yaml     | 67 ++++++++++++++++=
++++++
>  1 file changed, 67 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/thermal/google,gs101-tmu-t=
op.yaml b/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.ya=
ml
> new file mode 100644
> index 0000000000000000000000000000000000000000..b09e1ff5d89194b570810a042=
c75836ca2e53950
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/google,gs101-tmu-top.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Google GS101 Thermal Management Unit (TMU)
> +
> +maintainers:
> +  - Tudor Ambarus <tudor.ambarus@linaro.org>
> +
> +description:
> +  The Google GS101 TMU is a thermal sensor block that supports both dire=
ct
> +  register-level access and firmware-mediated management via the ACPM
> +  (Alive Clock and Power Manager) firmware.
> +
> +  On this platform, the hardware is managed in a hybrid fashion. The
> +  Application Processor (AP) maintains direct memory-mapped access
> +  exclusively to the interrupt pending registers to identify thermal
> +  events. All other functional aspects - including sensor
> +  initialization, threshold configuration, and temperature acquisition
> +  - are handled by the ACPM firmware. The AP coordinates these
> +  operations through the ACPM IPC protocol.

Is it Google TMU hardware block or Exynos/Samsung TMU block?

My understanding at this point is that ACPM interface, ACPM protocols, etc
appeared on Samsung SoCs before gs101 (maybe even before initial SCMI
prototyping). It looks like ACPM firmware, communication via mailboxes,
TMU channel, dealing with TMU behing ACPM, etc are actually a standard
Samsung Exynos architectural feature, rather than a Google-specific
implementation. I can't say though what was the first chipset where it
was implemented.

Given that this is a Samsung design that predates the gs101, would it
make sense to use more generic name for this binding to reflect that
it is Exynos-derived? That would save us from generalizing things later
(if it happens, and I hope it happens).
I was thinking that name for this schema could be smth like:
samsung,acpm-tmu.yaml or samsung,exynos-acpm-tmu.yaml or whatever works.

Thanks,
Alexey


