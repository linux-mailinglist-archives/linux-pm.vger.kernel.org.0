Return-Path: <linux-pm+bounces-16648-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7188F9B43B0
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 09:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DB611F23600
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 08:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AAE2036E3;
	Tue, 29 Oct 2024 08:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="E9WrE7ko"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C8B1DF99F;
	Tue, 29 Oct 2024 08:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730188994; cv=none; b=LUpsgsaTYFhopOeuMBNr9Z3HFCT+LIgEqSEkCQ6WfMeyGfZ4kGAGaXHgF8ZVJwDZtqN7AGrNExCta37uyB7u1z2ZHuCCGPb9QEFKuBlagxLnxcoA012ck6k0BHjA4Jo9gamNcefiFiMNG/+cNmejaPZ1f+dnZoXNbRPg8FR+38w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730188994; c=relaxed/simple;
	bh=/xUZ3coZ6gf0W/FIhSNP+3W6dQQSH6hXnIrXeTA8pgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZB2fumrZmBax9sQHnCqvLqJ6RiBu6FoXlc6V+19GTYLIi6UNv9Vjti3nxDcuR7eXCT2CFnotX/OgDlsAcOuP0jVpgQONAsgpFyUQMMomDp6KWFqmw8psSIlU7oLa7S7EiE9R2orQLNPNeoDPK+IUav2xHiwtekRcTW0O/5BXSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=E9WrE7ko; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iFdAzUkd+0GcTyGkQ9/oIIo1dvmqpp5hrlTc3EhXZOY=; b=E9WrE7kocNrMH0KBtISYyOsT32
	PSMSsRWWc5ttyuBz9k08bNtdV2pmnSIxLwf8TSavrfVanzPnFH+vFeWHa8X18XX4W7rs2HhWaEF39
	lMenGv8tWDu71gfI8++INuZmUySPZj8ECT1w4N5VRO5xYI/DzO+6lz3e6/1j5NgdinKJL8R+6sYWF
	eWDftBCWLy1wRDPEblOrOj+6ShySW3PiIVJ9DC83Ds6qlsvQRzdWknfrBAB0lg5znZL0QsVoR8zpi
	LB5SGxCh96C1CN9NxF/9ho2aS0Rb79rGDcq/QHH7rG9oiG32K6IP9wBS4BK0I3BhMQOOMdoFjeky8
	DpvOJkLg==;
Received: from [185.156.123.69] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t5hAk-0002ap-A3; Tue, 29 Oct 2024 09:01:50 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
 Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>, Qiang Zhao <qiang.zhao@nxp.com>,
 Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
 Huisong Li <lihuisong@huawei.com>, Linus Walleij <linusw@kernel.org>,
 Imre Kaloz <kaloz@openwrt.org>, Karol Gugala <kgugala@antmicro.com>,
 Mateusz Holenko <mholenko@antmicro.com>, Gabriel Somlo <gsomlo@gmail.com>,
 Yinbo Zhu <zhuyinbo@loongson.cn>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Daire McNamara <daire.mcnamara@microchip.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Nishanth Menon <nm@ti.com>,
 Santosh Shilimkar <ssantosh@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Duje =?utf-8?B?TWloYW5vdmnEhw==?= <duje.mihanovic@skole.hr>,
 Mark Brown <broonie@kernel.org>, David Wu <david.wu@rock-chips.com>,
 Jianqun Xu <jay.xu@rock-chips.com>,
 Jay Buddhabhatti <jay.buddhabhatti@amd.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Izhar Ameer Shaikh <izhar.ameer.shaikh@amd.com>,
 Naman Trivedi Manojbhai <naman.trivedimanojbhai@amd.com>,
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
 linux-mediatek@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH] soc: Switch back to struct platform_driver::remove()
Date: Tue, 29 Oct 2024 09:01:46 +0100
Message-ID: <5089490.31r3eYUQgx@phil>
In-Reply-To: <20241029074859.509587-2-u.kleine-koenig@baylibre.com>
References: <20241029074859.509587-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Dienstag, 29. Oktober 2024, 08:48:58 CET schrieb Uwe Kleine-K=F6nig:
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers.
>=20
> Convert all platform drivers below drivers/soc to use .remove(), with
> the eventual goal to drop struct platform_driver::remove_new(). As
> .remove() and .remove_new() have the same prototypes, conversion is done
> by just changing the structure member name in the driver initializer.
>=20
> On the way do a few whitespace changes to make indention consistent.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>


>  drivers/soc/rockchip/io-domain.c            | 8 ++++----

=46or the Rockchip part:
Acked-by: Heiko Stuebner <heiko@sntech.de>



