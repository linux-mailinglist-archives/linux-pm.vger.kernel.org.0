Return-Path: <linux-pm+bounces-32050-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38379B1E07E
	for <lists+linux-pm@lfdr.de>; Fri,  8 Aug 2025 04:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 401B3582A7B
	for <lists+linux-pm@lfdr.de>; Fri,  8 Aug 2025 02:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A0214B950;
	Fri,  8 Aug 2025 02:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e6OTTpJ+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D2B2F30
	for <linux-pm@vger.kernel.org>; Fri,  8 Aug 2025 02:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754619286; cv=none; b=L34DAOC3qXk9Kh48Dwo8JFyqO2LvsnnVERg4JKhgSlms+FQiUC8sx2LNGxtvNJfO0qGIncC9KdZSypDfQwRjBh5sRjzXq6znKrJc4wE5e2cEHe8WonLSmmeIzwLdeA7QCGipsNoF4DQCxfrwyn26Q2d7gHf7bXWkWxVknhgBOlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754619286; c=relaxed/simple;
	bh=wQtY/4WqbgE2guErpzIRLGgpkmE00KVZtNgRMV+Pi9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWbDzqnrb8vCGqIvMrQNxfdQipKkFvAkLcRy1YL1OsPLPLcEDRTFXtwDxrh6x8BW1s/l2qSfmIXbo5SvMxMSjX+jPDPBxF7AP55PUCx8MjLrRZJq0E1PP+T/Iy+S4uJ/dP3WI+ju7IFYCyZ7Ww++knfxSVbAhIiQmcW/Y/l0f4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e6OTTpJ+; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-240718d5920so60905ad.1
        for <linux-pm@vger.kernel.org>; Thu, 07 Aug 2025 19:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754619284; x=1755224084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U/CmW/UMEXSdHhdIMaJM/qU0QyxbiGV2rEVZVgEQQR0=;
        b=e6OTTpJ+CMRNIcfLBNXCn1/5XxPUHS0WOW1XKnBcfBLkCGavtrBGjBC62UuQPf7eG7
         88sP2h8TBrm1wa64Ex9S88Tc3NNR0iSjfXUFEz7Hp9dNqH0Rt3nUQqY/IN80bAPSr0iA
         6qOTQZTXbKuEYcBDSmwoUHYX9NLlW63bL+bysCYrHZPsADBRKJ2Y1WLMZ87YE48p+DsH
         4QaJAXaUE1u72TNxwAbHCY4s7cwoZmEzQX+9inhG6z6pm8m11ADGefYM6rWjBlGh4Bs6
         maHBzprpG6TbbpWZ28/nmZRawLfrnxWTjNUCQlRtHTdVP839XPHNFGqwl5dHEnxrTD+e
         JTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754619284; x=1755224084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/CmW/UMEXSdHhdIMaJM/qU0QyxbiGV2rEVZVgEQQR0=;
        b=prq3l0r6AtTSrE7rlUEWkJryWwGLqe8CVq00p/ByP+SEo+qxIw6njigf/ZfTLJ9w8P
         UHgDhnbpaejnyFzEKG2Bci9BKHHBRtKBYTqKC7NKVXOwADmarbZPoCdIRzuwGPU0VKe7
         AW+9N5gKpwqY5VeIR8MLHcWeF0Jy87DE9krB/8mif2nPaev7VRjDEcdzpoKyQTch2iKI
         oGdUyjPeGOxMYThqj59U7nCND7fZjmvDSD8Old8PMtjLjKE3YBdOFLX28oxxWfPLm8A4
         fOAzc8OoPrlUng94FJoQsEzgul/G8yuNuSjkoPcuBLwxNIAkfNa91q1XpfJHSCXnGeb+
         94eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUM1DJ6Reqil+OTuKtjZ+ZIm4Zs107OXagb6rW4z7ECKYE3cxIAjdGdl7GW9BXEXd0GGncnIDgALg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLgHGfvOfQY6gKbmS+gH9IlIDjaZI2gZJnqFgkehdivcIt7oZO
	t8lMHUJhzZo8OJ2gEsDRbMcRB8WpgnuwosTuYLbePI+k9LnZ45WeSC0VjlXZkwZZ2w==
X-Gm-Gg: ASbGncvlU1Cb24OApGMelKBGLB1fFAUizCPWBfJl5NTMul/sZuD9t+33jzlKbNbzqWN
	m+AVsdwI/ds8B61C4PwCsigwrJ2vLiykZhAtt2722zWcV2xP9azhVme1guCaQXfShlxGvpRLWso
	ts7Mg/GblbMAtcqpFByIKmRnPaT4q+OlZpr4F7rnkWZwQc8q3p3yjawMODrehuOAuVDP/1CFv/5
	RkhQjBX5Xbek59AOTQgwzq414g5G69S7VSi/Oc5Q57r+Gd9aVGisrs2iUtTcZOQVUiktoMfhjyR
	9cqtya0Ci5LVF8CyNVhcw2duuyNNFm1WSP76dAIzoypT7p5PRdpFFk6ycASH/S6UN/ZKhGN91YK
	yEjZdV+9sziFgU3K8ZmRnzBGH5hOJR4Y3eWEh9/3sl7jCEOjaXVuWQbjnhG5ftg==
X-Google-Smtp-Source: AGHT+IGDf1jT+enxl9JNofYHdNovWwHe1MWvyEkHBvgLmHv5L9E3x/M/t1aB9uYIJEtO8WST68i8fw==
X-Received: by 2002:a17:903:3b87:b0:240:2bd3:861 with SMTP id d9443c01a7336-242c16e10e2mr1712075ad.10.1754619283982;
        Thu, 07 Aug 2025 19:14:43 -0700 (PDT)
Received: from google.com (167.212.233.35.bc.googleusercontent.com. [35.233.212.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3216128ac08sm6689684a91.30.2025.08.07.19.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 19:14:43 -0700 (PDT)
Date: Fri, 8 Aug 2025 02:14:39 +0000
From: Prashant Malani <pmalani@google.com>
To: Beata Michalska <beata.michalska@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Jie Zhan <zhanjie9@hisilicon.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	z00813676 <zhenglifeng1@huawei.com>, sudeep.holla@arm.com
Subject: Re: [PATCH v2 2/2] cpufreq: CPPC: Dont read counters for idle CPUs
Message-ID: <aJVdjwU-qkdDIXaD@google.com>
References: <CAFivqmLG0LriipbmM8qXZMKRRpH3_D02dNipnzj2aWRf9mSdCA@mail.gmail.com>
 <CAFivqmJ4nf_WnCZTNGke+9taaiJ9tZLvLL4Mx_B7uR-1DR_ajA@mail.gmail.com>
 <aIso4kLtChiQkBjH@arm.com>
 <CAFivqm+kbRbJsJ_Obb4bV6fgxbqAwOndLUCDwHvWWnpMYoNoNw@mail.gmail.com>
 <aIvSe9VtZ-zlYfbQ@arm.com>
 <CAFivqmKR1dqVqTsoznH2-n8cyAM1=5zEGcEvmESU8RNGac-0sA@mail.gmail.com>
 <CAFivqmKgiVEWMQ90Lh6T+Y44E6m4jmdF5sUFfVNTmgVHOMtZsw@mail.gmail.com>
 <aJMCgGt5zu5Dhrd5@arm.com>
 <CAFivqmLSp6RwfsPBK0d=zvRd6M_5GoeU4jHb-0OM9BpaDeSrzA@mail.gmail.com>
 <aJR-4J-sTpLaNIJB@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJR-4J-sTpLaNIJB@arm.com>

Hi Beata,

On Aug 07 12:24, Beata Michalska wrote:
> Right .... that's what happens when you are (I am) making last minute clean up.
> That should fix it. Would you mind giving it another go ? Would appreciate it.
> 
> ---
> BR
> Beata
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 65adb78a9a87..2a51e93fcd6c 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -543,7 +543,7 @@ void counters_burst_read_on_cpu(void *arg)
>  
>  static inline bool cpc_reg_supported(struct cpc_reg *reg)
>  {
> -       return !((u64)reg->address != 0x0 || (u64)reg->address != 0x1);
> +       return !((u64)reg->address != 0x0 && (u64)reg->address != 0x1);
>  }

Here are the measurements with the fix:

The readings are less accurate. There are some which report
3.4 GHz (as earlier) but many are off:

t0: del:77500009084, ref:22804739600
t1: del:77500020316, ref:22804743100
ref_perf:10
delivered_perf:32

t0: del:77910203848, ref:22941794740
t1: del:77910215594, ref:22941798070
ref_perf:10
delivered_perf:35

t0: del:77354782419, ref:22762276000
t1: del:77354793991, ref:22762279400
ref_perf:10
delivered_perf:34

t0: del:64470686034, ref:22998377620
t1: del:64470695313, ref:22998380880
ref_perf:10
delivered_perf:28

t0: del:78019898424, ref:22957940640
t1: del:78019912872, ref:22957944590
ref_perf:10
delivered_perf:36

Best regards,

-Prashant

