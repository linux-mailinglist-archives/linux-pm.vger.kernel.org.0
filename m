Return-Path: <linux-pm+bounces-12845-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EFD95D9C3
	for <lists+linux-pm@lfdr.de>; Sat, 24 Aug 2024 01:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B72E81C23AAB
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 23:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD431C8FD5;
	Fri, 23 Aug 2024 23:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbI/Zcmc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B648B18786C;
	Fri, 23 Aug 2024 23:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724456395; cv=none; b=UYV/JOcuoOFZlikm6p6CCGaQwE0IKPc1f0AT1yIv8uh4KEshjszwgqVzP7oq3wu3y2Y4OLMytkLyvWUYJZ0OV0fMEvGroM72DnHvWT3MAabrAewFeb105FWpTUay1n4joEDsWW7aju9tx9S8HWlAt6i6woKtR82hpx7wwbtlqR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724456395; c=relaxed/simple;
	bh=kKWBQ7G/gB0nDLrO048tvpph0/Er6ULD8dku7gWLG48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cMgtzSii2Pp5YxOhMDfN5+XPfRCqDaLndNw5ASjfXLgL+wpkGnk8eDy0TvWbS6nuejsrpTm9gpd9yxw2j8VofkvuLUeHC5RfSuYTVEJCvDhW62q6rqVYo5IJj/XwGu44JVtJsCFZXm4LfUhJWpdaCwQDGLgRnnqlQFH6oV4GPSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbI/Zcmc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44172C4AF0C;
	Fri, 23 Aug 2024 23:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724456395;
	bh=kKWBQ7G/gB0nDLrO048tvpph0/Er6ULD8dku7gWLG48=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QbI/ZcmcvCRcz+B/FgOEuHA152qLPLxAjuKBSXTpPgt4/nVwipMbKPsETLLQEoW/f
	 GAZyWcO8UIDbkFLI+XZmruZnu3sbSHuupnEAY6uHoJ0y/7SZGs9JXpzawveVG7q0HS
	 WM4B07hpusajvZSJI8w0bNCXupkaJW76SNc4f2woV+H1h9+HLDs/6F+qDvQWq8Wwof
	 UkkTKckIRWdrMz8iFAVDoJfO+QVNibzFcBh3JOODYcWKq74oT6ez8f+1iFhUvRgM81
	 /FgAy2lIzL8qbuvjsL+ogle5fOicoJV6ZeCZVJGLizv162blmKtaNHFlAEu+PXF7M5
	 TsRMGLzXC3s/Q==
Message-ID: <7c75defd-372b-42cc-897a-eb46e4a8966e@kernel.org>
Date: Sat, 24 Aug 2024 02:39:49 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: interconnect: qcom: Do not require reg for
 sc8180x virt NoCs
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 quic_okukatla@quicinc.com, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
References: <20240730141016.1142608-1-djakov@kernel.org>
 <31173e79-4b2d-4027-a4a2-61071206f387@kernel.org>
Content-Language: en-US
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <31173e79-4b2d-4027-a4a2-61071206f387@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.07.24 17:32, Krzysztof Kozlowski wrote:
> On 30/07/2024 16:10, djakov@kernel.org wrote:
>> From: Georgi Djakov <djakov@kernel.org>
>>
>> The virtual interconnect providers do not have their own IO address space,
>> but this is not documented in the DT schema and the following warnings are
>> reported by dtbs_check:
>>
>> sc8180x-lenovo-flex-5g.dtb: interconnect-camnoc-virt: 'reg' is a required property
>> sc8180x-lenovo-flex-5g.dtb: interconnect-mc-virt: 'reg' is a required property
>> sc8180x-lenovo-flex-5g.dtb: interconnect-qup-virt: 'reg' is a required property
>> sc8180x-primus.dtb: interconnect-camnoc-virt: 'reg' is a required property
>> sc8180x-primus.dtb: interconnect-mc-virt: 'reg' is a required property
>> sc8180x-primus.dtb: interconnect-qup-virt: 'reg' is a required property
>>
>> Fix this by adding them to the list of compatibles that do not require
>> the reg property.
> 
> So I guess we are giving up on
> https://lore.kernel.org/all/20230530162454.51708-4-vkoul@kernel.org/
> ?

Thanks for the pointer! That approach is fine too, but i was expecting
a re-send and then later completely forgot about it. I have a slight
preference towards my patch, because it is more compact, but i can also
revive Vinod's patch if you think that it would be a better pattern to
follow in the long term.

BR,
Georgi

