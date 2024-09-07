Return-Path: <linux-pm+bounces-13819-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F8D9700C2
	for <lists+linux-pm@lfdr.de>; Sat,  7 Sep 2024 10:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 407E81F22B38
	for <lists+linux-pm@lfdr.de>; Sat,  7 Sep 2024 08:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FE81494A0;
	Sat,  7 Sep 2024 08:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="hVLvXf3W"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11E71B85E5;
	Sat,  7 Sep 2024 08:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725697030; cv=none; b=WPZZ5x1Ej8mCdnKEFsBkJHlMmiU8wyEiMquPoj0Go5EoTpK7mnbKPeompjwCZNPXBbip/t55u9nm+iiTjacRnOW5/UH1qUAPgTnmM51T/A3tmzfh2h5hDlQPGal5usvnVvQ0NxY9nY6/ilyshjLkkJ4e4qmO9mQZM/gRfAqgyEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725697030; c=relaxed/simple;
	bh=gvsW8BNIX7ljcrGWrKD6clzUjbfdkYMLn3v7uub/6MQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=izZkvzfm2bgO0AbUy73MfOVt9p6RZi9HBZYN78JKdjOyuK8fz91iUyIv+9S/xcoqqWkDrPXq8p1XyiQHzfmdway1rhJV8u8veIGrQTgg2uIB2AUgQ5WpfZl0cHztRz8LG9vMFVx5NJ8lkVTq3/5GXTUFuLRD3yUNS8SU2X3kNEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=hVLvXf3W; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1725697009; x=1726301809; i=markus.elfring@web.de;
	bh=1Mu96APm/7R/w7K+9IvvOwhZsTEP32teqBSIVibe/dU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hVLvXf3WFsdgdiJPtcuSILojs7qpt2WHEdbgdm5cVtsG4xon+vSeZLZnhXniazQk
	 vv5pm3O2k+FcAMYOhlufRRjNTcEVfqDvc+cPrz+Un0QQXuGuNyIVSLFSATWxc8U6r
	 Cxc5HHgJgp77LpT5gUf4W83AwXdVW1u78GCWRcHGg5r1Sho9t9zHTGPPzg7kIotiC
	 pCSitXocBLx0kJ0N9a+Os4tRML0+sKXCIaEmuVvNdPfg9s8qnO/UdDwRULDs5b4pb
	 +Vgw7yeFpbJMx/WHaTsv66k/GBTVRi78QU0Di3V/7apVmqlJYsiJMOGMxx7FNQf2+
	 FlgP1xpQuFeXDLMyqw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MSZHv-1scDWM0IH3-00PRSE; Sat, 07
 Sep 2024 10:10:27 +0200
Message-ID: <d79dbfae-d50b-45e5-b430-be8106bbb03c@web.de>
Date: Sat, 7 Sep 2024 10:10:07 +0200
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
X-Provags-ID: V03:K1:3sDZvZ572CstfLRiymj0OEa2v50uxQRQS5dGEo6EFlvxjxYXotF
 iqSgsOe0U9L+cf9Xd7SKvjmB4Ob5MfVx3nFns3ltwbXYO6Zvkj3hqOxCWZDHFKgRP2B5l7s
 dnGTu2+IcVzqaedRB5bfzg4zd4MslQitWJZMwCfnV+eEszme1/BaaIf8r3D0eu7hwTiiX2C
 bc+jMBkrtEYHS4L0Oa85Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hQwvtSihhyM=;ZvsDh+ewC/rGs/AQZ4pUdxKdguu
 /7Dlmmzgx7ViXxl9CTTAadFCgTm91BJX01+CMVanf86teKHwyxK7SkgfzcxZPyve5XX+BYTeF
 oXnMG4+wx5/wIzRHIWE0hJZCJiCFKQ/p/UZ6F5NvVyyXYftPNxq4vQ9IGpc/+P653j9zrguhA
 +Pj4916QdVnjdR0tkSKf++3qStUvAH5GMcJdpVID7c67Qh6Tk7M3BqB3YiFcbt0KUUzBtxPHU
 7gVf2awH+qCdGxzuGg0cIg6XShFH2FVeYk58i5ICM0V97v7X5YDFyUDt1io1TpQu26QekifgJ
 Cm5pMDya9q2US3bNQWpg1Mc/HF/pqrYN1f05qa0rL2KUgayeT/kXQR4+WOMmfM2hoT5Z2gnw+
 Uzjy02T697sGHOruySceLgBXsWCA249FnKqinrJYYjEO0vKjihdlywxrjkt8EUOZiFGIQ+qhm
 7D64lLz/WllzrR/SpFBsyMSy1CBj/jRoV/2rgywR8vRFZ/X2QegTm/QcRE9Nlv4edn2SrJNfp
 Mt69oeHmHVQFMVbU6+ZblpjNZqk+otxn/G4wm41jJp1s7vWAca7l6N4MQ3+Db5IUWkaXTspXd
 Bm8AAtRGtWKFFn8bKs9VxZHJvVOCFHetcuQDg75OeCRXwnAj3mzgfceboyahv2KgO5Vr+rlTp
 oDvaVc8HMFq55qiNRjJjsIkjOfkTMxYgff3VwssoK9A9UuFffZ7Ao5UjcMDVRM1z6iF8jPNL9
 vwQ6cSWf4lZAdcOIeup2zLFUoH7YzAMT5Wu43LBnW3tTo+Ab+U3nGmf4qh3X9n4ubmph3dh8d
 Xe13PuDCHS/ZPGfSqe264SyA==

=E2=80=A6
> +++ b/drivers/mfd/photonicat-pmu.c
> @@ -0,0 +1,501 @@
=E2=80=A6
> +int pcat_pmu_execute(struct pcat_request *request)
> +{
=E2=80=A6

Under which circumstances would you become interested to apply statements
like the following?


> +	mutex_lock(&pmu->reply_lock);
> +	if (request->frame_id =3D=3D 0)
> +		request->frame_id =3D atomic_inc_return(&pmu->frame);
> +	pmu->reply =3D request;
> +	mutex_unlock(&pmu->reply_lock);
=E2=80=A6

A) guard(mutex)(&pmu->reply_lock);
   https://elixir.bootlin.com/linux/v6.11-rc6/source/include/linux/mutex.h=
#L196



> +		spin_lock_irqsave(&pmu->bus_lock, flags);
> +		ret =3D pcat_pmu_raw_write(pmu, request->frame_id, req->cmd,
> +					 true, req->data, req->size);
> +		spin_unlock_irqrestore(&pmu->bus_lock, flags);
=E2=80=A6

B) guard(spinlock_irqsave)(&pmu->bus_lock);
   https://elixir.bootlin.com/linux/v6.11-rc6/source/include/linux/spinloc=
k.h#L572


Regards,
Markus

