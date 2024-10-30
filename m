Return-Path: <linux-pm+bounces-16686-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7469B5884
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 01:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9252C1F24F47
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 00:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4832211187;
	Wed, 30 Oct 2024 00:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="di+ZrdRm"
X-Original-To: linux-pm@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F822C9D;
	Wed, 30 Oct 2024 00:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730247806; cv=none; b=L/0aMMQVYVuo1dOM32/LmQ8ZaUGkKXpIIUlUVPYfwZKU4sn0j4gamMfIh49vD7VIMwwTAHYD5Amq8v5skutkZXOCguFDo+KZnvqg22rl3m2ly8NonDRxVo0ht2psSBsEp0tyAvXZbH2K5wqLgBKd6dKjuj3OArw2wjRPf2HdXXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730247806; c=relaxed/simple;
	bh=g97qSBk0nfVaTQ4nSQz7mm5l86i31AAhLyCvLjCxnwg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FmQGSyKcldzlfRQheEr3X11jCZ6pwkSNT2Bo6mbFG/TTCkWSYBuKl1TQ6mCOdAQaKVvBSiu1smIl1U2yY2tE4gRovoWnt2pqei//7CrB9SKCp2A9ZjJxXbX8b6dxAII16qocwcjOFYSb+ZnZbuQFfjMJg6PWt08cgY0JLz8F0sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=di+ZrdRm; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1730247801;
	bh=g97qSBk0nfVaTQ4nSQz7mm5l86i31AAhLyCvLjCxnwg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=di+ZrdRmCd/lQns/8eExuvjbnZpOwlfJZqQhT0vk6A4dWQSREGaSjYA1NUpuSXq/9
	 zLOKIqOjor7p9tE0dyGfw4ybWiryzyo+iipRVF2kM5VpPdFA3d+3Ou9jXOVP2gRjYg
	 nxhaMgbcn/2U32y5829iQGbhb4KxNznUA2+K/2a0+EQ2SswvR0VQC5IX3R2gM1Hc5H
	 qIqUDA2Y9Sx6OWg9iXKjz7Q61ZLM8qzV89E79bImydBlZ3cYU8OsnRBo4eKdTRLt29
	 HKUqM1u67bcl+f74e72B6y7/Ev8hL3bEW1/AqAaeVkze+VI+uRfQfKCa7B551KThzG
	 ud9Ehgxe8s9Jw==
Received: from [192.168.68.112] (ppp118-210-190-243.adl-adc-lon-bras34.tpg.internode.on.net [118.210.190.243])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id A1A9067E6D;
	Wed, 30 Oct 2024 08:23:10 +0800 (AWST)
Message-ID: <3c7893f5186f0c6d64c063dc0a609ec8d6c8bcf1.camel@codeconstruct.com.au>
Subject: Re: [PATCH] soc: Switch back to struct platform_driver::remove()
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>, 
	Arnd Bergmann
	 <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: Joel Stanley <joel@jms.id.au>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>, 
 Qiang Zhao <qiang.zhao@nxp.com>, Hitomi Hasegawa
 <hasegawa-hitomi@fujitsu.com>, Huisong Li <lihuisong@huawei.com>, Linus
 Walleij <linusw@kernel.org>, Imre Kaloz <kaloz@openwrt.org>, Karol Gugala
 <kgugala@antmicro.com>, Mateusz Holenko <mholenko@antmicro.com>, Gabriel
 Somlo <gsomlo@gmail.com>, Yinbo Zhu <zhuyinbo@loongson.cn>, Matthias
 Brugger <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Conor Dooley
 <conor.dooley@microchip.com>, Daire McNamara
 <daire.mcnamara@microchip.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Alim Akhtar <alim.akhtar@samsung.com>,  Thierry Reding
 <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Nishanth Menon <nm@ti.com>,  Santosh Shilimkar <ssantosh@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Duje =?UTF-8?Q?Mihanovi=C4=87?=
 <duje.mihanovic@skole.hr>, Mark Brown <broonie@kernel.org>, David Wu
 <david.wu@rock-chips.com>, Jianqun Xu <jay.xu@rock-chips.com>, Jay
 Buddhabhatti <jay.buddhabhatti@amd.com>, Radhey Shyam Pandey
 <radhey.shyam.pandey@amd.com>,  Izhar Ameer Shaikh
 <izhar.ameer.shaikh@amd.com>, Naman Trivedi Manojbhai
 <naman.trivedimanojbhai@amd.com>,  linux-arm-kernel@lists.infradead.org,
 soc@lists.linux.dev,  linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,  linuxppc-dev@lists.ozlabs.org,
 loongarch@lists.linux.dev,  linux-mediatek@lists.infradead.org,
 linux-riscv@lists.infradead.org,  linux-arm-msm@vger.kernel.org,
 linux-rockchip@lists.infradead.org,  linux-samsung-soc@vger.kernel.org,
 linux-tegra@vger.kernel.org,  linux-pm@vger.kernel.org
Date: Wed, 30 Oct 2024 10:53:09 +1030
In-Reply-To: <20241029074859.509587-2-u.kleine-koenig@baylibre.com>
References: <20241029074859.509587-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-10-29 at 08:48 +0100, Uwe Kleine-K=C3=B6nig wrote:
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement
> for
> platform drivers.
>=20
> Convert all platform drivers below drivers/soc to use .remove(), with
> the eventual goal to drop struct platform_driver::remove_new(). As
> .remove() and .remove_new() have the same prototypes, conversion is
> done
> by just changing the structure member name in the driver initializer.
>=20
> On the way do a few whitespace changes to make indention consistent.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---
> Hello,
>=20
> I did a single patch for all of drivers/soc. While I usually prefer
> to
> do one logical change per patch, this seems to be overengineering
> here
> as the individual changes are really trivial and shouldn't be much in
> the way for stable backports.
>=20
> There is no dedicated maintainer for all of drivers/soc, but I'd
> expect
> it to be ok to be picked up by the arm soc team.
>=20
> This is based on today's next, if conflicts arise when you apply it
> at
> some later time and don't want to resolve them, feel free to just
> drop
> the changes to the conflicting files. I'll notice and followup at a
> later time then. Or ask me for a fixed resend.
>=20
> Best regards
> Uwe
>=20
> =C2=A0drivers/soc/aspeed/aspeed-lpc-ctrl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 2 +-
> =C2=A0drivers/soc/aspeed/aspeed-lpc-snoop.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 2 +-
> =C2=A0drivers/soc/aspeed/aspeed-p2a-ctrl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 2 +-
> =C2=A0drivers/soc/aspeed/aspeed-uart-routing.c=C2=A0=C2=A0=C2=A0 | 2 +-

Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au> # aspeed

