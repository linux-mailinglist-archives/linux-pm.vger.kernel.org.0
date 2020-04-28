Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015D11BC412
	for <lists+linux-pm@lfdr.de>; Tue, 28 Apr 2020 17:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbgD1PuF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Apr 2020 11:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728050AbgD1PuE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Apr 2020 11:50:04 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16687C03C1AB
        for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2020 08:50:04 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j2so25240225wrs.9
        for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2020 08:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yT8C9Z0cwFWg9VQuzJhxHhG3ta75UnZwwwKuAE5M5tY=;
        b=avd/pmgWdLY1y8mQnSn0uB5ryWhU4mq8HAgoi7O/LPXfvHM9YVRyfiHaEF3eGtLHjo
         O2ubgIYBklniO3y6CuHwYELYbiKcaVmUSWntQbfaIK0CWhz66VXE9BlcdodN25zoASiS
         eAEvRHd3r1neXiHvCqN9XvQiuP9f3GZCRp2wvkHqQdy492cKSu0T8kGqzUmARV2JgDNW
         GHrv0i6AB1g9feyJR6CTpggjwMtw93bPmuWbLjwSZQjHYI7byREOTg8gbyIfm2/jrcRi
         kpmbYeqwuhKZT9h6zq7Zu9394OB0Pc3QYZtQ9a7HKRxAztXNrlgdvMQsnuzOKajqAJhl
         +GRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yT8C9Z0cwFWg9VQuzJhxHhG3ta75UnZwwwKuAE5M5tY=;
        b=C6rXbfh7yzzDOOGGsSGdypuOZVfL0FBj8hJNQa9EG9fwDm5iTKcte9U5I41HQISgHG
         0JFKnNmFwvCBWzHJnypzAK6PWr7ZSpz9ktqhLdshwzJ+4NCAh3DXXiFRVHddokyF/CRn
         CWPGHdqUh0Z2MhTVzBjk25bOePmG+QqFGOAW/lV6+pUZZELabSHzyrKlL/mXueehzWNn
         IOoV0OtSpAQSxUgPodx8EMUISnyZUivSdS/JI7iqMw7TnYa5qSZA0nGn69NO1I5HgnMW
         SafSPlBtR3FIaYWPYUMhUL+wm9a0HIofipjxt4pF6QH4vWty89Mhv1qvF+Pax0OOyjf6
         ZCig==
X-Gm-Message-State: AGi0PuZHgYuC3dwGHI93I1m9G5Ov67N3wTACJtXbO0d7R0FvBTbDR1Mp
        lBk/Veuh0zj+edfQFVMhaip9GQ==
X-Google-Smtp-Source: APiQypLuvf33xbU0o5nhAgBeuDXi+K0R0nlCHYf0M7ztjlUX/f2ATSV9hbXz0meRY4EtRyh3ktZ3Lg==
X-Received: by 2002:adf:c3ca:: with SMTP id d10mr35642201wrg.64.1588089002660;
        Tue, 28 Apr 2020 08:50:02 -0700 (PDT)
Received: from [192.168.0.136] ([87.120.218.65])
        by smtp.googlemail.com with ESMTPSA id f2sm27297345wro.59.2020.04.28.08.50.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 08:50:01 -0700 (PDT)
Subject: Re: [PATCH] interconnect: Add helpers for enabling/disabling a path
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     linux-pm@vger.kernel.org, evgreen@chromium.org,
        bjorn.andersson@linaro.org, akashast@codeaurora.org,
        linux-kernel@vger.kernel.org
References: <20200428091650.27669-1-georgi.djakov@linaro.org>
 <20200428152842.GG4525@google.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <e6d9cae4-6674-9426-183d-d9d810c6335b@linaro.org>
Date:   Tue, 28 Apr 2020 18:50:00 +0300
MIME-Version: 1.0
In-Reply-To: <20200428152842.GG4525@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Matthias,

On 4/28/20 18:28, Matthias Kaehlcke wrote:
> Hi Georgi,
> 
> On Tue, Apr 28, 2020 at 12:16:50PM +0300, Georgi Djakov wrote:
>> There is a repeated pattern in multiple drivers where they want to switch
>> the bandwidth between zero and some other value. This is happening often
>> in the suspend/resume callbacks. Let's add helper functions to enable and
>> disable the path, so that callers don't have to take care of remembering
>> the bandwidth values and handle this in the framework instead.
>>
>> With this patch the users can call icc_disable() and icc_enable() to lower
>> their bandwidth request to zero and then restore it back to it's previous
>> value.
>>
>> Suggested-by: Evan Green <evgreen@chromium.org>
>> Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

[..]

>> +
>> +	return icc_set_bw(path, path->reqs[0].avg_bw,
>> +			  path->reqs[0].peak_bw);
>> +}
> 
> The two functions are identical except for the assignment of the 'enabled'
> flags. You could add a helper _icc_enable(struct icc_path *path, bool enable)
> and call it from icc_enable/disable().
> 

Yes, indeed! Will send a v2. Thank you!

BR,
Georgi
