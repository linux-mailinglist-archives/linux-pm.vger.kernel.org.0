Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4743170A5
	for <lists+linux-pm@lfdr.de>; Wed, 10 Feb 2021 20:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbhBJTwd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Feb 2021 14:52:33 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42844 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbhBJTw0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Feb 2021 14:52:26 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 11AJpWtR004088;
        Wed, 10 Feb 2021 13:51:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1612986692;
        bh=XzS/ZJanCrIZX7p0c1TNTRFEMN1N0SuLhFmG8GhLakg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=t19jm8m5xtSdV1iMjU5+aOt+4B24Iwg4szin03bFWKlCmb8J3aJzq4SuEBhijneLo
         yezJHP1TU5ZZfRvwSS3sA9AqiGU1IB5bAEwQ8db7bVcfo3k4vxAyvS9C0RaXQexpDB
         mNc2l38tkUvbgHkN53XAM3jgI+hHSAChC7CZHUgg=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 11AJpVF8102199
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Feb 2021 13:51:31 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 10
 Feb 2021 13:51:31 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 10 Feb 2021 13:51:31 -0600
Received: from [10.250.39.16] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 11AJpVQM109838;
        Wed, 10 Feb 2021 13:51:31 -0600
Subject: Re: [EXTERNAL] Re: [PATCH 2/2] power: supply: bq25980: Moves
 properties from battery node
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     <sre@kernel.org>, <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210209230527.26712-1-r-rivera-matos@ti.com>
 <20210209230527.26712-2-r-rivera-matos@ti.com>
 <CAJKOXPeqd7iMU+gVC-xT-MY6YKXrB88gsCyd9M0NX=wCtyWrmA@mail.gmail.com>
From:   Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Message-ID: <e815f46c-d035-b9db-0239-dba81ad8e02b@ti.com>
Date:   Wed, 10 Feb 2021 13:51:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPeqd7iMU+gVC-xT-MY6YKXrB88gsCyd9M0NX=wCtyWrmA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 2/10/21 2:23 AM, Krzysztof Kozlowski wrote:
> On Wed, 10 Feb 2021 at 00:52, Ricardo Rivera-Matos
> <r-rivera-matos@ti.com> wrote:
>> fix: exposes POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT on the
>>
>> charger node
> Why is this a fix? Why is exposing this property wrong? What is the
> problem here? Why do you start sentences with a small letter? Your
> commit message should answer such questions.
ACK, I will rebase and reword this commit message
>
> Best regards,
> Krzysztof
Best Regards,
Ricardo
