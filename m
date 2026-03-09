Return-Path: <linux-pm+bounces-43921-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MH3ZKL4urmlrAQIAu9opvQ
	(envelope-from <linux-pm+bounces-43921-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 03:21:50 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4A32332F8
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 03:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0849302330D
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2026 02:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A3523E356;
	Mon,  9 Mar 2026 02:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NadfPqtz"
X-Original-To: linux-pm@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E7222256F;
	Mon,  9 Mar 2026 02:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773022886; cv=none; b=lVO4x4PBQ3bAQU1oR/03Pnz2q917G/P5LXFt7e1N2U+rZXvXqJsPsH3WIZzIzME5j9pqKk+hY9WJAWX/RJuwKotLa1Aqfxk3Uw6gSGIh4gr4KCaBAtTp2lWlCsDPUpcZTshzQ43IpqmwKJ49pu8L+PijDTDoBQ7Zw+cFxj4aFuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773022886; c=relaxed/simple;
	bh=Z4FQS5o6LdrxZtJZPJZcL+20cH6ENQ2QjzYwvbhF45E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=APtAE3FLemtLMAaV7LR4Sqi1HmI5zkQA/JJh4vjj8z8djpGjei6v4WAbCbjvJ1DnGo1fo6wSw16+IxBGDkKhExSWDSCZhCEChRLHWZ+mQEWh65f7u5w0uz1deLhIfXvmngbVksHoeMNPlf1EWnQ/2vd+CjwSSY9J+AS/36se/3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NadfPqtz; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=X/qAWoaZQqfb6mtpn3RUbhKRNiQ6ePUEK1WQXiHHbIU=;
	b=NadfPqtz8oMWrUpzwmHqTpokdiv1d47DKAMKLBDP6WE9yRx0GDycuB2GWUuo8Z
	z1dGYXltA4A+rdof6bquGxHhi05pA1P0etHRAvUKSUguBgjGCHi+CqJSwu7L76eW
	rNFhMBzmd+bilj7sCTCe4k7dJgh1zymw5MRpG9dRYjses=
Received: from [192.168.50.71] (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAnya99Lq5ptIx5Rg--.66S2;
	Mon, 09 Mar 2026 10:20:48 +0800 (CST)
Message-ID: <5507e0c8-9733-47e1-bd8e-a335d39ad5ce@163.com>
Date: Mon, 9 Mar 2026 10:20:45 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: scmi: Fix of_node use-after-free in
 scmi_dev_used_by_cpus()
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: sudeep.holla@kernel.org, rafael@kernel.org, cristian.marussi@arm.com,
 arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260302155348.26374-1-18255117159@163.com>
 <4lbgs3xszh75i4nucdhkbi2j33xvu6y3qfkilrshswbn73kpo4@kp36dhmrpogk>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <4lbgs3xszh75i4nucdhkbi2j33xvu6y3qfkilrshswbn73kpo4@kp36dhmrpogk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PygvCgAnya99Lq5ptIx5Rg--.66S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw47WFy3tF4DuF4fZrykAFb_yoW3uFcEgF
	WkK39xuw1UGF1IkwsxKFW3AwsrKFW5Z3y2vw1kJF4fX34fZFW3ZFWkZ3yaq3yxXw4vqrnx
	CryYqF4ayryxZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRic_-tUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxACxVWmuLoCodAAA3V
X-Rspamd-Queue-Id: 2A4A32332F8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43921-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[18255117159@163.com,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.867];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	FREEMAIL_FROM(0.00)[163.com]
X-Rspamd-Action: no action



On 3/3/26 12:20, Viresh Kumar wrote:
> On 02-03-26, 23:53, Hans Zhang wrote:
>> In scmi_dev_used_by_cpus(), the code previously released the of_node
>> reference via of_node_put(np) before checking whether np equals scmi_np.
>> This could lead to a use-after-free if the node pointer was accessed
>> after being freed. Reorder the logic to perform the comparison first
>> and only put the node after the check, or immediately return if they
>> match. This ensures safe reference counting and avoids potential kernel
>> crashes.
> 
> It shouldn't lead to a use-after-free problem as we aren't using the `np` for
> anything apart from simple comparison of value.
> 

Hi Viresh,

Thank you very much for your reply. Then, do you think this patch is 
necessary? Or should I revise the commit message?

Best regards,
Hans





