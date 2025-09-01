Return-Path: <linux-pm+bounces-33521-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C0DB3D986
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 08:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4D3B3BEA8D
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 06:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F5A21019C;
	Mon,  1 Sep 2025 06:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r9oVSeNk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E156322DA1C
	for <linux-pm@vger.kernel.org>; Mon,  1 Sep 2025 06:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756706909; cv=none; b=AuqLEFYcaK1DpmfbyasXowO85Tmm3X8rbVFDyUbu6LbIOAlfvIglc7FcjKnAJSxAbWAHbqCZDb9JXa+RjeCzQzfG/G5V/33qsWc9aG/YEJBmtfQXuyijIe/g2gx0SbmULviNz2g3wCtnrjppwEt+lEe5+j1vziqhN/aH+mUdsTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756706909; c=relaxed/simple;
	bh=e1/x6A5urLvTgdY+gnXoSD7qH4dRwjI2/pmtywnvuE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKRpWPNtdgcZVgjejlBRxu3cJCr+FGTyrQmSm7Ow5m7TruEveZ8OfgWLJdvOZ2TAZAG/fUrLfgB9QACSYFJ0i5vNDK0yrAeNnfRMcwPYx3o1JpmUyb5L+d20xNc8h2J97gWdiAlmpokkZMgP4Mh7BaZXBfSDbcXwoN4JT7sKcM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r9oVSeNk; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77246079bc9so1265530b3a.3
        for <linux-pm@vger.kernel.org>; Sun, 31 Aug 2025 23:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756706907; x=1757311707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fe5oE6Vxe0adEfjv7356gkuMjNfz5H4iaVwaqjt3KrE=;
        b=r9oVSeNkB92bzmTA8KCcOTMyOGtXGFOrBquN/1MwVGy7St+EvtZSmeTznC4ROHEiEz
         1XnlsypyGSKj4fe7MyXaz5QX3/m3VSFRh0JEMOrVeHy64zupmB2B2Y7s+h6nBygcAbfF
         0v5Z02M6dcU8OLdrY3lmfAEeNkpik+o7kKuEaTMy4X0Z1HiN4mDggyE7qutHlLUpmMXo
         doGDSCzebtxlmizwpYzPZLfpJPAHkFNZPd+swt3KU+1Iq1grEQAMHgIHdKLgFAfyULmb
         H7l6bImUoCVdjfVEflLPxc4kHDHERLiGsq75wPhWZjZyKEW4v/GUu6W4aJpKLkD0XHRI
         YYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756706907; x=1757311707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fe5oE6Vxe0adEfjv7356gkuMjNfz5H4iaVwaqjt3KrE=;
        b=gXHHCrz9LDFonjv+Hh/mS3Fy5bs0eCI3mVB0JtO77Nmw+NUhAjv3vAHfmsxJ/VA+sO
         DnmMBEZ4eZjDYmfr7qHlnVX7w8p/JaB9hCL7aS95hYxjUYi8Kn+z4sqo6GysBGD0LiPC
         yGIZYzbC8VcaX5gcrQ1qfwjNfL7yslXO/qEFyGdm3CzEYQkp5vbrrhpwEo9qUxfyqK1y
         5rK3tDaa7mwH3MwpQmA+PkYWV6ywNtT0qElB/scBuCkiKP9UG9TI/tlMKh2O+v4T2da5
         GS/hv1FHqLg8hMUj//vOo+8D9mRpC9YtyR86w/316GRWkGVsqwuyHbMRntjQWhmPvSnV
         S55A==
X-Forwarded-Encrypted: i=1; AJvYcCU36C7GceQB1sP23YX+u4n3jV6DDDsLv3F99VsGqX+UjDAQHlfry/ukLbRPff3fArW5fcyr0Lx1Dw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSIidXU0GGGuZbomaZp+02phJn/aRpTX/JR9ZgO2NtoH8FAxrd
	QYAh63PgwTFJlB1/BYlGr5NGk+HRaDEVG6ofXZ16sVcafzB6MbKbTPbqHqwZ/ZzNQRE=
X-Gm-Gg: ASbGncsJoegcICk//7ijusmYXtazYSf/iBRJVs3XuLBwanNHdV4VFmN4RBSOfK4iZq2
	c+JInCszVTxfuuP+S5xDzd8qOMGqxhygIUyIw3ZsndjPY3o/nZF01Mv8u8OT7heqE7sd8gJsFBV
	ia//4f3SizmOgXSBTkWwMw802x7Uc4NLoXbGhTdApvZ3IldiAZ4ROvL/qWqxDaomi4eHvN7eTRc
	W1TBcbQl9bkeFY4OHeQOV4AZj/V1fz4vrAcKCrBExlA+Zd8uGpBLg7fa/TLafvAGv93xIRm/45E
	x+NfFT3B2dkoB2yk21++7Gedgbvl5zdk6JaHbs3GNkc7lTg5yjANYEF0AuRkgPm6Jyq/3/ANL+Q
	1KBasvUfxXJ91IE114rzf+FE7pKmwa2ubd2A=
X-Google-Smtp-Source: AGHT+IH3TOlUNGR0bRaH/xbi5/9JMGK8XkYr8G8EH3FSGJe4n9pposHv4cDvSfnGe7rWjHU0JcQavg==
X-Received: by 2002:a05:6a21:6daa:b0:243:a857:4377 with SMTP id adf61e73a8af0-243d6dd15b4mr9304697637.4.1756706907228;
        Sun, 31 Aug 2025 23:08:27 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327da90ed87sm10064942a91.23.2025.08.31.23.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 23:08:26 -0700 (PDT)
Date: Mon, 1 Sep 2025 11:38:24 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: Use int type to store negative error codes
Message-ID: <20250901060824.6zenbu5wdko5rot6@vireshk-i7>
References: <20250830093458.642881-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250830093458.642881-1-rongqianfeng@vivo.com>

On 30-08-25, 17:34, Qianfeng Rong wrote:
>  drivers/cpufreq/cpufreq.c       |  2 +-
>  drivers/cpufreq/powernow-k7.c   |  2 +-
>  drivers/cpufreq/speedstep-lib.c | 12 ++++++------
>  drivers/cpufreq/speedstep-lib.h | 10 +++++-----

This should really be three different patches instead.

>  4 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index a615c98d80ca..f47096683abb 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -914,7 +914,7 @@ static ssize_t store_scaling_setspeed(struct cpufreq_policy *policy,
>  					const char *buf, size_t count)
>  {
>  	unsigned int freq = 0;
> -	unsigned int ret;
> +	int ret;
>  
>  	if (!policy->governor || !policy->governor->store_setspeed)
>  		return -EINVAL;
> diff --git a/drivers/cpufreq/powernow-k7.c b/drivers/cpufreq/powernow-k7.c
> index 31039330a3ba..88616cd14353 100644
> --- a/drivers/cpufreq/powernow-k7.c
> +++ b/drivers/cpufreq/powernow-k7.c
> @@ -451,7 +451,7 @@ static int powernow_decode_bios(int maxfid, int startvid)
>  	unsigned int i, j;
>  	unsigned char *p;
>  	unsigned int etuple;
> -	unsigned int ret;
> +	int ret;

I would rather do this instead:

diff --git a/drivers/cpufreq/powernow-k7.c b/drivers/cpufreq/powernow-k7.c
index 31039330a3ba..72430c3c5500 100644
--- a/drivers/cpufreq/powernow-k7.c
+++ b/drivers/cpufreq/powernow-k7.c
@@ -451,7 +451,6 @@ static int powernow_decode_bios(int maxfid, int startvid)
        unsigned int i, j;
        unsigned char *p;
        unsigned int etuple;
-       unsigned int ret;

        etuple = cpuid_eax(0x80000001);

@@ -500,8 +499,7 @@ static int powernow_decode_bios(int maxfid, int startvid)
                                    (startvid == pst->startvid)) {
                                        print_pst_entry(pst, j);
                                        p = (char *)pst + sizeof(*pst);
-                                       ret = get_ranges(p);
-                                       return ret;
+                                       return get_ranges(p);
                                } else {
                                        unsigned int k;
                                        p = (char *)pst + sizeof(*pst);

-- 
viresh

