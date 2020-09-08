Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939A0262149
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 22:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgIHUou (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 16:44:50 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:46280 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgIHUos (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2020 16:44:48 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 088Kik6K061665;
        Tue, 8 Sep 2020 15:44:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599597886;
        bh=8mYvf+CQoKAGZrdEOvriqyzz9emhdrOfR8Q/uFnYD+U=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=eadaxMEXrH+4UX8UsHkCL3BnWOITdn0v7gbNQhBFcP4iKJuv/4J03z13gNaUxPLsA
         t+PTdk7JjSJ37MilEKgOMB8lF6bR6V/YEeuxQJMYPeic8YTbh1Uqvepv5FUjTZeda3
         YD10D1+tlbjHkTEOek22OEHHuiWSGnKaDQ1thTKg=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 088Kikqb105449
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Sep 2020 15:44:46 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 8 Sep
 2020 15:44:46 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 8 Sep 2020 15:44:46 -0500
Received: from [10.250.38.37] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 088Kikia028261;
        Tue, 8 Sep 2020 15:44:46 -0500
Subject: Re: [PATCH 2/2] power: bq27xxx: Fix spacing style and white space
 issues
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     <sre@kernel.org>, <pali@kernel.org>, <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200730143122.28519-1-dmurphy@ti.com>
 <20200730143122.28519-2-dmurphy@ti.com>
 <CAJKOXPeTWko5zD-AJiAud+QvXgSj9_jjvEx3aBCNqRSYL0iJmQ@mail.gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <b9db96d3-c94e-79b2-006b-eb7ae90de1b3@ti.com>
Date:   Tue, 8 Sep 2020 15:44:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPeTWko5zD-AJiAud+QvXgSj9_jjvEx3aBCNqRSYL0iJmQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Krzysztof

On 9/8/20 3:32 PM, Krzysztof Kozlowski wrote:
> On Thu, 30 Jul 2020 at 16:32, Dan Murphy <dmurphy@ti.com> wrote:
>> Fix spacing style issues with the chip data array.  As well as fix
>> missing new line after variable declaration.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>   drivers/power/supply/bq27xxx_battery.c | 63 ++++++++++++++------------
>>   1 file changed, 33 insertions(+), 30 deletions(-)
> Hi all,
>
> Different topic. Do you know what is happening with Andrew's email? I
> receive bounces with 550, so permanent error (no recipient under this
> address).

Andrews email is invalid.  He no longer works for TI.

Dan


> Best regards,
> Krzysztof
