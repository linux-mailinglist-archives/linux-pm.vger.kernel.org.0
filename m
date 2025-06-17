Return-Path: <linux-pm+bounces-28906-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2753AADCFCB
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 16:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C5233B390F
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 14:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E229F2E974A;
	Tue, 17 Jun 2025 14:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GWDS9YSJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012065.outbound.protection.outlook.com [52.101.71.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D14A2E9730;
	Tue, 17 Jun 2025 14:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750170069; cv=fail; b=FtFFYBUjHtMn80c2fDedILkIjKINavvU7NKQfUC41aojmdOAsqauyow5A04NPgP0Ql2GYwQdHVdKuFaA5IWZw6dWKVSMBzu96av1ybuWO7lqjJ4daH84x8Z4AnuSOp0O2XITp73WYEvT+MkboVf+xcRl9Ly1wHG2VusaD8OIzYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750170069; c=relaxed/simple;
	bh=ooPEM4FYHBVVh7ekaf2Cv44dODfh9QCYl7talDJ8pE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eRulIEuuPGhYyNv9+5Y0XEFgDUB2O0Gq3Z2CZEv4XhL1us183optRr8a7CLFBHqhzdf7mKafklzueXSZuMwqGWj8TOhWHhDz5wAP9Pyqad+4TdvM01sLckhlOxe+yMgcXuxfOkmv6B7aH+3vgIin3TRoZcM1bjzDkwNT1pRNmuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GWDS9YSJ; arc=fail smtp.client-ip=52.101.71.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JdPRxCBsB/KVX9UrHNos1pYOPXzNVBKYnXu+UV+C58mu1de0SBURl+KqAZaLGZHPbIqRfZ0usjxbkvnyQ7ui8Q1fCltI7rHVFuUbNUvz59Op/FsJDc4mgwwlReuIjK0662ZvW1u3D+9QjlKHScxAcEAh5aDEPT6VxY83GOeUDcVXNTuLE/cU+rsh4dRCVc/fkqtRxHQRDPUGpkmwbjZvXzbikKNrnOHnLKiRZOkJniSeg9fUH+ZRJMeUOwkgHDkHZSj9QRMqFjpBhF7R3w78+6daUSJotcQ+SXWHoiXZLNBd01yPMn68OsvH/7LjZwdRiA02EPqspNp+4yoPeE7GJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNs4I4/wL0TWpvycFJzPSA4oWM5wL3MOv7AT2fPdcnM=;
 b=I1x4IG4ya4McuKGyA92CXHsPYqkFgGGBbUM58kzo1Uyr64VFsE41PHyYdqEuk0gUU9dYieXP65C0q45wr2b/sww/6tdn0E15jeO6VylZrB0NV5ImvW77TgN+/YuHBIK/mdLD1qLiyEGNCqJpqBDANQmNopZsN+rY7hwuw3d7BHuxApTJDlCmupJ8czlBdNZVlM2c5WxAAnjbrUz1CEvFKnZ3k+KDF6ZELvy3ZwP12xJXDNM/404saKeYiLFdnD3bVEPbW0K9OFt1DwEXt2Ee5KV1xvYO8VPeKmzloHZwt3EKJM7Ok0tRzLRWIeHBzAOd6CC1LGkxQYNsBjq6C8+Wog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNs4I4/wL0TWpvycFJzPSA4oWM5wL3MOv7AT2fPdcnM=;
 b=GWDS9YSJ/vp9HTA4DAlPRtxSAUnLT1YuIqQqCa65Ju+E2naSQPm3UiU6Zes/PDglB2UulvBaItpWC05D8Z096PQnds1MwLLyaHIR5ZPp/qbBBC9Gdt1aNxXNrqBjYYZx0rai7279go3DVY2zo1SLKexSL/i9pJJiSLceXoq2z+zbIIT9MecsFH3I87t75XO+VR/rbPMRtYuNElXrMXT3zI2wKIlhJuGvCEFRKeW2K7Zxbp4rZusv4MRCtf6/VZhG4LbgnikWtaQ+Ttwaxvj7V58nJOZQpllF6YEguzdbBAuJWGF+4SB0cmALw6o4/TtL3R+m7KhHW4jsIIu0yYuD1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8400.eurprd04.prod.outlook.com (2603:10a6:20b:3e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 14:21:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8835.026; Tue, 17 Jun 2025
 14:21:01 +0000
Date: Tue, 17 Jun 2025 10:20:48 -0400
From: Frank Li <Frank.li@nxp.com>
To: Joy Zou <joy.zou@nxp.com>
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	Peng Fan <peng.fan@nxp.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jacky Bai <ping.bai@nxp.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, Ye Li <ye.li@nxp.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
	"will@kernel.org" <will@kernel.org>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	Aisheng Dong <aisheng.dong@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>
Subject: Re: Re: [PATCH v5 0/9] Add i.MX91 platform support
Message-ID: <aFF5wNjLq0frZwsl@lizhi-Precision-Tower-5810>
References: <20250613100255.2131800-1-joy.zou@nxp.com>
 <175011005057.2433615.9910599057752637741.robh@kernel.org>
 <AS4PR04MB93863494863F595F74B12129E173A@AS4PR04MB9386.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS4PR04MB93863494863F595F74B12129E173A@AS4PR04MB9386.eurprd04.prod.outlook.com>
X-ClientProxiedBy: BY3PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:a03:254::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8400:EE_
X-MS-Office365-Filtering-Correlation-Id: cb21c2fb-0b5a-4789-10a2-08ddadaa2fc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/yDYXhU0OA6yYFqgNJZ7joz2dWArVmA6EFy3CR1/g4qDfupMmDlOPljpqw+q?=
 =?us-ascii?Q?njsOn8NhsjP0a897vZYu4Ug6YG1eXqLMy6TI4wUl4/6RC3EV1deUCUk6YMgP?=
 =?us-ascii?Q?YINGMmBiDuMGlCBeVkKc/E1oedmY0eYBYcVZ1gAq3Sllzb4/w5rX8A9N+2EZ?=
 =?us-ascii?Q?3MfPafVl6/lMVVOwoiIHGUiQczNYBAqUWnCLn22zeL15PyXa9lmn30E6vChN?=
 =?us-ascii?Q?fsTV7vPxGatlJl3pzB+qfUKMdZC+EgHkHY9Ge2TL6tEUx5xMSc97djd9+Ruu?=
 =?us-ascii?Q?pZGYUWHry+9VV3Tg+uTHzC9vRV8qnse7AXZZpJ1+r6kIyEsmzM6ygqZO+5KX?=
 =?us-ascii?Q?GtAUHU3P4aNjXEJaqeVtxXiA1s2hn5uYLS9hf6B1Qa67WdYUBzhLISpdtLEZ?=
 =?us-ascii?Q?i4RN1OtOT4lrCU0DPzYVtpeV0W/VxJcW4otnNxthSfzZ+mQMZVnl+8CtjYtv?=
 =?us-ascii?Q?awLn2YVWpCRB8DBx5WKGzOMRiHJ97GIY1BOBJ+4aG4Ebnx/RNM5vCVoXHXZf?=
 =?us-ascii?Q?jCLWRDJyfFrC69M8k6pq+RcDxDT5V/IULubXn2y1cRm6AChprLOqGe6vgeOH?=
 =?us-ascii?Q?zSOlegFastrV+YpKfW98AN5GURwcrWbtE+f/Tgx8t7ySlTxrtDdDvFUFGnoB?=
 =?us-ascii?Q?y2pGl/NRClfjWkw7SpcgIjtFqW0m5dbV4E7GTEcnqeYptxtG8hINM05MtV8b?=
 =?us-ascii?Q?ZsUJlymgb8Spo74WML2N+Spi5r522Th3jYZjUYcriUYiPZcqPZKhhPhE4YkE?=
 =?us-ascii?Q?bXv9VDe/LBu/686tdhI91mU2W0ploxIo1Apy6eU8OmwxJVECPA5ziE6NrDek?=
 =?us-ascii?Q?9zIgZMoNP+zLTWfkOK86xTeFRvfSvML9WCiY5uWCKhDS62B+RX5BwC61CC9D?=
 =?us-ascii?Q?0qUSq8ZyGy1xGOZBrdcxdwig4dz9ZB/CX02PKADpRPRa0mdEaXfMr9VxJKp8?=
 =?us-ascii?Q?JX768rXkunNa6oDcRD9DQhsR3SWSb/tUmnrCgQQlrc7R4BibNeD1ghZfvtu1?=
 =?us-ascii?Q?q7R4SV8Q9zTfx8uarDMvMP8zJndyxgZDV8UVf9Zet1On8ErSu0PI/BQfax3z?=
 =?us-ascii?Q?hBInDMgqHX9szCslkjegvqE4+frv8P0/vaxcGUt5pNAOaXTbMzW1fIWbvKMb?=
 =?us-ascii?Q?mNGTi4OEG48aT/xVYEJGkCOBPX6mrq3EA1lXDDAlx65lvVMObo1V6zAxy7Au?=
 =?us-ascii?Q?tSnH20INUqXvzdNw+yBBX0TFa3HWXKIY0sy1ESij/OVyw5gOynGPkxjlznw4?=
 =?us-ascii?Q?9nTLujZ2PyyH9MtrF67fYwwrTos9Ce3qNXg1qyxttS/B65jbuCxT3eYzbjHK?=
 =?us-ascii?Q?pxxqrVyp7daAzO5y/EGLRFMHHSfRrAe00SyVrGzgn44I+i/E/8w20ualgtnJ?=
 =?us-ascii?Q?O6Mr++WuqTCQnKHTDC04+ZfBdTNaR+OB1rIv7isFlsXqtVx1svkc+s2/kHI7?=
 =?us-ascii?Q?DdE3/sWdSQ6XQAvy4U/YnZWKQURSeRn/orMoDsc2eVQd5EfeQuJA4hls726e?=
 =?us-ascii?Q?YLI1R9kEIwTTDF0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eB6/O/tOyDM+gUhLlF1K8Y85FgXyHb/TT0sGO9jXT2LlPvL1ElSgmWCB5DHp?=
 =?us-ascii?Q?fxUIVb4kbxLTCvIg3Cbnu2cBrJFQqFsFohFSAqSwndovLugC7x+ePOnDbUTL?=
 =?us-ascii?Q?32pZf90qzT0OEsYir7lenQIGu0rljYhU6HfR2ERGeHWeM/jTMI8M4lRJ3Ude?=
 =?us-ascii?Q?rblfAmmAn4KH+kXrlJ3BsThHLdqKBizxMZNQb2hEOXvC4BTq2ncMBVL07EPh?=
 =?us-ascii?Q?OqnkLQ22qWRn/uiarBJtGnk9qrm7H94R+5W0EUUXUZGTMQPQpsiaoO2jHkmE?=
 =?us-ascii?Q?8PYoEUFmRM16VGuCf8ezpzQnO8NhZpPzY2VYpphCxOTNdNv5zRMM+diTrteS?=
 =?us-ascii?Q?i+u0RNCUg3rpRnXbnFPcCwS0PKSU5+pKXvfvf+OVl+iPl5NVsjE3TBJtG2jL?=
 =?us-ascii?Q?Zg0aHMgxgLoDpGCgtq9oxofrnJbmpdp3Le9HhYUvvYXT0vFNU+hApu6ZWlfR?=
 =?us-ascii?Q?lunlRboKlK0bUmpCPKaVaSnn6qJKQ0AdXbYtq3j3vmAZ+1DN4RJ6869P28kw?=
 =?us-ascii?Q?YbRu7mSfsHVTbL2JVGxM0ZHHckBvGWSjQgd2QHzAl3gwYdzC614UcbnDZdkz?=
 =?us-ascii?Q?6YNcNpe0kaheL0Xvvai3YKpvA6gePkj2DcsNkFNJLnqNr6uIjXA4kT+nIcFO?=
 =?us-ascii?Q?snVMnv7vDpBL9fZete6B23ULlfk/B/R7FWgByRhsd1whTRllWkCJqmn8cGau?=
 =?us-ascii?Q?wL47IzFuoCmMOszSzu7BpT62RMKgvSqWXZ5FhYLG6X3MukUCDmZ4qauF57Zp?=
 =?us-ascii?Q?aEiDXAzd3BtjkGk7BdVAuAM6bD5WYPFd/oppZRXpViHqgL4jc2bCMG7cNs4a?=
 =?us-ascii?Q?FTQJnPnuqQft/6DX2oL4iQDI5rfg/muPm3Odwl5QFyJbf4lnFbmPVjVoQzGy?=
 =?us-ascii?Q?FhuYonf2JTBKSsbuJY1NwNwMIoGOtQUgQsmo2PhviCxW3GnBf7PQ//LPlK2L?=
 =?us-ascii?Q?nOj8YXKt8K52w8Yhhno5JTlAydSjiTJqRNZPqajSqHoV3jVlSt2Eg/nUNRX2?=
 =?us-ascii?Q?o+4V2OUlHSSRnLsFM+MnENuqGaCLPbEoD+h6Pzgg4xdwik0v3Xxl/QVzat3D?=
 =?us-ascii?Q?YOfPkc3T+jSaMDwX3cJFX05ouPyp2srksxabJL/L0gl49yWryRSieOvnhz7b?=
 =?us-ascii?Q?q0Q9rSasRO4gwI0UnFR6yvMqczK6TXwDoGLxC4qBU6W+R9b+0UnOl4j0uufJ?=
 =?us-ascii?Q?ge0DPcAKlXrXl0Bb0+QYfZorIIsWCfSE1Cl46fRyzfsPwfT9mmLXUBYgdmzD?=
 =?us-ascii?Q?TxFXRWwzkOA/RZdVGXQmxqY/eEuqIV0DSji9ocgwwajxPUqmMaom8G4Wsh0j?=
 =?us-ascii?Q?fKNdDzBpIMplUERACZRSkwFtr5ncVAFSxdd9XBRIk4bKuNlzYdTlKiikJRqQ?=
 =?us-ascii?Q?qWrMqqTztlNMQx7ub5DBsrCPSikhrQ4IYJvolS8ZcUbS0t4iE9hCAZOe3bXc?=
 =?us-ascii?Q?aUNMTQxKEVoZXrxOMdXhoYRJQzI1jofj/fF9W4B5BleXOitOkzRjBf+J786S?=
 =?us-ascii?Q?j3Ybb8jEW714IuVzQxVsiz3e2WA6JAD3lCYMPA6dPtTBkazg4QGeodFu3Lhg?=
 =?us-ascii?Q?ghAmDsHByu4dd7BACNE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb21c2fb-0b5a-4789-10a2-08ddadaa2fc3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 14:21:01.5629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZufGAYez/jELTP06m+vy3Mp6pLj4ZNTiL3GzdPOJu3ZkXtk2kj0IBwel5tByvdNkWc1kvzH2E28QMQY09NyBeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8400

On Tue, Jun 17, 2025 at 08:09:10AM +0000, Joy Zou wrote:
>
> > -----Original Message-----
> >
> > On Fri, 13 Jun 2025 18:02:46 +0800, Joy Zou wrote:
> > > The design of i.MX91 platform is very similar to i.MX93.
> > > Extracts the common parts in order to reuse code.
> > >
> > > The mainly difference between i.MX91 and i.MX93 is as follows:
> > > - i.MX91 removed some clocks and modified the names of some clocks.
> > > - i.MX91 only has one A core.
> > > - i.MX91 has different pinmux.
> > > - i.MX91 has updated to new temperature sensor same with i.MX95.
> > >
> > > Joy Zou (8):
> > >   dt-bindings: soc: imx-blk-ctrl: add i.MX91 blk-ctrl compatible
> > >   arm64: dts: freescale: rename imx93.dtsi to imx91_93_common.dtsi
> > >   arm64: dts: imx93: move i.MX93 specific part from
> > imx91_93_common.dtsi
> > >     to imx93.dtsi
> > >   arm64: dts: imx91: add i.MX91 dtsi support
> > >   arm64: dts: freescale: add i.MX91 11x11 EVK basic support
> > >   arm64: defconfig: enable i.MX91 pinctrl
> > >   pmdomain: imx93-blk-ctrl: mask DSI and PXP PD domain register on
> > >     i.MX91
> > >   net: stmmac: imx: add i.MX91 support
> > >
> > > Pengfei Li (1):
> > >   dt-bindings: arm: fsl: add i.MX91 11x11 evk board
> > >
> > >  .../devicetree/bindings/arm/fsl.yaml          |    6 +
> > >  .../soc/imx/fsl,imx93-media-blk-ctrl.yaml     |   55 +-
> > >  arch/arm64/boot/dts/freescale/Makefile        |    1 +
> > >  .../boot/dts/freescale/imx91-11x11-evk.dts    |  878 ++++++++++
> > >  arch/arm64/boot/dts/freescale/imx91-pinfunc.h |  770 +++++++++
> > >  arch/arm64/boot/dts/freescale/imx91.dtsi      |  124 ++
> > >  .../boot/dts/freescale/imx91_93_common.dtsi   | 1215 ++++++++++++++
> > >  arch/arm64/boot/dts/freescale/imx93.dtsi      | 1412 ++---------------
> > >  arch/arm64/configs/defconfig                  |    1 +
> > >  .../net/ethernet/stmicro/stmmac/dwmac-imx.c   |    2 +
> > >  drivers/pmdomain/imx/imx93-blk-ctrl.c         |   15 +
> > >  11 files changed, 3166 insertions(+), 1313 deletions(-)  create mode
> > > 100644 arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
> > >  create mode 100644 arch/arm64/boot/dts/freescale/imx91-pinfunc.h
> > >  create mode 100644 arch/arm64/boot/dts/freescale/imx91.dtsi
> > >  create mode 100644
> > arch/arm64/boot/dts/freescale/imx91_93_common.dtsi
> > >
> > > --
> > > 2.37.1
> > >
> > My bot found new DTB warnings on the .dts files added or changed in this
> > series.
> Thanks for your reminder!
> Have run DT checks and found this warning. The temperature bindings and driver patch v6 is reviewing.
> So add note to the " [PATCH v5 5/9] arm64: dts: imx91: add i.MX91 dtsi support" patch.
> Refer to the link: https://patchwork.kernel.org/project/linux-arm-kernel/patch/20250407-imx91tmu-v6-0-e48c2aa3ae44@nxp.com/
> BR

tmu is not critial part, we can add after 91tmu binding merged.

Frank

> Joy Zou
> >
> > Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings are
> > fixed by another series. Ultimately, it is up to the platform maintainer whether
> > these warnings are acceptable or not. No need to reply unless the platform
> > maintainer has comments.
> >
> > If you already ran DT checks and didn't see these error(s), then make sure
> > dt-schema is up to date:
> >
> >   pip3 install dtschema --upgrade
> >
> >
> > This patch series was applied (using b4) to base:
> >  Base: attempting to guess base-commit...
> >  Base: tags/v6.16-rc1-6-g8a22d9e79cf0 (best guess, 6/7 blobs matched)
> >
> > If this is not the correct base, please add 'base-commit' tag (or use b4 which
> > does this automatically)
> >
> > New warnings running 'make CHECK_DTBS=y for
> > arch/arm64/boot/dts/freescale/' for
> > 20250613100255.2131800-1-joy.zou@nxp.com:
> >
> > arch/arm64/boot/dts/freescale/imx91-11x11-evk.dtb:
> > /soc@0/bus@44000000/thermal-sensor@44482000: failed to match any
> > schema with compatible: ['fsl,imx91-tmu']
> >
> >
> >
> >
>

