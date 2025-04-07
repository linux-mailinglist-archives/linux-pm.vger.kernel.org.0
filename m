Return-Path: <linux-pm+bounces-24870-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B56BA7D8FF
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 11:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D94961658B9
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 09:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2236A22E40F;
	Mon,  7 Apr 2025 09:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="X1LdVyns"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B496C22AE7F;
	Mon,  7 Apr 2025 09:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744016797; cv=none; b=L/dYbOA15KlDFS6YJDv0f1q9dA8tEcyFU+jEfNJLLfU7Yn90s41PaVMxBbXn2lnxijYCdpIPVblNEfY2SilIYSmMTZcDa8w7R6OZKQN31/hGaWKkO0o7O/L+IgvMLBQ/45JNfe6UowKn/4EMLUg0TQwd9Echysm3caFlAfi32ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744016797; c=relaxed/simple;
	bh=Xe9yKMk7Eypr5knTG3yOuK/cqx3Z7cmsTjnuVuhrHUY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=nLLWMn3dGHnr2udHiKlv7U1Prn9wEMa+JGxDVbrayLbQftB3W2FdM974os5iJxyY1fX0sbBBhmAcOYA1CL0Qjx3TH2j4e9IBsjSw65pgt27t4XaO/nicoVkmhW43FGjjsuHUAyWavrsqZg4Kp+OBntE4zaTQHoJqlojJ0AZFneU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=X1LdVyns; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1744016771; x=1744621571; i=markus.elfring@web.de;
	bh=Xe9yKMk7Eypr5knTG3yOuK/cqx3Z7cmsTjnuVuhrHUY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=X1LdVynsvT7LMZUL48PGjcF5QfwADAOJBci+gK0YQC+mYO+Oth4dixt7C/us06Fg
	 izM1kujfXxr00vRFMmoCjSSjSzQNQPpi3Q5Uf7TzQyO9RbeJqq2kOQtXbrCpNwhi1
	 OByikFCOXyimwXnMfGeOE4MsOyDuAAuJPbZSOPtc2z9kDBeeybCIdfu8iJXJLxT3K
	 JYVgAl/IVVe2rQTLaKPt2A/g4guNKVcoVXhyDdhHTVMC5A9nO6F0Kz2/1Df6skXDs
	 hyytHJmajV+hbatfDGBEW83/d4J5h9ON1il13hOgwfJHA1xs/qsXpLTKoUVAwNMUR
	 jyCeTIdRPihqgurNDA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.4]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MCol0-1tsx0M3nIO-000KwN; Mon, 07
 Apr 2025 11:06:10 +0200
Message-ID: <e8e785a8-5f8f-4ea2-a150-2837f47b4472@web.de>
Date: Mon, 7 Apr 2025 11:06:08 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Henry Martin <bsdhenrymartin@gmail.com>, linux-pm@vger.kernel.org,
 arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Cristian Marussi <cristian.marussi@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Sudeep Holla
 <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>
References: <20250405092314.76297-1-bsdhenrymartin@gmail.com>
Subject: Re: [PATCH] cpufreq: scpi: Fix null-ptr-deref in
 scpi_cpufreq_get_rate()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250405092314.76297-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Hy+PR5k1xY84cSBOrA+CeAth7lHjF5yH3qIF6tQorjq8ujw9unB
 Ks4IChpY96tqaRD6pGhUjBBs7AD/6yfZH4xvKnUQos26x9FfQu93Gd0XdE89tMqvo0YPdcR
 VDNRT6zLixpOmCXyHpEuRlwGTQ+kxaz2YwER1KLPLm8MUEqfggXWCP9yivXFoymxsgDOsRm
 GXoMf51AyhgIEgfCsmzAg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Vr4ssYFlXBA=;CwpOnPasjk7LIzSK0EdCunmDOsF
 CmFnhsW9Fwns8jYe0WBp01axpuwv73QwaF2JzHNiIxidoEmo4nEXlfrsN+mLINpCu60C3wwNb
 +42cmsxOkKM4rIScVM7n7VH3grZZI8CWCNyxaCrGa9PqwKZsiP9QpjQn0u3XsrDt436yY4q/B
 J0dQd4DJoHQ1ODnOBTP2jMipcHhP1QaVABQCEetLZjfQjBBlScsr/XrhyIosWpSt8K0mOg9cr
 I/U/+/ELHTlRgiREvA2bvT08A32NrAdDOU1U4JjjJUwp1gDm1z0bPsSsbpe7Nnpeb0rKbSuj9
 cylTuhl1bnNPklWyJY44CtfgXIyqjMYki2exg/a7KwBSGUvz3a1XBhPBID6T9gSm8zWwG+Dk0
 j3AyDrCZIUpuJDx2NIXj3BJyJQ1W5q8R+Cu6lyu4PjHjh4sPYeFokygpwWS4kasn9SH8n3gNb
 stG2PM6JhJLklptT1OZ56+tWoO7b1bRiuvHLu+pYvr00/naqUUVJCzoD/mER626JVLFvaNHvv
 gGuZJD0+jpmtliv4AVA/0ESFeI2kmAPeMlJ/Su+MLLM6qKyBIHTW2VrwvhPT8R08UClh3GlWU
 gHA/K6gxErMGyuStkatD91valEW2Bh3tSB/cVkmHfTWP29QGNMYhmP0/ToLzHrU17FfCOJ/n2
 VS+iKsa00P9NRFq5vZ1FPDdkRzLcm3rrowIFJFHiF2LJj2WQ6j94c5LByIhLHPgWYPSnKsETZ
 L0BtPF8JYyZrKY4/hKuDUErdpiKoaneLohoZfUyVgFwvIY08JXtzCzObAWmHZA3k+f+CANXGh
 s4lSGes3w9L2iqUHi40kr+cBK456TWWX//zVT/IoPh7NpGBrVro7viyCzRLNI55i4cSfif4wb
 VyL7y+ngIGlzmIYHinuddbT9Tg3hFjeWBdu81RnnPxrKgzBEhkGRap6p2uznca2l4NHAo+Bka
 4e4KpyUMPhLgs3jDPL0SPgoxrdg85bt04niJw4s2lyr0rJ6geh/qkBiAX9/Zwa71Cs17gvw/B
 VlPZSHQTZ5N4+aiWyGxUBk0aaYWoIzvPbdhWzM9tOgEiu1YVXSM4olXRhECHTUazM3WEBvxFP
 uCF4prVBaHsxDFePgW4N7wIPewTI5/prYKgwd8MV1YasTs6e44Y4N4fXczGx2yp77FgwE4QPJ
 mEzJR0elzo4fFqxinahkKUuZ02TCgup3nHySV+ZGeROXW8CPkENQoBUabmpAId+1ytrLxU0e1
 IJ7mHKesEhboV2IaeCGmjGpWmw92A46GzRkFntHldoZfff5GGuHQWGijMRvko5suAfndd7v2E
 2o1Xveuh6AwSXqeDVOPBLJnkiLsj3fZTFscGuthYUJ3BgZeeCbWiuGn8Ch3I138ZoJtZ4vfBg
 KDyjZ2y8rrF0iUEqgu+YPtg69zUa8WyK6jeqyVmeSMa+MfWSiRlmQuT0Agm0SCwlYkcgONBAZ
 N8UudDLTplOwSFjDVO73Z9lnf+U8BkfscSghwVOmOS/DVRK6D

> cpufreq_cpu_get_raw() can return NULL when the target CPU is not present
> in the policy->cpus mask. scpi_cpufreq_get_rate() does not check for
> this case, which results in a NULL pointer dereference.

See also once more:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.15-rc1#n94


Can any other summary phrase variant become more desirable accordingly?

Regards,
Markus

