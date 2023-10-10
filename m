Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5757BFAA7
	for <lists+linux-pm@lfdr.de>; Tue, 10 Oct 2023 14:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjJJMDN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Oct 2023 08:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjJJMDD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Oct 2023 08:03:03 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2044.outbound.protection.outlook.com [40.107.249.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBAC2691
        for <linux-pm@vger.kernel.org>; Tue, 10 Oct 2023 05:02:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hagl1sRNpHQtkLB22PQGi4rE0Met+VO2EkxLKlxMJXDHauxQzaLma9f+OX7V/ZD4A5MY1LltEqBZidxgbZ1IUq/+Y5Ip+F9EyELj0Xjkpvi9xeIgqWcY8+F/q3NWEX4n8WMeenHQv6+4l6YEty+o9DBZ3JCL2iDo9XTcsXUikxS1EW1Qm0U8Lc/IgaVTN0yvNTCh1L++KRQlciFdWJ1OkHZ52CL9CzJ9q/yOmuWtJ8emd9b08qsJxXDe+qpcuorljx+w2hiAad5e/0d5nI0pJKGrJCk8lDugYwC6FHpyGc37kc27ODCvk73geilw/F0ivzgwxBl+4HYmRUMUW/zYsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkjYOHdnPNLYRZ3vdF86FbFkShmZF9Jj4DI+3V2QRPs=;
 b=U0rph4wXgXdAzKuoIcW8DU1Qndp0pyqLr0kpyjiNxiDgtRXFfoyDi2+4YFzpOd2hDW2DFCqcUBGtWaJVrEy6hCYNbpkcMxNZgVYtalsecxVWnLWlU9bYXBYSRQnISzEE8se5ad1TEyCgwMZ5Rq5Wkq9NtC/mJOcIqPpBv/4+1QwooA+/KYWITRf7aHa1JPii3aN1eY/T+fIYlyL9tbIkRVuHMi4GfShc0wE8bYykhc8WKH1pY9rbqJn+fsfb61uHbH5Ri1W0SS0z8+OmdZ/Y0CYKtpB93fu3jEJ2KE38reMEsSKvqDGlIQz3TVqSzJGznrxmjlcYFxfUQXL+LG/x8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkjYOHdnPNLYRZ3vdF86FbFkShmZF9Jj4DI+3V2QRPs=;
 b=OYa5g99/780m1NW642ib1Z76ZqpjunNVOAhPADlvdE3bgSVPo1nLe0iY5ej+aUGzt6coRN8OMHp3lc8CyWbE/88Iwo9eH3WEVBrLzX+cFikx/T4ZErB1dVwCB+niY8fi+emTw+UiDm0Dy4sxCSGxtN1QpwWAJHVsFYjq6bMBsio=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB9788.eurprd04.prod.outlook.com (2603:10a6:800:1d4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Tue, 10 Oct
 2023 12:01:58 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6838.040; Tue, 10 Oct 2023
 12:01:58 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Glen G Wienecke <glen.wienecke@nxp.com>
Subject: RE: Question regarding scmi_perf_domain.c
Thread-Topic: Question regarding scmi_perf_domain.c
Thread-Index: Adn7ZJVuPYTdu0ufRKeeVXBw4lJjnAAA6M+AAAA+SYAAALxWIA==
Date:   Tue, 10 Oct 2023 12:01:57 +0000
Message-ID: <DU0PR04MB941755466872E84217378F6388CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <DU0PR04MB9417DE145496DC03579F50E488CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010105503.jwrmjahuvcjgwtk5@bogus>
 <CAPDyKFqEpnKeF7Yuvv_a+=Kqs=pNU_kM59EqWdpCniHrY_373A@mail.gmail.com>
In-Reply-To: <CAPDyKFqEpnKeF7Yuvv_a+=Kqs=pNU_kM59EqWdpCniHrY_373A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|VI1PR04MB9788:EE_
x-ms-office365-filtering-correlation-id: fd13f546-2216-4f5f-3318-08dbc988b43e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FvUETtD9tAiTHI+eU66f8TwUTmZel1ZBRU9uKv5kXlTevmlbtlz4j3jr7JwPa8F4Rg73zOxkWaenN6v5yqPKMAOuIsSxEhCPRUFqLDKH0TGL7Yxi74X+AF+L58msdzNC/EtRU7E+osPSvpzdMOj015xK5kEiM/iFvWaEyijr3oG56RPJNpUjQCsp5FjSfzGtyjQABEUyQG4OQOnjFkeOvTufQ+LiFVxseuXv8NEcFzY7EKdI+b7exuIx25bKfQ/Wg2U0/KaFN5aWADf2fHUBdIKT0W5ncGu1PUcUOe6cWYcMTo+FZjG0HK2L4MweBZ8jB0KLrYrxuBRHICG1MVSJ6hEWu/QEEMTW6l91/bCXvZw2JX31D2PlULd4FRKIhlmVvpZCENMMBIt6i/EcgLGmvue9dyP5J/0nWS1tfO4OzG1BW3cpQKV9krqZgBk8twHHd7AAcWDutc9cmg+tOEdrqNk5aLVxRnECt9cKHOWXI5enPniovoPBfOWw15lRsMnRhLsEdX6M0K3vxHyGKo/aX6XULQN4x/sMc8Are/oU1o2c6W7iXzDEisYrYQXN0DxADeEi8qjX+pQfS6VHIYGT17R52kN6iu1qS+52hk7/y6juHP6xSN1yQkQdrozITZK4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39860400002)(376002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(9686003)(33656002)(86362001)(55016003)(122000001)(38070700005)(38100700002)(26005)(44832011)(2906002)(83380400001)(71200400001)(7696005)(6506007)(478600001)(8936002)(8676002)(4326008)(52536014)(41300700001)(316002)(5660300002)(66446008)(66476007)(110136005)(76116006)(66556008)(66946007)(64756008)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFhjQitwL2ZYbDM3WVRvSXRTN3ZXVllab3J6Uk80cU1rVUtFS3JsNFBObkpm?=
 =?utf-8?B?SktNNDNTRFZmZUVFWUMzbWhYYkhDcG8yeVJXQWwzdHEwemVMSlFxNC80TXBi?=
 =?utf-8?B?Q1N4Ryt3Ynk2enhEZ1N5YmNONjFBQzRCMHpzanR0d093ZjNFaXVkRXhPdXR5?=
 =?utf-8?B?UXRCQ2xWTGVzNDJBdXF0ZjZQNlM3dXVnYVljUyt2SHF4eEpZUDBTWGJPcDhK?=
 =?utf-8?B?d2JJNGRwMGx0cE8wbDZqdjEySmJZWjFSR3h3N3ZYb0lsOWFaRVk4MDRuS2Z0?=
 =?utf-8?B?QmJFVlY4d0pxNDBBbm1BSTNBamJNMFZac094bnBWTWxRWjQvdVlndFpzS0ZQ?=
 =?utf-8?B?WG5ybXU5M0JROHdCR1NqemYzb2ptbWMzbTR2ZlovSmFFMVpneHVvVHBuaEFt?=
 =?utf-8?B?MW1uNEd0RHhHMDlBWnNuUjMzYXNkWFVBbFpiZERDZjcyL3BIa2lqcnE0OG5x?=
 =?utf-8?B?ODJnUjhod3lxU0RZb3Jja0dOU3ZJcVo2cFJUVmNZYmVkVEZXRVJ2YXV3TkFj?=
 =?utf-8?B?bmlSVXVVT1JUTUpCOEMvMTZvdTJpcXExczdxTlg5K0xaM3U5WkhRdzlWT3lD?=
 =?utf-8?B?R3JlMnA3cVR2K25LeWNJU3VNZnZ3Wi9sNjdKaVFHT3JqRW1wN1lKNEU2SmFn?=
 =?utf-8?B?NHN1elNHNDNxOHFDOHB3WktMQ3lzSlVvVFlvdERmQnlnRWhLdlF1ckE4MW9P?=
 =?utf-8?B?dzByREtJME9ZcVBGaVBLNDkyRXBnYzc1czNadkM1N2pYNjJHaXI5ZlBsUjg0?=
 =?utf-8?B?OWRZSDdTajFlekhqYTBlL3ZhclB6V0RXRWZTL0FDWkcvZUFZbFpzWFVyMTR0?=
 =?utf-8?B?SWhxTnJPU0VlQVYxUkdnNUlkcWp1d3FOTEZpdnVVVWdja3RKMWRFQ3FMS1Rp?=
 =?utf-8?B?anMxUzBBd3NOZEY4ZG40ejA3aHhKVncxckwySURoWWFwZjQrSGZMbkgyQ3k1?=
 =?utf-8?B?eUZvcGs5RGR0SXh2RmNmMit3a0xnQy9qWWpCRVVwb2NaZGlaZDJlSTZWNTYv?=
 =?utf-8?B?U1B5blpQTlA5Y1VUZVIrb1N5R08rQU05K2l5U1o0bno2amhjb21wWXg1R01v?=
 =?utf-8?B?a1R1S3BWeU9KekV6T2RLRFQrMHV0UG8weks4V1V2TGYvZEQ0eTN6Mi9yYXVU?=
 =?utf-8?B?Skg5UzFaWE1kNGdJeGFVVTVFd0ZXYVdUVmMwRHZIVjdvLzlZb1FmMlV5emlh?=
 =?utf-8?B?NHpVOTF4TlVEN2lxQk42akd1UGpEZVZ2Z01TWkw3d0k4NmtOakpLNFJ4RVRt?=
 =?utf-8?B?RXVwYUlENWU0Y3BadnJ1MDc2ZTBSRTh3L01DUytNb1FWdVN4V3hycGlNTElE?=
 =?utf-8?B?Q0tEQ1g0Mm9ZWG1KcUE5S0tzaU5yaWM1V1F6VVAyenJFOFhZTHRHWmdqV0RF?=
 =?utf-8?B?blo3dFI0THhXNmoxb2dqWkJORW1YbmtiNi9tZ2hqaE9BVUcxeWVMOFJLRnFG?=
 =?utf-8?B?SENSbTE2RG9UWUJrRVVuVTRmMEp2b1ZiREV4ZS93K3poVm1aNVJzQ0FMR3lR?=
 =?utf-8?B?NTBkNFNERUJLZHVzUjQvQXgzSlNtdkl5d056azFMd2RpUGhSN2huWkdhYUNJ?=
 =?utf-8?B?OVc5ZWYySTFvY0xZbXdKNGtXN2p3cHpGb2pHbVpRa0p6V291bFIwUUNGUHJp?=
 =?utf-8?B?dlp6bXNTcUZqNTlFWkRLcUdwK3hYK3NmK01OSE5tSGFuOEQrM3VmNXZmRzcw?=
 =?utf-8?B?Q0FjV0V3bW5sVUVBdXZ5amdUTTVzNWdzVlhJZDB1ZmJxSnNhMHFMMkZBLzBR?=
 =?utf-8?B?d3hJeXN0WGRFdjVYeFRaM1lSK0M5UkthbVhvQkwyc1dkVi9qQkNFK1h6ZlJK?=
 =?utf-8?B?SjJQTlpQSTZYOTdzN3U0NGwycHNtTW1TU3RjTU1wYjNKeHd6WEhGdEJ2UEJq?=
 =?utf-8?B?ZG40SXhTM21nRlcwVXlZVmFZbVZvaFZkWGozaUkvdGxYTjgxRWtKVms5UGZi?=
 =?utf-8?B?SXpjdlF2TGZ3eHVmVFJ0bHJ6NEhYV0xtbTBsSzc2UGdId2drYk9MMEpyaXAy?=
 =?utf-8?B?a1d3TmxlZXRrdDBKM0ppZlE3bktkWElhcTROaTJZUVZlUlQvdXVCN0JBbnRv?=
 =?utf-8?B?V0t1NUhnVU9HYUVhTzRkWVBUSXF2ekttVStMWnZPSGZwVW1WOFJtdXcra0kx?=
 =?utf-8?Q?NWww=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd13f546-2216-4f5f-3318-08dbc988b43e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 12:01:57.9633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SIocklhUMC9A6HXkQeQZoLO6/GBKUqnFZJv6W55GwMcUF3jer1UMTv3QHXtog9sMlciiaW6AHNrNlcCNvMz5mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9788
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgU3VkZWVwLCBVbGYNCj4gU3ViamVjdDogUmU6IFF1ZXN0aW9uIHJlZ2FyZGluZyBzY21pX3Bl
cmZfZG9tYWluLmMNCj4gDQo+IE9uIFR1ZSwgMTAgT2N0IDIwMjMgYXQgMTI6NTUsIFN1ZGVlcCBI
b2xsYSA8c3VkZWVwLmhvbGxhQGFybS5jb20+IHdyb3RlOg0KPiA+DQo+ID4gT24gVHVlLCBPY3Qg
MTAsIDIwMjMgYXQgMTA6MzA6MTdBTSArMDAwMCwgUGVuZyBGYW4gd3JvdGU6DQo+ID4gPiBIaSBV
bGYsDQo+ID4gPg0KPiA+ID4gSSBqdXN0IHNlZSB5b3Ugd3JvdGUgc2NtaV9wZXJmX2RvbWFpbi5j
LCBqdXN0IHdvbmRlciB0aGlzIGRyaXZlciBpcw0KPiA+ID4gb25seSBmb3IgZGV2aWNlcywgbm90
IHN1cHBvcnQgYXJtIGNvcmVzLCByaWdodD8NCj4gPiA+DQo+ID4gPiBGb3IgQVJNIGNvcmVzLCB3
ZSBzdGlsbCBuZWVkIHNjbWlfY3B1ZnJlcS5jIGZvciBwZXJmb3JtYW5jZQ0KPiA+ID4gc2V0dGlu
Z3MsIHJpZ2h0Pw0KPiA+DQo+ID4gU29ycnkgaWYgSSB3YXNuJ3QgY2xlYXIuIFRoZSByZWFzb24g
SSBtZW50aW9uZWQgaXQgaW4gcHJpdmF0ZSBpcyB0aGF0DQo+ID4gd2Ugbm93IHN1cHBvcnQgdGhl
IHBvd2VyIGRvbWFpbiBiaW5kaW5ncyBpbiB0aGUgc2NtaS1jcHVmcmVxLmMgYXMgeW91DQo+ID4g
d2VyZSBsaXR0bGUgYml0IG5lcnZvdXMgdG8gdXNlIHRoZSBjbG9jayBiaW5kaW5ncyh0aG91Z2gg
dGhleSB3b3JrDQo+ID4ganVzdCBmaW5lLCBJIHVuZGVyc3RhbmQgdGhlIHBvc3NpYmxlIGNvbmZ1
c2lvbiB3aXRoIHRoZSBjbG9jayBwcm90b2NvbCkuDQo+IA0KPiBSaWdodCwgZ29vZCBwb2ludCEN
Cj4gDQo+IEkgdGhpbmsgd2UgZGlzY3Vzc2VkIGVhcmxpZXIgd2hldGhlciB3ZSBzaG91bGQgZGVw
cmVjYXRlIHRoZSB1c2Ugb2YgdGhlIGNsb2NrDQo+IGJpbmRpbmdzLiBNYXliZSB0aGF0J3MgYSBn
b29kIGlkZWEsIHRvIGluZGljYXRlIHRoYXQgd2UgcHJlZmVyIHRoZSBwb3dlci0NCj4gZG9tYWlu
IGJpbmRpbmdzIHdoZW4gZ29pbmcgZm9yd2FyZD8NCg0KQnV0IHdoeSB1c2UgcG93ZXItZG9tYWlu
cz8gUG93ZXIgZG9tYWlucyBtYXkgbm90IHNhbWUgYXMgcGVyZiBkb21haW5zDQpwZXIgbXkgdW5k
ZXJzdGFuZGluZyBhbmQgU0NNSSBzcGVjIG5vdCBoYXMgc3VjaCByZXN0cmljdGlvbi4NCg0KQ3Vy
cmVudGx5IG91ciBTQ01JIHNlcnZlciBwb3dlciBkb21haW4gaWRzIGFuZCBwZXJmIGRvbWFpbiBp
ZHMgYXJlDQpkaWZmZXJlbnQuICBJZiBsaW51eCBoYXMgdGhlIHJlc3RyaWN0aW9uIHRoYXQgcGVy
ZiBkb21haW4gaWQgc2hvdWxkIGJlIHNhbWUNCmFzIHBvd2VyIGRvbWFpbiBpZCwgd2UgbmVlZCBy
ZWRlc2lnbiBvdXIgc2NtaSBmaXJtd2FyZSBvbiB0aGlzIHBhcnQuDQoNClRoYW5rcywNClBlbmcu
DQoNCj4gDQo+IFsuLi5dDQo+IA0KPiBLaW5kIHJlZ2FyZHMNCj4gVWZmZQ0K
