Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E790823B48D
	for <lists+linux-pm@lfdr.de>; Tue,  4 Aug 2020 07:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgHDFqu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Aug 2020 01:46:50 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:62008 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725917AbgHDFqu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Aug 2020 01:46:50 -0400
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0745kanD014028;
        Tue, 4 Aug 2020 01:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=jdfCQJvlE37IZb0mYqHCDoOr8VIm3U/hPskqwFfp9Sk=;
 b=VZWr4vGS1cvVOLDGYongT5feZLbbYMG0zLf7nwi+Cif6QisK3oSb40CV/WIGZyAKv5p6
 pakW891rBDUmBtBtgK+u7yrQfwYd+I+llz1433KHVZEWbDh8uEGl5R7yDjOYSoF8zvYs
 ygAWtCc2J+plqlMy0ta0hNQUdMrFRUtvn/baiSh5BkPbCOd4zznLRBhi1i5kR8XWq8bG
 btknNcV/0/+blAlGa13SJgjApA+J/J+Vlz13lVngbQ4+zJhP/quarTyer5UyQW1tzhcG
 0mpWX23luHFg8w8F5lKcYoRtfohV8g0IvrGjMlIacTmmo3IyvdE50pNzWNS004hc66zQ CQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 32n7smqdbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Aug 2020 01:46:36 -0400
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0745kHiU034097;
        Tue, 4 Aug 2020 01:46:33 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by mx0a-00154901.pphosted.com with ESMTP id 32pynv1c1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Aug 2020 01:46:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XueqZrBscgpFFhxMgYgoJHLZd88VThD6aCS78D+cyOmZcfDhtXBeJUNcTvznW9zhqi/EVh5qXZuEUIm5GNi0gMaO2ZfPg5jYAc2ce0jXRY47TChU7iySLEDpaMRMUQoAJSxyDnWS/g3IZLDNqOfpmqIb6OXDIHQPyuvppkOsYMqv+WYrHo2HbBJ2hLiWpiwRF8MnNN6s/a4jxhnekWZUEQy8g9ELeG0vYL5/hVMCw374MsX4HOntbgvtDS32rQQSt46O4C02XaipBhGTvfENskngXCS+/foJbWJaa7iTs048w8Woc67n9z1twkknDI+taTXJwHc74/sti68m+Fz3Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdfCQJvlE37IZb0mYqHCDoOr8VIm3U/hPskqwFfp9Sk=;
 b=ZlUtkwllsWXLRAhe87JArOGo5yhM1ODH6OjfbjviWzbyeD1Mp+FabYEysX1TNGJ3cgFVTJPXZnQgmO1YIjlgaUNZX57UlMbqafGcjZo850JdwIhv+o5vN3rT2bBuQ8q0EbpU3ODbj0aoX5fCaPhMhlCSKPebbj75yIdygThlI2g/M+Dvsa1gGaT5aT2h0A76MtQzYC31GZNPzl6xDEojTq36i39yWp0DHe7q0qfqGqwEzNdRE/H8mJs8Irb4UdrjQw9+TrWCOCi4sizivXqL4VY5iNoee2dIWTOpwiNlecBNohs+42NCxJMBYY2pl05Wnf6tD1DwlSva3pplbAtfRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdfCQJvlE37IZb0mYqHCDoOr8VIm3U/hPskqwFfp9Sk=;
 b=NPMH0NovkdyhGEn56UwnYcP7WibrmHJiGidsm7FuN/TniFXPFWbHYxzoH0n439a2Q0szACWfa7JmE2tTnRPO6MHR4l5/+dVnTwdfipFZs3X+8ygDpN9vZt3zW2yrJ824qGmaMOcJRCllq3XBq8OAoXr39IiAvPMTkPxbM8XPk4s=
Received: from SJ0PR19MB4528.namprd19.prod.outlook.com (2603:10b6:a03:28a::6)
 by BY5PR19MB3987.namprd19.prod.outlook.com (2603:10b6:a03:22a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15; Tue, 4 Aug
 2020 05:46:30 +0000
Received: from SJ0PR19MB4528.namprd19.prod.outlook.com
 ([fe80::35ee:af12:500e:9f13]) by SJ0PR19MB4528.namprd19.prod.outlook.com
 ([fe80::35ee:af12:500e:9f13%3]) with mapi id 15.20.3239.021; Tue, 4 Aug 2020
 05:46:30 +0000
From:   "Yuan, Perry" <Perry.Yuan@dell.com>
To:     kernel test robot <lkp@intel.com>,
        "sre@kernel.org" <sre@kernel.org>,
        "mjg59@srcf.ucam.org" <mjg59@srcf.ucam.org>,
        "pali@kernel.org" <pali@kernel.org>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        "andy@infradead.org" <andy@infradead.org>,
        "Limonciello, Mario" <Mario.Limonciello@dell.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: RE: [PATCH] platform/x86:dell-laptop:Add battery charging thresholds
 and charging mode switch.
Thread-Topic: [PATCH] platform/x86:dell-laptop:Add battery charging thresholds
 and charging mode switch.
Thread-Index: AQHWZXUdJDuKgVR3CEC9cdT9c1KUKakiuGuAgATBmqA=
Date:   Tue, 4 Aug 2020 05:46:30 +0000
Message-ID: <SJ0PR19MB45281A4375E622F69642B526844A0@SJ0PR19MB4528.namprd19.prod.outlook.com>
References: <20200729065424.12851-1-Perry_Yuan@Dell.com>
 <202008011345.5O4q2hta%lkp@intel.com>
In-Reply-To: <202008011345.5O4q2hta%lkp@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [101.80.141.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 273c500f-602f-497e-5f34-08d83839bd02
x-ms-traffictypediagnostic: BY5PR19MB3987:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR19MB39873155DEA1DDC8B2759022844A0@BY5PR19MB3987.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b2tsIhlY0SLMhMvcDSuajyNfxFQD+qfRoBlIP22nIGkBcCRmOWfDbPs1sD12h0D3DF128vBupkVZeWsdoeYRVYILNaDBndI0pTTHLkt+jA/gzidAUqLnWLV4we/yYIz/CLFLSQpgK4LB2lw/xnq+YjWAhDGQQTO2qjLYr5X4N2Bwx0awYk2598MkTYHtw4XJBdH81cg82/zKAedfVUBjHKQkMFygor26eMjc9XEMxpQ5c4FyZnIrN8fwrp/Z/z/egGmfJ6s4kZ0c9zw5JFqJNJH2epFqEwEno/VJt9SAKt9Qa6suw0YbKb3CQLshAH9hEgy+vo4AV5zdyIW/+bpKnRhiOs6aTRynGEcbX+EzTeJcH8+OWOMQ7e18Oby3LpeMbVLAcYV9JMXlgzQIL9jZ+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR19MB4528.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(6506007)(86362001)(33656002)(53546011)(4326008)(7696005)(8676002)(71200400001)(64756008)(66446008)(26005)(66946007)(186003)(66476007)(66556008)(8936002)(76116006)(54906003)(110136005)(6636002)(5660300002)(55016002)(966005)(9686003)(52536014)(2906002)(498600001)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: tawn+fA0cD7ePoNtNb5h24NsvlaOx+MC1oxtUeldKRU0015Z7C1zs4YI6SIfZQiHr4YZHEt1asw+gkNBG88wEn1w7h+nCQYsJdvHHKgNukmtamCUrjEyY0p77P93qnBAaJxm1iVxd0CCNPuSZiDWM9HNMkD9U2fjqCDBJOlc4AtOzwtd1cI+bVC/5UHkA8H6BZjsRwrcV1+9H8uHE7hhZ3Q9e+9dxKQpxTwbXE3PGepldVkZNLMrOPPZR11lHwMAkofhWnghdYFCpsq43t4bXr5h/mE0fWIasJSP7BQeL+yLS6oIIoJ3E7g4SmD32eM/thGmIO1EEgCtmeMfAGXceTg4KuHH45c7UVDKdUWawGju3anpz6NdnFrTUO3fx0+bDh/5Wu57wPFCLHdIjfUC13JE4LhGCqzh6cY2joIfJkFnjS4TbvQfL580IgtBx1mYqKEL/pwmKALol8Nn8w/YcY2TGrzg6OZEFc+fTAXO/JADheDkiVldbkzgKoNjVcCVENqrQs7+ZRm27yLrF3ymB9BsmzzLqexzhgrr+QgLlj+ilGhQAz9YWBKAYw4aVzVK981jQRZEtU2Oh2JWs9846a/2Jp4DepHsGbsxl/qS2x36hmYb+NZLYo7E+TTwO+c4MR77OW6vCW9aRVDAAWXEFg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4528.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 273c500f-602f-497e-5f34-08d83839bd02
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2020 05:46:30.6672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ArZohoXrm5pBgvS5eyQHOIv0P3UP1CJB+gGeJj0W28F/tyTXjbREJe01zg12g7sj2WkElRQ2as8+3KEMGARVqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR19MB3987
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-04_02:2020-08-03,2020-08-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1011
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008040042
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008040043
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> From: kernel test robot <lkp@intel.com>
> Sent: Saturday, August 1, 2020 1:08 PM
> To: Yuan, Perry; sre@kernel.org; mjg59@srcf.ucam.org; pali@kernel.org;
> dvhart@infradead.org; andy@infradead.org; Limonciello, Mario
> Cc: kbuild-all@lists.01.org; linux-pm@vger.kernel.org; linux-
> kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org; Yuan, Perry
> Subject: Re: [PATCH] platform/x86:dell-laptop:Add battery charging thresh=
olds
> and charging mode switch.
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> Hi Perry,
>=20
> Thank you for the patch! Yet something to improve:
>=20
> [auto build test ERROR on power-supply/for-next] [also build test ERROR o=
n
> linux/master linus/master v5.8-rc7 next-20200731] [If your patch is appli=
ed to
> the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>=20
> url:    https://github.com/0day-ci/linux/commits/Perry-Yuan/platform-x86-
> dell-laptop-Add-battery-charging-thresholds-and-charging-mode-
> switch/20200729-150347
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-
> supply.git for-next
> config: i386-randconfig-a005-20200731 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-14) 9.3.0
> reproduce (this is a W=3D1 build):
>         # save the attached .config to linux build tree
>         make W=3D1 ARCH=3Di386
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>=20
> >> ERROR: modpost: "battery_hook_unregister" [drivers/platform/x86/dell-
> laptop.ko] undefined!
> >> ERROR: modpost: "battery_hook_register" [drivers/platform/x86/dell-
> laptop.ko] undefined!
>=20
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

It is not patch issue, the kernel config needs to add  "CONFIG_ACPI_BATTERY=
=3Dy"
