Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44502AE0E9
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 21:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgKJUpa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 15:45:30 -0500
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:17952 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726307AbgKJUp3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 15:45:29 -0500
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AAKdYQd028107;
        Tue, 10 Nov 2020 15:45:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=34EP+UBHJHvxbmZeHIfA+9Yw2YzW/peWO/nvuIJWrwE=;
 b=bsHSzj3fwe5idukvSWjmIzTplbVlqkvA9g66DQl4rT8dx+eeeEg4oEMiIJIjJ+i1UIi7
 PX7zX+VM70vaM4JAHBDIaHzR4dwG2rQ8HDC4O+/EIBuXljMHBecrMghOw7uxZEYXZwfO
 FkbRwDWasyHp51cg5BImqr8NcVLLtvLfeEI+yRs/ijxd7MszeLzmvnDXOVhL9HtZrxvC
 Hlrtpq+X7aMXnYTPklDtZXHZwyQEpF8NcjHLFkt18f6R7xRzOA53RoDbvCl8kiQ42lpG
 wkBNO2L7pg8WHC3ur0wVBZ3JWPCfanQtvZYho72cwRcvrG38jqXP2JRG9QPhT9gEVdl9 TQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 34nra28ygc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Nov 2020 15:45:19 -0500
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AAKgbT3161640;
        Tue, 10 Nov 2020 15:45:18 -0500
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by mx0b-00154901.pphosted.com with ESMTP id 34qndnx4fw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Nov 2020 15:45:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghDtd5C/JQYU0kgh/OZKAVmpwxHe2UQTPMoOxQrf0GGCHBPbigio3WXrG1TOO2IswimtgyrKgwJMC4X8N2w6vUQQSlKgsxGJN5ubf6jB1krpZQMFFUbbZvZn/QfDZgIdPVYecluAlpL/i7cY3vHunLY2NDituNF1pUNspPVw8orlPXpywvifEq3dFhupMQwUCcmdFXGZ1aquLPnB7yJW2sKF0oWOyQ5PGIcHCH87Totq9ttWbn/6n/c50b7JXF2V9EpACVgdsB0bbmb6O2UvTmgo6pfHPDDVLZAkutzowCq+NyA6kzcQl1qY7m690xjtH67W9AfJKpYry/9rIl6mJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34EP+UBHJHvxbmZeHIfA+9Yw2YzW/peWO/nvuIJWrwE=;
 b=Ay9Wg7hUMJbgQm7B04v7S5VNRpnZxIVasuA2nDU81gOWSCCv7goaExcYmxgXljqTKWSGA6C+BdIJFSf/M7e3bUHmZqJguGL1h1CNnbUArRgTkv3DR2DtxcIElk/ZL39tQ1z6WshL423ZCeWMH6QY8wBGxEZRQAarcduPM3Lm5fZjrQ0EvyFHOCjT/wlIL53ujhhvMStpQfVJehV2eFhvvkM0xfXGmaJbLD0LXxrfNjmkByuODnks9fL3Mu57Q7AX3AL8SKQgDVL2o/pYptRg5s8Cn7MF2yzr8f9rpfImYZpj49wiQxwvoQQLTwiBu456w2TihNv9kyBbHGehmrXC8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34EP+UBHJHvxbmZeHIfA+9Yw2YzW/peWO/nvuIJWrwE=;
 b=C7MOaAZPjgZ7sYuIPeliWQo9VdoTfSI/MjfItLjIZ+6CC8Ba8M5mG/Mt1tr8uG8Q5dwaCXJaUeTxAVNxY0XCTGHd2NUcwH3aCoMXqdgafEhUfaL2Ivhzsk+gkWLZO2+ohJ9FkV/Y+fOEOQHql4tPxCdTXYH7JfnKT8rE6znI9iQ=
Received: from DM6PR19MB2636.namprd19.prod.outlook.com (2603:10b6:5:15f::15)
 by DM5PR19MB1578.namprd19.prod.outlook.com (2603:10b6:3:150::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Tue, 10 Nov
 2020 20:45:17 +0000
Received: from DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a8ff:e803:ee80:e59a]) by DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a8ff:e803:ee80:e59a%3]) with mapi id 15.20.3499.032; Tue, 10 Nov 2020
 20:45:16 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@dell.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        Bastien Nocera <hadess@hadess.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: RE: How to enable auto-suspend by default
Thread-Topic: How to enable auto-suspend by default
Thread-Index: AQHWt1BE6l+LjsERUU+/FRV4X0h3ganBPDeAgABA9KCAAB8fAIAABiwwgAAFvoCAAAA7cIAAH9kAgAANhEA=
Date:   Tue, 10 Nov 2020 20:45:16 +0000
Message-ID: <DM6PR19MB26360A123E3BFA4741853AF5FAE90@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <fe8ab4cab3740afd261fa902f14ecae002a1122d.camel@hadess.net>
 <X6p6ubTOoMPUPPXi@kroah.com>
 <DM6PR19MB2636C94B56D5FBC0BD98A1B0FAE90@DM6PR19MB2636.namprd19.prod.outlook.com>
 <X6rLUDuG0N98jz18@kroah.com>
 <DM6PR19MB2636460E97BD5E47957BB43AFAE90@DM6PR19MB2636.namprd19.prod.outlook.com>
 <X6rVT6IXHYQpqjic@kroah.com>
 <DM6PR19MB263696FE5FA50F344B559488FAE90@DM6PR19MB2636.namprd19.prod.outlook.com>
 <20201110195536.GD2951190@mit.edu>
In-Reply-To: <20201110195536.GD2951190@mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-11-10T20:44:42.7665611Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=cbca08b8-6d4a-4b3b-a0a0-2f9a33f79bbb;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: mit.edu; dkim=none (message not signed)
 header.d=none;mit.edu; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [76.251.167.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a35f0a3-2a45-4d01-17bd-08d885b987de
x-ms-traffictypediagnostic: DM5PR19MB1578:
x-microsoft-antispam-prvs: <DM5PR19MB1578CD8A25049C1B0D2A46D7FAE90@DM5PR19MB1578.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3PC4odck1C2OiL3ZWik7ZAPA07cVn53us4ek0WnAYBAHXuogaE+UFdbS0MLLQKtsBV1upHFNVP2ohiLUw4qWDbUjfBpCPruvnv7mCddwzWagXdBH8lXVup2H6raMiUK+/hb0u0qw9tjSxU4z6LM4kCVFBcJo7Fgq81ou+Py1XFlgrTs0pv2OChRVpW1iM4L96IxSh56dhijDTmRJIZHegP7vCA040sQ8x+dXuAngVLCLouda8ScrF6+E/Qn9zshXw09esNnGZ7QJQOh/3kQvTbfyVmCNftxPuOrp0vnAhDLOj/+bodcKBh/+Q9uRQfKUceX3pzlzGHFeT6KcBvHFIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2636.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(366004)(396003)(376002)(2906002)(26005)(8936002)(6506007)(5660300002)(186003)(76116006)(7696005)(83380400001)(4744005)(86362001)(6916009)(71200400001)(8676002)(54906003)(66446008)(33656002)(9686003)(66476007)(55016002)(64756008)(316002)(66556008)(786003)(52536014)(66946007)(4326008)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: pGK/TphZR1GejyUts1jBDETPvaooxhH5wlaAqtXRiD3ey7gdiC2hBsQPVDCtwFQd7Jv+uw98Kq2QKzsPivvDiOVytDBTF3uKOe8tWN0ic0Qe5iifQPHoRbc4y5QhGVk48zdsgxwWYTI+1O0WJMrlRZptdr/IO7jJ0ZOVdFT7HkAmjDN18rsBFxmbRV6mEWNQ5ULKK4NtpUeFYYYx1VJ0qRnWlHev0iMoQjaN/Ve+eRP3LLv83CkoPRxma2Ny1H0grtfvtP1zGKEYgMv6MGE5D+RgKfB5OjYyszjyd3wEwc1dIO7KVyz/U7nQcRCA/GG0ck5Aw81dJaMNafL/utAM9CFFkjGQA9PCxLU2uEBZWcwbA9kwEBPgsQ3qo62EEVuZQkRteyQ/HhehUPZa/ftrkqmdghwrmdpbMEgOlt5LkRUzSbYPK4DBXsuD5BeRveJlQzKrRZj03HhFVLtOuAM22LrbLmU7ouYY2BZh2IKZbpNSK6IY98jgsbtHPR7hfswyWuuic1u2nyMAmYccLz9IDcRB6jL6Jg3S2wowZsDV8DUGbR93ZbdJYvkb8AsQuauJs5dEWXXBc3M8qNRKcEZL2vTNnFLQv6cbdHsIqnCFmgfDFSPPR7H7Jvmp1zUtg404FbDAasXsZSqqxDuJedEiAw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB2636.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a35f0a3-2a45-4d01-17bd-08d885b987de
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 20:45:16.6828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NFuCTxce6BtDDuoRbO5gjnbTwPOWjdNESXq//VfMiAHUUIbhK9Me21TNkHrwCda/DXfd9a/d2f559sDp8bYTdswivJXe6VhS1orabzcKZQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR19MB1578
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-10_07:2020-11-10,2020-11-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 mlxlogscore=776 bulkscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 clxscore=1011 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011100139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 mlxscore=0 malwarescore=0 phishscore=0 mlxlogscore=892 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011100139
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


> One note...  I'll double check, but on my XPS 13 9380, as I recall, I
> have to manually disable autosuspend on all of the XHCI controllers
> and internal hubs after running "powertop --auto-tune", or else any
> external mouse attached to said USB device will be dead to the world
> for 2-3 seconds if the autosuspend timeout has kicked in, which was
> ***super*** annoying.
>=20
> 						- Ted

Perhaps this was not XHCI controller in the system, but maybe external
one provided by ASMedia?  I've not heard anything similar for host system
yet.
