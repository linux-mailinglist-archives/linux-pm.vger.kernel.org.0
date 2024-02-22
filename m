Return-Path: <linux-pm+bounces-4274-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1651185FC6D
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 16:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6A11284C65
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 15:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CB814F9CF;
	Thu, 22 Feb 2024 15:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s4mgHzoY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BEB14E2F9
	for <linux-pm@vger.kernel.org>; Thu, 22 Feb 2024 15:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708615944; cv=none; b=Zgkn5L9lwU2CrjM8nYYubdSwELOhOYug8rjjcvbPvCQQUfCtDxWCSDQpTthLmaUzBxzgGhBb8XgXABrdCUHflfyQSnIctBE7Kn3WiEoh8om/u0yrCWv0/Z2dzHu7VSkM8Ju7kKis2s/47m3fHc9FJe40oWiJaFAQPzEUyTlbbQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708615944; c=relaxed/simple;
	bh=HZutNOEuozUmilTycsHTvraIH3r8+SypP+r2VRMcm40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Obi8Ar1C30oOmSlOHs0P4A+grcDGdVyhHmlBVwNvNiUQqPtO01LQljqAusGFzGh2/qsa66DmAmPfqcnsuMkTqKGftgY0SZMCZtqBZITVdJKyyPybfd4RHi0jrVANZ9j+2ntLqAZ6uz2rkNw4pEQzstTPeA8pi8YZ4jBNSUNScG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s4mgHzoY; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4128d787765so3362475e9.0
        for <linux-pm@vger.kernel.org>; Thu, 22 Feb 2024 07:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708615940; x=1709220740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+q4vsHLhF7Vv0hgSfbRQ/lU/wgrHQF8P9rNsVKFLL/o=;
        b=s4mgHzoYRJTs6oIl/CU+su+3ti314XJjJ8DBd9P2fX2lDHNWu1bPc8E4czizspP1ob
         Bh97ATikC26VrwpCHTfoV21EGyYgTIsffTuDHU1e0pnd8dEGIhM7NkVXOn04LbXdlzZF
         t4kTwuK1HCAMllWowhner2tm8/9av9bXvTPiCRSILn5xySkPs80HYKh3Jh/0GiOFHT8T
         F120R8vTh032xNb+6MJycxtvkvLTKNJgwDAJaJ1LZNtr+13iCDMXPPXqt+mUfnSJ1BpH
         MLwDlUE308xSoFlcGcrJptebxAVmcdxUVjto++7wQZ5G8pgnXMS4yZZaOjmTk3B6NZIu
         TdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708615940; x=1709220740;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+q4vsHLhF7Vv0hgSfbRQ/lU/wgrHQF8P9rNsVKFLL/o=;
        b=i+Z5K8dKX+HvCG8qfTjkjyU+UD7agGcveC5iI/oJ4YKhJ5FK7Zmt9vkYOI2Ah+aKDG
         aSSLDsXdHW9GCfaUPq8lbPTp7p67I/alRWkeeb9djRbL72ylX6JluS5du4Ny8AE+XX/6
         Kk8h+rbCpf9R8bLC9MQamqQ+jo7atDeeUMk3IhSgxN3J5Ri4ReW5PbhGdI0dc1CbsoO3
         rPR/cMxGlVP8teN5WfxBNtRsGymIm8RAP8caPzVOcZuJLCDYu2QCnINHC3g3Q0nTpt+M
         bEu2K3KPr3kuTh1yjE3ScLnm+dyx6yP3VoQTt4Pv8d9avkB3OwxXWXCqo5VFbtqB8hNc
         XtrA==
X-Forwarded-Encrypted: i=1; AJvYcCVKmy2Hd+juGZ7w1sRWDYeoCBFTXi1Gfcjb6hW6BQOHsSVZZwxaZmSa6jlc5rq7R99eaCezZYIodHsL4hzWqCxnIMfCTg4HvNA=
X-Gm-Message-State: AOJu0YxarbCqD9CZyrKsihbmiymYBFBgYUeY9PCjUibm7VdTJ6oFsZu3
	mP6/cEQ5+Y9cAO5GSoH4ZRU/Ey8o5IUaHDMxNX4RgybGyYLgDPonwVRV9/XnfwA=
X-Google-Smtp-Source: AGHT+IHFWn61+J9PBn0aK/tovKHOYNTYZTMeCP4cG4kdpItzeBRLIBT4km0f7vWmhkKsGRxrN0UJVw==
X-Received: by 2002:a7b:cd8a:0:b0:412:a6b:d572 with SMTP id y10-20020a7bcd8a000000b004120a6bd572mr15081272wmj.34.1708615940264;
        Thu, 22 Feb 2024 07:32:20 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ka7-20020a05600c584700b004101543e843sm6434548wmb.10.2024.02.22.07.32.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 07:32:19 -0800 (PST)
Message-ID: <04f0a492-aad2-43f9-a3d2-fe60b50caefb@linaro.org>
Date: Thu, 22 Feb 2024 16:32:18 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] thermal: imx: Set THERMAL_TRIP_FLAG_RW_TEMP
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
References: <6017196.lOV4Wx5bFT@kreacher> <3790563.kQq0lBPeGt@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3790563.kQq0lBPeGt@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/02/2024 19:39, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is now possible to flag trip points with THERMAL_TRIP_FLAG_RW_TEMP
> to allow their temperature to be set from user space via sysfs instead
> of using a nonzero writable trips mask during thermal zone registration,
> so make the imx thermal code do that.
> 
> No intentional functional impact.
> 
> Note that this change is requisite for dropping the mask argument from
> thermal_zone_device_register_with_trips() going forward.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---


Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


