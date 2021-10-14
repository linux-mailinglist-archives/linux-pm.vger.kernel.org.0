Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2081142D731
	for <lists+linux-pm@lfdr.de>; Thu, 14 Oct 2021 12:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbhJNKiC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Oct 2021 06:38:02 -0400
Received: from mail-bn7nam10on2051.outbound.protection.outlook.com ([40.107.92.51]:41600
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230030AbhJNKh7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 14 Oct 2021 06:37:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKzVpkKzeejL9bPL0YPjuGvQBbbqxj+AgbUsega+hX7QH2dDXXiV/B7+CbKpq2m4/mQTGJR+Kr7qscvS+skMWQlZDN3eQKwuSz7At14wKjp/5W/6ieDliCyBXxDSrAvbhvy/29s9yJE5YKGhOK91GAMHYBO+9sGNLmyvQKkqwsZgmEDW+8wWF2xVDCLuON8mjW/WhstNAUa/m0ak8O6I1YE5c7uqMbWxNLm9ayUPAqj7m/3NlnWm0BW1fhFMs05m/1AgBPO6OvxxnzZoceQ2x0t5sfjzVx3s3jQrvoSm6owQ3VnUirMsjHhB1aENuhGYafEo8yzo0OEK6XTNjuNERg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GVfibrQAlCiv7zv9t03Q5HQtClGKOWHz8SJkwzk30E=;
 b=KWzJlyVyvnWIRPU2CO4rqdleEklb6E5IR5ZaL9yPg+cp+Cr663m+Up/eVUWLcJGBvRv1Qcz2peFYAPVVFHu0XOMqQZGstJy3L78cDMoWcUrcoYc6Xxb3wGIfPSELFuE8GaiKEFm9wz1KugRvHpScPKv+Nv8xFmh2utH3VWxC9YLLQ0NQBfRkDbI5A1bOeIyz1pYe1JUTTd5t+0hCpC+igN5xKBjd1SiIhU6eVoPxIQQPS/6gvap9gIdvyTz2JlXFqHgl3iC0L1nWr8OfvB8movST8tebl8wgbdsCdcPsNSHTvPz6DQqiJRXHJ8BMPgyigAaFsT0KPHcqpyoCDcHYRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GVfibrQAlCiv7zv9t03Q5HQtClGKOWHz8SJkwzk30E=;
 b=gFuBm2pOeFJ56dy/RHhCFlrxc+Dz2WfPh2c1gXQVK0T0UseXv+f6xmIC2bgtuaysZrBAGBk7bGLDnIltvuFdXGCFWcEUwPYds/DsmoKwV4CKfoDApBKyvXFQ15YXElRzxEmwF0Dc3lW2fauM4Bm21adTrZHuMHMQM6OR1ktqr+g=
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 (2603:10b6:910:23::16) by CY4PR12MB1591.namprd12.prod.outlook.com
 (2603:10b6:910:10::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Thu, 14 Oct
 2021 10:35:50 +0000
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::91ce:4fae:eca6:9456]) by CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::91ce:4fae:eca6:9456%9]) with mapi id 15.20.4587.030; Thu, 14 Oct 2021
 10:35:50 +0000
From:   "Huang, Ray" <Ray.Huang@amd.com>
To:     "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v2 11/21] cpufreq: amd: add amd-pstate frequencies
 attributes
Thread-Topic: [PATCH v2 11/21] cpufreq: amd: add amd-pstate frequencies
 attributes
Thread-Index: AQHXsrXjYrbau6WA2k2vdhaX9qFCHau5/ByAgBhslrA=
Date:   Thu, 14 Oct 2021 10:35:50 +0000
Message-ID: <CY4PR1201MB024635E78AC40B1DC04C9E81ECB89@CY4PR1201MB0246.namprd12.prod.outlook.com>
References: <20210926090605.3556134-1-ray.huang@amd.com>
 <20210926090605.3556134-12-ray.huang@amd.com>
 <01fab2a8-a5d0-7bff-8245-6ebb31332c64@amd.com>
In-Reply-To: <01fab2a8-a5d0-7bff-8245-6ebb31332c64@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-14T10:35:47Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=b559d8de-00fd-4410-a144-4948dee9b944;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 832d6a31-d102-46fd-9358-08d98efe6423
x-ms-traffictypediagnostic: CY4PR12MB1591:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB159196CFEA99FE590740D45AECB89@CY4PR12MB1591.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZDOd4pZfuU4gzBtPUeAj8EpM4BnLW43al3ggj/sR7UvTaEzyMeTUabf1f+Z5TMtfEwMimNkygsEPSFFFFPe6M1HaZlk4PntWR+V/L6tM55fJnoLqWRVMcsXWhwuwi+lr5vryvcZHf5EZ4TFtqqhqXoB/HDMI1YTu0ovUUbKOVzzlLdql36GzmZtKTdcVTjhZ8Ig2q41zzrexzNr4D9FYISeDHo56xy0Gu7R1FbAUqvfz0gNV9L7BdoP0xT+zMPjyWEJAnkxSZoEJjs7Zg8CHYj9cNeRh2ix0bHkJqy7QFkRN3uXU334VMJEpqq9e4k25bkQl1JG2TwhE3r/ipS72PRQ9mLWoZpPeMLU2AzJQ3mCNW7g3LUee009lRU8b0XlFRJ7jmaYkP9wd5GBrzI0nHP2eJ/ZoKH9Cb+KM6k2iTYuiUvrPYsWNrEXju5sfQIAnK6B8l+9mTBlXuRca7FDvrutAlxRytV3hk1WFKy9Sz45aAiKztpnjMjMPCZhn/q8mbzirq+2misDh7NeKBT/g6TCVwDo8jiUfyMOwvx0qdpzmmXxLA+UO88+FHblGDQOBukJZMBnDmWoAeYIBaE6NMG3Wfa1KQZFA/VHYhOI1cH9Icxub55AI2KFFULB/In9TYkGti5VwVf7QkwzGs1t/3x9XQUBKjlNkNUd859+Ncebz6bi2hA5lwJ2b//Z7EttjorEgQNKecs0agX7JqYIywg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0246.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(6506007)(38070700005)(508600001)(76116006)(53546011)(66556008)(186003)(4744005)(316002)(5660300002)(110136005)(52536014)(54906003)(86362001)(4326008)(38100700002)(7696005)(55016002)(66946007)(33656002)(8936002)(83380400001)(9686003)(2906002)(64756008)(26005)(66446008)(8676002)(71200400001)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3RRbmtrdFpzdlpRMXVZT3hlZlYxNEk1cjAzRi9rNHU4SzNtTzRWVHVXM1dR?=
 =?utf-8?B?eVdrZXFNeGRxRGQ1N0pnS0QxSityRnZrMnJ3ZHZjYXh0V0RxdTVZMVh6M1Vu?=
 =?utf-8?B?dDdzUnIydEdnMTlwMzUydFdtaGU5Kzd4UzZ6UUUxZCt1dnBMUUF2VktkR0cr?=
 =?utf-8?B?ZkxPeFZseDV3MkJ3U281REJyQUFiMkF1OTloWkJ2S3FyZUdKS01zNUNNL0RU?=
 =?utf-8?B?OXB6cGlHMkd1NGlaNDM3M3Z0WUV2OGJFQWQrWVV4bkdodEJrZTNTR2pxQWtF?=
 =?utf-8?B?TkxOOVN3UFpzMlZhY1VUNHg1RHU2OVpVeXJiTTlLV21DVjRmblRFWnVSalc4?=
 =?utf-8?B?WjRYM3hacmp4Zk1GV3FxS00weG9QUzlEMThKOW1mQ054VU1XNFg2dUZTOER0?=
 =?utf-8?B?ekNLbDhQbnNVVGwyMWJodTVlbUR4cGhxUjFmYXA3Qnp3ZG9aQk5ucSszZllq?=
 =?utf-8?B?QXpKL2ZaTEtDRk80OG5CLzBOMkJMU2J4NE5NRVFHeGZ1ckhaLzMwUEt2YVNn?=
 =?utf-8?B?a01OUTZESUNya1ZpaisrVFJWWW1YcFZrakk5Z3VVaVRleDJxVVdoR05XRHF1?=
 =?utf-8?B?cllUNGVNRnY5aHRpcEpFb3lHT1ZMVFNHc1Zuc3VYakllaGc2bkpseGNONUsx?=
 =?utf-8?B?SW4yamc2L0x0anJweldwL21Say9HS2pNdS9ZWm93RUJxVkxkeXFqUWdJTjJH?=
 =?utf-8?B?U1RMTk5YWjJRT0hJRXRESHNabmY0OEdYblQwQVp2eXF4akRXT3p2Yk10SlNz?=
 =?utf-8?B?OENVZXFMaDN1RFhuNTMrNTlyQldWekdQZVhmcnBhOGcvMEwrN0Y4L1FUT3Ay?=
 =?utf-8?B?NXVldVFHUlZ6QkhJdGdvQWFZV0F5eVFMaFdPZk5FM2ExWnhPR2FsUENZVHJw?=
 =?utf-8?B?d3hRUWUydnJNSFpHZW5SNEdNcGh3Mjg0RnVrTFgxREhodlY2NDNVZXNTZ2FI?=
 =?utf-8?B?bko3NUhSZTRYYVNmQ2pmQkNRdTJzc0FjQmVxSXNwT2xuK1VYUFMrYjBaWnVX?=
 =?utf-8?B?UmlsdEZaRTVvYndvWjVKekUxNjZGRURuK0FFNmhyYWhrQkMvNWdXU3ZTN04v?=
 =?utf-8?B?Y29tMnVXV2pXYXdwbjBFczdJNFZEdU5OVFBCTUNNQ0h5N0FrckFFRG1SS3JX?=
 =?utf-8?B?TDl4RTBob2pTckMvMTdYV3pRRjhGYU91ZnVKdm1YRnZZNFVJaWwrNldMdjhq?=
 =?utf-8?B?K0t5Yyt4dGxqVkNZSlVTOUp4OFhKZGU0YWxGaXJwOGhrR2NiSkwvbWRROW9l?=
 =?utf-8?B?bXU0VjZ5MmxSbFMzMzZFaU9TbSs5a1VLR3MyaVVlOW9uaGMzM2pwbzNxSG1V?=
 =?utf-8?B?cGllaFRQYzc3VmZyT2llL3VONzR1MVZUalJkM1BGMUJVZW9FMEJWOU1WL2xr?=
 =?utf-8?B?QjdLQno3QkZhbGlzMlNXSDNnUXpoRkoxS2VFVUxGK0g5RHBmcEdGM0VHOHY1?=
 =?utf-8?B?a3RtVjhicm9qWGtCN205dWF0VTVaSG1obTYvSjBUL0IyU3RkdUUyRFZ0QU5L?=
 =?utf-8?B?MnJ1TWZLL3FkeTRkOHo2YitreVhRb3U3aXI3Ti84NmZORGVPdWtlUkZuUDZQ?=
 =?utf-8?B?QmpCMTcwaTdrL2Jsa1JJZDhBM0NJOE0zRzJlY3p4NXFnUTQwQUFnaGJLYUJa?=
 =?utf-8?B?R2hNVERKa1BvR3BRa1ppRlFmcVV3OUlCM0ROWTNmOTRaSWhzUzNXbk12SSsv?=
 =?utf-8?B?TGhWMjZ5TllHTlpGVW1aUGhqSlVPVmFobjlwMC9HOWFUOUpVV2JNcElzbVZY?=
 =?utf-8?Q?06TUhVin01NiwyQ9ZxZfccvq+PmwrF9fwkK41SQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0246.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 832d6a31-d102-46fd-9358-08d98efe6423
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2021 10:35:50.0956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ldvSg/iUGZrl1D2KjVjfrObTTwvePJtbDTX/HiruvpxWGOl6dwtvZg5augKHZAv0F6xo9Qx438qiMBUzbkJoYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1591
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBGb250ZW5vdCwgTmF0aGFuIDxOYXRoYW4uRm9udGVub3RAYW1kLmNvbT4NCj4gU2Vu
dDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMjksIDIwMjEgNTozNiBBTQ0KPiBUbzogSHVhbmcsIFJh
eSA8UmF5Lkh1YW5nQGFtZC5jb20+OyBSYWZhZWwgSiAuIFd5c29ja2kNCj4gPHJhZmFlbC5qLnd5
c29ja2lAaW50ZWwuY29tPjsgVmlyZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz47
DQo+IFNodWFoIEtoYW4gPHNraGFuQGxpbnV4Zm91bmRhdGlvbi5vcmc+OyBCb3Jpc2xhdiBQZXRr
b3YgPGJwQHN1c2UuZGU+Ow0KPiBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+
OyBJbmdvIE1vbG5hciA8bWluZ29Aa2VybmVsLm9yZz47DQo+IGxpbnV4LXBtQHZnZXIua2VybmVs
Lm9yZw0KPiBDYzogU2hhcm1hLCBEZWVwYWsgPERlZXBhay5TaGFybWFAYW1kLmNvbT47IERldWNo
ZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IExpbW9uY2llbGxv
LCBNYXJpbw0KPiA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT47IFN1LCBKaW56aG91IChKb2Up
IDxKaW56aG91LlN1QGFtZC5jb20+Ow0KPiBEdSwgWGlhb2ppYW4gPFhpYW9qaWFuLkR1QGFtZC5j
b20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiB4ODZAa2VybmVsLm9yZw0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIHYyIDExLzIxXSBjcHVmcmVxOiBhbWQ6IGFkZCBhbWQtcHN0YXRl
IGZyZXF1ZW5jaWVzDQo+IGF0dHJpYnV0ZXMNCj4gDQo+IE9uIDkvMjYvMjAyMSA0OjA1IEFNLCBI
dWFuZyBSdWkgd3JvdGU6DQo+ID4gSW50cm9kdWNlIHN5c2ZzIGF0dHJpYnV0ZXMgdG8gZ2V0IHRo
ZSBkaWZmZXJlbnQgbGV2ZWwgcHJvY2Vzc29yDQo+ID4gZnJlcXVlbmNpZXMuDQo+ID4NCj4gDQo+
IENhbiB5b3UgcHJvdmlkZSBhbiBleHBsYW5hdGlvbiBvbiB3aHkgdGhlc2UgYXJlIG5lZWRlZCBp
biBhZGRpdGlvbiB0byB0aGUNCj4gc3lzZnMgZmlsZXMgY3JlYXRlZCBieSB0aGUgY29yZSBjcHVm
cmVxIGRyaXZlcj8gU29tZSBvZiB0aGVzZSBhcHBlYXIgdG8gYmUNCj4gZHVwbGljYXRlcy4NCj4g
DQoNCkkgd2lsbCBjbGVhbiB1cCB0aGUgZHVwbGljYXRlZCBzeXNmcyB3aXRoIGNvcmUgY3B1ZnJl
cSBkcml2ZXIgaW4gVjMuDQoNClRoYW5rcywNClJheQ0K
