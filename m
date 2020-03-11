Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1C9181E25
	for <lists+linux-pm@lfdr.de>; Wed, 11 Mar 2020 17:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730031AbgCKQnH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Mar 2020 12:43:07 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39450 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgCKQnH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Mar 2020 12:43:07 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02BGh3DL008631;
        Wed, 11 Mar 2020 11:43:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583944983;
        bh=5r7Nvl/xrjYQj1VqSKcuLORKIAOHb4UzYX18VU3KmRY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Mpyr2LRJ+oX88+/vZHIWWMQMZwQ6JtIxsMPBDSYCopXvJ8+xtktMxuUMgf7JLpUHG
         3DBRdyvVVjIX9iKvLBuMSFnFpuvDA0605pswoaapKr2Sj4hAXFVUyQUkxo/z8HemwQ
         vzVNTWHxByVFzm32roGk2xKozmHacW0GHTRzPXg0=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02BGh3wj080363
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Mar 2020 11:43:03 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 11
 Mar 2020 11:43:02 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 11 Mar 2020 11:43:02 -0500
Received: from [128.247.75.135] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02BGh2o7084185;
        Wed, 11 Mar 2020 11:43:02 -0500
Subject: Re: [EXTERNAL] Re: [PATCH v4 2/4] power_supply: Add additional health
 properties to the header
To:     Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sandeep Patil <sspatil@android.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@android.com>
References: <20200116175039.1317-1-dmurphy@ti.com>
 <20200116175039.1317-3-dmurphy@ti.com>
 <20200117010658.iqs2zpwl6bsomkuo@earth.universe>
 <20200306235548.GA187098@google.com>
 <20200310213050.si7gcr2wbmjgr7jf@earth.universe>
 <de919edb-79b3-82ec-f55c-31a127d6c751@ti.com>
From:   Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Message-ID: <66b2ac86-8513-b540-8a2c-c2ebef4124dd@ti.com>
Date:   Wed, 11 Mar 2020 11:43:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <de919edb-79b3-82ec-f55c-31a127d6c751@ti.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sebastian

On 3/11/20 6:29 AM, Dan Murphy wrote:
> Sebastian
>
> On 3/10/20 4:30 PM, Sebastian Reichel wrote:
>> Hi Sandeep,
>>
>> On Fri, Mar 06, 2020 at 03:55:48PM -0800, Sandeep Patil wrote:
>>> On Fri, Jan 17, 2020 at 02:06:58AM +0100, Sebastian Reichel wrote:
>>>> Hi,
>>>>
>>>> On Thu, Jan 16, 2020 at 11:50:37AM -0600, Dan Murphy wrote:
>>>>> Add HEALTH_WARM, HEALTH_COOL and HEALTH_HOT to the health enum.
>>>>>
>>>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>>>> ---
>>>> Looks good. But I will not merge it without a user and have comments
>>>> for the driver.
>>> Android has been looking for these properties for a while now [1].
>>> It was added[2] when we saw that the manufacturers were implementing 
>>> these
>>> properties in the driver. I didn't know the properties were absent 
>>> upstream
>>> until yesterday. Somebody pointed out in our ongoing effort to make 
>>> sure
>>> all core kernel changes that android depends on are present upstream.
>>>
>>> I think those values are also propagated in application facing APIs in
>>> Android (but I am not sure yet, let me know if that's something you 
>>> want
>>> to find out).
>>>
>>> I wanted to chime in and present you a 'user' for this if that helps.
>> With user I meant an upstream kernel driver, which exposes the
>> values. But thanks for the pointer. This should be mentioned in
>> the patch description, also the fact that the status values are
>> directly taken from JEITA spec.
>
> I mentioned the JEITA in the cover letter but I guess you would like 
> the description in the commit message as well
>
> Dan
>
>
I have added a note mentioning that the properties are taken from the 
JEITA spec in the commit message and listing the bq2515x_charger driver 
as a user. I am waiting for feedback on my other patches in the series 
before sending you v5 patches.

Ricardo

