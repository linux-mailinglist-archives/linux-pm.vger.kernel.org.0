Return-Path: <linux-pm+bounces-23054-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 211CCA47B5E
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 12:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 574133A235D
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 11:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6934222B8A5;
	Thu, 27 Feb 2025 11:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="hMqKiYeH"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02olkn2045.outbound.protection.outlook.com [40.92.15.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86C621CFE8;
	Thu, 27 Feb 2025 11:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.15.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740654310; cv=fail; b=ou2Xw/609BPb6h+m/2F0wubt0LLjhG90l80TLVuX2PdlP9//Zth4KAG8zkQkJr74tmVHWGaLbmUf/9dnNwX+CwdoISbcdpilySxUlapWaemp9b5kmGtc6+FLW3KP1aBspclmuEEPXWZn2g1EP/4eZP/PaIII3pD/6tr4DR8mcXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740654310; c=relaxed/simple;
	bh=4W8AToeSAniUgIeWSrkw+QIyEfEFa5KNJcZfOQN7qIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EuKjZu8CjTRcAdHiAOCk5w93MvVxXacEYW7yVgz6DOgnOZeQ2RhbSHoVywswqLfMJJ+A/CpLoue56FDaVNxt+/q4PD1zlk9WcUadRKl9CGMpfcKAOolIleiwrF5ZVyw0ZJHn3Ieo2mQcc1ZsokoOwO6smfYFix63Q9VD1BtlnfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=hMqKiYeH; arc=fail smtp.client-ip=40.92.15.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ngcxgncS7B1wH/UibJ05/a0xbim0Dhh1sIGqnykZFZ0LAwiBtnne/C4Fz85/gF+MY+MvUMSQSIj0mBVbc1rp/C61okXGu2G4LvRP/EPHJEGHvYxqo9QhWudo/BAMXBzZox+SVcvPmdCm0Fb/Fxmrm8JsGd4twhhFp5UZgWLwDnREB0M7lwraFHmiq7qb7ypuh0gkeykDFQgpYa67auv99H+6fipr+QBBvwlLDTM14jM24ll9lcLt86XUmIxrF/RTKMnM2NQQljF1KXo3LiOunCCzr4No2xCRVy8rQ045Ty7TXQ2IF/DJsF5GP8uufMItdvs/ghn+XZnkdTD8fAEiRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYzEb5vhoVlcsGihzy6imGYRwS3qn5QacjAXLwA8oSU=;
 b=b7u8sbet6zLl/e9wH9hF9K/hKhZiXUx2A1R1d3IlXYvCjIkJh47jYhQ2Y8gXccP2nir5E6sU0OMC40onu//xwik5vN97kcO+XqXz1H68NSg7mrU1G3mQRZO9dh38U0vUA+yv3ESYZ+WTT6oP56Czn/5NtniKdmJ5wtqaRAMflGigkW10j6ynG2lEkIvXkj8rLLpr0XI4aGDJuRMy69RaLx+CAidPMcHt9OBD4l4idjzxfdEhvphoX5UaLmrltmAaQ0Awhj5Pccg3C6GONF9U/V+TbNasKczN9L/eduJBjCoMsQRe/V+rWePg5//2BnhcNFmvNt/W4FAJ433yfZX7kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYzEb5vhoVlcsGihzy6imGYRwS3qn5QacjAXLwA8oSU=;
 b=hMqKiYeHJhdSTjwdMxBsYLf34cqyTz1FeP/hufAwXDWmgU0kox17ZXvKlL8916VDlvX2V+/X3UVeSXaKPQSFipnW/R/e3GvEkQIAJCAaqCws8kJGrWF4QjLzmxtkH1YhQlRaivfWyvFC6a046UP2s5oRwy37oXQsBwNp/7wMIm9igPvgK3KaRTLJH5uw6NInhrx0XG3vmDxNI7TCcrHa/qhoVrnZNlxAfHPCjR6QOWD3jk5m1WIhQvKDfHrfhyO1RVhOsbi53FGEyyksw8lUsoRTgUmzCNqd7ELJZ+GC4nq2Vn+ceNXpoqQqt/s2MWhU4Nr8G06UcEVfs87zdFSxfA==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by MN2PR19MB3949.namprd19.prod.outlook.com (2603:10b6:208:1ef::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Thu, 27 Feb
 2025 11:05:06 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.020; Thu, 27 Feb 2025
 11:05:05 +0000
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
Subject: [PATCH v8 2/5] dt-bindings: thermal: qcom-tsens: Add ipq5018 compatible
Date: Thu, 27 Feb 2025 14:56:40 +0400
Message-ID:
 <DS7PR19MB888332FA1A76A46C6820AE999DCD2@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227110423.8418-1-george.moussalem@outlook.com>
References: <20250227110423.8418-1-george.moussalem@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX1P273CA0002.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:21::7) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250227110423.8418-4-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|MN2PR19MB3949:EE_
X-MS-Office365-Filtering-Correlation-Id: 7378b952-2c9c-420b-7b34-08dd571e9738
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|8060799006|461199028|7092599003|15080799006|19110799003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KcK6/tmasQ3UUQBndZcEED81eSIuxkkrXEfk3Jve43Di3Ilbe5S0OPL9lKiI?=
 =?us-ascii?Q?lRetQVkduSScKeRU3W5NkBFhruThjXv743SSjq869dxJs7JS3AxdV8JCIaMk?=
 =?us-ascii?Q?h09GpjWzDpzK/A8/bcSrDBZQ1GH6SEvcsnC3ua0aEOBYQqEq6Ra5vznTFWTN?=
 =?us-ascii?Q?cqGXkAW9sxIHSMn14Bhxlv0UtaCqe2CXV7OFvQALXWJ0hHqwmJOcfPJRYpGP?=
 =?us-ascii?Q?KW58GBfZ5TuyJBuj9AfvIiBr43DMb+JKfIuOR+xyVjf5tbZPH2jeY4IxwGQQ?=
 =?us-ascii?Q?OATn8V3LMSvykoU5LlBNnA7UWAGhBa9xptgG/J+WIyoXk8LhAoE//ya8wLim?=
 =?us-ascii?Q?Rmp+ok6OdTXdm69Zm4K+wGf8qGH0Gqaun+52U5mn9i1rRRnsLj/nwlkC5T5e?=
 =?us-ascii?Q?KfrsCsh+dnc+xKAfcTZdC4ESI+0mmLl4eFilQGrRLkkll/CJonrr9k7U1mrC?=
 =?us-ascii?Q?lZOpmkpfpC4uFApOxUeunrJTHBRr/1iZhbG7/1hYuA/succXwESqUykhXC/l?=
 =?us-ascii?Q?KvUffF8AbFFWl8tNJ+1ABKLsqIJB15nYHX9sAfxkIBt7a83YH8WiQV6MLorj?=
 =?us-ascii?Q?zd1FBm+geeL5vS7tX/6CAJfXraPBl383RnkRP5McuUxu23ljy1ZYeg+AwThb?=
 =?us-ascii?Q?M0PojWacb3FqI2oMGgn+sfsgjveaIbk/NjKvWZPnLs01ekgfPB1VX9Ros68S?=
 =?us-ascii?Q?wYq0ewo6heKcxGt9gZACie0PERD3mgyiavPjZm31YCNZ7nnDlYoqeokGC3lr?=
 =?us-ascii?Q?JuXE1ogcahlSe9eRZlcEcSqXFRR0Wi68fOBKfEjBdo5SKVzCPEh3ELFr7wKO?=
 =?us-ascii?Q?KWY7PZYLVOD6YHiSienf4mRV/6ooQEuHL0VElGU774uP414I6Ap0fdqTm0Zk?=
 =?us-ascii?Q?2Iflndmf3ye+LqPVlvD9WkWwtCC+KbDn5xJBUR856D/+VPq3D2OOygQGlzVS?=
 =?us-ascii?Q?iYc4yuKHgXA3leVv48AIkJx5YIBv8ubkAeeRdJQpJOrAFmxjFuV92c2ieqFZ?=
 =?us-ascii?Q?duxlpkSRR9sqMHoxLUEeHWZAmGrXCUwwDm4BWUbZDN3s+7PHAZQL1GGCAoXa?=
 =?us-ascii?Q?VuEGAjDs1qeAyzZl954NiWGV8HLmYMN/kXYreR6VTfjyNP9vNSA=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZxsfD5M+kvx0JxZx5FUNym/WVCwxaLg2YYbJyX1qVzsYijjyvqbFO6xeED1R?=
 =?us-ascii?Q?ooWT0ReKtK6OT77af7gLosdNt5yiMdOIeCTnL7F2MQETxjvqMpQG6TldVGgL?=
 =?us-ascii?Q?FuHd5XY0zKysDB17bbTzh4LJTXuRcMncw2Nb6cNxHdBfXywfXx+ar6qimiL5?=
 =?us-ascii?Q?stpinj36KxlmoVW0LVzpbnCFgfJRfRcqBEZ8EoguQcPdInsRQdPp2VG8OoAr?=
 =?us-ascii?Q?LUJtKZkiMLV8d+9DFkYNJOH4cpU3/3hnRflnWG8ohFwfVDBnkGR4d/66P4bt?=
 =?us-ascii?Q?36qoOrdyqFXpAhynFbWgbFNve2+0OELvijN8xYTYIG/RBBeVrpmcfmfuP2w5?=
 =?us-ascii?Q?H61ANNC2lax2l8NNVOvfzpXyMgTyxSP0zSYguoZilCWLMU1y30MDoL1MZWDG?=
 =?us-ascii?Q?51ok/FV2x2TSr4uMGeTPs/sqc3f1bOBukz7EKzzVXrJOuoZ4RQqMm1boI69r?=
 =?us-ascii?Q?ZuZ8LoeFDW872B7UA5LYshsMVOdSDoEy32GJ6LIHigxnsd5GmFILI4Ux5fTL?=
 =?us-ascii?Q?fEV3+h6eAZK6rRFpuEPRm9WU1kU8AHj34yONZDgW/QesaIdeBzlt9NIhtbkn?=
 =?us-ascii?Q?EIPb1FYMqYjGFMlGvXUKc3r1VsLyR2FIMsaDtgtIFI/rs7DkgJBw8z2HMYHE?=
 =?us-ascii?Q?znxadm0Sb+lspcaxy9vHJozBJgiE+pc/tMSrH6JmZ9QdGs8WfCvKnOZKSzdr?=
 =?us-ascii?Q?QTM09ndeU0lNv4yiVwxhdKwixoL/MovvN/Q+RTbAX225ZGgYFJ3Ze9ZTNUxv?=
 =?us-ascii?Q?q+42Ct/NIN8uAP4tfKm4UEG4NFBmdDLBQ0JCFJHgNwFtZjsGlMFMFu5cyaPo?=
 =?us-ascii?Q?HrdmHNuXZVr1GUvgZIUpfz/+xH0vxBYqC28oAtEYVTrIXIK6g2zzjEPIiTxq?=
 =?us-ascii?Q?3/D14f2F8QJE/l6ZX5ecqght4Ygh9m+OG57/6vqyU+e5u4z19SVt7g3UCHhO?=
 =?us-ascii?Q?w4Fq+8/MYI6W42VPmzycWZoXtOlj3gIMmBsHG501eF9QSF7YODYfItv+RJ5K?=
 =?us-ascii?Q?lU2SqipZxgBi7urcfd5qVuSjlQWPWKGmTZB7piDN6cpImLGS3AG79v5bGTMT?=
 =?us-ascii?Q?qloSmRZmM9OSSIumSOKERUS8rZ6X4D9hQ6yCSUHEiiz45FmppKBdaXgt2y9d?=
 =?us-ascii?Q?OIdSTwOc90CzEMCpxLSb2oxLKBY5UFYXc65EqTYWcxlqFFMfhqc0PygUOi78?=
 =?us-ascii?Q?nStLgZKRJpaPUzOUF8uFYWolVXVRGOomBTX21LwPHZJKb8N7x80z1PGt/Tgg?=
 =?us-ascii?Q?bpJSRlOu596VKchsp7aQ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7378b952-2c9c-420b-7b34-08dd571e9738
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 11:05:05.8504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB3949

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

IPQ5018 has tsens v1.0 block with 5 sensors of which 4 are in use
and 1 interrupt.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index f9d8012c8cf5..0e653bbe9884 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -39,6 +39,7 @@ properties:
       - description: v1 of TSENS
         items:
           - enum:
+              - qcom,ipq5018-tsens
               - qcom,msm8937-tsens
               - qcom,msm8956-tsens
               - qcom,msm8976-tsens
@@ -251,6 +252,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,ipq5018-tsens
               - qcom,ipq8064-tsens
               - qcom,msm8960-tsens
               - qcom,tsens-v0_1
-- 
2.48.1


