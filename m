Return-Path: <linux-pm+bounces-13821-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF089700FC
	for <lists+linux-pm@lfdr.de>; Sat,  7 Sep 2024 10:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 541AE1C21B33
	for <lists+linux-pm@lfdr.de>; Sat,  7 Sep 2024 08:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7D9154C15;
	Sat,  7 Sep 2024 08:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="odk/rU7l"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CE238F83;
	Sat,  7 Sep 2024 08:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725698704; cv=none; b=B7snL8dMwwUQDYaNRJvblZem3/GE9WbLmG0sHZHDuNP4EamjSg91vi+oe3OAaTmnxC07LSR8QV7PNwc7G2BWNWbPYOZFpbX3yqIyGud3QkI1v4z/CMlycrPJfzR1U0rWZ4ZJNUSstZft0Zves2ItK5cmbb4/QX/N4My5DB2suXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725698704; c=relaxed/simple;
	bh=1T8ODkuWTdAoYSFX/rWPkZU7Xo9zq7V8SxV+btIcMho=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=SSkkIW85XXshCPt8lJOW8EGexhe3XU/E5N/4aEdmESPnLzKxpvf5nuj5lqbPGz9eN7MvF8mK/NT/NhYvYGVR4WkTDkhJlDfn6iqE3sy4SLwoGzwxB0s0/7YOFu5FkXy0LPEefkroAkjQEn4h3TiyfwVlNM/KCT0T6C9IBPNyi0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=odk/rU7l; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1725698658; x=1726303458; i=markus.elfring@web.de;
	bh=1T8ODkuWTdAoYSFX/rWPkZU7Xo9zq7V8SxV+btIcMho=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=odk/rU7lLA+X60vwLvTTHeTsuZEggW39GuTPuX38WgjG4HbOoOQOwB5MUpKAYz+F
	 KTc55WO+KfSIj2fWOmfsP2D2YrOOq6CmScYPcPnTEqNxfjnkag1UnSJUQMYDlsOV9
	 lQ6EWm7O+YQJ/svC//w7Z7vFa6Dyns3k/pm8vV76RU9RbNF55/SH/DmLDf6aMZ5R3
	 HAWw6CIsKdHRJrkOzbk10KefJZjGyY6j63EKXYid439BTMzqdnoBp1aCFTUUg87x1
	 i9k2QdZ0VWEHrdZQFeDeFjSGEiUTee0tFOaEJ6/S0pKP+pfF0wo4LUFelL3HwHJJr
	 YvihpoXTrJtq1LV0oA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MOm0r-1sORcT2zhH-00OkMZ; Sat, 07
 Sep 2024 10:44:18 +0200
Message-ID: <de5c9c27-56fa-4163-98e1-9a98400d2408@web.de>
Date: Sat, 7 Sep 2024 10:44:15 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Junhao Xie <bigfoot@classfun.cn>, devicetree@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Chukun Pan <amadeus@jmu.edu.cn>, Conor Dooley <conor+dt@kernel.org>,
 =?UTF-8?B?R8O8bnRlciBSw7Zjaw==?= <linux@roeck-us.net>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Jean Delvare <jdelvare@suse.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>
References: <20240906093630.2428329-2-bigfoot@classfun.cn>
Subject: Re: [PATCH 1/9] mfd: Add driver for Photonicat power management MCU
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240906093630.2428329-2-bigfoot@classfun.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AQhlxKYF+SVNHVdzbmkBXd5OhmUNfn40KEC4+sPg7R3VHJVCB6W
 kgsjtqr/3XCqYY0kbjdmfw4Gc/kKrY7O3ztbKrhpBdOJN57VkTcttlaBLx/P+jmYJkCyuL0
 hRC19UEg+8R1+cLinVv0nA99FmzeD4GnVAWaaCk1emQAgqOyWZuWFXyBcxPaLma8EaCteF0
 bt6BV+h9zAtjotQ1FDCdg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TnJKtUlBzu0=;V418xZ90PwgrfitnQWSk9KXPwgJ
 aO4UdqBu/LQQEY+Cz4tKzqvs1DTJFq40uX+Fzhi0gf7IQ4sMZuU1IAJhFfFx5C3I4TTt3GQ0n
 5kH1/9TGlYMK8dh3OTbdsPuwU+kAeVFHiTnXVDxONpd8VtGeNI98ly3v2rEaf5h7/aYOuRsXj
 IxTOPba2V7pGk75gqEbirMxCWrhuRrg6e6JR5l8tEuSZ90fkI5HPGdXBl7c+2euU21hnfEoMd
 TF4wnjEDcW0SFS9QuxFfntlY/3wmUhNQwM6J3RD0cY0n5bIvSTYAZ+SIayAOC/H0yWXnS0/q7
 +KSJpMn4Vqnls7uDaLStwgQPguUr0GWQSnRV69XEjevJSW66aJBLAPT0Ut6vwpOkHdbbhZs6p
 1i3UgPcGpXWdH3WvG/Thd53+JA03qNSKkK6Wh6EmkngZZeY/IIfCjOHY0CBreUtgBWL1K4loU
 MbZ7vO0AQQMCJlv7JqV0imAZ2FrtCgnvhcuUv7InGr7+LGN4DqaCli30yjSutSIC4nt6pyeGo
 TLwtx4wFJrja+4Hq/pG8Z8TZGRkKVLBlTLyX/exVXl33Vv99zhHfD92634Q5cuAXpQfxFKUT3
 8Yc/XKg0/FmeYrvZe3IWNsDavTxbS70d8zR9kl6XaxU+68ryzQJG6ZpmROPiGpv/R9X0/XkDO
 kqr42U9mHBfzuZbO4Q+10EA34DTNGxw3suP0Wh69x9H3tWVXa+OA8wJG16AJCgkPdC4uI7cek
 lbWoytI84HimqyjkrNnTvkgCnL0tMRfBp2QUxHFenieieQjNhHXzmTx3/UHtKc3zeKfY9OkZf
 Cb/WXIh7j8ak2djyeBZrO0Qw==

=E2=80=A6
> +++ b/include/linux/mfd/photonicat-pmu.h
> @@ -0,0 +1,86 @@
=E2=80=A6
> +#ifndef _PHOTONICAT_PMU_H
> +#define _PHOTONICAT_PMU_H
=E2=80=A6

I suggest to omit leading underscores from such identifiers.
https://wiki.sei.cmu.edu/confluence/display/c/DCL37-C.+Do+not+declare+or+d=
efine+a+reserved+identifier

Regards,
Markus

