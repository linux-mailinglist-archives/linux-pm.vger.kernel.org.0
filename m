Return-Path: <linux-pm+bounces-26328-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B99A9F8BD
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 20:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AAAF1A856C7
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 18:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82DC291166;
	Mon, 28 Apr 2025 18:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cNOHPgvy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BaPpkW0W"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AB920E332;
	Mon, 28 Apr 2025 18:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745865619; cv=fail; b=r9wWq/RfNVkSmogstuBZqGmBtWtHP8HZGm9bG/oNiq60dPf0rxlajhGDUmLDo2zYZpJNBIg+4bSWDj3BYro5RdP8wSSl9PZAuUTIE+E84ychIbIVfA/j/lfbuMmYkRsQ7sF+txDGBKGeIy3hJmzk5zPZuegF+tkXu+oks88DNkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745865619; c=relaxed/simple;
	bh=mPG2iQeNiUz8hniq3VHuSppskN7mIhySIML0jMKD/kY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b+4x/thA0+L5aNatW0E9uviAGGf2Hu3tQT1YJiE0tfCBYeJCKn3e6Wn5xe9TI9484sbhRIyGMIDqrB4RebJrntu9rpicyTAIzoY467Id0GggUmffYI1bYiJtm5AHxUM2o1vBjKZ+q55ACRNW6TeOcdegRoXGGSvdReAHkcJnze8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cNOHPgvy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BaPpkW0W; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SIWX6N002820;
	Mon, 28 Apr 2025 18:39:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=4K4TWwI8zDUA2sexU/
	iXuHJfAWQxPMz2KEERXZzz4T4=; b=cNOHPgvyHZ3btklK1cBssjoo7xSJjxKxxN
	zThqxrNmsjOptO/7Pu0pwbzX02CcIR4ZWNUXQDbYaaSNGQwry+o3bgQ3jazRWAGJ
	8VpCmDEhNx6hexkzTXI06Sn4kLzSu7t9RqOBiC/GVrWT/awZJQVX4LopkTLjL8ea
	WVG1Zpq6yXhcJqOvWRczgOVA7kMsfxCtg3jXRwjL2dInNHBT3m/KornV4u8vkMDR
	WNSBU2yTyTp2lvaFyjqMviOPlPmVu52i/n+E0q2NGZ64PW+2Ai3nBjc3mOjkq477
	Lktl7zDxxM4aau2NFZzTsegHCx5JW9ls70/kUxUrU0WrgqrNwNBw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46af1kg0fy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 18:39:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53SIQ8A6013974;
	Mon, 28 Apr 2025 18:39:54 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nx8u0nm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 18:39:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hC5o3XbiGNnFfgwNd7592kqB3RXFDF2g51NGaGRh+TWlSTDxJXmScEArWGPPMyWxiLgauCr4mpy7VTyEfvrNo9o1CqIHzUcdIExpugZdAIKnQ9316Bj1J+QXAJ79SswuXoIvd2G3cWdDfUsllJM4sssDQqhswESQ0xAyv7Wra8zSFoOHjI/+yKekqQtb2K7k+Gcjrjyi80JEjfRcm/SWjr9+VRnPWFB4wRZUgaAA0GiWn1ukoxaw66rMDCVNYyYK8I6oRM7aWpF2mtKZ2G82Yt1eFy5R8N6iX15TsviTYNiI3dvpEzsgV3NsmbGunmF2HCqCHaufTAmq6GKce5cDDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4K4TWwI8zDUA2sexU/iXuHJfAWQxPMz2KEERXZzz4T4=;
 b=QUbMcZZFwyW3W9tGesIIsNiaZl9nGoylTKw3Ft8BTfO7z+pBv1HwQWvQ9b5uZ3qNIFWrz4Pp/Ii75EekxAtevfo/D1/qK2L3kyQwcU2EBOfw2ns4zzUoCxG8ZfFYn2h8H9IVw49tJjP5D3mHb1kOaj5pFnPMxjDZYzx6R+/yfIdG8HvVSiwdGc1yzC6i5LQUGPOXIgMXjMDssaeXvgumaQIko0WoR4yZNo4/I/oXakBsHmF6qG1RGILdIcc8I08EK3g81T+r8Vmx/G+sgOf0IGDYvnk0tBiu9ckXOUQsr9czBzBFU/tUvOeUmS19+Z/lOS19YAQXtrIx+1JLfybiTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4K4TWwI8zDUA2sexU/iXuHJfAWQxPMz2KEERXZzz4T4=;
 b=BaPpkW0WlR9HvaafKAz/IKD4E+g1AHWBZHDQ9Np11gIh22jkissR1Tna3Zu+UJHvqRwYhMfDnwN2KbP16TAiFZsxmTk/4tjEwU9zMQVN6OhKo6HPImJXmIlL/7AC/wCiNvVAFTC9fK9Vf9TOmNx+x0UqbRbCtq49ygC6qsZ/X8I=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM4PR10MB6814.namprd10.prod.outlook.com (2603:10b6:8:10a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Mon, 28 Apr
 2025 18:39:51 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 18:39:51 +0000
Date: Mon, 28 Apr 2025 14:39:33 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Perry Yuan <perry.yuan@amd.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        Huang Rui <ray.huang@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:AMD HETERO CORE HARDWARE FEEDBACK DRIVER" <platform-driver-x86@vger.kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v9 01/13] Documentation: x86: Add AMD Hardware Feedback
 Interface documentation
Message-ID: <aA_LZZRVnWdv6IdH@char.us.oracle.com>
References: <20250423014631.3224338-1-superm1@kernel.org>
 <20250423014631.3224338-2-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423014631.3224338-2-superm1@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0103.namprd03.prod.outlook.com
 (2603:10b6:a03:333::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM4PR10MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: 83f4725a-3afb-4035-7acc-08dd86840f6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PRsJJyR4a5lx0xsWc6r0mlLY7cWAb89EIwGMq6OdK4e3fhwlSq5u5stZWCTG?=
 =?us-ascii?Q?P6BR1fRMzo+h71NMgwVHxClAezJQZseQJfrfy5kk4GM8KlJFujLnUbtsjvbh?=
 =?us-ascii?Q?ZL2XfR8zGIBh2PFyLQrxm8E074vdBE+sHXsOuMHteQYQe9xN64mAjxOJNopW?=
 =?us-ascii?Q?+Yv2SH68iiIP4bplwk3x9BvfjPGfc6mfmvEyaaaQVU4OtJbNyU7d8fS7R6Wm?=
 =?us-ascii?Q?yMW4l1qD2rdE/RqJ8yorO2xtDk9IfH0PyX9IOenl/Jgz2G86oPD7q7NtVa5C?=
 =?us-ascii?Q?30G1ePqk96L+Fg4PFjaad7JBkhuyLGNRvcg7CZPLBnuCde4wetMVaq7fpTZS?=
 =?us-ascii?Q?n25H5o1w7ePTo+1g7TKL4cVJ31rTK7FGud5qrH+0GtMwweHIh8bvjCtbK7bY?=
 =?us-ascii?Q?gYfMuLb5w90DOYdLg+9j0+ZFrdLWHIyJKDCQ2Cz+BzgNSVBX96lgRYFriKtV?=
 =?us-ascii?Q?77SRvTP7rTBNtlVutuzQMuQ25GYHy1ZQhudym+YTHSsy//j78USNc0c5DRpl?=
 =?us-ascii?Q?nld4DBB95jC98YnaZqTj4JKE043gfvvHdq9+wnUA28+KK7HcEGBB6MQLF7RU?=
 =?us-ascii?Q?uofOBViBa+BMlBwi6JFQ+Jn5VIPRlZ9igMT53FANLJIcttHjYHD+WdbhHT24?=
 =?us-ascii?Q?kPVqFFI4l/NZ4ttSyKmfMduJVjWZyKNgN+Pvju6crSsMVDT3NbGlbY8q+ylv?=
 =?us-ascii?Q?RtU93yYSzCc3kJCx6qvXeBcCyWztPh6JpyZRAY9a2yr8ekPtbjOPFLB5t6On?=
 =?us-ascii?Q?nsf1BeBo5Tc7rj+O5iHYL7IWiLxNklgtZYJ4WQu/6+JvHIRUJBp8uL+7D8kw?=
 =?us-ascii?Q?OZ0w4KmkqsrL+JhHrynJATd/97rs1OxXlLpY+TVDUICfFR2sgKPWlOWXNg2W?=
 =?us-ascii?Q?edPOB51WRGjSZMYr6w3FJYg0Cc3u/l6K/cyEBwnPLIJ14/nN5pIRwMWpBt7T?=
 =?us-ascii?Q?udahGOd3Na20d1BBwXbgubzIfji0BUDbnkMSY/43D0SVV/VSxM+EZXHZXBxt?=
 =?us-ascii?Q?R0e7kgP1fbLCMJbjlHG4w8J+4x6Dnc5voc9FsLAqEa7Pn/0/fQXOdaLoRoIM?=
 =?us-ascii?Q?BKH03G9xmrt3kkR2u1sPcJ7LLCJrZ/p520Jc1CRxPDAHDuFXLX6uh2MPNrlb?=
 =?us-ascii?Q?dh2N8A7wirFAuudqDxjuMEylBYwOmUaF6bkXTmfHPyC5eWysjLBznHF4Zb19?=
 =?us-ascii?Q?ek6CO9xEt3YeUyI0QJIKk0EHnEfMr+WzV4DYvpsnUBhXbyeuVTK86sRPUQ0w?=
 =?us-ascii?Q?ivGpmQ3Nme17RW3m7XxeinNY9+ZhvxexZK2ble72A5tUD57yHmw6Py40ircZ?=
 =?us-ascii?Q?MYwx+VmXcT3yze3dgjad4b1pMGg4UTnwZGRJ6MVUPd/4Fc19BCoV/th5ufWL?=
 =?us-ascii?Q?dUFeMjvnA2YM1VYNfXLsA8WSq1xrlo6RsqwQT9nGFQvf80S+/I6gqZncEQAR?=
 =?us-ascii?Q?Kojl2dw7VPU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1BfSaOUSYCN58Owyhi0g3tYyOq0rU0Kt5J8synWeJ8zBoIF7iT+q9wEFEjDf?=
 =?us-ascii?Q?VurTQ3kJrGdbUUuONoFm1ZQ/LOI1toTolmJe/U8LHIEnC2wWVYslETTuZI0A?=
 =?us-ascii?Q?vx5f5mP6t+neslQNiDTM2ipKHK/oITvnwTxZrjJH4wHr1emk8xfcDhLw+DM8?=
 =?us-ascii?Q?UFoMiOttgCP91slw/7YbBaA23p/PWsbKE/RSV5JJtb23hhOlPM0iTndKjUTQ?=
 =?us-ascii?Q?zyyMhPX9punmOiJVgMJd7jXIeME/TQptUIGMdQvd3Vmz+WkXVVKdRqDspUVQ?=
 =?us-ascii?Q?4iS6laD3tAEmQ5/jAvxqiMIqm8xl1+K2pf9xLghOXKtdBPf4HOSpMNj2vwEP?=
 =?us-ascii?Q?9YX1PpsI5UebOrX2cm4uV0cwAVUqIVlFyeZa+pQRxPJRjdSIVnEVL9raScXW?=
 =?us-ascii?Q?GXUTOVp1AeBFN1JZsE3XF3O0IQY2EE9Q0Z1xi3kolfwawb2R3Fl1hj4wFHEP?=
 =?us-ascii?Q?CMefOJdyX0sMKlC2bFL9INzQohXUbhkvh3giT+C2xsnpqB5w81fRKWnsh7Ko?=
 =?us-ascii?Q?/UNucCXXdqFy0tqXWonj+DpinYmqJBpuaNcOgHRo7jgD1QTuasmaPyhq58Dr?=
 =?us-ascii?Q?wp2O4bCkzrVIVa9bJSV0EX8sAFQ9SaXx4qK4kpyaNKT2iwGlt7lQIw0JncyQ?=
 =?us-ascii?Q?q+HidRkmw58LlQtvfJjjfJkYaCsYvDGkshIjdJhBlobfQILYEHg+tFhZ+3Nz?=
 =?us-ascii?Q?ujtQWfvBYlatu1HbPywsGID8vi2qsgn/7R+6M1CuMNvuwb76mr1O5fA26bn+?=
 =?us-ascii?Q?cYpLkYzRXLI1ALt+3G/dPAZ5ZWAejQlZBcnvKIADFH8GoFPhpacDBfHvnx3S?=
 =?us-ascii?Q?EJDbf/U6V5QO+B+xaa7Pxa+E7AR+1H45mYreRmZS44uo66P9NQNRJZ9QhG7g?=
 =?us-ascii?Q?RiJzCvbnZOnD6idFRrs3rpxvvC29yCri/vKkSfXKzfjmAJhGBGiVauhjMhc+?=
 =?us-ascii?Q?u6rZnUonI37ccSrYUevdUJ8VWafTTQ+LvXPi3atdpRcuXcgYDMSnZaEOGpxM?=
 =?us-ascii?Q?vN+7gp3P0qHfck6sUa5NLLmOCgy8E6y00m1TePn1DkBaU1ASsAOtGs1iP10H?=
 =?us-ascii?Q?SzIZjC+1iqUdX3JqJUXRFTnlcjNeJWYxBgBXb+90htn33i1syAEvV564+sH/?=
 =?us-ascii?Q?cPx+Ylm2/RoNbVybDTP/YjtF+ko4ebf+9cCv80nSXQbs2TIKCOHXAx7pcrkh?=
 =?us-ascii?Q?29U6lQcUWFQIRvOVeBBg0vflwe6LOOWMbyCvg63J21amf2tonnZk/VPw9Ok+?=
 =?us-ascii?Q?BswkL/U+vvT/93HRt3IpGPCzCfQ16LX6gBYKqEi1lyXn5BGifHVceO7Le0VR?=
 =?us-ascii?Q?sjJSySJV2269UWcRTAT3MT7jLTj1u2VPABTvEzzEyWgYR2Ylxcv16TtQjbzY?=
 =?us-ascii?Q?coLwH4A3q2F4a3iGPaWzQF50ZBtdKXX1ZQ7gCEukQW2TIi2XSGywIX9I0dEh?=
 =?us-ascii?Q?xg78ZWQOwUDINpSyaibBca072Ik7Q8mNycVHiOowUtqJrBasrFor9r/M+PUe?=
 =?us-ascii?Q?zylu17hY105nBRHdCizZ3MVf0zs2EdNggqpHz6sV2HCWyl9PwB3+mJ2of++A?=
 =?us-ascii?Q?JQCTdpLD/I3QkTCNCliXR69srRDc1M9/KwTiI5YbWysfP7rnpZFwpgLnP90J?=
 =?us-ascii?Q?Rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5bEwoQfmR+alhLAUmp651bM5TwFCTufIQ30vqogtATDjxy0NzNPw3mBBb5o8/z92Ip6242+NfJn+7zfOuIXMeYTPay3B0vdxLulkzUty79zhGeorte+BdKeIl0SkxA7ywq23yUYSmwd7A7jdACt7WxCpRROS87BN/Vrsskv5RoAKftNQ9Dii3CmBT0U9udI0UIBk0uQmkEo689KnGy2rP+IqzdAqgmmnUwrRd8nTsejB7Bvy2x1wn51Lte9+cc6HvDlrjjKR1c/X4Mzfq58WjIeEuLGQBZ5On48coUA6O3asB8vpu9c0W8iWAePM3NwFzKPuxYnfAE2a5EdRL0G0VI2H9mH41hRIvaHTZFb2HmUr7lenCYwqxf77gnKeupTxynWcaoEMVII7UrsieeOa1SCyYU3AXUGgJ3y7sxLkrE86KagmKBgqfU31v6JoeQfoTH+eSt9c5TJdpUAvosI6XHeRwlu+8wIRkNFGSdG+SUi/uGE9pmt2puWMNs29ZFeYHkUgF19iHYqLFpZ/IYDnVVOwFAiKauAgO9/1hFvRYMv5Q+r+9fTiZ/kG2aQn/fjBWNr7Q0985qxt0JYMcJgPZNUytuu7FtfO97wUXNnUjIo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f4725a-3afb-4035-7acc-08dd86840f6f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 18:39:51.0850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ne/Ojy1vmtrTrY4Rh20aGkP/xoUF6ZXsOuI1AOsf/AKK77NiWsAil6eL8QnHj6eHlm0omP6HbAigUoVAv0O85Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6814
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_07,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504280150
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDE1MCBTYWx0ZWRfX2r5MWai72YFC yz14Fd83Wnz08r2xoGC/1NvYR0nMlL94BCHOLKbhjRXBDheUTrEcuCtn5B8J4qlwsH6tm5q+Wwg H25cv0UJJaoxWaOoOnMYw2krbZ8Lv8J33JhFZSyhRP9f0sFWrfkeM7Q2yFS6jfV9U0nCc6S2z2w
 GCTetHIUAK/AD5ARFjbhVrZW+zUMwJzDgdQEdpfhofTi/Oz5oROrBwO2/le6dKFPodJu0t0+oIH QkE4nxwwi9rvCv6LGbsklSW1x0ibygsBMMugv7dVSE0v2pSDwWyXQt3uVsgYcI9Jy2rtUQq4lKD bXbL277xMjEgH3HwVXn7XHh5vn30wHL5FbfmycSwMPX7IFAY6ejLqUJVBzfh7StgcB9+3T4Mjxp U7sz/N86
X-Proofpoint-GUID: NKOKPl3NdtEAleZNRBSEgMZUGx6cP0PO
X-Proofpoint-ORIG-GUID: NKOKPl3NdtEAleZNRBSEgMZUGx6cP0PO

..snip..
> +Implementation details for Linux
> +--------------------------------
> +
> +The implementation of threads scheduling consists of the following steps:
> +
> +1. A thread is spawned and scheduled to the ideal core using the default
> +   heterogeneous scheduling policy.
> +2. The processor profiles thread execution and assigns an enumerated
> +   classification ID.
> +   This classification is communicated to the OS via logical processor
> +   scope MSR.
> +3. During the thread context switch out the operating system consumes the
> +   workload(WL) classification which resides in a logical processor scope MSR.
> +4. The OS triggers the hardware to clear its history by writing to an MSR,
> +   after consuming the WL classification and before switching in the new thread.
> +5. If due to the classification, ranking table, and processor availability,
> +   the thread is not on its ideal processor, the OS will then consider
> +   scheduling the thread on its ideal processor (if available).

Can you expand on 5) please?  The one patch in this patchset that
touches the process file just does an WRMSR.

