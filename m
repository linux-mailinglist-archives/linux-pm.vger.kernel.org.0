Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 806BCEB0C2
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 14:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfJaNBi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 09:01:38 -0400
Received: from mail-eopbgr130040.outbound.protection.outlook.com ([40.107.13.40]:22339
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726462AbfJaNBh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 31 Oct 2019 09:01:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNKL8cMVak8wplDmvxsplmxnslRLPe0t3Xd1C7s/NgR/K4hgruyFL0WTxwlaB1vOutfyH1E5ZWuoCcuWJa9tyO1lcbaaBJA/5mS3mJkrTMj3WX1FOWc0nTHgGFPj8nAacJ6zkG3NfxlSP5L+EU2EzA2bas3gPS+D8nlMfkN6hTKOdu+ObzYjEsEivtRYK0TIh2/5t4j5AU2MsmZ2X4iZvLGSti0F0r+Oo5FsOfj+AZCwDMDoxq+eFVBNo8wnvh5WZJHJo7JmUr6F07SZXI0V/MWnphz8Wwm5rHIzs7kCK+zoz0yzQNd1lJgknVVDR0Db/hIfcjZccVA5KhRjIl9hMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B92p04MP/A8Yl8gV1Y5+1sTbFN8RPAa4Oo+q6mvAtOw=;
 b=ETjmy7fHPRN4r1g+wmzBSo01nSNc/4CaWw2EShDb45D1496VyUCtCrOxZsqERRnsQJ1cPW+7ri4dCC1WMp+XXIyLDWBqZZHWpe245/9CNfSn8oU1AVI1Z0032tTY6p3wnvx9v1pySUBc+IJWyW652TvRyHcpxU/VX+RIzaDPVlHY8m63pmSgG2GsWjED0iZ0Cpq+CmURuHtUbUuMI66N9RjhlO5SNqk5wN2PAK0TP+SAXwzs6YKKdcyI9JxsRJSGZ3s8MaWTJYU+IrOI+c3nCGPrEJs45zW4PZ83i0UltlF6q2IlLvcW6VlHbNz2VCeZ+1wGZClcAzatDFgw5HdYUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B92p04MP/A8Yl8gV1Y5+1sTbFN8RPAa4Oo+q6mvAtOw=;
 b=KMHPrdumaoxRBch3BOG7rwudCQz8uUSH/cwGc4kxDb+6LCTmNoXiToRe0eZtWi5kpjAyUM+aMFLRPykGM24hfGYq8yM3U+aPapEKuKxQZnqNGK/E/q2nKDPE0TMioc6tzyzGbiq+1I8Q5s73ajToodj/xBm2cSuUR5q8wnkQm6w=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB3149.eurprd04.prod.outlook.com (10.170.229.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Thu, 31 Oct 2019 13:01:31 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2387.028; Thu, 31 Oct 2019
 13:01:31 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     Viresh Kumar <viresh.kumar@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] cpufreq: Add user_min/max_freq
Thread-Topic: [PATCH] cpufreq: Add user_min/max_freq
Thread-Index: AQHVj9VhgSJamFWQXUuwZXqKbPPg4A==
Date:   Thu, 31 Oct 2019 13:01:31 +0000
Message-ID: <VI1PR04MB702337E37DF8E57A754C1DC5EE630@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <c222deda79ad334ff4edcbd49ddda248685c4ee1.1572395990.git.leonard.crestez@nxp.com>
 <3169109.BFaCN5124U@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6693aa8d-8518-4484-f837-08d75e02736f
x-ms-traffictypediagnostic: VI1PR04MB3149:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <VI1PR04MB3149858AD1BDF75CD3201A66EE630@VI1PR04MB3149.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02070414A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(189003)(199004)(53546011)(99286004)(6506007)(102836004)(76176011)(7696005)(8676002)(8936002)(81166006)(26005)(33656002)(81156014)(186003)(229853002)(316002)(71190400001)(71200400001)(54906003)(6436002)(86362001)(66066001)(478600001)(3846002)(6116002)(45080400002)(966005)(5660300002)(6246003)(14454004)(25786009)(7736002)(446003)(91956017)(66946007)(305945005)(74316002)(4326008)(2906002)(52536014)(5024004)(14444005)(256004)(9686003)(7416002)(6306002)(55016002)(486006)(66446008)(44832011)(64756008)(66556008)(66476007)(76116006)(6916009)(476003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3149;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SNdtppzeSEQIaQHZth0z1jHH7hhrVwQL8Juek/lbu1oVSju9COm1QN96wqWC+8l/9yE+0zFBk7HMJNVfvvHn1hVvU/wX2exizeSj2ZUDBcITxA1Se2e1d6w2GyaEdybjt2qBOxGYN8UvKYimyThpKE8NYm4mBvQKwbIJose95NT1ALzHQbWapHsvDzVqP8nGNcDXaNZYTH4+xHRn8MmW8wzP8R0jx0p77VvAkgbenOw2RchHcaOOmdsQI9vFFEwbOUZ/+adw9LRr6NPRzHNLV5AjHPAbUbynuV0rZIdYIhgzVO62GIX2vk7B7BrbWqw8+KlkiGYm9tKE1aWdmP/teqaHafoqx4c3oruDqXebHF7p2XurVWUXaaDHlsIb7hV4M1OAGRzLoLMKhvQJsYun4//GrIyUuphCp2P1CriCA7yESjLvOrLnDUN1qcZbM2gmVzcSrmDRxkoJCjkkPH4HvEhENRyNWhcG43TUEKqIayA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6693aa8d-8518-4484-f837-08d75e02736f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2019 13:01:31.5021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hOMNoWQ/eTZfL2OkEMFRBWGmBX2MclBwBWRLddJxGvw+MGPIalZ8Rx9t62oUBVTn4YcUIWlnIViRrkdQNIygYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3149
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 31.10.2019 12:24, Rafael J. Wysocki wrote:=0A=
> On Wednesday, October 30, 2019 1:41:49 AM CET Leonard Crestez wrote:=0A=
>> Current values in scaling_min_freq and scaling_max freq can change on=0A=
>> the fly due to event such as thermal monitoring.=0A=
> =0A=
> Which is intentional.=0A=
> =0A=
>> This behavior is confusing for userspace and because once an userspace=
=0A=
>> limit is written to scaling_min/max_freq it is not possible to read it b=
ack.=0A=
> =0A=
> That can be argued both ways.=0A=
> =0A=
> It is also useful to know the effective constraints and arguably the abil=
ity=0A=
> to read back the values that you have written is mostly needed for debugg=
ing=0A=
> the code.=0A=
> =0A=
> Also arguably, if there are multiple sources of frequency limits in user =
space,=0A=
> there needs to be a user space arbiter deciding on which value to use and=
 in=0A=
> that case it needs to store the last value chosen by it anyway.=0A=
=0A=
If an userspace tool needs to temporarily adjust min/max_freq it has no =0A=
way of reliably restoring the old value.=0A=
=0A=
>> Introduce two new user_min/max_freq files which only contain the limits=
=0A=
>> imposed by userspace, without any aggregation.=0A=
> =0A=
> I'm not sure how useful that is except for the debugging use case to be h=
onest.=0A=
> =0A=
> Do you have any specific use cases beyond debugging in mind?=0A=
=0A=
No. I guess it would be useful for userspace cpufreq daemons but I'm not =
=0A=
familiar with any. Maybe somebody else could chime in?=0A=
=0A=
Honestly it's not very useful for debugging: what you would want is a =0A=
debugfs files which can enumerate all QoS requests in the system.=0A=
=0A=
>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
>> ---=0A=
>> This was motivated by these discussions:=0A=
>>=0A=
>> * https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpa=
tchwork.kernel.org%2Fpatch%2F11078475%2F%2322805379&amp;data=3D02%7C01%7Cle=
onard.crestez%40nxp.com%7C9935807314f14a73eb9d08d75dec8695%7C686ea1d3bc2b4c=
6fa92cd99c5c301635%7C0%7C0%7C637081142759735597&amp;sdata=3DG0JDLEytUKMCDN2=
x7ccXmRHBFktPOJBbPsY52A0ppxY%3D&amp;reserved=3D0=0A=
>> * https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpa=
tchwork.kernel.org%2Fpatch%2F11171817%2F%2322917099&amp;data=3D02%7C01%7Cle=
onard.crestez%40nxp.com%7C9935807314f14a73eb9d08d75dec8695%7C686ea1d3bc2b4c=
6fa92cd99c5c301635%7C0%7C0%7C637081142759735597&amp;sdata=3DFLP0%2FoMMubhPM=
yDt2xTL%2F3xlLfR%2FK9CWIcDA6T14MFw%3D&amp;reserved=3D0=0A=
>>=0A=
>> Those threads are about devfreq but same issue applies to cpufreq as=0A=
>> well. Let me know if this solution seems reasonable?=0A=
>>=0A=
>> An alternative would be to make scaling_min/max_freq always read back=0A=
>> the configured value and introduce new effective_min/max_freq files for=
=0A=
>> the aggregate values. That might break existing users (though I'm not=0A=
>> familiar with any).=0A=
>>=0A=
>>   Documentation/admin-guide/pm/cpufreq.rst | 27 ++++++++++++++++++------=
=0A=
>>   drivers/cpufreq/cpufreq.c                | 19 +++++++++++++++++=0A=
>>   include/linux/pm_qos.h                   |  4 ++++=0A=
>>   3 files changed, 44 insertions(+), 6 deletions(-)=0A=
>>=0A=
>> diff --git a/Documentation/admin-guide/pm/cpufreq.rst b/Documentation/ad=
min-guide/pm/cpufreq.rst=0A=
>> index 0c74a7784964..734c01c1040e 100644=0A=
>> --- a/Documentation/admin-guide/pm/cpufreq.rst=0A=
>> +++ b/Documentation/admin-guide/pm/cpufreq.rst=0A=
>> @@ -309,21 +309,36 @@ are the following:=0A=
>>   =0A=
>>   ``scaling_max_freq``=0A=
>>   	Maximum frequency the CPUs belonging to this policy are allowed to be=
=0A=
>>   	running at (in kHz).=0A=
>>   =0A=
>> -	This attribute is read-write and writing a string representing an=0A=
>> -	integer to it will cause a new limit to be set (it must not be lower=
=0A=
>> -	than the value of the ``scaling_min_freq`` attribute).=0A=
>> +	This attribute is read-write: writing an integer will set a new limit=
=0A=
>> +	(just like ``user_max_freq``) while reading will show the current=0A=
>> +	limit (potentially affected by other system contraints such as thermal=
=0A=
>> +	throttling).=0A=
>>   =0A=
>>   ``scaling_min_freq``=0A=
>>   	Minimum frequency the CPUs belonging to this policy are allowed to be=
=0A=
>>   	running at (in kHz).=0A=
>>   =0A=
>> -	This attribute is read-write and writing a string representing a=0A=
>> -	non-negative integer to it will cause a new limit to be set (it must n=
ot=0A=
>> -	be higher than the value of the ``scaling_max_freq`` attribute).=0A=
>> +	This attribute is read-write: writing an integer will set a new limit=
=0A=
>> +	(just like ``user_min_freq``) while reading will show the current=0A=
>> +	limit (potentially affected by other system contraints).=0A=
>> +=0A=
>> +``user_max_freq``=0A=
>> +	Userspace contraint for the maximum frequency the CPUs belonging to=0A=
>> +	this policy are allowed to be running at (in kHz).=0A=
>> +=0A=
>> +	This attribute is read-write: writing an integer will set a new limit=
=0A=
>> +	and reading will show the last limit set by userspace.=0A=
> =0A=
> Making these read-write is not useful IMO.  Make them read-only.=0A=
> =0A=
>> +=0A=
>> +``user_min_freq``=0A=
>> +	Userspace contraint for minimum frequency the CPUs belonging to this=
=0A=
>> +	policy are allowed to be running at (in kHz).=0A=
>> +=0A=
>> +	This attribute is read-write: writing an integer will set a new limit=
=0A=
>> +	and reading will show the last limit set by userspace.=0A=
>>   =0A=
>>   ``scaling_setspeed``=0A=
>>   	This attribute is functional only if the `userspace`_ scaling governo=
r=0A=
>>   	is attached to the given policy.=0A=
>>   =0A=
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c=0A=
>> index 48a224a6b178..caefed0dac43 100644=0A=
>> --- a/drivers/cpufreq/cpufreq.c=0A=
>> +++ b/drivers/cpufreq/cpufreq.c=0A=
>> @@ -722,13 +722,28 @@ static ssize_t store_##file_name					\=0A=
>>   									\=0A=
>>   	ret =3D freq_qos_update_request(policy->object##_freq_req, val);\=0A=
>>   	return ret >=3D 0 ? count : ret;					\=0A=
>>   }=0A=
>>   =0A=
>> +store_one(user_min_freq, min);=0A=
>> +store_one(user_max_freq, max);=0A=
>>   store_one(scaling_min_freq, min);=0A=
>>   store_one(scaling_max_freq, max);=0A=
> =0A=
> I don't agree with duplicating functionality like this.=0A=
=0A=
OK. My logic was that a tool which doesn't want to deal with the =0A=
"effective" limits would switch to always reading/writing =0A=
user_min/max_freq if they're present.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
