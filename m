Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63A4284B43
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2019 14:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfHGMNf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Aug 2019 08:13:35 -0400
Received: from mail-eopbgr60052.outbound.protection.outlook.com ([40.107.6.52]:53838
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729722AbfHGMNf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Aug 2019 08:13:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mo7r/QDJryGZRT3QRqZ0H5YTAMrIGAZgY4PujuZBTawwmCbOYCO36EULrx5k4tW6QwewUoMoI4GGCvN7uDs7PHrAZ70jfzWqAr6TtWBPTS/abM582ZvHmDkJUvvISJi04xXCQMJ3zxzS0PQayAYdbiiodt1C7gpQB9s9pHJv1ZRmTiRwePDDAUHdmNWfFRnkiiV8Jaq2aqZ/tjjZr9hnIElDAU6RXbFD+VSt4I3M+QL7ekaYR4FFFFtK0tW1NRDv7apeFgrcuafL8otegigwnz3Aumh2QINGnBBOWMJlN5f5avrwQc5KVYQrf0jFARPuLVfLharkVGqxvno4Qdp/RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWWwJ8m1NX44x4zyMqwd+YZpf5dfjgYoPl9kVLInkPs=;
 b=aZo6MgrIe6SqqAyOsPNSHU3xr/ReVFzvy1hD2n5ZnYU1ep27akQfQh78AqAsYuz4xKkDO+h5XLHNkl3K0c2hFo2+XobTuEY1JNrcxiKH+KDgxqlz2AfVdiDjtA4xB/oANU4FxsQb2C+npgbt8DykYyHXJJ2Wo850N4nQxn81F7gdj5Ls8kbbuOAPKDEaUDKtGZC6dXOrBvSwZfOGognOIaaIB8m5vcSnRsfDjkozrW9aLfdFVaRwTZkZFzaxpYoqcCAmzKCMg+LHUA3crB9Kk34u1aXOBRLdIr3ynHW2Sg168YjOhpMvFHENXvX2ANxXiX71mgww7erVeYiz4DWg/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWWwJ8m1NX44x4zyMqwd+YZpf5dfjgYoPl9kVLInkPs=;
 b=MbLmHwxQD69cXQBHZk/x/nOvTCKWpRGzO0htreo/i0d8GA06pwpmVpMXVjB+Zc6d1LE6FLa7vF6yI5q82QnFt8GcnKaCdcm1SvfQKBvmO/7N2PLYeVAFTb6w017fnEpIJRglvBgx5LN4XWRMfGOuIx17IHqLEMWkuApcxlZP8MM=
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com (20.177.50.140) by
 VI1PR04MB4735.eurprd04.prod.outlook.com (20.177.48.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Wed, 7 Aug 2019 12:12:51 +0000
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::41:43ca:bf4c:7b99]) by VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::41:43ca:bf4c:7b99%3]) with mapi id 15.20.2136.018; Wed, 7 Aug 2019
 12:12:51 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
CC:     Artur Swigon <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] PM / devfreq: Add dev_pm_qos support
Thread-Topic: [PATCH] PM / devfreq: Add dev_pm_qos support
Thread-Index: AQHVTDXXQompASFxY0iEK4ZTlwB6yA==
Date:   Wed, 7 Aug 2019 12:12:51 +0000
Message-ID: <VI1PR04MB5055AEA825C101D73262D371EED40@VI1PR04MB5055.eurprd04.prod.outlook.com>
References: <bcbab490489ef5143361048db93752741b38e379.1565081126.git.leonard.crestez@nxp.com>
 <CGME20190806090343epcas1p366bca79527337fcc169ff5c4451f2129@epcms1p6>
 <20190807080709epcms1p666f0a1ba637e020b484e62129a0345c9@epcms1p6>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5a65d98-1b47-42aa-0ff4-08d71b30920f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4735;
x-ms-traffictypediagnostic: VI1PR04MB4735:
x-microsoft-antispam-prvs: <VI1PR04MB4735F8DD36588E802D0867ADEED40@VI1PR04MB4735.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(189003)(199004)(33656002)(26005)(7736002)(53936002)(186003)(7416002)(3846002)(6436002)(8676002)(52536014)(66556008)(91956017)(316002)(66476007)(6116002)(64756008)(9686003)(76116006)(81166006)(305945005)(81156014)(446003)(44832011)(66946007)(66446008)(229853002)(486006)(5660300002)(476003)(8936002)(74316002)(55016002)(4326008)(25786009)(478600001)(256004)(14444005)(6506007)(99286004)(54906003)(68736007)(6246003)(2906002)(71200400001)(2501003)(53546011)(86362001)(102836004)(71190400001)(76176011)(66066001)(110136005)(7696005)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4735;H:VI1PR04MB5055.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: opbJs/MaShlXM5UTzHSJK5lgoWfebT/ioKPLyY/79glFu8cQaQu1zshWb2l7JVK/Ul4R7dzFpXaStLKvI8lBlRGt8ysYplWrUd+rES37aAj8JdUceVSLNqGkHdW2BLrm3dYy1LPiIaTNbsHySaCzpoO39pmBjohG4DQWRGnrbojwuh7CljGeJh81aAFkMy7qSvOTWZQfR17qpinb39eiYMKh+ROQjbhehD9ijTWUhNHqOTTOTKTbiK7P745FN1foRDAVNiFX1/C+YQLOv9qd7KoGmpZLTB4CyVaMgy+DyEfq6pZ/+HmOunqFK0/GRsQB8pdR2OEHf9622lmmTGQ1FvcPozwMPmFQY65gJlSy6GJjqk4AUZ0bvCkR2d1dyCJmRSGPbEN5ysBbuczMROYBReyFECLZqB6rZjNCbdr+9kc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a65d98-1b47-42aa-0ff4-08d71b30920f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 12:12:51.7506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leonard.crestez@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4735
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07.08.2019 11:07, MyungJoo Ham wrote:=0A=
>> Add dev_pm_qos notifies to devfreq core in order to support frequency=0A=
>> limits via dev_pm_qos_add_request and related APIs=0A=
>>=0A=
>> Unlike the rest of devfreq the dev_pm_qos frequency is measured kHz:=0A=
>> this is consistent with current dev_pm_qos usage for cpufreq and allows=
=0A=
>> frequencies above 2Ghz.=0A=
=0A=
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c=0A=
>> +	/*=0A=
>> +	 * notifier from pm_qos=0A=
>> +	 *=0A=
>> +	 * initialized outside of devfreq->lock to avoid circular warning=0A=
>> +	 * between devfreq->lock and dev_pm_qos_mtx=0A=
>> +	 */=0A=
>> +	devfreq->nb_min.notifier_call =3D devfreq_qos_min_notifier_call;=0A=
>> +	devfreq->nb_max.notifier_call =3D devfreq_qos_max_notifier_call;=0A=
>> +=0A=
>> +	err =3D dev_pm_qos_add_notifier(devfreq->dev.parent, &devfreq->nb_min,=
=0A=
>> +				      DEV_PM_QOS_MIN_FREQUENCY);=0A=
>> +	if (err) {=0A=
>> +		dev_err(dev, "Failed to register MIN QoS notifier: %d\n", err);=0A=
>> +		panic("fail\n");=0A=
>> +		goto err_dev;=0A=
>> +	}=0A=
>> +=0A=
>> +	err =3D dev_pm_qos_add_notifier(devfreq->dev.parent, &devfreq->nb_max,=
=0A=
>> +				      DEV_PM_QOS_MAX_FREQUENCY);=0A=
>> +	if (err) {=0A=
>> +		dev_err(dev, "Failed to register MAX QoS notifier: %d\n", err);=0A=
>> +		panic("fail\n");=0A=
>> +		goto err_dev;=0A=
>> +	}=0A=
> =0A=
> Do you really need to have two notifier blocks?=0A=
> Wouldn't it be sufficient to register the same notifier block for both ty=
pes?=0A=
=0A=
Can't register the same notifier block twice, struct notifier_block =0A=
serves as a node in a linked list and there are two lists we need to add to=
.=0A=
=0A=
Two notifier_call functions are also required because container_of is =0A=
the only way to get back to the devfreq instance.=0A=
=0A=
>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h=0A=
>>=0A=
>> 	struct srcu_notifier_head transition_notifier_list;=0A=
>> +=0A=
>> +	struct notifier_block nb_min;=0A=
>> +	struct notifier_block nb_max;=0A=
> =0A=
> Need Doxygen entries.=0A=
=0A=
OK=0A=
