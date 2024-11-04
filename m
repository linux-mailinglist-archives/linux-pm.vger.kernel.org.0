Return-Path: <linux-pm+bounces-16928-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F87C9BAF5D
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 10:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60F991C2467D
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 09:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715151632DD;
	Mon,  4 Nov 2024 09:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nLak1cwQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49361494DA
	for <linux-pm@vger.kernel.org>; Mon,  4 Nov 2024 09:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730711718; cv=none; b=KOVKPRUq9RjhFgYLJAPCUX3T96KklGfg2BnKarBQPPONam0PjfVcjP8Djj5MiZfaJIOz1QuM5dVrF3BBToHk+go6GfHKJwpAgW817yO8IIHt77mAftVBC2aNR42D6KrFhrC8gGhH7YAgrgean5WAELQCyNqfTRuumQsBZ79YSXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730711718; c=relaxed/simple;
	bh=dYVkoC8qQAE2PBdJGIGIvHnVo6H9gaMACJ2ZD4GkPTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDt4WKkTttlp/YH+ftZabl4Dc7z4pZAcPGGzlxFCl0u7GxTH1yxB1i3MgvCcfSES8LmCyKzxQeUjxdZCfEcPvikfyYsXzR9mB7TeBKXfKqTQUfFHxfCkVkg7hHr084zTtFpjjdBAywtYtPSiEjDBqfpS9fV0hEPOob32VX85gY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nLak1cwQ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9e8522c10bso240832966b.1
        for <linux-pm@vger.kernel.org>; Mon, 04 Nov 2024 01:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730711715; x=1731316515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dYVkoC8qQAE2PBdJGIGIvHnVo6H9gaMACJ2ZD4GkPTQ=;
        b=nLak1cwQkMsgikLT3BpGmHLoglmJMlGUUKCYJ8h4H5D0PFEM93mTn8jfW43MRM16Df
         bIGtnE22JQL8WRTNcjcS/u9hpk0ievJpcBPSIp1MxnGYCooiqzsqZ7Bg/I6vawGqMG+w
         ScJmn5JA3hMXVDdH1PX3hhm1fcPDSo7DeBQzr7gfIUydd52Iy6LcomHovmExIvn0HrYV
         2hjg7BJgOmpPEumb3sXujwfQLgO6JUHshtQ+8Zv0Zb2fxvTrHR0o9hwubTd0dbnO9HPP
         jt9Oct2zw27xZmMCdsUtXsRVhFT7EeVQM8dT8hjFuOFzEwO2vs7gVWnHeDuTqF1sTBMj
         Trew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730711715; x=1731316515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYVkoC8qQAE2PBdJGIGIvHnVo6H9gaMACJ2ZD4GkPTQ=;
        b=RSP6wrJBSsTM/Ks5tjbiN83wUXUuuq8W97/ufcQMlGou2Aw4aeZlgcSnLKEuaJ50Or
         k2IipSupJU++MNzamF5Rgx6XHbCkM2qwmMyA3PqVTIoTG8ptGaZDuGV8a43GctmTCa4x
         8yxGtbMbRPw6cclUgT6YKx2w7XqybZOtmnJdzadcsZTksCAhchsEc3aoistEp4Zh90/g
         CSMkZGt3XS1EqgaJ6oe7gs1M8Selq/3QmMqWVtW/0HwL7g0b+cCz2u1BVp3wHy82Xm5R
         OkLE31O2OgDZ/rXaU2RQAXPiPqRJ7UVVeLXzatsPekEvc2GD10nboKXrFdEXR34Ex424
         2b5g==
X-Forwarded-Encrypted: i=1; AJvYcCV2EC360odQNA3Rkzx81M7CtIpJ/Kpa7tI2BGDy2D1KcRyw++LCfVqq7JKLt8M57P8dEjXOLoC2uA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpliqh668ySWzMobdBh6At3DeEG2/VXAYm3kjekZKtsxGAjpXR
	/uflACJOfh47W2er5w2UhWBqqpjzEVSylW1b9BIDvYIs+0fG6cG7+xSxdqHWww==
X-Google-Smtp-Source: AGHT+IEvXzMmWnK2YXMCd9hjcHNO93GnMVMN6VzlMlbNRo53oIfLHWGpTiQQ4J66GXfSZmVa6UQBeA==
X-Received: by 2002:a17:907:82a0:b0:a9e:85f8:2a49 with SMTP id a640c23a62f3a-a9e85f845a8mr437389966b.8.1730711715040;
        Mon, 04 Nov 2024 01:15:15 -0800 (PST)
Received: from google.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564cc5e4sm525678366b.89.2024.11.04.01.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 01:15:14 -0800 (PST)
Date: Mon, 4 Nov 2024 09:15:11 +0000
From: Quentin Perret <qperret@google.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
	daniel.lezcano@linaro.org, lukasz.luba@arm.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM: EM: Fix uninitialized power in em_create_perf_table
Message-ID: <ZyiQnz4jbB5ChNxn@google.com>
References: <20241104090351.1352997-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104090351.1352997-1-ruanjinjie@huawei.com>

Hi,

On Monday 04 Nov 2024 at 17:03:51 (+0800), Jinjie Ruan wrote:
> In em_create_perf_table(), power is uninitialized and passed the pointer
> to active_power() hook, but the hook function may not assign it and
> return 0, such as mtk_cpufreq_get_cpu_power(), so the later zero check for
> power is not invalid, initialize power to zero to fix it.

Sounds to me like a driver bug? We check the return value of
active_power() first, so if the callback failed it should tell us.

mtk_cpufreq_get_cpu_power() should only fail if we couldn't find a
cpufreq policy IIUC, so why can't this return -EINVAL instead?

Thanks,
Quentin

