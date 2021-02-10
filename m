Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C24D3170A0
	for <lists+linux-pm@lfdr.de>; Wed, 10 Feb 2021 20:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbhBJTvs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Feb 2021 14:51:48 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44014 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbhBJTvh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Feb 2021 14:51:37 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 11AJo32w023859;
        Wed, 10 Feb 2021 13:50:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1612986603;
        bh=KbGjO9RvEE9nypUEybeaQ6iz5h67qLkB0O8m1jrgJBc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=C6J7LLk7n/hg1720k5dC1KGWg58+rp6eT8FXtAyK2wLcbRw4YGnD/xlMVYKPqe8kP
         r/UKk0WF6JbNryd0yxdmI34QTl1oU4i1aTgEjTSl6wnI1b2BUwsn2oAZCY70VKiCB0
         FL2Ckf877nchhNZisf6PBmumULG0DsNdhfqiTHOI=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 11AJo21U102328
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Feb 2021 13:50:03 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 10
 Feb 2021 13:50:03 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 10 Feb 2021 13:50:03 -0600
Received: from [10.250.39.16] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 11AJo3nM107248;
        Wed, 10 Feb 2021 13:50:03 -0600
Subject: Re: [EXTERNAL] Re: [PATCH 1/2] power: supply: bq25980: Applies
 multiple fixes brought on
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     <sre@kernel.org>, <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210209230527.26712-1-r-rivera-matos@ti.com>
 <CAJKOXPdy4BJMSb7KXhU8vYrJ2+qWPOw0MzTGhXQEgh1xHDZFNw@mail.gmail.com>
From:   Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Message-ID: <8f952bd9-1849-af7e-d54f-b897c653a126@ti.com>
Date:   Wed, 10 Feb 2021 13:50:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPdy4BJMSb7KXhU8vYrJ2+qWPOw0MzTGhXQEgh1xHDZFNw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Krzysztof,

On 2/10/21 2:20 AM, Krzysztof Kozlowski wrote:
> On Wed, 10 Feb 2021 at 00:52, Ricardo Rivera-Matos
> <r-rivera-matos@ti.com> wrote:
>> fix: corrects various register step size and offset values
>>
>> fix: corrects bq25980_get_input_curr_lim() and bq25980_set_input_curr_lim()
>>
>> fix: corrects bq25980_get_const_charge_curr() and bq25980_set_const_charge_curr()
>>
>> fix: corrects BQ25960_BATOVP_MIN_uV, BQ25960_BATOVP_OFFSET_uV,
>>
>> BQ25960_BATOVP_STEP_uV, and BQ25960_BATOVP_MAX_uV
>>
>> fix: corrects busocp_sc_min and busocp_byp_min members
>>
>> fix: removes unnecessary polarity check from bq25980_get_adc_ibus()
>>
>> fix: removes unnecessary polarity check from bq25980_get_adc_ibat()
>>
>> fix: clamps ibat_adc to match datasheet change
> Thanks for the patch.
>
> Only one fix at a time and please exactly describe what is being fixed
> using proper sentences (starting with capital letter, ending with a
> full stop... and usually description needs multiple of such
> sentences). You add here multiple changes without proper description
> of a problem being fixed. This is not the correct style of a patch.
ACK, this patch is meant to implement changes brought on by a new 
datasheet revision. The revision tweaked the register step size and 
offset values to improve the accuracy. I can rebase and reword the patch 
if that works for you.
>
> Best regards,
> Krzysztof
Best Regards,
Ricardo
