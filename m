Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5590F1C8A22
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 14:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgEGMJ0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 08:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725879AbgEGMJZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2020 08:09:25 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFA7C05BD43
        for <linux-pm@vger.kernel.org>; Thu,  7 May 2020 05:09:25 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z8so6104743wrw.3
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2020 05:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=90vc9+gg31gTodCFfqabRhf0L1y+66v0VlxzDAW0JmM=;
        b=m/hNhWAJrEAkwRd7Asqcllvo/0WlhwBTJ4CHEKzWXXEFVMtHW74xrf6enuWiqtYDhB
         jYRDwhXlH3f0EwssjzvpjCZvnG1ennyfwYOOjWn5IrGPhsAu3lZskASycyG5HZdSZKJk
         wKc1TwtVFWMIIW+N4NLj6ZErytAfDVeMJqEg7XE2hYz5+d3CqrB03gNNAiJ6RiIoKLYj
         rfa3rnUnINwmjfd3otn/SlS4ni9HVnSUwgpioQVXmATBIgXQKEPNmynKz2bHeHXTHlQU
         cESv9D6lMawl0L52ysrXLuLzq+9Lz+ncf9AEv1OIx08VeOOnjZTRtAvjlIVHgLG3VEK/
         jeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=90vc9+gg31gTodCFfqabRhf0L1y+66v0VlxzDAW0JmM=;
        b=imwXzCs3enmtYhGtwRPV5QGqOqyunRTHzUIyF298VkHHsVyLiICPD6AYFyrpk6xJi9
         FEbJ7mOzaxlOP14V9qNd2AL8BLiZRlLBsRCvpawHSJ5qrbCpOAXEoAR303OKLv63Pw6g
         KMw0Kjh6GFU7HSdQjruEcmhC+0q1TJrxjtehny15bSqtHGh9NuGQdkt7GHBAhn9bcDtT
         MZJXK0yuj2xxgVAYu1pJDcPBqcb3fGeaxBMjV6RcxhFJEPM/nR8cfBN/qzHHkotF9Xnn
         0xFLgnGanjMv0wiW6M9hRykEWJtkPW1AzXmQXzg6tSN08ec1NOCUdYww0ozkgA5tNwhP
         QHtg==
X-Gm-Message-State: AGi0PubQ7nIOsxWjclq/W1ldIBCJZd7SJ/tT5zAb1l3X14BXwuOVO0d3
        uaSBAy5tVjPcQg9g5khlKKW4/Q==
X-Google-Smtp-Source: APiQypKMICJDzchdLEuUDWUPJvhguvBLqjAs7tSuSPnHHBlJScv2BxzUTOXhXS4x1cuRqK8Gc6cZHQ==
X-Received: by 2002:a5d:6283:: with SMTP id k3mr14550666wru.62.1588853363825;
        Thu, 07 May 2020 05:09:23 -0700 (PDT)
Received: from [192.168.0.136] ([87.120.218.65])
        by smtp.googlemail.com with ESMTPSA id a9sm7524087wmm.38.2020.05.07.05.09.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2020 05:09:22 -0700 (PDT)
Subject: Re: [PATCH] interconnect: Add helpers for enabling/disabling a path
To:     Akash Asthana <akashast@codeaurora.org>
Cc:     linux-pm@vger.kernel.org, evgreen@chromium.org,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org
References: <20200428091650.27669-1-georgi.djakov@linaro.org>
 <44cbf83d-f210-97ec-21c2-ebe65b9821c1@codeaurora.org>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <27bcb979-cf5c-4969-6c39-80061158effa@linaro.org>
Date:   Thu, 7 May 2020 15:09:22 +0300
MIME-Version: 1.0
In-Reply-To: <44cbf83d-f210-97ec-21c2-ebe65b9821c1@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 5/4/20 11:57, Akash Asthana wrote:
> Hi Georgi,
> 
> On 4/28/2020 2:46 PM, Georgi Djakov wrote:
>> There is a repeated pattern in multiple drivers where they want to switch
>> the bandwidth between zero and some other value. This is happening often
>> in the suspend/resume callbacks. Let's add helper functions to enable and
>> disable the path, so that callers don't have to take care of remembering
>> the bandwidth values and handle this in the framework instead.
>>
>> With this patch the users can call icc_disable() and icc_enable() to lower
>> their bandwidth request to zero and then restore it back to it's previous
>> value.
> 
> Thanks for this patch.
> 
> Are you planning to add bulk versions of icc_enable/disable APIs?
> 

Yes, i have already a bunch of patches that add bulk versions for most
of the API functions. Will post them on the list.

Thanks,
Georgi

