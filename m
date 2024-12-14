Return-Path: <linux-pm+bounces-19231-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3DF9F1C17
	for <lists+linux-pm@lfdr.de>; Sat, 14 Dec 2024 03:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 383CF188EADF
	for <lists+linux-pm@lfdr.de>; Sat, 14 Dec 2024 02:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE2F11712;
	Sat, 14 Dec 2024 02:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="wWq8rTej"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6081C36
	for <linux-pm@vger.kernel.org>; Sat, 14 Dec 2024 02:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734143218; cv=none; b=sP2CP1zqSnxt2avL6vn8LxBRphCQr5yOGa88vahx53TOfnwrHo6yA+6fYL/0EMFuO8T3FvT1fYsFJPkvykX8BW3bIrUUZsdC6MeY8Doqq8A12J6a5gbx2/eLcDHfp7mbmZeOowWSvp7z4Jp416rTi+UGOUYguHKuLBfE3um/Xd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734143218; c=relaxed/simple;
	bh=Ao1NMpM9H0qoA13oyUJCPZXljfgJn720+aFyXdx2FXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eqYLExZ9y5ThV2xir7wMSki4AuQYMsL1CykEQNSRERPMeN7Q7ynXzGW2XJjQJQjWcaZc6TIwdGYR+vOBPIRJ4foHh4agFSavyC4aLiqEQfQEW0XxiYbDTdhj42UuMnfYH78ACe0edmQvgUwAygwMKAsJBoEzzGvgJVZa5jOitVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=wWq8rTej; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ef87d24c2dso1809317a91.1
        for <linux-pm@vger.kernel.org>; Fri, 13 Dec 2024 18:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1734143216; x=1734748016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k1GXrUV001dErBvzcYJfNgPyRsL7+homNHBWUvWv40M=;
        b=wWq8rTejur1ydABJrmd19UajZFkpYd97WL6paPNR66VxgqDXOfpSu6dcIJlbMcxcF2
         QP1qGD8dKehDGXTI6ECNnToH4o+g5VQjmJ+olXaRveVjDcnvux0znflAt/MzaHSSPBK9
         8a7XXOyZp7GGIIyW+IcDYuQXLPJR8MuajWMc3ey1YjAHUJ12L2a7zZAz6ytpt6m/H3ns
         eS64V6wcp7VuYj+yLpjGcZfOHHFCgO/1v6bbGKqZ+Tjqh0CxRmR9wjQnNKsQdL0YsGSm
         bJMdOqrXC0WqRK55966iJ5eDetwqy5v0lHLpiEWzH3sflOQzBPtD7bacKjfyusN6nrp5
         TtAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734143216; x=1734748016;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k1GXrUV001dErBvzcYJfNgPyRsL7+homNHBWUvWv40M=;
        b=c9RNzobS3Ku/VbD3eGvymgFuUYZJPU/qciY7PfvJeypaEuryrZyEO0psf5HwjA0WUI
         R18OAu6FEnCjktrKNR73ssd2ea9pNe+NK83x/BClTuw/0kr5d5Y7HyN6PBxsYdsQgIK+
         z3cCO+NSHg908UH1oa3LoZkGzy0/D4jYnvJVbK/UqNCqzF50OWrGbTfbDJcXQhLzz4Kk
         zccVv3kiwH3sMfJcBsbUxhrFhzgVbQtBbSIdKB+2KwRlqEBCuMP3TjJav8imyExoV3mT
         blYvsYXHcUfkLUrd0qYd9/KmEefVep/UUjkoTFMwkOvVHKK1/kY1TjS6C7pL21VzlPXo
         MMcA==
X-Forwarded-Encrypted: i=1; AJvYcCV6TOG/6AltlvuxKgt23FQZ940dZtEsKUd/Sg7Wo+h1niWz2zMq9KbhwhBu/1g4kdMz6BR/VVqyjw==@vger.kernel.org
X-Gm-Message-State: AOJu0YycamszAN2upS3v7j360qHhj3Dd4aomkR/ZmHm5Y5NOdsfDSPw7
	GNHR1ywrAaRRLUS5p5zcBOufFL44uxNxKoixiS2aP3y0NTie24crcN7KPtIm9wE=
X-Gm-Gg: ASbGncvTdrrZXgfh3mFiZS6F8zRzxlIWa2GVimZIXGGCorClTnLFbZB+sFbdpMqjCo+
	+CouiJ/bg61tp6d8QbbG/gP2nDkpV5IsKHLfBVRbgbn5dUEWHWq9bStMfeiHCRREqnSUwsBqcg6
	u1e2uWmiDdMOsIHIiN8BFTR0UX7e2unXE/jOY3S6kQyZfDUKkcbaQoKqGwg11Ecx0CwWpFTmilT
	B51Z5cKOtVXUv+Sz24IIcZ8zqTsxznXOyapMR2Bf4H25zPbHxbjWd5LStO1ovQZafCQJGQVy9ex
	5eCnioEOmp3xtLjquCM908hkvx3DOi+lQA==
X-Google-Smtp-Source: AGHT+IH5JoWIXpfewW3B4IHy8HMSuUfyPLEMNUb8eLGidzqep51HdSMVZcLn/JASahvllA2PNckiiw==
X-Received: by 2002:a17:90b:3fc7:b0:2ee:693e:ed7c with SMTP id 98e67ed59e1d1-2f2901b1169mr7734298a91.33.1734143215700;
        Fri, 13 Dec 2024 18:26:55 -0800 (PST)
Received: from [192.168.0.78] (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1dcc4e3sm4203355ad.69.2024.12.13.18.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 18:26:55 -0800 (PST)
Message-ID: <8219826d-62fe-406f-a750-6e901dee0690@pf.is.s.u-tokyo.ac.jp>
Date: Sat, 14 Dec 2024 11:26:52 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM: wakeup: implement devm_device_init_wakeup() helper
To: Dhruva Gole <d-gole@ti.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
References: <20241213035235.2479642-1-joe@pf.is.s.u-tokyo.ac.jp>
 <20241213092642.sq44raaty2ub6c7s@lcpd911>
Content-Language: en-US
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
In-Reply-To: <20241213092642.sq44raaty2ub6c7s@lcpd911>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dhruva,

Thank you for your review.

On 12/13/24 18:26, Dhruva Gole wrote:
> On Dec 13, 2024 at 12:52:35 +0900, Joe Hattori wrote:
>> Some drivers that enable device wakeup fail to properly disable it
>> during their cleanup, which results in a memory leak.
>>
>> To address this, introduce devm_device_init_wakeup(), a managed variant
>> of device_init_wakeup(dev, true). With this managed helper, wakeup
>> functionality will be automatically disabled when the device is
>> released, ensuring a more reliable cleanup process.
>>
>> This need for this addition arose during a previous discussion [1].
>>
>> [1]:
>> https://lore.kernel.org/linux-rtc/20241212100403.3799667-1-joe@pf.is.s.u-tokyo.ac.jp/
> 
> CC Alexandre who I see is an important part of this thread.

Yes, just sent a v2 patch with Alexandre in CC and in the "Suggested-by" 
tag.

> 
>>
>> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
>> ---
>>   include/linux/pm_wakeup.h | 27 +++++++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>> diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
>> index 222f7530806c..baf4f982858a 100644
>> --- a/include/linux/pm_wakeup.h
>> +++ b/include/linux/pm_wakeup.h
>> @@ -240,4 +240,31 @@ static inline int device_init_wakeup(struct device *dev, bool enable)
>>   	return 0;
>>   }
>>   
>> +static void devm_device_disable_wakeup(void *data)
>> +{
>> +	struct device *dev = data;
>> +
>> +	device_wakeup_disable(dev);
>> +	device_set_wakeup_capable(dev, false);
>> +}
>> +
>> +/**
>> + * devm_device_init_wakeup - Resource managed device wakeup initialization.
>> + * @dev: Device to handle.
>> + *
>> + * This function is the devm managed version of device_init_wakeup(dev, true).
>> + */
>> +static inline int devm_device_init_wakeup(struct device *dev)
>> +{
>> +	int err;
>> +
>> +	device_set_wakeup_capable(dev, true);
>> +	err = device_wakeup_enable(dev);
>> +	if (err) {
>> +		device_set_wakeup_capable(dev, false);
>> +		return err;
>> +	}
>> +	return devm_add_action_or_reset(dev, devm_device_disable_wakeup, dev);
> 
> Why not just call in device_init_wakeup which already does all this for
> you?

Makes sense, applied in the v2 patch.

> 
> 
> Then the devm_disable will just be device_init_wakeup(dev, false);
> 
> 
> See for eg. how runtime pm does it:
> 
> 	int devm_pm_runtime_enable(struct device *dev)
> 	{
> 		pm_runtime_enable(dev);
> 

Best,
Joe

