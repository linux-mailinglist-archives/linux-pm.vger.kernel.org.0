Return-Path: <linux-pm+bounces-36236-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E501BE2A81
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 12:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0283F50381E
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 10:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF9E2DF703;
	Thu, 16 Oct 2025 09:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="aipIkr55";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="rBDQanJ3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7658D2DFF3F;
	Thu, 16 Oct 2025 09:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608742; cv=none; b=eG0yoUahcp/U4gN67+CKvmhklrbt/6hMBPfizdbu6r8UXId2zOEMWUzwqIUVfiQaTX0KiuLVJYcAYgb2+PzyQ3045jPpFmM1wzjIP+0mnTkFxzW47EewC7vSXXB2esiFstH19w0fEaeQi6qqFoxiZ4zSz8eb8ZTAlw892GJVOgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608742; c=relaxed/simple;
	bh=0myl7+eecFYC3uJ49S5/p1O8sOxw27NoGrlpR4pgihw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HzD/nd9UYfDtGI5VfPGb19MU13w6pwCZLn8iTPVgzV3EwY9tRhOvSKjPXwhnmsB/Uvi8wJEX/u/idIfrLFpCJMPYhZiecI3+UvjVilkhi2mgNtnwfNabPk0K40Opd7m4uxBSlB8tyKoDr7wSujqAC+sHDfZQlGnHR5Sfi58CGio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=aipIkr55; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=rBDQanJ3; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cnNhL3bSzz9tkC;
	Thu, 16 Oct 2025 11:58:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1760608738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=++h923KP06/abXCubB4DCzwM+QM2ZyYkkutYj5Xm0mM=;
	b=aipIkr557wDgKdcxlJtiwabVjYX5XYR3qmP6pV0VMl8kTSm+3dTH2XSIYuJBofZCLxQv0P
	NvNbjlWys5jojHvSP3wBU6D6nAEvxgnKUd2oNRGdN+F7MyUaZSfscUvyDG33afhyN3KIsy
	USV2bWCSvtGXUiZMVUVmqm24QwYyuTv0BhOPr+Dw7sRd7WKwU7yJTTpzP30qGIPVCHfr7f
	EGrwTHsJ5IYAbLNDVmH7QqSsjncFAKAZ0wOrdFCt1RZcAuQymMIkWuWweg3R47ctf49u7J
	gY64nUL8Fjl803VBwButUSwWNZ8WrjrIVshis+QArZyUCrKM8OigcuS+rwjt/w==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=rBDQanJ3;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <23421cce-4873-4439-b68b-0f3bd8b72692@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1760608736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=++h923KP06/abXCubB4DCzwM+QM2ZyYkkutYj5Xm0mM=;
	b=rBDQanJ3GKnpN5CiWhNp3rB5JVCP30t+kiOEVQ++vRUg6lZ5XJrdFIcr658K95C1OCIm8y
	FUMeEEkupEPhZvajCrNK4K2OMQdYTexoqP8e1r9mqt3Iwe3VTaIkkmufSzIotmMQntNlwF
	t9wMESMAkAYQtQe7ubo1FWYpaFrjdXBjLquxOz3CDM/2BIk73Hs+ODka7oRQ1eAZ3KO6j+
	DOTO3xH3zKaG9REum0uogmKsJrsEJVr2th/WIyloM16qsLUBKg98iyPfNw3HNeWO5uI3d6
	Zc4Mgp7ryfWvJT6KWOrizeMXNDyYNUXDTjBBrtv1qHnaGK7d5mxrW3SgT2MGEQ==
Date: Thu, 16 Oct 2025 11:58:50 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] thermal/drivers/rcar_gen3: Document R-Car Gen4 and
 RZ/G2 support in driver comment
To: wsa+renesas <wsa+renesas@sang-engineering.com>,
 Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "niklas.soderlund" <niklas.soderlund@ragnatech.se>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Lukasz Luba <lukasz.luba@arm.com>, "magnus.damm" <magnus.damm@gmail.com>,
 Zhang Rui <rui.zhang@intel.com>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
References: <20251015155905.186612-1-marek.vasut+renesas@mailbox.org>
 <aO_eLEFLAnjc8n4G@shikoro> <62670d89-56f2-419e-8f80-0536858415f3@mailbox.org>
 <aPCmZp8sM5oV2jPa@shikoro>
 <TY3PR01MB113468C08443256EC6D99209386E9A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <aPCqtn3OwY1NRCD5@shikoro>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <aPCqtn3OwY1NRCD5@shikoro>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: x6bhsh5uok8xrdufhdzrk55cp8oukry9
X-MBO-RS-ID: ab838ff85d1ed314f83
X-Rspamd-Queue-Id: 4cnNhL3bSzz9tkC

On 10/16/25 10:20 AM, wsa+renesas wrote:
> 
>>>>> I am not opposed to the patch. Just want to mention that such
>>>>> information gets stale all the time, so I would suggest:
>>>>>
>>>>> + R-Car Gen3 THS and compatible thermal sensor driver
>>>> This won't cover RZ/G2 which something else, and Gen5 seems like it
>>>> will be also a bit different, so maybe the list is now exhaustive?
>>>
>>> Sorry, I don't understand: If RZ/xx THS is compatible with R-Car Gen3 THS, why is this not covered?
>>
>> RZ/G2{H,M,N,E} thermal sensors should be compatible with R-Car Gen3{H,M3W,M3N,E}
>> But RZ/{G2L,G2LC,G2UL,V2L} uses different compatible.
> 
> I do understand this.
> 
> But if I say "this driver supports R-Car Gen3 THS and all THS instances
> compatible with it", this includes all RZ which are, well, compatible
> with it. And not those which are, well, not compatible with it?
> 
> Where is the misunderstanding? I am feeling a little awkward here...
I think the only misunderstanding is, that if I spell the list of 
supported devices fully, it is easier for the reader. Gen3 and 
compatible pushes the onus of looking up whether their SoC has THS 
compatible with Gen3 onto the reader. It seems no other entries will be 
added in the foreseeable future, so the list is currently likely 
exhaustive for a while.

