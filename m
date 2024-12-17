Return-Path: <linux-pm+bounces-19395-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF8F9F5756
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 21:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F2471890A8A
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 20:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7491D89EC;
	Tue, 17 Dec 2024 20:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hCnncDr8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6C917BEA2;
	Tue, 17 Dec 2024 20:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734466184; cv=none; b=fNMvqFIffb4Kucb0m5KYI2sK69yCJwa5idA2rj8SzOQXSxR7yu7MP3aBB/iBfxxMYG/JatVkgccKB9LwjjjRAVy4FzLj7LRharadvJWHPXqfKDD3o/hYlKsM3g48NRGX7erPOepqO6WN5Ziyv8a3Kp35iajIXUVxrR+6WuvYwv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734466184; c=relaxed/simple;
	bh=XnwlUw/gpZFSSKHBLIVThgCuLR1wyOpGPa572pdtQtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ioijco2CCm0KqbCBRgfFSJZ3hDU8+XZub3Og4EQkA2KDG70D5yTzHbVcsnLgbIE5H+76GGDJHjXfKah4o6g0XpfXmQ6P4u7tSraMna2jYFiQFWagMNUmCleWuazTPaTW0G1CFXX8X4Vyqcu91mzkbHmuNhA/8QwZCESIcyXvIu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hCnncDr8; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734466183; x=1766002183;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XnwlUw/gpZFSSKHBLIVThgCuLR1wyOpGPa572pdtQtc=;
  b=hCnncDr8OtPkQihIVqF6S09yHRjrQtLx8pU+yg+wiu7aPFwZPW38x0A6
   uD3A4Enx6jI0FEv54of32SG1UQumW1lMAANfpm3PBOzuspy8S/Ea+BcEH
   /xRcV3qp5B55oMx6f9nY3qt63p430+8JUbQ/k+uvXZEq/G+/I9nKeej6d
   PtRpCeHRPIRCtGgt42/8h/yk1nYQ4sUK+a8i5PCEbahZzQdwreIgcwZxF
   A59wkQyXMkKH/ID8B16dTzipBZ2jZlM2nXl53PWP6cMkz/jtVuPbI8Hmi
   BSmOjKYHJQR0mt7TBrO4yR0Oc0z78vADRv1NyDotYrZ+EdgpB7kcY5RRA
   w==;
X-CSE-ConnectionGUID: Vl+cBmS1QymdhCdALyJLYw==
X-CSE-MsgGUID: CGzUTH+KSk2YFrdx93IuqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11289"; a="37748398"
X-IronPort-AV: E=Sophos;i="6.12,242,1728975600"; 
   d="scan'208";a="37748398"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 12:09:41 -0800
X-CSE-ConnectionGUID: JCBM9E23Sp6FlcFafqpyPw==
X-CSE-MsgGUID: +eFjPJGBSsGZEp4A1O4V+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="98081964"
Received: from ksztyber-mobl2.ger.corp.intel.com (HELO [10.245.244.6]) ([10.245.244.6])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 12:09:37 -0800
Message-ID: <2320a952-334d-4d52-a15a-669a5670df7d@linux.intel.com>
Date: Tue, 17 Dec 2024 21:09:27 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/4] x86/smp: Allow calling mwait_play_dead with an
 arbitrary hint
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael.j.wysocki@intel.com, peterz@infradead.org,
 dave.hansen@linux.intel.com, gautham.shenoy@amd.com, tglx@linutronix.de,
 len.brown@intel.com, artem.bityutskiy@linux.intel.com
References: <20241129182232.14987-1-patryk.wlazlyn@linux.intel.com>
 <20241129182232.14987-2-patryk.wlazlyn@linux.intel.com>
 <CAJZ5v0jhK51+pkf=Amr=qXWzK3e1xC_tdt0iqQXxVfeE4pcFJQ@mail.gmail.com>
Content-Language: en-US
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
In-Reply-To: <CAJZ5v0jhK51+pkf=Amr=qXWzK3e1xC_tdt0iqQXxVfeE4pcFJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> And honestly I'm wondering why adding a parameter to mwait_play_dead()
> is better than introducing mwait_play_dead_with_hint(), in analogy
> with the existing mwait_idle_with_hints()?
>
> The latter option would allow you to avoid introducing a function that
> is deleted in the same patch series (in patch 4).

We need to be able to call part of the old mwait_play_dead() code,
but without the hint calculation.

mwait_idle_with_hints() doesn't have the "kexec hack" logic.

We also need to leave the old code working and on top of that introduce
the acpi_idle and intel_idle patches that use the new API.

Now the old code is there and the new one. The only thing left is remove
the old code. I did it that way because of the comments earlier indicating
that I should not be breaking code in between.

Let me know if I answered your question or if I misunderstood something
now or earlier.

I'll apply your changelog suggestions when we agree on the implementation.


