Return-Path: <linux-pm+bounces-43516-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBVvHB8Dp2k7bgAAu9opvQ
	(envelope-from <linux-pm+bounces-43516-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 16:49:51 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6F41F2ECC
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 16:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8732E309B719
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2026 15:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673CE492501;
	Tue,  3 Mar 2026 15:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ItstUBvQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99E74921B7
	for <linux-pm@vger.kernel.org>; Tue,  3 Mar 2026 15:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772552843; cv=pass; b=chLRo3BTeUD9VPBAFN/y6W/XzOddwmUz60KAOJXSOVoXeHlnNWEO6v+IHqnLoT4WymejbNv5LKoPnI6aAiSLYY0jAENX7mz/yOApwzyfzZeP4w+UvGKVrq985irVVumFbNveGmfuo9QNMbT0zx2xdejIx/VyFhjx/gQ1427Tui4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772552843; c=relaxed/simple;
	bh=wZgekaKjKWhcsnBGlJkXxC6z3jyfRnUew/OlprWLgK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cYvwPlVveWZUB0TvUkb4LaaVZaCubQRMOnhqb7wvnlWr5H3JqWFaL+GyXWunh+h+a3G9j7btjJ2BZa9CnrffVVnegVbDV8X3afz6xsYmjYrk5a8oUWqFNe8HAMMcTwTh+iZeKpMeuSnp5PBRcAMlqAemOZ/pAL7cdhImSWlh98Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ItstUBvQ; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-389e2950f54so30759671fa.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2026 07:47:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772552840; cv=none;
        d=google.com; s=arc-20240605;
        b=C3WhXotRCw04jRzpvtUct0oA2c8l1qgMouE1cZNlkpExoBvHxOrdFRwkSY+jWHQMlT
         ZVrjdwK/penqQspH+HQ3ICRlXMnlYod++6CaA+l0uMrmEOJ1vLnfQKyoXpzyt4lC9d9M
         4QJx1UsDrjvfph+giSgBwCMo+vA2lD9i9QP/iyGHEeRfB/mwu33cUIBfhVsMCO7bKZJU
         A0sc3Rvp14omow1/5nKzExQ9UtUrP2hNz2yUE5eGjmtOqh97dQ3mNWaUMrdiPecmcgma
         d5zNH2ziavQ0TA6r5NE3UGYXtNJpso53qhl/miwibi4BBd6CPrqK8ahfPz35NCx9/a4N
         kW+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gD2a6WR3H4tVJC77g+1awJLOtzCGL8fqkwjycUOG98g=;
        fh=3uk1lUExJTjNtMOl6VONH7EW7SSm+iftnZmF7hyUqTQ=;
        b=f99fckn3VdowAIS+zu3QrwAAdZBWaTP/kHWan5xVIIAn2/2+64GlmYsBHkWX/Zrku8
         CQOM3uyp8mKZ6m3PUmMjn07JsJDc5q6bfwDl3socjoDAC5PT1qZRUZjhiScu1KAxn7el
         SD9UfXUSDkDXf5LRsPnXdHHFx8G2ORWe+j290OgH8SmnkKy3X9Gk51vIMzS7DhVk7TMl
         9pPeDaScOUYWVsYLO0/Bc16W3OaqPB01LTVakKu02VF35GINaXdNJH8kQb8hW2KVvfaH
         f43E5ysklFdQEmFfboLu1RJE6/P4I6QrY/xeJDLwBkMM++XSWaNfeWshxW64typ4O+aH
         50oA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772552840; x=1773157640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gD2a6WR3H4tVJC77g+1awJLOtzCGL8fqkwjycUOG98g=;
        b=ItstUBvQPLKoIc/LO/7+6ZRCCMedGbCw8BYF/81GD9AZhQniBlrS7Yyd0RnUwmO4CN
         ipY73t7d9Z4203zs1Ep29oGkAJWNn11oZvpG3vfbav+U7lHt3PFeJ0lR3QSnFrncdL7I
         7UUjU/vtUCjrOCAU7gQpGH+24seBvDtvJ+I9d75bUE8s3U5NlJEbrX8baSGFBfuBAn9C
         iJwp/6jmyx+nRfBRPz4X2hcLZIYK/Dl6Dxz+KvXxh78SBI4t3BmaFUuLOC++V6cb+AUm
         HFgipBNVyva/IOwoRtZjT7y0gkVTL+/X8O92I5kR99zRFZd+eOnS8cabzea0e12XZTbI
         hjjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772552840; x=1773157640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gD2a6WR3H4tVJC77g+1awJLOtzCGL8fqkwjycUOG98g=;
        b=cKXElpazkEfph0++qnnAyUopzuatiBEG3jrJ/10mONc8cJXB3+Ef2yg9VC2fTwZHaQ
         VWj6oiVK7WsskbfDrWfxI+dvNAHrw+pxIngOQwJQ9j2J8+Btjzs4e2UhFd4QUdDHBWoX
         n7FKlq+zcGsjD4lMW6ap7PeI13dkhMrX18Fk+H5O27ePR9sW05gDxa5JAWiPZ9IEccWL
         jskla4pDDFoIjH8cwHEcUItC2LABzDF57Sr2vUjygbsRu6zbVn59A4HtZd6Y7szJRWxM
         LNo1LXK0B/jTlQEqETjs0HTb2jCdYYJVGwr/GI5772fXkFnzGksOPdhUyjAmszn4s7ux
         qhuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXY2zI+SHl3drOtMfWvTweOI6ftI8HdcaodEvBWHDArHMkdx3GczSy3RxLYoayU7khgzRPK2kTQnw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXNKjW0O5jJXmMRSDZnvk99MNno35GN+R2iv4TGuT6rr3tYz8Y
	Igwz6SeB5KgWgutmGsCbDkNPq+uHCcFFtOle79EBtCOEWu+SnbTf8FJLcrrP08z4P7A3CsBCBe8
	QP2cSVOYkM7hl6w9I1hhR7gpAcOlrF15hbV3KjiapIw==
X-Gm-Gg: ATEYQzzY/2Gjc54w1qNoDeGbbpmhZ+30wFL24/CacdL5DH+p3XosYLzw3g/9STbpKnI
	hXHFAB7DPfp9LxISH+PBGaBdhWgXF3/AzNLyQ/i/z1bI+AMO2wvbkms1f3AgDHKykDQyIEhZcpJ
	DhiCd5jBtEAmEnzGB3ULR7eJQg2XkrgHq+OM753/UpOvluO/y80ZUMcIkcJfPWcwuY7NYtu7kl4
	wYG5tQr0P6hKh2K+sAiBsSPrLH9pWSroImMqiyZnbkfZ/k+arer0HeHtujHB337QUxS89ZJfW+M
	PcfjNB11foJGNB2uZSE=
X-Received: by 2002:a2e:ae0a:0:10b0:387:a16:ee83 with SMTP id
 38308e7fff4ca-38a1c40121emr16229581fa.11.1772552840006; Tue, 03 Mar 2026
 07:47:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205-gs101-pd-v5-0-ede49cdb57a6@linaro.org>
In-Reply-To: <20260205-gs101-pd-v5-0-ede49cdb57a6@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 3 Mar 2026 16:46:42 +0100
X-Gm-Features: AaiRm51Gkmd1147qVAzeBw_Z4HEuTsOKVPJKFQ1XaM2VqwFLZ9phmWOW4SQBHOY
Message-ID: <CAPDyKFpCCoCH+z8MGhf84zLQbQB-UFa+JxkxMCGxcHmcT_1M+A@mail.gmail.com>
Subject: Re: [PATCH v5 00/10] pmdomain: samsung: add support for Google GS101
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
X-Rspamd-Queue-Id: DD6F41F2ECC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43516-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Thu, 5 Feb 2026 at 22:42, Andr=C3=A9 Draszik <andre.draszik@linaro.org> =
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
> Bullet points 2 and 3 are new since version 4 of this series, and
> related changes are in patches 1, 2, 9, and 10. I can merge patch 9
> (SMC call) into the gs101 patch (patch 7) if preferred, but for now I
> kept them independent to make it easier to see changes compared to
> previous versions of this series, and because patch 9 actually applies
> to not only gs101, but to many newer Exynos SoCs, and to make patches 9
> and 10 themselves easier to review and reason about.
>
> The DT update to add the new required properties on gs101 will be
> posted separately.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---
> Changes in v5:
> - add domain-supply to binding (patch 2)
> - Link to v4: https://lore.kernel.org/r/20260128-gs101-pd-v4-0-cbe7bd5a40=
60@linaro.org

[...]

FYI, I have reviewed this and it looks good to me. Although, I am
awaiting a new version/confirmation about the last DT patch from Rob
before applying.

Kind regards
Uffe

