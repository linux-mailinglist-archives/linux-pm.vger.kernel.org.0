Return-Path: <linux-pm+bounces-23554-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EA4A5472F
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 11:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618A218828E5
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 10:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DEBB667;
	Thu,  6 Mar 2025 10:01:57 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A31B2E338B;
	Thu,  6 Mar 2025 10:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741255317; cv=none; b=DFXURjnDWpOMfTMDLlZrWFIoNB5uJwmgTxe68CtEKrn3GqvXOtxCGye4zCpHITIhGMgQOCCNduPSSe4D7Iw60zYDeQ0KcTl5m4MPyBLoKQmsI5j9LlJfGXAko6KXptWWLa552qbiSVl5M/t3R8/dsdphRwgJBmt+Lowcu9ioHLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741255317; c=relaxed/simple;
	bh=OM/PqgpSw5i4ZZTUdcO8OMaoy9EaM6pQ0v011OXekus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IwxqRhFFei3jRX3rUlSl0/SHn7RySbhXNrzt+l/fnZLRLiyZcPnQQAOdm0/hjHA5hx9CpMoc5AOh2Cyk8eRs+tGkKd41UMh/6QqbjEU3F2H/WtccuvB240AM/6vF0V1n/3zqvsoDr2hl3FJu1RGlizCpinH4DLe3iQNc3HhrBEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99F05FEC;
	Thu,  6 Mar 2025 02:02:07 -0800 (PST)
Received: from [10.57.83.26] (unknown [10.57.83.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F7C83F66E;
	Thu,  6 Mar 2025 02:01:53 -0800 (PST)
Message-ID: <92699eb4-8495-4ccd-a9dc-120b14271f9d@arm.com>
Date: Thu, 6 Mar 2025 10:01:51 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] PM: EM: Make three functions static
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
References: <5880743.DvuYhMxLoT@rjwysocki.net>
 <1929404.tdWV9SEqCh@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <1929404.tdWV9SEqCh@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

On 3/5/25 21:11, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Three functions in the Energy Model code, em_dev_update_perf_domain(),
> em_table_alloc() and em_table_free(), have no users outside that code and
> so make them static, remove their headers from the Energy Model header
> file and remove a piece of documentation associated with them.
> 
> This also helps to clean up RCU handling in the Energy Model code that
> will be done subsequently.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This essentially follow the rules that all functions without users in the
> files where they are defined should be static (with all due respect to any
> out-of-the-tree users of them).
> 
> This change can be reversed when any new users of these functions appear,
> but it will have to take changes made by the subsequent patch into account.
> 

I see your point and it's valid.

Although, please give me a few days and I will send some patches which
add a client for this API. It will be a modification of the EM for
CPUs while the GPU is producing heat to the SoC. Then IPA and EAS
will get the updated total power values (doe to this this leakage power)
in the EM.

As of now, I had some code downstream for research, that I share with
partners in the Android world [1].
I believe the user-space sysfs (like in that top patch) which allows
such EM modification would not be accepted?
Such approach might also help the Middle-ware in the OS to influence the
kernel decisions, mainly on phones, where the app just occupies the
screen and Middle-ware knows about it.

Regards,
Lukasz

[1] 
https://gitlab.arm.com/linux-arm/linux-power/-/commits/dynamic_energy_model/android14-v6.1/v6.1.75/?ref_type=heads

