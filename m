Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3FC411032C
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2019 18:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfLCRJv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Dec 2019 12:09:51 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38222 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfLCRJu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Dec 2019 12:09:50 -0500
Received: by mail-qt1-f193.google.com with SMTP id 14so4513798qtf.5
        for <linux-pm@vger.kernel.org>; Tue, 03 Dec 2019 09:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=01XTZm3AS7koka7w5jivDQ2JG2pQ51gmspKmJxBqM1Q=;
        b=zJPRWJCQ9gSKKHtNoQkPpkVhPb6G6MprpMmhaSzr6kW4vteKLinPQTkgn9416FJR69
         5lV9+1PlE7XPHwUgdc3JuwuwuZvFSTrGcqQjeYO4B2EHn5o42yH79D91//r/DHMnYHjE
         p0sxOGpehEgghxcN3sWqp0qnnfvr8q1HOAsQNWL3Ni4U0Q27bRl6xGlxGD22EBtadzDN
         njofEhekijY8AqIt+naPajyVpehpTo7eElacvXb636tGr/odwDcpVtXcCIxFcDZs7Sj8
         zd9+xfqnP5ZIfrnOs0Ra4M6KZM1gVOuXjIayqFfAmY0W2fkycELAp2a4uSvbtYRbdMxN
         v8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=01XTZm3AS7koka7w5jivDQ2JG2pQ51gmspKmJxBqM1Q=;
        b=mITVWm1gCKJ2K9YTsy/EeNdDzoHZnU0/rrlO10pLJJPSbgzELCJybco6chcSwDrq00
         egGXWSrZswXNWj5i3quuhY2lnoH32UVzRQKoVXAvpSsDUZ6evGTb+z2Te2KxkOa7KKlB
         zcl+f69GheR9OQBOLyyL7LzPgE6iYfkaQONNhAGnd8KjGVGMYTKmjZxZ8N73L7FvV6DD
         Lvq3V62Gsk7TV2g+0vdZ9Cv4YwmyAGHXNKWS0mhx2uSASAFbjdgW65SRvKc0bXxgb7iN
         SHZgVzLDa5vSvVmzRY4Q137iwXh7/xVEgheVuwfqZcrxBlnTP0Yfv0Jxvb1aoLQLPv4l
         ky3g==
X-Gm-Message-State: APjAAAVFw3t6Lw6QY/7/mcx+o5or2zdowfIZOmTQCmlO7mKkQ2KG+jNq
        Knha984FKRNeG0Ae5BFfk15PDQ==
X-Google-Smtp-Source: APXvYqxswEP7BWTESkF+xDQwJvwSyualWlw2Wic9gRROnndJ/Dzzf7wxni2jTzryB5DqNqTh3dTqYA==
X-Received: by 2002:ac8:47cc:: with SMTP id d12mr5995726qtr.246.1575392988911;
        Tue, 03 Dec 2019 09:09:48 -0800 (PST)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id s189sm2058727qke.41.2019.12.03.09.09.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Dec 2019 09:09:48 -0800 (PST)
Subject: Re: [PATCH v3 3/7] thermal: core: Add late init hook to cooling
 device ops
To:     Amit Kucheria <amit.kucheria@verdurent.com>
References: <1571254641-13626-1-git-send-email-thara.gopinath@linaro.org>
 <1571254641-13626-4-git-send-email-thara.gopinath@linaro.org>
 <CAHLCerOCt9VBizAHu+y+CmzFmz-ktqCJgcB_NeC3WC4W9YBvAQ@mail.gmail.com>
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5DE696DB.7020308@linaro.org>
Date:   Tue, 3 Dec 2019 12:09:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <CAHLCerOCt9VBizAHu+y+CmzFmz-ktqCJgcB_NeC3WC4W9YBvAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/03/2019 12:04 PM, Amit Kucheria wrote:
> On Thu, Oct 17, 2019 at 1:07 AM Thara Gopinath
> <thara.gopinath@linaro.org> wrote:
>>
>> Add a hook in thermal_cooling_device_ops to be called after
>> the cooling device has been initialized and registered
>> but before binding it to a thermal zone.
>>
>> In this patch series it is used to hook up a power domain
>> to the device pointer of cooling device.
>>
>> It can be used for any other relevant late initializations
>> of a cooling device as well.
> 
> Please describe WHY this hook is needed.
Hi Amit,

Thanks for the review. This patch is no longer relevant.
I had posted a v4 of this series based on other review comments[1]

1. https://lkml.org/lkml/2019/11/20/355

-- 
Warm Regards
Thara
