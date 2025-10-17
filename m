Return-Path: <linux-pm+bounces-36365-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81708BEAF1E
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 19:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B76E1AE2F0C
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 17:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EECE2F7441;
	Fri, 17 Oct 2025 17:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="GHNvhdyO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CE52F619A;
	Fri, 17 Oct 2025 17:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760720451; cv=none; b=eob2BtUq53xPFs6EAqXEZvIosV6bZPy9XQ5rKZaN6HZ2w66gGbx7oBSiqQo7HsZTOZPRYZolK7ZSpZP4GLmag0DSiRB02Yb0tIubrMjtXjnwHuADusxOUVa6G5OnfYjdM6TrsWnKmcfysDcKrlqEo8+JfryQW0CLdlSFDMpTWUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760720451; c=relaxed/simple;
	bh=BDpQpTaK8FT02fLieU1z12t2UTrDwWO9TIsJNiEkQtc=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=n1PiDeulLLvJ7MUPJzZZPlS+1i9A2DRTDq4heinVoBdptXdsBk3Mzny1G+qeRL+C7EMSEVknFC2P0hk/QLf1aBfttBt3s/vdtLnDfQaASUF2gdhwBCG5mw3RYKkLTbe8FWQhaQNv3xh3sltontIuMDNWbGUSIL7z/pLi3Agb55I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=GHNvhdyO; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1760720425; x=1761325225; i=frank-w@public-files.de;
	bh=eKcQlBPjPB472NaD5zP4wHbT+w80iRDXssOS6Yp5LGU=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:In-Reply-To:References:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GHNvhdyOjKx9DEkuc+CiOWaxpTezwOpUD04IB3bEanFKTSB1DJ9dnzxwB5kx5hqp
	 371Cveqdw/s8uitSL3XvezoEw09EB8avPsYP5/BvDYOrGosn3muZyE+OOJC22IMou
	 x2eAuBXzkw1teioOmlM5iqfY7RNNljzBVLbM5YDE/eixiVbOjQ2pC9GLuItxYDxH+
	 YPp1rI6mRfsRau37u5uhwvbtTbsnF2cdoQY4bzXp0p+7fN+QXCOGGstXFjnDs1lLU
	 3G0p+7UEQLr/NAH+WkCDpdxhjpR1ZshR5K+zREH13ukMRAGsjH5/juSXxbYxkwb/g
	 H1XV068d9ZtymvCO1Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [194.15.82.42] ([194.15.82.42]) by
 trinity-msg-rest-gmx-gmx-live-654c5495b9-86l6j (via HTTP); Fri, 17 Oct 2025
 17:00:25 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-189d521f-e308-475e-a4bf-3821794cd216-1760720425043@trinity-msg-rest-gmx-gmx-live-654c5495b9-86l6j>
From: frank-w@public-files.de
To: laura.nao@collabora.com, srini@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, rafael@kernel.org,
 daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com
Cc: nfraprado@collabora.com, arnd@arndb.de, colin.i.king@gmail.com,
 u.kleine-koenig@baylibre.com, andrew-ct.chen@mediatek.com,
 lala.lin@mediatek.com, bchihi@baylibre.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com, laura.nao@collabora.com
Subject: Aw: [PATCH RESEND v3 0/9] Add thermal sensor driver support for
 Mediatek MT8196
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Oct 2025 17:00:25 +0000
In-Reply-To: <20251016142158.740242-1-laura.nao@collabora.com>
References: <20251016142158.740242-1-laura.nao@collabora.com>
X-UI-CLIENT-META-MAIL-DROP: W10=
X-Provags-ID: V03:K1:P+Yvh/yA0ff0Yl471I+mnmEBCSnB2JA4O9ZcySGW8hcqiIhGA76N3zud4wRV3OLMhC65r
 8fKbTK2sx2Xv2Q9sEwiMx/Fr1QVBPj2jardHsJ1KdI4Iv3nzb7SH8aWMjnnLIW81OTdGvyKxGfLM
 X1YiuUquo3wO+LMKewInBl0Eykwqowy3Rd4Bl4hTyTariZ4Dcnn5WY5N3Y054oPWuUI31DecW+TA
 Pd31FUGvCwaH7vek68jB6gih3xfut7pG7BQ7uFLeFnRwDMgFu0AKQJtB5uCsECKvWCjW7jccv1sH
 f/eTAM7O7lxjMFxrddAcW5J1gaDqKZo+gNqlI2WZ/ov7Srq8DUXMsv0gdz6TLdrvRo=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SjEZhVmOfL0=;mUu1hbKY9O2aQGd+FALgkn7YiZg
 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
Content-Transfer-Encoding: quoted-printable

> Gesendet: Donnerstag, 16. Oktober 2025 um 16:21
> Von: "Laura Nao" <laura.nao@collabora.com>
> Betreff: [PATCH RESEND v3 0/9] Add thermal sensor driver support for Med=
iatek MT8196
>
> This patch series extends the MediaTek LVTS thermal driver to support th=
e
> MT8196 SoC.
>=20
> MT8196 requires a different implementation of the lvts_temp_to_raw()
> function.
>=20
> To support this, the series introduces:
>=20
> - A new struct lvts_platform_ops to allow platform-specific
>   conversion logic between raw sensor values and temperature
> - A variant of the lvts_temp_to_raw() implementation
> - Platform data and controller definitions for MT8196

Hi

tested the series against mt7988 and mt7987 (support not yet upstreamed, s=
o added the necessary fields for it to my 6.17 version)=20
and it does not break these boards.

Tested-by: Frank Wunderlich <frank-w@public-files.de>

regards Frank

