Return-Path: <linux-pm+bounces-22659-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C07E3A3FB04
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 17:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA38F8639DE
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 16:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028ED1F37B8;
	Fri, 21 Feb 2025 16:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lxyWEOSO"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2059.outbound.protection.outlook.com [40.92.18.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305581EC016;
	Fri, 21 Feb 2025 16:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740154278; cv=fail; b=aFq6p2TCiKG2yILoRqlP58FqijW9xT+C2XWSjm7Zt0EXA3P9iDwG/ilTdtKybWBv6W55RuDuVYgdzy7EDbKnZpohqej8cLuXaOnif2ThKOp1YSsI9u+bhQObmr1jdVQccYHjl80AUJfer9tf4kKOJ/9JZS7EkdXQRspbXEkoLk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740154278; c=relaxed/simple;
	bh=XmywJEHqsrVx4/SUVuGG0Sna1QRlSN3O053LtdIAhzk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tFGPVXtZgXx7IlZZfBXc/m90xD2lymNkdIr4A8LlKsSEko5l07OeyrbavuNwbb8QqY5+Z0F5Bhxj1gYxK2rhdSrPhrdkmSrWQzuG+QQ3C5PFB7Xa9NIyM/W29nnQKlK9Cn5f68j9yK+2O8c/W3K2yGtgGF645+Mw6Nj95vzFn+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lxyWEOSO; arc=fail smtp.client-ip=40.92.18.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w2IrrvhXLuBGozXLdCh4QxXaxM66pCnA8FeWSzpLbvw5QyObf6/CvVnskWyb6ETlah8hq/efM6gfyAnuyWMIkN+G6OmKu2hJ75w1SxTkz9socRa0nmUOWzA4k10A5qPgwVx4yqWd6mKLh/6f6eDug7cUJqpZu39mzWl4rAIQow29F1t+hLgJrnGjJsgdl0aiGSQQ/49EuCflgiUpUbUgJWPSOezd1ujWEx/HJJMsyzAWpc++xfLw5t9fraxUtK6tv0ll+VuUYOJ37pZ+g4dRE0Z/1psOB8ADoKWllrWalBWvcsZSDg50y/6ooogBOAmBN1RCSd76ZTOTd1UdFyte8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+RyT6tH57KfZUeT8M77dFcoFBL27LWxIVYzrlEAYA8=;
 b=AFsD0VZLizsar9Fyhw8FS1y5eP5Sb4U8OX+ckVAfnNG6R9vzMHBUqU9KGIpWE7EU8Q2kXd44OV7LlAMeA1GRaBnVcVb/ysx0XA3WfuMu5KrSvoEmqZNT+n86mFt6XCsiDt5nn3EPhc0k0UovU/i4tI8bHuFITwmaUeh2IGVT0iYRE85zmp5Rt17u+Nmt5X55NEqtTxNYGzRkGUE8PRQj94KWOkTB3wFUHyyBI8/XCxko8kek9+uQ/uJm5AX4L8ww3zcehgipdihV7kw8DNRBHkv4GmXf/M1U6cDhux+yuGg9ZQllGCX8etYzxFRNPS7DTxmj0w420ZgjRJMbegJuBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+RyT6tH57KfZUeT8M77dFcoFBL27LWxIVYzrlEAYA8=;
 b=lxyWEOSOXTMDiy0vi0YUx+lQp7z5OChnct7FoT927PVIlelL5eZ+Ma8yJoC6G4JL2JRV+XbiFLJoaz9nF3T6PxR9s9LW0JTrxoaFdmvR8K2zrvanhirgzRSaRcaJ6601oPZ+Zcn+6lmc7yKfJ3jpHSjs8VXuN5i4a+3oIsz0E9t0AUZLo97iStVKX9SrKDpCyAwYsxIt3YewhZdAkTXVVBZoV60kyzbiaTRTFF8iwX7qjEjuZj8+e+9BEFJmoVl/5i2wVuLaJopo3xUMOPbRINHcqCWjRtj/cuSxX4GNM5/i0cnISjUdd1uEtltecIgcg/HmtnJsEph9oewejMoAgg==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by IA3PR19MB8736.namprd19.prod.outlook.com (2603:10b6:208:51b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 16:11:10 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 16:11:10 +0000
From: George Moussalem <george.moussalem@outlook.com>
To: linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	amitk@kernel.org,
	thara.gopinath@gmail.com,
	dmitry.baryshkov@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	quic_srichara@quicinc.com
Cc: George Moussalem <george.moussalem@outlook.com>
Subject: [PATCH v5 0/5] Add support for IPQ5018 tsens
Date: Fri, 21 Feb 2025 20:10:56 +0400
Message-ID:
 <DS7PR19MB88832FDED68D3EBB0EE7E99F9DC72@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX0P273CA0051.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5a::11) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250221161101.17204-1-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|IA3PR19MB8736:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f197b71-7bf2-4f32-5f81-08dd52925ada
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5062599005|8060799006|5072599009|19110799003|7092599003|15080799006|461199028|4302099013|10035399004|3412199025|440099028|41001999003|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o3q0fkybuacqy/dTU57Mkoc8PziE1sfpbLFmRwSuJxnRZEpPE1QTuFumyiGq?=
 =?us-ascii?Q?ICnwmouhHYsrYAYggyAiN1Ls6bYu3cLvVWQOInDf7J57oSGigI5qgKCV+8H7?=
 =?us-ascii?Q?MunWWoXOs03BXypWHTtkePSFN7Cp/QglOndv0T8XlBFs4oecQexeMMI19Hlh?=
 =?us-ascii?Q?rzC3i5g8XQtqc0DmbPecMdLSAusGtCNbicZ78xSeE/vy0NnE0Jzwy3rG6k0P?=
 =?us-ascii?Q?dkIDQ6WLYN3oNnRmaLehpanHGGSy3iV5foswIKJM2zEfz4IdWdXF66I0NXUF?=
 =?us-ascii?Q?Rk+aJt+Wurq2SbCFwiOY0s1hYSLdy6PMnjG6dmCO1P0GkW/dEUa9ZK/vTW+E?=
 =?us-ascii?Q?48vl3FZRzdCyWIwBJUko+QKcGhv0SW3G5xdVRR4PDbvCSuldiP9C7MT17yOw?=
 =?us-ascii?Q?zQikUdiqzRLB4AA7YVQ3W8iSDGWXd1OhrkfGIJx3hSsgBlWneubc8LY4MbPF?=
 =?us-ascii?Q?uon+fWtK/t4djQlIMH4oeYRzqDP9Ljvy4tiZXNEWddFpXwr9Ovi1HpO7NRLA?=
 =?us-ascii?Q?Stgww3QfV2HuaOKNhh/68uxBaPoE3I07odaMC2dFoo16YqGe/ROKyFc/PW/r?=
 =?us-ascii?Q?fMAb/4Wy69ijzk61UwLZrsg5u1fyDGLtrJoK+mWnAw3gTa80zzMluw9asyMs?=
 =?us-ascii?Q?+j8e5xT7gzNQrphEFiUFr0WWBeurKgSjVDSkP5hqaa+jV6C9xWMJHT1oupOQ?=
 =?us-ascii?Q?zil99qdtCuPkcv9IhVSJFPqt7AJUips9ckLyJkhwmMqEsWcXvO+S8SlMv8M8?=
 =?us-ascii?Q?DE+ETScrq50euAYp3t5+4n+airuqDkMLDdwwjhXFfSbh+HE64RM6lpA3svt8?=
 =?us-ascii?Q?B6bB5Cx5z/utwvg2e5A1S0rltkZImqFTHcX2TVIELzbF76bKNcbZ2mRuEbm9?=
 =?us-ascii?Q?wklUyLLKQ3Su31eFexQy1sS5Cs6LPlVqh9MHZ+zog8ysQVZ8Z7eXk2L6/6Pn?=
 =?us-ascii?Q?gm+IkNRZSZBZ0f5UB7IDX8I48SDpSJWc9+qp8jMYZZbndrDPIIs6o91y8lLY?=
 =?us-ascii?Q?3lXeGmvp/0j2sYZ4gOdkl4/BIoTqL6oJiTt5UcwMXN+F25xBAy6YloNJJI1r?=
 =?us-ascii?Q?Fn8nHztFKBnDWLD1PFqePNpaIbqJeSoSOHu/d3OMJnPCDnpqj0qm6ROfbEwb?=
 =?us-ascii?Q?bQtmszDDaGHJww8fBBQ8x49p2ym3OVLF4r1gv2+s/fpdiN/YCv41qVHMhfwG?=
 =?us-ascii?Q?Rn6Z8uy9/1jIDVNQKGi8gznJpJsYKeGxyDiLOszsEmz3P3FEMH3+qXhXMA45?=
 =?us-ascii?Q?fCGvmKTwP8oTS2DSv0Tg8/MRqfPBtFgcylFxFGV+mc5QAT7EZiMI2Th4BTqV?=
 =?us-ascii?Q?lGoQKCl/hNp/pztc+tzjvGK5No5KenvLB/NFbI/+nl903A=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6nqk3lT68rj8wUQxG1Q7lVk6580MBCMpuJAluehwKmr8q+R158UO5o4I+Now?=
 =?us-ascii?Q?zy7LrjIISxr5r5hWWr5tEru41s/Kss11fR20faw7uMhpuILXicH4R1qt7N4A?=
 =?us-ascii?Q?tdE9n+H8c1+wZaDRcbTKCk8z1apJhFs8HYjMuyosh+vmrA+eZvtUGZB71u7L?=
 =?us-ascii?Q?UWR6OmMaGw5GhOGgoy49z8BmzT/D9jgLzXSQLrZERa1GNj0iDIqI2Vqsep0d?=
 =?us-ascii?Q?Hjik+uyHcagiUZe++wJdIfThDDVaTemHamV3nqlVgb35BDf8Xa/mw6D2NR//?=
 =?us-ascii?Q?8TnhKxKN2TlBI3iFsZY1EpIO+q89UkUoAx8GQBuIY8kBer6Wya8ufpYXvMY9?=
 =?us-ascii?Q?atROjaMneoBOsNgiD27jC/ZCNU4CskJ2Hf3x5GWEVtRy9/nxiw9YIIw/cnYU?=
 =?us-ascii?Q?xHD/WcHHHG3btXumBZdyl7zlDMckNLZaM45DsEXTpgKc7YpPWA85OxcerhmQ?=
 =?us-ascii?Q?s/aD1JEEOJLCzDYsNzDh0XtE+Uf+qwBscCRYLEWJtbk4kjHfhMVUKIKTJZx7?=
 =?us-ascii?Q?SIX0pGjptwiqN+QuYUNoSa/wSicuv8VV4vOnnzizrFLHlxN4E+sho8KLHzXX?=
 =?us-ascii?Q?jsdl685X+hKrjJSwrDERRtLaprs5zA1bWwBV1tjOC0XYZSiDDSv3jhvPQw/R?=
 =?us-ascii?Q?lBh8Tnh5T3cw44nPViRDm6IP0glZgMPr4kduFVKLVfTn995r9eoltv87KZpo?=
 =?us-ascii?Q?XwuiQTBE5zMJNsiOP03DzWmy7edRrbamFK+Cup5fsvcRuJhOy3fDxgx+lx2U?=
 =?us-ascii?Q?67omZNGefu9cgOTLt8irHukxQlfmpBNGMybWdB/iMVGI8OM3t5r2dlqgteYG?=
 =?us-ascii?Q?AdOM0t3PzM1ZGurC2EEPMCSpAkughQPzwTy/eBQX+6lv7qD2Ef/xZP+R7PaZ?=
 =?us-ascii?Q?/qA7ETod7h1qkqbzDiQExnYAFrwns83N/6OaaWKH334QZQXw/3L7UCdP+0bF?=
 =?us-ascii?Q?VuEL7E+2rBPrp/lz9h/Kk5iVR7TlRaOkQs1+AWV8rH+Dt8KAGsvrEZNlih0E?=
 =?us-ascii?Q?nXJWE++4sdTawjE+Nk+EbLsDj541mjO3h/6V7ch52BZ7yd+DlFKMOm+u2dlT?=
 =?us-ascii?Q?EvxGOWbMoE1DxhxduUy8hEGpKkpJd2nkyMRvvSaVkdIuicFZsRppf1zQsCM/?=
 =?us-ascii?Q?4M8hRPvnnasxhDbpiXZpl5Q0kM4Xae41xThefjBJNsQLhMdj/RRA+sqz8Dxq?=
 =?us-ascii?Q?NCvb5QfQPT1KxUd/GrxW71VJXFVBIKxaPNWsJROk6SH1p4wgQrX0OLOKzoxU?=
 =?us-ascii?Q?xqw0ktP/mLYPRtgOTID5?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f197b71-7bf2-4f32-5f81-08dd52925ada
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 16:11:10.5393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR19MB8736

IPQ5018 has tsens V1.0 IP with 4 sensors and 1 interrupt.
There is no RPM present in the soc to do tsens early enable.
Adding support for the same here.

[v5]
 	*) Adjusted commit messages to indicate IPQ5018 has 5 sensors of
	   which 4 are described and in use as per downstream driver and
           dts.
	*) Padded addresses of tsens and qfprom nodes with leading zeros.

[v4]
	*) Documented ipq5018 in qcom,qfprom bindings
	*) Constrained ipq5018-tsens to one interrupt with description
	*) Added Rob's Acked-by tag
	*) Added Dmitry's Reviewed-by tag
	*) Fixed modpost warning: added __init to init_common
	*) Sorted tsens nodes by address
	*) Sorted thermal-zones nodes by name
	*) Link to v3: https://lore.kernel.org/all/20230922115116.2748804-1-srichara@win-platform-upstream01.qualcomm.com/

[v3]
	*) Added the tsens-ipq5018 as  new binding without rpm
        *) Added Dmitry's Reviewed tag
        *) Fixed Dmitry's comments for error checks in init_ipq5018
        *) Ordered the qfprom device node properties
	*) Link to v2: https://lore.kernel.org/all/20230915121504.806672-1-quic_srichara@quicinc.com/

[v2]
	*) Sorted the compatible and removed example
	*) Fixed the name for new tsens_feature
	*) Used tsend_calibrate_common instead of legacy
	   and addressed comments from Dmitry.
	*) Squashed patch 3 & 4
	*) Fixed node names, order and added qfprom cells
            for points seprately
	*) Squashed patch 6 & 7
	*) Link to v1: https://lore.kernel.org/all/1693250307-8910-1-git-send-email-quic_srichara@quicinc.com/

Sricharan Ramabadhran (5):
  dt-bindings: nvmem: Add compatible for IPQ5018
  dt-bindings: thermal: qcom-tsens: Add ipq5018 compatible
  thermal: drivers: qcom: Add new feat for soc without rpm
  thermal: qcom: tsens: Add support for IPQ5018 tsens
  arm64: dts: qcom: ipq5018: Add tsens node

 .../bindings/nvmem/qcom,qfprom.yaml           |   1 +
 .../bindings/thermal/qcom-tsens.yaml          |   2 +
 arch/arm64/boot/dts/qcom/ipq5018.dtsi         | 169 ++++++++++++++++++
 drivers/thermal/qcom/tsens-v1.c               |  60 +++++++
 drivers/thermal/qcom/tsens.c                  |   5 +-
 drivers/thermal/qcom/tsens.h                  |   5 +-
 6 files changed, 240 insertions(+), 2 deletions(-)

-- 
2.39.5


