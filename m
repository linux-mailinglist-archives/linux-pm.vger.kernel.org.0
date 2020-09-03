Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCCA25B83F
	for <lists+linux-pm@lfdr.de>; Thu,  3 Sep 2020 03:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgICBWo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Sep 2020 21:22:44 -0400
Received: from mail-dm6nam10olkn2068.outbound.protection.outlook.com ([40.92.41.68]:9042
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726686AbgICBWn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Sep 2020 21:22:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtPCGatIhmag3EL4caAQj8ZEei2olVqt8JwXb+31sJCdv6P4kSIhuQezmShOUf5MP3MKNO71bX1rKhEyhTojK1UqXTKpjmuxsEd1Na6okMEFauxI7xdXAW/Nf1sMKsCEjMTKrg0QbDpDkLsYfrvJXbLt2APqUo+V982ZUAZWxkmM0T8wLi8yOp8T7HHnB4n6gbWh8K+FJPRW6OAP9FcQqKsMGX7525fdtJpiWQVY+uryKrHBGFBy62A0j/9kjG1QiAqYRS+fwJIfYHs2JZYCAgv+U3ahyhRDG+VwH4qV1ito/wWjYEZBSmM5Z2A5MsfEBwkgw1POF2lEFvSheBfYlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8O6flp/VNLBr1pyqypVoUthXYcGeK+q3afJG8L9C6c=;
 b=S0DpK8Ymc49o83eqNNM2KT+eAHICTLmIsSMWYZzJDAnA4pxeM0IrocO1HCJy0XbVAI0AgzDMxpBxrDgpg0C8DVeEwBWgyS0e1GOgk15YunZHVRZk5185QA3OKRHqQdwBmpDYz9t8/Z5EaWxAdQEh/9n40ntwPQnDwhKDkpEp766ljw28tgSJMC4CQidpiIF3ZL5iZsDJO/04xrvau/era+fTh2nbspPpJ3Ubpcmp2W/52JW2QHAdyB5DkwGFdO91m4+faBg6HDTxiohBTVgWwsxZM8eEDU2lF7pbIBVpe1ex2aQwwcz060Z/KsH4E77hkKTeG+WKCz/kv+RtBUBVCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MW2NAM10FT046.eop-nam10.prod.protection.outlook.com
 (2a01:111:e400:7e87::43) by
 MW2NAM10HT019.eop-nam10.prod.protection.outlook.com (2a01:111:e400:7e87::296)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Thu, 3 Sep
 2020 01:22:40 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:7e87::50) by MW2NAM10FT046.mail.protection.outlook.com
 (2a01:111:e400:7e87::205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23 via Frontend
 Transport; Thu, 3 Sep 2020 01:22:40 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:5EE49EA4CD4E8BFBD877CD9AF491D4CF9A308AD2F327B7892E7C8F31EFB20DCE;UpperCasedChecksum:F2662F72595D4826829102FDE7A4872667CD74AE6A2F111A2FA3FF1FE4829E3A;SizeAsReceived:9223;Count:49
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::303b:a75b:d03e:bd04]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::303b:a75b:d03e:bd04%3]) with mapi id 15.20.3348.015; Thu, 3 Sep 2020
 01:22:40 +0000
Subject: Re: [PATCH v2] power: supply: charger-manager: Fix info message in
 check_charging_duration()
To:     Colin Ian King <colin.king@canonical.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200902162315.GA11384@embeddedor>
 <f93c0fa0-51a1-291f-feda-fbd8d7397e88@infradead.org>
 <20200902164344.GC31464@embeddedor>
 <33793c11-0705-f072-00c8-adfd1bee8915@canonical.com>
From:   Jonathan Bakker <xc-racer2@live.ca>
Message-ID: <BN6PR04MB06605A5DF06E758520BFC0E5CB2C0@BN6PR04MB0660.namprd04.prod.outlook.com>
Date:   Wed, 2 Sep 2020 18:22:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <33793c11-0705-f072-00c8-adfd1bee8915@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR10CA0062.namprd10.prod.outlook.com
 (2603:10b6:300:2c::24) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <7a294073-4fcd-6463-09cd-2caf68e4c624@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MWHPR10CA0062.namprd10.prod.outlook.com (2603:10b6:300:2c::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Thu, 3 Sep 2020 01:22:38 +0000
X-Microsoft-Original-Message-ID: <7a294073-4fcd-6463-09cd-2caf68e4c624@live.ca>
X-TMN:  [Iwlo5JWfihNX1GwC7ElpLrvlzzSOR3gCSYXuk8wcFzoUlK9ZEm1WzaGiT4kkpugx]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 49
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 9d8ce39b-2f40-4161-b836-08d84fa7d95a
X-MS-TrafficTypeDiagnostic: MW2NAM10HT019:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dSlHop2MddRbX7tITPfIJbPBNf2ao/uMQ/EDQpBcfPYLtXaSFMunnUcirBx+34aJXTIgRakGzYkFWzzDtHvJgDAu5ejF9UtVIhSem6XI2V7gmqdzHFndKQq/0tMrlJEWRR9TcUf4oZiB9j+k8xdbgorYq7TiRPFjnMmsAF0WhNySD4OqlyAZujpROzv6dWWC5EW8yPGUlKLzZxii4Np+Pg==
X-MS-Exchange-AntiSpam-MessageData: 58u2FTjNWQ75qFbLwrJudGLW7InnHzJ9v09c9KKWi9vfKRIMQcUEHLsUFqi8u1ijYHslryYWNOb/73XT4wz3c1MkBvRW8tocDyy0gCPH4+aGkqh2fYqHFA9o/XTtEPsBfZ1+TFWHRL2LbiZkitn3yCIoxt/1WW26FaCGh+vcz2Lu3VNbamLul+PqFEChoVd9sg+zaBLrUSmYbR9YYcysLw==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d8ce39b-2f40-4161-b836-08d84fa7d95a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 01:22:40.2806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM10FT046.eop-nam10.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2NAM10HT019
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 2020-09-02 9:46 a.m., Colin Ian King wrote:
> On 02/09/2020 17:43, Gustavo A. R. Silva wrote:
>> On Wed, Sep 02, 2020 at 09:29:31AM -0700, Randy Dunlap wrote:
>>> On 9/2/20 9:23 AM, Gustavo A. R. Silva wrote:
>>>> A few months ago, commit e132fc6bb89b ("power: supply: charger-manager: Make decisions focussed on battery status")
>>>> changed the expression in the if statement from "duration > desc->discharging_max_duration_ms"
>>>> to "duration > desc->charging_max_duration_ms", but the arguments for dev_info() were left unchanged.
>>>> Apparently, due to a copy-paste error.
>>>>
>>>> Fix this by using the proper arguments for dev_info().
>>>>
>>>> Also, while there, replace "exceed" with "exceeds", for both messages.
>>>>
>>>> Addresses-Coverity-ID: 1496803 ("Copy-paste error")
>>>> Fixes: e132fc6bb89b ("power: supply: charger-manager: Make decisions focussed on battery status")
>>>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>>> ---
>>>> Changes in v2:
>>>>  -  Replace "exceed" with "exceeds"
>>>>
>>>>  drivers/power/supply/charger-manager.c | 6 +++---
>>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
>>>> index 07992821e252..a6d5dbd55e37 100644
>>>> --- a/drivers/power/supply/charger-manager.c
>>>> +++ b/drivers/power/supply/charger-manager.c
>>>> @@ -464,7 +464,7 @@ static int check_charging_duration(struct charger_manager *cm)
>>>>  		duration = curr - cm->charging_start_time;
>>>>  
>>>>  		if (duration > desc->charging_max_duration_ms) {
>>>> -			dev_info(cm->dev, "Charging duration exceed %ums\n",
>>>> +			dev_info(cm->dev, "Charging duration exceeds %ums\n",
>>>>  				 desc->charging_max_duration_ms);
>>>>  			ret = true;
>>>>  		}
>>>> @@ -472,8 +472,8 @@ static int check_charging_duration(struct charger_manager *cm)
>>>>  		duration = curr - cm->charging_end_time;
>>>>  
>>>>  		if (duration > desc->charging_max_duration_ms) {
>>>> -			dev_info(cm->dev, "Discharging duration exceed %ums\n",
>>>> -				 desc->discharging_max_duration_ms);
>>>> +			dev_info(cm->dev, "Charging duration exceeds %ums\n",
>>>> +				 desc->charging_max_duration_ms);
>>>>  			ret = true;
>>>>  		}
>>>>  	}
>>>>
>>>
>>> Hi,
>>>
>>> It looks to me like the second block (else if) should be about discharging,
>>> not charging, more like Colin King's patch had it:
>>>
>>
>> I had the same impression for a moment, but what makes me think this is
>> more about charging than discharging, is this line:
>>
>> 471         } else if (cm->battery_status == POWER_SUPPLY_STATUS_NOT_CHARGING) {
>>
>> which was introduced by the same commit:
>>
>> e132fc6bb89b ("power: supply: charger-manager: Make decisions focussed on battery status")
>>
>> let's find out... :)
> 
> It's a 50/50 bet :-)

I believe it should be as Colin King's patch had it, ie

-		if (duration > desc->charging_max_duration_ms) {
+		if (duration > desc->discharging_max_duration_ms) {

The battery_status as POWER_SUPPLY_STATUS_NOT_CHARGING only occurs when we would be charging,
except that we're above or below the allowable temperature readings.  This retains the logic
of prior to e132fc6bb89b ("power: supply: charger-manager: Make decisions
focussed on battery status")

Plus, this is the only place discharging_max_duration_ms is actually used.  It appears to
be the time that the battery can discharge (while being plugged in but out of temperature range)
before restarting charging is tried (which will probably then fail on the next monitor session
due to being above temp).

Thanks,
Jonathan

> 
>>
>> Thanks
>> --
>> Gustavo
>>
> 
