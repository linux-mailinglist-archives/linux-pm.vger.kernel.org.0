Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E935586C7F
	for <lists+linux-pm@lfdr.de>; Mon,  1 Aug 2022 16:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbiHAOBr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Aug 2022 10:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbiHAOBq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Aug 2022 10:01:46 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE7C28720
        for <linux-pm@vger.kernel.org>; Mon,  1 Aug 2022 07:01:45 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271A6I7G006995;
        Mon, 1 Aug 2022 07:01:16 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3hn20q79ns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Aug 2022 07:01:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GlAC40ir0J8mL0+8w9T6LzHHadZDRiy2ok9zMRaG8zZSIcgT+uyR0CI7S5eUzDRrqmHE409tmNF0QnOqcqys5VIs+d1dR2q4hur1Ow82xVGPof/EbVxP9kWvrAlRlKRMgAx5jnYtAIW+lF/Oa66CtTJAMQz03MRI7ztEHSvX1HkftuMpIwboVUIITEFwajJe83W0SYLcQPG9Y7qe0935/0Jg3ud3GREGnIGRgNomGo5TLRMYK2QGADObL+MfIvvsKlw8qL6HkQtQDW26nfCxn5cg7MvCnXAm5hBmItRfk2XXBhetFh63GIZVf/OIYQlpgyZTyVett65vTtCNDxdl8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZZPrXZBDeZuLY12CCh2jOjYNMgnR4ttHUwSS65KrO8=;
 b=jLp6rU+C5l06KXKNLjld6bBHrPDH7dfD73pQ3IMAmrrdAjI4CaEsHq3mH7fmef7kBzqiOfi+MlbuN8cdc2GeZOZzANjGlTLp3z5VU2n5jbBBvPKVCDG9evzAiAuDmX0Ti4QVZIeGNCpBYndXYEOYaY+c6P/nhaEv+vx+rRxJiNYoo9S+0R1/s6ryAUJxP9b3qvGOEcO+CWGhe9PE9ylcolaJUrQd+SGo603eVbDGTJObZUFdlm4BZxy4oK1cF0oZaf9gUHnPZrpa1i/y5fmZq/E2hRT8zLuC9tkjGWY5qwgwh9zVr0uivzGK54pJwuR0V40HE1Ev8RczXxlTlb+m4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZZPrXZBDeZuLY12CCh2jOjYNMgnR4ttHUwSS65KrO8=;
 b=B08kHvHXKuskYfjAx5x2e9q17o3ySJxe7HhHd4Tddr+ii0EP2tVD24nwN0SDcttVwb77/snAgt/koYogZyrcKZ1KQNMhPsauw85AdiGiLj+lyA/FLDN7lmIrKPVZcj8YhPItkyh1Zdg+TfiqAmFT/xisVzEBmzsNqdkqgw5vJ5s=
Received: from BN9PR18MB4251.namprd18.prod.outlook.com (2603:10b6:408:11c::10)
 by BY5PR18MB3154.namprd18.prod.outlook.com (2603:10b6:a03:1aa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15; Mon, 1 Aug
 2022 14:01:07 +0000
Received: from BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::28e5:399f:68fd:8210]) by BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::28e5:399f:68fd:8210%9]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 14:01:07 +0000
From:   Elad Nachman <enachman@marvell.com>
To:     =?utf-8?B?UGFsaSBSb2jDoXI=?= <pali@kernel.org>,
        Wojciech Bartczak <wbartczak@marvell.com>
CC:     =?utf-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Anders Trier Olesen <anders.trier.olesen@gmail.com>,
        Philip Soares <philips@netisense.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, nnet <nnet@fastmail.fm>
Subject: RE: [EXT] Re: [PATCH v2] cpufreq: armada-37xx: forbid cpufreq for 1.2
 GHz variant
Thread-Topic: [EXT] Re: [PATCH v2] cpufreq: armada-37xx: forbid cpufreq for
 1.2 GHz variant
Thread-Index: AQHYpaNS2am5wAMEh029JWVLvnD4z62aElMg
Date:   Mon, 1 Aug 2022 14:01:07 +0000
Message-ID: <BN9PR18MB4251768A59D38A44C264E1FEDB9A9@BN9PR18MB4251.namprd18.prod.outlook.com>
References: <20210630135942.29730-1-kabel@kernel.org>
 <20210630225601.6372-1-kabel@kernel.org>
 <20210702163035.nmb5pniwpqtmaz4b@pali> <20210708143451.4htvdop4zvjufrq6@pali>
 <20210715193321.z3vswz6x4rzvw2fd@pali> <20210808193026.xuyaufi5wqnrcakd@pali>
 <20220801123616.uol4wrs6trttumsg@pali>
In-Reply-To: <20220801123616.uol4wrs6trttumsg@pali>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a067523-e84f-493c-9423-08da73c647f7
x-ms-traffictypediagnostic: BY5PR18MB3154:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xxz+eYCB2yeDBjbnzZAiFRhMquhF8wVCecIFxKAXf5qOUJZMwQLNjnmmvEckwdKokcN28LnEJ+yD32shV0aa5mhXQKmRBnpID18/hOQXB0ws3yfGFg5Wq0fID/UIYwTm0OKdUSmfdGaX7hz5lgL5xjrE6X9lEoPSZX1QidTw8OqYJkZqxNRKNydmbTunFBJNYHBhY7e+yTst+9zrUDl3t5OWMWDKYVuy0Mzn8Mgsqinif8SBdUoKblTocOXBHXjoQ224vDX9cUFS3HlK0tx0ZQaJBD3jYk0CNaIKdKFbiCzRwR6ixGs+CAkGubKJCMAk9P/hFbo/2HFA4rXG8w5SrfK9Zh4hSM02OIVnIq1O6W0c5q4wP5b+KAXTcaurCuU2X7w3H87x6fBkYnZ2IJk47DFeU68nakqLMzH2QoRbz5APrKboAXIBMvrdgvSgMtFrjiBXgUpL/AYz0vYqnmEcGudecjwBwQAJYgiXIy/TfPOS4cKi/wawJynxw171nwm4peRvhu/QJ2kwYX1nZKOOt48T4rI4YalC0jAPwuKz/Cg7TIo4Ap8uwJbzc6mz27royp7rPL0sKFHx27u9HEVLpzEmSoSYTVaLR9dTK0hf65X1lgrL7zOAh2h/kaa9LudSyfWXYZUuc8jyJoU7uvBWutEtnHbjbMZT4x3L6L1DNjvuyfg28MusXGeGbxQRNZH4bL0whevYVB9GbHkIjbfL76JCGQ/nvcZ4KSBOjKummYOcG27n0I7phoS5ouhbkrdVA5KYkHuDKgvE0OKZS+ebNnA5FTGV4GrBCwMatEhlX87S1IsS3e3/yEDEGZDCtoq9T8vgcFF0fiLO9KWMT2HRoxvPsPBLNUNyAjOb86ZOiFx/dwZFNY/YDKqh0oymUxXI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR18MB4251.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(376002)(136003)(39850400004)(396003)(8936002)(6506007)(110136005)(966005)(8676002)(53546011)(316002)(19627235002)(52536014)(6636002)(54906003)(478600001)(33656002)(7696005)(38070700005)(71200400001)(26005)(9686003)(41300700001)(66946007)(66556008)(83380400001)(186003)(86362001)(76116006)(66574015)(4326008)(66476007)(5660300002)(64756008)(38100700002)(122000001)(55016003)(7416002)(2906002)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1hpalpBN2ZVWGdKQmxQU3JQbTlPeHJ0MWJPeEUrcFZ1cmxBeFNmeU1Td204?=
 =?utf-8?B?OVFsUmVNQ3lvRVY5TXBURHVRZkwzcnpiOEpObGRLMXZMZWtLZFNqNGNpdkRx?=
 =?utf-8?B?K3JDVmVEU3FMR0I5LzVzUng5c3hVclFkU2JBWldJMjJhRE5CeCtEWjIzc1FH?=
 =?utf-8?B?RlRXTTBDZ3hQdzFHSGhpM1I1WlRHaDR3dEtxWHBBcHJVVFl1MTgvVURFL2wy?=
 =?utf-8?B?Y3BTTWMvYmpWNHM0UDRBVWJBRVJ2bDJ3WWI0MmNvM3NJSm1yRUtOS2I3QzNQ?=
 =?utf-8?B?eGJ1a3Z3bFNaUzg3ZStRb2prK0JuVm1yM3A3Y0UrQmdxQVlTUGVQU1o2OC9j?=
 =?utf-8?B?TzNkRUJsN3FuT3h6Vk1DT29zQjFDNXZhSGlqYko1OVdMd2tPU2ZsZi92WUN2?=
 =?utf-8?B?ejJuN2ZCK0x5Vkg2OHBkTm5WNk5PUDFwKzdVdGlWR2RxWVc4TFhSN2hYeGY0?=
 =?utf-8?B?QkQwS2plSmJyZ0t1SGNJZVZ0MFFTMjZGMjhXdEZuK1pGMm1yVTJuQ2dtSTZ2?=
 =?utf-8?B?VnBqblFNK2UrM0pkZVAvaXcranQ1YmMrckcxaTlOVmVSUUNZMzV0THN4dzBM?=
 =?utf-8?B?WlZWenUyeDNkZ2liSnpPczBJMmQxN2V4TXpudHpzWmw3aXF1clhjS1JFMmpC?=
 =?utf-8?B?eXFOQVpQUlBOUCt2bEo5OHZPTzEzd3pBQUx6aG9Bc3hsVXd5Z014QTNxOGtR?=
 =?utf-8?B?cFZiSkF3VnhzUzdibnYwMXhPYzE5djA2L29YbW9CMnpyZVpYZkN2cUFGV2F2?=
 =?utf-8?B?Sks5eHdFQXk3eGZiOWRWSm1sQ1VVNFpUOGZ2OTYrZ2xlREN1VE5UUXpyQTd1?=
 =?utf-8?B?bExvVzBWcGNLNU5IZUlySTRLeEI3cXZsWUhWM05TekdpNW9OU3YraTFVWUJt?=
 =?utf-8?B?UTc2djNGVTlSU3lLZ2VxL3VueW5uQ05IRFl1Vm1ScXpKZTN6K2FSNWpsQkUr?=
 =?utf-8?B?MnFLYXR2SEcrL2RBclY0ak5MdmRzdURtQ1BtWFBuM3lVK1pxK0MxSlZLUjZF?=
 =?utf-8?B?cS9INEVIdFlMK2VuSXdHdkpHRHFqWVNnNGc4dGJFbWl6QUtkdzhFVko2dThL?=
 =?utf-8?B?RGozOUdxRHlsVHlsRFJRNUV2ZXVra01ubFdDT0hmeTE5QzFhbUxXai9Ia2hW?=
 =?utf-8?B?S0c5UExjOWtiOVJaTitXWWk2bDBUejI1MTNiSkQ3VnlOc1hTR0dvSHNCdC9G?=
 =?utf-8?B?eGxtU1pMcVVMUWZKa1NnUGRLczdqYjF5RndJTUtIMVNPR2RieGY2QlIwTnZT?=
 =?utf-8?B?cGd2N29xak02UTV5MDZLR1BsR3RyKzNJKzNWS29XNFo0TDNFYUVPdlV3ZHlu?=
 =?utf-8?B?UE1qTGtOeEZLcHZlOUVmdFFoZFZhMnVxUUVUMmlvdXZodFFNVG8vbWgyRFpD?=
 =?utf-8?B?OEZBRGhwR2UyVW1sMFlkMk5IM1d2Q0VMalRvK0R5Y2xsSGs1V1Y0UVQ0L0JJ?=
 =?utf-8?B?M05DOEdTdHhML1NlOW9wWUtvOVE3enk5dlM2RlhYUGQxTFBETC80VkJ0L3RX?=
 =?utf-8?B?aWJIQ0hXSEYxY0tlaTRnMjlENllBUk5DbXNETEFlaURuZUZRbjFyMVlXN1Ry?=
 =?utf-8?B?djZ5ZG9GL01RV0lPUS9kZ0x4U1JBQ2U2b1hHb1hVM29RN0RFUDNFWGpSdFIr?=
 =?utf-8?B?S3AyT1hKd21yK3VRY0tnUmR5bGszL1dVRzJoUzdCN05XTkQ3L3NvWUtDUHh3?=
 =?utf-8?B?cVJ2Z241d3JlSTY5MUNIR2hpbGQxN21pc3FNbjU0RXczcEVHRm1seWJwRWxy?=
 =?utf-8?B?eTdvWnBrRzFZRHhpRmMxQTZyaUxPZXlXRlo3d05kUWE2K2liZWIyWlg1UVk5?=
 =?utf-8?B?eXh3cCsydXdGU3ZLVFhiRUpTYnZHVGRmTTNpMDRqNTRkWHM5VkI5N2NGcytS?=
 =?utf-8?B?MVRhV3M2cThRWnJoMkNQUUdkOXpDUDdoYkZLSm9Kek1mclF6TVpuWlhLRUxU?=
 =?utf-8?B?N1ZBNHl4Q3RPNzRoQ1hrTURvRjBrK0cyRFR1UkNNRDI1dXNpOVlsaHAwb0J4?=
 =?utf-8?B?dkdBcnpsYTV0bFpWdHJrS3RYV29zdjJMaUhYQmNqb3FWejByQWVOL29nd205?=
 =?utf-8?B?cFd5WitVOExtaHZNSG5VanVSSi9wTzB6TDcxV3Bibi9BbWpkVUlWaTgyS1Jr?=
 =?utf-8?Q?zNnmagZ3FVVnKqyFU22OEUv30?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR18MB4251.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a067523-e84f-493c-9423-08da73c647f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2022 14:01:07.4316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4NGNHMybsIR/ViGckePBqvV2fBzvfxHd9RTl7gQqipNcxxE134ercMvTctSQn/TEkeVCpdLhIj31IKVxfnIwjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3154
X-Proofpoint-GUID: XScasQn3H9mzbtGG96It8rTzUhnyBV9l
X-Proofpoint-ORIG-GUID: XScasQn3H9mzbtGG96It8rTzUhnyBV9l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_07,2022-08-01_01,2022-06-22_01
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgUGFsaSwNCg0KVGhlcmUgaXMgYW4gZXJyYXRhIGZvciB0aGF0Lg0KDQoiDQpTd2l0Y2hpbmcg
ZnJvbSBMMi9MMyBzdGF0ZSAoMjAwLzMwMCBNSHopIHRvIEwwIHN0YXRlICgxMjAwIE1IeikgcmVx
dWlyZXMgc3VkZGVuIGNoYW5nZXMgb2YgVkREIHN1cHBseSwgYW5kIGl0DQpyZXF1aXJlcyB0aW1l
IHRvIHN0YWJpbGl6ZSB0aGUgVkREIHN1cHBseS4gVGhlIHNvbHV0aW9uIGlzIHRvIHVzZSBncmFk
dWFsIHN3aXRjaGluZyBmcm9tIEwyL0wzIHRvIEwxIGFuZCB0aGVuIEwxIHRvIEwwDQpzdGF0ZS4N
CiINCg0KSSB3b3VsZCBhbHNvIGFkZCBhZGRpdGlvbmFsIGRlbGF5IGZvciB0aGUgVkREIHN1cHBs
eSBzdGFiaWxpemF0aW9uLg0KDQpGWUksDQoNCkVsYWQuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQpGcm9tOiBQYWxpIFJvaMOhciA8cGFsaUBrZXJuZWwub3JnPiANClNlbnQ6IE1vbmRh
eSwgQXVndXN0IDEsIDIwMjIgMzozNiBQTQ0KVG86IEVsYWQgTmFjaG1hbiA8ZW5hY2htYW5AbWFy
dmVsbC5jb20+OyBXb2pjaWVjaCBCYXJ0Y3phayA8d2JhcnRjemFrQG1hcnZlbGwuY29tPg0KQ2M6
IE1hcmVrIEJlaMO6biA8a2FiZWxAa2VybmVsLm9yZz47IFZpcmVzaCBLdW1hciA8dmlyZXNoLmt1
bWFyQGxpbmFyby5vcmc+OyBHcmVnb3J5IENMRU1FTlQgPGdyZWdvcnkuY2xlbWVudEBib290bGlu
LmNvbT47IFJvYmVydCBNYXJrbyA8cm9iZXJ0Lm1hcmtvQHNhcnR1cmEuaHI+OyBUb21hc3ogTWFj
aWVqIE5vd2FrIDx0bW41MDVAZ21haWwuY29tPjsgQW5kZXJzIFRyaWVyIE9sZXNlbiA8YW5kZXJz
LnRyaWVyLm9sZXNlbkBnbWFpbC5jb20+OyBQaGlsaXAgU29hcmVzIDxwaGlsaXBzQG5ldGlzZW5z
ZS5jb20+OyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc7IFNlYmFzdGlhbiBIZXNzZWxiYXJ0aCA8
c2ViYXN0aWFuLmhlc3NlbGJhcnRoQGdtYWlsLmNvbT47IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZzsgbm5ldCA8bm5ldEBmYXN0bWFpbC5mbT4NClN1YmplY3Q6IFtFWFRdIFJl
OiBbUEFUQ0ggdjJdIGNwdWZyZXE6IGFybWFkYS0zN3h4OiBmb3JiaWQgY3B1ZnJlcSBmb3IgMS4y
IEdIeiB2YXJpYW50DQoNCkV4dGVybmFsIEVtYWlsDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCisgRWxhZCBh
bmQgV29qY2llY2ggZnJvbSBNYXJ2ZWxsDQoNCkNvdWxkIHlvdSBwbGVhc2UgbG9vayBhdCB0aGlz
IGlzc3VlIGFuZC9vciBmb3J3YXJkIGl0IHRvIHJlbGV2YW50IE1hcnZlbGwgdGVhbT8NCg0KTWFp
bnRhaW5lciBWaXJlc2ggYWxyZWFkeSB3cm90ZSB0aGF0IHdlIGNhbm5vdCBoYW5nIGZvcmV2ZXIg
Zm9yIE1hcnZlbGwgYW5kIHBhdGNoIHdoaWNoIGRpc2FibGVzIHN1cHBvcnQgZm9yIDEuMiBHSHog
d2FzIG1lcmdlZDoNCmh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1o
dHRwcy0zQV9fbG9yZS5rZXJuZWwub3JnX2xpbnV4LTJEcG1fMjAyMTA4MDkwNDAyMjQuajJydm9w
bW1xZGEzdXRjNS00MHZpcmVzaGstMkRpN18mZD1Ed0lEYVEmYz1uS2pXZWMyYjZSMG1PeVBhejd4
dGZRJnI9ZVRlTlRMRUs1LVR4WGN6ak9jS1BoQU5JRnRsQjlwUDRscTlxaGRsRnJ3USZtPTVuTU1L
eUtPT00zWGRNZV9QZXJaUng4TDctRDdNa1doQ2w3R3hwWFRQaW90VmYxVFI0ajh2M2JwalFtUktD
TEMmcz1jWGlDWkJ5a25mejFyT0lnSmw0ZkpIbDFLTExScTJzaEh1bDItVlBwWVAwJmU9IA0KDQpP
biBTdW5kYXkgMDggQXVndXN0IDIwMjEgMjE6MzA6MjYgUGFsaSBSb2jDoXIgd3JvdGU6DQo+IEdl
bnRsZSByZW1pbmRlci4gVGhpcyBpcyByZWFsbHkgc2VyaW91cyBpc3N1ZS4gQ291bGQgeW91IHBs
ZWFzZSBsb29rIGF0IGl0Pw0KPiANCj4gQWRkaW5nIG1vcmUgTWFydmVsbEVtYmVkZGVkUHJvY2Vz
c29ycyBwZW9wbGUgdG8gdGhlIGxvb3A6IEV2YW4sIA0KPiBCZW5qYW1pbiBhbiBJZ2FsDQo+IA0K
PiBPbiBUaHVyc2RheSAxNSBKdWx5IDIwMjEgMjE6MzM6MjEgUGFsaSBSb2jDoXIgd3JvdGU6DQo+
ID4gUGluZyEgR2VudGxlIHJlbWluZGVyIGZvciBNYXJ2ZWxsIHBlb3BsZS4NCj4gPiANCj4gPiBP
biBUaHVyc2RheSAwOCBKdWx5IDIwMjEgMTY6MzQ6NTEgUGFsaSBSb2jDoXIgd3JvdGU6DQo+ID4g
PiBLb25zdGFudGluLCBOYWRhdiwgS2VuLCBWaWN0b3IsIEphc29uOiBUaGlzIGlzc3VlIGlzIHBy
ZXR0eSANCj4gPiA+IHNlcmlvdXMsIENQVSBvbiAxLjJHSHogQTM3MjAgaXMgY3Jhc2hpbmcuIENv
dWxkIHlvdSBwbGVhc2UgbG9vayBhdCBpdD8NCj4gPiA+IA0KPiA+ID4gT24gRnJpZGF5IDAyIEp1
bHkgMjAyMSAxODozMDozNSBQYWxpIFJvaMOhciB3cm90ZToNCj4gPiA+ID4gK0phc29uIGZyb20g
R2xvYmFsU2NhbGUgYXMgdGhpcyBpc3N1ZSBhZmZlY3RzIEdsb2JhbFNjYWxlIEVzcHJlc3NvYmlu
IFVsdHJhIGFuZCBWNyAxLjIgR0h6IGJvYXJkcy4NCj4gPiA+ID4gDQo+ID4gPiA+IE9uIFRodXJz
ZGF5IDAxIEp1bHkgMjAyMSAwMDo1NjowMSBNYXJlayBCZWjDum4gd3JvdGU6DQo+ID4gPiA+ID4g
VGhlIDEuMiBHSHogdmFyaWFudCBvZiB0aGUgQXJtYWRhIDM3MjAgU09DIGlzIHVuc3RhYmxlIHdp
dGggDQo+ID4gPiA+ID4gRFZGUzogd2hlbiB0aGUgU09DIGJvb3RzLCB0aGUgV1RNSSBmaXJtd2Fy
ZSBzZXRzIGNsb2NrcyBhbmQgDQo+ID4gPiA+ID4gQVZTIHZhbHVlcyB0aGF0IHdvcmsgY29ycmVj
dGx5IHdpdGggMS4yIEdIeiBDUFUgZnJlcXVlbmN5LCBidXQgDQo+ID4gPiA+ID4gcmFuZG9tIGNy
YXNoZXMgb2NjdXIgb25jZSBjcHVmcmVxIGRyaXZlciBzdGFydHMgc2NhbGluZy4NCj4gPiA+ID4g
PiANCj4gPiA+ID4gPiBXZSBkbyBub3Qga25vdyBjdXJyZW50bHkgd2hhdCBpcyB0aGUgcmVhc29u
Og0KPiA+ID4gPiA+IC0gaXQgbWF5IGJlIHRoYXQgdGhlIHZvbHRhZ2UgdmFsdWUgZm9yIEwwIGZv
ciAxLjIgR0h6IHZhcmlhbnQgcHJvdmlkZWQNCj4gPiA+ID4gPiAgIGJ5IHRoZSB2ZW5kb3IgaW4g
dGhlIE9UUCBpcyBzaW1wbHkgaW5jb3JyZWN0IHdoZW4gc2NhbGluZyBpcyANCj4gPiA+ID4gPiB1
c2VkLA0KPiA+ID4gPiA+IC0gaXQgbWF5IGJlIHRoYXQgc29tZSBkZWxheSBpcyBuZWVkZWQgc29t
ZXdoZXJlLA0KPiA+ID4gPiA+IC0gaXQgbWF5IGJlIHNvbWV0aGluZyBlbHNlLg0KPiA+ID4gPiA+
IA0KPiA+ID4gPiA+IFRoZSBtb3N0IHNhbmUgc29sdXRpb24gbm93IHNlZW1zIHRvIGJlIHRvIHNp
bXBseSBmb3JiaWQgdGhlIA0KPiA+ID4gPiA+IGNwdWZyZXEgZHJpdmVyIG9uIDEuMiBHSHogdmFy
aWFudC4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBNYXJlayBCZWjDum4g
PGthYmVsQGtlcm5lbC5vcmc+DQo+ID4gPiA+ID4gRml4ZXM6IDkyY2U0NWZiODc1ZCAoImNwdWZy
ZXE6IEFkZCBEVkZTIHN1cHBvcnQgZm9yIEFybWFkYSANCj4gPiA+ID4gPiAzN3h4IikNCj4gPiA+
ID4gPiAtLS0NCj4gPiA+ID4gPiBJZiBzb21lb25lIGZyb20gTWFydmVsbCBjb3VsZCBsb29rIGlu
dG8gdGhpcywgaXQgd291bGQgYmUgDQo+ID4gPiA+ID4gZ3JlYXQgc2luY2UgYmFzaWNhbGx5IDEu
MiBHSHogdmFyaWFudCBjYW5ub3Qgc2NhbGUsIHdoaWNoIGlzIGEgDQo+ID4gPiA+ID4gZmVhdHVy
ZSB0aGF0IHdhcyBjbGFpbWVkIHRvIGJlIHN1cHBvcnRlZCBieSB0aGUgU09DLg0KPiA+ID4gPiA+
IA0KPiA+ID4gPiA+IEtlbiBNYSAvIFZpY3RvciBHdSwgeW91IGhhdmUgd29ya2VkIG9uIGNvbW1p
dCANCj4gPiA+ID4gPiBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9
aHR0cHMtM0FfX2dpdGh1Yi5jbw0KPiA+ID4gPiA+IG1fTWFydmVsbEVtYmVkZGVkUHJvY2Vzc29y
c19saW51eC0yRG1hcnZlbGxfY29tbWl0X2Q2NzE5ZmRjMmIzDQo+ID4gPiA+ID4gY2FjNTgwNjRm
NDFiNTMxZjg2OTkzYzkxOWFhOWEmZD1Ed0lEYVEmYz1uS2pXZWMyYjZSMG1PeVBhejd4dGYNCj4g
PiA+ID4gPiBRJnI9ZVRlTlRMRUs1LVR4WGN6ak9jS1BoQU5JRnRsQjlwUDRscTlxaGRsRnJ3USZt
PTVuTU1LeUtPT00zWA0KPiA+ID4gPiA+IGRNZV9QZXJaUng4TDctRDdNa1doQ2w3R3hwWFRQaW90
VmYxVFI0ajh2M2JwalFtUktDTEMmcz1iOWNES2VtDQo+ID4gPiA+ID4gdDcwT2lUSkY2S1hqMHlT
emJ4cHNCX251dGVYSkU4N3ZpYTgwJmU9DQo+ID4gPiA+ID4gaW4gbGludXgtbWFydmVsbC4NCj4g
PiA+ID4gPiBZb3VyIHBhdGNoIHRha2VzIGF3YXkgdGhlIDEyMDIgbVYgY29uc3RhbnQgZm9yIDEu
MiBHSHogYmFzZSANCj4gPiA+ID4gPiBDUFUgZnJlcXVlbmN5IGFuZCBpbnN0ZWFkIGFkZHMgY29k
ZSB0aGF0IGNvbXB1dGVzIHRoZSB2b2x0YWdlcyANCj4gPiA+ID4gPiBmcm9tIHRoZSB2b2x0YWdl
IGZvdW5kIGluIEwwIEFWUyByZWdpc3RlciAod2hpY2ggaXMgZmlsbGVkIGluIGJ5IFdUTUkgZmly
bXdhcmUpLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IERvIHlvdSBrbm93IHdoeSB0aGUgY29kZSBk
b2VzIG5vdCB3b3JrIGNvcnJlY3RseSBmb3Igc29tZSAxLjIgDQo+ID4gPiA+ID4gR0h6IGJvYXJk
cz8gRG8gd2UgbmVlZCB0byBmb3JjZSB0aGUgTDAgdm9sdGFnZSB0byAxMjAyIG1WIGlmIA0KPiA+
ID4gPiA+IGl0IGlzIGxvd2VyLCBvciBzb21ldGhpbmc/DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+
ID4gIGRyaXZlcnMvY3B1ZnJlcS9hcm1hZGEtMzd4eC1jcHVmcmVxLmMgfCA2ICsrKysrLQ0KPiA+
ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3B1ZnJlcS9hcm1hZGEt
Mzd4eC1jcHVmcmVxLmMgDQo+ID4gPiA+ID4gYi9kcml2ZXJzL2NwdWZyZXEvYXJtYWRhLTM3eHgt
Y3B1ZnJlcS5jDQo+ID4gPiA+ID4gaW5kZXggM2ZjOThhM2ZmZDkxLi5jMTBmYzMzYjI5YjEgMTAw
NjQ0DQo+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9jcHVmcmVxL2FybWFkYS0zN3h4LWNwdWZyZXEu
Yw0KPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvY3B1ZnJlcS9hcm1hZGEtMzd4eC1jcHVmcmVxLmMN
Cj4gPiA+ID4gPiBAQCAtMTA0LDcgKzEwNCwxMSBAQCBzdHJ1Y3QgYXJtYWRhXzM3eHhfZHZmcyB7
ICB9Ow0KPiA+ID4gPiA+ICANCj4gPiA+ID4gPiAgc3RhdGljIHN0cnVjdCBhcm1hZGFfMzd4eF9k
dmZzIGFybWFkYV8zN3h4X2R2ZnNbXSA9IHsNCj4gPiA+ID4gPiAtCXsuY3B1X2ZyZXFfbWF4ID0g
MTIwMCoxMDAwKjEwMDAsIC5kaXZpZGVyID0gezEsIDIsIDQsIDZ9IH0sDQo+ID4gPiA+ID4gKwkv
Kg0KPiA+ID4gPiA+ICsJICogVGhlIGNwdWZyZXEgc2NhbGluZyBmb3IgMS4yIEdIeiB2YXJpYW50
IG9mIHRoZSBTT0MgaXMgY3VycmVudGx5DQo+ID4gPiA+ID4gKwkgKiB1bnN0YWJsZSBiZWNhdXNl
IHdlIGRvIG5vdCBrbm93IGhvdyB0byBjb25maWd1cmUgaXQgcHJvcGVybHkuDQo+ID4gPiA+ID4g
KwkgKi8NCj4gPiA+ID4gPiArCS8qIHsuY3B1X2ZyZXFfbWF4ID0gMTIwMCoxMDAwKjEwMDAsIC5k
aXZpZGVyID0gezEsIDIsIDQsIDZ9IA0KPiA+ID4gPiA+ICt9LCAqLw0KPiA+ID4gPiA+ICAJey5j
cHVfZnJlcV9tYXggPSAxMDAwKjEwMDAqMTAwMCwgLmRpdmlkZXIgPSB7MSwgMiwgNCwgNX0gfSwN
Cj4gPiA+ID4gPiAgCXsuY3B1X2ZyZXFfbWF4ID0gODAwKjEwMDAqMTAwMCwgIC5kaXZpZGVyID0g
ezEsIDIsIDMsIDR9IH0sDQo+ID4gPiA+ID4gIAl7LmNwdV9mcmVxX21heCA9IDYwMCoxMDAwKjEw
MDAsICAuZGl2aWRlciA9IHsyLCA0LCA1LCA2fSB9LA0KPiA+ID4gPiA+IC0tDQo+ID4gPiA+ID4g
Mi4zMS4xDQo+ID4gPiA+ID4gDQo=
