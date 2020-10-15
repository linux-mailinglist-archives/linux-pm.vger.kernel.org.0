Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924E828F371
	for <lists+linux-pm@lfdr.de>; Thu, 15 Oct 2020 15:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387853AbgJONjZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Oct 2020 09:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729892AbgJONjZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Oct 2020 09:39:25 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F393FC0613D4
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2020 06:39:24 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id e23so3228020wme.2
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2020 06:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o2Nh6KJm4jPGdm8+1OLljLZrSt0m6NW06Aa+KD07b00=;
        b=hv2CDDRO2tkNNRofdtyGczxALxVwH4U+r/AF4hjKShlob9En1V/hZpPy+qjwW/Ps4V
         NQyU3olnRIylVF+P8VLYAFzHZVRHYeTMl484i3qS7sVykQvixx9xvfXS84cTe1VonRMa
         bQ5samKS9ScnJ9ibQ12oJlA/Ie2dg6pWHF2CK/WrkhBRSVGmjpOjZRdr7Pzwnk1ytNs/
         67q68LN8YA8frqWhvf72+lpFBu0wmSnnubuZWrTDSQit1l2UIThXrNl4n77Muz7iAyWM
         x9FE/QxkWrueH12IiZx1nyuO9Tjaiz9WZdZ86Bxqc50Bj3vQY2yBk07lUxwhlNZiS0NB
         GyMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o2Nh6KJm4jPGdm8+1OLljLZrSt0m6NW06Aa+KD07b00=;
        b=psqpxLZoxXj6okK8dbmC/9aZ3OVtTdyiv3/9ivvZEXW/yeqCaIKfD4nCAKFs/CpSQG
         TKWyJbIjsxUL3NZyjXG98TPl6IuF/He2Hjt8VpXxu1kZkVLjZvyn10irur+QHSCvuzaT
         OHK5dKc57O5bgV+3kDjc0ln79PP9rRAxPIwWGQeTheDVqBSs8/S58LHttNUBN7JarlIP
         OhvX34C9UgBleD12Xr0BT/w0tbJ7lnO5oxL0ftHYTNbYfizUu5MazYpKdRVwb9/qC0QJ
         AY6io+Vp9nY8IQO1mfqcT7l7JdMkMQfeHAX8EqP80zmL6L7an+eF2n1H/qq/UOJ++pWk
         1Yzw==
X-Gm-Message-State: AOAM533D7iijSnRL/DrqjVRvevkz+uqT66FdHC5rMI6aDWcsQGNnh0EZ
        nMTHzqjWByyQwjwBvReXhmCbZA==
X-Google-Smtp-Source: ABdhPJx2lu3FnUf0sJpN8vCYCdGRv5t8JUlS/lE5EZosWOJK9Taj+BresQtefuQQdeBIDXMdGqhbAQ==
X-Received: by 2002:a1c:449:: with SMTP id 70mr4008121wme.40.1602769163466;
        Thu, 15 Oct 2020 06:39:23 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:5400:5b12:4f4c:844b? ([2a01:e34:ed2f:f020:5400:5b12:4f4c:844b])
        by smtp.googlemail.com with ESMTPSA id b5sm4539952wrs.97.2020.10.15.06.39.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 06:39:22 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] Clarify abstract scale usage for power values in
 Energy Model, EAS and IPA
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        Quentin Perret <qperret@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Nayak, Rajendra" <rnayak@codeaurora.org>
References: <20201002114426.31277-1-lukasz.luba@arm.com>
 <d2960f6a-1805-1fb4-98ae-4a756d20370b@arm.com>
 <765e6603-b614-fb72-64ff-248b42474803@linaro.org>
 <b19c1f12-b7cf-fcae-4ebb-617019effe2e@arm.com>
 <55d3fb0f-f7d8-63c5-2bdb-53eaa62380e0@linaro.org>
 <f660731e-132b-2514-f526-d7123ed3522c@arm.com>
 <d04019bd-9e85-5f3e-2a1b-66780b8df3dc@linaro.org>
 <CAJZ5v0jmTYtMyujxxTBezmiO-j3iW_RjRKOkCpqU4gtRe+OJ2Q@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <03baa329-8fce-410c-ba51-385d4041aaa9@linaro.org>
Date:   Thu, 15 Oct 2020 15:39:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jmTYtMyujxxTBezmiO-j3iW_RjRKOkCpqU4gtRe+OJ2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15/10/2020 15:33, Rafael J. Wysocki wrote:

[ ... ]

>> Up to Rafael to decide what to do with this documentation update.
> 
> Well, I was hoping that you both would reach some kind of agreement.
> 
> I don't feel like the decision is mine here to be honest.

No problem, probably we have to think about that a bit more before
reaching the agreement.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
