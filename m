Return-Path: <linux-pm+bounces-41259-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMYtE7WJcWk1IAAAu9opvQ
	(envelope-from <linux-pm+bounces-41259-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 03:21:41 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA45A60D5C
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 03:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CD3B8407903
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 02:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AC938A702;
	Thu, 22 Jan 2026 02:18:33 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [61.152.208.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B188389E0B
	for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 02:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.152.208.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769048313; cv=none; b=GK6u1tHcwI+IC2M3SL6bMzFaHdMd/37H49SVnfd35ZbKVD3lW18w5hTu0de5FJ4+w8bQd0rtJmev2KyJxMvqfOk7M2pO23DJXLVukWYbbYgKF4n4SxjqUKuEyHSmqj0Z7xvgoG9qDIagmuK6sqxFINTptETDJU9EJWLaC27pUPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769048313; c=relaxed/simple;
	bh=mc8oAqdPKTrLSgBk9ssD4ehgVOIYktLIFwYhAv2PF6g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=T7V3PRbRHV7lg7T/dHmSdlVR2YjhmfKfI0ZkwxuzNxuuFJYWHj7R/SDtK+Vc/vhhSBJNW6FpoaBlj4Uq1XJV3bNsAafBjmuCqf90Fc4LIaSaAdirDb9uehV0/laUMBmZxFOs1AheD85ooLuIAo7QifcazhKzoHc/rvqjVeWUceU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=61.152.208.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1769048306-1eb14e7c0425a80001-MQbzy6
Received: from ZXBJMBX03.zhaoxin.com (ZXBJMBX03.zhaoxin.com [10.29.252.7]) by mx2.zhaoxin.com with ESMTP id BsFZw2z7U3h3jF4U (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 22 Jan 2026 10:18:26 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.7
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Thu, 22 Jan
 2026 10:18:25 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::936:f2f9:9efa:3c85]) by
 ZXSHMBX1.zhaoxin.com ([fe80::936:f2f9:9efa:3c85%7]) with mapi id
 15.01.2507.059; Thu, 22 Jan 2026 10:18:25 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.7
Received: from [10.32.64.8] (10.32.64.8) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Thu, 22 Jan
 2026 10:13:28 +0800
Message-ID: <c138c3dc-14ab-4daa-bbed-3cbe5d7c33e4@zhaoxin.com>
Date: Thu, 22 Jan 2026 10:13:29 +0800
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
 <345044bb-15e8-48d3-bc03-d5f327aeb3ae@zhaoxin.com>
 <qlcwa27dujkhxdyeminfzc3435xdz6z7bc627hd4fukr5qbhiw@anrsyspxw4mz>
Content-Language: en-US
In-Reply-To: <qlcwa27dujkhxdyeminfzc3435xdz6z7bc627hd4fukr5qbhiw@anrsyspxw4mz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Moderation-Data: 1/22/2026 10:18:18 AM
X-Barracuda-Connect: ZXBJMBX03.zhaoxin.com[10.29.252.7]
X-Barracuda-Start-Time: 1769048306
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1166
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.153386
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.26 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[zhaoxin.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[TonyWWang-oc@zhaoxin.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all];
	TAGGED_FROM(0.00)[bounces-41259-lists,linux-pm=lfdr.de];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BA45A60D5C
X-Rspamd-Action: no action



On 2026/1/21 18:02, Viresh Kumar wrote:
> 
> 
> On 21-01-26, 16:37, Tony W Wang-oc wrote:
>> The expectation is to register a notifier of type CPUFREQ_POLICY_NOTIFIER
>> via cpufreq_register_notifier in one of our drivers. The notifier callback
>> will configure Zhaoxin registers to different values based on the different
>> cpufreq governors when the event is CPUFREQ_GOVERNOR_CHANGE, thereby
>> allowing the Zhaoxin hardware to adopt different power management
>> strategies.
> 
> Firstly, for this change to be acceptable, we would need your upstream
> platform specific changes as well.
> 
> And then I am still not sure if this it the right way to solve this
> problem.
> 
The driver for Zhaoxin using this patch still needs further verification 
on actual platforms; it cannot yet be submitted to the mainline. 
However, we have already verified that this patch itself has no issues 
with Zhaoxin's driver.

 From the perspective of this patch itself, we think it provides the 
capability to perceive changes in cpufreq policy for all modules 
concerned, and it can serve not just this Zhaoxin driver.

Sincerely
TonyWWang-oc

