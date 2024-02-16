Return-Path: <linux-pm+bounces-3992-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B3385838D
	for <lists+linux-pm@lfdr.de>; Fri, 16 Feb 2024 18:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA94B1F24302
	for <lists+linux-pm@lfdr.de>; Fri, 16 Feb 2024 17:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B2F13175D;
	Fri, 16 Feb 2024 17:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZhJXz31"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B6C130E3D;
	Fri, 16 Feb 2024 17:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708103316; cv=none; b=LUlIrJNQ3ouivb1oMSblk57dtriZvWb28rO93y9XZVF0Io3eCdv6w3pbvoNJXOdC4zyj6C2WyvOjjRUXRPvUMOSAKrCQysyrKBNpgk5fRi7dvN/BqhReuhLPy/iGhi5DhBJRfiQiyMgM/K1p8Ab2qe9Em0p2+tWWodcOUdKA1Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708103316; c=relaxed/simple;
	bh=SB34whE8k8//JA8TPqdLY7UO/i65EOIKqHrImLMAGnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qeuLlRQtU+ExJYE8nMjYSUkwKkorl912Smu79A1qtMg+DRB99zaQjxAKPwMUo2REp0N4K9hS3pDEclc2HDD4W8KOKLTnqQdRFgXXffJo9ov/lBxTj/PsZf3Mn20cFgftxZ+n+N+RNTa1XbhULAj6kHPrHnnClzRh0n+W7E1Sq3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZhJXz31; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA72DC433C7;
	Fri, 16 Feb 2024 17:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708103315;
	bh=SB34whE8k8//JA8TPqdLY7UO/i65EOIKqHrImLMAGnw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EZhJXz31yImkfZVXyttGpDPWE4Zyn5oXjFm2qwlOBBZ0AcNPZlMbrShVmvDPjMomj
	 ePYfV5iER+H85ZxFlB2vzex1vIvVRAGrZ9eVPXZa4WEHit/QsoGuWgK5IYH3PSWQSU
	 OfcgSX4ibnExhFSjt+boSg8+KLHq5JME4TmiMQJCsLyw2rOIGn1jmC/NsLtPEQapeD
	 xLWVM7ikFca1YtuFS4L1QLaZ30YUa9RZGulh7VjI5rwtt7Dup+hgz8rz3Buj86bywW
	 Z35ovlhnpQWSCDwuXuxUjQt3BSiI62UviZGD87i2uKN/vzuunFAjjFffaBnR2agMNH
	 zH55qI9aR2KqQ==
Message-ID: <87dab0be-df4a-453d-86cc-61ce8e2b706f@kernel.org>
Date: Fri, 16 Feb 2024 19:08:29 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: interconnect: qcom,rpmh: Fix bouncing
 @codeaurora address
Content-Language: en-US
To: Jeffrey Hugo <quic_jhugo@quicinc.com>, Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, konrad.dybcio@linaro.org,
 linux-pm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
 andersson@kernel.org, quic_okukatla@quicinc.com, devicetree@vger.kernel.org,
 conor+dt@kernel.org, linux-arm-msm@vger.kernel.org
References: <20240202181748.4124411-1-quic_jhugo@quicinc.com>
 <170715826040.3958103.13885911803274019580.robh@kernel.org>
 <aca58fb4-b9c8-1730-cff4-56a2d73bd235@quicinc.com>
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <aca58fb4-b9c8-1730-cff4-56a2d73bd235@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16.02.24 18:19, Jeffrey Hugo wrote:
> On 2/5/2024 11:37 AM, Rob Herring wrote:
>>
>> On Fri, 02 Feb 2024 11:17:48 -0700, Jeffrey Hugo wrote:
>>> The servers for the @codeaurora domain have long been retired and any
>>> messages sent there will bounce.  Fix Odelu's address in the binding to
>>> match the .mailmap entry so that folks see the correct address when
>>> looking at the documentation.
>>>
>>> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
>>> ---
>>>   Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>
>> Acked-by: Rob Herring <robh@kernel.org>
>>
> 
> Will you take this into your tree?

Hi Jeff,

I'll apply it.

Thanks,
Georgi

