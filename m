Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C2823B4B4
	for <lists+linux-pm@lfdr.de>; Tue,  4 Aug 2020 07:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbgHDF6B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Aug 2020 01:58:01 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:65290 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726514AbgHDF6B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Aug 2020 01:58:01 -0400
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0745vLOf023730;
        Tue, 4 Aug 2020 01:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=lTlyhEpdiQJocqUxalWtg8DPV2A3bUym/ZFs61HcPZQ=;
 b=GExOgq4/4CzaTiOTHovdTztuXDLRmPEqvsc4BK3ViD8jLo24wxyLquVMYWBl2MjzQ2vR
 1tjTL0H+xfXiEBssBn2+r4udcaSgkOYyojjbi8EmRoZbVvJKrQL0T9fWCTvxDSCA1A/J
 eU3CcYs1X5NatgeOCVDgOLRSh1L8ERCji9Z6m1dtzbQveo9UDdm3RWjF/7yKexfD7/ED
 GSOpm2CuMPMe8y5E8FO+Zezvh6bqLXGWfPXAVMUJRN4VBnzFoXTex9DLN06plTohwqy5
 Y5ULi4myCeZDEaK7yp8rsY7tMfRrEkfo+wU65EXRa1f17paBixzgKtKYaZonNMywOcyv +g== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 32n7svqfbu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Aug 2020 01:57:52 -0400
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0745sRxi053999;
        Tue, 4 Aug 2020 01:57:51 -0400
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2058.outbound.protection.outlook.com [104.47.38.58])
        by mx0b-00154901.pphosted.com with ESMTP id 32q0jps2xa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Aug 2020 01:57:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUKL0tyCCKxtDUssZvr0Y48t4tdTen0+2xkqwSh/vlfXxnSq8UkUwWhZIo/Absy+Ih0cfoYze6UjySLoqkrvSBUBNcJrt2dlZ8QSaidUFFQCtAtdM2rCE0GFJ7XyHQc+mBKcboLSKS3Pf+BlJt7wOOJx0MVQCxrt/hEtb46L7eGtYaxI9DBZj0E5Wt29g8bZ1PGJziVEz8B6/Be58z5xqQyAWz002bAqlaEecTsRKD1xvnuAqDiBBj29j/EriNEpHS9eLd/8SLXjOG1K/Wv5nblkd1Q3ycicCC/4nDwFsMxWO88GXhYaVLcSR/7fvjhgWprXIT7WpKusm0Xz2HtO8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTlyhEpdiQJocqUxalWtg8DPV2A3bUym/ZFs61HcPZQ=;
 b=YIXrlJS8xfBe9//Ml58WzXoIxa7Uo5Fb0gw75YQ0MTnByq+ZcAuK32KUWcaF0AwcY2ZupJDjuyReRyyZCIjQ3fYhpEGfLVclNWI82kYxYhz+SIAnDZtUAZ9NO/L5LpHEKVDdCs1VFE+SGoFJCK4+ta6UMJE61OuQkL/llzbHmLGAC27u+uVWBMyGhZXG2cdiaITzvPGN1RFTIdGhCZ3cIjHJU177sA9WXPNCCr373cPWN8fxMGwuheRiOwv6HkQCNOOwcZg3zi83eWXJOn8dDa95d2xhiKTakCvQ+Nr7VTxBCjiHZAf1bqgvJDVj9wNseqrqmCI6WwBzItB51o+HkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTlyhEpdiQJocqUxalWtg8DPV2A3bUym/ZFs61HcPZQ=;
 b=IcfUXCtXiV2SFLEFUK23dU/eypMNr2L7FpjQwjCfilMPQ8BaC2OQ1IoP4MX9oJbuYLG2Zh4EW/S9S2RPDeIAbGraCMA+Kcku/Pt57mvViRZbwbo8CY4TnLCb9UkkCQwH1Uu1tZZmXTvwp60vGlC9R+6oHFQzzqefx5yJdClUyyg=
Received: from SJ0PR19MB4528.namprd19.prod.outlook.com (2603:10b6:a03:28a::6)
 by BY5PR19MB3796.namprd19.prod.outlook.com (2603:10b6:a03:221::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15; Tue, 4 Aug
 2020 05:57:50 +0000
Received: from SJ0PR19MB4528.namprd19.prod.outlook.com
 ([fe80::35ee:af12:500e:9f13]) by SJ0PR19MB4528.namprd19.prod.outlook.com
 ([fe80::35ee:af12:500e:9f13%3]) with mapi id 15.20.3239.021; Tue, 4 Aug 2020
 05:57:50 +0000
From:   "Yuan, Perry" <Perry.Yuan@dell.com>
To:     Matthew Garrett <mjg59@srcf.ucam.org>
CC:     kernel test robot <lkp@intel.com>,
        "sre@kernel.org" <sre@kernel.org>,
        "pali@kernel.org" <pali@kernel.org>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        "andy@infradead.org" <andy@infradead.org>,
        "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: RE: [PATCH] platform/x86:dell-laptop:Add battery charging thresholds
 and charging mode switch.
Thread-Topic: [PATCH] platform/x86:dell-laptop:Add battery charging thresholds
 and charging mode switch.
Thread-Index: AQHWZXUdJDuKgVR3CEC9cdT9c1KUKakiuGuAgATBmqCAAAJJgIAAAJkw
Date:   Tue, 4 Aug 2020 05:57:50 +0000
Message-ID: <SJ0PR19MB452858C9D87E62F5D5592703844A0@SJ0PR19MB4528.namprd19.prod.outlook.com>
References: <20200729065424.12851-1-Perry_Yuan@Dell.com>
 <202008011345.5O4q2hta%lkp@intel.com>
 <SJ0PR19MB45281A4375E622F69642B526844A0@SJ0PR19MB4528.namprd19.prod.outlook.com>
 <20200804055343.mmkypi272sgfx6al@srcf.ucam.org>
In-Reply-To: <20200804055343.mmkypi272sgfx6al@srcf.ucam.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: srcf.ucam.org; dkim=none (message not signed)
 header.d=none;srcf.ucam.org; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [101.80.141.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 209103cc-0f1a-49ba-077a-08d8383b5244
x-ms-traffictypediagnostic: BY5PR19MB3796:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR19MB37964E25D56511E145C4E656844A0@BY5PR19MB3796.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1cLli/3NdzoaxxaPSJrkzdtYurqMjjQBIIE91CzZt4+0OumxOx2babrigKKLBwTSEUbVMo5kys3PjHTlSGkmyBgt/sxYh3dLzQ3K/pmplyDowcv9DUg1HEhByLkI//IgNOAoYUA2EdZdHPhR9CSXwBv1UHV8Ry6vYpnbZhLI5D5hXCaJGNRxgAni3oWIpgn/O83FWHzyw/OsFLf0CwUIx0xViAIJgwTJZtOOzSir4nqs/pJTw36DcBNYucYanePdVTHOmQPkFxwF8p8SFdH0zKm/rcE+1MIp5c74RFbHcDoIC0hk++m3RzxxjTsxukHF5J9RigzU5Scus9nzVivU+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR19MB4528.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(39860400002)(396003)(346002)(376002)(136003)(8936002)(55016002)(7416002)(26005)(9686003)(33656002)(478600001)(71200400001)(4744005)(4326008)(53546011)(8676002)(186003)(5660300002)(6506007)(6916009)(52536014)(66446008)(66556008)(66476007)(76116006)(66946007)(786003)(64756008)(86362001)(316002)(7696005)(2906002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: QE+41VWV541DZFQb8IqK/7DQi1mxkqr0R1Kh0EDXCWYUHpvkUMn/HKYSqiR7qRK2qjo9zvSe8j7kdMEZf0D+U4Ss1rIvdNXuEJoCIpdzoZE0PxFw0lJY2RYNGi0BhKfUbofDFYdiCDfL9Kn3UYBmwqC6RvmtwzHdtwaSgAS21Xy8Ib9QmDz67iQZ772wrJkSz7OylPhj43nIIDv0XIwVgKMVvH3+dsExdlEm2prM0JsDEgkcrEQ9ckP1XNpNbEsHIpkcPcI9i5kXNQmJq+ffvq+UWIx4ji08iaKS7zKQuG+xj6NF95V+Bsvm9xEAIHMCmqapyQZzNwil/j++eUN7mMtOeSEwN0EM6jTA9ZaCKNPY7p6yfpCNh6MHfzNdSGhsuLp1zYJoXOcD24gjbKgU8dvgu4vCwdM16iJwip6A13aFEhaAkfeXlD9iqJ7l0W3WC8gl1NeBDGXXjN/7aRkSkAre7eo4GWGNINkf+4pbNsdAfQ+1nxLlJwI0YR8ZKummqvdbJNSRVgibBFP+VOB0/b1HtaP2ArjhH/mAQUMDbjInPEPX/ED20YfS3KosF219WgkUsQ7j2lmw1yheZ/a4M+Q41rqv6JtgpcrKFLwXdKhRDVI5bygP0H+pttt4WLkwFEqV6NdOTHstpC6IG5/67A==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4528.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 209103cc-0f1a-49ba-077a-08d8383b5244
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2020 05:57:50.5827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T1N8du987Y5Be5GuXLot72jcnArzNx1tBxks1vf3lRuLKW6eEiwmmn6JH1bpnpF82CRwFTYcVrrhvK2LQyc7Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR19MB3796
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-04_02:2020-08-03,2020-08-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008040043
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008040044
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> From: Matthew Garrett <mjg59@srcf.ucam.org>
> Sent: Tuesday, August 4, 2020 1:54 PM
> To: Yuan, Perry
> Cc: kernel test robot; sre@kernel.org; pali@kernel.org; dvhart@infradead.=
org;
> andy@infradead.org; Limonciello, Mario; kbuild-all@lists.01.org; linux-
> pm@vger.kernel.org; linux-kernel@vger.kernel.org; platform-driver-
> x86@vger.kernel.org
> Subject: Re: [PATCH] platform/x86:dell-laptop:Add battery charging thresh=
olds
> and charging mode switch.
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> On Tue, Aug 04, 2020 at 05:46:30AM +0000, Yuan, Perry wrote:
>=20
> > It is not patch issue, the kernel config needs to add
> "CONFIG_ACPI_BATTERY=3Dy"
>=20
> In that case you probably want to add a dependency to ACPI_BATTERY in the
> DELL_LAPTOP Kconfig.
>=20
> --
> Matthew Garrett | mjg59@srcf.ucam.org

Thank you Matthew.
I will add it to the Kconfig as DELL_LAPTOP dependency.=20
