Return-Path: <linux-pm+bounces-28058-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2558ACCDF5
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 22:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 428A11895AC8
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 20:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7FD1AA1D8;
	Tue,  3 Jun 2025 20:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bjuGfDzU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE94128395
	for <linux-pm@vger.kernel.org>; Tue,  3 Jun 2025 20:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748981243; cv=none; b=B8VKKoM8n5j6wjVk4/eM/83b/NPDVNnq3LeQWxeJetWrjsVqW0PpWnNnRBmC1dS50RFgp+/UklCQNM3SwqA/7a1Y0cPcZY7f5ihKFekCLB+HV2HwoijsCHwmiNFexjp4sbPdQQeXvqSh8jeaBhCfjnz1KlTjKPNVzXigV0aLqj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748981243; c=relaxed/simple;
	bh=G0iFOUyDV/GAuSohmFJCstbby3ILFFSM5UcwftzcUcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=kAuVqO9HW0f7vfJ4OOC3OA8cbLGpLnsTvYt+xQCZ0PM539V0waO2sWAVuRmjVxQ7sNFo//kdTOwdm0QP6d+/HaaAP7TSwdjsU87aU4PPlWv0OIG6zx3XftUhW2qakfGGX2adCpgxgBgVAX6y9T3EFQNoP4Cvz6U49njDjQbkkAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bjuGfDzU; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250603200720euoutp02d9d5fbbb897b8846f9e2bf4eade6a3e4~FoSv3kUsB0409104091euoutp02B
	for <linux-pm@vger.kernel.org>; Tue,  3 Jun 2025 20:07:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250603200720euoutp02d9d5fbbb897b8846f9e2bf4eade6a3e4~FoSv3kUsB0409104091euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748981240;
	bh=I9G0dsh/HfxzQk/gcXna/50vSZKPGGK2LiIfw6uO1nQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=bjuGfDzUTy9cQ6Kctw7U5Gy8ojzufrQV+RTuK64u0KEuaHzOte1gio3BTTwqhy67c
	 25f587mHCzCk+ItozavpLgjWs2vw2y8ghqsR+ctUI+UZA3OoB0cFZh0oLduJOAiZoo
	 8/Qyi4rGJptYEHgAoBaZcmrTpwv6r7i01HEhLaVg=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250603200719eucas1p2a1693746bd398be6f5fd7a661b40a5c8~FoSvDD3kN0233102331eucas1p29;
	Tue,  3 Jun 2025 20:07:19 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250603200718eusmtip2fffef2b43712841199296d3e62877bda~FoSuBeEet2231322313eusmtip2g;
	Tue,  3 Jun 2025 20:07:18 +0000 (GMT)
Message-ID: <471578ae-5605-4051-af46-bae83bf4f44f@samsung.com>
Date: Tue, 3 Jun 2025 22:07:18 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] dt-bindings: power: Add T-HEAD TH1520 GPU power
 sequencer
To: Bartosz Golaszewski <brgl@bgdev.pl>, Krzysztof Kozlowski
	<krzk@kernel.org>
Cc: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, Fu Wei
	<wefu@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, Frank Binns <frank.binns@imgtec.com>, Matt Coster
	<matt.coster@imgtec.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>, Ulf Hansson <ulf.hansson@linaro.org>, Marek
	Szyprowski <m.szyprowski@samsung.com>, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <CAMRc=Mc-jjULmc=3fS0qZgXbq9Sgfg8JBoH7peWML1PdyyyH+A@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250603200719eucas1p2a1693746bd398be6f5fd7a661b40a5c8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250529222403eucas1p1923fe09240be34e3bbadf16822574d75
X-EPHeader: CA
X-CMS-RootMailID: 20250529222403eucas1p1923fe09240be34e3bbadf16822574d75
References: <CGME20250529222403eucas1p1923fe09240be34e3bbadf16822574d75@eucas1p1.samsung.com>
	<20250530-apr_14_for_sending-v3-0-83d5744d997c@samsung.com>
	<20250530-apr_14_for_sending-v3-1-83d5744d997c@samsung.com>
	<CAMRc=Me9cWfe2mL=Q6JQbAFjpd55MOBZuAWC793Us0criiQr4Q@mail.gmail.com>
	<4519844e-b1c0-40a7-b856-a6e4a80c6334@samsung.com>
	<20250603-cuddly-certain-mussel-4fbe96@kuoka>
	<CAMRc=MfXashaEscE1vF_P6cs9iOCBerfNFiB4yC+TX76fZ87nA@mail.gmail.com>
	<CAMRc=Mc-jjULmc=3fS0qZgXbq9Sgfg8JBoH7peWML1PdyyyH+A@mail.gmail.com>



On 6/3/25 16:49, Bartosz Golaszewski wrote:
> On Tue, Jun 3, 2025 at 3:35 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>>>
>>>> The compatible string could be updated like so:
>>>> "thead,th1520-aon-pwrseq"
>>>
>>> Should not be separate node, you already have one for AON.
>>>
>>
>> Agreed. And as far as implementation goes, you can have the same
>> driver be a PM domain AND pwrseq provider. It just has to bind to the
>> device node that represents an actual component, not a made-up
>> "convenience" node.
>>
> 
> I'm seeing that there's already a main driver under
> drivers/pmdomain/thead/th1520-pm-domains.c and a "logical sub-driver"
> under drivers/firmware/thead,th1520-aon.c which exposes
> th1520_aon_init() called by the former. Maybe just follow that
> pattern, add a module under drivers/power/sequencing/ called
> pwrseq-th1520-pwrseq.c and call its init function from the pm-domains
> module?

Right, sorry I haven't noticed this and responded to previous message.
Thanks for the direction !

> 
> Bart
> 

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

