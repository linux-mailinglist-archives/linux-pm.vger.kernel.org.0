Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4131684C5
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 18:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgBURVq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 12:21:46 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37308 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgBURVp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Feb 2020 12:21:45 -0500
Received: by mail-lj1-f193.google.com with SMTP id q23so2985355ljm.4;
        Fri, 21 Feb 2020 09:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CvuDNKeU+rm8KnyVI1BSRu9KN4IH3E88OS8OkYP5kyk=;
        b=YqUIX4hGeh7FgBk8jDQIZ0IqyxE+MpJm0f9cyOc39FhuYRtHnOf9GvTJQie2n2+Xt+
         1lthSU+yZyR+jNBoTe2Esi4/tI6j5dy1o0+B9EIxJb8rxv01bltfLkvyY6y4O7cPA+vb
         Yy4auUM2+P0juteh25Q33Lja8fG3y6EGqlgeEK+rFYtPKV/q04Gd0h0AYns/13g85r3k
         jGrPg/KBNITyA3VFZYENd/jBfj9bLZ6/GnFuY4u7v7TkNwLHYk3zSNGZHbiilg0ygUKo
         AWa63MTdlXiO5Xmfzu3DoJ6BeWJSO8cOX5Z+RAyhGrX26Nz5jFOtCY5NugxWCA2bcLCQ
         Z26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CvuDNKeU+rm8KnyVI1BSRu9KN4IH3E88OS8OkYP5kyk=;
        b=fvMUzPNGj+2PPoZm0vnqtzE2GCZa1sc3UuJyin7aYUcJS4k0dSkSnddelX4Uz7Jihc
         eBMtmXRB3AGvZihildxKxbqiCb1glUQSmGQ7Ska6Xw4lBO05VjhLjBvJ2Pq6ay0OOdwF
         4reO0pJqRhegtTyLsMwhJH7TxrOc713+nRGS6oWHoC/OHfXVwwylzkV7dfd9VP+NLyL0
         ndPFyXrkfcrOjEthqNn1Fq9pdCEtEzCgbJ/9zvYWUtbdnl3UNxvNX18mmHkYlC6jmsf+
         JFo7Y6KrmpIXyQ3ZCPQEeDXlOZetNiMM1L4bRMnHTTXXSWu25UMAeXjt/F1yBGTwxKhi
         yKCQ==
X-Gm-Message-State: APjAAAWBCtzGF8ybpBkaetNfIVzXF33opN6XnCAif2FFhf1eOrRJ/0JD
        fgvfyUS79rCIbCgmqPoDVSPTFdPw
X-Google-Smtp-Source: APXvYqzXSlsPKgeqTvfnRB49wQ13cU988V03irwGQqoCiDEwv3LJdYl+Ah74AiBQ2RqzqGLZwL2Z2w==
X-Received: by 2002:a2e:a361:: with SMTP id i1mr22254567ljn.29.1582305703125;
        Fri, 21 Feb 2020 09:21:43 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id b17sm1984588lfp.15.2020.02.21.09.21.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 09:21:42 -0800 (PST)
Subject: Re: [PATCH v9 05/17] ARM: tegra: Propagate error from
 tegra_idle_lp2_last()
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200212235134.12638-1-digetx@gmail.com>
 <20200212235134.12638-6-digetx@gmail.com> <20200221151612.GJ10516@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1a8c81ab-6f6a-8221-6a4e-c080ba595836@gmail.com>
Date:   Fri, 21 Feb 2020 20:21:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200221151612.GJ10516@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

21.02.2020 18:16, Daniel Lezcano пишет:
> On Thu, Feb 13, 2020 at 02:51:22AM +0300, Dmitry Osipenko wrote:
>> Technically cpu_suspend() may fail and it's never good to lose information
>> about failure. For example things like cpuidle core could correctly sample
>> idling time in the case of failure.
>>
>> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
>> Tested-by: Peter Geis <pgwipeout@gmail.com>
>> Tested-by: Jasper Korten <jja2000@gmail.com>
>> Tested-by: David Heidelberg <david@ixit.cz>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
> 
> [ ... ]
> 
>>  	cpu_cluster_pm_enter();
>>  	suspend_cpu_complex();
>>  
>> -	cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, &tegra_sleep_cpu);
>> +	err = cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, &tegra_sleep_cpu);
>>  
>>  	/*
>>  	 * Resume L2 cache if it wasn't re-enabled early during resume,
>> @@ -208,6 +210,8 @@ void tegra_idle_lp2_last(void)
>>  
>>  	restore_cpu_complex();
> 
> If the cpu_suspend fails, does restore_cpu_complex() need to be called ?

Yes, because suspend_cpu_complex() didn't fail. I don't see any reason
why restore_cpu_complex() shouldn't be called, please clarify yours thought.
