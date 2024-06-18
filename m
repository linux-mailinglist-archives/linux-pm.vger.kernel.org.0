Return-Path: <linux-pm+bounces-9436-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDB790CF89
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 15:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 790E81F21448
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 13:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8350014EC51;
	Tue, 18 Jun 2024 12:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWiZYPGY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF4314C5B5;
	Tue, 18 Jun 2024 12:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714958; cv=none; b=e+CaphvEyfYXnqXgD+cttOq73FsZdtZ1+uI9i0YVNHcc65cfA0J53+1kgSlBIHRazum6Ysr5Ovi1NqOzpki9NF63y66wAHPAguIcnS7tzwMeXJsbU1Pe1LJ9cb5+AEejiqMYRQp/DBcJz86VqM1H37PSf9cYtCIOgdhLlA4Ykv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714958; c=relaxed/simple;
	bh=4VhvBr7Wg/7G3Jr6+g/s22i5535HMilESlb5EOVncww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VCc0/c0Z/E954P/xDh233BRo3z1GbfXxUNSCYmj6vcLl9DClsoDUZay1JGuZrXV4BHG0ryCLvpW9xi9wSOZ7pc9HosjlK8vGy34EaPq94oV1iTO0F7LtdU/ec92qK5GfGo8p2r1pDT+vYYR5E4Ij1ueW2NtfSYioSWY9iv2iFNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWiZYPGY; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5295e488248so5940400e87.2;
        Tue, 18 Jun 2024 05:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718714955; x=1719319755; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2sXcETfbHlUWfisUUTj4CxNKCJIy4cebBQ7DHfUnh8U=;
        b=cWiZYPGYotLQVdSV44h4iwtpvWBOEBBJ0iqcydKBRN0BUO5PIj/uenL6T24Z5+hlvy
         u7r5JlJprgvqLuKcLOkhH3OhgarVGjdjmC6oAXdpOE7ltv454Z+THUQ6D+28aq6ZcJ4h
         5/A2UnCa5jAlVakSTr7Arh8uId5YGsYNFf+FDNrtc3QbP7Ukco5VA5sxmuakAqtyTiZB
         mL1EmS1yaiTj1YwEStkGf4j5y/PeH7mkio3kD4qjonbEBYQhpYG83qj/m1/JWF+5X8zz
         DNpzuF3wBFwYA+XNMVWYeenDaETwcKiKVViWpBRr8/VS3jmcSm+jHmUp7nKiBflOqJPq
         2IZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718714955; x=1719319755;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2sXcETfbHlUWfisUUTj4CxNKCJIy4cebBQ7DHfUnh8U=;
        b=a2TqSq2ytBun82XvPFm80eKvK/8gRUXYmt4ps9mjVvVdu9Nw+wqTu0jQn5G3aeHJ24
         j/jGtLZ4cg1bgBLLqV8tk8W34if/rHmeolFCH91pWCGJM/RWrVQ+lEgdiMGbRhy8/a8U
         atBM70kgJItbOY35odmf35t4X/kCgn5MkMHXhkX/vPjFkRoZvf+TzUlKtNQatia94lCV
         GrkxQZRwfz09DBkEh3voaGZyCMaYWEC9JcNrLufFstZlV1Fq3ET9Ay905CzIMCl7kv6G
         4wiZZOIvRq5wxmHtYSQhyBEE2ufVYAvIIDHkj8Fh5ie3tSSwVhSPIq/MuSOwUIyf2KLf
         gccA==
X-Forwarded-Encrypted: i=1; AJvYcCXVwYRbAkD1s0BS7GMbBwPkV1fmY1KpWlj0vJjhrf/d/FYwYvFYhgnITKjrp++g/MA0LUvJbNDzyk1HSRBHwkb1g2Su4l6zOItJT/xW0xsDe7CrHj5UUIBUeLiqOldEoTRpu3JQ6znIOGJJZ+S2bClLyHXEHrY1GtvHNO+PHEDEucke5bn2NHo8
X-Gm-Message-State: AOJu0YzADQ2fbqz8Ju36cXWn51K83mYsBLB54vG6BYCNGys3KRu2Bb+a
	Wv1+iWkW+5+zCjWhiOw1twCaLGcDrcCNnyPObx4OKR40N2g+q5kG
X-Google-Smtp-Source: AGHT+IE9w4ry/QbXHWhMJuXWgGLSRBogwWxoMLLzS2ARV8udDGzJ2qhBtUyqMZQvjogK7z5+J9SxIw==
X-Received: by 2002:ac2:46e3:0:b0:52b:7d16:2c7a with SMTP id 2adb3069b0e04-52ca6e55d4bmr8257740e87.3.1718714954496;
        Tue, 18 Jun 2024 05:49:14 -0700 (PDT)
Received: from ?IPV6:2001:660:6102:320:d6c5:cc21:7a1a:7498? ([2001:660:6102:320:d6c5:cc21:7a1a:7498])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42471584306sm8662155e9.0.2024.06.18.05.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 05:49:14 -0700 (PDT)
Message-ID: <8d757ea3-87a3-4663-ac76-66b04e33e6b3@gmail.com>
Date: Tue, 18 Jun 2024 14:49:10 +0200
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
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Cc: daniel.sneddon@linux.intel.com, tony.luck@intel.com,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>
References: <20240617-add-cpu-type-v1-0-b88998c01e76@linux.intel.com>
From: Brice Goglin <brice.goglin@gmail.com>
In-Reply-To: <20240617-add-cpu-type-v1-0-b88998c01e76@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 17/06/2024 à 11:11, Pawan Gupta a écrit :
> Hi,
>
> This series adds support for CPU-type (CPUID.1A.EAX[31-24] on Intel) to
> differentiate between hybrid variants P+E, P-only, E-only that share the
> same Family/Model/Stepping. One of the use case for CPU-type is the
> affected CPU table for CPU vulnerabilities, which can now use the CPU-type
> to filter the unaffected variants.
>
> * Patch 1 adds cpu-type to CPU topology structure and introduces
>    topology_cpu_type() to get the CPU-type.
>
> * Patch 2-4 replaces usages of get_this_hybrid_cpu_type() with
>    topology_cpu_type().
>
> * Patch 5-7 Updates CPU-matching infrastructure to use CPU-type.
>
> * Patch 8 cleans up the affected CPU list.
>
> * Patch 9 uses the CPU-type to exclude P-only parts from the RFDS affected
>    list.


Hello

Is there still a plan to expose this info in sysfs? Userspace currently 
uses frequencies to guess which cores are E or P. Intel sent some 
patches several years ago [1], but they got abandoned nowhere as far as 
I know. There was also some discussion about using a "capacity" field 
like ARM does, but IIRC Intel didn't like the idea in the end.

Thanks

Brice

[1] https://lkml.org/lkml/2020/10/2/1208


