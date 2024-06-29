Return-Path: <linux-pm+bounces-10236-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F59E91CC6D
	for <lists+linux-pm@lfdr.de>; Sat, 29 Jun 2024 13:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC28DB20F31
	for <lists+linux-pm@lfdr.de>; Sat, 29 Jun 2024 11:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE954D9FB;
	Sat, 29 Jun 2024 11:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BR8OKA9W"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86ECB1CF8D;
	Sat, 29 Jun 2024 11:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719661061; cv=none; b=OeTcshOyTDB0tXuXylGXxxNGQQAd3P3oxf+pc4fZGGgq9HSNK/jAZBbJsczLpRSVrj6X0fwgw9NvX/jkX/fNNI077WyJxwvwANn+iBSPmq643oI2XEKSNOMxaXv2cBA4+WocKditV8L/O+9R9patsIufWU3uoWaDhcYet4rVDBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719661061; c=relaxed/simple;
	bh=X3OrdE8tHEuRIWkpN7xz4H2ZmRwU5x8R8N0n2ExI1bI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PDwFo8REtkR2E71iN8VKsOH/5l8WTqlj/NpXMhj1hq6Vefk2mQIASz6pTIJqWJGLWUYuFCcJ5GDP5cBVGpdFebBJEQPeyxkAKTAplsyu2U9ClpF642XtOJWrjEp8uGfvpqHAIS8gmN2XxnWh8pRMsPI60CCNbBEdjTGhwGNlpW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BR8OKA9W; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ec1ac1aed2so16678911fa.3;
        Sat, 29 Jun 2024 04:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719661057; x=1720265857; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pe16ihnWpmSMGbSmw9G4cWVv0LJ235vBSc4jGfcKa3U=;
        b=BR8OKA9Wn8RwfdO9yMKe40tdshRawtEVvoLu5XwQ8ouncXlUkwRDsvAdAxw6Sa1xNB
         aOdrw0NfXVPZZUVp7ip5VJeuWjU2oQMlElDI3XkOC+OdyqblklG4qYx8mvE212PYgPNa
         VX+iqIxrgDnzVO6ql5sVBTKLvsG4k5w6jIbIY5M1vBWrHVIuuXamSWDhRGmY2Yy+itxh
         jvBwg8ufTiZgvYcxDWo0OzZmBCY8nJQFpZWUVHWayoDapMV5W2DESuYwEGaAuwS6fO6C
         33PUXTM4+am0Kw2hvjZmcm56/E4VOwpOalb6KenZpF/lf6H60C+w4RuRb0F/K/3Oq07j
         O/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719661057; x=1720265857;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pe16ihnWpmSMGbSmw9G4cWVv0LJ235vBSc4jGfcKa3U=;
        b=UusKmeHC9Jw7o0VLkuEbPcgkpylx4w0sFqr8VbGEuLU32qe8t011mTIyyBuY4w/X28
         PYl/sd0GnwUZ9VxRZzFPV+zWlpla0RQtmCoQoV7+45FJ+jszfteN9+Wy4Whr5VLORE3r
         CqSrw3bUs3PyiPl5wKFifwzzWnpXYxqUEQcW7KbOBnJcqOyM54EaV3y8D1EuyOlPhl6M
         xzeMhvjoGdaN7+wg5N7mvs7rVm/l5N1M4FisSRnVulVJ6dArmuvLf/H9koG4oNkxIEcG
         eqeGAs8Rd2/9bdd4k2AjLI56LhqH3biRWIvYpyscaZ2x+kL4JPaenrJpP7P7qypBcofO
         bTHg==
X-Forwarded-Encrypted: i=1; AJvYcCUcrFLa2SVSyAyRdJasNC16jsoMJ4wPJ0iCNC3fE6+/5r9LruRlCtI1Zhgy5vF51Fe2yPSvLZsMZVq1Yw8cKwrwxahXdzs/+Ox8XS5WugxclQQ9tm4LTI/FX0suK6I33FtMYyNLitALEp7EPJ+pzxfuP407G412bsq54xWJks8mYfsDrpK9H+1c
X-Gm-Message-State: AOJu0YxFWymAcbTyqjspBZlgChE9Dh4djQSiK4ZABTk79S8X920SofaL
	qA0n2oWrkMQSaR49wSvjX2fEP+6q1XPph4RRV8X4CdsZo8RHkSE9
X-Google-Smtp-Source: AGHT+IFGKhBFD51k/jFj+TSVOjeoBEuY+SNOHqIIFbh+FsMLCdjdpNgAQoKDVWkL6D/muRGn93iBsg==
X-Received: by 2002:a05:6512:1384:b0:52c:86d6:e8d7 with SMTP id 2adb3069b0e04-52e8264733dmr724753e87.13.1719661056922;
        Sat, 29 Jun 2024 04:37:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1:6960:9f76:b012:ddc2:11de? ([2a01:e0a:1:6960:9f76:b012:ddc2:11de])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af3c2afsm73856095e9.2.2024.06.29.04.37.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jun 2024 04:37:36 -0700 (PDT)
Message-ID: <f947c0f5-e94d-4aea-9e06-687b6f7eeae1@gmail.com>
Date: Sat, 29 Jun 2024 13:37:35 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] Add CPU-type to topology
Content-Language: en-US
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
 srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, daniel.sneddon@linux.intel.com, tony.luck@intel.com,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>
References: <20240617-add-cpu-type-v1-0-b88998c01e76@linux.intel.com>
 <8d757ea3-87a3-4663-ac76-66b04e33e6b3@gmail.com>
 <20240619015315.3ei5f6rovzdnxovo@desk>
 <bc75ff55161671e4470849ed51baa547f619889d.camel@linux.intel.com>
 <0021f5f2-67c5-4b20-939d-48c9c1c60cdb@gmail.com>
 <1b99017a-6964-46de-ba3a-09552e7cf072@intel.com>
 <20240627125154.GA4743@ranerica-svr.sc.intel.com>
 <20240627132230.hondzls5bt3jspay@desk>
From: Brice Goglin <brice.goglin@gmail.com>
In-Reply-To: <20240627132230.hondzls5bt3jspay@desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 27/06/2024 à 15:22, Pawan Gupta a écrit :
> On Thu, Jun 27, 2024 at 05:51:54AM -0700, Ricardo Neri wrote:
>> ARM gives userspace specific details. This makes more sense to me. Instead
>> of reading these details, user space would have to infer these details if
>> a CPU type was given in sysfs.
>>
>> Having said that, Intel does have a CPUID leaf that gives the CPU type. Such
>> leaf also has a "Native Model ID". Exposing only the CPU type may not be
>> sufficient.
> Do we know if there are applications that would benefit from this information?


There are HPC users who want a homogeneous set of cores, ie only P-core, 
or only E-core without the low power ones (because they don't want some 
imbalance between task speed in homogeneous parallel jobs). I've 
received requests from hwloc users running small parallel jobs on their 
desktop/laptop machines, and also from developers of big apps who want 
to debug on their laptop without heterogeneous cores creating imbalance 
that don't exist on servers.

They don't care much about the actual hardware details so far, they 
mostly want an ordered list of set of homogeneous cores (ordered from 
performance -> low-energy).

Brice



