Return-Path: <linux-pm+bounces-17534-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 526CB9C8472
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 09:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B939DB25F09
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 08:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6B01F6691;
	Thu, 14 Nov 2024 08:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o2Mmyh8v"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926F61F584D
	for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2024 08:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731571261; cv=none; b=vGETEdbhipXTMa+DIFBgU08eEtscBNrT4oTThBvR2kNA68nNs0LQo5ckTinVsPSpzrupIe/UA6qQoE/C9w7+sqmgLwpOu4zGa4w4LLsJbC37pKQ8rIao5WW5LlYPUhRlNz5FLTQGv13Cr91HwUNlgwqwG0b+WSGTurECGxFEaLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731571261; c=relaxed/simple;
	bh=wOCWjPgHPHxlrLgnxw+VusgzvGF9XhbpJDgq//4tRjo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=goM5L1wgKZZzikI0ZMAyxdNzU9krhOPzRY/xrf5KMBWntV7ADjFsVuU3jMkQ/ZgWp0Nueo3IyuKa3DQNYnrcigwWIiDKUUCeW1+XIzSDUof3C1FNE3vKY2axGZZS5AvVJC9kAbhZU/d8bsMeDpsxYtgbq8WUdsCBp62Aa00l08o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o2Mmyh8v; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d5aedd177so213543f8f.1
        for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2024 00:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731571258; x=1732176058; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pmP4R+KTmabCCg4llADCF0oCU+tvvoVH1i02bViR8w0=;
        b=o2Mmyh8vFK1GVoLfz/wlS/zxojNrKNkVIR37FOtgdRKL/Dd1lHBgZ20Y79jGB47CBu
         zwG3o0FH/2P5I5/AgwgE/SmvBtL5Dw5vSw1e2KLekXA2zS8URyOd/vPtO7//lDIW/5/+
         jQgD+IIsfRUswDvDA1BtCtRugxLqh2BdVJ+t4vc5OUSRweexJNHTW64/pr1v+05ewSUk
         HDpH0PPLOOfYAeDsnKANExDRqieWFDQ567AFwykP1cLFJtGTQ2FXmtn4CmDDzotmOIVj
         mLyVUu3nlDp9aAeVgLde9UmLZ0oWO4dTNAbh1P0PmhL+o5ki4zdlhV/0U3MWGZ/z+k3l
         orzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731571258; x=1732176058;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pmP4R+KTmabCCg4llADCF0oCU+tvvoVH1i02bViR8w0=;
        b=kcXtTQHMT91uTC2Q7kohgyU2RfLD9mNPbaKIe/bcDxmRJRscZ3OHaWlSSPCjR7orTy
         s4fyVuLuAa8umttVBw9gESnlXrvgoGlpkBZH8VQOsEhgfoBaoMmeJAT5NmhtsWAysEX4
         ARFxupBuwcTI0KTT8MfTftFjIVoFbHtJSkAP430U+aSDdqQR+sfepuQtXLwQqSLgrWxW
         JUdHCCaLs1iJKjR8Z6rvIU3xFpjjYS1O0CB7OQIFNqYCvqadRRwFbi4P5GkP1zjPH/BI
         5NeEENb1A+D1noXXoS4cdmhgTQdaVzgWHVTomBoyMMyX2fA4tLrL0iNYKuKy0tyJH2VX
         rTbA==
X-Forwarded-Encrypted: i=1; AJvYcCWCfnfw73QWXRHTeGA+sx80jQxasZSu84s485fw505WokJVTaLeD+mSx8kwEFOuV2bzPSgiguSZsw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhAMGoLFgySRcLsrxFjIaxCne49ACvKahwxj/b6m0qxmh2IBny
	R82Vdf2VQ8lb+AF7NT2dQrovYzg6MHelVdiXzvJXSD8kvrEAhkr9WUYwVMLsQ44=
X-Google-Smtp-Source: AGHT+IG31WYQ/X+72unRx69C1P/9iMZOs5trq1EXzJAGNdrj+lIds7pAsY6/bw5o7AELpMO6q2+fpA==
X-Received: by 2002:a5d:47ac:0:b0:37d:5282:1339 with SMTP id ffacd0b85a97d-3820df6136cmr4676316f8f.22.1731571257780;
        Thu, 14 Nov 2024 00:00:57 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821adae022sm748412f8f.44.2024.11.14.00.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 00:00:57 -0800 (PST)
Date: Thu, 14 Nov 2024 11:00:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-acpi@vger.kernel.org, devel@acpica.org,
	linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge 447/448] drivers/thermal/testing/zone.c:333
 tt_zone_add_trip() error: uninitialized symbol 'tt_zone'.
Message-ID: <d8da45d7-0a98-41c9-a9a8-49043caaa7af@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   d1bf954af846f66ac2ea07b2457b4a089a009c08
commit: 498ea32432db6f2a0bce88fd521e529a58a370c4 [447/448] thermal: testing: Use DEFINE_FREE() and __free() to simplify code
config: x86_64-randconfig-161-20241113 (https://download.01.org/0day-ci/archive/20241114/202411140825.w4TfKdbS-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202411140825.w4TfKdbS-lkp@intel.com/

New smatch warnings:
drivers/thermal/testing/zone.c:333 tt_zone_add_trip() error: uninitialized symbol 'tt_zone'.
drivers/thermal/testing/zone.c:333 tt_zone_add_trip() error: uninitialized symbol 'tt_zone'.

Old smatch warnings:
drivers/thermal/testing/zone.c:188 tt_add_tz() error: uninitialized symbol 'tt_work'.
drivers/thermal/testing/zone.c:240 tt_del_tz() error: uninitialized symbol 'tt_work'.
drivers/thermal/testing/zone.c:335 tt_zone_add_trip() error: uninitialized symbol 'tt_trip'.
drivers/thermal/testing/zone.c:390 tt_zone_register_tz() error: uninitialized symbol 'trips'.

vim +/tt_zone +333 drivers/thermal/testing/zone.c

f6a034f2df426e Rafael J. Wysocki 2024-08-22  331  int tt_zone_add_trip(const char *arg)
f6a034f2df426e Rafael J. Wysocki 2024-08-22  332  {
498ea32432db6f Rafael J. Wysocki 2024-11-10 @333  	struct tt_thermal_zone *tt_zone __free(put_tt_zone);

These __free() pointers need to be initialized to NULL otherwise it leads to an
uninitialized variable when we return before they're assigned.

f6a034f2df426e Rafael J. Wysocki 2024-08-22  334  	struct tt_work *tt_work __free(kfree);
f6a034f2df426e Rafael J. Wysocki 2024-08-22  335  	struct tt_trip *tt_trip __free(kfree);
f6a034f2df426e Rafael J. Wysocki 2024-08-22  336  	int id;
f6a034f2df426e Rafael J. Wysocki 2024-08-22  337  
f6a034f2df426e Rafael J. Wysocki 2024-08-22  338  	tt_work = kzalloc(sizeof(*tt_work), GFP_KERNEL);
f6a034f2df426e Rafael J. Wysocki 2024-08-22  339  	if (!tt_work)
f6a034f2df426e Rafael J. Wysocki 2024-08-22  340  		return -ENOMEM;
f6a034f2df426e Rafael J. Wysocki 2024-08-22  341  
f6a034f2df426e Rafael J. Wysocki 2024-08-22  342  	tt_trip = kzalloc(sizeof(*tt_trip), GFP_KERNEL);
f6a034f2df426e Rafael J. Wysocki 2024-08-22  343  	if (!tt_trip)
f6a034f2df426e Rafael J. Wysocki 2024-08-22  344  		return -ENOMEM;
f6a034f2df426e Rafael J. Wysocki 2024-08-22  345  
f6a034f2df426e Rafael J. Wysocki 2024-08-22  346  	tt_zone = tt_get_tt_zone(arg);
f6a034f2df426e Rafael J. Wysocki 2024-08-22  347  	if (IS_ERR(tt_zone))
f6a034f2df426e Rafael J. Wysocki 2024-08-22  348  		return PTR_ERR(tt_zone);
f6a034f2df426e Rafael J. Wysocki 2024-08-22  349  
f6a034f2df426e Rafael J. Wysocki 2024-08-22  350  	id = ida_alloc(&tt_zone->ida, GFP_KERNEL);
498ea32432db6f Rafael J. Wysocki 2024-11-10  351  	if (id < 0)
f6a034f2df426e Rafael J. Wysocki 2024-08-22  352  		return id;
f6a034f2df426e Rafael J. Wysocki 2024-08-22  353  
f6a034f2df426e Rafael J. Wysocki 2024-08-22  354  	tt_trip->trip.type = THERMAL_TRIP_ACTIVE;
f6a034f2df426e Rafael J. Wysocki 2024-08-22  355  	tt_trip->trip.temperature = THERMAL_TEMP_INVALID;
f6a034f2df426e Rafael J. Wysocki 2024-08-22  356  	tt_trip->trip.flags = THERMAL_TRIP_FLAG_RW;
f6a034f2df426e Rafael J. Wysocki 2024-08-22  357  	tt_trip->id = id;
f6a034f2df426e Rafael J. Wysocki 2024-08-22  358  
f6a034f2df426e Rafael J. Wysocki 2024-08-22  359  	guard(tt_zone)(tt_zone);
f6a034f2df426e Rafael J. Wysocki 2024-08-22  360  
f6a034f2df426e Rafael J. Wysocki 2024-08-22  361  	list_add_tail(&tt_trip->list_node, &tt_zone->trips);
f6a034f2df426e Rafael J. Wysocki 2024-08-22  362  	tt_zone->num_trips++;
f6a034f2df426e Rafael J. Wysocki 2024-08-22  363  
f6a034f2df426e Rafael J. Wysocki 2024-08-22  364  	INIT_WORK(&tt_work->work, tt_zone_add_trip_work_fn);
498ea32432db6f Rafael J. Wysocki 2024-11-10  365  	tt_work->tt_zone = no_free_ptr(tt_zone);
f6a034f2df426e Rafael J. Wysocki 2024-08-22  366  	tt_work->tt_trip = no_free_ptr(tt_trip);
f6a034f2df426e Rafael J. Wysocki 2024-08-22  367  	schedule_work(&(no_free_ptr(tt_work)->work));
f6a034f2df426e Rafael J. Wysocki 2024-08-22  368  
f6a034f2df426e Rafael J. Wysocki 2024-08-22  369  	return 0;
f6a034f2df426e Rafael J. Wysocki 2024-08-22  370  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


