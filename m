Return-Path: <linux-pm+bounces-12489-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9AF957302
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 20:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90EF31C225E9
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 18:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A4E18953A;
	Mon, 19 Aug 2024 18:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R7mUpHoo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64661EA65
	for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2024 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724091628; cv=none; b=b8cWPnx9wAVu4bHhQSdeNBeR6srNoc5TITbvisCvwSwmkNl44xbvy4uSXqfSSJ1vDVVDi4Zec0Xd+iW6dAY3Wn2fU3G2NDLaxTWcyxP0kCQ8LNI7If/KIjQcyyCzOWTyzehwZFwDJnps6fnFKQuMYm9c/WLSLUvU6LAXYHfSoxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724091628; c=relaxed/simple;
	bh=ohqaIS85nwDHQ3F5PskuN1FDjd3Wx4YOZcBoXkyY80w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gl9KZRktZlikDwToWQlKqB/UreON3pqpngna3AY8cpOu6qOrvE9OsALpmMcZxO4A/9oEE7w8ca1nztPQiTqdMIdbtypGTrwPHcgJJ29hawdOetIbTZv5kZ+5WPsvEa2K/zoRWo/m+XDM731GWgPFAxW/osXFf8bpTlplSolDnLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R7mUpHoo; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-371b2e95c34so1217296f8f.3
        for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2024 11:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724091625; x=1724696425; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pY40c8MeO7wCQWLmfvqT/8LDQ+fiEc0VYhcuPcSiXug=;
        b=R7mUpHooYKe9wZECB4cOItEdQymGcjLrejDb+1JXbiGMSUnrDi/U/Z9MkwDma/ETXh
         SrlZPzTwT24rXSC79GbHRdQFtvNE7jbH6eYIZ+kc3v4P802aTTyNPYb22esy9hnz7FQV
         V4xF60LWRdzHJ2cNrk4zaLqHC2C9so5tL+l8jXh+Iv4wERUG/4OA+NmBzEhyJrBQGJF7
         KqgUe8GryusqCN/3+8Jq+R3htq53JKW0Ycsvm1P43vQ5yTjgt0v6Ol5oZMDOYM8v/RWz
         QuqPqIHjclK6Rif6dR5DvAarDChTgTkifHUUeKs6MQSKuzvFEFCu4t9kTnjipc+0OgFX
         agEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724091625; x=1724696425;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pY40c8MeO7wCQWLmfvqT/8LDQ+fiEc0VYhcuPcSiXug=;
        b=Qhp8ZvF+7kICYno3xOfOjZ0YTDEaaUZ3MuVCN2//0lb4byS/f5sKvIMdDop0VkqLSQ
         emk61YN1Loam3CyG3okM+P2xfDs68YaeETv0vWdv865TZ7/lH5T6gkj+9oMXiNVRoquE
         C2NocyF27u98N0xb5V1jiYJ8kXpXCFXLxPUGv5FT1bCdnjkGnLSAudU0gHcNQtiEtZP2
         PNroLYKE6uTl2WGa69opDrl9o2N+72DQ9WSqKQqDC8rG2vXljQ3KF63+qXD6CdEaj+G6
         HYJOhLJbFUT0j+RxsBw30WOE9o4yylUXcoT+mi3+YwWCe34AvRCl4nseCr5i64tJlQGd
         HZvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXh59IJpGlFfE+QsPs09wVQBjixzvbf7qwNcD9jSK/5zSV+1hVz/qzjse3BHJm7F3aWBKKjioEHYHfIFR5T1IdxwAHltTeWKeo=
X-Gm-Message-State: AOJu0YxUgJV2FryF87iEf2kb8kHoh7DmLH1x2rWVqE6Bfxg0S63bhS/k
	yybDHMFKUPhoF4HWSiQXY4y9ydTERC09PcAsGIawksbpqMT/pn70aZyGIF0y/zg=
X-Google-Smtp-Source: AGHT+IFl2TrB8IPXloaOj7JTMJz+l6mr8rLXTAZKHwNBK2V3VFDsQxUC7+dBB8kwUg3liXyt2YF3Fg==
X-Received: by 2002:a5d:5582:0:b0:367:9881:7d66 with SMTP id ffacd0b85a97d-37194676a74mr7891076f8f.41.1724091624514;
        Mon, 19 Aug 2024 11:20:24 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-371898b8ae2sm11155610f8f.113.2024.08.19.11.20.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 11:20:24 -0700 (PDT)
Message-ID: <c4f08810-66a3-4de9-9cac-699ff9273d1e@linaro.org>
Date: Mon, 19 Aug 2024 20:20:23 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] thermal: qoriq: Remove __maybe_unused notations
To: Fabio Estevam <festevam@gmail.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
 Fabio Estevam <festevam@denx.de>
References: <20240819142700.1206586-1-festevam@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240819142700.1206586-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/08/2024 16:26, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> The combined usage of pm_sleep_ptr() and SIMPLE_DEV_PM_OPS()
> allows the compiler to evaluate if the suspend/resume() functions
> are used at build time or are simply dead code.
> 
> This allows removing __maybe_unused notations from the suspend/resume()
> functions.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

