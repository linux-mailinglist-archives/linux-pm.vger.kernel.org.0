Return-Path: <linux-pm+bounces-3776-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3479F850F26
	for <lists+linux-pm@lfdr.de>; Mon, 12 Feb 2024 09:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8E8028207E
	for <lists+linux-pm@lfdr.de>; Mon, 12 Feb 2024 08:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0205F9E5;
	Mon, 12 Feb 2024 08:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="1178iJRL"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664CBF9D1;
	Mon, 12 Feb 2024 08:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707728039; cv=none; b=Ivj6wQ3v7n0CV/XMMdD9Lc0TeKEtvLFbwcJTs4JcVA1bgd7vn04cbjI2YKIkIBrv669rUPEFxuhcF+XLdbKdLEpe6E1OkWhKLOx+XFaoG6f3xJV6DSgEKE1Fm7TaUjrgBx57eUrYMoVMQ3g/zyD5S4Wd+kmTkdfd52sfxf8CbXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707728039; c=relaxed/simple;
	bh=7piWbCGcMV8jXNFfjDe8eSN9IgwzXBxHsFlz7ti4esk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FKTWfH0NRtb4SUUtz17P3gObCVuJ/lVMik/bOLqNu/ofu7z5lhyYb8XbpadEQ1n521Zqxs5iFkp3CcibdhH1Sw4O6KQdJsu+41qKzlXBY67+3mft4E8PVEdkwaPkvIR3RPsl/8k4cKCKs2X5uEmjk7OQaOpEu4ubxXzdOvr8N1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=1178iJRL; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707728036;
	bh=7piWbCGcMV8jXNFfjDe8eSN9IgwzXBxHsFlz7ti4esk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=1178iJRLXbbYR8AYKbv5sFIihYAc/ahj51fIrhXgT3ft6izjDupE9LvnKlJxm4Bfp
	 0VbEIFSQRHHqNZalSc7Vb5i+ezl17azKyJGxU3umGhSgPCi2ELmcmjxUUy+nW91CJ1
	 H346mHIjZrGLmQRur2D3DuotorEFq31G43LCRFlwQ5mCjlted4dJrqMv8yfNDRu9/Z
	 7036VddkvHloZF6ysL8jnJklrsPLJUbl8k2gmzpj6nXd8BQHDVVrLX2Q6FsJRdwxsi
	 7yjn/kmQdhpbIDymTnafGQ25UGYQsoJPoZ1r8oyaP67oHkiAm7HTVGLQBmPr1NevEG
	 IawYeZ/SLVXJA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 66A5D378203F;
	Mon, 12 Feb 2024 08:53:55 +0000 (UTC)
Message-ID: <cd1350d0-6333-4519-a811-8413080ac92d@collabora.com>
Date: Mon, 12 Feb 2024 09:53:54 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] dt-bindings: thermal: mediatek,thermal: document
 AUXADC 32k clock
Content-Language: en-US
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, Daniel Golle <daniel@makrotopia.org>,
 Sam Shih <sam.shih@mediatek.com>
References: <20240209055203.17144-1-zajec5@gmail.com>
 <17d143aa-576e-4d67-a0ea-b79f3518b81c@collabora.com>
 <ddec28a5-8d65-4e52-bb3c-9587acf7bca1@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <ddec28a5-8d65-4e52-bb3c-9587acf7bca1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 12/02/24 07:11, Rafał Miłecki ha scritto:
> On 9.02.2024 10:13, AngeloGioacchino Del Regno wrote:
>> Il 09/02/24 06:52, Rafał Miłecki ha scritto:
>>> From: Rafał Miłecki <rafal@milecki.pl>
>>>
>>> SoCs MT7981 and MT7986 include a newer thermal block (V3) that requires
>>> enabling one more clock called AUXADC 32k. Require it in binding.
>>>
>>> Cc: Daniel Golle <daniel@makrotopia.org>
>>> Cc: Sam Shih <sam.shih@mediatek.com>
>>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>>
>> So, I've made some research on this matter.. and this is a NACK.
> 
> Well, I can only thank you for the research.
> 
> Let's drop this patch. I'll sort out the rest later.

Thank you for bringing that up - this was necessary to clarify this and
to actually make both of us aware of the mistake in the device trees that
we have for those SoCs.

Take your time, btw, you're doing a great job.

Cheers,
Angelo

