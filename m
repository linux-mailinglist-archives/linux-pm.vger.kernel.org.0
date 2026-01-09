Return-Path: <linux-pm+bounces-40530-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AADD085FE
	for <lists+linux-pm@lfdr.de>; Fri, 09 Jan 2026 10:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A559E304422B
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jan 2026 09:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA8E335543;
	Fri,  9 Jan 2026 09:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="BYLUdhZl"
X-Original-To: linux-pm@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010051.outbound.protection.outlook.com [52.101.229.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AD1296BCB;
	Fri,  9 Jan 2026 09:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767952645; cv=fail; b=QE72HgJu6bctJb7YoiMIXF/IYaZ1nswHq/KroYLOyTV4SFhMrFUls3najfpgXtKHFdtXn3tZZJWFyZcudqJAkfKFaREl8cUx/Pjycxq+suw/xuWSQdxMO57t2GaiTgZjIXSh0mD4DyS8r3JUjclQOgvb6iZxRqfKhRsTQtTKrDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767952645; c=relaxed/simple;
	bh=5M334h7+Lly14RdUbWfUDvOrrw6x2P5p1c7YBDpr0cU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ag6eeogCz28LBsv34aHwsZBANieyABsF6uOc67gpBQNMJnnbtWPPJfPprPRhkW9Zz/o1fWC/L6i/2jka9FkDwkmlgN272EeLpBjoKyeIVqoLvfXk5I6YCQQV1MfFlpXCAjRUXe0obYNc/d/6OQziS9m+5fcuYqqUXPakWtUlEKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=BYLUdhZl; arc=fail smtp.client-ip=52.101.229.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hpSw7BGywQ46rpas9/P+CR/EAXrCNdOvJATReC4o9/QWHGbgQfE1uCZP+Q89Oz85RPA1Ct3PJk7/2WozHkecefNEFHdnolCjnI5uNXkMpSKOc2lZGQn0kz61uonYRSyLSMXWvM6cZgSjvdWYvGQvLG56u/swjjUCFDYeVDBYRe5+8crAeCQt9tIMwdWc9GQi2jFm4kBy/jjdrpvTaw0depg9erC87JhqsqzPN+gmtuzUwHxsWnG1QWNLmo1/OcQr9JMKr53D3M/01CeVVi2cjh2bcASS/j5jPG5TAN/Stk+ea8+pgwWc4Y1CMwjkdxMtgdVWoMzaSZcL6ZYB/pz8Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JN8nhHVOs3qHIr+gKX4e8mV/qc/vbScv+iZ/8FEvEjY=;
 b=Efm04ECbvgj+nphUGTTEf7Vrl1a+MMxMzscOtFo/KKl/NlCrK4uNCl6vnsfyggpO2P2oxJ0WyjUk9jpQIn7yA9oFlmouLxRnjt4mH1iiZcbdczbfn1uRXzmqnBYm9ZZ6HzUAZvw8NBiuXvcDJrujix2mZMkMfZabTkNeM7r65sRKkjG/SOac06xQpXKbE+jFsKHlUaVSuFxSmMbkBuIitwb9WERQmHzjMbpuJObhjvYky4nDFZc6Ori0q8Yxm90HNK/seEPnnwgTKTQEbC6M6Dt80+z9WKow7DVimD+pNLFatskHzvOjzga0WHFBv3EJff/eKFtiJ5ZWUQwN1ASFPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JN8nhHVOs3qHIr+gKX4e8mV/qc/vbScv+iZ/8FEvEjY=;
 b=BYLUdhZlVq0E/pbMYBHsvUvfm1BSgw9u8zSgSlmYb47P8JW5SktXAZ1npinFnJca/0ssU1BavYDzj4gJ6kUWFDgKFCLQa8TfsOoUWCSuzJqYUK27yHIicZKv+Yrsun5CcD8jquAWqYAgJunbA14gdeFDD6V59T5ZqQqL/F4fEBc=
Received: from TYYPR01MB15615.jpnprd01.prod.outlook.com
 (2603:1096:405:291::13) by TY3PR01MB10484.jpnprd01.prod.outlook.com
 (2603:1096:400:310::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.1; Fri, 9 Jan
 2026 09:57:18 +0000
Received: from TYYPR01MB15615.jpnprd01.prod.outlook.com
 ([fe80::4ba6:4f37:7226:aabd]) by TYYPR01MB15615.jpnprd01.prod.outlook.com
 ([fe80::4ba6:4f37:7226:aabd%5]) with mapi id 15.20.9520.001; Fri, 9 Jan 2026
 09:57:18 +0000
From: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>, John Madieu
	<john.madieu.xa@bp.renesas.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Geert Uytterhoeven <geert+renesas@glider.be>,
	magnus.damm <magnus.damm@gmail.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v5 5/5] thermal: renesas: rzg3e: add support for RZ/T2H
 and RZ/N2H
Thread-Topic: [PATCH v5 5/5] thermal: renesas: rzg3e: add support for RZ/T2H
 and RZ/N2H
Thread-Index: AQHcgNiGYhiwEGfBgEGPuaKI9I9oWrVJXCsAgAAo+GCAAAebgIAACb7A
Date: Fri, 9 Jan 2026 09:57:18 +0000
Message-ID:
 <TYYPR01MB15615737AD71FC9DBE4923D778582A@TYYPR01MB15615.jpnprd01.prod.outlook.com>
References: <20260108195223.193531-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20260108195223.193531-6-cosmin-gabriel.tanislav.xa@renesas.com>
 <TY3PR01MB113464DB06BD82F3CC72B5B458682A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TYRPR01MB15619CB167FAD4042FE45D95A8582A@TYRPR01MB15619.jpnprd01.prod.outlook.com>
 <TY3PR01MB1134624FF7929D32670CA90F68682A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TY3PR01MB1134624FF7929D32670CA90F68682A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB15615:EE_|TY3PR01MB10484:EE_
x-ms-office365-filtering-correlation-id: b7793ef8-1bd0-4108-3d92-08de4f6579b2
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?89eEj4DjhNU1cLfdxvQGH0zKzTB0k5EZYCpXfeoe+Fa8dRe8rVTwGa46Ctvd?=
 =?us-ascii?Q?ugDuywMw3jice3bKK+b5y8TTEBE4Ccz/Knljus+uis36kef4HbvsAuuGPFfk?=
 =?us-ascii?Q?geOwyR9RFqy4bYu/ZNzrEVsGjCMLqvCag1p2aQhwi3deGQtFDb9JC5RiEgEA?=
 =?us-ascii?Q?zE8jtakXtcHEo6ox2WPSlfcZ3LWExuMp1xA6Ac9f3VGPqA2rXRfK2t9qKIrn?=
 =?us-ascii?Q?16+1XI5sG1W/XpiHXdL2UEydHHYNHAm4tD34CIu71/40wC7r2mONBZas7ULt?=
 =?us-ascii?Q?pC5BrluzyG93sVw3eSxI354PPcApruPccYQ86eiVu+O0AIa9VtbiQUASgowg?=
 =?us-ascii?Q?fMtRsem1U4ph+S1Tc91+oVCVzQ+hyggE5f4ckuxpp7oAN3DAf5JnHYw19lBY?=
 =?us-ascii?Q?Sbkkitzd3o9sQRtTEiE66HH/FCs4mQGUjos/MVTeDPz5cGXaT7w5b/JBKgCc?=
 =?us-ascii?Q?S46YyMB0hAFJA9egNlnmALYMTy43ZGuI1MQBJGX0PyPoW4JRZZ/nLyj31YrM?=
 =?us-ascii?Q?fg8OqvSH6nXZwkgEAqUT+y8alwf8zKFPllBQ++XfBRSQBlatHbuoenSlBv14?=
 =?us-ascii?Q?8FLcJME6SanCjBKf6MUfU2pmMw33Kh2hP1Im+LhQ1HgBcepAlUVRMYjDEa5t?=
 =?us-ascii?Q?M3boyMwxKqnJr/ain21SfxB9xOpXUSXdWgzbC5WW/AKc2fAtEViFBTldQjFa?=
 =?us-ascii?Q?JJEEFAhmRrGvgCS6MF+TFmiLgNjI7uBQRP16L1lixvE6TCi/aALotGBWAv0t?=
 =?us-ascii?Q?2hARnqrprGNy1d3EVMic5PH1yJ57/wkIL5xbDzRKZGpLnO/npSXsCJme/mOH?=
 =?us-ascii?Q?4SsHDC4bN4o90JwN9INZcVi8+dtJyo+4tba62pBAuP3jf7EX8poMDmje/QY8?=
 =?us-ascii?Q?F9mHoCjWjPL5hyT6xuxu4NpMEN+5cIBq2gc9Nl+Wit/iqGsNOMS5IAMCRo0D?=
 =?us-ascii?Q?jfzJoTLI1SGtrGmHfV6OG/N0ru+Q9SLvij550mEd84+U9P19oI4puK7/3K2y?=
 =?us-ascii?Q?Ys/R/6xRLptn8zsBiJx6GVGmyuND55dmCB1qipM/0ZpKZUQLKqwmOGWbfpLy?=
 =?us-ascii?Q?X2aXtL6Jr7tcBjhzWIQKMcD20A0GiME+2TpPjcYlXA1zpBbJdEvt5ZWprTq1?=
 =?us-ascii?Q?S0WdysebttiPYXaQ8gXDFsc4aLNDiu86R08//JiQHUMowBuh3fY6eDqb8/lA?=
 =?us-ascii?Q?wTY3wu4riD2ohEaYOF3r9JkSuJFw7sXWuGR2K6uQ7okGIN/1g/wJYZ93uSGc?=
 =?us-ascii?Q?i9EGlQQM7+uaPvaSMdrKEMxyvkQlqqdyAXAH/4X/RjJI93Msig9dhJQGutmd?=
 =?us-ascii?Q?/Jk6MOr5Ai7zHmQ+8qlMk4fYxQNPNIfTsHjWP9c6EVO95w1dZLbk0Y1rxRf2?=
 =?us-ascii?Q?jFQxuYQmDzC6vQO25LjYX1kIYeZOs849TRkYMvkletO5zaZh/YwoopLCapob?=
 =?us-ascii?Q?f5rdU1ui3QWIfiz1P4lU/ohnXOwlOG1p/HRCh/17oPIxcIPI3IoQlKEYTk1O?=
 =?us-ascii?Q?5Ia7YaE/ODFoNIOrIDN5o62lDkaGu/lZUWdm+sbX33cWC4DMZ2/Wqjt8Cw?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB15615.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QCPdWSCnbeHxqCUAZoNWKzUGyDcwNFsDc2AHRER2EEhj/yEC+MDDZiXx5jc/?=
 =?us-ascii?Q?zE34DNh/FP6/52cZIJ8RiOdAXasDzxxCaW6uP2UlwpQBU+u9dVYoJvCXNICo?=
 =?us-ascii?Q?LjwebtS+AmD6oACLUC74OY/7r/B2f7zIDdqaTcp4Ec/PO5+sih3H8HTU7aHL?=
 =?us-ascii?Q?SVNwtsApgNN6aYDIwhQjZyGdeHXBEFBjegd+rHSgCTn6rAS0ZZX9PF2z12C8?=
 =?us-ascii?Q?FBCtHiH67kE1f7xJorIROO8X7J6SlrBzK06p6IpTQykIZPG3uMdMDRMoeK0A?=
 =?us-ascii?Q?+vK74DNAjav/Lo0skDcLBCkJWzWm9plcIn7pdwHTTQxnec0Lm0qI/esRxbDQ?=
 =?us-ascii?Q?Ef0rMAMKHlCieD05QtpdpexK+vvQ1LguuH6odfwH2/vci85/fQLAftQYGma3?=
 =?us-ascii?Q?tAb9TerOV4TnfWrBr84Y0EeCFPU9cNrN8W5lBXQbvZy9nwf0a/9V880R8nRE?=
 =?us-ascii?Q?gXqhR1LZyHY+3X2nQGXCM10N0X7NrQHjMkKpbKvoaQRaH7Ypbf+1sIoz/rAF?=
 =?us-ascii?Q?QU73bHpc2na0cmFt9II4XfX7BAUTag4Bisl+JVo6fUaoge5qTnyuePJZA39h?=
 =?us-ascii?Q?ykG4MWMYN66OsEO9Fdi2toc4tyEFxLHXqDjw1I/KzFZks3ioasn5J1DCtDgo?=
 =?us-ascii?Q?wHUcgJ+XIh2xQn9SlRuK4eE1U3P2G0YQ1B06qFa4w8BEErW3iXFg/ucgt+Lj?=
 =?us-ascii?Q?28x6HDdQ6CITDBDuhlW8la9Pghgz8l3ijd/yPAkGooK28jw+krqvulEg1UvU?=
 =?us-ascii?Q?RchdRkTOXeTyWECAfzAGw20Cp+WiTvBJqLUtiHDnjVVN0VMmRWiBlbGmDcNU?=
 =?us-ascii?Q?EXy27Q43nr9uRKdlRYAMIgqrJe2Pf/3C8Zeq088YVr2pQQkZSXEh4M0vKjJc?=
 =?us-ascii?Q?nRXm0XIgmLrK/GEzuMwh+MyKhXsHciwk+/jFX71oPsWWoKFcHEw+6udlcHhK?=
 =?us-ascii?Q?I0o/tXPU2JMFWVdDLosDZxQ7Beh53IomRoQPT1ssPDlcFms3D2gz7rJ8RGvS?=
 =?us-ascii?Q?lunchSN6MidFCoYmHK0zPy2O9bDvT/PqBK7/JW1Lh9idFs5v5u8NhIMEIYfl?=
 =?us-ascii?Q?rPh5DDnbIpyEUYsbYLdg/bquY/EppioxjnPfpwvTfsgAPUALy6O1QzjOOU5O?=
 =?us-ascii?Q?9ygs53UU+DTt9ykdCsPyVJ+jh4Pgg5koXu+80big8jt37PMWRDAtLg1+tnsb?=
 =?us-ascii?Q?djJTtPJ8sbBN2xkLlGjhG0boRAa6S7xOAugswEHM8sK4ViSi7e9zvtpVYqkL?=
 =?us-ascii?Q?WFW6xYiHrJ8ZxvoCxC9TxKSQwdheWzWNFySTv4/ZEr4VwM2+BRrbAn/yIDWW?=
 =?us-ascii?Q?E9Ts4K4nPVpKVmY1sDKBR9mEiLKttBx95OXyCri8zb3u8qtRVCIIOFgpswlv?=
 =?us-ascii?Q?/tbn4JtTJqnV7ytvC8Rtk2BLntXRRUqUy2nJera8a40xxqF0At7gALafhzqs?=
 =?us-ascii?Q?+yrTX/4wO4tsl+URhw99rAFmVXRYMlRbSiP5lcuh4xWxLX/prHy7lPBrf65n?=
 =?us-ascii?Q?AvAtdOLC78ECxFuOOHicvDYEQ7QQ7YqNnk5p459u7GAcgXMC2+pRfSvoSsFu?=
 =?us-ascii?Q?8Fdv+5xoofeb/ecRUEMUQYM9nzKA20YCYnSCEWG/FwC8WUMiJxLQijvr7L0j?=
 =?us-ascii?Q?6slsydqzCi/df2BQf28XPC2i2FqX36xhOo8PB6U+xjMrjggYaqEM9GozxKhq?=
 =?us-ascii?Q?QlyVt5RFOSltavWmYBgRdc3fYWRZJ6TG7mfGQvtD56nZMUK48cV7VIbM5Khm?=
 =?us-ascii?Q?yyKJudOSoomtP1u3vNtzVVrTMvJEmlCxccJuQ6RnYHcKlJaLxvub?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB15615.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7793ef8-1bd0-4108-3d92-08de4f6579b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2026 09:57:18.5132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qzKpDHWB5EQc3DmqlV3CQ5p3JjvMQampzaPgaSiFlsZVjTwJdWEFy4nsCxVyYdI0Im5s54tGTXPMQ5mQ0NRIjD6wb+qjLe7Wo4743lMkO87xwI89C37FtsgGLm1WoBfn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10484

> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Friday, January 9, 2026 11:06 AM
>=20
>=20
> Hi Cosmin,
>=20
> > -----Original Message-----
> > From: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> > Sent: 09 January 2026 08:51
> > Subject: RE: [PATCH v5 5/5] thermal: renesas: rzg3e: add support for RZ=
/T2H and RZ/N2H
> >
> > > From: Biju Das <biju.das.jz@bp.renesas.com>
> > > Sent: Friday, January 9, 2026 8:12 AM
> > >
> > > Hi Geert/Cosmin/John,
> > >
> > > > -----Original Message-----
> > > > From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> > > > Sent: 08 January 2026 19:52
> > > > Subject: [PATCH v5 5/5] thermal: renesas: rzg3e: add support for
> > > > RZ/T2H and RZ/N2H
> > > >
> > > > The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs expose
> > > > the temperature calibration via
> > > SMC
> > > > SIP and do not have a reset for the TSU peripheral, and use
> > > > different minimum and maximum
> > > temperature
> > > > values compared to the already supported RZ/G3E.
> > > >
> > > > Although the calibration data is stored in an OTP memory, the OTP
> > > > itself is not memory-mapped,
> > > access
> > > > to it is done through an OTP controller.
> > > >
> > > > The OTP controller is only accessible from the secure world, but th=
e
> > > > temperature calibration data stored in the OTP is exposed via SMC.
> > > >
> > > > Add support for retrieving the calibration data using arm_smcc_smc(=
).
> > > >
> > > > Add a compatible for RZ/T2H, RZ/N2H can use it as a fallback.
> > > >
> > > > Reviewed-by: John Madieu <john.madieu.xa@bp.renesas.com>
> > > > Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
> > > > Signed-off-by: Cosmin Tanislav
> > > > <cosmin-gabriel.tanislav.xa@renesas.com>
> > > > ---
> > > >
> > > > V5:
> > > >  * add arm-smccc.h include
> > > >
> > > > V4:
> > > >  * pick up John's Reviewed-by and Tested-by
> > > >  * replace new macro TSU_TEMP_MASK usage with existing macro
> > > >    TSU_CODE_MAX
> > > >
> > > > V3:
> > > >  * no changes
> > > >
> > > > V2:
> > > >  * no changes
> > > >
> > > >  drivers/thermal/renesas/rzg3e_thermal.c | 27
> > > > +++++++++++++++++++++++++
> > > >  1 file changed, 27 insertions(+)
> > > >
> > > > diff --git a/drivers/thermal/renesas/rzg3e_thermal.c
> > > > b/drivers/thermal/renesas/rzg3e_thermal.c
> > > > index 97c4053303e0..dde021e283b7 100644
> > > > --- a/drivers/thermal/renesas/rzg3e_thermal.c
> > > > +++ b/drivers/thermal/renesas/rzg3e_thermal.c
> > > > @@ -4,6 +4,7 @@
> > > >   *
> > > >   * Copyright (C) 2025 Renesas Electronics Corporation
> > > >   */
> > > > +#include <linux/arm-smccc.h>
> > > >  #include <linux/clk.h>
> > > >  #include <linux/cleanup.h>
> > > >  #include <linux/delay.h>
> > > > @@ -70,6 +71,10 @@
> > > >  #define TSU_POLL_DELAY_US	10	/* Polling interval */
> > > >  #define TSU_MIN_CLOCK_RATE	24000000  /* TSU_PCLK minimum 24MHz */
> > > >
> > > > +#define RZ_SIP_SVC_GET_SYSTSU	0x82000022
> > >
> > > Maybe add a comment mentioning firmware should support this index and
> > > the otp value is stored in
> > > arm_smccc_res.a0
> > >
> >
> > The fact that the calibration value is stored in .a0 is clear from the =
retrieval code, let's not add
> > comments where the code is straightforward.
>=20
> If you have just a0, then driver expect a0 from firmware
> is either error and OTP value.
>=20
> If you have a0 and a1
>=20
> Success case a0=3D0
> Error case a0=3DSMC_UNK
>=20
> a1 will have the value from OTP.
>=20
>=20
> >
> > Regarding the firmware support, it's obvious that the firmware needs to=
 support this and that the
> > values don't just magically appear, no?
>=20
> How do you share this info to customers that they have their own firmware=
?
>=20
> Eg: Customer firmware is using different service ID and driver uses diffe=
rent one.
>=20

If you think it will help customers, we can add a comment like below.

/*
 * SMC function ID for reading TSU calibration values from OTP needs to
 * be supported by the TF-A firmware. Calibration value must be returned
 * in the a0 register.
 */
#define RZ_SIP_SVC_GET_SYSTSU	0x82000022
#define OTP_TSU_REG_ADR_TEMPHI	0x01DC
#define OTP_TSU_REG_ADR_TEMPLO	0x01DD

> >
> > Let's see what Geert thinks.
> >
> > > > +#define OTP_TSU_REG_ADR_TEMPHI	0x01DC
> > > > +#define OTP_TSU_REG_ADR_TEMPLO	0x01DD
> > > > +
> > > >  struct rzg3e_thermal_priv;
> > > >
> > > >  struct rzg3e_thermal_info {
> > > > @@ -362,6 +367,21 @@ static int rzg3e_thermal_get_syscon_trim(struc=
t rzg3e_thermal_priv *priv)
> > > >  	return 0;
> > > >  }
> > > >
> > > > +static int rzg3e_thermal_get_smc_trim(struct rzg3e_thermal_priv
> > > > +*priv) {
> > > > +	struct arm_smccc_res local_res;
> > > > +
> > > > +	arm_smccc_smc(RZ_SIP_SVC_GET_SYSTSU, OTP_TSU_REG_ADR_TEMPLO,
> > > > +		      0, 0, 0, 0, 0, 0, &local_res);
> > > > +	priv->trmval0 =3D local_res.a0 & TSU_CODE_MAX;
> > >
> > > Do you think it is worth to ask firmware team to return error values
> > > in a0 and actual OTP value in a1.
> > >
> > > So that driver can check the error code and propagate to the caller.
> > >
> >
> > If we do that, we will have one more variant to handle here, as we cann=
ot make sure that the TF-A
> > running on the board is always the latest.
>=20
> Mainline will use new variant, that can have both a0 and a1, if we take t=
hat route.
>=20

Mainline code will be backported to CIP, and customers might try to
use old firmware with CIP. Not adding another variant is the better
way in my opinion.

We can wait for Geert's opinion.

> >
> > Right now things are simple as it's either supported or not supported.
> >
> > If a0 is some error value, how would you distinguish between an error i=
n the new variant and a
> proper
> > value in the old variant? Both cases would only populate a0.
> >
> > Also, I'm not sure how much use we can get out of a TF-A error value.
> >
> > The error that TF-A already returns in SMC_UNK =3D -1, or 0xFFFFFFFF in=
 u32, it is pretty standard for
> > SMC calls and the probe() function already checks against it.
>=20
> The OTP value can be 0xFFFFFFFF, if it is not programmed, if that is case
> How do you distinguish error with respect actual otp value.
>=20

From the kernel's standpoint both error case and an unprogrammed value
stored in OTP have the same effect: missing calibration data, cannot use
the TSU.

> Cheers,
> Biju

