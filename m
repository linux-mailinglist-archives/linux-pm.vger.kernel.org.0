Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300DF650B5A
	for <lists+linux-pm@lfdr.de>; Mon, 19 Dec 2022 13:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiLSMVn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Dec 2022 07:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiLSMVk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Dec 2022 07:21:40 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43683D2EB
        for <linux-pm@vger.kernel.org>; Mon, 19 Dec 2022 04:21:37 -0800 (PST)
X-UUID: 0dc958a50fa64bbbbc18cd8025c9d064-20221219
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=XKxIR6AbyYgJkRMm+Uiwp324IC6NDN7Yc5x1he2rvsQ=;
        b=HuUmrU3vjHy3WAQjBGTFEADPxQ/4bRQWO5U9614F+hvZowPk9AHembCdPwEEXsbEAJZ7nTeuxsUe08RWC8gUKmYXiwpwC9i22HCMK/LNL6vRH5ZwfsC87VSQCw+bOc/x7CfgHuNSjSZmulrdiTbtxDVtLXtgisb9E8n+7n6CY24=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:089bca40-1bd4-4477-9e89-17fa90aa7f99,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:e2e4c789-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 0dc958a50fa64bbbbc18cd8025c9d064-20221219
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 967925356; Mon, 19 Dec 2022 20:21:31 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 19 Dec 2022 20:21:31 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 19 Dec 2022 20:21:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYIryuoHyCC5tI91W1dU+yEj70a0FE7k/550uNE+WwuxXNfB6K4lSNQeZ7keskQMsGwEqgdcVG0OK8v/ndXjKrAynNlnVuiYKYtHg456Y2KmyPB+qPPpynJke7LkiUmG6szBDVVpK53GjugrpeU1fvwnh3pllYhmCSh0KKbSHDscSQvmuaFKbbIIXRI1DhAW86YUWZQCKSd1ifIdgh/1Y8PzswzApZ13oaZ67PogQvcno9wOxWSa+fNzjI6f377c6gIu/CQxwlMxH/mz1ucStxtnC8ZamgWQSVIcSqRMHWrVajg+JXh0m/3Eg5ZvzjYvq2r+LNYKzQ/3lTRr4mgweA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKxIR6AbyYgJkRMm+Uiwp324IC6NDN7Yc5x1he2rvsQ=;
 b=G2MkUVy2DpNFLlZGhD/D6CVtZDAiHnbxC9EYIvILLTLnWV/jU/TS7hfyW4xMF9brQOvPomkzXQi167ARI4hX1+56ts/kzpcI5556n14tA9WjHylZGmqbVdbdJ8TUFPJ3JwlzQqpjeIsetHoWOmO/S52pBewfJI1QVmrdRb7ixiOlRl8mPkXRjFaB6HGLa9Qs2SIUga6wfmpTgrmsKbwYm0VVkDGNpVn+gHhAc/lAlJpxPI8aXSpbFUpwpPK9RixVSH5Yjo3XdfgRIxNMlCDAQMDC1oRoWsLmRq6ZG6alnIKCi8P2IycdN5SNtGzHeFqADhOyS6QhBCcPeM2O3upLNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKxIR6AbyYgJkRMm+Uiwp324IC6NDN7Yc5x1he2rvsQ=;
 b=Te3iQQCfw51iSAFKCwD9SlLQXh0Rt8hnUZHhcULaV8Cezi3AHg/XU1sNqrGSF59zGWAE7dynVY/2zEcCPCuiRdOtXLbXdEgOFFcC0wHl5j65zbHOqfDK7Ff2Yw6nWwHmxzz6cVUHFF33okoPPgbGXZ0eKgq52vt4fd3uOmrNnBg=
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com (2603:1096:400:28c::9)
 by TYUPR03MB7088.apcprd03.prod.outlook.com (2603:1096:400:355::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 12:21:26 +0000
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::55ee:fab0:3a02:5aa]) by TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::55ee:fab0:3a02:5aa%7]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 12:21:26 +0000
From:   =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>
To:     "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "vincent@systemli.org" <vincent@systemli.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "regressions@leemhuis.info" <regressions@leemhuis.info>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "daniel@makrotopia.org" <daniel@makrotopia.org>,
        =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <Rex-BC.Chen@mediatek.com>,
        "thomas.huehn@hs-nordhausen.de" <thomas.huehn@hs-nordhausen.de>,
        =?utf-8?B?SmlhLXdlaSBDaGFuZyAo5by15L2z5YGJKQ==?= 
        <Jia-wei.Chang@mediatek.com>
Subject: RE: Kernel Kernel bug caused by (cpufreq: mediatek: Refine
 mtk_cpufreq_voltage_tracking()) on Banana Pi R64 (MT7622)
Thread-Topic: Kernel Kernel bug caused by (cpufreq: mediatek: Refine
 mtk_cpufreq_voltage_tracking()) on Banana Pi R64 (MT7622)
Thread-Index: AQHY9EBMG2Hs3dZcS0K63Lh/Rcrv+644BgIAgAhm7ICAGNg0AIAABQwAgAADnQCAAOcvAIAAOrgAgAAGTACAAAaJAIAABV4AgAAK0ACAAAVsgIAAAEaAgAgn54CAEqYEgA==
Date:   Mon, 19 Dec 2022 12:21:26 +0000
Message-ID: <5e07eb07de0fea2232c32f58691ffb7cfd2303f8.camel@mediatek.com>
References: <02c2c955-940b-b315-0474-85d0eddad7a3@leemhuis.info>
         <Y4jHvomTrU8guBox@makrotopia.org>
         <47a4665e-333d-a6e7-a2da-96cb06c2d87b@leemhuis.info>
         <20221202052716.uj3kzkunazmgazeq@vireshk-i7>
         <0ebef1a2-6b5a-04b9-a79b-79eb3349c32b@collabora.com>
         <c76bd301-0e8d-2d2b-0d3e-a57ece9b496f@collabora.com>
         <b1822bbc3775730c4cedf9652323c7d72e663e4b.camel@mediatek.com>
         <8be3e050-f32a-6761-8ebd-49c38dfcf9eb@collabora.com>
         <c186d104-43e0-ca10-3ce2-c2f922acd8bf@leemhuis.info>
         <37468027-6a27-dcb8-9c14-8f8426ec50d1@collabora.com>
         <20221202110139.vmwcmoudakm2nap4@vireshk-i7>
         <f70d7c09-df0d-4fa9-92c9-63f31cf56483@systemli.org>
In-Reply-To: <f70d7c09-df0d-4fa9-92c9-63f31cf56483@systemli.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6919:EE_|TYUPR03MB7088:EE_
x-ms-office365-filtering-correlation-id: e90bdf8a-84cf-4334-f8e1-08dae1bb8d08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Dv8AOgAZAe7uZgePkVrYREVKstvUJAJ/bHPS1zzhxt+tNOtKGu1f4imEgPxDt0wyEaB9juD87dL4ukhtsUEeUDSH7viOrqdKSB3y0aEklnliaTSWfLT5Ae4CAwMDffHY5L1jekw4FPUaLJBA0SVpsgcXXTdluOPtrxvXJkadcuh1BgPM+155OVe82uOBzkRleL6hr5dJKCoeD94DQUmXZbGEwToTG0dxDUKx+ThAOsVnz4dJSKA3NufNMfEdrhRn/wrz6WiXSb3l0ax3A6iF/x1+dwqFTFnbqZteDQkaCcSD9ZlUgONKt3rM/sYyoCudDU0Q+XbqKfYMQ5FmtapZMcUhFTAiIy6muI+d3ioyyGx47sdpn5HSu9+zSFfYWcLcApmpf+WLfZPRy4LUGyj7jSNl3l9jySOuDuQ/d5i58/B/oheTZ9SlI8ZExeDB1ppH/WeeZM8I5itzazZHog2lf3U3VIrFrQ4tP2fX4E1HCf3mEngb3tpRSx7GG/0RkgrXw6WkiMszJcfuFduL5t8giliXTpqT++mw8EfrjFmzWWp4GtwD5t/pcgslV+e2T2v3OgjALjWeARMpVPWMAW6jzHmGsRA/U9sZCstY1PCDEPSzknxFXLerLCDDz5lusotUU55YXatQFWZmdKluxvcrN1b43oFTSMuEMQtGDrrNGIu/MS29v+qRLTHFt7ZrOKheDYghjHRBZt6zKQtr8GLdC0c8aYvL0C2NSbO2CmA9TM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6919.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199015)(36756003)(85182001)(2616005)(91956017)(7416002)(4326008)(66946007)(64756008)(66446008)(66556008)(76116006)(83380400001)(5660300002)(66476007)(8936002)(8676002)(966005)(53546011)(6506007)(71200400001)(6486002)(107886003)(478600001)(110136005)(54906003)(6512007)(316002)(186003)(26005)(41300700001)(86362001)(38070700005)(2906002)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUFvTWwzaWRWc0VVdGNlRWpOY2lHSFgyd1F0U1ovWi9oc3M2cjFQMzVKc0RY?=
 =?utf-8?B?RUhQVGZrRE43bzU0ZHVZVVhBUkdmcG1qbGRxVmw4bFE0RXNtKzdkRGFNd2w2?=
 =?utf-8?B?d3drNkJSL0pyd0J0dys2UmFCMFNma2hmSmRuQXJRdThpRDhoZmZzYlROTng4?=
 =?utf-8?B?RGVmQkpTTnZYZDMvUGtTWDMvRXpoQktXQ1JlVCt4WlhEQmJlR2tQUHpXLzdR?=
 =?utf-8?B?YjVqaW9Eb3FkUDB4cWhTV2dlUTlsbDNmODYrZ0dXSFNBNzErRHBjcVNZaXRk?=
 =?utf-8?B?TWtra09URTFwUDJ1WGloTGlreGVsOXpqY3hjTkNQRjI3NzdnTElDUTd6bi9o?=
 =?utf-8?B?V0ViWStTQnFoS2UxR2F5TUMva1VmcmVvRmNYUGJENWdtRjNCUG01cm5tMWZU?=
 =?utf-8?B?bmpZS0ZNTWMvMzhHYm9OZzJLNSswcDNlcnBINklWQTVYbndaNlQwUzZmZDRy?=
 =?utf-8?B?ZXI0R1NkNEdsY1ZVZmpEYXhWQlZZcURic1d0Q2I5Y2FxTmQraUNKWVl0bGZm?=
 =?utf-8?B?QnFSL2lvZDJPM2FhTXhub3d2OGFQcnkwY0ZhcEhKa3lvQzlLT21qNXROUGtU?=
 =?utf-8?B?K0kvYkQ1ZVl6N3hWVkxIMEJ2Nk95UnlwanpHRGdXc25iMDUvTHBWd1NsckJl?=
 =?utf-8?B?ekY4TFA1YmRoSzdyb3daTC84VFpMS05jdzAxdEhCb3d0eVV0UUpWd0tvWnha?=
 =?utf-8?B?eWEraFlFZTFzRmpVS2x1cmxmSERhN0w0NUdKdWkvQ0wySk9uUFZIblVMSXJy?=
 =?utf-8?B?UFZCYStWeWM0TENwU0hROExZQ3ovM3dqZmc3dXArd2twMysrNTNzeis1TDJu?=
 =?utf-8?B?YmNoOFg1M2tibE8xcDJVMlo4N3YzZnUzcnR5eXhwd2VVN3BQVTZjSnBIdVl1?=
 =?utf-8?B?ZnlwWTBpbjFhY0VVQWdvNzRMMjFMUmZEcUswSG01MnBUT2JNTTRraFJ2V1Iz?=
 =?utf-8?B?TE0zNXBQUWtSSVNpWklaTVVRSTdKeEJlbE95cmxzQ2hnTzdOczQ5OWdibUZ0?=
 =?utf-8?B?MTFNQVc1WVVsMFVaa0NPaC91SzhQL2pHTEZ6MEVRazRhd3RnUHkrUGdEOGJP?=
 =?utf-8?B?M3p4YzFuMnhmM3ZnOGQ1dVJwVnlNT2oyM1hTQjhLRnlOT3NiVEZLTlBqNVRo?=
 =?utf-8?B?cEtGZHUzamhsOTZIK1llN0pFMTY2Zy9RdERKRk9jbHVJL3FmZHRleGNMZVhp?=
 =?utf-8?B?WjNwMHprcFhhV2FQNXJidE0rZ09ndE5CU0xLNE5XK3VDZDBlM0NGVDNCd3gz?=
 =?utf-8?B?S3RJTmVnZ05YM0dVb0IwV0hMelpma3NRWHlsUmZuSXFTeC8zeVVaaHF6NG13?=
 =?utf-8?B?eWdoM3UrT0VybzM2WW00aUtUTDlZcXBQMVpMR3VGWDY5ZGZGZmd4SmM3cDIv?=
 =?utf-8?B?emFTcDByM0JPU1lQdmNwMUxyQXM1NElISThSdjVmcU40cFcrbXA2aHJIaWt2?=
 =?utf-8?B?eDV4THpuSXpkcHVqTmRuaFUzLy80Q1Z3Z2tJWmRkdGZNZlhVSmhHVkFlRksw?=
 =?utf-8?B?K0RheFpYdDVXL09KcjRKMjJ6WXpJWUc5NUJpRTRDZ3h1eGE5dDcxRlNxUVpE?=
 =?utf-8?B?dEdaTVEwbVgvblJIVG5lV2xxMGRkSFhMdGRpTmZoZkd5OElLMlFoTm5XYnFp?=
 =?utf-8?B?U043eVFTdEg4cklPZi9Za1ZGbXJNLzJZOGRvL1FxM0ZQTHhOUFVaY0ZQV0Nn?=
 =?utf-8?B?cldPZGNvNGllK2o0WTBVMGhUMkxSZkpBMEN4T1FlTk5yRU1sQ1ZXc29jTnRD?=
 =?utf-8?B?YTZsM2tYaldpNWJuRzFuRXo5T0R1bTI5ZDFOaXFMeVR2U1pGcXFoalpXOW9l?=
 =?utf-8?B?V3prREt4NmtFSENhcy83VHNzaG5HL1RQOHc1bHVxYkJPVHBKQWhqckhrRUpX?=
 =?utf-8?B?V2RjYzFKMHBla3dZL1JpaFJMNUtzZUVlNGU0OXpiQ1FzYXFuL2pyb3VsU3hP?=
 =?utf-8?B?STBSbUg5S2FBWHAweVQ3WjNrSFZ3Wjk2cTFiQ0Vrdi9sZ2dIdDVmMDlPK0FT?=
 =?utf-8?B?WGtUUi84eExDUVNtY2dpSVB2Q3ZCbjZnMG5VVER2VnNWMTlSQkJ3T05zR2VV?=
 =?utf-8?B?bGhwMGdSem12L2E1UTZPT0crWmRvUHM5M2xPbUhkZHk3QnJqNnpCTlIxY1pN?=
 =?utf-8?B?VldzSVNYMGFUeVVzcFNsS2o1cnh4WVk5S2JZWEVmVmV0YVV6aS9MVUtLcHhJ?=
 =?utf-8?Q?hzlzjM3dS11jWpot+LYthTI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <913E09C4CADCC54FBD732BA88888EAB0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6919.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e90bdf8a-84cf-4334-f8e1-08dae1bb8d08
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2022 12:21:26.7031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qq+4xGvytUZ1BuU1qPh6Dvn4Q2z6tA129CCyO4nHGp2601x1thq+gcZ2e/vEcG3ghQuj2QmXy+ZD7XP07mdMEY9I8kJ1G44+p0GuwZH9dy8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7088
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgTmljaywNCg0KVGhpcyBpc3N1ZSBkb2Vzbid0IHNlZW0gdG8gYmUgZ29pbmcgdG8gaGFwcGVu
Lg0KSXMgdGhlcmUgYW55dGhpbmcgZWxzZSB3ZSBuZWVkIGhlbHAgY29uZmlybWluZz8NCg0KVGhh
bmtzLA0KQWxsZW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IExpbnV4LW1l
ZGlhdGVrIDxsaW51eC1tZWRpYXRlay1ib3VuY2VzQGxpc3RzLmluZnJhZGVhZC5vcmc+IE9uDQpC
ZWhhbGYgT2YgTmljaw0KU2VudDogV2VkbmVzZGF5LCBEZWNlbWJlciA3LCAyMDIyIDExOjM1IFBN
DQpUbzogVmlyZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz47IEFuZ2Vsb0dpb2Fj
Y2hpbm8gRGVsIFJlZ25vDQo8YW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29t
Pg0KQ2M6IEFsbGVuLUtIIENoZW5nICjnqIvlhqDli7MpIDxBbGxlbi1LSC5DaGVuZ0BtZWRpYXRl
ay5jb20+OyANCmxpbnV4LXBtQHZnZXIua2VybmVsLm9yZzsgZGFuaWVsQG1ha3JvdG9waWEub3Jn
Ow0KUHJvamVjdF9HbG9iYWxfQ2hyb21lX1Vwc3RyZWFtX0dyb3VwIDwNClByb2plY3RfR2xvYmFs
X0Nocm9tZV9VcHN0cmVhbV9Hcm91cEBtZWRpYXRlay5jb20+OyBSZXgtQkMgQ2hlbiAo6Zmz5p+P
6L6wKSA8DQpSZXgtQkMuQ2hlbkBtZWRpYXRlay5jb20+OyBUaG9yc3RlbiBMZWVtaHVpcyA8cmVn
cmVzc2lvbnNAbGVlbWh1aXMuaW5mbw0KPjsgbGludXgtbWVkaWF0ZWtAbGlzdHMuaW5mcmFkZWFk
Lm9yZzsgbWF0dGhpYXMuYmdnQGdtYWlsLmNvbTsgDQp0aG9tYXMuaHVlaG5AaHMtbm9yZGhhdXNl
bi5kZTsgSmlhLXdlaSBDaGFuZyAo5by15L2z5YGJKSA8DQpKaWEtd2VpLkNoYW5nQG1lZGlhdGVr
LmNvbT47IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgDQpyZWdyZXNzaW9u
c0BsaXN0cy5saW51eC5kZXYNClN1YmplY3Q6IFJlOiBLZXJuZWwgS2VybmVsIGJ1ZyBjYXVzZWQg
YnkgKGNwdWZyZXE6IG1lZGlhdGVrOiBSZWZpbmUNCm10a19jcHVmcmVxX3ZvbHRhZ2VfdHJhY2tp
bmcoKSkgb24gQmFuYW5hIFBpIFI2NCAoTVQ3NjIyKQ0KDQpEaWQgc29tZXRoaW5nIGNoYW5nZWQg
b24gbWFzdGVyPyBJIGNvbXBpbGVkIG5vdyB0aGUgaW1hZ2UgSSB1c2Ugb24gdGhlDQpCUEktUjY0
IGEgYml0IGRpZmZlcmVudGx5Lg0KSSB1c2VkIHRoZSBvcGVud3J0IHRvb2xjaGFpbiAiYWFyY2g2
NC1vcGVud3J0LWxpbnV4LW11c2wtIiB0byBjcm9zcy0NCmNvbXBpbGUgdGhlIG9yaWdpbmFsIGxp
bnV4IHJlcG9zaXRvcnkgb24gY3VycmVudCBtYXN0ZXIuIFRoYW4gSQ0KY29tcGlsZWQgd2l0aCBP
cGVuV3J0LUJ1aWxkc3lzdGVtIGEgaW5pdHJhbWZzLCBwdXQgdGhhdCB0b2dldGhlciB3aXRoDQpt
a2ltYWdlIHRvIGEgIml0YiIgYW5kIGJvb3RlZCBpdC4gU3VkZGVubHkgaXQgd29ya3M6DQoNCmh0
dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2dpc3QuZ2l0aHVidXNlcmNvbnRlbnQu
Y29tL1BvbHlub21pYWxEaXZpc2lvbi81ZTQ5NTI5MjA2YmE1ZDI3M2JmNmE0MTZjNDJjNjIzNC9y
YXcvN2VjZmY3YmUzOTdhNmU5YTQxZWYxMjBjM2ZhNjEwNjBjNDg4Y2Y1Yi9tdDc2MjItYnBpLXZh
bmlsbGFfXzshIUNUUk5LQTl3TWcwQVJidyFnbE5oemlKeDhwanZWc1ZvUm0wTE84d3NoWEpMX2Iy
UF9qWVY1dk9fOXVoZTFFbmJNcFdSbklFY2pfNTYxSWp4dXJkOEMtRmpjN3VDYkJOSU1fRS03WVlj
JMKgDQogDQoNCkJlc3RzDQpOaWNrDQoNCk9uIDEyLzIvMjIgMTI6MDEsIFZpcmVzaCBLdW1hciB3
cm90ZToNCj4gT24gMDItMTItMjIsIDEyOjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyB3
cm90ZToNCj4gPiBJZiBWaXJlc2ggY2FuIGFkZCB0aG9zZSB3aGlsZSBhcHBseWluZyB0aGUgcGF0
Y2gsIHRoYXQncyBmaW5lIGZvcg0KPiA+IG1lIA0KPiA+IC0gb3RoZXJ3aXNlIEkgY2FuIHNlbmQg
YSB2MiBhZGRpbmcgdGhlIHR3byBzdWdnZXN0ZWQgbWlzc2luZyB0YWdzLg0KPiANCj4gU3VyZSwg
bm8gcHJvYmxlbS4NCj4gDQoNCg0K
