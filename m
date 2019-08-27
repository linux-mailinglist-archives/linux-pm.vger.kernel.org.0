Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFDE9E5F1
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2019 12:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbfH0KmP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Aug 2019 06:42:15 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42059 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfH0KmP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Aug 2019 06:42:15 -0400
Received: by mail-qt1-f196.google.com with SMTP id t12so20773567qtp.9
        for <linux-pm@vger.kernel.org>; Tue, 27 Aug 2019 03:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=HW0Up87SScdHrFzZ0SShtUIE9RDf120BeZe+stnrKi8=;
        b=QDPc4MDrwprvwckvgYJdaGq0badzodt2SdzcCYeT7XN0yzq9QGEEplFzFoHXmSQzlB
         Tpvx0L8dFEBf0UkrvmDWQKN85zeNlGVHoCHgQgipu9gqgrORy/mr18qf5shx/ScTkY/Y
         WEHVB/XuFsocfpiqCgQI8wNUVKTf4kYHINKYBvbFcQW5tcSPWMi/fDoaaZ+VC/IGwDaV
         6IMQHs8oWwb002sUU3cUd9eADMrP0stA/sOhL9oA+pXX3kLgwfQQ7Fe1GjvArdirCFNO
         crzfzHnzoDzRyu9M2KZmxYg4yin8YAHyBq7hCm18J3OCUmNfnWxYkSzL28X+dNWXQu0o
         creg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=HW0Up87SScdHrFzZ0SShtUIE9RDf120BeZe+stnrKi8=;
        b=i9aboQIAMarH9YdK5SBVxtXhYvd1QQUkM1BQsi+/oaGkOnEktmvjUCiPOn6Sy32x9k
         6xE7l227v6BB5LmRbKFHS61GFHoj9wfikjM40oCaTbH6wFz5zCX/5FipqVH6x/MKYYd1
         nvMH9hzseS04e2VM+8wbB0fY+2hxAiUFGD+fB/iIiLC00dgkYR04pueDvHslWcw1wy1H
         0yrSZoEBMqDkgVhxtWD1iXvuTX147gyrebyJO0FRbCOT6/iUl/2TW0DXyOGPXQ1mDx+y
         613fX+5kChE41QtmNM8xbTo2qoBz28iMTKzFl+f4+zKXCT2Qqu9VicDnD5TereaXZW86
         rDxw==
X-Gm-Message-State: APjAAAV8AI6heahf6MvS934gwxSzHu5z8smcfeezMUbyS6JkhMzFEFWw
        3x/GkHmzese/M47GbcX14ZmxUA==
X-Google-Smtp-Source: APXvYqxgGIYJa3ZsiHyOHwIsPZ5rZmSnZHUpM/421cYamaePu4Yy8A/pP6okpZW8QzANxkbuzUBUuw==
X-Received: by 2002:ac8:3364:: with SMTP id u33mr22487663qta.115.1566902534214;
        Tue, 27 Aug 2019 03:42:14 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id z7sm8271409qki.88.2019.08.27.03.42.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 03:42:13 -0700 (PDT)
Subject: Re: [PATCH 3/4] thermal: qcom: Add RPMHPD cooling device driver.
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
References: <1565398727-23090-1-git-send-email-thara.gopinath@linaro.org>
 <1565398727-23090-4-git-send-email-thara.gopinath@linaro.org>
 <20190824061029.GT26807@tuxbook-pro>
Cc:     qualcomm-lt@lists.linaro.org, linux-pm@vger.kernel.org,
        ulf.hansson@linaro.org, rnayak@codeaurora.org
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5D650904.1010402@linaro.org>
Date:   Tue, 27 Aug 2019 06:42:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20190824061029.GT26807@tuxbook-pro>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08/24/2019 02:10 AM, Bjorn Andersson wrote:
> On Fri 09 Aug 17:58 PDT 2019, Thara Gopinath wrote:
> 
>> The MX power domain in RPMH can be used to warm the
>> the SoC in SDM845. To support this feature, introduce
>> a RPMH power domain cooling device driver that can be
>> plugged into the thermal framework.(The thermal framework
>> itself requires further modifiction to support a warming
>> device in place of a cooling device. Those extensions are
>> not introduced in this patch series).
>>
> 
> This cooling device provides an interface to set a minimum state for a
> power domain.  So while it's used for controlling the MX rail exposed by
> the RPMh on some Qualcomm SoCs there's nothing Qualcomm/RPMh specific
> with it.
Hi Bjorn,

I agree that there is nothing Qualcomm specific. Are you suggesting a
more generic driver here ?

Regards
Thara

> 
> Regards,
> Bjorn
> 


-- 
Regards
Thara
