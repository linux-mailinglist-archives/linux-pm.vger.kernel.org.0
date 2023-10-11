Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932FF7C5285
	for <lists+linux-pm@lfdr.de>; Wed, 11 Oct 2023 13:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbjJKLw0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Oct 2023 07:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbjJKLwZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Oct 2023 07:52:25 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2074.outbound.protection.outlook.com [40.107.14.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58262B0
        for <linux-pm@vger.kernel.org>; Wed, 11 Oct 2023 04:52:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BP4KBB33UOuPxuix66e7ScFhVFDqSbaZ8fw9FDhXbUc6BzgFwJ7CWu2Kk8yuzF4haNCBmcPC80ckCjF4tTjF+NaOcwtgJyYvrqvHaS69nAA9Dh5WuInCas7ZwKwSFP/P2t8nBIhqJ5pSaUVm7laMx/yQx4jd3UCZfVlktfLC23s6uqT3WGv+D44kUA38hxvgovr6uQsZ4c4kqMBnZMWP7MLGgVsC8y7Fp2YuH7EYewW23t8opg1sCf4utfuKmx+XiT08sbSh+lbJ41BYMGyIuG+nsH74rqDEmME2WRTtsrn+jV/OlF1YWItHC0kc2kqakDgKsxqHwnSupxpL37aGjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ZDFgMukGcEPqtMmH/vrwMWolNWbgPcNVpBWewmL1AY=;
 b=dd7dk1L5Fg6tgMR/bxe8RaHTkfGo6kO+mv1nYgWOLL/4avX23DPGInWQDKqNEUSRxOWO9RL72vLAbbuiseoYTvBk+QljbGK77Nz4fihJRIO8VD9NxE8suR0QdA8rd2sz0CZGIwOxt93XiBRQPgwcJYjy0YgJBxjbbrdZE5VuaP9EYXWp2Jir13mybLAWz4EquNaw33eQpAQrQwSmqyXj27emctOo5O3GBXk0haxtgG8XM/WpWSIVSoo8HyYp+JP3iXBd83V0rwLLT+X08sjsp3SKBmM06DNYQA9V/0c1IqVN3v8B6WZg3THmv5bT4udsJ4OAS/BAYvVVb7Q52JyyJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZDFgMukGcEPqtMmH/vrwMWolNWbgPcNVpBWewmL1AY=;
 b=SkgOjopIBa0+BUqnN7XEgRuGWCaI5iNHv2osre+BGwfcxMU/FOLDjDoaIqj97twfheztzMjwdCIQvzIAeOvejvsSBTEu46XSkYSDn7Wo7c+FR4tVbWQfbHxB/qgF2QPFJ82uIVXALd61T/E7GOvXW7xcsvghvRPXX1r5JZbeLyw=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by GV1PR04MB9055.eurprd04.prod.outlook.com (2603:10a6:150:1e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Wed, 11 Oct
 2023 11:52:19 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6838.040; Wed, 11 Oct 2023
 11:52:19 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Sudeep Holla <sudeep.holla@arm.com>,
        "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Glen G Wienecke <glen.wienecke@nxp.com>
Subject: RE: Question regarding scmi_perf_domain.c
Thread-Topic: Question regarding scmi_perf_domain.c
Thread-Index: Adn7ZJVuPYTdu0ufRKeeVXBw4lJjnAAA6M+AAAA+SYAAALxWIAADapAAAABn5rAAAKUSgAAAVlkAAAJ6koAAEqiu0AAUSrsAAATWA4A=
Date:   Wed, 11 Oct 2023 11:52:19 +0000
Message-ID: <DU0PR04MB9417FE9A445AD251735FAD5288CCA@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <DU0PR04MB9417DE145496DC03579F50E488CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010105503.jwrmjahuvcjgwtk5@bogus>
 <CAPDyKFqEpnKeF7Yuvv_a+=Kqs=pNU_kM59EqWdpCniHrY_373A@mail.gmail.com>
 <DU0PR04MB941755466872E84217378F6388CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010130054.ieylxocuapugajif@bogus>
 <DU0PR04MB94177FFEAA62AC27839D826F88CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010133059.57rs52qedrc5mxfr@bogus>
 <DU0PR04MB9417D01218CA4803D00545A788CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010145137.fyxjlsj5qq3elq7l@bogus>
 <DU0PR04MB9417233F914A061FB0A23B3088CCA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <CAPDyKFo32GQdgMWJ_rkb88mcdc+0jYubWiCapf99Zg9JTnNnPw@mail.gmail.com>
In-Reply-To: <CAPDyKFo32GQdgMWJ_rkb88mcdc+0jYubWiCapf99Zg9JTnNnPw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|GV1PR04MB9055:EE_
x-ms-office365-filtering-correlation-id: 98984e71-920b-4475-71fe-08dbca5085f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 48gJzDWYllFV50cEAdl27wdwJqaIwJORNnQOp+AmbjSfgiJYAzMXFBWZAfufEqMiEbXmp625L9vLaFQS304Dj+TGXDMHfpsLS/jS9y1wFeN0lkzr8KqpEDKFJAiphuYAB1WY5WqbfDgOhDe45CmxOQWLBydg0wZE2VE2qwWgd8sa+5zUfkVKpr8AdIjG3snaFWNBMVFiZGLHvXubGhVMVaM70YkiR45WSlRJ8FOUwKhjej5bPZMWZIXgUQFymtoHkrqm9N4s3y0zus/9ZrVwxOP39+ZwYshfkgT5LHv0NrzaLhjTLOpjnBC6eCL6WUtPnmTGcM7IJDFa/rRhWZh3r5dNdDssJNBadgk64yy2olfCmkTbSndcC2xu4faxMXM7IZjL6Sly6BsWgp3IrNHVpzHI/A9wn5k1FlPv8yv1FWZnABi0XAonsuU9jJ5IJZerFVVkl71N9k9cIBeGNuXGJjA5EhZmnW9ietueAYQqbSuP7Gy+y+lfhEj9kc1CSZqJCtG2hTvhCbkqCgadOlOS4vm2TJUhdo8qlluN62j1hv94CHE9WvESOVwSbMNOGzk3yS19/X4EcVc1ViHnykhMh8mrg3VY7nnOG5++swsG56re8WszESQPBPYHg+oOhKLl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(346002)(136003)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(7696005)(9686003)(33656002)(55016003)(38100700002)(86362001)(38070700005)(122000001)(44832011)(83380400001)(2906002)(6506007)(71200400001)(4326008)(478600001)(8676002)(52536014)(8936002)(26005)(6916009)(66476007)(316002)(41300700001)(66556008)(64756008)(76116006)(66446008)(54906003)(66946007)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VngvSGIrSDZ5QWoxM1REdkxHQ09oYjc2SUYxcXF3WTk1SjhWMlppNXpPZ2VZ?=
 =?utf-8?B?dWxnZFJUekFwS082NGtPVmI5T1VQVklEaG91NVp4bXRmOVFuN3NZSVNFazdp?=
 =?utf-8?B?aFVHeEdGVkY2M2NqYnVZZTFOZkY0VDVWTU90d1NySVpoOEVFMlAzZGMxWWxh?=
 =?utf-8?B?aE90YTd2KzV0bVdBS0lZaVEvSTFjNFRKNWsxMWcyQ2ZpaUw4M21vTDhDa3Rs?=
 =?utf-8?B?RnhiWVJhL1ZWNWY3aGN6RStlK0NNcEhhMmZ5RVMxOFRaWG1HYUlhSjV6YStP?=
 =?utf-8?B?NjFaVzR5WG1NN1hKT2w3ZHZtOWNTVktiUHMybjBMYXJJSG80cy9hemZVa3Yx?=
 =?utf-8?B?M0VNMnphMUYxa0tJVDlTR1VCWWZyUHlTODhjaGRPYkZHc25VYjZKeGxOSDl0?=
 =?utf-8?B?YjdJeUhuOVBjRENvY2xMN2lySjFPa1ppOVdCd2VOSkhNQTRKNFdlZEdLcVZW?=
 =?utf-8?B?d0loenNFWms5czhyNC9VWGFoY3FMaUs5TlYvZTFGdWt2R0hKYnlLWUIvQTlp?=
 =?utf-8?B?bjdWU0dVbU5MZHBZd3JaTW9IODlDMHdrMVpZc0Q3OFF5VmRBcmdmY2dLZktX?=
 =?utf-8?B?R29iSzM1bkQyM2NLbHhmdmd6ZlQ2NncrcTNDQW44N3BTN3BUN3NDQ3UyalBL?=
 =?utf-8?B?TGJnd2RoMVJKYUs3MFhTd2xKVklqNk5vcGg3SmNUOERjeHlaYm9TOHpDNm11?=
 =?utf-8?B?UXlIT05KRlZKdk4vWlVIclVqZnFMdlhJdnpVbTNPQm81aTlTZ2JMY2oydkRI?=
 =?utf-8?B?aHZNelE1eFNXZmY1MGt4ZzNhU1l3RW5Cek9xRjY5WEJuTnRYc2ZCd2pvdHdW?=
 =?utf-8?B?bDBSanJJNEZwaEhrSVVlYVh1NVpmSjdmRFRvYXhxQ1k1ZGpnWWhwemtaZnpK?=
 =?utf-8?B?YmhsR0VyRG9TYTIzcFpVSlI0QWVhd1dETjNVMFd6WU9XazhnVzV4RGpjUjJT?=
 =?utf-8?B?OHdJL3VnREhJZXAyOUNmeUNwSlFkYXhFUWdkVFhndzlZcUFKbUJpdUU4V08r?=
 =?utf-8?B?c0llSHFlcFZQNnBUZytrOFcxa2psdm95dU5uZXRuRldudGEvSDFnNTZmU0RD?=
 =?utf-8?B?eGZQTjA4S205azBRSklTKzJDSlFOakl1cEZIaVRkQ3hsd3dDOGpOcDdUMTlG?=
 =?utf-8?B?bExvTllMNmlmcTV5MitqMlNZNGFOSHoxWC9SN2t2ZFZVNlBRcnFKWEtnVEJq?=
 =?utf-8?B?Zmt2cVphemMyTmpqb05GUlQzalliaHVkUWZPcGhRcVhZdjlITmtPM0d5NlY0?=
 =?utf-8?B?c3JnMmlQMWZDbGVnT29GcnhrMUwvRDFvSC9kTEJNS0RkaWZGVWRzSWxhdHlh?=
 =?utf-8?B?b0hGNnhGT0RFT2w3RmsrU1A2T3RvNis4b3NUVkRsMHVEY3E4Tjd3aERvMjRn?=
 =?utf-8?B?ZTZZN29jbFVZZnlWTnVpQWYwbjVMMXkrb05QZWRTZDVMaUpFS1gvQXRMM2lh?=
 =?utf-8?B?UVQ3clErWXpMYk9iTWlyYWkwZlBHeHNPeVk4N2MxbXdCbzhaWEorbE1nY29u?=
 =?utf-8?B?aGZITS9wQzZtYVl4S2pWYmIrblNYL0lWY1lOZjZpZThnZjhuWFdOR2JuN1FF?=
 =?utf-8?B?RWpNYmpqMXorM1FybzlpdjMyampFRVRiWm1LM3QvVExaZ0YzaDBmbWRPWWdj?=
 =?utf-8?B?MHJ3SWc0bmRzOUI2NVEyUkQwOG0xTWlJUEsxTVExdVNoNm14WmJFc1ZEOTNi?=
 =?utf-8?B?T3BZOTRzMjQvRERHRXo0QTRSdFhsOERkdXladzlpZjVLT01VWjFnc3Rpc2F4?=
 =?utf-8?B?aXpvNUp5T254NlIvUXZLbDdLZHJzaElNSWZhQkp6R0hreUJZZGxJZ1FmaVEw?=
 =?utf-8?B?QjJMT2xMc0RXVzZhdUx4VXVHSGFOWEFvK3haanhJY0NEL2RjWkFNMXN0SUl0?=
 =?utf-8?B?ZzF1eExSb3J5TjQxYkowODVRY2NwVDVWeUhIcnA5SkF3S0d2T3MvWURycm42?=
 =?utf-8?B?NTh2ZEp2UlJpNTBLamNLeVpvU2krUXBaZGdaZHNBN0gyMXhtVSt0RWtZSEVQ?=
 =?utf-8?B?RmdzZ05RQXI2WFh3T3ByWnd0VGFCZmFnbjMwQStXSWxoREdyMjdaRk12cjBC?=
 =?utf-8?B?S3JLaEpNSlJ1clVabk9JQW5ZVFQ1eVVHbHpIWGgyMVRXaW9pbU1FL1ZpOVpH?=
 =?utf-8?Q?VRB0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98984e71-920b-4475-71fe-08dbca5085f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 11:52:19.6587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9+wNmmp6MM3f4tXOM5iAcIkj0QqlpmXjq8A21KMQWjKnnl0fTK9b+wHGLxp9Shq8GUJcK5YqjHGWkEnnMzA/MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9055
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PiBTdWJqZWN0OiBSZTogUXVlc3Rpb24gcmVnYXJkaW5nIHNjbWlfcGVyZl9kb21haW4uYw0KPiAN
Cj4gT24gV2VkLCAxMSBPY3QgMjAyMyBhdCAwMjozMCwgUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5j
b20+IHdyb3RlOg0KPiA+DQo+ID4gPiBTdWJqZWN0OiBSZTogUXVlc3Rpb24gcmVnYXJkaW5nIHNj
bWlfcGVyZl9kb21haW4uYw0KPiA+ID4NCj4gPiA+IE9uIFR1ZSwgT2N0IDEwLCAyMDIzIGF0IDAx
OjQzOjMyUE0gKzAwMDAsIFBlbmcgRmFuIHdyb3RlOg0KPiA+ID4gPiA+IFN1YmplY3Q6IFJlOiBR
dWVzdGlvbiByZWdhcmRpbmcgc2NtaV9wZXJmX2RvbWFpbi5jDQo+ID4gPiA+ID4NCj4gPiA+ID4g
PiBPbiBUdWUsIE9jdCAxMCwgMjAyMyBhdCAwMToxNToyNlBNICswMDAwLCBQZW5nIEZhbiB3cm90
ZToNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBUaGFua3MgZm9yIHRoZSBkZXRhaWxlZCBleHBs
YW5hdGlvbiwgc28gcG93ZXItZG9tYWlucyBwcm9wZXJ0eQ0KPiA+ID4gPiA+ID4gY291bGQgYmUg
dXNlZCBib3RoIGZvciBwb3dlciBkb21haW4gb3IgcGVyZm9ybWFuY2UgZG9tYWluLiBCdXQNCj4g
PiA+ID4gPiA+IGlmIG9uZSBkZXZpY2UgaGFzIGJvdGggcG93ZXIgZG9tYWluIGFuZCBwZXJmb3Jt
YW5jZSBkb21haW4uDQo+ID4gPiA+ID4gPiBPbmx5IHBvd2VyLWRvbWFpbiBwcm9wZXJ0eSBpcyBu
b3QgZW5vdWdoLiBJIG1heSB1bmRlcnN0YW5kDQo+ID4gPiA+ID4gPiB3cm9uZywgbGV0IG1lDQo+
ID4gPiBsb29rIGludG8gdGhlIGNvZGUuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+
ID4gSSBoYXZlbid0IHRyaWVkIHRoaXMgYnV0IHNvbWV0aGluZyBJIGNvdWxkIGNvbWUgdXAgcXVp
Y2sgd2l0DQo+ID4gPiA+ID4gSnVubyBEVFMgYXMNCj4gPiA+ID4gPiByZWZlcmVuY2U6DQo+ID4g
PiA+ID4NCj4gPiA+ID4gPiBXZSBjYW4gY2hhbmdlIHNvbWV0aGluZyBsaWtlIHRoaXM6DQo+ID4g
PiA+ID4NCj4gPiA+ID4gPiAgICAgICBzY21pX2R2ZnM6IHByb3RvY29sQDEzIHsNCj4gPiA+ID4g
PiAgICAgICAgICAgICAgIHJlZyA9IDwweDEzPjsNCj4gPiA+ID4gPiAtICAgICAgICAgICAgICNj
bG9jay1jZWxscyA9IDwxPjsNCj4gPiA+ID4gPiArICAgICAgICAgICAgICNwb3dlci1kb21haW4t
Y2VsbHMgPSA8MT47DQo+ID4gPiA+ID4gICAgICAgICAgICAgICBtYm94LW5hbWVzID0gInR4Iiwg
InJ4IjsNCj4gPiA+ID4gPiAgICAgICAgICAgICAgIG1ib3hlcyA9IDwmbWFpbGJveCAxIDAgJm1h
aWxib3ggMSAxPjsNCj4gPiA+ID4gPiAgICAgICAgICAgICAgIHNobWVtID0gPCZjcHVfc2NwX2hw
cmkwICZjcHVfc2NwX2hwcmkxPjsNCj4gPiA+ID4gPiAgICAgICB9Ow0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gQW5kIHRoZW4gaW4gdGhlIGNvbnN1bWVyIG5vZGUodGFraW5nIEdQVSBhcyBpdCBoYXMg
Ym90aCBwZXJmIGFuZA0KPiA+ID4gPiA+IHBvd2VyIGRvbWFpbnMpLiBUaGUgQ1BVcyBhcmUgc2lt
cGxlciBhcyBkb24ndCBoYXZlIGV4cGxpY2l0DQo+ID4gPiA+ID4gcG93ZXIgZG9tYWlucywgc29t
ZSBRY29tIHBsYXRmb3JtcyBkbyB1c2UgdGhhdC4gQW55d2F5cyBJIHdvdWxkDQo+ID4gPiA+ID4g
Y2hhbmdlDQo+ID4gPiBHUFUgbm9kZSBsaWtlIHRoaXMuDQo+ID4gPiA+ID4gSG9wZSB0aGlzIGNs
YXJpZmllcyB0aGluZ3MgZm9yIHlvdS4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+ICAmZ3B1IHsNCj4g
PiA+ID4gPiAtICAgICAgIGNsb2NrcyA9IDwmc2NtaV9kdmZzIDI+Ow0KPiA+ID4gPiA+IC0gICAg
ICAgcG93ZXItZG9tYWlucyA9IDwmc2NtaV9kZXZwZCA5PjsNCj4gPiA+ID4gPiArICAgICAgIHBv
d2VyLWRvbWFpbnMgPSA8JnNjbWlfZHZmcyAyICZzY21pX2RldnBkIDk+Ow0KPiA+ID4gPiA+ICsg
ICAgICAgcG93ZXItZG9tYWluLW5hbWVzID0gInBlcmYiLCAicG93ZXIiOw0KPiA+ID4gPg0KPiA+
ID4gPiBXaXRoIG9uZSBzaW5nbGUgcG93ZXIgZG9tYWluLCB0aGUgcGxhdGZvcm0gY29tbW9uIGNv
ZGUgd2lsbA0KPiA+ID4gPiBhdXRvbWF0aWNhbGx5IHBvd2VyIG9uIHRoZSBkb21haW4gYmVmb3Jl
IHByb2JlLCB3aXRoIGhlbHAgZnJvbQ0KPiA+ID4gPiBnZW5wZF9kZXZfcG1fYXR0YWNoLg0KPiA+
ID4gPg0KPiA+ID4gPiBCdXQgd2l0aCBtdWx0aXBsZSBlbnRyaWVzLCBkZXZpY2UgZHJpdmVyIHNo
b3VsZCBoYW5kbGUgcG93ZXINCj4gPiA+ID4gZG9tYWlucyBieSB0aGVtc2VsdmVzLg0KPiA+ID4g
Pg0KPiA+ID4gPiBNYXliZSBVbGYgY291bGQgY29tbWVudCB3aGV0aGVyIHRoZSBnZW5wZCBjb3Vs
ZCB1cGRhdGUgdG8gc3VwcG9ydA0KPiA+ID4gPiBwZXJmL3Bvd2VyIGNhc2UganVzdCBhcyBvbmUg
cG93ZXIgZG9tYWluIGVudHJ5IGJlZm9yZS4NCj4gPiA+ID4NCj4gPiA+DQo+ID4gPiBIbW0sIEkg
d291bGQgcmF0aGVyIGNoZWNrIGlmIHRoZSBnZW5wZCBjYW4gc3RpbGwgaGFuZGxlIGF1dG9tYXRp
Yw0KPiA+ID4gcG93ZXIgb24gb2YgdGhlIGRvbWFpbiBiZWZvcmUgcHJvYmUgd2l0aCBvbmUgcG93
ZXIgYW5kIG9uZSBwZXJmDQo+IGRvbWFpbi4NCj4gPiA+IElXTywgb25lIHBvd2VyIGRvbWFpbnMg
YW5kIG90aGVyIGRvbWFpbnMgaW4gdGhlIG1peC4gVGhlIHJlYXNvbiB3aHkNCj4gPiA+IHdlIGNh
bid0IGhhdmUgc2luZ2xlIGRvbWFpbiB0byBzdXBwb3J0IGJvdGggcG93ZXIgYW5kIHBlcmYgdXNp
bmcNCj4gPiA+IFNDTUkgaXMgd2UgZG9uJ3Qga25vdyBpZiB0aGUgZG9tYWlucyBhcmUgMToxIGFz
IHByZXNlbnRlZCBieSB0aGUNCj4gPiA+IFNDTUkgcGxhdGZvcm0gZmlybXdhcmUuDQo+ID4gPg0K
PiA+ID4gQUZBSVUgaXQgd2FzIHRoZSBtYWluIGlzc3VlL2NvbmZ1c2lvbiB5b3UgcmFpc2VkIGlu
aXRpYWxseS4gSSBhbQ0KPiA+ID4gc3VycHJpc2VkIGFzIGhvdyB3ZSBoYWQgYWxsIHRoZXNlIGRp
c2N1c3Npb25zIGFuZCBub3cgeW91IGFyZQ0KPiA+ID4gY2lyY2xpbmcgYmFjayBhbmQgcmVxdWVz
dGluZyB0byBjb21iaW5lIHRoZSBzdXBwb3J0IGluIHNpbmdsZSBkb21haW4NCj4gPiA+IHdoaWNo
IGNvbnRyYWRpY3RzIHlvdXIgaW5pdGlhbCBjb25mdXNpb24uIEkgYW0gc2VyaW91c2x5IGxvc3Qg
YXMNCj4gPiA+IHdoYXQgeW91IGFyZSBsb29raW5nIGZvciBub3cgPw0KPiA+DQo+ID4gTm8sIEkg
YW0gbm90IHJlcXVlc3RpbmcgdG8gY29tYmluZSBpbiBzaW5nbGUgZG9tYWluLiBJIHN0aWxsIHdh
bm5hDQo+ID4gcGVyZiBkb21haW4gYW5kIHBvd2VyIGRvbWFpbiBoYXMgdGhlaXIgb3duIElEcy4g
QnV0IEkgd2FzIG5vdCBhd2FyZQ0KPiA+IHBlcmYgZG9tYWluIGlzIHVzaW5nIHBvd2VyLWRvbWFp
bnMgcHJvcGVydHksIHNvIG9uZSBkZXZpY2UgaGFzIHBvd2VyDQo+ID4gZG9tYWlucyBhbmQgcGVy
ZiBkb21haW5zIGJvdGgsIHRoZSBhdXRvbWF0aWMgcG93ZXIgZG9tYWluIG9uIGlzDQo+ID4gYnJv
a2VuLiBJIHdhcyB0aGlua2luZyB3ZSBpbnRyb2R1Y2UgYSBuZXcgcHJvcGVydHkgc2F5aW5nIHBl
cmYtZG9tYWlucw0KPiA+IHByb3BlcnR5Lg0KPiANCj4gTm90IHN1cmUgZXhhY3RseSB3aGF0IHlv
dSBhcmUgcmVmZXJyaW5nIHRvIHdoZW4gc2F5aW5nIHRoYXQgImF1dG9tYXRpYw0KPiBwb3dlciBk
b21haW4gb24gaXMgYnJva2VuIi4gR2VucGQgcG93ZXItb24gdGhlIFBNIGRvbWFpbiBmb3IgYSBk
ZXZpY2UNCj4gdGhhdCBnZXRzIGF0dGFjaGVkIHRvIGl0LCBpZiB0aGUgZGV2aWNlIGhhcyBvbmx5
IGEgc2luZ2xlIFBNIGRvbWFpbi4NCj4gVGhpcyBpcyB0aGUgbGVnYWN5IGJlaGF2aW91ci4NCj4g
DQo+IFdoZW4gd2UgYWRkZWQgc3VwcG9ydCBmb3IgbXVsdGlwbGUgUE0gZG9tYWlucyBwZXIgZGV2
aWNlLCB3ZSBkZWNpZGVkIHRvDQo+ICpub3QqIHBvd2VyLW9uIHRoZSBQTSBkb21haW4sIGlmIHRo
ZSBkZXZpY2UgdGhhdCBnZXRzIGF0dGFjaGVkIGhhcyBtdWx0aXBsZQ0KPiBQTSBkb21haW5zLiBU
aGlzIGJlaGF2aW91ciB3YXMgY2hvc2VuIGRlbGliZXJhdGVseSwgdG8gYWxsb3cgY29uc3VtZXIN
Cj4gZHJpdmVycyB0byBkZWNpZGUgdGhlbXNlbHZlcyBpbnN0ZWFkLiBJcyB0aGVyZSBhIHByb2Js
ZW0gd2l0aCB0aGlzIHlvdSB0aGluaz8NCg0KTm8gcHJvYmxlbS4gTm93IHBlcmYgZG9tYWluIHRh
a2VuIGFzIHBvd2VyLWRvbWFpbiwgdGhlbiB0aGUgbm9kZQ0KaGFzIG1vcmUgdGhhbiBvbmUgcG93
ZXItZG9tYWlucywgc28gd2UgbmVlZCB1cGRhdGUgZGV2aWNlIGRyaXZlciBmb3INCnRoaXMuICBJ
IHdhcyB0aGlua2luZyBkZXZpY2UgZHJpdmVycyBvbmx5IG5lZWQgdG8gY2FyZSBhYm91dCBwZXJm
b3JtYW5jZQ0KZG9tYWluLCAgYW5kIG5vIG5lZWQgZGV2aWNlIGRyaXZlciB0byBoYW5kbGUgcG93
ZXIgZG9tYWluIGp1c3QgYXMgImxlZ2FjeQ0KYmVoYXZpb3VyIi4NCg0KVGhhbmtzLA0KUGVuZy4N
Cg0KPiANCj4gS2luZCByZWdhcmRzDQo+IFVmZmUNCg==
