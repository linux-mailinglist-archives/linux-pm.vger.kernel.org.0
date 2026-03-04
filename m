Return-Path: <linux-pm+bounces-43585-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBH+C4VeqGmZtgAAu9opvQ
	(envelope-from <linux-pm+bounces-43585-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 17:32:05 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 834F72044E3
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 17:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AC0B30179D9
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 16:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740C435E923;
	Wed,  4 Mar 2026 16:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="KvyMhbpy"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011000.outbound.protection.outlook.com [52.101.70.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220C235DA75;
	Wed,  4 Mar 2026 16:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772641013; cv=fail; b=oMCpAFILT8hOcQh03WYrHl7hy/NvhOH7H+nB8crd3lStpR44c2aVopNEq2t9OmHZFV0GUliyinf9nxlQiDY28oRC1LksVeubtyYkdgzLC2spItHBs5BPxXSwPxo0ltndDtThZ3J+u40mrLjJkuZg1g754vatJydTQWTNmzA2xbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772641013; c=relaxed/simple;
	bh=my2TcbKi2tN/bQ1wSewYiM5CSbqYL6cCxjvCcsvFhqk=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ULVS1+N5hewP9F4UeLxZcVAIVSJPcNh5qE/bhvrKZt3ISXr5KguebnQbvcFdVZQlE0vSTAocP4xBwjH4JW6bAUyXXQ6Etmatj2kEKDJbcQsDvTht9wpPQ/91MtoVV37BUEygRiljyEaP3/K3jMLO+66MrDzEqJ8g6uSfsKncb/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=KvyMhbpy; arc=fail smtp.client-ip=52.101.70.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQNjkn4tjqNxMpHjEU68+DS44vfkFzKh1zfGTcNcRACJEI+dmZthd9P3S6irWhSovZlD2+jrFXliW1Ap/5TjEtS9lInAWqd98s9D5Bz658nwtJMBnZUMf3g0i8JRmvtpul2aWZvA3JssTxnDhGeBSHWyIRhGLzH8kWUVGr5sFSaxcT3vDJv9As4moNSmI0XjNPeC33mDquaAq0FPTxZwKh6faUJFPEnMUstS0KfjkRm6tBrjzRYO/RErNGoasert9RhdNrW4fzZJlF96IFZEQxk0f5tCUd4mNAvjN+ZdLuggyPlC0uEezIC+OMN12RpEBKyPf+0IlrxI2HJgnDP6aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=my2TcbKi2tN/bQ1wSewYiM5CSbqYL6cCxjvCcsvFhqk=;
 b=KaPeBtAwmwnyBQ+cdEORUssrF4Te8yvW03/MerzyHzipHzseF3W5mbBhqIhjNDuibs063XTSdIdIZf4IyhjL3pKVA1q8fdnHZEZyf1UNTpjLuLaznJYm/tWw6YCSMm6oS/tGfa0VKD2XSimH4nUraxNB5wQ4loCcPdD6EbIk9xubxAzkdiwY5dkWnfqT2f7wyFPgHNCQkPtzI98MnLuBIen8+uL1YHfEhRq+Kbxr26aELpbLThNW8/xCWD7kHIGSc5cL8K/287oT27hYHBetlxIigpgT68w2oxjfFVzUcygJK+8f7HSFylDhnqk6LS1fjPGDkFZFc8mVm9dgYZMJgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=my2TcbKi2tN/bQ1wSewYiM5CSbqYL6cCxjvCcsvFhqk=;
 b=KvyMhbpy6ARgWuzG/Cni793xb3V0kCAIbpeEhCDCwYvca6z63RXqvBp0Aw85qm8ISa5ajFyn6q24atJulHIqag9Br9mFpiGoCSVygfYDKpfe0Gz2W5BDYtD8fC7L5jzJakAs9Qz86O2CHc1bVtX4Jm0h6aBljLa2wMgb9ZvDSNU=
Received: from DB7PR05CA0003.eurprd05.prod.outlook.com (2603:10a6:10:36::16)
 by DB9PR02MB6905.eurprd02.prod.outlook.com (2603:10a6:10:1ff::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 16:16:47 +0000
Received: from DU6PEPF00009526.eurprd02.prod.outlook.com
 (2603:10a6:10:36:cafe::fc) by DB7PR05CA0003.outlook.office365.com
 (2603:10a6:10:36::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Wed,
 4 Mar 2026 16:16:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF00009526.mail.protection.outlook.com (10.167.8.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 4 Mar 2026 16:16:47 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Wed, 4 Mar
 2026 17:16:46 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Conor Dooley <conor@kernel.org>
CC: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<kernel@axis.com>, <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] dt-bindings: power: supply: Add TI BQ25630 charger
In-Reply-To: <20260302-removing-fidgeting-ea8909e3f407@spud> (Conor Dooley's
	message of "Mon, 2 Mar 2026 17:47:41 +0000")
References: <cover.1772201049.git.waqar.hameed@axis.com>
	<65f55d19b4bcf8f07300df5922ba1605bb669138.1772201049.git.waqar.hameed@axis.com>
	<20260227-percolate-armful-ac15f947b2ff@spud> <pnd8qcawdl8.a.out@axis.com>
	<20260302-removing-fidgeting-ea8909e3f407@spud>
User-Agent: a.out
Date: Wed, 4 Mar 2026 17:16:46 +0100
Message-ID: <pndldg7a7td.a.out@axis.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail11w.axis.com (10.20.40.11) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009526:EE_|DB9PR02MB6905:EE_
X-MS-Office365-Filtering-Correlation-Id: c2eb4c53-f110-423d-5886-08de7a096f74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016;
X-Microsoft-Antispam-Message-Info:
	C55jMfL+nJoDJbpd/KgxKwuXiXzmp/EhWgrF6x8QkauwDhQkw0YSwJ94af0s1vRLT6uShBcOHBSg2DjDhi3hY29cnKP3BIoeXYelVJ+JyLEmKKYOS2jQWrwLxa1BTUQ+N9qhgFiQssC1T+2FvrbnZujakkDoeOtQj/ZDddSkk36qXmYN7T01FAMgbN1TXQQXfl1f8CY/nJiv/xp/L9Ebj6hzHo+aftsxXVSZ/Kwz20AgDsReG5+LLVacPG/JyQNHYNo57AvebUBERoo/wymkVBhICnH5HCmjrbRxQx2rvTZ4ai24qVjSZ06jBZyeajPBaBj/D3BHKJYpwrBdp4sgB56bteiq6g+wgfdVpyy39C1xNK2RdQ85Ph/2gKXPQUIt6gLTohiH2rduL4OWWWleeb7ED5wa3U375iepPEJttaUvgSjcCncihuFSRJaMl2Xos7iC9IM+w5leQh2EEdO5UwmXemtWqlPN3eBwgA3jFivgTSZZYjHmVM1+aKY0vBeq5Ua/HNarRc4bWCp+K5wKamVQBbZPwLg/j8/md077oGkF/R8AMd8qRm5tSMmqiQkcuZweZ5A82Dp/ART0Hz7Ysz/vCjBeM3ssTwWVgR7UGYWUkTss3CTSfX9MVhJPv7VfeNetOp9HWjbvh3ueIC/6pRgX028uZqNDUGrDpPqXyR1xsSUMMAO79Q2p/v9DsyI/ku817b5vXjof4nY03bMBtqgPMZ+zq63qEmrlHqOLElV83rD5k/O7XGqmYGrxZD1Hr4w2SJekNlJSdbmkt01Jug==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JNGuigdAJBJSZi2oi3Fwg18DX/yNDKasFZ/c0Rwg1sjDl8ew5wxUSvfEr5Tx55l5wCW8T/Xe18HRokR6sij6TneCwqxi0rWEerFZHFkOaAb4rneccOP/R+YHJUwjdXgus5Lm1GeLBakjlvRP4u1T9r4Vfew46rd52ggY30AkPe5WripK7WRWzM9ZIVIL5xJcj6nIm4DviWIKeHDme2H6T4itrZBkIowRlSujVYEGQ6AJv919hKXPkBOLumn4d2tEA7YEQ2PUfuI1IJMVg8vh5jtVo5XBR0QHC+tP26evB86F/ZVBkMRYsvLGS7XHCX84h9hgmJ1XvyNs8JoFC6FOznULleVarUzMorW8MgK+6Me7nu8m3NoI+T5GmW/wFBOExw3ZtIAfrEJZ8Eh8qoZfZtALoq4AGZh3ZtVTBuwMC/En2CwskZ3lW6cKezBSPBAQ
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 16:16:47.5878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2eb4c53-f110-423d-5886-08de7a096f74
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009526.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6905
X-Rspamd-Queue-Id: 834F72044E3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.35 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[axis.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[axis.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43585-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[axis.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[waqar.hameed@axis.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 17:47 +0000 Conor Dooley <conor@kernel.org> wrote:

> On Mon, Mar 02, 2026 at 02:44:19PM +0100, Waqar Hameed wrote:

[...]

>> I'm guessing you mean that when extracting the example, the insertion of
>> `/plugin/` to the `*.example.dts`-file will "falsify the phandle"?
>
> I'll be honest, I don't know exactly what the mechanism is that fakes
> the phandles, but it means that any sort of generic device doesn't need
> to be included in the example.

Haha alright. I appreciate the honesty :)

I'll stick to my explanation for now then, since it makes sense for me
at least (someone otherwise please correct me).

>
>> There are some other examples in this folder that include this node. Not
>> sure if it's worth the churn to fix those as well to help the next
>> person?
>
> Probably isn't worth the churn /shrug

Alright, let's leave it then.

