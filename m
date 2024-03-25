Return-Path: <linux-pm+bounces-5326-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C4488A83D
	for <lists+linux-pm@lfdr.de>; Mon, 25 Mar 2024 17:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83C681F3A074
	for <lists+linux-pm@lfdr.de>; Mon, 25 Mar 2024 16:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8490886270;
	Mon, 25 Mar 2024 13:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hnnR4KZK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A918625E
	for <linux-pm@vger.kernel.org>; Mon, 25 Mar 2024 13:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711374458; cv=none; b=olebygTklQEOzcJ6FrlI9XvkGu64BrSYSUDXqilX7Oo7qIYUnujZh17CjiGnjKmxtcT/R69RWvBkmQf5Q/wugGi+hQKiENqEeoHTDW8DW3bE1TG3dVyHdrNgIr0nxUkqaWxvveTsMCgtOqirvftaHfc5+8c6liBPHl0bD27O0Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711374458; c=relaxed/simple;
	bh=SuIRM/3Q6w7TaZkKYsx/rzdQjJe9T75LpZogkG5lMpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d0tLv64oxk+1N2yq8573/3JiYUVNRrCd/dutSpHuWQ7xeuVmQZ5oWwpHq3Uj7ksIq9GEi/MJqnNvjzNzzdr/qwJH6Tr8nmyajPgXNKb5NoVVwyR0Emh7Vv+PqL77XtYfi10K9rFYmlXgntK8d8LOiHEYT06NMGnD2zyvMfmE9xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hnnR4KZK; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33ecb04e018so3063430f8f.1
        for <linux-pm@vger.kernel.org>; Mon, 25 Mar 2024 06:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711374455; x=1711979255; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ak1tU1hAMrwRs+LPSBUwIgy4Aqmw1ipgIVU8IK0CaAk=;
        b=hnnR4KZKGmHRorXH8S4KGSwsp1MNYyxNTnSJFbArZ0Udh7blkQ0NmCKyrbQjN7Lb3V
         4lxqNWqPlVSa5mcDZQXTs0CRVA3/GCVpoY3yWHI/e62FJ5qKz+YjBaH78lhym6/0xM1o
         Tp1vecAGxqPAoudAARS0QEFHQncQS2w0iFhgEsiC6SqcRKr67z/wW3Uk0xJ3AjyBzIxe
         pMhR6PZbHWCddJO7W8kCj4K3gGSjhBlWxwuxgbpgITPuIoF1J/ACzP/5Q8x3PzG5ra4H
         +lSmbDL41Z/bSeo/2L7wWOGIxbDxjSmnUnDT5Oy7TV4OWy2J9zBoUu0rmhDXbTIG6INv
         Rf3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711374455; x=1711979255;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ak1tU1hAMrwRs+LPSBUwIgy4Aqmw1ipgIVU8IK0CaAk=;
        b=VrMD95K0UbjJosOuHhneeMgo+3vFifuEgXeLIRTpMCMhRow2J76gkJ1PQpbTprQp6t
         YgZgl0LiQMZyaoLWhNVbeWWG526BOou1UrYBk4Cfrd0bQ6k/pf8b7Aq6yaMcitpKPhJU
         5UbP0vQ61zBRIPRpZk1RlIvpWUGhRUMhQhS4kRWYt4jA4CTEmYAemGLI7jbTAGu03zb/
         WvKshQEgG6q6GS7n+An3tMyLrzma5XY6/7D7FGfs9RErwy1YjsZ/CiP0F15hdkvMFpe0
         3YbX9jWnWwLO6tiOE4jay9ai9Gk9suxIBaLzPR83yLRo6+bZGwfNJOZQvMoh4h6J/zN+
         s/VA==
X-Forwarded-Encrypted: i=1; AJvYcCX/lGN6v/pWAO1gmIbwGq0buuDwUAEYfj7xreQSyCs7GBP8OfSYYzQO70apt2dYmVnlIswjMTPu9LuXTM4NRcSTU0zWCWaw4LA=
X-Gm-Message-State: AOJu0YwrzQ+RQGbhZTZJ0y70F0fRCAsT/ExcBAv5Rpni7PMJR0VJ5kq5
	Q9SN8cjZXWG1SuDRdOA1ICVbUSjL+JVVas6L/hZuC+95YHjXxJYMEI1vIUinwaA=
X-Google-Smtp-Source: AGHT+IF7KdIGQlqGnlG2Se4SlU0THQwzSCPNQgRzsRuSHRDL4SNJc7TBiOopCAeuLAKnQhCBUsp9Tw==
X-Received: by 2002:a05:6000:4c9:b0:33e:c070:686c with SMTP id h9-20020a05600004c900b0033ec070686cmr4717780wri.45.1711374454950;
        Mon, 25 Mar 2024 06:47:34 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id e7-20020a5d5947000000b0033f20497d4asm9590291wri.5.2024.03.25.06.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 06:47:34 -0700 (PDT)
Message-ID: <1f028df8-435a-43cb-b776-0c2141f1c374@linaro.org>
Date: Mon, 25 Mar 2024 14:47:34 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] thermal: More separation between the core and
 drivers
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
References: <2331888.ElGaqSPkdT@kreacher>
 <42ffcfb8-33fd-4ea5-bfac-fa8c78cd1cd4@linaro.org>
 <2273843.iZASKD2KPV@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2273843.iZASKD2KPV@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25/03/2024 14:39, Rafael J. Wysocki wrote:
> Hi Daniel,
> 
> On Monday, March 25, 2024 2:33:27 PM CET Daniel Lezcano wrote:
>>
>> Hi Rafael,
>>
>> thank you for this series.
>>
>> It has been reported a regression with commit cf3986f8c01d3. I'm
>> investigating and confirming it. If it is the case a revert may impact
>> this series.
> 
> Sure.
> 
> Can you please give me a pointer to a BZ or e-mail thread where this is
> being handled?

That has been reported to me directly. In a moment, I'll start a thread


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


