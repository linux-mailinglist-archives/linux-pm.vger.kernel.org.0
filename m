Return-Path: <linux-pm+bounces-42146-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OADbI8SHhGl43QMAu9opvQ
	(envelope-from <linux-pm+bounces-42146-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 13:06:28 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AB0F234B
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 13:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DE6953003BCF
	for <lists+linux-pm@lfdr.de>; Thu,  5 Feb 2026 12:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81513D3337;
	Thu,  5 Feb 2026 12:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aairm6CY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED763A7F40
	for <linux-pm@vger.kernel.org>; Thu,  5 Feb 2026 12:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770293182; cv=pass; b=o3jSMXGu0Sd+9lalw4cHKDM1TrxdTs852bpNVrwNIGbXj/RtAPBXeeYYNX5I9MPfY3/WLAHV0FZaxGHE1sdbmcSeQfIq1ZA+qpRa2BCMOwgW1mF+5wKzieUTTaVi3jbIrOdDtCBqWfPdRE+3XqVZbaBCy7AFJlHgg6Xy6Hg7SZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770293182; c=relaxed/simple;
	bh=epTizwofu6tUIWScFsKfhBb6Vw+PqSxYlpupgsKdrEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mbH93XmrqWVXBYxi+XTVN9vj0yghuCTemC35V37u/WbIkjMrxEkw3YnH0+6tgNgQIn0RV/fRDCXSuyyFlB6ATonymUabn78O/CAa6i8O0RbHeH5DveD1sHpFaSSHgWWkD3tzljMsGIeNlJhSl+H/lZDwMI4vVnhdqFwLkqcrrJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aairm6CY; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59ddf02b00aso1105062e87.0
        for <linux-pm@vger.kernel.org>; Thu, 05 Feb 2026 04:06:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770293180; cv=none;
        d=google.com; s=arc-20240605;
        b=ImXTXhAtN1m0/6MXqtNVmixA4P4OaAxP18vzFdcKQNjBa4qdNjQedhLr5sMnxWeCtN
         pNTiqS0MSHXcHnRhXnvQiUlgRF8F/3g/usMAQgDNHofKsMGbAjREUhzFakOzOgvDycDX
         xxogjElNxwtePnpL001laXx4RgITI8WJF6824onPsBfSVTlT+e2k9/AKVxYp1BMW3i5D
         WnZ9aoGHotTeHu3fDaQCon2KXBeA6k7BSq5lKqg1c5LTB4rfxWAfvRAUA2gh4PfFIia5
         5a7fl3cMyeSHD1dVMf8es3BfaB2OHK9N6/AMM7mPfNxQ4tfY8C1HIWvl6a6/ro3V4DcR
         JDfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cdO9CFNu6vQJNd/2WSszJmp2jWHwNCxretKor7RUNos=;
        fh=7zaOVW+cUoJa//ZSDuII3MYP75LzxSZJkQbbri5tD2k=;
        b=G9z/zhuD2OjrM6q/0LbYpdDKXIdNEJeCN8eOpEmeZeKhNdikrQgcGpqht2nqx6T+WW
         dt2izke9JLW0YvEfrt4y6UGo4pC3fVxcxIdKcq4IpeCkJlScW6t+Mns3Zb6vAabd32Ws
         spRVxDA+AvTcgTW+3f4AkoTdg40/HkATQzt3ydFdaadL0rERz1UflPq6qvSKzQyjRV2Z
         LpgkfeC4b8wplAq7/3TogVHJoDzVj+coujakwH2TN9iygEPuDvvCYAvmxZfIdpBm9GjO
         QioyrCJrZaesIVcgAuujvV3gzDiedU9390j28z+K/WXIPjhiNuceSd0jXvtfRDbi8TfO
         qx5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770293180; x=1770897980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdO9CFNu6vQJNd/2WSszJmp2jWHwNCxretKor7RUNos=;
        b=aairm6CYrP5gbN7adLgwmLaStWmc5LLpMxrDDWJwMASwSVvhYYiAfHD7jyQFa3bIZ6
         1pMdfMb033FVhAMlatLotidw/wGkIrrCEMXp7mSuUxL61cU1pVr5KEuoaKAQvfsH1bHZ
         mntNuXS1UGNs/n01EZTtTNQKoq8/Py67Xvc8jby00DCpLtWFhhbh6F+w79x7kJGV1eR3
         ryJHjBrVuL8qzWlABW3t9VDRH7s1IYMdOkjJdDKKFhKfA24QPLjCwmuKAHCxUv0KqcOK
         6dsZ+lVGfbXAuh8p7MUFfv5wkVX3CECmsVOk7GMyFHltmrMQDiSbY3zozUzoEal1/ch8
         VWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770293180; x=1770897980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cdO9CFNu6vQJNd/2WSszJmp2jWHwNCxretKor7RUNos=;
        b=QBBXqG7m4g+xWRPEHdl58Midi7f03wvX0nEj19Uy0Yd+WTG2uRbw9XaCuFGwppZYge
         ExMDl8/9YwAJUSg9sQlgNq6hZNugcFuyHil/Ldz502HaS3BTbY3xEI2jiwiKaq+Y17XP
         m0v81iqNv5xBjgsaXVMqnzZk3GceeYs3VSmYl2GCR+wsMJLSqp9qGNOSak4mQl0LXwzN
         X+xesc4vejpQXko2ZkHCGj2mLx1e7bq/N+P+XCM4v11Win7qHQuvX4eatelNgFAL84sr
         JDgjOIIIN9UiO63o4BgbOJBj2ZnOYcS51qCH96/GO+fjFc+UfP2REJMOEp0w5GTrDg/q
         uIFw==
X-Forwarded-Encrypted: i=1; AJvYcCWTcRArBnLYyrxGyBYCAIAKx5swEF3Y+U6Y2RSani1X3AaNXI/jkVzGfaqPi2nitK3EH36DBoKMUw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrp4ABGPRZk4peeSSL2szUDi0Pp0YvrHkKD4jDI3c3RHLzguPo
	vBtkjovieRDHNP+SUqRYPEOPG7Ji71HtZvSO0Q6EdBPrtktEI0d+T37TEvDfNlH5O5hD4Eriu4z
	dd63nVoSw8eXZlIt5lDbDPg2hTrhgmW9jiOotUkVOmw==
X-Gm-Gg: AZuq6aJKn8+4A8szJR1DcsrH6r6+7XhHSwu0tfJ2bjWGNKsWB2obql39dWKFdoncKpi
	9hVmwUiudUfjnZqPHHg7m2SzeY8uB11UmNl0Kzo1TctktRAZeAeDucEEvWfvaPvWAf2mxgRmJZx
	tg8bgk88o1xoe3g+HkXY6MzNsST2OGwbDGbkuzEX/JbKq8cUokgImOyLUiHvDymV3C1L9128EpW
	lMQ7B2RJxbSXh22dwmikgqYru2U/wnxLqDhSsInXIe5H1fsipujrm6XpvLyMxU12m0OoesY
X-Received: by 2002:a05:6512:10ce:b0:59d:ea35:bc8e with SMTP id
 2adb3069b0e04-59e38c2955bmr2270537e87.24.1770293180225; Thu, 05 Feb 2026
 04:06:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128-gs101-pd-v4-0-cbe7bd5a4060@linaro.org>
In-Reply-To: <20260128-gs101-pd-v4-0-cbe7bd5a4060@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 5 Feb 2026 13:05:44 +0100
X-Gm-Features: AZwV_Qio0mUxbt1hdbXGSjmWyyPdwpqKntqpt17Vt_Fu987EJSjXGSrypfMmYU0
Message-ID: <CAPDyKFoRXaiZiZw0NmmgnJzfw3sCYi1cNAuLHUU6fyF-4gxDuA@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] pmdomain: samsung: add support for Google GS101
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42146-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[kernel.org,samsung.com,gmail.com,linaro.org,google.com,android.com,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,linaro.org:dkim,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A5AB0F234B
X-Rspamd-Action: no action

On Wed, 28 Jan 2026 at 17:10, Andr=C3=A9 Draszik <andre.draszik@linaro.org>=
 wrote:
>
> Hi,
>
> This series adds support for the power domains on Google GS101.
>
> There are a few differences compared to SoCs already supported by this
> driver:
> * register access does not work via plain ioremap() / readl() /
>   writel().
>   Instead, the regmap created by the PMU driver must be used (which
>   uses Arm SMCC calls under the hood).
> * DTZPC: a call needs to be made before and after power domain off/on,
>   to inform the EL3 firmware of the request.
> * power domains can and are fed by a regulator rail and therefore
>   regulator control needed be implemented.
>
> Bullet points 2 and 3 are new compared to previous versions of this
> series, and related changes are in patches 1, 2, 9, and 10. I can merge
> patch 9 (SMC call) into the gs101 patch (patch 7) if preferred, but for
> now I kept them independent to make it easier to see changes compared
> to previous versions of this series, and because patch 8 actually
> applies to not only gs101, but to many newer Exynos SoCs, and to make
> the two patches themselves easier to review and reason about.
>
> The DT update to add the new required properties on gs101 will be
> posted separately.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---
> Changes in v4:
> - drop unneeded or already merged patches
> - drop patch "pmdomain: samsung: convert to regmap_read_poll_timeout()"
>   as Marek reported issues on some platforms
> - rebase
> - DTZPC related changes
> - Link to v3: https://lore.kernel.org/r/20251016-gs101-pd-v3-0-7b30797396=
e7@linaro.org
>
> Changes in v3:
> - use additionalProperties, not unevaluatedProperties in patch 2
> - fix path in $id in patch 2 (Rob)
> - drop comment around 'select' in patch 2 (Rob)
> - collect tags
> - Link to v2: https://lore.kernel.org/r/20251009-gs101-pd-v2-0-3f4a6db2af=
39@linaro.org
>
> Changes in v2:
> - Krzysztof:
>   - move google,gs101-pmu binding into separate file
>   - mark devm_kstrdup_const() patch as fix
>   - use bool for need_early_sync_state
>   - merge patches 8 and 10 from v1 series into one patch
> - collect tags
> - Link to v1: https://lore.kernel.org/r/20251006-gs101-pd-v1-0-f0cb0c01ea=
7b@linaro.org
>
> ---
> Andr=C3=A9 Draszik (10):
>       dt-bindings: soc: google: add google,gs101-dtzpc
>       dt-bindings: power: samsung: add google,gs101-pd
>       dt-bindings: soc: samsung: exynos-pmu: move gs101-pmu into separate=
 binding
>       dt-bindings: soc: google: gs101-pmu: allow power domains as childre=
n
>       pmdomain: samsung: convert to using regmap
>       pmdomain: samsung: don't hard-code offset for registers to 0 and 4
>       pmdomain: samsung: add support for google,gs101-pd
>       pmdomain: samsung: use dev_err() instead of pr_err()
>       pmdomain: samsung: implement SMC to save / restore TZ config
>       pmdomain: samsung: implement domain-supply regulator
>
>  .../devicetree/bindings/power/pd-samsung.yaml      |  29 ++-
>  .../bindings/soc/google/google,gs101-dtzpc.yaml    |  42 ++++
>  .../bindings/soc/google/google,gs101-pmu.yaml      |  97 ++++++++
>  .../bindings/soc/samsung/exynos-pmu.yaml           |  20 --
>  MAINTAINERS                                        |   2 +
>  drivers/pmdomain/samsung/exynos-pm-domains.c       | 254 +++++++++++++++=
+++---
>  6 files changed, 395 insertions(+), 49 deletions(-)
> ---
> base-commit: e3b32dcb9f23e3c3927ef3eec6a5842a988fb574
> change-id: 20251001-gs101-pd-d4dc97d70a84
>
> Best regards,
> --
> Andr=C3=A9 Draszik <andre.draszik@linaro.org>
>

I have looked through the series and it looks good to me. I will be
awaiting a new version and to get the DT patches acked, before I
continue to apply patches.

Kind regards
Uffe

