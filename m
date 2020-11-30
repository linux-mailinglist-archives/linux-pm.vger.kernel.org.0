Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A102C8EA6
	for <lists+linux-pm@lfdr.de>; Mon, 30 Nov 2020 21:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbgK3UEa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Nov 2020 15:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgK3UE3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2020 15:04:29 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4328DC061A48;
        Mon, 30 Nov 2020 12:03:49 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id q8so10919021ljc.12;
        Mon, 30 Nov 2020 12:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vEhR+Du89PZ5uHlmTZPVOeMBpk4ZhmnPvG7++GYzT48=;
        b=nBOB4vH5fDSmMiI/v/KOP5Ztcc6gTG6ASlCRAPZhAb9QgYDhofOwwasWO/d1BRsUkk
         Cnupc2ovJEBaBFe93fntQP+ZixTtvkH5q6FIHboY6BK87SY4WkJ9fFWtR9ZFnw1dj+Sf
         J4ys4VkWRj+fnHA8vvebgnOgB0bML3F69nf786Y/dESEr9E6R9oVuV213MrxeuGCkMDN
         QLcHFPwJgjO9/9+MHinqfxKIJmcmWdFOlYB5/N1bMSPckEB1yIP5Ye/GlqAwp7GiTNPU
         NPUIIzw57SzwVWTkj5WmK1U8g4O1qfaIUQE6qimGPW4DPikyT7bO5mbHN2ckFEAqX2jQ
         DWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vEhR+Du89PZ5uHlmTZPVOeMBpk4ZhmnPvG7++GYzT48=;
        b=AuzXTAJsAhKhMFVqZpJqg/hNvK9MS/9lOILWZ5UBaTc9ylg6FxQdHVGXmkXy+NHQgD
         RiIrTC7jQqkdBteqruvjaqj3OXuDPB0fB5Myrq/CRxsK0ZUKvNwNy3PNN1wXInfixZqU
         a17oV53tY4qcJi6zlBtkqLgmrYiVWDdT5jwzwLcxhAJPvpITF7fWdCsvyiZfnb5eGki9
         RU58nZKBJvW5SjjzM9INCwg1dctwn3OnF4M2UwUMUN6tSffnNgvw7ZUWmi/M2a2EWyJn
         KKTKdkhSiEOdjEPO+g2R6KTDfJLNMdOotK5CcW4Se/j9RIbOY/+i1SS9m4OftMr9/2cx
         /Xvw==
X-Gm-Message-State: AOAM531GlsEPj1VczE1o7RmRrwpGLHdY+9d5RpdhmGIdCN2yKEJ6juR+
        qGOsW3Yi835jjiF117vK9+s=
X-Google-Smtp-Source: ABdhPJwUMn+ecDX4H4n6Wk18z6ki+FFE/Gwq+LcNPFp5nQTq6WKmEZqr7eMcBen1vKLu0kYmPs69jA==
X-Received: by 2002:a2e:b386:: with SMTP id f6mr10398273lje.320.1606766627766;
        Mon, 30 Nov 2020 12:03:47 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id l6sm2606668lfk.150.2020.11.30.12.03.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 12:03:46 -0800 (PST)
Subject: Re: [PATCH v10 01/19] dt-bindings: memory: tegra20: emc: Document
 opp-supported-hw property
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20201123002723.28463-1-digetx@gmail.com>
 <20201123002723.28463-2-digetx@gmail.com>
 <46b3bab7-1c2c-2f50-6e41-f411e532357b@linaro.org>
 <20201130182345.GA28450@kozik-lap>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4ff3fe7f-ec17-dd89-3cde-d677b3a92104@gmail.com>
Date:   Mon, 30 Nov 2020 23:03:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201130182345.GA28450@kozik-lap>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

30.11.2020 21:23, Krzysztof Kozlowski пишет:
> On Mon, Nov 30, 2020 at 11:48:18AM +0200, Georgi Djakov wrote:
>> On 23.11.20 2:27, Dmitry Osipenko wrote:
>>> Document opp-supported-hw property, which is not strictly necessary to
>>> have on Tegra20, but it's very convenient to have because all other SoC
>>> core devices will use hardware versioning, and thus, it's good to maintain
>>> the consistency.
>>
>> Hi Dmitry,
>>
>> I believe Krzysztof is waiting for Ack on the binding before merging
>> this patch (and the rest), but unfortunately it was not sent to the
>> DT mailing list for review.

Good catch, thank you.

> Indeed I am still waiting for Rob's and Thierry's acks for this and the
> following patches.  It has been just a week so I'll give it few more
> days.

Rob doesn't review patches which aren't sent to the DT ML, which isn't
cc'ed in v10 by accident. I'll make v11.
