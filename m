Return-Path: <linux-pm+bounces-41197-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eD0rAToQcGlyUwAAu9opvQ
	(envelope-from <linux-pm+bounces-41197-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 00:31:06 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A88304DD31
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 00:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E8DAF84FCE8
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 23:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BCD3F0765;
	Tue, 20 Jan 2026 23:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="gKbRq/kq"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139313E95B2
	for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 23:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768950862; cv=none; b=U6Zcbsg57n9dk937HxZ/EdcQrIzCYB3XPKQeM2+5xgaNpXvGCJJMbRInGiYyF4lWs1E5aEriZ8EYH9MWLyOJtA3M/MAYOIeNNTPIK4RvgebsioEbnEjbvPupekS6SScTilHDwXnQcJ3Hk+227gulQiKIlDX1Z48CdoKFyvfmPP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768950862; c=relaxed/simple;
	bh=RorFZnKGOpMXxF12DBPQ224YDw0c1sGVEyMqQrlvtpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oB652ZFPJ2ND7gQE9RrActkueodgmsyClNwCZwxCFxm1VMN03JmYaqp0GlSAOoyGrpsvolOdANrVYITmprSF4Y537z0I5Vi491TMwk3/rh7fon7NGDP6UO/B6O5wVFGwK/KTHqzQR2TesSHBB3XCAEoRaBmOuEZ+wNU+DiycoyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=gKbRq/kq; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Message-ID: <74de8f03-dae1-4bf9-a2a1-973952fee2e1@packett.cool>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1768950857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Dx1ZkuxJTJAJ1nIRHVdlZkQt5JO4SJQc0yCogyN8i0=;
	b=gKbRq/kqhma7PJJPi+fWCJpnygM+IQqdK4al8/qcOSuzBuLUOV5/jNAVfaGEArr7dv9pEK
	R4nfUUeBPQFnUI4ETDCyrCu8eMuahWq2BkHdruRx6hLCUpeaRvox+Py37k2082SfFdGX3e
	sLMnWWLQxAFc8RpcM3ouMpY3KdmMKZNF1CsVwCeX1TJzksHgHXMq/4z8itP7ZA/PpgLg0W
	t4KSX7BkXH/dKhJhw2OjM3sf6xIJ6+fcpXHg6oLBJ6uKetcI2oX15s2q4ICbK9PrlpT36S
	sFG7rGR+L4wfYi22Qaf6pVozsj5ppSiQwoIkTY7YsJRSJ7GtiublQpWP5kUfzg==
Date: Tue, 20 Jan 2026 20:14:12 -0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] power: supply: qcom_battmgr: Recognize "LiP" as
 lithium-polymer
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Sebastian Reichel <sre@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260117210941.6219-1-val@packett.cool>
 <bih6lxs4u7q2kfe4kmid35cpmnqmvjltvzv4wrowah6x7v3tth@kptyk7bnmnhv>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Val Packett <val@packett.cool>
In-Reply-To: <bih6lxs4u7q2kfe4kmid35cpmnqmvjltvzv4wrowah6x7v3tth@kptyk7bnmnhv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[packett.cool:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[packett.cool:+];
	DMARC_POLICY_ALLOW(0.00)[packett.cool,quarantine];
	TAGGED_FROM(0.00)[bounces-41197-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[val@packett.cool,linux-pm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[packett.cool:email,packett.cool:dkim,packett.cool:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: A88304DD31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 1/19/26 3:38 AM, Dmitry Baryshkov wrote:
> On Sat, Jan 17, 2026 at 06:09:24PM -0300, Val Packett wrote:
>> On the Dell Latitude 7455, the firmware uses "LiP" with a lowercase 'i'
>> for the battery chemistry type, but only all-uppercase "LIP" was being
>> recognized. Add the CamelCase variant to the check to fix the "Unknown
>> battery technology" warning.
>>
>> Fixes: 202ac22b8e2e ("power: supply: qcom_battmgr: Add lithium-polymer entry")
>> Signed-off-by: Val Packett <val@packett.cool>
>> ---
>>   drivers/power/supply/qcom_battmgr.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
>> index c8028606bba0..80e701c66434 100644
>> --- a/drivers/power/supply/qcom_battmgr.c
>> +++ b/drivers/power/supply/qcom_battmgr.c
>> @@ -1240,7 +1240,8 @@ static unsigned int qcom_battmgr_sc8280xp_parse_technology(const char *chemistry
>>   	if ((!strncmp(chemistry, "LIO", BATTMGR_CHEMISTRY_LEN)) ||
>>   	    (!strncmp(chemistry, "OOI", BATTMGR_CHEMISTRY_LEN)))
>>   		return POWER_SUPPLY_TECHNOLOGY_LION;
>> -	if (!strncmp(chemistry, "LIP", BATTMGR_CHEMISTRY_LEN))
>> +	if (!strncmp(chemistry, "LIP", BATTMGR_CHEMISTRY_LEN) ||
>> +	    (!strncmp(chemistry, "LiP", BATTMGR_CHEMISTRY_LEN)))
> Why do you have extra brackets around the second strncmp?

Copy-pasted from the line above (the "OOI" one) :) Didn't see that the 
first one in this expression doesn't have them.

Feel free to edit this when applying

~val


