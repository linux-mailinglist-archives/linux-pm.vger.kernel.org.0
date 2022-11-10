Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF1A6246D0
	for <lists+linux-pm@lfdr.de>; Thu, 10 Nov 2022 17:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiKJQXW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Nov 2022 11:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiKJQXV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Nov 2022 11:23:21 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AF41A052;
        Thu, 10 Nov 2022 08:23:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDK7Q0/TLkDJ1kAbmhKrAh+JYW5g6zzagcrgO+IheEpVJz5E+4ZwqEJ8mc6q2Oqf+8WFmABcx7VcjUbfmey+pwapRGxaMAMFznAqBaDsOlQpsXyB5uOIrOeXvl3BFYNMpSOY0ImhgPtmPZZWo0ck5HqfcSNUUdrF80zQKobyrqxE8W6KgA1lN/O8A994ZYQa1BD6cXtmelKsJp18gUnfaZG/eNdfuq9z3A8sb3b1rYX6r4rmb3UfuENs4NlcpCa3fkBx+/Z7Zyrtg3kIBWydXeljGNoBHWfGmhdgCK2RGvC0CXbx/k7NKWW9RjKRU+zevMqW2lYUftnH8fSY1NaZSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1h/9yK79tSkosWR2n1Nr3eQhCghrxpsXO3HIHCxNpA=;
 b=QGY2Lm+fVUk9+nXsNOswuCObh+WQE9GtJYWvhKmchCHEWTETV4FdDWErSsp/RN6IyTVWaiHBe9YwAUbmsqXURz/Iox9EcGE1FzQF/AhS4ATVKMSUMpEnCDGMybsinEp0qGaiOlM5U+12uCAbtgHoEjGxam/f4tIo0E5fp6iMJ5FsgNIFqKeo76o1zMTlNSKP3LWMTS+NP/XXsxFWSau7XknTMcsRsAUge2VWqr5tkXta2cR0GcUjk4dpldUJXXMSqZPUNWJKENkEV+ux1O8X3jo8YXzwRLrBCEeYD1hiBkEdt+9SU9LdzxC1aT9xtsyW8i1GgjlX+Ht2wVp6JONtVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1h/9yK79tSkosWR2n1Nr3eQhCghrxpsXO3HIHCxNpA=;
 b=I4TRUCT106xrP+38YIVaGh5J8z00+/Zcjo64xEuUbLhQS7SqZ/wzKHT5II/gcH2MLc/QYeugbu9mF/5Lp8DjwblLvW0wd2fOEuDoYBFzXif2/RP3YJKTGafAIjWCQ2O7vGJakq2n2TW8M8FXlrPfE4b17kIkpN5t0aOh6uA8PXA=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Thu, 10 Nov
 2022 16:23:17 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::514f:bcdf:d10f:fedf]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::514f:bcdf:d10f:fedf%8]) with mapi id 15.20.5813.013; Thu, 10 Nov 2022
 16:23:17 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/8] ACPI: CPPC: Add AMD pstate energy performance
 preference cppc control
Thread-Topic: [PATCH v3 1/8] ACPI: CPPC: Add AMD pstate energy performance
 preference cppc control
Thread-Index: AQHY8tJ5lkMqqIgvCEa5LoYFwMJCvq4zzFGAgAR1VICAAAUngIAADUeAgAAASsA=
Date:   Thu, 10 Nov 2022 16:23:17 +0000
Message-ID: <DM4PR12MB5278548A2409B9067E5078E39C019@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221107175705.2207842-1-Perry.Yuan@amd.com>
 <20221107175705.2207842-2-Perry.Yuan@amd.com>
 <64836554-7caa-9a3e-3832-a66e87c83bf9@amd.com>
 <CAJZ5v0ik68V6D2tipGH4tepaAmy5bpSy2nZUyAHn=Qia9SCLzA@mail.gmail.com>
 <DM4PR12MB527881961B4BE3F74F503CFE9C019@DM4PR12MB5278.namprd12.prod.outlook.com>
 <CAJZ5v0h3HLp8eLeLJXegSQxiiY-+d3eb8UHh1TE00f-EhBnwZg@mail.gmail.com>
In-Reply-To: <CAJZ5v0h3HLp8eLeLJXegSQxiiY-+d3eb8UHh1TE00f-EhBnwZg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-10T15:56:33Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=501d3889-1228-4a98-a0d3-1029aff5ba8b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-11-10T16:23:13Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: f7eb8bd3-3d32-415e-8881-a83f667884c0
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|IA1PR12MB6604:EE_
x-ms-office365-filtering-correlation-id: 9623bf62-1fb1-4c4f-842f-08dac337e015
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fJfFKaLR9kY0I2v1JGwt30ZhxYNXgQp1TorZ/sTwM170WOwv8qn8s+bmPtt6gYPQ5qOuaT5FOCTtw2N4gRnqaTww7rOLBsEZh27RQrJXgc9NLfdLgx2ncmdJTYwo5tb6I1tH9BPiiyrA37fXbVpB9KFr1dCxYbvF35l7mXYhUB1V+becmgqR4QzSzjDNoP8fYvtWEYzjx9uI43ZWvIpDQQTrH+EaT0mmrDmXjb5IiMaIVhbzoH+XATzuwjagBZVtwl+XK1TiPcEaVBzlceC9v43t8xjtfSlBEmdGD20hWaSV9aPvUtVQJG2YpCvTTh7blbLL++cWLAwbcq3oy5P0avahK3F5N8QxKy4Xg/CuK7IWT6tHy6EPwuuHbQ5Ec0dvET4Jyd7pcHcPnBjh5J7Mp8EFtNpK7MgaBftfPsYK8HaToo1W8le6REAReIeZWf263eQh/N6NgrxFX413q04BHIGooaHZuRxZslD6u8PxYBzUKQgSQRqaMBRLj44p813haYXgMIJVBhg2EXKgSqkPjL3iM2dZjUBnCvjSIqhHvCKja23g5c8VM20q6O5U9EW7ee3Y9gcx6Anyoz/K+/0/RRYzTqqh9KgG377FJFxH3RHWUjfWgTtqqlZsMwp7s1E1oSq5dqkmiXcONqCIpl6VtMLT2ZrwHRroapOdz/9nBXof2uwGl/ivLCSKCfPfVJ23p8aurXOuArNfL5FHX1S+o1G2FPZNS/ep5goKG8Yo3/F4qv67RvKMJ/+DdYv59lqtXvOHMqFIzhYM1kFvZikj5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(451199015)(478600001)(6506007)(53546011)(7696005)(316002)(54906003)(6916009)(86362001)(66476007)(186003)(5660300002)(8936002)(52536014)(41300700001)(33656002)(2906002)(64756008)(66556008)(66946007)(4326008)(8676002)(66446008)(76116006)(9686003)(26005)(83380400001)(55016003)(38070700005)(71200400001)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0d3OGtUYkZWN0pscVdnSEZ2RjhFZlFIdHV2eHBTc0FoSzZiZHp0ZVcwWW9o?=
 =?utf-8?B?OWJhbzk4bEw3S1hiY3B3VUZjSnFMc3BqcURJK0RaY3o4UnRMT1BWNlh5R05h?=
 =?utf-8?B?eWtLK2xHdFJOWDFvZkZ6TlhTdm9waUJZbDVBaXdKVVhZa00vaFBraXk4dUp2?=
 =?utf-8?B?OElLYmZoemROUnRqNWRzMjNoOEhQWlBWcUF0d3ZsekNTYTRqcWFmR3kvb3Uz?=
 =?utf-8?B?OUd4L0pRNk1OeDlsRFZ3eGorTlRrbVM4NVlqc0ZBL3V6ZFRsWCtGSUZrREQv?=
 =?utf-8?B?c0FTLzRZRkJFWHVZaTNsSWJRNTdRV3A2R0VLa2czZzlUSHZFa05qcW40dGpJ?=
 =?utf-8?B?RlRzeVdXTGVQS0tJVHJaaWgvNG41MjB3YVRiekRRVGYvTlBHcUdvRGlkWmxp?=
 =?utf-8?B?TE5ibmlBYjBLdWR1ZE1hdUdBa0JJZENMYXBpeVpMZldxbTlRaGZBd0ZhQ2pX?=
 =?utf-8?B?TmQvWjlTcWNhVXdJY2x3TExNNkZtK1pzZ2RrR2JzTGlGMFVPWHBXT25UVmJj?=
 =?utf-8?B?L29iTUt3SzRKbHdQUXFwWnQzQndCT28vNE5MNy9OS1BaN1BpaXh2WTJtWDl0?=
 =?utf-8?B?Q3Y1YXQyb3BZeTkyeStONjFZdFNPYXpqamliNXpORmNnWkFWSVpic0VnelVv?=
 =?utf-8?B?dlhvRjRTTVJYcGxwRjlBSTQwRGFsZTN1YkR5eEkzblFCY2FXT3cvY0lVNG9G?=
 =?utf-8?B?emJYZGdodFlVejVjU1BLR0UzVjFoVWEwR2NBdG1qckhxZExPYzczcWw3empC?=
 =?utf-8?B?bFdPOThZQUpwYjRMdGVPeUVWRnJ5VTZtUGJBYW4zRGg3SlRzV29rdlFQWnJh?=
 =?utf-8?B?SmREaXhFVXdrYlhYK29zODNqd1FVcWZFcW9zZWxxbGdsNEo1dFNXMU0vY1RB?=
 =?utf-8?B?VHQ1dmZENGhheGx1SzQ2eFp2b0x4a1VRVXlVUkFBSThndWdQRkI4NTRwQWZQ?=
 =?utf-8?B?ZnpJU0xzNStsQXVKblRTOC9OWTNkR0llazM1bXBXZ0ZBMkRseitKY2tOdjVz?=
 =?utf-8?B?Y2twM1ZzazNJb0orRHBRK0pUN010RnlzbnBLL2lDMkYxdU9wSWtTYUhZK0Jz?=
 =?utf-8?B?K3NSMU1ZYkptK1Y1Ykp0ZTlMcGJmd1FvTTJPd2VlSXFMYThMbnlITUhUbU5C?=
 =?utf-8?B?V0d5emtjb0xxZnJ4YkNyVTd4N25VaURGYWl4TW9JVHdvbHc4TitranA5ek50?=
 =?utf-8?B?OXhtL0hDSXBDNVhsN3h5VkdIOUdFOTBvRXlTSnc0emVsaUdHYmZvTFNCZnRZ?=
 =?utf-8?B?TkFTeGpaWEhtRXBqbkRzR09tanR2WUFQeGdCaEYvcmhPTDF2ZXAzaStoelds?=
 =?utf-8?B?eWduREFIS3NuOHdQQzBJb21LLzNQeXJ5QjdnMFdDaUhmMTNvWEZQelg3YzVm?=
 =?utf-8?B?NjVPd2gzV29jYzlQNHA3WUVKc3RDOWhZZGxkaFBxYXZUeHN4NlBDVXlGazN0?=
 =?utf-8?B?NXBkdFJVU2JBblhkU01MaXV6OGNrYmdEMUt5STA0dUVDMVNCYWpTL2hyZElG?=
 =?utf-8?B?RnRMYUdGQU5sTlpublliWDBVcGdEWDlnZ0l4MHZXQnhpakk5eDduY09PY3NC?=
 =?utf-8?B?c21RMVBYZmw0cDFSWnY3NW03K21aOUwzODJQdVd1bVk3RGVZRTIwS3ZxRXI1?=
 =?utf-8?B?aU1SVk81WW9FUWw0MHdhRVBGRnBPdFU0dWNYdGNCVmV0WEFDWUJDdFZlUFFQ?=
 =?utf-8?B?WGw3b2dzb3ROU0lkQVgvdWVXbTRKUTg1Sy9NeFR5ZHBsN0s3Z2pCTElSVEVZ?=
 =?utf-8?B?N3B3V3RSa0VMVjY5dVA0VnFBVUwrcXlOMGNaUnNOeFNlY1BOZ3JnS1FYM0Rh?=
 =?utf-8?B?NDN1dXRpb200eFQ4QTFLUExjNnZwSE9TdExQTHZtekZ4UnkweGx3Y3Z5cWVr?=
 =?utf-8?B?UVVXb2hMSlY0MzdsMnRQUjJncUZwTVdJeDF0Mnh1WDhZeHpqQnlQaWJrSnBx?=
 =?utf-8?B?enlucjdzWk0rQkU3MFZESm1vcUR5Qng1Tjl2Z1dFUTh5WEFibVpMREJJNGFU?=
 =?utf-8?B?SWJPMC8rTVZJcFpQbjJOQythYWo1dWVXY2l1RjNVK29rcnZYVFJsL0s4QTFS?=
 =?utf-8?B?QXl0STBKemRvSFBGcnhDTDJjcExrVWM2bGg5YzFlV2k5UzRxUDNsMGZtekdr?=
 =?utf-8?Q?9MSZDML7g8gpQZo9Aq+IS92fD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9623bf62-1fb1-4c4f-842f-08dac337e015
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2022 16:23:17.6158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UrrXhRCPrwTZPWrtMmAvEaEGwrLjxEXnOIuSNVd2wlTPswo8R27BhjzkYjMb7pVHm0GjvkCxqXW9112Jpf+1LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6604
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIFJhZmFlbC4gDQoNCj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFl
bEBrZXJuZWwub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgMTAsIDIwMjIgMTE6NTYg
UE0NCj4gVG86IFl1YW4sIFBlcnJ5IDxQZXJyeS5ZdWFuQGFtZC5jb20+DQo+IENjOiBSYWZhZWwg
Si4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+OyBMaW1vbmNpZWxsbywgTWFyaW8NCj4gPE1h
cmlvLkxpbW9uY2llbGxvQGFtZC5jb20+OyByYWZhZWwuai53eXNvY2tpQGludGVsLmNvbTsgSHVh
bmcsIFJheQ0KPiA8UmF5Lkh1YW5nQGFtZC5jb20+OyB2aXJlc2gua3VtYXJAbGluYXJvLm9yZzsg
U2hhcm1hLCBEZWVwYWsNCj4gPERlZXBhay5TaGFybWFAYW1kLmNvbT47IEZvbnRlbm90LCBOYXRo
YW4NCj4gPE5hdGhhbi5Gb250ZW5vdEBhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxB
bGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgSHVhbmcsIFNoaW1tZXINCj4gPFNoaW1tZXIuSHVh
bmdAYW1kLmNvbT47IER1LCBYaWFvamlhbiA8WGlhb2ppYW4uRHVAYW1kLmNvbT47IE1lbmcsDQo+
IExpIChKYXNzbWluZSkgPExpLk1lbmdAYW1kLmNvbT47IGxpbnV4LXBtQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2MyAxLzhdIEFDUEk6IENQUEM6IEFkZCBBTUQgcHN0YXRlIGVuZXJneQ0KPiBwZXJmb3JtYW5j
ZSBwcmVmZXJlbmNlIGNwcGMgY29udHJvbA0KPiANCj4gQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9y
aWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBTb3VyY2UuIFVzZSBwcm9wZXINCj4gY2F1dGlvbiB3
aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNsaWNraW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0K
PiANCj4gDQo+IE9uIFRodSwgTm92IDEwLCAyMDIyIGF0IDQ6NTIgUE0gWXVhbiwgUGVycnkgPFBl
cnJ5Lll1YW5AYW1kLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5
IC0gR2VuZXJhbF0NCj4gPg0KPiA+DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+ID4gPiBGcm9tOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+DQo+
ID4gPiBTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgMTAsIDIwMjIgMTA6NTAgUE0NCj4gPiA+IFRv
OiBMaW1vbmNpZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+OyBZdWFuLCBQ
ZXJyeQ0KPiA+ID4gPFBlcnJ5Lll1YW5AYW1kLmNvbT4NCj4gPiA+IENjOiByYWZhZWwuai53eXNv
Y2tpQGludGVsLmNvbTsgSHVhbmcsIFJheSA8UmF5Lkh1YW5nQGFtZC5jb20+Ow0KPiA+ID4gdmly
ZXNoLmt1bWFyQGxpbmFyby5vcmc7IFNoYXJtYSwgRGVlcGFrIDxEZWVwYWsuU2hhcm1hQGFtZC5j
b20+Ow0KPiA+ID4gRm9udGVub3QsIE5hdGhhbiA8TmF0aGFuLkZvbnRlbm90QGFtZC5jb20+OyBE
ZXVjaGVyLCBBbGV4YW5kZXINCj4gPiA+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgSHVh
bmcsIFNoaW1tZXINCj4gPFNoaW1tZXIuSHVhbmdAYW1kLmNvbT47DQo+ID4gPiBEdSwgWGlhb2pp
YW4gPFhpYW9qaWFuLkR1QGFtZC5jb20+OyBNZW5nLCBMaSAoSmFzc21pbmUpDQo+ID4gPiA8TGku
TWVuZ0BhbWQuY29tPjsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gPiA+IGtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMS84XSBB
Q1BJOiBDUFBDOiBBZGQgQU1EIHBzdGF0ZSBlbmVyZ3kNCj4gPiA+IHBlcmZvcm1hbmNlIHByZWZl
cmVuY2UgY3BwYyBjb250cm9sDQo+ID4gPg0KPiA+ID4gQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9y
aWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBTb3VyY2UuIFVzZSBwcm9wZXINCj4gPiA+IGNhdXRp
b24gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGlu
Zy4NCj4gPiA+DQo+ID4gPg0KPiA+ID4gT24gTW9uLCBOb3YgNywgMjAyMiBhdCA3OjQ0IFBNIExp
bW9uY2llbGxvLCBNYXJpbw0KPiA+ID4gPG1hcmlvLmxpbW9uY2llbGxvQGFtZC5jb20+IHdyb3Rl
Og0KPiA+ID4gPg0KPiA+ID4gPiBPbiAxMS83LzIwMjIgMTE6NTYsIFBlcnJ5IFl1YW4gd3JvdGU6
DQo+ID4gPiA+ID4gQWRkIHRoZSBFUFAoRW5lcmd5IFBlcmZvcm1hbmNlIFByZWZlcmVuY2UpIHN1
cHBvcnQgZm9yIHRoZSBBTUQNCj4gPiA+ID4gPiBTb0NzIHdpdGhvdXQgdGhlIGRlZGljYXRlZCBD
UFBDIE1TUiwgdGhvc2UgU29DcyBuZWVkIHRvIGFkZCB0aGlzDQo+ID4gPiA+ID4gY3BwYyBhY3Bp
IGZ1bmN0aW9ucyB0byB1cGRhdGUgRVBQIHZhbHVlcyBhbmQgZGVzaXJlZCBwZXJmIHZhbHVlLg0K
PiA+ID4gPg0KPiA+ID4gPiBBcyBmYXIgYXMgSSBjYW4gdGVsbCB0aGlzIGlzIGdlbmVyaWMgY29k
ZS4gIEFsdGhvdWdoIHRoZSByZWFzb24NCj4gPiA+ID4geW91J3JlIHN1Ym1pdHRpbmcgaXQgaXMg
Zm9yIGVuYWJsaW5nIEFNRCBTb0NzLCB0aGUgY29tbWl0IG1lc3NhZ2UNCj4gPiA+ID4gc2hvdWxk
IGJlIHdvcmRlZCBhcyBzdWNoLg0KPiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSW4gb3Jk
ZXIgdG8gZ2V0IEVQUCB3b3JrZWQsIGNwcGNfZ2V0X2VwcF9jYXBzKCkgd2lsbCBxdWVyeSBFUFAN
Cj4gPiA+ID4gPiBwcmVmZXJlbmNlIHZhbHVlIGFuZCBjcHBjX3NldF9lcHBfcGVyZigpIHdpbGwg
c2V0IEVQUCBuZXcgdmFsdWUuDQo+ID4gPiA+ID4gQmVmb3JlIHRoZSBFUFAgd29ya3MsIHBzdGF0
ZSBkcml2ZXIgd2lsbCB1c2UgY3BwY19zZXRfYXV0b19lcHAoKQ0KPiA+ID4gPiA+IHRvIGVuYWJs
ZSBFUFAgZnVuY3Rpb24gZnJvbSBmaXJtd2FyZSBmaXJzdGx5Lg0KPiA+ID4gPg0KPiA+ID4gPiBU
aGlzIGNvdWxkIG1vcmUgc3VjY2luY3RseSBzYXk6DQo+ID4gPiA+DQo+ID4gPiA+ICJBZGQgc3Vw
cG9ydCBmb3Igc2V0dGluZyBhbmQgcXVlcnlpbmcgRVBQIHByZWZlcmVuY2VzIHRvIHRoZQ0KPiA+
ID4gPiBnZW5lcmljIENQUEMgZHJpdmVyLiAgVGhpcyBlbmFibGVzIGRvd25zdHJlYW0gZHJpdmVy
cyBzdWNoIGFzDQo+ID4gPiA+IGFtZC1wc3RhdGUgdG8gZGlzY292ZXIgYW5kIHVzZSB0aGVzZSB2
YWx1ZXMuIg0KPiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogUGVy
cnkgWXVhbiA8UGVycnkuWXVhbkBhbWQuY29tPg0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ICAg
ZHJpdmVycy9hY3BpL2NwcGNfYWNwaS5jIHwgMTI2DQo+ID4gPiArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysNCj4gPiA+ID4gPiAgIGluY2x1ZGUvYWNwaS9jcHBjX2FjcGku
aCB8ICAxNyArKysrKysNCj4gPiA+ID4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTQzIGluc2VydGlv
bnMoKykNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvY3Bw
Y19hY3BpLmMgYi9kcml2ZXJzL2FjcGkvY3BwY19hY3BpLmMNCj4gPiA+ID4gPiBpbmRleCAwOTM2
NzViMWExZmYuLmQ5YzM4ZGVlMWY0OCAxMDA2NDQNCj4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL2Fj
cGkvY3BwY19hY3BpLmMNCj4gPiA+ID4gPiArKysgYi9kcml2ZXJzL2FjcGkvY3BwY19hY3BpLmMN
Cj4gPiA+ID4gPiBAQCAtMTM2NSw2ICsxMzY1LDEzMiBAQCBpbnQgY3BwY19nZXRfcGVyZl9jdHJz
KGludCBjcHVudW0sDQo+ID4gPiA+ID4gc3RydWN0DQo+ID4gPiBjcHBjX3BlcmZfZmJfY3RycyAq
cGVyZl9mYl9jdHJzKQ0KPiA+ID4gPiA+ICAgfQ0KPiA+ID4gPiA+ICAgRVhQT1JUX1NZTUJPTF9H
UEwoY3BwY19nZXRfcGVyZl9jdHJzKTsNCj4gPiA+ID4gPg0KPiA+ID4gPiA+ICsvKioNCj4gPiA+
ID4gPiArICogY3BwY19nZXRfZXBwX2NhcHMgLSBHZXQgdGhlIGVuZXJneSBwcmVmZXJlbmNlIHJl
Z2lzdGVyIHZhbHVlLg0KPiA+ID4gPiA+ICsgKiBAY3B1bnVtOiBDUFUgZnJvbSB3aGljaCB0byBn
ZXQgZXBwIHByZWZlcmVuY2UgbGV2ZWwuDQo+ID4gPiA+ID4gKyAqIEBwZXJmX2NhcHM6IFJldHVy
biBhZGRyZXNzLg0KPiA+ID4gPiA+ICsgKg0KPiA+ID4gPiA+ICsgKiBSZXR1cm46IDAgZm9yIHN1
Y2Nlc3MsIC1FSU8gb3RoZXJ3aXNlLg0KPiA+ID4gPiA+ICsgKi8NCj4gPiA+ID4gPiAraW50IGNw
cGNfZ2V0X2VwcF9jYXBzKGludCBjcHVudW0sIHN0cnVjdCBjcHBjX3BlcmZfY2Fwcw0KPiA+ID4g
PiA+ICsqcGVyZl9jYXBzKSB7DQo+ID4gPiA+ID4gKyAgICAgc3RydWN0IGNwY19kZXNjICpjcGNf
ZGVzYyA9IHBlcl9jcHUoY3BjX2Rlc2NfcHRyLCBjcHVudW0pOw0KPiA+ID4gPiA+ICsgICAgIHN0
cnVjdCBjcGNfcmVnaXN0ZXJfcmVzb3VyY2UgKmVuZXJneV9wZXJmX3JlZzsNCj4gPiA+ID4gPiAr
ICAgICB1NjQgZW5lcmd5X3BlcmY7DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsgICAgIGlmICgh
Y3BjX2Rlc2MpIHsNCj4gPiA+ID4gPiArICAgICAgICAgICAgIHByX3dhcm4oIk5vIENQQyBkZXNj
cmlwdG9yIGZvciBDUFU6JWRcbiIsIGNwdW51bSk7DQo+ID4gPiA+ID4gKyAgICAgICAgICAgICBy
ZXR1cm4gLUVOT0RFVjsNCj4gPiA+ID4gPiArICAgICB9DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+
ICsgICAgIGVuZXJneV9wZXJmX3JlZyA9ICZjcGNfZGVzYy0+Y3BjX3JlZ3NbRU5FUkdZX1BFUkZd
Ow0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArICAgICBpZiAoIUNQQ19TVVBQT1JURUQoZW5lcmd5
X3BlcmZfcmVnKSkNCj4gPiA+ID4gPiArICAgICAgICAgICAgIHByX3dhcm4oImVuZXJneSBwZXJm
IHJlZyB1cGRhdGUgaXMNCj4gPiA+ID4gPiArIHVuc3VwcG9ydGVkIVxuIik7DQo+ID4gPiA+DQo+
ID4gPiA+IE5vIG5lZWQgdG8gYWRkIGEgZXhwbGFuYXRpb24gcG9pbnQgYXQgdGhlIGVuZC4NCj4g
PiA+ID4NCj4gPiA+ID4gQXMgdGhpcyBpcyBhIHBlci1DUFUgbWVzc2FnZSBJIHdvbmRlciBpZiB0
aGlzIHdvdWxkIGJlIGJldHRlciBhcw0KPiA+ID4gPiBwcl93YXJuX29uY2UoKT8gIE90aGV3cmlz
ZSBzb21lIHN5c3RlbXMgd2l0aCBsYXJnZSBudW1iZXJzIG9mDQo+ID4gPiA+IGNvcmVzIG1pZ2h0
IHBvdGVudGlhbGx5IHNob3cgdGhpcyBtZXNzYWdlIHF1aXRlIGEgZmV3IHRpbWVzLg0KPiA+ID4N
Cj4gPiA+IHByX2luZm9fb25jZSgpIHdvdWxkIHN1ZmZpY2UgSU1PLg0KPiA+DQo+ID4gRml4ZWQg
aW4gVjQuDQo+ID4NCj4gPiA+DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsgICAgIGlmIChDUENf
SU5fUENDKGVuZXJneV9wZXJmX3JlZykpIHsNCj4gPiA+ID4gPiArICAgICAgICAgICAgIGludCBw
Y2Nfc3NfaWQgPSBwZXJfY3B1KGNwdV9wY2Nfc3Vic3BhY2VfaWR4LCBjcHVudW0pOw0KPiA+ID4g
PiA+ICsgICAgICAgICAgICAgc3RydWN0IGNwcGNfcGNjX2RhdGEgKnBjY19zc19kYXRhID0gTlVM
TDsNCj4gPiA+ID4gPiArICAgICAgICAgICAgIGludCByZXQgPSAwOw0KPiA+ID4gPiA+ICsNCj4g
PiA+ID4gPiArICAgICAgICAgICAgIGlmIChwY2Nfc3NfaWQgPCAwKQ0KPiA+ID4gPiA+ICsgICAg
ICAgICAgICAgICAgICAgICByZXR1cm4gLUVOT0RFVjsNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4g
KyAgICAgICAgICAgICBwY2Nfc3NfZGF0YSA9IHBjY19kYXRhW3BjY19zc19pZF07DQo+ID4gPiA+
ID4gKw0KPiA+ID4gPiA+ICsgICAgICAgICAgICAgZG93bl93cml0ZSgmcGNjX3NzX2RhdGEtPnBj
Y19sb2NrKTsNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKyAgICAgICAgICAgICBpZiAoc2VuZF9w
Y2NfY21kKHBjY19zc19pZCwgQ01EX1JFQUQpID49IDApIHsNCj4gPiA+ID4gPiArICAgICAgICAg
ICAgICAgICAgICAgY3BjX3JlYWQoY3B1bnVtLCBlbmVyZ3lfcGVyZl9yZWcsICZlbmVyZ3lfcGVy
Zik7DQo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgIHBlcmZfY2Fwcy0+ZW5lcmd5X3Bl
cmYgPSBlbmVyZ3lfcGVyZjsNCj4gPiA+ID4gPiArICAgICAgICAgICAgIH0gZWxzZSB7DQo+ID4g
PiA+ID4gKyAgICAgICAgICAgICAgICAgICAgIHJldCA9IC1FSU87DQo+ID4gPiA+ID4gKyAgICAg
ICAgICAgICB9DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsgICAgICAgICAgICAgdXBfd3JpdGUo
JnBjY19zc19kYXRhLT5wY2NfbG9jayk7DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsgICAgICAg
ICAgICAgcmV0dXJuIHJldDsNCj4gPiA+ID4gPiArICAgICB9DQo+ID4gPg0KPiA+ID4gV2hhdCBp
ZiBDUEMgaXMgbm90IGluIFBDQz8NCj4gPiA+DQo+ID4gPiBXb3VsZCByZXR1cm5pbmcgMCB0aGVu
IHdvcmsgZm9yIGFsbCB1c2Vycz8NCj4gPg0KPiA+IEZpeGVkIGluIFY0DQo+ID4NCj4gPiA+DQo+
ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsgICAgIHJldHVybiAwOw0KPiA+ID4gPiA+ICt9DQo+ID4g
PiA+ID4gK0VYUE9SVF9TWU1CT0xfR1BMKGNwcGNfZ2V0X2VwcF9jYXBzKTsNCj4gPiA+ID4gPiAr
DQo+ID4gPiA+ID4gK2ludCBjcHBjX3NldF9hdXRvX2VwcChpbnQgY3B1LCBib29sIGVuYWJsZSkg
ew0KPiA+ID4gPiA+ICsgICAgIGludCBwY2Nfc3NfaWQgPSBwZXJfY3B1KGNwdV9wY2Nfc3Vic3Bh
Y2VfaWR4LCBjcHUpOw0KPiA+ID4gPiA+ICsgICAgIHN0cnVjdCBjcGNfcmVnaXN0ZXJfcmVzb3Vy
Y2UgKmF1dG9fc2VsX3JlZzsNCj4gPiA+ID4gPiArICAgICBzdHJ1Y3QgY3BjX2Rlc2MgKmNwY19k
ZXNjID0gcGVyX2NwdShjcGNfZGVzY19wdHIsIGNwdSk7DQo+ID4gPiA+ID4gKyAgICAgc3RydWN0
IGNwcGNfcGNjX2RhdGEgKnBjY19zc19kYXRhID0gTlVMTDsNCj4gPiA+ID4gPiArICAgICBpbnQg
cmV0ID0gLUVJTlZBTDsNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKyAgICAgaWYgKCFjcGNfZGVz
Yykgew0KPiA+ID4gPiA+ICsgICAgICAgICAgICAgcHJfd2FybigiTm8gQ1BDIGRlc2NyaXB0b3Ig
Zm9yIENQVTolZFxuIiwgY3B1KTsNCj4gPiA+ID4NCj4gPiA+ID4gSXMgdGhpcyBhY3R1YWxseSB3
YXJuIHdvcnRoeT8gIEkgd291bGQgdGhpbmsgaXQncyBmaW5lIGEgZGVidWcNCj4gPiA+ID4gbGlr
ZSB3ZSBoYXZlIGZvciB0aGUgb3RoZXIgX0NQQyBtaXNzaW5nIG1lc3NhZ2VzLg0KPiA+ID4gPg0K
PiA+ID4gPiA+ICsgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gPiA+ID4gKyAgICAg
fQ0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArICAgICBhdXRvX3NlbF9yZWcgPSAmY3BjX2Rlc2Mt
PmNwY19yZWdzW0FVVE9fU0VMX0VOQUJMRV07DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsgICAg
IGlmIChDUENfSU5fUENDKGF1dG9fc2VsX3JlZykpIHsNCj4gPiA+ID4gPiArICAgICAgICAgICAg
IGlmIChwY2Nfc3NfaWQgPCAwKQ0KPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICByZXR1
cm4gLUVOT0RFVjsNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKyAgICAgICAgICAgICByZXQgPSBj
cGNfd3JpdGUoY3B1LCBhdXRvX3NlbF9yZWcsIGVuYWJsZSk7DQo+ID4gPiA+ID4gKyAgICAgICAg
ICAgICBpZiAocmV0KQ0KPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0
Ow0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArICAgICAgICAgICAgIHBjY19zc19kYXRhID0gcGNj
X2RhdGFbcGNjX3NzX2lkXTsNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKyAgICAgICAgICAgICBk
b3duX3dyaXRlKCZwY2Nfc3NfZGF0YS0+cGNjX2xvY2spOw0KPiA+ID4gPiA+ICsgICAgICAgICAg
ICAgLyogYWZ0ZXIgd3JpdGluZyBDUEMsIHRyYW5zZmVyIHRoZSBvd25lcnNoaXAgb2YgUENDIHRv
DQo+IHBsYXRmb3JtICovDQo+ID4gPiA+ID4gKyAgICAgICAgICAgICByZXQgPSBzZW5kX3BjY19j
bWQocGNjX3NzX2lkLCBDTURfV1JJVEUpOw0KPiA+ID4gPiA+ICsgICAgICAgICAgICAgdXBfd3Jp
dGUoJnBjY19zc19kYXRhLT5wY2NfbG9jayk7DQo+ID4gPiA+ID4gKyAgICAgICAgICAgICByZXR1
cm4gcmV0Ow0KPiA+ID4gPiA+ICsgICAgIH0NCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKyAgICAg
cmV0dXJuIGNwY193cml0ZShjcHUsIGF1dG9fc2VsX3JlZywgZW5hYmxlKTsgfQ0KPiA+ID4gPiA+
ICtFWFBPUlRfU1lNQk9MX0dQTChjcHBjX3NldF9hdXRvX2VwcCk7DQo+ID4gPiA+ID4gKw0KPiA+
ID4gPiA+ICsvKg0KPiA+ID4gPiA+ICsgKiBTZXQgRW5lcmd5IFBlcmZvcm1hbmNlIFByZWZlcmVu
Y2UgUmVnaXN0ZXIgdmFsdWUgdGhyb3VnaA0KPiA+ID4gPiA+ICsgKiBQZXJmb3JtYW5jZSBDb250
cm9scyBJbnRlcmZhY2UgICovIGludCBjcHBjX3NldF9lcHBfcGVyZihpbnQNCj4gPiA+ID4gPiAr
Y3B1LCBzdHJ1Y3QgY3BwY19wZXJmX2N0cmxzICpwZXJmX2N0cmxzKSB7DQo+ID4gPiA+ID4gKyAg
ICAgaW50IHBjY19zc19pZCA9IHBlcl9jcHUoY3B1X3BjY19zdWJzcGFjZV9pZHgsIGNwdSk7DQo+
ID4gPiA+ID4gKyAgICAgc3RydWN0IGNwY19yZWdpc3Rlcl9yZXNvdXJjZSAqZXBwX3NldF9yZWc7
DQo+ID4gPiA+ID4gKyAgICAgc3RydWN0IGNwY19kZXNjICpjcGNfZGVzYyA9IHBlcl9jcHUoY3Bj
X2Rlc2NfcHRyLCBjcHUpOw0KPiA+ID4gPiA+ICsgICAgIHN0cnVjdCBjcHBjX3BjY19kYXRhICpw
Y2Nfc3NfZGF0YSA9IE5VTEw7DQo+ID4gPiA+ID4gKyAgICAgaW50IHJldCA9IC1FSU5WQUw7DQo+
ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsgICAgIGlmICghY3BjX2Rlc2MpIHsNCj4gPiA+ID4gPiAr
ICAgICAgICAgICAgIHByX3dhcm4oIk5vIENQQyBkZXNjcmlwdG9yIGZvciBDUFU6JWRcbiIsIGNw
dSk7DQo+ID4gPiA+DQo+ID4gPiA+IElzIHRoaXMgYWN0dWFsbHkgd2FybiB3b3J0aHk/ICBJIHdv
dWxkIHRoaW5rIGl0J3MgZmluZSBhIGRlYnVnDQo+ID4gPiA+IGxpa2Ugd2UgaGF2ZSBmb3IgdGhl
IG90aGVyIF9DUEMgbWlzc2luZyBtZXNzYWdlcy4NCj4gPiA+ID4NCj4gPiA+ID4gPiArICAgICAg
ICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+ID4gPiA+ICsgICAgIH0NCj4gPiA+ID4gPiArDQo+
ID4gPiA+ID4gKyAgICAgZXBwX3NldF9yZWcgPSAmY3BjX2Rlc2MtPmNwY19yZWdzW0VORVJHWV9Q
RVJGXTsNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKyAgICAgaWYgKENQQ19JTl9QQ0MoZXBwX3Nl
dF9yZWcpKSB7DQo+ID4gPiA+ID4gKyAgICAgICAgICAgICBpZiAocGNjX3NzX2lkIDwgMCkNCj4g
PiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9ERVY7DQo+ID4gPiA+ID4g
Kw0KPiA+ID4gPiA+ICsgICAgICAgICAgICAgcmV0ID0gY3BjX3dyaXRlKGNwdSwgZXBwX3NldF9y
ZWcsIHBlcmZfY3RybHMtPmVuZXJneV9wZXJmKTsNCj4gPiA+ID4gPiArICAgICAgICAgICAgIGlm
IChyZXQpDQo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4g
PiA+ID4gKw0KPiA+ID4gPiA+ICsgICAgICAgICAgICAgcGNjX3NzX2RhdGEgPSBwY2NfZGF0YVtw
Y2Nfc3NfaWRdOw0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArICAgICAgICAgICAgIGRvd25fd3Jp
dGUoJnBjY19zc19kYXRhLT5wY2NfbG9jayk7DQo+ID4gPiA+ID4gKyAgICAgICAgICAgICAvKiBh
ZnRlciB3cml0aW5nIENQQywgdHJhbnNmZXIgdGhlIG93bmVyc2hpcCBvZiBQQ0MgdG8NCj4gcGxh
dGZvcm0gKi8NCj4gPiA+ID4gPiArICAgICAgICAgICAgIHJldCA9IHNlbmRfcGNjX2NtZChwY2Nf
c3NfaWQsIENNRF9XUklURSk7DQo+ID4gPiA+ID4gKyAgICAgICAgICAgICB1cF93cml0ZSgmcGNj
X3NzX2RhdGEtPnBjY19sb2NrKTsNCj4gPiA+ID4NCj4gPiA+ID4gY3BwY19zZXRfYXV0b19lcHAg
YW5kIGNwcGNfc2V0X2VwcF9wZXJmIGhhdmUgbmVhcmx5IHRoZSBzYW1lDQo+IGNvZGUNCj4gPiA+
ID4gaW4gdGhlIGlmIGJsb2NrLiAgSSB3b25kZXIgaWYgaXQncyB3b3J0aCBoYXZpbmcgYSBzdGF0
aWMgaGVscGVyDQo+ID4gPiA+IGZ1bmN0aW9uIGZvciB0aGlzIHB1cnBvc2UgdGhhdCB0YWtlcyAi
cmVnIiBhbmQgInZhbHVlIiBhcyBhcmd1bWVudHM/DQo+ID4gPiA+DQo+ID4gPiA+ID4gKyAgICAg
fQ0KPiA+ID4NCj4gPiA+IEFuZCB3aGF0IGFib3V0IHRoZSBub24tUENDIGNhc2UgaGVyZT8NCj4g
Pg0KPiA+IEkgbWVyZ2UgdGhlICBjcHBjX3NldF9hdXRvX2VwcCBhbmQgY3BwY19zZXRfZXBwX3Bl
cmYgaW4gVjQuDQo+ID4gRm9yIHRoZSBub24tUENDIGNhc2UsIHdlIGNhbm5vIHNldCB0aGUgRVBQ
IHZhbHVlIHRvIEZXLCB0aGVuIGp1c3QNCj4gPiByZXR1cm5lZCBFcnJvciBjb2RlLiAgSXMgaXQg
T2sgPw0KPiANCj4gWWVzLCBpZiBpdCBjYW5ub3QgYmUgdXBkYXRlZCwgaXQgc2hvdWxkIGJlIHRy
ZWF0ZWQgdGhlIHNhbWUgd2F5IGFzDQo+IHVuc3VwcG9ydGVkIElNVi4NCg0KTWFrZSBzZW5zZSwg
SSB3aWxsIG1ha2UgY2hhbmdlIGZvciB0aGlzIGluIFY0IGFuZCB5b3UgY2FuIGhlbHAgdG8gdGFr
ZSBhIGxvb2sgYXQgVjQuDQpUaGFua3MuIA0KDQpQZXJyeSAuDQo=
