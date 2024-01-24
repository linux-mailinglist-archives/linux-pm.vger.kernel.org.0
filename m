Return-Path: <linux-pm+bounces-2661-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A9183A60F
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 10:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13948B23204
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 09:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E7018045;
	Wed, 24 Jan 2024 09:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="OK8P2EEk";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="OK8P2EEk"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2055.outbound.protection.outlook.com [40.107.104.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6368818048
	for <linux-pm@vger.kernel.org>; Wed, 24 Jan 2024 09:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.55
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706090170; cv=fail; b=BH/ynAFwnz7gZXiy81gsok2/wEEJbQuHKa5LZ8oQLrUfFvjRnbojZS+SBpGYFHEOCPIiPx4ntwRl7Y2pQwmFnr/EmWeb6AaZyfOUDV4a+lKbpzcRszDb74gX121ak6O4QYqr+VaJjfkGGUEH4ivvJ1cAH3OljQ6m226tMGgGv9g=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706090170; c=relaxed/simple;
	bh=suK4HlWFMvSMMQjKD3Y1Zj5PeQOEQVWEsMdTb/qXMUc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MAi5LRDU31SJln/9mAcTW7yYUljJzP4xwBldsG9mX8iCi1O/J9M4e8rnLbNzP1aVGcMsLBPWDGzru1Hd8p8RdKVUjIGmIyRdYKA0FvCn4NJgN272O1PNB834/98ACoVGDsriwqW61JbiGW959VJe+pDkLgo/ab7I95Sj4hbIP74=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=OK8P2EEk; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=OK8P2EEk; arc=fail smtp.client-ip=40.107.104.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=mkJxcq8/Mqsj0/V8N3Jw6lsBAw1G+8i1OImiL0x8vtK4QaNOg7FZcPUzJGTaMT9nw3KXHoqpFO6YCI+0fDyTRivFJQz0PpTpLKSP+bk4dO1UPRqE1vfp9EI7Ej8AUDEbUpNuLCGb3K/c+vxW5WK5u2hvHaehp+TsTm1gOisirzl18G3nRhfjyaJnWgHUFLp0XpwEKf4mzK3TJLdVHCusEIlq0aEZubrB7zALKtpfWuNf31XNKtMT6usxuetLTEeha5KNABWbIZizs+NDmqFt2F1oGhq/llciqY/Nf937JnPVIuTC2St4ksLD3boS6cj0zxsM0Lp0a+uv02Yrw+olFg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNbU+8lcMthuHX6hiSFKL5rks4KjRb8SkhdrLwGCy4E=;
 b=mx7pyaJ4U9BTwCLduNYwW8ySy9Bczk3rJSjtqYfUXwqyYKajSoXMgPBbt3jUuYEEcvwyVRPreE4o/Tg3PElxihsbkgQZuoyFC1FM0eeX1G/aREaWqmt5/Epx5a9JUY7b1ZRXMADJsE1UohNwgG3TuMTAbbCELEbayy768tcvc519GHqmwiD92tSji0eHaBzUOtFN/rC6rlVRF76s4KZj0EkuVIoptOB/PWrYFn49Coyt6lBhv+J/+fD7ysywhZoEkFs6/CfKRdrqS6hhQ8zldqcstahiIh8cS6DSPShmH3UgyXy959ttu4RKBiJ/xtJtq3hEPqAEkNOoC1Ia+E92xQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNbU+8lcMthuHX6hiSFKL5rks4KjRb8SkhdrLwGCy4E=;
 b=OK8P2EEkscI6uWY7DZK4TNYFXCw+wD1FfggY2LWRwizBbdejtowxDbs4z0tkHz7ZsUB1aWPvrmsClVmsZ/RPCNmCyM0RsN3GsD1crEYfH/xSLi6WG8aWmfJhMyAsenL42E8sNxqVU8fnWhNnnQUmftCKrcy110GpeDxgBzUWDOU=
Received: from AM8P189CA0002.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::7)
 by PAXPR08MB6368.eurprd08.prod.outlook.com (2603:10a6:102:159::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 09:56:04 +0000
Received: from AM3PEPF0000A79C.eurprd04.prod.outlook.com
 (2603:10a6:20b:218:cafe::5c) by AM8P189CA0002.outlook.office365.com
 (2603:10a6:20b:218::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Wed, 24 Jan 2024 09:56:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM3PEPF0000A79C.mail.protection.outlook.com (10.167.16.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Wed, 24 Jan 2024 09:56:03 +0000
Received: ("Tessian outbound 67699c3f02bc:v228"); Wed, 24 Jan 2024 09:56:03 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 019d2fc682d22517
X-CR-MTA-TID: 64aa7808
Received: from 96f92101ff4f.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id C0200B95-8F40-4863-A4AF-1C57085BFEB2.1;
	Wed, 24 Jan 2024 09:55:57 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 96f92101ff4f.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 24 Jan 2024 09:55:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXmU6it/sTiobf0RU4vtDyg0bP4KDcjvscayy50NEIM+1jmwPC4TknoJFdaTZY+IiBT6zi4BULcl0r39lhDpqQ867sJEL56Jb6hSaNtTlsKWLSneLSTFisRCp5hr23dNXwtSEmyN0ZInmD7pmJXg5Eu9ejoGlIt7aZIl7a1C3XFzxo0hUpnNThNuUx5jAco6bR8EffC8BVOYwWm8ZUvMZ9kbEqg5Q7/uaH3mMPaXBFYOMOpoiLUzSsQQP3SB+GTTAzK9ELYqByvZcGx1WxcAVikPVSy6OawNpwH9nhlVsV6lW4LAWbgAZxIiuYTGSrNkEgDmAB6J2TeL3g725a7PAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNbU+8lcMthuHX6hiSFKL5rks4KjRb8SkhdrLwGCy4E=;
 b=DLXN6aVD0qh6/fa+6ediMq06+7vLFVFPp5dMFkI9gKczTANmqaJBPZExuIMmc50Ywhi7DUtXk9pb3faeHf0fzMDqqx9qla5xDXVmErfwZTOO13HsA+ld5liHYidO9+OzwxXm9+mgWcxdlYGYXHi+8cWBN8YMw4OduB7xIDUxRpfg0lVcCYbXVncdgiIWO4j/i1IWKFowINV04zd1Pxf33T/d627qs8aFRX72g/bydLMcvDK4X/boSdIpJWtirWe5BE+zR1OnNTIrxpO89NPLdvSqYKkE3hDR3Ow0c4Ld0XKTdzcgjpV1+veEDZqlwSwUNspnS9u13lyOHdmcxgoLfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNbU+8lcMthuHX6hiSFKL5rks4KjRb8SkhdrLwGCy4E=;
 b=OK8P2EEkscI6uWY7DZK4TNYFXCw+wD1FfggY2LWRwizBbdejtowxDbs4z0tkHz7ZsUB1aWPvrmsClVmsZ/RPCNmCyM0RsN3GsD1crEYfH/xSLi6WG8aWmfJhMyAsenL42E8sNxqVU8fnWhNnnQUmftCKrcy110GpeDxgBzUWDOU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VE1PR08MB4768.eurprd08.prod.outlook.com (2603:10a6:802:ab::22)
 by VI1PR08MB10298.eurprd08.prod.outlook.com (2603:10a6:800:1be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 09:55:55 +0000
Received: from VE1PR08MB4768.eurprd08.prod.outlook.com
 ([fe80::5c98:7294:1307:4796]) by VE1PR08MB4768.eurprd08.prod.outlook.com
 ([fe80::5c98:7294:1307:4796%4]) with mapi id 15.20.7202.031; Wed, 24 Jan 2024
 09:55:54 +0000
Message-ID: <aaf6ee71-6177-43aa-a01f-183ef35e77a1@arm.com>
Date: Wed, 24 Jan 2024 09:55:52 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: Using scmi performance domains and scmi power domains together
Content-Language: en-US
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, nd <nd@arm.com>,
 Vishnu Banavath <Vishnu.Banavath@arm.com>,
 Florent Tomasin <Florent.Tomasin@arm.com>,
 Cristian Marussi <cristian.marussi@arm.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <VE1PR08MB476848A0895993EAC92AF77B91752@VE1PR08MB4768.eurprd08.prod.outlook.com>
 <Za-WCHwfpf7dXJ1Z@bogus>
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <Za-WCHwfpf7dXJ1Z@bogus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0432.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::23) To VE1PR08MB4768.eurprd08.prod.outlook.com
 (2603:10a6:802:ab::22)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VE1PR08MB4768:EE_|VI1PR08MB10298:EE_|AM3PEPF0000A79C:EE_|PAXPR08MB6368:EE_
X-MS-Office365-Filtering-Correlation-Id: 367bc5c8-c72f-472a-5ab2-08dc1cc2ad74
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 /cmz0GU3D34ZXU7QJehpkdtkxdCIM35RMzc6lxBgMsJeT7hA2mDqEjlxweq4ooLa4tPkZ6X3sZPnzD0Z938FhHgdFkvhXsj94mnVokNtXTBFm6t2OEEwVaxTrtKCPaBnJwGgI0IiM8Wi46rn8Cxoo1dS/v3eg9COy94XcJAh7Iq5p/gZ/imPNavz8nNtSuzxQAp0/sItr4DxnzpVa5K6GxiXq+cHCOvbZLVT5hRuCfw9LRjUrKysuiNzJcfbhSvvxjrhBhwec/wZmx0C9vbqc1v0G5sUmFFGnlywdgtyhtXdjDOoBSmFbG1B7OrAjBIsX8A1+DLp0rZKSjsDxoefkho7s258G97FMwOeMH2NHr+Wrset5ZvI1E5Z3lo2z4DVmYC4iMFqOUR4F4sICH+Vd2HdpwfkEliKVqXe8tAO768yt7H2oBzt7aq95mk5jcITc8W4xx8zIRxeHwO/PZgT58T8YkSKtpDV30kYdEzA1ABRYJx0RUzOJzEUFQMpDNEtaf4bT1Ui8Mr91PE9H+BMCGivdHGerll8myeGhqPQBigFTOIBkTlAD4zzUcVOChv5kspt/jQpDEnMdFMOjc7Bk7KHUjlVU2Hz2NGBM0+cI0/Lb/SMrGuV6+peGJAPPlsf2/sJwO0YAqyoO+OnPtJUvQ==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4768.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(6512007)(6506007)(54906003)(53546011)(66946007)(316002)(6636002)(38100700002)(6862004)(4326008)(6486002)(44832011)(8936002)(8676002)(478600001)(26005)(2906002)(2616005)(5660300002)(66556008)(37006003)(66476007)(31686004)(83380400001)(31696002)(86362001)(36756003)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10298
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A79C.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	6b969f6c-f717-448a-ccfb-08dc1cc2a7e5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6p/NiCSvRi62bGJKP27HHg7GQyInqZoFIZNoD16Bz56n6mcHU+nen9BaEiYInDUFFLW3uuA6g6FtYJOjxBXK8X9XdJK8fikCod5rrIZmim2mxceEbi7Wa70RcHtuRmmJxMzdUlWgs9j67azj9GQBDNstfSGN010Q/lE7+iihkj1i9PewMqKlMXSJ6ddKh/ONqQqFdtkLg/ePUDutP5xmUXleiqCOrjbALvmqFrEEeBUrfRHLuzPAIbWUzQP0zqFmSsBCzwraEFHcQFDWjPCrF3Xz4lLKS+/yYFpGG+Vw/mNB0HUYi5fSoBfNw3M0q1wyHDTinYftb7I9Kmttl/6wklduNhfvvBBD7f6//HIhfp6BMSPBuSr3f+ry/IE2xvegiaeDUO7zhG1zt1rg4FTVza+z3wwWmC0cT5V3XBxNmrn/gKe8lbYeZdHYMsAO4VZkFODEU68IzpY6xTWWuU8ghoNtZyNfxx3DYG6fMpJaVc2M8JdU57Ia0LKsRnzA6YGZ5nSfolT+wYNNv3zBPIkoqwRHTnxoVmEKyRLGoMjSWd0z80CxO9RyhUOSNFq+t+t8j84WwACAykjOTg0yF9IJPuf2zKiR4+Td0StNqkF8dPG6X9HvJBY6wVxnh1SpX4BKK2WnpdSh/2G9bbJSreOgBm0/Izqr9MMBbTbsCGMU5q24jAbIeJcz7qA64X3VhcU0A2R8fDVKi4mYoqYiHAP+3DFE5qULKzH3i1Jlrq8dMBLlCb2LGv3GSVC2uKGU1YJOAwfCuBTz6oR5wkz0M3V6Sg==
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(82310400011)(46966006)(36840700001)(40470700004)(8676002)(6862004)(44832011)(4326008)(40460700003)(40480700001)(8936002)(81166007)(478600001)(41300700001)(31686004)(83380400001)(36756003)(336012)(70586007)(70206006)(37006003)(26005)(2616005)(6636002)(54906003)(316002)(86362001)(36860700001)(31696002)(6506007)(6512007)(2906002)(6486002)(356005)(82740400003)(5660300002)(53546011)(47076005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 09:56:03.7522
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 367bc5c8-c72f-472a-5ab2-08dc1cc2ad74
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A79C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6368


On 1/23/24 10:33, Sudeep Holla wrote:
> (+ Cristian)
>
> On Mon, Jan 22, 2024 at 08:27:03PM +0000, Ben Horgan wrote:
>> Hi,
>>
>> I've been looking at adding support in total compute, an arm reference
>> platform, to control the gpu operating points and gpu power on/off via scmi.
>> This was previously done for the juno platform but involved hacks. I would
>> like to make sure this is cleaner going forward.
>>
>> For device driver simplicity it would be good if a device with a single
>> power domain and a single performance domain could just use a single PM
>> domain.
> Do you have any other technical reason for this other than simplicity ?
> We can't always have to so simple when managing to support wide variety
> of platforms with standards like SCMI.
>
> You need to justify why it is hard for the driver if there are 2 genpd
> domains associated with a device(power and perf genpds).
>
>> Using a single PM domain means this can be on the platform device
>> and you don't need to create virtual devices. The drivers scmi_pm_domain and
>> scmi_perf_domain both initialize a separate 'struct generic_pm_domain genpd'
>> for each of the corresponding scmi domains. Possibly, there could be some
>> way to bring these together under a single genpd domain. Possible options
>> are:
>>
>> A. Parent power domains with a helper driver that just uses an empty genpd
>> domain as the child of both the genpd performance domain and the genpd power
>> domain.
>> B. Combine the scmi_pm_domain and scmi_perf_domain driver and create a
>> 'struct generic_pm_domain genpd' for every pair of power domain and
>> performance domain.
> This is purely software implementation and expect no change in the firmware
> (DT) representation of these domains and association with the device.
>
>> C. Combine the scmi_pm_domain and scmi_perf_domain driver but only create
>> the 'struct generic_pm_domain genpd' for the power domain combinations that
>> are used.
> Not possible unless the specification assures the power domain and the
> performance domain IDs match.
>
>> D. Keep things as they are and use separate PM domains for performance and
>> power when using scmi.
> +1, it was designed this way to ensure it addresses all the possible
> implementations using SCMI.
>
>> Examples of possible ways of expressing these options in the device tree,
>> the scmi performance domain is 3 and the scmi power domain is 8.
>>
>> A.
>>
>> scmi_devpd: protocol@11 {
>>          reg = <0x11>;
>>          #power-domain-cells = <1>;
>> };
>>
>> scmi_dvfs: protocol@13 {
>>          reg = <0x13>;
>>          #power-domain-cells = <1>;
>> };
>>
>> perf_and_performance: perf_and_performance {
>>          power-domain-names = "perf", "power";
>>          power-domain = <&scmi_dvfs 3>, <&scmi_devpd 8>;
>> };
>>
>> my_device : my_device  {
>>          power-domain = <&perf_and_performance>
>> };
>>
> NACK as I mentioned, we need to keep DT representation as minimal as
> possible, adding nodes for this virtual domain is a no go IMO. Just
> use the existing binding to create this virtual genpd at which point you
> may realise handling 2 genpd in the driver may not be so hard 😄.

My motivation here is simply trying to avoid having hacky custom changes 
for our platform in either linux or any other drivers. I started looking 
at this before the recent changes to make using the scmi perf domain 
from linux for devices proper and was under the misapprehension that 
there was even more work to be done to make this even better. Naively, I 
thought as a platform device driver can work with a single power domain 
using either the scmi_perf_domain driver or the scmi_power_domain driver 
and they use separate callbacks that a way to use them together was in 
the works. Getting a NACK on this means that I now know that the missing 
piece is in the driver and we can get the work done there.

>
>> B. Combine on every pair
>>
>> scmi_pm_perf: protocol@11_13 {
>>          reg = <0x11>, <0x13>;
>>          #power-domain-cells = <2>;
>> };
>>
>> my_device : my_device {
>>          power-domain = <&scmi_pm_perf 8 3>
>> };
>>
> Again big fat NACK as above. No change in the binding to make it confusing.
>
>> C. Combine on used pairs
>>
>> scmi_pm_perf: protocol@11_13 {
>>          reg = <0x11>, <0x13>;
>>          #power-domain-cells = <2>;
>>         used-domains = <8, 3>, <9, 4>;
>> };
>>
>> my_device : my_device {
>>          power-domain = <&scmi_pm_perf 8 3>
>> };
>>
> At this point I give up and will just say I would expect no change in the
> DT bindings to achieve whatever you are terming as "simple" here. We are
> not going to add any bindings to make it easy or simple for OS to implement
> it's policy.
>
>> It seems wasteful that the scmi_pm_domain sets up and makes scmi calls for
>> all possibly usable domains at start up even those that aren't controllable
>> by linux. E.g. cpus may use scmi power domain controlled via psci.
>>
>
> Not an OS issue. If the power domain is purely controlled by PSCI agent, why
> is it even present to OS as SCMI power domain. We have examples where it
> is correctly presented as PSCI power domain. So this issue doesn't exist,
> fix the SCMI platform firmware. It needs to present per agent view correctly
> and not present a global system view to all the agents.
Good to know. I will get this fixed in our platform.
>
> Unless I hear strong technical reasons to this approach other than simplicity,
> I am inclined towards opposing this proposal.
>

