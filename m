Return-Path: <linux-pm+bounces-1667-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8C781FEF0
	for <lists+linux-pm@lfdr.de>; Fri, 29 Dec 2023 11:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 976BE28476C
	for <lists+linux-pm@lfdr.de>; Fri, 29 Dec 2023 10:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3483910A30;
	Fri, 29 Dec 2023 10:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iOeV39u5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ABB10A26
	for <linux-pm@vger.kernel.org>; Fri, 29 Dec 2023 10:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3367601a301so6481841f8f.2
        for <linux-pm@vger.kernel.org>; Fri, 29 Dec 2023 02:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703847050; x=1704451850; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2xqjN3Qj9j09eMYaDIGiYmAZIOx1BVzIvkIYHk7g9T0=;
        b=iOeV39u5yubyithhqPnDpTOL/9jTJSR0WPyKcAG2qVuEGJZN3Mrcziapa5c+/cxAMM
         OwMzNdwFls3JKlQf+3bL4fI/vMOC3gvRqyYRKLJzC1nJo285lQmU+ISwXDYhD0dfcZ7N
         Mq86AQDY9mQIP8UJ1wiX3WwSAzBLmRUOJ0MHd7fIjLZ9wm26owCEHVrRnAW2AoY2+u28
         PP0gNrqWc12kU1FySfH7T6rCglyWAtIs8sufBUnohCmWiNscLEvO1rOm0IOIKYe0Mx8a
         QUEL55MxXkbIWVzfa2TZ1BKu8pMjvsckTN2Jz5XSi6UlAHgyqTP2aT/59BcnAzUV69R2
         hsfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703847050; x=1704451850;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2xqjN3Qj9j09eMYaDIGiYmAZIOx1BVzIvkIYHk7g9T0=;
        b=C6tdempJCDEr90/GD0QroPz2ChvUizKjExqjWtRIeb3nmu+T2MLTK0VU61Gal6yRDY
         UEgcIISTTMFb49Nud0Rwok8YKPb/nivdVj1Y62hSINzkoO0a9KGbs5hgXPLOTTTwRlP7
         JX818amU9MOdCncaxP87rGBlPMOS7iqWcgCCO9kaiPoPdCzLnbuRxBB7J14WPm5ztIdh
         +LVx3JRuW70G37KM6et93R3y/AN8QjIipOglz6PEJhGS0Iohtd7izX0guiBStbUzq/sh
         OPO4uuxUNtF6sG3htzLpekifvE0RVY2EXcoYjd3qk0saHjInUjlj/OUffg/wKgLgTIue
         eDmQ==
X-Gm-Message-State: AOJu0Yz33niC3L87s+FC4lbpH6C8zTL8Yj/bMRGrUzbZySONacvODcKX
	kf8OXwKPFgBj2ymxv31w2SUW4U/DfNFOEA==
X-Google-Smtp-Source: AGHT+IHcx225fckoMtJ4LeKav6+dRtZ3vv8CWubYpxumm76xMw0A4/K8rmjP9GYLC417nQxFFm2kBw==
X-Received: by 2002:adf:ff8b:0:b0:336:66ff:2031 with SMTP id j11-20020adfff8b000000b0033666ff2031mr4051141wrr.170.1703847049857;
        Fri, 29 Dec 2023 02:50:49 -0800 (PST)
Received: from [192.168.100.86] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id p7-20020adfe607000000b00336843ae919sm18728375wrm.49.2023.12.29.02.50.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Dec 2023 02:50:49 -0800 (PST)
Message-ID: <fc16eb72-fbef-4059-a871-ef229e1f121a@linaro.org>
Date: Fri, 29 Dec 2023 10:50:47 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] media: venus: Convert to
 dev_pm_domain_attach|detach_list() for vcodec
To: Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Kevin Hilman <khilman@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Nikunj Kela <nkela@quicinc.com>,
 Prasad Sodagudi <psodagud@quicinc.com>, Stephan Gerhold
 <stephan@gerhold.net>, Ben Horgan <Ben.Horgan@arm.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-remoteproc@vger.kernel.org, linux-media@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20231228114157.104822-1-ulf.hansson@linaro.org>
 <20231228114157.104822-6-ulf.hansson@linaro.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20231228114157.104822-6-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/12/2023 11:41, Ulf Hansson wrote:
> Let's avoid some of the boilerplate code to manage the vcodec PM domains,
> by converting into using dev_pm_domain_attach|detach_list().
> 
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
> Cc: Vikash Garodia <quic_vgarodia@quicinc.com>
> Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
> Cc: <linux-media@vger.kernel.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

On top of 39676dfe52331 - (tag: next-20231222, linux-next/master) Add 
linux-next specific files for 20231222 (7 days ago)

Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

---
bod

