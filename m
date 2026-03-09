Return-Path: <linux-pm+bounces-43931-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOXpOZmErmnKFgIAu9opvQ
	(envelope-from <linux-pm+bounces-43931-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 09:28:09 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA222357CA
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 09:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 883A03006973
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2026 08:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7998236CDE5;
	Mon,  9 Mar 2026 08:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hSaGmZHW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A353624B2
	for <linux-pm@vger.kernel.org>; Mon,  9 Mar 2026 08:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773044873; cv=none; b=nvTw32G/+90e15vQWNWYk7SwSvgf0mC/ur2RN/NZZDh6K1PSeCmgvbz7spoaS8vdP8WTWbkNdS7azSEDRDPeJWbCu1CEJSPifBQsCzOnWJpTwVRmS6p/jKjBojjqULrMkE/zGsk1UAd737WrbrLChd5jca2Wmp/GMA97RgqFkV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773044873; c=relaxed/simple;
	bh=qdE7aetTD2OkRfGseSdadjVv3y60yy4ER3eP1hJeH3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDRj2JDdIUAsqYcZIHCQmSG38l9KebX9k0d70cqcOfWf6GxzTCO8IRcmRGzdr8xGzpN3NbG9G1kURrLiYFNpRpfiOQV8Hb2/HLZWTHN+DkY14DEjrzUWRBuJ/Wd4numPY0+roeJ6+f12LWFpWqwuCE5LtV7JvL698uZAKInhF/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hSaGmZHW; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-829865a8471so4107127b3a.3
        for <linux-pm@vger.kernel.org>; Mon, 09 Mar 2026 01:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773044871; x=1773649671; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LU80+fkuDcvHCzjSUt0DZ3QvTPAcZXlD4sk1ib9lUAQ=;
        b=hSaGmZHW98xrRnv6qqQccAMy4lCQ7GS+D72cuHkwdlEVoTpE9nnkygtFZxw9A4S5un
         NibBP74M04mJ+w5J4IjC0bSCiteeFzYeafbsp7cODmlc+mQme6D91KGpajuqBHkcyU3Z
         I66l1ujbMghu77hNgqd601X+O0/RF1o3iGkq2tzq9acQYg5NT2dVEijbLdEpopDzVpwM
         EeBXySAs8P+4cm5/kc3ocZRyxGM26vkY6jNW2RLImnqwCJT9Jye0ojyL4JH8PiTbgSgD
         jBZFLU0LcV1/73kTBYn5BB9yoDEjZ7IeHhSTbvyAp57PuocF0/cOFPeXW+uZ0zvjJJEX
         V37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773044871; x=1773649671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LU80+fkuDcvHCzjSUt0DZ3QvTPAcZXlD4sk1ib9lUAQ=;
        b=rJq6qjIrg++Qs5CFB5P4RV9m53wfGR9sYGbf0grGliQkVE32/OlBbzWJLpfvmo8RVS
         ymKCC0NHtwiJt8uv+bYJopL3QIbuwm+4hKlIUsXbqeWoqvYdegb7j3ekIvAabihT8OPS
         TSYKQy33RDhvOgkSvnPuoXvNiyIb0+5A9SjQx87CsLuocFQBvIf5dvxttDoZMvGIk97x
         YefvundhWwcV+BvzsaW24buZRaJL0qQRMMd2By3qXk4Ug+UnnQuuDVS9gb5e4w4BITUP
         6+wZpgf3QKSKdqy4HlTY2wgj1PzbenUMmMVuuQMLOGRGN9GPUBdqVpd5YGdG/d5CUtqE
         F6xg==
X-Forwarded-Encrypted: i=1; AJvYcCXhFXzY4lgn9GuMhGCOyf6IOowAp7jJgi6QrngvToCpA1q0m7m+cRow4HEHY4EleQ8z5jxB+HL5Cg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyBsPKyUABRUinQsod6dhoOqyzJnNVlWE+hehCj6/dik/kILT2
	vSWYJoJ11fuuIkkyorjbn70R9nOW65LqeMRHRxAnBn3ZmzW+Per1cG+c+tNyGgw9xm4=
X-Gm-Gg: ATEYQzyIGjKt7RKrt6IRr1zHOA7EGuCPhpxzOBKmhsT4l+kF1/IehhoNUxiEeuulfKo
	106+WlqkoVPbO+M5/bSt1eOcpdZqW+8r0iqIRo82U17YbLL85bYqh0x/ZknWMdMy/TyeVjftarw
	kOFSFt8GjjOWRDI1/lGhfXZAvmxANkUYTcGlwr3OXnrgEBmwbe7YZ6Sk+nmvawQP+aFfFGiHbTy
	6kWQEOlVcZVFI24Z5a3+qVaaZIQmPs8gU0LWxgQCLzUWshw1MMzppqqJIeMiQ3GSzQz58MPXmqF
	HyZnc4+JO8nvFBKnVDsvVV8jcI7B7X4dWdQaGID4/5x2F3c4ODw5kqanKGzEDL0Irn7EuZl0sUS
	TyNV+asyAEDH8mUR43d40yGwJDxedeD9WsHhUZXjFbQutfCTmTt0jQf7pQzmAC1v/WrKJ03ePgQ
	FaI8fuZk9aww6XQURrKD5NAg8D
X-Received: by 2002:a05:6a00:3d13:b0:829:86a5:d30a with SMTP id d2e1a72fcca58-829a2dba846mr9525478b3a.16.1773044871129;
        Mon, 09 Mar 2026 01:27:51 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a465b6ecsm9626690b3a.22.2026.03.09.01.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 01:27:50 -0700 (PDT)
Date: Mon, 9 Mar 2026 13:57:47 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: rafael@kernel.org, Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, jonathan.cameron@huawei.com, 
	zhanjie9@hisilicon.com, lihuisong@huawei.com, yubowen8@huawei.com, 
	zhangpengjie2@huawei.com, wangzhi12@huawei.com, linhongye@h-partners.com
Subject: Re: [PATCH 0/2] cpufreq: governor: Apply limits with target_freq
 instead of policy->cur
Message-ID: <javy6tllyw7pcnri3s6s2gnpv3kewe2b4zkyoz3vj3jzmfu6c5@nikhlydadvcc>
References: <20260210115458.3493646-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210115458.3493646-1-zhenglifeng1@huawei.com>
X-Rspamd-Queue-Id: 4BA222357CA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43931-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viresh.kumar@linaro.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linaro.org:dkim]
X-Rspamd-Action: no action

On 10-02-26, 19:54, Lifeng Zheng wrote:
> The motivation for this patchset cames from a test on our platform:
> 
> With conservative governor and some pressure on CPU, the frequency rapidly
> reach the max supported frequency, such as 2GHz.
> 
> Later, some frequency division strategies on our platform were triggered
> and the actual frequency become 500MHz -- 1/4 of the OS distribution
> frequency.
> 
> At that time, if someone excecutes 'cat cpuinfo_cur_freq', the actual
> frequency will become 250MHz -- 1/4 of the min supported frequency.
> 
> After the platform recovering from the frequency division, the frequency
> will stay on 1GHz, until the pressure disappear.
> 
> The reason this happens is that in cpufreq_verify_current_freq(), if
> policy->cur != new_freq, policy->update will be queued, which will
> ultimately lead to a call to cpufreq_policy_apply_limits(), and update the
> target frequency to policy->min. And then in cs_dbs_update(), since the
> pressure never vanish, it will always hit the following branches:
> 
> 	if (load > dbs_data->up_threshold) {
> 		dbs_info->down_skip = 0;
> 
> 		/* if we are already at full speed then break out early */
> 		if (requested_freq == policy->max)
> 			goto out;
> 
> Therefore, the target frequency will always remain at the lowest frequency.
> 
> The branching conditions in cs_dbs_update() may not be strict enough, but
> the root cause of this problem is that the target frequency was updated
> when querying cpuinfo_cur_freq. For ondemand and schedutil governor,
> although the frequency will not always remain at the lowest level without
> rising, will still be min_freq in a short period of time when the query
> action occurs.
> 
> Using the freq requested by the governor to decide whether to update the
> target frequency is more reasonable in cpufreq_policy_apply_limits().

I think I understand the problem now. We are tracking the current
frequency state via two cached values, policy->cur and requested_freq
and a mismatch (because of your hardware specific quirks/features)
between them is making things tricky.

Rafael, will this break anything we can think about ?

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index e0e847764511..c69577e4f941 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -14,7 +14,6 @@
 struct cs_policy_dbs_info {
        struct policy_dbs_info policy_dbs;
        unsigned int down_skip;
-       unsigned int requested_freq;
 };

 static inline struct cs_policy_dbs_info *to_dbs_info(struct policy_dbs_info *policy_dbs)
@@ -59,10 +58,10 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
 {
        struct policy_dbs_info *policy_dbs = policy->governor_data;
        struct cs_policy_dbs_info *dbs_info = to_dbs_info(policy_dbs);
-       unsigned int requested_freq = dbs_info->requested_freq;
        struct dbs_data *dbs_data = policy_dbs->dbs_data;
        struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
        unsigned int load = dbs_update(policy);
+       unsigned int requested_freq = policy->cur;
        unsigned int freq_step;

        /*
@@ -72,16 +71,6 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
        if (cs_tuners->freq_step == 0)
                goto out;

-       /*
-        * If requested_freq is out of range, it is likely that the limits
-        * changed in the meantime, so fall back to current frequency in that
-        * case.
-        */
-       if (requested_freq > policy->max || requested_freq < policy->min) {
-               requested_freq = policy->cur;
-               dbs_info->requested_freq = requested_freq;
-       }
-
        freq_step = get_freq_step(cs_tuners, policy);

        /*
@@ -113,7 +102,6 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)

                __cpufreq_driver_target(policy, requested_freq,
                                        CPUFREQ_RELATION_HE);
-               dbs_info->requested_freq = requested_freq;
                goto out;
        }

@@ -137,7 +125,6 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)

                __cpufreq_driver_target(policy, requested_freq,
                                        CPUFREQ_RELATION_LE);
-               dbs_info->requested_freq = requested_freq;
        }

  out:
@@ -310,7 +297,6 @@ static void cs_start(struct cpufreq_policy *policy)
        struct cs_policy_dbs_info *dbs_info = to_dbs_info(policy->governor_data);

        dbs_info->down_skip = 0;
-       dbs_info->requested_freq = policy->cur;
 }

 static struct dbs_governor cs_governor = {

-------------------------8<-------------------------

This always pick the next freq based on policy->cur instead of the
real last request. The two can differ if:
- the hardware plays with current frequency, as is the case here.
- or the limits change and that changes the current frequency (in
  which case we will be at policy->min/max anyway).

-- 
viresh

