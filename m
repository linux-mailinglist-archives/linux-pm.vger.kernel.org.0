Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCE05FCA0B
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2019 16:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfKNPhe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Nov 2019 10:37:34 -0500
Received: from mail-eopbgr70071.outbound.protection.outlook.com ([40.107.7.71]:45329
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726339AbfKNPhe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 14 Nov 2019 10:37:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oi3AKWVRiOXLKtkRWU6Y2jF6AlCuQfUUOB7Qhu3g4S8ZIvvfiAFpiiuzCny23VxW7ybESCwI7pRJ6+30G0hmQSBFijBjLZhjarfwP/I66u5jMymKe7YIRczNZMF/NjQvz7yxWD6f6KK+Z9hOEZETN3B9WeV1zgOFRuZDEc8JVmY7xGhz1KrYV+HyZtiy7FgSvDsFr4Zk7jgNtf9OlFCjjFKK/gRW0FZL/RrtoGBymeiu6WcgQxSXTm6j32Pho+lDr9Mh9rdc5tKQjgyLpHjIBM8PPIkBffi2YIN1Wq73TPbzl+as2kpqbi9znvBu3LCmaB7M7uG/2cyFYwW1g+38Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzLVkIeB4avHKt7gZXrgD2I5Q65q1ns7M4a1EjLFR8M=;
 b=ZxMV2MpXvfnzxyq72ttLk2kBOXVYpDGpTDr4pcb/PKln5KAB7T0y0xmhLkmay8hM7yDeMgIAmXpg8/CkkNjep87GlzfIYQAYKftOfXI31SLOC73BjbOfCer7dlMgShg3Clr4tEegzq0uRiR3O7p26Hkl5sZeu960etTRUBDzvbNWWDA6RlIDHtWKrp62ViE1wFOpzTJZlX2DaXXWjc3nBqQtTmwHQEltn+j1lYmJWWfcZsT50cOfLsU/2VZHsAXJNXjP6JJO3kX0+oYEQ+Z9M0QM+Xp2ryQG7dI62q1mQl3Ifzl37W94x4Dqqhz4y2ArZU9+spTEQa5oHzaimxWz+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzLVkIeB4avHKt7gZXrgD2I5Q65q1ns7M4a1EjLFR8M=;
 b=r1IZDEtvHVcsDMu1d7+u16i0Q50YoC/8vogBxft44c5DfgboF6PhkxaQmIaDOurGwPkRR0U6pgVLJC1AF8vOe6DYVTJuxUiWmT9zX/v9+RkxGtpaw6AOHe4m9craOGNg5kPWlvKtwbBoqSzzyxuwrxzG1L7k6LY44mL3MWuk0GI=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB3069.eurprd04.prod.outlook.com (10.170.228.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Thu, 14 Nov 2019 15:37:30 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2451.024; Thu, 14 Nov 2019
 15:37:30 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     Viresh Kumar <viresh.kumar@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@partner.samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 2/3] PM: QoS: Export _freq_qos_apply
Thread-Topic: [PATCH 2/3] PM: QoS: Export _freq_qos_apply
Thread-Index: AQHVi14l5BMB9UEF1E+gVvTdlffcwg==
Date:   Thu, 14 Nov 2019 15:37:30 +0000
Message-ID: <VI1PR04MB7023C32807542C9EAFC2011FEE710@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1572025364.git.leonard.crestez@nxp.com>
 <27d83f2bb2aaa4e69d480622727ba7f4497dbe2a.1572025364.git.leonard.crestez@nxp.com>
 <2045347.p7qcj6nqyX@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cf36aa40-580e-48cb-dbaf-08d769188f99
x-ms-traffictypediagnostic: VI1PR04MB3069:|VI1PR04MB3069:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB30691DCB830D13CD03E0358DEE710@VI1PR04MB3069.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(189003)(199004)(66066001)(71190400001)(71200400001)(478600001)(26005)(14454004)(25786009)(9686003)(256004)(2906002)(4326008)(66946007)(66446008)(64756008)(66476007)(66556008)(476003)(14444005)(6916009)(99286004)(6246003)(44832011)(6436002)(486006)(102836004)(91956017)(316002)(54906003)(5660300002)(76116006)(305945005)(446003)(74316002)(52536014)(33656002)(186003)(7736002)(81156014)(81166006)(3846002)(53546011)(8936002)(6506007)(8676002)(7696005)(229853002)(76176011)(86362001)(6116002)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3069;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xx2q+mIxMZ37Y2gsC7X+rmNHIFn76UwkuONsUtopZ/Ckc+VoCmVAdrfENkfcBzj3MDE8Lq2frtXIqIZcM0m8pXHX4q9ysSvVBSiglEb76EJNvjtiwfekAFMpStTRC1cvsImjIju1axLe/QBFbadO8R+xa/+BVYC9Ma4A6wjgD+Uz2aZRt/04vtakf7eLEozJuLNgj5Sqs0Iy1Be7pNIPcwC9vKpScQGvCvgnfamfwCsYgELyfhSCs4fdawx+zOOBV/rXwFeq400i3hf1mXhST4EQGqcoEUgKUTFuoluKOEWkPajedMgUJ7RV0IUMYXblIlHxJHOTfXtyU76aFNkPYQ+ESYiFzX9FXPaXJHMGpZB2d6wKyUpig6v9N6MZ1Qd5JxRxVfoVjPXwqrkLm3Fed8FVs88GcX51DhXCq6iKPdViYB4oOvbS5SmYq449m7+4
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf36aa40-580e-48cb-dbaf-08d769188f99
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 15:37:30.4555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: evQhTsZHX3MT/AACMG83bd1nEAe5kiNec+To7BysYWcDzzXLKnhhThGE37M0FjnGwbEOPdGnGArCNgL2LdeFyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3069
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14.11.2019 00:24, Rafael J. Wysocki wrote:=0A=
> On Friday, October 25, 2019 8:00:48 PM CET Leonard Crestez wrote:=0A=
>> This is exported only for dev_pm_qos to use in order to implement=0A=
>> per-device freq constraints.=0A=
>>=0A=
>> Export with a leading underscore because this is an implementation=0A=
>> detail, it's not meant to be used by drivers making QoS requests.=0A=
>>=0A=
>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
>> ---=0A=
>>   include/linux/pm_qos.h |  2 ++=0A=
>>   kernel/power/qos.c     | 11 ++++++-----=0A=
>>   2 files changed, 8 insertions(+), 5 deletions(-)=0A=
>>=0A=
>> diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h=0A=
>> index 9105f47f5195..e90dae0b8de9 100644=0A=
>> --- a/include/linux/pm_qos.h=0A=
>> +++ b/include/linux/pm_qos.h=0A=
>> @@ -291,10 +291,12 @@ s32 freq_qos_read_value(struct freq_constraints *q=
os,=0A=
>>   int freq_qos_add_request(struct freq_constraints *qos,=0A=
>>   			 struct freq_qos_request *req,=0A=
>>   			 enum freq_qos_req_type type, s32 value);=0A=
>>   int freq_qos_update_request(struct freq_qos_request *req, s32 new_valu=
e);=0A=
>>   int freq_qos_remove_request(struct freq_qos_request *req);=0A=
>> +int _freq_qos_apply(struct freq_qos_request *req,=0A=
>> +		    enum pm_qos_req_action action, s32 value);=0A=
>>   =0A=
>>   int freq_qos_add_notifier(struct freq_constraints *qos,=0A=
>>   			  enum freq_qos_req_type type,=0A=
>>   			  struct notifier_block *notifier);=0A=
>>   int freq_qos_remove_notifier(struct freq_constraints *qos,=0A=
>> diff --git a/kernel/power/qos.c b/kernel/power/qos.c=0A=
>> index 04e83fdfbe80..ea38ae86bd66 100644=0A=
>> --- a/kernel/power/qos.c=0A=
>> +++ b/kernel/power/qos.c=0A=
>> @@ -708,16 +708,16 @@ s32 freq_qos_read_value(struct freq_constraints *q=
os,=0A=
>>   =0A=
>>   	return ret;=0A=
>>   }=0A=
>>   =0A=
>>   /**=0A=
>> - * freq_qos_apply - Add/modify/remove frequency QoS request.=0A=
>> + * _freq_qos_apply - Add/modify/remove frequency QoS request.=0A=
>>    * @req: Constraint request to apply.=0A=
>>    * @action: Action to perform (add/update/remove).=0A=
>>    * @value: Value to assign to the QoS request.=0A=
>>    */=0A=
>> -static int freq_qos_apply(struct freq_qos_request *req,=0A=
>> +int _freq_qos_apply(struct freq_qos_request *req,=0A=
>>   			  enum pm_qos_req_action action, s32 value)=0A=
>>   {=0A=
>>   	int ret;=0A=
>>   =0A=
>>   	switch(req->type) {=0A=
>> @@ -733,10 +733,11 @@ static int freq_qos_apply(struct freq_qos_request =
*req,=0A=
>>   		ret =3D -EINVAL;=0A=
>>   	}=0A=
>>   =0A=
>>   	return ret;=0A=
>>   }=0A=
>> +EXPORT_SYMBOL_GPL(_freq_qos_apply);=0A=
> =0A=
> The devuce PM QoS code is not modular, so this is not necessary.=0A=
> =0A=
> And so I wouldn't change the name of the function, just make it non-stati=
c=0A=
> and add its header to pm_qos.h.=0A=
=0A=
OK, and since the changes for exporting freq_qos_apply are so small I'll =
=0A=
just I'll just squash into the third patch.=0A=
=0A=
> =0A=
>>   =0A=
>>   /**=0A=
>>    * freq_qos_add_request - Insert new frequency QoS request into a give=
n list.=0A=
>>    * @qos: Constraints to update.=0A=
>>    * @req: Preallocated request object.=0A=
>> @@ -763,11 +764,11 @@ int freq_qos_add_request(struct freq_constraints *=
qos,=0A=
>>   		 "%s() called for active request\n", __func__))=0A=
>>   		return -EINVAL;=0A=
>>   =0A=
>>   	req->qos =3D qos;=0A=
>>   	req->type =3D type;=0A=
>> -	ret =3D freq_qos_apply(req, PM_QOS_ADD_REQ, value);=0A=
>> +	ret =3D _freq_qos_apply(req, PM_QOS_ADD_REQ, value);=0A=
>>   	if (ret < 0) {=0A=
>>   		req->qos =3D NULL;=0A=
>>   		req->type =3D 0;=0A=
>>   	}=0A=
>>   =0A=
>> @@ -796,11 +797,11 @@ int freq_qos_update_request(struct freq_qos_reques=
t *req, s32 new_value)=0A=
>>   		return -EINVAL;=0A=
>>   =0A=
>>   	if (req->pnode.prio =3D=3D new_value)=0A=
>>   		return 0;=0A=
>>   =0A=
>> -	return freq_qos_apply(req, PM_QOS_UPDATE_REQ, new_value);=0A=
>> +	return _freq_qos_apply(req, PM_QOS_UPDATE_REQ, new_value);=0A=
>>   }=0A=
>>   EXPORT_SYMBOL_GPL(freq_qos_update_request);=0A=
>>   =0A=
>>   /**=0A=
>>    * freq_qos_remove_request - Remove frequency QoS request from its lis=
t.=0A=
>> @@ -819,11 +820,11 @@ int freq_qos_remove_request(struct freq_qos_reques=
t *req)=0A=
>>   =0A=
>>   	if (WARN(!freq_qos_request_active(req),=0A=
>>   		 "%s() called for unknown object\n", __func__))=0A=
>>   		return -EINVAL;=0A=
>>   =0A=
>> -	return freq_qos_apply(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);=
=0A=
>> +	return _freq_qos_apply(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);=
=0A=
>>   }=0A=
>>   EXPORT_SYMBOL_GPL(freq_qos_remove_request);=0A=
>>   =0A=
>>   /**=0A=
>>    * freq_qos_add_notifier - Add frequency QoS change notifier.=0A=
>>=0A=
> =0A=
> =0A=
> =0A=
> =0A=
> =0A=
=0A=
