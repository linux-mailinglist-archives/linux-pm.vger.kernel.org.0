Return-Path: <linux-pm+bounces-31762-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C794B18381
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 16:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D4214E6DE6
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 14:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3119E26B756;
	Fri,  1 Aug 2025 14:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IWsKB1Yn"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013057.outbound.protection.outlook.com [40.107.162.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E42038DDB
	for <linux-pm@vger.kernel.org>; Fri,  1 Aug 2025 14:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754057696; cv=fail; b=MDZ/R6YjdE+CQFczeisAkWG3S7lAfV76a9Dx/p8gjfva21dMYs7l4hx/M5okw2eB23WcpiG96p1dHA24ooTxAWtGLn7vZY7lboAQYrPFBMgtRs8MPJPX3vEIl0U+nfHLcr+RabEmLBoFEe5pSxatuSlJW2s3xJq5NRzG/poLg8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754057696; c=relaxed/simple;
	bh=uzz4QtSLJSODcNZRzTDLwjtrs799BWNqXFfaKymRXR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YjxQ4IpgujQn+EmWIOvOM3OOKxFOI6d28SyPhkAatTo59TymFbwPKKjIhTfR3+fRb2XhcuipTQ5f6sPzHBgja+9wrsKaN8lA6i0Ur/8cgXoEkL98H6oOn3tVlNx3uro79SWzMRy/baneVOBDuAA+j0E/6Qu/tOzEuWPDQNnvd4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IWsKB1Yn; arc=fail smtp.client-ip=40.107.162.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NZYKMw3ufD/4Aq3lReO2jIxm7FBcXRiC8EhxMkhfr/bg6k+/ccgb6JSpAFCzFaUGgzU3Xlsei8yNT9idolsS3r2fdqnAaortMGqt6oJygADP3Cwx/Y3UbDjasygxlweT0rUi033LEgp26TAkh7vct2L+0GR3/TfSi8+0hOiaJ7hVz+zpe/PkXgc5D1pQePjUDe7VwP1E/zfDP31adJIJUSKJ5xnryJZngJiDt2Iz9A1aQzGaXXOKf9G1Fe1GXuoL0KERUjp4PkusYAroWmbYsVT86L/3cQKZhjo3DM7pQyl8YAvCwp/FSPCnaHTj3qp1x+hqr2OuikhY/1U2SwPfAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9aKU/hCyDnd+iAgJLktlkWlrOVWB2JuKuPtEgqwk02o=;
 b=SBNoNLY6taZvDgdvoK/lk9w07WV6mD1QGH+icugkqg2k9HFU4UrxdsmgDXZbzUlx5WQWKm7VcyktTD5oNi07aolH9wcKaXO3EAWpgLWko8XsiykL05gfgjrOvp8P73LKVKYEk+2enVUZNKei9v0oBkO6Itl0hVgta8Fw5PXUMbdbD5+JtodYYwBNZi5CD60B59zVL7z3Qkk+EqEjiTHVeZkTD4ZFPTp7qQWOxt+XS+1goQd3/o03+GW3NsI7RGayO0/yZk9Rn+WMsN1KjduyErU7YtzRmrSYiBMMs41WWspjNhJA6VdtyAErheb1WRjvP52fu0E8SAWJqBVWOCvHzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9aKU/hCyDnd+iAgJLktlkWlrOVWB2JuKuPtEgqwk02o=;
 b=IWsKB1YnsI2Ptr1uNVnFh6LnGv24ZyDdb/W22fzIesTqyu+QgmicHas6ykq5k+GHQqgHiNj9JlWywa9RRRgtw0QQgzzdMRGfqHav61bBG4p2U0IaGJTEDDtaZkrT/2+yX6/+Eom9O/1C69T9JJTD4WJY62Ly+tXhA0YU4TOJ7dGQlyRhUiccTVTWxCSO1HJTjZmWGy0qs92LcnUdqXlsctq63PZ3Zv9bS5ecB5Vd8MwRWcM+zPeAoW2d/4m/d/hOHrsPzjROfwgLtnZzfaqmzzqJXKCu5HqlU1XmcFXNpaBeNUK/HqbKLAQ5uPx89E19Ktgb/kX901m3IXwozDR5Bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10228.eurprd04.prod.outlook.com (2603:10a6:102:454::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Fri, 1 Aug
 2025 14:14:51 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8989.011; Fri, 1 Aug 2025
 14:14:51 +0000
Date: Fri, 1 Aug 2025 10:14:44 -0400
From: Frank Li <Frank.li@nxp.com>
To: Jacky Bai <ping.bai@nxp.com>
Cc: krzk@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
	rui.zhang@intel.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	kernel@pengutronix.de, festevam@gmail.com
Subject: Re: [PATCH v2 1/4] dt-bindings: thermal: qoriq: Update compatible
 string for imx93
Message-ID: <aIzL1L6zLuhy11pT@lizhi-Precision-Tower-5810>
References: <20250801081119.1999298-1-ping.bai@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801081119.1999298-1-ping.bai@nxp.com>
X-ClientProxiedBy: PH8PR02CA0027.namprd02.prod.outlook.com
 (2603:10b6:510:2da::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10228:EE_
X-MS-Office365-Filtering-Correlation-Id: dd9e3fad-6400-4fe4-200f-08ddd105c7f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YfwpOEdqKrMspEqaLfoybreeV5fKXX6z8fcPhutYtbX27EylDL9bqrhRP32t?=
 =?us-ascii?Q?3F85s3KJmVDrxT5Q7a6lRB13uC1EdyheMQp7jSbuOLqo6TeuE5oSrrF9o5p1?=
 =?us-ascii?Q?cqIXwCCN9igOKCV90isiioEO8CqOkxcdRI5yLr4DO5bteuosr+Ge1Rqt8KD3?=
 =?us-ascii?Q?wDSDCt3+3n1PknFPWfQbuWMDgOXZz0YJEGCljKsxEkUMjaucW0aKK7rWzE2L?=
 =?us-ascii?Q?8+953Cw2LTnrgyCe8HG1tOJFWzJTASV83GaKyVN465fzEgXqq18WrinTLfgc?=
 =?us-ascii?Q?B+RxavM2lixU9bVjsfnToTx5QC+J+xTJp1Ex9FFdPCCbhPSWDIRp9oq3ZadL?=
 =?us-ascii?Q?0NJ2sXJFA0faCp7qnbt5rvSz168kFVnEvKSfitoCm54vwd4FrFlafYUGi6w3?=
 =?us-ascii?Q?INeOJuRg0evETgDTvdbvf8GufWeDwyZGJv6Wika6uAPo0qFIJEvHu8wdQKNZ?=
 =?us-ascii?Q?/xfUDg7eAa5pgf0Y0fPb2U8sosBammizR2G067PT7+p3tfOh6NgXKIELUmVk?=
 =?us-ascii?Q?KGQzbkHJ08w7rzTyhipgZ1/lZSTDs4hXH7Wf3AH739eanM8jYaXUxB/4Lzrl?=
 =?us-ascii?Q?Y7qaS4TlXq5b/IVTAj/X8XAerObRZZhIme6PMZdDqqI/TbY4FAOMlR7sc3sN?=
 =?us-ascii?Q?I7unTKFMPoaH1GZWtOeAIRut5w+1ag7zJ3zTeURFArKds+bvf6TUDQYE7LwG?=
 =?us-ascii?Q?AbNGZ1GOqq8S7wzZX5Qht8Ce4ZkZsacmuCe7I9dleg/1eXtwZivbwsb16zyE?=
 =?us-ascii?Q?+zRIV4asrci8rWNBQ/B4IpkapzeuVFpr8pDj3LjMrGavYuKnG55nqkKR/sw+?=
 =?us-ascii?Q?qSXmYjoTloWswNkWHn+Zo1k6DiB0iLdEQFJ7sVXdpS4QUnv0RtxVOQg0iBaj?=
 =?us-ascii?Q?NuzSBdDyXPSURd0x+hoA+DAA+RJQ95S/IH5/z4E4h+l/Wo6JyrpIlr3A9onh?=
 =?us-ascii?Q?Bo1R8KYI3aTch2tWHilrglEiaS2hwcS9qmbhtjFfSdEv//d2UiNxoXUsrpnH?=
 =?us-ascii?Q?Nimbj/ae6Bu9rZGjcCRcMeWH8pyooxFt2nFXcR4jwsLjGnb9VFLNBuxkLTAM?=
 =?us-ascii?Q?tpQPSt6a2eFrXQdCurr2Kf2kLVjYIiFc54yUv6WnVo1m+XGGG5MjmTDYc7Zm?=
 =?us-ascii?Q?TNA1r1mvF+9uDgU4eR44pLATMC/bMM9WiJmcqgUmxHJpJD+h7mRqKZIiQrBZ?=
 =?us-ascii?Q?m5ItTCf5Mg0sSMOBXo3532wW2V+MSgzqYdcTigYDLvaaMmdZrHqqk9474Nao?=
 =?us-ascii?Q?GYL8c8KqJhhPlv1kUnrF6GEKg4vOa05jX4sGAHUk6s0KlO8pXPeGLJ1tH3FN?=
 =?us-ascii?Q?pWsYDO2uPN0hh8JkdyEFQjghoDOAXdEGQS95Wzc6oySt4tVGmJXU/gSPajSN?=
 =?us-ascii?Q?KJFgqxCk85f+ZY32k0y2zFLXrwyKUThVJsoa//467RUq67za35pQ9b6WEXCJ?=
 =?us-ascii?Q?SXt63GuWx/F1jw6S3QzXUi4AxlOXFvgFubdy9BFp3qwCfAjDCMGzwA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nzQVvjNwhDR1z53eY2boPCHnYIvuPgbnXc9lV1o+caGtpFa9aw5PfZ4k29iz?=
 =?us-ascii?Q?1xK/FtADsn6MlFj9njewpTtSRAqt3j34W6GqLS+Kq0aqRAuuA1iwQnGxsNec?=
 =?us-ascii?Q?Tk8CQ5lcUyi5Dzt6Zak6fWJ/aom/PMbH+UYE26gvaHPLnYzFBRbzsj+4pGtt?=
 =?us-ascii?Q?HKGxFjoq33MMBRpThI8DLkUXLztg+Vas5N85gPdEfbGK2uwBBuu/xvalWkYo?=
 =?us-ascii?Q?0YmuvsF+N5pjrhWWyYb8cTXHKW6PbDXC7uWpYhvhk25xq+H8OQoFEBm8vzzf?=
 =?us-ascii?Q?7Az8uMXiLVaHNuL/WtR855/VDpculHpbiXJUIz8SYbfAAKnVB3ANqk8b0sHV?=
 =?us-ascii?Q?+laySsZkW28YAMzZ5o7Y3T4XLqG8+3Y4p7ozDVyJdanRouOX169PMmObK5OB?=
 =?us-ascii?Q?Y8Zf9eQ6qut4ozzdi/XJGMESjVV73qaBXeY2redTGflJ229GLvIZAxZ06EQA?=
 =?us-ascii?Q?fQoeaDoUe8+rEEIMAKAWKQWkeZdqxf2lJFyuYfcEmjdsP5yJYvp0lvNI5rPn?=
 =?us-ascii?Q?3rXYeufuISOFHfeTdKQcHzQ/hzKLqOqWLiud/0ftzx4S/hDE3eOHSoImI9RN?=
 =?us-ascii?Q?vbefALdBGQX1IMvvHQk7A7M77z37SSuj4xruDXmUChLLR7AV6ug4ewbzcJPx?=
 =?us-ascii?Q?m8lPF/ml2JWsjK+Qd7c97Jmpl4lrqKzkphguSqkisEPiIHR2U4vmv5wIO82B?=
 =?us-ascii?Q?CqG54Xso8u+RIxsxVtz2xFn+PcgTPie5XuB6XeMq1jaJy+2S7nABIeBpK4p0?=
 =?us-ascii?Q?ZKZ5PDbXOqUfrm7ao5ibDGtjTOSFUz7SUjqtb2X3rudpsLs1CBKo1EoHmSji?=
 =?us-ascii?Q?WwWwipN+A8R9syuP8SgcMVDAu25QEDEdyFDBDh275bfVp5x2iHMgVJ1SQNj/?=
 =?us-ascii?Q?mhWJy6Oe6AO4i5k9StrMws9OjUqCIojip4TN+u+yuj5yChNCHJvUu8vKxipE?=
 =?us-ascii?Q?SM9y22S3ICXoY3Fb+lcHidJfF+FfZ1xXRKbZ8jkWw0KR7ySgIplZZ/8840Ob?=
 =?us-ascii?Q?b1HHi+puYwcqY5mkIJ1DW/zGhSU64UyiVQaIEsIbNBi5rlkftmOhufmwBA4Q?=
 =?us-ascii?Q?DRuXRAc+cvXN7S0fS2C0RwJtvMZ9bJT25NcB/fd8olZfMGEMtLusgT6Ud0r6?=
 =?us-ascii?Q?HW3uJu/YZRW3MpuyPWiwvuSgvHcf9AfA8VrMkyaQqVFcbHIZTNgXriHOljdw?=
 =?us-ascii?Q?axeX41ld1BQCFeiXACTpKSjLeNOK4C6p9+ArLTA0b1wnOayKLKX7A9uRyaom?=
 =?us-ascii?Q?YevRHw9kYE5dcFC70gPuPzlOeqLlZ2LhRL/rwPtKjX6pFMHU/LhvUc+drlOJ?=
 =?us-ascii?Q?5MGmV/JwHx38GhP/xMHhcy+yAVZ52VXFRto63CHcLBAb9yHPRMpSdXHlt9I3?=
 =?us-ascii?Q?7e6YININ69tDKAmWdKFiPWOm4GdDIphBF2X2u8zs8J9epaqTc9zvBPGZiGmY?=
 =?us-ascii?Q?6Iw6tjxJTwSOedju2lowJFmIvkajep0bSZq8xwVR4sHEGLMs/ngAhrgYsvwy?=
 =?us-ascii?Q?pQVxXOREKBSYunGHIm6C8PsXaEpyHaQLpwX4GJthTl6x8qaQzObyMQANe66u?=
 =?us-ascii?Q?UvSkgBCbI1WoD5V+LjFDnoYPtInT6NrnDS3zg1is?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd9e3fad-6400-4fe4-200f-08ddd105c7f6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 14:14:51.8101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7M0MN8zX9lnLB/0qJvuvJfZxnzAevj+GvBdAMT0WwNOnh1aZcLCyl3kmq/gO+UJjPConbdHpTexhXO79hzzK2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10228

On Fri, Aug 01, 2025 at 04:11:16PM +0800, Jacky Bai wrote:
> The TMU used on i.MX93 has some slight differences and bugs compared with
> the one used on QorIQ platforam even the basic function is the same. Add
> i.MX93 specific compatible string and keep the fallback ability.
>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> ---
>  - v2 changes:
>   - keep the enum
>   - refine the commit log to use i.MX93 and QorIQ name
> ---
>  .../devicetree/bindings/thermal/qoriq-thermal.yaml     | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml b/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
> index aa756dae512a..6d8766c6a58d 100644
> --- a/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
> @@ -22,9 +22,13 @@ properties:
>              Value           Device
>              ----------      -----
>              0x01900102      T1040
> -    enum:
> -      - fsl,qoriq-tmu
> -      - fsl,imx8mq-tmu
> +    oneOf:
> +      - enum:
> +          - fsl,qoriq-tmu
> +          - fsl,imx8mq-tmu
> +      - items:
> +          - const: fsl,imx93-tmu
> +          - const: fsl,qoriq-tmu

look like previous fsl,imx93-tmu have not define, which new compatible
string, and you also add it in driver, needn't fail back to fsl,qoriq-tmu

enum
  - fsl,imx8mq-tmu
  - fsl,imx93-tmu
  - fsl,qoriq-tmu

Frank

>
>    reg:
>      maxItems: 1
> --
> 2.34.1
>

