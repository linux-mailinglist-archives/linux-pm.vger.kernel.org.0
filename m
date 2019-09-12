Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9627BB11DB
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2019 17:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732934AbfILPMC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Sep 2019 11:12:02 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41422 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732819AbfILPMC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Sep 2019 11:12:02 -0400
Received: by mail-lf1-f66.google.com with SMTP id r2so1637216lfn.8
        for <linux-pm@vger.kernel.org>; Thu, 12 Sep 2019 08:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BQvYwrynlYgeY28xmsYzLa0ffbneFj8mnp+haD7bRLA=;
        b=ENsfZJkMjORBKTzN9InS4Qq1+hPIy+FobNBG+Ena5keYaBEmvUrWZLfaRNYw8xkoen
         vVD+WOL0YCJIHyOZ+HpaVkoH/yqZnpTyzqEc7sbx8cmySujTVU5Qz+pv0EOQfGMMBoJb
         rHY6Mrg4y8J3vt5SQ+dK7ypPBH357L0u9516DNKc9sRbrg7WrDms1KpXOBIBg7dztdcj
         /37jjIEvvmMFYdPmhu7pCzs8FHazLx0byDnvY+tvxnflZntSlCKhTzm1HX2EvTx1986u
         Y6FdFxq0W5PgYn84RwCDNJrNdX2YftrIMngO4VVCh93UgMLzrdv9m36RF3XmLVupwjCz
         RXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BQvYwrynlYgeY28xmsYzLa0ffbneFj8mnp+haD7bRLA=;
        b=CI+zVYqcnBQw5XQJVn5biBDw9rryn3Tju0ymBGTzvIa3Yhn4IvbcpI3YLRjD8/QLW6
         m+adKq6MpmP+keNvTHRxQqDyc4H8KAXvm970k4yJXu8hmYP1t6fHcm/tAzdhwl0/tyRO
         k+CehVCAwKL7cMVQj6kwh6e08Q0iH6yg2+q2OLZAOjWyvyaIWNSQ+1Knr/tsJfD8bsBU
         lUjn9QEcIOSjOP0DjytsreLa1555YCNCegQfp0T/AQijZeXz2ggbVQlwi5PkDupUlI74
         toyEQK8nqJzMdS8lHOGxy+qlFSmeYjzolRelKVDwqP2eOwE2sRY/geZxQvmpY8LctW1J
         TmGw==
X-Gm-Message-State: APjAAAUxXJzwAfaEQNqKE/jJ0YodV2g+kUydlIQEgCGjEAyA7T4r65O7
        aP05qWoksg7Ohzy3Af+UPNGcK1yBCE2nZg==
X-Google-Smtp-Source: APXvYqwWSdyMu492oXhyvP8A2cmtRd5oVCP054vpKaFphiupoFECabgdvNUNKEscV0ryJoBjzBFGHA==
X-Received: by 2002:a19:428f:: with SMTP id p137mr28616130lfa.149.1568301119743;
        Thu, 12 Sep 2019 08:11:59 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id k13sm5764857ljc.96.2019.09.12.08.11.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2019 08:11:58 -0700 (PDT)
Subject: Re: [PATCH 1/2] venus: use on-chip interconnect API
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Aniket Masule <amasule@codeaurora.org>,
        Linux PM list <linux-pm@vger.kernel.org>
References: <20190814084701.25455-1-stanimir.varbanov@linaro.org>
 <20190814084701.25455-2-stanimir.varbanov@linaro.org>
 <cc85f55c-3d21-c3b2-6848-e48513263e39@linaro.org>
 <20190904042203.GC3081@tuxbook-pro>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <345e7450-b3af-92c5-4e83-bccaf0a98a0b@linaro.org>
Date:   Thu, 12 Sep 2019 18:11:55 +0300
MIME-Version: 1.0
In-Reply-To: <20190904042203.GC3081@tuxbook-pro>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Bjorn,

On 9/4/19 07:22, Bjorn Andersson wrote:
> On Tue 20 Aug 02:34 PDT 2019, Georgi Djakov wrote:
> 
>> Hi Stan,
>>
>> On 8/14/19 11:47, Stanimir Varbanov wrote:
>>> This aims to add a requests for bandwidth scaling depending
>>> on the resolution and framerate (macroblocks per second). The
>>> exact value ff the requested bandwidth is get from a
>>
>> s/ff/of/
>>
>>> pre-calculated tables for encoder and decoder.
>>>
>>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>>> ---
>>>  drivers/media/platform/qcom/venus/core.c    | 34 +++++++++++
>>>  drivers/media/platform/qcom/venus/core.h    | 14 +++++
>>>  drivers/media/platform/qcom/venus/helpers.c | 67 ++++++++++++++++++++-
>>>  3 files changed, 114 insertions(+), 1 deletion(-)
>>
>> It looks like venus can be built-in, so how about the case when venus is
>> built-in and the interconnect provider is a module? Maybe add a dependency in
>> Kconfig to depend on INTERCONNECT || !INTERCONNECT?
>>
> 
> I've been struggling down this road for remoteproc et al for a long
> time, I strongly suggest that you make the INTERCONNECT config bool, to
> ensure that we don't see this problem for every client.

Thanks for the comment. Well, i was expecting that we will have to make it bool
one day. Viresh actually already sent a patch [1]. Maybe you can add an Ack?

> 
> The interconnect framework should hide the fact that the provider is
> module.
> 

Correct.

> 
> But with this in place is there actually a dependency? Won't the include
> file provide stubs in the case of !INTERCONNECT?

There are stubs, so we are fine.

Thanks,
Georgi

[1]
https://lore.kernel.org/linux-pm/b789cce388dd1f2906492f307dea6780c398bc6a.1567065991.git.viresh.kumar@linaro.org/
