Return-Path: <linux-pm+bounces-22788-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3F0A41A7C
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 11:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEEE93A392F
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 10:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D744F24BBF0;
	Mon, 24 Feb 2025 10:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="LD5c8jAZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2013.outbound.protection.outlook.com [40.92.21.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2908D24A069;
	Mon, 24 Feb 2025 10:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740392085; cv=fail; b=s62/fgXSRZ8KklvULYZGMup3HITy3JQ8XDNTlkEf4fWfij1TFF4mG+t1VR0/bt/ebmkj0L13+Jd7ehIfNW/FBWovBM4JwjFJ+hEdz9PJRjoN6oUyOzgWBbunEMWnzTGK+5BiMEKB9OwKMQy3/WgiqWY6L9anS6AYxTJYb2GsACQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740392085; c=relaxed/simple;
	bh=Y6Q4JEvynCfWkAUdGUArIplh4eQCmCPANUpLO4VTLjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dAO/GBPM4zIWRceOHdV13ySNqAom7lFv/blOKvbz+BddWWjSmQyS9BOPfKThg1JWuhTRtUAmYKviYimci90QoLTTQyJyQrzUa8XIc/bA5ULm6XADBkaUMpqOW4sUjsVAbLYHbOaDus10mVjgtkVoLfaKzCkbTfC8FWxo6Q3tEx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=LD5c8jAZ; arc=fail smtp.client-ip=40.92.21.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W2Q4R0LWHWe9UwRPr5DZ3Xjud83brkz+8MdLU38Q4oK2aiiY3xly1kq3xd10+eltdlMjVvFtpQz1YyGxyHfFM7/mfW4Z96ZyKJDa8gR2TyFGa502usHDE2MmZLSoHXDhlxapIjg2FdJXEzVY1HglRjWINxAXGQ/+91wu+aOcjCeocHwZOiPu6vz84jFx1QEC0an6aY6/ktOBf0o5MiGWU/oBXz7tZPZMTxI+dyGFxLpCuQBliJqd181Ixpj0SjLApP70kYwGhbEtwmbcZTIDFINThlDNYz+Olrrp7/yUM4dqBNa44LcCwJxpnpU3DRUDIK/BIhBgvG69BNH5xhQ4Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y6Q4JEvynCfWkAUdGUArIplh4eQCmCPANUpLO4VTLjY=;
 b=AfNRW1NHRCX67xXnxkz0bvkAlZu0QiJT93v0DGdIccol1qruGDwAAjfMQbainz7h1NfXQ9ROJnY/SSBYea42euH3rFfNBhWmUvPU366yTnRyjC4gdulrFbzBdAQIcS520nogGw02H/wpjikZWK4aNQTox5PEpvBaDBL9HIgikpf5zt64/MVKQUnxH3KL4gSVsRHEd7TXM8Hjxxui0Dt//tmmgBhKdy2N1jr6jzuR7GPnPtvvcl34zUzRPDdRzvAWMT3cs3eTdzs2wv+aB4+eIJ0wd0hI3hyUGnKlibd2nP47dqZVMElfi/KwI8wLGRXfAc+wvx/ejYIDgA6VWlStDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6Q4JEvynCfWkAUdGUArIplh4eQCmCPANUpLO4VTLjY=;
 b=LD5c8jAZn2SASAEKQsy+i6h3OvMUvftaa9uI+gEXavQTC8YD4s59rf6QDyT/wtblEanCy4SLoMeC0ko3ImkFzd44I63Dja/X8wYm3TPW7ACaIzumADy5juIEjadsRKxNuU+5LzqGSYovvHea+Ml0mwhdnzWuJwLzefhYqmtteChLw+u9JaHuoEhMImnpdsTGLB/pf7QZJrgshwZwIV8rPPyiLKD6WdwaZqr3q+lAwHDExiz1fAVG+/Epil9JWHr0mCb+HU6woT8DYLGmOF+gn/OGitHk3TwAzgk3bv/vTvyENyfbEB7xgkfYQuHwLS85Be3Rw3HxA8Q3JK+YmqP0nw==
Received: from BL4PR19MB8902.namprd19.prod.outlook.com (2603:10b6:208:5aa::11)
 by MW3PR19MB4220.namprd19.prod.outlook.com (2603:10b6:303:45::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 10:14:41 +0000
Received: from BL4PR19MB8902.namprd19.prod.outlook.com
 ([fe80::b62f:534e:cf19:51f4]) by BL4PR19MB8902.namprd19.prod.outlook.com
 ([fe80::b62f:534e:cf19:51f4%7]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 10:14:40 +0000
From: George Moussalem <george.moussalem@outlook.com>
To: krzk@kernel.org
Cc: amitk@kernel.org,
	devicetree@vger.kernel.org,
	dmitry.baryshkov@linaro.org,
	george.moussalem@outlook.com,
	krzk+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	quic_srichara@quicinc.com,
	robh@kernel.org,
	thara.gopinath@gmail.com
Subject: Re: [PATCH v6 0/5] Add support for IPQ5018 tsens
Date: Mon, 24 Feb 2025 14:14:32 +0400
Message-ID:
 <DS7PR19MB88832437987FE85662A878149DC02@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <ca812748-8ec2-41f3-8272-5e774f764493@kernel.org>
References: <ca812748-8ec2-41f3-8272-5e774f764493@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX0P273CA0014.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:26::19) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250224101432.26042-1-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR19MB8902:EE_|MW3PR19MB4220:EE_
X-MS-Office365-Filtering-Correlation-Id: b6dab7e8-f452-4b68-4eab-08dd54bc0c01
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|19110799003|15080799006|7092599003|8060799006|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nsfv5tmX8AuZbQWCuqzGQZvKKw26DgptcDy1wSDNBD7XfU5Kw5oBVIXZAKdk?=
 =?us-ascii?Q?zW2t+pRrky0yMFhNa4WzVtvcwN3dhlXpOw9vqfnvoBV25WNJyXCAqZoo4Hec?=
 =?us-ascii?Q?SrB5bhrLXnKCkSMnhT93aSOveygTr/T1ugdSVEq9qmFqAK9dtkuX6UieqzoR?=
 =?us-ascii?Q?aOkBdoEuY3SgdJFD2GY0kC6x5CD/yZE1Oja7QF8eXQgd5KXF5Pz7dV6gG8yR?=
 =?us-ascii?Q?SS6GU/YPd7VnshAbGcZWFYw82H/fRBTHY0/ciPg4LiTHQscCpvYq1gzFyYJP?=
 =?us-ascii?Q?8f82o0G4cdEv7+uDju3wKKUYAvNcwGBgEp4+i55dBNPgs49eLwBBfYYE9iRS?=
 =?us-ascii?Q?evgoqawwQpfhw88Q4QBUL+EVYYLzf3akoBP+joAMX+OMCKKHqy1mYKii3Yno?=
 =?us-ascii?Q?MDBjHF4LrtykPw+wF5cvQSqkjKtwef8wVt5vMfC0H5kadheOSc/1GFGgk6mo?=
 =?us-ascii?Q?/o2VODzLQUqd38WQQKGe331dklxM2O0e4lPB4Tqt90v9p1ipFe8vVdZH/xK7?=
 =?us-ascii?Q?1hoVNJgRDLldfA07gC2rA7yx8GjER8jHY0rvBvx5t4BrEZejwxiWONuNWdj6?=
 =?us-ascii?Q?Z2MtJCPd8OWitB7IisXu/a4BWfIt043hqCUysBxQYEufovd+O9FWF3EbvVnW?=
 =?us-ascii?Q?Ta58XLe4PoeYPtUm456jAzSM4/mP9nl/8TqY0RLZ979l+M0H7TrhWwvmAQxz?=
 =?us-ascii?Q?q0g6vta5s+XA+aGTCyKZge2wFGLzhsaLotrcuLFcWX/jXRAQVPp5jDkBM8jJ?=
 =?us-ascii?Q?idPASE83X9i763qn8BSXIb+SymilbeBEsjVaJtZ1BHjr5j48WAFqlzfGKHrl?=
 =?us-ascii?Q?q+w8F2Vtx4oE4dTr37Cp32dcFrW8Z6dYLQNUVk5eMmK3Hok1CUDWAa9dH3f7?=
 =?us-ascii?Q?ZOp3M/W2/DkLavfSWy12daZVL1WtdFZ6rFYlSVvy3g1awHH0KvxjxQ8mYkqc?=
 =?us-ascii?Q?LLSvVQlUKFLNGtN0hl29pzpSMNMNiHbsRc3zUctwktvX0vgmbonavwzwIXUj?=
 =?us-ascii?Q?Zwm5Jifg9JVuMeO34B68BB9en3opQ7dLtCLrN9jDt7qzO4Qr5Kv7OJc+YXSY?=
 =?us-ascii?Q?4+1/XgqtdLRyAnahupDLhbX+ZZgVpxkTABEU2QRJPeQhuzUjn64=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+WVKn9sP3UBK1KliOhPI4TQrp+nk9jD6pBHd6MiPix/hcAWoB+hGyO0hieMf?=
 =?us-ascii?Q?xyYcGEvMW7SCD0D1P0FrSs12OROMSKHTK9QWNUZVyUOxooz2g9PA3G0DeuLO?=
 =?us-ascii?Q?5MlT/lCjp900Plnx7aoORM4X1psiLfKNWROQ/+SWuashp3hU/eYgpchcMCe3?=
 =?us-ascii?Q?vGlIagJhhmb9GSTu+FysPXMhlTTaw7tOGElGF1OnHF6iILyX3Ja1hN0CTLLU?=
 =?us-ascii?Q?EJvNnOQwfD40iWBoOUObjSel07ytWOf/BfX1MCJoywuqkszhniw/+a++aNl/?=
 =?us-ascii?Q?Po8RMqIKrbtFMjDakTSVytyRa/qT9SWkyU4vCh03PKJ2iLGGpac/SXmOfODR?=
 =?us-ascii?Q?+RFALaHWjsGUSKBIoM6mNX+IiJk2xZ+FNbuRDBj+rDVxFxaxMfqOlMbIuyBp?=
 =?us-ascii?Q?fCR/cU8AQZfR60sx5CWIaW4kYPHiI88mb8I2VGey9XxRPqVhZzYLWNQrzukb?=
 =?us-ascii?Q?3W89l2MqD9/8X6/nBnB45GzK6lA4EaByfR8vm0zBQK/HyhJswfkHxXnHav0U?=
 =?us-ascii?Q?nnM8w3lvyyX1G6Hn2AGJ/TTyJB5pNbb1yO7DjZomMWsxKY2smrQJkSUZByCk?=
 =?us-ascii?Q?CR3RRpJUHh/sX8sw8+bu6QREndxzvvS/NhCnGc+4fDoodHnLUDfXxiRLnwKY?=
 =?us-ascii?Q?JoZFcVMsEiQPmPj2LyaNKO7Zd66TleIAfP2BX/u+XtklFFb6BOAY19dU6RjC?=
 =?us-ascii?Q?xp4OJWOvvXtDVX1KfmLdGj8vG8k9C6vUcw+/baMWx1trs5cc4D5xgVWuCK7o?=
 =?us-ascii?Q?SmgpwmYieaJOARDoTcZ6nocVS1r4PbI3Ql15imu1XPHvj13PGYLEztpWAf6t?=
 =?us-ascii?Q?mVnAwIExOmukPs87QYTFUcW32jDVW6nXuARAy23GjOmbsJP7UvQ+a1A1sUGi?=
 =?us-ascii?Q?+EUhy+zDi0YdqUjRWaKPJhytN//3bI5ljl7ZJ5U4JFP9frNmnPdDAE/baFbu?=
 =?us-ascii?Q?r7f+VEzQWF/IudDE6rYjAesSzpmv4TVT6wQNdWwbI9OmfXmThB6MXu0KP9qD?=
 =?us-ascii?Q?z3ekm7OGQCZdbbs7COoPc3m6vmhGfpsgOiwglWloVVN+vlkiPSS7PYURBtE0?=
 =?us-ascii?Q?g2CEBvJW8gphvsoEJ1r3JyIFqCmww1poeZ+Lw2eCK5RVXqhv9Cn8Tn2xoqFW?=
 =?us-ascii?Q?zPHORtns5hxoy8UMA06K+kMUsaj0Jvia/LyhqR2wwqefgF9v4ZAqIPcwrDNf?=
 =?us-ascii?Q?/RhLp9tTjnXdWiPSQB146IplcpJtnXWGo+DzndaJWWni99UILv30LDhx8bxP?=
 =?us-ascii?Q?BLfIAhs3az2Bf4EcY7w8?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6dab7e8-f452-4b68-4eab-08dd54bc0c01
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 10:14:40.8517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR19MB4220

Thanks Krzysztof, circling back to acknowledge the feedback.
Missed it, but will add the reasoning in the next version.

Best regards,
George

