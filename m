Return-Path: <linux-pm+bounces-32361-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CCCB259BD
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 05:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB0B9682B4E
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 03:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C10E17A2EC;
	Thu, 14 Aug 2025 03:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="QRWt+HcY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41723234;
	Thu, 14 Aug 2025 03:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755141262; cv=none; b=qEpsrxtQ6rR6kyqZcGZZWBr2IbN+L8zJDHeOneymDBc5jU29YaKCkKy95HmnFQ/UExPqKx3qojJzocfXuOrzZx0TDa+UFXYU0EXW0vKcxnaecQSNFK2Ru5x86k5AR+qqVJjiDbwdgOrLOkOWdR7evB1qfuqLDsjfqwbNnbTxGxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755141262; c=relaxed/simple;
	bh=S+mDtH3a7GZVI6PI7WfqUUtB/fen0VDRqapFmW5O4LA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YIwAZjD+UY0mxWJTsliFREXoauXPeXpHZ14id8fnOdbwGemfwJllN5+ABJLcUPlNqRWPzM4iNVgY2wAqt+tugSzYH6DexcIw3FQy3ZANGgRtmhGsL+aEqDQcJk+eF919PLKstX83+5PdfSwf/8ikLmWgQIoJB++4G5H8cqzf4cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=QRWt+HcY; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4c2VhS5zZWz9sRc;
	Thu, 14 Aug 2025 05:14:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1755141256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pkqq7e1ThN32hUKBUrJr8poP7PhUWYYFk5fFFdUqYjg=;
	b=QRWt+HcYBIqHEkzHNygG1zmigwKE5063xKHJjIFoxWRKv+UJ/m+HpkHYoLoWnIuRaTUgPS
	1cclCYAwEskdOFMw+sMzVYfLEtLHGzMIgSTAfzV59PE6tUyT/37QZ2Xe4gmKxyJxEToao5
	XVqnBAi7AgUupdkixVqqBzj8SDttN9qYWgLtgwDem9fYIzBYrDrijFwF0y+ynLd/czv5R5
	BOsEelkb4GYBXictp1RLl5JpxJklmUhEZVAvBDxB7CQexIEmPd245b05U+9PIeASqJnT2H
	VbECsykcH4H4noOx7VyILLLbhReL68sLt//gIRCYZ2t7GDsQ+0acyRVfNMDgow==
Message-ID: <519cd75a-50f2-4c9e-8a53-82ffb9cc0a8d@mailbox.org>
Date: Thu, 14 Aug 2025 05:14:13 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] thermal: rcar_gen3: Add support for per-SoC
 default trim values
To: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Cc: =?UTF-8?Q?Niklas_S=C3=B6derlund?=
 <niklas.soderlund+renesas@ragnatech.se>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Lukasz Luba <lukasz.luba@arm.com>, Magnus Damm <magnus.damm@gmail.com>,
 Zhang Rui <rui.zhang@intel.com>, linux-renesas-soc@vger.kernel.org
References: <20250625181739.28391-1-marek.vasut+renesas@mailbox.org>
 <86f5260f-6625-4e2d-88a8-013143922fb9@linaro.org>
 <a65ae3e9-8970-46b4-a80f-3654daa7a0c2@mailbox.org>
 <5ffb67b8-cded-412b-881c-14179c2ba3b8@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <5ffb67b8-cded-412b-881c-14179c2ba3b8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: roumbnqnzywoyppt6zsahrcn53u8ghxe
X-MBO-RS-ID: c7ca27327942fdd45a6

On 8/14/25 12:00 AM, Daniel Lezcano wrote:
> On 13/08/2025 22:37, Marek Vasut wrote:
>> On 8/1/25 11:59 AM, Daniel Lezcano wrote:
>>> On 25/06/2025 20:16, Marek Vasut wrote:
>>>> The Working Sample R-Car SoCs may not yet have thermal sensor trimming
>>>> values programmed into fuses, those fuses are blank instead. For such
>>>> SoCs, the driver includes fallback trimming values. Those values are
>>>> currently applied to all SoCs which use this driver.
>>>>
>>>> Introduce support for per-SoC fallback trimming values in preparation
>>>> for SoCs which do not use these current trimming values. No functional
>>>> change is intended here.
>>>>
>>>> Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>>> ---
>>>> Cc: "Niklas Söderlund" <niklas.soderlund@ragnatech.se>
>>>
>>> Applied, thanks
>> Is this series supposed to be in linux-next by now ?
>>
>> I don't see it either on git.kernel.org thermal group tree or your 
>> tree, where was the series applied to ?
> 
> 
> Sorry I did push the branch.
> 
> It is in the thermal bleeding-edge branch now and will go to linux-next 
> in a couple of days
Nice, thank you !

