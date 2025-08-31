Return-Path: <linux-pm+bounces-33490-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 378DFB3D489
	for <lists+linux-pm@lfdr.de>; Sun, 31 Aug 2025 19:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6B403BA397
	for <lists+linux-pm@lfdr.de>; Sun, 31 Aug 2025 17:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4484B22578A;
	Sun, 31 Aug 2025 17:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="UhDUVgld"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4309718CBE1;
	Sun, 31 Aug 2025 17:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756659758; cv=none; b=fz8CWvFJWFUts34dlt0ErkHYiRBHUNRIyK8R+khX1be3C7qZs947+EH0XMdIJJ+zv5WWtiMYF9TZ0TXioESlF3/RnxcTD8LLtf1On5mAMe9IV8qtlkiSiyOoGwXIl1drKo8avygdEv57sub4LYyY77oBG8dg9YpP+Tsm86YtbGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756659758; c=relaxed/simple;
	bh=j0s1g6T7szqqQz0NOlM0LCZb2VyBs0Y+/37TtuQDT/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gJDShpY726qCVDUQ6RPKb/UdED7uJtdds4TMV2jhUAQzWk82476Q/fMHhb2S5Kx8VF0SJKK9kftosnb4ufxLX9d6JaC3wisWV+xgRL/XD5eNeuBslT/M8vJw9XfsjDe1qkpeuhKdkDOf6Ra+gHPy2WcVoWGhRtD3egGAm3sbYyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=UhDUVgld; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cFJGJ6Krsz9t94;
	Sun, 31 Aug 2025 19:02:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1756659752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VTLyQG7j7A1vMGLhICF0+BbT4IMg8qrNmb1b72NPnKY=;
	b=UhDUVgldEQRRFzRj+odC3RC1KEyoMfF6UmLKFT1POqmYF9VrkB4cU4Selh/rPlwjCjaZSV
	fjPEt2+DAKnmLeN9LxwHv5GwWqmJxgetw45aWAL3qwS4t3vtXeG1kav6s/dRx9IDMRI0N2
	FYGNne14lslrgLaFLbud1yx1M/x+Qs0HZ/+lNuZM5rso54nSzw/FtFzBstpYoYeopi+PfE
	iygGq56wJ3/41LNAz8DdDtfo+o6ne9fUMZyfA0lSMI1HexGLyMlick1vh6UevxWox6b2t+
	x10UX4unHewgzICd3wpwuw/js+rPUEQ/gcaLha6+DjCtg5H5JI/Mmq80JvF/SA==
Message-ID: <f30a88d0-a7f2-45be-a523-bd27597d229f@mailbox.org>
Date: Sun, 31 Aug 2025 19:02:28 +0200
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
X-MBO-RS-META: 9we9mf94nkuow6616oir7qzisecfowzo
X-MBO-RS-ID: 1959d133be77ff48cb6

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
This still didn't show up in next/master , did something go wrong ?

