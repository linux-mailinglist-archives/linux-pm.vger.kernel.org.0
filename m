Return-Path: <linux-pm+bounces-39050-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CD345C9ACBC
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 10:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E6F14E2B72
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 09:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFF23093DD;
	Tue,  2 Dec 2025 09:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="tnUusfzc"
X-Original-To: linux-pm@vger.kernel.org
Received: from fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com [63.176.194.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38C6309DC4;
	Tue,  2 Dec 2025 09:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=63.176.194.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764666590; cv=fail; b=Sv/ElpbYMfLSUPjp4ozpU9GStslr2+7889Iq8Jm1yG4vRmxQPZbxEynaKG5QgdAN+15k6pGyn0hikSZb/GggicTJhWC0rjvbsTPg6W9kfShSybOYwhjjAxqM/aQKXlNoYCGyhj04bjA/ai9Gy3SIdzvU0zALEnBvaJ7UQx7oIIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764666590; c=relaxed/simple;
	bh=pee/xNvcaWD1VcD1hPOUTmuoHK/fBDZpVUNxu5wJIdA=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jpojc5UHjsALhemUEdT+HE2OtT0EkZfKJwK8G4d0xOAD1/zEXTmi7Vc4c3ugHkKh5J3Ij0pA1anO4vVHVk2iOjK3ielB7pjBkNuG3NZtt2m1CeZkhjhPQwIgrfFQCJhisYSBSginn3krWvctzhvlGJ6Ju+LlpOPtAEJOV4XAIVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=tnUusfzc; arc=fail smtp.client-ip=63.176.194.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1764666587; x=1796202587;
  h=from:to:cc:date:message-id:references:in-reply-to:
   mime-version:content-transfer-encoding:subject;
  bh=XVT60RiKSsqH5Hn/89krf1LRDicMVXOZZNRsCURY5tU=;
  b=tnUusfzciyliwzuH1H6cKupASk7x8PpCXqAJ2f9nVf2/yqejKthGXDEe
   08Rda0umP0Bt22AIp5zjGlNDxnOiQrZ3Efd2ZnpeAkcTzOEue2a0EiJmL
   tmbZOdLSnEsoiVNGK0qEzFidOWbiySOMyakECwLyga88NEIzPVqWWUMZt
   PKTmIgO0yiLN0hkFxoxBY4d7ZjWn2hfPrInH+Z6sQTCKfsKaMI4PlPbE3
   vp4Nqh2rui1Jjxp8f8hmspqBUJwijEGI6QJLu/qxUG9471hEoZv7DVxQR
   H5VJh3T4hynk9k7N2Nu1yeXNEHoIAWSIC3x3n+XfcC1LYKPYU5sP0LzBC
   g==;
X-CSE-ConnectionGUID: oTiZJacMQ4Wx9ds2BY28rg==
X-CSE-MsgGUID: hMzwz7pNQVC5NkRvFZLckA==
X-IronPort-AV: E=Sophos;i="6.20,242,1758585600"; 
   d="scan'208";a="6105330"
Subject: Re: [PATCH 2/2] tools/power/turbostat: Fix division by zero when TDP
 calculation fails
Thread-Topic: [PATCH 2/2] tools/power/turbostat: Fix division by zero when TDP calculation
 fails
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 09:09:28 +0000
Received: from EX19MTAEUA001.ant.amazon.com [54.240.197.233:17791]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.33.168:2525] with esmtp (Farcaster)
 id cd8de5a0-e9c0-4d8f-abad-c80e80297cf9; Tue, 2 Dec 2025 09:09:28 +0000 (UTC)
X-Farcaster-Flow-ID: cd8de5a0-e9c0-4d8f-abad-c80e80297cf9
Received: from EX19EXOEUC001.ant.amazon.com (10.252.51.133) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Tue, 2 Dec 2025 09:09:25 +0000
Received: from EX19EXOEUB002.ant.amazon.com (10.252.51.83) by
 EX19EXOEUC001.ant.amazon.com (10.252.51.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Tue, 2 Dec 2025 09:09:24 +0000
Received: from BEUP281CU002.outbound.protection.outlook.com (10.252.51.94) by
 EX19EXOEUB002.ant.amazon.com (10.252.51.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29
 via Frontend Transport; Tue, 2 Dec 2025 09:09:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tf2Ms3PEBTKEBDqgUm2M6+HzUM/WVcELznWqjPxfeipaoiZFeIG78tndz4xKRSi+XtSWQRrbuRTM6RCdrk6Yjmxcx3Ja4WS0jx3+XfgZ+CyrS9lugibQmYcOfts7yH/cvQl7XYgg+wOVGXY515xwniGJnF58+rSDe2zF4vNIdVmUTJFlvIGr5uqgd0q9H7saqxVKI6m50ibaq+Pi1j1fy7Y6Zlim/b1Kr0N3rqxx2yTUUuA/G5s/zVe9p+LxKnUDmaLXY4hoYhBpYDlqenizIR98JZVrrgBC5wv6iWvB40vkwEFcWm6R+i4u9BteQgiNQD8nLdFeFDDXs3Q7Bax27Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7fJB4U3yEEMidUib6992gTDQmPjXQaHRAptzgTcuFQ=;
 b=tp7XAccISzIBUPq7qXYzMlEwk3lkqOz+UBzm4EiLLb9TPvFvB2R/z7CEoRv3QNL8MehOkbcOdIgaD6CwZ5wZCTt1TfExu9n2Cbkah8gvGVSVsaBl54M7PJygO6ebUtkOQk5c9aRPs5U6m5zIQOhlJqqzmM58tJamaaK72NFowbM0ww5ZGbRuxDBhEZceE+BeadkaTmH4XcYYMqi0sMCdfRTH6YBWX2Zck8kPNdSAL+vWATkHHdwX/s2M0xh23PtiAR/+jKZut4ilRnILetgcJHiETXswZkuO0XrioINmnABAMlLtht6X6v96nzcsPU6KDxCu7RSxbsKtoxmSkM8pJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.de; dmarc=pass action=none header.from=amazon.de;
 dkim=pass header.d=amazon.de; arc=none
Received: from FR2P281MB2685.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:62::10)
 by FR5P281MB4547.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:11a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 09:09:20 +0000
Received: from FR2P281MB2685.DEUP281.PROD.OUTLOOK.COM
 ([fe80::c9:cd39:a76d:1af5]) by FR2P281MB2685.DEUP281.PROD.OUTLOOK.COM
 ([fe80::c9:cd39:a76d:1af5%7]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 09:09:20 +0000
From: "Ehlert, Emily" <ehemily@amazon.de>
To: Len Brown <lenb@kernel.org>
CC: "Zhang, Rui" <rui.zhang@intel.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Emily Ehlert <ehemily@amazon.com>
Thread-Index: AQHcYuUfHRPTFLhV6UW24ebNZtDfyLUNJ6AAgADnUmA=
Date: Tue, 2 Dec 2025 09:09:19 +0000
Message-ID: <FR2P281MB268504A9A1DD29C5BB7F0241BAD8A@FR2P281MB2685.DEUP281.PROD.OUTLOOK.COM>
References: <20251113191609.28574-1-ehemily@amazon.de>
 <20251113191609.28574-2-ehemily@amazon.de>
 <CAJvTdK=_v9q2eGMB6qG3iaDhXMzQHz-EJ4NeDEfBe2fbv+wKfQ@mail.gmail.com>
 <BEYP281MB5509D3D7A01DEC1FAAEB9DBDBADCA@BEYP281MB5509.DEUP281.PROD.OUTLOOK.COM>
 <CAJvTdKnjreryLA9KuuobwJShbVseHOyujmXBAXRuSUDsCZxSVA@mail.gmail.com>
 <BEYP281MB550957A6BA42B6371400472FBADBA@BEYP281MB5509.DEUP281.PROD.OUTLOOK.COM>
 <CAJvTdK=Ty4W=5diU0D0JYHh70ZN4avKjodUoLhuz_D7+=3xcdA@mail.gmail.com>
 <CAJvTdKmr=AVo7UQP28EeD6oLzyeOM+vGCjZZMBo1bV=4n1pcmg@mail.gmail.com>
In-Reply-To: <CAJvTdKmr=AVo7UQP28EeD6oLzyeOM+vGCjZZMBo1bV=4n1pcmg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2P281MB2685:EE_|FR5P281MB4547:EE_
x-ms-office365-filtering-correlation-id: 0f156a48-78ab-48fe-2e0e-08de31827a33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?S9IWg0N/sUmA1qB2XXjBH2J3e+/Gzq6aoqa3gEO23xXtuXWF2+fR7qOSfsqp?=
 =?us-ascii?Q?oPOIoli0Yp8WzSVRaAQauj05IvCmoDuCOmLoiaG0Rtu2BEs/5WVT2ZkoIO9b?=
 =?us-ascii?Q?67OUeJz1lFFgYAs0aUTuHNBrWIyAai1U+EaQcZlzn1MUaW4zA+9P6bMx6SSh?=
 =?us-ascii?Q?ggGWNypcCWBCD4gFs3dgBGw1nlvWo97dMNrpe33hsCBIW1rOLE9dMxMIGkSc?=
 =?us-ascii?Q?Q56mR87nCvJKL+6DnSlnLMdU++ebLi5LGV2MscAwBRLyqTLOYDn28RVlwKvC?=
 =?us-ascii?Q?8K7l3vAbIcCPQGB0u1myZGUqMuTArPeWI05yMe+15J+lLzO3MtbhdrVWLtPs?=
 =?us-ascii?Q?sDs8HoIt9o1NeNUfBD008mP1apnTFpt9ZRsAUeHbD+0gTyZE7ox206k15vTb?=
 =?us-ascii?Q?l7lThAP3nF9krqExtU8R13pq8HiFdRaFgpWlTy/YnbJQQSSmPkC/C6liQITq?=
 =?us-ascii?Q?cIbSAt/9jxgC+jDHx541zO0i3lswrQGA0b7mX9rkAwzqZ2NOde+F6CbD0DPM?=
 =?us-ascii?Q?uFX35qMsnTzcJbabdQweL/iirl0yxZpTUILciAUQwlnHBYCDaPt8ht5RD2z5?=
 =?us-ascii?Q?ksAdGyya+RhzvyB8kTtNZUTvzmQuBpzdu/ROmRTyk9spzNE05MJCwstGXIYD?=
 =?us-ascii?Q?INrCI9uV3Q+i4Sw4Itb8bv07+xcphF1uBN3Cr+ada2E3l3XC4QmDV5Glpw8h?=
 =?us-ascii?Q?l+M9//J8mywBE/Z5wRhJcb8tJlKJs1RtprVqID5Z2Hx2/grnHOcGASJCb5eY?=
 =?us-ascii?Q?el6A+9c7X1OjUWyvOTeDMPfHdVl5KdFeK+w6WLKvTOikbZSBe1H3montI277?=
 =?us-ascii?Q?X9e1tBb3yTKW1cvBQiXl+5Ikq8nUhVFKgbHCRfsNIe4OdGygYgL/v6mWy0Da?=
 =?us-ascii?Q?hn6wwTZjPGgHIMKbPMA3ZcGeLv3VD4s4N7Fdw6Ov1J25D7Ua8+DkEbB9P5le?=
 =?us-ascii?Q?5bIdBKyTUvGZoWYoNVZuMxRgguHvQOLnObdswtAEnrhq4oPxzTblANXaUGv0?=
 =?us-ascii?Q?x+Sq58uUm87At/LrFpDGjKgiD3Xs/BvUF2q0bOk6TCsG+69HsLdc9yW47Wnn?=
 =?us-ascii?Q?zR7gFcixmSqVXAVKrBeHsTyE+Tgp5ZFXejdlovjkTEuwC7G/vEL7WWlMsKh0?=
 =?us-ascii?Q?nAEHoLD2X0Jj2FZkMuUKJnMJOVNnqvHIrpqd0nPDn4KFBp7rox0+KHCZcETD?=
 =?us-ascii?Q?M9WSXbBJTRtPKN0CThNfTtRWk0FU+9FlsEJAPC6NXX9K9/WuJb6ApBhjihil?=
 =?us-ascii?Q?oSufWpDo/y331DzpF2opflnm99VP1L5IruSXXbRAo5swfADiULBQ9LdZli3G?=
 =?us-ascii?Q?3k0vx9h7xIT7zq8/ObStYkd7wiQ+94ylO72+XEomMxDhkkjFJG9apt61rwpy?=
 =?us-ascii?Q?PJN+fr6lDPihPBwIKwOP/ETvZKebHW16u9mtRILQp+c7E7bDPhJnugFej2EB?=
 =?us-ascii?Q?zPGFz2j+CPnMImMhrwjIvYHdpeKE1P1wxlGV56vOMkAm1l8fOooOMufyTuWA?=
 =?us-ascii?Q?5mY2hgPXdA12z0j4F/yGNGHc5awQJzW9uZnc?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2P281MB2685.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hC6BUnykfWWSPWO0WJw22xw8AnJB0j6R/+9YVYgYPG+RPekCVSFFLMxwC/pz?=
 =?us-ascii?Q?GJ7vkv+/5naCDkuUCO33GnnbNQ2yo143dfSe68fyJjWfcbWk18OOyySySjFH?=
 =?us-ascii?Q?iHzk08YHebW6eGE54p5gyw/Jjv9zKzxSTiRofnegptLesGslfARbgvLTgQb7?=
 =?us-ascii?Q?FrXNsiZTo28MDTApyzw2hwpsMQsnxF8iAAu4EV1HnFbTKmaTxKLpZoSxunpI?=
 =?us-ascii?Q?HHIdmziGRfxETxsEtmXy1QnrAVhsicoy16n3BXOzCHTb+I+ZpAwKhkNuPxUi?=
 =?us-ascii?Q?HeOHaGnpTDx+15yiGXjAK+/YpK4M8xxT4WVG60L5YrkavCswr2Z3ipxYVZw/?=
 =?us-ascii?Q?5EBKKsWfV1QuY8eYvkVXXp2Kr5y6vxDCrO37sz5Ixjm6/DeBEhYYzbRo6sQI?=
 =?us-ascii?Q?qnGBaNvSvSMl7xqCjgox3tsJ6R8fV3KxB3yBRitHsEIqu04QdHlplL75NEgs?=
 =?us-ascii?Q?LSbQKa0A2BmwztZGPkIHdX4Q4SoIIYEbv+xUFkEe+HwEikQp9Z0woUv9t+CN?=
 =?us-ascii?Q?bueUbbiPb2vm/+mS/yTr3uSYBZekffEzaXNW/xW/OX57rPqEKZny9F55VZum?=
 =?us-ascii?Q?69bRjdK8BGrmMisCrqYK6YXf5W7V7xNi7CgDOvmGQtG3+pJAiqXIko9zEifE?=
 =?us-ascii?Q?LDGatL1r0o67LGpGA4YEAcK0QqIDPxzArkePVrmh0oGrRt3LzXMfxm/mViTQ?=
 =?us-ascii?Q?YFYDnPz2ijlh20UyBDyVyuOa6mOQEDsMI4npyBwLqQxrZmo+3oIY5OIdnVxQ?=
 =?us-ascii?Q?fSnEf4Ib8WY2vjxsTeCQ4RWwBDnB/gTGfbip5hc8dwPBQ8LJ9mzI2rLFIU2C?=
 =?us-ascii?Q?hSQ+b58vHDGXo7nU2Os5m78x8kp83iHIgiEu8m7ASXupkwQZcMqBcweTI/wv?=
 =?us-ascii?Q?BEacLBuzrUrAQnBTVFM1qBgYR9yNt6dhitEXp93ppnnOXFWy+zRUgMKx5T5Y?=
 =?us-ascii?Q?6nFlUtFGEy4sWJ57QNfJdH1futF86ld4bMrB9S10cBq+rscEVS8ILmHTZD5x?=
 =?us-ascii?Q?RyUtFV3aJ4HgrTKZ+sgpqTAHJ4/YnNHgMgRS0mGngvbYpi/45b03z2zyAGH0?=
 =?us-ascii?Q?VdUjuuyFJ+xYD865DnLVhzJHoj67VRstL1xFZVylsppjzeGFSItKXyRHRhL3?=
 =?us-ascii?Q?kEHw3/7GjMegPhxpy/ILLIrOjLdhNmFApr1jvGZ4a/QO8U9zBKGMR0b0GtFs?=
 =?us-ascii?Q?xr5HThpigXrsdFBcqOAx6bF0r0RQw+FpNdwDc58DLJU2k+R/6JanpTJQFpKK?=
 =?us-ascii?Q?Do3kvCWqHJudAGCo6jOj4HXh+miWtQpxLB46P+lQMjsLtmN7CvQDM9MmxUiw?=
 =?us-ascii?Q?pc+m8dU4Rhmy1c5Z+acQFBveWPJst3l6qT9ugIqohkFVTZcQeeXBKTrib75o?=
 =?us-ascii?Q?EKSMak58sHbBHJnpRJ4VEu0sbsB5/bWVXxO+Ad7V/A1afrctrQCzJp3T36Qj?=
 =?us-ascii?Q?b+cD1sSjABMeZHQ3CVQuAwOUrebCXlcdSHRms7rIpVXZJHkpxQv6UI0TBOh1?=
 =?us-ascii?Q?Kmj0ox341smNNZWdnN58M2768njBOfhZpcw+NnwBNdUVSF5qYr7dQ+9VxQ+v?=
 =?us-ascii?Q?K9ilFHNI3nW1FgWUkg4=3D?=
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR2P281MB2685.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f156a48-78ab-48fe-2e0e-08de31827a33
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2025 09:09:19.8424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p4uRPiXTfSKSdf2BroByi/QPMpnnmP/Q1YUAhOlerqmFcGBaP7wfvP6/fM8fO39wA6x1dD5tLVDaHT3nW283rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR5P281MB4547
X-OriginatorOrg: amazon.de
Content-Transfer-Encoding: quoted-printable

Thanks for the patch. I think there is one small mistake leading to RAPL no=
t being disabled properly if the read is 0. This patch here should fix it a=
nd makes turbostat run with good values.

```
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbos=
tat/turbostat.c
index c2b72b4e80c4..b5da37ce5ac7 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -7986,9 +7986,11 @@ void probe_rapl_msrs(void)
                        fprintf(outf, "Can not read RAPL_PKG_ENERGY MSR(0x%=
llx)\n", (unsigned long long)offset);
                return;
        }
-       if (msr_value =3D=3D 0)
+       if (msr_value =3D=3D 0) {
                if (debug)
                        fprintf(outf, "RAPL_PKG_ENERGY MSR(0x%llx) =3D=3D Z=
ERO: disabling all RAPL MSRs\n", (unsigned long long)offset);
+               return;
+       }

        valid_rapl_msrs =3D platform->plat_rapl_msrs;             /* succes=
s */
 }
```

Log output of turbostat with this patch applied:
```
turbostat version 2025.12.01 - Len Brown <lenb@kernel.org>
Kernel command line: BOOT_IMAGE=3D/vmlinuz-6.14.0-1015-aws root=3DPARTUUID=
=3Dcd553419-794d-4da4-9ba5-c355f5f9f74d ro console=3Dtty1 console=3DttyS0 n=
vme_core.io_timeout=3D4294967295 panic=3D-1
add_counter(msr0, cpuidle/state3/time, C6%, width64, scope0, type3, format2=
, flags2, id0)
add_counter(msr0, cpuidle/state2/time, C1E%, width64, scope0, type3, format=
2, flags2, id0)
find_msrp_by_name: C1E% C6%
add_counter(msr0, cpuidle/state1/time, C1%, width64, scope0, type3, format2=
, flags2, id0)
find_msrp_by_name: C1% C1E%
find_msrp_by_name: C1% C6%
add_counter(msr0, cpuidle/state0/time, POLL%, width64, scope0, type3, forma=
t2, flags2, id0)
find_msrp_by_name: POLL% C1%
find_msrp_by_name: POLL% C1E%
find_msrp_by_name: POLL% C6%
add_counter(msr0, cpuidle/state3/below, C6+, width64, scope0, type0, format=
1, flags2, id0)
find_msrp_by_name: C6+ POLL%
find_msrp_by_name: C6+ C1%
find_msrp_by_name: C6+ C1E%
find_msrp_by_name: C6+ C6%
add_counter(msr0, cpuidle/state3/usage, C6, width64, scope0, type0, format1=
, flags2, id0)
find_msrp_by_name: C6 C6+
find_msrp_by_name: C6 POLL%
find_msrp_by_name: C6 C1%
find_msrp_by_name: C6 C1E%
find_msrp_by_name: C6 C6%
add_counter(msr0, cpuidle/state3/above, C6-, width64, scope0, type0, format=
1, flags2, id0)
find_msrp_by_name: C6- C6
find_msrp_by_name: C6- C6+
find_msrp_by_name: C6- POLL%
find_msrp_by_name: C6- C1%
find_msrp_by_name: C6- C1E%
find_msrp_by_name: C6- C6%
add_counter(msr0, cpuidle/state2/below, C1E+, width64, scope0, type0, forma=
t1, flags2, id0)
find_msrp_by_name: C1E+ C6-
find_msrp_by_name: C1E+ C6
find_msrp_by_name: C1E+ C6+
find_msrp_by_name: C1E+ POLL%
find_msrp_by_name: C1E+ C1%
find_msrp_by_name: C1E+ C1E%
find_msrp_by_name: C1E+ C6%
add_counter(msr0, cpuidle/state2/usage, C1E, width64, scope0, type0, format=
1, flags2, id0)
find_msrp_by_name: C1E C1E+
find_msrp_by_name: C1E C6-
find_msrp_by_name: C1E C6
find_msrp_by_name: C1E C6+
find_msrp_by_name: C1E POLL%
find_msrp_by_name: C1E C1%
find_msrp_by_name: C1E C1E%
find_msrp_by_name: C1E C6%
add_counter(msr0, cpuidle/state2/above, C1E-, width64, scope0, type0, forma=
t1, flags2, id0)
find_msrp_by_name: C1E- C1E
find_msrp_by_name: C1E- C1E+
find_msrp_by_name: C1E- C6-
find_msrp_by_name: C1E- C6
find_msrp_by_name: C1E- C6+
find_msrp_by_name: C1E- POLL%
find_msrp_by_name: C1E- C1%
find_msrp_by_name: C1E- C1E%
find_msrp_by_name: C1E- C6%
add_counter(msr0, cpuidle/state1/below, C1+, width64, scope0, type0, format=
1, flags2, id0)
find_msrp_by_name: C1+ C1E-
find_msrp_by_name: C1+ C1E
find_msrp_by_name: C1+ C1E+
find_msrp_by_name: C1+ C6-
find_msrp_by_name: C1+ C6
find_msrp_by_name: C1+ C6+
find_msrp_by_name: C1+ POLL%
find_msrp_by_name: C1+ C1%
find_msrp_by_name: C1+ C1E%
find_msrp_by_name: C1+ C6%
add_counter(msr0, cpuidle/state1/usage, C1, width64, scope0, type0, format1=
, flags2, id0)
find_msrp_by_name: C1 C1+
find_msrp_by_name: C1 C1E-
find_msrp_by_name: C1 C1E
find_msrp_by_name: C1 C1E+
find_msrp_by_name: C1 C6-
find_msrp_by_name: C1 C6
find_msrp_by_name: C1 C6+
find_msrp_by_name: C1 POLL%
find_msrp_by_name: C1 C1%
find_msrp_by_name: C1 C1E%
find_msrp_by_name: C1 C6%
add_counter(msr0, cpuidle/state1/above, C1-, width64, scope0, type0, format=
1, flags2, id0)
find_msrp_by_name: C1- C1
find_msrp_by_name: C1- C1+
find_msrp_by_name: C1- C1E-
find_msrp_by_name: C1- C1E
find_msrp_by_name: C1- C1E+
find_msrp_by_name: C1- C6-
find_msrp_by_name: C1- C6
find_msrp_by_name: C1- C6+
find_msrp_by_name: C1- POLL%
find_msrp_by_name: C1- C1%
find_msrp_by_name: C1- C1E%
find_msrp_by_name: C1- C6%
add_counter(msr0, cpuidle/state0/usage, POLL, width64, scope0, type0, forma=
t1, flags2, id0)
find_msrp_by_name: POLL C1-
find_msrp_by_name: POLL C1
find_msrp_by_name: POLL C1+
find_msrp_by_name: POLL C1E-
find_msrp_by_name: POLL C1E
find_msrp_by_name: POLL C1E+
find_msrp_by_name: POLL C6-
find_msrp_by_name: POLL C6
find_msrp_by_name: POLL C6+
find_msrp_by_name: POLL POLL%
find_msrp_by_name: POLL C1%
find_msrp_by_name: POLL C1E%
find_msrp_by_name: POLL C6%
add_counter(msr0, cpuidle/state0/above, POLL-, width64, scope0, type0, form=
at1, flags2, id0)
find_msrp_by_name: POLL- POLL
find_msrp_by_name: POLL- C1-
find_msrp_by_name: POLL- C1
find_msrp_by_name: POLL- C1+
find_msrp_by_name: POLL- C1E-
find_msrp_by_name: POLL- C1E
find_msrp_by_name: POLL- C1E+
find_msrp_by_name: POLL- C6-
find_msrp_by_name: POLL- C6
find_msrp_by_name: POLL- C6+
find_msrp_by_name: POLL- POLL%
find_msrp_by_name: POLL- C1%
find_msrp_by_name: POLL- C1E%
find_msrp_by_name: POLL- C6%
cpu 0 pkg 0 die 0 l3 0 node 0 lnode 0 core 0 thread 0
cpu 1 pkg 0 die 0 l3 0 node 0 lnode 0 core 1 thread 0
cpu 2 pkg 0 die 0 l3 0 node 0 lnode 0 core 2 thread 0
cpu 3 pkg 0 die 0 l3 0 node 0 lnode 0 core 3 thread 0
cpu 4 pkg 0 die 0 l3 0 node 0 lnode 0 core 0 thread 1
cpu 5 pkg 0 die 0 l3 0 node 0 lnode 0 core 1 thread 1
cpu 6 pkg 0 die 0 l3 0 node 0 lnode 0 core 2 thread 1
cpu 7 pkg 0 die 0 l3 0 node 0 lnode 0 core 3 thread 1
CPUID(0): GenuineIntel 0x1f CPUID levels
CPUID(1): family:model:stepping 0x6:8f:8 (6:143:8) microcode 0x2b000643
CPUID(0x80000000): max_extended_levels: 0x80000008
CPUID(1): SSE3 MONITOR - - - TSC MSR - HT -
CPUID(6): APERF, TURBO, No-DTS, No-PTM, No-HWP, No-HWPnotify, No-HWPwindow,=
 No-HWPepp, No-HWPpkg, No-EPB
cpu0: MSR_IA32_MISC_ENABLE: 0x00000001 (No-TCC No-EIST No-MWAIT PREFETCH TU=
RBO)
CPUID(7): No-SGX No-Hybrid
CPUID(0x16): base_mhz: 0 max_mhz: 0 bus_mhz: 0
cpu0: MSR_PLATFORM_INFO: 0x80080001800
8 * 100.0 =3D 800.0 MHz max efficiency frequency
24 * 100.0 =3D 2400.0 MHz base frequency
cpu0: MSR_TURBO_RATIO_LIMIT: 0x2020212123242526
cpu0: MSR_TURBO_RATIO_LIMIT1: 0x302e2c2a26221e18
32 * 100.0 =3D 3200.0 MHz max turbo 48 active cores
32 * 100.0 =3D 3200.0 MHz max turbo 46 active cores
33 * 100.0 =3D 3300.0 MHz max turbo 44 active cores
33 * 100.0 =3D 3300.0 MHz max turbo 42 active cores
35 * 100.0 =3D 3500.0 MHz max turbo 38 active cores
36 * 100.0 =3D 3600.0 MHz max turbo 34 active cores
37 * 100.0 =3D 3700.0 MHz max turbo 30 active cores
38 * 100.0 =3D 3800.0 MHz max turbo 24 active cores
cpu0: MSR_CONFIG_TDP_NOMINAL: 0x00000000 (base_ratio=3D0)
cpu0: MSR_CONFIG_TDP_LEVEL_1: 0x00000000 ()
cpu0: MSR_CONFIG_TDP_LEVEL_2: 0x00000000 ()
cpu0: MSR_CONFIG_TDP_CONTROL: 0x00000000 ( lock=3D0)
cpu0: MSR_TURBO_ACTIVATION_RATIO: 0x00000000 (MAX_NON_TURBO_RATIO=3D0 lock=
=3D0)
NSFOD /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver
cpu0: MSR_MISC_PWR_MGMT: 0x00000100 (ENable-EIST_Coordination DISable-EPB E=
Nable-OOB)
cpu0: MSR_IA32_POWER_CTL: 0x00000000 (C1E auto-promotion: DISabled)
C-state Pre-wake: ENabled
cpu0: MSR_PKG_CST_CONFIG_CONTROL: 0x00008000 (locked, pkg-cstate-limit=3D0 =
(pc0))
/dev/cpu_dma_latency: 2000000000 usec (default)
current_driver: intel_idle
current_governor: menu
current_governor_ro: menu
cpu0: POLL: CPUIDLE CORE POLL IDLE
cpu0: C1: MWAIT 0x00
cpu0: C1E: MWAIT 0x01
cpu0: C6: MWAIT 0x20
cpu0: MSR_PKGC6_IRTL: 0x00000000 (NOTvalid, 0 ns)
RAPL_PKG_ENERGY MSR(0x611) =3D=3D ZERO: disabling all RAPL MSRs
cpu0: MSR_MISC_FEATURE_CONTROL: 0x00000000 (L2-Prefetch L2-Prefetch-pair L1=
-Prefetch L1-IP-Prefetch)
add_msr_perf_counter: msr/aperf: 6 (cpu: 0)
add_msr_perf_counter: msr/aperf: 7 (cpu: 1)
add_msr_perf_counter: msr/aperf: 8 (cpu: 2)
add_msr_perf_counter: msr/aperf: 9 (cpu: 3)
add_msr_perf_counter: msr/aperf: 10 (cpu: 4)
add_msr_perf_counter: msr/aperf: 11 (cpu: 5)
add_msr_perf_counter: msr/aperf: 12 (cpu: 6)
add_msr_perf_counter: msr/aperf: 13 (cpu: 7)
add_msr_perf_counter: msr/mperf: 14 (cpu: 0)
add_msr_perf_counter: msr/mperf: 15 (cpu: 1)
add_msr_perf_counter: msr/mperf: 16 (cpu: 2)
add_msr_perf_counter: msr/mperf: 17 (cpu: 3)
add_msr_perf_counter: msr/mperf: 18 (cpu: 4)
add_msr_perf_counter: msr/mperf: 19 (cpu: 5)
add_msr_perf_counter: msr/mperf: 20 (cpu: 6)
add_msr_perf_counter: msr/mperf: 21 (cpu: 7)
add_msr_perf_counter: msr/smi: 22 (cpu: 0)
add_msr_perf_counter: msr/smi: 23 (cpu: 1)
add_msr_perf_counter: msr/smi: 24 (cpu: 2)
add_msr_perf_counter: msr/smi: 25 (cpu: 3)
add_msr_perf_counter: msr/smi: 26 (cpu: 4)
add_msr_perf_counter: msr/smi: 27 (cpu: 5)
add_msr_perf_counter: msr/smi: 28 (cpu: 6)
add_msr_perf_counter: msr/smi: 29 (cpu: 7)
Failed to parse perf counter info /sys/bus/event_source/devices/power/event=
s/energy-pkg.scale
Failed to parse perf counter info /sys/bus/event_source/devices/power/event=
s/energy-pkg.scale
Failed to parse perf counter info /sys/bus/event_source/devices/power/event=
s/energy-cores.scale
Failed to parse perf counter info /sys/bus/event_source/devices/power/event=
s/energy-ram.scale
Failed to parse perf counter info /sys/bus/event_source/devices/power/event=
s/energy-gpu.scale
Failed to parse perf counter info /sys/bus/event_source/devices/power/event=
s/energy-psys.scale
Failed to parse perf counter info /sys/bus/event_source/devices/cstate_core=
/type
Failed to parse perf counter info /sys/bus/event_source/devices/cstate_core=
/type
Failed to parse perf counter info /sys/bus/event_source/devices/cstate_core=
/type
Failed to parse perf counter info /sys/bus/event_source/devices/cstate_core=
/type
Failed to parse perf counter info /sys/bus/event_source/devices/cstate_core=
/type
Failed to parse perf counter info /sys/bus/event_source/devices/cstate_core=
/type
Failed to parse perf counter info /sys/bus/event_source/devices/cstate_core=
/type
Failed to parse perf counter info /sys/bus/event_source/devices/cstate_core=
/type
Failed to parse perf counter info /sys/bus/event_source/devices/cstate_core=
/type
Failed to parse perf counter info /sys/bus/event_source/devices/cstate_core=
/type
Failed to parse perf counter info /sys/bus/event_source/devices/cstate_core=
/type
Failed to parse perf counter info /sys/bus/event_source/devices/cstate_core=
/type
Failed to parse perf counter info /sys/bus/event_source/devices/cstate_core=
/type
Failed to parse perf counter info /sys/bus/event_source/devices/cstate_core=
/type
Failed to parse perf counter info /sys/bus/event_source/devices/cstate_core=
/type
Failed to parse perf counter info /sys/bus/event_source/devices/cstate_core=
/type
Failed to parse perf counter info /sys/bus/event_source/devices/cstate_pkg/=
type
Failed to parse perf counter info /sys/bus/event_source/devices/cstate_pkg/=
type
Failed to parse perf counter info /sys/bus/event_source/devices/cstate_pkg/=
type
Failed to parse perf counter info /sys/bus/event_source/devices/cstate_pkg/=
type
Failed to parse perf counter info /sys/bus/event_source/devices/cstate_pkg/=
type
Failed to parse perf counter info /sys/bus/event_source/devices/cstate_pkg/=
type
Failed to parse perf counter info /sys/bus/event_source/devices/cstate_pkg/=
type
Failed to parse perf counter info /sys/bus/event_source/devices/cstate_pkg/=
type
Failed to parse perf counter info /sys/bus/event_source/devices/cstate_pkg/=
type
Failed to parse perf counter info /sys/bus/event_source/devices/cstate_pkg/=
type
Failed to parse perf counter info /sys/bus/event_source/devices/cstate_pkg/=
type
Failed to parse perf counter info /sys/bus/event_source/devices/cstate_pkg/=
type
Failed to parse perf counter info /sys/bus/event_source/devices/cstate_pkg/=
type
Failed to parse perf counter info /sys/bus/event_source/devices/cstate_pkg/=
type
Failed to parse perf counter info /sys/bus/event_source/devices/cstate_pkg/=
type
Failed to parse perf counter info /sys/bus/event_source/devices/cstate_pkg/=
type
usec    Time_Of_Day_Seconds     Core    CPU     APIC    X2APIC  Avg_MHz Bus=
y%   Bzy_MHz TSC_MHz IPC     IRQ     NMI     SMI     LLCkRPS LLC%hit POLL- =
          POLL            C1-             C1              C1+             C=
1E-            C1E             C1E+            C6-             C6          =
    C6+             POLL%           C1%             C1E%            C6%    =
         CPU%c1  CPU%c6
 1632   1764666333.980537       -       -       -       -       17      0.4=
9    3502    2400    0.08    517     0       0       0       -nan    0     =
          0               0               0               0               3=
               221             59              643             10722       =
    0               0.00    0.00    0.17    99.70   0.35    99.00
  148   1764666333.979303       0       0       0       0       20      0.5=
8    3506    2400    0.12    99      0       0       0       -nan    0     =
          0               0               0               0               0=
               24              11              130             1398        =
    0               0.00    0.00    0.21    99.61   0.30    98.99
   94   1764666333.979428       0       4       1       1       17      0.4=
8    3504    2400    0.12    13      0       0       0       -nan    0     =
          0               0               0               0               0=
               5               2               83              1337        =
    0               0.00    0.00    0.04    99.84   0.30
  169   1764666333.979757       1       1       2       2       17      0.4=
8    3502    2400    0.06    65      0       0       0       -nan    0     =
          0               0               0               0               0=
               10              2               89              1353        =
    0               0.00    0.00    0.07    99.80   0.16    99.22
   93   1764666333.979898       1       5       3       3       16      0.4=
5    3501    2400    0.05    37      0       0       0       -nan    0     =
          0               0               0               0               0=
               5               2               82              1337        =
    0               0.00    0.00    0.04    99.86   0.16
  106   1764666333.980159       2       2       4       4       15      0.4=
4    3498    2400    0.05    25      0       0       0       -nan    0     =
          0               0               0               0               1=
               9               4               30              1288        =
    0               0.00    0.00    0.11    99.80   0.15    99.28
   91   1764666333.980281       2       6       5       5       15      0.4=
3    3499    2400    0.05    29      0       0       0       -nan    0     =
          0               0               0               0               0=
               10              1               35              1290        =
    0               0.00    0.00    0.05    99.86   0.15
  104   1764666333.980417       3       3       6       6       19      0.5=
5    3501    2400    0.08    172     0       0       0       -nan    0     =
          0               0               0               0               1=
               116             29              109             1369        =
    0               0.00    0.00    0.64    99.18   0.78    98.50
   90   1764666333.980537       3       7       7       7       17      0.4=
8    3504    2400    0.08    77      0       0       0       -nan    0     =
          0               0               0               0               1=
               42              8               85              1350        =
    0               0.00    0.00    0.21    99.67   0.78
usec    Time_Of_Day_Seconds     Core    CPU     APIC    X2APIC  Avg_MHz Bus=
y%   Bzy_MHz TSC_MHz IPC     IRQ     NMI     SMI     LLCkRPS LLC%hit POLL- =
          POLL            C1-             C1              C1+             C=
1E-            C1E             C1E+            C6-             C6          =
    C6+             POLL%           C1%             C1E%            C6%    =
         CPU%c1  CPU%c6
 1894   1764666338.987679       -       -       -       -       16      0.4=
7    3501    2400    0.06    370     0       0       0       -nan    0     =
          0               0               0               0               0=
               111             49              449             10553       =
    0               0.00    0.00    0.12    99.76   0.29    99.08
  142   1764666338.986310       0       0       0       0       20      0.5=
8    3501    2400    0.08    134     0       0       0       -nan    0     =
          0               0               0               0               0=
               47              30              113             1389        =
    0               0.00    0.00    0.55    99.27   0.63    98.65
   98   1764666338.986439       0       4       1       1       16      0.4=
6    3497    2400    0.05    8       0       0       0       -nan    0     =
          0               0               0               0               0=
               3               0               69              1326        =
    0               0.00    0.00    0.02    99.89   0.63
  162   1764666338.986756       1       1       2       2       16      0.4=
6    3502    2400    0.06    41      0       0       0       -nan    0     =
          0               0               0               0               0=
               6               0               49              1312        =
    0               0.00    0.00    0.03    99.86   0.08    99.34
   95   1764666338.986903       1       5       3       3       15      0.4=
3    3501    2400    0.05    8       0       0       0       -nan    0     =
          0               0               0               0               0=
               2               0               28              1286        =
    0               0.00    0.00    0.01    99.91   0.08
  109   1764666338.987175       2       2       4       4       16      0.4=
4    3499    2400    0.05    28      0       0       0       -nan    0     =
          0               0               0               0               0=
               2               1               36              1295        =
    0               0.00    0.00    0.02    99.89   0.06    99.38
   94   1764666338.987314       2       6       5       5       15      0.4=
4    3500    2400    0.05    25      0       0       0       -nan    0     =
          0               0               0               0               0=
               1               0               36              1293        =
    0               0.00    0.00    0.01    99.90   0.06
  104   1764666338.987548       3       3       6       6       16      0.4=
7    3503    2400    0.05    76      0       0       0       -nan    0     =
          0               0               0               0               0=
               37              11              57              1321        =
    0               0.00    0.00    0.24    99.64   0.40    98.95
   92   1764666338.987679       3       7       7       7       17      0.4=
9    3507    2400    0.09    50      0       0       0       -nan    0     =
          0               0               0               0               0=
               13              7               61              1331        =
    0               0.00    0.00    0.11    99.75   0.40
usec    Time_Of_Day_Seconds     Core    CPU     APIC    X2APIC  Avg_MHz Bus=
y%   Bzy_MHz TSC_MHz IPC     IRQ     NMI     SMI     LLCkRPS LLC%hit POLL- =
          POLL            C1-             C1              C1+             C=
1E-            C1E             C1E+            C6-             C6          =
    C6+             POLL%           C1%             C1E%            C6%    =
         CPU%c1  CPU%c6
 1824   1764666343.994695       -       -       -       -       16      0.4=
7    3501    2400    0.06    311     0       0       0       -nan    0     =
          0               0               0               0               1=
               86              36              439             10519       =
    0               0.00    0.00    0.09    99.80   0.23    99.15
  169   1764666343.993351       0       0       0       0       21      0.5=
9    3502    2400    0.08    114     0       0       0       -nan    0     =
          0               0               0               0               0=
               52              29              83              1355        =
    0               0.00    0.00    0.49    99.32   0.58    98.70
   93   1764666343.993469       0       4       1       1       16      0.4=
6    3497    2400    0.05    20      0       0       0       -nan    0     =
          0               0               0               0               0=
               7               1               61              1315        =
    0               0.00    0.00    0.04    99.86   0.58
  139   1764666343.993843       1       1       2       2       17      0.4=
7    3503    2400    0.05    60      0       0       0       -nan    0     =
          0               0               0               0               0=
               5               0               68              1332        =
    0               0.00    0.00    0.03    99.85   0.10    99.30
   95   1764666343.993969       1       5       3       3       15      0.4=
4    3501    2400    0.05    11      0       0       0       -nan    0     =
          0               0               0               0               0=
               3               1               39              1293        =
    0               0.00    0.00    0.03    99.88   0.10
  103   1764666343.994201       2       2       4       4       17      0.4=
8    3499    2400    0.06    67      0       0       0       -nan    0     =
          0               0               0               0               1=
               10              3               94              1351        =
    0               0.00    0.00    0.07    99.80   0.14    99.26
   92   1764666343.994334       2       6       5       5       15      0.4=
2    3497    2400    0.05    7       0       0       0       -nan    0     =
          0               0               0               0               0=
               1               0               57              1314        =
    0               0.00    0.00    0.00    99.91   0.14
  107   1764666343.994572       3       3       6       6       15      0.4=
4    3502    2400    0.05    21      0       0       0       -nan    0     =
          0               0               0               0               0=
               6               1               19              1280        =
    0               0.00    0.00    0.05    99.86   0.09    99.33
   95   1764666343.994695       3       7       7       7       16      0.4=
4    3504    2400    0.07    11      0       0       0       -nan    0     =
          0               0               0               0               0=
               2               1               18              1279        =
    0               0.00    0.00    0.02    99.88   0.09
usec    Time_Of_Day_Seconds     Core    CPU     APIC    X2APIC  Avg_MHz Bus=
y%   Bzy_MHz TSC_MHz IPC     IRQ     NMI     SMI     LLCkRPS LLC%hit POLL- =
          POLL            C1-             C1              C1+             C=
1E-            C1E             C1E+            C6-             C6          =
    C6+             POLL%           C1%             C1E%            C6%    =
         CPU%c1  CPU%c6
 1754   1764666349.001690       -       -       -       -       17      0.4=
8    3500    2400    0.06    430     0       0       0       -nan    0     =
          0               0               0               0               0=
               87              39              532             10614       =
    0               0.00    0.00    0.09    99.79   0.22    99.15
  146   1764666349.000359       0       0       0       0       18      0.5=
2    3498    2400    0.06    69      0       0       0       -nan    0     =
          0               0               0               0               0=
               5               5               74              1344        =
    0               0.00    0.00    0.07    99.80   0.16    99.19
   96   1764666349.000500       0       4       1       1       17      0.4=
7    3499    2400    0.05    32      0       0       0       -nan    0     =
          0               0               0               0               0=
               6               2               62              1315        =
    0               0.00    0.00    0.04    99.85   0.16
  128   1764666349.000765       1       1       2       2       17      0.4=
8    3502    2400    0.06    59      0       0       0       -nan    0     =
          0               0               0               0               0=
               1               0               72              1338        =
    0               0.00    0.00    0.00    99.87   0.49    98.83
   95   1764666349.000902       1       5       3       3       18      0.5=
2    3505    2400    0.07    99      0       0       0       -nan    0     =
          0               0               0               0               0=
               58              27              64              1324        =
    0               0.00    0.00    0.46    99.37   0.49
  112   1764666349.001167       2       2       4       4       17      0.4=
8    3498    2400    0.06    73      0       0       0       -nan    0     =
          0               0               0               0               0=
               6               2               89              1346        =
    0               0.00    0.00    0.05    99.82   0.11    99.29
   93   1764666349.001306       2       6       5       5       15      0.4=
3    3498    2400    0.05    16      0       0       0       -nan    0     =
          0               0               0               0               0=
               1               0               57              1314        =
    0               0.00    0.00    0.00    99.91   0.11
  108   1764666349.001574       3       3       6       6       17      0.4=
8    3502    2400    0.06    61      0       0       0       -nan    0     =
          0               0               0               0               0=
               6               2               74              1332        =
    0               0.00    0.00    0.04    99.83   0.10    99.27
   90   1764666349.001690       3       7       7       7       16      0.4=
5    3503    2400    0.07    21      0       0       0       -nan    0     =
          0               0               0               0               0=
               4               1               40              1301        =
    0               0.00    0.00    0.02    99.88   0.10
usec    Time_Of_Day_Seconds     Core    CPU     APIC    X2APIC  Avg_MHz Bus=
y%   Bzy_MHz TSC_MHz IPC     IRQ     NMI     SMI     LLCkRPS LLC%hit POLL- =
          POLL            C1-             C1              C1+             C=
1E-            C1E             C1E+            C6-             C6          =
    C6+             POLL%           C1%             C1E%            C6%    =
         CPU%c1  CPU%c6
 1978   1764666354.008912       -       -       -       -       17      0.4=
8    3499    2400    0.06    410     0       0       0       -nan    0     =
          0               0               0               0               0=
               108             43              556             10701       =
    0               0.00    0.00    0.11    99.77   0.26    99.09
  141   1764666354.007538       0       0       0       0       20      0.5=
6    3499    2400    0.06    100     0       0       0       -nan    0     =
          0               0               0               0               0=
               45              22              65              1341        =
    0               0.00    0.00    0.40    99.44   0.46    98.83
  102   1764666354.007684       0       4       1       1       17      0.5=
0    3497    2400    0.05    55      0       0       0       -nan    0     =
          0               0               0               0               0=
               4               1               73              1328        =
    0               0.00    0.00    0.04    99.84   0.46
  135   1764666354.007989       1       1       2       2       16      0.4=
6    3499    2400    0.06    44      0       0       0       -nan    0     =
          0               0               0               0               0=
               5               1               51              1314        =
    0               0.00    0.00    0.03    99.86   0.20    99.18
  111   1764666354.008132       1       5       3       3       16      0.4=
7    3499    2400    0.05    46      0       0       0       -nan    0     =
          0               0               0               0               0=
               25              8               40              1296        =
    0               0.00    0.00    0.16    99.73   0.20
  107   1764666354.008362       2       2       4       4       18      0.5=
1    3501    2400    0.07    80      0       0       0       -nan    0     =
          0               0               0               0               0=
               14              6               141             1411        =
    0               0.00    0.00    0.14    99.73   0.24    99.12
   97   1764666354.008502       2       6       5       5       16      0.4=
5    3499    2400    0.05    20      0       0       0       -nan    0     =
          0               0               0               0               0=
               3               0               117             1379        =
    0               0.00    0.00    0.02    99.89   0.24
  109   1764666354.008776       3       3       6       6       17      0.4=
8    3501    2400    0.06    47      0       0       0       -nan    0     =
          0               0               0               0               0=
               6               1               41              1325        =
    0               0.00    0.00    0.04    99.85   0.15    99.22
   97   1764666354.008912       3       7       7       7       16      0.4=
6    3500    2400    0.07    18      0       0       0       -nan    0     =
          0               0               0               0               0=
               6               4               28              1307        =
    0               0.00    0.00    0.08    99.82   0.15

```

________________________________________
From: Len Brown <lenb@kernel.org>
Sent: Monday, December 1, 2025 8:14 PM
To: Ehlert, Emily
Cc: Zhang, Rui; linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; Emi=
ly Ehlert
Subject: RE: [EXTERNAL] [PATCH 2/2] tools/power/turbostat: Fix division by =
zero when TDP calculation fails

CAUTION: This email originated from outside of the organization. Do not cli=
ck links or open attachments unless you can confirm the sender and know the=
 content is safe.



> I'll send you a patch for this later today.

Please try the latest turbostat in my public tree:
git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat

The top commit should be this:

commit 4b295ae45d3e6eb4d811c8fc2408b9e4e91c9474 (turbostat, next)
Author: Len Brown <len.brown@intel.com>
Date:   Sun Nov 30 00:11:22 2025 -0500

    tools/power turbostat: Validate that RAPL MSRs really exist

    Even though the platform->plat_rapl_msrs enumeration may be accurate,
    a VM may deny access to the underlying MSRs.

    Probe if PKG_ENERGY is readable and non-zero.
    If no, ignore all RAPL MSRs.

    Reported-by: Emily Ehlert <ehemily@amazon.de>
    Signed-off-by: Len Brown <len.brown@intel.com>



Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Christof Hellmis
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


