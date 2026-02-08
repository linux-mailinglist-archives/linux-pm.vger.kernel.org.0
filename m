Return-Path: <linux-pm+bounces-42259-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHpoCdpiiGmapAQAu9opvQ
	(envelope-from <linux-pm+bounces-42259-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 08 Feb 2026 11:18:02 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F82F108564
	for <lists+linux-pm@lfdr.de>; Sun, 08 Feb 2026 11:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC3C23009FA6
	for <lists+linux-pm@lfdr.de>; Sun,  8 Feb 2026 10:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607D52F28E3;
	Sun,  8 Feb 2026 10:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="fuoXs4l4"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010066.outbound.protection.outlook.com [52.101.228.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F2286277;
	Sun,  8 Feb 2026 10:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770545878; cv=fail; b=fjbJDxWiO+A7MeHKB2DCTgfVohnMgFp8V1KaJYqIISBry09PJEtM033hMtZkHNBYVjOkf76PIRDrCsoSJR58Vu6g0t0Lp0n2Dia/yQGKVGyILZcy2LSJg1Knw1GQy/uguQDcT8ocdKn3/KD6g6VvAyQgXGMCX4zqrC3mN7c9sQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770545878; c=relaxed/simple;
	bh=MUIGigF0E3IjyGIZSebupGVVe5FKX4Obckrnz1c7mUE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hZ7Tp5ot3Xz08ZVkWqbcg6cYZZRjxqPE2hgqMFNSCFuUjgWVCuGkuFrg94gdbwHxssb3Yy5d3/jMCS/orepkdUIbFUXyroshnrIqnkpol0xaJyHeIX8w3VHhqaN1oBJ+Qgd5yrRFwlvIizcO4lW7TwwtdZw4iw/GmDgUuZ6xEcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=fuoXs4l4; arc=fail smtp.client-ip=52.101.228.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a8mLkXVm7/2ZvRU3qCXcQueJFoBWe+l8iyX0HVf7UNYYzBEnMyZyMw4Wt3wjighE4IHDi3FUWYwEk9KNu9/dRegyFkEJo+WS73sCLh7I3+vN39k/FIpaP9Xp4X43tAAZQd5FL4iH2oZ1yMtnfS2/EomkuIs8Gsr5YbFzwHKQ3zsG9A5n8vO102MSj2Rbfs8KgejmU8x3fgs5xwzcNKfMEULmMrjL+Nwg6WbyHOihHdrXijpWifpbmCgK0/pO+z9+uw8jPaJ51MKz7ZUrdI05aaobfd0K8HUjh6qOtCVjRvlj3TuUBLISgijeF4BzpeJIUIgmuSSA7GaVml8bV9zi7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFD60ecOcEKaXHXykg+FO20hesvoZK9fVa/i0kBflY4=;
 b=eGTKneP1+YTZgOLHwp8bqWz8wWe98cf3W99SBUkitHydPkrD+zU5WtFQtBZ4h0/kDZOXf2vhLAyWOTSMR8SWToTLZmwdKFwC293S1gWvf8VOLDbGxz3EMgMHKkQKoxJTXnGwkcOeqZidg1rZV36lggnalGe6WBZgmppIi6vXuzJzEvIqCL12vGw9403eFdEjI3Bl4U3U9XVzEK6W+zgD+1Oo4ZoTEsyHosIL1KnBV/8Y6QuDTjqKyVEe551Ty3zYdK6yKP9DZueThiNMIwFMwmeGd8FcUvYL/ajUZpJ9FyCx6LJSr9tdMSgc4rVaVBK4ocGULhZhsVE6Cgm+6fh+/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFD60ecOcEKaXHXykg+FO20hesvoZK9fVa/i0kBflY4=;
 b=fuoXs4l4e/evWNopx4nCXZy3u2EHBLxl18DY9AhQLiiC10sLsVCyIx2zb6rt8OfzErJeF4bbJt0KKDyU7VqmiK7KHwxVKbXdLtcLi53YiKlr8pTgvwQWP1+IBar/DW14siVta1bkZEkqx7yqPxabfKYzELLUwUOb76z79A7xBIc=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY3PR01MB9667.jpnprd01.prod.outlook.com (2603:1096:400:22a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 10:17:50 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9587.017; Sun, 8 Feb 2026
 10:17:45 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: biju.das.au <biju.das.au@gmail.com>, John Madieu
	<john.madieu.xa@bp.renesas.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
CC: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] thermal: renesas: rzg3e: Drop unused kernel-doc comments
Thread-Topic: [PATCH] thermal: renesas: rzg3e: Drop unused kernel-doc comments
Thread-Index: AQHcmN1Z6UkJ4av95ECQBJc8l9MOQ7V4ldLQ
Date: Sun, 8 Feb 2026 10:17:45 +0000
Message-ID:
 <TY3PR01MB11346FF4FBB88C666B2DA2AC58664A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260208092848.5313-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260208092848.5313-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY3PR01MB9667:EE_
x-ms-office365-filtering-correlation-id: 0616cc92-bfaa-4998-3dfe-08de66fb4da6
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?PyjzDGpigo7nnWSBHmHPlbxzS1NtXzBOljqNsl7FeNbwnfQMNswrOG18dH0j?=
 =?us-ascii?Q?ZYY4by3jrWWmxo8jpGlh80H2HG2Qc1lefCapIlTHIr1EXQn1kqq67+woN2Lf?=
 =?us-ascii?Q?FNwN/6k+z2WO0Qhc7K3EvcV0zMAK4EOuvouT0+UJWa0N1DGu7TO49eLRPViT?=
 =?us-ascii?Q?Mc9YY5QWYLEcaWlEf33Ah0+zs6ggolwW97mkJ4xOfQOOZ9e7RCECTAWekTwq?=
 =?us-ascii?Q?k6BL5ApOHJ/tkDTb69YPAPgqu73O6Cf+q2XkyhzJvX7ofvfIFt99KSvveHSD?=
 =?us-ascii?Q?eLuRLNrcu4Pi2IT3Bepxn3YOYMrrrm8Ou84XD7Dnhy2zqctQiMLW5om/xzOe?=
 =?us-ascii?Q?ibsGrswoZ9Ls+vYis9AP6ZWEGNqdIZnAySg0pZLABsiUb6PNRDP3Du2Wnbg/?=
 =?us-ascii?Q?yASrKd6jeRrSHpoG+aev2quJrkhO1jASk2ElTwhsTj3ShfQVTpzz6TKYG/sY?=
 =?us-ascii?Q?VOIpyVAvbkjtFgcGYsRHcpluqY5IyWg8UJ1PrEHbVMbTkNuFm7t5lNui7Lr/?=
 =?us-ascii?Q?20+mTBuNwqYYrtAn+YQVcaKtnaLpxYMK1FdDPibkZl0Q+oSPHkovL01rOO1A?=
 =?us-ascii?Q?IZtQC2uIwQWIPVxzwIszlsCOqsJekMls6OdaCjOsMdOeIh+P2O8SDqmsaCYl?=
 =?us-ascii?Q?fjTz1CECJunpqbfwybAsRlpttiNVJhZThutPx5af7vvY84xDl/cZagRxVE64?=
 =?us-ascii?Q?CDLSYcSfNq/zeK4GoIQaDhyJjskHyscyfu0A4LTP9jnsoepD2EggDVzmbPuw?=
 =?us-ascii?Q?whyetVwCSuaS62DXVx1k5UfjqjnhAPn/r+6UpmocrqudH0bes5h9ZcPBZxLP?=
 =?us-ascii?Q?yAs4IfXbxN8efK4yWc8ItVME1Rz2V0BYs11J2+fWexlrC3HGqcQgsH+Ucat8?=
 =?us-ascii?Q?Kox92Lg5kLh0AYrn6mGAhhV8qGJNvsBmTYvpP74+jBMeHMbkSyvbLXmSVqyj?=
 =?us-ascii?Q?htNZHmXnyYx7ln/QBE4ShvlHHGt3ZGZjO4Sjz9AFbsb3VmFxw2OzcDEeGN9W?=
 =?us-ascii?Q?xn81SDXM912xOz3GeABC8K48bwsxvZDYekUCMidGKbkQATZ4MgG2DYv448w6?=
 =?us-ascii?Q?q0oNnBVPIAWLiXGwVbk52KHMDU1mEKTBODp8IJMU4IIpW6+aOTedZXBI+kV8?=
 =?us-ascii?Q?fZtSqOOZMLhpmUEbLnUD29xZTJ/gLxR7uPhLxa0xWfVwo10zwmV6dJpcxpde?=
 =?us-ascii?Q?DolfpjSW1yLPSzcpgDmy8LTLN21+33uVCZjToW0nqGuN0ZjtMNiBVhp0Hkza?=
 =?us-ascii?Q?hWsLv40sQHz1/j5dWLIe0F8cLgqZSQ+GftMwvACMoaptV7DqgD8/lkgldwnq?=
 =?us-ascii?Q?HJpO1JHySgPf145TwXdLMTDj3M0CwEA0ZSoGD9fjYyNi4sIKO1+YurUO53Ih?=
 =?us-ascii?Q?c1UK+R+EbOlzjlz4C6Wkw32hW5yAYFjIzVlrNyJw0pL35K7PX6hTI/d/xEHc?=
 =?us-ascii?Q?51hnduRnSOUZ75AAF8knHqt2uEnz3INml4EfFQU0R0PXRMb1GhixcZqpbbCI?=
 =?us-ascii?Q?FrNtrydmA0uCj6LEa1JAFAJhmc+U+gnndtz+DxEkYh5V4Bz6twoonwy0vHeU?=
 =?us-ascii?Q?NwkXiWquTEr7U+ROke77YTjlZ+e1LHkHFKEOO+Bvc9VC8U+A7K3itz8ivKSl?=
 =?us-ascii?Q?A6//5QvMaIq5nKmZeYAeDO8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?g7kVL63CkxAnLdDPQeXV0/LNR+RmSE2+y33PIkuBMQZXNHri+RQZk4YFdLGY?=
 =?us-ascii?Q?lijzBO00B5yBdp64qsdTKEst3TYv/74l5b+JLDfdrjksfB8atAN6vx5ppUjn?=
 =?us-ascii?Q?sUcb1MCyQk4JLUDY5VSw8p+/nzlmtNgNRnV9IZJyq9eDsAA5Mv/uhpmpt2zW?=
 =?us-ascii?Q?zCBlQjS/AZofToDt8pMC7ErS/LVjRZOEMN5KQKlvBr70yWkY75pqT5Vr5I9d?=
 =?us-ascii?Q?v7n2hZWD0nMcROjoe7ozadVMvyG/pBduOMlOR0nvDXfMMy8raY3fXWIA+9Qe?=
 =?us-ascii?Q?99ATzUrDEcBJd9zRj3Sh76GfRPDmkbQDqhsskkHQV7+WGNqyiGSkSAYm05np?=
 =?us-ascii?Q?96JVQzjOrCdXUE00xuzqZpNNc2Xkquq+6ntQgwgNY1C9oHXful466kZLOawL?=
 =?us-ascii?Q?R5I9FtEiEOCINBTN6/yVnNuxmfJYgv04lGb+V+9KldOeBXOym8LdRP2SAdlx?=
 =?us-ascii?Q?WkUyng7OApL3a4sxLqiqFO2IjdSnGgTDoNyn8znB0BPvF2RrkkY4v9921SFG?=
 =?us-ascii?Q?FvoLe4z2T+AaqlEXzgkeeZd3XITwinN3eceXHwSvvj5rb6V6kr9fRzuOjpSH?=
 =?us-ascii?Q?ZdB9L0fnFkzxUvR7oytXGe0UThE4hCpAo0Kp6cGYXZH2PMFrBmQUV/xNfoTm?=
 =?us-ascii?Q?HRNi+9DF+sycbHr5AzBIWCdsGYGd/bk+WibT0P1Fwh04U4x7Ccp8ncbmESFH?=
 =?us-ascii?Q?YWgXL2Q/+DT4p8jfIIsiekldT/ePGJL0DNe4tyaCKZF7UDctGtMVlqRVyk53?=
 =?us-ascii?Q?xn9IrH63+OQ+YI/84seFvtti6b+4X9EVkw3PLrjtHjBYIpA37IOnwANorN0b?=
 =?us-ascii?Q?7CUNbiMe07D89hX8RFWtJfLW4yM/6AQvFPRjVifB3v7MdprFN3i4EysPfuhQ?=
 =?us-ascii?Q?PoE6Wrc+DTsepVJQD4u6NPcGqwNkJwR5wmYNAU+HXsn/6+Fd1mkOAwXNUoER?=
 =?us-ascii?Q?8e+UujfBJ+nIVaO0FZicFz0g/Qen9kHGx9H21floUiA2OOlCxf7d7cme062S?=
 =?us-ascii?Q?tRUycK4a8bb3/GAajuW8AybGA+/B8ZNAjezk7WNRptOCPFpgI0/Nz2okbzRQ?=
 =?us-ascii?Q?7FQy3sqXKMigcdiNx4GyEGaVJcj32zQiVQhG106OwNFHdr4+k0DV1dDiUz7y?=
 =?us-ascii?Q?FcT55Lks02vsEf4YSoKiQlarR6jxfiw18yvDF6AeCu/cTwR0UG6JJdc9Ili6?=
 =?us-ascii?Q?jIA/QanZXbO5aGp2kwSmuJfMwH01yPVl9l48BogFMTwP3D6qRCGk34XNphvX?=
 =?us-ascii?Q?zz5CNQH9khxUNYF0nij7mssoBdwk+DX96QFUqNzv5ZqjYH+gP/ClVMETn4YG?=
 =?us-ascii?Q?3gQ3IX8w2EJuyRM4zIZsK+TIGnhzBIemin8CvmeskKUlyX7JW8caKqdYxf/J?=
 =?us-ascii?Q?7b6dEbAAE5iP8uf/uHYYlDXKr6jOCdwzbrQ08Iino5xqLV1Vin3sEEPeXwcO?=
 =?us-ascii?Q?PAipb1zUxx6d52cnRwlV3FpWbgm0hLR9bJTgZqp1Yt26k/EPhdol6wfaGafa?=
 =?us-ascii?Q?jGsRh/0g33CeOQcsKdx6PdTF562xVMOnOiwVtTaEPDNiXCE4oto5UC+LhK5n?=
 =?us-ascii?Q?Cd7CImE1sYe4et4J7MXqG9I16dYcIvfiLbgoxmTVp0rzq8AjTKvJgQv/iUgJ?=
 =?us-ascii?Q?nEWQDgnC5PMoSRF/GjlgPA4tcdDK5/QmTGSbJUXXd5ClpvFYxzJf2xDgTypB?=
 =?us-ascii?Q?Eq0HTyLUmeulW8+2qECBjkJ7k/dJmoQUnYuYwFGSQB6Eir65hjmn04DmtE97?=
 =?us-ascii?Q?RSzoLx18Sw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0616cc92-bfaa-4998-3dfe-08de66fb4da6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2026 10:17:45.8736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 44WCtQ66tSoHsALRIZN/8uML2RJz5qoxWm/UPNrvWudlhUdGlH62YIKnuJHw8wXwo7Q2u/i/zCd/UJFmx/Qp+A3CxZXvorLbVTapB+Rz970=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9667
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42259-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,bp.renesas.com,kernel.org,linaro.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,arm.com,vger.kernel.org,glider.be,bp.renesas.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[biju.das.jz@bp.renesas.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm,renesas];
	NEURAL_HAM(-0.00)[-0.994];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7F82F108564
X-Rspamd-Action: no action

Hi All,

> -----Original Message-----
> From: Biju <biju.das.au@gmail.com>
> Sent: 08 February 2026 09:29
> Subject: [PATCH] thermal: renesas: rzg3e: Drop unused kernel-doc comments
>=20
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Drop unused kernel-doc comments from struct rzg3e_thermal_priv.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

If it all Fixes tag required to make the code in sync with kernel-doc

Fixes: c33edd8f936c ("thermal: renesas: rzg3e: make calibration value retri=
eval per-chip")

> ---
>  drivers/thermal/renesas/rzg3e_thermal.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/thermal/renesas/rzg3e_thermal.c b/drivers/thermal/re=
nesas/rzg3e_thermal.c
> index dde021e283b7..086bd3da10e1 100644
> --- a/drivers/thermal/renesas/rzg3e_thermal.c
> +++ b/drivers/thermal/renesas/rzg3e_thermal.c
> @@ -87,13 +87,11 @@ struct rzg3e_thermal_info {
>   * struct rzg3e_thermal_priv - RZ/G3E TSU private data
>   * @base: TSU register base
>   * @dev: device pointer
> - * @syscon: regmap for calibration values
>   * @zone: thermal zone device
>   * @rstc: reset control
>   * @info: chip type specific information
>   * @trmval0: calibration value 0 (b)
>   * @trmval1: calibration value 1 (c)
> - * @trim_offset: offset for trim registers in syscon
>   * @lock: protects hardware access during conversions
>   */
>  struct rzg3e_thermal_priv {
> --
> 2.43.0


