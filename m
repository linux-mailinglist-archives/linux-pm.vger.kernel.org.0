Return-Path: <linux-pm+bounces-36209-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 11008BE098F
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 22:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F3E134E2221
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 20:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607CD30C61B;
	Wed, 15 Oct 2025 20:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="FXy/Exts";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tvAA9Z+G"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B768305044;
	Wed, 15 Oct 2025 20:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760559189; cv=none; b=roYWGWfyA1OzRqr43ZBfpR/87mwk8A+SB8mDkiXXnxRfkw+l7TmhfCsPG7B3JrdjV/KUtpikRz2G9l246/kKRsrvIaOL/3NfuFzPzLp9FWJjYZ57Hzzjm8LRGXZkxug/sxGJdenOFL9gt3lapBTnJYR6SDA8WbHSYADORRPFhY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760559189; c=relaxed/simple;
	bh=8SKLt6xilXa4kagNtkejZieX7wSZCHIz6QC7oBHqhr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=khXT/D0YENwqXQoWEYEZSTKl8YJcAntjonXcdzdSoOhyxtUK4DQuPP40XJQi1jRMp9P5MQIzGb1ksCUpJfkbM/ZyXXpnr4MYXTiscFJMFHc6FKvw0o/71rhtHljAgjFL8En3ZFo3KUayHgAzEZXc3wDhEecL9KinP0YC3ags/Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=FXy/Exts; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=tvAA9Z+G; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cn2ML4Zpxz9tM1;
	Wed, 15 Oct 2025 22:13:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1760559182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=On7KI6QGKFzJ37IXkt8daBR+7FSXWV0v1bLXrhH1v6g=;
	b=FXy/ExtsnnVVQRy00YJCWzBPuQPAeZdgerugJO8yVLXDh/uPCb6amfBHA8Epz4l8kHS++p
	T1WeC2+OAcj2wMtg1tx9QjXgcA/7AhgmV+RROCaTSjf6ydwiuhM0uclBSqF28OfhipWtIf
	8KnUaXhnENL6hJrRpOH1eki//6hvbM8upkTWX12grq22hAoCmCDUoMpg1++R2936wT850u
	3PeXqEt0ybi9ThPW3544zXrApR3j88vZUYvWvp+a5w6rbsdgtrnHF/N67cJk1RZC4gMl3n
	QcRf61dIpOqIadlae7TqKongiND+BVOZW5goDVF9UYqfQj4NL2KTfU+E8PIGKw==
Message-ID: <62670d89-56f2-419e-8f80-0536858415f3@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1760559180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=On7KI6QGKFzJ37IXkt8daBR+7FSXWV0v1bLXrhH1v6g=;
	b=tvAA9Z+GSL3jyYYr6Sb5/QYXyRW5mn1hB7rCwhO+zJltxTVCaCGvWBvav56SB50LHTgwtx
	/sKFmOOaphU6iy66WRALnCS4HPDQXmOLGSDIK/B5vu05DrH51G1lFTkczlz2uKsMRdrYoN
	E3IkAHirbRvy/Z3aTchSUSRAokIbLqGtJtV+IvNa/HLlQc9W9VDNnEP8nk9/imoLWT6QQ5
	AaHxSXEtadlEMwNCWPMezWArXmPTRPq7Wz3AUEZP7s1UbzavRrRPaE7UyohmkgufijtejL
	R3ZNkh351d/5F7NHi8GvdvUY3bLdwUmt+39iPv7+Mx/92/MmIP/ZHRF7zqJfag==
Date: Wed, 15 Oct 2025 20:12:37 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] thermal/drivers/rcar_gen3: Document R-Car Gen4 and
 RZ/G2 support in driver comment
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pm@vger.kernel.org, =?UTF-8?Q?Niklas_S=C3=B6derlund?=
 <niklas.soderlund@ragnatech.se>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Lukasz Luba <lukasz.luba@arm.com>, Magnus Damm <magnus.damm@gmail.com>,
 Zhang Rui <rui.zhang@intel.com>, linux-renesas-soc@vger.kernel.org
References: <20251015155905.186612-1-marek.vasut+renesas@mailbox.org>
 <aO_eLEFLAnjc8n4G@shikoro>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <aO_eLEFLAnjc8n4G@shikoro>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ifwukssuqgahtgyngunxgbjcznfsmf3a
X-MBO-RS-ID: 5177b494faae2c86738

On 10/15/25 7:47 PM, Wolfram Sang wrote:
> 
>> - *  R-Car Gen3 THS thermal sensor driver
>> + *  R-Car Gen3/Gen4 and RZ/G2 THS thermal sensor driver
> 
> I am not opposed to the patch. Just want to mention that such
> information gets stale all the time, so I would suggest:
> 
> + R-Car Gen3 THS and compatible thermal sensor driver
This won't cover RZ/G2 which something else, and Gen5 seems like it will 
be also a bit different, so maybe the list is now exhaustive?

