Return-Path: <linux-pm+bounces-41219-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KArEIqyTcGlyYgAAu9opvQ
	(envelope-from <linux-pm+bounces-41219-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 09:51:56 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F31CC53E45
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 09:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7D08E4A481B
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 08:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4A0423A8B;
	Wed, 21 Jan 2026 08:51:24 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [61.152.208.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB7A45BD67
	for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 08:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.152.208.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768985484; cv=none; b=R+2GNZr6SGPZfb6eBYInM1HdUEb1VYsjccya6CMKgNQog+WAzfuww8sF1yURsT7kI6GW6twNxjEDHT9aHyYSvLwRirPfr2d5q5fC2fkichUFhazrqz3G3nD3+2wc21pacPwAXeicgw679Lly6zUxPr+TWnGIVtAsKavfY0iaWHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768985484; c=relaxed/simple;
	bh=t8AxgcrUiDxyo6xrma8hT4+Wt9+aUACZuPus/ho8qzw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=U0CGg0OyNsRaFLOXwRYoLld7sA9aC17TN+blGZNjX8FD9pqm78Q2NANgZQL1UV89wnF6D7tyHIK8q4gnMUxijnUbwOVCeoowzuqbhgAswik9VZf/vyHLk3fCfyq9TSBihriDpQy7KxpL5Cns0Hiz0AaeleEsxH7HW79UTTO1Ii4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=61.152.208.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1768985468-1eb14e7c0423e40001-MQbzy6
Received: from ZXBJMBX02.zhaoxin.com (ZXBJMBX02.zhaoxin.com [10.29.252.6]) by mx2.zhaoxin.com with ESMTP id ocMSZHYg6l5XbDHc (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Wed, 21 Jan 2026 16:51:09 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.6
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXBJMBX02.zhaoxin.com
 (10.29.252.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Wed, 21 Jan
 2026 16:51:08 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::936:f2f9:9efa:3c85]) by
 ZXSHMBX1.zhaoxin.com ([fe80::936:f2f9:9efa:3c85%7]) with mapi id
 15.01.2507.059; Wed, 21 Jan 2026 16:51:08 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.6
Received: from [10.32.64.8] (10.32.64.8) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Wed, 21 Jan
 2026 16:38:07 +0800
Message-ID: <345044bb-15e8-48d3-bc03-d5f327aeb3ae@zhaoxin.com>
Date: Wed, 21 Jan 2026 16:37:48 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Subject: Re: [PATCH] cpufreq: Add CPU frequency policy change notification
 support
To: Viresh Kumar <viresh.kumar@linaro.org>
X-ASG-Orig-Subj: Re: [PATCH] cpufreq: Add CPU frequency policy change notification
 support
CC: <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>,
	<LeoLiu-oc@zhaoxin.com>, <LindaChai@zhaoxin.com>
References: <20260120092445.5711-1-TonyWWang-oc@zhaoxin.com>
 <pdp3oabac4g6bakm46w5wj7edl446dqhggdfrlke55gniuju5b@jzodjar7tc2e>
Content-Language: en-US
In-Reply-To: <pdp3oabac4g6bakm46w5wj7edl446dqhggdfrlke55gniuju5b@jzodjar7tc2e>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Moderation-Data: 1/21/2026 4:51:07 PM
X-Barracuda-Connect: ZXBJMBX02.zhaoxin.com[10.29.252.6]
X-Barracuda-Start-Time: 1768985469
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1231
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.153350
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
X-Spamd-Result: default: False [-1.26 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[zhaoxin.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[TonyWWang-oc@zhaoxin.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-41219-lists,linux-pm=lfdr.de];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F31CC53E45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/1/21 13:51, Viresh Kumar wrote:
> 
> 
> 
> On 20-01-26, 17:24, Tony W Wang-oc wrote:
>> Implemented CPUFREQ_CHANGE_POLICY notification in cpufreq subsystem.
>> This enhancement allows kernel modules to be notified when a CPU frequency
>> policy is modified, facilitating more integrated system management.
>> The notification is dispatched after a successful governor switch during
>> policy updates.
>>
>> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
>> ---
>>   drivers/cpufreq/cpufreq.c | 2 ++
>>   include/linux/cpufreq.h   | 1 +
>>   2 files changed, 3 insertions(+)
> 
> Who is using this stuff ? Please explain why you need this and how you
> are going to use it. I don't think it is a great idea, but I still
> want to see what you are doing in the first place.
> 

The expectation is to register a notifier of type 
CPUFREQ_POLICY_NOTIFIER via cpufreq_register_notifier in one of our 
drivers. The notifier callback will configure Zhaoxin registers to 
different values based on the different cpufreq governors when the event 
is CPUFREQ_GOVERNOR_CHANGE, thereby allowing the Zhaoxin hardware to 
adopt different power management strategies.

Sincerely!
TonyWWang-oc

