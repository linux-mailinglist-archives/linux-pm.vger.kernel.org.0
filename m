Return-Path: <linux-pm+bounces-37632-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC402C41233
	for <lists+linux-pm@lfdr.de>; Fri, 07 Nov 2025 18:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33477561406
	for <lists+linux-pm@lfdr.de>; Fri,  7 Nov 2025 17:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0038A336EDA;
	Fri,  7 Nov 2025 17:44:01 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2108.outbound.protection.partner.outlook.cn [139.219.17.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1B1253340
	for <linux-pm@vger.kernel.org>; Fri,  7 Nov 2025 17:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762537440; cv=fail; b=AqBMXiue3AnnjWp/s7b1zl+kWRtSeqsVry5hdsBwmz60/9WcN+V4zzhsD3dR7wdX+BMeYj/64gWGj4jVP3fUQogSNsIE9y3ii3zjfkMW1TX+Bp8fu7nM1VqcB/k7nMEBiZcXS5QYavc30/rHd+paL4RqS6uU8KA75m3n1/3fUWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762537440; c=relaxed/simple;
	bh=CMncNAIkFJzq3AaBdfMJfgRxRC1SW5aGI9sWeI+88ZM=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EVHNXJ1i++AbjeclFj2gzFqyQj7VJpkloIe4US9QYHtcudhU/l85uh1YzaMa0RPGTS7uIJ5ck88zHbJJWNshCdYJo8LhMk7G5S1hB6Ha4vrVJXgbVhQ7mkYaPD8aXGX+jWIVO5dR1sd5sYBACoxu4kkCelU3e4aayrGFSX+qJCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qw7S2h3oDImc03RteaMvOvhNExlHg6zlGRlGv0xuLfsy+QCo3I8SWEPz7AvoBcGwLUpmHZav2KT2IFOib9VnXQNB00Eu+N7lTsIt2P4qjovuZJlNPYL37vzTFxCDesMCIhjN9LjJGj9i5ZWsRzcxctSh7PN39ko5+KVp+QV1oAEh3yzAeyCEmyCt3cyY1QaAHUf4uM1+bdi798/JTTd1hrAeMhLre89oejcx5t7ZcwM/QGEUK9a6g2gmXU/LPIhXAIdHOAeMfCXIwveXarBuKPjpthpo7IQ+JF9N/J7UB4a/b7u3nwGEz4eXpzAN8nfwdQ1xLwAbjd/DWGDoJQzCGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsI+jg8/diAG9QeAdgxFLy5qUShrXlN7sQIjkUGJJoA=;
 b=ISA3VW3wV4Xtb1J06oHF9pmvqZOGeN6RZdCAbKstDiMQ8x8vc+iGLfQ16vcN9nIAXr4wVRvsxK7OJRr8rBQXJAohODMIWNsWDr7XToDrsrmo45Z47HUpl7gdK9AkkJRwhTyS1EqcbRd8eB0vnBz2bGZKg1yeRaDTeKqpM1lHBMetF2n0z2cNzdz79xypBFi+t+rKKYQ6kSG8xAG545nVqHa60BEa08jZatfeuqdWLkatTB/zaayJ1hbcl8/7MvHsC8Xb/pcYsUjD73+TJAj/N6TIf9E5YEOeiEBjoQvoAQ9XsAJ/DgEk4FF7BzWRRlNY4IZ1Fy38Hl89+YQgeDsj6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14) by SH0PR01MB0539.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:8::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 16:09:25 +0000
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::81c4:2724:6a48:a18]) by SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::81c4:2724:6a48:a18%4]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 16:09:25 +0000
From: Joshua Yeong <joshua.yeong@starfivetech.com>
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: pmdomain: unable to prevent disabling unused power domain
Thread-Topic: pmdomain: unable to prevent disabling unused power domain
Thread-Index: AdxQAN+9iPgEwacuRWKUsrt9GFHyQQ==
Date: Fri, 7 Nov 2025 16:09:25 +0000
Message-ID:
 <SH0PR01MB08411D2AF1EF4B73BDE02015F9C32@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SH0PR01MB0841:EE_|SH0PR01MB0539:EE_
x-ms-office365-filtering-correlation-id: daf0494e-42df-4cea-f948-08de1e180575
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|41320700013|10070799003|38070700021;
x-microsoft-antispam-message-info:
 To0Wyxy62B74wvkYPB5mpr+8zdM7uAMh7EVNHjuNlJzxPQDbsocMvma6hqm1FzfT3zljkrfNj688UKNTii/3SWfkyoi5xttZsn7J9tEArzmmb0JVw7uG3YLSMBiJL3zU8+gUWcNFdhazWqEak2WPA5Xa+ugZShblwA2JO6LQITR7n3pg/7deg9KHc61Pw/6b7DRQeu6ryEgJ6ihufNBJ8ToP2kaLBqc5kDhPCQ6+X0E34vbF3+CIZGuc09Vu238jqsgfUDtkrRusx/jaOPHGsTUSzaaIfoMB2Wz5nZn/QifiwBZGSvDuObzadHM2jy9i7udc3y768YKSDXzCRFsYjb+0IOtKxsa0Lo/n5XLddrj852dNKgHna2zNayrALBdLeA3qI531HFXdmiZIOz6EEoh+E2alRAd0PUqRIip+qy+htjl7Oeg5kfdXImBZhVPlzd+dCL8vNvPfyCk7VOcE0dY7PUnpk5u11HONgid0qjNw+AplSpxALDpXAnl2lrwQI06OCnjsWyDEnV7M/E0MKgkryXdWLnzkYpGZluKKe402Awe8ABbDo0ykVPv7AJ+8M20czxmEaf1OxyP+vMXfMlnR+QRDfsb+j0kSPPmYcT8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(41320700013)(10070799003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Yt8x+HH/h6GgCzfxm7kLlCeuS3SUbJ0CYBwsJXcHcRAwf4HnpaUrfBWdh85h?=
 =?us-ascii?Q?IYismPjgRY1QMit+JVQjJ17UbC+BrYSfyUFoT6WlVLy0YSrIKmbQo5O1Moyn?=
 =?us-ascii?Q?4lWn6HldtSSOL+xrzu8QguuNvr7K4EVhhMZIh2NoPG8X3HDXZlb4by3T3m0U?=
 =?us-ascii?Q?CQwKU9SKZSS7uc8XKMl9W0y0fXy2YtS6HanLPx1S5iuFT0hWPO9DfQTksaKR?=
 =?us-ascii?Q?pg8KAayEFBvD19TQ+gqcQ9v+vaCodJlHiKX+USTfLMxwkDYluH+nOFndU0TY?=
 =?us-ascii?Q?uPNXaAT4HAtBL8qfw9cXGN1YTTyaJkDgUY6M4spa8DgJZ8Q7zmQjsqpP7mm/?=
 =?us-ascii?Q?amDmgFHY9UufjoiVjEauIXqyfroMe70EkBhZRYiY7wwkw2mtBaArXtzEUdAz?=
 =?us-ascii?Q?5Vv+dwXEHjTNWO6lHzybXS3rGNlyP/IG30QsIbTkBV3WhUO5qXfaf1wXtIeH?=
 =?us-ascii?Q?dSFf6VYuGymCJcEjNbFG5D/igOXyuiYhv9bhh6O2sSw0jn4T2UZOv+d9vuG4?=
 =?us-ascii?Q?mww4t7yS8igPWT/B5/mntkJB04Qd+WjK1dJL8LA/hGlB/pX3EQH9MOm0Jkhz?=
 =?us-ascii?Q?23gVYLHHg+rKDecOkbXRewCiol4yfSxVW/8z8zbJYNiJ1LtDXH76aKcSjxUu?=
 =?us-ascii?Q?a0G98/GrqqfOfHy7faoOqDPP5YmCNd4Bg7Mvn0GG34CNyHBrRQ53NdkIf0A9?=
 =?us-ascii?Q?mBF8xnvmpMlKczjHKS4HmtxInDAFYGfrZtIbCdCHO0yms3V1rEUijE/k2P8d?=
 =?us-ascii?Q?ocSijRuSAq4mgZWULV/HshGVSSlO0HKWVDPQo08YQ9iZwhemV8lk3U7i/bzP?=
 =?us-ascii?Q?An0wI4NcJsfbAPB5C+5W05ur4o2vRtmrPl84+aYtNrHINEuVbjn301O5Ti6j?=
 =?us-ascii?Q?dGb5gJShRASGSIQKWDzhFjw/ZG1f5ZkQTNl6XIA6mn8RNiBvGRDDy0VMTgNq?=
 =?us-ascii?Q?mMXzRoK4mNSQYZlzvO1eGA6HCtvbEb6CJElngwblsFddlTmvlMuQ2EVmsHhr?=
 =?us-ascii?Q?5XhfZwZEatoNmzroO/JtA5UUqEOdiMBN1/2woit4DGXue7vvgOoJYD6WVXFu?=
 =?us-ascii?Q?xGQc8fmJ3L33G/reMnKLRaawegWoAITPAYzj2be5SuSZFja/2LqTG15gpJhB?=
 =?us-ascii?Q?uOgjbWD1yvjDbgOqjQEcJ+Mfo9b1/En2FA4YAYdYwxb/PUVu/Y9V9Z8cKCx9?=
 =?us-ascii?Q?wsZ9tyoiFi1+Baex19PDm9/iQOl+ajC0zVOQMpgzxXBKD3G205MGk15IsRAg?=
 =?us-ascii?Q?s54PYlax30aG/2/6fLagN8H3xdU7rrufhdNdXoYlyEHU2XzOVZoqt0jqbIyI?=
 =?us-ascii?Q?6qH45CZ6yUD+1hT4ov9irPXvGkmHGicEI4ADi2PwZX9ZscjdqDVBAw16SvwG?=
 =?us-ascii?Q?FL6rvnh++Jo7fIYbkndCjZOjNPwM3rYNcv/BIFG2/mBc6FXwz5UIqncoPccQ?=
 =?us-ascii?Q?SyewFobAV7jO9gVyEyENkOFC6d6HCy6hBz5YgY9hJRz6DztLRlKhtLBO3RVT?=
 =?us-ascii?Q?mig64HxlKS91wn3Qsdv6nNGk6VH4FNXyWsX6So93Mote48nekSKyjSg7iSdW?=
 =?us-ascii?Q?+2FLhS2aaV3KvHZvTs+2Kzrr/qiKorNI8D3jGIQLtmw/wlHzVrl70drxB8Ma?=
 =?us-ascii?Q?5L5z7DgCuCmpAMf6jSBXJYc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: daf0494e-42df-4cea-f948-08de1e180575
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2025 16:09:25.2718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OcPKEZFQsjSveCPrOrPt0fxQ0NLWDncdKthFES3USZW6EqcJPxS7SfECvqbGQqVbmdb05hTeHWjjLxf0IK7/97d2SGjvqJOQfhnTw9TObBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0539

I tested linux v6.18rc-4 today and notice that the kernel parameter 'pd-ign=
ore_unused'
is no longer honour despite it is used to prevent any power domain that is =
'on' and
no driver associated with it. I tried to trace the logs, and it might be du=
e to recent=20
commits. Can anyone advise if this is by intention?

https://lore.kernel.org/all/20250701114733.636510-8-ulf.hansson@linaro.org/

[    3.191235] PM: genpd: Not disabling unused power domains
...
[    3.231672] [<ffffffff806f62ee>] _genpd_power_off+0x7e/0xf0
[    3.231739] [<ffffffff806f8e92>] genpd_power_off.part.0+0x112/0x1f0
[    3.231792] [<ffffffff806f9cb2>] of_genpd_sync_state.part.0+0x82/0xc0
[    3.231845] [<ffffffff806f9d22>] genpd_sync_state+0x12/0x20
[    3.231897] [<ffffffff8076995e>] device_links_flush_sync_list+0x4e/0xb0
[    3.231951] [<ffffffff8076c28c>] device_links_supplier_sync_state_resume=
+0xac/0xf0
[    3.232003] [<ffffffff80e3ca28>] of_platform_sync_state_init+0x10/0x1c
[    3.232059] [<ffffffff80010936>] do_one_initcall+0x56/0x1f0
[    3.232110] [<ffffffff80e012aa>] kernel_init_freeable+0x26e/0x2ec
[    3.232165] [<ffffffff80bfae4e>] kernel_init+0x1e/0x150
[    3.232218] [<ffffffff8001253e>] ret_from_fork_kernel+0xe/0xd0
[    3.232270] [<ffffffff80c053f2>] ret_from_fork_kernel_asm+0x16/0x18


