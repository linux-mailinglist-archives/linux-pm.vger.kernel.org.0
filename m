Return-Path: <linux-pm+bounces-32414-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 336F0B27171
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 00:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB607725281
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 22:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D504A27FB0E;
	Thu, 14 Aug 2025 22:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="RW4vGmT3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FDE23BCEE;
	Thu, 14 Aug 2025 22:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755209412; cv=none; b=iTPDmYHf5BSEacUBFYlJLTVgxv7Ki1hLEDzjHlKO36X03vq776D7UVBFDS+y9duV49GOccn5AZkJOTLiFj0iJEW3u7Xup4JGvxlotjsJpyydL55KBly48LdmiCURO9apuOK5L3H44MqvCb9LbLZ+w63F+aSctHDvhPiQtv1JZYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755209412; c=relaxed/simple;
	bh=73+i7s5/6//7zCSSfaQ+2ayeMbsLNPENCWgflm8i12w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hDuucB5ryk6gAlCFC9qLAXOoWhP4cAEJo6MrGuUF0j0ELlAMFIKEq4awuz+EMBIi9z1rtFPeQR6FDRKLmNEbXEzT1Ft0ns/hI20CvaThoobvOlKyjrwXmYiWY5UsuqFIrJIwYa8X2doHJwVIMiV9GKw749ZLWaWSkXdk76/DGQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=RW4vGmT3; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
DKIM-Signature: a=rsa-sha256; bh=4I4y9p6g8uF8af8xJlIXiua7qXTwOk9TC6eFyAo4fSU=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1755209309; v=1; x=1755641309;
 b=RW4vGmT3R7bc2vG9KFYpnuFLleUhLnYO+7xmmnOO0qdejks4AnsXnAKLztVj3Zok4BR+BaR8
 qYT7D32NS5vPehpUhEJ0PnzmKeHK3wBbJDuuiZ1i0yXx8LUtiZlh554u9JwAQrlIcc5wzZuxNFa
 333pGYlnUW/r8vBL9RcmcoEFlOp1d2xkyKfegGcSwQcrz2IWdXxEUxW6JGCmqkyNXgu1KD+XxMz
 oz8x/c9TjraSLSa16/Idxa8o+qGdnStRy4QPuCp7XtpHUKf+VIvQa268KD2WQGpCe3zSDljGll3
 PMGvK+jX3bMshWzcDkRHDGMmY2kWOLzLj/AcgvT6NiOJw==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id f24866f2; Fri, 15 Aug 2025 00:08:29 +0200
From: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <duje@dujemihanovic.xyz>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, David Wronek <david@mainlining.org>,
 Karel Balej <balejk@matfyz.cz>, phone-devel@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH RFC 2/5] dt-bindings: power: Add Marvell PXA1908 domains
Date: Fri, 15 Aug 2025 00:08:28 +0200
Message-ID: <1950265.tdWV9SEqCh@radijator>
In-Reply-To: <dfaa36d6-41b2-46c1-ba14-e2fb5c9815e6@kernel.org>
References:
 <20250806-pxa1908-genpd-v1-0-16409309fc72@dujemihanovic.xyz>
 <2017616.PYKUYFuaPT@radijator>
 <dfaa36d6-41b2-46c1-ba14-e2fb5c9815e6@kernel.org>
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

On Monday, 11 August 2025 08:38:15 Central European Summer Time=20
Krzysztof Kozlowski wrote:
> On 08/08/2025 21:46, Duje Mihanovi=C4=87 wrote:
> > On Friday, 8 August 2025 09:34:54 Central European Summer Time Krzyszto=
f=20
> > Kozlowski wrote:
> >> On Wed, Aug 06, 2025 at 07:33:21PM +0200, Duje Mihanovi=C4=87 wrote:
> >>> +          A number of phandles to clocks that need to be enabled dur=
ing
> >>> domain +          power up.
> >>=20
> >> This does not exist in your example, so it is just confusing.
> >=20
> > This is because I have not implemented any of the clocks used by the
> > domains at this moment.
> >=20
> > Actually, I am not sure anymore whether it is necessary to assign
> > clocks to the domains as I have just yesterday successfully brought up
> > the GPU with some out-of-tree code and that did not require giving the
> > domains any clocks even though the vendor kernel does this. Should I
> > just go with that and drop all clock handling from the power domain
> > driver, at which point there would be no need for the individual domain
> > nodes? If not, how should I in the future assign clocks to the domains?
>=20
> I am asking to see complete binding with complete DTS in example and
> submitted to SoC maintainer.

Hm, so if in the example (and the actual DTS) each domain is assigned a clo=
ck,=20
can I then keep the domain and domain controller nodes like Mediatek and=20
Rockchip have?

Does SoC maintainer here mean the SoC mailing list or the maintainer of the=
=20
particular SoC family in question?

Regards,
=2D-
Duje




