Return-Path: <linux-pm+bounces-26963-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5DEAB19F3
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 18:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED4F5168BA1
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 16:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1EC235046;
	Fri,  9 May 2025 16:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="GLz1dxhf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UPpw3I6w"
X-Original-To: linux-pm@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FAF233736;
	Fri,  9 May 2025 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746806818; cv=none; b=pTSqx7q308rRn0oMevRFKp1rehfUPHlFuPXW5A8MAPIMOJ+lihDDDBrqm5afUwdj4Bt59TZsZRRpTe4ejSwxLBGEftA+4VyeCOGKTrGXsNWW3GuZAj/6gxUMJ2Yh4TiBdi1dKLV5zSOyME3syNm4zpFdaJk6uYDwXd50bVk6HWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746806818; c=relaxed/simple;
	bh=h9wEK2bdvWm+IEfqp2a4luhTwfPw16tY+aDDWF3jP5Y=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JYZ+8Ai8WKVRn9H3HISgxCXzNeKr2xOTsutMCJ3DUCU1WBUUgAdGXwB/86J94JtfJYubJQT8GWpMShYHNVPj1cwGYcaFjDsRRBihZWC8BxVcarG+v9RWKM/c8kodYxML6eTH+iRItcjAl1egct1y4G48HA5kLViXoK1kcTG3rjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev; spf=pass smtp.mailfrom=svenpeter.dev; dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b=GLz1dxhf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UPpw3I6w; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 224141140130;
	Fri,  9 May 2025 12:06:53 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-04.internal (MEProxy); Fri, 09 May 2025 12:06:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1746806812; x=1746893212; bh=jyrrLL6pNEaoCnUi1cDiZH8UNc4WSR1j
	AKygV8Vcp/Q=; b=GLz1dxhfWvK/FIhktPQQCZdelZzJsm7iq6vIuM8suJ6VHOwK
	8+W1hd1aRWMlI9Cs9mFoZb4RO7ZkhgfDKyZkbSE8oPz02lQvz41KyGC91u2LfT4G
	yXizipodS+y+UkeNfQt8RFi9x4aQqATLvFTzO3RB483eONhe0Z0yZlIAD7OVa6tM
	+La87J4JMmnp4j01PEyUTXZPBW6xg50O7Vo806J83gdGKUU5igLeXkBFrMsriw0q
	JoxPeHzCFfwBf/Lz7idrWKcBpofv+VqGboxbCoZj3OKJk7VuaqGuSoxKgQXZvwAA
	2zsxdUi2gAs9foA2OZ8jlYUJ043mKXH7EuwkHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746806812; x=
	1746893212; bh=jyrrLL6pNEaoCnUi1cDiZH8UNc4WSR1jAKygV8Vcp/Q=; b=U
	Ppw3I6wygDoZymOERFCXAyhASfAdj6//4xQcYZwsCm0WVuyZNm0Od8Dv3mZnhIOG
	MnbjEbb8w4nv6JMTV1VWcmVO8W82cJy3zvWEOcUll1TjTUtv62+el4yMHfOuFCC5
	0hQJYHceGlIAjRhUHwN12r6JUnl1ZJuOIW7HHEB84eY7+karv6Pt1PTvkxwNo8lV
	G9Fx5Ot8CGvTaKo6PGsQ6H6iR1dXwKLmtOzgcSbLz0qeDAMmRqifRzfcoAfVeKFp
	wQ1Gookn9E3rXeEb6rRsX+w/sngzJXiM2KpsBxIQvyRO0rFA5il3KBsVygpk9wNf
	eB6KDseFz8NoM5VpJEvow==
X-ME-Sender: <xms:GigeaAavgig7sy90lGSuRZQBnT1RiHmEUylIM8KE7-ClYV1tE-aikw>
    <xme:GigeaLYFYn73-pcWSpPeKiT-IzUBXly_BV8JxybdCqyi2O1rbDi74Os0T0iyuPFWi
    2ihCAtbf3_XZdr8GGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleeftdehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:GigeaK9KBvAFhcdHvXNA1WP9IedwLUk9m7X_lkKr7qlHWOJM7gMmqQ>
    <xmx:GigeaKpy_rmu3cPs_AXGzWYVd8RYSlQV8bdW-1OrpN-gX-JL4Dstzg>
    <xmx:GigeaLpSVyk8ADc98aCZArZFdS_tVKm7Z2xJDBuiqrmgbkPcX4EB3g>
    <xmx:GigeaITx3x6ORAxlGj8EESOiYsrNgLDnbo_y-0ajZToKhto_uV5_YQ>
    <xmx:HCgeaALSxJ-0enKgeC4LEag1gPFI6jhZOApI2DRNfUANWa_myZDleEOC>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B4A331C2006A; Fri,  9 May 2025 12:06:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T7b1dce586c77e7bf
Date: Fri, 09 May 2025 18:04:21 +0200
From: "Sven Peter" <sven@svenpeter.dev>
To: "Lee Jones" <lee@kernel.org>
Cc: "Janne Grunau" <j@jannau.net>, "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
 "Neal Gompa" <neal@gompa.dev>, "Hector Martin" <marcan@marcan.st>,
 "Linus Walleij" <linus.walleij@linaro.org>,
 "Bartosz Golaszewski" <brgl@bgdev.pl>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Sebastian Reichel" <sre@kernel.org>,
 "Marc Zyngier" <maz@kernel.org>, "Russell King" <rmk+kernel@armlinux.org.uk>,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Message-Id: <0acee8e6-f9e1-4f25-aff6-d3f71cd11d37@app.fastmail.com>
In-Reply-To: <20250509135104.GC2492385@google.com>
References: <20250503-smc-6-15-v4-0-500b9b6546fc@svenpeter.dev>
 <20250503-smc-6-15-v4-4-500b9b6546fc@svenpeter.dev>
 <20250509135104.GC2492385@google.com>
Subject: Re: [PATCH v4 4/9] mfd: Add Apple Silicon System Management Controller
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Lee,

On Fri, May 9, 2025, at 15:51, Lee Jones wrote:
> On Sat, 03 May 2025, Sven Peter via B4 Relay wrote:
>
>> From: Sven Peter <sven@svenpeter.dev>
>>=20
>> The System Management Controller (SMC) on Apple Silicon machines is a
>> piece of hardware that exposes various functionalities such as
>> temperature sensors, voltage/power meters, shutdown/reboot handling,
>> GPIOs and more.
>>=20
>> Communication happens via a shared mailbox using the RTKit protocol
>> which is also used for other co-processors. The SMC protocol then all=
ows
>> reading and writing many different keys which implement the various
>> features. The MFD core device handles this protocol and exposes it
>> to the sub-devices.
>>=20
>> Some of the sub-devices are potentially also useful on pre-M1 Apple
>> machines and support for SMCs on these machines can be added at a lat=
er
>> time.
>>=20
>> Co-developed-by: Hector Martin <marcan@marcan.st>
>> Signed-off-by: Hector Martin <marcan@marcan.st>
>> Signed-off-by: Sven Peter <sven@svenpeter.dev>
>> ---
>>  MAINTAINERS                |   2 +
>>  drivers/mfd/Kconfig        |  15 ++
>>  drivers/mfd/Makefile       |   1 +
>>  drivers/mfd/macsmc.c       | 657 +++++++++++++++++++++++++++++++++++=
++++++++++
>>  include/linux/mfd/macsmc.h | 337 +++++++++++++++++++++++
>>  5 files changed, 1012 insertions(+)
>
> Looks generally okay.  Much better than the previous attempts.
>
> If the exported API gets much larger, it'd be better suited to
> drivers/platform or perhaps co-located with the rtkit in drivers/soc,
> whilst leaving the resource handling and child driver registration her=
e.
>
> Most of what I see here are stylistic issues, so bear with me.

Thanks for the review!

>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 2c16b2fc3fec76104967530f487123485af1e777..831df43892a64c95e00c2=
4d77b8aa2a6ec87e074 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2300,6 +2300,7 @@ F:	drivers/input/touchscreen/apple_z2.c
>>  F:	drivers/iommu/apple-dart.c
>>  F:	drivers/iommu/io-pgtable-dart.c
>>  F:	drivers/irqchip/irq-apple-aic.c
>> +F:	drivers/mfd/macsmc.c
>>  F:	drivers/nvme/host/apple.c
>>  F:	drivers/nvmem/apple-efuses.c
>>  F:	drivers/nvmem/apple-spmi-nvmem.c
>> @@ -2312,6 +2313,7 @@ F:	drivers/video/backlight/apple_dwi_bl.c
>>  F:	drivers/watchdog/apple_wdt.c
>>  F:	include/dt-bindings/interrupt-controller/apple-aic.h
>>  F:	include/dt-bindings/pinctrl/apple.h
>> +F:	include/linux/mfd/macsmc.h
>>  F:	include/linux/soc/apple/*
>> =20
>>  ARM/ARTPEC MACHINE SUPPORT
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index 22b93631003943c393d9fe704748bc23f1905397..da56fc4f05b7b7e0a521f=
cd97bee087424ec4d5b 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -285,6 +285,21 @@ config MFD_CS42L43_SDW
>>  	  Select this to support the Cirrus Logic CS42L43 PC CODEC with
>>  	  headphone and class D speaker drivers over SoundWire.
>> =20
>> +config MFD_MACSMC
>> +	tristate "Apple Silicon System Management Controller (SMC)"
>> +	select MFD_CORE
>> +	help
>> +	  The System Management Controller (SMC) on Apple Silicon machines =
is a
>> +	  piece of hardware that exposes various functionalities such as
>> +	  temperature sensors, voltage/power meters, shutdown/reboot handli=
ng,
>> +	  GPIOs and more.
>> +
>> +	  Communication happens via a shared mailbox using the RTKit protoc=
ol
>> +	  which is also used for other co-processors. The SMC protocol then
>> +	  allows reading and writing many different keys which implement the
>> +	  various features. The MFD core device handles this protocol and
>> +	  exposes it to the sub-devices.
>
> MFD doesn't usually like this much knowledge of the communication
> mechanism.  We usually rely on; I2C, SPI, USB, etc APIs for that.
> However, given the unusualness of this device and the submission
> history, I'm willing to slacken that off a bit.

Thanks, if the exposed API ever gets any larger (which I really don't ex=
pect) I'm
happy to figure out how to split and move it to drivers/{platform,soc} t=
hen.


>
>>  config MFD_MADERA
>>  	tristate "Cirrus Logic Madera codecs"
>>  	select MFD_CORE
>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>> index 948cbdf42a18b22a826f0b17fb8d5796a7ec8ba6..e9e2403d961a631d9d63a=
274e0e4f6457ae9e0f2 100644
>> --- a/drivers/mfd/Makefile
>> +++ b/drivers/mfd/Makefile
>> @@ -21,6 +21,7 @@ obj-$(CONFIG_MFD_CS42L43_SDW)	+=3D cs42l43-sdw.o
>>  obj-$(CONFIG_MFD_ENE_KB3930)	+=3D ene-kb3930.o
>>  obj-$(CONFIG_MFD_EXYNOS_LPASS)	+=3D exynos-lpass.o
>>  obj-$(CONFIG_MFD_GATEWORKS_GSC)	+=3D gateworks-gsc.o
>> +obj-$(CONFIG_MFD_MACSMC)	+=3D macsmc.o
>> =20
>>  obj-$(CONFIG_MFD_TI_LP873X)	+=3D lp873x.o
>>  obj-$(CONFIG_MFD_TI_LP87565)	+=3D lp87565.o
>> diff --git a/drivers/mfd/macsmc.c b/drivers/mfd/macsmc.c
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..59c2851b70f70a2214342=
87cc99ef870a96f3659
>> --- /dev/null
>> +++ b/drivers/mfd/macsmc.c
>> @@ -0,0 +1,657 @@
>> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>> +/*
>> + * Apple SMC (System Management Controller) MFD driver
>> + *
>> + * Copyright The Asahi Linux Contributors
>> + */
>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/delay.h>
>> +#include <linux/device.h>
>> +#include <linux/io.h>
>> +#include <linux/ioport.h>
>> +#include <linux/math.h>
>> +#include <linux/mfd/core.h>
>> +#include <linux/mfd/macsmc.h>
>> +#include <linux/notifier.h>
>> +#include <linux/of.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/soc/apple/rtkit.h>
>> +#include <linux/unaligned.h>
>> +
>> +#define SMC_ENDPOINT			0x20
>> +
>> +/* We don't actually know the true size here but this seem reasonabl=
e */
>> +#define SMC_SHMEM_SIZE			0x1000
>> +#define SMC_MAX_SIZE			255
>> +
>> +#define SMC_MSG_READ_KEY		0x10
>> +#define SMC_MSG_WRITE_KEY		0x11
>> +#define SMC_MSG_GET_KEY_BY_INDEX	0x12
>> +#define SMC_MSG_GET_KEY_INFO		0x13
>> +#define SMC_MSG_INITIALIZE		0x17
>> +#define SMC_MSG_NOTIFICATION		0x18
>> +#define SMC_MSG_RW_KEY			0x20
>> +
>> +#define SMC_DATA			GENMASK_ULL(63, 32)
>> +#define SMC_WSIZE			GENMASK_ULL(31, 24)
>> +#define SMC_SIZE			GENMASK_ULL(23, 16)
>> +#define SMC_ID				GENMASK_ULL(15, 12)
>> +#define SMC_MSG				GENMASK_ULL(7, 0)
>> +#define SMC_RESULT			SMC_MSG
>> +
>> +#define SMC_RECV_TIMEOUT		500
>> +
>> +static const struct mfd_cell apple_smc_devs[] =3D {
>> +	MFD_CELL_OF("macsmc-gpio", NULL, NULL, 0, 0, "apple,smc-gpio"),
>> +	MFD_CELL_OF("macsmc-reboot", NULL, NULL, 0, 0, "apple,smc-reboot"),
>
> Are there more devices coming?

Yes, we additionally have drivers for rtc, hwmon and hid in our downstre=
am
tree right now but they're not quite ready to be upstreamed yet.
None of those need additional code inside drivers/mfd except for entries
here. I haven't added them because the dt-bindings aren't ready and
they might need compatibles as well.

>
>> +};
>> +
>> +static int apple_smc_cmd_locked(struct apple_smc *smc, u64 cmd, u64 =
arg,
>> +				  u64 size, u64 wsize, u32 *ret_data)
>> +{
>> +	int ret;
>> +	u64 msg;
>> +	u8 result;
>> +
>> +	lockdep_assert_held(&smc->mutex);
>> +
>> +	if (!smc->alive)
>> +		return -EIO;
>> +	if (smc->atomic_mode)
>> +		return -EIO;
>> +
>> +	reinit_completion(&smc->cmd_done);
>> +
>> +	smc->msg_id =3D (smc->msg_id + 1) & 0xf;
>> +	msg =3D (FIELD_PREP(SMC_MSG, cmd) |
>> +	       FIELD_PREP(SMC_SIZE, size) |
>> +	       FIELD_PREP(SMC_WSIZE, wsize) |
>> +	       FIELD_PREP(SMC_ID, smc->msg_id) |
>> +	       FIELD_PREP(SMC_DATA, arg));
>> +
>> +	ret =3D apple_rtkit_send_message(smc->rtk, SMC_ENDPOINT, msg, NULL,=
 false);
>> +	if (ret < 0) {
>> +		dev_err(smc->dev, "Failed to send command\n");
>> +		return ret;
>> +	}
>> +
>> +	do {
>> +		if (wait_for_completion_timeout(&smc->cmd_done,
>> +						msecs_to_jiffies(SMC_RECV_TIMEOUT)) =3D=3D 0) {
>> +			dev_err(smc->dev, "Command timed out (%llx)", msg);
>> +			return -ETIMEDOUT;
>> +		}
>> +		if (FIELD_GET(SMC_ID, smc->cmd_ret) =3D=3D smc->msg_id)
>> +			break;
>> +		dev_err(smc->dev, "Command sequence mismatch (expected %d, got %d)=
\n",
>> +			smc->msg_id, (unsigned int)FIELD_GET(SMC_ID, smc->cmd_ret));
>> +	} while (1);
>> +
>> +	result =3D FIELD_GET(SMC_RESULT, smc->cmd_ret);
>> +	if (result !=3D 0)
>> +		return -result;
>> +
>> +	if (ret_data)
>> +		*ret_data =3D FIELD_GET(SMC_DATA, smc->cmd_ret);
>> +
>> +	return FIELD_GET(SMC_SIZE, smc->cmd_ret);
>> +}
>> +
>> +static int apple_smc_cmd(struct apple_smc *smc, u64 cmd, u64 arg,
>> +			 u64 size, u64 wsize, u32 *ret_data)
>> +{
>> +	guard(mutex)(&smc->mutex);
>> +
>> +	return apple_smc_cmd_locked(smc, cmd, arg, size, wsize, ret_data);
>> +}
>> +
>> +static int apple_smc_rw_locked(struct apple_smc *smc, smc_key key,
>> +				const void *wbuf, size_t wsize,
>> +				void *rbuf, size_t rsize)
>> +{
>> +	int ret;
>> +	u64 cmd;
>> +	u64 smc_size, smc_wsize;
>> +	u32 rdata;
>> +
>> +	lockdep_assert_held(&smc->mutex);
>> +
>> +	dev_dbg(smc->dev, "SMC key: %p4ch, wsize: %zu, rsize: %zu\n", &key,=
 wsize, rsize);
>> +
>> +	if (rsize > SMC_MAX_SIZE)
>> +		return -EINVAL;
>> +	if (wsize > SMC_MAX_SIZE)
>> +		return -EINVAL;
>> +
>> +	if (rsize && wsize) {
>> +		cmd =3D SMC_MSG_RW_KEY;
>> +		memcpy_toio(smc->shmem.iomem, wbuf, wsize);
>> +		smc_size =3D rsize;
>> +		smc_wsize =3D wsize;
>> +	} else if (wsize && !rsize) {
>> +		cmd =3D SMC_MSG_WRITE_KEY;
>> +		memcpy_toio(smc->shmem.iomem, wbuf, wsize);
>> +		/*
>> +		 * Setting size to the length we want to write and wsize to 0
>> +		 * looks silly but that's how the SMC protocol works =C2=AF\_(=E3=83=
=84)_/=C2=AF
>> +		 */
>> +		smc_size =3D wsize;
>> +		smc_wsize =3D 0;
>> +	} else if (!wsize && rsize) {
>> +		cmd =3D SMC_MSG_READ_KEY;
>> +		smc_size =3D rsize;
>> +		smc_wsize =3D 0;
>> +	} else {
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret =3D apple_smc_cmd_locked(smc, cmd, key, smc_size, smc_wsize, &r=
data);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	if (rsize) {
>> +		/*
>> +		 * Small data <=3D 4 bytes is returned as part of the reply
>> +		 * message which is sent over the mailbox FIFO. Everything
>> +		 * bigger has to be copied from SRAM which is mapped as
>> +		 * Device memory.
>> +		 */
>> +		if (rsize <=3D 4)
>> +			memcpy(rbuf, &rdata, rsize);
>> +		else
>> +			memcpy_fromio(rbuf, smc->shmem.iomem, rsize);
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +int apple_smc_read(struct apple_smc *smc, smc_key key, void *buf, si=
ze_t size)
>> +{
>> +	guard(mutex)(&smc->mutex);
>> +
>> +	return apple_smc_rw_locked(smc, key, NULL, 0, buf, size);
>> +}
>> +EXPORT_SYMBOL(apple_smc_read);
>> +
>> +int apple_smc_write(struct apple_smc *smc, smc_key key, void *buf, s=
ize_t size)
>> +{
>> +	guard(mutex)(&smc->mutex);
>> +
>> +	return apple_smc_rw_locked(smc, key, buf, size, NULL, 0);
>> +}
>> +EXPORT_SYMBOL(apple_smc_write);
>> +
>> +int apple_smc_rw(struct apple_smc *smc, smc_key key, void *wbuf, siz=
e_t wsize,
>> +	void *rbuf, size_t rsize)
>> +{
>> +	guard(mutex)(&smc->mutex);
>> +
>> +	return apple_smc_rw_locked(smc, key, wbuf, wsize, rbuf, rsize);
>> +}
>> +EXPORT_SYMBOL(apple_smc_rw);
>> +
>> +int apple_smc_get_key_by_index(struct apple_smc *smc, int index, smc=
_key *key)
>> +{
>> +	int ret;
>> +
>> +	ret =3D apple_smc_cmd(smc, SMC_MSG_GET_KEY_BY_INDEX, index, 0, 0, k=
ey);
>> +
>> +	*key =3D swab32(*key);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(apple_smc_get_key_by_index);
>> +
>> +int apple_smc_get_key_info(struct apple_smc *smc, smc_key key, struc=
t apple_smc_key_info *info)
>> +{
>> +	u8 key_info[6];
>> +	int ret;
>> +
>> +	ret =3D apple_smc_cmd(smc, SMC_MSG_GET_KEY_INFO, key, 0, 0, NULL);
>> +	if (ret >=3D 0 && info) {
>> +		memcpy_fromio(key_info, smc->shmem.iomem, sizeof(key_info));
>> +		info->size =3D key_info[0];
>> +		info->type_code =3D get_unaligned_be32(&key_info[1]);
>> +		info->flags =3D key_info[5];
>> +	}
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(apple_smc_get_key_info);
>> +
>> +int apple_smc_find_first_key_index(struct apple_smc *smc, smc_key ke=
y)
>> +{
>> +	int start, count;
>> +
>> +	/* return early if the key is out of bounds */
>
> I'll only say this once, but it applies throughout.
>
> Please start comments with an uppercase char.

Sure, will fix that everywhere.

>
>> +	if (key <=3D smc->first_key)
>> +		return 0;
>> +	if (key > smc->last_key)
>> +		return smc->key_count;
>> +
>> +	/* binary search to find index of first SMC key bigger or equal to =
key */
>> +	start =3D 0;
>> +	count =3D smc->key_count;
>> +	while (count > 1) {
>> +		int ret;
>> +		smc_key pkey;
>> +		int pivot =3D start + ((count - 1) >> 1);
>> +
>> +		ret =3D apple_smc_get_key_by_index(smc, pivot, &pkey);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		if (pkey =3D=3D key)
>> +			return pivot;
>> +
>> +		pivot++;
>> +
>> +		if (pkey < key) {
>> +			count -=3D pivot - start;
>> +			start =3D pivot;
>> +		} else {
>> +			count =3D pivot - start;
>> +		}
>> +	}
>> +
>> +	return start;
>> +}
>> +EXPORT_SYMBOL(apple_smc_find_first_key_index);
>> +
>> +int apple_smc_read_f32_scaled(struct apple_smc *smc, smc_key key, in=
t *p, int scale)
>> +{
>> +	u32 fval;
>> +	u64 val;
>> +	int ret, exp;
>> +
>> +	/* pretend the 4 bytes returned by SMC are a 32bit unsigned integer=
 */
>> +	ret =3D apple_smc_read_u32(smc, key, &fval);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* extract exponent and fraction from the IEEE 754 32bit float */
>
> This seems like it's to technical / generic to live in a lowly device
> driver.  Is this specific to this device?  If it's generic math stuff,
> shouldn't it live somewhere more generic in the form of helpers?

Agreed. It's only used by our hwmon driver so far which we will submit l=
ater
and I can thus just drop it for this initial submission and figure out
where it can live then. The same is true for apple_smc_read_ioft_scaled.

>
>> +	val =3D ((u64)((fval & GENMASK(22, 0)) | BIT(23)));
>> +	exp =3D ((fval >> 23) & 0xff) - 127 - 23;
>> +
>> +	/* move fraction to target scale */
>> +	if (scale < 0) {
>> +		val <<=3D 32;
>> +		exp -=3D 32;
>> +		val /=3D -scale;
>> +	} else {
>> +		val *=3D scale;
>> +	}
>> +
>> +	/* apply exponent if possible and fall back to 0 / U64_MAX on overf=
low */
>> +	if (exp > 63)
>> +		val =3D U64_MAX;
>> +	else if (exp < -63)
>> +		val =3D 0;
>> +	else if (exp < 0)
>> +		val >>=3D -exp;
>> +	else if (exp !=3D 0 && (val & ~((1UL << (64 - exp)) - 1))) /* overf=
low */
>> +		val =3D U64_MAX;
>> +	else
>> +		val <<=3D exp;
>> +
>> +	/* handle IEEE 754 32bit float sign bit and catch possible overflow=
s */
>> +	if (fval & BIT(31)) {
>> +		if (val > (-(s64)INT_MIN))
>> +			*p =3D INT_MIN;
>> +		else
>> +			*p =3D -val;
>> +	} else {
>> +		if (val > INT_MAX)
>> +			*p =3D INT_MAX;
>> +		else
>> +			*p =3D val;
>> +	}
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(apple_smc_read_f32_scaled);
>> +
>> +int apple_smc_read_ioft_scaled(struct apple_smc *smc, smc_key key, u=
64 *p,
>> +			       int scale)
>
> Unwrap everything less than 100-chars please.
>

Ok, will fix that as well everywhere.

>> +{
>> +	u64 val;
>> +	int ret;
>> +
>> +	ret =3D apple_smc_read_u64(smc, key, &val);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/*
>> +	 * The value val is represented in 48.16 fixed-point format, where
>> +	 * the upper 48 bits represent the integer part and the lower 16 bi=
ts
>> +	 * represent the fractional part. Dividing by 1 << 16 extracts the
>> +	 * integer part by discarding the fractional portion.
>> +	 * To scale the value as requested mult_frac is used to multiply val
>> +	 * by the scaling factor while dividing by 1 << 16 in a single step.
>> +	 */
>> +	*p =3D mult_frac(val, scale, (1<<16));
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(apple_smc_read_ioft_scaled);
>> +
>> +int apple_smc_enter_atomic(struct apple_smc *smc)
>> +{
>> +	guard(mutex)(&smc->mutex);
>> +
>> +	/*
>> +	 * Disable notifications since this is called before shutdown and no
>> +	 * notification handler will be able to handle the notification
>> +	 * using atomic operations only. Also ignore any failure here
>> +	 * because we're about to shut down or reboot anyway.
>> +	 * We can't use apple_smc_write_flag here since that would try to l=
ock
>> +	 * smc->mutex again.
>> +	 */
>> +	const u8 flag =3D 0;
>> +
>> +	apple_smc_rw_locked(smc, SMC_KEY(NTAP), &flag, sizeof(flag), NULL, =
0);
>> +
>> +	smc->atomic_mode =3D true;
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(apple_smc_enter_atomic);
>> +
>> +int apple_smc_write_atomic(struct apple_smc *smc, smc_key key, void =
*buf, size_t size)
>> +{
>> +	guard(spinlock_irqsave)(&smc->lock);
>> +	int ret;
>> +	u64 msg;
>> +	u8 result;
>> +
>> +	if (size > SMC_MAX_SIZE || size =3D=3D 0)
>> +		return -EINVAL;
>> +
>> +	if (!smc->alive)
>> +		return -EIO;
>> +	if (!smc->atomic_mode)
>> +		return -EIO;
>> +
>> +	memcpy_toio(smc->shmem.iomem, buf, size);
>> +	smc->msg_id =3D (smc->msg_id + 1) & 0xf;
>> +	msg =3D (FIELD_PREP(SMC_MSG, SMC_MSG_WRITE_KEY) |
>> +	       FIELD_PREP(SMC_SIZE, size) |
>> +	       FIELD_PREP(SMC_ID, smc->msg_id) |
>> +	       FIELD_PREP(SMC_DATA, key));
>> +	smc->atomic_pending =3D true;
>> +
>> +	ret =3D apple_rtkit_send_message(smc->rtk, SMC_ENDPOINT, msg, NULL,=
 true);
>> +	if (ret < 0) {
>> +		dev_err(smc->dev, "Failed to send command (%d)\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	while (smc->atomic_pending) {
>> +		ret =3D apple_rtkit_poll(smc->rtk);
>> +		if (ret < 0) {
>> +			dev_err(smc->dev, "RTKit poll failed (%llx)", msg);
>> +			return ret;
>> +		}
>> +		udelay(100);
>> +	}
>> +
>> +	if (FIELD_GET(SMC_ID, smc->cmd_ret) !=3D smc->msg_id) {
>> +		dev_err(smc->dev, "Command sequence mismatch (expected %d, got %d)=
\n",
>> +			smc->msg_id, (unsigned int)FIELD_GET(SMC_ID, smc->cmd_ret));
>> +		return -EIO;
>> +	}
>> +
>> +	result =3D FIELD_GET(SMC_RESULT, smc->cmd_ret);
>> +	if (result !=3D 0)
>> +		return -result;
>> +
>> +	return FIELD_GET(SMC_SIZE, smc->cmd_ret);
>> +}
>> +EXPORT_SYMBOL(apple_smc_write_atomic);
>> +
>> +static void apple_smc_rtkit_crashed(void *cookie, const void *bfr, s=
ize_t bfr_len)
>> +{
>> +	struct apple_smc *smc =3D cookie;
>> +
>> +	dev_err(smc->dev, "SMC crashed! Your system will reboot in a few se=
conds...\n");
>> +	smc->alive =3D false;
>> +}
>> +
>> +static int apple_smc_rtkit_shmem_setup(void *cookie, struct apple_rt=
kit_shmem *bfr)
>> +{
>> +	struct apple_smc *smc =3D cookie;
>> +	struct resource res =3D {
>
> I don't get this at all.  Is this left over from a previous version?
> Why do you need to store these values in a resource struct that never
> gets used?

I think it might be a left over. Right now it's only used for
resource_contains a few lines below but I can just open-code that
to save a few lines and makes this less confusing.

>
>> +		.start =3D bfr->iova,
>> +		.end =3D bfr->iova + bfr->size - 1,
>> +		.name =3D "rtkit_map",
>> +		.flags =3D smc->sram->flags,
>> +	};
>> +
>> +	if (!bfr->iova) {
>> +		dev_err(smc->dev, "RTKit wants a RAM buffer\n");
>> +		return -EIO;
>> +	}
>> +
>> +	if (res.end < res.start || !resource_contains(smc->sram, &res)) {
>> +		dev_err(smc->dev,
>> +			"RTKit buffer request outside SRAM region: %pR", &res);
>> +		return -EFAULT;
>> +	}
>> +
>> +	bfr->iomem =3D smc->sram_base + (res.start - smc->sram->start);
>> +	bfr->is_mapped =3D true;
>> +
>> +	return 0;
>> +}
>> +
>> +static void apple_smc_rtkit_shmem_destroy(void *cookie, struct apple=
_rtkit_shmem *bfr)
>> +{
>> +	// no-op
>> +}
>
> Looks like .destroy() is checked before being called.
>
> You can remove this.

Ack, will be removed.

>
>> +static bool apple_smc_rtkit_recv_early(void *cookie, u8 endpoint, u6=
4 message)
>> +{
>> +	struct apple_smc *smc =3D cookie;
>> +
>> +	if (endpoint !=3D SMC_ENDPOINT) {
>> +		dev_err(smc->dev, "Received message for unknown endpoint 0x%x\n", =
endpoint);
>> +		return false;
>> +	}
>> +
>> +	if (!smc->initialized) {
>> +		int ret;
>> +
>> +		smc->shmem.iova =3D message;
>> +		smc->shmem.size =3D SMC_SHMEM_SIZE;
>> +		ret =3D apple_smc_rtkit_shmem_setup(smc, &smc->shmem);
>> +		if (ret < 0)
>> +			dev_err(smc->dev, "Failed to initialize shared memory\n");
>
> We shouldn't submit an error then carry on.
>
> If this is not catastrophic, it should be a warn().

It's quite catastrophic actually and I had to double check myself to make
sure it's handled: smc->init_done is completed with smc->alive still fal=
se
if this happens. Then further below in probe the following code actually
propagates the error and eventually returns -EIO:

	if (wait_for_completion_timeout(&smc->init_done,
					msecs_to_jiffies(SMC_RECV_TIMEOUT)) =3D=3D 0) {
		[...]
	}

	if (!smc->alive) {
		ret =3D -EIO;
		goto cleanup;
	}

I'll see if I can find a better way to write this and otherwise add a co=
mment
to explain what's going on.

>
>> +		else
>> +			smc->alive =3D true;
>> +		smc->initialized =3D true;
>> +		complete(&smc->init_done);
>> +	} else if (FIELD_GET(SMC_MSG, message) =3D=3D SMC_MSG_NOTIFICATION)=
 {
>> +		/* Handle these in the RTKit worker thread */
>> +		return false;
>> +	} else {
>> +		smc->cmd_ret =3D message;
>> +		if (smc->atomic_pending)
>> +			smc->atomic_pending =3D false;
>> +		else
>> +			complete(&smc->cmd_done);
>> +	}
>> +
>> +	return true;
>> +}
>> +
>> +static void apple_smc_rtkit_recv(void *cookie, u8 endpoint, u64 mess=
age)
>> +{
>> +	struct apple_smc *smc =3D cookie;
>> +	uint32_t event;
>> +
>> +	if (endpoint !=3D SMC_ENDPOINT) {
>> +		dev_err(smc->dev, "Received message for unknown endpoint 0x%x\n", =
endpoint);
>> +		return;
>
> This error is not being propagated?
>
> If there are no repercussions, this too should be a warn(), or better
> still, pass the error back and do something about it.

This can only happen if there's either a bug in our code or a bug in App=
le's
firmware. In either case we can't do much except printing a warning here.
>
>> +	}
>> +
>> +	if (FIELD_GET(SMC_MSG, message) !=3D SMC_MSG_NOTIFICATION) {
>> +		dev_err(smc->dev, "Received unknown message from worker: 0x%llx\n"=
, message);
>> +		return;
>> +	}
>> +
>> +	event =3D FIELD_GET(SMC_DATA, message);
>> +	dev_dbg(smc->dev, "Event: 0x%08x\n", event);
>
> How useful are these debug messages post-development?

Not very, I'll remove them.

>
>> +	blocking_notifier_call_chain(&smc->event_handlers, event, NULL);
>> +}
>> +
>> +static const struct apple_rtkit_ops apple_smc_rtkit_ops =3D {
>> +	.crashed =3D apple_smc_rtkit_crashed,
>> +	.recv_message =3D apple_smc_rtkit_recv,
>> +	.recv_message_early =3D apple_smc_rtkit_recv_early,
>> +	.shmem_setup =3D apple_smc_rtkit_shmem_setup,
>> +	.shmem_destroy =3D apple_smc_rtkit_shmem_destroy,
>> +};
>> +
>> +static int apple_smc_platform_probe(struct platform_device *pdev)
>
> Drop the platform part.

Ack, I think that's a leftover from the previous version as well.

>
>> +{
>> +	int ret;
>> +	u32 count;
>> +	struct apple_smc *smc;
>> +	struct device *dev =3D &pdev->dev;
>
> Reverse these please.
>
> Largest / longest at the top - "reverse Christmas-tree".

Ack.

>
>> +	smc =3D devm_kzalloc(dev, sizeof(*smc), GFP_KERNEL);
>> +	if (!smc)
>> +		return -ENOMEM;
>> +
>> +	smc->dev =3D &pdev->dev;
>> +	smc->sram =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "s=
ram");
>> +	if (!smc->sram)
>> +		return dev_err_probe(dev, EIO,
>> +				     "No SRAM region");
>> +
>> +	smc->sram_base =3D devm_ioremap_resource(dev, smc->sram);
>> +	if (IS_ERR(smc->sram_base))
>> +		return dev_err_probe(dev, PTR_ERR(smc->sram_base),
>> +				     "Failed to map SRAM region");
>
> All of the above usually gets condensed into:
>
> 	devm_platform_ioremap_resource_byname()

Ack.

>
>> +	smc->rtk =3D
>> +		devm_apple_rtkit_init(dev, smc, NULL, 0, &apple_smc_rtkit_ops);
>> +	if (IS_ERR(smc->rtk))
>> +		return dev_err_probe(dev, PTR_ERR(smc->rtk),
>> +				     "Failed to initialize RTKit");
>> +
>> +	ret =3D apple_rtkit_wake(smc->rtk);
>> +	if (ret !=3D 0)
>
> Just (ret) will do - throughout.

Ack.

>
>> +		return dev_err_probe(dev, ret,
>> +				     "Failed to wake up SMC");
>> +
>> +	ret =3D apple_rtkit_start_ep(smc->rtk, SMC_ENDPOINT);
>> +	if (ret !=3D 0) {
>> +		ret =3D dev_err_probe(dev, ret,
>> +				     "Failed to start SMC endpoint");
>> +		goto cleanup;
>> +	}
>> +
>> +	init_completion(&smc->init_done);
>> +	init_completion(&smc->cmd_done);
>> +
>> +	ret =3D apple_rtkit_send_message(smc->rtk, SMC_ENDPOINT,
>> +				       FIELD_PREP(SMC_MSG, SMC_MSG_INITIALIZE), NULL, false);
>> +	if (ret < 0) {
>> +		ret =3D dev_err_probe(dev, ret, "Failed to send init message");
>> +		goto cleanup;
>> +	}
>> +
>> +	if (wait_for_completion_timeout(&smc->init_done,
>> +					msecs_to_jiffies(SMC_RECV_TIMEOUT)) =3D=3D 0) {
>> +		ret =3D -ETIMEDOUT;
>> +		dev_err(dev, "Timed out initializing SMC");
>> +		goto cleanup;
>> +	}
>> +
>> +	if (!smc->alive) {
>> +		ret =3D -EIO;
>> +		goto cleanup;
>> +	}
>> +
>> +	dev_set_drvdata(&pdev->dev, smc);
>> +	BLOCKING_INIT_NOTIFIER_HEAD(&smc->event_handlers);
>> +
>> +	ret =3D apple_smc_read_u32(smc, SMC_KEY(#KEY), &count);
>> +	if (ret) {
>> +		ret =3D dev_err_probe(smc->dev, ret, "Failed to get key count");
>> +		goto cleanup;
>> +	}
>> +	smc->key_count =3D be32_to_cpu(count);
>> +
>> +	ret =3D apple_smc_get_key_by_index(smc, 0, &smc->first_key);
>> +	if (ret) {
>> +		ret =3D dev_err_probe(smc->dev, ret, "Failed to get first key");
>> +		goto cleanup;
>> +	}
>> +
>> +	ret =3D apple_smc_get_key_by_index(smc, smc->key_count - 1, &smc->l=
ast_key);
>> +	if (ret) {
>> +		ret =3D dev_err_probe(smc->dev, ret, "Failed to get last key");
>> +		goto cleanup;
>> +	}
>> +
>> +	/* Enable notifications */
>> +	apple_smc_write_flag(smc, SMC_KEY(NTAP), true);
>> +
>> +	dev_info(smc->dev, "Initialized (%d keys %p4ch ... %p4ch)\n",
>> +		 smc->key_count, &smc->first_key, &smc->last_key);
>> +
>> +	ret =3D mfd_add_devices(smc->dev, -1,
>
> devm_*?
>
> PLATFORM_DEVID_NONE

Will fix both.

>
>> +			      apple_smc_devs, ARRAY_SIZE(apple_smc_devs),
>> +			      NULL, 0, NULL);
>> +	if (ret) {
>> +		ret =3D dev_err_probe(smc->dev, ret, "Subdevice initialization fai=
led");
>
> "Failed to register sub-devices"

Ack.

>
>> +		goto cleanup;
>> +	}
>> +
>> +	return 0;
>> +
>> +cleanup:
>> +	/* Try to shut down RTKit, if it's not completely wedged */
>> +	if (apple_rtkit_is_running(smc->rtk))
>> +		apple_rtkit_quiesce(smc->rtk);
>> +
>> +	return ret;
>> +}
>> +
>> +static void apple_smc_platform_remove(struct platform_device *pdev)
>> +{
>> +	struct apple_smc *smc =3D platform_get_drvdata(pdev);
>> +
>> +	mfd_remove_devices(smc->dev);
>> +
>> +	/* Disable notifications */
>> +	apple_smc_write_flag(smc, SMC_KEY(NTAP), false);
>> +
>> +	/* Shut down SMC firmware */
>> +	if (apple_rtkit_is_running(smc->rtk))
>> +		apple_rtkit_quiesce(smc->rtk);
>> +}
>> +
>> +static const struct of_device_id apple_smc_of_match[] =3D {
>> +	{ .compatible =3D "apple,smc" },
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, apple_smc_of_match);
>> +
>> +static struct platform_driver apple_smc_driver =3D {
>> +	.driver =3D {
>> +		.name =3D "mfd-macsmc",
>> +		.owner =3D THIS_MODULE,
>
> This is handed by the core, you can remove it.

Ack.

>
>> +		.of_match_table =3D apple_smc_of_match,
>> +	},
>> +	.probe =3D apple_smc_platform_probe,
>> +	.remove =3D apple_smc_platform_remove,
>> +};
>> +module_platform_driver(apple_smc_driver);
>> +
>> +MODULE_AUTHOR("Hector Martin <marcan@marcan.st>");
>> +MODULE_AUTHOR("Sven Peter <sven@svenpeter.dev>");
>> +MODULE_LICENSE("Dual MIT/GPL");
>> +MODULE_DESCRIPTION("Apple SMC driver");
>> diff --git a/include/linux/mfd/macsmc.h b/include/linux/mfd/macsmc.h
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..0b24b8e44dcb4564b50e6=
d2145f23f23321139c1
>> --- /dev/null
>> +++ b/include/linux/mfd/macsmc.h
>> @@ -0,0 +1,337 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
>> +/*
>> + * Apple SMC (System Management Controller) core definitions
>> + *
>> + * Copyright (C) The Asahi Linux Contributors
>> + */
>> +
>> +#ifndef _LINUX_MFD_MACSMC_H
>> +#define _LINUX_MFD_MACSMC_H
>> +
>> +#include <linux/soc/apple/rtkit.h>
>> +
>> +/**
>> + * typedef smc_key - Alias for u32 to be used for SMC keys
>> + *
>> + * SMC keys are 32bit integers containing packed ASCII characters in=
 natural
>> + * integer order, i.e. 0xAABBCCDD, which represent the FourCC ABCD.
>> + * The SMC driver is designed with this assumption and ensures the r=
ight
>> + * endianness is used when these are stored to memory and sent to or=
 received
>> + * from the actual SMC firmware (which can be done in either shared =
memory or
>> + * as 64bit mailbox message on Apple Silicon).
>> + * Internally, SMC stores these keys in a table sorted lexicographic=
ally and
>> + * allows resolving an index into this table to the corresponding SM=
C key.
>> + * Thus, storing keys as u32 is very convenient as it allows to e.g.=
 use
>> + * normal comparison operators which directly map to the natural ord=
er used
>> + * by SMC firmware.
>> + *
>> + * This simple type alias is introduced to allow easy recognition of=
 SMC key
>> + * variables and arguments.
>> + */
>> +typedef u32 smc_key;
>> +
>> +/**
>> + * SMC_KEY - Convert FourCC SMC keys in source code to smc_key
>> + *
>> + * This macro can be used to easily define FourCC SMC keys in source=
 code
>> + * and convert these to u32 / smc_key, e.g. SMC_KEY(NTAP) will expan=
d to
>> + * 0x4e544150.
>> + */
>> +#define SMC_KEY(s) (smc_key)(_SMC_KEY(#s))
>> +#define _SMC_KEY(s) (((s)[0] << 24) | ((s)[1] << 16) | ((s)[2] << 8)=
 | (s)[3])
>> +
>> +#define APPLE_SMC_READABLE BIT(7)
>> +#define APPLE_SMC_WRITABLE BIT(6)
>> +#define APPLE_SMC_FUNCTION BIT(4)
>> +
>> +/**
>> + * struct apple_smc_key_info - information for a SMC key as returned=
 by SMC
>> + * @size: size of the buffer associated with this key
>> + * @type_code: FourCC code indicating the type for this key.
>> + *             Known types:
>> + *              ch8*: ASCII string
>> + *              flag: boolean, 1 or 0
>> + *              flt: 32-bit single-precision IEEE 754 float
>> + *              hex: binary data
>> + *              ioft: 64bit unsigned fixed-point intger (48.16)
>> + *              si8, ui8, si16, ui16, si32, ui32, si64, ui64: signed=
/unsigned 8-/16-/32-/64-bit integer
>> + * @flags: bitfield encoding flags (APPLE_SMC_{READABLE,WRITABLE,FUN=
CTION})
>> + */
>> +struct apple_smc_key_info {
>> +	u8 size;
>> +	u32 type_code;
>> +	u8 flags;
>> +};
>> +
>> +/**
>> + * struct apple_smc
>> + * @dev: underlying device struct for the physical backend device
>> + * @key_count: number of available SMC keys
>> + * @first_key: first valid SMC key
>> + * @last_key: last valid SMC key
>> + * @event_handlers: notifier call chain for events received from SMC
>> + * @rtk: pointer to Apple RTKit instance
>> + * @init_done: completion for initialization
>> + * @initialized: flag indicating if SMC is initialized
>> + * @alive: flag indicating if SMC is alive
>> + * @sram: pointer to SRAM resource
>> + * @sram_base: SRAM base address
>> + * @shmem: RTKit shared memory structure for SRAM
>> + * @msg_id: current message id for commands, will be incremented for=
 each command
>> + * @atomic_mode: flag set when atomic mode is entered
>> + * @atomic_pending: flag indicating pending atomic command
>> + * @cmd_done: completion for command execution in non-atomic mode
>> + * @cmd_ret: return value from SMC for last command
>> + * @mutex: mutex for non-atomic mode
>> + * @lock: spinlock for atomic mode
>> + */
>
> Make sure you enable W=3D1 when compiling and fix any fallout.
>

Ok, will check what happens with W=3D1.

>> +struct apple_smc {
>> +	struct device *dev;
>> +
>> +	u32 key_count;
>> +	smc_key first_key;
>> +	smc_key last_key;
>> +
>> +	struct blocking_notifier_head event_handlers;
>> +
>> +	struct apple_rtkit *rtk;
>> +
>> +	struct completion init_done;
>> +	bool initialized;
>> +	bool alive;
>> +
>> +	struct resource *sram;
>> +	void __iomem *sram_base;
>> +	struct apple_rtkit_shmem shmem;
>> +
>> +	unsigned int msg_id;
>> +
>> +	bool atomic_mode;
>> +	bool atomic_pending;
>> +	struct completion cmd_done;
>> +	u64 cmd_ret;
>> +
>> +	struct mutex mutex;
>> +	spinlock_t lock;
>> +};
>> +
>> +/**
>> + * apple_smc_read - read size bytes from given SMC key into buf
>> + * @smc: pointer to apple_smc struct
>> + * @key: smc_key to be read
>> + * @buf: buffer into which size bytes of data will be read from SMC
>> + * @size: number of bytes to be read into buf
>> + *
>> + * Return: Zero on success, negative errno on error
>> + */
>> +int apple_smc_read(struct apple_smc *smc, smc_key key, void *buf, si=
ze_t size);
>> +
>> +/**
>> + * apple_smc_write - write size bytes into given SMC key from buf
>> + * @smc: pointer to apple_smc struct
>> + * @key: smc_key data will be written to
>> + * @buf: buffer from which size bytes of data will be written to SMC
>> + * @size: number of bytes to be written
>> + *
>> + * Return: Zero on success, negative errno on error
>> + */
>> +int apple_smc_write(struct apple_smc *smc, smc_key key, void *buf, s=
ize_t size);
>> +
>> +/**
>> + * apple_smc_enter_atomic - enter atomic mode to be able to use appl=
e_smc_write_atomic
>> + * @smc: pointer to apple_smc struct
>> + *
>> + * This function switches the SMC backend to atomic mode which allow=
s the
>> + * use of apple_smc_write_atomic while disabling *all* other functio=
ns.
>> + * This is only used for shutdown/reboot which requires writing to a=
 SMC
>> + * key from atomic context.
>> + *
>> + * Return: Zero on success, negative errno on error
>> + */
>> +int apple_smc_enter_atomic(struct apple_smc *smc);
>> +
>> +/**
>> + * apple_smc_write_atomic - write size bytes into given SMC key from=
 buf without sleeping
>> + * @smc: pointer to apple_smc struct
>> + * @key: smc_key data will be written to
>> + * @buf: buffer from which size bytes of data will be written to SMC
>> + * @size: number of bytes to be written
>> + *
>> + * Note that this function will fail if apple_smc_enter_atomic hasn'=
t been
>> + * called before.
>> + *
>> + * Return: Zero on success, negative errno on error
>> + */
>> +int apple_smc_write_atomic(struct apple_smc *smc, smc_key key, void =
*buf, size_t size);
>> +
>> +/**
>> + * apple_smc_rw - write and then read using the given SMC key
>> + * @smc: pointer to apple_smc struct
>> + * @key: smc_key data will be written to
>> + * @wbuf: buffer from which size bytes of data will be written to SMC
>> + * @wsize: number of bytes to be written
>> + * @rbuf: buffer to which size bytes of data will be read from SMC
>> + * @rsize: number of bytes to be read
>> + *
>> + * Return: Zero on success, negative errno on error
>> + */
>> +int apple_smc_rw(struct apple_smc *smc, smc_key key, void *wbuf, siz=
e_t wsize,
>> +		 void *rbuf, size_t rsize);
>> +
>> +/**
>> + * apple_smc_get_key_by_index - given an index return the correspond=
ing SMC key
>> + * @smc: pointer to apple_smc struct
>> + * @index: index to be resolved
>> + * @key: buffer for SMC key to be returned
>> + *
>> + * Return: Zero on success, negative errno on error
>> + */
>> +int apple_smc_get_key_by_index(struct apple_smc *smc, int index, smc=
_key *key);
>> +
>> +/**
>> + * apple_smc_get_key_info - get key information from SMC
>> + * @smc: pointer to apple_smc struct
>> + * @key: key to acquire information for
>> + * @info: pointer to struct apple_smc_key_info which will be filled
>> + *
>> + * Return: Zero on success, negative errno on error
>> + */
>> +int apple_smc_get_key_info(struct apple_smc *smc, smc_key key, struc=
t apple_smc_key_info *info);
>> +
>> +/**
>> + * apple_smc_find_first_key_index - find index of first SMC key bigg=
er or equal to key
>> + * @smc: pointer to apple_smc struct
>> + * @key: smc_key to be found
>> + *
>> + * SMC keys are represented using either FourCC (which is stored as
>> + * uint32_t / smc_key in this driver) or an index into the table of =
available
>> + * keys which is sorted lexicographically.
>> + * This function takes a FourCC key and uses binary search to find t=
he
>> + * index of the first SMC key that is lexicographically equal or big=
ger than the
>> + * given input.
>> + * This is required for e.g. the GPIO driver: GPIO keys start with gP
>> + * and the driver has to find the first such key (by calling this fu=
nction with
>> + * key =3D SMC_KEY(gP00)) to be able to enumerate and register all a=
vailable GPIOs
>> + * at probe time.
>> + *
>> + * Return: Index of the first smc key that's bigger or equal to the =
given key.
>> + *
>> + * If the key is smaller than the first available key zero will be r=
eturned.
>> + * If the key is bigger than the last available key smc->key_count (=
i.e. an out
>> + * of bounds key) will be returned.
>> + */
>> +int apple_smc_find_first_key_index(struct apple_smc *smc, smc_key ke=
y);
>> +
>> +/**
>> + * apple_smc_key_exists - check if the given SMC key exists
>> + * @smc: pointer to apple_smc struct
>> + * @key: smc_key to be checked
>> + */
>> +static inline bool apple_smc_key_exists(struct apple_smc *smc, smc_k=
ey key)
>> +{
>> +	return apple_smc_get_key_info(smc, key, NULL) >=3D 0;
>> +}
>> +
>> +#define APPLE_SMC_TYPE_OPS(type) \
>> +	static inline int apple_smc_read_##type(struct apple_smc *smc, smc_=
key key, type *p) \
>> +	{ \
>> +		int ret =3D apple_smc_read(smc, key, p, sizeof(*p)); \
>> +		return (ret < 0) ? ret : ((ret !=3D sizeof(*p)) ? -EINVAL : 0); \
>> +	} \
>> +	static inline int apple_smc_write_##type(struct apple_smc *smc, smc=
_key key, type p) \
>> +	{ \
>> +		return apple_smc_write(smc, key, &p, sizeof(p)); \
>> +	} \
>> +	static inline int apple_smc_write_##type##_atomic(struct apple_smc =
*smc, smc_key key, type p) \
>> +	{ \
>> +		return apple_smc_write_atomic(smc, key, &p, sizeof(p)); \
>> +	} \
>> +	static inline int apple_smc_rw_##type(struct apple_smc *smc, smc_ke=
y key, \
>> +					      type w, type *r) \
>> +	{ \
>> +		int ret =3D apple_smc_rw(smc, key, &w, sizeof(w), r, sizeof(*r)); \
>> +		return (ret < 0) ? ret : ((ret !=3D sizeof(*r)) ? -EINVAL : 0); \
>> +	}
>> +
>> +APPLE_SMC_TYPE_OPS(u64)
>> +APPLE_SMC_TYPE_OPS(u32)
>> +APPLE_SMC_TYPE_OPS(u16)
>> +APPLE_SMC_TYPE_OPS(u8)
>> +APPLE_SMC_TYPE_OPS(s64)
>> +APPLE_SMC_TYPE_OPS(s32)
>> +APPLE_SMC_TYPE_OPS(s16)
>> +APPLE_SMC_TYPE_OPS(s8)
>> +
>> +static inline int apple_smc_read_flag(struct apple_smc *smc, smc_key=
 key, bool *flag)
>> +{
>> +	u8 val;
>> +	int ret =3D apple_smc_read_u8(smc, key, &val);
>> +
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	*flag =3D val ? true : false;
>> +	return ret;
>> +}
>> +
>> +static inline int apple_smc_write_flag(struct apple_smc *smc, smc_ke=
y key, bool state)
>> +{
>> +	return apple_smc_write_u8(smc, key, state ? 1 : 0);
>> +}
>> +
>> +static inline int apple_smc_write_flag_atomic(struct apple_smc *smc,=
 smc_key key, bool state)
>> +{
>> +	return apple_smc_write_u8_atomic(smc, key, state ? 1 : 0);
>> +}
>> +
>> +/**
>> + * apple_smc_read_f32_scaled - read a float value from SMC and scale=
 to a regular integer
>> + * @smc: pointer to apple_smc struct
>> + * @key: key to be read
>> + * @p: pointer to integer that will be overwritten with the read val=
ue
>> + * @scale: target scale
>> + *
>> + * Read a float value from the given SMC key and scale it to the giv=
en order
>> + * of magnitude. If the value is smaller than the given scale zero w=
ill be
>> + * used. If the value overflows an integer at the given scale p will=
 be set to
>> + * U64_MAX.
>> + *
>> + * This is useful for e.g. reading power consumption, which is repor=
ted by SMC
>> + * in Watt (W) as a floating point number, and scale it to uW like s=
o:
>> + *
>> + *     apple_smc_read_f32_scaled(smc, SMC_KEY(PSTR), &power_uW, 1000=
000);
>> + *
>> + * At that scale, noise starts to dominate the power measurements an=
yway and
>> + * there's no reason to deal with floats.
>> + *
>> + * Return: Zero on success, negative errno on error
>> + */
>> +int apple_smc_read_f32_scaled(struct apple_smc *smc, smc_key key, in=
t *p, int scale);
>> +
>> +/**
>> + * apple_smc_read_ioft_scaled - read a 48.16 fixed point from SMC an=
d scale to a regular integer
>> + * @smc: pointer to apple_smc struct
>> + * @key: key to be read
>> + * @p: pointer to integer that will be overwritten with the read val=
ue
>> + * @scale: target scale
>> + *
>> + * Read a 48.16 fixed point value from the given SMC key and scale i=
t to the
>> + * given order of magnitude. If the value is smaller than the given =
scale zero
>> + * will be used. If the value overflows an integer at the given scal=
e p will be
>> + * set to U64_MAX.
>> + *
>> + * This is useful for e.g. reading temperature, which is reported by=
 SMC in
>> + * degrees as a 48.16 fixed point number, and scale it to milli-degr=
ees Celsius
>> + * like so:
>> + *
>> + *     apple_smc_read_ioft_scaled(smc, SMC_KEY(TR0Z), &temperature_m=
C, 1000);
>> + *
>> + * Reporting temperature with more precision runs into measurements =
errors and
>> + * isn't very useful such that using a simple integer instead of fix=
ed point
>> + * numbers is reasonable.
>> + *
>> + * Return: Zero on success, negative errno on error
>> + */
>> +int apple_smc_read_ioft_scaled(struct apple_smc *smc, smc_key key, u=
64 *p, int scale);
>> +
>> +#endif
>>=20
>> --=20
>> 2.34.1
>>=20
>>=20
>
> --=20
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]


Thanks,


Sven


