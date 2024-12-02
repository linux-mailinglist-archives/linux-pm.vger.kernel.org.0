Return-Path: <linux-pm+bounces-18320-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0399DFD73
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 10:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0051CB20A7B
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 09:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9A31FAC51;
	Mon,  2 Dec 2024 09:44:04 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11020136.outbound.protection.outlook.com [52.101.225.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934551F9EBB;
	Mon,  2 Dec 2024 09:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.225.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733132644; cv=fail; b=r7VHCjCMsNF7AlfnlkzbAMY+TfAJDZVV9aRnhn8zF7pjrCLko8jkJookd/NaI3w408B9kLYbulPMZtyT8dVsnlq3aNu8Gqycxwra+ITDnDUeDPhBAw1UEqqf2Fxc9+zlr5hJ8glYPGxtsidzpNyj5Es8FBQSsdR1LzUAL5RfbuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733132644; c=relaxed/simple;
	bh=9EVMzfd6WqgI5oHzyZiBOI8g7zmpGbC/RTeLeaKkqoA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sLNrTxvH95hLS6X9CBxzq3tWW0S/8i5jl9g0F1dhme5i0ZTmLjTLmStJGPM7uXg3c+DpjoWfLiCzOQNZYfhyhC8uUoDRIE8Q9ninysBfEngMOU4ct0fGEjgWqzhYf1fQQjQeF7nzy2q1guLa56m0pm203M0BuiwPI55yIG2crQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=52.101.225.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TS6gZJox4msg3NHr9b8aXk9LX3WNnaxvPX0BpBerZ1Qkn5j2k9GqVNsWyq6+5kgUpG0Z0SmvqwDgxx4mjyiOOaUht2H0vcwdwBIQnhAJhNOh4T865tRHLSaIjyqJtGtRb+bTYEosHybcRuVR96/me2ILsMLcQ4n6e5GEKTysadpnQ6ERF7PHpU/n89Kk2TGxi5lakhEJqjbxnP9HbuBge32Qnccf9mklp0MeLx6ckxRoHX4FuD3oCYBcWNLNhytD9tikD+TZOZWUTT5gxXVEkGiG1tt9Ag5G2+mfEDSvv8EMDeZHSoYsrndyvi1L3kr7o+55TjrS/ZSACY3J8gxgJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCX2U/Z4CZwxFUSp1yv8VW7JEH51zWrQ8mptJW5dNcE=;
 b=Dpli6EiSetWcDFVcLKQAopaTnRIXtDDO1j7O3Fe5TS97PuCick07mv1ICjRW7d+HUVV6ikVymnKuMcuURWaR1ER6BCX6hC7kg6qlq5Fw54q+mKxB+QgFfiHZF2I9MltO2IUOVcWbbBc8GCriY9DBV6CnjO0HLfU4NAARZCHX3Xu1Rl11cC+6+drMNIEZaeuv1Bl5sgCun9P6IEnet6enVfgjmfn7nc4c8Jk+6D27oEms7c7KvKxiGEoozYgCufKTtWe90+Iy5iMT8hUikWHSL97sj3FGiIPOBtHEng1QicuIr+b7/DwLcKpVq/UN9oAKJc8odqST6ZiWfDkVZIMOVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM (2603:1096:c04:1::15d)
 by PN2P287MB1028.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:134::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 09:43:57 +0000
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::740f:ab98:2be1:538]) by PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::740f:ab98:2be1:538%4]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 09:43:57 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: sre@kernel.org,
	christophe.jaillet@wanadoo.fr
Cc: Bhavin Sharma <bhavin.sharma@siliconsignals.io>,
	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/2] power: supply: Add STC3117 Fuel Gauge
Date: Mon,  2 Dec 2024 15:11:51 +0530
Message-ID: <20241202094328.14395-1-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0177.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::32) To PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c04:1::15d)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN2PPFF679F9759:EE_|PN2P287MB1028:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a4f5060-f845-4edc-1c7a-08dd12b5d7cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4MDB15Xzm7FEhIUrP018XIZ2UP5In9+i1LJO/tNGjQ7GMK4E7Cj0VjmhE/SX?=
 =?us-ascii?Q?o2glZGt8MQPUO8GNR84/wgE0dP3FnEXisSarv7O7rSiJr5HZ9hXfz0YHrz7D?=
 =?us-ascii?Q?/SZtIbI9XD2GKbGUz5P82v3uPzY2QgjzVoFp935TnvX4TpI5AKjtbAvg4lUG?=
 =?us-ascii?Q?Y/wZ7YocKMyaclUMCgAvax9dqoITq0shJeG0PQKGG2lV9+B8ZVLPm0T+8FtU?=
 =?us-ascii?Q?ZCCS4K25UinDJkJR2IWVs/LuN4ZRqTJPf4Ogq+m4LNKY5/l9QEZp8wwhK97O?=
 =?us-ascii?Q?yH8rmXHLKhzKYxwoBTYHdw0nFR7k0REy3jzEqBy64smxwm2A3nAXOx9+v/Ib?=
 =?us-ascii?Q?lmTF0m7myhyB2DoTrn1elpmR9AYtPtsPzfeNxYdsetExhlrvkOWqzdATF1rh?=
 =?us-ascii?Q?BmIhrei5GAA17qoWne740Wd5XmvtlaaTpNavbLGSjVn1/gIfiHQD4S2Fu3lj?=
 =?us-ascii?Q?i9CUk/9UCYNuIDpGOqdZD8bGhcKUwnzAFel94sOSL3S1ssIolGIetbKIh19+?=
 =?us-ascii?Q?Dz5jpWIhI+I14YipS8o7eEn/mAU83Zk4QSrSmbUPs96e4xuVGrcKwuoDpE7F?=
 =?us-ascii?Q?aW0PvdWYLnSQbae4DsPSIP6kwU/ZbQkpNrSIcjaJiF29u+sALkbZwrx4cNoc?=
 =?us-ascii?Q?JaKrrBfF1yPNR+rkPvuw3JgJ1bVYbZRWnjuaCjbCjt/kV0e3EIVOQO8lvOf6?=
 =?us-ascii?Q?1vq83bueuelqUgQx6iu6AkE8n9ddzey8PQjLZha08F1/1lwDtSwix8ZWAoor?=
 =?us-ascii?Q?o9R6efwuC2PBwv6UXAHFw8tnDnTzx2RmhC60T4cGnGkss6ZirapBdd/qw6Jw?=
 =?us-ascii?Q?uYdoisLjWon0T3kC4b4RngbIb/+Wps/ER6pC2WCA3zSeBnwdgcP0QVm0QOp1?=
 =?us-ascii?Q?adtc+bP9/MjWSnAIi+QOXa2ZYVE/0/MlmSJvw2VwtaAcExpr3HcPcukO01Gj?=
 =?us-ascii?Q?vIkK/5kyvW/O9HZEMrbBQ+YNuRWe34o258VUKhe2Qkc59WqYVTv7BWZqftHG?=
 =?us-ascii?Q?tfPzakjpH16wsp68kvIu1wvR804yXULVV9vEpq1HHpRDKBGB6kQ/t+PPcxVM?=
 =?us-ascii?Q?9k9do3u2eXm6PuOa4WQNlRS6quo2Yu5VjrvO55QFMz6EYE3xxBUrINsQM7Dt?=
 =?us-ascii?Q?HuptBR74N++d4s51FyB9ReGS0YiImnsgimgx/euhldqJqyJGDAL8YqIlzUdB?=
 =?us-ascii?Q?NQU71nqDxfcdiuj3HfNCZ5eliAGE43mpOenRcHG2IEbBrSI5TFbPijRyOjfh?=
 =?us-ascii?Q?WzkpZwdXnOReISDMrSlnnLFE74sxUSD8MqCbew3U3mDdNb7vRNTaJ57hS0ar?=
 =?us-ascii?Q?/nLlivB8+ke13n2YFW4UQ9XjVPLx7TllQoPoDM9y0zs9F5VvwlmIhLSN4OSr?=
 =?us-ascii?Q?V1SJwK8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5qRqUtbcsF8HOlCMlHxufbjWq8OgRmJIzSxQc663JX6eDqKiejhhcWU1+fUk?=
 =?us-ascii?Q?inTu2wyf6ZBmpLcPmfeNDgVfE+Qm7Z+dJWnADIJl43Jf33PGNwlWKwO8ZxxR?=
 =?us-ascii?Q?TNnwYMLDSpayu2Ei7O1+xBGkh8TAwg86NsA/DvR5HGpBkdo1z/nXZun6vne3?=
 =?us-ascii?Q?vHIha1NhUTBgKg2VOP/j4zG+4EtTGTFYVu4/BeNKPO9Au9D+O5q1SOzM/j98?=
 =?us-ascii?Q?gPiSwg34ApSAwcJliRQNETZ++Xbu7SFi/6iyoSHrYUJKRiW++byiwt1PcscD?=
 =?us-ascii?Q?c5Pphi/Z+oI7dXZ6vUEzmgMczNnciTxSgOXoEgWOYlj/Z9WJHYdBQpJLSOQL?=
 =?us-ascii?Q?roGOy7JzYq/qseHIADkrIvFICAtOtIAzYw2zHcJxLnbvxNFyeez/dTt2Gq45?=
 =?us-ascii?Q?qRi20MawTP6Dp8aqPJRE5sob+v8+/JN0UPRObW//tjROUXBOSFEqhjdFx7UK?=
 =?us-ascii?Q?tgBXOYhWQdWhhbpPTiXbevXrU/iNlFYJIqT1xsp6yiFuOZuAHPu9ZzFj56gl?=
 =?us-ascii?Q?uSK0Sda6G4fhNPnM44h7WhOt99wqq8Ds+Y3IA8rwSx0iIuiPy1m8xKKJuxJB?=
 =?us-ascii?Q?2GMmt7pCNfF//nCx0UwPJYOWDnk9Ukpv5BOSGunV5qvHbdWXP8EMv2LIHdNk?=
 =?us-ascii?Q?ZqyG7atjjpnbcdCmfH+FUntwxDcwJkuEsxynGtTNGLRMt8EtkupHzqxMXwr+?=
 =?us-ascii?Q?WqsEm7diwT3YnzZsjVxelB65fKlsciW/dVne2yxqpFio1awAnPQykVpdhoBg?=
 =?us-ascii?Q?YJk4+zwuuxwtIO6yLyKS37IR9UW0T5Ly0eAb25Zg08rxkax8d3GbbmFnkpEF?=
 =?us-ascii?Q?waG5mj4uZ/79FYiVNCYfmelB0vQUSuHszTLxcRq5AYWBBuYLyaNLvSq6ewaO?=
 =?us-ascii?Q?FpTsUMpK1NQbNQPJR1SlhixPKECa4VuIoWEyE2D1i7prfysay4qatKEGYcJe?=
 =?us-ascii?Q?e6jVC0mXCwdOmFseduW9Y3+c0Q2ey67WeG/jnTQr8v7NatgoWtQFtHSmDM1o?=
 =?us-ascii?Q?LYiHn0oWQwMNj/9t7U3/6rttcD4749+jFpvPJSAnkir69nqmit1Aw8GUD1cS?=
 =?us-ascii?Q?yyxHqzvxXObhi7AAY4cuab49aa8tvaQpe6I2YpYJb3uwaZQ6Cm9kfbvvKKNJ?=
 =?us-ascii?Q?8z582h4o1L3nz86pi2aK/M5psG9qfhCevpJNrzhJdsWbI6lgPCYLt/rIXCEf?=
 =?us-ascii?Q?veQGsROM+EJY8EKdcwXnOKyJxhVSY73v6OyBPGP0UkGw2GVeHINcK4DQtcz6?=
 =?us-ascii?Q?a1PRB2Pwk6nvnZCtPBAJJggkhOFS85Eqnix6m6f4OGJmj0RHQOOTf8SN8sZy?=
 =?us-ascii?Q?F/s1y0iVuBIJuGGsiZdUqkSlZQop9DgyhP2/5L1fFaERXmrXTkOPE1yb9MNT?=
 =?us-ascii?Q?abGh/gb5XgPSNkMC796BDvJpwu8py0GIJiINKnaS4M/n7gTzMp+2+k8QBEeb?=
 =?us-ascii?Q?bD0Q76N9etzZ8qBVHjpx6HS0JrXFHLMz1rpWAtc1ByLXEFfLHqbUyXWzMxzr?=
 =?us-ascii?Q?GhQIslBK5IBmKKOPH7b2+DTPnJq1itAd4ET5Xa4bi6o0jIMejaPGQeyULqgc?=
 =?us-ascii?Q?TYgzYH7wHgGImk4ImDcjXIR+hLi5H6sGLODJErH79iby6mIJUeWZdxih4/qz?=
 =?us-ascii?Q?BuO+HoOV9YlHK3pHQXJ5LFs=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4f5060-f845-4edc-1c7a-08dd12b5d7cf
X-MS-Exchange-CrossTenant-AuthSource: PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 09:43:57.6872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mUrWHC99alq3dcdcqphTkbwILBiYnuU5rTBWpNsEJCiYQP6e/C+1t5xTHOv1mj8NLNKspTzCxNUonclJzjiv55Hj5O3j8j8FeHc6OqufgBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB1028

Adds initial support for the STC3117 fuel gauge.                                

v6 -> v7

- Removes extra spaces.
- Fixes error handling.
- Fixes the logic for checking battery status.
- Fixes typos.
- Removes unnecessary commas.

Link for v6: https://lore.kernel.org/linux-pm/20241130094531.14885-2-bhavin.sharma@siliconsignals.io/T/#t

v5 -> v6

- Use shunt-resistor-micro-ohms property instead of sense-resistor.
- Remove the battery node from the binding examples.
- Add interrupt bindings to the example.
- Correct the Signed-off-by (SoB) order in the commit.

Link for v5: https://lore.kernel.org/linux-pm/20241129114200.13351-1-bhavin.sharma@siliconsignals.io/T/#t 
                                                                                
v4 -> v5                                                                        
                                                                                
- Fix variable names                                                            
- Limit code line length to 80 columns                                          
- Add interrupt and monitor-battery properties to bindings                      
- Correct error handling with return dev_err_probe()                            
                                                                                
Link for v4: https://lore.kernel.org/linux-pm/21c08a45-34f1-443c-97d4-6baf9fa01b67@kernel.org/T/#t
                                                                                
v3 -> v4                                                                        
                                                                                
- Added support for current, soc, temp, and status properties.                  
- Addressed comments and feedback provided by Krzysztof and Sebastian.          
                                                                                
Link for v3: https://lore.kernel.org/linux-pm/20240205051321.4079933-1-bhavin.sharma@siliconsignals.io/T/#t
                                                                                
v2 -> v3                                                                        
                                                                                
- Resolved DTC warnings and errors                                              
- Formatted the changelogs                                                      
- Added monitored battery properties                                            
- Replaced 'additionalProperties' with 'unevaluatedProperties'                  
- Replaced '&i2c6' with 'i2c'                                                   
                                                                                
Link for v2: https://lore.kernel.org/linux-pm/202401080530.0hMWnrIg-lkp@intel.com/T/#t
                                                                                
v1 -> v2                                                                        
                                                                                
- String value is redundantly quoted with any quotes (quoted-strings)           
- Found character '\t' that cannot start any token                              
                                                                                
Link for v1: https://lore.kernel.org/linux-pm/46bba29c-330d-417d-ad84-ceb5207fdb55@wanadoo.fr/T/#t
                                                                                
Hardevsinh Palaniya(1):                                                         
  dt-bindings: power: supply: Add STC3117 Fuel Gauge                            

Bhavin Sharma (2):
  power: supply: Add STC3117 fuel gauge unit driver

 .../bindings/power/supply/st,stc3117.yaml     |  74 ++
 MAINTAINERS                                   |   8 +
 drivers/power/supply/Kconfig                  |   7 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/stc3117_fuel_gauge.c     | 666 ++++++++++++++++++
 5 files changed, 756 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/st,stc3117.yaml
 create mode 100644 drivers/power/supply/stc3117_fuel_gauge.c

-- 
2.43.0


