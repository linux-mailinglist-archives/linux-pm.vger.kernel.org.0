Return-Path: <linux-pm+bounces-29507-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEFEAE8442
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 15:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 556FD1BC5F7F
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 13:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAF62652AC;
	Wed, 25 Jun 2025 13:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hi/sTCLH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DBD264A7C;
	Wed, 25 Jun 2025 13:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750857357; cv=none; b=GHB0ROSNNFKYArRq1eLqJRnYaHjkYJpQVlKeLynhU1Sxboi2M8IEz0qDZGRPaKgkFkWWTCN1RBEsh268trC9ykt0bve2VNmUMxJiQK7WPVFgdiw+O2ga8rAzLtMea4f4EuiDTvLmPb+OmO7ClTVj869s394s44lIzg8TM/WTyZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750857357; c=relaxed/simple;
	bh=1Ew8prqLY6S9T/f6MB6W2DVISyi22iiN0qriMIihJcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HIYSTpIC05huOWaZugngYgYbK5cTpShHdWQ/TCwHaAvvd0Ks4Ikb3QDQuoZiGMtG/NPADpK++1SYuGhAYLVYTL0BDVOg+OWYzN+qVIuDuUIABXcFGLOPqNYeo0FRx46MXpffeWdMBYh9jTj7gfn60hpFx+qFYlmrMMVhUErpw8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hi/sTCLH; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-450ce671a08so41965915e9.3;
        Wed, 25 Jun 2025 06:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750857354; x=1751462154; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=myFzD7QWLL6mVi6x4ybFyj0pD8esGFOCmQhIz9MBaqQ=;
        b=Hi/sTCLHFZcUVlrTf3cCRcmg0TUEtWHHx5UkFHCgNecYD/FpeLTgUZjv9YNXGMwqBs
         Bw2idU4IkZMMwPqkYouvsQmYTkxRJBLx/qtjh4Jaf6JF52zIiubJenjQi8nq2ntP1nGp
         afAblklFnTjGoea9lk2RiZsaN47aR32nOYHEnfD2QUxEKtvwj790+LsXxT3qizq9nM+p
         3/psnVWVtHXnGAESWeseHuHhcgl7mG84zEi5zsfVFvzjbqREK2VikrAk+Rwl8pOVL5yP
         PF/duCkTJpI8obwzgkqwVnBDjXc8e4WGd0v+Mjd7RCszthMmDMsYpOsbb3V79+vi/Meg
         ew/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750857354; x=1751462154;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=myFzD7QWLL6mVi6x4ybFyj0pD8esGFOCmQhIz9MBaqQ=;
        b=UsiW0vgZa/5iWEh9Zm6mK+GAIdDAGqcQ9gWSaJM5xq4NN6A44T4cpu7D4qjhNs99rk
         Y3bwaLwdsyDIjvJ+Q9lvQw3mkAhmlnlLjqFuGEV+dHqfO/bkc8DKIGrXXKKtP68VwsbZ
         MOke0Bu/F4Szaq3Kv2e3KKAO56xG7pxUmIc/H0tILhfpQ7EJI/Uwhg9Mf9000WrZh7ge
         OvSdP9tr//39EI+9BznwEITV4FKHkPMMtAZfkJbM4ZhAoJbzUlicayTuj1WCBHXFn7f4
         Aw4YAzdZswrdFUDm1nCEKsHc9Vv5dnCE3+89ec4ZrkCJ6cC39AQbBNHRkCcbyMr729rR
         RP+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW0g30Z5ZbhoTYeNIj6oMBMx7k5CzS8bTbvT+bCmAVzccpOp2VeHQjqKgTavIzCd567tW9fbaLlO48=@vger.kernel.org, AJvYcCXdOAY80h64QwmQ+iCSeYYlbl2rZTXSSg6Hd0NWPYWfUDeijjbSJXz1akHKeltBZnlEdEehOFvLnv1I2Lk5@vger.kernel.org, AJvYcCXiJDR6gSlZeFUEeUAwza48/x2fKxAX17zKhdLm+aV6UBFpPNP1Ns79i99vEatL0LEXdVTRgaEnOl9YgL6t@vger.kernel.org
X-Gm-Message-State: AOJu0YzgMkRMDAP8VWdI3Zopm3EajkdRwDESg/Axv2IxbwrgnokgO5Do
	l/8/CBnSVpJA7KxjUSswDTGWlVpa+Elxgp/JsUM4RwRpoZNcHpq3LUNN
X-Gm-Gg: ASbGncu8wXVuWc5dvExTw4J5tcdLTUVo5N2X3LyQek09bW2JGarHGcdV/+po9fq3Yld
	xZTtTcx9vj6Nn0z7Ps7bSC0qll4gGejsLPqhpYhlNHeXpMfkoV8ZHUlAD9L84zsiIQTAojzp0qM
	5FZLll5obgpnl+epZfgcquPfDvjLWzG+KSRhiuv4FYrRmUkfWYLgyEWY+vY32/C/a1QeElML+7f
	lICi3MdRKR33h+Oz4oDD2XGwXRFR83vKRQuCVU0gZXTulJ0AvJ/tMia95TWwTNHCdaY/ReFVxGM
	Rut5EsTMjkQF3kQOUZbJ1Atd3KdSaKnF1dvjz5xa88qxNw+Q76AdBsrCD/uhduOVbp/LWGi5Ul5
	IfLjx7CNZrVxEG+ZS7x86iVONzWk=
X-Google-Smtp-Source: AGHT+IHqyiRVjvoB8YSLe3HZosm1kBlsHb8xxS6UoEjuMcGWiykX94tFxvLlVox0eEJcWTFkCAve6Q==
X-Received: by 2002:a05:6000:4014:b0:3a5:8a68:b839 with SMTP id ffacd0b85a97d-3a6ed67507amr2459464f8f.45.1750857353988;
        Wed, 25 Jun 2025 06:15:53 -0700 (PDT)
Received: from [192.168.20.170] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823ad1adsm19989575e9.24.2025.06.25.06.15.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 06:15:53 -0700 (PDT)
Message-ID: <84b94649-a248-46b0-a401-772aeb8777a2@gmail.com>
Date: Wed, 25 Jun 2025 15:15:53 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] interconnect: avoid memory allocation when
 'icc_bw_lock' is held
To: Johan Hovold <johan@kernel.org>
Cc: Georgi Djakov <djakov@kernel.org>,
 Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
 Johan Hovold <johan+linaro@kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250625-icc-bw-lockdep-v3-1-2b8f8b8987c4@gmail.com>
 <aFvr1zSkf4KmIcMT@hovoldconsulting.com>
 <aFvuiVX0kMIqXQtZ@hovoldconsulting.com>
Content-Language: hu
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <aFvuiVX0kMIqXQtZ@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2025. 06. 25. 14:41 keltezéssel, Johan Hovold írta:
> On Wed, Jun 25, 2025 at 02:30:15PM +0200, Johan Hovold wrote:
>> On Wed, Jun 25, 2025 at 01:25:04PM +0200, Gabor Juhos wrote:
> 
>>> @@ -276,13 +276,17 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
>>>  		qcom_icc_bcm_init(qp->bcms[i], dev);
>>>  
>>>  	for (i = 0; i < num_nodes; i++) {
>>> +		bool is_dyn_node = false;
>>> +
>>>  		qn = qnodes[i];
>>>  		if (!qn)
>>>  			continue;
>>>  
>>>  		if (desc->alloc_dyn_id) {
>>> -			if (!qn->node)
>>> +			if (!qn->node) {
>>
>> AFAICS, qn->node will currently never be set here and I'm not sure why
>> commit 7f9560a3bebe ("interconnect: qcom: icc-rpmh: Add dynamic icc node
>> id support") added this check, or even the node field to struct
>> qcom_icc_desc for that matter.
>>
>> But if there's some future use case for this, then you may or may not
>> need to make sure that a name is allocated also in that case.
> 
> Ok, I see what's going on. The qn->node may have been (pre-) allocated
> in icc_link_nodes() dynamically, which means you need to make sure to
> generate a name also in that case.
> 
>> And that could be done by simply checking if node->id >=
>> ICC_DYN_ID_START instead of using a boolean flag below. That may be
>> preferred either way.
> 
> So you should probably use node->id to determine this.

You are right. The problem is that ICC_DYN_ID_START is only visible from the
core code. Either we have to move that into the 'interconnect-provider.h' header
or we have to add an icc_node_is_dynamic() helper or something similar.

Which is the preferred solution?

Regards,
Gabor


