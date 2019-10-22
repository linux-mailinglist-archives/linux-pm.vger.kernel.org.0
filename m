Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1232FE0971
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2019 18:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388974AbfJVQo0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Oct 2019 12:44:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39715 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388775AbfJVQoZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Oct 2019 12:44:25 -0400
Received: by mail-wm1-f68.google.com with SMTP id r141so7244263wme.4
        for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2019 09:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b4MQR7kg4xEXyQ6ThJfWdeWd8UUKU56l+z1ZpJFgsO8=;
        b=AmtLO2NM6cTb+XZhRL3UQAsCMyNRHtLk1l4Z0EqBxd/5AabDEwo/fcSA12+e2EIiWU
         sBlusVSiymgsH1JVCazx7QK11d6YDEqDGlZecqjYwb6Yb9K+RuqZdpsQpfC2d8ZO/txM
         YWvFB97MMTx9oPQGuxG6DtmVbPx+71gBBUat35m1J1plIBida6ULSTtQKJ2yMvNCC56v
         d8fZt7h88kRUzbJJOXvGOcLZSixxSI41g0OOfAWWTlHY8E5v/WJMRQ/NhfJZODRWnzEe
         OZvrwRzl3wpKn1WrlTZY0MPnu914725aQVBIwaLN2dkKcVWOcOnzo6GqcGwflZsimJ9/
         R6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b4MQR7kg4xEXyQ6ThJfWdeWd8UUKU56l+z1ZpJFgsO8=;
        b=c2KXPuu6SM1EnPgUPNASa3NPvDKEXwsIo/EddODu0Z2Y2d/72kT0CPmZnaJk8sCeXw
         R70iimFFNYxxEbDbdnWVI6+vHb0mCWe9fMymytRuIgsWPAhJUOcwE3nz1hB1NjsPfPyq
         7dRt7qhzXrpGj3I22JmdcJghhoM1Z6ayLB55CdkyBL9OxHiKBxe6lcuVoj5qhub47Xlu
         Sec0aHpUN20PADIGDbp7mJe/mMYDQiV2bztMg2vS42utODsFnv1vz/usDfGMui/KeUSl
         F6lJFqGgRgwI0yB/aJ1DZevgcPx+5KmzHwLZcon2vGbEHR2JP7GChSI3YWnErdgnnWUl
         4h9w==
X-Gm-Message-State: APjAAAU7q4AqiKbKbP6jt005/Gpdy0IcLHyI8GLiByWnfSB1fy1u425a
        rCAiOFRAKzeQBkxISj+1W2JMHg==
X-Google-Smtp-Source: APXvYqzqgvYygL3lYW4mVTiQoAHOovtsSB0sTUf1v0UIK2XibBtbCwzcJj6Ac5YsDNIHnqimRSq5zA==
X-Received: by 2002:a1c:cc18:: with SMTP id h24mr4064979wmb.40.1571762663499;
        Tue, 22 Oct 2019 09:44:23 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id l8sm1298514wru.22.2019.10.22.09.44.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 09:44:22 -0700 (PDT)
Subject: Re: [PATCH][next] thermal: qcom: tsens-v1: fix kfree of a non-pointer
 value
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Colin King <colin.king@canonical.com>
Cc:     Andy Gross <agross@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20191022111806.23143-1-colin.king@canonical.com>
 <CAP245DXjVDJ68kmWONmWh4YB=dcVrQ4q1y3bPncDc5=FohY2Vw@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <10cbe6fb-05b8-3219-cef5-05980559f053@linaro.org>
Date:   Tue, 22 Oct 2019 17:44:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAP245DXjVDJ68kmWONmWh4YB=dcVrQ4q1y3bPncDc5=FohY2Vw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 22/10/2019 14:06, Amit Kucheria wrote:
> On Tue, Oct 22, 2019 at 4:48 PM Colin King <colin.king@canonical.com> wrote:
>>
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> Currently the kfree of pointer qfprom_cdata is kfreeing an
>> error value that has been cast to a pointer rather than a
>> valid address.  Fix this by removing the kfree.
> 
> Hmm, we just added this to other places[1] as a fix for mem leaks
> using the nvmem api. >
This patch has nothing to do with the memleak fix.
> I think we need to fix up the qfprom_read wrapper. Srini?

not sure how we can fix that, as the pointer returned from read is needs 
to be freed by the caller after its done with it!

--srini


> 
> [1] https://lore.kernel.org/stable/20191010083616.685532154@linuxfoundation.org/

> 
>> Fixes: 95ededc17e4e ("thermal: qcom: tsens-v1: Add support for MSM8956 and MSM8976")
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>   drivers/thermal/qcom/tsens-v1.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
>> index 2d1077b64887..bd2ddb684a45 100644
>> --- a/drivers/thermal/qcom/tsens-v1.c
>> +++ b/drivers/thermal/qcom/tsens-v1.c
>> @@ -240,10 +240,8 @@ static int calibrate_8976(struct tsens_priv *priv)
>>          u32 *qfprom_cdata;
>>
>>          qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
>> -       if (IS_ERR(qfprom_cdata)) {
>> -               kfree(qfprom_cdata);
>> +       if (IS_ERR(qfprom_cdata))
>>                  return PTR_ERR(qfprom_cdata);
>> -       }
>>
>>          mode = (qfprom_cdata[4] & MSM8976_CAL_SEL_MASK);
>>          dev_dbg(priv->dev, "calibration mode is %d\n", mode);
>> --
>> 2.20.1
>>
