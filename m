Return-Path: <linux-pm+bounces-29664-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 356A8AEB792
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 14:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88AE93A7DA0
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 12:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3862BDC37;
	Fri, 27 Jun 2025 12:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iaAia7Bz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B923298248;
	Fri, 27 Jun 2025 12:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751027007; cv=none; b=iUB8C+ByCh1GKzR4SkgjplOgiOid8miBtIXLDmHJbq49Xbr8xonCZYNu5Hfl6rLoFMnechRkX+1fj028XaMttLqY9sELplt7+kWivRcDVhK7HPkJsl/DS8nxXaEZWPPfb6y/SQzj/L/ImGTH5pgoKEQj6F4bZTIJuepOg3ZNrfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751027007; c=relaxed/simple;
	bh=TKE/PcirYgBaEnKVtc6oY0F6itZHLZa+hSxsQ4xJUJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XMyOsNeZyJTrFFitwn69zeJQB9o33GdR+UPfOpRIl5dr8uWhISaZGjY9XoVjBYq3gH6Zayi0egwgSaivKgXMK+ipR5FGZJQhgzUSDJ9z/kOAKl/DR8sQkqrPJgU6DbixynX6KCfwf9VCPUhmiagWx2nYcwdP9uuIbIhNoh+clfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iaAia7Bz; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-451d54214adso14705075e9.3;
        Fri, 27 Jun 2025 05:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751027004; x=1751631804; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8uHDdjuJYEAU1yduIeaRva64ieAw7KTAi6gEOcE+hfA=;
        b=iaAia7Bz4kXZ0lNWLMftRiRMejO6AFiMgaRJ27Rza3jg11H9wo83qOrV9xnSiIE2R4
         6qiHkCRVuZzUVWQRr0FnDtFdI/lcNr+/RexxZBNZol7AeRv+8pIArLPJevNQ5xWnkV8o
         nKx9hEqS2HsygD656x77jmYVy8vjXvfpNsuxaymqNm49M2aNl22ymiyrPBqoUUYXMIG9
         56CFDwjQTTQZ9zo1EsklQ4qB0DBNNBDvh60L4Bb2ErPZewPcbwgZBYGCU7ydV+X76BMk
         uvmFr6jN0PYwCI78ssgjp0XNJvv4MzCRIjQO2Nl5wvj061C4k5wm2ej6/dSV4byOD75h
         cVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751027004; x=1751631804;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8uHDdjuJYEAU1yduIeaRva64ieAw7KTAi6gEOcE+hfA=;
        b=MldKRYSIKMJL0uYagKlA0PqyrrbSNKNxzbNfFnq7GkYinzU5tFkniOY0TsGI2cTylj
         WtWMk4rIXoJ1buJVD+P4eWemWr9d5eJpVI2laHLKbIiB21+oGyrAk299wqtLfjCYUIxL
         1eabsqpaUZGwxNraPAfv/LH+1hWe5wACuB792TPVGUV4kLMS4vq7RXkQMGqDe24uPLUp
         QQqBva2XipLL4mNOHpXpDhNLvRU1w+fQVl3lAYawoARU5F2THi2aNLVDDNeKsoM/r8FM
         tf3KR2wE3hdhBcfsvR6tM6pHQOjPsBFz55/3tRFuHDle1ue1oYarlls1RqFBKvZFyCu1
         7Jfw==
X-Forwarded-Encrypted: i=1; AJvYcCUMUfDHrPe/CL4HjtDN9oFFaGKRtlHTDcLoXng4IUEAxRqQNIsx88J3cQodT0UmRTRRsUbdZ/MxthOd7Tyi@vger.kernel.org, AJvYcCWEcxt8Nwc3xt2VR2czdi9D6EWPd/G9nnCHKhSVVOPE8bwaV/wECP7mJ66O1yl4CiQ2o9TkoOBTv2I=@vger.kernel.org, AJvYcCXFMJ0+kB0kn48Hj1j5XO0ihIQNEODzBuAwkMdIh5/sZtT7fGBPaaQtrNdPyz30vNiaw4XF1+AesTynUtHn@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo8kp5bE4XVEIwL69QV0Jgthib8KJgcZ6rUh8zonB0WptcXAMu
	4d712fMg6xPEbC8f0LfdvtNPdKLRPdjcJjrqUdqnpS7kP2bUJ44xJJRN+BfbX8jL
X-Gm-Gg: ASbGncuh/j45iMtu9fQARruyzBi9b1R1V8Smv2U4xsyXWzsgPxmw6jFsP4YMzCEaZuy
	SWFMOQJnjnRFsH8q5eq55DqADfhQlr3qhgAV3GalV1BA297RXZ5oBcrHxoePi956hv3syKDVKcE
	0RF76w7HuxvhrT1SlfxekOLBh82/8nQKlPXVfJ6fM5wlGUizXvxa+46uZ4IFKe/WVy6dkc/KHrl
	u4Mk0r4TZ2LiLOuVhg6juzZBveuRJ0kljmE1ytoy820TVV1uTtIkTQi3aJppDgvQ74sME5o/iFQ
	hkGV7IB93Y1CCS9M1d69oRRY/0ZZrY7FjblNa3BPiiRxptAzlkgq0n3B7qNdXXfLYE3u4UENdvx
	eMn+UdWjrSm/VmBT/pBVLFDKYzwY=
X-Google-Smtp-Source: AGHT+IHHNyiJnortXGltf6dobXUszzMZIiEWCBoSFL/rKagraeF+X9BVsxcCM0pKIkAYOK9PI1rC+A==
X-Received: by 2002:a05:600c:4446:b0:442:e9eb:cb9e with SMTP id 5b1f17b1804b1-4538ee85917mr28872705e9.26.1751027003516;
        Fri, 27 Jun 2025 05:23:23 -0700 (PDT)
Received: from [192.168.20.170] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823c42e1sm78774495e9.37.2025.06.27.05.23.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 05:23:22 -0700 (PDT)
Message-ID: <85fa756b-9f18-446e-a50a-2aafaa40744c@gmail.com>
Date: Fri, 27 Jun 2025 14:23:22 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] interconnect: avoid memory allocation when
 'icc_bw_lock' is held
Content-Language: hu
To: Johan Hovold <johan@kernel.org>
Cc: Georgi Djakov <djakov@kernel.org>,
 Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
 Johan Hovold <johan+linaro@kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250625-icc-bw-lockdep-v3-1-2b8f8b8987c4@gmail.com>
 <aFvr1zSkf4KmIcMT@hovoldconsulting.com>
 <aFvuiVX0kMIqXQtZ@hovoldconsulting.com>
 <84b94649-a248-46b0-a401-772aeb8777a2@gmail.com>
 <aFwBYRF0wJwVDdeX@hovoldconsulting.com>
 <ac5ba192-b538-457e-acc4-c2d358b1fd0e@gmail.com>
 <aF0TIWfDI4M1azzc@hovoldconsulting.com>
 <3b90caec-b4c0-47d8-bdd7-1a7abd5e69d9@gmail.com>
 <aF5EPhd5smrmB38Q@hovoldconsulting.com>
 <b960680d-6c5a-4130-b2dd-4ddf1f800430@gmail.com>
 <aF5nv6TQoyfh7wKS@hovoldconsulting.com>
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <aF5nv6TQoyfh7wKS@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2025. 06. 27. 11:43 keltezéssel, Johan Hovold írta:
> On Fri, Jun 27, 2025 at 11:36:26AM +0200, Gabor Juhos wrote:
>> 2025. 06. 27. 9:11 keltezéssel, Johan Hovold írta:
>>> On Thu, Jun 26, 2025 at 05:00:42PM +0200, Gabor Juhos wrote:
> 
>>>> Despite the note above, your proposal looks good to me. Would you like to
>>>> send it as a formal patch, or shall I do it?
>>>
>>> I can post it in a bit.
>>
>> Great, just saw the final patch. Thank you!
> 
> Here it is for reference:
> 
> 	https://lore.kernel.org/lkml/20250627075854.26943-1-johan+linaro@kernel.org/
> 
> It looks like Georgi picked up the patch from this thread yesterday,
> which should be fine as well as I only changed the commit message
> (replacing the ipc splat with one from sc8280xp) before posting it as
> v4.

Yes, it is fine. I have tested the icc-fixes branch which contains the IPQ9574
specific patch as well.

Regards,
Gabor

