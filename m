Return-Path: <linux-pm+bounces-13836-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F615970213
	for <lists+linux-pm@lfdr.de>; Sat,  7 Sep 2024 13:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 434341C21A3D
	for <lists+linux-pm@lfdr.de>; Sat,  7 Sep 2024 11:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E96A15957E;
	Sat,  7 Sep 2024 11:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="YrkLgYyJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3329413C836;
	Sat,  7 Sep 2024 11:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725709962; cv=none; b=WZVK806sNdkbiKZRPKV8JnfwF59HIc0CCHQcO/FnCthilUjHk2IAvTVUtlYFeVuhUXP4Ar1mcxOja5i3VCpi1IgYNnPKb9o9Ymf2JJhNyHH46KFdb1Ux6uMHDjWV4WN8n/XZ59fFQWZ7XekcbnIjHgqSqS7f5boEGmy8E01D8Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725709962; c=relaxed/simple;
	bh=HFuhqy0gtb4Xan4YS+EvK4BM8+e2aLE5NLMGAJBRILw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=c15OPFcAmtVt+ahkbA92rI2pprHgPqNy7NiBDR0X4fDcys5Cc+F3SkidhjsMdM72QRzjlm4LH8p+SuKxYIpkKgyE7hKhCw5d2PorUeWl5lU/UIgf0xUrig6PT8crai3z52G+pUwRi+5Hbacq/MXeQi92fnosY0iI6hL1ijWCpPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=YrkLgYyJ; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1725709952; x=1726314752; i=markus.elfring@web.de;
	bh=Y7AIzcXVfL6c8QeOgxRyvPUNXsOrybDoX3YWh2FCfT0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YrkLgYyJprAxivK/2sF5cNwGNjJ7n6MLYvgZEXuxPtVmv9x/cgiPe+5azq3VXgK/
	 e3ZOTJwfzopf6LgnDv4PKXf4tw2KPr1TRH6k1ZI0C6/3H+HbpzgA946eHS2ObUCIC
	 uTP+b8cUH4UU8+Xr4AdnVuM/E+BbRk+BtK6TzuI49C7HH+mR+tOKmQO4S6zLvs/Cz
	 fTOYyUej5/m8BD7caiiteFyxCJPbwTFA1Khysf4dF8zJOtszcIXbxyx5XWeu9CJ9v
	 l35h0njuVFkPSDAHpCQJeLSzXXRjSfMR3zaSZGTTazUwxaXqTHacUtP6aKh9Wk1ab
	 sy40WVJxosRE//8g0g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N6sBp-1ryAfP1lol-00tYsQ; Sat, 07
 Sep 2024 13:52:32 +0200
Message-ID: <c1e8c2f1-d123-4e72-a774-f15daa156afb@web.de>
Date: Sat, 7 Sep 2024 13:52:22 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Riyan Dhiman <riyandhiman14@gmail.com>, linux-pm@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240906084057.67680-1-riyandhiman14@gmail.com>
Subject: Re: [PATCH] cpufreq: mediatek-hw: Fix resource management and error
 handling in mtk_cpu_resources_init()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240906084057.67680-1-riyandhiman14@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UU+U/3+BocogIlcQAhIUeX4kyi7S2g/rb7v53Sr8w3Z5ADsQAsN
 XAzL0h17O8HFcISc6gfzS47Kf2FvHDrXcKeCnhWUCw2NbHQoWZ15VlzyT8AcB+DXaliItWc
 EAyYoAmbE5FM1DA73slecLbiSwBd7ZK+rPGU6BJ6m3fWozvQq3rRMmeAUk5frwUfm+iL1Wv
 uAtBxy72wJ4TYRd+qwlMg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:D/H1dsTR4QI=;y9MXG7aKqHUgsSLFBFCNRXq1l4I
 ClZpDBdcyKmRLStFlsJJ/mNidV/ee4timkcIJAylQFH+XeUhRx6Ze+w5r2vEwmCdZ+EicQZrJ
 Eeb2TbHCNgGis+TRKNrjLLRQP7WGFXMMixu25QRr/cG1HRYHD9APGZ33v+JT+fsLjHbDhBnTx
 3dg/6YYXhIlRxAimpv3tUjtaH1EwLjaEFt3o8CafSBNXa2HQY6/qylIdO+2SBOOof1X3bzw7G
 pTTuvf5OwHRN+VdhQQWQiNI+T22DQu40DRtDt0RsZDOv2V5y7sx3ynvta2qIDI2E9FKsTuuls
 rDafgFCqJrDSLZTmIeOz2VteFKqU5AKNSZncR3OasG1GhG4IS2brR31OVl7r5/iKkFJvuNYRQ
 yjdjtGA9EAUN+xCozsZDwAnNljXWRSXCfcbj1L7jQLESFGjM7eiDoPXnCFyRFSVEq/q7DgVyu
 7WAmVYMLdizCPM8yGSGNsBN4MoCVWjNhKJyM3lImYCHNDrAa8wkmnBYKkxbOxHSB9SBA5uNh/
 /KLZOBddWPk3F22f6jPE47xUfo8tXKMn2rRpUG/YEn3wxK/AyJxM1kn//AZY2YqP4Ba81ZHBg
 5QvCnZiiTv+ksejzvJx0h+SIVSLNsFN8Lnuer82/uGlA7Nwjcr6NpyoAp08eOSyVZ4+ckrvQf
 BtAL4gvoDAwTFrLpbubD/qIMZM00rMEv4bTlOl+OPfhNPbH1Ny6c1Nb8Se/QFItoGaQhv6BO6
 hiq3lQeY4V6CghE049bQkBhZlMmUf3PWw8HJdIloxhqJ9zI55W+GcklOvPChICX/8LU9qzN3E
 3tuOSNX0BJNhGi22K3/bGLOA==

> Memory region and IO memory were not released if mtk_cpu_create_freq_tab=
le() failed.
> Added error handling to ensure that IO memory is unmapped and the memory=
 region is
> released properly to prevent resource leaks and ensure all resources are=
 cleaned up on error.

* Would you like to improve such a change description another bit
  also according to other line length preferences?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.11-rc6#n94

* How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and=
 =E2=80=9CCc=E2=80=9D) accordingly?


Regards,
Markus

