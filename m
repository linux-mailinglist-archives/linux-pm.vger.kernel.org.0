Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C085D27183B
	for <lists+linux-pm@lfdr.de>; Sun, 20 Sep 2020 23:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgITVhq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 20 Sep 2020 17:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgITVhp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 20 Sep 2020 17:37:45 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228B9C061755;
        Sun, 20 Sep 2020 14:37:45 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id c2so9444695ljj.12;
        Sun, 20 Sep 2020 14:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uUHnkFzVd/NEKgu8zQqIER3cRG3IZwAsoXwHaK0rQ0Y=;
        b=B2ySQtn7QA6RNzAGSr45L8cA6W7UpfdWFhxBXFkjIl9Tg+UWUrBdnhY3ETzPYBTrUO
         aXCdDQMrOwJ3ABvhdmti3LdflLW7dL7Iy0R2Ydy0ipMeNAmU005aDbLrp/OuCs2otozz
         Mr9+a2iC3D8FAs3goeXEk9+ZsjvvW72UKYIUEKZ2GvifAePgW4k+WqCT1eP2eSEKYjEC
         xoUCv9gc49IIwsC4Y6XTxgp3A01zWB4ce5X/pkJgOzXFs2i4hkFQ1JMKTJeWVr+4AgYl
         7efBzevXIzbWWdhZvKzg/aFdpbdlg2SKGtFi30mLnWW9J8/rrTR/Spiu/YKTN7YkeVEc
         1wbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uUHnkFzVd/NEKgu8zQqIER3cRG3IZwAsoXwHaK0rQ0Y=;
        b=likSctkTsUYHBDxMRZN5G96RmBP/s++lOXevWqWSFBT5dT3scq5uR3RRZXM5qL3dnj
         EyX09cFp8tGa6N85JLOa4UMtrtGolOujnkrlKk6/FKxrbUjKNGpBxRHDkxJr81biv9SV
         3enJJfrkJXcrAbfCPoy/xo0xTdDuxkOYQLS90l4UYmNTZKdeyzPLa7/R0g+k+1UaXOFj
         58V1MBHnKr1dfOTZoWjkN1MsWnQL+9rYdo7iLg79u+GSJ42KGAVfXIMtOZaBdekWT7Ze
         HciFf8tHmglU9SBDe2nn3+Tx95zLvstExwGWYIyahsnbzFyDpCWbpxpMmlnhe8KBknRW
         G2fw==
X-Gm-Message-State: AOAM533TSgPrHuCSlz9K3V/vf1QWAuaGV8IhxFtJgGkSI7SmF/Ko2P9q
        IR9ag+EZ6pg9i37Rhof8VPuvZxjxCYg=
X-Google-Smtp-Source: ABdhPJzY3c1BSGgoLUS+Qku420dV/Lo6lL4tufDPffWltCXV4MYZf3R+2C9Qe0CyMYjXNeMiB6mASQ==
X-Received: by 2002:a2e:8153:: with SMTP id t19mr15777844ljg.334.1600637862040;
        Sun, 20 Sep 2020 14:37:42 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id g74sm2047040lfd.152.2020.09.20.14.37.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2020 14:37:41 -0700 (PDT)
Subject: Re: [PATCH] PM / devfreq: tegra30: disable clock on error in probe
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <CGME20200908072627epcas1p41f2c8c2730d42bd8935a40b0ab8122f7@epcas1p4.samsung.com>
 <20200908072557.GC294938@mwanda>
 <2ceb045a-ebac-58d7-0250-4ea39d711ce8@samsung.com>
 <44560522-f04e-ade5-2e02-9df56a6f79ba@gmail.com>
 <e45c8ffc-ea24-1178-7bfa-62ca6bedbb3b@samsung.com>
 <2573cd77-1175-d194-7bfc-24d28b276846@samsung.com>
 <5aac4d59-5e06-25a6-3de1-6a5a586b9e34@gmail.com>
 <bccb08ef-7e48-0cc7-08b5-7177b84a5763@samsung.com>
 <887f4b2d-9181-356c-5f09-23be30d2480c@gmail.com>
 <8edcfd7b-110b-3886-64ee-3ec02cc6bd19@samsung.com>
 <57e8ccad-f0d5-febb-7a31-8d34430a5cb8@gmail.com>
 <64f4b682-00b7-60f2-902f-e50a40a04a55@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c80c6f3a-bbbf-f18b-33c8-62e63397df9c@gmail.com>
Date:   Mon, 21 Sep 2020 00:37:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <64f4b682-00b7-60f2-902f-e50a40a04a55@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

18.09.2020 12:23, Chanwoo Choi пишет:
...
>> Hence if we want to improve the code, I think we can make this change:
>>
>> diff --git a/drivers/devfreq/tegra30-devfreq.c
>> b/drivers/devfreq/tegra30-devfreq.c
>> index ee274daa57ac..4e3ac23e6850 100644
>> --- a/drivers/devfreq/tegra30-devfreq.c
>> +++ b/drivers/devfreq/tegra30-devfreq.c
>> @@ -891,8 +891,6 @@ static int tegra_devfreq_probe(struct
>> platform_device *pdev)
>>  		return err;
>>  	}
>>
>> -	reset_control_assert(tegra->reset);
>> -
>>  	err = clk_prepare_enable(tegra->clock);
>>  	if (err) {
>>  		dev_err(&pdev->dev,
>> @@ -900,7 +898,7 @@ static int tegra_devfreq_probe(struct
>> platform_device *pdev)
>>  		return err;
>>  	}
>>
>> -	reset_control_deassert(tegra->reset);
>> +	reset_control_reset(tegra->reset);
>>
>>  	for (i = 0; i < mc->num_timings; i++) {
>>  		/*
> 
> It looks good to me for improving the readability
> for everyone who don't know the detailed h/w information.

Okay, I'll make a patch sometime soon.
