Return-Path: <linux-pm+bounces-40845-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A02D1E3C6
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 11:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9448F3002947
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 10:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D47395D9F;
	Wed, 14 Jan 2026 10:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="FgLWonAP"
X-Original-To: linux-pm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011046.outbound.protection.outlook.com [52.101.65.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5D139447E;
	Wed, 14 Jan 2026 10:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768387988; cv=fail; b=ufiiXUi6ghsywRJhIcLEujCmVqOrO1NraehcMwgXONG4CGHC5LOExNhf9SOTUeTOz9MjYH6nOlKDaqI4wtnkRoXlQiahuVuyVlLy4NdUDYXwNBKtJi7Cwbp9oq1sMld1sXmlIKXqEF1qsuWx8RX7Jg+0mugZ5d9N+4+FU2k/q24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768387988; c=relaxed/simple;
	bh=jmz6okCwurMNthC8jj+Qqe/jyzDlewNO9Tg7earYyjQ=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TROOz/k36osHGoKE337gC0QR3z8anBiBkjWAvRHP4z9t6phX18BcdJSX18NMznfttuZ6dYdZy1clWZWF6coqwfhV/e/KpViV312kPEB0bQKIY25+KBnZ1hnQYZ68D9ZxEC/+dO9xxLwcn5elBzNyZhHz1WTzsG+qPLzIVt6T7IM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=FgLWonAP; arc=fail smtp.client-ip=52.101.65.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LYOt2otpFliduHLuz8rJoicNbvYFFdNyJm0O5DlWmAW/RRBbTXg8MzMJKpNbvIdkqnrXikXNf/HRlNN+xfH8tobJ+WQUrjCqbuji6RerI0NGO74JgnZxsITuOyBRunAFkc2W6GNWsPmiyMRsApKmHoOWh75Z6lX2/C5GQuQVpW9j+GrbKYYmoFgwJtMt3yGmfR2YyUKCP3WEBhQk05vT6TcPu8kMIFCEpeNFVVRUB2wNpbIuUo69zg+MDjW3AMPwkPYC+BYguqMjGTjOJcaKgcC9toQmrgFL2YHeaTzY31imIcLQRtNhAp6Pj6odxqW4edKofjrBkxzMVbOeHRBedQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+e1HEFLRzUiOqZcQ/2PFH4vsQEHim6WFciYVD9Q7c2o=;
 b=Scu7NcGHR8ShARp5UzBDv2ToP2vUKu92BqyxyUdKRR/vNK8Bd+ydOsN90Pvim/krXfR8qLiscySdAvb5PzaYxWigrzC2LiZtCIl4zAHGiUyoapnvSXs2CzbDDx3XAV3jsu9bk1Si5RrSzJUQ3f/ZZkux8v0x6tc/eZh+POQ1lA4/54uuG5YBQ9vrjl661Cat40zIjp2RwlMoLFu5ELyK42iu6BbW9Zdj+t23bcE7xZXqslCEm9eOERncjjI7dGUwGPysA3JGDajE2RcY6r5dF/wlNbJC1SLSXVQsDJ3/qibX6O01K/g13ols73pca6TF9sS3vVvMk7qmqKY2hRZmHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+e1HEFLRzUiOqZcQ/2PFH4vsQEHim6WFciYVD9Q7c2o=;
 b=FgLWonAPsMQeStbvMl0aaq792w2aUzYxjo9AzJ1nGdqzjzajGFH7ubn4EFoYIqKfqvymFRHyU5Z0W92j0GUlZe+f4ZU2+A7kxvJNN2COoJG1bIzuOx53KJQVCu7nPX8SbkTt+8238WqS8GqhFKAAhSOucQXTAXTBRsish0sJY5o=
Received: from AS4P189CA0055.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:659::22)
 by PA1PR02MB11284.eurprd02.prod.outlook.com (2603:10a6:102:4f7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 10:51:21 +0000
Received: from AM2PEPF0001C70C.eurprd05.prod.outlook.com
 (2603:10a6:20b:659:cafe::e0) by AS4P189CA0055.outlook.office365.com
 (2603:10a6:20b:659::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 10:51:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM2PEPF0001C70C.mail.protection.outlook.com (10.167.16.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 10:51:21 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Wed, 14 Jan
 2026 11:51:20 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] power: supply: wm97xx: Use
 devm_power_supply_register()
In-Reply-To: <aWRPvn_BtqTb768i@venus> (Sebastian Reichel's message of "Mon, 12
	Jan 2026 02:36:46 +0100")
References: <cover.1766270196.git.waqar.hameed@axis.com>
	<883bfa991f977dcda20f9ee6b82782850a0ab100.1766270196.git.waqar.hameed@axis.com>
	<aWRPvn_BtqTb768i@venus>
User-Agent: a.out
Date: Wed, 14 Jan 2026 11:51:20 +0100
Message-ID: <pndikd4tql3.a.out@axis.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70C:EE_|PA1PR02MB11284:EE_
X-MS-Office365-Filtering-Correlation-Id: e4f3f2cd-4aae-4122-6cf2-08de535adabd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IIFTboOviBbTnbWlc6cAOyo/iHouH0MrXpkRgvMY9PNdHrJCQwToYXgNWPpR?=
 =?us-ascii?Q?9fWOr/ShlbEM0kTMUXk2QgYWFsKs6EAkxLMoGw7AfLjYLjWkm7tu7tLDUARU?=
 =?us-ascii?Q?ZIQylS6eET2HKqGQ0kVG4upC2IqPpdTI+KIcIynwnmmU5EYq40G82ZorUjIf?=
 =?us-ascii?Q?PnzjSuDP36pLUOCqmTkOj7uLISdQM5qJ7eZk+5b0b5QATIgjg1ab7Q5DGDOM?=
 =?us-ascii?Q?hjlkUVp1KbH6OIXvHMq0LJqqXLVUBfSVDJnW/Srs1abe8hyffnRryCfKyBS0?=
 =?us-ascii?Q?9hXEC71mRbKKzpgb9zcakKJGWnd241OkbtzWBN3TODlm3Zh1bKrmWhBHusmj?=
 =?us-ascii?Q?zN/BfQdbo537jeRx3/nWpprlfD93ganMOBBr8ox1oqyLyZh5SIi/t9grnA5G?=
 =?us-ascii?Q?7PmYR9jN3m2KDdulFpjBDl7otmVClCw8znqjQi/r1Wv+rBJLoVS+2q6HIkKC?=
 =?us-ascii?Q?RzXBn0eLxKCuH6M79M2RwsYWPLlIid6OuOyf42hrllQh3NO79/E7Vi2MO45M?=
 =?us-ascii?Q?sltwrpES4YsiNmUmQHscBNX/lfw4JiblJJsps86JW/3CYiHWG4kjzqUT03hc?=
 =?us-ascii?Q?iojYywRsiITiyJLTXwQbWBauoZ7Wcuw+7zORA05XjQoQuVSTlztIEgfz8WTC?=
 =?us-ascii?Q?1madAnajbLC899RdIZ26Y8+dXd7OrDEzvMfwae645bmyzcXTJ6RRorguO1is?=
 =?us-ascii?Q?AA0xT/aeyfXcwRVZqsqe4IydzMjmQcV4C+kGUtO0gIQSMoSH7EJx7vizMpl1?=
 =?us-ascii?Q?YV7Bvz1DXhrGYTiB6F0GTxn8CHdYXZlI6ygwZ/hclP67TBOG0LDQXkTssnJs?=
 =?us-ascii?Q?C2LIannOxveVvFyffO0BjCLYcd6P85OO5C7/U50fVn0ErIEAfJ64BVRFtHKW?=
 =?us-ascii?Q?RhsHW7RTlTcx1AD5F0VgMb4yAUTOp6+rsTGjwmdberZHQ7PN4MjWUmZJws0J?=
 =?us-ascii?Q?CeKWGU2w0p+KuJ2pl8ZLzpnCEney8pKLKU91u2AbjURKzOdtRK08rmhTkAc0?=
 =?us-ascii?Q?w4TijPDC6ORunWyUL+FZOB4ONfMKUXZbp7rcnQL3N5BkF2hwupm83kWYHwOY?=
 =?us-ascii?Q?jByfUdVzJTjsnNLCHkanMV9PUFeku84E1pgMBZyjjdHLvPY7BCh7WOALrSiu?=
 =?us-ascii?Q?UfEySw+UFMUGWxW+009e/fP+q7HJVSWhOK/rdEDL3PpvqBF/NVeduGvHW66C?=
 =?us-ascii?Q?25CyNzTqUQFSd/EBftkLYlYVOR1nsFsR2KrL7KnffVLiItDtuaKOUa7G17uu?=
 =?us-ascii?Q?IErIGonKenC9uwNS4Dz+6D5CzCrtjDGaAO9PC+kUsfY7ZiS3CC7fnEZZCE60?=
 =?us-ascii?Q?2rNxt4SDJ8aYz7MJDHmoBIdTMbhE1QGG3Pd6dJoZAFxv6LranQAFOdnUTmIT?=
 =?us-ascii?Q?hp5uKMGZKZzYYBQWbhWee7CRMBa82CxBowca+MC3jkTjX3v855UAgY7zhlAi?=
 =?us-ascii?Q?OF6pOPJIBDb217o/kpOUJg7NiRLsZmPNkR7DBDGG2y8OfbyqulPVThIBZHMQ?=
 =?us-ascii?Q?eGiGe7ntxddVy7jaiYDBtemwh/1XACR5PQl5shp0h8oUKctCG6wXfzUqvbye?=
 =?us-ascii?Q?hRLsiJBFsStASCnrqyDbhTO2FgnhQMx9CmHTSmTqUN+Eaz650mYQhLoQ1qYU?=
 =?us-ascii?Q?uD+2jW9nZSshffjNDokFBTQaSBT6qRkOkWx9K/uKlxgsdY6WwODAzb1QUA2R?=
 =?us-ascii?Q?leh7HQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 10:51:21.4789
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f3f2cd-4aae-4122-6cf2-08de535adabd
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C70C.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR02MB11284

On Mon, Jan 12, 2026 at 02:36 +0100 Sebastian Reichel <sebastian.reichel@collabora.com> wrote:

[...]

>> @@ -257,7 +254,6 @@ static void wm97xx_bat_remove(struct platform_device *dev)
>>  	if (charge_gpiod)
>>  		free_irq(gpiod_to_irq(charge_gpiod), dev);
>>  	cancel_work_sync(&bat_work);
>> -	power_supply_unregister(bat_psy);
>>  	kfree(prop);
>>  }
>
> This free's prop before bat_psy. You fix that in the next patch, but
> to be bisectable those two patches must be swapped.

Ah, of course! Let's swap the patches in v2.

