Return-Path: <linux-pm+bounces-37399-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B74C33DE2
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 04:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5300218C4F54
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 03:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7902226CE32;
	Wed,  5 Nov 2025 03:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="a/Vz63RH"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010033.outbound.protection.outlook.com [52.101.69.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EAD25EFBF;
	Wed,  5 Nov 2025 03:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762314201; cv=fail; b=LQi44WBG7CygX+in72wqppfuNTNrT0VDoEctWeYt/LFSWHBsqvJwbzYDvEI6aDm0fXbPyWjEiPeUcZuvYJgtBzs89CftxJ25S5WLYfpjfdX8k6LOR8F6nJ/wIlS+cCzbVO5Vq2nKnSqgKhf07vU37Wjt7+TlwSqRpokGxc4u8Qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762314201; c=relaxed/simple;
	bh=kyZzm//v74YpuRusr2SKLuuT4wHjK8Ti+Sr6e9dPvGA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B/3OETR4BLsRS82967tiDFrBRGYmKFXhi5XFvs8WgPP3MeTh2kYpB3QJR0EFdwIjzIhd7uDIPZtVA/GslXY8TRdpapfeW96MfDBcXgUCUjepAJkKu3888vWr5DAbh2GTe7FSTyl7koe2Y7AqOVqfBt9c1DesVAig1R+auhOullw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=a/Vz63RH; arc=fail smtp.client-ip=52.101.69.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VQxuWOqX0kGmwGpX5hvFQDL0zhDbtydyNfhSqDJr1qYgU5E09CkulMJbv7KnqvKv3ZrRaCF4kP4ieq9ub/ohiq/61GNlV9UB9MosXfZN6MF2hjA7QOHduOCR8NBCnTy6DchwdBln3WEUwpCUDGZtZQefTTkQRbo+K18REIUWEh4zIAoyV+Oww7qWl2nNnJT8PPIAmdsjfT46CZmH8nJtytLCm1fXYIrC0KjN0IvllyltP6+6S8ngzq/DhHV0yu5dhK22ykm1x/wqTNSHHo/FFdWeytmxE4twoNMHv+5QzSk959PsJjb5P20X2akQMYfOZGij/90Va6c7asG379+MSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPQzE0MMqwfos6WG+5iC1UERJgx86nXlGq2Kz8LWF/s=;
 b=kCVjfisp1RxIxVHm9r6WYN8IWhbaSRt1f1z6XO9ijZyUuM8dPuJofD91AZBa6Te7AT5sdSL7wBwCnuGiy67PsSY4pTO9+PQTJvt+LAROS6YzAnDL7/DRbTj3CfyZkXczJ6xnxXzHpPO2J2z0sHqKLEMtmw1CwNsP01/x7thTg6dp1NaCzi/9eQK2RpCUwle4/UgvJKVinEyP+Ya8ReFRaziHrJmscvkKI/a1SRZczMtWA8GmK730K14ail32+bCKSPICt/h01QAtgCoXzn/P7l/fIMfuMF08eIEYGjGAMJJLq9D6FWQUBiXi9YDheQSPX8Mr0wEnIGso6PhNrzeqag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPQzE0MMqwfos6WG+5iC1UERJgx86nXlGq2Kz8LWF/s=;
 b=a/Vz63RHqqFLD6EMNsuM4gPH0QUyPkGUtbT8NaLrFvOhxpo+Dr8VTIdISasYF+FzcuVK5tvd8zuAtWfFV0cYtBTR1F81uN9kxjo90xIickkR780swq1tUQFk/oN67zOxZEoYXeQoufwPqzKSFa09l7Bpb/zMiIn1v/EJKwcBb87eo7wvVXnxuGlRqZMIVXH2HJ5BDRha11RUTjCT9sHxTZ9xTN1uK7sQpZZxUUai9Xrp42W1l+q4NYSl2BpzJu90dwjaEhOfgYHD0qDOXNM8XyVOGDGrPGqVUcvZZPvwkyFV48fMfZY85yafn+wpqSAqTucMdt9vQNdJolknBPUdqg==
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by AM9PR04MB8193.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Wed, 5 Nov
 2025 03:43:16 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%6]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 03:43:16 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: John Ogness <john.ogness@linutronix.de>, "esben@geanix.com"
	<esben@geanix.com>, "pmladek@suse.com" <pmladek@suse.com>,
	"senozhatsky@chromium.org" <senozhatsky@chromium.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby
	<jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, "ryotkkr98@gmail.com" <ryotkkr98@gmail.com>,
	"kkartik@nvidia.com" <kkartik@nvidia.com>, "fj6611ie@aa.jp.fujitsu.com"
	<fj6611ie@aa.jp.fujitsu.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial
	<linux-serial@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
Subject: RE: [BUG] Suspend failure with nbcon + pm_debug_messages (Linux
 6.18-rc4)
Thread-Topic: [BUG] Suspend failure with nbcon + pm_debug_messages (Linux
 6.18-rc4)
Thread-Index:
 AdxNWDvvSHwf8ruwQWK/6o5sXxny8wADMeQAAAJkdwAAAV1ngAAAwrYAABqcaoAACG+3oA==
Date: Wed, 5 Nov 2025 03:43:16 +0000
Message-ID:
 <DB9PR04MB84295A352C49B093F4125A2F92C5A@DB9PR04MB8429.eurprd04.prod.outlook.com>
References:
 <DB9PR04MB8429E7DDF2D93C2695DE401D92C4A@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <87tszamcaz.fsf@jogness.linutronix.de>
 <DB9PR04MB842977523C92FDE8AF4B714A92C4A@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <87qzuem7bo.fsf@jogness.linutronix.de>
 <DB9PR04MB8429F50811DDC648DD8A7B8792C4A@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <87bjlhz8pw.fsf@jogness.linutronix.de>
In-Reply-To: <87bjlhz8pw.fsf@jogness.linutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8429:EE_|AM9PR04MB8193:EE_
x-ms-office365-filtering-correlation-id: 13a255ae-a75d-4ff5-0a0b-08de1c1d7440
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|19092799006|366016|921020|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?yrnlSvaDHp2OufGHyAVWUBY/D8vEU4rjyyLQLII0FQCCs4H604sfoNj7PMnG?=
 =?us-ascii?Q?SK5lGMGt8JgsvqYzxq3vPxhv04nSY7Q1YaL3eqae4pD10vNDJ4DnG1alhc2T?=
 =?us-ascii?Q?VBBBZtsND9WdfSkw+FsdFG7RKLoMY5Sj0O1Ti+QstuYTlsAR4yuWcFqILbRH?=
 =?us-ascii?Q?7HOZo5tMwmQ4iZIsCnjiOy7pz5DU5QxpWNTqRcJkkVm/LMf4hEeUaYN8+5EX?=
 =?us-ascii?Q?K3CSD6liA602WvMHt6GL7Nv2V9MK9SW4w2IGnZxnUEGmA7TaLLdwJd1HCNBn?=
 =?us-ascii?Q?z5OZIqgwHZH+8OE0YAsnVCLOPPtlOVRqNnRB+pBl1VLiD1FDN6F9wQHpeMSD?=
 =?us-ascii?Q?SJjTZkNZmfJ6gQwz7BLgM4uujwhMjGvmoLLQzjHnTiZrijxpoW46MnvVC5Jz?=
 =?us-ascii?Q?JjUkmoOJ6dsrzAx/WnGdWMa0C51hNjUj4a782he8LU1qvFnIE0In1JEfD3sQ?=
 =?us-ascii?Q?n9SOtRHcBpTPquHCV/zyJJg4UKHuPNmy1ErO1KdRQFK/iAofR8y0Hzf+8iV9?=
 =?us-ascii?Q?pF7yGtunIi+mTmGoIGLOro29U9n8X9Rwkf+UAMjN3e76agIwFOpxQXXqmsmS?=
 =?us-ascii?Q?m0QD3htu4cGMU6lW7Oxi9DBqXtwZYLskpJ60JtoCEO9ZwQX2Tl3qT2LOvyxl?=
 =?us-ascii?Q?lNTqPndoourNiq9CXd/+NxReJV0g/LRx/q+anjJEBdJDzJ5G55Wb1o0hx6ap?=
 =?us-ascii?Q?VsCJSKEaT9F65s3UnKuplU/C2DMc7PDKuRyeU3Gpr25XiIazQoeyFrFkoyuj?=
 =?us-ascii?Q?dingYJxns4IKR6bD47H8RjrZDuDIMGsPBN6msq20BvPtC2ctC5F0WREVv+eg?=
 =?us-ascii?Q?VCQHpXMx+oL81goALBizeHf1AAmC8WsoQL5ZCdyWEwcvttka3k//f/l1kjaM?=
 =?us-ascii?Q?fm3R1y4ztdZxmeuzX5hrhE/fP2r6oRTyyEfQUqWYfsnYLUsRBRuYp89tclzk?=
 =?us-ascii?Q?lUJNobPld3Tp+W8Z60EzNXjV7HF349Bpt5l74renBp8NfaaIHQb94m1RzsX+?=
 =?us-ascii?Q?9tlO3Lo9OU3bYBhgAXGANIHJCFrG9O38OqVac/0SySJtF/2qw+gheYIm6rEm?=
 =?us-ascii?Q?US7FBJc19M41zswDIfXhrbaaU5X7Kql+roTEtyO78aCPOm6t/uGBsyVbcZ6c?=
 =?us-ascii?Q?8NzB1XospbVGTgIgt+veZGah8wfuplMXHKy3FOTGBg2+C0qixl5VeZwqPz70?=
 =?us-ascii?Q?1IXM8i0OC4NkVwsrCDJv7LBpDFarsNj8+Z4knYYoB5OMChXlw8Vxv8WY9gmi?=
 =?us-ascii?Q?T/Ii9pr1rFXuOmxkQeWMjIyheHoUOipVL1BN9bd6MRfXKHgjqPdpPflm4d6f?=
 =?us-ascii?Q?rb34LDKMxG6k6HUwVuj4EQpLsyGshCD242zg7ahEHyNEfHB9sNmKSxP96Py1?=
 =?us-ascii?Q?TH8GIX6CNkE3qA3Fn+zcMQ+d0zWDVOPpPIdYjcLeaUZDvnvfaOFGJffCPsr7?=
 =?us-ascii?Q?30yFjuZRjG3e0olLY43KQ55DtWYwbDFbyvqdXi7hwKLuKe+qBxBLjXQ3BWIy?=
 =?us-ascii?Q?O6p0LdYi2D5yUjg+NOmoSn4QcZ4sX/J4vNKy08evMIUr84SQBESJ2/s2hQ?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(19092799006)(366016)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mpvUj/lK7m4Nt6vHMUKTChlLYAzjxwn/QBRbeg/pU1Gbe9Iz1SvO8UzKyIE3?=
 =?us-ascii?Q?GEKo6JEflKgcktRpMqh3HFL2hd1yJOfyIsQn2zylI44UZENHxSsnVRoDVhtU?=
 =?us-ascii?Q?YnjLq53gUl3UEKc5lgmnIyJ1+gOl7qqy/AdtWvBkfNV+f42ZmzC8pPhOxC50?=
 =?us-ascii?Q?n78PbNMYC6x16S/hubvIpT/znspN9erMbRoCFCruAe662mYoRoMjXhbhvBos?=
 =?us-ascii?Q?1N0qwM/dq4UIE7Jxmx0Ez4EF71Jlgq21vtTbeNYEC+fXah5wLsiOVHU7JT8E?=
 =?us-ascii?Q?U2BteIdKH3XXjOB5oaavYUxWS9NUBd5HzNWHdoWchd+KRwbgZ6KMSHs4CwEG?=
 =?us-ascii?Q?ZiXZzAbACiBdhh1HguBizHVpVUEe7PyLoaLtjeEifGcnPzt726RN0SGTAytg?=
 =?us-ascii?Q?HDIdBzb5kxMfIswMs23NFAhR0ybF7Oek8pVaKRb++5w9JdDWkFtR613vas2I?=
 =?us-ascii?Q?uxDumh98oF9YoyPXwabHTsAau48cn4nfO2gGhz/LsiywyH53xTIIvfLA5cL6?=
 =?us-ascii?Q?exbDiAiMz7u1WlyQTqkadn81q50qXiaTUQb3CkTsI9TJwAfqgnnP0objhgWr?=
 =?us-ascii?Q?4aOGrcIqbsFeudpRgentT+aCe0rguAvyJrgFetikl9XpAbwnx3mFxSR649Vr?=
 =?us-ascii?Q?zow+FvdsD2BnY8p5RTKEx7Fz+7G4gxvQ2YwIcP7CCoqm7mvK0BhbtYJ/EXM7?=
 =?us-ascii?Q?E/TrnHpyuJhrykm3DjHiMxkFJ+mlHmMoWyLAVbb7ir2DiXyjgqUFzCcRui6h?=
 =?us-ascii?Q?R0jJz+r7/RpDcl8m95KtgnPOlZ+F1HDYWb2Mrrwe11lSCHg7yAYHDBXqa6Io?=
 =?us-ascii?Q?adrjxZOBhZXTvHle3afX4FI/gE5rONNBb6jsr0jSO2/NCQpONfiswwdflRMm?=
 =?us-ascii?Q?Cc5namdW7L3SwL9cjCpKDoZWQ/RiOQWi+7gbblFr5utXM0EtCauPcus3VJea?=
 =?us-ascii?Q?wDa4o1SPmRJGDgFXW80OOFWu8jWh3iXgnSunDSA6CmMwZ68DAw+JRLejZr2B?=
 =?us-ascii?Q?I1r/UO3HD+ZLyQlChBE5XwTq3SNUnxKmkHoK3MnTf9anUdg/HLLd2SR7CZD0?=
 =?us-ascii?Q?nR4Stk4w4ZsvNIHPW9pVPWt+TnaoQZTe99Nl1g6HAWOBhKUv87gxrHAzw3hG?=
 =?us-ascii?Q?sZIKVlcoH2g+akbvda40DXV3YzCwb1+/Gmpj6kPRGwo85CRH3bu5Rr2OSm4M?=
 =?us-ascii?Q?pdX/NtmmqxtUv3O389gjAjGzmn2YgHdtkwlOASenz84exV0/GyuIJEW/0Kki?=
 =?us-ascii?Q?bI4whL9ZwHSTc/hHRj0vGN9ifFvPM8HcHx1+LJKQeL8uGNb37bms79qpD3FS?=
 =?us-ascii?Q?ROKsEHDTqE7AkXHGOWpUSeLPZ7Fh+kJktW5munX5B/m9pIJyhekeeb5VYipK?=
 =?us-ascii?Q?ZMBWX+1enX+S0BJf9QcFXz/C7SlFJAQNfk7ihBVXSvHsSd/XHsALauhFuQ58?=
 =?us-ascii?Q?HEQYCfjjhExShUzoK/K3sKIoafB10wd8J5hp7CKEBzJhLbPoMbKssUG3uArN?=
 =?us-ascii?Q?AW+qGLM4tGLtOeIRW9BGgbmXXD/gYr/f6p7uz/gqSRX4JWrA2uAislvt/i7s?=
 =?us-ascii?Q?Zf4zGSPsPWwuVeibPAA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a255ae-a75d-4ff5-0a0b-08de1c1d7440
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 03:43:16.3027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dh1xOyukU3Sxy/rTlwNp1NirOTp1pTNQknRFD1UxpxupLnXWYNRgxRKtvHICHMeAWyvcUd1c2maqdIjBldruFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8193



> -----Original Message-----
> From: John Ogness <john.ogness@linutronix.de>
> Sent: Wednesday, November 5, 2025 7:20 AM
> To: Sherry Sun <sherry.sun@nxp.com>; esben@geanix.com;
> pmladek@suse.com; senozhatsky@chromium.org; tglx@linutronix.de; Greg
> KH <gregkh@linuxfoundation.org>; Jiri Slaby <jirislaby@kernel.org>; Shawn
> Guo <shawnguo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>;
> ryotkkr98@gmail.com; kkartik@nvidia.com; fj6611ie@aa.jp.fujitsu.com
> Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; linux-seria=
l
> <linux-serial@vger.kernel.org>; imx@lists.linux.dev; Pengutronix Kernel T=
eam
> <kernel@pengutronix.de>; linux-pm@vger.kernel.org
> Subject: RE: [BUG] Suspend failure with nbcon + pm_debug_messages (Linux
> 6.18-rc4)
>=20
> Hi Sherry,
>=20
> On 2025-11-04, Sherry Sun <sherry.sun@nxp.com> wrote:
> >> Thanks for confirming the fix. I will make an official post on LKML
> >> with the patch today. Since the i.MX nbcon-driver is already
> >> mainline, I will CC stable. I will CC you as well.
> >
> > I'll keep an eye on any fixes you send later and verify them if
> > necessary. Hope this fix can be applied to the mainline and the stable
> > tree ASAP.
>=20
> Even with this patch [1] I am able to reproduce the problem on one of my =
test
> boards. I am using the following extra boot arguments:
>=20
> no_console_suspend loglevel=3D8 initcall_debug
>=20
> And then:
>=20
> # echo 1 > /sys/power/pm_debug_messages
> # echo mem > /sys/power/state
>=20
> This generates a lot of output and leads to the same suspend failure. Thi=
s
> may be due to the out-of-tree nbcon-8250 driver I am using, which introdu=
ces
> extra irq_work usage within the driver. Could you please try the above bo=
ot
> arguments with your i.MX board?
>=20
> I am wondering if blocking the queueing of irq_work during suspend should
> be generally implemented rather than just printk avoiding it. It also see=
ms to
> only be a problem for ARM32 so perhaps it needs to be addressed at the
> architecture level.
>=20

Hi John,

I tried to add "no_console_suspend loglevel=3D8 initcall_debug" boot argume=
nts and enable pm_debug_messages, i.MX8MP suspend is still ok  with your pa=
tch [1].
And please note, i.MX8MP is ARM64 arch.=20
I also tested the patch [1] with the same settings on i.MX6ULL(ARM32), same=
 observation with i.MX8MP, suspend also works fine.
Seems the issue you observed here cannot be reproduced on i.MX UART as it d=
oesn't use the irq_work, and at least per my testing, the fix should be add=
ressed for both ARM64 and ARM32.

Best Regards
Sherry

>=20
> >> [1]
> >> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi=
t
> >>
> hub.com%2FLinutronix%2Flinux%2Fcommit%2Fae173249d9028ef159fba040b
> dab2
> >>
> 60d80dda43f&data=3D05%7C02%7Csherry.sun%40nxp.com%7C7988cfdc84f64e
> 9cd1d
> >>
> d08de1bf8ab21%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6389
> 789520
> >>
> 47428481%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYi
> OiIwLjAu
> >>
> MDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%
> 7C%7C
> >>
> &sdata=3DyPKOGyd5wAECK8HFz3bD09vLva6jCPAQyLZPNbnG%2Buk%3D&reserv
> ed=3D0

