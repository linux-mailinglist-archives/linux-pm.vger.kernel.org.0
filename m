Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6C9412EAE4
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2020 21:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbgABUji (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jan 2020 15:39:38 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:17360 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725783AbgABUji (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jan 2020 15:39:38 -0500
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 002KcXD5032584;
        Thu, 2 Jan 2020 20:39:30 GMT
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        by mx0a-002e3701.pphosted.com with ESMTP id 2x9q0m08ts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Jan 2020 20:39:30 +0000
Received: from G1W8108.americas.hpqcorp.net (g1w8108.austin.hp.com [16.193.72.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2352.austin.hpe.com (Postfix) with ESMTPS id C9AAC85;
        Thu,  2 Jan 2020 20:39:29 +0000 (UTC)
Received: from G4W9120.americas.hpqcorp.net (2002:10d2:150f::10d2:150f) by
 G1W8108.americas.hpqcorp.net (2002:10c1:483c::10c1:483c) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Thu, 2 Jan 2020 20:39:29 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (15.241.52.12) by
 G4W9120.americas.hpqcorp.net (16.210.21.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Thu, 2 Jan 2020 20:39:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rk5zq3gh9p82aU9XN1wV4Nfsyc7QfTjyav5TMRxohs0g+HPEJNazXw7CXjqnrPQyBesFSYBA1J3v8j2RrqpRMt1reGws3/duuhGNtEFZtZCyD2wlv79iGGcgfgrjwkCgdGC6Fq8hGo7AZJx4XlaVi63A4LVv1bmikyJ2HO4/m72Sb+Je9cCcyLyRRVggimzbK7a2oWgNg+d2czn/+Eew5/LFzTa5/iiXYwkdc5rX8M+s1ymTGG9+C9wLE/iNtpM4XchUJUB/rPxg/QOYx+VdrBBPOLR4osTPV2nahjqelI5fn8MBb0maItMJJaX2LCpUAcg3oWtfQAas5YGZfWKNpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cw6T8+vS5I97Cy7totuVy3TksQAGqr9S2CXE9fUlFAQ=;
 b=n6GtJcMGa959CAg+7yGzvZQjH/7D4IS1sqnvMh6yX8FaAs7nIcCsYeDhaKhGrCWmdB23IMS5CBW1zYYXJe335X4jvqWF9oct8Aw/jtA8B6INUsvYpBwFy3Wu6QBio1MaheZt6USehLjyFCGutQKz9jSkngYossnLdh+ZC+6SZvEjglayO+kLGkOndMaa2X6QDqcdNEtuEZy1O9W+vfsVyekXh/Tr5svY8w0VrmeuVDksBoRF6nzFAQN6NqBuWgAvXBhUTDmuPVUzAMA/+Zf8fBah/48957be7mQkjQpMcrL+jrK8CTKnhTHlVwEzIUb9UsGK6twOWZHUoLPWkuoDLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from TU4PR8401MB0927.NAMPRD84.PROD.OUTLOOK.COM (10.169.47.145) by
 TU4PR8401MB0479.NAMPRD84.PROD.OUTLOOK.COM (10.169.43.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Thu, 2 Jan 2020 20:39:27 +0000
Received: from TU4PR8401MB0927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::98db:60af:be84:d1bf]) by TU4PR8401MB0927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::98db:60af:be84:d1bf%3]) with mapi id 15.20.2602.012; Thu, 2 Jan 2020
 20:39:27 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     Luigi Semenzato <semenzato@google.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "gpike@google.com" <gpike@google.com>
Subject: RE: [PATCH v2 2/2] pm: add more logging on hibernation failure
Thread-Topic: [PATCH v2 2/2] pm: add more logging on hibernation failure
Thread-Index: AQHVwadzLuU7voWfk0GF79yTnSqIUafX1KzQ
Date:   Thu, 2 Jan 2020 20:39:27 +0000
Message-ID: <TU4PR8401MB0927CC96419009A3D0B0FDDDAB200@TU4PR8401MB0927.NAMPRD84.PROD.OUTLOOK.COM>
References: <20200102200052.51182-1-semenzato@google.com>
 <20200102200052.51182-3-semenzato@google.com>
In-Reply-To: <20200102200052.51182-3-semenzato@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [15.211.195.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b23c70ff-d9dc-4d32-e71a-08d78fc3dc8a
x-ms-traffictypediagnostic: TU4PR8401MB0479:
x-microsoft-antispam-prvs: <TU4PR8401MB0479B2051F764B68C2742F88AB200@TU4PR8401MB0479.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0270ED2845
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(396003)(136003)(346002)(199004)(13464003)(189003)(33656002)(7696005)(8676002)(54906003)(8936002)(86362001)(81166006)(81156014)(9686003)(6506007)(110136005)(55016002)(186003)(66946007)(4326008)(76116006)(52536014)(2906002)(66446008)(4744005)(66556008)(316002)(478600001)(66476007)(53546011)(71200400001)(5660300002)(26005)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:TU4PR8401MB0479;H:TU4PR8401MB0927.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DjQEJC5MmryFw+Pm7QdATy9BHfwOHt5+oXQa4+ZT+QbHeplL9G+8jVH5e30iBpwXJ9NLrVbQv+wOpe7llTd3dwNCQcZ1yr0N413YtlWiPUtfQHj/N5XgrKhc2P+olCOfuelFst+dvXAWpnyM5RlIW7qk1gJ0H71LxSBBIG1ulgzUEcIQmXS/TRFkW0sgiRAMmVGy+22pO7gcpGDsH9Bq3v4XgQs7GYta52Q2vHDrvoaw9YNBDX1wBmSQmSAk8s5G6+w2VdEZobsurLlEyamHAs5DoZNnuYom9WdAfw1RGQ+j3IaBKnM2OxxftnbtXbFEpU3SXEitJDBMF3l0/aMI0ACcPLJzPjWwT8S/5iTgGlq64Z/bsU7U50AqycddscbZ706rptud1SlPfgzEysmRB4zdX4EMp+O6mlwTQvb7ZD8sfpI9wl/twv+i2TU2Wgv/wECtmQHM8gG1XvXs+zK3nAToxG7iKso8e+1h5qGrKp2iPXv9o0Ax+ukBZU6w3lWj
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b23c70ff-d9dc-4d32-e71a-08d78fc3dc8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2020 20:39:27.5910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EsHczafdXk0obh0J1JoSGbi6jsp+0ym3/pw/HEFVTk/NzrBhh0aDimB27IXiVL+3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TU4PR8401MB0479
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-02_06:2020-01-02,2020-01-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=744
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001020165
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgta2VybmVsLW93
bmVyQHZnZXIua2VybmVsLm9yZyA8bGludXgta2VybmVsLQ0KPiBvd25lckB2Z2VyLmtlcm5lbC5v
cmc+IE9uIEJlaGFsZiBPZiBMdWlnaSBTZW1lbnphdG8NCj4gU2VudDogVGh1cnNkYXksIEphbnVh
cnkgMiwgMjAyMCAyOjAxIFBNDQo+IFRvOiBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmcNCi4uLg0K
PiAtCXByX2luZm8oIlByZWFsbG9jYXRpbmcgaW1hZ2UgbWVtb3J5Li4uICIpOw0KPiArCXByX2lu
Zm8oIlByZWFsbG9jYXRpbmcgaGliZXJuYXRpb24gaW1hZ2UgbWVtb3J5XG4iKTsNCi4uLg0KPiAr
CQlwcl9lcnIoIkNhbm5vdCBhbGxvY2F0ZSBvcmlnaW5hbCBiaXRtYXBcbiIpOw0KLi4uDQo+ICsJ
CXByX2VycigiQ2Fubm90IGFsbG9jYXRlIGNvcHkgYml0bWFwXG4iKTsNCi4uLg0KPiArCQkJcHJf
ZXJyKCJJbWFnZSBhbGxvY2F0aW9uIGlzICVsdSBwYWdlcyBzaG9ydFxuIiwNCj4gKwkJCQlhbGxv
YyAtIHBhZ2VzX2hpZ2htZW0pOw0KLi4uDQo+IC0JcHJfY29udCgiZG9uZSAoYWxsb2NhdGVkICVs
dSBwYWdlcylcbiIsIHBhZ2VzKTsNCj4gKwlwcl9pbmZvKCJBbGxvY2F0ZWQgJWx1IHBhZ2VzIGZv
ciBoaWJlcm5hdGlvbiBzaGFwc2hvdFxuIiwgcGFnZXMpOw0KPiAgCXN3c3VzcF9zaG93X3NwZWVk
KHN0YXJ0LCBzdG9wLCBwYWdlcywgIkFsbG9jYXRlZCIpOw0KDQpJbmNsdWRpbmcgdGhlIHdvcmQg
ImhpYmVybmF0aW9uIiBvciB0aGUgcGhyYXNlICJoaWJlcm5hdGlvbiBpbWFnZSIgaW4NCmVhY2gg
cHJpbnQgd291bGQgaGVscCBpbiBwYXJzaW5nIHRoZSBtZXNzYWdlcyAoZS5nLiwgd2l0aCBncmVw
KS4NCg0KDQoNCg==
