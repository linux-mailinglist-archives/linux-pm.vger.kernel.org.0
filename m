Return-Path: <linux-pm+bounces-16666-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC729B4DCC
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 16:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63154285211
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 15:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D996192D84;
	Tue, 29 Oct 2024 15:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E31i4+n2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ECC21348;
	Tue, 29 Oct 2024 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730215448; cv=none; b=t7br68SlobF9P3m+v6DoW5SKdF9fqBSr5bqv1ZLvYmUYfjZaENqVWNhEbCCfLCxDJcnA7wEhKHfy3Y9zdTuZTOA1SS8eYtQD7eHwHqrF3B989FaVkbud4bQOC/0+oEL5w9s5Sc0jE96Egxr6tBzrxjAk88/UK9NhROvkInWFUHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730215448; c=relaxed/simple;
	bh=OnfPNjPFcprKl1sN97TkhOv/xNK+Q/zpiKD+oNhDMSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=duKdzRHkQpDVn8lqn6eHzuJlyjC4MZA7N5h7aiRMCl5cQzP1S5yZu/L8BS90/jxeUokGwGA283y8ckgjyavLC8gV09znVolKW9SyV2Osbwc1bwRMiCXEWJR1Kl64RSMozI9zxgY+BlQeifA6jAp50sDpKTOP8A2yCC+pRl1JAPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E31i4+n2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C660FC4CECD;
	Tue, 29 Oct 2024 15:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730215448;
	bh=OnfPNjPFcprKl1sN97TkhOv/xNK+Q/zpiKD+oNhDMSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E31i4+n2VfP73VqUtiK+gGGwGyJPG/gqLdz1F/Xn8gtzgIte2GFbSrzS2tWamSxWl
	 9Zw0YDHmBYpciQUj3b95NnqAHMns0WZL/efHJoyMUe+TT5Av6j75+LIOn2d10jG2Sa
	 Y/wGc+s3uqYoxSChwozTI4vlkJhehj9XoxmAnsXi9m/WRyrUAexAyJpLI7kZGMq9cI
	 Jv7t9zvjRKrRJHu6S4D0XxbuREDxDww2gja2p+62K9u14TvqnkkJV5ZTCLzYcENc29
	 ekLAvwOCsdlxLy8apvJqWVnUINaro65w+MkYq8mkZm8f4/4hV8Vcja9W6w98QyEBGi
	 YG75XcuK7bCvw==
Date: Tue, 29 Oct 2024 10:24:02 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>, 
	Qiang Zhao <qiang.zhao@nxp.com>, Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>, 
	Huisong Li <lihuisong@huawei.com>, Linus Walleij <linusw@kernel.org>, 
	Imre Kaloz <kaloz@openwrt.org>, Karol Gugala <kgugala@antmicro.com>, 
	Mateusz Holenko <mholenko@antmicro.com>, Gabriel Somlo <gsomlo@gmail.com>, 
	Yinbo Zhu <zhuyinbo@loongson.cn>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Daire McNamara <daire.mcnamara@microchip.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Nishanth Menon <nm@ti.com>, 
	Santosh Shilimkar <ssantosh@kernel.org>, Michal Simek <michal.simek@amd.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, 
	Mark Brown <broonie@kernel.org>, David Wu <david.wu@rock-chips.com>, 
	Jianqun Xu <jay.xu@rock-chips.com>, Jay Buddhabhatti <jay.buddhabhatti@amd.com>, 
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Izhar Ameer Shaikh <izhar.ameer.shaikh@amd.com>, 
	Naman Trivedi Manojbhai <naman.trivedimanojbhai@amd.com>, linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	loongarch@lists.linux.dev, linux-mediatek@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH] soc: Switch back to struct platform_driver::remove()
Message-ID: <7iufjf4cnoofq63vtzrnlxneyjhmuhuaq2tqflzw6nc6xpixiu@dnyh4etii2vz>
References: <20241029074859.509587-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241029074859.509587-2-u.kleine-koenig@baylibre.com>

On Tue, Oct 29, 2024 at 08:48:58AM GMT, Uwe Kleine-König wrote:
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers.
> 
> Convert all platform drivers below drivers/soc to use .remove(), with
> the eventual goal to drop struct platform_driver::remove_new(). As
> .remove() and .remove_new() have the same prototypes, conversion is done
> by just changing the structure member name in the driver initializer.
> 
> On the way do a few whitespace changes to make indention consistent.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

Acked-by: Bjorn Andersson <andersson@kernel.org> # qcom parts

Regards,
Bjorn

