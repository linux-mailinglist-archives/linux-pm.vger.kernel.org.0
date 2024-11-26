Return-Path: <linux-pm+bounces-18122-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B33F49D96F3
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2024 13:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70B57B292D7
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2024 11:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747531CF2A0;
	Tue, 26 Nov 2024 11:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TuVxpSyy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC88D1CEE80;
	Tue, 26 Nov 2024 11:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732622171; cv=none; b=AWqVJdfoXiVaQBaR4OylGFeSfGtg5GywmDIB5guh0l3T8CslbQbJzQr/YPVktzzJ3eLQSjvDfUXTjvi0ZtEqcAbAHUYk0fQk5yh9wfpDnySGWwZK+45WrkA9UmBSnUaZXLRMDy59idj7/jtxEWcktD1ExqvuqsOa2EqXmzlwkDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732622171; c=relaxed/simple;
	bh=8wxOar+08JuPXTzblHvb6fZNGENcenr7quB3bqJJv0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jOgPdKZD8cl31TydJbb6vyV7ousBk8vrEnq3N8JhPgB+2Vapd3zTWg6N503nRVhCiUg8gmRjP0phNx+OpvmuyZnr799P+JratEkoPbfAWgmwc7rFsHeIjA/K6gINpJEGPSxdf5zATKWtRgeQqU7HZz8I8Tz1nMVsUoinPhodg8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TuVxpSyy; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732622170; x=1764158170;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8wxOar+08JuPXTzblHvb6fZNGENcenr7quB3bqJJv0Q=;
  b=TuVxpSyyQgurwN3J7Kqn6f2ZN6knSlOwO8kFqphpZCIiPP22LM3pTdPM
   oqY1H0nBPCvOTo8Ra2kE/y7D+Or4eM8KJgM5UAxSLM+vK4VSKH/m+gV1u
   sAIynEmcouIYdbnNkyPIxKUsb6sqveNApntmqu1SyW80EkoeDmGpfYjBw
   GZe73KH9glmN0n+CWOqkpS0Y3mjJA1/55nCHulDLIffph9dVOn1QYMNou
   LkxjskcXWP9dL8YaRZw9Cuq0wYsm6HlAhNMulQVsvSDZ3mFfJHfoZbsq/
   oBuZwgYh3q00g5CmaQhcpjDRexaLdfU38jpAz73l3TNSMsAKni9zAOx7J
   Q==;
X-CSE-ConnectionGUID: ahtJqZ4MRtqYRaDoLfy6rQ==
X-CSE-MsgGUID: dIvRqH/NRkGz17RFf+4LWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="32519890"
X-IronPort-AV: E=Sophos;i="6.12,185,1728975600"; 
   d="scan'208";a="32519890"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 03:56:09 -0800
X-CSE-ConnectionGUID: fz6v3ZffRH2pdALgDMUqKw==
X-CSE-MsgGUID: xkkhygMeQ2WaDKrsm9+Iug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,185,1728975600"; 
   d="scan'208";a="92058991"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO [10.245.245.172]) ([10.245.245.172])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 03:56:06 -0800
Message-ID: <a8d53d86-d658-4e18-bfd6-b37a2656b180@linux.intel.com>
Date: Tue, 26 Nov 2024 12:56:01 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 5/8] x86/smp native_play_dead: Prefer
 cpuidle_play_dead() over mwait_play_dead()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael.j.wysocki@intel.com, len.brown@intel.com,
 artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com,
 peterz@infradead.org, tglx@linutronix.de, gautham.shenoy@amd.com
References: <20241125132029.7241-1-patryk.wlazlyn@linux.intel.com>
 <20241125132029.7241-6-patryk.wlazlyn@linux.intel.com>
 <CAJZ5v0iJ7hca68Pk1g1m=FNX6Psr3Ow-K7fvXZCcRM8PFM7EjQ@mail.gmail.com>
 <883447da-aeca-41ba-99ef-038dd8ddc6b3@linux.intel.com>
 <CAJZ5v0hZ8ajccb=B7P5g1+KJ+tsw5vP-e9ix7j_65WgT34H1XQ@mail.gmail.com>
Content-Language: en-US
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
In-Reply-To: <CAJZ5v0hZ8ajccb=B7P5g1+KJ+tsw5vP-e9ix7j_65WgT34H1XQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

>>> If you first make intel_idle provide :enter_dead() for all CPUs on all
>>> platforms and implement it by calling mwait_play_dead_with_hint(), you
>>> won't need mwait_play_dead() any more.
>> Crossed my mind, but because mwait_play_dead doesn't filter on Intel
>> vendor specifically,
>
> In practice, it does.
>
> The vendor check in it is equivalent to "if Intel".

Actually, what about INTEL_IDLE=n?
We might hit acpi_idle, which would call mwait_play_dead_with_hint() now, but
if we don't, don't we want to try mwait_play_dead before hlt or is it too
unrealistic to happen?



