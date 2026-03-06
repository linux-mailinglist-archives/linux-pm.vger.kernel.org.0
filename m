Return-Path: <linux-pm+bounces-43845-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCtzD0LuqmmOYAEAu9opvQ
	(envelope-from <linux-pm+bounces-43845-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 16:09:54 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B47223826
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 16:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 31EE630013BE
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 15:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6063B4E83;
	Fri,  6 Mar 2026 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Ly2LqbdH";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Ly2LqbdH"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013035.outbound.protection.outlook.com [40.107.162.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BA2387582;
	Fri,  6 Mar 2026 15:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.35
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809787; cv=fail; b=piQ9niu/LESwCTzX26eqBL456ostHbD4tCorj6QXbM1J8wHs+H3jbN2YLIoLnwdaBXSCXKxl07toLqmL2hfCACYqiN0uTEycAbih2p9kzLQblQaD2WeEw0p+M/JjtFplZOFe5bzdmORfpHaL5SujIYw436i4IB3q6G8bBnsojTM=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809787; c=relaxed/simple;
	bh=TOJfZhc0MykByWbiKoADWVFwfOfxuKsPiUvyV2cWcz0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QBnNzS1Ca9joE3Uy9eY/CwYjzaXJMOCY+JRnpst6SxhPm7I2DjP9zsrSC/3qneoSV/icZD8+Em5Intg8kV7hVLBDmJIkEuEXm5jzSha+nDkxT2jN9Vmu0ZgUHRQrgHy6xQ1Ewpeu0chkCiJtlReHDzp1qlLgZSXJWLMBwH3zxbI=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Ly2LqbdH; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Ly2LqbdH; arc=fail smtp.client-ip=40.107.162.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=g65NQQg8qce/v1pHj0uhIWFgDj92Q4W+qrqcQZO0S/w3fkQclreuGNKQqJqVF4u+eZCfJUU9gA0PbFv2eWqd1XFkqvI4BZGs6Nkn+G1YLqXSJYksJydi9Pk1jC+iNigOeRQdz7OjMGEFDBbHdc97v20/+kcow4TmT3OYoOlYItoj6BHqvK4NLIwsCOojX5og0NUpSLeMVigh7YFDbaw+yJPSXk8iv/Jl0kjoZlO+llfpY90uZpwaP3TFnsNm739GZ1SILutCyO4DqYRSbCVj6ffUMxP0asCECxj2jilEBCkq5P+Pha2TmdJShs6N0SztWYvWxFWHrz4RALwVmA5Qdg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5QvgW+axmEGrGghrTpgo2cYDTuIA9GOiLzeXoQbYOQ=;
 b=PBR/QZzKjPCcIXva/ciDXljjoiFxorR1rGPN0hYWi8HLW9Bf18c+BljfUxwXQDNWK2pyYLpf2nnUYxmDDR70bVJayIPv/CFWbTEqfYW9tU2hOgKiQrVljA6EglP1fpUOgd2nF7ZK6GkPPIKhXvm8ZWJU7Oe2eqF6fuiP+3992WunZqzdhkAN/li3PacK/Q1Y12DBlSfVodIW19HEb5hV6GLOPuf0zgib1Gz1m/ZTMIJ+jHkeR7YaHFDSXuEWVXPlsL3Llty6wOcjVapJNEbitHkybsu467BBOn617+vetqtGCWKlyzSgQCHfR+tb7xXQxzEC1uo/D5tw83mgEV6wHQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5QvgW+axmEGrGghrTpgo2cYDTuIA9GOiLzeXoQbYOQ=;
 b=Ly2LqbdHLbhUsbltI+slO8rlGaPEwKsa39btHbAuvYzul2KIxiQHgxtLsFBB8jPN7oZdEfKZCw6wZzF6KQ0IbijM/vS963RrySMXsce628hbs1yRKTyYhtVk5i2XzuIx92oZLmXl5CYif1sGjUxr+3+WRRfiulDsIzFIbtQvi+A=
Received: from DU7P190CA0028.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:550::14)
 by AS4PR08MB8118.eurprd08.prod.outlook.com (2603:10a6:20b:58a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 15:09:37 +0000
Received: from DB1PEPF00050A01.eurprd03.prod.outlook.com
 (2603:10a6:10:550:cafe::c5) by DU7P190CA0028.outlook.office365.com
 (2603:10a6:10:550::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend Transport; Fri,
 6 Mar 2026 15:09:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF00050A01.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.16
 via Frontend Transport; Fri, 6 Mar 2026 15:09:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJ7iPYZNvNzFiOUTG//AMVfF7Z1napeSAuUwm/RYAGnPMtl8R4VMLSTXkKRZ5GGBljKU71RlldeoHT1jMygJA4bC1H7JP1S0o6yU/CN/WylKBBpyNg8NcfOjhKE+cxslxTjfQfeW9RZtlIVlkblzcn/gIHPVqXCvQgmn4pIP3fZ/FiblCqErl8QfaP2+f+5D8zgisBuw00uAsJ6G1NL4xpCtg5EA7sMrthMosXa42S57T8LklH/7o2QOyt9AT1e/sFsejMIL4EFIqIgDa+dK6m1B6nnM0p2H9svstVEeRwXqA3V28wVoQ7RwGu9cw4q/ym3BedUyj9Wy8pe3jXuU9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5QvgW+axmEGrGghrTpgo2cYDTuIA9GOiLzeXoQbYOQ=;
 b=Ga3L0rluS9xJzOwmbGf+U4g+TMZqMFIhaiatf5OiSpuiCzptZ32FQ0P9pYyivhfGT+TbsiRrRkWSO+LLF8yuvgmpA9uaX+e47bVcsTqeB8kZnuPA7aGOH4uSpxOqZ96FD8kAJPsVx2RQJ1mLbJi1hsd57u6cMaikHd3o6cy7p0KWEMBZwoJPYkVOCNMjh/WXtHbv+9asNUUqgd1Jyisyxa8XcDNghUMV6bGvQnKUmjsADI0d7APbZ874CKi28JLcrBgPmbF4RF9QiIGRRJ/Ac+hn+nLpm4rI6M+ZgxEbTvGAFk9UjWQPlgLwDuPCWQIYWJuHrUTe81kaT+ZEbW2fug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5QvgW+axmEGrGghrTpgo2cYDTuIA9GOiLzeXoQbYOQ=;
 b=Ly2LqbdHLbhUsbltI+slO8rlGaPEwKsa39btHbAuvYzul2KIxiQHgxtLsFBB8jPN7oZdEfKZCw6wZzF6KQ0IbijM/vS963RrySMXsce628hbs1yRKTyYhtVk5i2XzuIx92oZLmXl5CYif1sGjUxr+3+WRRfiulDsIzFIbtQvi+A=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by AS2PR08MB8832.eurprd08.prod.outlook.com (2603:10a6:20b:5e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.19; Fri, 6 Mar
 2026 15:08:34 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 15:08:34 +0000
Message-ID: <a5827299-28e8-480f-a250-5f3eed8dd128@arm.com>
Date: Fri, 6 Mar 2026 16:08:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq: cppc: Clamp default minimum limit to
 lowest_nonlinear_perf
To: Viresh Kumar <viresh.kumar@linaro.org>,
 "zhangpengjie (A)" <zhangpengjie2@huawei.com>,
 Sumit Gupta <sumitg@nvidia.com>, Jie Zhan <zhanjie9@hisilicon.com>,
 Prashant Malani <pmalani@google.com>,
 Ionela Voinescu <ionela.voinescu@arm.com>, beata.michalska@arm.com
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, zhenglifeng1@huawei.com, lihuisong@huawei.com,
 yubowen8@huawei.com, linhongye@h-partners.com, linuxarm@huawei.com,
 jonathan.cameron@huawei.com, wangzhi12@huawei.com
References: <20260213100633.15413-1-zhangpengjie2@huawei.com>
 <54f5795f-2c0b-49f2-a319-216c17657c0f@huawei.com>
 <ixm6xascso3hjfwhrocnudr7kv4o4plpmywsd2pwksr77nowup@l3ngfnctk5xh>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <ixm6xascso3hjfwhrocnudr7kv4o4plpmywsd2pwksr77nowup@l3ngfnctk5xh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0019.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::11) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|AS2PR08MB8832:EE_|DB1PEPF00050A01:EE_|AS4PR08MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: cf622d67-9af5-49c8-1ab6-08de7b9261bd
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info-Original:
 43BsWYPx1G7kUlmdJ0lIi82irZaPznAvgItS/n+iAs6L1c8uOSoG9kFtUTQZmDd/E8QRiiBJl5pFPjEzujSJNsQlKznQejmqcBxnFU1hmtJ1yEoAqG5Tk+J1xGHv3XKyIJWUehju+xBP+R3LPEoHLyGu7ooOpC5aqFmmKlih5ovhAR3PrzH20xX1ZY06fk2RsYqj1kgVZWK7IEsEQHB+Bfv23Wk84UorK6cmnNOEoUA62eUG1+ihgJZYZbVU9Bg07KD+YMZecUy313uVvJXwrix+ngR+LvTGb3xVLrEv5tvzA/3vGkpI+/AJkKhsPl+dYYDgdjBdnECLwstLHZ+vmn69BvTNWJvwgPfrRT+SKuiyCeI8bqj49J7hc6So9FDMXbMXmNM86CW8zoBQfv5WFJg3kFUYXWnVyrVAkgUZLLvq23F80kkJDbs3BppaVAMNKVBHCUF3wbR2kjj+/8AAmfsJbKC6N+UIMPIbnQCXhk95O6kh9xdNyCLIsOvMozpFSH1/Rr7cNtv0Vis4/4GlcqQKbiW1dEriqufkAInvC/gahfNLiy+LQbVCIXaZzjCgYMK2810KEbHJ2LChgh/Hq4Nm9bHqB7yAqIJv+eeq/GLzF0wGc0Etx/fPmFYp3Kn9ddnNmfl+Q4ZDzWekt2iqKgXKMKsSPYLsunSYGwgrx7Iqm8c1YcAm97RFm9izywq1ykE5TLq23tEfa1VXdZqCvxDH434oRFALxUmko0/iDkg=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 Dxi0syyjSudQKsRfmyzajk8fUHM8UpwFJsfOPoPt/GEDrhWSMjiSi2TfR3+hv0974Luj7OcW3wzTSfTpZTt5SaViELF04hBVW42HGxCEUhVDnjfPBeo66mkNSJ3g110xWpQcWBK1OXevuxnd6kgpeRI8+JrtL0GNCnGieqn7+7TBIrAVi6+WUggdw8ja8HoGsKXTglEyBOmAI2ksijnjE6Hgsq8r8u7QJ1/8qbbT99SGzfRSjfIyhq/X73KY3S9kj8PVqVj9sE+BndZTsauD/24QmrM+90Dz71+TXUd4Qv8oS6s108dPIOXKthg6Cw9Oe0e+2qtFj/3PAJ6O4zjDPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8832
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF00050A01.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	06ac294e-6d35-43eb-74f2-08de7b923c4b
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|14060799003|35042699022|1800799024|36860700016|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	RAPREhZXzWXhx9+FX/oE6zgkRS4uP+LXsMopzyGSLdtJwvX0RZCKzkdvBI7zHZ+gm1apf2+BiH6lr4IxSCvCshkyF/XzSlgDR74IbRwfQcQ2gGxCBC204aVaF3ks7+Y2DQYUoToRGJqnTSU8UibQtveymTsND5MyF/W8/7hf2mL+SvQln0Y7+qVCqDi5HshPlUcVybEngHXGBSvtBwyP2Na4kZ4xs5II5k6R1/WoLuvVtL3Vw2ay3veKB0+XhX3B357B5n+wdr7pcy8x3DOTIF5LpH4iRhIqHkvV1yFeZ15ezl4RSKmbDtsuiHgxEMuJWKvknxyWSKESL/EP66uwC4TxyReMEfkdj6g2JwTcin6nr3RgxTcXkcIcj+z6VWYeBoH36mAJ57nzRBAJFgNl2S958IjlG/IaAX/aeFD7cpQRF34Dt4e7DISeH+p5wJvHMV7xS1Ley5nLC/HwkXsxi7tC4XCw0L/6sp6nlyd2ORWhggtHnAiQOX3ihmxOamB7k1c+b2UOTt8vagy8SOb6c+zROwhp9e3DvhzLFSlkqpgovkklEXlC0u6NOxoD1UWq6ULX7nXfeYza1c7v01me7r3HL+JHCUJ1rcDGmXmRr89IbdbbLcFSTBmluqLZt9fteTJeQZej3fXnUIagYGgmx0CcgjFnchRkLidqErdXtiYJo7lFMIWLAg/2oOnq5VKk+u2QVhVOq0DjriKCOQti/MylcRdkDTri931g5bBWoYP+mDXI7/gFB3JSVCNMkIZoHAnQ2EEsVyGdX4v6fwfeWg==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(14060799003)(35042699022)(1800799024)(36860700016)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XoWPxajaWu/Nop3k4LO1+COCfjFpDA2Y9MaGp8eiMrDU2L/S9vilhrqTCrmVGv13mkvmr0r5D/rY6F/EcESxoG7a/EwNHUEu7JCag6dFWxaJpnUCT7YdK3U0pS/d+9neCYBztn8I9zAXskP7menWOnso3fC1ycYfgRr1W2PQGFDMzOyGIbo9xzwnOHhkOttcqz+M13jmxxbYzCbJcwshIntP3W6McPHZYiR6JEE9qPe7NRuavGSvY7ujquIWwy1vzai1yhWR1ICo+g6LXQCmOgZE/eds06yc+pQ11yiXSbyJSfstPYoj8lvcX/KTy2xDabuyHL0e0zGUOQSDS6aLEjdBsAXeUtlplr6nILFDNIS/0NMmfxkg/TMoQhiZFy0ZzGS+jCoFKVZ3Dlb5Ahntl5DOIS6im3cp8OP3P2VPebdp6OuGx/U/SlVH0MtZWATg
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 15:09:36.7388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf622d67-9af5-49c8-1ab6-08de7b9261bd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00050A01.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB8118
X-Rspamd-Queue-Id: 66B47223826
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=3];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43845-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,arm.com:dkim,arm.com:mid,huawei.com:email];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[arm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pierre.gondois@arm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.961];
	TAGGED_RCPT(0.00)[linux-pm];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

Hello Viresh,

There are already quite some people, but please add me aswell.

Regards,
Pierre

On 3/5/26 07:32, Viresh Kumar wrote:
> Added few more people
>
> I think we should updated MAINTAINERS with a list of reviewers or maintainers
> for the CPPC driver. Who all want to be part of the reviewers list ?
>
> On 03-03-26, 20:03, zhangpengjie (A) wrote:
>> Just a gentle ping on this patch.
>> Thanks, Pengjie
>>
>> On 2/13/2026 6:06 PM, Pengjie Zhang wrote:
>>> The ACPI spec defines 'lowest_nonlinear_perf' as the threshold for
>>> linear performance scaling. Performance levels below this threshold
>>> are typically inefficient and should not be used by default.
>>>
>>> Currently, the QoS minimum request is initialized to 0. This defaults
>>> the performance floor to the absolute "Lowest Performance" state
>>> instead of "lowest_nonlinear_perf", allowing the CPU to operate in
>>> an inefficient range unnecessarily.
>>>
>>> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
>>> ---
>>> Changes in v2:
>>>     - Renamed the patch subject to better reflect the logic change.
>>>     - Updated the commit log to clarify ACPI spec details.
>>> Link to v1:https://lore.kernel.org/all/20260116094555.2978887-1-zhangpengjie2@huawei.com/
>>> ---
>>>    drivers/cpufreq/cppc_cpufreq.c | 18 ++++++++++++++++--
>>>    1 file changed, 16 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>> index 7e8042efedd1..4a3031d9fcf4 100644
>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>> @@ -333,9 +333,23 @@ static unsigned int cppc_cpufreq_fast_switch(struct cpufreq_policy *policy,
>>>    	return target_freq;
>>>    }
>>> -static int cppc_verify_policy(struct cpufreq_policy_data *policy)
>>> +static int cppc_verify_policy(struct cpufreq_policy_data *policy_data)
>>>    {
>>> -	cpufreq_verify_within_cpu_limits(policy);
>>> +	if (policy_data->min == FREQ_QOS_MIN_DEFAULT_VALUE) {
>>> +		struct cpufreq_policy *policy __free(put_cpufreq_policy) =
>>> +					      cpufreq_cpu_get(policy_data->cpu);
>>> +		struct cppc_cpudata *cpu_data;
>>> +
>>> +		if (!policy)
>>> +			return -EINVAL;
>>> +
>>> +		cpu_data = policy->driver_data;
>>> +		policy_data->min = cppc_perf_to_khz(&cpu_data->perf_caps,
>>> +			cpu_data->perf_caps.lowest_nonlinear_perf);
>>> +	}
>>> +
>>> +	cpufreq_verify_within_cpu_limits(policy_data);
>>> +
>>>    	return 0;
>>>    }

