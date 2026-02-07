Return-Path: <linux-pm+bounces-42250-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GLGFYVkh2k6XgQAu9opvQ
	(envelope-from <linux-pm+bounces-42250-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 07 Feb 2026 17:12:53 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C008C1067A2
	for <lists+linux-pm@lfdr.de>; Sat, 07 Feb 2026 17:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4EE15300D9E8
	for <lists+linux-pm@lfdr.de>; Sat,  7 Feb 2026 16:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DA03314D1;
	Sat,  7 Feb 2026 16:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AgtfPLko"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2807626A1A4
	for <linux-pm@vger.kernel.org>; Sat,  7 Feb 2026 16:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770480768; cv=none; b=q/hql7MzvQ5whuJJzMEd4sOokjYbMngSjs2PFxd9w7kVD0q0h0d+47Wxp5TS5LT8lDaIIuWWUXwUlas2tni/Vj2YrbwdgDFmFewaKcJW5X4apiMcJp5M6RlF46Eep+a49803GHR5MnpHJgHEX/rJ431IgA95qcs5o+C2W2MH+oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770480768; c=relaxed/simple;
	bh=5FU4986/CEdbCVe9oYAoV+DycnOwiz7WRhXJx5zdG2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xnhtxy5YJklohA9tDsJSF7ady+hNOvquuAKjmFhmiYS/poEr0bJLJ2MctaMuzevwR8Bf+Ykeu8Xc1HLbagOK4EcvYWfXBk3nlRoPzo12qVqbFX7sDo+HajV/YjNLNLU0TfX/7EkypC1dybOrIZc4rcQDbE+lCn/w+Mz9eduZcGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AgtfPLko; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c6c444e89bcso1124385a12.2
        for <linux-pm@vger.kernel.org>; Sat, 07 Feb 2026 08:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1770480767; x=1771085567; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ry53ilai/uZAcbwgVMNhYIXsrPk9GKDXJEgL6q3vl6E=;
        b=AgtfPLkovd7tOw/cdsaNrfXn5fLcAVozGdffKMGQxaYloXYoTFSyw++/wMhALolBT2
         vjqPluYkDzuBJjIPppCrdcfWTJdki0xq+NleOXwMRa8EAJEVqLjeMJ5tpFGDAkiBmaE2
         4+SXNJe8xTD6zP8Lk1vC3iMAvqLbnTEDRCjfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770480767; x=1771085567;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ry53ilai/uZAcbwgVMNhYIXsrPk9GKDXJEgL6q3vl6E=;
        b=TMMfvwvbgz5LCqgsnZrXWSERGYH/xAna+xViCgNO3L6LWmhq2zI755hsqyZv/SMWip
         zMlaQuUc50WjGXLb7xX80BbhX4mM8LOeyyGvfiMTlt/q9b6anlhjQWvmjebXdWgm+DCq
         wOsJ6VSB0lna6K49WvHJxi5LKpDlpeOicabPz0faCViVEWqTgvlYYUlqEvpJ7y8Y178+
         q1GIuLGspRnIoPk+S7VdX3pRjsTKutQRl9vl7DGP54vYSt/hqT+4u2ICRPyzou0qjBrT
         B67oOZL4P35ovTFRTvPbigeblRZb40M1qWgrICOmyQTyKFO+Yi+P9/Niw52lULwRsaOQ
         KPUQ==
X-Gm-Message-State: AOJu0YwnSKU5oumY3kx9Liuok6oas4HAIatvRQqcAfRPwAdTmPEWSf4c
	AuguE6xlJ+Jcmn/spnDQeepV+LZcXFJosoih1pLHCBREfj7JHRg78rSWz4vVAx6VYLsXmNNaTws
	121c0hso=
X-Gm-Gg: AZuq6aK+LlZSXdL0zAffcERWLtTvfCymBWIapAOYBIpirZtWAzeE4uX1wLgb0Qh+qPd
	Lz063ii++dATPcJCxrLcPB+HFV1j/duvBUmN4OxpNgERvLaEttj58/br25DnH1dvHwjBGjbQhQ8
	kHKSSp+bkFZBP4DijMZXvUF4QiyGwGJZ/iPz68JcEasPotKbpSDLG1mMT7fksS4l/+9ARwHQV3H
	F9OR9qdzfkLZh9JBNnM+ZxK2J6b9NCUFmI6P9m3kx6FHoufsKBxIXoN88mdaTdkrCATXIg14KOl
	SIRqshjXckdzglMhA7Rdd0WEHgvrxCHmi6T4mOrjl/FHgjINaaCXc26QP1uqtpZzo9drwrUiFqG
	FS2zi3hek42lQhqmmAIwUon/zZEuKe6CSRdVutlhvZMzL83wezBeqUARjD8t3EBs6JCejJR6p6q
	CFsxteGaCodh4n6lW1W/39pRL2
X-Received: by 2002:a17:903:b07:b0:2a9:62e6:ab11 with SMTP id d9443c01a7336-2a962e6b00fmr22178615ad.59.1770480767421;
        Sat, 07 Feb 2026 08:12:47 -0800 (PST)
Received: from [192.168.96.30] ([49.207.181.115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6dcb61d6dfsm5200163a12.24.2026.02.07.08.12.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Feb 2026 08:12:46 -0800 (PST)
Message-ID: <96b8e23d-8f65-440c-b3ff-d6afd218d329@linuxfoundation.org>
Date: Sat, 7 Feb 2026 09:12:42 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: Remove incorrect EPP dependency in
 get_latency()
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>, trenn@suse.com,
 shuah@kernel.org, jwyatt@redhat.com, jkacur@redhat.com
Cc: linux-pm@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20260204111104.3490323-1-kaushlendra.kumar@intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260204111104.3490323-1-kaushlendra.kumar@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42250-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,linux-pm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C008C1067A2
X-Rspamd-Action: no action

On 2/4/26 04:11, Kaushlendra Kumar wrote:
> The get_latency() function incorrectly called get_epp() and
> returned error if EPP (Energy Performance Preference) was not
> available, even though transition latency and EPP are completely
> independent CPU frequency features.

How did you find this problem? Are EPP and CPU frequency features
independent on non-intel platforms?

> 
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
>   tools/power/cpupower/utils/cpufreq-info.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
> index 5fe01e516817..4a9172f4599f 100644
> --- a/tools/power/cpupower/utils/cpufreq-info.c
> +++ b/tools/power/cpupower/utils/cpufreq-info.c
> @@ -459,9 +459,6 @@ static int get_latency(unsigned int cpu, unsigned int human)
>   {
>   	unsigned long latency = cpufreq_get_transition_latency(cpu);
>   
> -	if (!get_epp(cpu, false))
> -		return -EINVAL;
> -
>   	printf(_("  maximum transition latency: "));
>   	if (!latency || latency == UINT_MAX) {
>   		printf(_(" Cannot determine or is not supported.\n"));


thanks,
-- Shuah

