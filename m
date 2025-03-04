Return-Path: <linux-pm+bounces-23448-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB90A4EEA3
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 21:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D6091894C78
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 20:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9272641D5;
	Tue,  4 Mar 2025 20:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="khGMv6sW"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2261825FA39;
	Tue,  4 Mar 2025 20:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741121088; cv=none; b=UVZusWnM6V3cWAxwEi3NyhemQWG4MCAgeoWLzQtSpEzeBIZ0xfn5H8TTNKJcnl5prNq5+rhohAg3Y8iSfQSOJtUeoLMmAVa796QFtCgMB5Mh8oPEPnlwVyGWXoKL1AJHRfbF7S77cQBPSxkxQxB7VPH53g+lPFhQ/p22mJH1OCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741121088; c=relaxed/simple;
	bh=mgeFOhbzA7xgHj0yX/dEQDW+5rrSom4q+B+m5bthomU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UGFF9gQmCS3EFK+3XBlHf2TzPuCNkM5R5N/gpZ0VuAQ3FSiCHPr//vTJNL9CvBeiMjSRa59he7LILCKTy0/eZNMuIjoLKgimW9so58o0sJDW/gys6M0YuLKzcCYK15TB+JCVlYLwJ2qjGcsf+TvIdCpwC6uDqbObFImWicNRXr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=khGMv6sW; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ElnzQ303PfA4B5g1gtMvm2zchjHj9gy7dIO2NLrF/qY=; b=khGMv6sWor2meFhrfpWQII3ocu
	ZXfiolYMgsDqacRYWeZl5MtbzdCNfGtkktEW/NFF1DiCtSDEzOGchuf95/yQi+DHh2rXm0jV7IC+k
	2wLuKL8yhHVYV/JqEHYwuXNUwkn4NH4waYjTygagq2IGpWuO8GVYvlnCVTTy9jh0UmAyvReBOOMA4
	jOAxBWDSwdUUojUo4NCjl8z2h0TNPhdZSexKVRPnD2tuolCf/sdY0yncROnq4kHbj4q3lbGkUqUL/
	BZA3aY7aFEqnrtbvr7YR7TYuvtRLfCmZuAOwxuVyKFuwMSGvO7DlJT5h14ObWcUt3lD3KPSdeFftX
	4WVLGh7Q==;
Received: from i53875a38.versanet.de ([83.135.90.56] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tpZ82-00062P-7p; Tue, 04 Mar 2025 21:44:38 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Ulf Hansson <ulf.hansson@linaro.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pmdomain: rockchip: add regulator dependency
Date: Tue, 04 Mar 2025 21:44:37 +0100
Message-ID: <3938258.QJadu78ljV@diego>
In-Reply-To: <20250304142803.689201-1-arnd@kernel.org>
References: <20250304142803.689201-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Dienstag, 4. M=C3=A4rz 2025, 15:27:59 MEZ schrieb Arnd Bergmann:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> When CONFIG_REGULATOR is disabled, this pmdomain driver fails to build:
>=20
> drivers/pmdomain/rockchip/pm-domains.c:653:30: error: implicit declaratio=
n of function 'devm_of_regulator_get'; did you mean 'devm_regulator_get'? [=
=2DWimplicit-function-declaration]
>   653 |                 pd->supply =3D devm_of_regulator_get(pmu->dev, pd=
=2D>node, "domain");
>       |                              ^~~~~~~~~~~~~~~~~~~~~
>       |                              devm_regulator_get
> drivers/pmdomain/rockchip/pm-domains.c:653:28: error: assignment to 'stru=
ct regulator *' from 'int' makes pointer from integer without a cast [-Wint=
=2Dconversion]
>   653 |                 pd->supply =3D devm_of_regulator_get(pmu->dev, pd=
=2D>node, "domain");
>       |                            ^
>=20
> Add a Kconfig dependency.
>=20
> Fixes: db6df2e3fc16 ("pmdomain: rockchip: add regulator support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



