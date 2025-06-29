Return-Path: <linux-pm+bounces-29795-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA405AECC26
	for <lists+linux-pm@lfdr.de>; Sun, 29 Jun 2025 12:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC31818922DA
	for <lists+linux-pm@lfdr.de>; Sun, 29 Jun 2025 10:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E623204096;
	Sun, 29 Jun 2025 10:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=jvpeetz@web.de header.b="tjo2GJal"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C79F1E521A;
	Sun, 29 Jun 2025 10:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751192917; cv=none; b=GMl9rrnnmNqOv3dtQQ6FlU4g2QJgssaZui349f4vYXa32GSmrEENd++DRYwYgiWi5SCssjcRpM2/6Er6ScidJd6CmjfZtVgmqfxpX+mKyitYQHYHygEVEb+SkMvMcSCcA07xsyrCkqlGhkZ+0Gxj/ddWSQfbtyrcTKp3ola7f+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751192917; c=relaxed/simple;
	bh=+5ikiu7XgWggN7GSucyZAOUndbzRvEOoaAP0VWIPI3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a3C+LBEqXJsxA8V3yYo7Z5cUT+2/zm4wxzJheV3sBju5FuGkHWj/W9Z9TigAFOAYty9ssM+FN4HdFoLqNfrUmDWZucKltrcbABi8SQej4+8WRTPY+7muboTm1AgifA5F12ndk0qt3fqNOn7kJ7JKXdkcc981Bhhm8JOaMjO0czA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=jvpeetz@web.de header.b=tjo2GJal; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751192903; x=1751797703; i=jvpeetz@web.de;
	bh=VOoNj+Cs4ODOAPIDCFLiLS4Oyrwj/PqYkV8MDlP7a5Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tjo2GJal00qnZ1cUvNp3M+MvvPEn5Qsz8jj7TE15V4xUGrAHVWx3+n2u+AS0jZtI
	 3QssBOJir86cFnVApVRlgYrc9qZyYF4vwcRWy4QD8dnWTs1Rptdt67sOKJ31NiOyf
	 oM63C9Y4SKuKTnx7NDJdiZNfGwpsUPrwkZMspiruVU0Uh/rul5E8EJ7JLNUvUrQUu
	 2bzwZLoDVhRmR26snQUgvD2T9Zpo+EUjjm7ItIbytBeCEJgrZtTenUV3pIldCdlME
	 bozrrcelfxL7wbz0qm5Z/RN1++mJNHMmDCPK20wCCBA6viryHvkGh9rXuQ2Ss7cAb
	 D3VZ1hoBYEZ7YDckbA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from uruz.dynato.kyma ([84.132.145.192]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M59n6-1uWveA3zk4-00FMUG; Sun, 29
 Jun 2025 12:22:51 +0200
Received: from [127.0.0.1]
	by uruz.dynato.kyma with esmtp (Exim 4.98.2)
	(envelope-from <jvpeetz@web.de>)
	id 1uVpBQ-000000007uM-0rch;
	Sun, 29 Jun 2025 12:22:48 +0200
Message-ID: <a17ab649-82ab-4fe9-a9f3-eca67e7d5953@web.de>
Date: Sun, 29 Jun 2025 12:22:47 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.15.4
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, jslaby@suse.cz, rafael@kernel.org, viresh.kumar@linaro.org,
 linux-pm@vger.kernel.org
Newsgroups: gmane.linux.kernel.stable,gmane.linux.kernel
References: <2025062732-negate-landless-3de0@gregkh>
Content-Language: en-US
From: =?UTF-8?Q?J=C3=B6rg-Volker_Peetz?= <jvpeetz@web.de>
In-Reply-To: <2025062732-negate-landless-3de0@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3U9BiSdo2aIEM1L0lH0O8Pj0LKu+eD8G0tjf6GbKvoFHpnJjFim
 jlU+BF+OsvOBYdKW+eCXDbyDLkQ1PBxj41PKz1YKc6oNJDjMeUrUkk917Ww5B3LvgIW7DEU
 hvwzNhAVqiHGKCqrnxsNzZP7Z4Kw77Gw+mkpcwmlhkYvMip8GWh5Xk6gN13e99J2Qnuz0BN
 4gMiwlEI9JVbDpm7ydrxQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ofCO3+W68z4=;q4VZ/JVniXYMCGCbQW8s1m8R0kb
 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
 XNb6kaF3gH65Uc+08IVsRzavrLMdA==

Hi,

upgrading from linux kernel 6.14.9 to 6.15.2 and still with 6.15.4 I notic=
ed=20
that on my system  with cpufreq scaling driver amd-pstate the frequencies=
=20
scaling_min_freq and scaling_max_freq increased, the min from 400 to 422.3=
34=20
MHz, the max from 4,673 to 4,673.823 MHz. The CPU is an AMD Ryzen 7 5700G.

Has anybody else noticed?

Is it intended?

Regards,
J=C3=B6rg


