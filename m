Return-Path: <linux-pm+bounces-23145-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CBEA490C4
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 06:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15D2B3B32A2
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 05:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CF01A4F22;
	Fri, 28 Feb 2025 05:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Hy3yNkfT"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2032.outbound.protection.outlook.com [40.92.20.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE0E632;
	Fri, 28 Feb 2025 05:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740719753; cv=fail; b=EpkPOiM5goT0BkgivyI62IPfIWrSaukjf/vIonfqTQGBoE/rA5Nf4EAIyoxctlwAniN6lsca2pFLtXST/itRtQdr7Fzhi3PZoLgrbl1zsEZlMzhFkD4vQWik8x5DVock96fg2KiB5RkmAoaeoSq9+IAoqAIcNw4WuCV0ixRnLKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740719753; c=relaxed/simple;
	bh=h9IzJNMFidrJQb1i992T/k5gaVHKZm6nEZWH+G/riMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F83icbMk8VY7OlEYO1WYfnkg7syNNS1QxqVVB1sBDQBzKhBuvkIcfbG0FX1lwNvD7CVQ4hMq0X+U40yNo6tCb8GPtGELOVvg/CfQ9hLyU2Eu5XNO6L5+zg3Y7eEZljqffL4TOWOqaHbxoYmIEqlfdNniAGUI2wjHE+wkUQg0ukU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Hy3yNkfT; arc=fail smtp.client-ip=40.92.20.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VOc3g8j4WP+NC4rRNZ78h7VN1REm/CSTF9gklnRS5iAOzMxz18BVQBOOKj7ddEuJr/g5NL9YsI+zKvochkBWxNEudj5XqkdxLzIoNG8DDc+KWRrpyGEJGGSvon5WZFExw0YJvhI7pv6CYkxr62CfbAkrDGPsCqUGIqbKRdl4HWQWv1Pn0mgu5ewv51qMbFioNEad1Lpk3rE5A3+yzUFNhTlACr4mvo90aj0LbQJwwndEGhNWMxTvcSReY7ayF6Bn9K5v6mPeVOp3GAYgdXUOMCH8ATBYA3KzooxGd8y2+U0gdCF36lyB+DU4buXCkNj6tTM07nwx39m4oUMbXC6+sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0meMMKvmI5jgnz6bOBgmuYVEZO7+N5tW7s6N2tVEUSs=;
 b=y5B5D+YA22+7SiH+7pYfxjUJhOIemHzKCdvkqmtoowXtoMAwiWJAiyHojrhfSUm2emqX5ZM+kScJtR7xGc5EHNQBfUvq3DanCSE+FvYglPZu8i+qTJP5GbolX09tya0fi1q3BSsjSKm7vvy622DcO+sijnYGaqjL8/Wn/vRqckQBcOv94CpG8xdtuO+bQFN2kPGfqdDlwPid8DMoonsiP4UOMygKuiW8vLFT/yf2fUAPpxFDSrjFnI4//DkJ6vQLf7H65C6dXGTjcEBuaihisNSwisQjAn8RvTyRcwtJIlurda7kvB55ozbynppIkhhqTO/WGm9ykqdU3d1rb/QIGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0meMMKvmI5jgnz6bOBgmuYVEZO7+N5tW7s6N2tVEUSs=;
 b=Hy3yNkfTrkGgblDIdWF9gGF/+c3gNe26xgKbO4xX1ZidwKVCzElxthtpRC2W4nTxZtCF0nUF7nd4yJ86jWPNJL+OF6Pic61CbXqkXqbOdJeSBSYRXDCt8jDlDrXkqDc2rYhfEyg16qBD6oGvWBjSa5tn54z/CUcwx4e0PNI/t3jO8ZiKJYGzyWVq2XMrG0wTS+uMR8vLvbfEFemUpwxtWxu/GMhoDwT8tqGk0WqrT7mIVyAboqqZ9ObKYJWc9lee9a6CekZZSlOoOtZALOGLG8mDBTtbFuIDhD+Au5wKG5uP5Km8K+d5Bumh1lOhw2Q6Hdr/cyegFE/fd74fynCH+w==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by LV3PR19MB8318.namprd19.prod.outlook.com (2603:10b6:408:215::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.21; Fri, 28 Feb
 2025 05:15:49 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.020; Fri, 28 Feb 2025
 05:15:49 +0000
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
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	George Moussalem <george.moussalem@outlook.com>
Subject: [PATCH v9 1/6] dt-bindings: nvmem: Add compatible for IPQ5018
Date: Fri, 28 Feb 2025 09:11:34 +0400
Message-ID:
 <DS7PR19MB888326D1786D232EB3282C299DCC2@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228051521.138214-1-george.moussalem@outlook.com>
References: <20250228051521.138214-1-george.moussalem@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX0P273CA0097.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5c::12) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250228051521.138214-3-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|LV3PR19MB8318:EE_
X-MS-Office365-Filtering-Correlation-Id: b0f113dd-b569-4bbc-4da7-08dd57b6f6db
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|7092599003|8060799006|5072599009|19110799003|15080799006|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cAbGjjwIW1hD9CUsDT9CFWmTurhwc9vvSk742d0mGskuhQ1fT03nEMkRp7r2?=
 =?us-ascii?Q?5nW0YBIz9u+OToSd9R3Ibu2Dh6b9ItqD4/CUtF+iBRP89hI4M1ovNBgE+gmG?=
 =?us-ascii?Q?u6XSpV6gCumnVgz5aqHM/Uy1w8OhJFbjTyJelI8dwEfWrxuhmlp7h3o11k0o?=
 =?us-ascii?Q?1QNhSgCePG1+Y3uYpz7s6mQE6TPwbKDCO5FxQzsqffeMjLWkNd+CnfaoN81W?=
 =?us-ascii?Q?2WSMoVnzj16kvHvzbZer1Fm18a6sAFYvj2WjFpGfnK+XyPeSVEkI21IcLEU5?=
 =?us-ascii?Q?0WIzUAitYn3If6o5i/zOJBKqyqjIVqz0rNU4hEPlt+vuou+soy2+wXk7SQDt?=
 =?us-ascii?Q?1m/IOQdFzHxXMhAFXiXW51YRYYhzPpTVaPW3L5R5WI3qiX5AwQw9M/24W8ai?=
 =?us-ascii?Q?qc6RXRtlQ0QcykNUKQs2//UPYc7+YED1GCARgnGVnH4TNrUD2uozO78bd+3x?=
 =?us-ascii?Q?UCb4uLgQwHq45GSVU2XBifg145DcOkC/sE80+0WPkn3T+KApgQD11FqRsXx+?=
 =?us-ascii?Q?m60Bz+2dPHCiPdRa8bohEWSRtc2sprSlyz0mnnSZyjymKS5/KEoGyQHnEWvb?=
 =?us-ascii?Q?fLHK6VSijfS6tIglHEP3oKGQgzVGy9vVzdZajbwGE1FXrHwJpO2w3/EygTQw?=
 =?us-ascii?Q?2yflQ7pOM8DYPCkKKap0Sd0UeyF1mSDP3vGdbccPVuJMVU2LqVZ76Mpfbc9N?=
 =?us-ascii?Q?uZjURv0AxOzM9v1y5yy6SLe1NvEZcezlCpMvHwt9YBjPjaDOYwPksenjJ8eX?=
 =?us-ascii?Q?Z+UoadtAHDkZV4QqqSlJtlknwPLfOzWgqxFs61JANwkUgJMgTAs8hJUhNDgg?=
 =?us-ascii?Q?QISAAoRi/jYiSmNBN0yHEpJjlKSen9yoeFgr2gmYStjLTQStB5MY7xO5AnB8?=
 =?us-ascii?Q?ng3q/51HYM8m54kXGoHDk4nr4pmFO3ZGS6PMtjPgTb7MTRghoARI+PiRUc1w?=
 =?us-ascii?Q?ajIfJQ6x1pmfkAyfnQ7V+NciYZuudSmVQIRwkCdOVtW1qLfr7iiF9SuKglWe?=
 =?us-ascii?Q?OQqtkUGvYPXiwACecOfaDUPDwdAll9Q9WRcmF/dwHvct3KICR0au0+Xzme8W?=
 =?us-ascii?Q?n7SOJ2zbaUBIRIKw6WhF3YUXYLXBoFbwbusAsAf4nyAvlaaokz4=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YG3OzrcSQYguCXhTXSlIbltXY8jX5Xt34F/4mM01TLCcowUIDaQFlXCda8bd?=
 =?us-ascii?Q?kV+UAltpo7vifr1F9XvqZANOe5mq0NyKBRcLm0p3X2YYh6wdOVEX7nbu1/or?=
 =?us-ascii?Q?Xl33sdhEzX+HHw7M9/wjrAt+ygvd72o/uVl2T2Soe0JsxOC3gUuADKa9Bjiq?=
 =?us-ascii?Q?4YhFOyjAIr5Ym5GqR3I7t7RGbmBa+XrfNlq+X5XtzOVECA/uNVQfAzH8gn0V?=
 =?us-ascii?Q?HZ9zgGeVfnY/h1TNKpNTvAPK4yWh6NImcbu9w2IJwMTzlHDHTi2WuEc87DLA?=
 =?us-ascii?Q?JPSCArrddGLbWBOVQIUualfAhnmn0rUZ/1hFG4GfFcltasykPs8BSoLW7sD/?=
 =?us-ascii?Q?riM0CjxxN8qlNAQLdpbFj4IWWF0IKvvJK7dAOg4mDFdRGFXeX17K4sh9tpP7?=
 =?us-ascii?Q?/uNNlltL5v8vvi/g9QrcpOnn4KQp6NE+Nuw0johzsbLsSupeRnBfxec5DcBb?=
 =?us-ascii?Q?pS/1pHJzPpmzmbu4cyPqe9ihYHvY9p9eVjOnOI/7ahuX5vdOJxPbIepo7ME+?=
 =?us-ascii?Q?3HS4cmxMuc0E4A/vRKnmWxS9i6v6VlTEeRqLrs4sj2UsOJ9YPs695UnE2HfQ?=
 =?us-ascii?Q?GgUP/0d17Ft1qxZ46RJxM/QsYiCMByTftU2V02na1Ofue7psi+Kk9siEyG/A?=
 =?us-ascii?Q?72SznHmX3NS7hQBWZyUnq+H5RalVgcgK+HxOD7fnB/Pb3Z1v05np0E7rDAVc?=
 =?us-ascii?Q?ENGsi3TPyTWEeD5w96XMb0QE0RbqM/jQr1n0863IISRoz27uox0G7DHgGr3m?=
 =?us-ascii?Q?WXQ+Ic2L8Yu7GNp1cJIil6sX/Tkl6+CURLKFjX07tJCPzt78oY8FroLVuzBt?=
 =?us-ascii?Q?wdvqs/5u1fnijNpNKuU86hOrQf96ozyQBsxHiaeXJ+3kJvoslOEORbB5DKpX?=
 =?us-ascii?Q?jetnR7le7YPSoH8pnIeS3QsWAm9CEETzt7dI6OM7PQYrUjFcn3thNnULxfV3?=
 =?us-ascii?Q?3cjRbYKTJ2cEEt0zIA4c8FYf2HtTV6CINbiooXHOp3PhEhh28bGmBpyARBRK?=
 =?us-ascii?Q?v4v/q31rwcdFVXehvv7ub66/p0Sc+iTG8dp1o/yhBm2OAFkfzLeyj0htwxHg?=
 =?us-ascii?Q?Nrhz4pk1HIkB6ZoWQfW1sXGDuhdr3smFSJp4xs0esdmb9j+ScqfkZPVvTBpp?=
 =?us-ascii?Q?Cx4PFBBfXuR+Vxfr1kFHoRMp3kC1jmetvU3QEIatS+T3gRSjDSS9dOx6sVMH?=
 =?us-ascii?Q?A6pMHmeh5A0JYBEG+bpmGCclb4aEyg0uz6v6uU9FzJlQmobhkDNRjW17wCCT?=
 =?us-ascii?Q?itSDFEm1U8u4P7Z+YyT3?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f113dd-b569-4bbc-4da7-08dd57b6f6db
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 05:15:49.7780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR19MB8318

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
2.48.1


