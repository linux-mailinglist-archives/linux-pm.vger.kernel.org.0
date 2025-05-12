Return-Path: <linux-pm+bounces-27049-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2A8AB3C6F
	for <lists+linux-pm@lfdr.de>; Mon, 12 May 2025 17:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99DC917E4E2
	for <lists+linux-pm@lfdr.de>; Mon, 12 May 2025 15:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D210223C4FB;
	Mon, 12 May 2025 15:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="jL8JZhYU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pxC6oBya"
X-Original-To: linux-pm@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A627239567;
	Mon, 12 May 2025 15:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747064519; cv=none; b=QXpvn5FvUhMTCFldLCxe6fRf9gd4oEwgz+jAP4uycjqlBhqjulkJiUCn+WoNd6Za8eUFcXtrkSiksHIz+q/IZofPnZ7buFxlIj8hx/xHFLDp/P5uU0sWOjzUtd0UmiW+Vn7fpehElMQ1iILtZpDKmNjOcVh2KrP7mCnUdcHLFeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747064519; c=relaxed/simple;
	bh=+4oLiO4GFHU12kRH/cBJ0soX/a+bXHdHYP8wcVfW7ZU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=l+PEBVXQmkLJfLGUf24CsopV1+vaUVJ+I57XlgqASaeeXToURAYDwvYfYmbhE/qZuW+YYkYmOQ3FYscryCI0hMgP33re58d5v+yjZnpAJx/feY2NyWEoWuoR3hE2YRmVvJOjPuVNrTHffwWgzdONGopLyqS7jSp3nj3U7tT8ngU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev; spf=pass smtp.mailfrom=svenpeter.dev; dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b=jL8JZhYU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pxC6oBya; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 21A5925400D8;
	Mon, 12 May 2025 11:41:54 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-04.internal (MEProxy); Mon, 12 May 2025 11:41:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1747064513; x=1747150913; bh=A/ri/6ZjxW7RCFovjRl8X2bDl9rq/UBN
	CApnh0pl15I=; b=jL8JZhYU/eNhS1Dbxm8P0HfZ5uJ0f9c89R1Xokb5AT19RPm5
	+UMawNHN9e+gdyVjzbmeX0UKUI35c234NQmPyK/mQN1vlgMpkP+3fQ+z7WYvLzUG
	sceVXAUgUxkf5tiVfvmbw4vMxinru9KcJcufIOr8wRBYK0VIpTg7cCnCpCXG63Oh
	vRv1TLt6VN54bh03c1nN2wI8LocK8MRenPos2cZSlGgVs0sErjULY+GDJ7MKSHHr
	MDBkG0xm/dhyS/UpDBDXBJbUcXF6tYYybOXiIpQERyDgr5NDKJVU6fdAOl8WkyH8
	3uRz2iYtOXuvSg6H7fpRdeXvD8iDbLPr8R4dyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747064513; x=
	1747150913; bh=A/ri/6ZjxW7RCFovjRl8X2bDl9rq/UBNCApnh0pl15I=; b=p
	xC6oByaTqzWJwlrUULPV7S5tdE3lUUlVajj+ozI2sdYQCKWMgpFqxhnNp6sQ/y3Y
	p8bnDHQOwqQ/WqZdvo8+vkHIsA/pUzAxfOWQGRR/Q9tRWYXCfq/j+OiIDeBLGjhh
	FMWtTGLYAZ7nbIeleqlohvHNw1IbFxAGLbJ3fIDKY8rUEoV1BOx2+vDkyBtq5QAM
	O2wvUDSEmgPxFwTiea0QShiLok1j9VwG5slUFcddocxg18gYxzdxeDIiDJtd/lNa
	KyTyG0FwUBWoJY3cwKOADqIRnwYgcZvdbmg3E3j2hGR7cK1GVhqQec4Ws4V2Zwk9
	RT1cigP76djJ9Yz+g6hHg==
X-ME-Sender: <xms:wBYiaFNvahD2L0uAISA-4GNPY-XHMqVkfJCBRUPL7Uvkv83DCo0tOA>
    <xme:wBYiaH8U0H8aSWHE257TqtISn56uYU87w7rZURaBjDJPUK09AVw70q4qCmQh_L5Oj
    b1V3uXVnZJoZL6QUHI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdduieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedfufhvvghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvth
    gvrhdruggvvheqnecuggftrfgrthhtvghrnhepleefteeugeduudeuudeuhfefheegveek
    ueefffdvffektdffffelveffvddvueffnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepshhvvghnsehsvhgvnhhpvghtvghrrdguvghvpdhnsggp
    rhgtphhtthhopeduledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhmkhdokh
    gvrhhnvghlsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepsghrghhlsegs
    ghguvghvrdhplhdprhgtphhtthhopehsvggsrghsthhirghnrdhrvghitghhvghlsegtoh
    hllhgrsghorhgrrdgtohhmpdhrtghpthhtohepnhgvrghlsehgohhmphgrrdguvghvpdhr
    tghpthhtohepjhesjhgrnhhnrghurdhnvghtpdhrtghpthhtoheptghonhhorhdoughtse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrgiise
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:wBYiaEQsd1xvdtdJJ1WfCDmYgfhkFuWZm0lxil1__WEgKGWQUR0-5A>
    <xmx:wBYiaBtdFny8lKddpw7XUOJHW7bSUw9R_n012ooBLLVM6JlUq0Nj3A>
    <xmx:wBYiaNeqU2j49KazqgorE4hyn67K84YsrCQN126k-JyVdi2Ck_kauQ>
    <xmx:wBYiaN2DNwhMgAxOfYxgOmMN8aQfZCmK0CIhYyyTJgzfnV1YBPVl9A>
    <xmx:wRYiaDO07QpmSUH25G9IVJMjlkEKU2glNIRaTFN6QHOUrCApyau3cbWu>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B65281C20067; Mon, 12 May 2025 11:41:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tee5e6786d5fc82a3
Date: Mon, 12 May 2025 17:41:32 +0200
From: "Sven Peter" <sven@svenpeter.dev>
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: "Janne Grunau" <j@jannau.net>, "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
 "Neal Gompa" <neal@gompa.dev>, "Hector Martin" <marcan@marcan.st>,
 "Linus Walleij" <linus.walleij@linaro.org>,
 "Bartosz Golaszewski" <brgl@bgdev.pl>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Lee Jones" <lee@kernel.org>,
 "Marc Zyngier" <maz@kernel.org>, "Russell King" <rmk+kernel@armlinux.org.uk>,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Message-Id: <438dc401-a531-4b07-b77c-92748acadf85@app.fastmail.com>
In-Reply-To: 
 <2mhqiy6twurcidtwe7rhtobq5mivb2meoq6ik3dt45zwerkwrd@ebudw64trryq>
References: <20250511-smc-6-15-v5-0-f5980bdb18bd@svenpeter.dev>
 <20250511-smc-6-15-v5-7-f5980bdb18bd@svenpeter.dev>
 <2mhqiy6twurcidtwe7rhtobq5mivb2meoq6ik3dt45zwerkwrd@ebudw64trryq>
Subject: Re: [PATCH v5 07/10] power: reset: macsmc-reboot: Add driver for rebooting via
 Apple SMC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Sebastian,

thanks for the review!

On Mon, May 12, 2025, at 00:16, Sebastian Reichel wrote:
> Hi,
>
> On Sun, May 11, 2025 at 08:18:42AM +0000, Sven Peter via B4 Relay wrote:
>> From: Hector Martin <marcan@marcan.st>
>> 
>> This driver implements the reboot/shutdown support exposed by the SMC
>> on Apple Silicon machines, such as Apple M1 Macs.
>> 
>> Signed-off-by: Hector Martin <marcan@marcan.st>
>> Signed-off-by: Sven Peter <sven@svenpeter.dev>
>> ---
>>  MAINTAINERS                         |   1 +
>>  drivers/power/reset/Kconfig         |  11 ++
>>  drivers/power/reset/Makefile        |   1 +
>>  drivers/power/reset/macsmc-reboot.c | 363 ++++++++++++++++++++++++++++++++++++
>>  4 files changed, 376 insertions(+)
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index fa3a5f9ee40446bcc725c9eac2a36651e6bc7553..84f7a730eb2260b7c1e0487d18c8eb3de82f5206 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2303,6 +2303,7 @@ F:	drivers/mfd/macsmc.c
>>  F:	drivers/nvme/host/apple.c
>>  F:	drivers/nvmem/apple-efuses.c
>>  F:	drivers/pinctrl/pinctrl-apple-gpio.c
>> +F:	drivers/power/reset/macsmc-reboot.c
>>  F:	drivers/pwm/pwm-apple.c
>>  F:	drivers/soc/apple/*
>>  F:	drivers/spi/spi-apple.c
>> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
>> index 60bf0ca64cf395cd18238fc626611c74d29844ee..6e8dfff64fdc001d09b6c00630cd8b7e2fafdd8e 100644
>> --- a/drivers/power/reset/Kconfig
>> +++ b/drivers/power/reset/Kconfig
>> @@ -128,6 +128,17 @@ config POWER_RESET_LINKSTATION
>>  
>>  	  Say Y here if you have a Buffalo LinkStation LS421D/E.
>>  
>> +config POWER_RESET_MACSMC
>> +	tristate "Apple SMC reset/power-off driver"
>> +	depends on ARCH_APPLE || COMPILE_TEST
>> +	depends on MFD_MACSMC
>> +	depends on OF
>
> This can also be 'OF || COMPILE_TEST'. But I would expect this
> driver to just have 'depends on MFD_MACSMC' and then manage the
> checks for ARCH_APPLE and OF in the MFD Kconfig.

Makes sense, it'll just depend on MFD_MACSMC then and I'll move the ARCH_APPLE,
OF, etc. depends to the MFD Kconfig.

>
[...]
>> +#include <linux/delay.h>
>> +#include <linux/mfd/core.h>
>> +#include <linux/mfd/macsmc.h>
>> +#include <linux/module.h>
>> +#include <linux/nvmem-consumer.h>
>> +#include <linux/of.h>
>
> Once of_get_child_by_name() is no lnger used the correct include for
> the remaining 'struct of_device_id' is <linux/mod_devicetable.h>
> instead of <linux/of.h>.

Fixed.

>
[...]
>> +
>> +	pdev->dev.of_node = of_get_child_by_name(pdev->dev.parent->of_node, "reboot");
>
> Why is this needed? The of_node should already be set correctly when
> probed via the of_match_table.

Leftovers from a previous version that didn't use of_match_table.
I'll remove it.

>
[...]
>> +
>> +	if (device_create_file(&pdev->dev, &dev_attr_ac_power_mode))
>> +		dev_warn(&pdev->dev, "could not create sysfs file\n");
>
> custom sysfs files must be documented in Documentation/ABI.

This sysfs file allows to configure if the system reboots automatically after
power loss. But now that I'm looking at this again I'm not sure this driver
is even the proper place for this (the nvmem cell is kinda unrelated to SMC)
or if we need this at all in the kernel since the nvmem cell is already
exposed to sysfs just with a less convenient interface at 
/sys/bus/nvmem/devices/spmi_nvmem0/cells/pm-setting@d001,0.

I'm going to drop it for now and revisit this later.


>
>> +
[...]
>> +MODULE_LICENSE("Dual MIT/GPL");
>> +MODULE_DESCRIPTION("Apple SMC reboot/poweroff driver");
>> +MODULE_AUTHOR("Hector Martin <marcan@marcan.st>");
>> +MODULE_ALIAS("platform:macsmc-reboot");
>
> Why is the MODULE_ALIAS needed?

No idea, my best guess is it was copy/pasted without a good reason.
I'll drop it.


Thanks,


Sven

