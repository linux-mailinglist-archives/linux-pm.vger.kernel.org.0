Return-Path: <linux-pm+bounces-1378-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4285C818F8E
	for <lists+linux-pm@lfdr.de>; Tue, 19 Dec 2023 19:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3CAD1F27873
	for <lists+linux-pm@lfdr.de>; Tue, 19 Dec 2023 18:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD9E39AD6;
	Tue, 19 Dec 2023 18:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C6k0wE56"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5630E3C087
	for <linux-pm@vger.kernel.org>; Tue, 19 Dec 2023 18:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33666fb9318so2821955f8f.2
        for <linux-pm@vger.kernel.org>; Tue, 19 Dec 2023 10:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703009564; x=1703614364; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yyh7ha3m2IjRXfbiQQ4otkeqh6GTNsiu49nR/VS8r18=;
        b=C6k0wE56ycMqnhR4h/RTnbyiafkmRfc1neUU/FDVArHrOzxlE+FnrO2EtDzJtSoWVf
         iuq0IQv1acObMM0ao46xmVdqhpDWULA6EAJuyUtgvUH3MtFUZvjDWLFc8UGxCY3BXrrA
         V7SI3lel1sewz4wfMj52qd94IOyb5SxHlk4WSntkxRknooK4LK4oWWqg2MEmKONdhdPS
         AVEvkwpNMZi7osYRPL1yfHaF8/8NXsdN6WUVmSWc9b3GebN9U95794ziM9QymsViJTZU
         NuHEKx13+FT0FhII2QyOq5rJp+Unx0nWjd+QPNFbn8OLVdewgeZo211OvY7v8TugX3h5
         T4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703009564; x=1703614364;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yyh7ha3m2IjRXfbiQQ4otkeqh6GTNsiu49nR/VS8r18=;
        b=FI6jsBFIrIpxcrulWYAi5PEqqxEAJb/wy1s6Tbupsm/3fOl3ex7nGyCcATS3Csx8ki
         qKT+W1notuWT+5l6FrdFhXYOENviCSnCJDgXmvpxqYXHGkmdefsbSfNp4WkhRGLNBG15
         OzIW5fXBVDrogPBGARn9bIug7mNg6XUO30ldOTGgD6H6LIwd/fjjE8SJXPDK1vziqLwU
         fuIU8xs24Iol/2Htse0yKRbzY9FjbzBSAikWB6Uz9PSLO8H8P5z8wnwX0KVjEcaSkGSA
         aHVazENQcVoz5EGnL7w1oFfaAI9pT0/BjIgUroij+3MSToBxMotqLQJprW7za/PZgWsR
         yW/Q==
X-Gm-Message-State: AOJu0Ywi+hXviBNtoApvs2Jx29tXOdD11uu3G5TALJrzrMzNo6RV3RqK
	BGEHu2nCVsHcBXeqHN+NhpaCaw==
X-Google-Smtp-Source: AGHT+IHittYrYA+Gk+CSDWYjh8D/glMO+9CAnAsKsAjBCROUoDPnwoAT+DbZ1h2QaoE3RqishgqtUg==
X-Received: by 2002:a05:600c:1f1a:b0:40c:38dd:1b1d with SMTP id bd26-20020a05600c1f1a00b0040c38dd1b1dmr9514100wmb.168.1703009564453;
        Tue, 19 Dec 2023 10:12:44 -0800 (PST)
Received: from [192.168.10.46] ([37.170.14.102])
        by smtp.googlemail.com with ESMTPSA id n33-20020a05600c502100b004030e8ff964sm4066461wmr.34.2023.12.19.10.12.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 10:12:44 -0800 (PST)
Message-ID: <6dbed9d3-abfe-476c-a771-10a5e70bb87c@linaro.org>
Date: Tue, 19 Dec 2023 19:12:42 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/thermal/tmon: Fix compilation warning for wrong
 format
Content-Language: en-US
To: Florian Eckert <fe@dev.tdt.de>, Eckert.Florian@googlemail.com,
 rafael@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231204141335.2798194-1-fe@dev.tdt.de>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20231204141335.2798194-1-fe@dev.tdt.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/12/2023 15:13, Florian Eckert wrote:
> The following warnings are shown during compilation:
> 
> tui.c: In function 'show_cooling_device':
>   tui.c:216:40: warning: format '%d' expects argument of type 'int', but
> argument 7 has type 'long unsigned int' [-Wformat=]
>     216 |                         "%02d %12.12s%6d %6d",
>         |                                      ~~^
>         |                                        |
>         |                                        int
>         |                                      %6ld
>   ......
>     219 |                         ptdata.cdi[j].cur_state,
>         |                         ~~~~~~~~~~~~~~~~~~~~~~~
>         |                                      |
>         |                                      long unsigned int
>   tui.c:216:44: warning: format '%d' expects argument of type 'int', but
> argument 8 has type 'long unsigned int' [-Wformat=]
>     216 |                         "%02d %12.12s%6d %6d",
>         |                                          ~~^
>         |                                            |
>         |                                            int
>         |                                          %6ld
>   ......
>     220 |                         ptdata.cdi[j].max_state);
>         |                         ~~~~~~~~~~~~~~~~~~~~~~~
>         |                                      |
>         |                                      long unsigned int
> 
> To fix this, the correct string format must be used for printing.
> 
> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


