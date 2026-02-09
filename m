Return-Path: <linux-pm+bounces-42309-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOupOFFHiWm25gQAu9opvQ
	(envelope-from <linux-pm+bounces-42309-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 03:32:49 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5808410B18D
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 03:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0AF40300764A
	for <lists+linux-pm@lfdr.de>; Mon,  9 Feb 2026 02:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A944827A10F;
	Mon,  9 Feb 2026 02:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pJfARf2/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nlYuD0iD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2614814A60F;
	Mon,  9 Feb 2026 02:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770604364; cv=fail; b=d9v35QZdoHOVH5UOjFyLsOfkKXJEbiE2Xo4R8IhdI1p8+1avZdnaoDVwlSPiAGPxbGxAbkB0SMQMfO2L7aeFM6vlyjqpeJ1GkoYN3VtTJyfcy/uzJPuRtYsipewFqbekEiGZJigKQ4f4as8qRp9f2EVHB8CoAztWVmNcAnArmyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770604364; c=relaxed/simple;
	bh=MG2x6YIvpVYEQVEekfDrFOnpgGdF6NeUU1wew1e7b5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=qUNSwo65Bcl+3ZBI6cQ93PkGsQl0z/ZY/rHsICBuUxc+cCj/d1lm/3XNu0DOLafsM9P7eyMk9O0CpABECsgdObCdkaUVUEcrehjiyjpwKuvttLNkijAdi+N/tZQwVFWpZSLLjT9gHSB+0C7di1DE2a7E1cfaqPlu84o3alnmYjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pJfARf2/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nlYuD0iD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6191jGIw4127298;
	Mon, 9 Feb 2026 02:31:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=cbvMxn7myCR5xO65
	w5pP6QO1wNzHQsaTC8wmKOdd57E=; b=pJfARf2/8FyXPQT3KLc1SEM34c9NO1BC
	hA4+DitVvgywcHhYZybeUkVIfm4VfRSNrj/IVNvRTTOqCHeQlm8jjoBIwPi3WrFU
	mV7wF3rfc/5fkioGvtvxX9S+QlOdXQ9MCvJ5Dzhye96IRR3vXbYCnv4iXeN+l02h
	fniW7bpRgL2UiVMGIs35DKsepPOPOuhFb4rBbpfPrGZXnHYSi04xEfScPMUIsfTp
	8FsUE3kt3PeWXFASEXHfukfCih4XFa0WFhRWcwc4z2gva9YHkaVkjNe8gDWF1sSF
	Q7txNyApmqQyPCv8jz26i6NPV6vO3ada+bg5XYDOhRJO8ThB96zilQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xjys9cc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 02:31:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6191gXsH020839;
	Mon, 9 Feb 2026 02:31:58 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010067.outbound.protection.outlook.com [52.101.193.67])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c625g7arp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 02:31:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gqg7jYXp0pPUPJMmF6cVJwG8x+c7WtWz8oP7VhvaVWoJHjgqghxjuMeDaxbUS0r2A03tdqSCaIpLz2inNj0BSbS5AJpZcARXF4eZNtfskv4jaxgXjrmRC5WUsk2ABnxZOQwAQsR7n+6iuSg45haA0UVnxF5VCWLOn9yymXcGQpjmofCC6R2L9ERzcx539FvmV4cUJ+tt5IwGqBMClD3+5Rqwx4G8On56oEA0VZ/w3/ygOS+D8/o8/CKLN3QYMhZwqaqgGdj9CLwgOLbY4DT1PLklt3PyquS0PJFoWv89mVgj2jFdnLAIQbZpM02jymU/KYvj1CPpGvvtZOzGTBs3kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbvMxn7myCR5xO65w5pP6QO1wNzHQsaTC8wmKOdd57E=;
 b=AdrgZO+iBjLURhdvtxEXkp9ZETv8KGYugUVsSUJ0tTOtgsjD/LpTF0WJH32RuNLs27yiQn+4fwbxIL2r+Oi1OtmRCrNhh5EYvbslrqESMJQ7B5NnxeV2N34nna6bl1FzON9ihcRPFdTq0CWWNztAfTRw+DeopZVgaVZw/D9uSambk0cVje5rPaYvA0YyDX4p/r+KcKLFY8KnnnhnZX1Ak6X4Pd+pw5jm9j+jIz1Id032+oryKdab9oJ5EJorG5LwKZhPWB+wBKPCJvG6aT4Agr9GhvogkPkHL6t/BJTiwbO1QXZtIigdALjvzHDz+XIJnlzlHb/CiYIWWlG1BgNBCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbvMxn7myCR5xO65w5pP6QO1wNzHQsaTC8wmKOdd57E=;
 b=nlYuD0iDPmOMAmjWiN8Gsnz2lC+qwfObT9rBEbu9Zv2hWZHq6I3ojHwCYonRKkZ0X1RtscW866azsDCdWmKhRW19YrHG5wX7ZM2sZ0rx3QFGMIPgps72PURSfKXjOLtjb66wc/m2xqmjkdWTO/AXFA0MDmzQVoeDBKt6EX18etA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB997601.namprd10.prod.outlook.com (2603:10b6:8:314::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 02:31:54 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 02:31:54 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v9 00/12] barrier: Add smp_cond_load_{relaxed,acquire}_timeout()
Date: Sun,  8 Feb 2026 18:31:41 -0800
Message-Id: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0172.namprd03.prod.outlook.com
 (2603:10b6:303:8d::27) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB997601:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ad61412-55f3-4a7c-ae32-08de678363de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EBrbCHBiSaOuIO5X+7IutHoHmKbwldM/6inZ9Sq9OKj1Phyva1drp4I+byvB?=
 =?us-ascii?Q?U62p6yknGW5cD73sG7qqTQeXQ/zOFsWeC09K4i5AMbBbzVQfWEbK+iDyqW3+?=
 =?us-ascii?Q?wQXZTT8lSFrL0kexhdABH7RQuLAOnkVuD9+g0kG8VjILL/ipLmwA1eQQMYQh?=
 =?us-ascii?Q?7MotAO9QTbZJY3KMWUQbSO19kZ0Fj4L41yJggnjj4wHwfe+UHF31MrvSChLN?=
 =?us-ascii?Q?3HUEdR5slzsIDlM17UpfldY9gVeoSK5Mr8Fh09q5XYQH1vs3j3ecgfGS0q/N?=
 =?us-ascii?Q?Z9FXuGJCwNx5QLWngGwpk7k+pUA5R9edKT6Se0S32V4RcNrV0SyyO396tUmq?=
 =?us-ascii?Q?dLX1VMu6osY8IGEYIt0/cMbUlsWHgEWb9IqxW4/JzBau5xQ+pJG7tiv0sqYX?=
 =?us-ascii?Q?m+iBNs2rqPrv73zdxpnpFBjBP4siq8y+aVTdiAws8XPUAhz6VbCryrq4Pvtq?=
 =?us-ascii?Q?XFv63r03xEInXsH6zneGP88S67Hn2d254llaKWdcgobnqMfX5A6LI1p23esN?=
 =?us-ascii?Q?l0cq5UHQd7xWy6AtzD+RN3FB26ADrvpLBMNmL10jfmELP8TR47mff9NM9Hwm?=
 =?us-ascii?Q?u3qOdCnCogyeuNV4nlb1Ou9FZBw4jJnF5NcAsthTlj0r1DdlBOENR33HxTTp?=
 =?us-ascii?Q?Y5qTMpADU2snueszMOn0/7U+v5ONR0BOwIIU7Gw5V5v+qcMacrfagMxqDUdQ?=
 =?us-ascii?Q?IVtBdFpVjpw8dP71i1I4OkD4q0gRUU06MiZH7ouU8PyIRnNI0ldiDZvSX/1W?=
 =?us-ascii?Q?g2iLol8JfBizBc2m6hQ1kLUOIYpllP39H1PNzZCvI9+UqfYNNzPVafxnDoBC?=
 =?us-ascii?Q?FK/eRkyKqJE18JaU8MP77QPN27PwG0oOnrcv9fKF6TPZlRvDwiIrwlGiwgPW?=
 =?us-ascii?Q?+uLUyyL2BfD/XIVAm3fsDS/ZYyP+jZ+IkrEcjMflJ2AT4DC+Zp6RntEW0PSr?=
 =?us-ascii?Q?c8Qhg/uB0c7o+dinEOfnA+ZryUsnpMMjWzylBPPLgPQ9an86wC6PyMXtShbE?=
 =?us-ascii?Q?XUY5n5st0fWDVGtmd27c0SR2AXFlmkGJd5mn2Plvl6LrLkZeRkpw/aiK6G0p?=
 =?us-ascii?Q?TyakZ/1U3Dnmvvs8h9V/zoIUkau9JN22xtU8zhms1D6V8HRoG488dX3ZiiIx?=
 =?us-ascii?Q?Slh2inplb6zDs2MCNctxc4Ppd3uKuCt8jJXUkGa2O30I6VRQzDH/D5c7qbrq?=
 =?us-ascii?Q?nkDhpXjRydiBIAvLCCgzz6ABvg5kvZFTWMod8AyLXZxtSe06mTdb8FsLNgzF?=
 =?us-ascii?Q?aZwu9u/lQQnpCTrh4kWngWffvO8oLVJ8RfbY+8TZAiZqp5xhQ9vjt827v6P8?=
 =?us-ascii?Q?AydM0w+GHa7KetTGyicMHAM+AoI+kteiltbtFWmeC08Z1+KkPiclj04FuCPt?=
 =?us-ascii?Q?p/0NB4D4wX8vfj62LIiTsRyB/hSSgU7jL2krVDmq7EMRN3pMohWQ9JpItCoH?=
 =?us-ascii?Q?tADin0Smo0vlkg/o5pVVhhWxP+2nEzC9+2h090ENwsPAycWprvMcgoaxU8/f?=
 =?us-ascii?Q?yw86dQc37yePkwHoFTb2oQXCDou/8V3xxfyQ2DDbGh2lI90dLn80V3f2Pd5A?=
 =?us-ascii?Q?cM6/M7DWuSjU1rcU0QIec0igRZ4Lv8U5R+DR85wT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hPmNb+qzLyh0P0Rcg15SDRobsIW6mSAe2GxpJuoJIZOvNrKQTtBubg1rs3Kp?=
 =?us-ascii?Q?5MT5aXMJnL06V6wXasJA0D1cqVknBhUg2JrMW0C6euqWEA3Lhs27BOoYHr2g?=
 =?us-ascii?Q?XvIHqjWBlFHZ88kD7AReD0DSzBu4lOAcJrHm7CZF3L6H1I28rK0X/AUvMX/c?=
 =?us-ascii?Q?TcHf0Opt8xG/j2bzHceHPHeBikA940gVIfXIm0bEsSCT8E2cqM9Q3D5tKD8Z?=
 =?us-ascii?Q?pgea0krDuIxtlmVnETi56wNR15SgB3QgoWAqXfmeDwPuxUR8+zw3EBy0B+Ri?=
 =?us-ascii?Q?9EDhO/k/RidO2zTfnMwAQAMaxESlH9wWXHx8F3xS3zYWuj2rvdlrprkuThmD?=
 =?us-ascii?Q?qc9/i8PxIP/PyY53JdubKft+jHsMa6hCHkgYSPFNJp5rKWoim5NcLrkjybcJ?=
 =?us-ascii?Q?yGwIwpmYhoyyWT0X+esjL3NlAwSoaKahUfLpaTiUpCNDHQY8AkJk9c3a87wb?=
 =?us-ascii?Q?cQi1qNmgwqnmdET2sqWik4aXwp+J4trmyrRI8GwBiVnvWgddQsJvQwqaVN22?=
 =?us-ascii?Q?8EwzYdgk3WChbO2E/tOUigZNgre1wogabvvoYFf0Iaqi0Cos04qLlAMJEhKy?=
 =?us-ascii?Q?7/NGTBiEX3uYY+46iZJEC5+8s1XK5S53igtNXjY8f+VIauJAPkyYwJo2+yTd?=
 =?us-ascii?Q?gC8HG0Uzyrg8bl2MKd4IdmmYffk8cLfmFZgay3r0AR9lngOj2/M8BjjoR1X3?=
 =?us-ascii?Q?EVEjVqL+nwx0Mtj5u+cXzdbC9Z9kNculubW8w75KTdJjSFTmNvWp5+kfqZZM?=
 =?us-ascii?Q?EWpL8OSs4uvPvF2DhmNVjvnwKHEiY9nBtlsTT6DRu85yRqS6qcPprAXUgTa3?=
 =?us-ascii?Q?KgdgF3R0w41OtH8e5p1M1jOA7UNWHEpWEbI2HDmliEzC7AaxLA2C94tnxHAd?=
 =?us-ascii?Q?QC0oT1z4I01ftHzazactJOoAj6hshGfpQyXnD8n7OyL8kV7IPw36oqYSq8TB?=
 =?us-ascii?Q?xdBHpWMmzlPUu853npYcoP4d59m44g9YKxr/9QiQa8iP+3mzo1RIzvjn8bjC?=
 =?us-ascii?Q?pA65nF5z9fueUwiqKoibpNYLSYWVjC6ZhdJYRp4wruGB/AXfchuTO5hRk37N?=
 =?us-ascii?Q?S5qT+OSNLedaoVP2M1IFONgjqhxzwV5Hkxu86k716KfOiNKojVUWcf3qRXfc?=
 =?us-ascii?Q?RvzCGP9+n24YSdvRb32p6q2ZOwVXTjNAJ4LHv8y7LCvp1GNPAONv2Q3TZ+lt?=
 =?us-ascii?Q?wV6xbV2RrCBpOU3APMi0ahzxIXFmIz9s7uFmtmGgaUZQWX+aW45rSMV4tCuH?=
 =?us-ascii?Q?49KOk3XRJfBTgWSX1MeQLamltgoIT4p1Ft65NZOIo6FwhVRha8+oNzjgOmaP?=
 =?us-ascii?Q?MNLVG0le1/DjcDwr73fXJHsm0w22dqJiOkNCty7GKGksXxxEbi2fmI2Qgkoh?=
 =?us-ascii?Q?JhikVkL7x/mO+luSkhDbyGNYrvgLYckgB7EPdfdvVssRr/laxbrTrVgG7Pb+?=
 =?us-ascii?Q?ZBrirEGnGAANOLqQlDF1GSgwGF35KMrBAAQzMCVpdQGP3jN6g6tgncUgwp5v?=
 =?us-ascii?Q?SJAVga84Etvc2R+Yum3Espoh7i7KyH4F7dPPGNSxB+Vuj6z6QL5Paexpnl4N?=
 =?us-ascii?Q?9Hv7GvunpDG3KUGLmcTi4nG3ScqZiDhZ51DN1/9ZHnSai8kh550Utvj1CKYb?=
 =?us-ascii?Q?qqZYqqKmQ3HhVr8/ngW22pJDruf5GmM4etpDyUt2ScAQx9/SAcnqJLN4BTtR?=
 =?us-ascii?Q?igErkeKxnqRhj49jZWr+1/2u0lzyURShKkEnn78R3NXk4oZmDTF84HPjhnim?=
 =?us-ascii?Q?lg0v+qUnI8gfi0pk5OOLRw0od1mt6u0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7KWkrgHxyhWtZFFphDHqhRKi5lwDOm9Fj3z4fpvkdpuYBAZa0Eg17tWXKSB5+uqjN+SWzjLU8dEOVzgys+r5jwN1xYyQdD136goqwzcQeg5TR2xaf3UwPbtwH0HCHwl3B2XaOhtCGHiepWrAvBwK11ftICHEBxwUM6KPEQ1bBicqj9gZTWYEveB8VmOBnmfdXDEfqRuaPIBoVZJ78iQYMebcaZI5cYsPtwwGf7qc4QqC5Fyz0PfWPo6zKEMYijMUcvMZ0uOD5jInaAd3w4Svtmr/IdAcJuEACP+fkOHIrv/H5Jrx1nP8wmzRERYlOnNu6us8ItLN2qvJwWqFsDUoVlIo83oooH/Hd8oWYyKzsXWBYbRV9cbX0eAuclNqoZwCOCKx0io5tUsI/rZxwVkiuSWm4SRI/5sD/B4F0l3hqN5IUo689Ama7oTSfddfqc1h/jpEXOjIvFM7dUMdG3PH+YZ1lBn8qxla5HiN4O/1nJw2ciXvhM0HcMcmsU29FaJbmzCpwZ69VKImGdTm7XgbetzakNvxTrbQKkKd5k8J0WPSp37sCPZ8Xvo8s0YIHrnitmc0n3+DVQNAkpp1HsyJF25ae+WRQXpzf2dCZZ8qsT8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad61412-55f3-4a7c-ae32-08de678363de
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 02:31:54.8493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LFm5fYC0vX48ENDtSGkeyeouaLt42dKk4MBZIY9mqDZeqI+pFcVc/jajEVqn8LlMSGbjqG3SY2BeIOKbJ7vikhRg+7d+k06ifQIw5cW4qT8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB997601
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602090019
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDAyMCBTYWx0ZWRfX/A5gG8Sqq1JO
 5ddhEaZxflwOAD5VMpxUN1bHhStMirkv6qo2U4uPagc7vNkBT0CUChpj+GSGa7Tw9ocFGOoMKML
 JIxM5CZHzG3n+dNyF4nTbzWKnEYxslZa30KqyohXuhOGuhftJr+hAQ7PkryftUZRbWVBwZCPfGz
 33yBxaKnvixKdBoQrgqzzONzB98ZLk3bdtRb9eCSPjXcU9FBIBSuN0my4nTREwF8zSWl7T0HXiC
 zqddL5/ystkcJz9Sk78MaAZcMSA7tvnrXT8kHXT4aCC68TupchYg88km2BRtDnmeUVYn+MHKHeS
 NiOOT9TfYxr7akVoj9TbwEDHNIAUib/ArPB79RS09x6jBrgU8pq4ppVwzvKwL3l2GHn8iXp+X9y
 O49zQbIoEszG4b7I7VTdJvGN4qSPn0zXpoLh/L+26medMSogUGadgCB39R8GwB4JlbC/MTqF63V
 0fGgZGI7wUgM45Uuo+g==
X-Proofpoint-GUID: zG5bZghjMWfXRaMl_nH-MPn0eBwBRnuE
X-Proofpoint-ORIG-GUID: zG5bZghjMWfXRaMl_nH-MPn0eBwBRnuE
X-Authority-Analysis: v=2.4 cv=VPLQXtPX c=1 sm=1 tr=0 ts=6989471e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=vggBfdFIAAAA:8
 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8
 a=6ti3txioAssqp9lg6qUA:9 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=cvBusfyB2V15izCimMoJ:22
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[arndb.de,arm.com,kernel.org,infradead.org,linux-foundation.org,amazon.com,gentwo.org,linaro.org,gmail.com,huawei.com,linux.alibaba.com,oracle.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42309-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ankur.a.arora@oracle.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:email,infradead.org:email,linaro.org:email];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 5808410B18D
X-Rspamd-Action: no action

This series adds waited variants of the smp_cond_load() primitives:
smp_cond_load_relaxed_timeout(), and smp_cond_load_acquire_timeout().

As the name suggests, the new interfaces are meant for contexts where
you want to wait on a condition variable for a finite duration. This is
easy enough to do with a loop around cpu_relax(). There are, however,
architectures (ex. arm64) that allow waiting on a cacheline instead.

So, these interfaces handle a mixture of spin/wait with a
smp_cond_load() thrown in. The interfaces are:

   smp_cond_load_relaxed_timeout(ptr, cond_expr, time_expr, timeout)
   smp_cond_load_acquire_timeout(ptr, cond_expr, time_expr, timeout)

The parameters, time_expr, timeout determine when to bail out.

Also add tif_need_resched_relaxed_wait() which wraps the pattern used
in poll_idle() and abstracts out details of the interface and those
of the scheduler.

In addition add atomic_cond_read_*_timeout(), atomic64_cond_read_*_timeout(),
and atomic_long wrappers to the interfaces.

Finally update poll_idle() and resilient queued spinlocks to use them.

Changelog:

  v8 [0]:
   - Defer evaluation of @time_expr_ns to when we hit the slowpath.
      (comment from Alexei Starovoitov).

   - Mention that cpu_poll_relax() is better than raw CPU polling
     only where ARCH_HAS_CPU_RELAX is defined.
     - also define ARCH_HAS_CPU_RELAX for arm64.
      (Came out of a discussion with Will Deacon.)

   - Split out WFET and WFE handling. I was doing both of these
     in a common handler.
     (From Will Deacon and in an earlier revision by Catalin Marinas.)

   - Add mentions of atomic_cond_read_{relaxed,acquire}(),
     atomic_cond_read_{relaxed,acquire}_timeout() in
     Documentation/atomic_t.txt.

   - Use the BIT() macro to do the checking in tif_bitset_relaxed_wait().

   - Cleanup unnecessary assignments, casts etc in poll_idle().
     (From Rafael Wysocki.)

   - Fixup warnings from kernel build robot


  v7 [1]:
   - change the interface to separately provide the timeout. This is
     useful for supporting WFET and similar primitives which can do
     timed waiting (suggested by Arnd Bergmann).

   - Adapting rqspinlock code to this changed interface also
     necessitated allowing time_expr to fail.
   - rqspinlock changes to adapt to the new smp_cond_load_acquire_timeout().

   - add WFET support (suggested by Arnd Bergmann).
   - add support for atomic-long wrappers.
   - add a new scheduler interface tif_need_resched_relaxed_wait() which
     encapsulates the polling logic used by poll_idle().
     - interface suggested by (Rafael J. Wysocki).


  v6 [2]:
   - fixup missing timeout parameters in atomic64_cond_read_*_timeout()
   - remove a race between setting of TIF_NEED_RESCHED and the call to
     smp_cond_load_relaxed_timeout(). This would mean that dev->poll_time_limit
     would be set even if we hadn't spent any time waiting.
     (The original check compared against local_clock(), which would have been
     fine, but I was instead using a cheaper check against _TIF_NEED_RESCHED.)
   (Both from meta-CI bot)


  v5 [3]:
   - use cpu_poll_relax() instead of cpu_relax().
   - instead of defining an arm64 specific
     smp_cond_load_relaxed_timeout(), just define the appropriate
     cpu_poll_relax().
   - re-read the target pointer when we exit due to the time-check.
   - s/SMP_TIMEOUT_SPIN_COUNT/SMP_TIMEOUT_POLL_COUNT/
   (Suggested by Will Deacon)

   - add atomic_cond_read_*_timeout() and atomic64_cond_read_*_timeout()
     interfaces.
   - rqspinlock: use atomic_cond_read_acquire_timeout().
   - cpuidle: use smp_cond_load_relaxed_tiemout() for polling.
   (Suggested by Catalin Marinas)

   - rqspinlock: define SMP_TIMEOUT_POLL_COUNT to be 16k for non arm64


  v4 [4]:
    - naming change 's/timewait/timeout/'
    - resilient spinlocks: get rid of res_smp_cond_load_acquire_waiting()
      and fixup use of RES_CHECK_TIMEOUT().
    (Both suggested by Catalin Marinas)

  v3 [5]:
    - further interface simplifications (suggested by Catalin Marinas)

  v2 [6]:
    - simplified the interface (suggested by Catalin Marinas)
       - get rid of wait_policy, and a multitude of constants
       - adds a slack parameter
      This helped remove a fair amount of duplicated code duplication and in
      hindsight unnecessary constants.

  v1 [7]:
     - add wait_policy (coarse and fine)
     - derive spin-count etc at runtime instead of using arbitrary
       constants.

Haris Okanovic tested v4 of this series with poll_idle()/haltpoll patches. [8]

Comments appreciated!

Thanks
Ankur

 [0] 
 [1] https://lore.kernel.org/lkml/20251028053136.692462-1-ankur.a.arora@oracle.com/
 [2] https://lore.kernel.org/lkml/20250911034655.3916002-1-ankur.a.arora@oracle.com/
 [3] https://lore.kernel.org/lkml/20250911034655.3916002-1-ankur.a.arora@oracle.com/
 [4] https://lore.kernel.org/lkml/20250829080735.3598416-1-ankur.a.arora@oracle.com/
 [5] https://lore.kernel.org/lkml/20250627044805.945491-1-ankur.a.arora@oracle.com/
 [6] https://lore.kernel.org/lkml/20250502085223.1316925-1-ankur.a.arora@oracle.com/
 [7] https://lore.kernel.org/lkml/20250203214911.898276-1-ankur.a.arora@oracle.com/
 [8] https://lore.kernel.org/lkml/2cecbf7fb23ee83a4ce027e1be3f46f97efd585c.camel@amazon.com/

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: bpf@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-pm@vger.kernel.org

Ankur Arora (12):
  asm-generic: barrier: Add smp_cond_load_relaxed_timeout()
  arm64: barrier: Support smp_cond_load_relaxed_timeout()
  arm64/delay: move some constants out to a separate header
  arm64: support WFET in smp_cond_relaxed_timeout()
  arm64: rqspinlock: Remove private copy of
    smp_cond_load_acquire_timewait()
  asm-generic: barrier: Add smp_cond_load_acquire_timeout()
  atomic: Add atomic_cond_read_*_timeout()
  locking/atomic: scripts: build atomic_long_cond_read_*_timeout()
  bpf/rqspinlock: switch check_timeout() to a clock interface
  bpf/rqspinlock: Use smp_cond_load_acquire_timeout()
  sched: add need-resched timed wait interface
  cpuidle/poll_state: Wait for need-resched via
    tif_need_resched_relaxed_wait()

 Documentation/atomic_t.txt           | 14 ++--
 arch/arm64/Kconfig                   |  1 +
 arch/arm64/include/asm/barrier.h     | 23 +++++++
 arch/arm64/include/asm/cmpxchg.h     | 65 ++++++++++++++----
 arch/arm64/include/asm/delay-const.h | 25 +++++++
 arch/arm64/include/asm/rqspinlock.h  | 85 ------------------------
 arch/arm64/lib/delay.c               | 13 +---
 drivers/cpuidle/poll_state.c         | 21 +-----
 drivers/soc/qcom/rpmh-rsc.c          |  8 +--
 include/asm-generic/barrier.h        | 98 ++++++++++++++++++++++++++++
 include/linux/atomic.h               | 10 +++
 include/linux/atomic/atomic-long.h   | 18 +++--
 include/linux/sched/idle.h           | 29 ++++++++
 kernel/bpf/rqspinlock.c              | 72 ++++++++++++--------
 scripts/atomic/gen-atomic-long.sh    | 16 +++--
 15 files changed, 321 insertions(+), 177 deletions(-)
 create mode 100644 arch/arm64/include/asm/delay-const.h

-- 
2.31.1


