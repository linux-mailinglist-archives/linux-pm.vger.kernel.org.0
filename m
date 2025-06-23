Return-Path: <linux-pm+bounces-29355-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C06B7AE481D
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 17:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68CB57A6E42
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 15:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFD0283FD0;
	Mon, 23 Jun 2025 15:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Dk4DRySe"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957FE27991E;
	Mon, 23 Jun 2025 15:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750691645; cv=none; b=LnlgSVeCNqV/eP1kKBTxVbv+yO9dAWzTPo1/ImUHPVrQOHOqrblJ+3KqKvqBUT6x7E1D2gyHX5yB6V/F5m6K4TyfEiFBuZm6Q/rOh+ftfadWEhUVWZqxnc4o3umA3Hl87EmsCwvjr2kSjZtje2aXPGyawwbUZoC+tSvt13x4i7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750691645; c=relaxed/simple;
	bh=45lmqAUYpUykmyRNsOjFpkel3OPLmML527QXdh0o9zU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hK+7gZKYSHAqxgdGA2MlGmdFsGm1Hm1pkro6djfcz3U6LmRLqLC6cPrrJ3OttmC5wKxxbRe+Pg9QRjcd+X8inaTq6LopXZBqx65izD+Zqqkr6sHIcUSeP45S7Y2NgqZDNdk/wvn3dV5ODfIsAyaCQraBygZxuFChAxwq7N9cdx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Dk4DRySe; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EC94944288;
	Mon, 23 Jun 2025 15:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750691640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=45lmqAUYpUykmyRNsOjFpkel3OPLmML527QXdh0o9zU=;
	b=Dk4DRySeiEHJkC5ucZz7LZZ5UhTo8qfaM+NNpNfIAmI8eb71jZ1iyZigWxGJIVUh/eddQP
	8Xl1XY+V1ya18+kaQTE+VfNrEVges9y6YeLXaGu/C3rRQVwdpYLIzr+sV2HHzE/5UmgjzB
	/+xepzhCWX1cw6Sjteg1eK+SyfTf1nG848+wARLHC34oEtB0GGeHyHyWCzEjD96U8cz4ZV
	Q9lHqj9ZKe3ogELbhBMi//RQzmrzPpFKAf5qiAiUT/AZUHomVPjE09J5Bf3w9srIdSfWcY
	Yt4Oua24qVH3rU576TSTUWjL+lZ5mN7oW47CVCJAgdJIvxqw3/Z3LAIlRF5uqQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Pan Chuang <panchuang@vivo.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,  Daniel Lezcano
 <daniel.lezcano@linaro.org>,  Zhang Rui <rui.zhang@intel.com>,  Lukasz
 Luba <lukasz.luba@arm.com>,  Markus Mayer <mmayer@broadcom.com>,  Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
  Florian Fainelli <florian.fainelli@broadcom.com>,  Shawn Guo
 <shawnguo@kernel.org>,  Sascha Hauer <s.hauer@pengutronix.de>,
  Pengutronix Kernel Team <kernel@pengutronix.de>,  Fabio Estevam
 <festevam@gmail.com>,  zhanghongchen <zhanghongchen@loongson.cn>,  Yinbo
 Zhu <zhuyinbo@loongson.cn>,  Amit Kucheria <amitk@kernel.org>,  Thara
 Gopinath <thara.gopinath@gmail.com>,  Niklas =?utf-8?Q?S=C3=B6derlund?=
 <niklas.soderlund@ragnatech.se>,  Geert Uytterhoeven
 <geert+renesas@glider.be>,  Magnus Damm <magnus.damm@gmail.com>,  Heiko
 Stuebner <heiko@sntech.de>,  Bartlomiej Zolnierkiewicz
 <bzolnier@gmail.com>,  Krzysztof Kozlowski <krzk@kernel.org>,  Alim Akhtar
 <alim.akhtar@samsung.com>,  Maxime Coquelin <mcoquelin.stm32@gmail.com>,
  Alexandre Torgue <alexandre.torgue@foss.st.com>,  Vasily Khoruzhick
 <anarsoul@gmail.com>,  Yangtao Li <tiny.windzz@gmail.com>,  Chen-Yu Tsai
 <wens@csie.org>,  Jernej Skrabec <jernej.skrabec@gmail.com>,  Samuel
 Holland <samuel@sholland.org>,  Thierry Reding <thierry.reding@gmail.com>,
  Jonathan Hunter <jonathanh@nvidia.com>,  Kunihiko Hayashi
 <hayashi.kunihiko@socionext.com>,  Masami Hiramatsu <mhiramat@kernel.org>,
  Thomas Gleixner <tglx@linutronix.de>,  Matthias Brugger
 <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,  Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>,  Greg KH
 <gregkh@linuxfoundation.org>,  Peter Zijlstra <peterz@infradead.org>,
  =?utf-8?Q?N=C3=ADcolas?= F. R. A. Prado <nfraprado@collabora.com>,  Conor
 Dooley
 <conor.dooley@microchip.com>,  Julien Panis <jpanis@baylibre.com>,  Arnd
 Bergmann <arnd@arndb.de>,  Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>,  Colin Ian King <colin.i.king@gmail.com>,
  Raphael Gallais-Pou <rgallaispou@gmail.com>,  Patrice Chotard
 <patrice.chotard@foss.st.com>,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  "Jiri Slaby (SUSE)"
 <jirislaby@kernel.org>,  Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>,  Andrew Morton <akpm@linux-foundation.org>,
  Costa Shulyupin <costa.shul@redhat.com>,  Yury Norov
 <yury.norov@gmail.com>,  Cheng-Yang Chou <yphbchou0911@gmail.com>,  Caleb
 Sander Mateos <csander@purestorage.com>,  linux-pm@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  imx@lists.linux.dev,  linux-arm-msm@vger.kernel.org,
  linux-renesas-soc@vger.kernel.org,  linux-rockchip@lists.infradead.org,
  linux-samsung-soc@vger.kernel.org,
  linux-stm32@st-md-mailman.stormreply.com,  linux-sunxi@lists.linux.dev,
  linux-tegra@vger.kernel.org,  linux-mediatek@lists.infradead.org,
  Yangtao Li <frank.li@vivo.com>,  Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v6 01/24] genirq/devres: Add
 devm_request_threaded_irq_probe() and devm_request_irq_probe()
In-Reply-To: <20250623123054.472216-2-panchuang@vivo.com> (Pan Chuang's
	message of "Mon, 23 Jun 2025 20:30:34 +0800")
References: <20250623123054.472216-1-panchuang@vivo.com>
	<20250623123054.472216-2-panchuang@vivo.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Mon, 23 Jun 2025 17:13:54 +0200
Message-ID: <87a55ywkwd.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddujeefhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgfgsehtqhertddtreejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepffeghfejtdefieeguddukedujeektdeihfelleeuieeuveehkedvleduheeivdefnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepjedtpdhrtghpthhtohepphgrnhgthhhurghnghesvhhivhhordgtohhmpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepmhhmrgihv
 ghrsegsrhhorggutghomhdrtghomhdprhgtphhtthhopegstghmqdhkvghrnhgvlhdqfhgvvggusggrtghkqdhlihhsthessghrohgruggtohhmrdgtohhmpdhrtghpthhtohepfhhlohhrihgrnhdrfhgrihhnvghllhhisegsrhhorggutghomhdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Pan,

On 23/06/2025 at 20:30:34 +08, Pan Chuang <panchuang@vivo.com> wrote:

> From: Yangtao Li <frank.li@vivo.com>
>
> There are more than 700 calls to devm_request_threaded_irq method and
> more than 1000 calls to devm_request_irq method. Most drivers only
> request one interrupt resource, and these error messages are basically
> the same. If error messages are printed everywhere, more than 2000 lines
> of code can be saved by removing the msg in the driver.

[...]

> So add devm_request_threaded_irq_probe() and devm_request_irq_probe(),
> which ensure that all error handling branches print error information.
> In this way, when this function fails, the upper-layer functions can
> directly return an error code without missing debugging information.
> Otherwise, the error message will be printed redundantly or missing.

While I understand the goal and adhere to it, may I challenge the use of
a yet another intermediate function that 99% of the users will anyway
use? Wouldn't it be more straightforward to just add the error message
in the existing functions directly? If we really want an alternative, it
may be created and called in the few places where a dev_err_probe()
might not be relevant.

Thanks,
Miqu=C3=A8l

