Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAAEB56A7
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2019 22:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfIQUHQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Sep 2019 16:07:16 -0400
Received: from mail-eopbgr10074.outbound.protection.outlook.com ([40.107.1.74]:62475
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726523AbfIQUHQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 17 Sep 2019 16:07:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQIOqHFInF8xEgyPho/UD8X47msaD79QdgdNsrmf11NHd8T5gQUi4QcuEWeDCao8BzSpYCCiJKExl3FAdYHweuByQFxGNVYUtOI4PdmXzpniHucHkVXWAiQ1RIDXlqgkuD/7nIHSwpyjMWLhPDtM6KO/H8lis79WP8sc5exwxX1nYbuwNy/L6AqRLuxTnOJNQBt7IAkwLV2Eap2n5HUWblUCUCsww+IvCkXoUWceQTI4A1XanB+HS7PFfusqzedX1dGhc0zMYbbAI1qYI1LRTFGv2HZd8qoT5Gv6lYiMPf89a5OceBkeyM+FS4RpXaCoIogAvs9TdH2dFn1qNh8JKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnAyjC3Aob1yhpFk02csDqSG/+w7mX1MaNs1jwVzHjQ=;
 b=P5uObUmQ2sVlXqls1R/QZN1nmLCnEYGgCWGmlLwFPtL01ya2DoxYr4Qna7jjb+bTEibQ8aqioeXIoTkwA/f3aGEa/BfZyJJS6/sU2CcN3pRwNzM3xBwFLKy+Yvtj6wb/T6pdZKFRp0+L8hnIx2ysQdhFAQhJRzhb3GGza2rReXscpF3yvqE+LxVVS5p9AjAiNhtqpNfwtOcCinzr+mkXLRy+4i7KhmwHTKgN3nyQlzgV5Z8Lau4ClqZRouIVU1qKi7D+jxoQPV4kluU9vdREDSJmCBXtZxxJqnf62bg3g+5L1uZVG3J7C3csdXGEEz7bab4qfX/D43E9UoNIhMCX6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnAyjC3Aob1yhpFk02csDqSG/+w7mX1MaNs1jwVzHjQ=;
 b=VNds1ZzAih133BfooedxLtRfJycx/bTrhHLCLUb716l7cPKjp2zGkB8nQJTZFXIG5bPw/Rz4XVfSpqBbi8hJheBACF7KxbvNvY7mAnhgK7eeb40/biold+9EpwhJJE/y10cL45dLkCCVvJCfGKJKwKj8Jm78azIaBOo8UDc6TFA=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB6941.eurprd04.prod.outlook.com (52.133.246.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.20; Tue, 17 Sep 2019 20:07:12 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::c5e8:90f8:da97:947e]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::c5e8:90f8:da97:947e%3]) with mapi id 15.20.2263.023; Tue, 17 Sep 2019
 20:07:12 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v4 1/6] PM / devfreq: Don't take lock in
 devfreq_add_device
Thread-Topic: [PATCH v4 1/6] PM / devfreq: Don't take lock in
 devfreq_add_device
Thread-Index: AQHVbRUAgHQh/XUwK0KEOpn0GYjB8w==
Date:   Tue, 17 Sep 2019 20:07:12 +0000
Message-ID: <VI1PR04MB7023542CDF1707E04E7938BAEE8F0@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <CGME20190917050135epcms1p15ba77f52d2a34db0236fd81107dba07f@epcms1p1>
 <20190917050135epcms1p15ba77f52d2a34db0236fd81107dba07f@epcms1p1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [82.144.34.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3fa435a2-93db-4c6d-3bcb-08d73baaa0a2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR04MB6941;
x-ms-traffictypediagnostic: VI1PR04MB6941:
x-microsoft-antispam-prvs: <VI1PR04MB6941F3D6B586BA03003D641DEE8F0@VI1PR04MB6941.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01630974C0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(199004)(189003)(53546011)(446003)(476003)(52536014)(305945005)(2906002)(8676002)(102836004)(186003)(6116002)(81166006)(256004)(66446008)(66946007)(76116006)(14444005)(64756008)(66556008)(66476007)(6916009)(14454004)(5640700003)(478600001)(6436002)(81156014)(71190400001)(3846002)(229853002)(8936002)(71200400001)(33656002)(44832011)(25786009)(7736002)(86362001)(54906003)(26005)(6506007)(74316002)(6246003)(76176011)(55016002)(4326008)(2351001)(91956017)(7696005)(316002)(5660300002)(486006)(99286004)(9686003)(66066001)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6941;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: msMyOFFwXc9ZzXG7rQDVUkOaogQXBPF6kS4dxqfbp99/7DVjmGrycPikDFIBtGWY6iJKsmzFuNfP8ef/ZkbTP05CGwkbZhncDg2DxGbYs2M9fpY1UxcyTkIgnl3Dx3HLfyQQzmCN13hzLuE91hM2pRxaY3F1a/WppFHO9IsbfCpfKbaEPRLDZ/2QXp8YYZLf7NpcCQ6nFvTJ6JHT+cIQG9UQlYdtCXeb7d8jxHNfsHB+k3/dD/yw+MCeRiDFeuz95HRXpQDHrq1GNURt/yLf8ysPjI+Am9SB3Rf2RYW9MwJIBAiowjCTD0rQRSRPOUqI1GugAwMsuOkK1CfKyDu85Z9Mfac8sUwT2Ly72Z1niDMwHvD+IujWBKww/QWjb/d757OtUxmcaZt0j9n8VRkkfJaaQKha5ocBpncQK5HrSnk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fa435a2-93db-4c6d-3bcb-08d73baaa0a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2019 20:07:12.0379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: meEmwYdqHOCmI2EmrNfEllTlQ5XQs2LtXJb5favkBju6ja7ZNgt4NF19MwOYz2qIqFci4/asBaBSQpw10Tm8yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6941
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019-09-17 8:01 AM, MyungJoo Ham wrote:=0A=
>> A device usually doesn't need to lock itself during initialization=0A=
>> because it is not yet reachable from other threads.=0A=
>>=0A=
>> This simplifies the code and helps avoid recursive lock warnings.=0A=
>>=0A=
>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
>> ---=0A=
> =0A=
> =0A=
> =0A=
>  From the line of=0A=
> =0A=
>> err =3D device_register(&devfreq->dev);=0A=
> =0A=
> Other threads may access the protected values.=0A=
> Thus, if there are recursive lock warnings, we need to resolve it without=
 eliminating lock usages.=0A=
=0A=
The following fields are initialized after device_register:=0A=
   * trans_table=0A=
   * time_in_stable=0A=
   * last_stat_updated=0A=
   * transition_notifier_list=0A=
=0A=
The transition_notifier_list initialization could be easily moved higher.=
=0A=
=0A=
The rest are for transition statistics and in theory if a transition =0A=
happens his early (how?) or trans_stat_show is called then something bad =
=0A=
could happen. It seems that trans_stat_show doesn't even take =0A=
devfreq->lock anyway?=0A=
=0A=
The code allocating transition stats could be moved higher by dropping =0A=
devm usage or spliting device_register into device_initialize and =0A=
device_add (but that's more complicated).=0A=
=0A=
Further on the governor is initialized and started after device =0A=
registration but (even before my change). This seems fine, a NULL =0A=
governor is explicitly checked against in various update functions.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
