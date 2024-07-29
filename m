Return-Path: <linux-pm+bounces-11537-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5C093F5F1
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 14:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAE34B22BB3
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 12:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EAC14901B;
	Mon, 29 Jul 2024 12:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEWM6sUU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C269A146D6D;
	Mon, 29 Jul 2024 12:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722257749; cv=none; b=c/U69MhNzxvrXDG5dO2OXdkGu2MPL4PztwU2uw1wAwBSMN/HhT0MSFRx4T1RBuGo0iwggySGzE+pCflIq6NbC/bgapCsq5m8YnTly2MtxHhE9B8eBThVBUwnzbS+gHwSBMSskILq4PJvKR7S/TuRZhf4T5kLO4MFOqvJ8NwU260=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722257749; c=relaxed/simple;
	bh=U1webEH2RCY9liuGqqqp7vkAF6n3Hx9x4RWxqUrciE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YwNMHws8hQkSoHVAeKWYwTqjFn8+T3A9G/HHWtwbs2WpKBcFNLvOYVTPgG9uWyGigYGWHch2qihT43UZUwW8dAcBt8vda4+SW2a+iJTz+JVChp1GfQrIAo5cAn5hwATYjoE61OVI3urU7fSUxbdEem2xSmlQAbrZWutEnU6y/lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEWM6sUU; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7aada2358fso632250766b.0;
        Mon, 29 Jul 2024 05:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722257746; x=1722862546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qR/vBojdZFsa2xaAseqMvWWZxAcLC6Y8RjNWdERSqmU=;
        b=SEWM6sUUy7ICGHq7FEiFjuJq8kAx9JZ06gH9P7Lw/vaeK/6SlhfSb3+nEaloUWAT3Y
         5hbg5VeSYlwy+ZHxK5/l87ahFCOHuQ3KwJa4ATwLebbPL1SwzZGV+RxMjcvIlzCczElQ
         HU5va73iL3mgbbk3gvKCF9EbuFbjbqjYmhPTQBDIOnO2UsYfyPTV0yfiLQj1uO2S5Xid
         rzJl5bdDy9JZJCI0Bm36us2AhQtWqUrQ3psvJabYMPmlaBBEaRKItZijNz+QqxNUgQTB
         AOd10iB5imBiQsWwIsoEMLtcdTsqhJe3ViydLW6NcgDR6wAxQPCF5iRZznZ8J8J0KDMM
         yuMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722257746; x=1722862546;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qR/vBojdZFsa2xaAseqMvWWZxAcLC6Y8RjNWdERSqmU=;
        b=THizywimR+DLruUcRdn3BHG3aqPZ37ces+zNdMHWrmMuQMsInKLfhaLl3OxyMFIDnf
         NmY4nLl6UNTlFSfHN5Cxj8zw8WzjEwUId4hiQjkH4eeRfS/mwfXmq40LiEKoA2GpH5DG
         UO1iBIuUi0rNRGI38vtpJ8siLtpx3qQdYIwyywwaWlS/NWtGIcxJn7yba14fsht56xSL
         VEADujDfOvxG94RWdxPdqRI6vvsQsAr1bCZ7Be4KcVV6iAH6CIQZscME0FsyzLL3k2+M
         oc13dtxGUm5eDh2NwmRIVRZFRmgswkxco05874Hk0Nu25mSSLE0u/RzWLQ6tUBbfZL6U
         6d7g==
X-Forwarded-Encrypted: i=1; AJvYcCVcm1kgobEh/NVUJ+tpwAvbGTZKh54DV8W1zS++V+DZX/0/xE83ZKvnana0kOxCjsdy1gpLVxS7gXxFq7zWn9jgNkicWEXJsLGaDiRwewB2GEc+XUvYAjF6XQycrB+O1H6LZfRUI4V9TgUaUMYHZ60POKy8vkf9fro6qIvpUiO/yEOcY6iW
X-Gm-Message-State: AOJu0Yz5Nfu+YAGfwqHwyltCjnQram9GwdYY0tnUaNFVXKfxBlYa3E7a
	cfBQgC2xeL2SgB5lDLt5iPSClCS5Qglr5t9YwPbystlrdSzjSruN
X-Google-Smtp-Source: AGHT+IFYLxLa5C1lxPvmKsruDwbb3MC0Hd7b22TT+Vxz0bhSckaKQDDQduUgdElX8FsESFUOAIKHkg==
X-Received: by 2002:a17:907:60cf:b0:a73:9037:fdf5 with SMTP id a640c23a62f3a-a7d3f81dccdmr851992166b.6.1722257745634;
        Mon, 29 Jul 2024 05:55:45 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad4117asm506350166b.133.2024.07.29.05.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 05:55:45 -0700 (PDT)
Message-ID: <a1ff72a2-7992-4ebd-b48b-2bb85335edaf@gmail.com>
Date: Mon, 29 Jul 2024 14:55:43 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: update email for Konrad Dybcio
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-kernel@vger.kernel.org
Cc: Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-pm@vger.kernel.org
References: <20240729125225.2090-2-wsa+renesas@sang-engineering.com>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@gmail.com>
In-Reply-To: <20240729125225.2090-2-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 29.07.2024 2:51 PM, Wolfram Sang wrote:
> The old email address bounced. I found the newer one in MAINTAINERS,
> so update entries accordingly.
> 
> Cc: Konrad Dybcio <konradybcio@kernel.org>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---

Already sent a series of fixups, but thanks for keeping track

https://lore.kernel.org/linux-arm-msm/39a2303c-c89c-4fa3-a2e3-87589d242f4e@kernel.org/T/#me914f204e70ab34dd8bc3e6cbb51747490a81817

