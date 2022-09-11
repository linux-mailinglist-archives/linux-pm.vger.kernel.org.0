Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FA25B4B41
	for <lists+linux-pm@lfdr.de>; Sun, 11 Sep 2022 03:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiIKBr4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Sep 2022 21:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiIKBrz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Sep 2022 21:47:55 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60045.outbound.protection.outlook.com [40.107.6.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A583730542
        for <linux-pm@vger.kernel.org>; Sat, 10 Sep 2022 18:47:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOwEIkSls4XGu66Qh2LKXvY8sWUiVVZ+AxAEQskF6G4ep6+5mF88hl4/ynctuq29c+VGpFtWxzXCHV58OEyZ83akTq6T5vh4/xhNFPkDYQZ8rUKX0FSdzqX3Y57N7fOwakjaN4vMrB6KUTiBe/pWxK6Qyr8QFW2LM9YnK9gsE1oCnL/wKrW/lL+WZ5CQLj8K++y45TjDhMgDjxHABtuEEg1MB/J8u6uaXENu/DlG1k9tlYy3/6CxM6gkhWLK/Ss4gbkdmQuk50Bv0o7uAUbEmQWD1C+UDUxVE+1Hu//8dWg7R7P46QZTkXH/EA73mLaJ7d7+XFbOshUdtDFvYzuY1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRyqxyZa1dIFEYLafF4Nep19pnqzRUf2LTlgrcumWqY=;
 b=bzW4ILGNPeMyKLt5dwikWHPTT7UEPxADLPFK4fORhZCzwPjXu2s4mdFKgqXq4llAm1zp6ycz8vyOex8a8CGSGPxbsnpYZsp43P9CKiwEewdjX+DtqgSa0qKIxWX0F/7RL8wtF5mARp3TQ/SX5wYRjXaxP5mJvYuhmIKbHVlSnp2Qb990jkeNSIJKzystz6TcYgK2tBZL0vdJ1ICChizPkMua0KnO+ZytCcALXL5HGASJYHJ4MMNv5pNpXlDv9Ktvwm97SSypI92qFthGj8hcspi5BFx+E3DroJttl8gvaJKCvg1CVQ0RZR9bcICaIfMhHhtHc/5wDCoWdagZ1r7FNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRyqxyZa1dIFEYLafF4Nep19pnqzRUf2LTlgrcumWqY=;
 b=r7Qz4kUKvKJL1U7E9FRsvXuPkmEIuro9UwwDpg1hxtJUW3+jJ/XsH1Vja2BpzhKfmc+BwWN5hgZhNoG37SixDH+vm3s/RPxVBXYBgzG5YouHFAPqxpJRwWqqPAifRrjlBsC5X9gKzUIgcN1KUcD/XX8spTrUaB/7fBohRAHTF9g=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8322.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Sun, 11 Sep
 2022 01:47:50 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::75b7:64ed:bc9e:5354]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::75b7:64ed:bc9e:5354%5]) with mapi id 15.20.5612.022; Sun, 11 Sep 2022
 01:47:50 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "npitre@baylibre.com" <npitre@baylibre.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>
Subject: RE: Question: why call clk_prepare in pm_clk_acquire
Thread-Topic: Question: why call clk_prepare in pm_clk_acquire
Thread-Index: AdjDVBjUt0pijoGuQyGRoo5K0OYp9gAPGMmAAAZWSgAAJMn7gABQpY5g
Date:   Sun, 11 Sep 2022 01:47:50 +0000
Message-ID: <DU0PR04MB94175F798F858FDF738BF80088459@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <DU0PR04MB94173B45A2CFEE3BF1BD313A88409@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <CAPDyKFrzJikk6rJr9xwV6W-whvdLe5tTUE+xO_EoRtm+9DAbNA@mail.gmail.com>
 <20220908173840.rqy335cdeg5a2ww5@bogus>
 <CAPDyKFqYDNXxfKHd8PYy8T3di2s206nCiHY7cEf+_EHVrY1YbQ@mail.gmail.com>
In-Reply-To: <CAPDyKFqYDNXxfKHd8PYy8T3di2s206nCiHY7cEf+_EHVrY1YbQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM9PR04MB8322:EE_
x-ms-office365-filtering-correlation-id: 42624ce6-bb61-4b4c-a32d-08da9397a293
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dCpdULKZysbrrGmrNzNzZnrN0pNStf9gJP55/K5DunOhbwtk4uU6YfllVLpY6TWAwpFJkHVVeR9q9vTjZx89OM8CuMXRNm9aNyZq8Fj07IxGCQDEeKpFyUTOo+n8m7TLfoGaCxgr/YOfXqoFKFpz9+9nAWSm+6m+d0D0fr1qJ78Ko1cPhRtBkSxosXlDc6ytOWKjw7ksSlghjFsEqBDpTmKChrf9IL6xO8bv14o58RwUjWoM3lwSEmRf0KR5OgDs4lpbvsdY9dSfu40xdlmq/Zp5pA1SojTLtvG5Vc6IQN9G2EsYXeS3OWu1dqJImlQeGklaSbxzfDYvuCdWOn9XqMyUQJe0dQF7mVkwL1E9dFf0XxuWYdl21UXCBjE3JKbtUYgDoo7Q5JCGAJrH6rFFvtesmqe/uovACx+fZfrMQTbCd+THTdsp5MaDl+2DjWi6NZ1aTne8SuMFBKAKYLdqbzN3VGbML3kg2OP/VZnJZhUEDKeQxPy0yXrRaCTtKyv3DDba/uZP89lb/QQtdZ4Bd7WESODozDVRKXqrJuBLEO7uek7fvRZuetjs063z/WHKa5rip7ySDmG1dIMqwPJJfZmj+fKsx0rYicCAWj/WkzpNHkPb2YrHfME+I41yrpat79yDwg6QQGmR8pMB/zN2KmgG5kctiR8QdCAhKLUZwhIa1QmCWb3D/Y6LTNElT6k85PV4va7UNYP5m1YnqvMi+nN7eYBqSrT0PwhmNC+LKTXEvx2o7tNJlbMg83kGbxmPGfKWvpRJ+po9eqb5/Qsw9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(110136005)(7696005)(6506007)(26005)(38070700005)(9686003)(86362001)(71200400001)(478600001)(122000001)(41300700001)(55016003)(186003)(83380400001)(8936002)(5660300002)(66556008)(66476007)(66446008)(64756008)(66946007)(2906002)(4326008)(54906003)(76116006)(8676002)(52536014)(44832011)(38100700002)(33656002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enVuQTdML3EwL0ZCK1VHTFAxdzZBYnlyZk83bWNyTDJrR1kzelNnek1Eb2NN?=
 =?utf-8?B?aDQ5RldoMGJBdHNxUFVGWmlHQ0VBdStlM3Ixb1VMbnovMHZMYVErUGFqYXFi?=
 =?utf-8?B?R0lnUmlNeHg2UWd6MVBVVGduUERmZDM5Q3g2NVVWbm0wUzBOdDhaazI1QlV1?=
 =?utf-8?B?cFB3S000UmNlV2huc0FWb055cVdiN2kzQjdMc1d2YWFpM2FhK25QWWdJTTRl?=
 =?utf-8?B?eVpGUEZGK0tnaG9BMHdZWDZqc0hmN3NSUHdZZGhMZmVMaWQ3N3VSbzdnSkEx?=
 =?utf-8?B?Z0hMcmdXSWlCT1ZlRXh6SVFwU1U1RGk4QzJKb1k2ZjQ1ZWVTZWlMVWFHTVV4?=
 =?utf-8?B?WjdnNEkvUGxQTFM0cXFXUTJkdUpmMFlSVE9tY0MwSWc3bTIyWmJjYTZCR2l3?=
 =?utf-8?B?TVlucE03ME1zc2N2RzB0RXhyOUpoaW42YjFGU0RvVXJ4SmNEY1ZxNDgyY1VE?=
 =?utf-8?B?dkdoeXUxbWMrQXNqQnducUI4U1pBbEUrcVNvemNrYjhpUVVNeEd2aVppaFlM?=
 =?utf-8?B?Z2tjclBJWXpRcVJ4SmI2VlFzS09rNWxxZzZIa2tsQTZRNnF2UDdLQmlPVFU0?=
 =?utf-8?B?SHNSNnRCYVErSm43YTRVOGxWQnFDSlU3bnJDM0doSzcrMVAzaks5ejlPUHpM?=
 =?utf-8?B?aDdFTURuWUdiR2l0QVRMUm1ZMWloblNtRDdWbFordkNwVWZHdjVmVVUvS1VW?=
 =?utf-8?B?OVBTOU90UXVmNzFzVENaQjlHNzVoOGpXelpRTWJZcVBYT3c4elNhSEJaekxh?=
 =?utf-8?B?VG1nVzVVOXQxMDFFeGxNOThRWm1jMElUbTR4aGVEUHdCb1BFNFZzSUkwM0Zo?=
 =?utf-8?B?aFVIanpzOGQ4SXNJL1MybUF2N3JrTUpNRlkyQm8wYmJLU3F5cFEzc2VEdi9y?=
 =?utf-8?B?WXMwSkhDcUdqL1hHZVpHZE44Q1ZYY3doM2ZHdXNOeVY1aFRXWGQ4WHZYV0Js?=
 =?utf-8?B?K0twSnllNUNpYWs3bVdIZUFQb2VYUURRb09vTUVwYXlyQmppdXArcjFBMURF?=
 =?utf-8?B?VSt2Y0M4c2hvb2paeXNpcjRQYUNhSDdzWVJyTFhoMkZETkF0WVVLSzQ0Y2JS?=
 =?utf-8?B?Y2hHcWpPUVJEWHc2OHNLNFVXL3YrQzV1cUNDS0VkeGtYYmxCTnh5M2U1blg2?=
 =?utf-8?B?cWhKR3d6NUJqMFlreHFRVkJjS3lYbEovclBwUTFFSmdGRDgyT0oxaFRXK3VE?=
 =?utf-8?B?Sld2T1hRTnZVTG1qZFhiOUNYdExXK2hsbWFQWStYSHNtMnpuTzNmbWd5RjM3?=
 =?utf-8?B?YnQzbW56dFUxRk05RlRMOVQySGkzME9INzlLR1B2WHJ6OHNiUDhiV3F1VFIx?=
 =?utf-8?B?S2VIR2xadlV1OVJCZHJNbld3MVJiSTdyM1hJc0laNllZeTVMTVVkNHZGdEY4?=
 =?utf-8?B?ZG1CSzVNbXN4cmIzMlBDSmxHY1Jndk5Wd3F2NXYvRm10N0NMRXdRSDgxblNL?=
 =?utf-8?B?Sk5KejlJQWtTaGh0R1g3a09lUEs0QjcwR01BVCtPK0lOaHVsV0ZpRUFzNWc4?=
 =?utf-8?B?KzZsMWM1bElLdGZMajY1OHpZT1ZLTGFKdmNDelVxWEZwcDZ6MXVSTDdGa2RW?=
 =?utf-8?B?VHZtWkFKT0h3MnB3MzVac2t5MWs1RkJsQXQ3Zm5INmhwTmZPbFV4MzlUcG8z?=
 =?utf-8?B?d0lHNlN6dHpCUksrMktaemNzdi9kazYxb0JMQWhYRmdlN3BtZ29XM1FXaGdn?=
 =?utf-8?B?dEovZlJMTmpUMkNDL3A1aVhZNDZHL1VlbkN4MlBvWC82Q2ZsUTRkVnJqZ2gy?=
 =?utf-8?B?UGFyUE05clgwV01lTU5HVWhGbE8yY0cvRmU1SWhzWEtPVmJJOUliTDhzVmpt?=
 =?utf-8?B?ODRacWtIcnFHU2NSL29QR1puamhSZWNuQXV6b1BzRjhvZlp5Kzh5R3NPQU5J?=
 =?utf-8?B?UGE0ZExRY1ZJY1FrRTNlY1RLWWdmbzlwR01vejA1dWxJS0pSR0pzRmIwSGNt?=
 =?utf-8?B?dDFKSk9SV0NkU0RQa01kQTZIOFFsSW5zc0JCZ0ExdTJLMjVQMzFsdGxrZFVJ?=
 =?utf-8?B?VzVkTHpycEdSUDNyVUJiWjZ4dHpQN3oyeXNqWFFKcDVZbW5PR3hZMUpmZXYx?=
 =?utf-8?B?ZStxLy94S3A2L3F6cVZZRXR0Y0xSR3F6Zy9SdHFNeUMzUWYwc0NkUXJ6QnFT?=
 =?utf-8?Q?oD3w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42624ce6-bb61-4b4c-a32d-08da9397a293
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2022 01:47:50.2807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LaOXqkKpb09ZO7xr3Cb2XsCUO0pQVjQXYDCTmj+mJnPOK89QALj8rQ5GaP9LJPoXI/sk3/wkTWi9/9eClPZXeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8322
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PiBTdWJqZWN0OiBSZTogUXVlc3Rpb246IHdoeSBjYWxsIGNsa19wcmVwYXJlIGluIHBtX2Nsa19h
Y3F1aXJlDQo+IA0KPiBPbiBUaHUsIDggU2VwdCAyMDIyIGF0IDE5OjM4LCBTdWRlZXAgSG9sbGEg
PHN1ZGVlcC5ob2xsYUBhcm0uY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IE9uIFRodSwgU2VwIDA4
LCAyMDIyIGF0IDA0OjM3OjEzUE0gKzAyMDAsIFVsZiBIYW5zc29uIHdyb3RlOg0KPiA+ID4gT24g
VGh1LCA4IFNlcHQgMjAyMiBhdCAwOTozMywgUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+IHdy
b3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBIaSBBbGwsDQo+ID4gPiA+DQo+ID4gPiA+IFdlIGFyZSBm
YWNpbmcgYW4gaXNzdWUgY2xrX3NldF9yYXRlIGZhaWwgd2l0aCBjb21taXQgYTNiODg0Y2VmODcz
DQo+ICgiZmlybXdhcmU6DQo+ID4gPiA+IGFybV9zY21pOiBBZGQgY2xvY2sgbWFuYWdlbWVudCB0
byB0aGUgU0NNSSBwb3dlciBkb21haW4iKSAsDQo+ID4gPg0KPiA+ID4gSG1tLCBJIHdvbmRlciBh
Ym91dCB0aGUgbWFpbiByZWFzb24gYmVoaW5kIHRoYXQgY29tbWl0LiBDYW4gd2UNCj4gPiA+IHJl
dmVydCBpdCBvciBpcyB0aGVyZSBzb21lIHBsYXRmb3JtL2RyaXZlciB0aGF0IGlzIHJlYWxseSBy
ZWx5aW5nIG9uIGl0Pw0KPiA+ID4NCj4gPg0KPiA+IElJVUMsIGF0IHRoZSB0aW1lIG9mIHRoZSBj
b21taXQsIGl0IHdhcyBuZWVkZWQgb24gc29tZSBSZW5lc2FzIHBsYXRmb3JtLg0KPiA+IE5vdCBz
dXJlIGlmIGl0IGlzIHN0aWxsIHVzZWQgb3Igbm90Lg0KPiANCj4gT2theSEgTWF5YmUgTmljbyBy
ZW1lbWJlcnMgbW9yZSwgYXMgaGUgYXV0aG9yZWQgdGhlIHBhdGNoLi4uDQo+IA0KPiBOb3JtYWxs
eSBpdCdzIGJlc3QgZGVjaWRlZCBvbiBhIHBsYXRmb3JtIGJhc2lzLCB3aGV0aGVyIGl0IHJlYWxs
eSBtYWtlcw0KPiBzZW5zZSB0byB1c2UgdGhlIEdFTlBEX0ZMQUdfUE1fQ0xLLiBBcyB0aGUgc2Nt
aSBwb3dlciBkb21haW4gaXMgYQ0KPiBjcm9zcyBwbGF0Zm9ybSBwb3dlciBkb21haW4sIGl0IHdv
cnJpZXMgbWUgdGhhdCB3ZSBsb3NlIHNvbWUgbmVlZGVkDQo+IGZsZXhpYmlsaXR5LCB3aGljaCBp
cyBsaWtlbHkgdG8gbWFrZSBpdCBtb3JlIGRpZmZpY3VsdCB0byB1c2UgaXQgZm9yIHNvbWUNCj4g
cGxhdGZvcm1zLiBBbHNvIG5vdGUsIHRoZSBtYWluIHBvaW50IGJlaGluZCBHRU5QRF9GTEFHX1BN
X0NMSywgd2FzIGp1c3QNCj4gdG8gY29uc29saWRhdGUgY29kZS4NCj4gDQo+IFRoYXQgc2FpZCwg
SSBkZWNpZGVkIHRvIGRvIHNvbWUgcmVzZWFyY2gsIGJ5IGxvb2tpbmcgYXQgdGhlIERUUyBmaWxl
cyBpbiB0aGUNCj4ga2VybmVsLiBTbyBmYXIsIHRoZXJlIGlzIG9ubHkgSnVubyBhbmQgdGhlIGlt
eDggYmFzZWQNCj4gcGxhdGZvcm0ocykgdGhhdCBhcmUgdXNpbmcgdGhlIHNjbWkgcG93ZXIgZG9t
YWluLg0KPiANCj4gRm9yIHRoZSBpbXg4IGJhc2VkIHBsYXRmb3JtcyBbMV0sIHRoZXJlIGFyZSBv
bmx5IHRocmVlIGNvbnN1bWVycyAodGhyZWUNCj4gbW1jIGNvbnRyb2xsZXJzKSBvZiB0aGUgc2Nt
aSBwb3dlciBkb21haW4gKCJzY21pX2RldnBkIikuIFRoZQ0KPiBjb3JyZXNwb25kaW5nIG1tYyBo
b3N0IGRyaXZlciBpcyB0aGUgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYywNCj4g
d2hpY2ggbmVlZHMgdG8gaGFuZGxlIHRoZSBjbG9ja3MgaXRzZWxmLiBJIGFzc3VtZSB0aGlzIGlz
IHRoZSBvbmUgUGVuZyBpcw0KPiByZWZlcnJpbmcgdG8uDQoNClllcywgc2RoYyBpcyBqdXN0IG9u
ZSBvZiB0aGUgZGV2aWNlcywgd2UgaGF2ZSBzb21lIGRvd25zdHJlYW0gZHJpdmVyDQphbHNvIGhh
cyBpc3N1ZSB3aXRoIHVzaW5nIHNjbWkgcG93ZXIgZG9tYWluLg0KDQo+IA0KPiA+DQo+ID4gPiA+
DQo+ID4gPiA+IHdlIHVzZSBzY21pIHBvd2VyIGRvbWFpbiwgYnV0IG5vdCB1c2Ugc2NtaSBjbGss
IGJ1dCB3aXRoIHVwcGVyDQo+ID4gPiA+IGNvbW1pdCwgdGhlIGNsayBpcyBwcmVwYXJlZCB3aGVu
IHBtX2Nsa19hY3F1aXJlLg0KPiA+ID4gPg0KPiA+DQo+ID4gSXMgdGhpcyBiYXNlZCBvbiBsYXRl
c3QgU0NNSSBjbG9ja3MgdGhhdCBzdXBwb3J0IGF0b21pYyBvciBvbGRlciBvbmUNCj4gPiB3aGlj
aCBkb2Vzbid0LiBJZiBsYXR0ZXIsIEkgc2VlIHBtX2Nsa19hY3F1aXJlIGRvZXNuJ3QgYWN0dWFs
bHkgY2FsbA0KPiA+IHByZXBhcmUgYXMgaWYgY2xrX2lzX2VuYWJsZWRfd2hlbl9wcmVwYXJlZChj
bGspID0gdHJ1ZS4gRG8geW91IHNlZQ0KPiA+IGhhdmUgaXNzdWUgPw0KPiANCj4gSXQgZG9lc24n
dCByZWFsbHkgbWF0dGVyIGlmIHdlIHdvdWxkIGJlIHVzaW5nIGFuIGF0b21pYyBjbG9jayBvciBu
b3QuDQo+IA0KPiBUaGUgcHJvYmxlbSBpcyB0aGF0IHdoZW4gdXNpbmcgR0VOUERfRkxBR19QTV9D
TEssIGR1cmluZyBydW50aW1lDQo+IHJlc3VtZSAoZ2VucGRfcnVudGltZV9yZXN1bWUpIHdlIGVu
ZCB1cCBjYWxsaW5nIHBtX2Nsa19yZXN1bWUoKSwgYnV0DQo+IHByaW9yIGludm9raW5nIHRoZSBj
b25zdW1lciBkcml2ZXIncyAtPnJ1bnRpbWVfcmVzdW1lKCkgY2FsbGJhY2suIEluIG90aGVyDQo+
IHdvcmRzLCB0aGUgY2xvY2socykgd2lsbCBhbHJlYWR5IGJlIHByZXBhcmVkIGFuZCBlbmFibGVk
IHdoZW4gdGhlIGRyaXZlcidzIC0NCj4gPnJ1bnRpbWVfcmVzdW1lKCkgY2FsbGJhY2sgZ2V0cyBp
bnZva2VkLiBUaGF0IGNlcnRhaW5seSBpc24ndCBnb2luZyB0byB3b3JrDQo+IGZvciBhbGwgY2Fz
ZXMuDQo+IA0KPiBJbiB0aGlzIHBhcnRpY3VsYXIgY2FzZSwgc2RoY2lfZXNkaGNfcnVudGltZV9y
ZXN1bWUoKSBuZWVkcyB0byBtYWtlIHNvbWUNCj4gcHJlcGFyYXRpb25zIGJlZm9yZSBpdCBjYW4g
cHJlcGFyZS9lbmFibGUgdGhlIGNsb2NrcyAoaXQgY2FsbHMNCj4gY2xrX3NldF9yYXRlKCkgZm9y
IGV4YW1wbGUpLg0KDQpZZXMsIGJlY2F1c2UgdGhlIGNsayBwcmVwYXJlZCwgaW4gcnVudGltZSBy
ZXN1bWUsIHRoZSBjbGsgd291bGQgbm90IGFibGUNCnRvIHN1cHBvcnQgcmVwYXJlbnQgYW5kIHNl
dCByYXRlLCBiZWNhdXNlIENMS19TRVRfUEFSRU5UX0dBVEUsDQpDTEtfU0VUX1JBVEVfR0FURSBh
cmUgaW4gd2hlbiByZWdpc3RlcmluZyB0aGUgY2xrLCB1bmxlc3Mgd2UgZG8NCmNsa191bnByZXBh
cmUgZmlyc3QuDQoNCj4gDQo+ID4NCj4gPiA+ID4gSG93ZXZlciB0aGUgY2xrIGhhcyBmbGFnIENM
S19TRVRfUkFURV9HQVRFLCBjbGtfc2V0X3JhdGUgd2lsbCBmYWlsDQo+ID4gPiA+IGluIGRyaXZl
ciwgYmVjYXVzZSBjbGsgaXMgcHJlcGFyZWQgaW4gcG1fY2xrX2FjcXVpcmUuDQo+ID4gPiA+DQo+
ID4NCj4gPiBXaGVyZSBpcyBDTEtfU0VUX1JBVEVfR0FURSBzZXQgZXhhY3RseSA/DQo+ID4NCj4g
PiA+ID4gTG9va2luZyBpbnRvIGRyaXZlcnMvYmFzZS9wb3dlci9jbG9ja19vcHMuYywgSSBzZWUN
Cj4gPiA+ID4gcG1fY2xrX3N1c3BlbmQvcG1fY2xrX3Jlc3VtZSB3aWxsIGhhbmRsZSBjbGsgcHJl
cGFyZS91bnByZXBhcmVkLA0KPiBzbyB3aHkgcG1fY2xrX2FjcXVpcmUgd2lsbCBhbHNvIHByZXBh
cmUgdGhlIGNsaz8NCj4gPiA+DQo+ID4NCj4gPiBBcyBhc2tlZCBhYm92ZSBkbyB5b3Ugc2VlIHRo
ZSBhY3R1YWwgY2xrX3ByZXBhcmUgZ2V0dGluZyBjYWxsZWQgYXMgSQ0KPiA+IHNlZSBpdCBpc24n
dCBpZiBsa19pc19lbmFibGVkX3doZW5fcHJlcGFyZWQoY2xrKSA9IHRydWUuDQo+ID4NCj4gPiA+
IEkgYWdyZWUsIHRoZSBiZWhhdmlvdXIgaXMgY2VydGFpbmx5IHF1ZXN0aW9uYWJsZSB0byBtZSB0
b28uIEhvd2V2ZXIsDQo+ID4gPiBpdCBtYXkgYmUgdHJpY2t5IHRvIGNoYW5nZSBieSBub3csIGR1
ZSB0byB0aGUgZGVwbG95bWVudCB0aGF0IGhhcw0KPiA+ID4gaGFwcGVuZWQgb3ZlciB0aGUgeWVh
cnMuDQo+ID4gPg0KPiA+DQo+ID4gQWdyZWVkLg0KPiA+DQo+ID4gPiBJbiBwcmluY2lwbGUgd2Ug
d291bGQgbmVlZCB0byBtYWtlIHRoZSBwYXJ0IHdoZXJlIHBtX2Nsa19hY3F1aXJlDQo+ID4gPiBw
cmVwYXJlcyB0aGUgY2xvY2sgdG8gYmVjb21lIG9wdGlvbmFsLCBpbiBzb21lIGNsZXZlciB3YXku
DQo+ID4gPg0KPiA+DQo+ID4gSSBzZWUgaXQgaXMgYWxyZWFkeSwgbGV0IHVzIHNlZSB3aGF0IGlz
IFBlbmcncyBvYnNlcnZhdGlvbi4NCj4gDQo+IFllcywgZ29vZCBwb2ludCwgSSBkaWRuJ3Qgbm90
aWNlIHRoYXQhIEhvd2V2ZXIsIGFzIHN0YXRlZCBhYm92ZSwgaXQgc2VlbXMgbGlrZQ0KPiBpdCBk
b2Vzbid0IHJlYWxseSBtYXR0ZXIuDQo+IA0KPiBJbiBteSBvcGluaW9uIHdlIHNob3VsZCByZWFs
bHkgdHJ5IHRvIG1vdmUgYXdheSBmcm9tIHVzaW5nDQo+IEdFTlBEX0ZMQUdfUE1fQ0xLIGZvciB0
aGUgc2NtaSBwb3dlciBkb21haW4uIEkgY2FuIHByZXBhcmUgYSBwYXRjaCwgaWYNCj4geW91IHRo
aW5rIGl0IG1ha2VzIHNlbnNlPw0KDQpUaGF0IHdvdWxkIGJlIHdlbGNvbWVkLCBhbmQgSSBjb3Vs
ZCBoZWxwIHRlc3QuDQoNClRoYW5rcywNClBlbmcNCj4gDQo+ID4NCj4gPiAtLQ0KPiA+IFJlZ2Fy
ZHMsDQo+ID4gU3VkZWVwDQo+IA0KPiBLaW5kIHJlZ2FyZHMNCj4gVWZmZQ0K
