Return-Path: <linux-pm+bounces-31986-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 998F8B1C368
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 11:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E15C18A5B63
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 09:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374F121ABDC;
	Wed,  6 Aug 2025 09:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wofn30h0"
X-Original-To: linux-pm@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013048.outbound.protection.outlook.com [40.107.159.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C671C27470;
	Wed,  6 Aug 2025 09:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754472819; cv=fail; b=qenzMWwjIuA53Sau6Awlt/Ga0C0GoiBHolUsD2QOJFHgMfM6jAeCo1WrQc400Px7MdAd3vfG7SqA1pg05rFrMb/T4gO4p0BehB8knyKILZ3V0H2vYGZYLqZxO/gj0M6aWfoLhxqP1xWzuKFM+wkE3mJEm0t1TJxCME37qzj396Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754472819; c=relaxed/simple;
	bh=8X/oBDZ0+rX+r84GAyBgHaWHbErf3GKRyYB6/DhEVGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TXeiBOeDwYvAZoSLoGPA5Np8BjexQTf8ShKOfdgKWxsn3/yWu95t208wZdONYEOzsEKZt6sT7czAjL4squSVWnCdWBzW2o1XnlEsTCXN+z5yWirKJDLaSJzXzRChI7E5CARwhIR7flmNuoAFVlmJgPFe8dzHO+rYSfQ7iG/nMOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Wofn30h0; arc=fail smtp.client-ip=40.107.159.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J75CM5QXpG6ndko2MW176/NHnHaW308JZKNjfvmxexPvFEitFizQbj/Qpe1z6RmNuhDoBNiM04MT4XSrf3JE71OEg4jYASfr25pktmNoj5/iam6V6ujfBOeLg2kv3LmmPEMKkEfeR4zAtiu3IIZkzgnD1rSzk0nE/7042RUk9iFZ6rX2c+9IE5vzhvkW2d/2CW1BYm8JcUXQePbpsbDyvbo1YtQd1EwjOO+zZ5X7Izum2c4wVBv3OhEfWCO/GrtFuZc1px29neLbW8iCuYcdPazN/CTCwAMOeyzQZffHGivSCCRUwSFdhqGqk82nBdnxNu2gLDA7CK5fWxJYzOhB3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2Wt9GQr/rxbLZPv3uiNfIyDvLjZmJLqsw7j0kAAjaQ=;
 b=yjNtJd/CvgHmznibKFZL+IAGYaEeGyTfKhHwl6Ji5xBQrMDmj+8i2NBXYX1vdHKFlORhjsPMewi3F99vBLKdpjmjeAvr5wTFU4odB+DwZbXU9+3W3lqAU60/30S1SfRYkOfHqPXP2MB/Om4u4MGqxu+TuELcHCJ4lS6yrV1xAxOlOo2913NOVT678g1d/9Q46cVtr7fzgXRIKfXTWmrI+yu/ci23B6Gsgq6TO5SKbeMzl4Ti8RQv2ViT0PHWG+1uY6Zs2CY3LKbW+loywl5zLyfqFHehA1cSYsDLfZfndWYlrcMh24txtVdPWcXp5tLvgyD8/YneazXAjl9w+fFEfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2Wt9GQr/rxbLZPv3uiNfIyDvLjZmJLqsw7j0kAAjaQ=;
 b=Wofn30h0XNO9GsYVXdrPfG3v5PmBQfO8147h+197fb1xz6fR5XbZbFY9XMULhFsxNIzYsouZk3ABBzaGjGijfM/JfnTFvSGQkdoUsWWNgz8gbUSEuBkLSJDkUKfgQKswqRZ/iYjm3RHdytZHxhk21NkpXEWNE4qc+GEc+4vJ498crd6oxoEr728kmNWKm7fIxEPF7sN6Cvh8XM9LkXDM5IzjbshCfiFUMn9ymriUjg0eCC0zb2z/qcaU1uCAphC2i/ScK3q+6JU377i4mlB5IWpJquTq5n5St2pRHvgeNgESWfMXD0KMIzY1pbEU9LENcaxzDPi8Xhdos1skWcSg+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DU2PR04MB8726.eurprd04.prod.outlook.com (2603:10a6:10:2dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Wed, 6 Aug
 2025 09:33:34 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 09:33:34 +0000
Date: Wed, 6 Aug 2025 17:28:08 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Peng Fan <peng.fan@nxp.com>, jun.li@nxp.com
Cc: Ulf Hansson <ulf.hansson@linaro.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Peter Chen <peter.chen@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	imx@lists.linux.dev, arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] usb: chipidea: ci_hdrc_imx: Set out of band
 wakeup for i.MX95
Message-ID: <zdzpddjjdj2ezkkfh5jjnnjvkvu4gb6vqmhkdlnnc2ioamvcuk@ftmezbyxrhfb>
References: <20250801-pm-v2-0-97c8fb2a433c@nxp.com>
 <20250801-pm-v2-2-97c8fb2a433c@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801-pm-v2-2-97c8fb2a433c@nxp.com>
X-ClientProxiedBy: SG2PR02CA0102.apcprd02.prod.outlook.com
 (2603:1096:4:92::18) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DU2PR04MB8726:EE_
X-MS-Office365-Filtering-Correlation-Id: 0df92b39-0886-4768-5dd2-08ddd4cc5010
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|19092799006|38350700014|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D17XFT/UAgmfkzQW4RZHAbawmIUpU7kLQLmMvShcbNyPtsen8iOtuWSQb7cd?=
 =?us-ascii?Q?dyBhQAij/0rUODshWOZH7EEUGuBKJU7/u+k40QWX57XhIGuM9NdIuJCjBOFP?=
 =?us-ascii?Q?E7L0N5TYjMMzaxFnSAEp+LE20OGmQw1SOTcAF+DGNUjv90EK3bZL6ULGBr2w?=
 =?us-ascii?Q?kp0Teavq/mlS5TVwBESM+z31VI83DjBKV0nKG2xuUK1DttSSodJbM1tdw/J+?=
 =?us-ascii?Q?B4jvton4UB5s4EBQfr82A9ymhsKKC4fWmY5mc1ltYOAd2ZIQX6/JhejwlblJ?=
 =?us-ascii?Q?8fA2vGc9J63N5VokAzyPfFLLdybYW+9yGLzGfsqNQycZGC8PqZobQEAuyXMG?=
 =?us-ascii?Q?v1twg13h7L4kCBYRPuzIte+19oGAEQtOC6ou+KjH+qfRlXWAneWj8pbpKsj1?=
 =?us-ascii?Q?iIY+ZHwxHQs+l7YbfsN3bjycm/Ex2qYXeXTqLv3+kvGovWnd4hiq06mmI7ir?=
 =?us-ascii?Q?0aRUs5jt3wtAD80YjSyIQzmipzcaf/eavfykmC2xK9eyhdQ8V7Mph1isZjm9?=
 =?us-ascii?Q?X/dXL0w/ERdVP3bg50KsAKKeDrIKQuxnsp2ULhyxTRkAHuJ990+znFHIBV6D?=
 =?us-ascii?Q?F0hHbsZFRZI+KIOKatCLWu4ZY59qedmCFkthV18SBSwzUTl1/MgaGachjKRT?=
 =?us-ascii?Q?oViwHg/PPEKlfncOexzZP6vTzaw5vUo/YxG5PNdKojcimL3fl/WXTueARIu4?=
 =?us-ascii?Q?CQkdQAneQW+bUwohThM3yF2Es1PVOafzM90avK2UrDtOAvqJCY4UZenXtrQZ?=
 =?us-ascii?Q?CveIMV1Cv/GF5uXFVQ7D+HLq2+mtplyqGkm7z1pHjBuTO3DRyw752LRPs1k2?=
 =?us-ascii?Q?R/pQd42nQc3B0Mvn3/wvxR+DJ5mBIWT6dkq6Z8KH5X21nCImg658+fYYMpT8?=
 =?us-ascii?Q?46HJHzw3JlUIReN55hada8ZHl6CIbxJ+46gwqSEjArd9yt+O/sIu1e57MTq4?=
 =?us-ascii?Q?ULTjaRN/Yn76b7fw4KigeQzXtLYpcdN3icXP+Rsnux2UnDbbawz3l7qL5ZbN?=
 =?us-ascii?Q?En6DiK7W4iWRae6nAmOn/lk4hK+QKFMztPlGQIf6zDmJjtvKUqtCdYfR4pFf?=
 =?us-ascii?Q?Y5GvIEeoEbqnB65u70JFi3dhxt+B1PQ7enP9diw5Ae1DA9QLPSKrE6aBLyDQ?=
 =?us-ascii?Q?kVXBzyMw7xxlsEAzhQ3nqVmlSGRd7eCnFpgPoPiyU8yPmQypcGKC1OshG4wa?=
 =?us-ascii?Q?ex5oOUQKkG7T5AkqXOlAvKHJ/JXoFiJ6G0QeXhW3wbKpEl3wS3JB7q3jdavb?=
 =?us-ascii?Q?PPiRzvodR/+pNIOU2iebrGj+JO28ziO4ni9X4xYVhC/CK0ar98mqLQPTBICG?=
 =?us-ascii?Q?2mFiE7bN47BOKE9VIk+8vWGG69yJK6nKIaoAizH0hBjETcj8p731rhyFLmlz?=
 =?us-ascii?Q?nGcPUHQdnm9I0znvVQfPDBr5ldrFjwIoGkfzC5hxCH7O3l3c94VBSjgb9FWY?=
 =?us-ascii?Q?sPqi/YzXjKmPB49k7KXYUNhEHe6CN/67U7lxEH1sPpHkAZnX9XCrT6ElffRI?=
 =?us-ascii?Q?kLc0mlWSsSPIRYJXUbZVOtWJZWKAn8Ht5Zuz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(19092799006)(38350700014)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KJoDYC5IQIHElRT8BIMB9HUvfhsC2/gQ1eLq3iKRXPn28Nflv+7kKluL8iLt?=
 =?us-ascii?Q?1DNydHJIp32PXeCHrbJomGmM+lGdc34v7akhcUF8kZZyVf1R9wyQbEzo3VOu?=
 =?us-ascii?Q?8XOdaQTuJpK6VSwen4aBQviN9yh0N+S+82jhBt38S3pXQYsh9+uMq4cDRPQQ?=
 =?us-ascii?Q?3UCyJ7RK6aKkY9KF8Tjxma9xFYihAFnXvZ1n8s+3SHhYO4hs/gdVHffqscu5?=
 =?us-ascii?Q?Ek5HB1o8isla0hEa00+1p4wmQdiYDAMpnhcMLgn+7n7zYyZFrnxbrtK7bSRb?=
 =?us-ascii?Q?1QGXMU+Kk4cqjgWGMPBBSEaHM+YZ+Qb2vXWGQxOsijen34/1D/LRTT+ISSJt?=
 =?us-ascii?Q?J6vfRJ/3VJyJiJlabhJXg7ipwHexa4TDxSPORJmOhIuxLkdJqlI45V9E2By9?=
 =?us-ascii?Q?4S9N+Rq8frl0kcoBKTQwOUA0LUDMXjTLPGrKOiWF5CLifskojytS+TdZgCCE?=
 =?us-ascii?Q?D2dCNoLUTFWAzb2zUFIOkPsEn+BEWz5sFsLbAn7+c1XdS4sidKxpER+ALX/Q?=
 =?us-ascii?Q?1sAEtrrIKM22dbnvRe1oLoBOl6ep4ZhshhYZqF2uQdBVQYz8un42WNqT4eLp?=
 =?us-ascii?Q?ak7tGzmiEeJYCo8RSXCLvk7MzA5cMwSnT+z71ZntfN32C1d8UGPCHQPpXWri?=
 =?us-ascii?Q?bAxda560j4JKF3hVA5GXNEDHHF7IDriuQANCnp7EYEB0OSRCfMkyxGvpzkm1?=
 =?us-ascii?Q?n+qPHOoMm5a37iANWkQYGl+IaPt1EDHc1kSzn65ByfzlsSoljcDvNXcHDLtd?=
 =?us-ascii?Q?eBzk9crFzGznWHKX3/lb4dEIVjEpuU+w38i+Uhg5mOyU9tbIc1RRS1DIJYtq?=
 =?us-ascii?Q?UmIn+YXFneOwbtVcN4A3mKcusYLazUUvpYGlrHIxMKrGFIL2Ij1P8ypN7AP1?=
 =?us-ascii?Q?J25xvvpv2kcYkc4J8WkSFvhOUn9xI07blUvTdySAgLn2PY+TKJ5GlQxePIFF?=
 =?us-ascii?Q?J3M0avl+N0QbWD7XF+LxOO8JVpPnyA58bhZiZPLtHlGtuPfvoBwZ+7vYRExC?=
 =?us-ascii?Q?1jw8+kojPq5vlPs7tJ4Gag75uhRQKesq8hmwWTIHMk921qe2wGN+5GX3i6lL?=
 =?us-ascii?Q?QLeN3JQxE8zadvwZNXkg+Z7da76+Ni1QiUUe4/g/Z18g2uT+XohloIycUA3/?=
 =?us-ascii?Q?WCX58sBqJnhREhDlixEpWG4OZTeANHcum3oC3WXv1oynXuz+GGK7QL3IKnD1?=
 =?us-ascii?Q?nP/2iLW8GncKLpSDRhjrbfy3zRNo2L/DSDsPm0XY1NxbUJQrnJUHo2qfV23a?=
 =?us-ascii?Q?EIKCzsURdiX9yAd05FMfIOVQ5MZiLSnnTpBxZ/92MAZidbNnLUDNM9Mgos3d?=
 =?us-ascii?Q?ws6FxdS7csWfBipbW/hwGnSlrUUMwX3MKVmy0crdZsHa8fYwpDa+uxbDZ9SM?=
 =?us-ascii?Q?8Rb4Qe5CtEsWC+z43cTrrwv0p1W87DPOEJHSwqd/6fNRY1cjdGXTagu8orV5?=
 =?us-ascii?Q?IamXHtf90xHQ+0/gl2QqR1mj1YRACjDUSq4iRNuWxt3znlGSoNmKrqb+aZxC?=
 =?us-ascii?Q?Zck4q7WNT6rhYElPXubLz+ZMXmJWvixNKaJchiR2zdaZj6YABeSRWixq6vI3?=
 =?us-ascii?Q?2RNxTM0lLXwgtqpimfTdCRc3BWur2JjTLMQb8yGN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df92b39-0886-4768-5dd2-08ddd4cc5010
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 09:33:34.0316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IxsbmvM71bDbpt1tQzgB4NmYWXNbq6wXRYz96GxHeMfP21jd4LzKqntqdt4qHjOWT0DQRBQ4/UP2c2iAV1rPBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8726

Hi Peng,

On Fri, Aug 01, 2025 at 12:34:23PM +0800, Peng Fan wrote:
> i.MX95 USB2 inside HSIOMIX could still wakeup Linux, even if HSIOMIX
> power domain(Digital logic) is off. There is still always on logic
> have the wakeup capability which is out band wakeup capbility.
> 
> So use device_set_out_band_wakeup for i.MX95 to make sure usb2 could
> wakeup system even if HSIOMIX power domain is in off state.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/usb/chipidea/ci_hdrc_imx.c | 8 ++++++++
>  include/linux/usb/chipidea.h       | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
> index e1ec9b38f5b9ba0568101b51fbf16b99461b6ee2..7a3360d8a0fd065394393de829108a12c27c85b9 100644
> --- a/drivers/usb/chipidea/ci_hdrc_imx.c
> +++ b/drivers/usb/chipidea/ci_hdrc_imx.c
> @@ -79,6 +79,10 @@ static const struct ci_hdrc_imx_platform_flag imx8ulp_usb_data = {
>  		CI_HDRC_HAS_PORTSC_PEC_MISSED,
>  };
>  
> +static const struct ci_hdrc_imx_platform_flag imx95_usb_data = {
> +	.flags = CI_HDRC_SUPPORTS_RUNTIME_PM | CI_HDRC_OUT_BAND_WAKEUP,
> +};
> +
>  static const struct ci_hdrc_imx_platform_flag s32g_usb_data = {
>  	.flags = CI_HDRC_DISABLE_HOST_STREAMING,
>  };
> @@ -94,6 +98,7 @@ static const struct of_device_id ci_hdrc_imx_dt_ids[] = {
>  	{ .compatible = "fsl,imx7d-usb", .data = &imx7d_usb_data},
>  	{ .compatible = "fsl,imx7ulp-usb", .data = &imx7ulp_usb_data},
>  	{ .compatible = "fsl,imx8ulp-usb", .data = &imx8ulp_usb_data},
> +	{ .compatible = "fsl,imx95-usb", .data = &imx95_usb_data},
>  	{ .compatible = "nxp,s32g2-usb", .data = &s32g_usb_data},
>  	{ /* sentinel */ }
>  };
> @@ -569,6 +574,9 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
>  
>  	device_set_wakeup_capable(dev, true);
>  
> +	if (pdata.flags & CI_HDRC_OUT_BAND_WAKEUP)
> +		device_set_out_band_wakeup(dev, true);
> +

In current design, ci_hdrc_imx_probe() will create another platform
device B which will be a child of current device A. Furthermore, device
A and device B will attached to a same power domain. In this case, some
conflict setting may happen. For example, if the user wants to enable
wakeup for this USB port, they may echo "enabled" to wakeup file for
both device A and device B as before. As a result, device A is out
band wakeup so it doesn't depend on power domain on, but device B has
also enabled wakeup so the power domain will keep on finally. Actually,
the power domain needs to be off for imx95.

So I think only letting the parent device A itself attach to power domain
should be enough. If it's the right way, then below change needs to be
included to avoid potential misbehavior.

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 694b4a8e4e1d..c2ca81fe5e09 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -915,6 +915,8 @@ struct platform_device *ci_hdrc_add_device(struct device *dev,
        if (ret)
                goto err;

+       dev_pm_domain_detach(&pdev->dev, false);
+
        return pdev;

Thanks,
Xu Yang

>  	return 0;
>  
>  disable_device:
> diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
> index e17ebeee24e3ecc4b1c2d153d9ea9b656b5a3d35..c6451191d2de68607a9380482701d11f949d0ff7 100644
> --- a/include/linux/usb/chipidea.h
> +++ b/include/linux/usb/chipidea.h
> @@ -66,6 +66,7 @@ struct ci_hdrc_platform_data {
>  #define CI_HDRC_HAS_PORTSC_PEC_MISSED	BIT(17)
>  #define CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS	BIT(18)
>  #define	CI_HDRC_HAS_SHORT_PKT_LIMIT	BIT(19)
> +#define	CI_HDRC_OUT_BAND_WAKEUP		BIT(20)
>  	enum usb_dr_mode	dr_mode;
>  #define CI_HDRC_CONTROLLER_RESET_EVENT		0
>  #define CI_HDRC_CONTROLLER_STOPPED_EVENT	1
> 
> -- 
> 2.37.1
> 

