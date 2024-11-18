Return-Path: <linux-pm+bounces-17706-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 956829D0F30
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 12:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCD4AB23CA8
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 10:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AA819415E;
	Mon, 18 Nov 2024 10:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="BVJ4Uo7g"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B732E19413B;
	Mon, 18 Nov 2024 10:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731926561; cv=none; b=EQqtvs9nr7Zl4JrlvfdOsG7kC9ZvoMCrFeV4hV1+JapmZuXB5E88abm2HZ85WokNawJ7PRCGQu9XqtXRzd3Njj5KnLNEnDgD4BCQYayVlzHe6iTypg3s7i8p0j8ojuk8KUxh9ZLZH+gLGA1ooCV4mmMSa/pQpjCOh0MXK86urZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731926561; c=relaxed/simple;
	bh=JXGM0NDWxvV1caPi72xGRyEC++jZLgh6VLRoOPHj+WY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=dLyOHWUFEcusWoniZBnHLT27I/tnWlGKGA4Cs1cynSMt3KUrI+v5V0udxlwa5fAKBvn9weWve5vBBCKsLGmz8iY2Iscdn9zQw0ewHggSLhjyS8zjDNygJ401pv+aJYThoSwp0De8lzlR3VqxL/K3ar4cvCW8+OOmTJCSqt1E5X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=BVJ4Uo7g; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1731926544; x=1732531344; i=markus.elfring@web.de;
	bh=JXGM0NDWxvV1caPi72xGRyEC++jZLgh6VLRoOPHj+WY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BVJ4Uo7gRs4LMs4Xst9BY6kKRp7uEaxK9ibPNkPCcFuh7O/ikH3+sO7oXiqh6wqm
	 2ROc7Y2lLZB7e3keD5K+Ofk3l3c2Dqi93cGe/Ns7riWfVOwhZKCmD8z/9Uf/Fmh0R
	 /+FDQU+mPt4CJCjamCnTSVZZK+afL4ZfygCJxDkjZZFyBfzE7g1JBfCGajjNI3HQ3
	 tHMzWqXLASfRhAac8qrGgB/B+Oy5eluqWJvDeeeHK67MogEZCqr4bZg5Iw2U3oOTX
	 v7pokmYKSHq5UHgrxhHWHfDf7ku1Iz52ELtxzmEiMezNacj8bzqdUVrTlIFI6AsOs
	 YwkegHzjeK5D6K1ScQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N5Ug4-1to30U2Iyw-00vjTX; Mon, 18
 Nov 2024 11:42:24 +0100
Message-ID: <3918d367-e29b-405c-a58a-7c4e813c3cff@web.de>
Date: Mon, 18 Nov 2024 11:42:22 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Charles Han <hanchunchao@inspur.com>, linux-pm@vger.kernel.org,
 Georgi Djakov <djakov@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20241118095939.49612-1-hanchunchao@inspur.com>
Subject: Re: [PATCH] interconnect: Add NULL check in icc_clk_register()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241118095939.49612-1-hanchunchao@inspur.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:CabRBC8g9w4i7TOVG53y/tgObyyRqNofLrFLlV2/kr1yixK/2t8
 R9v4NC9f/Rqq1EZ+y6DoOWV+bKr0wOKKiwfap5h85Mq9xWTKba0tRyl2I0oN1nqLx9pNTfp
 JVIhj7o5sSmNxjDA53H3hsFp+M40fFRbNH9l6vbT2Akj0YxH7G5lVrY/0C2Xern95GD3ir0
 T81+baZ39FxMxi1Bvi9nw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1RtUZUpBaVk=;cwCDfI2PfCspmO5dtBzGNXe8Q+r
 cRPSdtaxrIqLL4NIRGLVXD3wswKh2PDnf052yUvdGc7Pl7GMlofTI+j2yx3VkJTar0Wnei8MX
 V4S4U5o+Y83SbwbASDbsBO8MQ/4jS6nB4n6aTnUnAWN4rMKt1Ly/F32/WYGGgH9J+FeIj+Dhg
 9GaiJIfG+ZJ+UBTGG9ZJnBfQqp4ohp0d9JpaBoQwfZp7V6BrTPmFhqVNA9+KZw071Ks89btEF
 k+snqR5QHRIMjMTqTiAYlGiTS/U80HXo2eQZuRo541NF2mbkuuEYU6gYHXPI82/AbGV01j/Rz
 Zr9OupiMPquUaIMLqfpo3p025F6kypZ6FnimhfDMeGmZN4yKGmKK/p4y0Cu3Xyiw0A28+26Ys
 HKn2RqoWrmJ3MQlF6A/0cBTs/872kzArza1aKI9wGHabd/A+HNdXLd0fDK5a3v5PUgGI/j0Lo
 fqIJBQENyVUskAQLcC/FTM4DMSIfJ/wsg/t3jnjLW0PbBz+PhDm+zQP+N4NImHUDYScfShToY
 FmHFabSQKyjMsaGY3xRARSSfoxnK1rCAQYe17cPv/9tQdsg8ad6lHeiCj0XUvfHWLUvtYWx/d
 a9PDDe+B2QOaXRqHkciV9E5YmfG79/Pt4kQa+TEtSawsgBrsch7V8f0PSu3ezZMBE8nSy0BoF
 t2p1LU6JxJn7JdgHRRqJKA8GuW+nIOuONJqlzQY7B3HFPzmROsNGNAe14/LqFMcVWY6zRYJj9
 m7WuJkWxDyLle+e76hckY/ztQT9xRQYjcI3ML9jd1/fytEgFv7jIa6Sr5KFwPLG4NolfazWrG
 ZAeqsvq3DodJCVZ294mCTL3k7gD6kwAKkUf0yGwBSxNKA262xIEYiNh6dBr1zCMGjA/7LwiVS
 nG9LJB6UIgE1V6Lz5e6HsrTaAgX/tPG5zBBHdi2pcK65YB4CUqb1VlRuw

> devm_kasprintf() can return a NULL pointer on failure,but this
> returned value in icc_clk_register() is not checked.
> Add NULL check in icc_clk_register(), to handle kernel NULL
> pointer dereference error.

Another wording suggestion:
devm_kasprintf() calls can return a null pointer on failure.
But such a return value was not checked in this function implementation.
Thus add corresponding checks so that null pointer dereferences
will be avoided.


Regards,
Markus

