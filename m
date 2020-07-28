Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58E4230341
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jul 2020 08:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgG1GsN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Jul 2020 02:48:13 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:50988 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726874AbgG1GsN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jul 2020 02:48:13 -0400
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06S6ZmKo010183;
        Tue, 28 Jul 2020 02:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=zpO8PzPzx6sxD+sXV0FEjX9CE0r5zTzu11izREKdr/Y=;
 b=gujDDE58zpbWsfTIWSRAlgt3CKlfUbtwxAkphNkVK1KDvDig39MXYZqxyeJisDhx+ryu
 Cp64g0hplVPrPD76P+3+aDDROpR2HgnfsdtQ/uPUdNBHc/OOstb7qxXRA+P6N6lohNiV
 pX9j5kdBqSWtyC5fNQueXqmpNdjtmRv5tGNueiMxECSQi8VqKhg8x4/qGAArid2ooHvC
 wEfRK4HGuX7Q1osJPoGLRoPQf+Vq0EzY6BlfccJKIZ5HgSknwaMuu4CC79R89QTgE6F+
 NTA44xm/UbsTKdeegwGWEZL5ZzESvDiVr6iRMfBi0zd3GguRaoX9NEutDpX0Ik6GiQ6K YQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 32gfy7t05h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jul 2020 02:48:07 -0400
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06S6bl09050280;
        Tue, 28 Jul 2020 02:48:07 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by mx0b-00154901.pphosted.com with ESMTP id 32jeh60c1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jul 2020 02:48:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxHbklgPUgnDzEz1OtAeB5so+XKeDYP/J2kmOWqXEBJu4NiY07iJvs/5Wv1rC+FSyivTTKAJxM6Eto055fKHMP6KFD0lTVOkp40oeXqa0BMW3zwcxaNIMVld6xvT90D7Bq6KNpsJDsefkwQLRVWiEmON3chaaC5KzjgMcKQTVMKVYMWH1NC1uqm/WSkunclKS2k56xZ9tYY9elP6slj5mQVqh/MEHQ6KzPG7qOv6pzWxN/j7hAJ9CUNwpdTrk3nyeKXE4vInOALWVWJcTwUPH4g5dD/PQ2j+SK26L1BSNduxhRoeT7w4Leh1X2l0PvSHv9wvayvwrhtWtyFTDoMMQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpO8PzPzx6sxD+sXV0FEjX9CE0r5zTzu11izREKdr/Y=;
 b=h0cBE4jYu7naF0IHpX4sKcgASxPo4LG1W/MaIrb9L9nRAa9ohSSJdC1QG79kUxneaalV/qWbyr/sr+m2sJSY3UbE7PYIsCajuqt+YulCB3dKBfpTLPcAU1/4AuPuu5cYsqAAaiObiUI7BtDJrxXq7jeh5WFVi4XenzfuGc12c8vdpFJFGXEFtswY0urBBKcXcNfIGvSuWxGiqDnUK8vhLvCWl0919Uzmpc9pktPf8W/kWU7BMQ9y8X1Va3F8aO/mPfgMoHZTopSwzwIIQSqiDn3CD2ookSt3aYpjwTFQGZlS26WaRwxRCneNz1sCllFsthxpbf8f0ljM55ieFMwzdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpO8PzPzx6sxD+sXV0FEjX9CE0r5zTzu11izREKdr/Y=;
 b=awiQdkHfismQbb2bXjH8+b1dxR2OejrEKnxUojSezz77n0oznM5mKf3PVo3N85s2h+9earXYzZzqRT7E/lqhCc5e9Vj1KDt+VSGOCPfGugpKSBMJ+vif6ocjQt1p+Mh5KXliA2lvDbnEoUSw6XNr9QActVqiSbKs1kGz/EQB3aM=
Received: from MN2PR19MB3280.namprd19.prod.outlook.com (2603:10b6:208:13d::22)
 by MN2PR19MB3629.namprd19.prod.outlook.com (2603:10b6:208:190::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Tue, 28 Jul
 2020 06:48:05 +0000
Received: from MN2PR19MB3280.namprd19.prod.outlook.com
 ([fe80::44ff:c8ed:66e3:33b9]) by MN2PR19MB3280.namprd19.prod.outlook.com
 ([fe80::44ff:c8ed:66e3:33b9%7]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 06:48:04 +0000
From:   "Wang, Crag" <Crag.Wang@dell.com>
To:     Sebastian Reichel <sre@kernel.org>, Crag Wang <crag0715@gmail.com>
CC:     "mathewk@chromium.org" <mathewk@chromium.org>,
        "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        "campello@google.com" <campello@google.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RESEND 1/1] power_supply: wilco_ec: Add permanent long
 life charging mode
Thread-Topic: [PATCH RESEND 1/1] power_supply: wilco_ec: Add permanent long
 life charging mode
Thread-Index: AQHWWrjEGvO7WTs4p0K1hlx2cRbv+KkcJ24AgABURTA=
Date:   Tue, 28 Jul 2020 06:48:04 +0000
Message-ID: <MN2PR19MB32808EA057889F61C063DB4CE3730@MN2PR19MB3280.namprd19.prod.outlook.com>
References: <20200715145511.9464-1-crag.wang@dell.com>
 <20200727233414.xu5eqyes76a5hpkw@earth.universe>
In-Reply-To: <20200727233414.xu5eqyes76a5hpkw@earth.universe>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Crag_Wang@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-07-28T06:48:03.1598338Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=7e83b517-a3a7-4386-86d8-5d45b0147206;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [163.244.185.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d7b3b81-54d5-4447-7007-08d832c22df5
x-ms-traffictypediagnostic: MN2PR19MB3629:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR19MB362925C7BF1E69A6C6F13C9CE3730@MN2PR19MB3629.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s9XKR6T9afR8KaGhqESf1H9ABFFXGYRLWegOVSa7N+GtjDSB8bof3I2IQBPiX4BwZlNUnFYREmILPiNaxbK/kmk/zE3TDxw2CAIFA6NGCna4Ih4vJ8vjk4aG4tooEBD2g7NsdFIrpvSCpggAFiUtl6GagjCxW9hZxhZqqCwbAzFuglm+5M+nVCpfBFhEaeQCaNrqnTmGn/qqYipWolGTusbDkM+amfnXmJRSnvBFEBsCWvdMroy8RyLt0wHr0fjVtU7RiAwJ4j9CYgVGv/33MGnejnwka2ER3Ucno5A5i0BnxtPQF3vJCUDfi6BrE2noY1YBv7fAmHGkIu/T0a4nQQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR19MB3280.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(39860400002)(366004)(396003)(376002)(346002)(478600001)(76116006)(66476007)(66556008)(64756008)(66446008)(66946007)(86362001)(7696005)(54906003)(71200400001)(8936002)(9686003)(52536014)(8676002)(5660300002)(33656002)(786003)(4326008)(6506007)(110136005)(2906002)(26005)(186003)(55016002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: v1LiLbaHboa9M34FJqzg019nYXskZJUCVojtVwef/LvgKfssunzmYpicZCJ/Ica+6SEIIH7BvRf0/sassuzTMhcU2JZNJuT149IZa1vbJOgYMd/vnR41/9nZYLP18T2ZSvgL4omrOpOxxzEHL6hfgZ9J2UENBHWlVRDx/46q22JkycGhLDy0DHNTKQieJmxo5AbKoneHzpB4dko93CEVWZyEmB15MiWS5laV5ygmXAxAwbdlOsdUIJ9DzzJ4pCA2fTDG3T0vNouLlPV7Y81/ikAl0826ExER4vfLdmD47DD0CLTdPTM4MrYO0oJyntWzWxoavWyuzFXY9NdYd8uhGJKLpTOgf6duM76xdOp69gio43szKglSEy+Xc64JDJqxrPG0Xc6703vfcEOc17FkejcmgdAycAE0H94sCta4ramCEpKsxVgxbBXYDT79tlD16j1MMW6BVE+H8wlIU39nVqxn0BZfQNmgf7Mkeq9c8Do8Tu85I3rCRMoNukyZwm+W
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR19MB3280.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7b3b81-54d5-4447-7007-08d832c22df5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 06:48:04.7749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wMuPw9kN5JeL69JCbT644/zGcyM7LD3zTJUwZ7s8/mq5dhqCrSrO4/pD4eZaVnOE1oba8Zfrt0MHWmpU0w5o1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB3629
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-28_01:2020-07-27,2020-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007280049
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007280049
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> > +		Permanent Long Life: Last longer battery life, this mode
> > +			is programmed once in the factory. Switching to a
> > +			different mode is unavailable.
>=20
> The documentation lacks one important aspect: What happens if I have a
> device where the factory did not program "Long Life"?
> I.e. what happens when
>=20
> # cat /sys/class/power_supply/wilco-charger/charge_type
> Standard
> # echo "Long Life" > /sys/class/power_supply/wilco-charger/charge_type
>=20
> Will the controller switch into permanent long life battery mode without =
any
> exit strategy?
>

The set_property attempt will convert "Long Life" to its index of charge mo=
de
and send a EC command to Property ID 0x0710 for configuration. This try wil=
l be
denied by EC because "Long Life" mode must be set (enable/disable) through =
a
different PID that isn't publicly known. In the factory there's a proprieta=
ry tool
in use for PLL configuration.

In above example after the run the charge mode will remain unchanged i.e.:=
=20
"Standard".

> >  What:		/sys/class/power_supply/wilco-
> charger/charge_control_start_threshold
> >  Date:		April 2019
> > diff --git a/drivers/power/supply/power_supply_sysfs.c
> > b/drivers/power/supply/power_supply_sysfs.c
> > index bc79560229b5..af3884015ad8 100644
> > --- a/drivers/power/supply/power_supply_sysfs.c
> > +++ b/drivers/power/supply/power_supply_sysfs.c
> > @@ -87,6 +87,7 @@ static const char * const
> POWER_SUPPLY_CHARGE_TYPE_TEXT[] =3D {
> >  	[POWER_SUPPLY_CHARGE_TYPE_STANDARD]	=3D "Standard",
> >  	[POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE]	=3D "Adaptive",
> >  	[POWER_SUPPLY_CHARGE_TYPE_CUSTOM]	=3D "Custom",
> > +	[POWER_SUPPLY_CHARGE_TYPE_LONGLIFE]	=3D "Permanent Long
> Life",
>=20
> The "Permanent" part is specific to the Wilco EC, so I think it's better =
to avoid
> it in the generic API. I think it's better to use just "Long Life" (and k=
eep the
> wilco specific sysfs Documentation, that Long Life configuration is
> permanent).

Agree with you, I will include this modification in the next patch.


>=20
> -- Sebastian
>=20

