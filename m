Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5845993D9
	for <lists+linux-pm@lfdr.de>; Fri, 19 Aug 2022 06:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiHSEE2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Aug 2022 00:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiHSEE1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Aug 2022 00:04:27 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2046.outbound.protection.outlook.com [40.107.105.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F360D2E8E
        for <linux-pm@vger.kernel.org>; Thu, 18 Aug 2022 21:04:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5iDBGeqVLXMXBFWj1SgS0ncnF20W/vqRmcwGLEsGPjGH+/wOYu8OQnEBOEHvjSrCjRuatiAQecJDafvBksoJDf2t+tD9CNkWfkZ9j0F11NndQLox8UAN20OEbDFgZC6eai5ZmzgeQmWcjXOiK6SSXWcf/wHIr8J20ubTioB83fZaCyTikYs9M3KfbW9A4ugieDEensPKIoy8obOYgRvxIsF3sWD/+6Tf+aRt1OwGOrY2nyWF3Z6W98zb1AV51M4NVaNatwT/rWX5x1ig09iV3aWXdsXOhx/gm3h07YOxbetRR01g76QZu27DrZJfp6hHNqtu1qv/P1+SK9fUek1dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eos+3r9SybbHGvSsDjVAn80Ec2TYfCSiv02HGGBgTic=;
 b=eGz6xDnwpMht6mvMH07pfF3dnGQORvNbRtkmrr7JpVZt72Wl07/+TCJ9i4JlzSnhsovF8031hmyD23FZ6EFwQRC/+0Z3cGQWaiJ6RhepG8z3DM5umZ1NGDb3qWWXkxMqaXH+kgh++XsBEdy14NlxK7k2VACPdWHx0xqtKRs+lYW0L4WwXvm1I76lR6rM8MWtxy/XkukAoPeN3hQI1fusFh1BgGioAhoCsigwpDM9wGHzw1i5VpqRZaV8TKDNRu45GxBRczHHSeUCpxMoO/IZnENDdFWMaSDfCPJKVpbbwFlJzCu7brfm8v/KKLCd22z09B9A+mh/GIxOxY7ilcxhHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eos+3r9SybbHGvSsDjVAn80Ec2TYfCSiv02HGGBgTic=;
 b=SnaB7i+SfRJQqtpbQ5Cq4+VYqSZYqgGNQpe24Sapdzlp75tyVXnQA2BtLmCTb76LDAfCtvXu3FL69eT72+SeCkX7P5xn/ohbMBhx5zXlqiZhqqWTSZKZc6GlVjKyJyeb6VNZZyaLw9DLOQOTkfD2plsV67KM9FqoE6tNpnAGT+U=
Received: from VI1PR04MB4016.eurprd04.prod.outlook.com (2603:10a6:803:4a::27)
 by AM6PR0402MB3927.eurprd04.prod.outlook.com (2603:10a6:209:19::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Fri, 19 Aug
 2022 04:04:23 +0000
Received: from VI1PR04MB4016.eurprd04.prod.outlook.com
 ([fe80::d19f:fa88:6b5c:d9e4]) by VI1PR04MB4016.eurprd04.prod.outlook.com
 ([fe80::d19f:fa88:6b5c:d9e4%5]) with mapi id 15.20.5546.016; Fri, 19 Aug 2022
 04:04:23 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Saravana Kannan <saravanak@google.com>, Peng Fan <peng.fan@nxp.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Alice Guo <alice.guo@nxp.com>
Subject: RE: Regression: PM: domains: Delete usage of
 driver_deferred_probe_check_state
Thread-Topic: Regression: PM: domains: Delete usage of
 driver_deferred_probe_check_state
Thread-Index: AdixOGZw9fNTqIJNRCevdBJlb4IAbAAAtHmwAHyTHIAAEkT6YA==
Date:   Fri, 19 Aug 2022 04:04:23 +0000
Message-ID: <VI1PR04MB401618EB996FEDA5888B73A5906C9@VI1PR04MB4016.eurprd04.prod.outlook.com>
References: <DU0PR04MB941735271F45C716342D0410886B9@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <DU0PR04MB9417E391B514287D040E0EC7886B9@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <CAGETcx8xXM18Se-ykf7=fFJ_4bvSgQm8LG6Bq=3wd0skSR46EA@mail.gmail.com>
In-Reply-To: <CAGETcx8xXM18Se-ykf7=fFJ_4bvSgQm8LG6Bq=3wd0skSR46EA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a17aba06-4acd-429b-14c6-08da8197e68a
x-ms-traffictypediagnostic: AM6PR0402MB3927:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 26iEypkwFp8MWh80L/uCdzMWvpEbmswZoMqC/sXcM/ANF8iHOeeSAM+u6EGzahjmLO8BnDYVztkcnF4uLt1nsWo1j+utTX6WIA7WlkcDNC08o3iXsAlazxAa/LEN86NR9l4bDGWdaR8eBzO7xGykAP7wq/VwLPlERHGt2pZZtq0ifAvGsCOdaERuxlhG+PRIcjPRGUzYFSYvk6xOWMXFbQsfoJrTPkk6I0XNNz6DaETD5ZUmMSfKtNz8g1Fyc5YHqJjfAI5xOE+rt+Mw1fainZjVCH313iBLy9sXHV00k615Btj0u3IxybkKHcisNMuH/9SNOlez9Ho6xafIOo1gzg29Xs1uM2w0dt/tSLZQkjsNlGLryHTI9e5+0H4oxJggl4VEOagiX7u3togkJrijbXFqg/9Ya03goSyvi3wJWyMIfbu61dCLIHqVqa8G1K9N+hoxUEssa4G01O3TeJttpMOZcU+MIVvayIq3nfRkag3UjoDpPMNfkALxFOPoLO1vN3lsFsEA3ATwQAwhxMwghuV/ndXx0xYf89eQmISJlBN7+6U4ey5UjPKM6iJC1F29F0lae7qRomkXulOkWwXug/y4eId47PH1C0m92s0LPLRtvM2jXUZz+y3oMToz2ivAN3CTRRQdZbruUIi2Tqonb4cyu1o881xJk3t7QdxZ64FmD6wENvH0kOXKJrPsKTC3T/a6MdbeM5sLgjdM8EeE6jkHUZZOfUldGxq0vCaWyYWe3jR2XJ9IMQMx6YDKfT6A7UzsskKhC9Pdpvgi6mYqqyRyA2wo9KEL7HNpVha3SCEaqj97JaVJA+LAucEDBV+K7TCnE78bunuSHx7KDRwkLjAO6aPc7zgL5s6avcefbsrvXZEQUDiAmx2blcPouu9v
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4016.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(186003)(86362001)(38070700005)(83380400001)(38100700002)(122000001)(8936002)(5660300002)(66476007)(52536014)(2906002)(4326008)(66556008)(8676002)(66446008)(76116006)(66946007)(64756008)(55016003)(41300700001)(71200400001)(6506007)(478600001)(9686003)(7696005)(26005)(53546011)(316002)(110136005)(6636002)(54906003)(966005)(45080400002)(33656002)(71600200004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?RDhXdmw4cmhnNmcwZ25iZHZXMHJRQ2Y3YjBOZjVobjVaeWlyMlpxbDhVZjlC?=
 =?gb2312?B?ZVR5Rk9SYTM3WDVZZFpTSWhFRkt0ZVZtZGhNeFE5b2VGdVV3WFB2eE0ydTQ2?=
 =?gb2312?B?ZTBjUUV1czR1Q0hYMmp2SXBhek9kdnZRemlSenE5Qk5jL01TeXU2TXNWajJl?=
 =?gb2312?B?b1R6M2ZCOU5SMUVQN09yRkM0MjBYNjlWMitRZlllSUpSRHozaFV2VUZGbEJ1?=
 =?gb2312?B?SWcvUnBXRmhDbkkxVjRFNWFNMFBMcS9Rd2ZVRHNWWGcwSjI2U08vdzZFL1Jw?=
 =?gb2312?B?eEk2MjFyYkl5YmwvemVUaHdBQ041Ym54ZW16eHdHdEFuNWxWTG5aUDdrajFu?=
 =?gb2312?B?cEYrME1WRk9Ja0FmMjlLSVc4RUlMOE4wTmZHMmhmZDYrc0ZYS0hkTEdNYk1C?=
 =?gb2312?B?U2QzemgxS1JDWnphQlBZS2wvYVQxWWRxTmxBbnJ4NVltVi92b0hUTmxabmNC?=
 =?gb2312?B?R2hxbmYxZGxUVEoxNDRDWWJITGxGSjRlcXlWa1gyMCtsRVB5WXFORWdDR0NR?=
 =?gb2312?B?Z2dtQ25DTXFqKzd1N045TkRuV05WOVlBdHNlZGRIRy9NN1YvZFhEcjJaRnRK?=
 =?gb2312?B?S2MzUm1Hd2k0RHFmcUZvLzRJMEp4eWtZTWlUUWRHMzE1akZacC9yYjdpSVM5?=
 =?gb2312?B?azRETEJHdU55VG1EajFtUjY1VzNZWmRKSnI3cG4xNE1NNVhXenBocXBvOUZT?=
 =?gb2312?B?dEdxeFQyR3VpNDVOdHhlY3ZKNERSREVjVUJwMGFFN2NIWmxhNGsveEJRSEtq?=
 =?gb2312?B?Y0VwUzRSbm50NjdXcWRjZnVGNFA3aUdlSUJadU42SVhuNU5JT3lpWnA4RGFZ?=
 =?gb2312?B?WWtwMUY2cktFZmU2ZWoyN0NOOFBpLzRmNUMzRFhHVDlwMEx4TU9ERXVGa1pF?=
 =?gb2312?B?b1pWd3ZnckVTcXFrajJCc2c4YW9oLzBHeFVMcmpXcDJ3VkdZQjljclhIR2I2?=
 =?gb2312?B?aTlVWVFON3k3Qy9XSkE5akN0TXVQY3lvNWtXRm9rNTRKMlFDQklhZFBrM2lu?=
 =?gb2312?B?RktxSjhKRWJqLzRnR1VwdENpUGN2OUYrOERHeFh4TXdSSVA3TmRIZCsrYk1u?=
 =?gb2312?B?ZThCVDg4d0RZQVFGU2xsbWI0NVhvRFhkQURFb2IyT21la0VUMVF0TlU2cmlT?=
 =?gb2312?B?dCtOQzR5cFhOeFVab0F0c0tvT3dxSjI4d2Y1ZUJmUEVaMkVLUUVuaGlKdVQ1?=
 =?gb2312?B?YVY2ZHN2TFFxbFk1QTI0Q1g4cnkreDIyKzZmTVNXRDVWQ0tIUDhvN3pvMWpL?=
 =?gb2312?B?SGhZaVhlZnBvWTlhQ3VIVElPU3llK1Ivc3ZrQVR5d1lWZ1JuaWFrRUlzeTBG?=
 =?gb2312?B?SVh5VDhyM0UvWHd0eFZZZng5OFIrYTQxbmlJT01POWhweUlYOEw0c2ZCVm5I?=
 =?gb2312?B?ZG5XSnlFWGZ6bjZVUnVpVml0YzdyQ3ZEM3FJWk1xdWtUczQwR3NwMWt5RkJp?=
 =?gb2312?B?NHc4UkVjZzlUL1NzTVBGVUdDL3NUZURydDl2VEFFckVac1FRQkdyZC9SRktS?=
 =?gb2312?B?Y1NiRkZYQTR0dTJXSVJoTTN4cG45OVlUUkZwMXVOOVVkQ0Y2bE5xR1BXaGJm?=
 =?gb2312?B?UU1iQ2tkTGlGZHY3ek9ocUZYR2EvZHpSVzFiN3diTXdTeVBwMWtNQktaNUZm?=
 =?gb2312?B?RzNrOWtxNFlOd1NLVnFzZ2daMUxFTzVNbTRwYVpHZmRlT3RKakYwKzNPN2tZ?=
 =?gb2312?B?VUJqQzdQQllScG1IbGkwVjZkSVhQUXhKZXJMd1NBQ2E5TkNxeStDelhNWFZj?=
 =?gb2312?B?cVl0cXM3VjFKNm4wd1o4aVJBZXA1Ry9qVHRBR3l5VWp6WUV2SkNpaWM3N01v?=
 =?gb2312?B?dnFKUnMvSGlJZ084S1VMTlVnNGZmcjRqTHZtOVFuamtCUGhDNTNscGJuaDJj?=
 =?gb2312?B?ak8xTHRoaHhxaDVvdEVFK1ZTVkpKNWhOLzY0TWNqVzVuNndJM1pZL3pVZlZT?=
 =?gb2312?B?VVVtSnI0b0x6cE05STNUYWpyWUozRU1JaFluc1gzd2gwUlRQS1kzZ3owaVg5?=
 =?gb2312?B?ZjBUNWsvbDFwZHNDelh1bXQydnFRTUJ6d1B2VGpMZmN2V0ZNSW5lUnNnV2Vh?=
 =?gb2312?B?UDFtc2k4TmFSbnM3YWNDYThEZGo0eHV0TEQ1YmFZQzM1bFBDMmU3eDhoaThy?=
 =?gb2312?Q?l/Ip+NCJbbljW3DM9xGd0/xRl?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4016.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a17aba06-4acd-429b-14c6-08da8197e68a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 04:04:23.3887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vBDdNYBbA7WpgMMVkpznaeUbsw5kZgdc8seLBBW6Ny+51EFu2GoMKGLyp4U+E9kxBEzgEYrQk5H6Ic+0qK4ImA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3927
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTYXJhdmFuYSBLYW5uYW4gPHNh
cmF2YW5ha0Bnb29nbGUuY29tPg0KPiBTZW50OiAyMDIyxOo41MIxOcjVIDI6MDgNCj4gVG86IFBl
bmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiBDYzogbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsNCj4gc3VkZWVw
LmhvbGxhQGFybS5jb207IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZzsgQWxpY2UgR3VvDQo+IDxh
bGljZS5ndW9AbnhwLmNvbT47IEJvdWdoIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFJlZ3Jlc3Npb246IFBNOiBkb21haW5zOiBEZWxldGUgdXNhZ2Ugb2YNCj4gZHJp
dmVyX2RlZmVycmVkX3Byb2JlX2NoZWNrX3N0YXRlDQo+IA0KPiBPbiBNb24sIEF1ZyAxNSwgMjAy
MiBhdCAxMTo0MyBQTSBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4gd3JvdGU6DQo+ID4NCj4g
PiA+IFN1YmplY3Q6IFJlZ3Jlc3Npb246IFBNOiBkb21haW5zOiBEZWxldGUgdXNhZ2Ugb2YNCj4g
PiA+IGRyaXZlcl9kZWZlcnJlZF9wcm9iZV9jaGVja19zdGF0ZQ0KPiA+DQo+ID4gSnVzdCBzZWUg
eW91ciBwYXRjaHNldCA6KQ0KPiA+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24u
b3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxvcmUNCj4gPiAua2VybmVsLm9yZyUyRmFs
bCUyRjIwMjIwNzI3MTg1MDEyLjMyNTUyMDAtMS1zYXJhdmFuYWslNDBnb29nbGUuY29tDQo+ICUy
Rg0KPiA+DQo+ICZhbXA7ZGF0YT0wNSU3QzAxJTdDaGFpYm8uY2hlbiU0MG54cC5jb20lN0MzNjBk
M2U1MjNhOTQ0MTg4MmU1OQ0KPiAwOGRhODE0DQo+ID4NCj4gNGJlMTYlN0M2ODZlYTFkM2JjMmI0
YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM3OTY0NDI5NDg5DQo+IDA1OTM4NSUNCj4g
Pg0KPiA3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9p
VjJsdU16SWlMQ0pCVGkNCj4gSTZJaw0KPiA+DQo+IDFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMzAw
MCU3QyU3QyU3QyZhbXA7c2RhdGE9a3M2TEklMkZSeXdnSUsNCj4gSHJNSm1YdHpHDQo+ID4gbWR6
JTJCMk0xajVNN0J2ZnNOaVhPeFZjJTNEJmFtcDtyZXNlcnZlZD0wDQo+ID4NCj4gPiBUaGFua3Ms
DQo+ID4gUGVuZy4NCj4gPiA+DQo+ID4gPiBIaSBTYXJhdmFuYSwNCj4gPiA+DQo+ID4gPiBUaGUg
Zm9sbG93aW5nIHR3byBwYXRjaGVzIGJyZWFrcyBOWFAgaS5NWDhVTFAsIGJ1dCBJIHRoaW5rIGl0
IG1heQ0KPiA+ID4gYnJlYWsgb3RoZXJzIHVzZSBTQ01JLg0KPiA+ID4NCj4gPiA+IGNvbW1pdCA1
YTQ2MDc5YTk2NDUxY2ZiMTVlNGY1ZjAxZjczZjdiYTI0ZWY4NTFhDQo+ID4gPiBBdXRob3I6IFNh
cmF2YW5hIEthbm5hbiA8bWFpbHRvOnNhcmF2YW5ha0Bnb29nbGUuY29tPg0KPiA+ID4gRGF0ZTog
ICBXZWQgSnVuIDEgMDA6MDY6NTcgMjAyMiAtMDcwMA0KPiA+ID4NCj4gPiA+ICAgICBQTTogZG9t
YWluczogRGVsZXRlIHVzYWdlIG9mIGRyaXZlcl9kZWZlcnJlZF9wcm9iZV9jaGVja19zdGF0ZSgp
DQo+ID4gPg0KPiA+ID4gICAgIE5vdyB0aGF0IGZ3X2Rldmxpbms9b24gYnkgZGVmYXVsdCBhbmQg
ZndfZGV2bGluayBzdXBwb3J0cw0KPiA+ID4gICAgICJwb3dlci1kb21haW5zIiBwcm9wZXJ0eSwg
dGhlIGV4ZWN1dGlvbiB3aWxsIG5ldmVyIGdldCB0byB0aGUgcG9pbnQNCj4gPiA+ICAgICB3aGVy
ZSBkcml2ZXJfZGVmZXJyZWRfcHJvYmVfY2hlY2tfc3RhdGUoKSBpcyBjYWxsZWQgYmVmb3JlIHRo
ZQ0KPiBzdXBwbGllcg0KPiA+ID4gICAgIGhhcyBwcm9iZWQgc3VjY2Vzc2Z1bGx5IG9yIGJlZm9y
ZSBkZWZlcnJlZCBwcm9iZSB0aW1lb3V0IGhhcyBleHBpcmVkLg0KPiA+ID4NCj4gPiA+ICAgICBT
bywgZGVsZXRlIHRoZSBjYWxsIGFuZCByZXBsYWNlIGl0IHdpdGggLUVOT0RFVi4NCj4gPiA+DQo+
ID4gPiAgICAgVGVzdGVkLWJ5OiBHZWVydCBVeXR0ZXJob2V2ZW4gPG1haWx0bzpnZWVydCtyZW5l
c2FzQGdsaWRlci5iZT4NCj4gPiA+ICAgICBSZXZpZXdlZC1ieTogVWxmIEhhbnNzb24gPG1haWx0
bzp1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPg0KPiA+ID4gICAgIFNpZ25lZC1vZmYtYnk6IFNhcmF2
YW5hIEthbm5hbiA8bWFpbHRvOnNhcmF2YW5ha0Bnb29nbGUuY29tPg0KPiA+ID4gICAgIExpbms6
DQo+ID4gPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91
cmw9aHR0cHMlM0ElMkYlMkZsbw0KPiA+ID4NCj4gcmUua2VybmVsLm9yZyUyRnIlMkYyMDIyMDYw
MTA3MDcwNy4zOTQ2ODQ3LTItJmFtcDtkYXRhPTA1JTdDMDElN0NoDQo+IGFpDQo+ID4gPg0KPiBi
by5jaGVuJTQwbnhwLmNvbSU3QzM2MGQzZTUyM2E5NDQxODgyZTU5MDhkYTgxNDRiZTE2JTdDNjg2
ZWExZDMNCj4gYmMyYjQNCj4gPiA+DQo+IGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMCU3QzYz
Nzk2NDQyOTQ4OTA1OTM4NSU3Q1Vua25vd24lN0NUDQo+IFdGcGJHWg0KPiA+ID4NCj4gc2IzZDhl
eUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZD
STZNbjANCj4gPiA+ICUzRCU3QzMwMDAlN0MlN0MlN0MmYW1wO3NkYXRhPWlFRklpZlRWZnZDbnJy
cko4RjE5bklhY0dkRjhWUTZZDQo+IHduTjlCSg0KPiA+ID4gZWRhUGslM0QmYW1wO3Jlc2VydmVk
PTANCj4gPiA+IHNhcmF2YW5ha0Bnb29nbGUuY29tDQo+ID4gPiAgICAgU2lnbmVkLW9mZi1ieTog
R3JlZyBLcm9haC1IYXJ0bWFuDQo+ID4gPiA8bWFpbHRvOmdyZWdraEBsaW51eGZvdW5kYXRpb24u
b3JnPg0KPiA+ID4NCj4gPiA+IGNvbW1pdCA5Y2JmZmM3YTU5NTYxYmU5NTBlY2M2NzVkMTlhM2Qy
YjQ1MjAyYjJiDQo+ID4gPiBBdXRob3I6IFNhcmF2YW5hIEthbm5hbiA8bWFpbHRvOnNhcmF2YW5h
a0Bnb29nbGUuY29tPg0KPiA+ID4gRGF0ZTogICBXZWQgSnVuIDEgMDA6MDc6MDUgMjAyMiAtMDcw
MA0KPiA+ID4NCj4gPiA+ICAgICBkcml2ZXIgY29yZTogRGVsZXRlIGRyaXZlcl9kZWZlcnJlZF9w
cm9iZV9jaGVja19zdGF0ZSgpDQo+ID4gPg0KPiA+ID4gICAgIFRoZSBmdW5jdGlvbiBpcyBubyBs
b25nZXIgdXNlZC4gU28gZGVsZXRlIGl0Lg0KPiA+ID4NCj4gPiA+ICAgICBUZXN0ZWQtYnk6IEdl
ZXJ0IFV5dHRlcmhvZXZlbiA8bWFpbHRvOmdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPg0KPiA+ID4g
ICAgIFNpZ25lZC1vZmYtYnk6IFNhcmF2YW5hIEthbm5hbiA8bWFpbHRvOnNhcmF2YW5ha0Bnb29n
bGUuY29tPg0KPiA+ID4gICAgIExpbms6DQo+ID4gPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5w
cm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsbw0KPiA+ID4NCj4gcmUu
a2VybmVsLm9yZyUyRnIlMkYyMDIyMDYwMTA3MDcwNy4zOTQ2ODQ3LTEwLSZhbXA7ZGF0YT0wNSU3
QzAxJTdDDQo+IGhhDQo+ID4gPg0KPiBpYm8uY2hlbiU0MG54cC5jb20lN0MzNjBkM2U1MjNhOTQ0
MTg4MmU1OTA4ZGE4MTQ0YmUxNiU3QzY4NmVhMWQzDQo+IGJjMmINCj4gPiA+DQo+IDRjNmZhOTJj
ZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2Mzc5NjQ0Mjk0ODkwNTkzODUlN0NVbmtub3duJTdDDQo+
IFRXRnBiRw0KPiA+ID4NCj4gWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVN
eklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4NCj4gPiA+DQo+IDAlM0QlN0MzMDAwJTdDJTdD
JTdDJmFtcDtzZGF0YT00b2RDWVcxbEUxN1BaTEJsdllGTTQlMkIwYjBwbQ0KPiBjaHUzdnM4Vw0K
PiA+ID4gaVNmRXVISTglM0QmYW1wO3Jlc2VydmVkPTANCj4gPiA+IHNhcmF2YW5ha0Bnb29nbGUu
Y29tDQo+ID4gPiAgICAgU2lnbmVkLW9mZi1ieTogR3JlZyBLcm9haC1IYXJ0bWFuDQo+ID4gPiA8
bWFpbHRvOmdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0KPiA+ID4NCj4gPiA+IFRoZSBpLk1Y
OFVMUCBtbWMgZGV2aWNlIG5vZGUgdXNlDQo+ID4gPiAicG93ZXItZG9tYWlucyA9IDwmc2NtaV9k
ZXZwZCBJTVg4VUxQX1BEX1VTREhDMD47Ig0KPiA+ID4NCj4gPiA+IFRoZSBzY21pIGZpcm13YXJl
IG5vZGUgYXMgYmVsb3c6DQo+ID4gPiAgICAgICAgIGZpcm13YXJlIHsNCj4gPiA+ICAgICAgICAg
ICAgICAgICBzY21pIHsNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUg
PSAiYXJtLHNjbWktc21jIjsNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGFybSxzbWMt
aWQgPSA8MHhjMjAwMDBmZT47DQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAjYWRkcmVz
cy1jZWxscyA9IDwxPjsNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICNzaXplLWNlbGxz
ID0gPDA+Ow0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgc2htZW0gPSA8JnNjbWlfYnVm
PjsNCj4gPiA+DQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICBzY21pX2RldnBkOiBwcm90
b2NvbEAxMSB7DQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDww
eDExPjsNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgI3Bvd2VyLWRvbWFp
bi1jZWxscyA9IDwxPjsNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIH07DQo+ID4gPg0K
PiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgc2NtaV9zZW5zb3I6IHByb3RvY29sQDE1IHsN
Cj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDB4MTU+Ow0KPiA+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjdGhlcm1hbC1zZW5zb3ItY2VsbHMg
PSA8MT47DQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICB9Ow0KPiA+ID4gICAgICAgICAg
ICAgICAgIH07DQo+ID4gPiAgICAgICAgIH07DQo+ID4gPg0KPiA+ID4gV2hlbiBzZGhjIGRyaXZl
ciBwcm9iZSwgdGhlIHNjbWkgcG93ZXIgZG9tYWluIHByb3ZpZGVyIGhhcyBub3QgYmVlbg0KPiA+
ID4gcmVnaXN0ZXJlZC4gU28gX19nZW5wZF9kZXZfcG1fYXR0YWNoIGRpcmVjdGx5IHJldHVybiAt
RU5PREVWLg0KPiA+ID4NCj4gPiA+IGRldmljZV9saW5rc19jaGVja19zdXBwbGllcnMgc2hvdWxk
IGFscmVhZHkgY2hlY2sgc3VwcGxpZXJzLCBidXQNCj4gPiA+IHNjbWkgcHJvdG9jb2wgZGV2aWNl
IG5vdCBoYXZlIGNvbXBhdGlibGUsIHNvIG9mX2xpbmtfdG9fcGhhbmRsZQ0KPiA+ID4gICAgICAg
fC0+IG9mX2dldF9jb21wYXRfbm9kZQ0KPiA+ID4gdXNlIHRoZSBwYXJlbnQgbm9kZSBvZiBzY21p
IHByb3RvY29sIGFzIHN1cHBsaWVyIGlmIEkgdW5kZXJzdGFuZCBjb3JyZWN0Lg0KPiA+ID4NCj4g
PiA+IEkgYW0gbm90IHN1cmUgd2hldGhlciB3ZSBuZWVkIHRvIHJldmVydCB0aGUgYWJvdmUgdHdv
IHBhdGNoZXMsIG9yIGRvDQo+ID4gPiB5b3UgaGF2ZSBvdGhlciBzdWdnZXN0aW9ucz8NCj4gDQo+
IEhpIFBlbmcsDQo+IA0KPiBUaGFua3MgZm9yIHRoZSByZXBvcnQuIElmIHlvdSB0cnkgdGhpcyBz
ZXJpZXMgd2l0aCB0aGUgZm9sbG93aW5nIGRpZmYsIEkgZXhwZWN0IGl0IHRvDQo+IGZpeCB0aGUg
aXNzdWUgZm9yIHlvdS4gQ2FuIHlvdSBwbGVhc2UgdGVzdCBpdCBvdXQgYW5kIGxldCBtZSBrbm93
PyBUaGUgdjEgb2YgdGhlDQo+IHNlcmllcyByZW1vdmVzIHRoZSBkZXBlbmRlbmN5IG9uICJjb21w
YXRpYmxlIiBzdHJpbmdzLiBUaGUgZmlyc3QgZGlmZiBiZWxvdyBpcw0KPiBzb21ldGhpbmcgSSdt
IGdvaW5nIHRvIHJvbGwgaW50byB2MiBvZiB0aGUgc2VyaWVzIGFuZCB0aGUgMm5kIGRpZmYgYmVs
b3cgaXMgZml4aW5nDQo+IHVwIHRoZSBzY21pIGJ1cyB0byBzZXQgdGhlIGZ3bm9kZSBmb3IgZGV2
aWNlcyBpdCBjcmVhdGVzLg0KDQoNCkhJIFNhcmF2YW5hLA0KDQpJIG5vdGljZSB0aGF0IHRoZSB0
aHJlZSByZXZlcnRlZCBwYXRjaCBkbyBub3QgaW4gdXBzdHJlYW0gNi4wLVJDMSwgc28gb24gdGhl
IGxhdGVzdCA2LjAtUkMxLA0KSSBhcHBseSB5b3VyIDkgcGF0Y2ggc2V0IGFuZCB0aGUgdHdvIGRp
ZmYsIGJ1dCB1bmZvcnR1bmF0ZWx5IHN0aWxsIG1lZXQgdGhlIHNhbWUgaXNzdWUuIE1NQyBzdGls
bCBub3QgcHJvYmUuDQpZb3UgY2FuIHJlZmVyIHRvIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL2lteDh1bHAuZHRzaSBmb3IgbW9yZSBkZXRhaWwuDQoNCkFuZCBmb3IgeW91ciBzZWNvbmQg
ZGlmZiwgd2lsbCBtZWV0IGZvbGxvd2luZyBidWlsZCBlcnJvciwgSSBqdXN0IGFkZCBhIGxpdHRs
ZSBjaGFuZ2UgdG8gZml4IGl0Og0KDQoxLCBhZGQgb25lbCBsaW5lIDogICAgI2luY2x1ZGUgPGxp
bnV4L29mLmg+DQoyLCBhZGQgYSBibGFuayBiZWZvcmUgIj0iIGluIGxpbmUgMTk1Lg0KDQoNCmRy
aXZlcnMvZmlybXdhcmUvYXJtX3NjbWkvYnVzLmM6IEluIGZ1bmN0aW9uIKGuc2NtaV9kZXZpY2Vf
Y3JlYXRloa86DQpkcml2ZXJzL2Zpcm13YXJlL2FybV9zY21pL2J1cy5jOjE5NTozMTogZXJyb3I6
IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIKGub2ZfZndub2RlX2hhbmRsZaGvIFst
V2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQ0KICAxOTUgfCAgICAgICAgIHNj
bWlfZGV2LT5kZXYuZndub2RlPSBvZl9md25vZGVfaGFuZGxlKG5wKTsNCiAgICAgIHwgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fg0KZHJpdmVycy9maXJtd2Fy
ZS9hcm1fc2NtaS9idXMuYzoxOTU6Mjk6IHdhcm5pbmc6IGFzc2lnbm1lbnQgdG8goa5zdHJ1Y3Qg
Zndub2RlX2hhbmRsZSAqoa8gZnJvbSChrmludKGvIG1ha2VzIHBvaW50ZXIgZnJvbSBpbnRlZ2Vy
IHdpdGhvdXQgYSBjYXN0IFstV2ludC1jb252ZXJzaW9uXQ0KICAxOTUgfCAgICAgICAgIHNjbWlf
ZGV2LT5kZXYuZndub2RlPSBvZl9md25vZGVfaGFuZGxlKG5wKTsNCiAgICAgIHwgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIF4NCmNjMTogc29tZSB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFz
IGVycm9ycw0KbWFrZVszXTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjI1MDogZHJpdmVy
cy9maXJtd2FyZS9hcm1fc2NtaS9idXMub10gRXJyb3IgMQ0KbWFrZVszXTogKioqIFdhaXRpbmcg
Zm9yIHVuZmluaXNoZWQgam9icy4uLi4NCg0KDQpCZXN0IFJlZ2FyZHMNCkhhaWJvIENoZW4NCj4g
DQo+IFRoYW5rcywNCj4gU2FyYXZhbmENCj4gDQo+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnBy
b3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxvcmUua2Vybg0KPiBlbC5v
cmclMkZsa21sJTJGMjAyMjA4MTAwNjAwNDAuMzIxNjk3LTEtc2FyYXZhbmFrJTQwZ29vZ2xlLmNv
bSUyRiZhDQo+IG1wO2RhdGE9MDUlN0MwMSU3Q2hhaWJvLmNoZW4lNDBueHAuY29tJTdDMzYwZDNl
NTIzYTk0NDE4ODJlNTkwOA0KPiBkYTgxNDRiZTE2JTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTlj
NWMzMDE2MzUlN0MwJTdDMCU3QzYzNzk2NDQNCj4gMjk0ODkwNTkzODUlN0NVbmtub3duJTdDVFdG
cGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvDQo+IGlWMmx1TXpJaUxDSkJUaUk2
SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzMwMDAlN0MlN0MlN0MmYW1wO3NkYXQNCj4gYT1vNyUy
QjVIU3R1ODJTM2RqMUo1U2ZFTzNQckc5Zm8yU1NzUjZQVDV0MHYweDAlM0QmYW1wO3Jlc2VydmVk
PTANCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Jhc2UvY29yZS5jIGIvZHJpdmVycy9iYXNl
L2NvcmUuYyBpbmRleA0KPiAyZjAxMmU4MjY5ODYuLjg2Njc1NWQ4YWQ5NSAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9iYXNlL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL2Jhc2UvY29yZS5jDQo+IEBA
IC0yMDY4LDcgKzIwNjgsMTEgQEAgc3RhdGljIGludCBmd19kZXZsaW5rX2NyZWF0ZV9kZXZsaW5r
KHN0cnVjdCBkZXZpY2UNCj4gKmNvbiwNCj4gICAgICAgICAgICAgICAgIGRldmljZV9saW5rc193
cml0ZV91bmxvY2soKTsNCj4gICAgICAgICB9DQo+IA0KPiAtICAgICAgIHN1cF9kZXYgPSBnZXRf
ZGV2X2Zyb21fZndub2RlKHN1cF9oYW5kbGUpOw0KPiArICAgICAgIGlmIChzdXBfaGFuZGxlLT5m
bGFncyAmIEZXTk9ERV9GTEFHX05PVF9ERVZJQ0UpDQo+ICsgICAgICAgICAgICAgICBzdXBfZGV2
ID0gZndub2RlX2dldF9uZXh0X3BhcmVudF9kZXYoc3VwX2hhbmRsZSk7DQo+ICsgICAgICAgZWxz
ZQ0KPiArICAgICAgICAgICAgICAgc3VwX2RldiA9IGdldF9kZXZfZnJvbV9md25vZGUoc3VwX2hh
bmRsZSk7DQo+ICsNCj4gICAgICAgICBpZiAoc3VwX2Rldikgew0KPiAgICAgICAgICAgICAgICAg
LyoNCj4gICAgICAgICAgICAgICAgICAqIElmIGl0J3Mgb25lIG9mIHRob3NlIGRyaXZlcnMgdGhh
dCBkb24ndCBhY3R1YWxseSBiaW5kIHRvDQo+IA0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
ZmlybXdhcmUvYXJtX3NjbWkvYnVzLmMNCj4gYi9kcml2ZXJzL2Zpcm13YXJlL2FybV9zY21pL2J1
cy5jIGluZGV4IGQ0ZTIzMTAxNDQ4YS4uMDgwMmJkZDBlYmZjDQo+IDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2Zpcm13YXJlL2FybV9zY21pL2J1cy5jDQo+ICsrKyBiL2RyaXZlcnMvZmlybXdhcmUv
YXJtX3NjbWkvYnVzLmMNCj4gQEAgLTE5Miw2ICsxOTIsNyBAQCBzY21pX2RldmljZV9jcmVhdGUo
c3RydWN0IGRldmljZV9ub2RlICpucCwgc3RydWN0DQo+IGRldmljZSAqcGFyZW50LCBpbnQgcHJv
dG9jb2wsDQo+ICAgICAgICAgc2NtaV9kZXYtPnByb3RvY29sX2lkID0gcHJvdG9jb2w7DQo+ICAg
ICAgICAgc2NtaV9kZXYtPmRldi5wYXJlbnQgPSBwYXJlbnQ7DQo+ICAgICAgICAgc2NtaV9kZXYt
PmRldi5vZl9ub2RlID0gbnA7DQo+ICsgICAgICAgc2NtaV9kZXYtPmRldi5md25vZGU9IG9mX2Z3
bm9kZV9oYW5kbGUobnApOw0KPiAgICAgICAgIHNjbWlfZGV2LT5kZXYuYnVzID0gJnNjbWlfYnVz
X3R5cGU7DQo+ICAgICAgICAgc2NtaV9kZXYtPmRldi5yZWxlYXNlID0gc2NtaV9kZXZpY2VfcmVs
ZWFzZTsNCj4gICAgICAgICBkZXZfc2V0X25hbWUoJnNjbWlfZGV2LT5kZXYsICJzY21pX2Rldi4l
ZCIsIGlkKTsNCg==
