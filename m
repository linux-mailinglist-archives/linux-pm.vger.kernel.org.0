Return-Path: <linux-pm+bounces-39948-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 800DECDEB82
	for <lists+linux-pm@lfdr.de>; Fri, 26 Dec 2025 14:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF086300C6E6
	for <lists+linux-pm@lfdr.de>; Fri, 26 Dec 2025 13:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C812C3218DD;
	Fri, 26 Dec 2025 13:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a6cm/P+v"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDE031AAB6
	for <linux-pm@vger.kernel.org>; Fri, 26 Dec 2025 13:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766754775; cv=none; b=ObTwuYSNiUSiOGfvIW95rVhE1QfIIij06CXYWU9Y6h7Jj8MzPafSy6SSOUn5boM1q8Yput+++fautxvAQzWb5bQQA+ZWjZyrezPtA04x7uW8AEmVSK2GTxTkFmaC6208QseR82kFtg1dBMSHESICzZS49g0n93Gg2lrhQHlTooI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766754775; c=relaxed/simple;
	bh=Zzyrkv+jDg1lPu6LLx7PPcO2dvReUtPC3A4PLs347n8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KA8aSnoLS0x+KXXTDtz4erDQrDDWCgl4q/LsTv2hrHKeQjrDZP0iXTjPnPmhHTRz/A6I2za0GjafSnmvZ/UMZW5DJNNRJuUclIDfqcFMsnRHWPx9vkcG+fjoJ364G3p2q6t5D/vuozRgNX72m7PsrdzAV1yWrV0OYv/g1g5o92M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a6cm/P+v; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477632b0621so45500255e9.2
        for <linux-pm@vger.kernel.org>; Fri, 26 Dec 2025 05:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766754771; x=1767359571; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q7jnzss7SrgncsYKHhnBFIr8PlxYdzd1neAXYIb5ojw=;
        b=a6cm/P+vWSS8grV/VcwzUCRlaIXsYCZNmR4ZND1Oq8FoxAhTSEsIbAWuL+My1nzd+2
         OTjeiIFJPUXc4b4KiSB4slx0DUY6hUfFN36qy8je/fwV4FuKrXwIz2AzC/pEzv3irODV
         SbDV6YWxRhKOp+HYxusE5iNXXY965MraCN+MqiKxASiB3poLdc2gB7oWConMJPgXczdv
         g4iaLF9ksbv7YfLHvoQY8FKjKLAkCW4f1cOsrhFJC6Jz5+078yj5KU9ombZXnl9k1COo
         eOwr5UF+7+Lg542bcsCBuZX7SZiRUG/vaz3fZxMcTVNUHAIrDQNoE1kREpe8eFDXLXy/
         vSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766754771; x=1767359571;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7jnzss7SrgncsYKHhnBFIr8PlxYdzd1neAXYIb5ojw=;
        b=R/MbMY7fv0pp7TeQDGQzT6FsNxm1BpNJNU7wGmn3vrdJyu5vdOqHknDMfiT69ZcT++
         1noFFT1EzofFB6q0GuGzWgPShXF18eU5l8givsHKxzIyuKUhPvC1h3IE0KKCB6rhIUTl
         EIPaosYb33jyVTMmgll60lkSFYMEPdq9phsSRNGXd/TaOhBz0CRQPB0+m+G8jUttp6Fn
         8tBHJpoR9nwFB1p/k1UYmNBmDPdsZAkcSNVc1F8p0vrypNtpvae9FfrK5gPO5Cz4NV/c
         je0TVqmX/+F9qqwDoedy9lfJu2fNCWExmbGD8QIx8sBrmD8TpE56gZQ6HI9NcMAWksnr
         /DCg==
X-Forwarded-Encrypted: i=1; AJvYcCWI9XLt2qbQG62gwjkV2J8Ba1vLzh5ZQyqQPvzlY0DnhTf6QeZLja5eQS28LizCvGdwZf+IMcyO/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWkswE38gwi0+X466wLtsNUOqlcqcnSjB3AvlObYY0HVFdIaKC
	iEG4skAZGwrzjHGBFjv1FOqjtNR+w9x711uWx+85EBqiSGPq6tt8nkg8iSLEbAmyr+4=
X-Gm-Gg: AY/fxX4HEfyoT2VEML+1CQPxTLKwsDH2cOVWSO09IRbR8ckIpydv4SRnpG6wpaOGTpp
	OaRHOKzuea+PvPwUZI67CJWV5YEoJcoxfYakR1wUE8jpn8gk8GEesMaNtNn2wRWuY9R92+CKaMD
	8roMIlijMgsx67JsiPfSP41T+Ls9rDb6dYGfOOocVyRPPZ9OQmluefIys3egcMYIbf2TgiG9Jzy
	PqNKK6AaMYeiDTnPjPYXBozQY6pxdnL+D3KGB8xvoup5Ene0jJ6zI0A5U2Kz7xmV1LCLzkacLjH
	3kTTUJEFP/ot28Vbu6oOkOTLtwuTQOUldJk1l3ufk73kYP5Pno8RNdbyLNA641PJlGaz1rzCWwk
	YK8CjkkY/R+akVEbA5N1TasYLgizHGCretg0meDP+kQvp73HWs5gQAKCVAnYu6U2gqjWd/wdalq
	PfQsoyVqHu/Ko/ynzz
X-Google-Smtp-Source: AGHT+IGKzcbgQ+tXH1pXY7Tmn2bUwHhALa3rlAg9XLT80pEqkBwfhsO4hiRp/bMzr/tOXSWghlfGDA==
X-Received: by 2002:a05:600c:3b1f:b0:477:9b4a:a82 with SMTP id 5b1f17b1804b1-47d36c75e0cmr122805055e9.35.1766754770832;
        Fri, 26 Dec 2025 05:12:50 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be279c5f8sm423216845e9.9.2025.12.26.05.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 05:12:50 -0800 (PST)
Date: Fri, 26 Dec 2025 16:12:47 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [rafael-pm:bleeding-edge 69/72] drivers/acpi/bus.c:339
 acpi_osc_handshake() warn: variable dereferenced before check 'cap' (see
 line 332)
Message-ID: <202512242052.W4GhDauV-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   e08ef982088f28cd65654693f29ffe430a9d4d66
commit: e5322888e6bf4ec17964a93638c9b14433a2f6f1 [69/72] ACPI: bus: Rework the handling of \_SB._OSC platform features
config: x86_64-randconfig-161-20251224 (https://download.01.org/0day-ci/archive/20251224/202512242052.W4GhDauV-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.4.0-5) 12.4.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202512242052.W4GhDauV-lkp@intel.com/

New smatch warnings:
drivers/acpi/bus.c:339 acpi_osc_handshake() warn: variable dereferenced before check 'cap' (see line 332)
drivers/acpi/bus.c:339 acpi_osc_handshake() warn: sizeof(NUMBER)?

Old smatch warnings:
drivers/acpi/bus.c:297 acpi_run_osc() warn: sizeof(NUMBER)?

vim +/cap +339 drivers/acpi/bus.c

e5322888e6bf4e Rafael J. Wysocki 2025-12-22  328  static int acpi_osc_handshake(acpi_handle handle, const char *uuid_str,
e5322888e6bf4e Rafael J. Wysocki 2025-12-22  329  			      int rev, struct acpi_buffer *cap)
e5322888e6bf4e Rafael J. Wysocki 2025-12-22  330  {
e5322888e6bf4e Rafael J. Wysocki 2025-12-22  331  	union acpi_object in_params[4], *out_obj;
e5322888e6bf4e Rafael J. Wysocki 2025-12-22 @332  	size_t bufsize = cap->length / sizeof(u32);
                                                                         ^^^^^^^^^^^
The cap pointer is dereferenced here.

e5322888e6bf4e Rafael J. Wysocki 2025-12-22  333  	struct acpi_object_list input;
e5322888e6bf4e Rafael J. Wysocki 2025-12-22  334  	struct acpi_buffer output;
e5322888e6bf4e Rafael J. Wysocki 2025-12-22  335  	u32 *capbuf, *retbuf, test;
e5322888e6bf4e Rafael J. Wysocki 2025-12-22  336  	guid_t guid;
e5322888e6bf4e Rafael J. Wysocki 2025-12-22  337  	int ret, i;
e5322888e6bf4e Rafael J. Wysocki 2025-12-22  338  
e5322888e6bf4e Rafael J. Wysocki 2025-12-22 @339  	if (!cap || cap->length < 2 * sizeof(32) || guid_parse(uuid_str, &guid))
                                                            ^^^^
Checked too late.
                                                                                      ^^^^^^^^^^
Also this sizeof(32) should be sizeof(u32) although both are the same
so the current code works.

e5322888e6bf4e Rafael J. Wysocki 2025-12-22  340  		return -EINVAL;
e5322888e6bf4e Rafael J. Wysocki 2025-12-22  341  
e5322888e6bf4e Rafael J. Wysocki 2025-12-22  342  	/* First evaluate _OSC with OSC_QUERY_ENABLE set. */
e5322888e6bf4e Rafael J. Wysocki 2025-12-22  343  	capbuf = cap->pointer;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


