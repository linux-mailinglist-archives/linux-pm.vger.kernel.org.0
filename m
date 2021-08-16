Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35D203ED064
	for <lists+linux-pm@lfdr.de>; Mon, 16 Aug 2021 10:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbhHPIgf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Aug 2021 04:36:35 -0400
Received: from foss.arm.com ([217.140.110.172]:41548 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234025AbhHPIge (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Aug 2021 04:36:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31E801042;
        Mon, 16 Aug 2021 01:36:03 -0700 (PDT)
Received: from [10.57.13.98] (unknown [10.57.13.98])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 75E063F66F;
        Mon, 16 Aug 2021 01:36:01 -0700 (PDT)
Subject: Re: [PATCH] dt-bindings: memory: convert Samsung Exynos DMC to
 dtschema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
References: <20210813125414.104467-1-krzysztof.kozlowski@canonical.com>
 <73eebe7b-46da-137b-1938-09a5b453320a@arm.com>
 <0ec05a0b-9499-3bf4-a231-ea53b1cf99ed@canonical.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <626d539a-ff39-ba98-0e92-4563d4e21681@arm.com>
Date:   Mon, 16 Aug 2021 09:35:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <0ec05a0b-9499-3bf4-a231-ea53b1cf99ed@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 8/16/21 9:32 AM, Krzysztof Kozlowski wrote:
> On 16/08/2021 09:53, Lukasz Luba wrote:
>> Hi Krzysztof,
>>
>> On 8/13/21 1:54 PM, Krzysztof Kozlowski wrote:
>>> Convert Samsung Exynos5422 SoC frequency and voltage scaling for
>>> Dynamic Memory Controller to DT schema format using json-schema.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>> ---
>>>    .../memory-controllers/exynos5422-dmc.txt     |  84 -----------
>>>    .../samsung,exynos5422-dmc.yaml               | 137 ++++++++++++++++++
>>>    MAINTAINERS                                   |   2 +-
>>
>> I'm not an expert in this DT scripts and why it complains. Maybe it
>> complains because the "samsung,exynos-ppmu" is defined in the .txt
>> file... (?)
>> Although, in general looks OK.
>>
>> Acked-by: Lukasz Luba <lukasz.luba@arm.com>
> 
> I think the warning (triggered by DT_CHECKER_FLAGS=-m) can be ignored
> because it complains about compatible in example which is not present in
> the bindings. Usually it means someone wrote example not matching the
> bindings (e.g. a typo in compatible) but here it is on purpose.

Fair enough. Thanks for working on it!
