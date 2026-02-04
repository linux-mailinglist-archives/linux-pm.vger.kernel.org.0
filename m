Return-Path: <linux-pm+bounces-42109-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDoFGRO+g2mqtwMAu9opvQ
	(envelope-from <linux-pm+bounces-42109-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 22:45:55 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE40DECD64
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 22:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B253C300899F
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 21:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963E5285068;
	Wed,  4 Feb 2026 21:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KLNDyXgk"
X-Original-To: linux-pm@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013008.outbound.protection.outlook.com [40.107.159.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2079A2C859;
	Wed,  4 Feb 2026 21:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770241552; cv=fail; b=lmyWtzXU63s0gzvKTSbeeiBR9Wu5KuMUiRzjzlstkSReEmalmbwW1ZB3MS1jPLyKDed0sLbUkExB1H2uJ5PPmy36IBuaE0411YOaJl1VxTMCKLEMYydR9cW99h/3lYvNTbiWER+WU2ZlqUpB4C9z7HbRvMsKtXgU5PyolrmMMc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770241552; c=relaxed/simple;
	bh=LlZVJoz8POChJCI3PPDuHdleAIF4EHeCKyx0LbxWjUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qmPJnd6T2k4jrIBzssILy7Br6zXRK+Xx++gQJVo81qB+mH/6svwmCoIBcenRy6BNFqI0QY81bA9J3bEu6hGpbADXxtq1PH44k6N6AQ086B+BoMPMmUzNDVjFIqzVSsWJ2IrFWrIy1kjDUwzBR6Fkp9wrwwjsAwvBQx5Q5k4VI9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KLNDyXgk; arc=fail smtp.client-ip=40.107.159.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iXE+ZyuYGth+UR8FUKB5pM4e/twMP35zR1PGjCzfQ7VA+AvS/GvmI8fmIVRkXdQNja4TMum7/vF3lPIlQ9SOuffMv6/jsm2WUS4yghA3Vb4AZH91kp6tq6Qqf0/0hpFezxIuzksi6BzSVfxAE3ju/Un7Zi926K9giLZqCyyaVSffjhcrxut2DJuC+nfZpLKLk3JiSx4OfKH/uXuU37+8SKKgWC5U+M4Xw8AHOS5Dq3t3nGNOTgcfJbr36QSjNhsqiGhIohKrNW6S2WxfBaAgnZdglqY7bogcYQ+I9R6w6A/lh5+qIU6A9nWolRWlr5g1KVBM7UUFIXhHTUZ5zk3CDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txaf5Zi8Tee9Fvz9nfrxlC6PHo314Phzhr41aQJN7LY=;
 b=k/W1Z42Gk4doM+hsVv1MUWHRVO/KqpeL7NV/5qYxa+YPBzQYF93qeQnUk0iZL3Ri3lpKaD2pCiIxhTjtBEMZGc5o7rE9t95IyYv/tpEy+JdxWI9H7my5cPeBZZzvCD19/sgmKSFeZyk9cwCwj3GuHIGhEMRVw9W2jqCNZa6qm8ax0/FH1dKMPfzSpMl8xwMw0SyvNfbpMmLrqzWqImM2Ch5hsVcW4DMOdxHrpbx1j3RsTPglxujB9SJhBSA7O70dKvo8IswlwnV2ObMDxMjEl65HDJNbxqM/FGEFbD22sVz1miCiYBDSEMoRAjT2rHDdIzpD1pO0JjODiviWL9ysgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txaf5Zi8Tee9Fvz9nfrxlC6PHo314Phzhr41aQJN7LY=;
 b=KLNDyXgkqmXtuFYZhnXH9sikjV21uWq7H5+M9CY38eoybTcdO/Q5ykGlNoL4qNwAlJUkgWfWzWQnEsqWUDp6GjcHyd6uo0GfpFNpfWuvtMS1ZpLfej1QGLmnVYAGDHLcJadiDhuz+PzBP0IrPTshxwKZXp904aWDi917006S9Zw4WkSEnVOhvYjXz7/m8s2hJY+gPnaqFCF5+kiED6ul2aRYOO+NQTFOdthNrC7Ybufq//Ad2KaH8vnox8dXIVAOOmLj2DIkQ+CHRcFedSL+2pycDsw7OsuL3388TpPe0H0ANDxm6wFvZDDYhby7YcliQuop1FaCd9GHWRDl+aoPqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU4PR04MB11458.eurprd04.prod.outlook.com (2603:10a6:10:5d3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 21:45:48 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 21:45:48 +0000
Date: Wed, 4 Feb 2026 16:45:42 -0500
From: Frank Li <Frank.li@nxp.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: alexandre.belloni@bootlin.com, rafael@kernel.org,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH V2 2/6] i3c: master: Mark last_busy on IBI when runtime
 PM is allowed
Message-ID: <aYO-BlFaIV_gTeqH@lizhi-Precision-Tower-5810>
References: <20260204111511.78626-1-adrian.hunter@intel.com>
 <20260204111511.78626-3-adrian.hunter@intel.com>
 <aYNveVUsiixWWlWL@lizhi-Precision-Tower-5810>
 <a650c5c6-5975-40c6-828e-eaa27403adfd@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a650c5c6-5975-40c6-828e-eaa27403adfd@intel.com>
X-ClientProxiedBy: PH8P220CA0048.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:2d9::25) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DU4PR04MB11458:EE_
X-MS-Office365-Filtering-Correlation-Id: ff8eeab1-69d5-4acc-4c56-08de6436c23c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|19092799006|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x4LfvNM3AsRPlIJleFXZGBlgAcaCQnod5BrXvmU9x/hx1PKwoJ1mQXEWwAOO?=
 =?us-ascii?Q?Gbmrm5l5w9Y1acLl3zVI313G7uqdshgLHJUhZo2ns5E/pgjij7V/7DhQZTDr?=
 =?us-ascii?Q?J0/E56d/zkGNISmAlbLGNYM6+IjaHu1Ctis8oStUjBnbTlFhkZF7IfOt7ZSg?=
 =?us-ascii?Q?Im8HsvLy0UVsSrRFgLWM60RZFFKfFSe01oPX2kYtHXOIeMADvuq8UOPPMbiv?=
 =?us-ascii?Q?wanGx53Fx0sxTebNCT5cXEA//umwtw+t6fQqDS3z3L6fe+Obl4SLUwxvNBcz?=
 =?us-ascii?Q?WSUkjal9XjpvgCHasczidY+Gdp3E2LetefY98WymMidP9yPnq9mD5b2FZ2fm?=
 =?us-ascii?Q?ywytfdJh5wDR3lFiyhkdRbn5RmiFDB8PC2zl16DAraqGGLgUrT1dzbwXgFt/?=
 =?us-ascii?Q?JZFwpr51u611hNM9jCtejESp51Z+vvsELBtIQsKJJezyl8UMQ5OdOsjk9bZF?=
 =?us-ascii?Q?YLW594SI/RbO6LxkowxqWFDi2oVWsuxWqDuRwr9QpVKrUsHplk5ZPMxD5dSb?=
 =?us-ascii?Q?kK2q7RVk7e4rvxjEB0g5uoZ3bUIs85nf2+Lyr2Cm2Rr6nhS6W4UPbOZIDMSN?=
 =?us-ascii?Q?i1uw26UwxV6ZxZqKIfTASY8T1b5PX0IUS1BWs5oQTsKNpYjPFd+ZdXRHBSow?=
 =?us-ascii?Q?TemLs2nMUdfXJV0pAo26lK25pVJ6jmcZ2d6mALgH3sV4F/4+wzH9xSxdBVOA?=
 =?us-ascii?Q?n+pNIxD6k1AkdjFYuP2VzNoXNQQjq+3/fUCYRVyaABmZA6qAp1RppzOZRlIg?=
 =?us-ascii?Q?DbkPXVk/tbBShNiucxuP5dupZRLvsCx5MejfMOTB0yZnnGDp+qmIMM2Xz8S7?=
 =?us-ascii?Q?YQ1D/Y2Mqk3P3IG7i4OTWPH2R1t94M480iNpl4DS+dmzp7CNY0o+fpo1H4nE?=
 =?us-ascii?Q?XQF8uqSKljoKu9BrPV2PPva1Ak7qw6yKXf5ntt57aL/aCWZ2MBAJ2O2k9sQO?=
 =?us-ascii?Q?rHrCu+4r12uure92ZK6L6MTFF1nz8J5bGjfP0ZT7WpYhE8h6U+4TThQyGBHx?=
 =?us-ascii?Q?nRPZqUZYIiH7//8P7UXi0QCDvmz5zsri0RmSRLKdx6Ylubg/G6fyliHpcqcs?=
 =?us-ascii?Q?mApgPkS0+0hRPjkQOrwsAlFZOMy14nWoGE7Ra52PnMz0L6AluDjK0jtAUNN8?=
 =?us-ascii?Q?7O7jV95XG5A/F2b/AtSmR8Sf8kHa85Au8Bt7r+Pdkrk9iT6da3zVHZ1mqgMN?=
 =?us-ascii?Q?cMQWiv4cSkp18gRZAi2yR8TU0721mVJskw/d2IZ3bdkDJApegO/wgO/igMAf?=
 =?us-ascii?Q?h9X1X1ipurIPzaY/RcIL0wPJ93hsDo0DqjSpjVLQrK+r7qZMJ6uqpLTdTBeH?=
 =?us-ascii?Q?MIDRFysJIl3lAE3L/LfUqBpX0mgHtFw9SMDXlODbQWkkMcdIGN+00RVE3NYS?=
 =?us-ascii?Q?VshwyD9AJatLsohxmCdG7NijGF5lrS9U1tVWFJYIpGiYOws31ZvR3UrSAu/4?=
 =?us-ascii?Q?SEUgq864Fd9khvC6Sc4s6f6H+haamgr6+F+wfK8bPnjpfIN14qRaPAXe57Ya?=
 =?us-ascii?Q?jb1+NbH/s7an62x82/uHIlA3vVieWgRzVNZARpYodLhPogHJhpSg+IrTIo57?=
 =?us-ascii?Q?kUSPNds5TIUOQNOHXvefKtwkrQXHhtuR7T4mLcknigY9JLZLX0PFUZ/HhZHv?=
 =?us-ascii?Q?5/Z0IRhbFm9VWphWmPGSFn8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(19092799006)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kjj9TuLS/dxr2BJaoeqcZZX2jH/OmctO85Pwd2ay7weSLn+OXJyqW2chSPBY?=
 =?us-ascii?Q?dCDSzuEhv7eUlnS/eB/lfXTCSR+HJQjFeRd8LTJHzkYk5iS4Gvr0FAui8lQQ?=
 =?us-ascii?Q?hze5c20I4dFIReROgkGjCA6yd0avjZQj8mcYGDLsYTDlEif1qzNvxJcFzbtu?=
 =?us-ascii?Q?N10GRumGCt6yS/FyJq81/9ToUtHGFV/HhsGtJsf2gz5on8lcpGmX1hU4oAy7?=
 =?us-ascii?Q?OFiYOqVKTLOzUckIJtJSU0J3ExNwjvz1L0gHZu3jk+fkTIZPY0q6eXd+SJMZ?=
 =?us-ascii?Q?iK6NJKUHZa7jN1TtuYNqx3o0GRiiR67Jj1f1QyF3a5E/YZwHNhCJv6Qrck4u?=
 =?us-ascii?Q?ewCRrlQQdr9U3BLzgCppdtaIFV5eISNNSlR4j3QGMzq7+KxkPWmuXqcgTvDa?=
 =?us-ascii?Q?VyHoEZybpdin0I8aErXEpcjs6XHCzS9HMh1FzKUhElz4x77LDVzTAn2lKSi6?=
 =?us-ascii?Q?5//+ThtjcQXo6TB1i0/48fT5y8uCMBlSSOYWTvdb3NU55ceNkp4HZr0lOpjw?=
 =?us-ascii?Q?wG37dMPFLZxBRJD4iSma+S6tGLAcCETXyxMJbvfP7k0Rh+ch/BjdefFAsThR?=
 =?us-ascii?Q?gNSL+4RUefDHIynpl27SuENtgNjpuc8Ii58Xw3hwtseIC8cPBNggfxD7M4wk?=
 =?us-ascii?Q?VkYzZ9cVSSRaZMi0C3p84lURQb9OQOzfb8Wtvwtl74d7702vAWbi1ybvSL5q?=
 =?us-ascii?Q?j1N0tp7t8BnMR92tMiVDAQQNhqOgyZpdvbhn9AoQmV4zeuKjjZQCWFA5XTkU?=
 =?us-ascii?Q?R2eChFV93JyhbKas9HyLBx5tLLEAMDH0WTnFpRMO9w321yFwBKHyjbv1mngD?=
 =?us-ascii?Q?+EvzxrHNGSDY94S+zdeyrw170dtZO6KneODN/TktxSUKxsJuZkEfy4yaRVnK?=
 =?us-ascii?Q?llgzcynvDzaNS7M3X+QQ4KYf3ly1U2mfy4WD2j8l20UOBA74VdrxGG/gYHkr?=
 =?us-ascii?Q?AVzRjNJ9guMekZZVTuhSSPMTHE6k4lxZW3np0C88Bo0L84VIPbNf2f5uXRwO?=
 =?us-ascii?Q?eSb30fmkExMi90aqbO8ZWZdeTA52u7phV5AEoFqeUU0VfD4NSOoNxk+mBka0?=
 =?us-ascii?Q?ex/3ntIsGjsXXjxDG2Fzz7nBy1oBeboDdiG3vcnA4D+7koMjRxSCklXjGSYA?=
 =?us-ascii?Q?fc0Ja2dZesluIX+V8C2TlDEjlNxRp+h/CqbrjTX0mhIe8SEG3SmjCZMlimiB?=
 =?us-ascii?Q?ETNcBo7EcxNFVLLOJXFyexTL5knReRERuADErGJYuR/MQvXcIx9ij4L+eyXE?=
 =?us-ascii?Q?ck189OHOo4iv9rZwo6Yx5hj7esM5bpv/0xC1Q8cQqbdGpn/txlVCh/hAsxXR?=
 =?us-ascii?Q?qh1GafjubVvZGHPzuOWR4n6nEL/GECP0EZMltDaeXPw8//3G7otLxBRKjQxf?=
 =?us-ascii?Q?kuNof2i+Ta2TlxEAfc7/BzeUwan0Lajbx/BVYi7qV4n16JuhRMopJDXOgWoM?=
 =?us-ascii?Q?rV0jNu0F7rclq+uNGMypiauw3lkr4xZWmcoDTJidEoNb9f2u81//xrCZU1jS?=
 =?us-ascii?Q?YlMgiO1CNS1J/SOAshGRgvfxXJ8dRh6+X5tFfAmut/ulsDbf0OWsGrgVoERn?=
 =?us-ascii?Q?KF6ixTYHgL5vl/ApbP9mgZa4QjxQkzQZ9Qh4sxhDt7vOvj39o7umQrphnLrX?=
 =?us-ascii?Q?hOtPsobxVv0jdU5uPuQSLw0MInUh150lzQdL6GDo3qN+AlDsskVE+PgN9lIN?=
 =?us-ascii?Q?5IyVXYh01alsMaY79iXQU6d8lD3L1z/ivMPZrM3WQAA351f8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff8eeab1-69d5-4acc-4c56-08de6436c23c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 21:45:48.4802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: po43Vq/y/qg1ajWNseRuRJfPSKc+dR5xpsKpBMLd5+qLGSIE+yBX1+2G3US2/R9T/3fQCuyTHl/O7WHd6OJREA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11458
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42109-lists,linux-pm=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:url,infradead.org:email,intel.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: EE40DECD64
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 08:24:21PM +0200, Adrian Hunter wrote:
> On 04/02/2026 18:10, Frank Li wrote:
> > On Wed, Feb 04, 2026 at 01:15:07PM +0200, Adrian Hunter wrote:
> >> When an IBI can be received after the controller is
> >> pm_runtime_put_autosuspend()'ed, the interrupt may occur just before the
> >> device is auto-suspended.  In such cases, the runtime PM core may not see
> >> any recent activity and may suspend the device earlier than intended.
> >>
> >> Mark the controller as last busy whenever an IBI is queued (when
> >> rpm_ibi_allowed is set) so that the auto-suspend delay correctly reflects
> >> recent bus activity and avoids premature suspension.
> >>
> >> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> >> ---
> >
> > Although it is no harmful, I think it is not necessary to mark last busy.
> >
> > schedule's workqueue task to do i3c transfer, which will call run time
> > resume.
> >
> > Are sure it will block your function without this patch?
>
> It is not necessary at this time.  I wanted to cover the case
> where an IBI is not followed by a transfer from the target
> device driver.

look like it is impossible. Device raise IBI, which means device need do
some things. otherwise, why raise IBI.

Let's defer this special case when we really meet in future.

Frank

> Perhaps a device could operate almost entirely
> using IBIs, but there is nothing like that presently.
>
> Let me know if you think we should leave it for now.
>
> >
> > Frank
> >
> >>
> >>
> >> Changes in V2:
> >>
> >> 	Adjusted slightly for earlier changes
> >>
> >>
> >>  drivers/i3c/master.c | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> >> index 49fb6e30a68e..48d1b1256290 100644
> >> --- a/drivers/i3c/master.c
> >> +++ b/drivers/i3c/master.c
> >> @@ -2721,9 +2721,14 @@ static void i3c_master_unregister_i3c_devs(struct i3c_master_controller *master)
> >>   */
> >>  void i3c_master_queue_ibi(struct i3c_dev_desc *dev, struct i3c_ibi_slot *slot)
> >>  {
> >> +	struct i3c_master_controller *master = i3c_dev_get_master(dev);
> >> +
> >>  	if (!dev->ibi || !slot)
> >>  		return;
> >>
> >> +	if (master->rpm_ibi_allowed)
> >> +		pm_runtime_mark_last_busy(master->dev.parent);
> >> +
> >>  	atomic_inc(&dev->ibi->pending_ibis);
> >>  	queue_work(dev->ibi->wq, &slot->work);
> >>  }
> >> --
> >> 2.51.0
> >>
>
>
> --
> linux-i3c mailing list
> linux-i3c@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-i3c

