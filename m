Return-Path: <linux-pm+bounces-26733-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97110AAC124
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 12:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A17EC3B1981
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 10:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98018275114;
	Tue,  6 May 2025 10:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="ZJkhctv9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OKahMCMy"
X-Original-To: linux-pm@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8208026560B;
	Tue,  6 May 2025 10:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746526593; cv=none; b=fy9yEN4RVObpO9e2iQCBhHRkAdXcNt0n8OPcJnWZt0RmeOQeECPSzO/j/W0ARi/NoGFGXaj+J/JWxVRg9HJ50brWavuu0NmKdfykLj9guZnl4w6HxZdfeDOFdkzPs4/QxbyKOQq9ogjKM7hG41x4iTQzpCQK86t/hX58CD6NNe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746526593; c=relaxed/simple;
	bh=tfJE/xsquhVWWbSfVNtxd7mxkKLpuW/Q3MoXdBzWEbw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=q4NmBhMZYbZkhQdxxEwac7WQxOTJzva+9iSHYIYATaTb/lqSvyswiKRFqDjgj4E/VNiEd3V+QBzFBM4Xd/rcCaDcIn/eIsfLFLx1u5jUAe2hF0yC7hz90IbobXoSgK/ai0O30w9cev9UpsDZKIObMZTQ6QCiwG/j8OInesIPU1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev; spf=pass smtp.mailfrom=svenpeter.dev; dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b=ZJkhctv9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OKahMCMy; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 7375C1381006;
	Tue,  6 May 2025 06:16:28 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-04.internal (MEProxy); Tue, 06 May 2025 06:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1746526588; x=1746612988; bh=u4ZHetn6p+gj8N2CA7NvMJ9GHPYdTeEK
	pJ3GrEZD+ck=; b=ZJkhctv9B2NAQMglgaUYteeHtV1edBTOoePYfTVKqlvifJy0
	fJWCLZRQRtgNkvYhrsUnxw3VqEcSnH2mjGmYQIchOI+R5o/+J6h4vyI1DiJ0y7Bt
	fPCugGbW+1MaVK678SxNSuqA4i8+hHJEM2dA3ZGEfSxwKvThgD4X1Yv44hj8vZs7
	/GK3JDaonKVlrfnBuw8cJZVKvTNkPnDDX+2L+DiZL8Pf6Ew7IIN+1/71m6jcYaH9
	OVd5EizdKJH7Vx3xzAmKy/iZCDEo78QEUXFKjbVonWfMsju39Jy4BjJgA41r/H6D
	P6iK5l++JlKC5rqChIDW5zophjWsnZzP0zIqww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746526588; x=
	1746612988; bh=u4ZHetn6p+gj8N2CA7NvMJ9GHPYdTeEKpJ3GrEZD+ck=; b=O
	KahMCMyBsg8bRfkAg2P/TMCEqXjthOylc6NFspaoD0MYT1xQJvAUfAhfcZUzDGVd
	rsZfAfHuTu5U3jV+ODyWoOvOEughel86KZbeTbyMtg/aP0gEq5NO6lTE2vUqk6Up
	4ASIE6vox5B5Bm0UP9a0UgpKyKycQWN5ZI0rwjqbyhd2+P3FgxeYg85DBYhPpuAU
	XjEu0s9r08MxEiGcvtoYKioR0QYfJR6pk5OBSxbrRWcIHN1fte0ITDLU3Z6QBCcx
	mICb8y7b7e6P4bh6Ya3DMlPnIT6dVSsgmqKFNorw1KwfuKOC8xkYYe55D9VBzNVD
	m2ocg6mvOl9qvklVmxmYg==
X-ME-Sender: <xms:euEZaILVJBwWtr2baaSB6TlmAJNm3cUe58sBzaajE2dmvLpKKd7aBg>
    <xme:euEZaILQT-tTxNY6TK56P6NoH0nxCGZCxl_kIB_UkElbpiG4r9G0iKv2zz70efbwF
    kvIN86fbQIpNsFlk1o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeefjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertder
    tdejnecuhfhrohhmpedfufhvvghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvth
    gvrhdruggvvheqnecuggftrfgrthhtvghrnhepgeegheelffdujeduffevfefhieekgeef
    fedukedtvdduhfffjeehleekfeehhfdtnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepshhvvghnsehsvhgvnhhpvghtvghrrdguvghvpdhnsggp
    rhgtphhtthhopeduledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhmkhdokh
    gvrhhnvghlsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepsghrghhlsegs
    ghguvghvrdhplhdprhgtphhtthhopehnvggrlhesghhomhhprgdruggvvhdprhgtphhtth
    hopehjsehjrghnnhgruhdrnhgvthdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhgvvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgriieskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:euEZaIvriNGIwfgefP8pMni-k1-Mi8CzIMaLsYfTRdaK95nv6DwF1g>
    <xmx:euEZaFaY8i2dz8F74MNuvedfSCa6MYKKfa_p8CUuZr-bmsVlA8p48A>
    <xmx:euEZaPbks8S8RUfwkDzDMPwXPEs_Tznk-Kz1GYritVFxYQeFZUnpUw>
    <xmx:euEZaBAd_EfcQkYFXQgIpZRq4wMgV1jcVqubCESpNsKhAaP1bFfF6A>
    <xmx:fOEZaN4m4sWqe_fgyAZMrGAsSCzeZTmjg9ceuj_brIetONwj2TczbF81>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A6BA31C20069; Tue,  6 May 2025 06:16:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T90a118147f15bbe7
Date: Tue, 06 May 2025 12:16:06 +0200
From: "Sven Peter" <sven@svenpeter.dev>
To: "Bartosz Golaszewski" <brgl@bgdev.pl>
Cc: "Janne Grunau" <j@jannau.net>, "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
 "Neal Gompa" <neal@gompa.dev>, "Hector Martin" <marcan@marcan.st>,
 "Linus Walleij" <linus.walleij@linaro.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Sebastian Reichel" <sre@kernel.org>,
 "Lee Jones" <lee@kernel.org>, "Marc Zyngier" <maz@kernel.org>,
 "Russell King" <rmk+kernel@armlinux.org.uk>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Message-Id: <b96bd2d6-98f7-44da-9293-816daeac80d0@app.fastmail.com>
In-Reply-To: 
 <CAMRc=MebFf-DBh_=H0J4ORStaxBYhOnfY+jSk2d4UpdyS=m1LA@mail.gmail.com>
References: <20250503-smc-6-15-v4-0-500b9b6546fc@svenpeter.dev>
 <20250503-smc-6-15-v4-5-500b9b6546fc@svenpeter.dev>
 <CAMRc=MebFf-DBh_=H0J4ORStaxBYhOnfY+jSk2d4UpdyS=m1LA@mail.gmail.com>
Subject: Re: [PATCH v4 5/9] gpio: Add new gpio-macsmc driver for Apple Macs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,


On Tue, May 6, 2025, at 10:07, Bartosz Golaszewski wrote:
> On Sat, May 3, 2025 at 12:07=E2=80=AFPM Sven Peter via B4 Relay
> <devnull+sven.svenpeter.dev@kernel.org> wrote:
>>
>> From: Hector Martin <marcan@marcan.st>
>>
>> This driver implements the GPIO service on top of the SMC framework
>> on Apple Mac machines. In particular, these are the GPIOs present in =
the
>> PMU IC which are used to control power to certain on-board devices.
>>
>> Although the underlying hardware supports various pin config settings
>> (input/output, open drain, etc.), this driver does not implement that
>> functionality and leaves it up to the firmware to configure things
>> properly. We also don't yet support interrupts/events. This is
>> sufficient for device power control, which is the only thing we need =
to
>> support at this point. More features will be implemented when needed.
>>
>> To our knowledge, only Apple Silicon Macs implement this SMC feature.
>>
>> Signed-off-by: Hector Martin <marcan@marcan.st>
>> Reviewed-by: Bartosz Golaszewski <brgl@bgdev.pl>
>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>> Reviewed-by: Sven Peter <sven@svenpeter.dev>
>> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
>> Signed-off-by: Sven Peter <sven@svenpeter.dev>
>> ---
>
> [snip]
>
>> +
>> +       smcgp->gc.label =3D "macsmc-pmu-gpio";
>> +       smcgp->gc.owner =3D THIS_MODULE;
>> +       smcgp->gc.get =3D macsmc_gpio_get;
>> +       smcgp->gc.set =3D macsmc_gpio_set;
>
> I must have given my Reviewed-by under this driver before we started
> the conversion to the new GPIO driver setters. Could you please
> replace this with set_rv() as the old set() is now deprecated?

Probably, the last version I took from the ML is from November 2022 :-(
Will do that for the next version, I can just pass through the return va=
lue
we get from apple_smc_write_u32 anyway.


Thanks,


Sven


-- >8 --
Subject: [PATCH] fixup! gpio: Add new gpio-macsmc driver for Apple Macs

---
 drivers/gpio/gpio-macsmc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-macsmc.c b/drivers/gpio/gpio-macsmc.c
index 289be4268f63..a68676239718 100644
--- a/drivers/gpio/gpio-macsmc.c
+++ b/drivers/gpio/gpio-macsmc.c
@@ -135,7 +135,7 @@ static int macsmc_gpio_get(struct gpio_chip *gc, uns=
igned int offset)
 	return val ? 1 : 0;
 }

-static void macsmc_gpio_set(struct gpio_chip *gc, unsigned int offset, =
int value)
+static int macsmc_gpio_set(struct gpio_chip *gc, unsigned int offset, i=
nt value)
 {
 	struct macsmc_gpio *smcgp =3D gpiochip_get_data(gc);
 	smc_key key =3D macsmc_gpio_key(offset);
@@ -146,6 +146,8 @@ static void macsmc_gpio_set(struct gpio_chip *gc, un=
signed int offset, int value
 	if (ret < 0)
 		dev_err(smcgp->dev, "GPIO set failed %p4ch =3D 0x%x\n",
 			&key, value);
+
+	return ret;
 }

 static int macsmc_gpio_init_valid_mask(struct gpio_chip *gc,
@@ -214,7 +216,7 @@ static int macsmc_gpio_probe(struct platform_device =
*pdev)
 	smcgp->gc.label =3D "macsmc-pmu-gpio";
 	smcgp->gc.owner =3D THIS_MODULE;
 	smcgp->gc.get =3D macsmc_gpio_get;
-	smcgp->gc.set =3D macsmc_gpio_set;
+	smcgp->gc.set_rv =3D macsmc_gpio_set;
 	smcgp->gc.get_direction =3D macsmc_gpio_get_direction;
 	smcgp->gc.init_valid_mask =3D macsmc_gpio_init_valid_mask;
 	smcgp->gc.can_sleep =3D true;
--
2.34.1

