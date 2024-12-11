Return-Path: <linux-pm+bounces-19075-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0440F9EDA14
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 23:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF3F51673B5
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 22:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836C22063C7;
	Wed, 11 Dec 2024 22:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqZ00nyo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534F5206294;
	Wed, 11 Dec 2024 22:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956373; cv=none; b=kE+2n4gWzSKcRw5BaljCtg85wKO7DXr9mB05SeEzjL7RnO/4pDaPG7Yil2OyrJlBa1zgFBVWKbezxahVzsm7MMUsBH66Pm6SeFynQC7G0gPNB4UfwXQSQtvuNU9R69tPle9nqo2GlSBpzEQC9qrS2dBMZQy/THtrtcJ/+hpQirk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956373; c=relaxed/simple;
	bh=cVsBRq85rissDz94gS1APPLak1L31WJ3t5TGTSYE/as=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QZ1OYrjIuDJ7KNQRVYBVbyLFHeTZBG7pktYMmaVO1gVDjbt5EqKy4lui2wPIMExmcPFm+sCDqrfAV8CKdfD0LxYz/QIWff3zUhAfb33Z5sS4ARtieTSq9cAF+lBhJR+uEQj87IQ/M30U5bpwbe2ehX6tQTCFppOAvqIOUxCbzUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqZ00nyo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24AB1C4CED3;
	Wed, 11 Dec 2024 22:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733956373;
	bh=cVsBRq85rissDz94gS1APPLak1L31WJ3t5TGTSYE/as=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cqZ00nyo1Apj+jfDOCjAb0Dxj/1hdrSgL4z0d1BQUgbsnfyS1cxj2Bs3BmSupO9YI
	 ZrIs7UmW8cKEp43GKNoiniGEMwWKwmjdnER3WeCSCGcRBKWotkXLcx8jndR1TkSpRP
	 uiVGhMx/F4anBNn2cXEIgvbbMNAcLgjaLi7WcLTW60LB7hq+FQhuXx3i6Ic5UlnfEU
	 vzGsMum9i7o+4Bz2yDi5hvchzvThH3EecYX333iWDVqDeJrI5DcrWWqj0yc7VIBVVl
	 GPNr0CGIC5KgEmOa8jzIJQb3v4R6rhXRyTCF1prrQpAlkKDu/E5iMLuOrlL7ULHRg3
	 dPb253YfD0mvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CC8380A965;
	Wed, 11 Dec 2024 22:33:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] soc: Switch back to struct platform_driver::remove()
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173395638899.1729195.5401091299734997866.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 22:33:08 +0000
References: <20241029074859.509587-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20241029074859.509587-2-u.kleine-koenig@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=3Cu=2Ekleine-koenig=40baylibre=2Ecom=3E?=@codeaurora.org
Cc: linux-riscv@lists.infradead.org, arnd@arndb.de, olof@lixom.net,
 joel@jms.id.au, andrew@codeconstruct.com.au, christophe.leroy@csgroup.eu,
 herve.codina@bootlin.com, qiang.zhao@nxp.com, hasegawa-hitomi@fujitsu.com,
 lihuisong@huawei.com, linusw@kernel.org, kaloz@openwrt.org,
 kgugala@antmicro.com, mholenko@antmicro.com, gsomlo@gmail.com,
 zhuyinbo@loongson.cn, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, conor.dooley@microchip.com,
 daire.mcnamara@microchip.com, krzysztof.kozlowski@linaro.org,
 andersson@kernel.org, konradybcio@kernel.org, heiko@sntech.de,
 alim.akhtar@samsung.com, thierry.reding@gmail.com, jonathanh@nvidia.com,
 nm@ti.com, ssantosh@kernel.org, michal.simek@amd.com,
 andriy.shevchenko@linux.intel.com, duje.mihanovic@skole.hr,
 broonie@kernel.org, david.wu@rock-chips.com, jay.xu@rock-chips.com,
 jay.buddhabhatti@amd.com, radhey.shyam.pandey@amd.com,
 izhar.ameer.shaikh@amd.com, naman.trivedimanojbhai@amd.com,
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
 linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Arnd Bergmann <arnd@arndb.de>:

On Tue, 29 Oct 2024 08:48:58 +0100 you wrote:
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers.
> 
> Convert all platform drivers below drivers/soc to use .remove(), with
> the eventual goal to drop struct platform_driver::remove_new(). As
> .remove() and .remove_new() have the same prototypes, conversion is done
> by just changing the structure member name in the driver initializer.
> 
> [...]

Here is the summary with links:
  - soc: Switch back to struct platform_driver::remove()
    https://git.kernel.org/riscv/c/511c06e39035

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



