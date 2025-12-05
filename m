Return-Path: <linux-pm+bounces-39253-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F03A9CA90BD
	for <lists+linux-pm@lfdr.de>; Fri, 05 Dec 2025 20:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E2163028FB3
	for <lists+linux-pm@lfdr.de>; Fri,  5 Dec 2025 19:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B700362A88;
	Fri,  5 Dec 2025 19:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="huymwV+4"
X-Original-To: linux-pm@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06AF361DDF;
	Fri,  5 Dec 2025 19:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764961868; cv=none; b=gtMqP2aYkh8VqcYgej9HWaz2P+5zXRIh0YakWqQwOuDb9QJyvzNA9ACzB61ncfwf984ji3/38H5ikmVVs8uhsbseBCeWEdmkzjiJ56jvbd0mKFj5umJ/kvxuv/Mngw+cXW3pgixwx5pgR2xQmVZAzh/alKNH5Aiogh1SL6Z/0Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764961868; c=relaxed/simple;
	bh=FO8T7T0HEA6hQYAF6mbvsg6qNElGXGcpj71e9atwVYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PF5AFcitF7RRBOfRIzkD2ZXO5UrpesGkmVptBqQKptq3L6S58KbFbxHuIRBD92NUR3Xz4bSHnOT2XmvL+Fa/q5lQjayolPu9X+v9JBOFtTK3UbliyvlzyDS6qMicNDLEnOj8SMHTGBukOvTEiy80mPK3FRS7mHNfx/6mYmFGblE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=huymwV+4; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4dNLZG1CfMz1XMFZZ;
	Fri,  5 Dec 2025 19:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1764961860; x=1767553861; bh=FO8T7T0HEA6hQYAF6mbvsg6q
	NElGXGcpj71e9atwVYo=; b=huymwV+4qcQuM87ifual2chkmny3UdcX2nUXCKjT
	74+vNGUH0YGsTxMhVAolrBgkmuOBpQ3wk5BcTcuAAcTFK+jz0XrRicOZNSoyMeN4
	pkgLeeXswZuMFPp8h1jJPK/NtEhB/rtrXniZa6kFIqbibjXxV9h3Khe2sjCZHd0a
	TC3ZHx5c5V17BE7ZclsCdxGiqvuC8qQ0etjuBfS1tfKWPa7YyCa9ca7zlzWngLNd
	0X8n/4v2Ue8UiPDS6OuH7IUxdBEQLb1sYdrH0Mmc8TNHh2iSyQ0CzPpZ5u53FAYK
	b9USL+zVOTvigTxbZIC/u/jcGhCgPhqYluIb78FTelYz8Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ds6b7kWJl2dK; Fri,  5 Dec 2025 19:11:00 +0000 (UTC)
Received: from [100.68.58.56] (syn-076-081-111-211.biz.spectrum.com [76.81.111.211])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4dNLZ71lk1z1XLwXH;
	Fri,  5 Dec 2025 19:10:54 +0000 (UTC)
Message-ID: <fcecd822-a2ec-43e6-8dc4-290516e2187d@acm.org>
Date: Fri, 5 Dec 2025 09:10:51 -1000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PM: sleep: Do not flag runtime PM workqueue as
 freezable
To: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc: YangYang <yang.yang@vivo.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ulf Hansson <ulf.hansson@linaro.org>
References: <20251126101636.205505-1-yang.yang@vivo.com>
 <82bcdf73-54c5-4220-86c0-540a5cb59bb7@vivo.com>
 <CAJZ5v0hm=jfSyBXF0qMYnpATJf56JTxQ-+4JBy3YMjS0cMUMHg@mail.gmail.com>
 <12794222.O9o76ZdvQC@rafael.j.wysocki>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <12794222.O9o76ZdvQC@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/5/25 5:24 AM, Rafael J. Wysocki wrote:
> For example, it has been reported that blk_queue_enter() may deadlock
> during a system suspend transition because of the pm_request_resume()
> usage in it [1].

System resume is also affected. If pm_request_resume() is called before
the device it applies to is resumed by the system resume code then the
pm_request_resume() call also hangs.

Otherwise this patch looks good to me.

Thanks,

Bart.

