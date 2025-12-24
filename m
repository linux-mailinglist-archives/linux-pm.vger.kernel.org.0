Return-Path: <linux-pm+bounces-39921-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11811CDD0B6
	for <lists+linux-pm@lfdr.de>; Wed, 24 Dec 2025 20:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CFDC3021E6C
	for <lists+linux-pm@lfdr.de>; Wed, 24 Dec 2025 19:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB931917F0;
	Wed, 24 Dec 2025 19:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="SN+ObwVE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F83632;
	Wed, 24 Dec 2025 19:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766604694; cv=none; b=EGeijRr/njqq3CuyUj+DoN70iug7EVmmd6JRrMvQsRxtclT/Fqj1A+pD40TJHOQya0mnH/o6PNUl3jyMSZucKhjd8ZpIsGYpiWFa6/MW4NzIdyEMmFpn8A3VZqRydldjIMgCBa1yLbGO8tVTyv4Nab4dYDyAfaz9Q6QFM/Tc5Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766604694; c=relaxed/simple;
	bh=laVChJNHDMAEia3D9tY89qEJGVGUm43S0WNZqN+Tr7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kRWt/4YcoJN85+4PDOIfTR2YJjW4i7GHfksLEMjb4uv/7+wvCb4Fm2e9e3PPFlWO4u607tFJxF6oBXCML4cSezsQ9DuF1hV2hrGGaXRKuG4NData9PBl1GQUPm1/riDQSXP102xdbeT+9vgJxSv1wzag4GoXBBtF8Y88N9eIp2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=SN+ObwVE; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
DKIM-Signature: a=rsa-sha256; bh=laVChJNHDMAEia3D9tY89qEJGVGUm43S0WNZqN+Tr7Q=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1766603684; v=1; x=1767035684;
 b=SN+ObwVEF/zqznQv8SvkdHWJchtv4GCvgsa382pLIH7l8wzC8eYH3kBZ7/0xHo4i+qs04no5
 Il8QHjJoYawDMSXY31NNLJhoRymV94nQcxMthyZJdFRfiji+8fAIs4pMWdvvIIb8cqTtAzyQtDn
 vUL3sHnn8/6kmN5+whf+aD/Bq+XlxUnXlA14p7cRDWed9x2wDr+2eO+eMUf+lXi0p8ZNRx3Xqaa
 pv6GPsm3Vxyo0Reysvn2I6gTAcxhP3V9JwpD2nPvkZI+IZSbsiVcEzgcGkIgJVN6ptqr9EnX6O3
 P4u7mDsLoamS3zCPGSiR7GwgYHEuuy+kIRPOEngKACxVw==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id d4a10bf5; Wed, 24 Dec 2025 20:14:44 +0100
From: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <duje@dujemihanovic.xyz>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Karel Balej <balejk@matfyz.cz>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 Karel Balej <balejk@matfyz.cz>
Subject:
 Re: [PATCH v2 2/2] pmdomain: add audio power island for Marvell PXA1908 SoC
Date: Wed, 24 Dec 2025 20:14:43 +0100
Message-ID: <5977726.DvuYhMxLoT@radijator>
In-Reply-To: <20251213084843.7491-2-balejk@matfyz.cz>
References:
 <20251213084843.7491-1-balejk@matfyz.cz>
 <20251213084843.7491-2-balejk@matfyz.cz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Autocrypt: addr=duje@dujemihanovic.xyz;
 keydata=
 mDMEZokhzhYJKwYBBAHaRw8BAQdAWJZ0hsI/ytTqHGFV8x6tzd5sB596cTeeDB4CQsTf+wC0KUR
 1amUgTWloYW5vdmnEhyA8ZHVqZS5taWhhbm92aWNAc2tvbGUuaHI+iJkEMBYKAEEWIQRt/0HWDf
 MUtbdrpjCtMZNSRY+tAwUCaJ5XkSMdIEFkZHJlc3MgYm91bmNlcyBhcyBvZiB+MzEvMDgvMjAyN
 QAKCRCtMZNSRY+tA/N/AQDth3Xl3wNcETvWPqqfYfyw4BFqbOD05A/W0/G0ZIjFzgD+PZVts3sN
 p5WuEwIxUrWxwavWJQBJwhXeWdru5ol82gmImQQTFgoAQRYhBG3/QdYN8xS1t2umMK0xk1JFj60
 DBQJmiSH/AhsDBQkJZgGABQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheAAAoJEK0xk1JFj60Dlw
 8A/i4lPOL7NaYoYePDql8MaJaR9qoUi+D+HtD3t0Koi7ztAQCdizXbuqP3AVNxy5Gpb1ozgp9Xq
 h2MRcNmJCHA1YhWAbQoRHVqZSBNaWhhbm92acSHIDxkdWplQGR1amVtaWhhbm92aWMueHl6PoiZ
 BBMWCgBBFiEEbf9B1g3zFLW3a6YwrTGTUkWPrQMFAmaJIc4CGwMFCQlmAYAFCwkIBwICIgIGFQo
 JCAsCBBYCAwECHgcCF4AACgkQrTGTUkWPrQPUYAEAlVKitl0w6Wun+hC0JIf8bnc0TnrH8kcDxV
 f5lAF38fcA/j8RxR/p558NTFUyHZt2Sa5AqxVkaA4aJekySytWe1YGuDgEZokhzhIKKwYBBAGXV
 QEFAQEHQMRz0l4Dnk6Vl9YqC+ZGDDpr8SkFDyYOXqdBMGad3VccAwEIB4h+BBgWCgAmFiEEbf9B
 1g3zFLW3a6YwrTGTUkWPrQMFAmaJIc4CGwwFCQlmAYAACgkQrTGTUkWPrQMbkwD+K6jiXYYMRnV
 l/5dpL//wXB1cM72ceR9tXYweMXg1lfABAOugzMF0xypW9zwYAEWVNOAaPsqtEPPYfBY3IXxl6m
 sB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Saturday, 13 December 2025 09:48:13 Central European Standard Time Karel=
=20
Balej wrote:
> Define power domain which needs to be enabled in order for audio to work
> on the PXA1908-based samsung,coreprimevelte smartphone. In the
> downstream code, this power-on method is marked as specific to the ULCx
> series which is allegedly a codename of sorts with ULC1 corresponding to
> the PXA1908.
>=20
> No other audio components needed for sound to work on this phone are
> currently available mainline but some successful testing was performed
> with the vendor variants of the respective drivers and with the domain
> forced always-on.
>=20
> Signed-off-by: Karel Balej <balejk@matfyz.cz>

Reviewed-by: Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz>

Regards,
=2D-
Duje



