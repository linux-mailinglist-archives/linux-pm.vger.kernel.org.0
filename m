Return-Path: <linux-pm+bounces-9320-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E1790AA85
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 12:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3EBBB3860C
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 09:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13031946C5;
	Mon, 17 Jun 2024 09:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m3bEcuMU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5391946AB
	for <linux-pm@vger.kernel.org>; Mon, 17 Jun 2024 09:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718617873; cv=none; b=FV/citlK5CzjOvHRw7WYwt5us6VMCGiVHqubb4vm4vaXY/+UcdgFB4yvtlMy/v/a80xuK4Gi1YWnfAr+UYhKUfjW2nu8grtqNASg+0pHnvhJdDDpTRH8D2syUiqGbY/wOCkVW27m/ax2yAneiCBr+TJZQgHln0l+OUrQkQupux8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718617873; c=relaxed/simple;
	bh=1y73eQPVodwTMu2gDWLc1JeFO6mTtScZeSbIX23T2UU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BIKNP78xgIb6o489mrolWH8Y5RQWLBdkREkr6zNQNXKYgZEqdgG2UaDf97BDUnSVc7YvsxvX7g9gvwwGZnZDHFY07vVhksO+0NtX9BxwVBJXYR10vy6NzDEb0Xxqq5XEBJublgJSxZ0RH+W8ossCle0yrgnPzyFtX0KOXa5x0mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m3bEcuMU; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-35f275c7286so3734474f8f.2
        for <linux-pm@vger.kernel.org>; Mon, 17 Jun 2024 02:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718617870; x=1719222670; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mJ4Sf0Qpnpg0mNfJe0dZM5ooebC8zr2HkLzZYiJ9KxY=;
        b=m3bEcuMU0t1ZUPPdLrWRWZMxlotDXFbQBtRCwViGnZKuwSbr+uL0ZfYubZp1GNfOxX
         xbaLjzNOh5TYw4p7+PtQYy8CBPsjMs7e0arxigXFQtAmE5XDynMy/LoQoVWb9MVvr7Pt
         qUyKbBALunTzuZg6pNhGS+adLzjkqM6hxnPSgyamvZ+sWi8PBJxry7iXR2N2ConeyudG
         lrUHs2ioOFhtGRfk1+NBiTLuLMDVqOIFHWU6fNmaItTis2+Zij8AV3i3JoZ+eUsVJaDV
         6zVb5lB6Pj9PzQJt0iRMNuclzsDpdvOMXqt4+nND3at4SpWoCLtQHVVA9NDXPEOmjVQb
         DVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718617870; x=1719222670;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mJ4Sf0Qpnpg0mNfJe0dZM5ooebC8zr2HkLzZYiJ9KxY=;
        b=Crh7Dmc9JxRFLZ0G/6oN6vxWt5t7JV5zmJdxAmNNWDeMaUNDKqud+0NfW+kIkkVV/p
         D2CpBchccmct0Cuc7z13XXYcpagl9KvguUSoWNzJC5yBgLGJcm6rdbBqSzSOdXKRC+se
         yleSfBvtRq/Sm3+pgUUM38x09pTvD4DPRAaliMmg3O38fUNTThu9Frtzm0Z5cvStZULU
         hnXCOptwhwndXO/ooaak0DZAVcNmFFDqCfl7iPUk3/QWKqpZdIwZgeD4Gs05XT955zqc
         9c9a13DXeob/LzSuDbr6O7I2Kk4HmqdwmYl07SWtGKP8VyKVzBWE78lHKsUkkYDl/jjC
         tLow==
X-Forwarded-Encrypted: i=1; AJvYcCUTk+P8Sw6OWO8vphmbxtg+EJRYMzDpRJijd07M8jw5YFdBC4gcyT7/twRO9Ceapn3nE+I7DnUksJTvghylnGIyODaTNX4FZ7I=
X-Gm-Message-State: AOJu0YxpbyW6G4dnx011RJJs8ZKOg/Pgq2OkQ1NRhNpMjbhW+8ijslrD
	sYJjdi6UC+0FbN6zAv5ldvhHB0yQyj3LU5e/bo/6fySxFmUTCBtN2L4+DiZOS68=
X-Google-Smtp-Source: AGHT+IG9PUbxCPf1bgdr95dC5Am+XNjIYf8nW+qqKLMvGs09SVCiTZEntEjWJwmp7GgG/3LuhbnIqw==
X-Received: by 2002:a5d:64ea:0:b0:360:8589:37c0 with SMTP id ffacd0b85a97d-3608589385dmr7022782f8f.8.1718617870085;
        Mon, 17 Jun 2024 02:51:10 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750ad20bsm11420396f8f.54.2024.06.17.02.51.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 02:51:09 -0700 (PDT)
Message-ID: <01041302-120b-4f9d-87f2-bd841dcd227a@linaro.org>
Date: Mon, 17 Jun 2024 10:51:08 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 RESEND 5/5] venus: pm_helpers: Use
 dev_pm_genpd_set_hwmode to switch GDSC mode on V6
To: Jagadeesh Kona <quic_jkona@quicinc.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
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
 <d2e55523-f8fd-4cbe-909c-57de241107e8@linaro.org>
 <1df48a42-3b4e-4eb4-971b-cd4be001ba27@quicinc.com>
 <93a67151-02fa-4c53-8d6e-0ed1600128bf@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <93a67151-02fa-4c53-8d6e-0ed1600128bf@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/06/2024 03:31, Jagadeesh Kona wrote:
> 
> 
> On 5/31/2024 5:26 PM, Jagadeesh Kona wrote:
>>
>>
>> On 5/10/2024 6:31 PM, Bryan O'Donoghue wrote:
>>> On 01/05/2024 10:14, Bryan O'Donoghue wrote:
>>>> On 30/04/2024 21:01, Konrad Dybcio wrote:
>>>>> On 24.04.2024 11:50 AM, Bryan O'Donoghue wrote:
>>>>>> On 24/04/2024 10:45, Jagadeesh Kona wrote:
>>>>>>>
>>>>>>> Thanks Bryan for testing this series. Can you please confirm if 
>>>>>>> this issue is observed in every run or only seen during the first 
>>>>>>> run? Also please let me know on which platform this issue is 
>>>>>>> observed?
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Jagadeesh
>>>>>>
>>>>>> rb5/sm8250
>>>>>>
>>>>>> My observation was on a previous _boot_ the stuttering was worse. 
>>>>>> There is in the video capture three times that I count where the 
>>>>>> video halts briefly, I guess we need to vote or set an OPP so the 
>>>>>> firmware knows not to power-collapse quite so aggressively.
>>>>>
>>>>> We seem to be having some qualcomm-wide variance on perf/pwr usage 
>>>>> on some
>>>>> odd boots.. Any chance you could try like 5 times and see if it was 
>>>>> a fluke?
>>>>>
>>>>> Konrad
>>>>
>>>> Sure.
>>>>
>>>> The first time I tried it, it was much worse.
>>>>
>>>> The second time, captured in the video is only noticeable because I 
>>>> was *looking* for this specific error i.e. I don't think I would 
>>>> have noticed the error on the second run, had I not seen the first run.
>>>>
>>>> I'll find some time to do 5x with and 5x without.
>>>>
>>>> ---
>>>> bod
>>>
>>> ping bod please remember to do this thanks
>>>
>>
>> Hi Bryan, Could you please let me know if you got a chance to check 
>> the above? Thank you!
>>
> 
> Hi Bryan, Kindly can you please help confirm if this is a real issue or 
> observed as a fluke? so we can go ahead and mainline these changes.
> 
> Thanks,
> Jagadeesh

So I'm happier with this patchset when I run gstreamer instead of ffmpeg.

There doesn't appear to be a discernable difference between before/after 
on framerate or subjective UX with/without this set.

gst-launch-1.0 -vvv -e filesrc location=sample-5s.mp4 ! qtdemux ! 
parsebin ! v4l2h264dec ! autovideosink

Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

