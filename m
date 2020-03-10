Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31E591808E7
	for <lists+linux-pm@lfdr.de>; Tue, 10 Mar 2020 21:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbgCJUPY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Mar 2020 16:15:24 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:34026 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbgCJUPX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Mar 2020 16:15:23 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02AKFIv9090192;
        Tue, 10 Mar 2020 15:15:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583871318;
        bh=7NW06bwfj5FntAVsHPeONgq/hzdzS0WeL4eQPv/ypDo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Hb9FDy9AOTpR9RF7XWCZ0sPGYoNB66BI4mLMjVKZdeJn9IkyY50/dTQwZyfifn+QJ
         qi9mPfl3ipmJIHBBDgrqKkrC9QvridbF7otnRE7qL+gAGxdYfeJkhyG/8fORUt+aPF
         4DWemgFNLYbg6/8pyTMDRXGsgNIziDstjs8QugCc=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02AKFIlk071817
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Mar 2020 15:15:18 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 10
 Mar 2020 15:15:18 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 10 Mar 2020 15:15:18 -0500
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02AKFHvJ030430;
        Tue, 10 Mar 2020 15:15:17 -0500
Subject: Re: [PATCH v4 2/4] power_supply: Add additional health properties to
 the header
To:     Sandeep Patil <sspatil@android.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@android.com>
References: <20200116175039.1317-1-dmurphy@ti.com>
 <20200116175039.1317-3-dmurphy@ti.com>
 <20200117010658.iqs2zpwl6bsomkuo@earth.universe>
 <20200306235548.GA187098@google.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <6b947adc-a176-5fa0-1382-8b08ec3f8b09@ti.com>
Date:   Tue, 10 Mar 2020 15:09:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200306235548.GA187098@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello

On 3/6/20 5:55 PM, Sandeep Patil wrote:
> Hi Sebastian,
>
> On Fri, Jan 17, 2020 at 02:06:58AM +0100, Sebastian Reichel wrote:
>> Hi,
>>
>> On Thu, Jan 16, 2020 at 11:50:37AM -0600, Dan Murphy wrote:
>>> Add HEALTH_WARM, HEALTH_COOL and HEALTH_HOT to the health enum.
>>>
>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>> ---
>> Looks good. But I will not merge it without a user and have comments
>> for the driver.
> Android has been looking for these properties for a while now [1].
> It was added[2] when we saw that the manufacturers were implementing these
> properties in the driver. I didn't know the properties were absent upstream
> until yesterday. Somebody pointed out in our ongoing effort to make sure
> all core kernel changes that android depends on are present upstream.
>
> I think those values are also propagated in application facing APIs in
> Android (but I am not sure yet, let me know if that's something you want
> to find out).
>
> I wanted to chime in and present you a 'user' for this if that helps.

We have re-submitted the BQ25150/155 driver that would be the user and 
we have 2 more for review that will use the new definitions

Dan

