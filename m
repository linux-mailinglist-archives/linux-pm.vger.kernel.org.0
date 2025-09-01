Return-Path: <linux-pm+bounces-33591-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59040B3F15D
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 01:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B27B48670E
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 23:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B15274671;
	Mon,  1 Sep 2025 23:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="do8P0G4b"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7C3BA4A;
	Mon,  1 Sep 2025 23:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756770770; cv=none; b=ed+NSPlNfWBYVCvoKKjO0WlJKqOi/cSlOgvPT9wsGWOdr3C5vzx6Gk4XzO72ezgm8pa9rsWs1DcFvfraKyeaKesHEij+PRjMj3npUXyNAptt3RrweygafjGbce/2x4kvMouWYaugQa9MFpKwlgXvo4a4Bosdr3LLRikdJdaVkfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756770770; c=relaxed/simple;
	bh=ySL3otziA7UIaxbbqT0x4Y5NEYj27gmjQAiTXYQIEWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ty//WH51dV2mNsbX5clHQRqbZnUieQ8HQRerj5GUXyycXg8juqRnGTLwUHVGGzge5ZokhFwp+NYoi11QoeR+ssJujV5HwzJoFTShkxF8EBYXfs/3i7o0JU2dGnC2BCUoOCXVq8mm+UJQGHuy1ARm+rpsVkXnP+PA122Dg/NcEG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=do8P0G4b; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-74542b1b2bcso4878419a34.3;
        Mon, 01 Sep 2025 16:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756770768; x=1757375568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6r3kPaa7qmMxm8jAGLunwNptKQKbXCsbl3cGO36lMIA=;
        b=do8P0G4b9ypp4X/C79iKg+JrugLGqOLaHQh1kZA9LmDv8y4SJrMpFw6LqEE8Dm3rb1
         A5uWrIqyxq0vkem/kBSHb8Mx+9m6afsiCZXoNaSsJewvqyhZzQNm24bDabiWxS4ABv7k
         0I7jGO4TVIqI3VJQ8V+H4M6w7MKNlCiR5Cvcu1H+xhB+tq0ZJamk5F1PfFzFVuc9ShY+
         mnExXOzkoKI45Xyq/OzH0nPQ2dhhadrTk+xofbuceHtGOlt7OytOgoAg54pcbipDpV5N
         S43vlibVT0AhpwjS2rZHIlBQhhct0F2DwG6lt7FIw7CAhlGfE1ZFU8H8lbbXygGp2xHz
         oYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756770768; x=1757375568;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6r3kPaa7qmMxm8jAGLunwNptKQKbXCsbl3cGO36lMIA=;
        b=lyO1Kbw2sjD3OarjTGHT7HQA1tB/71+Vbc8BPcxGfqe2ZS9l0ndOCCaIFBn7CtaxfY
         QltO3OofAGxuM/u65Tuaa3t8+D2j+UnXbbuGjMnG3d5u2n1n2hqrkMltz2KOVdYKOV6J
         zNBmAdfd0A0GHnpz9FvWCSev6ahm5IuvALpjCCxJufM+pBNNRlXwBiXa+VZsQMMopd51
         3zHsHZi78IABUpl9+uwJtorEfwCSvWoAYLGMHlKXcCIuKqEIjVQdTcaxbWDrPkyQMsLQ
         nwaFCmR5evbVPFDHRgyZY+U1RpnPcPahTcmyTD9dq0Jo9Bd2ubrMZvkrewWi2Q5Uc32y
         Xf6w==
X-Forwarded-Encrypted: i=1; AJvYcCV/tAYtjj7aBTGaizXJWCLZQzgrMrLQ7143qaiF6gsU6koKI+LLl6pCmvS3p5q+s1OxGrTUK7vIM+hxKig=@vger.kernel.org, AJvYcCWNCT9V/Oq+t8HNMsH1Hq7h50hhG13KeOA7PlXYRyFu0Cfu7AFPYntaUVOj3Tq2GYWEpQr5TWLzPaY63m7fguZbW+KeUg==@vger.kernel.org, AJvYcCWY67CUIvxCH7gXGJoKIO2eUXWSmDKeHNV/EKVVUd+RceMrcAcKizmVbwxd8QJFVxWIv8roJza9qNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyeh1dmyDR3auw9zzoyxiwrij+Il8o1qshyE9Ov13V3WA6RgCRZ
	C/QEUeVU0ZTI+oQBVMF+rhkUwOxJ+kjqFaZKWiCGayHZsNog7rJabyTYYQ82MhzU
X-Gm-Gg: ASbGncvTClPm7R+a7WplD2f+qboT7kcs5SceCjWf86x6gvAGpFMIcVgVukNqIihrzdt
	BbgEreI8Lau2rv9bLaXyMQ7YXNZaIm1CttD7WwlDrBi3OqSLFdx8hJldFLVE7umg/p19ZoNC4cm
	HX8qqIza3JRfqaiqcaz9YxGaaKNHVtZ5Yqitu1MtDDu6A5LtZ88cXrw3ekcUVarEr1d7SxpeRzA
	LqnOHXudNV/hcQXhzJaEkgjXMSEWyVIIYJt3F165d/Dh4uVo/Ky78HAGwFl2MujnTLKjS1gYmlC
	PdVjXNpotGCba1lxX7Ud83g3nX/nJtp8dTtEdWraP3S4gEI2i8oHW58us8BLTaKMS3bcCN6T1ax
	xrJmveMispkyZNc8pvPEKd23uz1+W0++0/IawXAXpQa/5ObiR
X-Google-Smtp-Source: AGHT+IHLKG3EObyepXaGIZ3bopXpKCKFp4fmkpuPtoCKOCje+S/ItQ6mA95RukM2lXrCgat7c8Sqfw==
X-Received: by 2002:a05:6830:498f:b0:743:8af2:1af7 with SMTP id 46e09a7af769-74569e7c0bemr5446665a34.23.1756770768095;
        Mon, 01 Sep 2025 16:52:48 -0700 (PDT)
Received: from ?IPV6:2600:6c56:7d00:582f::64e? ([2600:6c56:7d00:582f::64e])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-50d8f0d4605sm2658409173.21.2025.09.01.16.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 16:52:47 -0700 (PDT)
Message-ID: <60e6b6da-ba46-4a75-b571-8b62f3186008@gmail.com>
Date: Mon, 1 Sep 2025 18:52:44 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] platform/x86:intel/pmc: Show substate requirement
 for S0ix blockers
To: Xi Pardee <xi.pardee@linux.intel.com>, irenic.rajneesh@gmail.com,
 david.e.box@linux.intel.com, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250815224611.2460255-1-xi.pardee@linux.intel.com>
 <20250815224611.2460255-5-xi.pardee@linux.intel.com>
Content-Language: en-US
From: Russell Haley <yumpusamongus@gmail.com>
In-Reply-To: <20250815224611.2460255-5-xi.pardee@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/15/25 5:46 PM, Xi Pardee wrote:
> Add support to read and show S0ix blocker substate requirements.
> Starting from Panther Lake, substate requirement data is provided
> based on S0ix blockers instead of all low power mode requirements.
> For platforms that support this new feature, add support to display
> substate requirements based on S0ix blockers.
> 
> Change the "substate_requirements" attribute of Intel PMC Core
> driver to show the substate requirements for each S0ix blocker
> and the corresponding S0ix blocker value.
> 
> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmc/arl.c  |   4 +
>  drivers/platform/x86/intel/pmc/core.c | 126 ++++++++++++++++++++++++--
>  drivers/platform/x86/intel/pmc/core.h |  14 +++
>  drivers/platform/x86/intel/pmc/lnl.c  |   2 +
>  drivers/platform/x86/intel/pmc/mtl.c  |   2 +
>  5 files changed, 138 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
> index 9d66d65e75779..17ad87b392abe 100644
> --- a/drivers/platform/x86/intel/pmc/arl.c
> +++ b/drivers/platform/x86/intel/pmc/arl.c
> @@ -725,9 +725,11 @@ struct pmc_dev_info arl_pmc_dev = {
>  	.dmu_guid = ARL_PMT_DMU_GUID,
>  	.regmap_list = arl_pmc_info_list,
>  	.map = &arl_socs_reg_map,
> +	.sub_req_show = &pmc_core_substate_req_regs_fops,
>  	.suspend = cnl_suspend,
>  	.resume = arl_resume,
>  	.init = arl_core_init,
> +	.sub_req = pmc_core_pmt_get_lpm_req,
>  };
>  
>  struct pmc_dev_info arl_h_pmc_dev = {
> @@ -735,7 +737,9 @@ struct pmc_dev_info arl_h_pmc_dev = {
>  	.dmu_guid = ARL_PMT_DMU_GUID,
>  	.regmap_list = arl_pmc_info_list,
>  	.map = &mtl_socm_reg_map,
> +	.sub_req_show = &pmc_core_substate_req_regs_fops,
>  	.suspend = cnl_suspend,
>  	.resume = arl_h_resume,
>  	.init = arl_h_core_init,
> +	.sub_req = pmc_core_pmt_get_lpm_req,
>  };

The cover letter and commit messages say Panther Lake, but I see a bunch
of "arl" here. Is this just confusing file and struct names, or is my
Arrow Lake 265K getting idle-blocker-cause debug info? If so it should
probably be mentioned in the changelog.

Same question about patch 5.

- Russell Haley

