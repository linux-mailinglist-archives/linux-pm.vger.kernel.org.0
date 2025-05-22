Return-Path: <linux-pm+bounces-27493-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B800CAC073B
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 10:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E5807B62F5
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 08:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6818262800;
	Thu, 22 May 2025 08:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="aw1ic9y4"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81260268691;
	Thu, 22 May 2025 08:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747902974; cv=none; b=ta30B5cUryBVho5SCau/CTk4y7LXADlPz2SeuqPdRCWpP2bU32QDqSz8d+uKgf54Sp3SA8RVGBVDma+LOGwLTvm/HX0yDA3BISm3EMlv47vVo6XFvYFDsWhU+2OcI4Sk3rmO+9/bae1sVUverElGNFdgiTCt48FdSzePBgaskFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747902974; c=relaxed/simple;
	bh=0iqH3SFau2Ad0MLJhsn1yGSNEsRQWQL4MBklLj1xHpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ANQ/rz3QZJKjhTpYlayI4SV15B2Ll4TDt9tP+xgA91NMBAvVJ7HrG0K9/YelyHe6/6/8TJabGfcGG+vv07u8kJSJBfV7mVnfstNaEqTs2vhJray6jck/bdxM9inDGcKCVGX0U/R4bB4fZd3XbZiFyF0GLjR31PmiEdihbBtN3oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=aw1ic9y4; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MlBjh67fGAfaX5KmbbcZM9E/1HTJY8YOYuHSiHb/X8g=; b=aw1ic9y4PyfVRDebLTLqFx8AOM
	j1uaR058N/V3dYnT6vvo65fUpuBqhwjqZBTmBAmf34hT6QrL36k1du5c3CGxF3dj2GirdrctCjJhO
	4oU8xknCmvl1ZBkc9ZtcfFY4XlGTCwkYMydJNh3sEX7jyfFaUWH/ndkMItPWeLlsI6nsISmLUgPdo
	QPLnN/b8yMAPM09zUOkCAUXFZZtawKC1EHJqJSHfkoXydgqYxHP0lpBAY1wEplne9yIPhyMzNVpb8
	brpOjWA1Jjx2G5NzsOaEb5t89ihzHZ2SaKK8QahCiYgkpQAyxnI0cFfOiWdQDrJfbevIStQ5rCJSj
	3B/hdWnw==;
Received: from [106.101.7.122] (helo=[192.168.210.21])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uI1PH-00Bcfi-Ew; Thu, 22 May 2025 10:36:03 +0200
Message-ID: <c85cbb96-8c0f-4f91-a568-20c9de65b10b@igalia.com>
Date: Thu, 22 May 2025 17:35:55 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PM: EM: Add inotify support when the energy model is
 updated.
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: christian.loehle@arm.com, tj@kernel.org, pavel@kernel.org,
 kernel-dev@igalia.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, len.brown@intel.com,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <20250507014728.6094-1-changwoo@igalia.com>
 <a82423bc-8c38-4d57-93da-c4f20011cc92@arm.com>
 <CAJZ5v0ixh=ra-TDbC59rpZoGn0pRWmAMchHqoOb_XwB2XUzA7Q@mail.gmail.com>
 <90834b07-9261-4be6-a10b-88d3f5308e1e@igalia.com>
 <CAJZ5v0jiAHHLP2O_0ZkXPPCXq9tFTxqrap1mFXOJtKuBo-gJfw@mail.gmail.com>
 <96b4ae67-b9a8-47d3-a951-a880848e6719@arm.com>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <96b4ae67-b9a8-47d3-a951-a880848e6719@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/22/25 17:19, Lukasz Luba wrote:
> 
> 
> On 5/10/25 12:34, Rafael J. Wysocki wrote:
>> On Sat, May 10, 2025 at 7:07 AM Changwoo Min <changwoo@igalia.com> wrote:

>>> I am curious about whether the energy mode is likely to be updated more
>>> often with this change. How often the energy model is likely to be
>>> updated is the factor to be considered for the interface and the model
>>> to post-processing the eneergy model (in the BPF schedulers).
>>
>> It really is hard to say precisely because eventually this will depend
>> on the platform firmware.  Hopefully, this is not going to happen too
>> often, but if the thermal envelope of the platform is tight, for
>> instance, it may not be the case.
> 
> It's hard to say for all use cases, but there are some easy to measure
> and understand:
> 
> 1. Long scenarios with heavy GPU usage (e.g. gaming). Power on CPUs
>     built from High-Performance cells can be affected by +20% and after
>     ~1min
> 2. Longer recording with heavy ISP usage, similar to above
> 
> In those two, it's sufficient to update the EM every 1-3sec to reach
> this +20% after 60sec. Although, at the beginning when the GPU starts
> heating the updates should happen a bit more often.
> 
> There are some more complex cases, e.g. when more than 1 Big CPU does
> heavy computations and the heat is higher than normal EM model of
> single CPU (even for that scenario profile). Then the updates to EM
> can go a bit more often (it depends what the platform would like
> to leverage and achieve w/ SW).

Thank you for the further clarification. I think the netlink 
notification should be fast and efficient enough to cover these scenarios.

Regards,
Changwoo Min


