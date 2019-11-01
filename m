Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19892EBC2A
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 04:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbfKADB7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 23:01:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36508 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfKADB7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Oct 2019 23:01:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id w18so8383735wrt.3;
        Thu, 31 Oct 2019 20:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AtU1kcIARpsZYXt8D05gLXwGGsU/iHc+JrhYCZdJwC0=;
        b=GneZf/o2V/MVG9Y4gW4QtHWHdQ+5TyHeNJ6pnmDSc9izj4PKx/0ckMqh68G3njNTY3
         B6zpaMvF2XhdF8QbLHSpezdDujpNm7qJANAgttigs6Uvuwcocjg1APrm/FTkQ10ZixgB
         RLhPINajyl4A3vE0Z6gjMfiBaRj5a9uCTzEmC31NE62Trp5aJO/ilxOTixMUD95Xkx8j
         3z3BAwMOxzO85URhER8TKMkMhE/3PW7Xkqug9qWHxh22d80mrsPb/nUKwyFVP1hhW03M
         Jy7C2/DH3E8bOscdp9/IcGBfpSto8GNsWElGFZwfy0bBKUPYtypc7NNQretGfoZ7UZzX
         4BDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AtU1kcIARpsZYXt8D05gLXwGGsU/iHc+JrhYCZdJwC0=;
        b=c53UeWMrt8SrPS7wdf2xYRXD5NjgYBEf+m2iOkfbFddkw6jnZNFjIJCdFAPkYtpCOW
         c3jwb37xogqOGVdytoC5DNXD6vGgWN/fsuXwuAk9UWf2qY7JSdyCe9EGKR83CWpnxfK2
         WM7EdGW3gIPByNIdn2ORcNb9EKFTIwPWAXKtme7lcLKaMJCtZSpGtMIbD8ZHmOqvML59
         XB+FZjGVEdvqxUU39lzsskRAT4u3WJUiMyJ9dcJVoF00zIAVcBFyV03JOY8xS6rFsyuV
         PskGTGL6NDnf8lwybY0NGx0kMF4Pb3cVoJJXOm3Ag+sxcbr9OqqkUEUWEMyGL3lTX4OO
         Q9RA==
X-Gm-Message-State: APjAAAX0yYtaFGiEH45B1p1rU08UmqKGypF+KaEZjxSsQTq79xR8MUoC
        4jkjRg+KjRi4PIl7GF1OODpEB1vk
X-Google-Smtp-Source: APXvYqx9jxVnR+WaWBKm9uhZse6CSdxQuKYSO3PVxNpyVBc4m7BoywFCNYX0uB8vasFwSxML0Wxlcg==
X-Received: by 2002:a5d:4ace:: with SMTP id y14mr4847999wrs.131.1572577316435;
        Thu, 31 Oct 2019 20:01:56 -0700 (PDT)
Received: from [10.230.29.119] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id o1sm4445376wmc.38.2019.10.31.20.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2019 20:01:55 -0700 (PDT)
Subject: Re: [PATCH] thermal: brcmstb: enable hwmon
To:     Stefan Wahren <wahrenst@gmx.net>, Chen-Yu Tsai <wens@kernel.org>,
        Markus Mayer <mmayer@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
References: <20191030163807.17817-1-wens@kernel.org>
 <91017889-2ae7-d467-eed3-6d3b2bb130b9@gmx.net>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <a3345dbd-19c6-ab9d-a19c-b8ee0a703c17@gmail.com>
Date:   Thu, 31 Oct 2019 20:01:51 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <91017889-2ae7-d467-eed3-6d3b2bb130b9@gmx.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/31/2019 6:08 AM, Stefan Wahren wrote:
> Hi Chen-Yu,
> 
> Am 30.10.19 um 17:38 schrieb Chen-Yu Tsai:
>> From: Chen-Yu Tsai <wens@csie.org>
>>
>> By defaul of-based thermal driver do not have hwmon entries registered.
>>
>> Do this explicitly so users can use standard hwmon interfaces and tools
>> to read the temperature.
>>
>> This is based on similar changes for bcm2835_thermal in commit
>> d56c19d07e0b ("thermal: bcm2835: enable hwmon explicitly").
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>
>> This patch was only compile tested. A similar patch [1] was submitted to
>> the downstream kernel, which I did build and actually run on a Raspberry
>> Pi 4.
> 
> just a note: from my understanding [2] the brcmstb_thermal isn't the
> right driver for BCM2711. Please consider the current downstream
> solution for BCM2711 support as a quick hack to avoid writing a new
> thermal driver. But must confess that i didn't test Florian's recent
> changes yet.

The brcmstb_thermal driver is for chips with an AVS_TMON whereas the
2711 does not have it AFAICT, even if the registers are there, the
hardware is not present (or so have I been told).

The AVS_RO register you are being pointed out may work, although the
data is over 10 bits (not 11) and the valid bit is 10 (not 11). It looks
like you may have to check bit 16 as well for a measurement being done
or not.
-- 
Florian
