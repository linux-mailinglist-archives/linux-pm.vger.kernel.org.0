Return-Path: <linux-pm+bounces-13344-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDE596860B
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 13:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EF301C21A5A
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 11:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326B2183CB7;
	Mon,  2 Sep 2024 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZP06Prr1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A27A13C684
	for <linux-pm@vger.kernel.org>; Mon,  2 Sep 2024 11:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725276027; cv=none; b=JjANVIVF/WsnPZvig2/scAZYTngLfp1HNHC7EnQjpjHL2p6eDRYg6msCG1N96jpsX9PMSdp7h4wBiJdgSglq2x3D4YTNBjIv/XsuSD31EVFXtRKduVNDeeQ+xcazTwWlz48WTsxsGtvbjr8ZoMsj2ULmJFNHi+QqxnpnefKXu98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725276027; c=relaxed/simple;
	bh=HtbwaAaoh93xosC7lfmEKanN38iHGUEf0zbC1fTpp7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=upZ4IDEUe3YTMrwE6yTLqJuCFzxyvDn+06Xsv3I8H1hA4rq2dYSeE0/gE5amUi0PAxN9ZDtdmcf0HH2t3hpLDXS405vk1OLJF8OjCiRhG9WjX8ey2XDVe6t6fiuIBogqg6StOpR7S32qHWYt0te5A0pwLMTgBBCg8EN/j4PsvBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZP06Prr1; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42bbf138477so21274675e9.2
        for <linux-pm@vger.kernel.org>; Mon, 02 Sep 2024 04:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725276024; x=1725880824; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S+dXV/IaXL0ABbzUh8/C/Uds4A4t+Sf0ZZd0WGgnHVU=;
        b=ZP06Prr12TpUJ6EHMNCd5cAneTaZDPo8lOZPbf4/yyBUdBB6veS0X+PE0r8O6pdEjQ
         dS4xrCjXZdyrcejwVlOvuXagKwahgS1IG6+pDl2C3efhuPqycFiIPWuGbz2t62zQ/iEr
         82SY6fLb9aFgpiZd5aik8xS3kO86gr/eta13mvxgrwC2SONrNanJiX4QIFF94QR/tcYx
         S3ezVp+xpRJN4pfsu+esy4bSXY+ikdoaCaDWoaCTlG7F0ILO75D3Y6VebGu7iRStuWzr
         ur2WFBzvpALf8bC/7KtYPIwC3b9EO8/y+OBiM75nBsNNWPngn6VGfAV9qyXflxNfFjKw
         xyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725276024; x=1725880824;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S+dXV/IaXL0ABbzUh8/C/Uds4A4t+Sf0ZZd0WGgnHVU=;
        b=lyIcnPxeXcoJXfxmkmenrm2siJmvptgNKF1c9CJGVvo0Tpul2zWQGeKTA3G3rMUSyP
         GQ/b5fc6STSs5L6AkQe/I1m91l/hXmoH9DzdeUqI7xsXth79E8BmZ4uS61d/i/MLf3QI
         x1XkhDWhrriE+Kr2FUHha/8+lyvb44BTIdNbTHshBXIVTFbhT/ZHouiUrNP6RuiblwNT
         r9cuXY8/SlebLt8ZwPQgfgtI1Q4YrWsWXylO7q3Pn6SabPKMaaHl8jm8Ensjir2yITuh
         oMEYPbBz8LMz8Lq2ji4ajvPvmJvGRNjxi3rAnqRrgYIlVBPgoiiwQ23BBgcScOMwZixL
         Fcwg==
X-Forwarded-Encrypted: i=1; AJvYcCUergwjuoj/a6fJcqdMLd8JtXmkiSASaaj25yjdIG9Dw7HTFVRCRSkP7ypDJbwUAB2ub85F4rulow==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa/eV1VB4WF8yM4O3F+Ka0VLbQJrErlrANFVPJP2Flk6RfJnU0
	K9DRDTxBZU8OEk+soFmA2hMhpsgb1lluWHRlh4H5mH3IMBk68dKlmRClGFRqNY8=
X-Google-Smtp-Source: AGHT+IGW7Ovetjy9+w52NxbgSe9EryfuVbQqnUmHxTrTdLjYygiIRZ8Qo4UNA078A1ISqoVtJJZ5Yw==
X-Received: by 2002:a5d:5581:0:b0:36b:a2bb:b374 with SMTP id ffacd0b85a97d-3749b584ec3mr9236392f8f.52.1725276022992;
        Mon, 02 Sep 2024 04:20:22 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3749eea50dasm11162271f8f.56.2024.09.02.04.20.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 04:20:22 -0700 (PDT)
Message-ID: <0d26478c-2ffa-4ab7-904d-aedd6a8e7d41@linaro.org>
Date: Mon, 2 Sep 2024 13:20:22 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: ti-soc-thermal: Remove unused declarations
To: Zhang Zekun <zhangzekun11@huawei.com>, edubezval@gmail.com,
 j-keerthy@ti.com, rui.zhang@intel.com, lukasz.luba@arm.com,
 linux-pm@vger.kernel.org
References: <20240812125210.94280-1-zhangzekun11@huawei.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240812125210.94280-1-zhangzekun11@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/08/2024 14:52, Zhang Zekun wrote:
> The functions definition of ti_bandgap_read_thot(),
> ti_bandgap_write_thot(), ti_bandgap_read_tcold() and
> ti_bandgap_write_tcold() has been removed since commit 9bebf3485c6a
> ("thermal: ti-soc-thermal: remove dead code"), remain the declarations
> untouched in the header files. So, clean up this unused declarations.
> 
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

