Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84F5364EA6
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 01:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhDSXdw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Apr 2021 19:33:52 -0400
Received: from mail-dm6nam10on2133.outbound.protection.outlook.com ([40.107.93.133]:27661
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229842AbhDSXdw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 19 Apr 2021 19:33:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NG8zL8/VWUnvrbXrII2mAqMUDcUJ6v2WAPbBzTLeCPjNc+4GUJoSLttyhKz8j72qllZrIZi64x0Ga0WVhlm6qUju8NXRfnvA6Qgp7QS8/7rLvn5/APACWm48/16IsQB185eiMibFmXvqyjqONZfLtgwi/DfIY9tbkHGWVi1pv4o1Cf1qT+fPi83KhmgUnRbyLdGjxWFpmGCa/d1jI0Th+lO8GCjOWV7ezi6mOGcgonTsL8Xr9+x21TUvXS9UTOpe2iq3Xc6BZ8IgZKrhx9R9n1GBdV30B45ZmgqhD5JqxzNyi8GMX3F1opqMylmfPFGrIaVLaF2oLyFF9S4G9Vo6xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZnmgKgsUPF1TW5fBYw01D0Ln0dTFiC8e/DIYXuNWDg=;
 b=H+SDQYjGxsEz7VjolJX4FLcoIq1WeLpja1wpQQ6xyK8a1yPpzz2hlX+9KSJaf8LxCTriV+/CefnstDn5RXtxRifnrSjAD/CjDPI77EDr3glmIgI+NIway2fD37eNvtvnOMzo1vfO0OJh6SebJIhh9pwCqe7SGghuWBREtkfbTclikyCD4yYNwlk2Eysk5/3m4m+ajC5tKKyHIz7eFIdL+hWIuRjvU/lV9Tq+8gmGS6xIVmSv4M/fq/ylBSEvUCepVK1qu6qjKOWaC/Mi8Gt13Q3Ga+VJgChI5N/xVIGbG9Aec3XyVXmmBMibpupcKzDV3FY0wtvu3/0jQ6SQ6rjYcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZnmgKgsUPF1TW5fBYw01D0Ln0dTFiC8e/DIYXuNWDg=;
 b=bHvQwUWH2lxfyAnjpHiR8CPib11b4VsPBHkptl7OhMIklArC6wWBOWj9V2060QFkK275oW2YCuxwG9GaqHx0nhb7ZJ2JZIjfzalVmRz3CkRM4jPHBgQZOJGGSZDZ/l06QnaM2LSW7MNg8RVK55BodfXVeh1/g4ZcJVzbUtAgimw=
Received: from MW2PR2101MB0892.namprd21.prod.outlook.com
 (2603:10b6:302:10::24) by MWHPR21MB0509.namprd21.prod.outlook.com
 (2603:10b6:300:df::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.3; Mon, 19 Apr
 2021 23:33:20 +0000
Received: from MW2PR2101MB0892.namprd21.prod.outlook.com
 ([fe80::5548:cbd8:43cd:aa3d]) by MW2PR2101MB0892.namprd21.prod.outlook.com
 ([fe80::5548:cbd8:43cd:aa3d%6]) with mapi id 15.20.4065.008; Mon, 19 Apr 2021
 23:33:20 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Chris von Recklinghausen <crecklin@redhat.com>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "simo@redhat.com" <simo@redhat.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1 v9] use crc32 instead of md5 for hibernation e820
 integrity check
Thread-Topic: [PATCH 1/1 v9] use crc32 instead of md5 for hibernation e820
 integrity check
Thread-Index: AQHXMsLQEFNBplk1gUCriYRgK68igaq8gdKQ
Date:   Mon, 19 Apr 2021 23:33:20 +0000
Message-ID: <MW2PR2101MB08921161444D6D2683660853BF499@MW2PR2101MB0892.namprd21.prod.outlook.com>
References: <20210416131655.22112-1-crecklin@redhat.com>
In-Reply-To: <20210416131655.22112-1-crecklin@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5f89ab86-89f9-4b34-a297-d2ab36fe37e3;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-04-19T23:28:15Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:600:8b00:6b90:95e3:c5e8:10c:f48f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 849bec70-243b-4039-062c-08d9038b842e
x-ms-traffictypediagnostic: MWHPR21MB0509:
x-microsoft-antispam-prvs: <MWHPR21MB05099FC9601C6C1645C3E9CABF499@MWHPR21MB0509.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R5vpvj+dH8bVaVYRM9jY2qqOYA5A8sKPOSNp73XnlJmb7YtgKUbNZDD0tcsgRe+omOU+DCG2OSSED8n7Enz5iyZiAVb4BeuU32duqzSn/SNY0xFSKzimWZq6mstXbhby1OgA44twnIXNxaaF+G6O4ompneR8frKLP5zrpKZGWlxUNnfQsX3aM93HPA0bqoqg7qGjxd2xn8UWE6EJTqBNoG4QC9VdjQOF7OQldF3DH+8AlIikY6k/btYsysrXjsfUSzhAGR36kN2+cMYUuv+qqaEmJJ4y+SvKEdYmVtKEU/jkihsOKHWL5Ukh6+g+DCTpTHfDvy6IUHeb+PWrbx3ulYbctvVpOWoWIJR59mYKrqI6/yiUwNQJ7IZ9J0WO5TaSGLryR6kr4+ZyvoYKa2lx2aQx4HblKYBTy396hs+y8B7D+BYM3WcTIYsM7uT+WjsrQR7H3yyXQ7T+8aXtK4Z0lSdApCg6QhaGbmvxrhgaosyQXUbiWpgbdYN1UP1mZeJB8zd8s4spWHP+m9HUJUXW0XlJZCqFbtAQMfwUZq9cryos9QI8DdhXIn2uZK3KaDHlRQ3+UHUhRhK89Qtmv5ECeE3Q0gSDBX1u1yKc4EBewPk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB0892.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(8676002)(55016002)(76116006)(316002)(64756008)(9686003)(478600001)(86362001)(66946007)(5660300002)(66446008)(52536014)(10290500003)(83380400001)(122000001)(110136005)(66476007)(66556008)(38100700002)(82960400001)(33656002)(82950400001)(8936002)(71200400001)(7696005)(8990500004)(6506007)(4744005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?sQ3K97TBSnPBUnz4WqZN6wf+6NVq5QzewUhj7pWrTUXNl41B3kFFH4Aqnz23?=
 =?us-ascii?Q?HYM0kvOFA04WR/TgdEYOWdQ488BRMPS0kx2z9JQdvpaBrRr6DzW92xnxoIRl?=
 =?us-ascii?Q?JWZO9Nt/OY+EnXDKJleStNHYrmSsuZ9axClG7vvlu6SyOKlqHotYig+F9TLb?=
 =?us-ascii?Q?rSn5fZ9ai/WPhmW8IRL8cy5A+cIDe4eZvb2DX14NenxYsSVS2YKz0Qso0rSn?=
 =?us-ascii?Q?aGgTK8wbTZoXZ/CsnuZr3L8rJL3XmTuN5rxk7Dl+Wn+jdEEYoG+gxXjgFt1G?=
 =?us-ascii?Q?w9tDekqvWTxybtnNNDwo9HSlQLMPlzK5H8oNhSfrzEDFKERwFIjZl/HJpSIC?=
 =?us-ascii?Q?P1PaRXy0ItbB69LZmGIoRX04WFKkAftnm7lJzyKQQjTbpCgYr4PxIDNHBcd6?=
 =?us-ascii?Q?WMtUPrbpqKqY+dvnIp1KnUaGHWKx+eJ1FZn7RAZhsQyzPnJL4dRd7S0RcXt1?=
 =?us-ascii?Q?Lk88mB34hBXmehNL+r5x8Cdb8WgpSxIUSHHdTHuzAVv9SrWHfS4yKExukfhB?=
 =?us-ascii?Q?jrEcyT4KU3qpNRnyz+1BOAxrJhRlnB29UTZ2UnopMwK5DL49rZQ8AHP9z47N?=
 =?us-ascii?Q?zMrJQQv4xcS9cvr3Y/6N9wdlbk/bnfeJuU0pD2UMdGdgrpPuv6K9d3VWmBAA?=
 =?us-ascii?Q?H7A7xOF9VovNe2SFDiiwosb/AFBhkSHpbCy1lOTAChlSVC6/SKGWvT9ZQu/q?=
 =?us-ascii?Q?L6fAVeh9ied5Pu+2dNMXZBkbt+pOnHUFGALfJYXM1o9EQJPFlz1GCMdFnt+M?=
 =?us-ascii?Q?FTfuTLNvAKPtC4ex204kg6+qKJYgJBHc6XoskS0wmTpjNjgRdaA6+vmqXYHj?=
 =?us-ascii?Q?qvXI9KhUjTTTlSmqddKELSFH5r2zCzmHv9xUfdPNQRKj88DARTpOjRPjEdeN?=
 =?us-ascii?Q?W14vz+mEc2aKBHGXo19nPqgRavcXYXOsQ1/eVOrDNJJ0FoGO1fc4vwNmTyKm?=
 =?us-ascii?Q?2uJcfwG12jw1BMgp+QoLfv1oUs5NRqAO2uLXQtdr+xzsxYaraUC2xEy/MpM2?=
 =?us-ascii?Q?KMgBkppp1OcVNMQ1Ca+ywnHDcReAgA2N3wnOQkZCOzn3HV2BczzEBzhOaOZ2?=
 =?us-ascii?Q?UV6Vd4gHL5a+oARqGDQkjcPRkDmiAaG5K2LuUzxAIedCAp+V4T1grD3lAfL0?=
 =?us-ascii?Q?Wt7PIWC5WB95iLElR//nmo83Fwo4+x1Hnv3siMVJEG9rY+I19o9XBVDyPEDs?=
 =?us-ascii?Q?oMGqRqitCbgzgg/DgrNEwddo1mEICzTU4WWmYk1MHGvToyGlT9Xs4Gzhqkpm?=
 =?us-ascii?Q?7nu+jR1pKqeMJjBdwVaHYihjj1vgQ+NA4D+S6L1H5q31nswkudxTfYs8Brmr?=
 =?us-ascii?Q?/JDO0J7Kr9mIrjNfvFXbGT+G7tFIBs5ebVo9GT862qVUke/YwPHNPB39tHWt?=
 =?us-ascii?Q?3TVrtxyKBma9171stRT4d5FL8d5e?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB0892.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 849bec70-243b-4039-062c-08d9038b842e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 23:33:20.1202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bldAepIy+5iBMp7dBNK0w113CD4mcDMqpQgUrCOmdrsLE42/6mWxPTeeepw60m7OmHLnDdyQfB+O0LepV4yUFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0509
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> From: Chris von Recklinghausen <crecklin@redhat.com>
> Sent: Friday, April 16, 2021 6:17 AM
>  ...
> Hibernation fails on a system in fips mode because md5 is used for the e8=
20
> integrity check and is not available. Use crc32 instead.
>=20
> The check is intended to detect whether the E820 memory map provided
> by the firmware after cold boot unexpectedly differs from the one that
> was in use when the hibernation image was created. In this case, the
> hibernation image cannot be restored, as it may cover memory regions
> that are no longer available to the OS.
>=20
> A non-cryptographic checksum such as CRC-32 is sufficient to detect such
> inadvertent deviations.
>=20
> Fixes: 62a03defeabd ("PM / hibernate: Verify the consistent of e820 memor=
y
> map
>        by md5 digest")
>=20
> Signed-off-by: Chris von Recklinghausen <crecklin@redhat.com>
> ---

Tested-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Dexuan Cui <decui@microsoft.com>

Thanks Chris and all for the patch!
