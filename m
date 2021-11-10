Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78C644C4A7
	for <lists+linux-pm@lfdr.de>; Wed, 10 Nov 2021 16:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbhKJPzC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Nov 2021 10:55:02 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:25750 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231795AbhKJPzC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Nov 2021 10:55:02 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AA6WCJE027707;
        Wed, 10 Nov 2021 09:52:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=PODMain02222019; bh=LMIc1XTCuMORjcqD74fjjOGC13l25tQnCBMxRD7cPDw=;
 b=DD7TOEr58YaI/3QdQztz+DIU5Xv4DKK5Sz+eIEWkS0hwVzgct6KZIPdQyOBJSjP5Yj/i
 S96HJVOrVKpN5W+TYINynlFgDC2russ6k6HWFGCvrwQvtuGpmr/1ILFRSVfJfrPN8JiY
 PEmhS8kyLPmMh2syOXBtj8KWtqG+WLVMKro8CzrAFbA0p47CAoIRctnCgZw0brWrPrTV
 tqhBMon9IobaMSDsgqOenybM6wUVwmxh98dDLTHChA82lrzJdKO8IL+vButoRm++QRNY
 780OghuYkISKkv1Pr9Rp/hS73aBXjGX4vcXqYJXJfIlhFgtZvvLjkseh23r83egkouBT sA== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3c7th8hp22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 10 Nov 2021 09:52:12 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.12; Wed, 10 Nov
 2021 15:52:10 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.12 via Frontend
 Transport; Wed, 10 Nov 2021 15:52:10 +0000
Received: from smtpclient.apple (macC02FN0GLMD6T.ad.cirrus.com [141.131.65.13])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8BAF9B2F;
        Wed, 10 Nov 2021 15:52:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH 1/1] power: supply: Introduces bypass charging property
From:   "Rivera-Matos, Ricardo" <rriveram@opensource.cirrus.com>
In-Reply-To: <20211104144444.rulz4br3xu4qc7yh@earth.universe>
Date:   Wed, 10 Nov 2021 09:52:08 -0600
CC:     <patches@opensource.cirrus.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-ID: <75DE78A9-572A-46EC-932E-057EFB7F6421@opensource.cirrus.com>
References: <20211104135027.2352874-1-rriveram@opensource.cirrus.com>
 <20211104135027.2352874-2-rriveram@opensource.cirrus.com>
 <20211104144444.rulz4br3xu4qc7yh@earth.universe>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-Proofpoint-ORIG-GUID: pHzHl3JYBTGIPcG45iDmzSOXYHh0BQ-S
X-Proofpoint-GUID: pHzHl3JYBTGIPcG45iDmzSOXYHh0BQ-S
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

> On Nov 4, 2021, at 9:44 AM, Sebastian Reichel =
<sebastian.reichel@collabora.com> wrote:
>=20
> Hi,
>=20
> On Thu, Nov 04, 2021 at 08:50:27AM -0500, Ricardo Rivera-Matos wrote:
>> Adds a POWER_SUPPLY_CHARGE_TYPE_BYPASS option to the =
POWER_SUPPLY_PROP_CHARGE_TYPE
>> property to facilitate bypass charging operation.
>>=20
>> In bypass charging operation, the charger bypasses the charging path =
around the
>> integrated converter allowing for a "smart" wall adaptor to perform =
the power
>> conversion externally.
>>=20
>> This operational mode is critical for the USB PPS standard of power =
adaptors and is
>> becoming a common feature in modern charging ICs such as:
>>=20
>> - BQ25980
>> - BQ25975
>> - BQ25960
>> - LN8000
>> - LN8410
>>=20
>> Signed-off-by: Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
>> ---
>=20
> Please always send API changes together with a user (e.g. in this
> case you could update bq25980_charger driver to use this property).

Ack, I will send out a v2 patch series with an update to the =
bq25980_charger driver.
>=20
> =E2=80=94 Sebastian

Best Regards,
Ricardo
>=20
>> drivers/power/supply/power_supply_sysfs.c | 1 +
>> include/linux/power_supply.h              | 1 +
>> 2 files changed, 2 insertions(+)
>>=20
>> diff --git a/drivers/power/supply/power_supply_sysfs.c =
b/drivers/power/supply/power_supply_sysfs.c
>> index c3d7cbcd4fad..1368e13dc94b 100644
>> --- a/drivers/power/supply/power_supply_sysfs.c
>> +++ b/drivers/power/supply/power_supply_sysfs.c
>> @@ -89,6 +89,7 @@ static const char * const =
POWER_SUPPLY_CHARGE_TYPE_TEXT[] =3D {
>> 	[POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE]	=3D "Adaptive",
>> 	[POWER_SUPPLY_CHARGE_TYPE_CUSTOM]	=3D "Custom",
>> 	[POWER_SUPPLY_CHARGE_TYPE_LONGLIFE]	=3D "Long Life",
>> +	[POWER_SUPPLY_CHARGE_TYPE_BYPASS]	=3D "Bypass",
>> };
>>=20
>> static const char * const POWER_SUPPLY_HEALTH_TEXT[] =3D {
>> diff --git a/include/linux/power_supply.h =
b/include/linux/power_supply.h
>> index 9ca1f120a211..9432234d7900 100644
>> --- a/include/linux/power_supply.h
>> +++ b/include/linux/power_supply.h
>> @@ -49,6 +49,7 @@ enum {
>> 	POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE,	/* dynamically adjusted =
speed */
>> 	POWER_SUPPLY_CHARGE_TYPE_CUSTOM,	/* use CHARGE_CONTROL_* =
props */
>> 	POWER_SUPPLY_CHARGE_TYPE_LONGLIFE,	/* slow speed, longer =
life */
>> +	POWER_SUPPLY_CHARGE_TYPE_BYPASS,	/* bypassing the charger =
*/
>> };
>>=20
>> enum {
>> --=20
>> 2.25.1
>>=20

