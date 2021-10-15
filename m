Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511B842F012
	for <lists+linux-pm@lfdr.de>; Fri, 15 Oct 2021 13:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbhJOMAv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Oct 2021 08:00:51 -0400
Received: from foss.arm.com ([217.140.110.172]:41540 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhJOMAv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 15 Oct 2021 08:00:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B99B7147A;
        Fri, 15 Oct 2021 04:58:44 -0700 (PDT)
Received: from [10.57.23.184] (unknown [10.57.23.184])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EE8F3F70D;
        Fri, 15 Oct 2021 04:58:43 -0700 (PDT)
Subject: Re: [PATCH] dt-bindings: memory-controllers: correct path to LPDDR3
 bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
References: <20211015072857.9770-1-krzysztof.kozlowski@canonical.com>
 <a34f6c91-8e94-e446-31fe-085f1e50b2c0@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <b30a1f10-db06-9eb1-0221-974facc2c43a@arm.com>
Date:   Fri, 15 Oct 2021 12:58:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <a34f6c91-8e94-e446-31fe-085f1e50b2c0@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,


On 10/15/21 8:54 AM, Krzysztof Kozlowski wrote:
> On 15/10/2021 09:28, Krzysztof Kozlowski wrote:
>> The LPDDR3 bindings were moved to memory-controllers/ddr.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>
>> ---
>>
>> I will fold it into original patch.
>> ---
>>   .../devicetree/bindings/memory-controllers/ddr/lpddr3.txt    | 5 +++--
>>   .../bindings/memory-controllers/samsung,exynos5422-dmc.yaml  | 3 ++-
>>   2 files changed, 5 insertions(+), 3 deletions(-)
>>
> 
> Squashed into "dt-bindings: Relocate DDR bindings".


Changes look OK, the squashing also make sense. In case you needed,
feel free to add:

Acked-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz
