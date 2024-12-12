Return-Path: <linux-pm+bounces-19156-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F099EFDC4
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 22:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E6BC165319
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 21:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E6B1C173C;
	Thu, 12 Dec 2024 21:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OecRacAm"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE55E19D074;
	Thu, 12 Dec 2024 21:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734037235; cv=fail; b=g7fEtgPVYuotUV8wmbaDAe87CPCNI3khNtNdvyi5DFnUz/eETo4SJ5lFkGiZObEi92Had3gP63lcFGy/W+I/VWCWiZA4Ok0aXmCu0p6dLbZJiJZpn/1tLwEtLIkJ4HX2dscGv4GDlW3dAPxMuAZl7mAmRWTZXWLFsb67lcHlkQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734037235; c=relaxed/simple;
	bh=ruIJLlF20swj7SJdyvZ5zimlnM5QVKtZfGGBtF7YgjA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=AJW3rC4SnX2cVWdCCSiXusm24vOyyYIXzZkmHqTrOyNgfm/zlsiPs+NZcfe82xUnrFNYfHaqCpveoznFwxtxG6Ols/nKGg4HQ9itjsj824G4H6UAG1X6Ecf0AqyI2IzKxXhRY/rb4vssoJFR4f0NHnTqcD8xkH3Wj+p1ONFvLjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OecRacAm; arc=fail smtp.client-ip=40.107.21.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwGBq40CuX7jGxKFlTPFk0gyiJxbcWu3MKcuf5RVKjEPs46wo/uiCzux7YDXQF7QgY/PzR3H2kI0Z7dhm5DUzUmIevnq0SRa0n0PdPa/wsX3gpkaRcLijU9qN/fvkZaLKjGxs72IOrrdoH5MAYDlNhbhBdhhgRoUY0cocyk2+PyZtCM1FKl2HFEcnK75nIg0WwnrIOtE9Llv0v7+FIvFILg/1Se7GEkFcig7RO0geF5MooV76pdpokiSFqsfclo+QOlPV4dzI0/hGZeiDSMBREYpXGNAlk21ijT0zch5BC0exyDJmcxHFBEPBo7dUoGipe7uaYKOrzX3rCywaaKYtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L99lfwl1lXdal6iy5qw3rDaAXaDEKsCNMObfCtzX3ZY=;
 b=dplqirbC8B+aQZvjb57hgy2IUkZTmjs4PhcaALL/DmpqqfWvex8Cw2FD/nGcQGKjVjyCNHrzQ+fnUrk5h4JoM84ct7t1BV/yVw1+maMpYkpUg/2n7b9MqIxovt69vgc2Kie1h3HILzEnfapRcd7cWN9wcmkDVtF8juS6ESGhFKa/pkF18cU+f2i0t8c2WACjXIVCtb0+C/gKR/VBJlnF/SHnA1YI7vuuCtAi1MPHYKWm73klczxFoIR7YFjhcfr8Cd64gI94EYeAhU0EpD7I1hiCc+XiiSiE0twi6bShT4usKrnDjbx/2aHRCpEx/eHJSYSJmlxgQkx8Y8YWCDfqmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L99lfwl1lXdal6iy5qw3rDaAXaDEKsCNMObfCtzX3ZY=;
 b=OecRacAmDalLEZCjg7ovoPbim9nz7z3VLZB3UcJKMKpzNuRKgcbeGBB+sUxJ6DfjaXneHRZgKRWEerH5TQVkUZsbU+T4czXW8Kws2T+NdDuazZ8DujU4wSAn+Wn61/wEoB123T+txIhCii0IqJHyC+Lbj5SJ810WcvHytP+1cp97OLRRkMg1gxVLh4iY43c7B+OKO+M6NHaPt3M+vpXFdigNfDw8HxTOqmdD61GJQ1u1UTb/OvWlGZ6AX7SsOsp4fMuuGrk26bJJ+rotqOcCHN3YvFxoQjjgrTZrypv80H8jTfHDzC2q2PNuVPkPuCXaljfc34yDC30tfDtzlzVUaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7560.eurprd04.prod.outlook.com (2603:10a6:20b:29d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 21:00:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Thu, 12 Dec 2024
 21:00:28 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 12 Dec 2024 15:59:59 -0500
Subject: [PATCH v3 1/2] dt-bindings: thermal: fsl,imx91-tmu: add bindings
 for NXP i.MX91 thermal module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-imx91tmu-v3-1-85e756b29437@nxp.com>
References: <20241212-imx91tmu-v3-0-85e756b29437@nxp.com>
In-Reply-To: <20241212-imx91tmu-v3-0-85e756b29437@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pengfei Li <pengfei.li_1@nxp.com>, 
 Marco Felsch <m.felsch@pengutronix.de>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734037218; l=2361;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=nIgf6yhXwINBKNcOtb5V9xIxfpGGwkUZ0FakJ5QJxZM=;
 b=Aw3XA4xG9d49zpxSYipWVwTUzY9ap+5By12YAaobM8/w46hCtTIsCEOJ73E1NEH/4+G3ZCI/0
 xj2fbWHqDJjCf4y3YKv5mEhd0kJqohKpInoNZuJm9WOTqWHije+aL3e
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:a03:254::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7560:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a9398e3-c0d2-47d2-45c6-08dd1af00219
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGtONHJab3F2SmljY2FtRkwreW1LcXh6ZmJYbUoyaHJBaXJPb1Vaa0Y5VFF1?=
 =?utf-8?B?dzdVaGR0U0I1cU1Pd3dOY01tSTBGUHlaejlLNHp2bjBYVWx5T1F5ZTEzb1dh?=
 =?utf-8?B?V2ZhTUYyck0xK3hKbTJkWGYzM3JUSEl6c1IxY1JPU0psVTNNNCtHdENiQTF0?=
 =?utf-8?B?YURSbkJzVWpCZUlRVU5lc0F5VUNSU0JvODBTVS9zWXVYMjZHTnhRRy94dzB1?=
 =?utf-8?B?VUI0dTJQZk1tZUpkMGRJRkNqMG9nMGpRMktuYjloTTdQL0JjWHZ5dm1zYzZL?=
 =?utf-8?B?TytDRFlCc3dLdFBDUjVhQTQ1MkVFMHZJK2dmVnJ3SzlBdmt1djZ2RnAwajQ5?=
 =?utf-8?B?S3BvdWZtVFFDejVGMXo4MFBZNVdoem1Bdi9RMExTSDkrY2Z5V01hY29aT1o2?=
 =?utf-8?B?cUVCTzFHL0dKUHhCVnFzWWRxTlIrSnZsajNBRnZscFZLYTRYN0Fsd21aV09J?=
 =?utf-8?B?Q1lFSVVvQklaZDl1cFdMV253aGEvVzl6azVDZ3hQOE1JZHhGNlF3NTZFeld1?=
 =?utf-8?B?N0pKbmFoZXB0a1Y1VVovbHdFTXpxZDJIQ3Btd05FUTBJT0lZTTRrT21id0hW?=
 =?utf-8?B?V1BPR1lSVmNDN05IQzdJU3NmaTRWSUcrZDh2eU8rSEJNTFZTdS9nUlpTNVly?=
 =?utf-8?B?RnlFQUo3WFY4WlVEVkRVLytWeEp1SWNXbWgzYkpoYURxSGd3K1ZKZG5haXRa?=
 =?utf-8?B?WHpwazJZTVd6RnFhQVYxd2N6SmY4L0s5akJmQjllcTd3TnBNSml5SXRKWk84?=
 =?utf-8?B?bHJrRGNWb05NemtETVYraWcxeUpQV25YVjZaRllSSWN3aU1Qc1pFR0o5d21l?=
 =?utf-8?B?cmcxYmlEVWFNNHZzQ2JZSHM2b3JMeE9iWFoxWWd5dnNCTmhDMjFtVXVHYmpp?=
 =?utf-8?B?dEp1aTRQekdGaHduNmpKbC81RlRqMG52cCtPVTQ4c01VZExFZ3B6T2t3MnAv?=
 =?utf-8?B?ajhMZWw1NkQwWWozMjhrcHBmNTZuSjV3N29lN2RjbXc5azljZm0wUkovTXdK?=
 =?utf-8?B?Z2FFMmY5cU94THEwZ1lCckNYWE14OGh1MEVxSVBDejJJSkRndWdMQXdIYmRR?=
 =?utf-8?B?M09RYzJaek5IbnZRbVFQdkdxZmRoNjdZeWJNUFNlNEpFaElvbG1uT1FSMVZI?=
 =?utf-8?B?MTBybXMzelpkZGQreVdobjdXeXNxd2V0MDRiNFhPTmV5VHNQTVl3aHRRUWda?=
 =?utf-8?B?c2JrRWROMzhBWXBaRlhzVU5Wb2VQTjdoTlQ4RDFWRXJVOFJqWGdwWXBZb0dr?=
 =?utf-8?B?M2I2bGJ1Y1ArQm5pN1oySUo3Y3crT3pnVHZTSzJ6T0lRQlIrOVZCQTBMbThk?=
 =?utf-8?B?VmJvbjdVVi9XYW1oZ0UrUWlFUTVUMG5Mai9yNVNEZk5rSk9zdWJUK2hESGds?=
 =?utf-8?B?RFVWNVlFWEhiQmFtaFp1VWhMR1llbTIwMmFoNGlJemE0U1RkK0o2U0p2bTJC?=
 =?utf-8?B?TjkxTFJubTdrWTAxL0hXS1kwM05sZmF3ZUwvbFBLZEFPZCtoeEFvUnBqV3lv?=
 =?utf-8?B?bnI1elpKOUhSSE5xeEtLL3JTRTVaak5hZ0tXRU9FcnlOU280MlN0SmZ3NlYy?=
 =?utf-8?B?aHV0VW9veTZ0ZzA3d1lpS2RJTVhpVG0zeEU1bytLaFl1U2kzcGFTWE1qRkkz?=
 =?utf-8?B?NC94bFg0eWkwcHZTcWVLa2crRDZMOXViQkZ2SmlvMUFsVWVDQ2lyYUZpUVVL?=
 =?utf-8?B?MGdCeTJJZyt1ZXFQUk1mZWJDNWZSNnY2MURTQkhBa3diclpRNW01REF1elp0?=
 =?utf-8?B?YkRzNU1ReUhGUnkxWlBabGs4VGhjNDVhNDBHY0VSU2QyRGdVdXViWWs2bnNZ?=
 =?utf-8?B?bFJKUlpla21HUXhBVlhYZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVgzcW5qMDUvMjBZeVNTV25kcTlrRWhybDRnVmhBdEY1QWkvSTlCenpFWHdi?=
 =?utf-8?B?R0R6dk4xeS92U25DcEpDMmd4MUxBN2F0N0d3V25KTy9tMFR1K0h2b0tBSHdy?=
 =?utf-8?B?bklTRUV0Y1B2cW85L3hhdVdDWHJ1V0ZCSFk5dE5NZDFaV0o0Sk5HcDZlQXRh?=
 =?utf-8?B?bG0xWUZGbWVobUt1dzR5czAxYnZxN3QzWDFBQU9ud01ERXJTc05aRmorS21U?=
 =?utf-8?B?S2kzRXZSZG1SMm91VlROVTA1WG5zSUxCWXRFVXhlRVFINEtNOHdwYmpPb3JW?=
 =?utf-8?B?dzFuanFFejZoYU54WlgzOHBjNVNGUC95UC9wWDJWMEx0RXFocDFIaWpmUlZq?=
 =?utf-8?B?TjRSTW1MT2ljWXpMSHFwTVA5dGpoZjhweFZiMDJ6bHZwejB4TURoM3RGck44?=
 =?utf-8?B?MHJnYzdxQkpYekFLbUlDSWhnT2U3WVFXbWhWQks1THcyeEVrYnU4OVd2aTB0?=
 =?utf-8?B?RDF5MDBKNlZCMDZ0YUxGV01acjBOdVZTaDVEREpsdzdtVXg1b2lWa0NBN1BG?=
 =?utf-8?B?alYwQ05PM09pbnNKYXZKTkpaamFYdzhHVWdXbm9ZMkRQeU0xNmlrdzNzTE0x?=
 =?utf-8?B?U0htUGRMWDVrd0lrL3R3SHY2ZW1ERjg1VUhpQllIT1BkNXUvWnIzM3E5UExn?=
 =?utf-8?B?TUtSeWZUT1MyYkIvT3pRc3piNGIvUFM1TUxISDBYb0xWR3ZmeFJrM0dhY2JY?=
 =?utf-8?B?dm8zcGxJbVJJVGphT016OTRLRXdhZlVtWkN6NFJUWi90VDZkenF3TmhESm5i?=
 =?utf-8?B?MFhzZ09FZ0hHKzRsYjltY3JMdjlWNHc1ZjRaRXFLYS96d0VTZXlEazZZeGpH?=
 =?utf-8?B?R0gzMXBvVkpjMllYYW5vK3pkM0hiS2lCV2dQQTlnNHc3ZTVxSUgzMHh5NG0v?=
 =?utf-8?B?QUdDTmFmZzNkaXJWWkU2RzRZcUZpQWtxSlk4Z3ZvRXdwUThPdkpCNzBKaE4r?=
 =?utf-8?B?QVphR0tXSm9GN2dXTmVwckY5TmNTY09HOTFIL2NKSS9nZXFjVUNnMXBWc0xu?=
 =?utf-8?B?cUlLUU1xTk5zVVlwQk5SRkpTbk1yVFVKWVFUbTc3eEkvUmRvV0FWL0JaL0Qx?=
 =?utf-8?B?cDZHSnJOSE9MSkh6U2NCT2lubEROcytCOVF3NlM1SUpwTnNiN1c1bG5NNytF?=
 =?utf-8?B?dk0zNlVydmFaZmltTVVOTGRDZE5WYzVwb0pPbEY2OE9LcFp2N0lpR3lsaFZT?=
 =?utf-8?B?UDZ6SFlvSm9BSkV4SWZ4OE1JNHdWN2hKT09KaDBUekpiYlhjZm1ESkNrV2oz?=
 =?utf-8?B?MmVYanJKbGY4cWJkY2NhaTg0MHhoelZDTVV0V1RnVWpHU2hMS0E3Rld2V0NB?=
 =?utf-8?B?YW53NkM1eW41OWxUcnk5OFlCWUJiNXJmd2FwdlAzTzBPYitvc080dDBCdFlB?=
 =?utf-8?B?TFpia2c5RUVBcVJra1I3eDZUbzNhdms1Qm9WbENGMjZQbC9TbFJHazlWbXIv?=
 =?utf-8?B?VStZZE9hR1R1QU9NbFQ4a2N2aUQwZFFrRU03MlpDSUVoakhvWUF1NFRxa2VK?=
 =?utf-8?B?dGk3TWk5QkR5dEFVdFRkWTB3TFlrQjl1cEdzOXBScThVVGpTOFJWOHNxOGhR?=
 =?utf-8?B?Q3Zjb09IQ3JIK0tIMEVkSmFlNkN6Y1prU3ZpbGp0eitWZGEvMWNWZ0dSamxY?=
 =?utf-8?B?QmRHaFVSZnZpMWYwcjFSanozM2E5Nk1NY3U1bGlObThKRWQ1cC9Ba29OQnlw?=
 =?utf-8?B?VS9WMUJ0UTFsY09wM1BrQkhzUDcvRE53Y3BQRmh2RHBEQzhJN210azdWYkQ4?=
 =?utf-8?B?TTdYN0VWRU5zY0E5VGJ1VHd0SWZEOTdZNHE4ZjFqSjhNUVNiQWhILzhDQVJy?=
 =?utf-8?B?bUN0dVhVNjBoNzNyRFBaMythOUFOM2pCODJhck1TQ3ZsWkZ3YmRkSFdOQytF?=
 =?utf-8?B?MDdxd2lMREFlS09iaFpTZ0hScG1aOGpDZ29hNzRrUUVUMUxwc0ZieTRUQmNC?=
 =?utf-8?B?QUJDaElVU1pramt2S2pSRVMxYURmUGdyLzNnTE00V1BKK1dCTDFsMzFmL2dH?=
 =?utf-8?B?TXNEV25HRE1rM1Z4K0JMTFZOdVprVHFZVXpyVTl1WDhZSWtqUUF2UGVLaWMy?=
 =?utf-8?B?ayt6NlpORjRQK2dva0gzRDhWaFhXdDRqTDRIbVFkd2FDOTlENnpVSU1raE0r?=
 =?utf-8?B?VUtMb2RIT3pWQmhnY2ZUcGRPNnNuZFJTVFBWSzV3U0lpMXVvb0p1N2laMGRU?=
 =?utf-8?Q?sO4gw90g75dYknP+nurCEsxb6FS7Z005W/F3nf3qwxpG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a9398e3-c0d2-47d2-45c6-08dd1af00219
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 21:00:28.7153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6atMOLJp7qWKTToPNRhZBBBBXUmSE9HINHZ1dZ3uP8zmNOeS98Gq2SLTUoGkriRHAzeKsLaGUt+gq+Eiezo4yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7560

From: Pengfei Li <pengfei.li_1@nxp.com>

Add bindings documentation for i.MX91 thermal modules.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v2 to v3
- add ref thermal-sensor
- restrict #thermal-sensor-cells to 0 only
- Change to unevaluatedProperties
---
 .../devicetree/bindings/thermal/fsl,imx91-tmu.yaml | 67 ++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/fsl,imx91-tmu.yaml b/Documentation/devicetree/bindings/thermal/fsl,imx91-tmu.yaml
new file mode 100644
index 0000000000000..8411f3233bf44
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/fsl,imx91-tmu.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/fsl,imx91-tmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX91 Thermal
+
+maintainers:
+  - Pengfei Li <pengfei.li_1@nxp.com>
+
+description:
+  i.MX91 features a new temperature sensor. It includes programmable
+  temperature threshold comparators for both normal and privileged
+  accesses and allows a programmable measurement frequency for the
+  Periodic One-Shot Measurement mode. Additionally, it provides
+  status registers for indicating the end of measurement and threshold
+  violation events.
+
+properties:
+  compatible:
+    items:
+      - const: fsl,imx91-tmu
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  nvmem-cells:
+    items:
+      - description: Phandle to the trim control 1 provided by ocotp
+      - description: Phandle to the trim control 2 provided by ocotp
+
+  nvmem-cell-names:
+    items:
+      - const: trim1
+      - const: trim2
+
+  "#thermal-sensor-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+allOf:
+  - $ref: thermal-sensor.yaml
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx93-clock.h>
+
+    thermal-sensor@44482000 {
+        compatible = "fsl,imx91-tmu";
+        reg = <0x44482000 0x1000>;
+        #thermal-sensor-cells = <0>;
+        clocks = <&clk IMX93_CLK_TMC_GATE>;
+        nvmem-cells = <&tmu_trim1>, <&tmu_trim2>;
+        nvmem-cell-names = "trim1", "trim2";
+    };
+
+...

-- 
2.34.1


