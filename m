Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE62B3AE8E0
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 14:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhFUMSL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 08:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhFUMSK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 08:18:10 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BE8C061574;
        Mon, 21 Jun 2021 05:15:55 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id t17so9649178lfq.0;
        Mon, 21 Jun 2021 05:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NfvgSlO2y4RW4qqEt3Ixp0ZYlDMw/VX+CDd04g25ZCA=;
        b=fY0sxVrBBklXZ1pURX1sXLjOGlXaxmc/LhbE6zWK0hfROOY/HqrU5xnC2b/wEI4c1Q
         LKB0AR+KySv7SN+v++aqWuZt+rLD/ZYF+uxAHsYJB+7pEGnYzCfEL6cE1JsfWFCkg93I
         BqsD7kr1aNgIkLGPv8fbtQuWz+6sWrJ11KH+8tNlAe1uwA6xfBzaaam4EY3I94M/Wa+V
         wb3cPHFHD+w9X1sxtMYE4wdnJ8SSjt9sbNC8eu/UTeyc0lSro3H2y+KS/diKOl2qnGwy
         342ayrC6pOpLJ96i9XPxmNHnp2BWMh2OkT29YboqyYAW5YZE2vtTyrKxh4DOpZKoaBxS
         0oiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NfvgSlO2y4RW4qqEt3Ixp0ZYlDMw/VX+CDd04g25ZCA=;
        b=jv2xbfyxXZW9aQ1PEFGFzmdpIPGKjgYMtSqv3ZJJTD5OQkuutiyH7q5rFJw7t410eO
         KZ+DSQxgK99lhfvrX5dB3Q9URyh+L9eHJcHiwgDh0KzYdHHlg8AMPkUZtuF0KtvHqZY4
         i46EKyQY38yp6XMy/buKr79CJkZ8a0BmPfS5oJNKBSjh4sCq9P7RQSlUV4UFYWAOVvni
         61BXpV/B0xuEPO5KGKD1CAsjLeLU133GT6yWBq2/l5eHSp6KlWAhZh7qCVeL+hp6YoFA
         eQ19EWR8x5a8ofP1p9jAiMFPqmxLnmGDCYPQ6VIrD1lU47cnOkfRaSyE1OwOknTsaDDI
         y4lA==
X-Gm-Message-State: AOAM532YvOOy1FokSVtJLChTny+8hcqEaaS2v0kDzGapUga7C7V6yE5+
        hj3v9cMB+ec2qj9LnpcjbP50OAOatlg=
X-Google-Smtp-Source: ABdhPJxxc8LZCLfgq/WHSt5cXQW897k97zYCCbvxi3QzwcoRc4gjkEhbfJq7djptSKa/LceWTlHwoQ==
X-Received: by 2002:a19:3846:: with SMTP id d6mr1570279lfj.525.1624277753915;
        Mon, 21 Jun 2021 05:15:53 -0700 (PDT)
Received: from [192.168.2.145] (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.googlemail.com with ESMTPSA id r8sm2018487lfc.90.2021.06.21.05.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 05:15:53 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] hwmon: (lm90) Prevent integer overflow of
 temperature calculations
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20210620211408.3893-1-digetx@gmail.com>
 <20210620211408.3893-2-digetx@gmail.com>
 <20210621121229.GB116119@roeck-us.net>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ac1c4350-687e-7999-633c-6b7354ef9b8c@gmail.com>
Date:   Mon, 21 Jun 2021 15:14:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210621121229.GB116119@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

21.06.2021 15:12, Guenter Roeck пишет:
> On Mon, Jun 21, 2021 at 12:14:07AM +0300, Dmitry Osipenko wrote:
>> The minimum temperature value that is passed to the driver is unlimited
>> and value that is close to INT_MIN results in integer overflow of
>> temperature calculations made by the driver. Limit the value in order
>> to prevent the overflow. For now the overflow condition is harmless,
>> but thermal framework won't work properly once we will support the
>> set_trips() callback because it will pass INT_MIN value to the driver.
>>
> AFAICS that should only happen for lm99 because all other values
> are bound in the temp_to_xxx functions. Where else do you see an
> overflow (or underflow) ?

You're correct that the overflow affects only lm99. But why we should
ignore it?
