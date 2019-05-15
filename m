Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 726831EC66
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2019 12:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfEOKwB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 May 2019 06:52:01 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37901 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfEOKwB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 May 2019 06:52:01 -0400
Received: by mail-wm1-f68.google.com with SMTP id f2so1999020wmj.3
        for <linux-pm@vger.kernel.org>; Wed, 15 May 2019 03:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IY0nzwi9vKnpYmNvcMep+bJnSeq0GrA/o59QaEDPfVQ=;
        b=K2uR2Hju4uVhWUovulzfQOZU2sVFJxpNv9FmCPIwXXyr2OfVIG8MmyjhceWV5Qcgwc
         m/6Oie/dGfo/vulbf6FK7clXnTUuHqH3HmdEQDkPMbH+FWOYiSBzAeBrBpgs8RFhLFt3
         I6nQbdna/eXio9Em1jQnzxl9jBTf0Cj38IBW5kQDc0QXS4ehFL+iKKP7MVR4gQU8jnoa
         grpahXWuL73Jw6za1/HUgCW/4HKMq7mEW4Q2EelfNaUTf7RJneR/o/BbpQ9V3OudxzsY
         X3vt87hz8kGlqdhIj0R9F18XwKuvKvZddF7io6HzFP+Ywxmlw4d5cJWgf0IvKyBo/L4a
         c1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IY0nzwi9vKnpYmNvcMep+bJnSeq0GrA/o59QaEDPfVQ=;
        b=CR97e3ZATC11oOktOtNEA0IeB94v6bg0E5ubEOKVQHc8LPIbhXYXF5X9dMfrfXx1/b
         st0D/lUYWIdD9ZNH9xpbzX2pbXu+LxmYHCRLguFDFaHBSWMWXpAvsw/jcVct93VFjUOF
         +3dHryXS4kT1ihZvEqHtj6PrXJmk6E/srQBpXyGccrcS4kBvZNvXKNQbNWt6Uudue6o0
         Y6lECYgGG3+xfylT1GZD+1Ltnwc2Vzp6SuOyRrwOhnxvDDCkWsFqzG/LelqHTKx5XL12
         3d0GqKr8R3RfVPgcqN5hLWiyYn9wQg3SdMqIRpyXEq5PtDh5CefUoIZviL8gsKdW9SLB
         zpIQ==
X-Gm-Message-State: APjAAAVhsT4QAdSBxBvNKciYgeniJU/jDGCDjcBRUvvj9n62CZRQSOh8
        sdI6YATLmggrvuRCatEUdQgqRA==
X-Google-Smtp-Source: APXvYqwa5QWMFUDmftHE7rA4C0Yvc38krvWgUpgyt9+ZE5+St4UDo8Ytls1Q4BoTcgwZtiLaO+iAWg==
X-Received: by 2002:a1c:eb07:: with SMTP id j7mr22011249wmh.138.1557917519110;
        Wed, 15 May 2019 03:51:59 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id y184sm2071278wmg.7.2019.05.15.03.51.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 03:51:58 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] PM / EM: Expose perf domain struct
To:     Quentin Perret <quentin.perret@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org,
        amit.kachhap@gmail.com, rjw@rjwysocki.net, will.deacon@arm.com,
        catalin.marinas@arm.com, dietmar.eggemann@arm.com,
        ionela.voinescu@arm.com, mka@chromium.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190515082318.7993-1-quentin.perret@arm.com>
 <20190515082318.7993-3-quentin.perret@arm.com>
 <0ced18eb-e424-fe6b-b11e-165a3c108170@linaro.org>
 <20190515091658.sbpg6qiovhtblqyr@queper01-lin>
 <698400c0-e0a4-4a86-b9df-cdb9bd683c0f@linaro.org>
 <20190515100748.q3t4kt72h2akdpcs@queper01-lin>
 <cf1474cb-7e31-7070-b988-a0c4d3f6f081@linaro.org>
 <20190515102200.s6uq63qnwea6xtpl@vireshk-i7>
 <20190515104043.vogspxgkapp6qsny@queper01-lin>
 <20190515104651.tv5odug7ce4zlupc@queper01-lin>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <5b55e432-f8b0-91ae-a7de-fe02e0cad322@linaro.org>
Date:   Wed, 15 May 2019 12:51:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190515104651.tv5odug7ce4zlupc@queper01-lin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15/05/2019 12:46, Quentin Perret wrote:
> On Wednesday 15 May 2019 at 11:40:44 (+0100), Quentin Perret wrote:

[ ... ]

>> +#ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
>>         if (capacitance) {
>>                 ret = update_freq_table(cpufreq_cdev, capacitance);
>>                 if (ret) {
>>                         cdev = ERR_PTR(ret);
>>                         goto remove_ida;
>>                 }
>> -
>> -               cooling_ops = &cpufreq_power_cooling_ops;
>> -       } else {
>> -               cooling_ops = &cpufreq_cooling_ops;
>>         }
>> +#endif
>> +       cooling_ops = &cpufreq_cooling_ops;
> 
> Argh, that is actually broken with !capacitance and
> THERMAL_GOV_POWER_ALLOCATOR=y ... Perhaps it's best to keep the two
> thermal_cooling_device_ops struct separated in the end.

Or alternatively you can keep one structure but instead of filling the
state2power,power2state and getrequestedpower fields in the declaration,
you fill them in the if (capacitance) block, no?




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

