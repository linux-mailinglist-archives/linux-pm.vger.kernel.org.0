Return-Path: <linux-pm+bounces-43421-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPOPBT6UpWnXEAYAu9opvQ
	(envelope-from <linux-pm+bounces-43421-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 14:44:30 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F101DA025
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 14:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E788A3019476
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 13:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359943E0C49;
	Mon,  2 Mar 2026 13:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="hTsfgut8"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012051.outbound.protection.outlook.com [52.101.66.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7A736C9D0;
	Mon,  2 Mar 2026 13:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772459067; cv=fail; b=ffR558fsAmp0WctdmVRv4J8MB/4ucfcYTGRxLLqBRMlotmw0UD10CVjaKwC2S7+Y6lo7YVUKaZelnRtLjfCUn2XWm7NaEoVsCI2npOoYDnpoEFvUem/XXO7wP16CLXKgKRIb+5Ynkxdt1BI3FgXhZG3K1G4RMjnKJvmpeGaxslY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772459067; c=relaxed/simple;
	bh=zzwmvuc3tuFF1xmmxr0EP4trFgSxy8d1jmLOK+UJ0SA=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qf9UT3t48ASCyXnrHqiOaiS0qbPyFLv7E49Gc59ODNTQ2ycer13kxSsS3uK9+FqPFAhaCjif9LMsXxdI9pQBHjrf2eeL3FM9mnNRWiqw92sEFb8uFWXhpq43nFeTNTvNs2efB7UiE7nz/MHeSdB3g5huCsBfiNmCPFqyTg4hI5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=hTsfgut8; arc=fail smtp.client-ip=52.101.66.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kra9JkECajwZUctfYwS0WgVZ9icE6d1hnmUDGXrPsF4h9sx/kYGFjJAQ3kJVMmyxaYWpVDQdn0m38IGuDigGdr3sAmvK0uyLk5hKSHkTsPVGE81F+nAF2WOvadokbE1jOC+Ms4h7K0Giv54PsqhL6g4AGw5ziJIZpNoWnO6qFBeam9zosU3zVJ53qaDrt9HW1SWMliUXh2/fWqGeloYCi81sK+vGzFvmOkfReh+jSx9SwfrcDKdkzAkKYiIlyX6pnF2iW2Ziyam6WumCkj5epyQOZu5bj4QxHdsKPKVaqsU6sDTV+6tHrPoLfsb9Q5Hn3zyvEIXBQPD02S8R62NRFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+J9Uc/yms6A5wwaCm60MJAQvQTNwB315gCmLz+FqcA4=;
 b=B+vOCQcqmymGZxgCVcrg1SSpi8+pnqOVwKE0ow/GcSHk5ErVkfPfsP/Ad/cfPJmp9RlUXrd0Rc1oeW09ZYp0pZTJEYbjn9ettncHG7ZeXjNnocRS32GjUPv2Aww9atQiebwBKrQZoqld3QXayZg+Czj5X/21ijcP3ESjbgGGtbQc8dVfJ7VZspfYZSVDNJpEJF4zsNLvLrwIeope7Ex41o9AqUTntX0dIHTR2mliwI+GfPtBQc8i79WdIo4xCKmwbhRyyYMJd527iqKI7mNDjlLMGlUOuUYMwB5WR5jS6P2YR1QY3bgAFsida8eltBqRl8NqGIdpBlXYv8TFcQE3EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+J9Uc/yms6A5wwaCm60MJAQvQTNwB315gCmLz+FqcA4=;
 b=hTsfgut8o1qf6xOjFZsa3YuBdH07/aY95y1rxKq1ePQjBtcyreoUXvhvA/rcDBtpHV3nfuNdJz1wdsvg6ba5q24O8aYYu7jExoVDuyerjwdt02HtRUDCWMwATi63Zr/h6RavAZQNCOEpEu9iI1mCZRPtSd7UQg4d6XKkSueKAZk=
Received: from AM6P193CA0068.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:8e::45)
 by PR3PR02MB6219.eurprd02.prod.outlook.com (2603:10a6:102:74::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 13:44:21 +0000
Received: from AM2PEPF0001C715.eurprd05.prod.outlook.com
 (2603:10a6:209:8e:cafe::12) by AM6P193CA0068.outlook.office365.com
 (2603:10a6:209:8e::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.18 via Frontend Transport; Mon,
 2 Mar 2026 13:44:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM2PEPF0001C715.mail.protection.outlook.com (10.167.16.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 13:44:20 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Mon, 2 Mar
 2026 14:44:19 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Conor Dooley <conor@kernel.org>
CC: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<kernel@axis.com>, <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] dt-bindings: power: supply: Add TI BQ25630 charger
In-Reply-To: <20260227-percolate-armful-ac15f947b2ff@spud> (Conor Dooley's
	message of "Fri, 27 Feb 2026 17:31:06 +0000")
References: <cover.1772201049.git.waqar.hameed@axis.com>
	<65f55d19b4bcf8f07300df5922ba1605bb669138.1772201049.git.waqar.hameed@axis.com>
	<20260227-percolate-armful-ac15f947b2ff@spud>
User-Agent: a.out
Date: Mon, 2 Mar 2026 14:44:19 +0100
Message-ID: <pnd8qcawdl8.a.out@axis.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail10w.axis.com (10.20.40.10) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C715:EE_|PR3PR02MB6219:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ac7e6ff-6c29-4e36-a1bc-08de7861ce90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	S989OxN4fdE5+pr3S+LUFsVhbwI23IhOAzwrpp2zwI8nCcdXahz+wkzDTF+FRqEgMr9/HUcnOLmqwaTRXJu+yoIKDh3JZt+MUB2USyI4cqpBaH5f/oLsYf1EVqjTz2+zM3vD+GiGXpbg7ynNTHurJ+XYjpAP3hh1AHR9v9aWmQPB+UirRxZxrWN2QNIyasxx8vsQvpSTs1CxkiWiLDPAUvT8bIC2zQCPT5CgUXoGOtS2n3IcbNk3roPZee8QfIEHl6OFcDD1UZOfW97qyKGurZQQ8AupLCdDavMjVT+1VB/9zuRDDNW+8eherWY/UQaMY6fpXFt9ryYG43lUEBoB0EAKagoacdxJ4RbE0iRgavDdMjX+malQMiqpUrZItlkkvqKSmsSAZZJe0yuCw7ldiNftxkNM4o8KSmp4pmguHe1qkcix3fKOUn628edZ1BRpws8+g2yX9cIOY8dcKxHeo85phMlX8TTAIWRY0d7EyxiBlCKiMmqxOf4tfRvZ1voxnAUX/wwhvupJDohRCRPk7sWtqnpGUFoeIOfVaQtIFRpd1jommkqm/l7Ag+atfjWvdSrCjxyM6EcsTdHQ8osnL8dmkRshylaEUUl/iO9ZeBLOlBnwPsYTCjrhzJa7MDnpF+LR3IKzSn0NuYVr0UbFypjIIQAlWWgxhKKENiKt00SwDRhRG7/UqurI6W0/AhkanGHHB5yZiMPJBE7QFOVmvGLcoQ7rtNka7N6utSqD972IR71b34NEgTk6wMfV/m1K/Lf1V6zeA5TNE5c3ZO/16e5OtVpyjNdo1fJQgiJ2ZdnaSFojvQpEYKtIb+QwA+CALHgxMrcr8wXNriYFjX2bFA==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Z29lVJq191eZ7+o+zxGU77EPALBL09e3Cvhgryo3SpnlLRpHhIEz7PR7m3iXM5iqoFanFA5fmefPWLZenvVnysrjBgbWOMq/aysIPa3xYCgGJnwFlx79VO8C51R7Sh8gcsWDRxru5HNeQF3IxBfa7W7Tth2FWD0t4DmuwA0L8QVsRitjAT2s/DMPT1Et13rPWyX4Xc/2u+kRxGDq2WbflNoQYMLT0CJt7mc/JqGLFR94KMMRmReSTpB5BIw4fZF7DOzliCKYtgQDh0brfzr0odN3hB5W/fub+oR3WlsdLeL6xjcwwI35etQbdLUD181qz/LeN5TrfaVnzY9hwABibCIX9ce+ExoTv+JJTMth3iq2iA5hDlTHJDoblMYqtgGV7ofRvaYydlo8QEe3Oq2vC2+bns9ND50HOvVGZVLbs60JU1WwFa0H/CRoZWa+56u9
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 13:44:20.5543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac7e6ff-6c29-4e36-a1bc-08de7861ce90
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C715.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR02MB6219
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.35 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[axis.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[axis.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43421-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[axis.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[waqar.hameed@axis.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A9F101DA025
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 17:31 +0000 Conor Dooley <conor@kernel.org> wrote:

> On Fri, Feb 27, 2026 at 04:35:33PM +0100, Waqar Hameed wrote:
>> Add devicetree bindings for the TI BQ25630 battery charger. It's I2C
>> controlled and sends interrupts.
>> 
>> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
>> ---
>>  .../bindings/power/supply/bq25630.yaml        | 68 +++++++++++++++++++
>>  1 file changed, 68 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/supply/bq25630.yaml
>> 
>> diff --git a/Documentation/devicetree/bindings/power/supply/bq25630.yaml b/Documentation/devicetree/bindings/power/supply/bq25630.yaml
>> new file mode 100644
>> index 0000000000000..57e4286dac7e9
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/supply/bq25630.yaml
>
> Filename is missing "ti," to match the compatible.

The majority of TI devices in this folder do not contain the `ti,`
prefix, so I just followed that. But I'll make sure to add it in the
next version then!

[...]

>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +    bat: battery {
>> +        compatible = "simple-battery";
>> +        voltage-min-design-microvolt = <1800000>;
>> +        constant-charge-current-max-microamp = <1344000>;
>> +        constant-charge-voltage-max-microvolt = <3700000>;
>> +        charge-term-current-microamp = <128000>;
>> +        precharge-current-microamp = <1000000>;
>> +    };
>
> This whole battery node can go, 

Alright, will remove in the next version!

> the tooling will falsify the phandle.

I'm guessing you mean that when extracting the example, the insertion of
`/plugin/` to the `*.example.dts`-file will "falsify the phandle"?

There are some other examples in this folder that include this node. Not
sure if it's worth the churn to fix those as well to help the next
person?

[...]


