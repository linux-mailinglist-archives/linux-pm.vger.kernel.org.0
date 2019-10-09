Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0C7D0F37
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2019 14:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731216AbfJIMyj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Oct 2019 08:54:39 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36872 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731214AbfJIMyj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Oct 2019 08:54:39 -0400
Received: by mail-qt1-f195.google.com with SMTP id l51so2956127qtc.4
        for <linux-pm@vger.kernel.org>; Wed, 09 Oct 2019 05:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=TgY7kPmBZqnecD8fmdALLpGAi+Y1sBS44TN0W3OZTbI=;
        b=Ieth1LzWB3tqDdxRYS6TrTDImdY44X93i3yUuyswKh9NjwTJ9MG4I2p3ASCGRBbhIi
         EN685xkM080/OSbNL3HVipQhMTiUC3wCskwGs71Fi0G583KGpAhgDjb9VZTSwNOizajq
         KjMDn74QgrW5rjxwCxpxgHrztK5XKLYGw7Ptb6Dzw2Um68uQEEtb9QD58DgmCL+djw5x
         hvj6SPb+jQ8H91BafRWYx9bXKeCGoUZ3pYmo9zaWEqj9Hbxyx5PkknrLQpIrt+b6pPv2
         UWqyEnjMQk6gtxIgsg+zv6Xm7CfObViLTHWCh+F8QEAs8uzXv+iWzUnHp4NYkK8A+eno
         2GbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=TgY7kPmBZqnecD8fmdALLpGAi+Y1sBS44TN0W3OZTbI=;
        b=BuzsJW207BFIV7IVxWJMLwZ//nCD5W+QVH8lmL2s8gsErHIsK4fpP37H2z14F5s88b
         Ru3IHizUztwLAV1swYLJ3PHQ8CHeV9oXmb0MrWSzV9/3R8BZULFgPjZpB7LZObSdlyLb
         mQzj1LeUml/v93CmwgLWUs7OoR1a5CZFHNtsuD3NLxiLqf7vsIaAKUm7UVmhiGw4tHFx
         HYvteLwdAEi5Sakm15aK9Aq6Y25n3NTQYIxgZq3at9BTifMIY1G5gi5NXf8UZb44Ck6+
         ulWYb5Wt6HNIO31omV185gBYq/gNzEKH9hRhnqWVYw7wqGx71PMNQQAJqplCq04gKGIZ
         Wr2A==
X-Gm-Message-State: APjAAAWVuxiUlkUiWlZH0rXumkQTHE6DIsH+dgWmLM/VfcATe1KWmy90
        47qH1iuyixmgzEE+/xqjf9gJHg==
X-Google-Smtp-Source: APXvYqxDRTRnNCFB3xzy90ZREa6zqiTGq9G4A+t6sp3p4WDaJF1dHGjJKNb5yoJjpKhBQP6sEqhRHA==
X-Received: by 2002:a0c:ef85:: with SMTP id w5mr3460733qvr.159.1570625678531;
        Wed, 09 Oct 2019 05:54:38 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id c201sm890854qke.128.2019.10.09.05.54.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 05:54:37 -0700 (PDT)
Subject: Re: [PATCH 1/4] dt-bindings: thermal: Introduce monitor-falling
 parameter to thermal trip point binding
To:     Rob Herring <robh@kernel.org>
References: <1568859503-19725-1-git-send-email-thara.gopinath@linaro.org>
 <1568859503-19725-2-git-send-email-thara.gopinath@linaro.org>
 <5d93ce86.1c69fb81.70b0d.ba56@mx.google.com>
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, amit.kucheria@verdurent.com,
        mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5D9DD88C.7090804@linaro.org>
Date:   Wed, 9 Oct 2019 08:54:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <5d93ce86.1c69fb81.70b0d.ba56@mx.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rob,
Thanks for the review.

On 10/01/2019 06:09 PM, Rob Herring wrote:
> On Wed, Sep 18, 2019 at 10:18:20PM -0400, Thara Gopinath wrote:
>> Introduce a new binding parameter to thermal trip point description
>> to indicate whether the temperature level specified by the trip point
>> is monitored for a rise or fall in temperature.
> 
> What if it is both?
> 
> When do you need this? Seems like you'd always want to monitor both 
> directions to undo any action done on rising temp. Unless you want a 
> hysteresis, but this doesn't seem like the best way to implement that.
> 

The thermal framework is designed in such a manner that I cannot think
of a use case for both.
The framework takes care of removing the warming/cooling action when the
trip point is crossed in the opposite direction. It only needs an
indication on when to start implementing the
action.
For eg. When the temperature crosses/increases above 90 degree, the
framework will start the cooling action and will continue monitoring
till the temperature falls below 90 and the cooling action is removed.
Vice versa when the temperature decreases below say 5 degree, the
framework should  initiate the warming action and monitor till the
temperature rises above and remove the warming action.

So the trip point is really an indication of the temperature crossing a
threshold in the specified direction.

Now this parameter is needed to indicate whether the thermal framework
has to start implementing the warming/cooling action when the
temperature  rises above the trip point or falls below the trip point.

Till now the framework was always assuming that the cooling action had
to be implemented when temperature rises above the trip point.

-- 
Warm Regards
Thara
