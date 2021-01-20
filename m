Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2901A2FD434
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jan 2021 16:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbhATPhc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jan 2021 10:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732738AbhATOu7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2021 09:50:59 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FC3C0613D3;
        Wed, 20 Jan 2021 06:50:18 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id m25so34409844lfc.11;
        Wed, 20 Jan 2021 06:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cBqXSju5MQpyXZT7TRd3tw9tf9n3a0iWTPTNsPXD1Do=;
        b=mjPWV84XqqOL7UDzZTCBWj4XvmxGnVHg1vSkkcIocudNsh0h6E7J743b6+1Q7StUvY
         SYl6Gcm46jGYIptGGD+xtw3AsOV/wAPpvkmig6YSAR7S0NJWltAeql/PbERHOFL8W0WS
         XqCExWACZ19gXFREyJQV5bti7oS/Ejm2vs6DEBi7yrZX5CSAtrx/7mOtxKyulEKqcgQl
         pYXoGj3cYjcwKimsVsKpkxOCZraO2t2UplgKVtkDELCQE/y1dCOK7n/VYK4Iy148Dk9S
         4krn9K3cYOCZjDobfNTwUrr/B2iCPzgXAkQffvksH/o3d0lD6aD8pswhdqmdZy1v8W2F
         LwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cBqXSju5MQpyXZT7TRd3tw9tf9n3a0iWTPTNsPXD1Do=;
        b=cesaxOVzefGQNUPKWzHrBkiKyfmnNvjBsVEf+BSmyLZStqmbE7es//b7W65zw4RcRL
         b+hIa8pPctm0MM2JRKUwzHKEa0aSMRyScypnCC0e9iiiBbvDeLbHeHFryk4Nizc/aBlK
         TtZwqhkn+nu2Ho/P3CrZH+v5U4vL6sqx3x+mfcAI11NjgJnlo/kvzHVKqRBFXQfi+qIX
         zLQ0d3ovdvsq6Tzrg7W9kX77Qq+nAivtyw3h8l+G7A1L0mt1whbFyFC+tsm7o70tosW2
         qeL0+XAYDcXZtQuXB1m8LrgFIr33A6VE1+YtyTcWbFGn0JDiuJMtuTM4466jtNuWrmJw
         tiIg==
X-Gm-Message-State: AOAM532ny18sj9ITmPH6td9sQC8c+v/AljTZu5VxCne1SxbdEW7e+hW8
        bu+OdwUIjyGds+xIud6S1s7k8VehXwc=
X-Google-Smtp-Source: ABdhPJxXQNNER/8wy81LcEoHia0Eh2zmInWKNqS8pVkcJO1Qh6LSeaK2/QF00BiICo1UR1ufmOoz/A==
X-Received: by 2002:ac2:44da:: with SMTP id d26mr4002998lfm.221.1611154217048;
        Wed, 20 Jan 2021 06:50:17 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id m24sm218892lfj.126.2021.01.20.06.50.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 06:50:16 -0800 (PST)
Subject: Re: [PATCH] opp: Prepare for ->set_opp() helper to work without
 regulators
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org
References: <fb69353c-a35b-9b7c-46bc-d464c6dab6f5@gmail.com>
 <302c014726dbd9fcde852985528c139d2214a1f2.1611038066.git.viresh.kumar@linaro.org>
 <c657b5b0-b841-1b26-8008-2fb4b490d63d@gmail.com>
 <20210120073912.yl4rgkthdyyznbfh@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <94f4ed8d-ab54-4180-87f7-4ddafb52074f@gmail.com>
Date:   Wed, 20 Jan 2021 17:50:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210120073912.yl4rgkthdyyznbfh@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

20.01.2021 10:39, Viresh Kumar пишет:
> On 19-01-21, 20:16, Dmitry Osipenko wrote:
>> 19.01.2021 09:35, Viresh Kumar пишет:
>>> +	mutex_lock(&opp_table->lock);
>>> +	opp_table->set_opp_data = data;
>>> +	if (opp_table->sod_supplies) {
>>> +		data->old_opp.supplies = opp_table->sod_supplies;
>>> +		data->new_opp.supplies = opp_table->sod_supplies +
>>> +					 opp_table->regulator_count;
>>> +	}
>>> +	mutex_unlock(&opp_table->lock);
>>
>> Why do we need all these locks in this patch?
> 
> In case dev_pm_opp_set_regulators() and
> dev_pm_opp_register_set_opp_helper() get called at the same time.
> Which can actually happen, though is a corner case.
> 
>> The OPP API isn't thread-safe, these locks won't make the API
>> thread-safe.
> 
> I am not sure what you mean by that, can you please explain ?
> 
>> At least both sod_supplies and set_opp() pointers should be
>> set and unset under the lock.
> 
> The ->set_opp pointer isn't getting used for a comparison and so
> putting that inside a lock won't get us anything. We are only using
> set_opp_data and sod_supplies for comparison at both the places and so
> they need to be updated within the lock.
> 
If OPP API was meant to be thread-safe, then the
dev_pm_opp_unregister_set_opp_helper() should unset the
opp_table->set_opp_data under the lock since it races with
dev_pm_opp_set_regulators().

Secondly, functions like dev_pm_opp_set_rate() don't have any locks at all.

It should be better not to add "random" locks into the code because it
only creates an illusion for an oblivious API user that OPP API cares
about thread safety, IMO.

Making OPP API thread-safe will take some effort and a careful review of
every lock will be needed.
