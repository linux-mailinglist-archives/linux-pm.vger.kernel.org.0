Return-Path: <linux-pm+bounces-41602-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EkrHC7oeWkF1AEAu9opvQ
	(envelope-from <linux-pm+bounces-41602-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 11:42:54 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 119359FA07
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 11:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E58743004618
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 10:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C202F1FD7;
	Wed, 28 Jan 2026 10:42:51 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8A729B78F;
	Wed, 28 Jan 2026 10:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769596971; cv=none; b=kGgj1biVOLnAnEndWcIvSiOIDEjK5utn5luk3jbUjspCvwP1wYjKG4BhjxvofP8SEJJqhTwnTCxnAKkSkBAh3LMbuLvMRcjEBWtyL2NFl/WyzR99CwzaXy7XttApIQNf36Pb9H267CYwIviDe1erv8Ip507JZktEYBRZxCwa2Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769596971; c=relaxed/simple;
	bh=XuLhm7lxuNCOLV9QyUWF4q0xm+qYs+xetGXCyt3L55w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GOUXhchyxFVeFTkA+wSjoUOVF+bUBDUGCMZFTmd3YRr7+ea6KFaVHqcU+iFuklJ/PVjvxZuDDHubfHiWVMtOHkbCFQPcHVLh+VU9sT2uL5ACwSXo5gAbWUU03G+kRm5blyGXRmGdWWckSEMU/qs3pNVZse1+y4UYG9GgSX40xww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 464B61515;
	Wed, 28 Jan 2026 02:42:42 -0800 (PST)
Received: from [10.57.17.95] (unknown [10.57.17.95])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20B9C3F5CA;
	Wed, 28 Jan 2026 02:42:46 -0800 (PST)
Message-ID: <67d1584c-a474-4873-8cc2-9899296ea7ea@arm.com>
Date: Wed, 28 Jan 2026 10:42:48 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/of: Fix reference leak in thermal_of_cm_lookup()
To: "Rafael J. Wysocki" <rafael@kernel.org>, Felix Gu <ustc.gu@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Yu-Che Cheng <giver@chromium.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260124-thermal_of-v1-1-54d3416948cf@gmail.com>
 <CAJZ5v0gL92f3g4oj47jaYQKG_V6vd_oBawbwQVWjUP7u9QKS7g@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0gL92f3g4oj47jaYQKG_V6vd_oBawbwQVWjUP7u9QKS7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-41602-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukasz.luba@arm.com,linux-pm@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 119359FA07
X-Rspamd-Action: no action



On 1/27/26 16:22, Rafael J. Wysocki wrote:
> On Fri, Jan 23, 2026 at 8:06 PM Felix Gu <ustc.gu@gmail.com> wrote:
>>
>> In thermal_of_cm_lookup(), tr_np is obtained via of_parse_phandle(). But
>> it never be released.
>> Use the __free(device_node) cleanup attribute to automatically release
>> the node and fix the leak.
>>
>> Fixes: 423de5b5bc5b ("thermal/of: Fix cdev lookup in thermal_of_should_bind()")
>>
>> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
>> ---
>>   drivers/thermal/thermal_of.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
>> index 1a51a4d240ff..b6d0c92f5522 100644
>> --- a/drivers/thermal/thermal_of.c
>> +++ b/drivers/thermal/thermal_of.c
>> @@ -280,10 +280,10 @@ static bool thermal_of_cm_lookup(struct device_node *cm_np,
>>                                   struct cooling_spec *c)
>>   {
>>          for_each_child_of_node_scoped(cm_np, child) {
>> -               struct device_node *tr_np;
>>                  int count, i;
>>
>> -               tr_np = of_parse_phandle(child, "trip", 0);
>> +               struct device_node *tr_np __free(device_node) =
>> +                       of_parse_phandle(child, "trip", 0);
>>                  if (tr_np != trip->priv)
>>                          continue;
>>
>>
>> ---
> 
> This looks good to me.
> 
> Lukasz, Daniel?


Good catch thanks! That looks good. This scoped device node
handling approach simplifies a lot the error paths (and is less
error-prone).

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

