Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E415586CAE
	for <lists+linux-pm@lfdr.de>; Mon,  1 Aug 2022 16:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbiHAOP5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Aug 2022 10:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbiHAOPt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Aug 2022 10:15:49 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B399EB86A
        for <linux-pm@vger.kernel.org>; Mon,  1 Aug 2022 07:15:47 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2719Den2025295;
        Mon, 1 Aug 2022 07:15:32 -0700
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3hn45m6x8a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Aug 2022 07:15:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDBIjtP85g2sGJrp/XoLz6AzzeiqFOp3vp/Fv3/jLi47rwDEFPJ1esqXei+m/rAsaJE8jdp8+w/4bNrXxl8+4eszFP5bqMjIdJHo3Mqnzg1VbN97ebPFgkud7yRS9lnwS7lg6CkUpm1uBmoVhvfdKwgMtDEQOwnTKtg7PUokDJVHlecSHAxLxgwq359sVKZ9HUZoWQf7zcT69YHdyskJ2/D6uBYBdmXzCDdeLimdNUvxUMoAn6hvWjjdK5aa9OMeAP3u+JzuRr6ZN8rlE7WAPcJkmiS9DG+QPGe+jz2A09HIt6z+/h7chxl0sLs/yPEuec4Rwb3ixbeR3ZAFfzilkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYotza7NrNm66zTWhLwhh6LMywO39iV4Ig2tL/dtxrY=;
 b=lWkZeLK1/70YDVUFFIJgU4JyztbTB++bjFQeygUdXbEbj+1Ox1o1NCJ/mLzEQ45d00WFcpc3vMoFtPhhM4yG2ECy0TWVKYVcRidwzpb/8CqzQ7WzQs5VUzXYqZTrpJiGLJlHrxp9aTcGpwLkszlRAsx1d1icUDd3TQdTskfS7pobaqZD6iAEBgSp3jp84MEtX3WU3MvdP3nTqZ9zZIgr7EbStVuGFdx0F30iLK63YC4vfTujzI2hbmdMxrFlOY4NQvCm81roEhhzBrPeAxoxZqotK2ET6P51nRbJX51zaOOEal2skyhOIt1aYeng4jbLebMY7e3ei5Blb2v3YtT7/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYotza7NrNm66zTWhLwhh6LMywO39iV4Ig2tL/dtxrY=;
 b=fXhPS4dHlYjU2zqiVvcDHsWljUP2Pe6xRb2CZbrQQvBhPai3UHghxoPN76nx9hRqruOlRb8lpz7NJvQefj9Hk/A3VZvPNK7wHrlue4Vr2n3jkA15VirAUHMfJ+qUj5UFn3YO1ol+6uRf337dG910nVEQFr/NRGOzsDmK219wCJw=
Received: from BN9PR18MB4251.namprd18.prod.outlook.com (2603:10b6:408:11c::10)
 by BL0PR18MB2273.namprd18.prod.outlook.com (2603:10b6:207:41::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Mon, 1 Aug
 2022 14:15:28 +0000
Received: from BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::28e5:399f:68fd:8210]) by BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::28e5:399f:68fd:8210%9]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 14:15:27 +0000
From:   Elad Nachman <enachman@marvell.com>
To:     =?utf-8?B?UGFsaSBSb2jDoXI=?= <pali@kernel.org>
CC:     Wojciech Bartczak <wbartczak@marvell.com>,
        =?utf-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
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
Thread-Index: AQHYpaNS2am5wAMEh029JWVLvnD4z62aElMggAAD+wCAAABSoA==
Date:   Mon, 1 Aug 2022 14:15:27 +0000
Message-ID: <BN9PR18MB42514ADBD547CADD93BD7646DB9A9@BN9PR18MB4251.namprd18.prod.outlook.com>
References: <20210630135942.29730-1-kabel@kernel.org>
 <20210630225601.6372-1-kabel@kernel.org>
 <20210702163035.nmb5pniwpqtmaz4b@pali> <20210708143451.4htvdop4zvjufrq6@pali>
 <20210715193321.z3vswz6x4rzvw2fd@pali> <20210808193026.xuyaufi5wqnrcakd@pali>
 <20220801123616.uol4wrs6trttumsg@pali>
 <BN9PR18MB4251768A59D38A44C264E1FEDB9A9@BN9PR18MB4251.namprd18.prod.outlook.com>
 <20220801141254.ojljy2lewgrkga3f@pali>
In-Reply-To: <20220801141254.ojljy2lewgrkga3f@pali>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1576ff78-6824-4d58-0192-08da73c848d2
x-ms-traffictypediagnostic: BL0PR18MB2273:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sj9VgCHg43S+9552ySlECUR5/3IHSy1W3C3e2MpoW193LVWDurxNWs6SPPOZhIkhsFNPgl14P19E2PTVg4lfSxK1zXZkUb1oU4XaYlpjnlvQbu/MJ3CZrwtYkz2l8C6vmwmg2SRqkduDCbrHjqmcy5CV4MTAff+PBlL1S6fniRKOpEE6VXj+sMhvJQWIJ/ODMvFIFRQbp+Yr+S4arEvlrxt/ldtTnRN/fEDO6pg11dPhLM+I3JxV0DF6kDH8Pvbd8+eaYiRDnyRyXl/HySO4LXbcF+OL+mbCdnYCk0UiiSwPZsRxhF3I0SDw/z9NVHsYKgst4dqd5Cb0hl7pBAl3AinW4hmnCkzziu5F7XS3QhafNg5rA3XXFZ3ZxcUMGwQm87f+9AhZMEX0VRVOrjCqrUlHnCTfauVh8U7M9m0HiLm4c3Gl1aUdh5aUbE11hs7HFxqrJnbLv1UDdSVqph+hO3l+Ust4mmstjECn6xTENcHChbUkR1VpIf+zQrmJzyG9ttJoLQ0YseKs6DYA/my2SRnl1KbNUPnUqI4n+h6Q6r6bnbdRxCeN6/3+lAkz0IYa6+DCJnGx+iVWitvPmlMYGYbP5A4+e9rp66ODilI6nnAF27gUFfPGyZW3SwCHHbqt9pf5nW7+iq0ClSA5191gWWMo+Ot3qlFeRq+G7U6GZEksAD6wh5+3qMlqbYdDJgBMq3DWBsAb1ww1WIZ8Pzjh575223B+wbggvEps3e5F6H7MSd/Qz3uPa1nx+AAjH3AwC40aIeWeoQpiYyyqM3UWYRtvM/o9UasSfRH8gO3SE5dTnmtWv5VB+00YBBJSKdZTvxg1YNHEtPey1Cl32ZznkpUpM8fn138Mzv9Qncpxgr4qUWBxnJ61f9JU5nET+PLV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR18MB4251.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(186003)(38100700002)(66446008)(64756008)(52536014)(76116006)(66574015)(66556008)(4326008)(8676002)(9686003)(2906002)(41300700001)(6506007)(66946007)(54906003)(7696005)(53546011)(66476007)(55016003)(26005)(83380400001)(86362001)(122000001)(71200400001)(33656002)(7416002)(478600001)(966005)(316002)(8936002)(19627235002)(6916009)(5660300002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3NIODdhQlFnWXRPSkxqK0NOZVVZYVp6T3JSQzdXM1N3azUrRGo4SHo5MmZD?=
 =?utf-8?B?N0s5elo1VVVwRUJnYSswTi9HSWZ5SUN4NUN3anNrMGFTY1pEeURLeWJ2RUtC?=
 =?utf-8?B?WGc3b1crYnFaZ0pQSkpHdWlWSGtlanFZUFpUYUNpYXNZQ09oWmMwd0RBckFE?=
 =?utf-8?B?QzFtdE1xM2xQZnpmL3hJZnF5K2lWemFlVS9xblNUVEZKaHA2aXBFREwwdmkw?=
 =?utf-8?B?cnpsUEttRUJkSkJFWE9SdnBtK2U3ZEtuUGN4KzFvbVlyUHpRSE96emlYaWtv?=
 =?utf-8?B?YTVobGpMK0VSRkdjbnR4Q2tnMU1tY1BQT3lDaVpONm00TmlZY2V3clFsUlpi?=
 =?utf-8?B?dWxHQ2N0bXZYNkUzQ1VxY3dQTEt3QWh3dkJjUDl4UTlpRHdyMENDYmxXMDZT?=
 =?utf-8?B?WDVUU0hjZmJJZ3kwMmVJMUlScEl6aVloOHNYTVBFb1Y1ZmY0dC9MZGhkUVBK?=
 =?utf-8?B?QVpvZmVZR1k3aFB5ZGg1UU9VaHZNdm1Vb25PRjhoTGRHRVhxaE5NdU5iR1Vh?=
 =?utf-8?B?ZlgxMmRJQUNFSXl6cnNjWklUaUhmM0FwNmZ2aTdSc2hJam5WWTFZSVFWR0Rl?=
 =?utf-8?B?cHRsL2daam9zQlo1Rnc2MjZ6emRieXZVVWlSYUpjcHZQMFlNenFUL1JtZmFZ?=
 =?utf-8?B?VzFyMEFnUGZJZVZjQ21MSzdMQjAvaEFJd0Q0RTlHbHRrY0FsRHh1UkFEdUtv?=
 =?utf-8?B?V1Y3VmhFSlBkNGxEMmVET2QzYjhGZUNLR3lCdkZhR2dzVHlxbldsVm9VeldZ?=
 =?utf-8?B?QXN4YTU0WVVrLzVQQUp0dU9vdlZuN0gwYzR1WkpILzRBZTY2SFhvRzVTbHVv?=
 =?utf-8?B?NlNJZm9QYy9MaDlSeDFwK2s3MUdHbG1DVlF5V1o2Yktwck9ab1R6emVpbG1T?=
 =?utf-8?B?a2xtQlpFTHcwRWJaZlZKR3RtNmhNcHpSWk9qWDdmRjZ5VnhBU1VlWnl6b2Vu?=
 =?utf-8?B?V094OVdLd04rSnV6aDh3eG1pN0h6aXJnb0NNWWIyYXlMQ0hhcnJ1QXZJNGZt?=
 =?utf-8?B?TklYUzF1MUdBbGhHdWdpaG5ydjhBRmZLTG1aNk1CMG56a0YrK1pMbUw4ajJG?=
 =?utf-8?B?b1FwUWtscUJxUmNSWFpJQmk5Y2ZvQi9QTU5DaVRkWXdYWllGMXJJM2lGaUFu?=
 =?utf-8?B?QmtQMS9rVTBuWkJ4YXU0TWYvOXFaaWN3OXowQWxTMTlITlNSWDNYUnNXUDFz?=
 =?utf-8?B?RlhjK25IUjcrbzVSWkY3UWR3Zm9rNVhoTDYvWTNVSjZqTSs5eURSbEdPZXRn?=
 =?utf-8?B?dFpsOGJkRWlMM254UWZpbWlpRVNKWFdWRUxYS29QdG9TMWVSQUo2YWovck5D?=
 =?utf-8?B?d0FvY2ZJU2pjTll1QmlkeW1YaHRxdVBkUW1GVzJ6OXVuWEVhNkxhTzg0YVRZ?=
 =?utf-8?B?djhQcE5reGxUNFc3R0JxQjRxeXVVdlN5SmFudzlLQTMxc29TNjl6WWlMQWFz?=
 =?utf-8?B?MHRzeVpqamtxOTY2U2Y3ZE5WWE9WYlBiMVM0MDhGaXJzMnJHZ1U3QlZPWkVs?=
 =?utf-8?B?ZUZmMW5NRGp3RjR1ZWdiZnZVNmVpWUVCdHUvdytnVFR0SmpsSlpBS2NZaVgw?=
 =?utf-8?B?UGdsY2FWbmVwcndJTmZsUW1FcWR6SU5iSHoxTzRSVTRBYUJpMFNQU05UOHNS?=
 =?utf-8?B?d1hzVHNDenpSWmxOYUVzSm1YdEdTMHJsMTU3VU8yNUJwcDF0ZDV3YWF3WVc4?=
 =?utf-8?B?Q055Q3JOQThvTWFTK3Arb0FmTDlVcENURi9vcU9CV2xyR2V1MFFZMVNncEEr?=
 =?utf-8?B?YzliVXVTb0RuLzR1TFpjbVFaVnQ1WW82K1hpQmhZWmt5b29QRkh2QmI2K2xB?=
 =?utf-8?B?MklzSFMrK1A1R08rRjB4bEN5eFRITFQ0ckJyUUY1WUNTa0FIOHRJWTdwbzhK?=
 =?utf-8?B?QUFYT1poOFkxZ3lyV2E3bDlNSU15c1FRRjk2MEFZYzI0SUYxSVZRNTRvaW1y?=
 =?utf-8?B?ZW1DeFVSWXFpcUxpNDBCVjVlWjBBL2tLSUpiQkJKOGtnMlB6YVBYcVpDUk14?=
 =?utf-8?B?NTlZR3B1Q05vUzB0VUViRVd5TnhkZlVuQTBYOG9halBPZ0R3SEh6YjJwdmx3?=
 =?utf-8?B?SWdMUDlrSnExR1E1MWtVLzdBTWg1NnNoSkdHZ0pFOHVEa1R6OXhkMncxNUR0?=
 =?utf-8?Q?f/ld3KsqVLJj5bNe3CwW9aQqw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR18MB4251.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1576ff78-6824-4d58-0192-08da73c848d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2022 14:15:27.8410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PO7hhMfj2wY4ankYzt8Hob6yHuU2rvKOWZMUGunFSqxban9OWUdhTIOT+obetuIUf77NeJsHvMxcqQxSU2Wxpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR18MB2273
X-Proofpoint-GUID: VoEovDGBgZ_HikSCgQEWgaOw7VOZ1SIt
X-Proofpoint-ORIG-GUID: VoEovDGBgZ_HikSCgQEWgaOw7VOZ1SIt
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

SGksDQoNCkFzIGZpcnN0IHN0ZXAsIHBsZWFzZSB0cnkgdG8gaW5jcmVhc2UgdGhlIGRlbGF5IHRv
IDEwMG1zLCBzZWUgaWYgaXQgaGVscHMuDQoNCkVsYWQuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQpGcm9tOiBQYWxpIFJvaMOhciA8cGFsaUBrZXJuZWwub3JnPiANClNlbnQ6IE1vbmRh
eSwgQXVndXN0IDEsIDIwMjIgNToxMyBQTQ0KVG86IEVsYWQgTmFjaG1hbiA8ZW5hY2htYW5AbWFy
dmVsbC5jb20+DQpDYzogV29qY2llY2ggQmFydGN6YWsgPHdiYXJ0Y3pha0BtYXJ2ZWxsLmNvbT47
IE1hcmVrIEJlaMO6biA8a2FiZWxAa2VybmVsLm9yZz47IFZpcmVzaCBLdW1hciA8dmlyZXNoLmt1
bWFyQGxpbmFyby5vcmc+OyBHcmVnb3J5IENMRU1FTlQgPGdyZWdvcnkuY2xlbWVudEBib290bGlu
LmNvbT47IFJvYmVydCBNYXJrbyA8cm9iZXJ0Lm1hcmtvQHNhcnR1cmEuaHI+OyBUb21hc3ogTWFj
aWVqIE5vd2FrIDx0bW41MDVAZ21haWwuY29tPjsgQW5kZXJzIFRyaWVyIE9sZXNlbiA8YW5kZXJz
LnRyaWVyLm9sZXNlbkBnbWFpbC5jb20+OyBQaGlsaXAgU29hcmVzIDxwaGlsaXBzQG5ldGlzZW5z
ZS5jb20+OyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc7IFNlYmFzdGlhbiBIZXNzZWxiYXJ0aCA8
c2ViYXN0aWFuLmhlc3NlbGJhcnRoQGdtYWlsLmNvbT47IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZzsgbm5ldCA8bm5ldEBmYXN0bWFpbC5mbT4NClN1YmplY3Q6IFJlOiBbRVhU
XSBSZTogW1BBVENIIHYyXSBjcHVmcmVxOiBhcm1hZGEtMzd4eDogZm9yYmlkIGNwdWZyZXEgZm9y
IDEuMiBHSHogdmFyaWFudA0KDQpIZWxsbyBFbGFkIGFuZCB0aGFuayB5b3UgZm9yIHJlc3BvbnNl
IQ0KDQpUaGlzIGVycmF0YSBpcyBhbHJlYWR5IGltcGxlbWVudGVkIGluIHRoZSBrZXJuZWwgZm9y
IGEgbG9uZ2VyIHRpbWUgYnkgR3JlZ29yeSdzIGNvbW1pdDoNCmh0dHBzOi8vdXJsZGVmZW5zZS5w
cm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fZ2l0Lmtlcm5lbC5vcmdfcHViX3NjbV9s
aW51eF9rZXJuZWxfZ2l0X3N0YWJsZV9saW51eC5naXRfY29tbWl0Xy0zRmlkLTNENjFjNDBmMzVm
NWNkNmY2N2NjYmQ3MzE5YTE3MjJlYjc4YzgxNTk4OSZkPUR3SURhUSZjPW5LaldlYzJiNlIwbU95
UGF6N3h0ZlEmcj1lVGVOVExFSzUtVHhYY3pqT2NLUGhBTklGdGxCOXBQNGxxOXFoZGxGcndRJm09
LUUtQXdCOVNUVng4eGdhcGFDTlNwREpJUFBua3J6cldrWlgwdUZ6MmJmTkdGbmNrWmVsVF9YYW92
VVVQck5JZyZzPTRFVWNkRFdCX2dxbkVWOG5SRVFpOUVfaXltNWJqb002bDV6THJiaF9HVnMmZT0g
DQoNClRoZXJlIGlzIGFsc28gMjBtcyBkZWxheSBhZnRlciBMMi9MMyB0byBMMSBzdGF0ZSBzd2l0
Y2guDQoNCkFueSBpZGVhIHdoYXQgY291bGQgYmUgd3JvbmcgaGVyZT8gT3IgaXMgc29tZXRoaW5n
IG1vcmUgdGhhbiBhYm92ZSBjb21taXQgbmVlZGVkIHRvIGNvcnJlY3RseSBpbXBsZW1lbnQgdGhh
dCBlcnJhdGE/DQoNCk9uIE1vbmRheSAwMSBBdWd1c3QgMjAyMiAxNDowMTowNyBFbGFkIE5hY2ht
YW4gd3JvdGU6DQo+IEhpIFBhbGksDQo+IA0KPiBUaGVyZSBpcyBhbiBlcnJhdGEgZm9yIHRoYXQu
DQo+IA0KPiAiDQo+IFN3aXRjaGluZyBmcm9tIEwyL0wzIHN0YXRlICgyMDAvMzAwIE1IeikgdG8g
TDAgc3RhdGUgKDEyMDAgTUh6KSANCj4gcmVxdWlyZXMgc3VkZGVuIGNoYW5nZXMgb2YgVkREIHN1
cHBseSwgYW5kIGl0IHJlcXVpcmVzIHRpbWUgdG8gDQo+IHN0YWJpbGl6ZSB0aGUgVkREIHN1cHBs
eS4gVGhlIHNvbHV0aW9uIGlzIHRvIHVzZSBncmFkdWFsIHN3aXRjaGluZyBmcm9tIEwyL0wzIHRv
IEwxIGFuZCB0aGVuIEwxIHRvIEwwIHN0YXRlLg0KPiAiDQo+IA0KPiBJIHdvdWxkIGFsc28gYWRk
IGFkZGl0aW9uYWwgZGVsYXkgZm9yIHRoZSBWREQgc3VwcGx5IHN0YWJpbGl6YXRpb24uDQo+IA0K
PiBGWUksDQo+IA0KPiBFbGFkLg0KPiANCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
RnJvbTogUGFsaSBSb2jDoXIgPHBhbGlAa2VybmVsLm9yZz4NCj4gU2VudDogTW9uZGF5LCBBdWd1
c3QgMSwgMjAyMiAzOjM2IFBNDQo+IFRvOiBFbGFkIE5hY2htYW4gPGVuYWNobWFuQG1hcnZlbGwu
Y29tPjsgV29qY2llY2ggQmFydGN6YWsgDQo+IDx3YmFydGN6YWtAbWFydmVsbC5jb20+DQo+IENj
OiBNYXJlayBCZWjDum4gPGthYmVsQGtlcm5lbC5vcmc+OyBWaXJlc2ggS3VtYXIgDQo+IDx2aXJl
c2gua3VtYXJAbGluYXJvLm9yZz47IEdyZWdvcnkgQ0xFTUVOVCANCj4gPGdyZWdvcnkuY2xlbWVu
dEBib290bGluLmNvbT47IFJvYmVydCBNYXJrbyA8cm9iZXJ0Lm1hcmtvQHNhcnR1cmEuaHI+OyAN
Cj4gVG9tYXN6IE1hY2llaiBOb3dhayA8dG1uNTA1QGdtYWlsLmNvbT47IEFuZGVycyBUcmllciBP
bGVzZW4gDQo+IDxhbmRlcnMudHJpZXIub2xlc2VuQGdtYWlsLmNvbT47IFBoaWxpcCBTb2FyZXMg
DQo+IDxwaGlsaXBzQG5ldGlzZW5zZS5jb20+OyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc7IFNl
YmFzdGlhbiANCj4gSGVzc2VsYmFydGggPHNlYmFzdGlhbi5oZXNzZWxiYXJ0aEBnbWFpbC5jb20+
OyANCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBubmV0IDxubmV0QGZh
c3RtYWlsLmZtPg0KPiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIHYyXSBjcHVmcmVxOiBhcm1h
ZGEtMzd4eDogZm9yYmlkIGNwdWZyZXEgZm9yIA0KPiAxLjIgR0h6IHZhcmlhbnQNCj4gDQo+IEV4
dGVybmFsIEVtYWlsDQo+IA0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICsgRWxhZCBhbmQgV29qY2llY2gg
ZnJvbSBNYXJ2ZWxsDQo+IA0KPiBDb3VsZCB5b3UgcGxlYXNlIGxvb2sgYXQgdGhpcyBpc3N1ZSBh
bmQvb3IgZm9yd2FyZCBpdCB0byByZWxldmFudCBNYXJ2ZWxsIHRlYW0/DQo+IA0KPiBNYWludGFp
bmVyIFZpcmVzaCBhbHJlYWR5IHdyb3RlIHRoYXQgd2UgY2Fubm90IGhhbmcgZm9yZXZlciBmb3Ig
TWFydmVsbCBhbmQgcGF0Y2ggd2hpY2ggZGlzYWJsZXMgc3VwcG9ydCBmb3IgMS4yIEdIeiB3YXMg
bWVyZ2VkOg0KPiBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0
cHMtM0FfX2xvcmUua2VybmVsLm9yZ19sDQo+IGludXgtMkRwbV8yMDIxMDgwOTA0MDIyNC5qMnJ2
b3BtbXFkYTN1dGM1LTQwdmlyZXNoay0yRGk3XyZkPUR3SURhUSZjPW4NCj4gS2pXZWMyYjZSMG1P
eVBhejd4dGZRJnI9ZVRlTlRMRUs1LVR4WGN6ak9jS1BoQU5JRnRsQjlwUDRscTlxaGRsRnJ3USZt
PQ0KPiA1bk1NS3lLT09NM1hkTWVfUGVyWlJ4OEw3LUQ3TWtXaENsN0d4cFhUUGlvdFZmMVRSNGo4
djNicGpRbVJLQ0xDJnM9Y1hpDQo+IENaQnlrbmZ6MXJPSWdKbDRmSkhsMUtMTFJxMnNoSHVsMi1W
UHBZUDAmZT0NCj4gDQo+IE9uIFN1bmRheSAwOCBBdWd1c3QgMjAyMSAyMTozMDoyNiBQYWxpIFJv
aMOhciB3cm90ZToNCj4gPiBHZW50bGUgcmVtaW5kZXIuIFRoaXMgaXMgcmVhbGx5IHNlcmlvdXMg
aXNzdWUuIENvdWxkIHlvdSBwbGVhc2UgbG9vayBhdCBpdD8NCj4gPiANCj4gPiBBZGRpbmcgbW9y
ZSBNYXJ2ZWxsRW1iZWRkZWRQcm9jZXNzb3JzIHBlb3BsZSB0byB0aGUgbG9vcDogRXZhbiwgDQo+
ID4gQmVuamFtaW4gYW4gSWdhbA0KPiA+IA0KPiA+IE9uIFRodXJzZGF5IDE1IEp1bHkgMjAyMSAy
MTozMzoyMSBQYWxpIFJvaMOhciB3cm90ZToNCj4gPiA+IFBpbmchIEdlbnRsZSByZW1pbmRlciBm
b3IgTWFydmVsbCBwZW9wbGUuDQo+ID4gPiANCj4gPiA+IE9uIFRodXJzZGF5IDA4IEp1bHkgMjAy
MSAxNjozNDo1MSBQYWxpIFJvaMOhciB3cm90ZToNCj4gPiA+ID4gS29uc3RhbnRpbiwgTmFkYXYs
IEtlbiwgVmljdG9yLCBKYXNvbjogVGhpcyBpc3N1ZSBpcyBwcmV0dHkgDQo+ID4gPiA+IHNlcmlv
dXMsIENQVSBvbiAxLjJHSHogQTM3MjAgaXMgY3Jhc2hpbmcuIENvdWxkIHlvdSBwbGVhc2UgbG9v
ayBhdCBpdD8NCj4gPiA+ID4gDQo+ID4gPiA+IE9uIEZyaWRheSAwMiBKdWx5IDIwMjEgMTg6MzA6
MzUgUGFsaSBSb2jDoXIgd3JvdGU6DQo+ID4gPiA+ID4gK0phc29uIGZyb20gR2xvYmFsU2NhbGUg
YXMgdGhpcyBpc3N1ZSBhZmZlY3RzIEdsb2JhbFNjYWxlIEVzcHJlc3NvYmluIFVsdHJhIGFuZCBW
NyAxLjIgR0h6IGJvYXJkcy4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBPbiBUaHVyc2RheSAwMSBK
dWx5IDIwMjEgMDA6NTY6MDEgTWFyZWsgQmVow7puIHdyb3RlOg0KPiA+ID4gPiA+ID4gVGhlIDEu
MiBHSHogdmFyaWFudCBvZiB0aGUgQXJtYWRhIDM3MjAgU09DIGlzIHVuc3RhYmxlIHdpdGgNCj4g
PiA+ID4gPiA+IERWRlM6IHdoZW4gdGhlIFNPQyBib290cywgdGhlIFdUTUkgZmlybXdhcmUgc2V0
cyBjbG9ja3MgYW5kIA0KPiA+ID4gPiA+ID4gQVZTIHZhbHVlcyB0aGF0IHdvcmsgY29ycmVjdGx5
IHdpdGggMS4yIEdIeiBDUFUgZnJlcXVlbmN5LCANCj4gPiA+ID4gPiA+IGJ1dCByYW5kb20gY3Jh
c2hlcyBvY2N1ciBvbmNlIGNwdWZyZXEgZHJpdmVyIHN0YXJ0cyBzY2FsaW5nLg0KPiA+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gPiBXZSBkbyBub3Qga25vdyBjdXJyZW50bHkgd2hhdCBpcyB0aGUgcmVh
c29uOg0KPiA+ID4gPiA+ID4gLSBpdCBtYXkgYmUgdGhhdCB0aGUgdm9sdGFnZSB2YWx1ZSBmb3Ig
TDAgZm9yIDEuMiBHSHogdmFyaWFudCBwcm92aWRlZA0KPiA+ID4gPiA+ID4gICBieSB0aGUgdmVu
ZG9yIGluIHRoZSBPVFAgaXMgc2ltcGx5IGluY29ycmVjdCB3aGVuIHNjYWxpbmcgDQo+ID4gPiA+
ID4gPiBpcyB1c2VkLA0KPiA+ID4gPiA+ID4gLSBpdCBtYXkgYmUgdGhhdCBzb21lIGRlbGF5IGlz
IG5lZWRlZCBzb21ld2hlcmUsDQo+ID4gPiA+ID4gPiAtIGl0IG1heSBiZSBzb21ldGhpbmcgZWxz
ZS4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gVGhlIG1vc3Qgc2FuZSBzb2x1dGlvbiBub3cg
c2VlbXMgdG8gYmUgdG8gc2ltcGx5IGZvcmJpZCB0aGUgDQo+ID4gPiA+ID4gPiBjcHVmcmVxIGRy
aXZlciBvbiAxLjIgR0h6IHZhcmlhbnQuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFNpZ25l
ZC1vZmYtYnk6IE1hcmVrIEJlaMO6biA8a2FiZWxAa2VybmVsLm9yZz4NCj4gPiA+ID4gPiA+IEZp
eGVzOiA5MmNlNDVmYjg3NWQgKCJjcHVmcmVxOiBBZGQgRFZGUyBzdXBwb3J0IGZvciBBcm1hZGEN
Cj4gPiA+ID4gPiA+IDM3eHgiKQ0KPiA+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gPiBJZiBzb21l
b25lIGZyb20gTWFydmVsbCBjb3VsZCBsb29rIGludG8gdGhpcywgaXQgd291bGQgYmUgDQo+ID4g
PiA+ID4gPiBncmVhdCBzaW5jZSBiYXNpY2FsbHkgMS4yIEdIeiB2YXJpYW50IGNhbm5vdCBzY2Fs
ZSwgd2hpY2ggaXMgDQo+ID4gPiA+ID4gPiBhIGZlYXR1cmUgdGhhdCB3YXMgY2xhaW1lZCB0byBi
ZSBzdXBwb3J0ZWQgYnkgdGhlIFNPQy4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gS2VuIE1h
IC8gVmljdG9yIEd1LCB5b3UgaGF2ZSB3b3JrZWQgb24gY29tbWl0IA0KPiA+ID4gPiA+ID4gaHR0
cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLTNBX19naXRodWIu
DQo+ID4gPiA+ID4gPiBjbw0KPiA+ID4gPiA+ID4gbV9NYXJ2ZWxsRW1iZWRkZWRQcm9jZXNzb3Jz
X2xpbnV4LTJEbWFydmVsbF9jb21taXRfZDY3MTlmZGMyDQo+ID4gPiA+ID4gPiBiMyANCj4gPiA+
ID4gPiA+IGNhYzU4MDY0ZjQxYjUzMWY4Njk5M2M5MTlhYTlhJmQ9RHdJRGFRJmM9bktqV2VjMmI2
UjBtT3lQYXo3eA0KPiA+ID4gPiA+ID4gdGYgDQo+ID4gPiA+ID4gPiBRJnI9ZVRlTlRMRUs1LVR4
WGN6ak9jS1BoQU5JRnRsQjlwUDRscTlxaGRsRnJ3USZtPTVuTU1LeUtPT00NCj4gPiA+ID4gPiA+
IDNYIA0KPiA+ID4gPiA+ID4gZE1lX1BlclpSeDhMNy1EN01rV2hDbDdHeHBYVFBpb3RWZjFUUjRq
OHYzYnBqUW1SS0NMQyZzPWI5Y0RLDQo+ID4gPiA+ID4gPiBlbSB0NzBPaVRKRjZLWGoweVN6Ynhw
c0JfbnV0ZVhKRTg3dmlhODAmZT0NCj4gPiA+ID4gPiA+IGluIGxpbnV4LW1hcnZlbGwuDQo+ID4g
PiA+ID4gPiBZb3VyIHBhdGNoIHRha2VzIGF3YXkgdGhlIDEyMDIgbVYgY29uc3RhbnQgZm9yIDEu
MiBHSHogYmFzZSANCj4gPiA+ID4gPiA+IENQVSBmcmVxdWVuY3kgYW5kIGluc3RlYWQgYWRkcyBj
b2RlIHRoYXQgY29tcHV0ZXMgdGhlIA0KPiA+ID4gPiA+ID4gdm9sdGFnZXMgZnJvbSB0aGUgdm9s
dGFnZSBmb3VuZCBpbiBMMCBBVlMgcmVnaXN0ZXIgKHdoaWNoIGlzIGZpbGxlZCBpbiBieSBXVE1J
IGZpcm13YXJlKS4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gRG8geW91IGtub3cgd2h5IHRo
ZSBjb2RlIGRvZXMgbm90IHdvcmsgY29ycmVjdGx5IGZvciBzb21lIA0KPiA+ID4gPiA+ID4gMS4y
IEdIeiBib2FyZHM/IERvIHdlIG5lZWQgdG8gZm9yY2UgdGhlIEwwIHZvbHRhZ2UgdG8gMTIwMiAN
Cj4gPiA+ID4gPiA+IG1WIGlmIGl0IGlzIGxvd2VyLCBvciBzb21ldGhpbmc/DQo+ID4gPiA+ID4g
PiAtLS0NCj4gPiA+ID4gPiA+ICBkcml2ZXJzL2NwdWZyZXEvYXJtYWRhLTM3eHgtY3B1ZnJlcS5j
IHwgNiArKysrKy0NCj4gPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2NwdWZyZXEvYXJtYWRhLTM3eHgtY3B1ZnJlcS5jDQo+ID4gPiA+ID4gPiBiL2RyaXZl
cnMvY3B1ZnJlcS9hcm1hZGEtMzd4eC1jcHVmcmVxLmMNCj4gPiA+ID4gPiA+IGluZGV4IDNmYzk4
YTNmZmQ5MS4uYzEwZmMzM2IyOWIxIDEwMDY0NA0KPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9j
cHVmcmVxL2FybWFkYS0zN3h4LWNwdWZyZXEuYw0KPiA+ID4gPiA+ID4gKysrIGIvZHJpdmVycy9j
cHVmcmVxL2FybWFkYS0zN3h4LWNwdWZyZXEuYw0KPiA+ID4gPiA+ID4gQEAgLTEwNCw3ICsxMDQs
MTEgQEAgc3RydWN0IGFybWFkYV8zN3h4X2R2ZnMgeyAgfTsNCj4gPiA+ID4gPiA+ICANCj4gPiA+
ID4gPiA+ICBzdGF0aWMgc3RydWN0IGFybWFkYV8zN3h4X2R2ZnMgYXJtYWRhXzM3eHhfZHZmc1td
ID0gew0KPiA+ID4gPiA+ID4gLQl7LmNwdV9mcmVxX21heCA9IDEyMDAqMTAwMCoxMDAwLCAuZGl2
aWRlciA9IHsxLCAyLCA0LCA2fSB9LA0KPiA+ID4gPiA+ID4gKwkvKg0KPiA+ID4gPiA+ID4gKwkg
KiBUaGUgY3B1ZnJlcSBzY2FsaW5nIGZvciAxLjIgR0h6IHZhcmlhbnQgb2YgdGhlIFNPQyBpcyBj
dXJyZW50bHkNCj4gPiA+ID4gPiA+ICsJICogdW5zdGFibGUgYmVjYXVzZSB3ZSBkbyBub3Qga25v
dyBob3cgdG8gY29uZmlndXJlIGl0IHByb3Blcmx5Lg0KPiA+ID4gPiA+ID4gKwkgKi8NCj4gPiA+
ID4gPiA+ICsJLyogey5jcHVfZnJlcV9tYXggPSAxMjAwKjEwMDAqMTAwMCwgLmRpdmlkZXIgPSB7
MSwgMiwgNCwgDQo+ID4gPiA+ID4gPiArNn0gfSwgKi8NCj4gPiA+ID4gPiA+ICAJey5jcHVfZnJl
cV9tYXggPSAxMDAwKjEwMDAqMTAwMCwgLmRpdmlkZXIgPSB7MSwgMiwgNCwgNX0gfSwNCj4gPiA+
ID4gPiA+ICAJey5jcHVfZnJlcV9tYXggPSA4MDAqMTAwMCoxMDAwLCAgLmRpdmlkZXIgPSB7MSwg
MiwgMywgNH0gfSwNCj4gPiA+ID4gPiA+ICAJey5jcHVfZnJlcV9tYXggPSA2MDAqMTAwMCoxMDAw
LCAgLmRpdmlkZXIgPSB7MiwgNCwgNSwgNn0gDQo+ID4gPiA+ID4gPiB9LA0KPiA+ID4gPiA+ID4g
LS0NCj4gPiA+ID4gPiA+IDIuMzEuMQ0KPiA+ID4gPiA+ID4gDQo=
