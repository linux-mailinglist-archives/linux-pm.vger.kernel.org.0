Return-Path: <linux-pm+bounces-23052-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91718A47B63
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 12:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D69BF16B349
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 11:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8CA22AE49;
	Thu, 27 Feb 2025 11:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="u53WeFKi"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2011.outbound.protection.outlook.com [40.92.18.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF1F22AE41;
	Thu, 27 Feb 2025 11:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740654296; cv=fail; b=WdPtDL3OmuAGaJa9Z5/FhKIg8/DlU+0BAAHbpynZonJ3PmPCiY7oBvP0dPRy5Lo5HfKwYTjWbj5Bk+2iGGyxlzgfPv6GkR6+YXz6TU5Z+p/1hUuagK6AH3vytdfx065gAorladuYtBmNEiOwcXGXODkVNAnQiBGg0dxHQbb1jhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740654296; c=relaxed/simple;
	bh=/c2E9HoDVSc4zOPNIGpbitmVOKK/Ct5GgrTBzdpRaTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n0Vthp0sGBi0RG7HrdET3OZY2O3z7PNiNbCJjGZShDfX/Js7FhKTbbt1sevvTvcqzRpR4H7H2O0N3V/rTe8/sAUH5QYH9mPZjyiIYZKM+EllYHWT/R6yqL+TcRrixsDc5qezQ/nTtkquFk667DaVd6Cgqedp/dIiY5U7iviKGT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=u53WeFKi; arc=fail smtp.client-ip=40.92.18.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aa6ARKiW4vnSAO52CWwKqNg+fRFD7GGSsmFAOD4adI8SXm9Sp2oaaHF60pprllpf7wMZkGpo3FcsyB7b50ztAoGN2TB69qxkMjJASTFLI7m8IQdfBc2vlQvfn/nMg1RgQ2yDyVaB+476tQzO7X0Bdua0AlGDGPBEOZhCpwoLYJW0257BoFrxRvr5ismpzj29/fAqh7JIjk5PKZKqYBTnzXULXLTFkoXEMiBeeuwzoj2wkqGTYHkbTwLSmtiIWw8gqdRPyZQkLgpiwZjQO0IOJ+Bn/ywz5Ny1zBLyIzLOvYVVeLCLlMKtHHiUX2ax9VHbB/eA2kBOGjUBC0N/G/H5Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6wo0ejIvR/WAgxd5Vz4EzxeuI8nqOTb0CBKg/tbHHA=;
 b=KmK5Iw8CdKUdiyga74RPxNFe8kwVwI8KBSyw3YMkho349JO/7pYw90lFiJYKD1S0h6Jqvh0FODeODq6sA1PeFpLP+fRkllGgMOPvfk+ZJhUVNB+e7A4/+DJ5xbm6ytd4DI0snetZwuY2dkEfYS43YfRfy2AHDaVoeVK15+ClR25JUdx7kWrKM/lNvVxeI5AoYzCEMojBth07+KPD5VXpW8hlFqq4e2uYviYSmnge0ddPQxoPHGY0gLyxmbGC340tGf0cWeRPLCh7sHGSzHI431nJ0QUwlFTTZuWlHLJZUFnACpNtI1YvvBhQU6T3HVAsdL1eRvxnDGhZuRfCHiVmGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6wo0ejIvR/WAgxd5Vz4EzxeuI8nqOTb0CBKg/tbHHA=;
 b=u53WeFKiG0bhxyXxenMANZ6+vha0rrHWvN9p0q6X+jVq1+eAGzox56F4poPydDLsl5Qp8t5l3arm8B770vVNW4Fwh4qvzP1JopfQjaeq9VUePbazu13fhq7z79irG1mR+BbSwsSKypuckmP8rsv9qEyRsuNdo+KN4BrHyyewZoQ0JoNiivoudeHeYm2813gCrnhuicYb4kmFyIjlQKgDB/phxgGkmEyJNiTVH9e5yIpg+qWeBxQUnW9aT2qmPXD4M86eciVZzjUnHd9okRtuPR6DApI8ix/tQph8ogv32HdwhV0fHHdEbvz09Yy3yJEESaJTd9qtR8NfvJlYefk66A==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by MN2PR19MB3949.namprd19.prod.outlook.com (2603:10b6:208:1ef::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Thu, 27 Feb
 2025 11:04:52 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.020; Thu, 27 Feb 2025
 11:04:52 +0000
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
Cc: George Moussalem <george.moussalem@outlook.com>
Subject: [PATCH v8 0/5] Add support for IPQ5018 tsens
Date: Thu, 27 Feb 2025 14:56:38 +0400
Message-ID:
 <DS7PR19MB88833F7A9C8F4FC484977BA69DCD2@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227110423.8418-1-george.moussalem@outlook.com>
References: <20250227110423.8418-1-george.moussalem@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX0P273CA0058.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5a::15) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250227110423.8418-2-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|MN2PR19MB3949:EE_
X-MS-Office365-Filtering-Correlation-Id: 449513f7-c0ae-424d-d017-08dd571e8f27
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|8060799006|461199028|7092599003|15080799006|19110799003|4302099013|440099028|3412199025|10035399004|41001999003|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+zxo7EEEAVbHum2xKkNgHBFPOwTRWpqUdls15YVvhhClqIKNMWMpk/wWTCTU?=
 =?us-ascii?Q?2ViVKAU6ojo0QU/wWPusXCrU5spM0G6gxJpqdekHuTuImgu0zvMlOfIXuQeG?=
 =?us-ascii?Q?CnViCWyxiVrkLnd/H5xqIhKVKcY6ZoOlltgBGzNdP9bTVzobtiPusj945X0w?=
 =?us-ascii?Q?YQF9WKdjL/nOTm/kl1hdmGWrtUX2QCR0UhaY1pMFnGt5HrjebUk8xWCu/3G5?=
 =?us-ascii?Q?778Ggr+hmHa3h8swdRtBrFWSQFHiT6M1GS/aDHgaQVPM2UB+H7yRDtcZswWI?=
 =?us-ascii?Q?ULLksdxAiK5jHYqItnpPixTOGvb/g/t/C6yVo9BcNYFrQ+ix1IG6xUTdulWf?=
 =?us-ascii?Q?DRFgjA+355C7U9yjliNqp/gK+XiLb+5GmRRSvQbE/meGHIRenlz04uMaS9j7?=
 =?us-ascii?Q?teyOhRXZUWWNjdoYasYoxc05QqPY6UvUVhJmxIibnSb3E6AYQuw1eX04SkVv?=
 =?us-ascii?Q?RN5aY2G24RRjISNZUuRd6QIh/OhKZx64wcAOdj9BicY/ZEsvhjcM/QIFLCFt?=
 =?us-ascii?Q?0epLK2cOAhdplAgZSp8vnWFmiKgbfH4Cl5aA/jyNuYsnjPjeBnm4pfAvAeWV?=
 =?us-ascii?Q?eLbJF1ZM6cvMisqayXBb0R4gNB/Ryse4jOii+kzcE9Gj8bXKHl4tn+tJPQah?=
 =?us-ascii?Q?glP52xcUhuxodilxBmH+63YV6o21davhYCqDOdYRqWQ0qYmK2Mwjfg+bWdBl?=
 =?us-ascii?Q?wgTGeGJwsHesfJws/oanFXZCjkLAj0NtwtDobV/UuJJQdj0VcIf05WhS9Bsj?=
 =?us-ascii?Q?WYpHAOqYzHN6fUVnhJ7CZneWvbnWVEesnPVdQ2Mc0qBGS5PeFRHaccNqK7Ew?=
 =?us-ascii?Q?ttkXu6b4DUfHSTiofTyqevCJOEcYMIH5AZVQZFBQxzvmJ9PPHfqhnDxTf72B?=
 =?us-ascii?Q?kgMsfK/aQcjtaGoctrUmo9FfrlyW1YAS31A7cWXMK0VNzM41zqJkufrYhH3d?=
 =?us-ascii?Q?r7VmXzxtfdkKjdQRULAtZFvYK25jaXrICrUw4W8lwhFBR7Xmdr0lAU+DGoXv?=
 =?us-ascii?Q?xPEpSUe0TEcmJUEhTiZ//syDl7O0ViTW/Sh+89MvsFbs9wb59EfRv1T0KnD4?=
 =?us-ascii?Q?TSQxtT3WDTVvC0xrPlsZSbW9Yi197/szXYG81Y6sjMVisaQRGcqhJdyPzmfY?=
 =?us-ascii?Q?4Fbq1nW/BySnZvjTGs+8go8qWtmFJpnpAxAhPw7cNtIOzhaBRIOsHN/lXmgZ?=
 =?us-ascii?Q?WWRLzH3CXGN/IgWzcU8C7GHJtnNTIF2VfAdxCJKQqSll8Y900OfHMqjnZEns?=
 =?us-ascii?Q?4NhYicH5JCkg675W++W20Ii8tahKCL3c7q3k0xpSebd5vaYoHGvuabTg/OJI?=
 =?us-ascii?Q?8A2tfnwMv4uJa7Rmo13ajiEk?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7rA5qH8ljcaNPYaP3Xr8cJ0o+H2A5G+e/xU8Mo339vGdN93GA37IwyNrtEwY?=
 =?us-ascii?Q?VInBbx09Wzw7NUdX/2z/Bgy8hd7ugWLSfdPkfixxBUviGwQrVtlbKfzeJCr/?=
 =?us-ascii?Q?Z9YstADHe9T2AqgWUUf5651KJ0LYXBt2VcAbYAiBu4fc/cCH2pKkbbreYq8+?=
 =?us-ascii?Q?UNygNEjDbH2bz1Os8u8CeNMyq3WcGnzrOFmBXLOxmL35rGGLnLn2PG+qd9Qk?=
 =?us-ascii?Q?OK1PFGQbJFLhhJaNZ23fEMJf4rZddAu0KbOjMLzMGLK0Dki4gz87xJxmclnd?=
 =?us-ascii?Q?76FbxATf9po772Ta9Ib2EjX5AGVwLV1Xn9WMCTJrFTy3iwEsGyRMgZEaPwAY?=
 =?us-ascii?Q?bQijKjwf6ejTNnz7zAFq+uIwWPNZ86xF3IlTwJ3gbyFoWZy3YvDijlKr5gH1?=
 =?us-ascii?Q?VHGf2KeX0kCjjTxgB5UddEXhVTKv1MY02lxEAMkJ+e4LrdAwAurDYx1Yk4tD?=
 =?us-ascii?Q?lEMAPWyZp3K634LnHLikgLYpvoTsTzxcg5/eLadLIXQnQFPanLPBUzXjcGdL?=
 =?us-ascii?Q?7GYbSvHi29O/e2NHI1rRwi/ugsaIS/HfAwZ9pBA728VTB9+zwYFla8PtUU73?=
 =?us-ascii?Q?jkzHhYSlBIqtEGP+D4eyK86/MUX9n1B/jKMtSHC20zEBtDF5/aff+uwgBSxz?=
 =?us-ascii?Q?d/pWtgo8DazAc7LlFDil8TP/GF9IaP8Daqjm3EH6cIscs1mq13Fnx6L/VSQ/?=
 =?us-ascii?Q?aT2URJCNSoOXHf0tVridIVY2Kz38SmXeVhWD6OJQ0+UdMrr4h+8VUI4WXWHL?=
 =?us-ascii?Q?McBK+d+H3jalUPkcHv1kKENrPEuyq0sbtQwIuA5tmO6FNhxSPwlk/Hc8vkh/?=
 =?us-ascii?Q?7sUwX6EGl9vK/dC25BnTFoBdwTtPS2HTsG+47Hxw/7W/ZaEHVFh9pK3Gir9H?=
 =?us-ascii?Q?yOy2Qy6Foy4zcYjbYnXNUp4/RdqYmqv4mC9fk6LUMb9TVVK09xLEqu2YLK10?=
 =?us-ascii?Q?20LqImB8T7j2FpduXKTLmF5IS7JQa0AVariwFJkMnMZBeJSgxSmfxl037PWe?=
 =?us-ascii?Q?GHrJdmTcRi/A/0qkaBBAQ995EAvIg3t77tdz4ffk7wBb9I6YbLy/QybOvCwy?=
 =?us-ascii?Q?x/H0bShZCehoC+IEcNTS6HSRlB58vOrasIsbPXlJ1vPzUEZbIyH1B1aOsUTp?=
 =?us-ascii?Q?Dd8WMs6ZT0Eky+cI5T6g0rG8aEzhCQC56V0ayYCikLsjUUbwhy7hpShbSjEv?=
 =?us-ascii?Q?/rtwYhH0W0jY1bXZcbQVc8AjBatT2GkpSi3Ojy5ZglzwXGHf8OmTOmzncjVN?=
 =?us-ascii?Q?T0c92zJF0kzETfiqmSWS?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 449513f7-c0ae-424d-d017-08dd571e8f27
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 11:04:52.2708
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


