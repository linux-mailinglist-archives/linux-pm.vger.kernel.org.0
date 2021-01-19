Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB562FBD67
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jan 2021 18:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391406AbhASRTD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 12:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391464AbhASRSn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2021 12:18:43 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF622C0613CF;
        Tue, 19 Jan 2021 09:18:02 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id m10so22805689lji.1;
        Tue, 19 Jan 2021 09:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r2VWX7pbw8QWI+tIAA7qRgNwILwoCnRnHzLsTEGFOOI=;
        b=CC64yTs+vd2UOAbN094YAo0g6Kqh+GXU9S8bCq5qzZccngXxz92LrhW0xf07diGINK
         xGf28z75IPS/QoNhh14sPjvojzhr+7YvZaoG/HtxJOx4A9B/faNsJp4SuR4nmNVtzS+D
         vvYyTXOqr14Mx9RDRTcPKtv3XJAHrP774EawAZht0WuiEAmy+6tTl098uLKCsPqn3BvZ
         tiYWUEOkjKsK+gI3FvnxBzl1nMkTrqUZRGkDb7mDRGEANEC9f4bbUs7MNcS3xduFrrQq
         JShUc6BX0BtOWhQjx0t/Uk69k6MSE8dq8ZIK8nGuemkXDcr8pE7EoRFUOfVA+BmTTFGl
         88Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r2VWX7pbw8QWI+tIAA7qRgNwILwoCnRnHzLsTEGFOOI=;
        b=F6vFIwSQDGZ76oDyqrXZml5nKbl8FHlYwrYAmoxXlFAYJh7zQeG+JD54eeXOZdWrTw
         LVLd/S3WJT1J8UoG/5Yo3tOcZXlJDgH5Is5NJiq4ahqncANVW6D5GYrlpWKOSJF+yoXS
         eRCUzSsLSOlmEswReBW8CEDsipFQCjZlF7sHwwChjYs6iQs/Sgy+muS88v2Q3xiIPYk9
         eFT5wrFv5BB4+PfUd5NEMsLBj1825hj/PmtF7AxHRx8uN0ZYHdIgRwIceOCTtvmSOJ4t
         aENLt3VFSdSZ403x99RlKs3+fGKUKVPe2jFA9VXwVFB6MC+0G7VPmx0xdYhPKpB3ziie
         WdwQ==
X-Gm-Message-State: AOAM531Jf7rcsHkbsOJ+oB/879GYf++LwlrkZW9t1Uw+9Eoeizxe5r19
        q8mHkFAxj6MD3Y6V45Ef3VTBsfSRqDI=
X-Google-Smtp-Source: ABdhPJwFT5RBJodUnhhNaFUZe8SF26+4QRgUWQCn4PQWLGk4818SrwMsz922byrbHIB1mLvvpUOm7w==
X-Received: by 2002:a2e:9849:: with SMTP id e9mr2302916ljj.319.1611076681264;
        Tue, 19 Jan 2021 09:18:01 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id a15sm2012870lji.105.2021.01.19.09.18.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 09:18:00 -0800 (PST)
Subject: Re: [PATCH] opp: Prepare for ->set_opp() helper to work without
 regulators
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org
References: <fb69353c-a35b-9b7c-46bc-d464c6dab6f5@gmail.com>
 <302c014726dbd9fcde852985528c139d2214a1f2.1611038066.git.viresh.kumar@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <8568b543-99e4-628f-128b-8c990aeeb6c2@gmail.com>
Date:   Tue, 19 Jan 2021 20:18:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <302c014726dbd9fcde852985528c139d2214a1f2.1611038066.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

19.01.2021 09:35, Viresh Kumar пишет:
> Until now the ->set_opp() helper (i.e. special implementation for
> setting the OPPs for platforms) was implemented only to take care of
> multiple regulators case, but going forward we would need that for other
> use cases as well.
> 
> This patch prepares for that by allocating the regulator specific part
> from dev_pm_opp_set_regulators() and the opp helper part from
> dev_pm_opp_register_set_opp_helper().
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Dmitry,
> 
> I haven't tested this patch, can you please help with that ?
> 
>  drivers/opp/core.c | 81 ++++++++++++++++++++++++----------------------
>  drivers/opp/opp.h  |  2 ++
>  2 files changed, 45 insertions(+), 38 deletions(-)

Works good, thank you. It also almost looks good to me, please see my
other reply regarding the locks.

Tested-by: Dmitry Osipenko <digetx@gmail.com>

Now the set_opp() needs to be taught about the sod_supplies in order to
actually make it to work without the regulators, I'll make a patch on
top of this change.
