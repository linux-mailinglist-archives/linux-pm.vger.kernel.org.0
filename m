Return-Path: <linux-pm+bounces-22615-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C488A3F15C
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 11:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD10317FE38
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 10:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D342046A5;
	Fri, 21 Feb 2025 10:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="uMSm8iYz"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2017.outbound.protection.outlook.com [40.92.20.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156331F4299;
	Fri, 21 Feb 2025 10:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740132378; cv=fail; b=A86Goi/b1Qo/rGfaIWF0+hEPt1KBxD6DFPW92AXV/NhM5gx22Vw6uPRXpfeuoOAaKhhNxHXTrA7xO/pDZNO8yyxTcY/Pl+0CZ/arTajLfTTkX5zi9TkGVs5p8dSZiCYxEY3ES+7zC0JNRzqIiGc1T8I/9pmF7v85oNrY9sLXRTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740132378; c=relaxed/simple;
	bh=BeUhUh9uCPxV/P6rPkRwAik973a7bSac7R6Drbpttvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YO9wIAzb1HroYsU9zksKg9xLRkShGSECQCFF3md6DxZdVHBaEV14qStEDMExXQlUY6PTWhGlNNfXDu12szsJfZNORGpK4+86ShWSpu16gRerXbbc+CuPGhqsXu7QQp3CAkAk4GCBY4caHlUGASmXpqQ95/NaCdrDmZ8vSbEf3xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=uMSm8iYz; arc=fail smtp.client-ip=40.92.20.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VA79a2JpNLCHwHMkOJwuBWAHdk/aL/MxvxzpTaC4suhaanz22uVbRe4VI0NVHgszm7Qce6CYaBAYu1Ll+9VPjVXUwLO21CeZK19DTei7JwIlgfgziSiDLuvWAgV9MlHz4PxI3Wif2Eq9xNm8bxtce0/2BmQJU22mN8KwJxdoAtGtPWNlEXlwl48YdDVnUGPq5MvopSL/7MA3C7IRbVmdhSROvOd6EH0an4C6wVJF2fHcHcFP8bB39IKOR9wbqkpZTtfiWmEaTYInJ3nlSP/PXzWreidMAYQvF6hmYXu9olDQgccX+yC8AmtuI290cWIIfOcFtLbV828KNY08USRDHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BeUhUh9uCPxV/P6rPkRwAik973a7bSac7R6Drbpttvw=;
 b=zJW0JbhyIrmZUKtQJuDAFm7hfvQ03iM5Di7shOZI2JYMedEXuR8kvh54OCV6csyYKXeYUsASs5NqYukk0SJBf7yjvj0hUL5BdKgO7C2NFnrEFwDAa+OWK7djlL/Zbyz0rfvAAPUza+2XLiTn2RFf4ALEAStmlHXKSW8BBtsK1Xj2sGbBQ+g4o/a7W4XOON7yaOaCIvTulAa/YV/y+qUvz9jTwpCJyST6LBj+O8297cdJga80AMbsBxQzT5hrauSRuwIGbPGZdsosepnxdwLC58n1D1r/ayf9H2EVuAeO53pBO73gQ8ZmgNNe+D2xtW8md29nk0uEijcu/Cc6Z1Cz7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeUhUh9uCPxV/P6rPkRwAik973a7bSac7R6Drbpttvw=;
 b=uMSm8iYzBhXYmFCc9N99GX1Qw6AJeAsYFdUUYtWEZCfhbXsODGdP5ihPm9Sz/U9sD9c1hBfKNUb49ayZfyyNtMnH5ii1QjjD7sehhnXlbvPtufr0RC9TJ5OtCiDcNHXESbrd+k8ON7VjJv1MC8bcVxvspCXo+TgMO+KtmiUlYhBD7OZz718yOYLgkrXZqz/+0o0z5m5e0K1p62HUt07m9xjqfju/Gv0wSUU5IDJrtKwiDGUSUufPCJeet1pUJFzNTWFJFUUYwZ4iQQGv+zjGvKYsbf8+PTg/YSdOUc7TQyWkOYgp7yEwKQsw/2V/9Gv4KbsiePZ7SXiDC0tnIaJ+KA==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by DS7PR19MB6278.namprd19.prod.outlook.com (2603:10b6:8:99::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 10:06:15 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 10:06:15 +0000
From: George Moussalem <george.moussalem@outlook.com>
To: george.moussalem@outlook.com
Cc: amitk@kernel.org,
	devicetree@vger.kernel.org,
	dmitry.baryshkov@linaro.org,
	krzk+dt@kernel.org,
	krzysztof.kozlowski@linaro.org,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	quic_srichara@quicinc.com,
	robh@kernel.org,
	thara.gopinath@gmail.com
Subject: Re: [PATCH v4 1/5] dt-bindings: nvmem: Add compatible for IPQ5018
Date: Fri, 21 Feb 2025 14:06:08 +0400
Message-ID:
 <DS7PR19MB88831660A8C1CB395634B1FE9DC72@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <DS7PR19MB8883C8E61B02269AAD7D8C1C9DC72@DS7PR19MB8883.namprd19.prod.outlook.com>
References: <DS7PR19MB8883C8E61B02269AAD7D8C1C9DC72@DS7PR19MB8883.namprd19.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX0P273CA0029.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5b::20) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250221100608.16329-1-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|DS7PR19MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: b01623a8-be3d-41d9-5a13-08dd525f5fc5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|5072599009|19110799003|461199028|7092599003|15080799006|440099028|3412199025|4302099013|10035399004|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J9Y871shwyu1ue6/2eH0V7sULvqKixqqRz5O0K9M0SKC6hs1MzNYb/GXks+I?=
 =?us-ascii?Q?/axLBoquuRMwgdXCnSTERnHbRNVzW2lMw2u5byo8Sk6UwKIWdU6BIw2nbWIq?=
 =?us-ascii?Q?MdnR4ZSbuJ1hd4tOESgGAfyi6yrUWkvVxbnRf+KdJfvgiRSlNy3yMF4Zaheo?=
 =?us-ascii?Q?EvMoO5xLU5MBaDs4ItOpaUCkh9eU+//FurjfUq5c8OAmHQwB+Y8Eonf+DEvd?=
 =?us-ascii?Q?WqfM1HsRnI9ENGfoLiFO0uQnrQTPbXIYivNrucCWLA9VQobjivGuc3pcW2Vy?=
 =?us-ascii?Q?XcjliX3O9P1H8bZZ0q+RRwP4GJySVeXzPaGytijzQLe56Erb2Mapsa+h+uWP?=
 =?us-ascii?Q?c1AljiaCQ6V14pVEGJ6Jhao3p/HPm36jseprwpKQjWOdPu9JuNYa4ksNzpeM?=
 =?us-ascii?Q?qW+McGZQ8OsBH52QZBapttqbstlagktd88km9UZZjb3DdDQ94WX0fof8HNgf?=
 =?us-ascii?Q?CguJMzWxdkgb9yIxVb5b93yjcP13WjiIvhB1pVcA7G726BDIwJfxa5/vU40P?=
 =?us-ascii?Q?HGbehlVOsB/EZtyvO7HQAN8MZ7DU97nwvjk2F+te92e8atuKN5tNA/EgPV8s?=
 =?us-ascii?Q?sdH1r4U4tCW62ZyxemwLupmdCuvYyz3gHHAgskuwxw2hrBt2qC88H8fjJESR?=
 =?us-ascii?Q?ww5bhQNFfaed/UrvUvjCu4WLBefvuLETkF4HdjWfYiN7Us2EQBSRvyYKNrvc?=
 =?us-ascii?Q?C1oFU03gpgfntO7usShvY6yNHKnpVHI/BfDYmu54/Kd/rbdJtavSlWxG5axY?=
 =?us-ascii?Q?zl9tMwPMI3j6EdZpwiUxp5Fzp5jGoN5cZHFeb8YVmjHVlWLTVsmDaBnxlL6g?=
 =?us-ascii?Q?VDwFzMaAlSw6RrOJ9V1upgV3Z9PgCYcADSsFN1awKuBBb70ChQSHDpdGJfUK?=
 =?us-ascii?Q?A00oaNur07bbWOdOqnya8+vVEWj8NNNiRT97t8yqesKBHmP2C6PI/vHseTR8?=
 =?us-ascii?Q?XmYjIvT5m2hjr8lU95llNkOoVrJFjgf7V7mx7bDWZ3Q8ysPuzXxPPi/HU8Bp?=
 =?us-ascii?Q?s8un9KCK7kOQ5zqh9aJ5wK4iUcN8vhIyDrhR3cMK1BHH4fgcMYNnTYG40aUN?=
 =?us-ascii?Q?7FZwxIrR7A2j1RCNTsW+Rs1FEZMzDKkEboKMTEPPFzK1eNpW29sSvELgyNL7?=
 =?us-ascii?Q?Yal9j38datKeow2xXV11gv5hTrApbb0HvmJa2tqEz1PtDkH7SizBWWmCp1TP?=
 =?us-ascii?Q?ffBuS4MfYGlaZcYYIry8y/JbMvnpDCZcaM9ZZCKRky0pS6nJYeqY8G07fRcR?=
 =?us-ascii?Q?/QsJfvfcn5pqjcTzzSU0Pv550D99giUyilJRfJGw7Q=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?74wz42QVaSq4Q9e8kV4b5GScMzVxw2g/B1NHbjgFmCw990aa60lpvOJe0Hct?=
 =?us-ascii?Q?zxqbJDJ57ggw0Ap8HMHaZ8LegGBLOlmTwytYOYbnY66yvLOVZUZy/Gzjle2E?=
 =?us-ascii?Q?82vxe3D3FHDgX4acGTIRVuSCXfvUU/tUU2tB7LlAsjhVIlfA9Nn2knht51lA?=
 =?us-ascii?Q?N9sMdgGr3fIm6dvAC+siMUKn4L+9eNJ8q3b7qcxL/Byo/95Kk0scO+f5Gh3i?=
 =?us-ascii?Q?Xnd+OoyeLG01NGJn3kawt6oEtf7/F8ZmKtwA8dioOdqEgX/SEgVd6iERTFDZ?=
 =?us-ascii?Q?1xV0XuTHGrdyEZFqSeVeaV5MSAbQFDRb4RAGc0IydUfryov23YWFEXIkvipo?=
 =?us-ascii?Q?yJYI12HXoruZMlEcm0P94tPujVKaAWKrgEQh0enS5cZBznasH+6oGx743rH9?=
 =?us-ascii?Q?qClWV/q+Kc+x72eUCMLLAFRCwEUOipF5t8pdRjLQLk4IGc7wZ2WsS9IMmCIl?=
 =?us-ascii?Q?2wdfYDNIxefFCpOxgTdVzGvUesfvdlqbm3hEQd5eIqn/YY7nylDqyjR5Orw7?=
 =?us-ascii?Q?GPkFYEo0qsbpSaQGV4t6uiFVkgoM3Rdokxek6/T7MJY6+DzozLvmtqByEIy5?=
 =?us-ascii?Q?bPet6pPpbc0u/uQ0E+p+PHil/ZUt04UI8MKc9KnQOz3Q22pQ/V7/oeEajMUT?=
 =?us-ascii?Q?g7G+XeWZCr1+n/MP4MQCTCRR6+z76fCuty1x7QsOJE0004j6qGI/Cg7wQ8ad?=
 =?us-ascii?Q?pR9cAyI/QH4HWoWKiQOua0+yAfVb8TWfIXxJa7HYHkmRODQ+h3ZVP16Ig3uc?=
 =?us-ascii?Q?sApYUmGmoVvxTYXkZClbiJK3oM4aDXNhHmzu+U6SqLRLL6qH6JQVdPjExxXt?=
 =?us-ascii?Q?/dPw8f6PbqKf9eTMBRadvFdmm3gFQ0CHI7Bfmahir+NJcj8jdHwmtzg1Ncp2?=
 =?us-ascii?Q?nxwcBAavDOp9HESjYJZtcDvMJu0vxftmybCqO36rNqc5utriyVvJwgscl8H4?=
 =?us-ascii?Q?JGQ51J5DKkcDPAJvK0meHhb8Ae/Ek8fkAK6DUnjDz4E5nuxEEgJ7+D/OE+i/?=
 =?us-ascii?Q?+v0DHl4WbCKR2HL7c20D0iv8nK+LpAfd1PeiD1TRXw+B3oRvM86lY561zBpJ?=
 =?us-ascii?Q?M3BYZripqBeLsMVvrOBNfbC11wQ3qd2/z0lhjd64ZHWHNK+pdHuxOFyfHD8s?=
 =?us-ascii?Q?NjNMXaKjhA4tn8kx9Go4c26ssl4Jy29tAXW6dWLvtWd8noTiBv+ZTX4iW9Ce?=
 =?us-ascii?Q?kkPtyHa56Ey+GJOJYQMMaSMudY4tsdtm725rYZ83FVeWq1McGQxLm1DDxeSP?=
 =?us-ascii?Q?JM3ZekkL07Z2WapqZu2q?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b01623a8-be3d-41d9-5a13-08dd525f5fc5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 10:06:14.8586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB6278

I can't speak on behalf of Qualcomm as to whether they've abandoned this chip.
However, there are plenty of routers/APs that use this chip and support for it and some IPQ5018 based devices has recently been added to OpenWrt.
Hence, I'm picking up where Qualcomm has left off and would like to send as much as possible upstream for mainline support.

I've included a cover letter here: https://lore.kernel.org/all/DS7PR19MB8883BE38C2B500D03213747A9DC72@DS7PR19MB8883.namprd19.prod.outlook.com/

