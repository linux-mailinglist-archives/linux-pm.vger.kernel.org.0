Return-Path: <linux-pm+bounces-22768-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F12F8A41531
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 07:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A97F03ABEA1
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 06:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D3D1C6FF9;
	Mon, 24 Feb 2025 06:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BiQRibNm"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02olkn2044.outbound.protection.outlook.com [40.92.43.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E64A1C6FEC;
	Mon, 24 Feb 2025 06:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.43.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740377572; cv=fail; b=CwLktonPSnlQgff3vfHZX3L/cdmZNEHdINl/0vqghQAfTcVZTSeADgyi7c/IUu4GQFEOQJLO9SVmhL2l4ZV4NKG95/368FDrwuOKtvGHbkfwSB7jSBgRToLJTQbMP7ryiuY/pmKV/e9DXIM5cQmUvTFonO66sfjDD92wV2TNVLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740377572; c=relaxed/simple;
	bh=y5/GfodOADYBuUi/XJZOIjmzHFgFGiQp3RDcUdbfcpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aDcIxLU6d6xsEXfW/KXbfBsJSdj9c/nl5fdUOFzGyzqL2P4wX83pwaUJD31d9rkq/sIiJAdmzwrY4I3RkCTQfO6AbsZ06/mCy7Si3pyEXiiDlxLeYcwyviOrmMmEORmEUT5Eguo0sldXRCpHoWwEInUjLiIFHFcgeWLkfUjReTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=BiQRibNm; arc=fail smtp.client-ip=40.92.43.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hbasU5BcwH9V4WBNCE70QvuScI4uz5LJKMU3NNcIdfXsTwYpEczID8/ISfOmCTGTykXDAG2gLmymMCAJD1FmeKehciZANeif9H7u+Fv54fW8uQ/my4sNig9HC8YEj5mubD0esewibKQWtyK9vu1mPEwaoAse4ro0U7PsjFEglLwKUkzWbJ7/nRYw5YbY6G6thvKHWeMmYtHOBEkGiVkQL4Ryso+VIAXr3fyyti15pBcoGXbsiYhjRGgVWBAh3p+7OfvUwU0PYlQhyhlLrFJpD7+ptCmXNrXAuScNLumY6pToHfQBtR+MVEdNNmdc49WRpiEAKfFcIn/a1oQLRgGZhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/EdbcgUAQZOKmN/YsPH6pyb5rvfRjPLhk5+gDF0YYE=;
 b=aBxwd5haMn0tS+3xkTcGNLYFQHizQyd3m5CcnBDhgsKWkJPuunwL8UWOfLsQGyC11BV0csi/1cIcno79UbnTxEfTYUSNmouMeTV12mNwMktdJdUpR7mMnewFt0hISWBbfdF2aXGwrIT5Wl45OQSy7Tdhs2tdnkzamKgliGRYIf88Lhq/JR/5efVYW+BjOU/0qjRQqAtgs/9lttWYysS1Sjozc+4k1PfqxkbxbIU0bQkoI/rDVXUMbEYveiSQ2llvYdeT3492benAt0PlZ20OtI8UhymW7WVcIdllVsVZtqyLHeDLvJL52LCbziYNZNu44ihhCX8GdUGHCl181Z3sXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/EdbcgUAQZOKmN/YsPH6pyb5rvfRjPLhk5+gDF0YYE=;
 b=BiQRibNm/P5wGnw5DFwq9chfLVfat/6Rg9ncO8ShLZPzdMM9hGTmszPmWpwXpjhI2FgNGK9+G9DRxbYE0tJwKUa2Q5Gerrak+x+A1CMH9yN2oQOU/LVSS2J7ZmlD2DWEOhieiqIjFVDEetxsI8c5iArp69JzUdkg2xL39kfZ4B98HCrrrff7ffpCHZzkS+40lppCUIkGdY4F6zr+YvxbfXV5T233M4xSmtU1rqZvtd/LG56vnHYWwhP/hysIRv4eL8Ei8W2taM6nKajBjPqMNbFKNUaqisA4pNK+bvV5IV78eypFaYtJGJMDQZG85eck6feJofuvy2RulseJWdPOAg==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by CY8PR19MB7179.namprd19.prod.outlook.com (2603:10b6:930:92::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 06:12:49 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 06:12:49 +0000
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
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	George Moussalem <george.moussalem@outlook.com>
Subject: [PATCH v6 1/5] dt-bindings: nvmem: Add compatible for IPQ5018
Date: Mon, 24 Feb 2025 10:12:20 +0400
Message-ID:
 <DS7PR19MB8883591F0D2E21E62025D2D69DC02@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224061224.3342-1-george.moussalem@outlook.com>
References: <20250224061224.3342-1-george.moussalem@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DXXP273CA0017.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:2::29) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250224061224.3342-2-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|CY8PR19MB7179:EE_
X-MS-Office365-Filtering-Correlation-Id: c5591805-8e90-4596-fc1d-08dd549a4349
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799003|461199028|7092599003|15080799006|8060799006|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2H8+p54ugRGSdGHz1hOR1gOjNB+qKpR6LlqS/ZhfMDm+IBsKgfn+GLfoA9mj?=
 =?us-ascii?Q?JLd4gR51y2zLC3/LosKAmQLUAoplvAb1DXhsS/EWHwY5A4ruL/HuPdPVMyfq?=
 =?us-ascii?Q?KFBQZ+Ge/0JSatq9YYquuGCsCe4skn48Kvg4jRGBycWI24zoAXESCnLV9JCg?=
 =?us-ascii?Q?ecw6AVM8xC+Mv46yFKMOCmz+9miqP+lLxg5yjUiqrb+jN/mulclKMg+oh2hf?=
 =?us-ascii?Q?ZzVDjTzR+JvE6eLqmyayuvUQeFH03p6Hkns/7JPIvEqU9pWSt2+wIuCe+1h7?=
 =?us-ascii?Q?4uri6IpI23zgPsn14z/YR1juFFwf9mnxgY1bE82ReVG/ioEoNyHCD6Rx7dXu?=
 =?us-ascii?Q?mFsjYyPcwzLH23NEQN21dwfhMa/lNAxh7wzt+YECFCi5jmKsnNxzFcNYjuZS?=
 =?us-ascii?Q?V1eRpG5Liod6bYaAbxmPHtALOqWcJem9Nwedx6xeU+OLyDpwrllkS3CADJw4?=
 =?us-ascii?Q?Qfy08N1Mks06b19MRkcH8r+KDlEfOsBEDa0zb5nsDDzuCUI9O9FAZZktvBOS?=
 =?us-ascii?Q?ToANbB5M+h8hiZ5L9AHoEPI50Tw9aVN4WDMLudvL2uncrs7WvDI6N9Ee/ixF?=
 =?us-ascii?Q?EbiwuPYoE8k3UaI70l6BgE3mSDCG6CPzR7zVBvTteNcMH/KNIeEJ186R3/tQ?=
 =?us-ascii?Q?fIq9WKUCiMbBAwbQkCdGwaVJ6AaA/oCVS20kA+9VcufZRu7aPj9alxqo98EH?=
 =?us-ascii?Q?vW+bm1xuejVs6LB86lfgv7HeTt7OZYAFzW2/rVGmmbQYfRPkYQn2nFoBGlTa?=
 =?us-ascii?Q?XU1jCbR38VsCdUwPilEJDryN7i8WecqA1eUu0Xhof8Jz3uJkHMMcXudyye5P?=
 =?us-ascii?Q?UOz2FnUF0J5V6EmJZz8q2ZkVVb9akqh//gXNZeIib1iBO6RgJbX8mnUhCUan?=
 =?us-ascii?Q?AZWK9YZez8b7wdasAaquIcmk9pqZ/ApBIproJZE8x8Rflfe2VK7l+g6E+Xar?=
 =?us-ascii?Q?5g3ztV+aOfdkEEM0VJV8jl9yC4aZZ5xweihx2vYiP0qfoRMLvSPRV2tOZbS3?=
 =?us-ascii?Q?adYQDHJ+7mfu9o8ngSfb93Thvnb56ddA9rBz4OvBLtpuelcMdyEUgV70sGkL?=
 =?us-ascii?Q?KDTHnajB9GJR93/UBgPAodPr91J+0CWVD7xxqHO1awSfKI1q2M4=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p8odO+em9bRXmhMIVwtimIftFqXCxuPt6rRnVs02Qs4Xb56k8VsD7OYt90jb?=
 =?us-ascii?Q?9aIUhXg/uq8HUzWgabrKkTLGwgT2idFUk/YPE9N6agS1E2zj0r/+ctHFERPh?=
 =?us-ascii?Q?UB4xH9yMpRNJlaCy16BFHkeXtaDwto/Jn/u9+n/uNOF600/NdPuIbLhpV/Td?=
 =?us-ascii?Q?UOnyFzw2goGcVq0jkFPbJXbQZB3gkvvUjKtmZqZqAi/BET16xb0WJfzHppDd?=
 =?us-ascii?Q?v3SRhXjmB7Jt76UUli6oE4wW1IojLGUKYOVpJjvNULcQB9JvBa+uzt8cZCn7?=
 =?us-ascii?Q?fRpkI9FPOj/+xNUEv63xUyPcW6LVaQjC8RFx7SNIdY+Y0MFXgj8lmO0rbWZW?=
 =?us-ascii?Q?jIR6VMlKo+xUdHc4IsSoUTpcclOhevMH9e0O2MZUO/ug79mLSnujhHQc6JdK?=
 =?us-ascii?Q?8qcOz2F1EKW6UfPKKaR6ZPh21NGCL10Qy9Vf03KGR2GmnYql2gHrwf1BDRf7?=
 =?us-ascii?Q?DachkVX4HAshtJHsvTQYmO9uy0W8qFKHqGNAU6n4dLIMT5zlWLiviQ82xlLs?=
 =?us-ascii?Q?N2FN9j/B/m2Gpja6SVEeb8CkTEWqOyDvfy8oQeEYSxOhH+7fUOqua77EkAs2?=
 =?us-ascii?Q?nwYSE8jAYs6lPzC1OnwPpuRGWNPwm1wi2lY9sMPRAu9adUjaBL/TS43Tvr+z?=
 =?us-ascii?Q?L7YIwNoJPDgDPegtYVuhGEN4SijY+f3/0N7BLwsr8nqinbcxG0v2/a0XDuAZ?=
 =?us-ascii?Q?+MXrL1rrfl5KyNFJ8ChTKzn/deD7p9jZVyQhXSCDPS8ewQ6Vk0MuMwWIaE3T?=
 =?us-ascii?Q?5AHUsjbUuF3xme6oEPFG/O1mK4g2z4X2T5dKaYyXsNvUR6ZN3EUB47Rb/s2P?=
 =?us-ascii?Q?uhZmWxwHWbwNgGyhNxOq35rRvPc94vya1DpxXBcJucjEd99QVwmByTTw8xM6?=
 =?us-ascii?Q?A7scp7d63nNOL/bn8qP/TKbh7nmDADGfy1l3CuuK4V6vWAplQUJXeHDaRTvl?=
 =?us-ascii?Q?T/PjOi/eyaH6AhVv8xRfRAC2q/RojQOhcRmt4BG385DAjbwUqgLALZnYSv/m?=
 =?us-ascii?Q?tR+jHb96MB27hBEaR6FS8bHwk62SOMNHZQy8o5wfAhpM2IzHOWRkMsYHwwER?=
 =?us-ascii?Q?mdQa9VUY/fKsMoheeGmn2r3a4xQzniJcMuKHGLMdF5n6QgH0ZNAi4C0j9IvS?=
 =?us-ascii?Q?QmfhEWwcmmYfk7SUibc4P5WU8WTOkYRTZwOKSWGvwk+DLzi5LBv5qFGHaIWP?=
 =?us-ascii?Q?feJu9eiwkdae+B2lpuAjvf8EAtYoSSdF8Q67rC3YyRzs8VVE8V/Mx/bvDmuE?=
 =?us-ascii?Q?z9u63MMdAzbYe3lNhEid?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5591805-8e90-4596-fc1d-08dd549a4349
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 06:12:49.3863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR19MB7179

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

Document the QFPROM block found on IPQ5018

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 39c209249c9c..de262f3153ed 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -19,6 +19,7 @@ properties:
       - enum:
           - qcom,apq8064-qfprom
           - qcom,apq8084-qfprom
+          - qcom,ipq5018-qfprom
           - qcom,ipq5332-qfprom
           - qcom,ipq5424-qfprom
           - qcom,ipq6018-qfprom
-- 
2.39.5


