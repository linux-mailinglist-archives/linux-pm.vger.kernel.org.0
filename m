Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E5B231F17
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 15:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgG2NPP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 09:15:15 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:10894 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726391AbgG2NPO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jul 2020 09:15:14 -0400
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06TD9DL4009008;
        Wed, 29 Jul 2020 09:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=VPzqII41ZacM99I23RlDA8wKL3aOHiKh7LOJIzRciwQ=;
 b=oZLhWnp//YZ28EQJyTcmejbHrFdHXJN6uejKkcBbSedweYBqq0yoK6PgBSkjtSnrwLzv
 Ha43yCDiORHqhqB67gDIql/8ZK3qNoxHCPIVale8rngD9f1EMMmQjyrTMnjz+PiTbbpl
 QnytPhJODMD4HCcOCZaIl417p9Ciy1VL0Upn6dEDzQf2fEUTep7JDB0KDP6KsfyYFYrT
 P98XzIHIUFZvp8wsZj77X+PvdPDo6gLkq0fWZkFccz2M1aTIAWEj1bd1DUwbsp8e8+/9
 k/9JsT9cJWSzSX1f4N51VBzu4FHbRrcG4OVoTYl7f2gA7BPdRyiwnwPCmfUS5XTUOh4V 1Q== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 32juprjgdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jul 2020 09:15:01 -0400
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06TD7cjU008185;
        Wed, 29 Jul 2020 09:15:00 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by mx0b-00154901.pphosted.com with ESMTP id 32k9h90f8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jul 2020 09:15:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOI90Y82VJ4qJhtOccehmKe9Wp1dWrG4WmX5/RhheWsRatWKm5+XGO9kJmNXVDLtg9dv7aJLt/l6wLw6qdZRmxxVL8Re0J5EFcgJA8L0Qkn8eB4pEF+t+OvysPtfVhSs3/SdJwa34HrJNLyr2+2m8B4QiMuLAJ3FqPY+o6Uiakl6yXlhhHpxOHJoekz5IMFgF3fjrpcheEle+3DiRKIWN9qJCaYC3EAYBrA9G0Hp6DGed7kihf41HJXXKQ72JiU3HYTOVcVfo3I0rupkjHM0HCwMXJzwXyTVWDmFlDma/+q+JeJQAZ/cx0lagso3ev0DfLQX8wHZquIlbhc4hIItQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPzqII41ZacM99I23RlDA8wKL3aOHiKh7LOJIzRciwQ=;
 b=O3Z6PSSBxM6heYKesyOGvOodJjL9GrCjJHalvLSMUtDIVM6EHEGvQ7tVm5ISE8CFElpneRTLRqj7AHrSTyxTPB4XhvPx4ERvZIPUUovOxMaq+9TrxYSaNP3rTcRd1k016GSGqrk/UCXlzkK7Qf+QFSoE+bymVoodM6m69kpmANQqFjQ+c1vNjsYsVDCHbqL3JTK1HHSLNcmThvKv86phmAv8RbnyM9X7hKEmgLQbZMJb//AKj5gr6hqRUszGjlIBJ+04h22UZTgZEofJZHbp3mcFlS9uuTv9nVyvnELaSZkkV/ycBwv7gi4kDG80SlR0F54+dKou3POk9LQRNLO5lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPzqII41ZacM99I23RlDA8wKL3aOHiKh7LOJIzRciwQ=;
 b=GWJ86P6r1TuB6eY6FDHzAM8xiAzJA855xFP2zxaLxB50t/MIErzxJzBubhR39VmLksqIpeFXwn4JzBYWBzLhCM8b9K/DjKcBkFT5VgjN1w1btvISb96c+/bQgMERbyu4GEephQ9TRTEL9+/2+ijRoQjb8usTdCYtZg0yfb7dwFA=
Received: from DM6PR19MB2636.namprd19.prod.outlook.com (2603:10b6:5:15f::15)
 by DM6PR19MB3145.namprd19.prod.outlook.com (2603:10b6:5:19d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Wed, 29 Jul
 2020 13:14:58 +0000
Received: from DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::f1c7:5bf4:a3b:ff40]) by DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::f1c7:5bf4:a3b:ff40%6]) with mapi id 15.20.3195.033; Wed, 29 Jul 2020
 13:14:58 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@dell.com>
To:     Matthew Garrett <mjg59@srcf.ucam.org>,
        "Yuan, Perry" <Perry.Yuan@dell.com>
CC:     "sre@kernel.org" <sre@kernel.org>,
        "pali@kernel.org" <pali@kernel.org>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        "andy@infradead.org" <andy@infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH] platform/x86:dell-laptop:Add battery charging thresholds
 and charging mode switch.
Thread-Topic: [PATCH] platform/x86:dell-laptop:Add battery charging thresholds
 and charging mode switch.
Thread-Index: AQHWZXUdOYKvo1LGAUWLXWRX1rhPb6keKKMAgABge60=
Date:   Wed, 29 Jul 2020 13:14:58 +0000
Message-ID: <DM6PR19MB2636C2298994F284C62924CEFA700@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <20200729065424.12851-1-Perry_Yuan@Dell.com>,<20200729072756.46skroedpbo3fjyn@srcf.ucam.org>
In-Reply-To: <20200729072756.46skroedpbo3fjyn@srcf.ucam.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: srcf.ucam.org; dkim=none (message not signed)
 header.d=none;srcf.ucam.org; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [76.251.167.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25f80945-ca2a-4cb5-6b2a-08d833c164ff
x-ms-traffictypediagnostic: DM6PR19MB3145:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR19MB31453A7A7F76413FE807A03CFA700@DM6PR19MB3145.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: enrV/RE1+t5zyBlizCf+FP9dbCSPamhnuu26Pmjs5JM5DvnceP3FJe7mRA5zN0p6T8oEaJkDwHOwdHyIqBnEmz3yiTFa6SQhKVo/YHLq+LaJZZUvNZq+aDP71e0s6NqnqPtn9+BPxFQZagqzGtKMttAXoxgMaez5vDVwbzEiON2ijk2fYVEhNBFbUD8ZAUoGK+oOlgvH+gh/SLAc8XWG+ez/K7VNJnuS/Vg5MBjVAvCqWhVptv2p0Zc3sLDdAtoMDXiV/9c2+SfwZdO+MR2n5LaobWbBgVPF+NwtcHtXhLNvedr3bo5KsCCtK5FN6+/BO+5rXWhyWhEmJDDCHmrzDA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2636.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(366004)(396003)(346002)(376002)(39860400002)(6506007)(7696005)(186003)(66556008)(66446008)(66476007)(26005)(4326008)(2906002)(5660300002)(76116006)(64756008)(86362001)(66946007)(6636002)(8936002)(71200400001)(8676002)(33656002)(110136005)(52536014)(55016002)(54906003)(9686003)(786003)(316002)(478600001)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: zsLZt8XZuqIhJWPV9vIA0sNzOmbRg9l4pIyFj4L7g3auiO3xDTB4gpxoI0jzoRHKam+xft5UTzSH3yl+WQXQ7I7maJ73Q8zp9UUHizPgMf+gH6V0gsJR35ZrLW4U0zCLNzTTYbFYPCnJQ3qpP/7mJRyLvktVapMXKlbR+s7tQsYJ6bkpZhyhcg3F4H3HOAOF5Dzup1Jxq/yPHCNKkIFVsno1nSueNWhg1d4aBXBeriF8cuIuKM6T0lQh99QTcvb12GveAwAsyqG2l9weGMjgENw+Vjy3Y6yDEk/OyjOFoEbv0r/d8pVXktK5V/m5boSyWzUSv0sDz32Xfs+v7KWk83jy5dqF+KKZ0BVTeAA7S9Pwo6aWMFCRXjn8+l//V/Pp6x7e2Uc0mz7BBkXXWCvOkAC+ZtcP8zto1MAwV6W05Gs3XQiKCzEjabfpdbEPOqP+IsQzHsorOg/wq6ZsaB4N51A/1phFTnrCDCbmbshNY+5WhLH4rKfYRSE2QoNDLg9+
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB2636.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f80945-ca2a-4cb5-6b2a-08d833c164ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2020 13:14:58.7281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rxECYiZ884fx2W1AzBUu0OSYnZNewLGm53cqTcHko3gnENtbSLVUUH6VuQcRhaKHjiJrysJaWl4HQ5DpE6Awwum6b5n35rua7KtE2FwRZEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB3145
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-29_07:2020-07-29,2020-07-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 clxscore=1011 mlxscore=0 bulkscore=0 phishscore=0 adultscore=0
 mlxlogscore=818 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007290087
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=898 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007290087
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> The values here seem very Dell specific, but this is going into a =0A=
> generic sysfs path. Really stuff here should be as vendor independent as =
=0A=
> possible. If these values don't correspond to a wider industry =0A=
> specification it probably makes sense to make this something Dell =0A=
> specific.=0A=
=0A=
Worth pointing out that for wilco-ec they use this path:=0A=
Documentation/ABI/testing/sysfs-class-power-wilco=0A=
=0A=
So that could be something good to model off for v2.=
