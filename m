Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 764ECF804C
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 20:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfKKTkr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 14:40:47 -0500
Received: from mail-eopbgr70081.outbound.protection.outlook.com ([40.107.7.81]:51814
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726927AbfKKTkr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 11 Nov 2019 14:40:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSbj5sbrTyIUoq2lIGh7XhlOmwVbGnzWdJ9MDDWoJkLSTy+0pW/LcEnjVoRRrTPGvpjDO0kglPSOppOTPjKDssJb61agNByUbpa3JJrFqVneuiRNoaQhAxxZSuJkEY+WBhSfLBYDq+NXkeD0d+rEbQRbkVRbn0jlok9QNWcn6aHw9UfZqFVcUK34+S4wQ/dot918t0sMoMA6OydXdbU6L/ie73InxeA1vgJj4KqMEwWW7rMiOF973q02IPcIaTzssMl4VkdBzUTqmYaQurTVvxgyhfxKQbKiPV/5xu0vBCwOk8W7RBMFqR7X+rg5ev4/bithK6okNUHnlWJLdjhu7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8dGiD2eHTRDrdRePyhQFMVYg30saT3lqPsvKfdRFH4=;
 b=Z4ANE9iTZ1B+CkDd0LeMSiuqR7qIFq71m111HpBqkS3E9ydB+S3FhEhrsr45SLSiHNlv70jNxu5nTL6d55REPZZhH0R6oP06o9frUBfXUnVRwcMeMgEwy7IsSkC7ONNiYCDvnOKJbJs9hopV+fvmqBzdNq1xTfCB2ykNtUHILZq5+dwWwLvszvJfiryBMxY87erU7vON07/YW8dGVxhGs6uni+N3SxFQl4DhPXHWzOs2HxOBGu0+UWQ3GYCeTxiiTkgu6jPKNLFSFEqZrApdwF76vBaSMJXJkO+F8/PA4+A1E5ybfEq8SsZ0c9o8w1tN/xEn9qi1jo3g53uA9eTNOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8dGiD2eHTRDrdRePyhQFMVYg30saT3lqPsvKfdRFH4=;
 b=H19tu+02MKQxp4MwBpLFnuEOehLVX2xDEp0bYSBvtLAxud2cL7KBJu1vfxUc11RM6VBKjy2A1IIm85Rb7BnkmIklcOFldoyqQnJzPgqU7VxnesXZPj3NTb331iT9leSWF4IyYe56bfXiYFTzW8ODgogT7jqgljCAYXuZjPA5C3I=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB6846.eurprd04.prod.outlook.com (52.133.244.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Mon, 11 Nov 2019 19:40:42 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2430.027; Mon, 11 Nov 2019
 19:40:42 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@partner.samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/3] PM: QoS: Restore DEV_PM_QOS_MIN/MAX_FREQUENCY
Thread-Topic: [PATCH 0/3] PM: QoS: Restore DEV_PM_QOS_MIN/MAX_FREQUENCY
Thread-Index: AQHVi14l4NlH3bshT0KcgbRRsNc3XA==
Date:   Mon, 11 Nov 2019 19:40:41 +0000
Message-ID: <VI1PR04MB7023A694AEAD93C2A4470EB4EE740@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1572025364.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ec2dec4b-5538-4b9f-39e4-08d766df0999
x-ms-traffictypediagnostic: VI1PR04MB6846:|VI1PR04MB6846:
x-ms-exchange-purlcount: 3
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB68460B070A6189F0F286BB3EEE740@VI1PR04MB6846.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(199004)(189003)(26005)(305945005)(6306002)(54906003)(110136005)(71200400001)(71190400001)(229853002)(6436002)(99286004)(74316002)(9686003)(316002)(6246003)(7736002)(6116002)(66066001)(86362001)(3846002)(4326008)(8676002)(966005)(66556008)(476003)(91956017)(7416002)(66946007)(2906002)(64756008)(76116006)(25786009)(66476007)(81156014)(81166006)(446003)(66446008)(76176011)(186003)(55016002)(5660300002)(102836004)(486006)(53546011)(44832011)(478600001)(6506007)(33656002)(14454004)(52536014)(14444005)(8936002)(45080400002)(256004)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6846;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kWg9XaUgjIKqSmN7Nh0ulDJKAyWw4LOlJ27dfdPEK//FgsOolAaYDDpuxEwddHTVxU88DCh7X5rXGsPsds9E/mHKKRz4lgyaW816Wtjifp/5anYPMywTbzl5MwMOMN/6sKsqEaKEYcWZBZz/I5B+XXKJiHz6DLXx+N/WyjIV9TV8WlKnnsTmvDntqyG76EMZBnw2PwX5k1wiOYWd9yZH9Q4tRPDfuvmctfNhD2AkiKBqDIzhO4BmhgFhElsG0khJAo/KEFsnLw8Dlfp3ejAsw1sKN/9nyU1utkU0G4+nFTO0VzI7BBwvIRFs3I0TPJTyG7qIBcHDvw9frgp4EQTu+Sps7SlzjWxdIx/Xb9FROw6LJn5Kb7hwZUcB6U+BWUg1vZpFx0E1urKfy7JYfDkFdHIOqbC3nK/D/WgisDyXHVIrx+VG/S35N+vknpFcaof4Ui4sNUyFQBZZTl0B+WtfLa56c1SFl90NgTOJs8OYgBw=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec2dec4b-5538-4b9f-39e4-08d766df0999
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 19:40:41.9786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YCD54qiD7k0wYAckQArc/HB1/havXuVXej6cwPKGsKOdYBm6V3QVYWmCtrlufBnABlYCkNvpTWULaVLZJ6ZbtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6846
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25.10.2019 21:00, Leonard Crestez wrote:=0A=
> Support for frequency limits in dev_pm_qos was removed when cpufreq was=
=0A=
> switched to freq_qos, this series attempts to restore it by=0A=
> reimplementing top of freq_qos.=0A=
> =0A=
> Previous discussion here:=0A=
> =0A=
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
kernel.org%2Flinux-pm%2FVI1PR04MB7023DF47D046AEADB4E051EBEE680%40VI1PR04MB7=
023.eurprd04.prod.outlook.com%2FT%2F%23u&amp;data=3D02%7C01%7Cleonard.crest=
ez%40nxp.com%7C56eca0f61d714ccda20d08d75975467d%7C686ea1d3bc2b4c6fa92cd99c5=
c301635%7C0%7C0%7C637076232541620636&amp;sdata=3DX7yVr362%2F2LyvYLX%2FPlmad=
iHIR2Q1whFOXGdqecG6s4%3D&amp;reserved=3D0=0A=
> =0A=
> The cpufreq core switched away because it needs contraints at the level=
=0A=
> of a "cpufreq_policy" which cover multiple cpus so dev_pm_qos coupling=0A=
> to struct device was not useful (and was incorrectly handling). Cpufreq=
=0A=
> could only use dev_pm_qos by implementing an additional layer of=0A=
> aggregation from CPU to policy.=0A=
> =0A=
> However the devfreq subsystem scaling is always performed for each=0A=
> device so dev_pm_qos is a very good match. Support for dev_pm_qos=0A=
> inside devfreq is implemented by this series:=0A=
> =0A=
> 	https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatc=
hwork.kernel.org%2Fcover%2F11171807%2F&amp;data=3D02%7C01%7Cleonard.crestez=
%40nxp.com%7C56eca0f61d714ccda20d08d75975467d%7C686ea1d3bc2b4c6fa92cd99c5c3=
01635%7C0%7C0%7C637076232541630633&amp;sdata=3DREK2U%2B7xDg3wmXO1JM5aO%2Bdj=
vpQkKh9%2BVrFz4ULxjnE%3D&amp;reserved=3D0=0A=
> =0A=
> Rafael: If this makes sense to you I could incorporate the restoration=0A=
> of DEV_PM_QOS_MIN/MAX_FREQUENCY in v10 of the devfreq qos series.=0A=
> =0A=
> In theory if freq_qos is extended to handle conflicting min/max values th=
en=0A=
> this sharing would be useful. Right now freq_qos just ties two unrelated=
=0A=
> pm_qos aggregations for min/max freq.=0A=
> =0A=
> ---=0A=
> This is implemented by embeding a freq_qos_request inside dev_pm_qos_requ=
est:=0A=
> the data field was already an union in order to deal with flag requests.=
=0A=
> =0A=
> The internal _freq_qos_apply is exported so that it can be called from=0A=
> dev_pm_qos apply_constraints.=0A=
> =0A=
> The dev_pm_qos_constraints_destroy function has no obvious equivalent in=
=0A=
> freq_qos but really the whole approach of "removing requests" is somewhat=
 dubios:=0A=
> request objects should be owned by consumers and the list of qos requests=
=0A=
> should be empty when the target device is deleted. Clearing the request=
=0A=
> list and would likely result in a WARN next time "update_request" is=0A=
> called by the requestor.=0A=
> =0A=
> Leonard Crestez (3):=0A=
>    PM: QoS: Reorder pm_qos/freq_qos/dev_pm_qos structs=0A=
>    PM: QoS: Export _freq_qos_apply=0A=
>    PM: QoS: Restore DEV_PM_QOS_MIN/MAX_FREQUENCY=0A=
> =0A=
>   drivers/base/power/qos.c | 69 +++++++++++++++++++++++++++++---=0A=
>   include/linux/pm_qos.h   | 86 +++++++++++++++++++++++-----------------=
=0A=
>   kernel/power/qos.c       | 11 ++---=0A=
>   3 files changed, 119 insertions(+), 47 deletions(-)=0A=
=0A=
Any feedback?=0A=
=0A=
The DEV_PM_QOS_MIN/MAX_FREQUENCY constraints are very useful for devfreq =
=0A=
but devfreq maintainers seem unwilling to take such core changes. See:=0A=
=0A=
     https://patchwork.kernel.org/patch/11221877/#22974093=0A=
=0A=
This makes a lot of sense, PM QoS core changes should be reviewed by =0A=
core PM maintainers.=0A=
=0A=
What would it take to restore DEV_PM_QOS_MIN/MAX_FREQUENCY?=0A=
=0A=
Cpufreq itself could still use DEV_PM_QOS if it performed two-stage =0A=
aggregation. This would require a bit of additional effort in =0A=
cpufreq_policy code but simplify consumers and expose fewer internals. =0A=
This sounds like a worthwhile tradeoff.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
