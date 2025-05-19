Return-Path: <linux-pm+bounces-27328-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51598ABB9E9
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 11:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AD897A7164
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 09:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E96727510E;
	Mon, 19 May 2025 09:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UFpixuAd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E265B272E6A
	for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 09:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747647090; cv=none; b=TLNA7gIuPGS0UoG1XeeBIyrHQCP52P5h8kYYmnXM1PzPAMKKLTFIb5zUSJyARMk79Yx7vhyMgQHQlKpD4WBE7Z9+2+BTSkFSaTJ6V4fzoaDb21PJ9JQuZXTcAb6KATfkgasxSq6Vq7INyHAB3YS5V40hlSmWXSrn28V+IVKJ50o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747647090; c=relaxed/simple;
	bh=c/wBlaYM4RSxl/erOHhMdSWmwIe8Uwd04Sjt8QeJ8/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=La1kvfRMD0MDT76QHFPVD3iFngyMlCKp32QxVhfJhTzzeo46mU8PkJfPQNU9GjouIOgk2MAeskFjBXy3utqZHanhtc8A4dWKD9knjpUwq7whq/eD/lKSJnT3ypF9MVFza5vwKib9/yJAepViB7wLxnfHUYtN/7zuGhmP6dfrf4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UFpixuAd; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b26f5cd984cso2419384a12.3
        for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 02:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747647088; x=1748251888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bvQ9YmGROOXrG/iLumMa04WB7ur/2tl9ZFhlSZDT+Cc=;
        b=UFpixuAdc+84m/oLMFEg7ktPLRO266iv4r2R61QJuK55D4eoz1BmICqbBnY4w/iPIF
         q5QcoIvX0Mef3IrqKvsvvxwx1VewXlyhpzKpbeWEVEUD7pqrygZ63rdvqR0XnWyLj1xC
         UV69s49HaJnmqDLoU8wsDXiu2aG2Zfxg3Em/rUGKQ6GMfjrNk2ZaF7mTvfFMj0wTfcdK
         brdUJerbFXyfT7pWp8uB9tWXlQwO/8XXCRTGc4l9+ClBBZLPUD+DEG8JSwRO2YlkIll5
         2m4xkgjPvV/wSxN62rvaXEhAtyk7+5k+tQKxq2N2ClK/uK+iEpIpmbG4grlBq7N9iLL9
         HswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747647088; x=1748251888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvQ9YmGROOXrG/iLumMa04WB7ur/2tl9ZFhlSZDT+Cc=;
        b=TOx7X520aMpvA5/YqgFnDZxPUqpViVGysL3WFh5ADi7yty4WfFH/IO2P8SzKhhshpe
         hSmcaMwSubl4trI/yintbHt8y/9QMbpcBmH+VT8FVZdTcTA8RGoYiwNiVZGPv4dujJQV
         Zhbn6HxfYTQlg7EJIt5g8oRRN6/3hi8x9zM7Kn2Xh/SiqlxGE+0L5WFP7/slShTN8NcU
         jvw/SlYZTRJv93fsYeVvL0zUe4DjVi/ZAaR6K1hCLVQMToAdW6LrnF7SrmPR+XVEjT82
         af4FexYU6nxp0SX0Oxvmww6o5O81WfC4PqlLIuskFHHit3/+Z5NI2/P8QzhRHv2mix8m
         mXoA==
X-Forwarded-Encrypted: i=1; AJvYcCWhrk4KoqAkA23BvwDZxgE4oe1hJpJZkqZ9XQ0H9g3KkHKabKGczWzxdavt3PQUIE3Pgro1/DzSmg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbbpvjcPhqufNg1oH141ocMTfiXZMTozP9gLSiMfTwlSYuPew7
	o8opRETqqiG38BOoSyIyIJYxomqUeZELRxyXxfwzgISBM22IMTWprEL5GVWGF2kdexE=
X-Gm-Gg: ASbGncvLWrvscZgb6HIjDbt9gAHBjnAMgpkrIShairewrEzH6syZVShiA6wNOisbSWj
	pcTebezmmDkvH3cH7IvS9kZGfGy9RcPv2xbiXNg6DWQmDiqU1OLjnUIX1UyZ6AGEx9rnS0tYHDy
	EGh0XKSDy023yJUNqnHivwRZVcp4PbLgr69mPEZGMqdDmvioZXpwdBfJe673NDPS5IFYPRBc1z6
	e8LT2sYuTmX0Dt/VnUgHZmFTyvgnQZfv46fV4CFq/aTgr3JPJmg5CclLzZAZDKqjFP/VxWv0JD3
	6gnKeB3ZqS0d9SKScMRpvF/DCCgI55T5/JHlNs/enG7Mmi3eMpx0
X-Google-Smtp-Source: AGHT+IHQejNmLqqvXox/EeoAuxX3X7m8LUs8KU1gDcylEBYdUF9gjHc0zecpPmtgBo7FvB8Kzn20/Q==
X-Received: by 2002:a17:903:2f47:b0:224:376:7a21 with SMTP id d9443c01a7336-231d452d0bamr162849905ad.42.1747647088089;
        Mon, 19 May 2025 02:31:28 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ac9567sm55776315ad.11.2025.05.19.02.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 02:31:27 -0700 (PDT)
Date: Mon, 19 May 2025 15:01:25 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, pierre.gondois@arm.com, sumitg@nvidia.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linuxarm@huawei.com, mario.limonciello@amd.com,
	yumpusamongus@gmail.com, srinivas.pandruvada@linux.intel.com,
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com,
	lihuisong@huawei.com, cenxinghai@h-partners.com,
	yubowen8@huawei.com, hepeng68@huawei.com
Subject: Re: [PATCH] cpufreq: CPPC: Support for autonomous selection in
 cppc_cpufreq
Message-ID: <20250519093125.jn2naozcsrroahco@vireshk-i7>
References: <20250507031941.2812701-1-zhenglifeng1@huawei.com>
 <20250519081850.7ycbcw56jzpiwkth@vireshk-i7>
 <4c4b0140-9126-4586-92f8-f7c9fd7a4a34@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c4b0140-9126-4586-92f8-f7c9fd7a4a34@huawei.com>

On 19-05-25, 17:29, zhenglifeng (A) wrote:
> cpufreq/policyN/ is linked to cpuX/cpufreq/, both paths correct.

Ahh, my bad.

> It means Continuous Performance Control, you can see that in ACPI 6.5,
> s8.4.6.1 _CPC (Continuous Performance Control). Use "_CPC" might be better.

Okay.

This looks fine to me then, let Sumit reply and then I can apply it.

-- 
viresh

