Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE497CC47A
	for <lists+linux-pm@lfdr.de>; Tue, 17 Oct 2023 15:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343819AbjJQNS6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Oct 2023 09:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235141AbjJQNSo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Oct 2023 09:18:44 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2052.outbound.protection.outlook.com [40.107.8.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA4D1A1
        for <linux-pm@vger.kernel.org>; Tue, 17 Oct 2023 06:18:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=huVjSDDl72HI0AveiTHD5WMtc3cOmA1J/h7uRZ0UN+MKk6PfqghPTNoKRkC7a2xplfZFZP81kyf5knNyYLvCCHvFBJKybVxCXiwo0x7r7K60RwRSVu0koLKoCECklj4uPK3/Ygc7Arpp4fYDjJI2utSqt9EEePjmFbgIvluka/ocj74kXidiJzaMefAPFhzi8KMmq5VdyR8uQ4iaZAKU8Fk9IjHqqdlaK06JdT7bfGxFdslIOJYnQlc1cBhdCKrNmezb62Gkqo3kF4kIkIjG7vb7REFjyqfSgNus666gxu8HXR6QGYMU+p1tZOoo2m3NaQux2OhTM0MrfTfpm0f7cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8j54BdqnVf6xUYhPm+SPSsncDkPJORPRh8Bgu14IrK8=;
 b=MLbzJ4W9MsSipMGDBvFrgBD1hcv2oHepTTq+4Rr3uoprAZ7nB+l5tDnS2CVLM00emhV2JCEbeYAJfSdSzm8M7M9y3TOOqva2UN9hAlQyHv28fH8PnaNDuv8wrsswBvW1sYxdHYLT1kbYVxp9B6HxOCBzkgrwKB6xSy736wYcIIhO7N/phX/+sjRAlXc9GfrO5n/zV+t8Jq/usBesVsbRYov8NaT+gSUHnLlfkrQAxv5w1Li8NRBnI4AsRThIj1yIJROuCPWMQwudYw53r0gs7j477O6c/7Ox/GfdY9mdYGuA5oZyHIrtzNnSHWIv065rqfxSoPMMiSOvqRbN329qwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8j54BdqnVf6xUYhPm+SPSsncDkPJORPRh8Bgu14IrK8=;
 b=n3LpIYYo1vYUiEiq8U1SnRIQAoC1rW3kxBps2IYYbPBf6EkkYRLDTXBRdGDsQ5zwTGqzC5wsJUxDZqD13F8H9xhvYUNZRiC7CaBr0IYQuinDOcufPNyve5sL/m1jaPzNyuk6yFyIMLzL+7rIbzoS6zVz+3xA5Z6lRBohkbA+vYs=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB9961.eurprd04.prod.outlook.com (2603:10a6:10:4ee::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 13:18:38 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::7a96:ccb1:6dbf:c381]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::7a96:ccb1:6dbf:c381%6]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 13:18:38 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Glen G Wienecke <glen.wienecke@nxp.com>
Subject: RE: Question regarding scmi_perf_domain.c
Thread-Topic: Question regarding scmi_perf_domain.c
Thread-Index: Adn7ZJVuPYTdu0ufRKeeVXBw4lJjnAAA6M+AAAA+SYAAALxWIAADapAAAABn5rAAAKUSgAAAVlkAAAJ6koAAEqiu0AAUSrsAAAoXaoAALVG/gADP+DUAAC4lOtA=
Date:   Tue, 17 Oct 2023 13:18:38 +0000
Message-ID: <DU0PR04MB9417BDFD8570B5406A62901788D6A@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20231010105503.jwrmjahuvcjgwtk5@bogus>
 <CAPDyKFqEpnKeF7Yuvv_a+=Kqs=pNU_kM59EqWdpCniHrY_373A@mail.gmail.com>
 <DU0PR04MB941755466872E84217378F6388CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010130054.ieylxocuapugajif@bogus>
 <DU0PR04MB94177FFEAA62AC27839D826F88CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010133059.57rs52qedrc5mxfr@bogus>
 <DU0PR04MB9417D01218CA4803D00545A788CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010145137.fyxjlsj5qq3elq7l@bogus>
 <DU0PR04MB9417233F914A061FB0A23B3088CCA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <CAPDyKFo32GQdgMWJ_rkb88mcdc+0jYubWiCapf99Zg9JTnNnPw@mail.gmail.com>
 <20231011141551.exqxkmt3xsl5fyjh@bogus>
 <CAPDyKFrWjAdujOr8JX5_JawaKqs0_MYUrsUN57XaB9q=darJ0w@mail.gmail.com>
 <CAPDyKFoJpnF_CezT6RySPpAwJY0+LO+RiSqqM=byTaRibKQPyg@mail.gmail.com>
In-Reply-To: <CAPDyKFoJpnF_CezT6RySPpAwJY0+LO+RiSqqM=byTaRibKQPyg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DB9PR04MB9961:EE_
x-ms-office365-filtering-correlation-id: 724ba5c5-cede-4674-4977-08dbcf139358
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6yeGQJO32pYTx1J/hGZXOpNd7x8/r0f90SBHZBHY5sz8Bq92Y29o1WUGvhOfDJoh4SqiKRlq9t6LiV3hzdjNuxmw+YnclufF4Fzo+AdA3aUCjqr0d6zldASuIK/zBWG4TbG/BDcepDsG11u12OSdnOTXrswqMva/0FeGdVponrHCicuJPlg4fv2+Mr1HVWBSZJwCjuI5BmkSNaLO+trdOTi/3dLJl8cUt7ZPlX0pdv1APN3cDIX+e2yAFX/riisD4bvEu4rpC/R/FhVfVPsPvozznh7UY4kvlbfjPSUiADvOV6zaxlKvjbZAHJhk/1I6LUR5dO2G8Zi/JEmmFsMRSFGUUmdYImr2/2t1X2qmfXswCwynlMlqbxftRZgDsHClUdqczA/JNE5gEb/FksLFn53et5O96Ou8Ku2sQX0+kC0y1wuqsJGmmz86S2hwleiuZsKx1sWAL4/2/Wfcgt+qg1WT6ZepHlLyc/Ppn8njvpVoe0XQ3sSh6ihwhtlqlzr217BU2toaUwkptOY683sAy35jsBUIv4Mi8/G1jAKUBnB43p96AmJ2b3jh4+9JZriaJEmU+y4j1B0gdYy5nXBvHH9vtcuJ/+z1xdNktH7/+4vEcO1hcLpjaTjI4zmWg4RV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(366004)(396003)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(478600001)(76116006)(66446008)(66476007)(54906003)(316002)(110136005)(66946007)(66556008)(33656002)(26005)(7696005)(64756008)(6506007)(2906002)(9686003)(8936002)(52536014)(8676002)(4326008)(5660300002)(44832011)(71200400001)(41300700001)(86362001)(38070700005)(122000001)(38100700002)(83380400001)(66899024)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFY3MzJENnJwMU1mSkZwRzV3Q3ZNWFFuK2ZEUXBJNHZsanpLVFZodGxxeDBy?=
 =?utf-8?B?L2UyUURCWHZUM1hOTWcyV2RObEJ4V21LbUZEeVVVZW9oMi9aZ1hQdlJ6V2JU?=
 =?utf-8?B?U0kwU3ZEaHBoNFA4b3JXVXVxYmtvRHJzbWtRTDZBckR2ZFNpclBLSDNQMGxD?=
 =?utf-8?B?SXJHTndHWVdISnJrUjMrdVlzRXlPbUk2M2pGeWFVei9jbWRPNzBITFZmZVQ0?=
 =?utf-8?B?dFprVXdYY1k2ZysrYTEyQjJuMk9wUHloNkoyRVVSL0p2Y1hhc203bmpaSnZY?=
 =?utf-8?B?VTVzalFseWJNRzVyWGh3Zk16YjMvcmZqWVpUTTBRcFM5TW15dHlMMWtNdDh0?=
 =?utf-8?B?NUNaN0IyakIvY3NLNFVIM2xsTW90QmVqcG1tazJ5VkptWXBRU0FOaG9KbCtO?=
 =?utf-8?B?MVhWY2Y0TzZldEd6bjY3U2VMRUJ0NXdYM25SRlF3MVAxeTNYKzFyTnVVTXJV?=
 =?utf-8?B?SWNmUkZ6NGtrMG12SkJISitMNVVUNXNxNlVYZU9lQW9mR2tvUzR4bUpwWStT?=
 =?utf-8?B?eHZ4amZ0VnNLWFA4ODVCaHc4SHlYMm4zcVNyL25qMmREMHIrT1pPYUROeFNy?=
 =?utf-8?B?bVg0UjFDVStCZVVjZ3lHQkxJY2kyZmhmd3V3dlllUUpPZFFKTGJSd2dEaWdr?=
 =?utf-8?B?MXlXbjJCdXRZQ3lUSGZXRmw2R091UGJxaHNwM1VlZkhkVmIvOTJYQXlyOUJJ?=
 =?utf-8?B?SzNJZU1qSU1CbkJ2ckNOcXk0N3FMZmZuTTRzbEo3N0s5NTZGZ29reUYyMkFD?=
 =?utf-8?B?WXJJTmhLNWR2UVdOUmZNVEovQU41bm5NRG13OXlMeXptdmNCYndzZkVuNGp5?=
 =?utf-8?B?OENiaTFWcUJSTGZJODNkS0Rvd084aG5aTmhWSE9hYXNKUERDT2pvM3ZqK3BG?=
 =?utf-8?B?eVZHb0dlTUp6dG56UnlaWWNadVVTck9Yc1ZPS29xblBRQjVwaVZUOEEzanBV?=
 =?utf-8?B?RVFLa2JYVzBjWnY5YWMyMVhLbmNwK05CS1pKajE0QWphdEdXZkZnU1g1OHlE?=
 =?utf-8?B?N0loNlVzemU2Rm1ycGlnVnZrR29VeEdXT0ZRbzlORjJqcHc3MW9LZUEwckJz?=
 =?utf-8?B?SFlTbjZnRjc1MFhlTDAyVFpNdkxhZVNoemd1RTZXTENpYWdQNGliU2hyTGxQ?=
 =?utf-8?B?UUN1MzlRdnNKVVdvdDRRYk5DdWhGdktxcXJWS3hxTURDNzlWTWJ6WU0vanBJ?=
 =?utf-8?B?OFBJcE9xZGg1N3FNUVRBVVg0dVNEV1VDTmxLU004eTRqTnhlS2pqaER2Z3NF?=
 =?utf-8?B?OXk2aDJiNDFHQVFidDF3Tk1EZTNmS1JUc3dvQzNsSElzUVhPZXhyc04vR2Jm?=
 =?utf-8?B?RTc1eEc2VnNuS2lFTFd6eXoycUNISTN1RnRpWXNBYVNDV3dFRCtkZHdSd2dD?=
 =?utf-8?B?NUtkbnFETEV4Unp2Q1RHNW9lcFNOVXhPWDNSR2o2M1g0K3VZNnZXMUpDbFdG?=
 =?utf-8?B?Q3NhcmxmZm5OUFo0TU4wc0ZYVXlDNmdIeHdyTndQdklmLzVtdVRHMDcvNktq?=
 =?utf-8?B?eXNiTFFIN1c0eVQ5K2R6eXJVWmd6bVF4S0dnQkkxQk4xd3J4NUtwWFNMUEh2?=
 =?utf-8?B?eWdmWUxqbTRLSkh6U0hsNjBMRDhNWlNuaUR0Vml1UUsvVVNZeDRuQnNFd0Zy?=
 =?utf-8?B?Ym1pc3JHSk9XRkdiUGRSTmF0NCs1VkxWbmYzUEZhTnFQSjRJdkpVZVEvMVV0?=
 =?utf-8?B?NmZXUEJxY1lCV1RramxWYzNGdGw2RHpLcXpxdFZublErUkJTRlJyeDhQNlI0?=
 =?utf-8?B?N2ZtZEpSOTNVZGMxd0FVQjJPbnl2dUFVTUR4MmZjSyt3SEg0aHpUNlNjbDdp?=
 =?utf-8?B?TENVMWp2ZmZlOTdwVWhMR2FLeU5JMUZIb00zS05kdEltUXhDM0J1WGdaVUFo?=
 =?utf-8?B?QUhoSVJ5Y0Y3dTB4Tit5UTMvcm1rdWUydHNaNnBBekp1Z205djRJRWRmWFBU?=
 =?utf-8?B?TVYrZ1JpQlNnWkFJYk5DM1hHV2drbGFXbGdtb05FcUltd1hGZlF5alpIdE03?=
 =?utf-8?B?MFROYTlYNEU3OEU4K2kvWFM5STJ3YXJjNWdoK0tPa003dUxxZzczM1NrYi8v?=
 =?utf-8?B?ZUFhTm50Yy9Ga1IwbDdacXk0eWRFYVZtMlgweVpUYlBKbmd4K1dTREpKLzZa?=
 =?utf-8?Q?kgJ4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 724ba5c5-cede-4674-4977-08dbcf139358
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 13:18:38.6395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nzJEB+bE6MxaBXp3cUjOALj+hfhKoqhq/mufjB7NiePbJYpn8EZbTLwYdqm81lJQSFDtuVqZRabLVxXyOiI0Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9961
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PiBTdWJqZWN0OiBSZTogUXVlc3Rpb24gcmVnYXJkaW5nIHNjbWlfcGVyZl9kb21haW4uYw0KPiAN
Cj4gT24gVGh1LCAxMiBPY3QgMjAyMyBhdCAxMzo1MywgVWxmIEhhbnNzb24gPHVsZi5oYW5zc29u
QGxpbmFyby5vcmc+IHdyb3RlOg0KPiA+DQo+ID4gT24gV2VkLCAxMSBPY3QgMjAyMyBhdCAxNjox
NywgU3VkZWVwIEhvbGxhIDxzdWRlZXAuaG9sbGFAYXJtLmNvbT4NCj4gd3JvdGU6DQo+ID4gPg0K
PiA+ID4gT24gV2VkLCBPY3QgMTEsIDIwMjMgYXQgMTE6MjY6NTRBTSArMDIwMCwgVWxmIEhhbnNz
b24gd3JvdGU6DQo+ID4gPg0KPiA+ID4gWy4uXQ0KPiA+ID4NCj4gPiA+ID4gTm90IHN1cmUgZXhh
Y3RseSB3aGF0IHlvdSBhcmUgcmVmZXJyaW5nIHRvIHdoZW4gc2F5aW5nIHRoYXQNCj4gPiA+ID4g
ImF1dG9tYXRpYyBwb3dlciBkb21haW4gb24gaXMgYnJva2VuIi4gR2VucGQgcG93ZXItb24gdGhl
IFBNDQo+ID4gPiA+IGRvbWFpbiBmb3IgYSBkZXZpY2UgdGhhdCBnZXRzIGF0dGFjaGVkIHRvIGl0
LCBpZiB0aGUgZGV2aWNlIGhhcyBvbmx5IGENCj4gc2luZ2xlIFBNIGRvbWFpbi4NCj4gPiA+ID4g
VGhpcyBpcyB0aGUgbGVnYWN5IGJlaGF2aW91ci4NCj4gPiA+ID4NCj4gPiA+ID4gV2hlbiB3ZSBh
ZGRlZCBzdXBwb3J0IGZvciBtdWx0aXBsZSBQTSBkb21haW5zIHBlciBkZXZpY2UsIHdlDQo+ID4g
PiA+IGRlY2lkZWQgdG8gKm5vdCogcG93ZXItb24gdGhlIFBNIGRvbWFpbiwgaWYgdGhlIGRldmlj
ZSB0aGF0IGdldHMNCj4gPiA+ID4gYXR0YWNoZWQgaGFzIG11bHRpcGxlIFBNIGRvbWFpbnMuIFRo
aXMgYmVoYXZpb3VyIHdhcyBjaG9zZW4NCj4gPiA+ID4gZGVsaWJlcmF0ZWx5LCB0byBhbGxvdyBj
b25zdW1lciBkcml2ZXJzIHRvIGRlY2lkZSB0aGVtc2VsdmVzDQo+ID4gPiA+IGluc3RlYWQuIElz
IHRoZXJlIGEgcHJvYmxlbSB3aXRoIHRoaXMgeW91IHRoaW5rPw0KPiA+ID4gPg0KPiA+ID4NCj4g
PiA+IEp1c3QgbXkgdW5kZXJzdGFuZGluZy4gU2luY2UgdGhlIHNlY29uZCBQTSBkb21haW4gYWRk
ZWQgbm93IGlzIGZvcg0KPiA+ID4gcGVyZiBhbmQgaXMgbm90IHN0cmljdGx5IHBvd2VyIGRvbWFp
biwgUGVuZydzIGNvbmNlcm4gaXMgc3dpdGNoaW5nDQo+ID4gPiB0byB0aGlzIGJpbmRpbmcgd2ls
bCBtYWtlIHRoZSBwbGF0Zm9ybSBsb29zZSB0aGlzIGF1dG9tYXRpYyBnZW5wZA0KPiA+ID4gcG93
ZXItb24gZmVhdHVyZS4NCj4gPg0KPiA+IFllcywgY29ycmVjdCwgYXMgdGhleSB3YXkgdGhpbmdz
IGFyZSB0b2RheS4NCj4gPg0KPiA+IEl0IGFsbCBib2lscyBkb3duIHRvIHRoYXQgYXR0YWNoaW5n
IGEgZGV2aWNlIHRvIG11bHRpcGxlIFBNIGRvbWFpbnMNCj4gPiBjYW4ndCByZWFsbHkgYmUgZG9u
ZSBpbiBhIGdlbmVyaWMgd2F5LCBhcyBpdCBiZWNvbWVzIGRldmljZS9wbGF0Zm9ybQ0KPiA+IHNw
ZWNpZmljLiBTaW5jZSB0aGlzIG5lZWRzIHRvIGJlIG1hbmFnZWQgYnkgdGhlIGRyaXZlcnMvYnVz
ZXMgYW55d2F5LA0KPiA+IHRoZXkgbWlnaHQgYXMgd2VsbCBnZXQgY29udHJvbCBvZiB3aGF0IFBN
IGRvbWFpbiB0aGV5IG5lZWQgdG8gcG93ZXItb24NCj4gPiB0byBwcm9iZSB0aGVpciBkZXZpY2Vz
Lg0KPiANCj4gRHVlIHRvIHRoZSBhYm92ZSwgaXQgbWlnaHQgYmUgYSBnb29kIGlkZWEgdG8gcG93
ZXItb24gdGhlIFNDTUkNCj4gKnBvd2VyLWRvbWFpbnMqIGR1cmluZyBib290IGFuZCBsZWF2ZSB0
aGVtIG9uIHRvIGFsbG93IGRyaXZlcnMgdG8gY29udGludWUNCj4gdG8gcHJvYmUgdGhlaXIgZGV2
aWNlcz8NCg0KRm9yIGRlYnVnLCB0aGlzIGlzIG9rLiBCdXQgcmVsZWFzZSB0aGUgY29kZSBmb3Ig
cHJvZHVjdGlvbiwga2VlcCB0aGVtIGVuYWJsZWQNCmR1cmluZyBib290IGlzIG5vdCBnb29kLg0K
PiANCj4gTWF5YmUgYSBtb2R1bGUgcGFyYW1ldGVyIG9yIEtjb25maWcgZGVidWcgb3B0aW9uIGNv
dWxkIGJlIHVzZWQgdG8gY29udHJvbA0KPiB0aGlzPw0KDQpHcmVnIG1pZ2h0IG5vdCBiZSBoYXBw
eSBmb3IgaW50cm9kdWNpbmcgbW9kdWxlIHBhcmFtZXRlciwgSSBndWVzcy4NCg0KPiANCj4gSW4g
dGhpcyB3YXkgYW4gdXBkYXRlZCBEVFMgd2l0aCB0aGF0IGFkZHMgYSBwZXJmb3JtYW5jZSBkb21h
aW4gdG8gYQ0KPiBjb25zdW1lciBkZXZpY2Ugbm9kZSAod2hpY2ggYWxyZWFkeSBoYXMgYSBwb3dl
ci1kb21haW4pLCBzaG91bGQgYWxsb3cgdGhlDQo+IGNvbnN1bWVyIGRyaXZlciB0byBjb250aW51
ZSB0byBwcm9iZSBzdWNjZXNzZnVsbHkuDQo+IA0KPiBQZW5nLCB3b3VsZCB0aGlzIHJlc29sdmUg
eW91ciBjb25jZXJuPw0KDQpBY3R1YWxseSBJIGFtIG5vdCBzdXJlLiBtdWx0aXBsZSBQRCBpcyBu
b3QgYSB0ZWNobmljYWwgaXNzdWUsIGl0IGlzIGp1c3QgYWRkaW5nDQptb3JlIGNoYW5nZXMgdG8g
dmFyaW91cyBkZXZpY2UgZHJpdmVycywgd2UgaGF2ZSBWUFUvR1BVL0RJU1BMQVkvTlBVLw0KSFNJ
Ty9DQU1FUkEgYW5kIGV0Yy4uIHNvIGFsbCB0aGUgZHJpdmVycyBuZWVkIHVwZGF0ZSwgd2hpY2gg
aXMNCm5vdCB3ZWxjb21lZCBieSBkcml2ZXIgZGV2ZWxvcGVycyA6KQ0KSSBhbSBzdGlsbCB0cnlp
bmcgdG8gZW5hYmxlIG11bHRpcGxlIFBEIGZvciBzYXlpbmcgTU1DLA0KYW5kIHNlZSBob3cgaXQg
d29ya3MgYWZ0ZXIgYWRkaW5nIHBlcmZvcm1hbmNlIGRvbWFpbiBhbmQgaG93IGRldmljZQ0KZHZm
cyB3b3JrcyBpbiBzdWNoIGNhc2UuDQoNClRoYW5rcywNClBlbmcuDQoNCj4gDQo+IEtpbmQgcmVn
YXJkcw0KPiBVZmZlDQo=
