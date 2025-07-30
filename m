Return-Path: <linux-pm+bounces-31638-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EBEB16669
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 20:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F6031AA6E19
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 18:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162A02DE700;
	Wed, 30 Jul 2025 18:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="czyzcLBk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909A44AEE0;
	Wed, 30 Jul 2025 18:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753900723; cv=none; b=hwHtKnMfRuWKqvVajxSAdaUkC8kAqQBHUaWzZ2eov/sLlwYN+6kuYYLY/4GeyhyWYpnpmj0/KG9tN0586wWNHBUGxqsVA00iFJTgnrB4UG4R0jukXtB/FYFMzOPErQYOqCx5iyw3q3v8BCFlUSEqQjVjmVWPfrhgkER0seS3rLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753900723; c=relaxed/simple;
	bh=iuETnzHMth2evVeqAbBnInRi5z+R2+bC5QE9h7TMDA4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=X3CsRDo/+oZLfKK/6xN8+RyZx9pdQU+s0vZ8zMD5M9D7NWuPqsmRbe3mgj1dTjhzUmuBXNwTHJiaKBxKM0Mty6IzpeyW9ozaoMX03AqRtpv6rj8l7g8/NiCMV5IGlqoyzcGdIGqiHpzd5BLJk0gdUSd5ohfnL7zc8b+8W+SJeuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=czyzcLBk; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753900694; x=1754505494; i=markus.elfring@web.de;
	bh=iuETnzHMth2evVeqAbBnInRi5z+R2+bC5QE9h7TMDA4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=czyzcLBkLurq4pRjblNuHIWQuS44pMkR1ChYxYkEuz3WDRd3hSsJ22GX2IRW7DT6
	 rL4S51ckwcHp9yfgct1epLtXpjIxoB4pqdFIBgF1deeQCamS9fhUcErzutaxlEg9k
	 Sa8MsKDpwSml1RKKjHXmtLvjY26Vgp7vl0XouFKAwSw7Se/WrtK3WdQnvTcwlkibA
	 WhR3bY5HSp5SF3Z/xedrKQ96GpNG7SGA6yq04BuqxFJeDxlJE8yibK+dmI3zgDxFU
	 XetcdEbC8cxy0L8gFVbD8DVnORN0VRdzQYx2l3iT5CdMSEDc6baU3dnQFt0ynfxzC
	 S8VokEwbt4sPZL5Qkg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.238]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MqZMQ-1uLJCv3SM4-00dbr3; Wed, 30
 Jul 2025 20:38:13 +0200
Message-ID: <4955be6b-9806-4f73-8618-1d8de7d3a9dc@web.de>
Date: Wed, 30 Jul 2025 20:38:10 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jie Zhan <zhanjie9@hisilicon.com>, linux-pm@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linuxarm@huawei.com,
 Beata Michalska <beata.michalska@arm.com>, Bowen Yu <yubowen8@huawei.com>,
 Huisong Li <lihuisong@huawei.com>, Ionela Voinescu
 <ionela.voinescu@arm.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Lifeng Zheng <zhenglifeng1@huawei.com>, Prashant Malani <pmalani@google.com>
References: <20250730032312.167062-3-yubowen8@huawei.com>
Subject: Re: [PATCH 2/2] cpufreq: CPPC: Fix error handling in
 cppc_scale_freq_workfn()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250730032312.167062-3-yubowen8@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YXn6k4GSIvbcBR3tbsaZuHTkAdnz/k15f/TSwOODTx/Zb8Z3kTZ
 6d2VQ6b26KXxfoyz0GnknNazI4j3DjggbZfAssE5nXhw4KN7kQjufNgSufq7HxJnQ2xBAZq
 mb48B4yIAAdFxm5v8C4bmkAJqlc51IL5ARUcp7r0Ds7fU89VSycPYue/Ya5NXaWgG7u9M9v
 iAuoshTwKLcZlFi/amlgA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+tnJZuA0pes=;EcIrYoTvgAto3xZguQklfMIrSPh
 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

> Perf counters could be 0 if the cpu is in a low-power idle state. Just t=
ry
> it again next time and update the frequency scale when the cpu is active
> and perf counters successfully return.
>=20
> Also, remove the FIE source on an actual failure.

How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.16#n145

Regards,
Markus

