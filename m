Return-Path: <linux-pm+bounces-4275-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A8885FC75
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 16:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1D371F24A6B
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 15:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971BA14E2F3;
	Thu, 22 Feb 2024 15:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GDJCTVwS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB1914E2EC
	for <linux-pm@vger.kernel.org>; Thu, 22 Feb 2024 15:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708615996; cv=none; b=SRIHseQ8We5TqiFKSHMHL3hQSt9VG2LElT/LWDW+Z2/i9EPSHrRfZxVHp+KFjm7j/M0CnDJ1se7x88vlGrG1cHFRttdcb583JSzvbxGNXdh5+GvHZMfd4a6uCu7kR9qM15KjGz9oHq4YZAPNmk77Mx/HibZQ20JyWQ7/nJBtLI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708615996; c=relaxed/simple;
	bh=oK1amVuCox27CRvUtnAUQD4LEuZhjZZ7ofBpfkgNkaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xj6lVGI2ndeeaHR12McdydOTSBl6fakMWCug0PgRjdWVZEfCHpVRDZ8q3ZQfUNyeQwkjWo6KzQ4stdVk8ST8VsvYpnuOES3jrVQrM7j0hp6nmUsogAMCTCh9dd+YGiTa2E2LytwXBfQYyZzeIZKKegEhjNvzB9IjE1DlF03zS84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GDJCTVwS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-412730e5b95so18908235e9.3
        for <linux-pm@vger.kernel.org>; Thu, 22 Feb 2024 07:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708615986; x=1709220786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qtcvbi0VWL42LwVToPMJNo4Anu/JDy4cWWHbbORlvFk=;
        b=GDJCTVwSTHpGPqz72t2E88U1tkM9I7yRGdMvPghQjXvuo+n4N7zDv/qamxlE4qMSq+
         BuEjOB9U7ivTSI5/8IrnU+AfUyrgzLTNl/vVAq/RB+yDa8id9quJ3fwGElHEiIHvqbAy
         Cv6Xjl8mWWDiHH+WGVzgVeV+/APktaPWiKjFIFFKaZJRQcfAI6hS95TvzSBJLbA+rMNJ
         dqCRP4Z7pFjb9bhA5u9rttisPDKIFjfkvsvKpkxCN7DNQvdQ6NKCsYq7Ln2CZ6+89JO3
         983aUoOSyfD/wB7GotP/4snyALOOH8hoOSJuWMdjOroFcmfJucTIn6cUkGzIVsGM5GHI
         2Ohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708615986; x=1709220786;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qtcvbi0VWL42LwVToPMJNo4Anu/JDy4cWWHbbORlvFk=;
        b=dD/7HTWOjYZB8wMDzceo2nziwZXrakwBp88XJxapkUFkHRHS3RysrkaWhW9CV5EBcd
         IagMSL7Aad00BLEGfJ3L/SoXqdbMqUH4a6UqkxOqB23RcdRbtahS4d4eryHcMFlpfdyq
         iLLv7X4j+q40GMV4nzXBbikzvy5+K4ScPGNJXe4kLhGKj8PLiUKhZU1gQZfL8FMSZsjP
         pyfnxc3QjOx2BUMcHpmBiLST3eisa55Iv9NFThDLI77KWXyBGPzrhVnjoA5ttioeX7h2
         LyDs71DZ2Ty+edjTsl9rmhMrueqIQaTFUIFuemSy4e+Um4sv5okl9jpvMyMQMUaDlon8
         8oPg==
X-Forwarded-Encrypted: i=1; AJvYcCVPERI7B3YLlv8XTZ1gpnGtws1EKo6IgFKIDysCQK+9M1jjpR9GIshb4lAOYN73b5z4tlolTOiLBM8WpVenEchlqCdw6Q7Y1qA=
X-Gm-Message-State: AOJu0Yx/dayCpt8v27wF6shwGCYTc6tOvwpEJC1TZ8/mpbkLhv9+c0YA
	FtAgEjeqyKCLoDIekjPuPRnhDrnvoeWQZoM2d4sRAmha6tszgzR5L2bMB33m+yo=
X-Google-Smtp-Source: AGHT+IHyJpAfcsOcSg7wL7lE6r7Z24xHwfv17RJU0PRSdSw7isnIXMwanFuLtLcaJs949t6M0RUnYg==
X-Received: by 2002:a7b:c4c8:0:b0:411:fe7d:ac4 with SMTP id g8-20020a7bc4c8000000b00411fe7d0ac4mr15711697wmk.24.1708615986587;
        Thu, 22 Feb 2024 07:33:06 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ka7-20020a05600c584700b004101543e843sm6434548wmb.10.2024.02.22.07.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 07:33:06 -0800 (PST)
Message-ID: <3e282706-2025-45d7-a2df-1c07f98ce10d@linaro.org>
Date: Thu, 22 Feb 2024 16:33:05 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] thermal: of: Set THERMAL_TRIP_FLAG_RW_TEMP
 directly
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, netdev@vger.kernel.org,
 Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 linux-wireless@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
References: <6017196.lOV4Wx5bFT@kreacher> <9235101.CDJkKcVGEf@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <9235101.CDJkKcVGEf@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/02/2024 19:40, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is now possible to flag trip points with THERMAL_TRIP_FLAG_RW_TEMP
> to allow their temperature to be set from user space via sysfs instead
> of using a nonzero writable trips mask during thermal zone registration,
> so make the OF thermal code do that.
> 
> No intentional functional impact.
> 
> Note that this change is requisite for dropping the mask argument from
> thermal_zone_device_register_with_trips() going forward.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>


Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


