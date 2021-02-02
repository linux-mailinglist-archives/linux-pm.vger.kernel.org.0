Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5AF30C8FF
	for <lists+linux-pm@lfdr.de>; Tue,  2 Feb 2021 19:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238123AbhBBSGz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Feb 2021 13:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238211AbhBBSEs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Feb 2021 13:04:48 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C7CC061573;
        Tue,  2 Feb 2021 10:04:08 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id a25so25056613ljn.0;
        Tue, 02 Feb 2021 10:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iGm957EAqC35f2tVXf0aXXYAaAN+/zd5ezyK81HFpGA=;
        b=o3/CHju6eXYlhS9XmSqXGD5swbvx7AxG46g1fhG4aOuuW5XGug/MbxG1xLvYmBoeuq
         L0lqJxV/8Ns4cgt+hEBpJvtOZlXIW8yYcI+ABSStHqzwJrrZql0UL/+XQ4fO1f0zpqUg
         gU9FxKwIHCkmsu0YJ/ffQU2eebGRHnVc/8211oi9xupIKOg6SnoVW1O7VBxpagFt0W4B
         v88Ab1J2d5PAUUm+AVVOO3W3m8FMtd5DR7Nu0gAvqi0JV44prZgMN7mRC+McPRc85pGr
         2xmWEhYxFEIlv+op6PeQOVTeFDcVsz0ipOgMnEsLrwXBEynaoYvRrZYAVbFUMB/sFA/m
         ww3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iGm957EAqC35f2tVXf0aXXYAaAN+/zd5ezyK81HFpGA=;
        b=VoHrC3I+/KnfwvSQy1xntrPYOotGAoEfSu21M6VYGgpLOZYBgFkEmceCnhsZ/Y+RAT
         +d04r3RDu/SsOAFTZ7RNLrdpjGJSDqUCJRrcRfTR7BS+j+q3US675DEM6RrbiCthRao9
         Gx2iEIqPLliKFxML0cFMnfLOxOX1i9q9KFYQs6FMRmiCxxdB8nm0cK3FejcNl7tcp8es
         2tmxVAu8YZ594uXbJcVSC6Kp6k9AAL6lJ5bziLlSG0VwQhiPXi/1epJjNiQ24q1pdnSA
         g9qeUfbgwA7tGnSa4G3WSBABToxSTxM/M0i7HcnHrjKiuLvk7HS/V8p78InkXF2DjnTP
         Kl7g==
X-Gm-Message-State: AOAM533O6sIlDJ/CzNeQIJO7T5hwqnDMlQYOABqSylBjPdDBSFc+fEPE
        CRavjRYpPR5T/Yi3KHGUN+IjsIBzkLY=
X-Google-Smtp-Source: ABdhPJwys5lTkySfyVwjPPEYacW6mYA7R8a015g4MOjY03STT16mDTfzTx5ZKZGYop5WvU+9M6OLCw==
X-Received: by 2002:a2e:b4b1:: with SMTP id q17mr14380485ljm.267.1612289046116;
        Tue, 02 Feb 2021 10:04:06 -0800 (PST)
Received: from ?IPv6:2a00:1370:814d:ea25:a10:76ff:fe69:21b6? ([2a00:1370:814d:ea25:a10:76ff:fe69:21b6])
        by smtp.googlemail.com with ESMTPSA id w13sm4413923ljw.115.2021.02.02.10.04.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 10:04:05 -0800 (PST)
Subject: Re: [PATCH V2 3/3] opp: Add dev_pm_opp_of_add_table_noclk()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
References: <1b58a72fa4d6aadc9542a66f8150150534752d81.1611817096.git.viresh.kumar@linaro.org>
 <a251d7a7245a2ded97b282b8dfda95359698bf22.1611817096.git.viresh.kumar@linaro.org>
 <72a546c5-8a7b-af8c-43aa-5344073f8623@gmail.com>
 <20210202050230.g7xxo6373stfvzbi@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <5130bbcf-2531-a5d4-4f30-315bbf485711@gmail.com>
Date:   Tue, 2 Feb 2021 21:04:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210202050230.g7xxo6373stfvzbi@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

02.02.2021 08:02, Viresh Kumar пишет:
> On 01-02-21, 23:00, Dmitry Osipenko wrote:
>> 28.01.2021 10:00, Viresh Kumar пишет:
>>> A few drivers have device's clk but they don't want the OPP core to
>>> handle that. Add a new helper for them, dev_pm_opp_of_add_table_noclk().
>>>
>>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>>> ---
>>> V2:
>>> - Split this into a separate patch.
>>>
>>>  drivers/opp/of.c       | 18 ++++++++++++++++++
>>>  include/linux/pm_opp.h |  6 ++++++
>>>  2 files changed, 24 insertions(+)
>>
>> For the all current/latest OPP patches:
>>
>> Tested-by: Dmitry Osipenko <digetx@gmail.com>
> 
> Hmm, I have now added your Tested-by to all the patches that we worked
> together on.. 
> 
> Thanks.
> 

That's exactly what I meant, thank you.
