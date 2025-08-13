Return-Path: <linux-pm+bounces-32357-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC356B25492
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 22:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E43795A4E0E
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 20:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8D51ADFFB;
	Wed, 13 Aug 2025 20:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="IkVqDVMi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615F5219E0;
	Wed, 13 Aug 2025 20:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755117469; cv=none; b=def8BwQrXWm2bCn0zjBVwYG5DCSFBRmynFtMfNvvUI4qolUhJlPEq1bMUNXinGrWryoh1Bh14XMPmw0N1jJium+8ZVyknuoqOznraSV8scn8Ji4yXGuolha9Hd15qm21ck/VHv15O8bqmIoIb+SzwNUVrNBTsH/4fHNE7XJb5FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755117469; c=relaxed/simple;
	bh=DD80uZigFGoWjYYQJAlIt9iBMcYmTn80hyT8Mou7Cis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ItA7444kfrzfqjCzvJk4q6Qhj7mVE4tftTIMD3qgsqNv0LZw4RVkkIisRyhyUN0abxT0jwbgNMGQOOx3Ye3+poo851Z38KwVjwHa8pLEslxE8+wy60YCDZB7AHeminSyMhgZSwYyDCA1ndEi8eQkNYRs4VN3+RXQbuQ6AOvvuZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=IkVqDVMi; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4c2Ktv4x49z9t0l;
	Wed, 13 Aug 2025 22:37:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1755117463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X5bfK1XdvApI/A/c1fHvINCL/7vPk40POQzsE1OOqjg=;
	b=IkVqDVMiQ3e3dJ6HdWCTYlUoyKpcwFtokQ10zTXihKhaiCdBOhYgF7s9Q8PQkxRVw0K0oF
	Ez+dCxp2DoULFYlAsf49OMvGvxzXNN/m5qG1x8Fllm6H+GrWgGLeoAQEizdJEWODZ4aRy3
	gcm7o/tmLvzNrEf0FA8UuuOskEO/NK6rTEIGtjzROaTirqLPcQyTrkugjawdgTSdLry0+5
	Pr4u9J0yrSVSMKOMhftj8D5bYGzqFemGL8U5rg/rVF2HRhujB0RmGta3d9cKCH+qqvCHzX
	pCnLE6FCLip5x85RlolIiGbXSfoojqJX0eoEF0Qw3o5xMvgk/janStaaW9oJjA==
Message-ID: <a65ae3e9-8970-46b4-a80f-3654daa7a0c2@mailbox.org>
Date: Wed, 13 Aug 2025 22:37:40 +0200
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
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <86f5260f-6625-4e2d-88a8-013143922fb9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: k65orsr5yd3xkertdceg9twcr9dowx3d
X-MBO-RS-ID: ea6407a4c68f7ecd21d

On 8/1/25 11:59 AM, Daniel Lezcano wrote:
> On 25/06/2025 20:16, Marek Vasut wrote:
>> The Working Sample R-Car SoCs may not yet have thermal sensor trimming
>> values programmed into fuses, those fuses are blank instead. For such
>> SoCs, the driver includes fallback trimming values. Those values are
>> currently applied to all SoCs which use this driver.
>>
>> Introduce support for per-SoC fallback trimming values in preparation
>> for SoCs which do not use these current trimming values. No functional
>> change is intended here.
>>
>> Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: "Niklas Söderlund" <niklas.soderlund@ragnatech.se>
> 
> Applied, thanks
Is this series supposed to be in linux-next by now ?

I don't see it either on git.kernel.org thermal group tree or your tree, 
where was the series applied to ?

Thank you

