Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2486C2AB03A
	for <lists+linux-pm@lfdr.de>; Mon,  9 Nov 2020 05:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgKIEls (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 8 Nov 2020 23:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgKIElr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 8 Nov 2020 23:41:47 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B00AC0613CF;
        Sun,  8 Nov 2020 20:41:47 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id l2so10579981lfk.0;
        Sun, 08 Nov 2020 20:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iZRG/P0XDE8J45minyMWYaCFUPrsvcXAimG9QNq9Z0Y=;
        b=bYLirLk/D0MDS+ujwv74DJRgYMnaZR/hT3gIZo1uL0Bop75Axl+nrqZ53bXZBJRwA5
         YCxsLmzPExFpAUGXyXRCPUNo8cWFeojuNyX+OosnqS4HlM72J+fusG77JRbgUWblPHlv
         ov0mfrhpGwm+orEPmUcgMqKUiQeSb/RRDdOv4mNBOqkHEgSQ8dzbW6U3gczVEIM0vHbd
         rV0Ou6RbaVSsz8a29x/2urAXP7IPRVknO0Xt6EQSdvJY0wINvKZBhFacVFxHV4pBZSBR
         nAgfZvYGz2AW4FMj4hyZN3JvDNQsIUwP7hKZVi1oqahPjJOVbIls7hp2eNnC+yjy26Us
         9GWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iZRG/P0XDE8J45minyMWYaCFUPrsvcXAimG9QNq9Z0Y=;
        b=KpnJmuTgpRoTdAornaxjNvWEo8Vf2rojguIeGlV+yJ1oIRTPTOTzZwf7SdCg9ZrpgW
         vKSn2KAFsOx94un84Nk7oH1zURMMp+f09Lp2yRuBA2TWgboOmvJgWIaH44NxWZziKwhM
         NVDD0SKyAlAEUerso8YnNfTx0RWBk57OxmUIeWp87UYsKI0h7gB6hTKaZHaQWWu6Xu/7
         NxFXHFem8CRe7z+AedAJEbDQrSSFp8ux22N9usb6fA/cduLaN6gB25yIDMj3ltJJa2Ra
         gS0KvkjiiZb4xaSyWRimRQH9Lrfv2vyhfdDDNpvVPuS42kco4T3cSkSFisDZZHC82nb1
         DJZg==
X-Gm-Message-State: AOAM532jw7hIvXGTPRAVUASgR4K5n2cJaTQEnZTPyA0nVoDJMDUmh38X
        sRKIUrunXr+M+ClEAzoD9Gzz35eqrmA=
X-Google-Smtp-Source: ABdhPJyNfJwo9zPe6AyxZQpLs4PtnOINPRJoAImNqhI6RiX+GzfpdvqRiP7epYAsAr5jX5A9jf5idA==
X-Received: by 2002:a19:6753:: with SMTP id e19mr4621055lfj.425.1604896905704;
        Sun, 08 Nov 2020 20:41:45 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id q21sm1515487ljm.52.2020.11.08.20.41.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Nov 2020 20:41:45 -0800 (PST)
Subject: Re: [PATCH 2/2] opp: Don't create an OPP table from
 dev_pm_opp_get_opp_table()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
References: <684ff01900180c0a40ec307dacc673b24eab593b.1604643714.git.viresh.kumar@linaro.org>
 <1012a98950355bd5a52424668050a17c3430cbe0.1604643714.git.viresh.kumar@linaro.org>
 <ec9839dd-5d2d-0d6b-6563-b14da4af1a57@gmail.com>
 <20201109043457.xf55kufhjjz2fvct@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c5078503-ee14-0f84-85fd-9c6e55d2e897@gmail.com>
Date:   Mon, 9 Nov 2020 07:41:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201109043457.xf55kufhjjz2fvct@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

09.11.2020 07:34, Viresh Kumar пишет:
> On 06-11-20, 16:18, Dmitry Osipenko wrote:
>> 06.11.2020 09:24, Viresh Kumar пишет:
>>> It has been found that some users (like cpufreq-dt and others on LKML)
>>> have abused the helper dev_pm_opp_get_opp_table() to create the OPP
>>> table instead of just finding it, which is the wrong thing to do. This
>>> routine was meant for OPP core's internal working and exposed the whole
>>> functionality by mistake.
>>>
>>> Change the scope of dev_pm_opp_get_opp_table() to only finding the
>>> table. The internal helpers _opp_get_opp_table*() are thus renamed to
>>> _add_opp_table*(), dev_pm_opp_get_opp_table_indexed() is removed (as we
>>> don't need the index field for finding the OPP table) and so the only
>>> user, genpd, is updated.
>>>
>>> Note that the prototype of _add_opp_table() was already left in opp.h by
>>> mistake when it was removed earlier and so we weren't required to add it
>>> now.
>>
>> Hello Viresh,
>>
>> It looks like this is not an entirely correct change because previously
>> it was possible to get an empty opp_table in order to use it for the
>> dev_pm_opp_set_rate(), which would fall back to clk_set_rate if table is
>> empty.
>>
>> Now it's not possible to get an empty table and
>> dev_pm_opp_of_add_table() would error out if OPPs are missing in a
>> device-tree. Hence it's not possible to implement a fall back without
>> abusing opp_set_regulators() or opp_set_supported_hw() for getting the
>> empty table. Or am I missing something?
> 
> For that case you were always required to call
> dev_pm_opp_set_clkname(), otherwise how would the OPP core know which
> clock to set ? And the same shall work now as well.

Why _allocate_opp_table() grabs the first default clk of a device and
assigns it to the created table?
