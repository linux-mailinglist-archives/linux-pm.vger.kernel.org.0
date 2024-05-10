Return-Path: <linux-pm+bounces-7717-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 062E38C2553
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 15:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 982051F21BFE
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 13:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF13E12882D;
	Fri, 10 May 2024 13:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="crVkqiIA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4850A127E27
	for <linux-pm@vger.kernel.org>; Fri, 10 May 2024 13:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715346081; cv=none; b=BcyqHLvVNTuzZ3+1fNFUhnTSkXCeZ8RY2XEAQ4/Pdj8dqyFgn4GVEmN0UdhE0LBGLWjkysu3B3cyo1R07tbb4jX0SdnLmQFhXaOrb8KtGmAhVCVpl5qOOFyXCf5SPgb2d1/RO2p0BYLcLZd+i/4+qKIOSp6Rm7GLvWYNjgJ6pJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715346081; c=relaxed/simple;
	bh=xsCgUTQujSpA87EGwezOFO4IkwKTUzAnJXwXCKepl10=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JiWTctq0wyibtiHX+JGsG+qlpn5LXZ92kzjiadLmlUQBLhusAjB7hBJNJg/SBpmI6Dgjrod6IbJ6k03h14l7UYNYRZwMyb7unlVcK+98NA6fTqf8U1MfKUAmfoHNQISQO3aR7l1WFKeXfAx1rKToMjteSGHAZBtWNu91KGTplSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=crVkqiIA; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-34d99ec52e1so1491206f8f.3
        for <linux-pm@vger.kernel.org>; Fri, 10 May 2024 06:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715346076; x=1715950876; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EuOqAb8ZpUuVP1mrlb2cKpurEJ0bRaZYBd2TNR0xxGs=;
        b=crVkqiIAkpGhPg2PhxnH0MUtf8I7DlEpb8NReO57skFh+IvC+Yjv6AktbtO9kx9haU
         4vhDBC262Gz9JSV2G72rTPyM5tisB8lO1NvoteP4ZGlxqFygM13S+5AKjwtl8da6Pw/j
         WkCc3d5Gh9lNkBxE3x4eeGwWhT5cevrdkJ/3Es7Y6ZYjQ+DrtE/QJ4ynVVLq334rRviT
         Yy2KJJ2bUI8bV50DjDnHyw9PMOnnu7w1sNzccwyTTYL87vUgKXNfIBlKjcOqgQ0BITAP
         AtdowtOyXSedQF89v33akaewvf/M9E+p2fi1Ohwd5Qqsx4IokQe9RnpqwFzb1Ecgs/1O
         Zrmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715346076; x=1715950876;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EuOqAb8ZpUuVP1mrlb2cKpurEJ0bRaZYBd2TNR0xxGs=;
        b=BS/le/khBve+2O9yqWNQBUhUrCrmp4vz8UPdgpYe8bm1Bva4z4AWd/yfJEB1rL/IIN
         l6AkzwwgnrowRn3NoyVmDJhNd3MpAKTMJ0KQCKBBCm7aCthBLxw7zGrCgNHmWEh96pPi
         5tX7UZjXlqCfYT0QzTK/2f/JQau7XRTY0YWCpiRmO5XvL5qqVQBwbp0HJbku7QW7b1RW
         3epzlmNBiFM3uT1HwJzAjAIsUm5O6S6C85J0DCiMfCdJMia0XPNrBZomp0HJMTx9svAV
         F3RjknSg8mtHB+WmeKfOrGumvCOvHjE5J03kinCpuEgur4xpEpbW6CtTZsU0cp+rjALN
         jZjw==
X-Forwarded-Encrypted: i=1; AJvYcCX6bZYRRscmd1cWsdHISfqWd7cSIJR8XwPAhzFd8gd0j+4HaGMbum9ji6olGAH7TRedgKMac/9zqolW6bPBmS4xMGiPAIvZED0=
X-Gm-Message-State: AOJu0YxydZIVmgSj+WpaWSyA7iS+/x8xuT1ekn6hOYysdsX0K2zv9AMR
	8Yl6E7LtAutP1CsI2UcVsZ9BtzgSSL7YzC5/1PPjamynV4UuEedjVUriOwwBgZE=
X-Google-Smtp-Source: AGHT+IH4l5dMeOQQ9CIlOmZviv3DR34gB+WFmPnfVAb0EORzuTaQVImXvg2bsbUFlg3yyxbsNPswOQ==
X-Received: by 2002:a05:6000:440e:b0:350:4c83:d669 with SMTP id ffacd0b85a97d-3504c83d8d8mr1455017f8f.1.1715346075781;
        Fri, 10 May 2024 06:01:15 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baad04dsm4512060f8f.81.2024.05.10.06.01.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 06:01:15 -0700 (PDT)
Message-ID: <d2e55523-f8fd-4cbe-909c-57de241107e8@linaro.org>
Date: Fri, 10 May 2024 14:01:13 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 RESEND 5/5] venus: pm_helpers: Use
 dev_pm_genpd_set_hwmode to switch GDSC mode on V6
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Jagadeesh Kona <quic_jkona@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Kevin Hilman <khilman@kernel.org>,
 Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andy Gross <agross@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Abel Vesa <abel.vesa@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-pm@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>,
 Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
 Imran Shaik <quic_imrashai@quicinc.com>,
 Ajit Pandey <quic_ajipan@quicinc.com>
References: <20240413152013.22307-1-quic_jkona@quicinc.com>
 <20240413152013.22307-6-quic_jkona@quicinc.com>
 <5c78ad52-524b-4ad7-b149-0e7252abc2ee@linaro.org>
 <b96ef82c-4033-43e0-9c1e-347ffb500751@quicinc.com>
 <a522f25f-bb38-4ae1-8f13-8e56934e5ef5@linaro.org>
 <dbd1b86c-7b5f-4b92-ab1f-fecfe1486cfc@quicinc.com>
 <621dbaaa-6b86-45b5-988e-a6d9c39b13d7@linaro.org>
 <d36c1163-a3f0-4034-a430-91986e5bbce8@linaro.org>
 <ef194e5c-f136-4dba-bfe0-2c6439892e34@linaro.org>
Content-Language: en-US
In-Reply-To: <ef194e5c-f136-4dba-bfe0-2c6439892e34@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/05/2024 10:14, Bryan O'Donoghue wrote:
> On 30/04/2024 21:01, Konrad Dybcio wrote:
>> On 24.04.2024 11:50 AM, Bryan O'Donoghue wrote:
>>> On 24/04/2024 10:45, Jagadeesh Kona wrote:
>>>>
>>>> Thanks Bryan for testing this series. Can you please confirm if this 
>>>> issue is observed in every run or only seen during the first run? 
>>>> Also please let me know on which platform this issue is observed?
>>>>
>>>> Thanks,
>>>> Jagadeesh
>>>
>>> rb5/sm8250
>>>
>>> My observation was on a previous _boot_ the stuttering was worse. 
>>> There is in the video capture three times that I count where the 
>>> video halts briefly, I guess we need to vote or set an OPP so the 
>>> firmware knows not to power-collapse quite so aggressively.
>>
>> We seem to be having some qualcomm-wide variance on perf/pwr usage on 
>> some
>> odd boots.. Any chance you could try like 5 times and see if it was a 
>> fluke?
>>
>> Konrad
> 
> Sure.
> 
> The first time I tried it, it was much worse.
> 
> The second time, captured in the video is only noticeable because I was 
> *looking* for this specific error i.e. I don't think I would have 
> noticed the error on the second run, had I not seen the first run.
> 
> I'll find some time to do 5x with and 5x without.
> 
> ---
> bod

ping bod please remember to do this thanks

---
bod

