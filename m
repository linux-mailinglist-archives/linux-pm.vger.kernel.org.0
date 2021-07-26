Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC8D3D67D6
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jul 2021 22:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbhGZTXs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Jul 2021 15:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbhGZTXr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jul 2021 15:23:47 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11705C061757
        for <linux-pm@vger.kernel.org>; Mon, 26 Jul 2021 13:04:16 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id z6-20020a9d24860000b02904d14e47202cso11151362ota.4
        for <linux-pm@vger.kernel.org>; Mon, 26 Jul 2021 13:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/UJ/PgAf9rpspIdYUyy6W0XNumgiVgXfjlUArwaqmlE=;
        b=S1p9g1qr1nxZ/RtAJmEQaKmuV9HF7p49a6Sr5UXPPsn669XOAnJxrhZXEkfkdUjDav
         89v2EiSuE1/YwPgdzzgT1R2PUVLBEtoFQM2HcsXEPkFgWj2ZJCj34bKQ7EPm8ALCIiW0
         IJ1uwaVJovWtvkWwdNKKR/+sBmtRBL9oTPJZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/UJ/PgAf9rpspIdYUyy6W0XNumgiVgXfjlUArwaqmlE=;
        b=FMAp4l2acRjFW+36silOed+Y+iDgZesE9HPVbjkVp8nmpB7UTONnDqJZCyMBR6tei8
         PGh5qE9graLie+MPNWUm0zGekIZ+3Bi+jXH25LB86yAruIL/7wd1A7U68/YR4P9rpohw
         8ooq3jVdkaTTuoe6Pp+ZbTqxAir724MTLYS/apoHbqvDzo+HvIM02r8gLK2vzZJn19/a
         ph1d3xRQwz4czNHMGTRWHBZ/VcRKEWudIiBXq3ASrZKkUoDlCWAmbCxhcwtMCvOeeYhb
         gU5PXOg9tu2d27ghNybhVyzUUhdF0DJn6UfVs3OObg153A7HAy5w9SF/9byiYsiR6tdQ
         /fUw==
X-Gm-Message-State: AOAM531MqryWVJMSJwj5GgiilzHdscHL8dSYHNeXeNM0fH3xOSjmEzBU
        wuIbvpz2wpU2O2Oj9uuVSsqnTw==
X-Google-Smtp-Source: ABdhPJxh6yZ28zBf0PUAfviAH/W4yXT6zxb1eFDrTtGKIhv4eKO/Sd9TdIWuaOMPRNq91YNAgKUGjA==
X-Received: by 2002:a05:6830:7:: with SMTP id c7mr13295153otp.313.1627329855429;
        Mon, 26 Jul 2021 13:04:15 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x38sm160557ott.42.2021.07.26.13.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 13:04:14 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] cpupower: Fix amd cpu (family < 0x17) active state
 issue
To:     =?UTF-8?B?5b6Q56aP5rW3?= <xufuhai1992@gmail.com>, shuah@kernel.org,
        Thomas Renninger <trenn@suse.com>
Cc:     xufuhai <xufuhai@kuaishou.com>, lishujin@kuaishou.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <CAOkq_Bf4NABfLnfVczj3sh5=8EqQxdZZeFc_3rQ24TmBbN365g@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c8aba22f-c61a-ef98-e3be-2102582dbffe@linuxfoundation.org>
Date:   Mon, 26 Jul 2021 14:04:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAOkq_Bf4NABfLnfVczj3sh5=8EqQxdZZeFc_3rQ24TmBbN365g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/23/21 12:23 AM, 徐福海 wrote:
> From: xufuhai<xufuhai1992@gmail.com>  <mailto:xufuhai@kuaishou.com>
> 
> For the old  AMD processor (family < 0x17), cpupower will call the
> amd_pci_get_num_boost_states function, but for the non-root user
> pci_read_byte function (implementation comes from the psutil library),
> val will be set to 0xff, indicating that there is no read function
> callback. At this time, the original logic will set the cpupower turbo
> active state to yes. This is an obvious issue~
> 
> Reproduce procedure:
> 	cpupower frequency-info
> 
> Reported-by:   yangrui<yangrui@kuaishou.com>  <mailto:yangrui@kuaishou.com>
> Signed-off-by: xufuhai<xufuhai1992@gmail.com>  <mailto:xufuhai@kuaishou.com>
> Signed-off-by: chenguanqiao<chenguanqiao@kuaishou.com>  <mailto:chenguanqiao@kuaishou.com>
> Signed-off-by: lishujin<lishujin@kuaishou.com>  <mailto:lishujin@kuaishou.com>

Please use your full names for the Signed-off-by - similar to the way you
would sign a legal document.

thanks,
-- Shuah
