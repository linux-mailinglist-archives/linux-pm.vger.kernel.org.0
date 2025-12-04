Return-Path: <linux-pm+bounces-39223-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 098B7CA5A9A
	for <lists+linux-pm@lfdr.de>; Thu, 04 Dec 2025 23:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D101F3140C45
	for <lists+linux-pm@lfdr.de>; Thu,  4 Dec 2025 22:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8318C2FE598;
	Thu,  4 Dec 2025 22:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="coRQy7OY"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013043.outbound.protection.outlook.com [40.107.162.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6F61DB125;
	Thu,  4 Dec 2025 22:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764889041; cv=fail; b=foxLvosYuXBOK5FFyT8FEeqKtNmFsVvNqLCJr3Gv17olLbcHnIJL4QQ9+YvHUR9PO4e0mwamty/bThlqiDUjRodO0xH/6sXPcpHns1bio+JvIgiZD9ls3iZWPXe4bIe6ZCoGbkHjPg4xiQnUjXE3Je3S4NtPV8etH8JRnl4gcWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764889041; c=relaxed/simple;
	bh=c/60seWdNm9CkcgFb9PnXymHetZchylixT+KjvHPSxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cHSMbfyfXuPwV1/qhlF+ktJ2cutUG/O54x5AdpRWohncdwtxaZu75MuRMiAwO35coHSlU9uV4BeZrIrHY8LOkHRP/62orOpKEtQJgl6boaAvfq6jzv18ME/XfMPSlMRRvXJy1UPQX2segn19j/32uG3152aYFNvjmnV9JeJv1QY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=coRQy7OY reason="signature verification failed"; arc=fail smtp.client-ip=40.107.162.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S5N9vgqtA7AHJb6Bje5+El0TN5IsBLYD0rYmpwrlNXbdB6FFTWDgVwity/UYbzr3/9sgwU7CVQIzfEQQsFTgL/tltq1PZDxQ8ljYgv46MVuC4TbdWg7UQZv8BSRHEYs87pUxMAhnugYHfEzu2z+aYZ++689caAe5cTJobJ4IMeoasuHMABxECFWJLPIdg38NqlTQjUzUg8woWtgD+zmEj5VlRi+gCVLorhBhPEyy46Fkj/wPEp4emuNDYwl7pmiu9dws7W6WeQSt/fiyxEkir5uecCNkT47GLbQm2BBP7v7EbMzSeHkSYE8XWMDaCxm4Lerd5N6My9sHaEBdXRWa9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBH63vqC79r8PoCw1Y+1pGebx5MITXibNh0y2AXFLWk=;
 b=MjdXPcIOXFQgRgEkAh57v2m5s/2YctgJatIlSvLFEQnpAABCGcGH/AEpv4WtQth6hLJiANE9KpNFd6H6Ju8tENO+JXIFqXoo7S4rStwPiPJ8uy5RD8uccEpWWqsnAgS1QwNUviv7fvD0L6891Kq48SHijQ1ncMtlGOZncwF7ANYadoaTfME6zN/T1PFIC2JrcgpihuBmsQbNUAUTIpAUjC/i1pTwygHeyVUuWks/mOIlHVxuiVWWGBejo+a8EqtUY7UnPI/5qytqtxjL+3Y7ekYHRkJe5Wck1xNKZxtd7GTzM6Yx8Ig4WQU4RO4RqhHDbx+buxQkbks9+IBG8mR67A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBH63vqC79r8PoCw1Y+1pGebx5MITXibNh0y2AXFLWk=;
 b=coRQy7OY6ThEf3G+SQKeTK1O7TZjYrL8PiQm/QcBJtHJiiMauXARZwiGgs9aiS6y+fAKiXNXKdrq3yjycm+flHd+3auRh3KeMO6PZnb1bQaqIGqnsBW0EerJqVDERtOLXPKNnotUDkpHXnrURbzMs2vbeQGSjs6usCCPFd6sNfGBY+K1lQhYRTiThyfBNZj+HxQL3Np6udJORWMyIQJl4ux5S9ciVswevvc1QCXN5B51avCBggWOQZo1Qvrvsf5FA8xuBZOHSklIyc44U9B5YTD/eI4grFaOtUiQl3FBLYyopKRPQL3blF5WuudLEFNLxLB7I0i3dHKI9/Lpzfq7nA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by PR3PR04MB7209.eurprd04.prod.outlook.com (2603:10a6:102:92::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 22:57:15 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 22:57:15 +0000
Date: Thu, 4 Dec 2025 17:57:05 -0500
From: Frank Li <Frank.li@nxp.com>
To: Nicolas Dufresne <nicolas@ndufresne.ca>
Cc: ming.qian@oss.nxp.com, linux-media@vger.kernel.org, mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl, benjamin.gaignard@collabora.com,
	p.zabel@pengutronix.de, sebastian.fricke@collabora.com,
	shawnguo@kernel.org, ulf.hansson@linaro.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
	l.stach@pengutronix.de, peng.fan@nxp.com, eagle.zhou@nxp.com,
	imx@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/3] media: verisilicon: Avoid G2 bus error while
 decoding H.264 and HEVC
Message-ID: <aTIRwcocnye0Y6yV@lizhi-Precision-Tower-5810>
References: <20251204090813.595-1-ming.qian@oss.nxp.com>
 <20251204090813.595-3-ming.qian@oss.nxp.com>
 <aTHGJzVKa7PbEifJ@lizhi-Precision-Tower-5810>
 <9f38bda2f1753645a1ae392ce5364ea0165fdc01.camel@ndufresne.ca>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f38bda2f1753645a1ae392ce5364ea0165fdc01.camel@ndufresne.ca>
X-ClientProxiedBy: PH7PR17CA0030.namprd17.prod.outlook.com
 (2603:10b6:510:323::25) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|PR3PR04MB7209:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d2ee007-6d3a-43bf-530b-08de33887793
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|7416014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?iHgkRaUsfKw/uphzvP5EPDTI8D+csfB1QWNw7laWXyFvHLJo0Dv7WMeUWc?=
 =?iso-8859-1?Q?Rsh3aEFGua7ecs5x2/iY2nfwJj03gVYRa2E/3pKYBkyGh3Hh/J4FZKa1dI?=
 =?iso-8859-1?Q?v0yzetmg8TPQxVQ5Cd+272/4D00VbuY529g0DIQ7QU0d94aJ2yGvqZZOrV?=
 =?iso-8859-1?Q?5NgsqFvO/2cys4BPyygUqu6Rv26aG2VFqjMvSy9RX/i6GW9skXFKJ2uR2U?=
 =?iso-8859-1?Q?okWVAuFWClkCgA4WjBQPLNhTAeh2YigyLlEoyQOYwaZL0QeoXd0jsdum1b?=
 =?iso-8859-1?Q?8CqVvQnMpeN56Mz6RScnW8mNgj2qq53fcLZKdfBX4+pMYqlSnG+PTrcXCb?=
 =?iso-8859-1?Q?JwLfsyhI8Op8FC3M8eReWfZiziaOe2Nv66oEYVFS+MDNBgaiqGFLWQYbIe?=
 =?iso-8859-1?Q?VbYWDBLWwyj/eeP66B+4Z6ORG4fM5h4crJTtv5n1cgmZipdIOvNPAQelcT?=
 =?iso-8859-1?Q?HmiI1B2rcR8+71b7pKT6O9nZWT8r+Nhx06uSyLU2p4vnIEo6pAYlr5QMVX?=
 =?iso-8859-1?Q?f4DEMa90loHicYREJVl2FWPc6a92SSkpjE530EOP/RQ524UaTGNve/LUmQ?=
 =?iso-8859-1?Q?yZ21SWpKKEQFcnEpwoU69jwm3Vejwsgxe0hHwDjwoVsA1cKGLsgrX4o16Y?=
 =?iso-8859-1?Q?EYg/tnAHnxWSJvpJ/fyKl0KAJMBsXvkRmXyJcSe1Lyettn+NzgiK7zoJ9i?=
 =?iso-8859-1?Q?FxSWP/Jpoa2gNcpKOIeR0fpCUUIVwC37CAH6Co8dXueyZ+Gake6bq2hUVn?=
 =?iso-8859-1?Q?Ki2Ei4YVej1vzazXMMOsKz0ELN4M1JMqszNpjtYavcBylWP7hLqqvjsv/j?=
 =?iso-8859-1?Q?mZ4x3bBf+VC1KOAASa4+6XuwrxyLEiW7SKGdT5hv38CBzj+3mqcW2dhFvU?=
 =?iso-8859-1?Q?wgwl2bc4S0RexgN3n5ODHa/uYabY2yWX9NyjNBKRT3KcxHC8Ira0olrAUd?=
 =?iso-8859-1?Q?gLX+QBszht7SdNXPN33Ynjfj9GiYpfH40MQsAR5G2Z1NdgwjEQLRxn/br3?=
 =?iso-8859-1?Q?FaMPudm2qCCi8hmku0G53nB7WYKadXV63o0QyWwediysanwQri5xxiF7kc?=
 =?iso-8859-1?Q?U9eVv14m618/GTZrbcB8paQFKTsqZ1yg2pZjZ1FwDbG2n/H55+wT2YDnuz?=
 =?iso-8859-1?Q?pN4BVx1+x+oCJfBgjkLAdysSKEUHFZ1LZnOeLXtuay+IOjTmQpooVBEERG?=
 =?iso-8859-1?Q?x+gbjHIrfNaTLFHVQShImiLyieHgcp2XX7ckgcENwYbII8qyyyvxpm3aJu?=
 =?iso-8859-1?Q?HoH3oCz0/6iViiGLEe69SXrtEffTxblaGskbXNdEfvMrNmpq9p4fk2AMH7?=
 =?iso-8859-1?Q?DRhBqRfUp/HLMF3F8mvUmgicTrPhygilYX3fx/sBllI76Hh3mIKY6cP+Pd?=
 =?iso-8859-1?Q?bu3WoMOHxOOCI2wOwzz5FTStW6ZiUKrS6PbHhCB7H7BecszQMCHLmSEyYO?=
 =?iso-8859-1?Q?0WipaO7S1YNWzEPsyjCnG3pT/tHWdvBAMg4G1S8jb2+W8xLl4sFFE/DJ42?=
 =?iso-8859-1?Q?Hb3r14A9gNFr6BXJmYIven/UvgMNsGLX8bRl1pa2qBF8M1oqbLfz1nZfPT?=
 =?iso-8859-1?Q?krd8Kp4jfJuz0zglSpM3zZG9qPi4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(7416014)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?QMDSO6cvPD9ovm2lHxsEzHHduSYiLSbT+yu1Lj+j5XHZFR7muNx0k7l/fK?=
 =?iso-8859-1?Q?gdrCc5nf9U5CgRspPnt+WLLkFuI2tJQ6694n+QI6RJGpVDhy+qzR3Ph7Ne?=
 =?iso-8859-1?Q?VxiV6D/j3/MMsar3ue0elvEcLSyIiysTQqGmEHE3U1nbvdeiIpBgKeePkj?=
 =?iso-8859-1?Q?9HXtjX76tXcAj04uSl0GZBGIGYf9uXvaxf3VlSfvSkOctlmUPY1uhXZjni?=
 =?iso-8859-1?Q?+Ei/B15C0kzO83llgp8nsxsdmFMQpbwE5ZUB06Trj24H469GFkqhVJRrHc?=
 =?iso-8859-1?Q?/GPznnTHhck/EFk3BGxauitzyp7asHHCynPIZod8c2JYyMwdEQbH707jqn?=
 =?iso-8859-1?Q?sjCWETUT3RGn007QEbDEsREy+A6s9Rt9NrWFirObSf6FoeWwlQ44If9Fd2?=
 =?iso-8859-1?Q?tpICQZEU6s9Ti8LV2LK/uFfqrK2v+b2nwiWj5PAWnD0z2bWjUCtzFlTJ3z?=
 =?iso-8859-1?Q?Rqn0XKwFbZzt70dL7WVSRDTkSSrrLRw4CQ7v/bndsTpF+8gdK+q3gVzGbX?=
 =?iso-8859-1?Q?rW353pIBjXJ1+ejLT0p7awvA6su+OZbfqyOuPiQWtiO++8m2rJlbPAR3yC?=
 =?iso-8859-1?Q?s4i2yTt3E0UI1ttwUkivuh6xS/5Gz4BAanWQv61nhpk04Nhtn32G60cwt4?=
 =?iso-8859-1?Q?3G0sgizUgP4g6xAfrAmiU/QTWQBKTBeaFxZH8Uuo+drb7OaIDtgaZFcNtW?=
 =?iso-8859-1?Q?pYwrNFPAg7LcgeLu2MA6iXJh4/cYTj5SrMEum8904HZ6WkLOq7nCU8Wt+O?=
 =?iso-8859-1?Q?c+76MbLn4U1U+vWpUtadldpXwlEcPxT+6YcpFdj0CTJqzkuyn12kfCUAEc?=
 =?iso-8859-1?Q?cIapkBjeRETBwlOu8yczcZUbDthMUbifvQZ1lkYxCDy07DGORfZMJWp2YS?=
 =?iso-8859-1?Q?ZgoZZeS7aB1fhXn7z4wcqg7U4l7SRUmVZUXlQPfW50kAQpfR/G76ujcDWp?=
 =?iso-8859-1?Q?k8meOP2hRAK1xuNJQfUpWPjzq9QMfEMgRHqOEoNLZCKUrZHtoqcX863r67?=
 =?iso-8859-1?Q?iQE3m2CxIZjmXZKF7r6Yv7750YwJ+GsPRenJs5Fe2fNipyNo26KDgEUUgO?=
 =?iso-8859-1?Q?8exZSFVAQ1iFHV5+7QgYTFR8DD/1rVuj9Hsok52P/Y5wswWmua0xCl/0re?=
 =?iso-8859-1?Q?hxJFVaUwkDEt8h2JqojPW4deI4qVSBTSmB5p4H/WwykX2G+3Rb5iYVIXEL?=
 =?iso-8859-1?Q?iXu1Tia9lCEyMmWSLl8FP7XDvXSUGGk6wX+2QiFOgmnkW6tMBb2/F7vvAH?=
 =?iso-8859-1?Q?6DukkA/Po6v14HvDdrQLoLDiA2W7fC97nAm28mT7su1/FIT3Da5kzgHv7V?=
 =?iso-8859-1?Q?JwXxSZlYc4lWFiS2wf+iuHG33lxHcRSfpKSLSsrL53JaR+hFDGLGiXMtzT?=
 =?iso-8859-1?Q?9ttV7RHiCHPC78xWkovvaLn0v+jzAsxJAcgH+1E9iGiZCFGVGsAg84KQ/8?=
 =?iso-8859-1?Q?mQTkCv+PFSl6GF9eO60HM5DsZOLbqRr6V9J8LOlLGM/oSiG0bO3zLUVy7A?=
 =?iso-8859-1?Q?1Ww+sxV6q54DLxZ7X3Wg12PrFPpVYOV8OhsBgVH6mVujskgLaQ23jvrKFN?=
 =?iso-8859-1?Q?XAF/5LgHK7hlhTAX3Lgf58VU7xJeoYKy0zBrLFj+17uXOfJrOo/Va/tq+f?=
 =?iso-8859-1?Q?A5XYMhSXwQ7qol6EGtEH50hYySEaNehzar?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d2ee007-6d3a-43bf-530b-08de33887793
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 22:57:15.5864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K2CcPk1kMaY3i2OxxRx3PdkZoEIjJBjwOuBwmkmcAdDRZBP1M27ylGwFGSriBnCl9k8N+RpSlzymkOc6zmeq9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7209

On Thu, Dec 04, 2025 at 01:15:35PM -0500, Nicolas Dufresne wrote:
> Hi Frank,
>
> Le jeudi 04 décembre 2025 à 12:34 -0500, Frank Li a écrit :
> > > +static struct v4l2_m2m_dev *hantro_get_v4l2_m2m_dev(struct hantro_dev *vpu)
> > > +{
> > > +	struct device_node *node;
> > > +	struct hantro_dev *shared_vpu;
> > > +
> > > +	if (!vpu->variant || !vpu->variant->shared_devices)
> > > +		goto init_new_m2m_dev;
> >
> > I found only use shared_devices here, how to  ensure that g1 and g2 operate
> > alternately by using shared_devices?
>
> shared_devices is an array of of_device_id we match against. All the matching
> devices will share the same v4l2_m2m_dev (aka m2m scheduler). Typically, both
> cores will be schedule as one. This achieve what alternate operations without
> active polling or blocking locks/mutex.

Okay, but this code require shared_devices==NULL's device probe firstly.
generally not order guaranteed, if there are not depentance at DT.

Does VPU always probe before g1/g2?

and if there are two VPU instances, what's happen?

Frank

>
> For this platform, we only matched against the compatible for simplicity, since
> we know there is only one of each type. I've suggested this method to Ming,
> since it will make it really easy to apply such a quirk if other hardware have
> problems or design constraints.
>
> regards,
> Nicolas



