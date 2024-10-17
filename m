Return-Path: <linux-pm+bounces-15853-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E23C29A1F85
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 12:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 808921F2866F
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 10:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C26B1DA10B;
	Thu, 17 Oct 2024 10:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yj48kNOS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A001D6DB4
	for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2024 10:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729159865; cv=none; b=m1ZWCIg+DAwsch4Dgspd9jvbBowCw3Oudz8Xy5nDV1XZbT1sv+xE89damEYFVQougPcZHiX8+lol0XhBqWj0q2sI+Q9RdtVkeCtfjaIDd07MJvv1VIsC2jHF9dQYFi/fEJSNZ38SrpdbBgvOz8f3EV0iLmsCB9N4RGo+PhZDO2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729159865; c=relaxed/simple;
	bh=lc00AdCTq/2/t/BtdkukbdZlvrRHBBk0m7Agx+nLNRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EAAmWACRtSncljAg7Fml371B60F8VRC4YjlMnwh+Yaymh9ERykGw3/jDNi2BjPzs+azZwXKh0LdS9ILfey48BnqY9ijhmBeVYkNFwGzY9J3wRWkTqCLrF6IrHrpkmpJT1uxNM/XPDZkCvg9FRBt4epNjjhN0TZdc+5+UPFBu/Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yj48kNOS; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-431286f50e1so10916215e9.0
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2024 03:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729159859; x=1729764659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kwSUtbC2QG30gzod5C51rIfQVl2oLZUpp827zDQsEaw=;
        b=Yj48kNOSHe/z1qV06+sEyMnPtZv8Hrj3S2SRAyPcsH3pPOefEhEtd9TBFIJOOzuXDJ
         u6/ndbYAbcln/YE3KHWMVB/5i4RsIvHO/KuhNvep9Cg+qSGpawV+o6fl/7DgkvPPL6Iy
         yH13uPXc4mP3+gPJXDA8DpFaPpD0nfR3Hfn+kiT5IdS4dccwA1w4qCJPtpaQCjnwyl8f
         OsXoBIA7I7fq8zewHLPFAaWM7zqpQ3R50U1tGhLGQoDthSWoAe0Z07jWTMUMCWNZKNxu
         luls8wbWrFzkDZ/2ZHeKIb4wTeDacY3y4cmJHCVPMHyLkp4YbHCSNlnD0s1bso6P685J
         ZdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729159859; x=1729764659;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kwSUtbC2QG30gzod5C51rIfQVl2oLZUpp827zDQsEaw=;
        b=L/qxL9au7vZjNcJfOL8cBfWVP3Ka0GBLeI/fvhDQSVwnTOcKnh5lskGxUlATSafYSJ
         ybPDrBkSxwU4ddo7hDgsOCT+9G9XsypB6U+NQP7mO2J2NbrXLLPnS5euQZPsachIEgGs
         A+SrXR4bFEAL4qxfUAfPiDrV77weQOGi9aaTX//VsNDoE5lOX0THdbTx4mj+A5KY392A
         7BbvioSoGN7EHLCTOSVvgSMt+ED6Enm4o0GEwcrRWFQxRHDKiHHEKvlRRvQmhqWf+CX1
         X4t97Dl1wkLNEOXRAXNeVrAp+ZCUU5CnnQ3puOqw6IQxQgL9nQgIKYvJ/Amj0px9Z9Uu
         7N1g==
X-Gm-Message-State: AOJu0Yy19/GSoYsn7rSpEPdNu9IInv3z9AzsDIDgonHIsqiOGRzCc6Xm
	XrQ0bR3GBoOSbq6tfuCoRrEcPZAEMPyVCksPMNN8zJDuXJJRWUK3EKg8mgqHK7U=
X-Google-Smtp-Source: AGHT+IFDQUgdscbI1Z5kPHdk5TBnLr4yFEtXtID8TH+QUdBD6eqOKePMA6XnxQ0TdtETvjOCosrMlA==
X-Received: by 2002:a05:600c:3d89:b0:42e:8d0d:bc95 with SMTP id 5b1f17b1804b1-431255ceac1mr198501805e9.6.1729159859499;
        Thu, 17 Oct 2024 03:10:59 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4314f1c3197sm37677105e9.0.2024.10.17.03.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 03:10:59 -0700 (PDT)
Message-ID: <523d2a1b-7a6e-4447-b74c-9ccd5a6ff870@linaro.org>
Date: Thu, 17 Oct 2024 12:10:58 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] tools/lib/thermal: fix sampling handler context
 ptr
To: juhl.emildahl@gmail.com, rui.zhang@intel.com, lukasz.luba@arm.com,
 rafael@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Emil Dahl Juhl <emdj@bang-olufsen.dk>
References: <20241015171826.170154-1-emdj@bang-olufsen.dk>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20241015171826.170154-1-emdj@bang-olufsen.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/10/2024 19:18, juhl.emildahl@gmail.com wrote:
> From: Emil Dahl Juhl <emdj@bang-olufsen.dk>
> 
> The sampling handler, provided by the user alongside a void* context,
> was invoked with an internal structure instead of the user context.
> 
> Correct the invocation of the sampling handler to pass the user context
> pointer instead.
> 
> Note that the approach taken is similar to that in events.c, and will
> reduce the chances of this mistake happening if additional sampling
> callbacks are added.
> 
> Fixes: 47c4b0de080a ("tools/lib/thermal: Add a thermal library")
> Signed-off-by: Emil Dahl Juhl <emdj@bang-olufsen.dk>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

