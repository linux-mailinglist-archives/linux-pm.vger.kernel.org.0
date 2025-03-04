Return-Path: <linux-pm+bounces-23424-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABC0A4E616
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 17:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1B981B40F31
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 16:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03E02980CB;
	Tue,  4 Mar 2025 16:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lTAHe75i"
X-Original-To: linux-pm@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013067.outbound.protection.outlook.com [40.107.159.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A946E2980AF;
	Tue,  4 Mar 2025 16:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104409; cv=fail; b=OLh3IXjiDTUI8kOYf14QPE3W+pAab7Pe+rpoZvyGO8GT2SHbnJbDZ1NPiLOKBqoenS+x744rjq/d38GIz6J+Tk5DK0f9EX14JsvhDzSye2p5/6jgFu1egccFg1UfVZWitdrU90vy3VTJbc38FEPiOyP0asflrE9zAlcxd66kMpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104409; c=relaxed/simple;
	bh=ySbaUpbxthsEioy/CKgD+JOY0PQgsIgKQIrzPQ+PTuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a8MCtMCWWPqRhVLabs/3AG8OST/x4IOOMYma7x6OkF98vhNCuNrmCxQVVRLQbsAUVOdOPYSCkxHCytYy+wu486Y6xwJK3XC7Sr7rT+dtwoecRZKKyp9AnVcVwrti6QEO/GItWxj58KVwZNr6zybl3lVtwylm9+Z7RwaXBfPzMIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lTAHe75i; arc=fail smtp.client-ip=40.107.159.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJkVXy07gic7kKZ2CVGY+jMiJh3sRVRX6zhhP4fq4lwTX4y/19zHhBGq/IjBpDbj0HIIUC0efeR6BqqMhc9gErDgrO/YQ/X9q3yhRerIuvrWXc/rVpqmTEow++ue5YbFnli8AZCSvtpg1cQ6E9bUC9RUhGuPNW+SxxFFxg42VIjv2eH7ppjeOP79pigStlwEFQ0MPqh58Mm1XqH8SGVbNItKsd8I3ldg0+/XpMhBfDCUycZDHFOUG8r8Hxwf9dz8WrdYsuEHoGQxgecYuYZyULnN43zwvC3HiJxLEbn5/8kiTSaY/LrJQXwh8Jt/kDhS5PvXG5vKXUI1dOdBjwJnUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ga1m/FmnSGeSoIB9+IzXPkwkC0Qk9juZIKXubxvZ0ws=;
 b=SSNOB73x44p9aFxYSTlUbYVSH5scnieaQ9qsPc6UISSkE3Djrlc6mteJ6dQUeDgjO7O/e6jVr0Js/s3W149bO6abd6VLj58+M9RfLPEUEf79TyVFBCswoKsHA7kspzbEGJ6VDi2S1vxZdj99zZg1EB4oJiyho0hCfcT1RGe8RHOMvXvcQ/vndI+WELi/b8LudnUD2kRc16d8DxBwjJQ4NZe5Ejjre50jrZOgc5MEry0so7BPJFXYSOOHMq7G6J/FzEFqkIYFai3EbZif3VJUD2nZBe+mwEsWWfYF7kIjBylEuXewZfSmbwiO3auLw9thPAmvDP9jhhEEK2YXitspbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ga1m/FmnSGeSoIB9+IzXPkwkC0Qk9juZIKXubxvZ0ws=;
 b=lTAHe75igzZwCqfIsxq9c9iLiugbCL9tl3CVYnSYmuJKUuWS6LsVjYq3cfkW25Fe8Sr+VDq/8VO9ePFAYt9WFF2GTkBt03BjpVSn0QS/VrvZxv4onI0Q504Jx4GtSI4xR0SReYlvpP2iCJEl82RuM2vQFGOFSFaElEOKwxvFadIBWuCVGz7Iddqopn+cmLU3f0lZAagpiryRgv9fAOKJmn8hRW0P3qeg+kq4hYDI92YgIozx5nx9cGO0Q7HZout/N5pmXX57l35Z54NT6zoarDLNjTmPZRkVa+rgcUCMEIeTcxF/H986w1xn3pyc+YiEWUeSPiyG8j3/f1NkLV29Pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS8PR04MB7640.eurprd04.prod.outlook.com (2603:10a6:20b:297::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 16:06:45 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 16:06:44 +0000
Date: Tue, 4 Mar 2025 11:06:33 -0500
From: Frank Li <Frank.li@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux@ew.tq-group.com,
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 2/6] dt-bindings: soc: imx93-media-blk-ctrl: Add LDB
 subnode into schema and example
Message-ID: <Z8clCaPHIVFl1WX1@lizhi-Precision-Tower-5810>
References: <20250304154929.1785200-1-alexander.stein@ew.tq-group.com>
 <20250304154929.1785200-3-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304154929.1785200-3-alexander.stein@ew.tq-group.com>
X-ClientProxiedBy: SJ0PR13CA0227.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AS8PR04MB7640:EE_
X-MS-Office365-Filtering-Correlation-Id: ddde4507-7637-4f42-9f76-08dd5b368ef4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|52116014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ytqkf7QuBp3+bHBYPGAKlP/rb+s5aaqFCfsQO1PfcJgcKaNugkBMPKuRWViD?=
 =?us-ascii?Q?pM/Xy/Gx2qxpIHyNeu9X8TE/Mbo0SHAvAlb8Mf8msE6XFe9Ia06tlZ1LK49L?=
 =?us-ascii?Q?0FYmWxyvHXFlXpoqdC8CjsHYrCZ3hL2FsnqvPk2NAlxN2VUy0KmCu/EN47qH?=
 =?us-ascii?Q?g22PeBVGmJAYuHZQe72KgU5ptSfuN7JNODBTV5W8BS9YmemKKlB5dyYGbS+8?=
 =?us-ascii?Q?WwreajDf52CJOqALEFCsMb20Y0ZZt/jrNlSjokuACdvo5uEC76RMvbsOIes1?=
 =?us-ascii?Q?onaH3nRm3nm3P5Ney2KX/y9zAQ/TarbJEZyWdkF7wXgQVs5SSZfWKgBxS5ig?=
 =?us-ascii?Q?wffJGV9ZD0hoqp9tP3WUqiJ0+pMXnwN5UUHM+cJ4Bjjx7YKLNZB4LdsRUexT?=
 =?us-ascii?Q?/0r56LJPG1zdfdcPgcrI1XzY24qQ6yjMY5JdzWHPfb8iHCyJo4szdqspMe2Z?=
 =?us-ascii?Q?5gQVFLVqAQZK9epqf/pwrFyW7vbxoo6cvKtmQbBgmoTnoGir7lDIZNppR6D8?=
 =?us-ascii?Q?tjcvZsuV4WB+xf7gXGAO63wuJfLzGYE8Nv54JdEKBMODI/mCNWXL7RHcdzKa?=
 =?us-ascii?Q?OAwYDdUW6R7vrxcydkT1yRL29PWiCSja2uxb1sI5NoiH03dfZO6xlzW6/b4p?=
 =?us-ascii?Q?X2i1nlmD7kGghdEU8bmdKinRWmnTsp9Bl7MIe+2sMIZUdyt6bU+th+Iw+2vi?=
 =?us-ascii?Q?7zQhidefVkLTCSa66lsugNiWsij+4W5bCAqueiBie/hg9tuVh50weZEQxY30?=
 =?us-ascii?Q?LpgR+JWAv6cw5s9paykmYFRZnhQwDnnj9pSeWbPZeyAK810EmxELhEiKS/Lc?=
 =?us-ascii?Q?RHEcYwAAPjjool+6fIdsNmr8hox8qIJWcW/3LW2x9F3j9/1L8/B42gqaAoHa?=
 =?us-ascii?Q?k+TZOB4q/zuHUP0uXQTBg/XLLbCdi1wY9Jnsj5d3rK+G87u2RUbe8GCWzHb4?=
 =?us-ascii?Q?ui5fdjQf4NOTz8hK4ac1/0RoOxIGVp6RciMblIGqUfMKP+o3FdXxqpqZ/ivb?=
 =?us-ascii?Q?ejIZmyVqUaS/KYoCb2sRNXCrEgGQbrpmnZn06cr4Sfdy59FHhbOgGxQUIr+6?=
 =?us-ascii?Q?3Q7gtbZVUgCxexSL/hsx6pODiR725246EvPAhpeEDpmxTUy2/nvWrJGcQebs?=
 =?us-ascii?Q?keQZDGnnywiMXJc7PE7njDCAwjipz0/AHGtAvCysJ1Aspo/X2/QNsLr7GP1E?=
 =?us-ascii?Q?zgQLd+fHSZxPCgn5lyuazJ1Tmh0gGPZ1FJ3OE/Yqd668MKLb5la0PNU+Nfcj?=
 =?us-ascii?Q?clxMp9uFC1QJd2SGY29pwqMy0BItmFZBhmHZzB01C7nvGdK4loWkwaPnfMUU?=
 =?us-ascii?Q?DkiqmgeM0eHFsjwd4w+AKAWXWHM2mpWXVLeTY0frbEdw/ZHV+L8FdzD78mnk?=
 =?us-ascii?Q?WGR8OYfV6NWjlmkcQJo7QBODEDk1CeDWAN/RNve5ZYivoeqB+jjkrjgvK8RF?=
 =?us-ascii?Q?RRIeH8haX7hvAVSyk5jeQwH/ohgJaVEG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(52116014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R45N8Z9sVVGbBqahemKR4i6Yrm4O+7PG4BUShY6jqkuBW9Btgm/VFpNGak36?=
 =?us-ascii?Q?nhlc1wmDEyQSTfnNsBLUGcFohO/fRMoUl2t9Ih1GjtomqAvNNxLvwkt/OtiI?=
 =?us-ascii?Q?tliHbDZUF9gfEp1Xosu85sRn3jMtuGSJAqj1sLRekce+kENoyfDdNJW8nvFt?=
 =?us-ascii?Q?uxlbQHt6dILmXPiLy9UldQuI+89QVaG6d+NBDffa7Fgkd985lbUDRDUNG7Uy?=
 =?us-ascii?Q?EptzDRhuyo8ao+qeeZWXGgsGfwjK0CYqEiMsiuL2zQSD+ChLNU1AJsJ4YxTr?=
 =?us-ascii?Q?InmWZmqmQ3PiKyshbWkM6XeJHVfbaxC6WGtbJP0yqzgl/tBvDYK44jspxRNh?=
 =?us-ascii?Q?oN3QVxvnI5y/BC0pHI5vEosXsg2746FKDHEluYE3dE3w6p4tWtGfBalrtLjx?=
 =?us-ascii?Q?Qiqqf41Pzz+9ht75nS1tVBfvWNX6byCAT1qNjh0ORQburZqyJbeVff8SqcPW?=
 =?us-ascii?Q?fGLesgzBC++J81qz6pdWSMowYHuBkCX4w3I3NVN37ijojPa0q2wfm305CKxY?=
 =?us-ascii?Q?HSaSEvArT5M0gY/QsHTIRVE1fVqqoAsfQpv9j1mYsIfuhWknuF0uAin2lXX+?=
 =?us-ascii?Q?qESY/dVx0VqaG53tZBqi51M2t5KLclUSJEmH1lMmfcP3axgFgiVV0pApXSXH?=
 =?us-ascii?Q?k3KvczYItNGhEpj80AmyndyzoqrV7KMXRNdbKvhbn+Yt2u7/QZfHEMTF1k0C?=
 =?us-ascii?Q?RCGCQ4hL/oeuMlV+jHr+js1k53FqX+Zd4EVGcZG6rIGObVCZVeLYc1hngjOk?=
 =?us-ascii?Q?zL8zclJE0TFfUbuMF9szT5wmmAcXIQXZMEhHKavZdHf6bXkZ4a0UbeBVQtl0?=
 =?us-ascii?Q?sfXbknNpyy2j0/tO3vP5Y7BdS3vDvEIFQBPS77snuBQOEujXOIOC3qlBRjXl?=
 =?us-ascii?Q?qlYKkXkdUe2hmQkY1j4PXQvHNQ4Ye6eZkBJjKMtKLOb/FNAZDQtos6o134iH?=
 =?us-ascii?Q?jNzN3mSWgrIRBQyiBHQ+nRqYmvZer7zP0FQMeXWXs0o4RhLxYvd29gg1nu9H?=
 =?us-ascii?Q?6wehdIPAo6Z/kX8LvZCgxMiE0nb3J3jDepuqqy4YohnI1kkarsxwvTxzB5Gd?=
 =?us-ascii?Q?p2dGPLmgfWcGOfkbkAgzsL8t+8AIYnZ6SxUr/LAi0GZ84KE2Rp22UYhFjlw7?=
 =?us-ascii?Q?uJz/Zv5z9mXN/F91rF/3VfwPhV4Fn8WQrfwJ5Uly7dVnrfaNza8+sC4XGIsw?=
 =?us-ascii?Q?GaLegcjkCEaeymtMA0Nd1W7/G1EoSpsdQbTXxDGNbdH17tvavNgm/VB4Ae7l?=
 =?us-ascii?Q?LWxhYwiBCnDs+lV6SJiYAfPFCxRi4RaoqrS549aexRzzJKwvQ1Xfp4cutXaM?=
 =?us-ascii?Q?AB/XxcP6l6kSpSzBkpdbkvH0+kP1Taz0MJKFKv1cNcWc5MpVbVDZYiOL0L3/?=
 =?us-ascii?Q?weaneESFgmHEE7km/wD1pcuYFLyFGIuViQRrscYP/iUpd2XoIWvI9ml5GR3E?=
 =?us-ascii?Q?L+reTJ3aamMU0wSbj/DCjYZn7EED0nhnzmyu+Aj5aAUhJQueqWjUaV61+gm+?=
 =?us-ascii?Q?DV2IaqtP2Wmk4P51AqtwXWbTdvjpxYP9dmOLo8rF2bxdXw93s7podzR+cDSs?=
 =?us-ascii?Q?mD0xeH++rekxigitZq/8NZE0GsRPCShUyJewama1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddde4507-7637-4f42-9f76-08dd5b368ef4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 16:06:44.9178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eckD7Ep/RdJVY4oeuuVbxYzas6XA2aeMy0Xbe3DHOp9zaBU8nfzxJWarvxdeTcMJp89cB5GLMzQgsFrouTlyJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7640

On Tue, Mar 04, 2025 at 04:49:21PM +0100, Alexander Stein wrote:
> Document the LDB bridge subnode and add the subnode into the example.
> For the subnode to work, the block control must scan its subnodes and
> bind drivers to them, do not misuse either simple-bus or simple-mfd
> here.
>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  .../soc/imx/fsl,imx93-media-blk-ctrl.yaml     | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
> index b3554e7f9e76d..cd785111928bf 100644
> --- a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
> +++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
> @@ -24,6 +24,14 @@ properties:
>    reg:
>      maxItems: 1
>
> +  ranges: true
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 1
> +
>    '#power-domain-cells':
>      const: 1
>
> @@ -46,9 +54,20 @@ properties:
>        - const: csi
>        - const: dsi
>
> +  bridge@20:
> +    type: object
> +    additionalProperties: true
> +    properties:
> +      compatible:
> +        contains:
> +          const: fsl,imx93-ldb
> +
>  required:
>    - compatible
>    - reg
> +  - ranges
> +  - '#address-cells'
> +  - '#size-cells'
>    - power-domains
>    - clocks
>    - clock-names
> @@ -77,4 +96,36 @@ examples:
>                 clock-names = "apb", "axi", "nic", "disp", "cam",
>                               "pxp", "lcdif", "isi", "csi", "dsi";
>        #power-domain-cells = <1>;
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +      ranges = <0x0 0x4ac10000 0x10000>;
> +
> +      bridge@20 {
> +          compatible = "fsl,imx93-ldb";
> +          reg = <0x20 0x4>, <0x24 0x4>;
> +          reg-names = "ldb", "lvds";
> +          clocks = <&clk IMX93_CLK_LVDS_GATE>;
> +          clock-names = "ldb";
> +
> +          ports {
> +              #address-cells = <1>;
> +              #size-cells = <0>;
> +
> +              port@0 {
> +                  reg = <0>;
> +
> +                  ldb_from_lcdif2: endpoint {
> +                      remote-endpoint = <&lcdif2_to_ldb>;
> +                  };
> +              };
> +
> +              port@1 {
> +                  reg = <1>;
> +
> +                  ldb_lvds: endpoint {
> +                      remote-endpoint = <&ldb_to_panel>;
> +                  };
> +              };
> +          };
> +        };
>      };
> --
> 2.43.0
>

