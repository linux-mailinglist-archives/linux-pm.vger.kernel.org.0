Return-Path: <linux-pm+bounces-467-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0327FD69C
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 13:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E964CB20AF2
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 12:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0977F1DA3A;
	Wed, 29 Nov 2023 12:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fi0ZkyD9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A3910E5
	for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 04:20:06 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40b34563987so5139255e9.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 04:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701260405; x=1701865205; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lv7lCvib7cg8BdYARPaDYByTQBG8009J26jtUgjhsJc=;
        b=fi0ZkyD9esYdMPv4Fzw/YnyWo2BmUJSzVi9Z52eNKrpEmUc8A4Kz5F2laIChCE7D63
         VzzukCfg0C+WsPQxzbYyZA8/cle/bgFnZkhgxGkYMOtTcF2VPWoDA242ghdNUgJfP6gn
         8AS6uqvNThPjOTefs9oAOAkjdRpkFLwk3WK5cUJl3f2C78cksPg2pE4o5xnVb8vreURl
         7lQRh5SJSBANj/R8ixU5GQkYN38TxbC15scposBnB6DvNGHr/ckxFbH7yjJNGnQTzkDR
         825I/d1TR9dFnWRAFqpj5QprZaSjA3nxqqS8F1KhDOmD1p7JREnkJxccE+kklBoeCNi0
         ngWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701260405; x=1701865205;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lv7lCvib7cg8BdYARPaDYByTQBG8009J26jtUgjhsJc=;
        b=eQVbsgWR02c2W5iJQJ6AkzqQN0olR460fE0qJ/pn+mi5NtU2gMoBveQCuhPH1QsGUm
         OcX2cT7MHVQsvMb8sOBbRXhr76jECIjbvajb84/LdGMaAp4A5/Y4nJrWOz2s4W442ySy
         ObSLkgjeix3pePwITQC8vfy0c9PBW7jWh7NE1Cig1m9toeyd+ZFnk07f5KQ7zTQufOnV
         JS12Q4/Op1/fB9CDYa91q03spDCGNjj1pEEFztKfRNojqg9fm4Bm430IR8HpWJ8/YDZh
         HydvpmjVRSb0B0+VEPDoQW2L4cK4y8UirHkUntyZZrwqKOcxyjaQZWMoP/SHcJL4+tCN
         CFIw==
X-Gm-Message-State: AOJu0YxrLtogMGSqyWsQtFgi7FlfhC8nM8S5kWdaRUA8tPZdgwUypFNX
	4P3yG/i/kye1NVYSyPowmUh1evbjr8X27oaNctY=
X-Google-Smtp-Source: AGHT+IFclPWCIxfftasJL2ulZLN6x80qbZSXpoKk2hJPRIXvyUeuE69g5XOFpdFLfVm+fpCBMilU4w==
X-Received: by 2002:a05:600c:1c89:b0:3fe:d67d:5040 with SMTP id k9-20020a05600c1c8900b003fed67d5040mr19653660wms.5.1701260404874;
        Wed, 29 Nov 2023 04:20:04 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:38f1:13b7:9b7a:2d6b? ([2a05:6e02:1041:c10:38f1:13b7:9b7a:2d6b])
        by smtp.googlemail.com with ESMTPSA id fa10-20020a05600c518a00b00405442edc69sm2063830wmb.14.2023.11.29.04.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 04:20:04 -0800 (PST)
Message-ID: <9d1009d9-b95b-4152-841f-19470a17ba97@linaro.org>
Date: Wed, 29 Nov 2023 13:20:03 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 RESEND] thermal core: add option to run PM_POST_SUSPEND
 asynchronously
Content-Language: en-US
To: Radu Solea <radusolea@google.com>, linux-pm@vger.kernel.org
Cc: rafael@kernel.org
References: <20231120234015.3273143-1-radusolea@google.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20231120234015.3273143-1-radusolea@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/11/2023 00:40, Radu Solea wrote:
> Some thermal zones are bus connected and slow to resume, thus
> delaying actions which depend on completion of PM_POST_SUSPEND.
> Add optional execution path to resume thermal zones on the system
> unbounded workqueue.
> 
> Signed-off-by: Radu Solea <radusolea@google.com>
> ---

This async change may have a lot of hidden implications.

Could you elaborate more the issue and how the async will fix the problem?

If you have a platform being slow to resume, can you provide numbers 
with and without this option?

Thanks
   -- D.

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


