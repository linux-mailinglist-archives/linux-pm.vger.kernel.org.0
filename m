Return-Path: <linux-pm+bounces-23051-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 128F0A47B56
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 12:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA3313AC84C
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 11:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113C822A80B;
	Thu, 27 Feb 2025 11:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="DSAkagF2"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02olkn2081.outbound.protection.outlook.com [40.92.43.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D2422A801;
	Thu, 27 Feb 2025 11:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.43.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740654290; cv=fail; b=DH24GyjHZiMA62ZrmQV/37c2FFFSknnYSkjoGXPOz4S0sHcN3uDz/OLBOyYiOPPEdTKRSwuXEsjnjJweo1lL9C0H9JMP7iZkBYUDxpaYQP8ROFsAlqZQbia2RoBD9FIOSLU4V/DECxrYef/yRFDoCuD+20SfL0KetJD3ohNj6Ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740654290; c=relaxed/simple;
	bh=o/YAU2vD+XmzZ0uOkXLeS5PmG+QDMdWFpNVk/LKjeMY=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NqJYFfFbc9SlUMdxL3ZBAobdSg0g3vRhDsfRYPB5rlcat7RUctJXCfDOV/ct8EcBZ75FXx1kMHOji1m6jJuFam5/IZdZnQD1d2rjZ6bGxB5z7MaEGJb3m7+WuonHJi47nDQuR1bB85QIxkbb0SVE21/IFuedB9UdvycD2xoByJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=DSAkagF2; arc=fail smtp.client-ip=40.92.43.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qjFrIQN7QrO+N0Rw1woJfCIzXRczOtIRHkoAts7Yi3U8eMdC4vaB01/MCB2VBVPZzjlIrP7kyqpUNub0gw6vUyngeeep3n5GnBJhw+jATql6y9stnAnQITiROIXLBb/IlVph4Fq6J1QjqblkfqOmrM98znORQ1oUctNxiQGu3r0b8bg+rbZ0rC1bweC+pdtr4/M0CvNWFjkb2Qf8iprOgFErUt9PAZa/cOBnoyUxepzbGl8IyGyoIIkkwAXvyp1larPlN/OOVh+aj4CZfwwm32pzfVVAPRGyVDLozIVCzsJwjW0CNZXfI2Q0Wjlgz6+u6pgwdXq3Wg586Y+ttPllLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6wo0ejIvR/WAgxd5Vz4EzxeuI8nqOTb0CBKg/tbHHA=;
 b=qITIAYedzIVhQvJioC+Pu42VkQyDEtqeVngoMuIRKkJdtymg/FzDISoVdEN3DToEtfTA1b/Jrb0SZ2Vp7Nqfan6XCg0DB6CG0/uIGMDOGwv2OCuvyEU2JGH4NP7fCqXftZashnftTb7ZnPDzE1te+d0BNrYngS83KEoJNKiHe9wuUc1pC+RmU4WkAqzI1kM1mG+o3In6qUWmsbDwznwLkTJr+rR38vwrO7p91nr4lrZ5K2TiiW26LQgMkdls7WbOuez7sVbqpSKVrnHkaM6yKlnQ0KgMCkx9vWhowRkb1CfLKzlUeKy6MCcy+oQIqSibSjPYwDC1qo/LA7RqsM2GYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6wo0ejIvR/WAgxd5Vz4EzxeuI8nqOTb0CBKg/tbHHA=;
 b=DSAkagF2WvdCHClDXzbwvvls5J1JJ9O3Q9Nn1xF3RLRSwSgAa2xeXBLCOVAdDUVo3J10rG+6hRCueBnj2Mx9VJq9+MkUAcqGi02GcxRv8bPWyNzzlON22IS/5aByGQh/DsdBv6WXTLCjSIw5LvvvT8bOuOl42BWPz6Fz0M51cWMYzUq7NT0ZNmouwJiIQkAy9JTK/q1GcAy5Zm+AJdZXgpT+3Lxfnsr1ffHhT3UcF/67iq22cIL4Z8/WmeAirh3/OTyl5odo7ZoKisE5Lrb66psippkIA6oXjJfqCb0+vBYQ08ifuuoR5QtYypKAm6zS2WG/JByHCVxYzhm0hG9yGw==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by MN2PR19MB3949.namprd19.prod.outlook.com (2603:10b6:208:1ef::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Thu, 27 Feb
 2025 11:04:45 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.020; Thu, 27 Feb 2025
 11:04:45 +0000
From: George Moussalem <george.moussalem@outlook.com>
To: linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	daniel.lezcano@linaro.org,
	rafael@kernel.org,
	amitk@kernel.org,
	thara.gopinath@gmail.com,
	dmitry.baryshkov@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	quic_srichara@quicinc.com
Subject: [PATCH v8 0/5] Add support for IPQ5018 tsens
Date: Thu, 27 Feb 2025 14:56:37 +0400
Message-ID:
 <DS7PR19MB8883E82926E44E000170779F9DCD2@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX0P273CA0017.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5b::8) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250227110423.8418-1-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|MN2PR19MB3949:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d3967cb-2616-4842-c333-08dd571e8b11
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5062599005|5072599009|8060799006|461199028|7092599003|15080799006|19110799003|4302099013|440099028|3412199025|10035399004|41001999003|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1GYRogZxlG6b6cVolLQm8z+fi0RvHyFsG/mETnDd97MEx+lgz8VKElWrAWds?=
 =?us-ascii?Q?LN66gsBSfQ4MAw8IGn100MjpQdthf9iQ6Tm8bhngP3yn4vjR2VdPRnjsicxI?=
 =?us-ascii?Q?c7PKtCjQaPA8sS1CME3eFhc/bfoA4DwUdH4chZxRut7x1hNzLnsFjDPUvphy?=
 =?us-ascii?Q?v21Dbqxfp8K5EKO/aJS3inK3ye6y0cLB3SILzuVLcdrqciRv+F2FjGKsy6Dp?=
 =?us-ascii?Q?mRm9Ad5J8kx82tFAbMc29C6bui2LebmwPszAXFo1vgpDdF8F4PVFbmvMUkwP?=
 =?us-ascii?Q?ryeTQ7YhvlFq/jjGSmvtmHjaAUCPiMfdqFsTw+cOMXbYoXkY+eYooSWuxt/F?=
 =?us-ascii?Q?UgVmz2SjUatJlxaa3DXgRUzs9OShspnTKxEz23upfYQqmPvrUe03E/0LMeON?=
 =?us-ascii?Q?P8TkqCNwAB5o/EqKKvqmyV6qN7P6EamHxIXgyyPtVWViYVAuvL7kcib+Dyuc?=
 =?us-ascii?Q?9/YAR3Tsb7u3WCbK1suiWaULx89Dp1KHhDXIO//kIgMWidHFdTSDHTwn/gRy?=
 =?us-ascii?Q?mMf6C0Tq0gDGqGnKu3v7kvRwcOo4WOGS0lB+w7eq5jF8RKaofzChYWuvbrGL?=
 =?us-ascii?Q?hkfsSqcO2ajmJBtOJaBI/qzyBlibQ0OP9QT1M6q6F4HbZB8KbAbZbMWO+/Z+?=
 =?us-ascii?Q?rFyewamv46SSNJrIMPaOBjcYZtU//r4mtKmXcTk6H5HS/TeND15oXqAluF3O?=
 =?us-ascii?Q?JzM7+gH911Op8qN4hRzqUeqpBu/LE/izrQP8PChpI1P2qAJJCN0oNihMOB2B?=
 =?us-ascii?Q?j2GNGrjrqRd2v7nLLtkrzhtHl3T7nBqPIQJRsUQtY1i7ed6NGXmpjACuY6e8?=
 =?us-ascii?Q?99MeJDBlds4EZdyDXkU9Yvc6JDPYZhOu8QBG6mAQ4XuliPdnu/GIZX02AJza?=
 =?us-ascii?Q?KbI8pTNlksUThv6rEvUw+D2GGQC9aeDLBq2KTqiNOctxNTRI0+dCFGM9IlMW?=
 =?us-ascii?Q?wznv6rjRog9bx8ALf3rts+caLHwVM2k+RfTa5Ody66L1Jgg1VxbIwIG4cxWp?=
 =?us-ascii?Q?3Wd7o2fdi117eVvECnyrPAMHcWYwzKrlpdfd558FlZ4UIQZSsC4N+/OeMNpl?=
 =?us-ascii?Q?PFCQjxZ1MHUvt5AoGp3QlT3J/5yj6tC6A6yXUK+rLLV4EuBnBLI07uLXc8gi?=
 =?us-ascii?Q?iyz1a7+LW30p3lSFcNUnf+7kQWqPPG/7CGV4PFNjPtRtJnIclw1Na/V7eQpp?=
 =?us-ascii?Q?udX7L9bhtR4QYjUxTz5ybljQmDfotiPZZ/E//l3PWhvxvriN9K7KTIgbYovR?=
 =?us-ascii?Q?lVxXs9ToXOZ6s7NsedViyKlkUQnd7yFkpMT1A+cRlsPYElYSm9xJB7L9gr8g?=
 =?us-ascii?Q?6FLn6oMGxtOcL/6u8Lo5vxvB?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o1jC88fx+nSGlYkZwYt/9AxacZyaaf2yTVcsEKwU5YwUDrYqJiYGd5H4P6F/?=
 =?us-ascii?Q?C/fhoPdgct0ENfoS2US93eH6HMLKzXc47lrET21j5cKlEMV7pqPt9cUlchmq?=
 =?us-ascii?Q?xBYuqG5jhYJ3rBdS4iIAExICzhFtETmonDJA7JstNo976Suv6OK43a/y5Dx6?=
 =?us-ascii?Q?+pv/c4ZMAI1/1C5r1CoEz5NuTUULRAK0pxylYOv6DbKDqmdaQpTkV68rvSJt?=
 =?us-ascii?Q?f1qZ4M0HvHw0+6NWTaytRrwJdieGmpNwwpf/VQ5wPdSwvaMy0l25p/4U8KWu?=
 =?us-ascii?Q?RNEdlAJ/9UBCYep6jfT/FIyzlc1lZA9a+Doa1UbGQXg8JLHSN/yGa7k98ECx?=
 =?us-ascii?Q?BR7YgjXWCMLPdhr/kquvOcaw+d5WR+aaMCz2UUjFxq0hjOezvF824u+o2Rhk?=
 =?us-ascii?Q?I/SxhBadHWmCSWwnpS83jd6P0pG47qJiGgd/vyV4x5QlLMpJPIuDwIORXF0/?=
 =?us-ascii?Q?Na/ZJ8gTdhYi0ekvdlRcInobL0+7oM3j+0Dr7zknl3zOGG3+TIWv9jhPs23X?=
 =?us-ascii?Q?Y64ZfHwyKGjvoLDDTCwacnH9v4QpB5hQxXwYIVkV799SFPj+R9JHP8PM+YYa?=
 =?us-ascii?Q?/CmhfILW/FOkWTedDuiqL2z0rNN5vkVgWXhB0xxFF+QQeKSuvLx3qK6VReHe?=
 =?us-ascii?Q?luykMOR2g9VLEWvqjj/LhCtFMmzQ+nKzYI93csi4XB5URXe60LWXbN6hjL4z?=
 =?us-ascii?Q?0QwuCsgrEZWrHVskRRw4GDnJYl00giIHhTPu4v8b2grEDzeqgxJC8yuIlhjk?=
 =?us-ascii?Q?sfvp+JMAIHPfdFgvswj78GCpMmniiF+P1lK3yaOHqCFpvV3J1WMQqTm2HWb8?=
 =?us-ascii?Q?sGvUUcOG5BVLAMuPaViOeu0f914jASuPFTi9ADoJ2yBgDTEuj4DmjSwjY3P7?=
 =?us-ascii?Q?m9kEx/PHTLM7ajcqdiCXNRa7CgezOHAKePtEYw7WaYVBHRMSvGfXgHNFpkIh?=
 =?us-ascii?Q?lMb4+bHwQDk7hb9yVoN+tlx/zNJdVRpxnZW7pl5HI74+Dt0o7KnW4jo6Qg/6?=
 =?us-ascii?Q?XI7VlI1ot4D7xISxyrYqR5o5Aa2UW1d+iqIxtdmBCnonDleDWG8QTEfGDLEj?=
 =?us-ascii?Q?ezvtTIDDghMO7huHgDENjlhmJ0eN9AKUgWgYlg2UuBDJQKIEiysjhYAVwEBX?=
 =?us-ascii?Q?7tFbKDiQvAIeKC6TXhVTk9cEoOHhxVA0VChVD1wClrPckNcJoKOKRScV4y3A?=
 =?us-ascii?Q?qQRyiFWm5JmUp3zr/O0NnuxCa8TVGy5iMAiL7PcXZ2D3WkuKrNcUoZ2B9Ire?=
 =?us-ascii?Q?imVpeAT8c2Y7pQgCW03z?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d3967cb-2616-4842-c333-08dd571e8b11
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 11:04:45.4263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB3949

IPQ5018 has tsens V1.0 IP with 5 sensors, of which 4 are in use,
and 1 interrupt. There is no RPM present in the soc to do tsens early
enable. Adding support for the same here.

Last patch series sent by Qualcomm dates back to Sep 22, 2023.
Since I'm working on OpenWrt support for IPQ5018 based boards (routers)
and Sricharan Ramabadhran <quic_srichara@quicinc.com> in below email
confirmed this SoC is still active, I'm continuing the efforts to send
patches upstream for Linux kernel support.
https://lore.kernel.org/all/63dc4054-b1e2-4e7a-94e7-643beb26a6f3@quicinc.com/

[v8]
	*) Tsens V1 uses v1 interrupts and watchdog is not present (only on v2.3+).
	   As such, replaced VER_1_X with VER_1_X_NO_RPM in conditons to ensure
	   v1 interrupts are set and watchdog isn't enabled.
	*) Tested on Linksys MX2000 and SPNMX56
	*) Link to v7: https://lore.kernel.org/all/DS7PR19MB88831624F11516945C63400F9DC22@DS7PR19MB8883.namprd19.prod.outlook.com/

[v7]
	*) Updated cover letter
	*) Replaced patch 3 with a new one to add support for tsens v1.0 with
	   no RPM and removed Dmitry's 'Reviewed-by tag
	*) Refactored patch 4 and split support for IPQ5018 from support for
	   tsens v1.0 without RPM. As such, also removed Dmitry's RB tag.
	*) Depends on patch 1 and 2 from patch series to add support for
	   IQP5332 and IPQ5424 applied on Feb 11 2025:
	   https://patchwork.kernel.org/project/linux-arm-msm/cover/20250210120436.821684-1-quic_mmanikan@quicinc.com/
	*) Link to v6: https://lore.kernel.org/all/DS7PR19MB88838833C0A3BFC3C7FC481F9DC02@DS7PR19MB8883.namprd19.prod.outlook.com/

[v6]
	*) Include (this) cover letter
	*) Picked up Dmitry's Reviewed-by tag on patch 5
	*) Link to v5: https://lore.kernel.org/all/DS7PR19MB88832FDED68D3EBB0EE7E99F9DC72@DS7PR19MB8883.namprd19.prod.outlook.com/

[v5]
	*) Adjusted commit messages to indicate IPQ5018 has 5 sensors of
	   which 4 are described and in use as per downstream driver and dts.
	*) Padded addresses of tsens and qfprom nodes with leading zeros.
	*) Link to v4: https://lore.kernel.org/all/DS7PR19MB8883BE38C2B500D03213747A9DC72@DS7PR19MB8883.namprd19.prod.outlook.com/

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


George Moussalem (1):
  thermal: qcom: tsens: add support for tsens v1 without RPM

Sricharan Ramabadhran (4):
  dt-bindings: nvmem: Add compatible for IPQ5018
  dt-bindings: thermal: qcom-tsens: Add ipq5018 compatible
  thermal: qcom: tsens: Add support for IPQ5018 tsens
  arm64: dts: qcom: ipq5018: Add tsens node

 .../bindings/nvmem/qcom,qfprom.yaml           |   1 +
 .../bindings/thermal/qcom-tsens.yaml          |   2 +
 arch/arm64/boot/dts/qcom/ipq5018.dtsi         | 169 ++++++++++++++++++
 drivers/thermal/qcom/tsens-v1.c               |  62 +++++++
 drivers/thermal/qcom/tsens.c                  |  27 ++-
 drivers/thermal/qcom/tsens.h                  |   4 +
 6 files changed, 256 insertions(+), 9 deletions(-)

-- 
2.39.5
 


