Return-Path: <linux-pm+bounces-19299-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F20F9F2EA6
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 11:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BACAC188409A
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 10:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E806203D77;
	Mon, 16 Dec 2024 10:59:27 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD38203D6B;
	Mon, 16 Dec 2024 10:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734346767; cv=none; b=C7bhmvk3zYbOHbfttCjb5w0vbjx4PEzSr4y/g2eV6Sr+PPwvTiKkkB130tn5/yDBnq1X2WVEI814v1m/I9YnmoJ6tbF20FHSAN/fJ61J6YaKcXSWFUSGrf4jEmYaLmdZKSez5jJYHz+446j3ixbhKte6irYQ57qBYFZR/wr/SRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734346767; c=relaxed/simple;
	bh=X+V49qqdFzL++0KpFU/EhwFPE2ZCQxxAN/9AR+s1Exk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HtNMjIviVPVMEs87KO/IJF7DnjajKsZaYWRbFQhlqggrRd7/126Y1q+umJVVg2L6B/1ZyUT/m5Ooa9XFCyfD0lzrM/HF32ZN/Wfz+eHvllfJ4cKEEAfchN/yhZlIkBIJ3sAyNF0hdqag8rhb8N/Wd0FVUDnjxY4ZpGqYZalMK+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 192D3113E;
	Mon, 16 Dec 2024 02:59:53 -0800 (PST)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B5843F720;
	Mon, 16 Dec 2024 02:59:23 -0800 (PST)
Message-ID: <a345f7a1-52f0-476e-b2ca-7e229e957d46@arm.com>
Date: Mon, 16 Dec 2024 11:59:16 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v021 7/9] PM: EM: Register perf domains with ho
 :active_power() callbacks
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Pierre Gondois <pierre.gondois@arm.com>
References: <5861970.DvuYhMxLoT@rjwysocki.net>
 <3278518.5fSG56mABF@rjwysocki.net>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <3278518.5fSG56mABF@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/11/2024 17:15, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In Subject:

with ho :active_power() - without ?
^^^^^^^

[...]

> @@ -594,7 +599,19 @@ int em_dev_register_perf_domain(struct d
>  			 * All CPUs of a domain must have the same
>  			 * micro-architecture since they all share the same
>  			 * table.
> +			 *
> +			 * If the :active_power() callback is present, the
> +			 * performance values for different states in the table
> +			 * computed by em_create_perf_table() depend on the CPU
> +			 * capacity which therefore must be the same for all
> +			 * CPUs in the domain.  However, if the :active_power()
> +			 * callback is not NULL, em_create_perf_table() doesn't

s/is not NULL/is NULL ?

[...]

