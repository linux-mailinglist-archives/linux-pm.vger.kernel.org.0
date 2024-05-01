Return-Path: <linux-pm+bounces-7420-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 515A38B8760
	for <lists+linux-pm@lfdr.de>; Wed,  1 May 2024 11:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C83F285126
	for <lists+linux-pm@lfdr.de>; Wed,  1 May 2024 09:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7EA51033;
	Wed,  1 May 2024 09:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yx+JmjMV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A98750A9D
	for <linux-pm@vger.kernel.org>; Wed,  1 May 2024 09:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714554902; cv=none; b=L46ztCOnzbo7tnCdtYeC0fzzhyCxuJgDKb2eEuxKsFQ+hwHNtKXSiYp6Ll9ashg/1VIMSMfV/j3NL0+eUWd8n+c5i6x06wJqodY21zs4iytJ/anPlozIzcVQ0Wc73pQy0OQu7tDkL/gh1KcRGbMs4WXiUj9qdGOHJrHnPGIej34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714554902; c=relaxed/simple;
	bh=WnsMRjfBiQvg0HY93oK+wHwfzdyxP7aK1TTwsAckKN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CUN4lHLsD9fs/viimbG0H/UAgbglPDA7RX2pIT0VYQe+MF+Os4sWtkYoJB18ZIWy24E404/7XWi7c9TZS9CD8TcKgVUYucZh8mDtWfTB/+yL9IIPnLIeLCsRBUStf642pcDx5YMToq4Ek0jO8pLHmE5wb3+/kO+XBJ8I9xdHcuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yx+JmjMV; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-418e4cd2196so51468705e9.1
        for <linux-pm@vger.kernel.org>; Wed, 01 May 2024 02:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714554899; x=1715159699; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P7Oo92HrLNTevL9sgb/rzYO2LYRP7kZeSluQHcb91H0=;
        b=yx+JmjMVVxkz6d3mjjt85AHKc9BVv3ECeu+GG9QZIfBRTzIaNTcNLFiWHAyJme9+Ee
         B3za9peFYn9YvtQPLIifPw9YrZhhap3cUvo7JiLDl9gtL3KCZAAiBRQqFdjKwmaC37T0
         xqZH4U39+ah0/yx19D628zqyA2sjxKKOe5C8vcyNuHG4Go1ACmkOSV/CrZcJwQBI99vy
         kvN5b+fQ7mIUi5B4YCKbzA8LLeqsTIp6VZ1Fg3rXyDCoPQ6toVdOH8XF68nHiuU+GQUN
         73Av2Cqk33JjyLgIYInrQRT3884lZ8VLNWnkuswlofdNZD9y0Y6ParEsEoiSzjEAREyj
         GXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714554899; x=1715159699;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P7Oo92HrLNTevL9sgb/rzYO2LYRP7kZeSluQHcb91H0=;
        b=M9sA19JQlTmPy5jcAG9yPDzj0f3i1YHERt/5DW1Ym4H5v5nYDAUxwjVMOO01ZlObC7
         hvoL1tFneCbzTI4LcIygu8wKPYY2/tA9XoXPxi/ruYDCjttqexAxt8X/EBCi0MS5rpNx
         8tlfqmoq21TjnllZJ0ZN6PKVWUW37JFxV88NoQ2mZKGPY0MS6gzjb5o+Yao//FuIMF2z
         dBWV/WGAJTeqOzxbCiH3saYzEeTTb4E9fknExIuH23zHFcttRDs95jqlJ9tVXL5udiWU
         ebaPV8k64r/AcXdJnTQ9UNu03PvJd5zZHZKGE2nZgRAMqnAMZ8+Md1kAUWktlx1E3IJp
         X6Qw==
X-Forwarded-Encrypted: i=1; AJvYcCVT9UaLqapnF1DF4iMdSyHiIhelEFIcI5k4J/zq1HNSDnNpHxuWQdFwBwPGKLQGLHh67hJETBHpQItQsgBli1FDRS9UN06+M3A=
X-Gm-Message-State: AOJu0Yw4X7I2a4nwbscM+wJQWIsrqzweo3WhzJuCsxHis25LCn1EU1+O
	BoOQfpK6G0vczDctcrue3UtltZ5PbHzdC62iTTeOJ5BIb4ZBoLcoHBakvugXZyc=
X-Google-Smtp-Source: AGHT+IGqYngsZENzsz/1pFANnIsWSoQqm6YP469dyVXFTuIpefceJcSqZyRDxsqxoDLcadLnDSNwBA==
X-Received: by 2002:a05:600c:4708:b0:41b:edf4:4077 with SMTP id v8-20020a05600c470800b0041bedf44077mr1338212wmo.36.1714554898671;
        Wed, 01 May 2024 02:14:58 -0700 (PDT)
Received: from [192.168.0.102] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id p5-20020a5d48c5000000b0034afaa9ca47sm25764690wrs.1.2024.05.01.02.14.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 02:14:58 -0700 (PDT)
Message-ID: <ef194e5c-f136-4dba-bfe0-2c6439892e34@linaro.org>
Date: Wed, 1 May 2024 10:14:56 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 RESEND 5/5] venus: pm_helpers: Use
 dev_pm_genpd_set_hwmode to switch GDSC mode on V6
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
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <d36c1163-a3f0-4034-a430-91986e5bbce8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/04/2024 21:01, Konrad Dybcio wrote:
> On 24.04.2024 11:50 AM, Bryan O'Donoghue wrote:
>> On 24/04/2024 10:45, Jagadeesh Kona wrote:
>>>
>>> Thanks Bryan for testing this series. Can you please confirm if this issue is observed in every run or only seen during the first run? Also please let me know on which platform this issue is observed?
>>>
>>> Thanks,
>>> Jagadeesh
>>
>> rb5/sm8250
>>
>> My observation was on a previous _boot_ the stuttering was worse. There is in the video capture three times that I count where the video halts briefly, I guess we need to vote or set an OPP so the firmware knows not to power-collapse quite so aggressively.
> 
> We seem to be having some qualcomm-wide variance on perf/pwr usage on some
> odd boots.. Any chance you could try like 5 times and see if it was a fluke?
> 
> Konrad

Sure.

The first time I tried it, it was much worse.

The second time, captured in the video is only noticeable because I was 
*looking* for this specific error i.e. I don't think I would have 
noticed the error on the second run, had I not seen the first run.

I'll find some time to do 5x with and 5x without.

---
bod

