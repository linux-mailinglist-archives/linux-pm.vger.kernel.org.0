Return-Path: <linux-pm+bounces-20740-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2594DA17760
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 07:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C9F03A8063
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 06:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF17D192B8C;
	Tue, 21 Jan 2025 06:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u8kQjO03"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4019F154C0D
	for <linux-pm@vger.kernel.org>; Tue, 21 Jan 2025 06:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737441481; cv=none; b=RZYm271hd9HDiY0eEi1pG6HA27aoJKD6Eh7f0yvH1rDWnfcm+LqJrTlPDuQDwxPSHa3NV7JFiED1Vtm0I+rGQ3N/d7Qn/bBd81xggxiTo7grUWtlvr3vGZOt4PYmfHQCz8EYQT0JtFRY4FT+x0aVJeBKHalDs8R1Km2S83VdhYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737441481; c=relaxed/simple;
	bh=FdZGtAaM/TXT0Jr+7xJOqpe1COzhlczVOT6FVqXwtlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJ+QetTxRzEI0rkv3UZtNxa0YyPdN5MVRmmxwdxXWnL+2DviEu39/ajZA6LlMazuBIuc0PNxtSSp1vf6BFVhiKQmzyteKUdJkyFDJzQvKvHpdC4qJtqFQUHmTznqs8jXJwS+w5n0idNBN4X0x4nvcBUMHZeMovTBTM5SNSa3JLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u8kQjO03; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21631789fcdso75433635ad.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2025 22:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737441479; x=1738046279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V1kXJ0dbTzsw+3qkFK+nnuSxVs4azc6yWs2Zy5LVe+0=;
        b=u8kQjO03qK/6O+oBISHNZDs2YK078MCYyW12jqIBBitZkM9POhMNaFYEQG8f0lZR8L
         LUBOyU1O3pY/thd61yjO/eE2fSw1Nl3EAV8UF/sAoRyoalVjSpBXn16cIY30Nx3gDCry
         AwWK3G9ZCSVPnX79aS3yxYd4yv+JF+MxeWBXxrA1ZGeXEkxPrGdcMMIPbjs807qa5W7+
         xEjIlxiYCX7AwT9fkNxWPqL571as22BxXaTLLNcwHuqvSSwAiQEZyUoc0CZqvSSxmOCP
         QE6zBJebg3qVn8Bg2CUteS1lQqJfEscE4aFWIK08hSiZWnM+FhgW2qQVyzf9RPIeyxcL
         mgsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737441479; x=1738046279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V1kXJ0dbTzsw+3qkFK+nnuSxVs4azc6yWs2Zy5LVe+0=;
        b=hcDjYZJaAYKtyDdndGzPX6+5Av40kISKeXYp0A8g5pK1arEJ7OLKH+ocexQaYqsm9N
         D2VgeaAmUtT9Lx1xK8ksg2HZ+Td9z5Jd2TTNyx4cdeXyHXUg2hmnBsosC/SCVSQRDiwy
         axhpLSk+Xw1LiHjnwK7ud1y/KY6+2/+D0ZfolB/UQdgWk4f5fHg6Gpiq8HTk21uh8/tT
         VRd7h3YWvkseSte+igCm2YVPZvBsYmzOe04pfESc9xHj2R6zJBGAgDvJqaLyXNw2Xycn
         4zxEr4pFD91wC2RTjvY/TSINEXVgaiT71gcuLmv8uvsq7NkaX9od/6lvmRL5kd9mT9Qb
         ahpQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1dZL4lEN/e4lcvgIbeWQbYYy41Cs5evqcXz7pJpVHUatisDiQv73YfDKdGuvtlrHNhTqpXhN7+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBYQb69X48TRJU4wk/+LfhVAdCF6VfO8LJ65oo6ITbo1bUn7/O
	aM0V/tc1djHp89t7Junql9/eX6nYIPGf/lPmJpQSZgO4KrduEq7Y2d5yfOeoWG0=
X-Gm-Gg: ASbGncuNUqeLTJJ70dRJq1A9Q/dBo5rgq3IkKlQyQFO3Oz2IllI3H7i21KMM/xx7vW0
	t2iG2cmMH7Bx3cmc3768+9BDJP2f56LDD0clI6Ydt8eoxtC1YvXfx+D+z+ZNBQhVVz8Ut/eTubc
	+vr22EEK/c4s1ij/peX3AokMJSLrWidCs6G7XjM/kcG23kjJY3MObLLo5xwLY1tdJteGM6pY2T3
	zQ1oDXFmHPHDIsW4wXkCgTSoopyqg3POz7bRxdn9zbD3WfqGO9olcVSOvdAxThAOohqcHhR
X-Google-Smtp-Source: AGHT+IF4tI8Gk35yzbZsOpYJY6h2+3h6rRku5D5843xUPH4A5zFeTN1f55KTda1Wh+k3REjGZR5L7A==
X-Received: by 2002:a05:6a20:7355:b0:1ea:f941:8d8e with SMTP id adf61e73a8af0-1eb2171e8f0mr23188974637.16.1737441478374;
        Mon, 20 Jan 2025 22:37:58 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dababc2bfsm8381451b3a.175.2025.01.20.22.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 22:37:57 -0800 (PST)
Date: Tue, 21 Jan 2025 12:07:55 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxarm@huawei.com,
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com,
	lihuisong@huawei.com, fanghao11@huawei.com
Subject: Re: [PATCH v2 2/4] cpufreq: Introduce a more generic way to set
 default per-policy boost flag
Message-ID: <20250121063755.sdlbaeappbhobihg@vireshk-i7>
References: <20250117101457.1530653-1-zhenglifeng1@huawei.com>
 <20250117101457.1530653-3-zhenglifeng1@huawei.com>
 <20250120090102.erm2ffkbnwa5vraa@vireshk-i7>
 <0c910772-368b-4e30-9ce2-1f68510703c4@huawei.com>
 <20250121042024.pstn2otfqnnajgxl@vireshk-i7>
 <2f9433f1-a826-4198-b4aa-9089f566916f@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f9433f1-a826-4198-b4aa-9089f566916f@huawei.com>

On 21-01-25, 14:22, zhenglifeng (A) wrote:
> On 2025/1/21 12:20, Viresh Kumar wrote:
> 
> > On 21-01-25, 09:45, zhenglifeng (A) wrote:
> >> On 2025/1/20 17:01, Viresh Kumar wrote:
> >>> On 17-01-25, 18:14, Lifeng Zheng wrote:
> >>>> +	/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
> >>>> +	if (policy->boost_enabled != cpufreq_boost_enabled()) {
> >>>> +		policy->boost_enabled = cpufreq_boost_enabled();
> >>>> +		ret = cpufreq_driver->set_boost(policy, policy->boost_enabled);
> >>>
> >>> I though you agreed to do some optimization here ?
> >>
> >> Sorry. Do I miss something here?
> > 
> > https://lore.kernel.org/all/17c7ed77-21f1-4093-91fc-f3eaa863d312@huawei.com/
> > 
> 
> I think I already done that, isn't it?

And I misread /facepalm .

-- 
viresh

