Return-Path: <linux-pm+bounces-19280-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 195BB9F2AB9
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 08:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 477851613FD
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 07:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3851D131E;
	Mon, 16 Dec 2024 07:08:44 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazon11020118.outbound.protection.outlook.com [52.101.227.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E76B1CEACD;
	Mon, 16 Dec 2024 07:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.227.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734332924; cv=fail; b=H0mf3oELWPadOBCov+lZUDGIeeiqeAZzV0OL+HSmuZKEJ2bYBadQbyFCGEx8XRNia5Y6tPH+vc1qMQn6oS6ZXwv/tcS6nMk+ecfiy1E/j9HcM4vJxGtAORJxUptgz361p2DO9MS5OZYLqo3DASubpIyZzwwH3iXCYIWLnsQD438=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734332924; c=relaxed/simple;
	bh=8V/9r63/4iagXBR9OdfGpR80VV3Sm/Ytb4TzFZXRDGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WBN4qoJakSXHVo0Dhnst9XwEAiWwg/smO+MvTblIb0OosTm5WN8lz7+pv7d9qIIBPJuU2MRQq+KURQisvIwcwdPCS+x+t10S/zvlXBwC30eft6vPx7QqU/vZMCSATxp2QzZLUxcqHa+2oBGscR5xeLztr+c87MbSb2uRdiG5pPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=52.101.227.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBwr6cS1DWFxneRdeRoRljqnw8T3Wzn0aKri4TTDm6uy5PxmvEFPc9Yl5sVP1zJuy5WIxJ3AeQ9qnZSQlPg1Je5LMAAdJ3hcSX9TL0rgKlsbMJUVDjCLQqFIcJgkWjgwfb4aEycnNzFA5bYSeKm3US1RH2jiqz7Obu63L7prufrwE72mM6Ge4IfPkAl8XM12ZuuSGcgOtFpQbpwWndNZCGV3Ils5axHwpsZW5oy9CHpJwCnwDODbqqTCoh04pjCCPWAVeeLZ2dAWd7rJd++HE1T+B0WWsmgyKe5mg0a9QLUoVA6v6gszlbIPFiEn1Dzcl/+W9VbwLaOc1s9V7Be3fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mY57XCb0CQWQpt1Erv7rl1zDhq+G9tF+R6nDGFWm1b4=;
 b=KMfW4gr5ynqJj+1amgCMUfP2rXQtFKruAiym+udvnKG7s4zC+4vpuqgacXeppc1AqP6wEJmklV/FzPWs+6cWRWCQD4q5CIor8fHiYVJ49ebXgzYMg4zxfFm6UdkGzQObTud5UumbJbTFNpMmRa6Cy3z9c7ZiS9yF8ppV4fbek5/O3xZ14UMmxBQsucFZZW3aadKzcDH7vprEjnTeZDlrMFaaNlpai0+bq1qC3fnMRbtXXVVf4k+ef5Y9jcS0ppbeLQWkGwTHVG8klZ7C3G59f2aO/Pat/0Ocp7209L1LV1rpcTdd8AKZtYMHQs6GJnVm9ZrSgXAKyNQxGUlVbkDf7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM (2603:1096:c04:1::15d)
 by PN2P287MB1855.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 07:08:37 +0000
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::740f:ab98:2be1:538]) by PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::740f:ab98:2be1:538%4]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 07:08:37 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: sre@kernel.org
Cc: Bhavin Sharma <bhavin.sharma@siliconsignals.io>,
	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v11 2/2] power: supply: Add STC3117 fuel gauge unit driver
Date: Mon, 16 Dec 2024 12:34:55 +0530
Message-Id: <20241216070457.8083-3-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241216070457.8083-1-bhavin.sharma@siliconsignals.io>
References: <20241216070457.8083-1-bhavin.sharma@siliconsignals.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0173.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::17) To PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c04:1::15d)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN2PPFF679F9759:EE_|PN2P287MB1855:EE_
X-MS-Office365-Filtering-Correlation-Id: f61dd97f-ef20-4dec-4264-08dd1da0766b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NSsyaWo1Nm1qWUJyQlNEcUNCWThTYjdDMGZ0bHV6Rm1YUGwwQmlJdi81Nit1?=
 =?utf-8?B?Tk1SQXlNU3lac0MrazdtTGZzK2QwWk9SVGVCVVIwby9GVlhkVFF4OXFHWFNH?=
 =?utf-8?B?RUNDbitUYkRXYjIzOW8ySWZWekFjOWFsZUt6eWl1ZW4vVkw0MHJMdzRGVkx0?=
 =?utf-8?B?K1BvRkJ4YVlnK3hzaSt5MnB5R0tBc3dxNnZLL2RRYTVUcy85MmdXZzhnei8w?=
 =?utf-8?B?TzRwUnMyRmk4ay9uZDhtSUpPRllkbVV4Y2c1a0JtRTZjMU1LU3Z6RjJFa0U4?=
 =?utf-8?B?cVhEUjVXeFE4aW5qRkV4Rnk4Q3I0eWtqQ0xzSEpmU0V5YXM0b2I2ZXF2a2FK?=
 =?utf-8?B?cVMrdEtBN29IMk9MTTNlVmRydEJ6TTg5VjVNbTh4TW4xV3VBalBmdHRkNWg2?=
 =?utf-8?B?RDQ0Sk5aMHNXZ0Q2cC8wZFpWK2F2cTF3WFVGMWVTcWlmMzg5NmIzYm9aSmc2?=
 =?utf-8?B?L01DRktQZHdRRE1GRDVpWGJGVU4vUThVdEVIT2Z1RnRvS2FmMnUxazIzaDBr?=
 =?utf-8?B?SFJlME1rNFZrMmJobmU1aWdUZzVSNXQyejk2c0Q4WU9lKzBvSlVSVzJ0aXBQ?=
 =?utf-8?B?emp6VENrWG81ZmtuTFZmeUl5WnRuVDlzN2tkTGZtK1FLQlluSUZjbWtIWlJ0?=
 =?utf-8?B?Z3ExN216UDRyRytuM1M4MC9iZS9TM3d3TmVYakpHc1ZSWGtvenlBa3VwUVZ0?=
 =?utf-8?B?bmVlZ3NqNkVLL05OTW9sKzJtT2JZb2xqNU9kR0EySVA0azMySmNxWHRNVGkv?=
 =?utf-8?B?ZlRLQWd3bVFocUxQMmtMWGxLLzBFQ1FLSXQxVFdUUHdPR1hqdkZSaFVlN1JP?=
 =?utf-8?B?OTQ2L3ZYbHBaMit2M0luaUUyL2poc1BFVEFDTDJUbXp0SURldXl2enlNbEw4?=
 =?utf-8?B?b1Q0QlB6WHNxK2llVXAxRm1aZzRTdlNQVE1aN0xaOTBFRHo1WFBuaTE5RzFQ?=
 =?utf-8?B?dUJlTk8rMWdOYWRSS21PUTFpQm1HdFc3YW4yMWhsd2pKRDZ6ZWZaUmxSVVFM?=
 =?utf-8?B?UDY3R0FqVGxJNExZSCtwZisydUtwT0NYaGhKSllGRkRabHY4ZkZnaHlwbTlk?=
 =?utf-8?B?b2YydmV1QXg1NDhFc0M4Y1dzQWlJSzh0M3MvY0dzRlBsdXZidlZDRk1NWUFt?=
 =?utf-8?B?cjMyQUhtbjdOUUNHR2RKekFzcXZ1R0ovUjVyazhSZnFyTnRheGlmQUdPSktX?=
 =?utf-8?B?WG9KejZIY0czTGs0N2RMaUdwcXVFWmJyeXBwbXJKN2FKRm9ZNjlidUJrNk4r?=
 =?utf-8?B?MS9lSTc0enhBUUNjbCtIYndHdSt5RHVDNHJxbThYMTZtdzNGYnRFNDJlUWlX?=
 =?utf-8?B?enhzUE0wdVVWc3A1aHlIY09vT2o2QU1TSDg3cGNXMjJjY3VjVWRnK1g3N3Rh?=
 =?utf-8?B?UWx4M2haQkJBd2JuOVRtR1RwK0NUUzEybWpyYU96cDBxRmFKdDJxTWt6cFUr?=
 =?utf-8?B?dDRuOWJPeW9rTTBuNnk4TnJIWUwzOG0rQTBGQ2x3czQvcFRCLzRjcDZKSDBv?=
 =?utf-8?B?Zmsvc1ZTNXNmaXVCZnBKbUpVMUpVeVIzMkN0VXhvNnNNOHY4VUhPRWE5N2Qv?=
 =?utf-8?B?SUNBN2daS2tKQWYvUzZaVEZRbkh0Yk8vWW52R0UyNEJMUDN4ZWE5RmdvYjNm?=
 =?utf-8?B?UG1wV1NiQU9oaWc5dVFtVnlKZkwvU2Rid2tJeS9YdDQwZklEcGxXRVdNMnk3?=
 =?utf-8?B?QnBlUFlwQlJzQUhzd2kzbFdZYkVNaGt3NE02SEFUSDlpSjVDQW9aaUFseUdR?=
 =?utf-8?B?bTBvL3RCempuNTFmZjNGcS90WEVsMzBNcC9MY2RRcHdaZGpKdjBKYUF5SVV0?=
 =?utf-8?B?bm9IcVVyeG5STkl1eHgwWG95RnVmR0ZMbDNUQmRhcDQ1UXlNdUNHSkVWOHdt?=
 =?utf-8?B?QnBWNmhwMlpLaUtMQ3kzak5jZE95amdWRzVXMFQvSldtd1VlaWUvZUdReS9i?=
 =?utf-8?Q?IRX4PHpVjNoy0v45WzqtjA4vXGaOt/Pu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2YrNnMyaHBjaUhscWhZekdwTVZ0OUZVWmdkNVlKakxjcFg5dmpNUUYxOXIv?=
 =?utf-8?B?Z1RxU1BDSmdBbDJVR1pZaXlEeEg5YjVUNUViMHZwbEpuTUloY0NGdFFJR2p6?=
 =?utf-8?B?QWtqcCtFQVluV3RVUHlOVTRHMjdBR0M3VDFadWpINDdra0VDU2hGUlAyV3RZ?=
 =?utf-8?B?TGN0cXN5dkdScE5WSld3RFAvTG5mbWpacWUwTTdKQUhPYzJ0RzZLWlZnU2lp?=
 =?utf-8?B?dGdJdFZnNUVaUm1CZWJwWmIvcmZjYVo5K2c5aDdUWGgxS1BSTjlsMTQ0dFpy?=
 =?utf-8?B?SEVMRXNMVzQxKytNTjJmWkNEcjNkN2hHNk1ZOUN6QWwvVk96enptZlpqM1kw?=
 =?utf-8?B?RkpST1gvNGVieU5aSFNGWTFQeVVka1R4WWh5RWxVbXpIdENldnVYNWdyWmdW?=
 =?utf-8?B?V05wSGluV00wbEtWendTa3hpUkoyNlNwZjdCZUU3VVFJNitYOS9CaXprTVJO?=
 =?utf-8?B?V1dTZUo5ZE5LcVBQZXFHZWxQYXl6K3MvcHA0RVltbjZ3KzhHTmpIWHh5dVow?=
 =?utf-8?B?TnhRdFdsM0RVU1J4U1RuM0hEYkc0aXQ4L1pKZ2VxNFJzK251bmpUaS92K3B0?=
 =?utf-8?B?blhvMm5rR1pyTTR5b1hPTG5xZDljZ0JUSHg3Q2NRZkthbG1KVmx1L3A3QVg0?=
 =?utf-8?B?cC93bUFSYzM2eHFORm1vQlY5bEVyUDh3ZS8ydHlJanZ1WVBLNVFxdFBiakNE?=
 =?utf-8?B?UUxFRTdnSzdRcUhxdldkQUQ1NlhURGhibFZSNllQUnVMbzh1ZVFqN21uZjZD?=
 =?utf-8?B?QzVJekNHTXJRR2NBSHNaSElLbG13ampYM2pFclZMck05eTB3ejkwSjNYbVNM?=
 =?utf-8?B?S2FwNVNJZlZQVXlmbjkrd0xHV2hwelhFek5CU3pwTDhtN1VubGJwbmRoQlhJ?=
 =?utf-8?B?ak1HRVNISkhtZkVUVEo3UG1BWDY3S2g2RFFJdGpKdU0veldBKy9HcGY0cnVG?=
 =?utf-8?B?bDFFS25kc2NWMktkNm1MVU40dHJPRlRDMFhDb3RIa0o1U3EyL3lXandzM3Nq?=
 =?utf-8?B?OFFhOHcvQVgwWHlYM3RjRlpNWXNEZk9jMm5Db2lwbWlCV0xjYU5EcmZjTXpn?=
 =?utf-8?B?eGVjbDNKUmhTY29KMzUyZk43bll4MEw2TTZJcXlseDVmQStOdlFxVUlvOHdM?=
 =?utf-8?B?aVd3OWtXWWRQd2IreSs3UmpnZExVQmh4a1Y5M3ZMdWhJVy9vVmNLS09xZ3RF?=
 =?utf-8?B?TnYxeWVUOCtuS3h1djRITWQ2aDNvNkJhdXZXak5ocnAycVdZYjBCanBiSWZ1?=
 =?utf-8?B?clh5TzhCZTN2enFNT3J4a3hmaEJLbDV4c1lXblphVDZmaDJzeStJTVd1bnJQ?=
 =?utf-8?B?UFEyQ2E4d0lHcHA4bDd0T0c3QTVDcVFmYzFLU0VuUTYvRS9JclBKZFgzV2l5?=
 =?utf-8?B?MG9nVTFpL3Q2Wlc0ckcrS1hqaUJaUi9rN2VyTlRuTXRxc1pPWjVEektuejgr?=
 =?utf-8?B?a1hmdnFTeG9IUEYxbGVCa3l5azgwYVpyS1N5VFBDTFdwRWhmQVRzVmNNc3Bq?=
 =?utf-8?B?R0RYbUVIUDRyRXJLbUZNdW1VTEc2VnhaanM2UWFqWnZaUUpwSFhpd3JqSGxN?=
 =?utf-8?B?bUFNbmFhL3ZibTZwWHJMeGQrd1N0bTZuMFdIU0ROZFVoWlNEcWg5WG56OWU0?=
 =?utf-8?B?VHlUdzluZDNJZXpUVXRlMzJ0UHcyemlzNzBxNERvV05MSFZZc2g3K2E1YllX?=
 =?utf-8?B?OVNHZ1VHQjZ1OEkrdGpCODJpbmdOaHVNNzFIWjdpZ3VSejJaK2pQb2h3S1Y0?=
 =?utf-8?B?Tlh3eTRtYmNYUlBuYklmWXJPZW9QcUhpanNiZ0tUSmk3NjA1dzNkR296QmxF?=
 =?utf-8?B?VjlJdjQzcjhRUng2UTFlQnZKV2d3QjBKd0cwcHh2Umx3dFpld2t4Rjg0U1BK?=
 =?utf-8?B?emJoTGhiYjF5QSs3OXNZaHZRclpHOUU3YVZCVFVnbzZwa3FqZWE4ODc5OVNG?=
 =?utf-8?B?NHFiVmtKOVQ3UkN6OEN1aFFHQnJwK2RhL0wzSVhFQ0o3azFpTXdyeWZWem1Q?=
 =?utf-8?B?SDl4Wk94cDlER1dqQ3VyNkFyeDNENEY1RzYvMHVkL1FoSVpwNDNFRCtSZFd4?=
 =?utf-8?B?dkZGWkNOa0o5S2ZQYWNSK0l1emc2NjZGY0lRQU1TTUd0MGRHcWVRWXlvRzVk?=
 =?utf-8?B?ZEhrYjNrc2VSbjMzUkhHOFQzNFpFVmJhbitzdUppOWIwUTdxYThmLzBESUUw?=
 =?utf-8?Q?sLlnF8N19n40fH1YlCN67qE=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: f61dd97f-ef20-4dec-4264-08dd1da0766b
X-MS-Exchange-CrossTenant-AuthSource: PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 07:08:37.7296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vlAj/U13o5YiLLV7Qrf0R22hd9Vwq/zDyOFZOLxrHvUgJBuOfhyWGyqRAz9ZJq8l6XS+lnWB3mM4FmrkViHavzQlJN0k8JXOcqj67TxHAug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB1855

Adds initial support for the STC3117 fuel gauge.

The driver provides functionality to monitor key parameters including:
- Voltage
- Current
- State of Charge (SOC)
- Temperature
- Status

Co-developed-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
---
 MAINTAINERS                               |   8 +
 drivers/power/supply/Kconfig              |   7 +
 drivers/power/supply/Makefile             |   1 +
 drivers/power/supply/stc3117_fuel_gauge.c | 607 ++++++++++++++++++++++
 4 files changed, 623 insertions(+)
 create mode 100644 drivers/power/supply/stc3117_fuel_gauge.c

diff --git a/MAINTAINERS b/MAINTAINERS
index baf0eeb9a355..6f39801fa952 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22170,6 +22170,14 @@ T:	git git://linuxtv.org/media.git
 F:	Documentation/devicetree/bindings/media/i2c/st,st-mipid02.yaml
 F:	drivers/media/i2c/st-mipid02.c
 
+ST STC3117 FUEL GAUGE DRIVER
+M:	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
+M:	Bhavin Sharma <bhavin.sharma@siliconsignals.io>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/power/supply/st,stc3117.yaml
+F:	drivers/power/supply/stc3117_fuel_gauge.c
+
 ST STM32 FIREWALL
 M:	Gatien Chevallier <gatien.chevallier@foss.st.com>
 S:	Maintained
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 9f2eef6787f7..9349eca4cdd7 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -918,6 +918,13 @@ config FUEL_GAUGE_SC27XX
 	  Say Y here to enable support for fuel gauge with SC27XX
 	  PMIC chips.
 
+config FUEL_GAUGE_STC3117
+       tristate "STMicroelectronics STC3117 fuel gauge driver"
+       depends on I2C
+       help
+         Say Y here to enable support for fuel gauge with STC3117
+         chip.
+
 config CHARGER_UCS1002
 	tristate "Microchip UCS1002 USB Port Power Controller"
 	depends on I2C
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 59c4a9f40d28..b55cc48a4c86 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -108,6 +108,7 @@ obj-$(CONFIG_CHARGER_CROS_USBPD)	+= cros_usbpd-charger.o
 obj-$(CONFIG_CHARGER_CROS_PCHG)	+= cros_peripheral_charger.o
 obj-$(CONFIG_CHARGER_SC2731)	+= sc2731_charger.o
 obj-$(CONFIG_FUEL_GAUGE_SC27XX)	+= sc27xx_fuel_gauge.o
+obj-$(CONFIG_FUEL_GAUGE_STC3117)       += stc3117_fuel_gauge.o
 obj-$(CONFIG_CHARGER_UCS1002)	+= ucs1002_power.o
 obj-$(CONFIG_CHARGER_BD99954)	+= bd99954-charger.o
 obj-$(CONFIG_CHARGER_WILCO)	+= wilco-charger.o
diff --git a/drivers/power/supply/stc3117_fuel_gauge.c b/drivers/power/supply/stc3117_fuel_gauge.c
new file mode 100644
index 000000000000..9215184f0e1f
--- /dev/null
+++ b/drivers/power/supply/stc3117_fuel_gauge.c
@@ -0,0 +1,607 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * stc3117_fuel_gauge.c - STMicroelectronics STC3117 Fuel Gauge Driver
+ *
+ * Copyright (c) 2024 Silicon Signals Pvt Ltd.
+ * Author:      Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
+ *              Bhavin Sharma <bhavin.sharma@siliconsignals.io>
+ */
+
+#include <linux/crc8.h>
+#include <linux/devm-helpers.h>
+#include <linux/i2c.h>
+#include <linux/power_supply.h>
+#include <linux/regmap.h>
+#include <linux/workqueue.h>
+
+#define STC3117_ADDR_MODE                      0x00
+#define STC3117_ADDR_CTRL                      0x01
+#define STC3117_ADDR_SOC_L                     0x02
+#define STC3117_ADDR_SOC_H                     0x03
+#define STC3117_ADDR_COUNTER_L                 0x04
+#define STC3117_ADDR_COUNTER_H                 0x05
+#define STC3117_ADDR_CURRENT_L                 0x06
+#define STC3117_ADDR_CURRENT_H                 0x07
+#define STC3117_ADDR_VOLTAGE_L                 0x08
+#define STC3117_ADDR_VOLTAGE_H                 0x09
+#define STC3117_ADDR_TEMPERATURE               0x0A
+#define STC3117_ADDR_AVG_CURRENT_L             0x0B
+#define STC3117_ADDR_AVG_CURRENT_H             0x0C
+#define STC3117_ADDR_OCV_L                     0x0D
+#define STC3117_ADDR_OCV_H                     0x0E
+#define STC3117_ADDR_CC_CNF_L                  0x0F
+#define STC3117_ADDR_CC_CNF_H                  0x10
+#define STC3117_ADDR_VM_CNF_L                  0x11
+#define STC3117_ADDR_VM_CNF_H                  0x12
+#define STC3117_ADDR_ALARM_soc                 0x13
+#define STC3117_ADDR_ALARM_VOLTAGE             0x14
+#define STC3117_ADDR_ID                        0x18
+#define STC3117_ADDR_CC_ADJ_L			0x1B
+#define STC3117_ADDR_CC_ADJ_H			0x1C
+#define STC3117_ADDR_VM_ADJ_L			0x1D
+#define STC3117_ADDR_VM_ADJ_H			0x1E
+#define STC3117_ADDR_RAM			0x20
+#define STC3117_ADDR_OCV_TABLE			0x30
+#define STC3117_ADDR_SOC_TABLE			0x30
+
+/* Bit mask definition */
+#define STC3117_ID			        0x16
+#define STC3117_MIXED_MODE			0x00
+#define STC3117_VMODE				BIT(0)
+#define STC3117_GG_RUN				BIT(4)
+#define STC3117_CC_MODE			BIT(5)
+#define STC3117_BATFAIL			BIT(3)
+#define STC3117_PORDET				BIT(4)
+#define STC3117_RAM_SIZE			16
+#define STC3117_OCV_TABLE_SIZE			16
+#define STC3117_RAM_TESTWORD			0x53A9
+#define STC3117_SOFT_RESET                     0x11
+#define STC3117_NOMINAL_CAPACITY		2600
+
+#define VOLTAGE_LSB_VALUE			9011
+#define CURRENT_LSB_VALUE			24084
+#define APP_CUTOFF_VOLTAGE			2500
+#define MAX_HRSOC				51200
+#define MAX_SOC				1000
+#define CHG_MIN_CURRENT			200
+#define CHG_END_CURRENT			20
+#define APP_MIN_CURRENT			(-5)
+#define BATTERY_FULL				95
+#define CRC8_POLYNOMIAL			0x07
+#define CRC8_INIT				0x00
+
+DECLARE_CRC8_TABLE(stc3117_crc_table);
+
+enum stc3117_state {
+	STC3117_INIT,
+	STC3117_RUNNING,
+	STC3117_POWERDN,
+};
+
+/* Default ocv curve Li-ion battery */
+static const int ocv_value[16] = {
+	3400, 3582, 3669, 3676, 3699, 3737, 3757, 3774,
+	3804, 3844, 3936, 3984, 4028, 4131, 4246, 4320
+};
+
+static union stc3117_internal_ram {
+	u8 ram_bytes[STC3117_RAM_SIZE];
+	struct {
+	u16 testword;   /* 0-1    Bytes */
+	u16 hrsoc;      /* 2-3    Bytes */
+	u16 cc_cnf;     /* 4-5    Bytes */
+	u16 vm_cnf;     /* 6-7    Bytes */
+	u8 soc;         /* 8      Byte  */
+	u8 state;       /* 9      Byte  */
+	u8 unused[5];   /* 10-14  Bytes */
+	u8 crc;         /* 15     Byte  */
+	} reg;
+} ram_data;
+
+struct stc3117_data {
+	struct i2c_client *client;
+	struct regmap *regmap;
+	struct delayed_work update_work;
+	struct power_supply *battery;
+
+	u8 soc_tab[16];
+	int cc_cnf;
+	int vm_cnf;
+	int cc_adj;
+	int vm_adj;
+	int avg_current;
+	int avg_voltage;
+	int batt_current;
+	int voltage;
+	int temp;
+	int soc;
+	int ocv;
+	int hrsoc;
+	int presence;
+};
+
+struct stc3117_battery_info {
+	int voltage_min_mv;
+	int voltage_max_mv;
+	int battery_capacity_mah;
+	int sense_resistor;
+} battery_info;
+
+static int stc3117_convert(int value, int factor)
+{
+	value = (value * factor) / 4096;
+	return value;
+}
+
+static int stc3117_get_battery_data(struct stc3117_data *data)
+{
+	u8 reg_list[16];
+	u8 data_adjust[4];
+	int value, mode;
+
+	regmap_bulk_read(data->regmap, STC3117_ADDR_MODE,
+			 reg_list, sizeof(reg_list));
+
+	/* soc */
+	value = (reg_list[3] << 8) + reg_list[2];
+	data->hrsoc = value;
+	data->soc = (value * 10 + 256) / 512;
+
+	/* current in mA*/
+	value = (reg_list[7] << 8) + reg_list[6];
+	data->batt_current = stc3117_convert(value,
+			CURRENT_LSB_VALUE / battery_info.sense_resistor);
+
+	/* voltage in mV */
+	value = (reg_list[9] << 8) + reg_list[8];
+	data->voltage = stc3117_convert(value, VOLTAGE_LSB_VALUE);
+
+	/* temp in °C */
+	data->temp = reg_list[10];
+
+	/* Avg current in mA */
+	value = (reg_list[12] << 8) + reg_list[11];
+	regmap_read(data->regmap, STC3117_ADDR_MODE, &mode);
+	if (!(mode & STC3117_VMODE)) {
+		value = stc3117_convert(value,
+			CURRENT_LSB_VALUE / battery_info.sense_resistor);
+		value = value / 4;
+	} else {
+		value = stc3117_convert(value, 36 * STC3117_NOMINAL_CAPACITY);
+	}
+	data->avg_current = value;
+
+	/* ocv in mV */
+	value = (reg_list[14] << 8) + reg_list[13];
+	value = stc3117_convert(value, VOLTAGE_LSB_VALUE);
+	value = (value + 2) / 4;
+	data->ocv = value;
+
+	/* CC & VM adjustment counters */
+	regmap_bulk_read(data->regmap, STC3117_ADDR_CC_ADJ_L,
+			 data_adjust, sizeof(data_adjust));
+	value = (data_adjust[1] << 8) + data_adjust[0];
+	data->cc_adj = value;
+
+	value = (data_adjust[3] << 8) + data_adjust[2];
+	data->vm_adj = value;
+
+	return 0;
+}
+
+static int ram_write(struct stc3117_data *data)
+{
+	int ret;
+
+	ret = regmap_bulk_write(data->regmap, STC3117_ADDR_RAM,
+				ram_data.ram_bytes, STC3117_RAM_SIZE);
+	if (ret)
+		return ret;
+
+	return 0;
+};
+
+static int ram_read(struct stc3117_data *data)
+{
+	int ret;
+
+	ret = regmap_bulk_read(data->regmap, STC3117_ADDR_RAM,
+			       ram_data.ram_bytes, STC3117_RAM_SIZE);
+	if (ret)
+		return ret;
+
+	return 0;
+};
+
+static int stc3117_set_para(struct stc3117_data *data)
+{
+	int ret;
+
+	ret = regmap_write(data->regmap, STC3117_ADDR_MODE, STC3117_VMODE);
+
+	for (int i = 0; i < STC3117_OCV_TABLE_SIZE; i++)
+		ret |= regmap_write(data->regmap, STC3117_ADDR_OCV_TABLE + i,
+			     ocv_value[i] * 100 / 55);
+	if (data->soc_tab[1] != 0)
+		ret |= regmap_bulk_write(data->regmap, STC3117_ADDR_SOC_TABLE,
+				  data->soc_tab, STC3117_OCV_TABLE_SIZE);
+
+	ret |= regmap_write(data->regmap, STC3117_ADDR_CC_CNF_H,
+					(ram_data.reg.cc_cnf >> 8) & 0xFF);
+
+	ret |= regmap_write(data->regmap, STC3117_ADDR_CC_CNF_L,
+					ram_data.reg.cc_cnf & 0xFF);
+
+	ret |= regmap_write(data->regmap, STC3117_ADDR_VM_CNF_H,
+					(ram_data.reg.vm_cnf >> 8) & 0xFF);
+
+	ret |= regmap_write(data->regmap, STC3117_ADDR_VM_CNF_L,
+					ram_data.reg.vm_cnf & 0xFF);
+
+	ret |= regmap_write(data->regmap, STC3117_ADDR_CTRL, 0x03);
+
+	ret |= regmap_write(data->regmap, STC3117_ADDR_MODE,
+					STC3117_MIXED_MODE | STC3117_GG_RUN);
+
+	return ret;
+};
+
+static int stc3117_init(struct stc3117_data *data)
+{
+	int id, ret;
+	int ctrl;
+	int ocv_m, ocv_l;
+
+	regmap_read(data->regmap, STC3117_ADDR_ID, &id);
+	if (id != STC3117_ID)
+		return -EINVAL;
+
+	data->cc_cnf = (battery_info.battery_capacity_mah *
+			battery_info.sense_resistor * 250 + 6194) / 12389;
+	data->vm_cnf = (battery_info.battery_capacity_mah
+						* 200 * 50 + 24444) / 48889;
+
+	/* Battery has not been removed */
+	data->presence = 1;
+
+	/* Read RAM data */
+	ret = ram_read(data);
+	if (ret)
+		return ret;
+
+	if (ram_data.reg.testword != STC3117_RAM_TESTWORD ||
+	    (crc8(stc3117_crc_table, ram_data.ram_bytes,
+					STC3117_RAM_SIZE, CRC8_INIT)) != 0) {
+		ram_data.reg.testword = STC3117_RAM_TESTWORD;
+		ram_data.reg.cc_cnf = data->cc_cnf;
+		ram_data.reg.vm_cnf = data->vm_cnf;
+		ram_data.reg.crc = crc8(stc3117_crc_table, ram_data.ram_bytes,
+					STC3117_RAM_SIZE - 1, CRC8_INIT);
+
+		ret = regmap_read(data->regmap, STC3117_ADDR_OCV_H, &ocv_m);
+
+		ret |= regmap_read(data->regmap, STC3117_ADDR_OCV_L, &ocv_l);
+
+		ret |= stc3117_set_para(data);
+
+		ret |= regmap_write(data->regmap, STC3117_ADDR_OCV_H, ocv_m);
+
+		ret |= regmap_write(data->regmap, STC3117_ADDR_OCV_L, ocv_l);
+		if (ret)
+			return ret;
+	} else {
+		ret = regmap_read(data->regmap, STC3117_ADDR_CTRL, &ctrl);
+		if (ret)
+			return ret;
+
+		if ((ctrl & STC3117_BATFAIL) != 0  ||
+		    (ctrl & STC3117_PORDET) != 0) {
+			ret = regmap_read(data->regmap,
+						STC3117_ADDR_OCV_H, &ocv_m);
+
+			ret |= regmap_read(data->regmap,
+						STC3117_ADDR_OCV_L, &ocv_l);
+
+			ret |= stc3117_set_para(data);
+
+			ret |= regmap_write(data->regmap,
+						STC3117_ADDR_OCV_H, ocv_m);
+
+			ret |= regmap_write(data->regmap,
+						STC3117_ADDR_OCV_L, ocv_l);
+			if (ret)
+				return ret;
+		} else {
+			ret = stc3117_set_para(data);
+			ret |= regmap_write(data->regmap, STC3117_ADDR_SOC_H,
+				     (ram_data.reg.hrsoc >> 8 & 0xFF));
+			ret |= regmap_write(data->regmap, STC3117_ADDR_SOC_L,
+				     (ram_data.reg.hrsoc & 0xFF));
+			if (ret)
+				return ret;
+		}
+	}
+
+	ram_data.reg.state = STC3117_INIT;
+	ram_data.reg.crc = crc8(stc3117_crc_table, ram_data.ram_bytes,
+				STC3117_RAM_SIZE - 1, CRC8_INIT);
+	ret = ram_write(data);
+	if (ret)
+		return ret;
+
+	return 0;
+};
+
+static int stc3117_task(struct stc3117_data *data)
+{
+	int id, mode, ret;
+	int count_l, count_m;
+	int ocv_l, ocv_m;
+
+	regmap_read(data->regmap, STC3117_ADDR_ID, &id);
+	if (id != STC3117_ID) {
+		data->presence = 0;
+		return -EINVAL;
+	}
+
+	stc3117_get_battery_data(data);
+
+	/* Read RAM data */
+	ret = ram_read(data);
+	if (ret)
+		return ret;
+
+	if (ram_data.reg.testword != STC3117_RAM_TESTWORD ||
+	    (crc8(stc3117_crc_table, ram_data.ram_bytes,
+					STC3117_RAM_SIZE, CRC8_INIT) != 0)) {
+		ram_data.reg.testword = STC3117_RAM_TESTWORD;
+		ram_data.reg.cc_cnf = data->cc_cnf;
+		ram_data.reg.vm_cnf = data->vm_cnf;
+		ram_data.reg.crc = crc8(stc3117_crc_table, ram_data.ram_bytes,
+					STC3117_RAM_SIZE - 1, CRC8_INIT);
+		ram_data.reg.state = STC3117_INIT;
+	}
+
+	/* check battery presence status */
+	ret = regmap_read(data->regmap, STC3117_ADDR_CTRL, &mode);
+	if ((mode & STC3117_BATFAIL) != 0) {
+		data->presence = 0;
+		ram_data.reg.testword = 0;
+		ram_data.reg.state = STC3117_INIT;
+		ret = ram_write(data);
+		ret |= regmap_write(data->regmap, STC3117_ADDR_CTRL, STC3117_PORDET);
+		if (ret)
+			return ret;
+	}
+
+	data->presence = 1;
+
+	ret = regmap_read(data->regmap, STC3117_ADDR_MODE, &mode);
+	if (ret)
+		return ret;
+	if ((mode & STC3117_GG_RUN) == 0) {
+		if (ram_data.reg.state > STC3117_INIT) {
+			ret = stc3117_set_para(data);
+
+			ret |= regmap_write(data->regmap, STC3117_ADDR_SOC_H,
+					(ram_data.reg.hrsoc >> 8 & 0xFF));
+			ret |= regmap_write(data->regmap, STC3117_ADDR_SOC_L,
+					(ram_data.reg.hrsoc & 0xFF));
+			if (ret)
+				return ret;
+		} else {
+			ret = regmap_read(data->regmap, STC3117_ADDR_OCV_H, &ocv_m);
+
+			ret |= regmap_read(data->regmap, STC3117_ADDR_OCV_L, &ocv_l);
+
+			ret |= stc3117_set_para(data);
+
+			ret |= regmap_write(data->regmap, STC3117_ADDR_OCV_H, ocv_m);
+
+			ret |= regmap_write(data->regmap, STC3117_ADDR_OCV_L, ocv_l);
+			if (ret)
+				return ret;
+		}
+		ram_data.reg.state = STC3117_INIT;
+	}
+
+	regmap_read(data->regmap, STC3117_ADDR_COUNTER_L, &count_l);
+	regmap_read(data->regmap, STC3117_ADDR_COUNTER_H, &count_m);
+
+	count_m = (count_m << 8) + count_l;
+
+	/* INIT state, wait for batt_current & temperature value available: */
+	if (ram_data.reg.state == STC3117_INIT && count_m > 4) {
+		data->avg_voltage = data->voltage;
+		data->avg_current = data->batt_current;
+		ram_data.reg.state = STC3117_RUNNING;
+	}
+
+	if (ram_data.reg.state != STC3117_RUNNING) {
+		data->batt_current = -ENODATA;
+		data->temp = -ENODATA;
+	} else {
+		if (data->voltage < APP_CUTOFF_VOLTAGE)
+			data->soc = -ENODATA;
+
+		if (mode & STC3117_VMODE) {
+			data->avg_current = -ENODATA;
+			data->batt_current = -ENODATA;
+		}
+	}
+
+	ram_data.reg.hrsoc = data->hrsoc;
+	ram_data.reg.soc = (data->soc + 5) / 10;
+	ram_data.reg.crc = crc8(stc3117_crc_table, ram_data.ram_bytes,
+				STC3117_RAM_SIZE - 1, CRC8_INIT);
+
+	ret = ram_write(data);
+	if (ret)
+		return ret;
+	return 0;
+};
+
+static void fuel_gauge_update_work(struct work_struct *work)
+{
+	struct stc3117_data *data =
+		container_of(work, struct stc3117_data, update_work.work);
+
+	stc3117_task(data);
+
+	/* Schedule the work to run again in 2 seconds */
+	schedule_delayed_work(&data->update_work, msecs_to_jiffies(2000));
+}
+
+static int stc3117_get_property(struct power_supply *psy,
+	enum power_supply_property psp, union power_supply_propval *val)
+{
+	struct stc3117_data *data = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		if (data->soc > BATTERY_FULL)
+			val->intval = POWER_SUPPLY_STATUS_FULL;
+		else if (data->batt_current < 0)
+			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+		else if (data->batt_current > 0)
+			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		else
+			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		val->intval = data->voltage * 1000;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		val->intval = data->batt_current * 1000;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_OCV:
+		val->intval = data->ocv * 1000;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_AVG:
+		val->intval = data->avg_current * 1000;
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		val->intval = data->soc;
+		break;
+	case POWER_SUPPLY_PROP_TEMP:
+		val->intval = data->temp * 10;
+		break;
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = data->presence;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static enum power_supply_property stc3117_battery_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_VOLTAGE_OCV,
+	POWER_SUPPLY_PROP_CURRENT_AVG,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_PRESENT,
+};
+
+static const struct power_supply_desc stc3117_battery_desc = {
+	.name = "stc3117-battery",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.get_property = stc3117_get_property,
+	.properties = stc3117_battery_props,
+	.num_properties = ARRAY_SIZE(stc3117_battery_props),
+};
+
+static const struct regmap_config stc3117_regmap_config = {
+	.reg_bits       = 8,
+	.val_bits       = 8,
+};
+
+static int stc3117_probe(struct i2c_client *client)
+{
+	struct stc3117_data *data;
+	struct power_supply_config psy_cfg = {};
+	struct power_supply_battery_info *info;
+	int ret;
+
+	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->client = client;
+	data->regmap = devm_regmap_init_i2c(client, &stc3117_regmap_config);
+	if (IS_ERR(data->regmap))
+		return PTR_ERR(data->regmap);
+
+	psy_cfg.drv_data = data;
+
+	psy_cfg.fwnode = dev_fwnode(&client->dev);
+
+	crc8_populate_msb(stc3117_crc_table, CRC8_POLYNOMIAL);
+
+	data->battery = devm_power_supply_register(&client->dev,
+						   &stc3117_battery_desc, &psy_cfg);
+	if (IS_ERR(data->battery))
+		return dev_err_probe(&client->dev, PTR_ERR(data->battery),
+					"failed to register battery\n");
+
+	ret = device_property_read_u32(&client->dev, "shunt-resistor-micro-ohms",
+				       &battery_info.sense_resistor);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				"failed to get shunt-resistor-micro-ohms\n");
+	battery_info.sense_resistor = battery_info.sense_resistor / 1000;
+
+	ret = power_supply_get_battery_info(data->battery, &info);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+					"failed to get battery information\n");
+
+	battery_info.battery_capacity_mah = info->charge_full_design_uah / 1000;
+	battery_info.voltage_min_mv = info->voltage_min_design_uv / 1000;
+	battery_info.voltage_max_mv = info->voltage_max_design_uv / 1000;
+
+	ret = stc3117_init(data);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				"failed to initialize of stc3117\n");
+
+	ret = devm_delayed_work_autocancel(&client->dev, &data->update_work,
+					   fuel_gauge_update_work);
+	if (ret)
+		return ret;
+
+	schedule_delayed_work(&data->update_work, 0);
+
+	return 0;
+}
+
+static const struct i2c_device_id stc3117_id[] = {
+	{ "stc3117", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, stc3117_id);
+
+static const struct of_device_id stc3117_of_match[] = {
+	{ .compatible = "st,stc3117" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, stc3117_of_match);
+
+static struct i2c_driver stc3117_i2c_driver = {
+	.driver = {
+		.name = "stc3117_i2c_driver",
+		.of_match_table = stc3117_of_match,
+	},
+	.probe = stc3117_probe,
+	.id_table = stc3117_id,
+};
+
+module_i2c_driver(stc3117_i2c_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>");
+MODULE_AUTHOR("Bhavin Sharma <bhavin.sharma@siliconsignals.io>");
+MODULE_DESCRIPTION("STC3117 Fuel Gauge Driver");
-- 
2.34.1


