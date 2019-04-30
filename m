Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2D7DF33D
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 11:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfD3Jox (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 05:44:53 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36157 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfD3Jox (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2019 05:44:53 -0400
Received: by mail-wm1-f66.google.com with SMTP id h18so3109340wml.1
        for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2019 02:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=looTlcqCIB3TJbyTND6k3EZ0RBWBOUlYZpKYaCAdqKk=;
        b=k1uR299Yxm7EYSAONf0f2K3YOAM0GjiFXsqYolyfZZLTPyI1gj/cbv4DyO9ZJMMo9V
         zaplBDtNX/iDfN7xaX2w1QFDFgjXVj/d5jAZ+h88IUQDUubQWZtxaRXTMD6XOyVdGCcy
         PA8KZrF+CCn51wYuRpN3z978NEy4BUA0y5XChjhrGM3V9n4QCoq3AYP2efD/U13xsVsX
         apuLMtSTLVH5zqkNoSSStkleNMmWoRppX04Wm32W6zOAMsv9N+zXPGE3QQ2a+Xx+s5Ni
         0NwQhN2rC+YABt5EWFekssoF+dpWSarQBwAXZzOztlay5fsAmT8xixoblGjJWBWE8II9
         4pYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=looTlcqCIB3TJbyTND6k3EZ0RBWBOUlYZpKYaCAdqKk=;
        b=rC1/mx3hkFlosMNOZTaIMfMwXbJ1n8r+jAJ35bCX2T5bbZ/FuQfBD+JKfRjtOVNC9K
         e2gc+lZuqLSgawdSObJMkFgmPLa1b20bSGuRcxjmzEaZv6aXzSdL9dJDDKi4MNgwMSiO
         AlhMr8p75ZFv+A8TLJ9t8OxAXTkkW+asLXbzOlmtQb0lAuFFbrIVYnA+VAqxicFVirjM
         7OG/EZXLp+WaiyVaXGQNN535pUdQLurUf13rmp9+ofFckyMiTZ2yCeULJiyNUV5/YBHN
         +xcFUbhcBzHD15L0Hazx5VRAjszdsAXt85zsUmJYIKxgpFqatc5fObGGajvTm7dQXybs
         f6sg==
X-Gm-Message-State: APjAAAUZWzehdqz393Bb3tvA/3GF1PLUpNP1FvsPoT4v3Ddfz4ItKBpr
        y5arGTXOModNJLXRN4aUnxYQ7A==
X-Google-Smtp-Source: APXvYqxDIo8nKc9Sp0C52XkXJ0RFa5uPzJ7miTrrLAzJ8p8qvVwZQM2Aq2xKA/IZYjIkM1ZaW930hQ==
X-Received: by 2002:a1c:4b03:: with SMTP id y3mr2522912wma.113.1556617491604;
        Tue, 30 Apr 2019 02:44:51 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id e10sm24031411wra.52.2019.04.30.02.44.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 02:44:50 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] thermal: rockchip: fix up the tsadc pinctrl
 setting error
To:     "elaine.zhang" <zhangqing@rock-chips.com>, heiko@sntech.de
Cc:     rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com
References: <1556187154-22632-1-git-send-email-zhangqing@rock-chips.com>
 <1556187154-22632-2-git-send-email-zhangqing@rock-chips.com>
 <be0170d7-64dc-896d-b847-5be192304791@linaro.org>
 <8d41ea98-e0e8-60c8-3237-ade5d0d169bf@rock-chips.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <70cc3a91-8f5d-da48-a815-eaf2670f9a93@linaro.org>
Date:   Tue, 30 Apr 2019 11:44:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8d41ea98-e0e8-60c8-3237-ade5d0d169bf@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29/04/2019 11:51, elaine.zhang wrote:

[ ... ]

> pinctrl select to gpio mode when tsadc suspend and shutdown.
> 
> When suspend, tsadc is disabled, the otp_pin should revert to the
> default gpio state.
> 
>>
>>>         return 0;
>>>   }
>>> @@ -1383,7 +1413,8 @@ static int __maybe_unused
>>> rockchip_thermal_resume(struct device *dev)
>>>       for (i = 0; i < thermal->chip->chn_num; i++)
>>>           rockchip_thermal_toggle_sensor(&thermal->sensors[i], true);
>>>   -    pinctrl_pm_select_default_state(dev);
>>> +    if (thermal->tshut_mode == TSHUT_MODE_GPIO)
>>> +        pinctrl_select_state(thermal->pinctrl, thermal->otp_state);
>> And then
>>     pinctrl_select_state(thermal->pinctrl, thermal->pinctrl_state);
> 
> pinctrl select to otp mode when tsadc resume.

Ok, thanks for clarifying.

  -- Daniel



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

