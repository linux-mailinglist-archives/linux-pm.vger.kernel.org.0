Return-Path: <linux-pm+bounces-35973-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F07A7BD345F
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 15:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD5964E4BDC
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 13:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BCD19E82A;
	Mon, 13 Oct 2025 13:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="iB++p8Hg"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48FA18C31;
	Mon, 13 Oct 2025 13:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760363211; cv=none; b=oMxhvvWFIH/1txadYwIaW1At03xe82hvJwjhiWLWelYJ07jD1/wo93T66upav0Jcg1ZHC38f8KKkQrhp1cbWaesmSdzesz0aesbEjhM/cdT01r6UXRNNrrzsjMcBu9MCBkdIiNXCWLrQbixNTbqFrdV07dE3OkSioEiA3TKPml4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760363211; c=relaxed/simple;
	bh=Pmmbcic/r+qIXV8K5ROPBDHBvFSG1h6KWUV4d88MJB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QqSOWqbL0unVv/1W/13x/TN6HynTBXQvPMrI5PBWtrSwrj8m+32E++YEg+psUJLaMLh1PqltrncxsgOaZIbm9d4TycgWaofwPdrwjYhONjlxl1Ew938aKO0AverUEZC1qbfNS4ZAejlcyAf0YY+cQ99hs1rgAIQCP3Qps3VpCs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=iB++p8Hg; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PcQMbKbBHQi1eguzQVLDx7OjmBd7vc+uwJpL8NjHAVQ=; b=iB++p8HgLU9j07rxYeZ8mf4TII
	A3tbYIw25XmlUev9vBRRfjySiA8bizOS/XQA7ASgUCFnqXBnxovcjHnmbnhsDXDd+wFHCKWVP5XWf
	j3j8X9T2J0xcm58r5DUlBbQR7XXZ+gfzLYf6bI9ky08Aa0BTV/Q7/xpjUdtodZEO/75FpE/DQ7cME
	HzHNLoeNYAicMSzLgX8bjU4PqYu3x0bWbuab0vPJ/RMqlcGVhVu+o+mld478tsjoajW6py1psYZXJ
	L/G3pH2Hky/Wwt3VovvP07PjPayr2ib05AxFiV5mw4/dzeSpxjuCvW76PrItihAj5EAed6FmuM+wH
	767vnj+w==;
Received: from [58.29.143.236] (helo=[192.168.1.7])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1v8Isg-008xCR-47; Mon, 13 Oct 2025 15:46:30 +0200
Message-ID: <66cbfbbb-53f8-4786-97cf-92eac8daeda8@igalia.com>
Date: Mon, 13 Oct 2025 22:46:23 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v4 01/10] PM: EM: Assign a unique ID when creating
 a performance domain
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: christian.loehle@arm.com, tj@kernel.org, pavel@kernel.org,
 len.brown@intel.com, rafael@kernel.org, kernel-dev@igalia.com,
 linux-pm@vger.kernel.org, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250921031928.205869-1-changwoo@igalia.com>
 <20250921031928.205869-2-changwoo@igalia.com>
 <05359260-336f-4047-bc3a-003ace5ad7c4@arm.com>
 <affa03ed-f859-4e11-9de2-59702b9d5ea4@arm.com>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <affa03ed-f859-4e11-9de2-59702b9d5ea4@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Lukasz,

On 10/6/25 21:24, Lukasz Luba wrote:
> 
> 
> On 10/6/25 09:17, Lukasz Luba wrote:
>> Hi Chanwoo,
>>
>> My apologies to delay on this topic.

Thank you for finding time and making an effort for the review! I
understand that it is not always possible to make time for review. :-)

>>
>> On 9/21/25 04:19, Changwoo Min wrote:
>>> It is necessary to refer to a specific performance domain from a
>>> userspace. For example, the energy model of a particular performance
>>> domain is updated.
>>>
>>> To this end, assign a unique ID to each performance domain to address 
>>> it,
>>
>> Is this related to the sched_ext view on the EM that we cannot re-use
>> the allocated ID for the given domain?
> 
> Ignore that comment, I know the need now.
> 
> Although, there is a small code sneak below...
> 
> 
> 
> [..]
> 
>>> @@ -660,6 +678,13 @@ int em_dev_register_pd_no_update(struct device 
>>> *dev, unsigned int nr_states,
>>>   unlock:
>>>       mutex_unlock(&em_pd_mutex);
>>> +    if (_is_cpu_device(dev))
>>> +        em_check_capacity_update();
>>> +
> 
> It doesn't below to this $subject at all. It looks like
> it was left from some your local changes, isn't it?

You are right. The code is redundant since the same check is done at
em_dev_register_perf_domain(). It is the side-effect of a bad rebase. I
will remove this in the next version.

Regards,
Changwoo Min



