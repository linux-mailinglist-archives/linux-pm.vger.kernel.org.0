Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 516271ACBD
	for <lists+linux-pm@lfdr.de>; Sun, 12 May 2019 17:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfELPVE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 May 2019 11:21:04 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:65485 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfELPVE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 May 2019 11:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1557674492; x=1589210492;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=p7EZ5tbxtTdiqhJVrKzJZ6BMMOQorDkccGgEo1rtjPg=;
  b=kWtMyvWcMNXry/7VpTXi8QGA/7yQ4slFKmpFeNEaUowQdEGd5G2Tzltp
   d0+p+Gg79Le+BKD/kfFSx5IzkrqfGgBq/yUCvGXkrBGcEi80eBG0J2h1L
   aypv1Hci9lbUzwoBIPHNPeFnjeDGjSzLhfSxhlPZeoPxbzwweszsHVvZi
   5uEh1EJDjaS50oCQArUfKjhlXJwzc9zGRKVaME7q96ZZNpgZCp+fv/mYR
   dQeBiSRGB1If2jy7T3l012zFZ9tyI9mJYVBkj01ZxOeekmxfy3xa7JmrU
   x1GuzrNP8WY+bnRGHN3pJGVPITx31uTsnu+RkF4AGmqzf9AQuFv7QlknW
   A==;
X-IronPort-AV: E=Sophos;i="5.60,462,1549900800"; 
   d="scan'208";a="207445866"
Received: from mail-sn1nam02lp2051.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.51])
  by ob1.hgst.iphmx.com with ESMTP; 12 May 2019 23:21:31 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rObSbto2H3ALHjpJ+Y/4MNSKfXrHRSRbVSqErB1GP6g=;
 b=B/n3epAmPdO/XOkbwRL6kPmP4cHR9PKR25/0t0BFs1lmnGRa6dQnv8yb3i3VD0ybdyEvbYzmmwU0580kUxo1iXunEmbd8/KbKJfHlhFePgbX/c+pnf54UQr3pm1ZI0321pJxcZXQb2ZcoZeRq9lNDc8yUNF4gwcfZ/Ru21FButE=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB5422.namprd04.prod.outlook.com (20.177.254.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.25; Sun, 12 May 2019 15:20:59 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974%5]) with mapi id 15.20.1878.024; Sun, 12 May 2019
 15:20:59 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Minwoo Im <minwoo.im.dev@gmail.com>
CC:     Sagi Grimberg <sagi@grimberg.me>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        linux-pm <linux-pm@vger.kernel.org>,
        Rafael Wysocki <rafael@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Keith Busch <keith.busch@intel.com>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        "hange-folder>?" <toggle-mailboxes@minwooim-desktop>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme/pci: Use host managed power state for suspend
Thread-Topic: [PATCH] nvme/pci: Use host managed power state for suspend
Thread-Index: AQHVB3hB+EEPM7nkIkW5pPdT52wd/g==
Date:   Sun, 12 May 2019 15:20:59 +0000
Message-ID: <SN6PR04MB45276B524D255F667A6BE29E860E0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190510212937.11661-1-keith.busch@intel.com>
 <SN6PR04MB452735778FD952AA838E78C9860E0@SN6PR04MB4527.namprd04.prod.outlook.com>
 <20190512143056.GA7761@minwooim-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [2605:e000:3e45:f500:f0c0:87f3:c23f:eddc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1222b068-5304-491a-b74d-08d6d6ed702a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB5422;
x-ms-traffictypediagnostic: SN6PR04MB5422:
x-ms-exchange-purlcount: 1
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB54228D748A084ED5B7DE30C9860E0@SN6PR04MB5422.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 0035B15214
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(39860400002)(366004)(396003)(189003)(199004)(68736007)(14454004)(74316002)(102836004)(186003)(9686003)(55016002)(6306002)(99286004)(486006)(76176011)(7696005)(478600001)(476003)(966005)(46003)(53546011)(6506007)(33656002)(446003)(54906003)(72206003)(7416002)(81166006)(81156014)(8676002)(2906002)(66476007)(66556008)(64756008)(66446008)(6916009)(66946007)(73956011)(91956017)(76116006)(6436002)(305945005)(229853002)(25786009)(6116002)(8936002)(7736002)(5660300002)(71200400001)(71190400001)(4326008)(53936002)(4744005)(6246003)(52536014)(86362001)(256004)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB5422;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4RDFrw4rH2UPodeWFWQ3YnDqgAWJcXj58XFyjehALnMynU8ddJ8RBia9PGWRrBnb8kGcxXEWJDVgI4PtciAMhYQexbQk7ePtEWzrlY5O4l3+lxUfZ7ebtbvQR7DUJdBUO32Ga0WSU2hwWPkS2J5SyjuVdzGE/DSazrnFo7qDGkYDL2Jj+cBL4fq/o/qYeUv8u+Cod1ZZCJWMCysggAobsKtykCLj4YKfO2Xo4HqV6sFjfw8ecIeHVUoIzZhsubO/pQrYuzPKyzAW6V615uTcYkMZJN0NFaYWN1AwvSS5RtJ6ogXgBRR6X2hBxbPQDMiTxOjwuX4zxzXNCEsp/Z0UjHsiYAx7/zPTeRlS8GqpzqsmroEr5eCCTSaOQeCe/oC6yh71goIvbfh5jF7D+wH9f7yxKS1iFKh86p/oU+U+owk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1222b068-5304-491a-b74d-08d6d6ed702a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2019 15:20:59.4783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5422
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Disregard my comment.=0A=
=0A=
On 5/12/19 7:31 AM, Minwoo Im wrote:=0A=
>>> +	union nvme_result res;=0A=
>>> +	int ret;=0A=
>>> +=0A=
>>> +	if (!result)=0A=
>>> +		return -EINVAL;=0A=
>>> +=0A=
>>> +	memset(&c, 0, sizeof(c));=0A=
>>> +	c.features.opcode =3D nvme_admin_get_features;=0A=
>>> +	c.features.fid =3D cpu_to_le32(NVME_FEAT_POWER_MGMT);=0A=
>>> +=0A=
>>> +	ret =3D __nvme_submit_sync_cmd(ctrl->admin_q, &c, &res,=0A=
>>> +			NULL, 0, 0, NVME_QID_ANY, 0, 0, false);=0A=
>>> +	if (ret >=3D 0)=0A=
>>> +		*result =3D le32_to_cpu(res.u32);=0A=
>> May be add a check for result here in above if before deref pointer :-=
=0A=
>> 	if (ret >=3D 0 && result)=0A=
>>=0A=
> 'result' already has been checked in a few lines above.=0A=
>=0A=
> _______________________________________________=0A=
> Linux-nvme mailing list=0A=
> Linux-nvme@lists.infradead.org=0A=
> http://lists.infradead.org/mailman/listinfo/linux-nvme=0A=
>=0A=
=0A=
