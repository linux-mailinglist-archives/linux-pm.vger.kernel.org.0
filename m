Return-Path: <linux-pm+bounces-6973-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3860B8B02D4
	for <lists+linux-pm@lfdr.de>; Wed, 24 Apr 2024 09:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E89BB23327
	for <lists+linux-pm@lfdr.de>; Wed, 24 Apr 2024 07:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0588157A47;
	Wed, 24 Apr 2024 07:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="don4JdYK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D96D15442D
	for <linux-pm@vger.kernel.org>; Wed, 24 Apr 2024 07:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713942242; cv=none; b=p+AwJuHMKmCMmwTxp/1Ex12wtMrpYtG1nmTy2iTqsFL/9Tvb47lzkMR6C0nexp6ELD6J25fkAR/Z4JBVVPSIRkbaDA4XyPOXkItmDVdOjHJDRe577OCUF6ZpTCgMqFEGUrbcA/kM+126aYhuP9pUy174DuUztZxH1GdHnGv3I6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713942242; c=relaxed/simple;
	bh=o5jcMAoIDMNK7GfvCWxVvCxihxd3VCuD7FnUm6B2H+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cv4kA6zAwSyYzMYZgER5F2Wb8zieb5C0eUooh76lJdKsTQTBpUklpNViv7N190oMpx9kAW+8AMOpF47RnD4Y2TJc9sRLg7Xvm+ntbpkaPwsr6BVObxsvSuckQdLj7TfPqR/uV7Zf5Nx72Aa0IBHLC+XSbp5nTchQifP4Yo5SD4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=don4JdYK; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41b13c5cbe0so532695e9.0
        for <linux-pm@vger.kernel.org>; Wed, 24 Apr 2024 00:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713942239; x=1714547039; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cOI5h8lbYo046MdXyWvwZM6Al+RR9BSMFKRZs9RVGww=;
        b=don4JdYKTkzVV+O6EmcRZS7J29JEmF+DUrJ2nl2hrNeMHjNERzi3sDjNsTv2LCwpKk
         14LI+ZT6wSUF7BMueQ6TZfGD+Toz/nvEx22+i6NeTvsB7WfQeVC5brPHS9tKiHHO4yrt
         I9EwbnYJEwmYVXdi4JZ+iRZnTiHMoTMC5v9MFFvpLAEq1LD2xj1X4aoqdrIWSycTj5Z1
         8YCKJdV1G+1qDT4cd3Pl380wMa9uP9Bw0k6Wz1scrWIQulfZF/hCLBS+CJj6XHaMbiUn
         3Yw5TOD7pdW75QeqSpIH5Go0rLQQe8GYQ5xv6U3/9yn5Wr+NK97XVlPVDD9Xp/JE3Dtx
         dyUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713942239; x=1714547039;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cOI5h8lbYo046MdXyWvwZM6Al+RR9BSMFKRZs9RVGww=;
        b=K1bQfCWixCwtuTPRohOPiLJjLRGfghbjIsxnVa20J4sBzn67ZJSEBnTncw5u6E4y4s
         5feGZeWgHXAGoXBh7PZh34PzFv5pTIxUZKHPDTc1AbpHCYvNwgLAa1O7zesxQ1PMaoA8
         ew/Nwu5qV7RF5CYYUZoRfkv0Ok6xxheUrdaO+137PogGKpWsiSFVx3IR2EP6SJeHAKjQ
         anJuyphZyjDBg1ro0ppr/ZQbIVEJPAk+E/OTSuhe4mAd+oSv15GiLcxqMKKHRCFHYVYT
         Nskupsh7wRJNUUd5AQhYXArt8WzDZ7pisOHpDND9u7r5OT6yFcMmoFFJNIRQRGrQu/Tn
         6xWA==
X-Forwarded-Encrypted: i=1; AJvYcCUx3aVngjWbW6/+73zHmS8YvFhfaan51ItlJ2DvKhNegp1UTdgQ9PDv5UQWGuuZVSBliUOntxHVgEmg4+i8WQegjgYTtnOaHWY=
X-Gm-Message-State: AOJu0YzYVik848rP9Arjy0ZY0/9uyGo+rjGtxpHDTkAGZt04eUEc8/QX
	vAPEPd0ge+7cls356u2SrT8UdPbrp4i+jJ75W6QK/8YVjlkXBmAB2MRBHetoQf4=
X-Google-Smtp-Source: AGHT+IEjfhUliB0ROA8SKjhBk1g0czsRVu0UcRbAW3otfksb7AnqbmAdQyGcaBd/8Pvcv9jHo73X3g==
X-Received: by 2002:a05:600c:c10:b0:41b:935:248d with SMTP id fm16-20020a05600c0c1000b0041b0935248dmr387282wmb.22.1713942239568;
        Wed, 24 Apr 2024 00:03:59 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id g9-20020a05600c310900b0041a9fc2a6b5sm6079518wmo.20.2024.04.24.00.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 00:03:59 -0700 (PDT)
Message-ID: <6067e8e1-d4e9-4226-9767-62cb930f400e@linaro.org>
Date: Wed, 24 Apr 2024 09:03:58 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 09/16] thermal: gov_step_wise: Use trip thresholds
 instead of trip temperatures
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13515747.uLZWGnKmhe@kreacher> <3769085.MHq7AAxBmi@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3769085.MHq7AAxBmi@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/04/2024 18:43, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In principle, the Step-Wise governor should take trip hystereses into
> account.  After all, once a trip has been crossed on the way up,
> mitigation is still needed until it is crossed on the way down.
> 
> For this reason, make it use trip thresholds that are computed by
> the core when trips are crossed, so as to apply mitigations in the
> hysteresis rages of trips that were crossed on the way up, but have
> not been crossed on the way down yet.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


