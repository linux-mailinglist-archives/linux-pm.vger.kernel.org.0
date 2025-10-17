Return-Path: <linux-pm+bounces-36328-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC5FBE6BDB
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 08:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0FC094F64DF
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 06:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562D430FC29;
	Fri, 17 Oct 2025 06:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WokAg896"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A839224234
	for <linux-pm@vger.kernel.org>; Fri, 17 Oct 2025 06:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760683417; cv=none; b=bg5ezdMSB1GptuKsq7Cx5oGCMYgXA0m5wqfN2ZNfmYuptI2N+iOCWzrCwvAQ4nTopS00jx63gqpjOKfNfhkkP80yUBPrvJtB0djffwCyGd/8eBoaSoP91E6ttZv2X0TEKaEtyCzBPfoosuLkG1SGBXGYYGRI2FJ56IxTQfseWxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760683417; c=relaxed/simple;
	bh=goiNe26JI97XimIaJqB0nQh2LC62mtWHX8LAPMghZtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Cf8o5RTW+3QyMkzyrTgeTeiD42Rtir3ojMdQQQgCxYyTzKsSH1CBIsnJAhDhdUUQWF5dmRYPF9Bb5EBx4YnuZkGNRiMT5KxdlQx6KBNv2ywLmOLvN6ENSqjd2i2t/ypQ/qYz646xsK6WZTp+wCHLI6Y1OrhCcTy3ZqoWZRtLQ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=WokAg896; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251017064327euoutp027d49e16813edd60d59c04af49e89b65c~vNDsHaR3_1864218642euoutp029
	for <linux-pm@vger.kernel.org>; Fri, 17 Oct 2025 06:43:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251017064327euoutp027d49e16813edd60d59c04af49e89b65c~vNDsHaR3_1864218642euoutp029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1760683407;
	bh=pmOERI3SUEXraCgPIeHw+QXcfM6eSSu/gHX94UGDCzg=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=WokAg896tCCv63IRBiccsVar42fKcVYzFnOA+JFwG5K7FKWRIYNZZQonCiKxs0uq6
	 Q3HXOXddKG6MYJL9GkAUI+7PeTOk69m0xIFW1kjpd1kLduazEoiyVrEwE+7VhyrFrQ
	 iUy4xUJnQ63u9uz54QPWZkDuZ/oHClyNGxJIUWFU=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20251017064327eucas1p29f30c1de202c52dc09548aa9fc6f54b7~vNDrsbPeZ1312513125eucas1p2d;
	Fri, 17 Oct 2025 06:43:27 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251017064324eusmtip201695dfb1cec04fbd125e4f2c643fd35~vNDpvJ8tS0730207302eusmtip2G;
	Fri, 17 Oct 2025 06:43:24 +0000 (GMT)
Message-ID: <1731abfc-c7e4-4ff0-a1b3-7d86c8025866@samsung.com>
Date: Fri, 17 Oct 2025 08:43:24 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v3 00/10] pmdomain: samsung: add supoort for Google
 GS101
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, Krzysztof
	Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Rob
	Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Krzysztof
	Kozlowski <krzk+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus
	<tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>,
	kernel-team@android.com, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	stable@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20251016-gs101-pd-v3-0-7b30797396e7@linaro.org>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251017064327eucas1p29f30c1de202c52dc09548aa9fc6f54b7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251016155848eucas1p193debe70e38b1694bfb250d748f4aa14
X-EPHeader: CA
X-CMS-RootMailID: 20251016155848eucas1p193debe70e38b1694bfb250d748f4aa14
References: <CGME20251016155848eucas1p193debe70e38b1694bfb250d748f4aa14@eucas1p1.samsung.com>
	<20251016-gs101-pd-v3-0-7b30797396e7@linaro.org>

On 16.10.2025 17:58, André Draszik wrote:
> This series adds support for the power domains on Google GS101. It's
> fairly similar to SoCs already supported by this driver, except that
> register acces does not work via plain ioremap() / readl() / writel().
> Instead, the regmap created by the PMU driver must be used (which uses
> Arm SMCC calls under the hood).
>
> The DT update to add the new required properties on gs101 will be
> posted separately.
>
> Signed-off-by: André Draszik <andre.draszik@linaro.org>

Works fine on existing Exynos based boards.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
> Changes in v3:
> - use additionalProperties, not unevaluatedProperties in patch 2
> - fix path in $id in patch 2 (Rob)
> - drop comment around 'select' in patch 2 (Rob)
> - collect tags
> - Link to v2: https://lore.kernel.org/r/20251009-gs101-pd-v2-0-3f4a6db2af39@linaro.org
>
> Changes in v2:
> - Krzysztof:
>    - move google,gs101-pmu binding into separate file
>    - mark devm_kstrdup_const() patch as fix
>    - use bool for need_early_sync_state
>    - merge patches 8 and 10 from v1 series into one patch
> - collect tags
> - Link to v1: https://lore.kernel.org/r/20251006-gs101-pd-v1-0-f0cb0c01ea7b@linaro.org
>
> ---
> André Draszik (10):
>        dt-bindings: power: samsung: add google,gs101-pd
>        dt-bindings: soc: samsung: exynos-pmu: move gs101-pmu into separate binding
>        dt-bindings: soc: samsung: gs101-pmu: allow power domains as children
>        pmdomain: samsung: plug potential memleak during probe
>        pmdomain: samsung: convert to using regmap
>        pmdomain: samsung: convert to regmap_read_poll_timeout()
>        pmdomain: samsung: don't hardcode offset for registers to 0 and 4
>        pmdomain: samsung: selectively handle enforced sync_state
>        pmdomain: samsung: add support for google,gs101-pd
>        pmdomain: samsung: use dev_err() instead of pr_err()
>
>   .../devicetree/bindings/power/pd-samsung.yaml      |   1 +
>   .../bindings/soc/google/google,gs101-pmu.yaml      | 106 +++++++++++++++++
>   .../bindings/soc/samsung/exynos-pmu.yaml           |  20 ----
>   MAINTAINERS                                        |   1 +
>   drivers/pmdomain/samsung/exynos-pm-domains.c       | 126 +++++++++++++++------
>   5 files changed, 200 insertions(+), 54 deletions(-)
> ---
> base-commit: 58e817956925fdc12c61f1cb86915b82ae1603c1
> change-id: 20251001-gs101-pd-d4dc97d70a84

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


