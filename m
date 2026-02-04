Return-Path: <linux-pm+bounces-42094-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wG8kOMdzg2mFmwMAu9opvQ
	(envelope-from <linux-pm+bounces-42094-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 17:28:55 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4061FEA379
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 17:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42D0E306EF0A
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 16:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9902842314F;
	Wed,  4 Feb 2026 16:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WF2Rmk9c"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010027.outbound.protection.outlook.com [52.101.69.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1693F3B52F6;
	Wed,  4 Feb 2026 16:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770221218; cv=fail; b=frOOeIDN+AV02N3NzGCz/CvRHX4xLdc0ivYDp8YCBPLMZgZ0LR2yz8yiLqAGUgd9Hk6klJJ2g/Uslfz3DTCupqQpfXCpj6tv8lANScPZinM4KmYd7VdMPFyUSAnEIwimp1J/zVPTw11YQTFqux4rfl5zhsIhJsgik5RDGWCufTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770221218; c=relaxed/simple;
	bh=UWP9aZYG+TBRmj46ZcfJB4AtlcxZt+vs5T0tv9pMIhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iUSPTQEOE59cwwMnvpr2l/oTFdiy+rfJeeLG4ikJDWvao1rm/Dfc+ARAf6P9u6rPtTBT0Xx5D/dpNDH8G8mn6+ZnuKnBaBAt6WnS2hiAxRsPX2QEq4AorTTSFl4EoBroTPTejmg780zIyRYWr75jukUXvaRi8x7/AKVu0Z77RgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WF2Rmk9c; arc=fail smtp.client-ip=52.101.69.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gS7PAGdzA9fbtaV/uMKsnAHVV0s1KzSRYdtlZW34r7rr86RdyIFY9q28tVVTEIu7ndYCzmICUHm72b8mQM4LQGdhWRe67iFVzXaFFfcdLYugMrChGWuNHrY1zp/pmY9Oj4uFI0sDn/tdo7Tgx3V4XlHOsh7Sx0ZIn+93SxhoUcpXUzIPvtj9CfuSZKN8qHF6RCvu8qI8CKC95B/QdCrB6GumsYezfnL1IwzeEqwM6rjCjCl+35TxOygBYRakV2idQ/eLSiTyjsTb/pPfTURCW/LbmUxrktwnmTLfuua24ejUe+VDtzLOeEmTJxMOfTvXxIeqFJv1y8Id8hCbBff6Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9VYyviMB6KATRQn7vICo+TqDnQypeCXkJc/EST++6g=;
 b=u2Uy9pcoI5NAUaNxHyyDZ5xgIgL8pKf826PWQsBfm1hFc+UhBtELSNk09zzFK5hCFuFcRDlQrq/qghO417hBjQ4vlvHLvH0b2MFewLHiIoeLyEMhHycUWZQ5pIVPSSPRzFWVBrGmnQi0tG5vueT2tuR/h+cl2hiUDjq1Pgbcew9vYsS+feXFJ605bP06a+PBZP44xE8Cy0JDHu4ekQW72B+jNsd5qX+dvXHIx8I9EiR7+K1EPNtdyXGe0hzRrEe/zAg8XRKb0H3obaJ5mFDyVkF+hzCM9XnWAJ2j5MrgINSGZw+P17h+SXW+hfukgCWjsNq//NvPFhIyDLHkhkFNTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9VYyviMB6KATRQn7vICo+TqDnQypeCXkJc/EST++6g=;
 b=WF2Rmk9cVNhyCZsy8OoOCY8QFCc0ILovDfrkXhRxbUWXi8/aI9jYFqG8mmawmibP391MN9ueBRLvZCbROSSP9hqcQgfEYrOReEVn30IcXEKAfBzVMc1IR4Erh1aa3P5+MfTGG2hgPrdQdgxP3OPQH0FRlQEDjBiU4H/0UyFkZCYLzqabfXT25gVWqmCbwTkc+ztFdlO6V60JHvcft52hTZA3oy++rLOemv8rcVZvcFUa0ctIZbTvOzn9IRFKkrwfXWai6blrg6Lc20U/X8OZKBaUvqdn8oMv7go+FBO3GneBZT06mMi7jYGBclB2SFdzhGn/L0ranUP22owZFqlLsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VE1PR04MB7486.eurprd04.prod.outlook.com (2603:10a6:800:1b2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 16:06:54 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 16:06:54 +0000
Date: Wed, 4 Feb 2026 11:06:48 -0500
From: Frank Li <Frank.li@nxp.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: alexandre.belloni@bootlin.com, rafael@kernel.org,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH V2 5/6] i3c: mipi-i3c-hci-pci: Add optional ability to
 manage child runtime PM
Message-ID: <aYNumA0-FvE-g7nl@lizhi-Precision-Tower-5810>
References: <20260204111511.78626-1-adrian.hunter@intel.com>
 <20260204111511.78626-6-adrian.hunter@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204111511.78626-6-adrian.hunter@intel.com>
X-ClientProxiedBy: PH5P222CA0003.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::17) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VE1PR04MB7486:EE_
X-MS-Office365-Filtering-Correlation-Id: c9c89fca-d6ee-49c4-68b4-08de64076a52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NLhvOcYL/5xjImZf6//hoBdznFDDgzbZi0mEdAKuuk0TEZkEgrmZyIwoUVAc?=
 =?us-ascii?Q?skPVaZJ/Gbq6xQEZhI1O8b/Z4CACoJ2ZvzZ6Q/qH7p4MXMsjnP8+kRzG6r7z?=
 =?us-ascii?Q?eHkivalMajkQl148h9a8WAsGpLZoxynJ1Kg9c2OP3WEeS6fNAj8mA32JHUza?=
 =?us-ascii?Q?poJYIWkrmC++C0HeKQYIHxnhjvmfVpD/WQomR+dL8U7G8fo5SBeRYPMSiSxC?=
 =?us-ascii?Q?4ex+dgmFPofJChUSq0crYHHTd8EpBav43yZkbUgdYhFVGPEg0SUs4GHxQuAN?=
 =?us-ascii?Q?k77+kJTMaifw+tJvLIhOn36waRK7p4iZ3g+e04Ns/M8iuPeyVFU60dJ8yw46?=
 =?us-ascii?Q?JcLxL9PEiL0a9r6mpkFq25K3HbJJ//O3yGpCPs15l1psqVgml8MF5KmwIO5X?=
 =?us-ascii?Q?wJlQSaggKYIpS2omR4fo7vPIPF3yTwLtR6sMdMcqiq/RFVNcPXzkxIHGrmZr?=
 =?us-ascii?Q?7j1lkZ2lo8HdwJdLWYtig8aB46/VkC4bHiA6OL365ov/TCYA8mjcGPfeqmXC?=
 =?us-ascii?Q?AQb7on7rdxZo5NcqJX/cfRJOE8jeK+trJoShiTDcCeAbbXqRusNSqBkhw2Yz?=
 =?us-ascii?Q?V/pPlFUSNISh3ZYECsjA7C2IW2JQ9G+i6imql8WgqlpkoJ6HxYeHGORjQ02A?=
 =?us-ascii?Q?YKs+uWa1UcbfzVUfSVAvqhAPem6aVsrqj2RKZDnOHU6CjywoPwQet43ier+4?=
 =?us-ascii?Q?zU318QfuzW+9KAc7DSawGZPf770+vGxN2FIZ1ogHmqJNQGd/F/prBahoCRIc?=
 =?us-ascii?Q?bzymGigfeo8KKGtsSE89LqXn9yN1IF5oJeI6hBD/8ea3GoRMKFO3xl5/QQWu?=
 =?us-ascii?Q?EL18OrO45/qq17IhCjes1wwT9DpjBkcuwBHA2YaDGUFocYD5GzzMzWZlnyq8?=
 =?us-ascii?Q?YRMVxWRBnu6K2Xhjz7OgiVuGYc1q2p8Nar9VlPiEjNAMhSI57yUlMYGk//Il?=
 =?us-ascii?Q?ZOJDh86TSb2BBz+fdKc+wxP1bW3aZi7D9FN2/ojlnFIT0MaLXW1Jel2/eQtD?=
 =?us-ascii?Q?kY1MDKDTiu66jPFGsI8hJugTMpV/710v1KHGfzeMiaO4crP1jgz9nYuORd0w?=
 =?us-ascii?Q?bo0EK6gXkUvLVayZUPBHbvtu0Ood1KqZODEedzfmTbnVPl7xPR+u1fTq6LYj?=
 =?us-ascii?Q?cSFkTNYcuzleUu5KZ1ffySCSr1+fRQRuIjBs0TXTgO6noeWqfwyHCi9g8aH8?=
 =?us-ascii?Q?M1AQSZ6UiCK39rj1hiBk04/j2mmhy0WLA8zT2mhIFNhn3al4GWApLVRI40Rx?=
 =?us-ascii?Q?t5ZNumbX7p5E/F/CbTcGiwh64X4eOJGTKG9jr3+voInnAdvA6YALdHl9uEpN?=
 =?us-ascii?Q?cSHewdmeaj8rkzXeDxi0cI0odL1PoqpMvHtpO9N8pw+CRLe0ETGREEqsSwDs?=
 =?us-ascii?Q?aQ9UXn+CJbLwVDG0KnZQUZBqQiy9O+U1hiGH6ZkkcK7YWas02NokOSx85a3J?=
 =?us-ascii?Q?OcK6/+i7J/kgv1akVxqXI2vCPKDe8jDECC9F0sE/OSQlAumZ3AMN7EVVbk5/?=
 =?us-ascii?Q?WEy32kKpxjp0EMtBEvwiXyfJOt6cpn0hGZmzvNG/sV0qhp0AcHIAu8Wu++NG?=
 =?us-ascii?Q?IF9WKm0fMK7XOgnoilCLryt18DKUOZIEQbgEi/fUUyFzBfek8PNyoHYNQd/2?=
 =?us-ascii?Q?TORmY1/kGAH8vtNZ58fMjVg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VMsSWwhCl9p1LmHiBJQkC+X6bve5pOIoH+oam9XeNpJyjvaJLbmYPXTLNs95?=
 =?us-ascii?Q?NK3PmjmZK5YC/FzSZft5trlntagaLktuhlKwj/YKGR5C/ckiJvDLCvo2LUhJ?=
 =?us-ascii?Q?at2t+ZpzxL9i5RFFraeBCsjOnhmPGuqvg10L92ARwkeaYTtzrmlxZAfZX0/i?=
 =?us-ascii?Q?zTLv4c5oaEDZ39iqaCAsFyDFXJh7ZtDUqNoxuT6Yzdqv6MqPzm0A36//0GnJ?=
 =?us-ascii?Q?nB1t68COblRSsdu3ZI6y5LNKEBASA5nfqe+vqvLBEqhLVDRsf34a48oXRRav?=
 =?us-ascii?Q?575SYZdWizpGmS4WiTwjTPGUz+BZwod+Q0rhkJSFiYclnoVSiWXlZ4IdXDmo?=
 =?us-ascii?Q?0LgIOLCGUAJNJCs4SsbKbWcvoIjzx9WIHUSYvD2Amd725Rm5RFz7+p8IStad?=
 =?us-ascii?Q?us69GhjGb9uPRcfagp/05snDjL0mdkn/oN6mqp7QVM3wosrzI7vszX6UuH10?=
 =?us-ascii?Q?Wi0TCxn5lWoHWJk24G+kZ3LkAj3QL6D5JhC0HQM9HbyDSb0IYpKyIbSZvCVv?=
 =?us-ascii?Q?D/rXcXo/9l0jTbgdWGlRo7mY26bcUD0lPf3k/T2w/0WzRiPLiMHSQIlvZyHw?=
 =?us-ascii?Q?UCpQKapfB9MO78CPDebyzGdgZyia7Ug07uXVZ6kgN4NCmMe3e8xtL7zJQZDU?=
 =?us-ascii?Q?nWhk3a9NF4jZJcHh+bCglf3dihNlyeAUJTrqIK1qeAEhALBxKJ/HQBCilcKv?=
 =?us-ascii?Q?GFNeg/M8eQEBUcWNZcKk9EGU2oVU9gGi2NsMfglMsMB4VwadxPZbBJdD1CmE?=
 =?us-ascii?Q?y4ebGbkbIwGBpnrwsRhgoyNirF8X3hIdjsjvR4Pks/IKXlTyfifrSWUG42Aw?=
 =?us-ascii?Q?KLMhywrsmk1c7EoNEN3I3tiWxYfeFIAJncsVEm9uQuC+K+OQJOyoFHXG1HiD?=
 =?us-ascii?Q?8E83dGa0YSh/7NLsz2UrDDLIS95aR2tAkA3nzdc5hA3du1AZGDQwij3EbX9q?=
 =?us-ascii?Q?q6AEYKiushKHMtzCgWd2jV6rXt6uat/4tg9b5lGgxVBoYECMTG5LpFo1tMO5?=
 =?us-ascii?Q?Vn7OhHZHlU+5RANTCVjOCp5GvQKVn2HnUNCqJuHYkaozzbbySA6PolU/9hDD?=
 =?us-ascii?Q?eZqvfuh6nF/GC9OnpwenQrZIKdJLn2N8jMdMBeAhNXfm5EoNdrP6Fl2sDRxj?=
 =?us-ascii?Q?C0U2kcgymyvsgbx/rGukGZIVSJuFq7sDV6g/8P3m8840977BHq+SbIRRm45r?=
 =?us-ascii?Q?mTrwjRnr5aSNjwgz85C43RfmclamQpkvaibHXiOMjchizEAz9+l5MBDOZCLe?=
 =?us-ascii?Q?2JrqxJl58b5QiRSNvEsbEsRENgg5IctTaUpltdWEsKTBhIyoZ0RHztpc7MEJ?=
 =?us-ascii?Q?i+tC5uweUZdysZpGgheLH/+NNKUZkwTtKGLTLpJRgOvB4Yl8KGxFq4Iy1Wr5?=
 =?us-ascii?Q?lerDDyr3sFQ5rD+ycLMWL87IXhfuW8CwY9wfKqQNWwSkNUuEvj6yJQFEyqHm?=
 =?us-ascii?Q?CR9wmNiVFA6tdtoj8B5dZl+Pq/S472U0nH2SY9J75C6Zm/TSZk6RVHr1MZNs?=
 =?us-ascii?Q?VrASCgvl0ULxwsKPTYJ6FSoqKtxaChq7JgT8+LU1kde3l9kZeJzMAZ7kjLub?=
 =?us-ascii?Q?Sj49brQw9LkUefS3cPSP5b4koRNXjnvxmdWBXYaChANMi23Xlr/OaD5sefMs?=
 =?us-ascii?Q?kC+V+f4Cpq611Ibh0eoHo7psiKSZTegenxalVGF1Bx3qneIZtNWpAbQwVG1e?=
 =?us-ascii?Q?WQgnzN9TGR20xW9JWNx8UpSs8GaBZHlPSuSGSPde6xUtjx09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c89fca-d6ee-49c4-68b4-08de64076a52
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 16:06:54.8154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IPNYLgq6umMRX1hHRf0mApkHogNIo8oLl3aevRH9W7lR9ltVMsDh3LQLUDAAIBbX6hZ31Okdon2D5HuU9+GzXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7486
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42094-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 4061FEA379
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 01:15:10PM +0200, Adrian Hunter wrote:
> Some platforms implement the MIPI I3C HCI Multi-Bus Instance capability,
> where a single parent device hosts multiple I3C controller instances.  In
> such designs, the parent - not the individual child instances - may need to
> coordinate runtime PM so that all controllers runtime PM callbacks are
> invoked in a controlled and synchronized manner.
>
> For example, if the parent enables IBI-wakeup when transitioning into a
> low-power state, every bus instance must remain able to receive IBIs up
> until that point.  This requires deferring the individual controllers'
> runtime suspend callbacks (which disable bus activity) until the parent
> decides it is safe for all instances to suspend together.
>
> To support this usage model:
>
>   * Add runtime PM and system PM callbacks in the PCI driver to invoke
>     the mipi-i3c-hci driver's runtime PM callbacks for each instance.
>
>   * Introduce a driver-data flag, control_instance_pm, which opts into
>     the new parent-managed PM behaviour.
>
>   * Ensure the callbacks are only used when the corresponding instance is
>     operational at suspend time.  This is reliable because the operational
>     state cannot change while the parent device is undergoing a PM
>     transition, and PCI always performs a runtime resume before system
>     suspend on current configurations, so that suspend and resume alternate
>     irrespective of whether it is runtime or system PM.
>
> By that means, parent-managed runtime PM coordination for multi-instance
> MIPI I3C HCI PCI devices is provided without altering existing behaviour on
> platforms that do not require it.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
...
> +
> +static int mipi_i3c_hci_pci_suspend(struct device *dev)
> +{
> +	struct mipi_i3c_hci_pci *hci = dev_get_drvdata(dev);
> +	struct mipi_i3c_hci_pci_pm_data pm_data = {};
> +	int ret;
> +
> +	if (!hci->info->control_instance_pm)
> +		return 0;
> +
> +	ret = device_for_each_child_reverse(dev, &pm_data, mipi_i3c_hci_pci_suspend_instance);
> +	if (ret) {
> +		if (ret == -EAGAIN || ret == -EBUSY)
> +			pm_runtime_mark_last_busy(&hci->pci->dev);

This should not neccessary, the runtime suspend API already call it now.

Frank

> +		for (int i = 0; i < pm_data.dev_cnt; i++)
> +			i3c_hci_rpm_resume(pm_data.dev[i]);
> +	}
> +
> +	return ret;
> +}
> +
> +static int mipi_i3c_hci_pci_resume(struct device *dev)
> +{
> +	struct mipi_i3c_hci_pci *hci = dev_get_drvdata(dev);
> +	struct mipi_i3c_hci_pci_pm_data pm_data = {};
> +	int ret;
> +
> +	if (!hci->info->control_instance_pm)
> +		return 0;
> +
> +	ret = device_for_each_child(dev, &pm_data, mipi_i3c_hci_pci_resume_instance);
> +	if (ret)
> +		for (int i = 0; i < pm_data.dev_cnt; i++)
> +			i3c_hci_rpm_suspend(pm_data.dev[i]);
> +
> +	return ret;
> +}
> +
>  static void mipi_i3c_hci_pci_rpm_allow(struct device *dev)
>  {
>  	pm_runtime_put(dev);
> @@ -323,6 +455,8 @@ static void mipi_i3c_hci_pci_remove(struct pci_dev *pci)
>
>  /* PM ops must exist for PCI to put a device to a low power state */
>  static const struct dev_pm_ops mipi_i3c_hci_pci_pm_ops = {
> +	RUNTIME_PM_OPS(mipi_i3c_hci_pci_suspend, mipi_i3c_hci_pci_resume, NULL)
> +	SYSTEM_SLEEP_PM_OPS(mipi_i3c_hci_pci_suspend, mipi_i3c_hci_pci_resume)
>  };
>
>  static const struct pci_device_id mipi_i3c_hci_pci_devices[] = {
> --
> 2.51.0
>

