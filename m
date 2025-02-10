Return-Path: <linux-pm+bounces-21704-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3D3A2F12C
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 16:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C52CF1881BE9
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 15:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B6D23644F;
	Mon, 10 Feb 2025 15:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xekjm++Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2AB2528E1;
	Mon, 10 Feb 2025 15:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739200407; cv=none; b=p0/JLVrgTCAQ9Pyl/uxJ/Nm1sKktAFDnB47ZuNx8UgKiE/2fGQuuL0fIPtus9A42Bqw55XNGf+28Sa8wW482Pu55V1a9aUDejXxI9ha/a7JJU2XZOTsiciBd+4W+hm9MSbw1xIEE5xKx05WLaCDrujCffglfHO5w3hQytGWJFkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739200407; c=relaxed/simple;
	bh=UXSwpCbZZloxFOKQ4lZ23qNeuJVml4BdbrotS6nr70w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sDP7aSnod1ZDsnBB+WvAAHf8gHrZ5C6kAGEaRuWESKCwZmBDdfefQyZZ3sOxA+GJzWEROvyO8kDqPXTUBbFgMl2lf62FrhU4GufWMoQ4VPEILFopA1W20qIYazhbiD4yw8qh4Due1H8tr6o8Q4PrXILTY69Tqawp/kJ0JjeYJyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xekjm++Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37DAEC4CEDF;
	Mon, 10 Feb 2025 15:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739200406;
	bh=UXSwpCbZZloxFOKQ4lZ23qNeuJVml4BdbrotS6nr70w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Xekjm++ZAARokl6QlAhSemplHdg8xccS9S3jd/br7ch+KvSE/LZsMvWARC1MQkqN2
	 AGfg2MPoKavCk8MasMmHqtIG3qtHKC8wNVSuHy5125xVyz5FInlisrKPZFsdmDh+FB
	 oMzXVK5Cn4ew1jOI/cMnmZKKaSHBSXFsRo126wJfjr22jX4TsvCL/QEZgdDQ30WQRl
	 /b3x81rdtezOZkBD/rm1z7zsakWr1uLvPU7GTMlof4AyiAd2DLtYcNZ4g5Qbzl3XTE
	 wqqkb4iaME2EabgRtHY0PL/yevMildALnWUXJHNnSuCa43N/2a3JduoUE8m4Ryp109
	 E3Pekp1dud84A==
Message-ID: <584c3152-e730-4cbf-a79e-aa5404de6ab5@kernel.org>
Date: Mon, 10 Feb 2025 09:13:25 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] cpufreq/amd-pstate: Show a warning when a CPU fails
 to setup
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250206215659.3350066-1-superm1@kernel.org>
 <20250206215659.3350066-2-superm1@kernel.org>
 <c7b4e115-91b6-4964-ad4a-58e8924997a3@amd.com>
 <Z6oELkyt+XEMp/nk@BLRRASHENOY1.amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <Z6oELkyt+XEMp/nk@BLRRASHENOY1.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/10/2025 07:50, Gautham R. Shenoy wrote:
> On Mon, Feb 10, 2025 at 05:29:24PM +0530, Dhananjay Ugwekar wrote:
>> On 2/7/2025 3:26 AM, Mario Limonciello wrote:
>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>
>>> I came across a system that MSR_AMD_CPPC_CAP1 for some CPUs isn't
>>> populated.  This is an unexpected behavior that is most likely a
>>> BIOS bug. In the event it happens I'd like users to report bugs
>>> to properly root cause and get this fixed.
>>
>> I'm okay with this patch, but I see a similar pr_debug in caller cpufreq_online(),
>> so not sure if this is strictly necessary.
>>
>> 1402                 /*
>> 1403                  * Call driver. From then on the cpufreq must be able
>> 1404                  * to accept all calls to ->verify and ->setpolicy for this CPU.
>> 1405                  */
>> 1406                 ret = cpufreq_driver->init(policy);
>> 1407                 if (ret) {
>> 1408                         pr_debug("%s: %d: initialization failed\n", __func__,
>> 1409                                  __LINE__);
>> 1410                         goto out_free_policy;
>> 1411
>>
> 
> Well, the pr_debug() doesn't always get printed unless the loglevel is
> set to debug, which is usually done by the developers and not the end
> users.
> 
> However you have a point that since the code jumps to free_cpudata1 on
> failures from amd_pstate_init_perf(), amd_pstate_init_freq(),
> amd_pstate_init_boost_support(), freq_qos_add_request(). So the
> pr_warn() doesn't indicate that the failure is due to
> MSR_AMD_CPPC_CAP1 not being populated.
> 

Right; my point is that without the warning no one knows there is a problem.

I don't expect we can anticipate all the potential causes, and I want 
anyone who hits this to raise a bug and we can ask them to turn on 
dynamic debug / ftrace and then triage it.

