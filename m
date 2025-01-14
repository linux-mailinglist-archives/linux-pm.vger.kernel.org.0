Return-Path: <linux-pm+bounces-20432-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BEEA11022
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 19:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB5AA188B15A
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 18:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AF51FBE9C;
	Tue, 14 Jan 2025 18:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kMJaW8yP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DA81FA27F
	for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2025 18:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736879436; cv=none; b=iiY0mw3wqocZNzFKbx652ISxN1osUtqN0dB9F+YqJd9MyS5DU86ixf1EilE3BUG49GY84etyGzTvl0PkMbmvdhkrUC/5QC8O1jJz/0fksYxfMy+/9r1D82egLk2x7oEKYXuDzs+/hOp7xOoFzhaRWDRVJ5epfAGNnHS/2WYwh+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736879436; c=relaxed/simple;
	bh=iPnisaLwyn4uRPEB7WDrZKm+oOwdziGvVmNWYObjYxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u92BiGGpcDIhNg1JBhB9mqx6y+MGp761itWs1c+ufzGqVi8+yVbE2fKhl3SGny8hMWIydjPaw+uSKVtpJcBRMykI3YlrMDfKFaH47wbIhqWUOahKYREoLBm5jPNzqDE5ylvSNzF+MS4TEtyYHSf72xSpfYanfm2XoX0uWXYrWWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kMJaW8yP; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4363ae65100so61651835e9.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2025 10:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736879433; x=1737484233; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xWXRGYqIYfAFCWYGR5cc8ElnhXv1e/ZNViY5lKk/9zc=;
        b=kMJaW8yPRv8X4zaUbVBHAP5OQmUfkdnaFTyP7w0M5dDIwBr0GsjckEDDIIHo9QxJBG
         s0wqC4ofd0q7jDhobybdUjfMc0edDKl3x44coof7CsyDUT+ZzJ58r1Csl884aU6TLZ5o
         C2qln8ecBjXRFzyJVNSNlrqMECMh9GV9Q1/t8MjdLFtaPKuSecnifjefnBrf+EgU5jgK
         bq4JZV/JSmoz4N9zGHEkMr3ivTOCwoxK5d/O3+EOad6F+LSjtUj0Skzoql62MD5NlQ+3
         CnLzlP0kArjypX5MbfOM414hpNBDnCxcuMeypX8QFfW7knJquIt4aE0LMzzs3Nid3zZQ
         Ky4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736879433; x=1737484233;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xWXRGYqIYfAFCWYGR5cc8ElnhXv1e/ZNViY5lKk/9zc=;
        b=lM7KM1/7uF9LVeRuXxzmzmsRRfl1cYdi6XJ2DI8jcX7RBrNjkmtYBiuLqsxPwby//R
         uz1PcaJTG3Mcj+yj5PyvMAiH8deQXHFsUCFRDpiFvf+M23RZ8r40PLW+SSytpzk0/xni
         YCUIFE1YoCI09kiEISdu8y4NgvPJ2hK4vjNEvbnKRHn3Cj8QMokl4nyKzpyFerWAIodV
         NPX7Da4W4ayXKfLg+5zRpcDMaQjbxmPpSfwT+FiJJWQMMhcCESLB3cXtuEMC0UVzUCxF
         fXcmYXK1MADewv+cb3LNQsxLIBIFH72DJ7qTfNodGtq/n0ki2GrmTWhNXCFGLyAtuQjH
         zxIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWW9nAVe+GyELg9SM3Lt8/r6SmG/d3Pyeu97arFoaAPYnJQT5yJ80QnVERrVn9Ir8B7sFIHVj6+Ig==@vger.kernel.org
X-Gm-Message-State: AOJu0YxlDCpwt16cALWc+4HNXeOMME6a9w7bl3QzPgTaGGd7kqgojrOY
	FVMAh5jNmM/iqE3dx7lluP65Fk+eU16nbCNyTwuDpUWszE/+ftmyJpU8ruw8/Uc=
X-Gm-Gg: ASbGncszKIy5DMy+3Uc9l9L2XhCmMgwECK0WMzAxmDsUUwUCgRlwMdl1T1ICfPCJjMx
	Qxl901el7kzku+W/qNEPv29YWPcnz1jtyVqxpyIyTfhsZcVExs+1fZP5xS24p+6ruXyujzcfbt1
	xF+k2SI6azGxvTQ96DQ2/Txh1FP+Rp8xO3kbSzyjOU6ny2JhhIVwNp0W21O2p3RKB+Nu7jLoF8b
	c4zAqk5FQ72rXU78MgsTo6R5NNoHwSSEd03TnWBVIc52TsKIugx/NhgkJ56wqA27mcfTQE4uuYE
	MHr8jGagwXMuMblvD20+
X-Google-Smtp-Source: AGHT+IEw8eHOips+m7BEL7pSk31Buqsgjf/0/YmNKYluWgMpJRjDHqhoLciiG4fuvyVDzaS9gJVk8A==
X-Received: by 2002:a05:600c:46d2:b0:434:a1d3:a321 with SMTP id 5b1f17b1804b1-436e2679db4mr237168165e9.3.1736879433323;
        Tue, 14 Jan 2025 10:30:33 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-436e2e8bea5sm217789155e9.31.2025.01.14.10.30.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 10:30:32 -0800 (PST)
Message-ID: <90dd8d93-5653-47f1-8435-f03502e4c0cc@linaro.org>
Date: Tue, 14 Jan 2025 19:30:31 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 3/5] thermal/drivers/mediatek/lvts: Disable low
 offset IRQ for minimum threshold
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Alexandre Mergnat <amergnat@baylibre.com>, Balsam CHIHI <bchihi@baylibre.com>
Cc: kernel@collabora.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Hsin-Te Yuan <yuanhsinte@chromium.org>,
 Chen-Yu Tsai <wenst@chromium.org>, =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?=
 <bero@baylibre.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 stable@vger.kernel.org
References: <20250113-mt8192-lvts-filtered-suspend-fix-v2-0-07a25200c7c6@collabora.com>
 <20250113-mt8192-lvts-filtered-suspend-fix-v2-3-07a25200c7c6@collabora.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250113-mt8192-lvts-filtered-suspend-fix-v2-3-07a25200c7c6@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/01/2025 14:27, Nícolas F. R. A. Prado wrote:
> In order to get working interrupts, a low offset value needs to be
> configured. The minimum value for it is 20 Celsius, which is what is
> configured when there's no lower thermal trip (ie the thermal core
> passes -INT_MAX as low trip temperature). However, when the temperature
> gets that low and fluctuates around that value it causes an interrupt
> storm.

Is it really about an irq storm or about having a temperature threshold 
set close to the ambiant temperature. So leading to unnecessary wakeups 
as there is need for mitigation ?

> Prevent that interrupt storm by not enabling the low offset interrupt if
> the low threshold is the minimum one.

The case where the high threshold is the INT_MAX should be handled too. 
The system may have configured a thermal zone without critical trip 
points, so setting the next upper threshold will program the register 
with INT_MAX. I guess it is an undefined behavior in this case, right ?


> Cc: stable@vger.kernel.org

[ ... ]


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

