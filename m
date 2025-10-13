Return-Path: <linux-pm+bounces-35975-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C015BD346B
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 15:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64ED7189B056
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 13:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3505E207A22;
	Mon, 13 Oct 2025 13:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="YeirV2OA"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6AD1F4C96;
	Mon, 13 Oct 2025 13:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760363244; cv=none; b=mIgx7yqpOPpwYn4fqhWyHANirWSgrlKKeVJPW55rBmmtuahpgRdZGAyQmD5UGk/CnXGNgeQjyVYCHt5lTqRHN8oJ4VnljOPdLGxqLx8SAKn1X/A3q28BLyE1DiTnNWZsbC6BtpzMKJRp2kk91IlmPfWgcnEbY782mRG+xY8ytzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760363244; c=relaxed/simple;
	bh=ASCEjBk1j+48gzYXPWRn6C4vs27D8XKOKdf6xu7Km5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ekrYoZavmfaECdBmXVNHCVhHK/3Qb967z7oa9o5oRLe5V5k0ACq67eUUUVRLI99K836fZ66SkO6Pc90n3qUcq6RxvbjJecYwdglSupd77GzGa1WZcU5wct4oOEHQ1aQ7+mLAqjodwRUSI0/KN6JpLkX8msr7IfAbYWzolmkxcPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=YeirV2OA; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=e/qlp/PY6PkbeTJyRNJEFFwc/ShVqN6+P4tbDlSlRTc=; b=YeirV2OARPMmcAKAFj+ndMeSLd
	O9zsNvmboI4/Cojdgo8+ZnfvJhUpL9JFkGm1tUCXGRlRtv+Rj7Hdpr4LDBUgZbEn3cxL1HNBEGbzp
	pQ2JKpTvd8f3ekDGtHiVtn4yshq65NBjNGh9sswfeu7e+ys6wQySnYtLP2eIDdIV5O9Jio7DPF2Tw
	85i1af3B0p2NLXqkjIHtaZwfwDWlyRqJ805GQvyb0zdyhuAIPjB168KwvsWlanHFJWu1cfDGzmY2b
	E8gKYOfPns/bDd2lk+3wqv334QS/pCf+8senBoAEUj4jkVv7FxEpnr7+NjcqQrmUYdd4bdkNxWlZe
	oTG8D5HQ==;
Received: from [58.29.143.236] (helo=[192.168.1.7])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1v8ItN-008xDf-Um; Mon, 13 Oct 2025 15:47:14 +0200
Message-ID: <0ddbe324-fc79-4ca6-8e9a-fdb3bef7dd3f@igalia.com>
Date: Mon, 13 Oct 2025 22:47:08 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v4 07/10] PM: EM: Implement
 em_nl_get_pd_table_doit()
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: christian.loehle@arm.com, tj@kernel.org, pavel@kernel.org,
 len.brown@intel.com, rafael@kernel.org, kernel-dev@igalia.com,
 linux-pm@vger.kernel.org, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250921031928.205869-1-changwoo@igalia.com>
 <20250921031928.205869-8-changwoo@igalia.com>
 <23fe1144-eecc-4e7d-aef7-9b6370d0e24a@arm.com>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <23fe1144-eecc-4e7d-aef7-9b6370d0e24a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/10/25 19:01, Lukasz Luba wrote:
> 
> 
> On 9/21/25 04:19, Changwoo Min wrote:
>> When a userspace requests EM_CMD_GET_PD_TABLE with an ID of a 
>> performancei
> 
> s/performancei/performance/

Will fix it. Thanks!

[...]

>>   int em_nl_get_pd_table_doit(struct sk_buff *skb, struct genl_info 
>> *info)
>>   {
>> -    return -EOPNOTSUPP;
>> +    struct sk_buff *msg;
>> +    struct em_perf_domain *pd;
>> +    void *hdr;
>> +    int cmd = info->genlhdr->cmd;
>> +    int msg_sz, ret = -EMSGSIZE;
> 
> Please put them in the reverse christmas tree order.
> 

Sure, will fix it as suggested in the next version.

Regards,
Changwoo Min

> 
> After fixing that cosmetic thing you can add:
> 
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> 


