Return-Path: <linux-pm+bounces-31683-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D5DB16FAC
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 12:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D69431775F9
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 10:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A459B1FC7CB;
	Thu, 31 Jul 2025 10:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="fnY/v+z1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F182E3708;
	Thu, 31 Jul 2025 10:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753958123; cv=none; b=lMwzaVeuEOcfBj8nuojaX8e7Ui5MX0QD9UGqQoJ3xlVprsaw91NAaDFCdiWvGYykcFnbb7t0mVR9tBfxFK7F+ygHBOtnAXX0nH85Hxs//Hi+duuHFxfAjknVWPdWUk0qsx3LfdpiRJpdpS/qJj8gHlsgrCQmcC5Ks2sNj8brZqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753958123; c=relaxed/simple;
	bh=siEJAGcddg3Vw44IonKKBXt3qF9tZaootFY83uvtDUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sp56HL/AUzHzjP/xtgD8GqXC43+Zp5O3GQspFpHV/YJDePW1m1QUQW60O/00eYFoVaqU8yhrFqqTstpTirkQhNj6uNesK7YsaGMnkGZjMnQiuBIkWqwBx4VQiSUxM0oja/C3qQLbrXQd2Nl69En2moYI9mbQcFoUnTKEHIiXmpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=fnY/v+z1; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753958075; x=1754562875; i=markus.elfring@web.de;
	bh=gyvOdwDL2tyYqoO4GbpCnai4TKVaK/0Jug2C/vaqAbY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fnY/v+z1u+C3c3+OLhUYH4yfFj1utjI1IbETsGAFL+xArhcpMvMI78Xqdx3ArWKe
	 +ebswT38iTUulCDEWkxqEZxUkGGAPqm2sPOvjGJWtqDaVfQhCDc35pfMVInLjPqBk
	 PJF5e2W8gtJG6TWqpqoErNJYZxVpWlIY/w5LQLvh4pPP01UDk+e+0nnme6zofj8L0
	 J9fHI+hGTDTJWg/lbDVH6d6hM8LQSoN/n/kfVI1kGyY110aEN/glzgY0ivdkEbPfF
	 FXzLnyZrqyTAFs5IO5gLZotcSS1xsRyOqSP6DmHXHv1/3xpUmuE8cXBsit8KCUCXq
	 +at7Uym5mLiczemaew==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.235]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MUlDJ-1v7WCw1RCL-00PGu7; Thu, 31
 Jul 2025 12:34:35 +0200
Message-ID: <3773fcd3-6a76-499f-ae32-bb3cb8a62d8c@web.de>
Date: Thu, 31 Jul 2025 12:34:32 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [2/2] cpufreq: CPPC: Fix error handling in
 cppc_scale_freq_workfn()
To: Jie Zhan <zhanjie9@hisilicon.com>, linux-pm@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linuxarm@huawei.com,
 Beata Michalska <beata.michalska@arm.com>, Bowen Yu <yubowen8@huawei.com>,
 Huisong Li <lihuisong@huawei.com>, Ionela Voinescu
 <ionela.voinescu@arm.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Lifeng Zheng <zhenglifeng1@huawei.com>, Prashant Malani <pmalani@google.com>
References: <20250730032312.167062-3-yubowen8@huawei.com>
 <4955be6b-9806-4f73-8618-1d8de7d3a9dc@web.de>
 <baef79be-5969-fa4b-3802-ac49d071b11b@hisilicon.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <baef79be-5969-fa4b-3802-ac49d071b11b@hisilicon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:4MygdXUtEo1lbQZarvUBmceBEvQFcep1CRAgePtCtQIVP2M6md6
 5SKd4F5DQIpn446EubqxEHNjKBr6PTpLmSlKqThca+lFcuL+mUY5v30CFu452mWYQyyNcJq
 bsZ0J/V8pn8A498ooeCTztQsmEjPlrsF78ADDUQ1cx+XKauyvhV1BWwaqifv36Ptswcbmrn
 E276ONgHKpYl5PSzp8WPA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XZbtPYTpmEc=;Q9gn9G4/0m8jk9dxfiDikg6AeUa
 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

> We don't think it's necessarily a bugfix that should be backported to
> old/stable kernels.  This is mainly an extra error handling for cases that
> may happen on our platform when a CPU is in a deep idle state.

I find mentioned tags relevant also according to proposed completion
of error handling.

Regards,
Markus

