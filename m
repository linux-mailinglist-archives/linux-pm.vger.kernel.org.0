Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B934A10C9DF
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 14:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfK1NwJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 08:52:09 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41803 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfK1NwG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Nov 2019 08:52:06 -0500
Received: by mail-ed1-f68.google.com with SMTP id n24so1460669edo.8
        for <linux-pm@vger.kernel.org>; Thu, 28 Nov 2019 05:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=OXomE3LhGTg9naIJXoKzldNxQQhZc2QZdqofXcgRGAw=;
        b=X2bSOyqIdi8cnv05tOfNI+Mur1hm3UDPtX+7e7QriBG09PhJCRKlOlHpC2sJ4/eC27
         AnUh4aIFMUnD8KV/32jsLizlgv17g3OiG3v1U+KoIp+xSuYvuTjvyZaKqUeJfLUw9OX6
         5WXX0qzjfk0RqQC/cvZ4MhDdji1hktXsdNFQmDJmSCJx+wcmVgZkNn9TVn8mgMtXI9P7
         r3iZOgXfCICax/BAAbUTucJPt8Fm54+2gdyjvQ8nkg5JbqfqAvrx/EKs+xc7SqSFlWkZ
         AJFWRltnWa4zzIX0P71c6MFOFAo9Kp2+gDwRnk4pxzazBwPGVJfShsKVcot6KacPUYv4
         EUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OXomE3LhGTg9naIJXoKzldNxQQhZc2QZdqofXcgRGAw=;
        b=CDtQPSbO4soU3s4owaaRMQw5YFAlr8xR/4/unFYXMbu7sUjbP9nqH6SK+Wtva0HSEj
         s+o9RjgHdmfDOUfywHd6CW/0ufs0Ehm6CO3c9GgntWdVEmGP4zV8dRC8Nv8TgDZYulC5
         OU0KrAHp4TEurHj2q4VqXc0K9d6MX6d6QDhGSbZXOK54KKEJGmGr7tB1lxw/PXISQX3Q
         qb+ilv4I8MZfhUvzq6+FWZA4ZOHWO8VZ2uZUQmlnytM7W+Hi3qSeIceETzlfBrDUC13+
         ry9pSWUvyZ114BOe1KftcymvwBsNKoiuBgmoB3LbbrjlTUF0EAglN25e8Pay3Fw/EtIw
         iJOw==
X-Gm-Message-State: APjAAAVyCnMo79QXrs1RXGjTTCUGMasIUTYSMC9galZ8ssRnoXepkapO
        w3mriDwyqeAdW2uV5kjrHAlR8A==
X-Google-Smtp-Source: APXvYqze3moY1+8pWkzpxVwArM0DcJsWSudhDMAXq4Iy7IMU1isjW8C8xkNEfHZ7nMxTtW6CUd5m7g==
X-Received: by 2002:aa7:cf83:: with SMTP id z3mr13233275edx.166.1574949123947;
        Thu, 28 Nov 2019 05:52:03 -0800 (PST)
Received: from [192.168.27.135] ([37.157.136.193])
        by smtp.googlemail.com with ESMTPSA id f18sm500625ejr.80.2019.11.28.05.52.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2019 05:52:03 -0800 (PST)
Subject: Re: [PATCH 5/5] interconnect: qcom: Use the new common helper for
 node removal
To:     Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        evgreen@chromium.org, daidavid1@codeaurora.org,
        masneyb@onstation.org, sibis@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20191128133435.25667-1-georgi.djakov@linaro.org>
 <20191128133435.25667-5-georgi.djakov@linaro.org>
 <5686a003-d72f-7a20-4851-9ebb3d2e9b20@gmail.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Message-ID: <3286eb91-f5b8-a4b4-2031-5be50cbb9206@linaro.org>
Date:   Thu, 28 Nov 2019 15:52:02 +0200
MIME-Version: 1.0
In-Reply-To: <5686a003-d72f-7a20-4851-9ebb3d2e9b20@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28.11.19 г. 15:43 ч., Dmitry Osipenko wrote:
> 28.11.2019 16:34, Georgi Djakov пишет:
>> There is a new helper function for removing all nodes. Let's use it instead
>> of duplicating the code.
>>
>> In addition to the above, instead of duplicating the code, simplify the
>> probe function error path by calling driver removal function directly.
>>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>   drivers/interconnect/qcom/msm8974.c | 40 ++++++++++-------------------
>>   drivers/interconnect/qcom/qcs404.c  | 31 ++++++++--------------
>>   drivers/interconnect/qcom/sdm845.c  | 29 +++++++--------------
>>   3 files changed, 33 insertions(+), 67 deletions(-)
>>
[..]>> +static int qnoc_remove(struct platform_device *pdev)
>> +{
>> +	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
>> +
>> +	icc_nodes_remove(&qp->provider);
>> +	return icc_provider_del(&qp->provider);
>> +}
>> +
>>   static int qnoc_probe(struct platform_device *pdev)
>>   {
>>   	const struct qcom_icc_desc *desc;
>> @@ -855,29 +863,10 @@ static int qnoc_probe(struct platform_device *pdev)
>>   
>>   	return ret;
>>   err:
>> -	list_for_each_entry(node, &provider->nodes, node_list) {
>> -		icc_node_del(node);
>> -		icc_node_destroy(node->id);
>> -	}
>> -
>> -	icc_provider_del(provider);
>> +	qnoc_remove(pdev);
> 
> This is wrong because platform_set_drvdata() is invoked at the end of
> qnoc_probe(), thus platform_get_drvdata() of qnoc_remove() returns NULL
> here.

True! Will fix it! Thank you!

BR,
Georgi
