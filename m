Return-Path: <linux-pm+bounces-40698-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76512D162AD
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 02:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37065300D43C
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 01:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8871A1DF248;
	Tue, 13 Jan 2026 01:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HmOLztkH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356A1173
	for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 01:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768267846; cv=none; b=J2RtNimOe2ezPzdAQIY5vd3NGKRNla0QmW+SZd+X1UgHfpstDH5L9nRwtJd/Rf4s+4xkSZ884EqhRxP1MXa19FA49zilqlJ31g72vYSSH2XoITZpVYvUnWyE+ttAPZ2nxnPVsUo4iip4NppzF4B8SiZGa+Z4Q1yhh8N6JOZyXPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768267846; c=relaxed/simple;
	bh=a/5rTh71GT21U7kcypqP8f0I+CjObQ+k0IbOvQTe0Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=laQuEdNWmFC9VN4rowqM2Ru7pnXMUwggot2/QSQFdFVKaiOIAIORZ86OoYgEzs0NSXjoG+LkdRxJt+ZHS+GhE2XsslZs/69XDEMPivVvDaLgUKOBbYOkOhm1VRofPRTf7YyJrcAesf3od3bLS4rkkaIXAqB08jFgTGbRW6LMjUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HmOLztkH; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c2dc870e194so3626475a12.2
        for <linux-pm@vger.kernel.org>; Mon, 12 Jan 2026 17:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768267844; x=1768872644; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=58UqtPkFFGDQxORFFboEVUxGaEihGLqNoblI1MNIBio=;
        b=HmOLztkHtZBv8vo+QEw/voKSFhtPGyhsD4HqhmVSLSgVFIXZXhcx8cakhNQ0kMKik+
         Fu9ALr7Y7kgU7hDoNTiIf3OTjgMhEFM2Sceki5zy/6OFtwA8bT/oMknFmdBYX3usc/1N
         ArwSLU4r+99C5mPOP68FK+/CLMNG4UCxMcjdyK3PhzEzym5OcEX3OaV1IKxoVo3ytFln
         08r6O9lWBusODMUrlpmiS0lf1GCWPlC49bDMI8ltYPz4bJhvQTelYPaSxPjYFV0NdIYA
         AA61WyV6kB4zU8pmpCBpBBPttCQXkRNQZtjC15px/l4q47IJ8oGwhHd5orBFy5O13aei
         YPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768267844; x=1768872644;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=58UqtPkFFGDQxORFFboEVUxGaEihGLqNoblI1MNIBio=;
        b=cMLhYxma9mQrrcHdpvbOBrbAKv0iEBR/w4dCVGnxRs0gzdjWKoB7K/7vCqj+tS8FlE
         nIgIQfMrKPx7T/8MbZD093A4Nn18bNBYUkH/kXu2EejVB0x74Tp2ng8WdZgkCsa7wfdt
         Svr0xz+WISpia55m44vFgi+b3iZDVX/VCyFAUp/scwjsXBeEBK0mPzn4/yDAkmYShQbr
         IgGTZ48x4Bes7COnSZWf205bbsDtlolo6BSTnXUX5knZYds9aQ85+oUXOFOa6Skat0Dh
         N0+tu1EAuRN7+ZNuGrEU8uOlGoLB/MUH+aDdF6i9pnZOEDEuxXRwBL47tRvBu7H1WzZh
         W4Bw==
X-Forwarded-Encrypted: i=1; AJvYcCXUYSHzrpqjFF+SSJHxnVbNHioVYRnmZpu92NofIVhFs6xK5a3WqMAFzoFXiUwNBsDRJnhw22bgvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd4hNJ9tFgN3EfPPt1sDJB/r7nuQuf6kc6YK6csjIa8fPqcnQA
	kpl22rRaYH4I2j9kusXWbf2nc1Wddw/ETPkGlVjkq2c95ijL5hgPx/9gKs9cjp7e6yw=
X-Gm-Gg: AY/fxX5Z2lCh61BuaAdzUmLMiC1Ln0F/cw77MSyAmGrw41RLuazrGd+Iu6HfW0cP2nc
	LVVmNrwJ1HVcw2Uia8UDvGDkRvlD8h7aKR/6pENr22KsNjd/8dtzGa/rD86I/c/4cNudCjWZNx5
	UIqWd+K10GQcbjO9iaLUSf/CR62hPWLy4oozpVGSXIsw6bP3W5Z+xASzQHAzM8t150iKjj7uXIi
	jJ/bJXcSt4aoCHagVQSGh2A/5f9c2llm9UdKPcMsbAcqlH9M8fqv9BhWSyYM3WGp0yZLfXa35DD
	jbU4Zeu1mimXZDRhvTwL9cXH8Z1eUqc5b3FtWIpyfNQ8VQ4jA1tkPCKvDrzj138w8y4ZPvEqhBj
	aVWfcpe9eh0bqJOyIBR4Nw5QZFdOJDZsrAMiKKvIzDwGRBhqOdoSgaNfG8Hfw33LN9cvi13CZQv
	53kQ5Mwa2AoUQ=
X-Google-Smtp-Source: AGHT+IGwAxsnzphJnaoHj9J1duApxVIL1q56mxfOQ8QBe/RBJnZ5avX9JIm0exOtxAXc6EicwXOzug==
X-Received: by 2002:a05:6a20:3947:b0:344:97a7:8c6a with SMTP id adf61e73a8af0-3898f9cc49cmr20372155637.51.1768267843930;
        Mon, 12 Jan 2026 17:30:43 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cca06b77bsm18618105a12.33.2026.01.12.17.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 17:30:43 -0800 (PST)
Date: Tue, 13 Jan 2026 07:00:40 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: "zhenglifeng (A)" <zhenglifeng1@huawei.com>, 
	linux-kernel@vger.kernel.org, Christian Loehle <christian.loehle@arm.com>, 
	Ionela Voinescu <ionela.voinescu@arm.com>, Jie Zhan <zhanjie9@hisilicon.com>, Huang Rui <ray.huang@amd.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 3/3] cpufreq: Update set_boost callbacks to rely on
 boost_freq_req
Message-ID: <ppzoeb4wod6jjhlvkiqogcd26v3shfh5cjiuq63r7bbnsyzzok@sdx5usgvcqzu>
References: <20251208105933.1369125-1-pierre.gondois@arm.com>
 <20251208105933.1369125-4-pierre.gondois@arm.com>
 <14ad55ce-413f-46e0-9ce0-f35fc421056c@huawei.com>
 <73da1186-5edd-4465-bd49-e18d9064a501@arm.com>
 <ea9111b5-cd85-4526-a959-54d8037d6ffb@huawei.com>
 <36630a40-b6e6-4bf6-8fa1-1a004e0d2798@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36630a40-b6e6-4bf6-8fa1-1a004e0d2798@arm.com>

On 12-01-26, 16:02, Pierre Gondois wrote:
> In:
> cpufreq_set_policy()
> \-cpufreq_driver->verify(&new_data)
>   \-cpufreq_verify_within_cpu_limits()
> 
> the requested min/max values are clamped wrt the cpuinfo.[min|max]_freq.
> However this clamping happens after the QoS constraints have been
> aggregated. This means that if a CPU has:
> - min = 100.000 kHz
> - max = 1.000.000 kHz
> - boost = 1.200.000 kHz
> 
> With boost enabled, the user requests:
> - scaling_min: 1.100.000
> - scaling_max: 1.200.000
> 
> If boost is disabled, we will have:
> policy->min == policy->max == 1.000.000
> without notifying anybody.
> 
> Ideally I assume it would be better to prevent the user from disabling
> boost without first asking to update the scaling_[min|max] frequencies,
> or at least detecting this case and have a warning message.

I don't think this is a problem and doesn't really need special care.
It is the user who is disabling the boost feature, its okay to force
set to clamped values.

> Please let me know if you prefer not adding the new qos constraint,
> I ll try harder not to have it if yes.

But even with that (the issue pointed earlier not being a problem), I
think a new constraint for boost does make the code cleaner and easy
to follow.

Rafael ?

-- 
viresh

