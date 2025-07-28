Return-Path: <linux-pm+bounces-31489-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C85FB13D4F
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 16:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45473189A299
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 14:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EB62222A1;
	Mon, 28 Jul 2025 14:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="U+GdqYWo"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011069.outbound.protection.outlook.com [52.101.70.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4754C3C1F;
	Mon, 28 Jul 2025 14:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753713384; cv=fail; b=dL1sR9B6bWiBEsgfT9cic/addGi8PLYWsQH2n/hVp5a6WQvWQJ0W4FJbVl8GddxvJu/UwrKxwupuFq5NOUDrSLOfcp0UXpuGcnOX4iaWVIAA6+FwXGMLgvlEHli2L4hn4E08CIuCHRHbK3e0psiH5qTJJLwqspORqcGqh2iBDns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753713384; c=relaxed/simple;
	bh=dLI3M9nPqM0rMmoK6bgjb9NZOGyZvyNlNiWXMwfZ/a8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fLwGwb2tl7WlKhNB01jZDZVi21MnIlfSXdPYF3n9jQXfn9x2OU/UiNC12PKAernHQhtFqvTVjP+SEV1ZIl46SFCfW+krOppBkSroGta0071c8Vf7igZ9E49ZGQwi501h0McC6ph0vjg1K4wBdyM7QJi8DVDT/tHGHzeSMPazgYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=U+GdqYWo; arc=fail smtp.client-ip=52.101.70.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R4fwkH0biWoBMbwgcEEsBQQ/4rhtoEuQCRC3TP1lxKRR98TD/4HZcNeuO8nd/vq7a8X6QGARscirST+vdOJVT2PM7Tda/mnCh8kZrHmggJswwsFBp3f1SWgdpQh+sertec1lQi33Dl4LV7hukXj/yEGeUmzcbIP5ou9hkAuXLi8R4AI8UP6InH4zWc/B3T2quxDgaOdGQ3xedb0nQjUSJ9jGToy0RSokJsTru0f8wstj7OvcQyuqx188bzFlo+UuP03s3/AjY93QKyhZdtbMLPmAmHB2YHVMv0CKGlBR3bmQLIiswBCdCf4ALDK+9QVHI19viwMLx8+4hbU6lXL7Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYi03s+u8oA1DXFZlA+DzdcdMZb5a/xbX/L7jnPdR0U=;
 b=ev6wvUzpWEV9asG2jYOdnmJVYjkhIrhB3MLrVpBJuWE5Vc0mXRfzY95WiambIdslLY2OS0V+jNhPc7HvqCgQWRdm01dxvQ6Beo8gTKrOBVMpbLz91sy2nvs1VJCL0cGXM9sY62XQmhdjeIB5putXTYtKEAIvuz3VybnelTg7DCPeoEaWl1CHFNJJzmpgCtwEcpFN2RFbNjR3zCF0ocpiHqOhFOkipc3vyyPvDBMam6oCkp5UvzcEWtqGkQBmR1JRmU7ocBxFfQUnc/xF343EGab5O+m2zadlBnA0+Oyey9tYsXe34ivD6tK2hMaYfivfIRUnbcknupC0Y+3JeTXapA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYi03s+u8oA1DXFZlA+DzdcdMZb5a/xbX/L7jnPdR0U=;
 b=U+GdqYWoHc5PysYSywvw1mk16add/8khqmuaQ9MXu5kV4vtAUjdvDOmRa5yztgW0Ql0XO+7glc1tsICvA0tm5zwWEe1c7MWbV8r8ri0r0FTBZ5mo91KegVqKZRE6S+3PA0JlUvd9sLcXL/VzNOD/iapYMfuNK5cj8JSxHA3Y3D+3Drk7NEOatnNUTRsayvxFJwVAXnXnb81K03Jaw4q9LE7xX9LhnRlUV/N3CCgqXS0qWEeR5UqvgXyzI4ha4a2fWhI+GXA/kURm2d1khnQW/ne82FgsBWFBe/Aa9qVm57hNLhizC1rgwsIFuZlIPEjhkCUcURjrPoeFYn56WWQnUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 14:36:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 14:36:16 +0000
Date: Mon, 28 Jul 2025 10:36:06 -0400
From: Frank Li <Frank.li@nxp.com>
To: Joy Zou <joy.zou@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, peng.fan@nxp.com, richardcochran@gmail.com,
	catalin.marinas@arm.com, will@kernel.org, ulf.hansson@linaro.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, frieder.schrempf@kontron.de,
	primoz.fiser@norik.com, othacehe@gnu.org,
	Markus.Niebel@ew.tq-group.com, alexander.stein@ew.tq-group.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com, netdev@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v7 08/11] arm64: defconfig: enable i.MX91 pinctrl
Message-ID: <aIeK1hK6rM+UIPfD@lizhi-Precision-Tower-5810>
References: <20250728071438.2332382-1-joy.zou@nxp.com>
 <20250728071438.2332382-9-joy.zou@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728071438.2332382-9-joy.zou@nxp.com>
X-ClientProxiedBy: PH7PR17CA0064.namprd17.prod.outlook.com
 (2603:10b6:510:325::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9185:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b129a7c-40f2-40a7-a3c3-08ddcde41c3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7H3F8EpMmozUaJCiMHMnjAf4vjmLHeGtuRiFt7qsthXPrZwuioPvNxIstWje?=
 =?us-ascii?Q?1SefX3xz1Fu/UeG6+xIyI653WwEWMvkuenAbSghuyvpJ5Z37i8k1deK6wdlq?=
 =?us-ascii?Q?xGfJm9faSKmP1xz+ljXlBEpUb+Jj4e55Va0463IJy/MzCA1h4zvJsrKXOW57?=
 =?us-ascii?Q?vw7T2OU01/sAg5gIVh1h0DqlOSuBLCzGxK0cTOxX/rez0zg7eGRo4W/oZJ7/?=
 =?us-ascii?Q?7xUTnAV2yljHMtlTw/Dzd9DDnhImuG5LMQy3QhWH9cArSAGZnaWumecHBTg/?=
 =?us-ascii?Q?uasp5PZoxHwcGZWpdjTI9u6fCv1KyoLFjByPre6qspza1GqPchNxfvKumLO2?=
 =?us-ascii?Q?LHvun9OZZv+0ylswmO0IaPTc5fQvAc7FIDSMl4tIRWcwMhqqtfR3XLgpW2zs?=
 =?us-ascii?Q?4CaRpEfW2HsAmyZFr2ve6smgMfrnb8beUj/GjYDFbEUOflfjUtf3h3xcUiCy?=
 =?us-ascii?Q?tkidfMJefw5S2E27KC8BFatGgbFtWM3yDJ61MUZdeUAKGU/rbfCRB0lBEfvs?=
 =?us-ascii?Q?mudkB4xcabNic2QG0IbiibvaMag3zyLtDygpjPFsLCIP4V0dp4X5+yNKQboc?=
 =?us-ascii?Q?SE/Hmo1ff7vmSjnB4tKIefNaNr0Yr4B9xGUfAgAQmEqSM9g3FviaivFVkkCD?=
 =?us-ascii?Q?IIZPBxn8ZhVVgNljrH9WVKls7u4ba+0+Henu1V9LKUefo3dgC+j5YiQG5/o7?=
 =?us-ascii?Q?P7fvySmQ3JlCpyOtXoakkj8tBn51N/V4fzvmlMh9sjGiZiNt5KszqTCDrAGR?=
 =?us-ascii?Q?W6sERqj4MB2CzHDmjB4J0p7hScIuzVdNMI7EjOJH2OilE6+j4e5Ho9QmFOd6?=
 =?us-ascii?Q?dxaU5DkUvbyigZqdZjuG6k2lHfW8dTdJV1fz3oNsYi+el7lFQ6n9wzu3qgk9?=
 =?us-ascii?Q?zyhseZWPt3VfHUeNse3LFu1cWQIF5KbdfDJFt43vkLzatgBDEUSRcmaXOcgf?=
 =?us-ascii?Q?auNdz811LID2OPiKUBA1acmTK3+Qn62pSyhdgb9zcxJpZ/vcIFEmXVpL4Dpr?=
 =?us-ascii?Q?aBoKI0388EiHi5KFuioMUIWuL24zLsEtKfrzAN5EwgaGZ075jmY2pSH6sj5r?=
 =?us-ascii?Q?shodVN8tS5Obm3sFQdgryjd0rK4LI5w2wjcW2QGN2GJoNqbmJU8uwaSVYW7Q?=
 =?us-ascii?Q?3kz+K2lk0e/zqtULU8jPHkC3EXg2EsVckr6KXrbnLETnhfAMFYSXdnIsaJQb?=
 =?us-ascii?Q?irnwgV3e1f7/H1+ZPAJiRcb26p4x9nM1e/2Qzoi28grBRTSMqZFJHGmW6TcX?=
 =?us-ascii?Q?Espsd/+AdNcd5r2gZJJkr9x+BQit9lGeEVTl8Qm3Vgjs0x/W1qnXB04tArm8?=
 =?us-ascii?Q?y1Uo6NCGAo3miHmYTL6Pqh/PeUwddAfPK0GJkk4xQW9mrKbT4l5FEPpo7c2a?=
 =?us-ascii?Q?SlLiZbBYmqFfg4luuknvgEtF8Wzhd6OwC6WB42pDmWIzY6oesjkLQJihk6A7?=
 =?us-ascii?Q?e4r1QSxxaUjT924NOA0kLIlN3onq+12VwzzEJAew9Xno+oB/JfGodw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mZ5sZpCQ4LgH8jc9YnWdK9bFOLZECahB2D9Zm7dnCNR2O3TwRiHTTPNPiQHM?=
 =?us-ascii?Q?1DWUTfKeCyXnNCzhjPolQK0fA6zWz+AxehHpdtjQGnAUqx8Ghz0D4FaFnt6z?=
 =?us-ascii?Q?aoemsxYfxFUZtK6trRv7toz92TXQLNfytNmjOyANx8170E8ceUYo6dBbDavA?=
 =?us-ascii?Q?1wxULJUSmk+Td8pIOvzP4oZ/gX8wLsHxf9yZcuCucwOB6UyXhbcYtKgRE6WP?=
 =?us-ascii?Q?axF9DMcMEJr+++fYvu65UzrfVJxfPOH/DUQFpR3ir8eKatsVcUNsdsF5bT4C?=
 =?us-ascii?Q?3ew+qRaOMfCUOi2+yOBnOw7IOgBGd6hUuyDjk4KUQ0iqBF38KyGyfDvIs6HJ?=
 =?us-ascii?Q?2V8lSqKfQRf7J5TU0Rgsjw2VSOHyv8TM7HdTCMqwbQquB0fli/9UWzWf+neK?=
 =?us-ascii?Q?Pild9C2dXKSUIXxlQxNQbRDG7UD3ZURRw4OFrp+/e7nHsyIZC7gUt4QQdGIZ?=
 =?us-ascii?Q?yeWaZUd6ZexvDPUC5/hc1rKjxDSJ3wFGwPAp/xzpjVr2wShLqrySPyCsutx3?=
 =?us-ascii?Q?+bPc/rsOsmE0Mz4MT9hLhAPkN4gdqIdeKh3RlUjsRczFelhbbqgVKYo1AZ1D?=
 =?us-ascii?Q?9us4lVokMxaa4frzh7t5Rzt9Z9jkMtVcvsT0Ei99ytMTR4JFvMFe4MGDOCSz?=
 =?us-ascii?Q?UL62SDKVfqeE6nV8uQQYSEjcPnnh+FWZ3tQBw4YZ1VImCoVK7P6BOO9tOCfO?=
 =?us-ascii?Q?VRAbpaRU9XVxgsIUDhzr8uMkS0Gj16Uayaut0YDU9Vzec4mwGa1p80LIBOcK?=
 =?us-ascii?Q?oiT7yCgYdKfpdgHEmI+D/QKK+0KWCT4sp6fbaLAHOyJlR3v7x50ZqPc6O8lS?=
 =?us-ascii?Q?zyz++sdacBOaEwlXR2SQ5w2kO19Qf2it0QsKmRcI75J1oRrD79Aa/xH8ul0J?=
 =?us-ascii?Q?UiCDVV8G+JMp5RRjkPq+xYWBDKCqjbFYXrIcOiyHnpaXa8rT28H/zVw/bPQ+?=
 =?us-ascii?Q?oLyp9i6K3t+NyOQkrYofs9UBYM1FYQTh1Pm58Med29YEbGe3+/6MdkiWY5dF?=
 =?us-ascii?Q?m5IYHlLalSdAjPR7JhUYt9KGECUhF/3othv0fxVCL3K2DsQGM8yJnZfpOCBE?=
 =?us-ascii?Q?Kt4+V+L4dw6psrBTDt38IVTqXc6ELfTdzaLMnXnA1fHQjS6eK4Fn8DZwx91/?=
 =?us-ascii?Q?oFqpSWk+0uVkFD7ejz+Yt51Y7+6gXHh4LxrliQgimQb/KqTsm0QNwmCftKF/?=
 =?us-ascii?Q?FTlsHPayfw/dT2fWJp+qig/SHUm8/07RR7aDa4Cwmx6V9F4pqQML//tn56lD?=
 =?us-ascii?Q?z1ZQAbRagONO19mnKPYv62RVpbL4hYF0NbOOiFnrxacZbpOwkrQOG2c3JReZ?=
 =?us-ascii?Q?ey/B08GtlPArq7Hq1JzIXv+ZiGEX7TEPQasstJSiHQb1dBdUo7uqRRpOeiBK?=
 =?us-ascii?Q?Uam3P3y08iPy/cTEAwKAsw74RVRPRQq7IXby1gIKHp6YHwMi+fKuMC8Tr95T?=
 =?us-ascii?Q?iRCpZq0oH0gn24Cw1iJ1MzVKhi2+bTj4x6WFvkuyX6vgYP7Z8lbSaFYMc8Nq?=
 =?us-ascii?Q?aYLt3xE4UPnsm0gy/IAKThXHyC/dOw5z4VAlZoWt9UqG5L+qhGdTqC1MbXKu?=
 =?us-ascii?Q?gaqZsY8Wp9gS4NwRXp4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b129a7c-40f2-40a7-a3c3-08ddcde41c3c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 14:36:16.8825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2vE/0fZMplVE1yejfLyJjSJo12R84UVukN8hpbdyR6axazA9bArfNDywiNKLzvHPJiKlaLjen1dPW4c+/Cqw/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9185

On Mon, Jul 28, 2025 at 03:14:35PM +0800, Joy Zou wrote:
> Enable i.MX91 pinctrl driver for booting the system.
>
> Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> Signed-off-by: Joy Zou <joy.zou@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 1052af7c9860..2ae60f66ceb3 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -602,6 +602,7 @@ CONFIG_PINCTRL_IMX8QM=y
>  CONFIG_PINCTRL_IMX8QXP=y
>  CONFIG_PINCTRL_IMX8DXL=y
>  CONFIG_PINCTRL_IMX8ULP=y
> +CONFIG_PINCTRL_IMX91=y
>  CONFIG_PINCTRL_IMX93=y
>  CONFIG_PINCTRL_MSM=y
>  CONFIG_PINCTRL_IPQ5018=y
> --
> 2.37.1
>

