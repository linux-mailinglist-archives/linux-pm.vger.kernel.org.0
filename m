Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C11F117282
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 18:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfLIRLa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 12:11:30 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39779 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfLIRL3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Dec 2019 12:11:29 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so17046114wrt.6
        for <linux-pm@vger.kernel.org>; Mon, 09 Dec 2019 09:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mPzvy9s/xchWB5p7Eh9jGDRZOnGTThlUcyCeDW/PbvI=;
        b=wU2NAzpCYkIaEPYjgtkBFUSWTuX5y5gQhAGA2GpJP7y3iuqfk9idi/5y4vwdczEnvn
         D9tkkDhiL7H4QWImYUbrjuP+3zmdnidXO0MrSs+6LFO8Y62goRSiighCAyO6n26/T+Zo
         hZaO4y4M+2/3ZaLFNDam+ljzGWYc4QHBE+n+ewz1JimHV2mFIDkx6y7vXCa7kZaa7EcC
         76Jjlj7sEvyNNiK1pPWmf2RqCzVNvQ1s6iaLjgdh1nUtSaBDJvnlY7Z9T9t6s67TFDh5
         ORb3T7mfZVtS/HckRlY1V+8KzScgu6JlIBAVbOqedykMWBsKLw66+e25xK7vcpw2U994
         RsuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mPzvy9s/xchWB5p7Eh9jGDRZOnGTThlUcyCeDW/PbvI=;
        b=KVG+q5ekm13TrHjO9pzjpTbQmzMapVFxzqmrB6rEIqgyqTvxBblI4XLMI2JLwFhJUj
         7q8Y98xBe54KNVOSe0FjdibxNfNH+XIV/0FXteZlwuXd5BiWXL97Avhbs3iZ8mJwv96d
         BK49quivmvST37ZHN4DYEgGtcaUo4GsXbpphjJAWHkwxhnbZygV0pfYYbD5enScUKpxq
         +9LS3iOa+oEKMmtp90Bjzzj35mzl0Tfrmi8Z78hlPXMdWQPgITWJzPs2Wl0Ro3tc+mZc
         lhhVlAn2LlDyvRyjshEpEKMtkROfWLWQmD3g1x0+lMTc/LnxsTkLMZFvxnYqndVKEeul
         m/bw==
X-Gm-Message-State: APjAAAUSyhS86Y+Lj92IUf7K7kxV/690w9uSBqNyFHFiHuuFXiPj6GDY
        iIrsJMr81vTpZ+I5suButoAQcA==
X-Google-Smtp-Source: APXvYqw8F2dYy8c1CNizEqE6KdcmZfx/Q+VqKrJIGm3yLYcNybUA+/aHHicnNwxMAEDey5qyWRbPiQ==
X-Received: by 2002:a5d:6b88:: with SMTP id n8mr3426308wrx.288.1575911486520;
        Mon, 09 Dec 2019 09:11:26 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:3114:25b8:99b8:d7fe? ([2a01:e34:ed2f:f020:3114:25b8:99b8:d7fe])
        by smtp.googlemail.com with ESMTPSA id d19sm407477wmd.38.2019.12.09.09.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 09:11:25 -0800 (PST)
Subject: Re: [PATCH v2 1/2] thermal: armada: fix register offsets for AXP
To:     Zak Hays <zak.hays@lexmark.com>
Cc:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1575485367-18262-1-git-send-email-zhays@lexmark.com>
 <BN8PR10MB3379A954079A4ECF574E80DE8C5D0@BN8PR10MB3379.namprd10.prod.outlook.com>
 <e2ed2a04-83c0-b346-4de0-0f92d6dd7fbf@linaro.org>
 <BN8PR10MB33792C7BA3B1D002AEDD25E08C580@BN8PR10MB3379.namprd10.prod.outlook.com>
 <6c4e79ab-313c-5bb5-1489-329d916bd947@linaro.org>
 <BN8PR10MB337975A77D726FDAFA9F13598C580@BN8PR10MB3379.namprd10.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <cee7f713-681d-8b03-08e3-3b10da36d2d5@linaro.org>
Date:   Mon, 9 Dec 2019 18:11:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <BN8PR10MB337975A77D726FDAFA9F13598C580@BN8PR10MB3379.namprd10.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09/12/2019 17:58, Zak Hays wrote:
>> On 09/12/2019 17:31, Zak Hays wrote:
>>> Hi Daniel,
>>>
>>>> Hi Zak,
>>>>
>>>> what patch to pick up? V2 or V2?
>>> I'm not sure I entirely understand your question. There are two patches:
>>>
>>> Zachary Hays  thermal: armada: fix register offsets for AXP
>>> Zachary Hays  thermal: armada: clear reset in armadaxp_init
>>
>> I'm seeing multiple posting of the V2 and reply to V2 with I guess a
>> changelog added.
>>
>> It is very difficult to deal with patches when it is unclear, duplicate
>> series with different changelog.
>>
>> In the future, post a resend version explaining what was missing, so it
>> is easier to understand what is happening. Or send a V3.
> 
> Ah. I understand now. I've been fighting email issues trying to get these patches sent and
> inadvertently sent out multiple versions of the same patches. The most recent patches
> are correct. Sorry for that spam. Shouldn't happen again.
> 
> Would you like me to resend as V3 for clarity or would you prefer to continue with the
> V2 patches?

A V3 please, so I can pick them up without ambiguity from patchwork.

Thanks!





-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

