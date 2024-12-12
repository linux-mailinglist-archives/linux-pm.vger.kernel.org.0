Return-Path: <linux-pm+bounces-19123-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 868529EE658
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 13:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60570160E4D
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 12:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CEC211A1E;
	Thu, 12 Dec 2024 12:09:44 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DD7259495;
	Thu, 12 Dec 2024 12:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734005384; cv=none; b=eIOYeW6bE/ky/EDdYtwVJ6hB1TePifMG3Ig4gxjgppWQhxKA0tRJtnjQMiw9fJUUhCnN/MWfCj4AnKTTI+08YqR3DGltcnNKkjR2cg+VLe+U1SV7bL5dOTbUOhT3l+pQqkIN6ECRS3dbsAjSZI/1sXn6L8As09+pLf+aBOX3ue4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734005384; c=relaxed/simple;
	bh=XF4noY+86Jp0DsYD/q3KZwDyyRyJQ4sWwBl4yWo4NwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b6Mm8jLh0Hz3qYiccbcnwvEKpt6xi6i5s04qpvf0InaN8MGSooojjTyfI6j7M4LxpOihquNWebx1mWgkHzWJDgZlOewhW97kHMR1UQntmo5iO4e3HnXkshMuVYanQabT6o11UQtDbIJxEtaw921u5ziYA0pGFC4DBfVkOfbU7XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EEA9153B;
	Thu, 12 Dec 2024 04:10:08 -0800 (PST)
Received: from [10.1.37.59] (e127648.arm.com [10.1.37.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A01EC3F720;
	Thu, 12 Dec 2024 04:09:38 -0800 (PST)
Message-ID: <097bee29-64b5-444d-a3ae-81c2dcc35ae7@arm.com>
Date: Thu, 12 Dec 2024 12:09:36 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PM: EM: Move sched domains rebuild function from
 schedutil to EM
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Pierre Gondois <pierre.gondois@arm.com>
References: <4977135.31r3eYUQgx@rjwysocki.net>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <4977135.31r3eYUQgx@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/12/24 12:01, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Function sugov_eas_rebuild_sd() defined in the schedutil cpufreq governor
> implements generic functionality that may be useful in other places.  In
> particular, there is a plan to use it in the intel_pstate driver in the
> future.
> 
> For this reason, move it from schedutil to the energy model code and
> rename it to em_rebuild_sched_domains().
> 
> This also helps to get rid of some #ifdeffery in schedutil which is a
> plus.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

As already mentioned during the RFC, fine with me FWIW.
Reviewed-by: Christian Loehle <christian.loehle@arm.com>

