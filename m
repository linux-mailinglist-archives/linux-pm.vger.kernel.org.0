Return-Path: <linux-pm+bounces-21009-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B682A20936
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2025 12:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF2AE1887FC8
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2025 11:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4983019B3EE;
	Tue, 28 Jan 2025 11:06:07 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCA278C91;
	Tue, 28 Jan 2025 11:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738062367; cv=none; b=nc5WFdkwIxaojwfbdvk+/6uuLFrvt4pVeU/YQPpUud/+5i0akGmOrDtGxoilkTcnSpOj6Hj0B5Bv5EEiQRfclqoWZsd1eFNxSIfBhi94TbMIEfBZchDz12wUB5b5nPMIi3NsMPtRr0wUSzJenSFivEE1uZq6bDJmEuzEm9hY0dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738062367; c=relaxed/simple;
	bh=f31PiioDsZwXI4/eOPQvgJcf+p5hRHNiD+lPfAlZ7TI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O46uEGEzW1T7rHeVCeYKJxM2Z9V01aNQ/5m0cat6rF7OhZRkpXusYx1KhfMb9CJywUr9NGE3LS6vHUnrh/q+4OnYjmGgMUBdX+Vzpb0jCDOtNQz42J3ApblllWMbO+IBepzyVMg/k6Enc2lcjYU7jCeh3KFIGNN6YFn8s70zCqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F576497;
	Tue, 28 Jan 2025 03:06:30 -0800 (PST)
Received: from [10.57.35.186] (unknown [10.57.35.186])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 520D43F694;
	Tue, 28 Jan 2025 03:06:02 -0800 (PST)
Message-ID: <f697970e-3796-41cb-9904-d61cbedec428@arm.com>
Date: Tue, 28 Jan 2025 11:06:00 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpuidle: psci: Add trace for PSCI domain idle
To: Keita Morisaki <keyz@google.com>
Cc: aarontian@google.com, daniel.lezcano@linaro.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, lpieralisi@kernel.org,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rafael@kernel.org,
 rostedt@goodmis.org, sudeep.holla@arm.com, yimingtseng@google.com
References: <31dd8c5d-0bc4-4d84-9ac9-7ca248e952cf@arm.com>
 <20250128042445.24920-1-keyz@google.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20250128042445.24920-1-keyz@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/28/25 04:24, Keita Morisaki wrote:
>>> The trace event cpu_idle provides insufficient information for debugging
>>> PSCI requests due to lacking access to determined PSCI domain idle
>>> states. The cpu_idle usually only shows -1, 0, or 1 regardless how many
>>> idle states the power domain has.
>>>
>>> Add new trace events namely psci_domain_idle_enter and
>>> psci_domain_idle_exit to trace enter and exit events with a determined
>>> idle state.
>>>
>>> These new trace events will help developers debug CPUidle issues on ARM
>>> systems using PSCI by providing more detailed information about the
>>> requested idle states.
>>>
>>> Signed-off-by: Keita Morisaki <keyz@google.com>
>>> ---
>>> v1->v2: Split the ftrace event into two (psci_domain_idle_(enter|exit))
>>> 		and rephrase the commit message accordingly. Rebased onto the latest.
>> Which makes it different to cpu_idle event FWIW.
> 
> Yes, psci_domain_idle_(enter|exit) are not meant to replace cpu_idle nor a
> variant of it. It's new and different events that provide finer=grained info.
> 

I mentioned it because it means it doesn't benefit from cpu_idle tooling
directly, which is slightly odd, but fine with me.


