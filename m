Return-Path: <linux-pm+bounces-12691-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3AB95ABA0
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 05:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 326AF1F2598A
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 03:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE8618633;
	Thu, 22 Aug 2024 02:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JQjxG1og"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A621BC44
	for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 02:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724295299; cv=none; b=CYemJyJxi2M0w+gLgT+AHDhRYysf9feWk/eQoxyQ9ZsaPXRLHQLQLgcnTrZV9UTomI6U8/0rftCGEQIrCStxmwSQXieO5tpym5YYu/o4nY2mBxoPwnWzIjdepHVNcgWFe3C4tFoiwY599nV5YSZ0PDrh8Q4uwIcl66fCZ0VQO6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724295299; c=relaxed/simple;
	bh=zhWiSa556sTPC6F0S0FwrATNNM1EWGxgxMPZMtks628=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=qmnrJrVq0P2leiDzEJ/y8Z79dmhUnf78Mq5vQLFBJb/UYfq5rTqu1WY+cVNDvj9p8tXZSNRZ4FY0nHCMhRT8tna4VEJvFFaqU0jIcg6oVnK/Ey2hRnXrvBYhoqwK8ZOR0zVkLE9R9AfLlXflTN9cgcuGM/xcb9LVoeJtT5AO71s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JQjxG1og; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2025031eb60so2686625ad.3
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 19:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1724295297; x=1724900097; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zhWiSa556sTPC6F0S0FwrATNNM1EWGxgxMPZMtks628=;
        b=JQjxG1ogJldZ93/FtwuvgWacsKIZq+w/mOkizZX79vkI+c5uh5cdtXk2Vjz43zdoSq
         gZndR2n0N5xLeMvZTlW4aU8hYRCvffkyE7ARkB50dSAusEEZPQHA/CcXCF8HVAcqce3A
         Dl2cfs8j22A+ehLVWuJkdDcgbbhX/pqj8WHoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724295297; x=1724900097;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zhWiSa556sTPC6F0S0FwrATNNM1EWGxgxMPZMtks628=;
        b=sCyCWi/B9Bq5+VkVdvj+j5ZBuzvzc4P/Fu2ddmjKDrM8TEGNpX/U3fLdC4Jm3ftzdv
         NFaYSIpKG1REzwa/OnWnqPLvzwrYEE8qXXag9suQcNfkKnMn/ypi3LqzvW3f7pZja49B
         q1D4oL77EHXOpIkQfV4GSBzO7ydlbgyI/JBSyTLTtiv19B455zu6z43P+XFKbkgDFFQ5
         gShaPEriOreQf9/cXiFWSf81URfPpo7lr0ksAIPkx+dL0OhdTx+q3zlZwJTFFya3pxpT
         zVoA0GPBGHoKcDLRpYMlzP3L5x0zjmLB80qRZo5mlkIDQOzpVmH4JBo7OyWjKAdcvQyD
         pqxw==
X-Forwarded-Encrypted: i=1; AJvYcCW+ort21dcyUQp/EqKr3uJxSb036YS5ZFs+bizbLYpn+tOcM1WgtMyWF0G/iyR/l9wCbC83N3Pgyw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxfoGlvEOSegxQaIvUXXutzWcGdRSn1iefxdMQVfUxca1Kozy/
	wTwh4BBrBBfpRF4rygGLmtt8YGHfGFnjExKftukxZHQEyoHCoiyWX2l1b8kJ/TE=
X-Google-Smtp-Source: AGHT+IG6hrenDBYEjjzI4UFXPGM4j1J+MoCBgMYKOWHdToNRH3bu2TqLfyElWzIJf2zDvhrXCBZb2w==
X-Received: by 2002:a17:903:234b:b0:1fb:8e25:e631 with SMTP id d9443c01a7336-20367af1b5cmr53759045ad.8.1724295296858;
        Wed, 21 Aug 2024 19:54:56 -0700 (PDT)
Received: from [172.20.0.208] ([218.188.70.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385ae7b1bsm2750365ad.262.2024.08.21.19.54.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 19:54:56 -0700 (PDT)
Message-ID: <df08390b-f265-4031-b55c-1985730dcdf6@linuxfoundation.org>
Date: Wed, 21 Aug 2024 20:54:53 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux repo contribution
To: Galib Gurbanov <galibg@crocusoft.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "shuah@kernel.org" <shuah@kernel.org>, "trenn@suse.com" <trenn@suse.com>
References: <212551724219199@mail.yandex.ru>
Content-Language: en-US
Cc: Shuah Khan <skhan@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <212551724219199@mail.yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/20/24 23:55, Galib Gurbanov wrote:
> Hi. I have one mini contribution to linux repo: https://github.com/torvalds/linux/pull/892 <https://github.com/torvalds/linux/pull/892>
> In my pull request im changing 4 typos, nothing other is touched by me. Can you accept my pull request? Thanks.

Sorry we don't accept pull requests - As suggested in the responses to the pull request in the
link you provided, send us a proper patch for this change.

thanks,
-- Shuah

