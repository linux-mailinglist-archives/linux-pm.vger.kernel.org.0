Return-Path: <linux-pm+bounces-25441-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10958A896F5
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 10:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1F663ACEC0
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 08:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD881DA31F;
	Tue, 15 Apr 2025 08:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFr04ROQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD1C1BEF87;
	Tue, 15 Apr 2025 08:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744706549; cv=none; b=D4R70sV1jQblqI38ckfYpkzSdv8nRTbiPEG62ksK5Ecw0xNnKgY9lSuywpKhAS1gpEJXdvxX5zWIYiJ/tMPFpT6eMn1dbTjsas4or2Zb0eoSNOvKbXPz7BlVvLBGhnMb2Uu/xNfkRV2ujuwrBK6YiNVgorX569H/+5dUq8CrM7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744706549; c=relaxed/simple;
	bh=w20RGK1lkSyIU02M7FlR9nHuOTWKhV+wVle+Ia548sM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JqmkrUM2uxzaU61SG/yvk1jGtNaSOKmdhlyQ91fDru/WZVXCb1w7xe3BU4tR/iFOOuSXUjhAF+FOT3CZpg02l1mFttRM/9z2Gc5Wp5v6pmxosIU/MNtB9sc/+MEirJaHNiwzj32zUORTJ8Z32ySPc+Ar55ZZgOnTiNbSpv2ePf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFr04ROQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2D0C4CEDD;
	Tue, 15 Apr 2025 08:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744706549;
	bh=w20RGK1lkSyIU02M7FlR9nHuOTWKhV+wVle+Ia548sM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qFr04ROQjCPZskawdYZm1LJIXKm+wWP1N3bQQQ/0JzdF/sxRmQ4fCmk3CMrpdH174
	 o7IhOJ1/wRb8yiDG5CY+ZOojbCTn77uDbhnjPk1g108VCVJXnaizQtBl5IBI9+TqWv
	 RtepyqGdlw71edWkKAJNJVH6BrzB4hg17WIqMm0T+Lvz39aSAAJkC+L1zTkpemADhe
	 NdnhH9cR0zz/wJU42JKbVAz8o9vuFY8ItIAa/ULy2JqVXkKoCWkEChvv9sbaNZkm2a
	 ur+ch3z+VHVFQ1ZtdWopUM6LPTFtiLoD2/mNtYzxZHhd7tgW2RXMYmAVURq7yNFkyM
	 XGgIYGWJhJPQg==
Message-ID: <9333ced0-88ac-4035-a2da-b2ec9ab4eccb@kernel.org>
Date: Tue, 15 Apr 2025 11:42:25 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] interconnect: qcom: sm8650: enable QoS configuration
To: neil.armstrong@linaro.org
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250407-topic-sm8650-upstream-icc-qos-v1-1-93b33f99a455@linaro.org>
 <b9f90b0c-cae5-4dc3-817a-183b49f947b9@kernel.org>
 <d80e2553-e5b9-4b79-b96e-f7092ac8d707@linaro.org>
Content-Language: en-US
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <d80e2553-e5b9-4b79-b96e-f7092ac8d707@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.04.25 11:17, Neil Armstrong wrote:
> On 14/04/2025 19:08, Georgi Djakov wrote:
>> On 7.04.25 18:16, Neil Armstrong wrote:
>>> Enable QoS configuration for master ports with predefined values
>>> for priority and urgency forwarding.
>>>
>>
>> Hi Neil,
>>
>> Thanks for the patch! It looks fine, but i noticed that there should be also
>> QoS configuration for the qnm_apss_noc node, but it's missing from the driver.
>> Do you know if skipping it was intentional?
> 
> The qnm_apss_noc node is not present in the upstream driver, I wanted to add it
> in a second time. Or I can do it first as you prefer

I was just wondering if there is any specific reason for not adding it or was
it just missed. A follow-up patch is fine.

Thanks,
Georgi

