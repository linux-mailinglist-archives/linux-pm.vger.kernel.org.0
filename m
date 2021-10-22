Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6787D4372EC
	for <lists+linux-pm@lfdr.de>; Fri, 22 Oct 2021 09:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbhJVHln (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Oct 2021 03:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbhJVHln (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Oct 2021 03:41:43 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF3DC061764;
        Fri, 22 Oct 2021 00:39:25 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id br29so3365502lfb.7;
        Fri, 22 Oct 2021 00:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/58fmdUhTm+vfNi37x8+KK09cI+TRWyCksHi0nDfU5w=;
        b=InAXn6SY9iZdGJoaYnKd6GyA2mSWyrbFdE79N4LY8b8lZmJblhqrlFCdjFM/rqFQb2
         TgybTyUTAjRL7SXNkv/joGkB3HPU9TjJLjHVyltGjDO0rpqE4R9ifzY4O3uf1DqAcXBc
         aS3ByHucFdSVKXqokg+hW4kQQD5z5sizJnGl/qSHp4ZywdgBkFNu+P1w4cb94cwwZfW2
         24yf+pLcE7Lk/e0/mm0UJGwMwilDUgRygz9vK0pqNvlhEbZobeMLC8LXZerwBsZ2CWJ5
         Qh20aH8mKeOlB/jpHHbgsimYZPW0/23p/6VLSgyTr08VpHtTZ5LviakjY6NFKM/AHt70
         5VYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/58fmdUhTm+vfNi37x8+KK09cI+TRWyCksHi0nDfU5w=;
        b=PMI9ZCUJ6arDgstj8wwuHYMPnOP16qfQeMLNwfnnO+ckohzmRPcFzPB10JL5cxCiGE
         PQ4Dr6p1hp3BqS/F7qX0jTwwO5hRZbXDR0Oodtq7pLoRjhi5c2aCf4et2OdIwzcLx08i
         /LDFwrc0zvrefT7pgUGs394zCNGD1Q0563yCOOzv1lB4zAJadJj7e/QrnO9ORwkP9HaH
         r25TWdpAK/e3Ta8yOJCQxzlIjMzi44nJJBkfxqIo/WFcsqZ3jgXC0mGZuO0pDq2kWurW
         nKQkeiXeD7y1BMjxQTaUOGM26vKThs/SzLEFSUf8iRqyEeZs2FoT55G2/yMvlyYim2CP
         s6uQ==
X-Gm-Message-State: AOAM532XrwvCYyUroHvYub5Jcv+8xoOlBmSO1haY1cDdYK8qjMAVLb0t
        21+jO4WN/hOQ2ceESwqzIbJpsgd5ivc=
X-Google-Smtp-Source: ABdhPJymo+Zl+DAOspOKSpT4DLOygjttXwzvy1Fv7LSUcZ7hlmbkYW/ZckIr7kJEQv4otKGXY694Gw==
X-Received: by 2002:a19:c7d2:: with SMTP id x201mr9416131lff.543.1634888363840;
        Fri, 22 Oct 2021 00:39:23 -0700 (PDT)
Received: from [192.168.2.145] (94-29-61-202.dynamic.spd-mgts.ru. [94.29.61.202])
        by smtp.googlemail.com with ESMTPSA id 13sm658620lfq.69.2021.10.22.00.39.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 00:39:23 -0700 (PDT)
Subject: Re: [PATCH v1] dt-bindings: opp: Allow multi-worded node names
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        David Heidelberg <david@ixit.cz>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
References: <20211019231905.2974-1-digetx@gmail.com>
 <YXAr4OlhucAibMlH@robh.at.kernel.org>
 <20211022044334.4yn3i4kwinbrjicd@vireshk-i7>
 <48de7f40-deda-739d-96ca-e61ec5a0b257@gmail.com>
 <20211022065029.x5a5oh7mh2sjofey@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9798d34b-4886-9d4a-9fb7-634aa323af02@gmail.com>
Date:   Fri, 22 Oct 2021 10:39:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211022065029.x5a5oh7mh2sjofey@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

22.10.2021 09:50, Viresh Kumar пишет:
> On 22-10-21, 09:40, Dmitry Osipenko wrote:
>> 22.10.2021 07:43, Viresh Kumar пишет:
>>> On 20-10-21, 09:46, Rob Herring wrote:
>>>> On Wed, Oct 20, 2021 at 02:19:05AM +0300, Dmitry Osipenko wrote:
>>>>> Not all OPP table names and OPP entries consist of a single word. In
>>>>> particular NVIDIA Tegra OPP tables use multi-word names. Allow OPP node
>>>>> and OPP entry name to have multi-worded names to silence DT checker
>>>>> warnings about the multi-word names separated by hyphen.
>>>>>
>>>>> Reviewed-by: David Heidelberg <david@ixit.cz>
>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>> ---
>>>>>  Documentation/devicetree/bindings/opp/opp-v2-base.yaml | 4 ++--
>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
>>>>> index ae3ae4d39843..298cf24af270 100644
>>>>> --- a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
>>>>> +++ b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
>>>>> @@ -22,7 +22,7 @@ select: false
>>>>>  
>>>>>  properties:
>>>>>    $nodename:
>>>>> -    pattern: '^opp-table(-[a-z0-9]+)?$'
>>>>> +    pattern: '^opp-table(-[a-z0-9]+)*$'
>>>>
>>>> I don't see how this helps you. What I see needed upstream is a prefix:
>>>>
>>>> '-?opp-table(-[0-9]+)?$'
>>>
>>> I wonder if we should disallow that to keep naming more 
>>
>> I also think that postfix variant should be disallowed for consistency.
>> I sent out patches for both variants.
>>
>> V2 uses pattern that supports both naming schemes. If V2 is less
>> appropriate, then please take this V1.
> 
> I didn't like V2, we can mandate to keep it like opp-* and opp-table-*.
> 
> This patch looked okay to me, lets see what Rob has to say.
> 

What we currently have for Tegra is a tegra-opps.dtsi and tegra.dtsi
which includes the OPP's dtsi.

the tegra-opps.dtsi has this structure:

table: devname-opp-table {
	opp: ...
};

and tegra.dtsi:

#include "tegra-opps.dtsi"

device@0000 {
	operating-points-v2 = <&table>;
};

It just occurred to me that there is no need to move all tables to
tegra.dtsi, but change structure of tegra-opps.dtsi to:

device@0000 {
	operating-points-v2 = <&table>;

	table: opp-table {
		opp: ...
	};
};

Then there no need to change current naming scheme. Let me try to
implement it and see how it goes.
