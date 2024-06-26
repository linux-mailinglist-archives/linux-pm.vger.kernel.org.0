Return-Path: <linux-pm+bounces-9985-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1947B9176B6
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 05:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C87772847D6
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 03:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA89282FD;
	Wed, 26 Jun 2024 03:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vFae8BhT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D861134C6
	for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2024 03:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719371878; cv=none; b=PzP21HGm0LF3TurqIZLu0Je5Oq2bZOpym6ZzWLPYQE3SsDb+E1MgodOGgCqf96k2vWXqxNqxdqpUdHQS1YkEseWlNEUWvW9aVLQ7caAMOEOZMEX/Uz16vMm6euLcqevGKV1TNmUdrwUj2CpMYn60UWQ5N7hYWYcaXo0JoCTHTpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719371878; c=relaxed/simple;
	bh=60NhhxN3yPB3953tKa0QOXd9UqE8ng+qs77qkwQM0IM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=roP+YgIfRCZCkMVvxaqMn/EE+WMlr45xl8PzlTXJHxC8kEmqsXQYUxrOrNpkk7QkP0A7pZqhjq1QTyIB+le1HcQ8uuZCdxJSHdlFGXwaiSSh323SLxDqzxSRR5/i8IY9JBrY/JMLtihd87MHlkkDHxDCpWei5854OYWzGQI8lE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vFae8BhT; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-71871d5e087so3076534a12.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2024 20:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719371876; x=1719976676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vJzv1w1u1kLSdubakEMQv2/bRwgId3N7h3glbHdnBPU=;
        b=vFae8BhTTItu3fZxe/7CZq6l2CpXC/BQaPht/qEEIPGB9i1dWJR7ju2cCs1jCzKDFc
         /T/VXYzjwQHy7Xm3x5lbH/EAjLfexnjxXiRFY5HLTp0ko6m2kWVbtNOsieNOcf2MVTDx
         gRV8q/5Jt+JbRTNCXEqr/SzcKH3nyQnO+t0bOXEl0nMjexrUlock4qfPisf4tgRFOFjN
         7IcvunWiIhXaeRwft+GfGBqVL0Re2uCW9GyWh2Us4xtWelsP4bbgkQkOHKp9pYuis/dx
         EqDQsO/DxewYzBNM/C0Qlf3Jf+GFd6GSIPn0ij+ZScENjboG8+zlynmUKYlA/2h8dBCw
         8wQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719371876; x=1719976676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJzv1w1u1kLSdubakEMQv2/bRwgId3N7h3glbHdnBPU=;
        b=XM4lu5Pad4ZjvYEfHxP3SZSRkNiSmiFb3pdhvAqCJ10mZU3kDfGHQDJ6dhn7I1LYvz
         5UDAxcbcfcCfW0q2CX4FF2imZpVQs00u6YN3/4Lrwtj2+5NGLS/uMrj4VJ6mwqkY8i1+
         SHT+AM6R7zSXYtVnX6xwOobDh4L2gC8caaBxlvfn8szu8a3L+OkyPPSBd9FgIsBlx/Qt
         iMoh99RtAShxmOqAz09+cq9VzxR9ib7k7CI4vcQ4k29Hq9A2r2Y8VVrDpQO+CWs+O7ep
         Ofrg1hgwPgMATg5D6LuT3WXv4kkrQpiOzr2IicpowdCxWgeAgRM9IjUI3jqTWBJskNdW
         zOew==
X-Forwarded-Encrypted: i=1; AJvYcCXZdjb3dFBRrWpeIND8YcV4A8OH0iNpbT3etpfwQmE5MauIdKo+4gKZhbHlTQ5V0+muazIl1nlvZK0iKyc0D3BHMor/eZrHw34=
X-Gm-Message-State: AOJu0YwNKkOrEIUS/Eg1IVzVgFIkcMfFGylUHcFLIHp3cx+pDJ1UAcQh
	cSm+rABmVMIMtubydwMrUgmLQFw+kmcp4gwGZYPWSElb99qm8/2qorAoptsqiRY=
X-Google-Smtp-Source: AGHT+IGznWYKbhRhy9DOzn+yZih8gsnpkzyS6qtMJpQcz14sfEAdFJ8t9e9M7fOt3xzZeChC/i7aRA==
X-Received: by 2002:a05:6a20:9490:b0:1b0:2826:9e2 with SMTP id adf61e73a8af0-1bcf44d8bd8mr10653731637.31.1719371876117;
        Tue, 25 Jun 2024 20:17:56 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716b3ee87fcsm7854852a12.27.2024.06.25.20.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 20:17:55 -0700 (PDT)
Date: Wed, 26 Jun 2024 08:47:53 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: perry.yuan@amd.com, gautham.shenoy@amd.com,
	Linux PM <linux-pm@vger.kernel.org>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Dhruva Gole <d-gole@ti.com>, Yipeng Zou <zouyipeng@huawei.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v14 5/5] cpufreq: Only disable boost during cpu online
 when using frequency tables
Message-ID: <20240626031753.dti6ixxi2jlykjqn@vireshk-i7>
References: <20240624213400.67773-1-mario.limonciello@amd.com>
 <20240624213400.67773-6-mario.limonciello@amd.com>
 <20240625063003.cw62yt46b7uaskrp@vireshk-i7>
 <27c030be-d06b-46ab-87d0-2fbfd1dd9e13@amd.com>
 <20240626031142.ytzpyuflgo73piaw@vireshk-i7>
 <056cc207-678f-48ad-bc44-6b3b06bcc5a3@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <056cc207-678f-48ad-bc44-6b3b06bcc5a3@amd.com>

On 25-06-24, 22:14, Mario Limonciello wrote:
> The earlier patches in this series do that with amd-pstate.  Gautham had
> suggested a change to acpi-cpufreq for the same too.

Ahh, since I wasn't cc'd, I missed that obvious part :)

The right fix would be this then I guess:

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index a45aac17c20f..9e5060b27864 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1431,7 +1431,8 @@ static int cpufreq_online(unsigned int cpu)
                }

                /* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
-               policy->boost_enabled = cpufreq_boost_enabled() && policy_has_boost_freq(policy);
+               if (cpufreq_boost_enabled() && policy_has_boost_freq(policy))
+                       policy->boost_enabled = true;

                /*
                 * The initialization has succeeded and the policy is online.

-- 
viresh

