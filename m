Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C573FFDAC
	for <lists+linux-pm@lfdr.de>; Fri,  3 Sep 2021 11:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348822AbhICJ7t (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Sep 2021 05:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbhICJ7s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Sep 2021 05:59:48 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70E7C061575;
        Fri,  3 Sep 2021 02:58:48 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id c8so10725866lfi.3;
        Fri, 03 Sep 2021 02:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LXMRkrOMa9GLKEtXyrT+pUgSmaeIa+E2ZbXgDwz3plo=;
        b=SqmHYtqhoYZZWA59PcoU/x1rQ1id2pS9Sb3t5KzQX+qVfm/0/Qjh00fWYaMa2zyeqx
         FJ+bH+Cd2HEfF6U/LwxDWxH/F451WfeiaAg/2VIma2Nz6ZTKjZN/6JjQwvTfUgeJwMTr
         a9NEz3RtNEUKd8hRMksKYjKXdl931mzjg4ZT1Q8bUfwD5npZCazTsyHwLRszfQh6UAOC
         insRnEGfwv983yBY2xiRx+23mTaZf4pnJSbJerx4uIdz/TACA9ZfTCJPjvPZeg7QvjVb
         2rq37l+eH7tOKDwTVJTm33nBlpitgrfcFVs52WmIZyA+3bOFFIirzv8+7EAzTBF671+u
         h7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LXMRkrOMa9GLKEtXyrT+pUgSmaeIa+E2ZbXgDwz3plo=;
        b=l60z58uwizc3l0pEs5/IAbwzqL0LlpSKhUX7F9bE4UovMDZYgLkiO8lAADJ1Z09+MO
         ulhRpsz/1dYIYkhcccPD9QT9wyf+gMwSIPFtss4hgkTIa2Q+MY7DXUHg2SslyfDMTMLe
         sTWyB5v/dtI39+Mr23ZF4UXzL+T5K0v7DoPmdVDK2gBQpWHrfv9vXgEaVxqA6/XnNXs+
         USlA7hmjaOOGPm203qS8ZUhSMhXIBTS0VW1DJuBEN7z1XUNO+91dPbYTn1ZjD99XNZ7I
         8dzt5A7uD3FYUaiJf5hWE3Q9lxlmrbbvTqifgLeGFJlo0aZESRYjJThPTyb3aAD8E4gq
         8HfA==
X-Gm-Message-State: AOAM530+9SQCFp6BKC73HgN2Hxn2S6mrylHhgOTdWKDGl93B1TlvxbGG
        yMXMrJTkWm0e/jU6TBfBofU+YM9otrM=
X-Google-Smtp-Source: ABdhPJwhz2eqWOtTgUewpywmxdYJ+44NiMVxCU/u1N50Q6hW0PG8LmncY1jl55ZNZBVa5edjaVtTMw==
X-Received: by 2002:a19:4817:: with SMTP id v23mr2247232lfa.154.1630663127152;
        Fri, 03 Sep 2021 02:58:47 -0700 (PDT)
Received: from [192.168.2.145] (46-138-26-37.dynamic.spd-mgts.ru. [46.138.26.37])
        by smtp.googlemail.com with ESMTPSA id k8sm530520lja.57.2021.09.03.02.58.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 02:58:46 -0700 (PDT)
Subject: Re: [PATCH 1/3] PM: domains: Drop the performance state vote for a
 device at detach
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210902101634.827187-1-ulf.hansson@linaro.org>
 <20210902101634.827187-2-ulf.hansson@linaro.org>
 <08335cd4-7dc8-3b8b-d63f-374585ffa373@gmail.com>
 <CAPDyKFofrEj2LdqXh-L256b2Tcz=qYQgzTUBVuvx0rOR58SrVg@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b597c805-e346-8c23-5014-cbb116e88075@gmail.com>
Date:   Fri, 3 Sep 2021 12:58:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFofrEj2LdqXh-L256b2Tcz=qYQgzTUBVuvx0rOR58SrVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

03.09.2021 11:22, Ulf Hansson пишет:
> On Fri, 3 Sept 2021 at 08:01, Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> 02.09.2021 13:16, Ulf Hansson пишет:
>>> When a device is detached from its genpd, genpd loses track of the device,
>>> including its performance state vote that may have been requested for it.
>>>
>>> Rather than relying on the consumer driver to drop the performance state
>>> vote for its device, let's do it internally in genpd when the device is
>>> getting detached. In this way, we makes sure that the aggregation of the
>>> votes in genpd becomes correct.
>>
>> This is a dangerous behaviour in a case where performance state
>> represents voltage. If hardware is kept active on detachment, say it's
>> always-on, then it may be a disaster to drop the voltage for the active
>> hardware.
>>
>> It's safe to drop performance state only if you assume that there is a
>> firmware behind kernel which has its own layer of performance management
>> and it will prevent the disaster by saying 'nope, I'm not doing this'.
>>
>> The performance state should be persistent for a device and it should be
>> controlled in a conjunction with runtime PM. If platform wants to drop
>> performance state to zero on detachment, then this behaviour should be
>> specific to that platform.
> 
> I understand your concern, but at this point, genpd can't help to fix this.
> 
> Genpd has no information about the device, unless it's attached to it.
> For now and for these always on HWs, we simply need to make sure the
> device stays attached, in one way or the other.

This indeed requires to redesign GENPD to make it more coupled with a
device, but this is not a real problem for any of the current API users
AFAIK. Ideally the state should be persistent to make API more universal.

Since for today we assume that device should be suspended at the time of
the detachment (if the default OPP state isn't used), it may be better
to add a noisy warning message if pstate!=0, keeping the state untouched
if it's not zero.
