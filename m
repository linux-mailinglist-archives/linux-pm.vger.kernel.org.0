Return-Path: <linux-pm+bounces-42953-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAeoHG6tmGlpKwMAu9opvQ
	(envelope-from <linux-pm+bounces-42953-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 19:52:30 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0BA16A30C
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 19:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9FFCA301A159
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 18:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C32536682B;
	Fri, 20 Feb 2026 18:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHigHaPY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F7C307AF4;
	Fri, 20 Feb 2026 18:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771613545; cv=none; b=XrtDqVExSyPNIZEPJOUJEFpXMc6jHHKINGmNMo8nT9q09Kukn9OaZo+GKiQePp1YmeqdNtHmOghJqqE95fG3NdEq/UuQmc4RYYrHR60lTTOB79EuL7CC2uru2Jt9UetsOdBgPLftF9kBngU7Wf7NzqkCKxUZ2fk8VzK6SxdS3dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771613545; c=relaxed/simple;
	bh=0j5B9u1TqAi1MV6AR+HHiY0JD5Wr72J6ItB5OtJnuwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V7PWCwkTFuCKnYy2soQERud4w94mQ7qMmqgvfdNPlZkzG9gQeoabUDvfegPcxTANhATzfMKycwEccAsgzR03RtU50pAtc8skp3yxXwNA8xXlMX33YKsagff7du+QubAUniyzcE3fz+8xd8AaR/m+gF9Vh0s6o7YcnI6aSBxCx/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHigHaPY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8380BC116C6;
	Fri, 20 Feb 2026 18:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771613544;
	bh=0j5B9u1TqAi1MV6AR+HHiY0JD5Wr72J6ItB5OtJnuwc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fHigHaPYnPtQ+lgebW1Dqw7mfoMWy2DkBEbQ8wgMcO4bEA2G+Z1LaXbgURMGIKKv+
	 2dVND6ewHHIfVzvXnZdER22tJWUAYJUSv8vUk7iZccgtjnKCEkS2Q96wbzu6/KRoxD
	 pCtPrvhAjxUVynXwfPnV5l8sBRMFZjVTqkiyjB2MkOOdPvJTO7IBucleCn/e0VTLy2
	 r37VQ9CudsGxJgy7sGbiuZN4qBJevJM8sRFhlt4iz8SfCn0I06vPkDx9HBDcxgSn1p
	 6Wk+l32ykqA4q8x5mFiv32t/JzNSJZRaWgeSJjWTcH9kBZWv/zpUahjHl5mnDeVC10
	 PFXqWk/w0eTwA==
Message-ID: <95cdfedd-3eeb-4de8-a8de-78e0ca5292c5@kernel.org>
Date: Fri, 20 Feb 2026 11:52:23 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: Add support for setting EPP via systemd service
To: Jan Kiszka <jan.kiszka@siemens.com>, Shuah <shuah@kernel.org>,
 Thomas Renninger <trenn@suse.com>, "John B. Wyatt IV" <jwyatt@redhat.com>,
 John Kacur <jkacur@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <aa240c08-9dc9-4e2f-a890-57ba9731fbb8@siemens.com>
 <3cf87836-1fb7-4706-86ff-267383a8d914@kernel.org>
 <5a50f8d7-d06b-479b-8b39-71817facd523@siemens.com>
Content-Language: en-US
From: Shuah <shuah@kernel.org>
In-Reply-To: <5a50f8d7-d06b-479b-8b39-71817facd523@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42953-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuah@kernel.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,siemens.com:email]
X-Rspamd-Queue-Id: DD0BA16A30C
X-Rspamd-Action: no action

On 2/20/26 11:27, Jan Kiszka wrote:
> On 20.02.26 17:19, Shuah wrote:
>> On 2/14/26 04:12, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> Extend the systemd service so that it can be used for tuning the Energy
>>> Performance Preference (EPP) as well.
>>
>> How would users use this support? Add a few lines to help them.
>>
> 
> Just like the rest of this service: Install it, tune the conf file
> according to local preferences. I just followed the preexisting patterns.
> 
> What would you like to see on top? And where? Copy what is inline
> documented below into the commit message?
> 

Yes. Copying what is inline into the commit message works well.

thanks,
-- Shuah

