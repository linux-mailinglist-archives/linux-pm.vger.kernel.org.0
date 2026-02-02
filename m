Return-Path: <linux-pm+bounces-41918-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGWnI+bfgGleCAMAu9opvQ
	(envelope-from <linux-pm+bounces-41918-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 18:33:26 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 047C9CFA17
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 18:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55DFC303748A
	for <lists+linux-pm@lfdr.de>; Mon,  2 Feb 2026 17:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19A4284895;
	Mon,  2 Feb 2026 17:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wfo10TCL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cCnK6+H4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8635F26738D;
	Mon,  2 Feb 2026 17:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770053500; cv=fail; b=dZrfT0MTlVaDMmjnrDxUpp3Fes0TOXgAErmBZ3vegPBPBTstjSdddfC6galmhhSKBulO2fm5Kl6VOwR4aN2EtiEAFLYx4yhVQpkf+SgZhdFxvEW6QsT4lvnzg6eAnZBCE6Q97P14lhwZToHwrwRR9nlCofdQg+w5g5Txo7GY4L4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770053500; c=relaxed/simple;
	bh=xh9HubVN1YKIkrATIH3cWHtp05fx9gv9Z7uGdrhjll8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Kdy7wrX/kw21mdJ021UWTwHjMfd+i5eyw63QCFCFx9sGvZ26GwlaaBmcxrCwXw1n1GR93q6UzNVmd0tAojQCOr++cr0E3A7BwABvFnNpCX7boxR++BQWOnp9eqT9bqYraT/VzS9iOxOu/TjxG/sbtsaCdLa7X6OYhgEgg6REktw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Wfo10TCL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cCnK6+H4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6128uSJP769181;
	Mon, 2 Feb 2026 17:31:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=W99EVfC0j++9B61AeedWoX6+A2ypQCNlCofvHFnMUG8=; b=
	Wfo10TCLrXfN7sZx5ESAojCoIj5N6pY0L9QYqOWNjekLdDvoCUv0O/HGwFIi6e3M
	c3ZXw7ZbKzChPGv6DkZOpyEoBxcdeiOTz2PTZS6VRyxkx022yyC9F63xMbjbTF/8
	Q3AGdxFUWaA5rgqTIzBG+TopzCq8IFWNMCxM8dkG1HfHbCUnU9u3dvIPTcNWGP2d
	s8+jfjl8QI6E1K+vuy1d58WS/4DSkZltf4B6z5p94Uw79NzFdAf9KpFmadeiydWr
	a0ROnfGj3D5FVPBjT9Rt78+K2ilILiYBv1cvNvAfZ8WJUCtKUVeiGmukdT36Lbq8
	YR/u+HBHttW3s/rm8VCuxw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c1atajp5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Feb 2026 17:31:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 612H4WvC034779;
	Mon, 2 Feb 2026 17:31:28 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012056.outbound.protection.outlook.com [40.107.209.56])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c1868pmch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Feb 2026 17:31:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F64AdIi68jow02gJJ4hRZdCy8ZKNYxzBg9LCsil1l04sr6RcQnLMIYiZe7itzH1ZdTPPSpP9983nd3Kbocfx6p0ZCEhRMGSCyMVHl1rDrSJ5mzW9FxLhpg8ORLb8IjWCjEFx1FkQlEQQRHa4l+f6u2lNSFYawoYmOMz1izjLsrO/Kc6ClWFLkXv/KT2aUKEqWKkL+EKEAUvPIsQZABruKr8nW1yEZsb6JkPwfLvpqOhmPvOthq1EnrXpcV5ytY+/cNLuHpof6vJ6o7MTVyKUY2eHBhy++87EHbQmcr86PcM7NCNYTBpm+tyYXMi7rkQvlxo28q8AWPXk5u3sT/48+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W99EVfC0j++9B61AeedWoX6+A2ypQCNlCofvHFnMUG8=;
 b=ATuSRWlosWG9fzkDm2Wcsf/cgS7/D0IhnWuJEZqBWsFFI8sfpZq4BzjQCsObGe/n+xWlqNAbdU7MYAOmGVA9rQzQXW85bw0y1k2Zukxr0uNDVzO+jhofg/1ZHalS/ljfI0RrIdbtK53w4UL7tzWXlh/MyvYDXyJ6z/mZLnS17YYlnobh6gPwgK9V+nMhCkV+2U5QLvEUZmjFMsOwllapp5iorT9aiDHD4E9XswH15U24hxPcX6wPrnlqnZREHdnr4XK3NCV1T3hNvkDOkNk/nrv5Ph2s/ip7nvCD24q3rdU8s7+YmXCKjbUYrk7Thl4hInHKORxugVgRixgI80yS1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W99EVfC0j++9B61AeedWoX6+A2ypQCNlCofvHFnMUG8=;
 b=cCnK6+H4W0trMjKM5LG2/gjkipkc1OKoj+4u9sfLmV4npTf6rOONm4Eh5qVGJG/EbZS4RsMITw8ngLmlXv4bhucA6MBeQ9QhdPHU+Yb3zF96jb7NXU9FaCHt7k54bZtzVXOnLlPS94pOpq9JijkLiAhPV6+BXx4ufUDS8CPCZRg=
Received: from CY5PR10MB6165.namprd10.prod.outlook.com (2603:10b6:930:33::15)
 by DM4PR10MB7526.namprd10.prod.outlook.com (2603:10b6:8:17f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 17:31:23 +0000
Received: from CY5PR10MB6165.namprd10.prod.outlook.com
 ([fe80::93e8:4473:e7c3:62bc]) by CY5PR10MB6165.namprd10.prod.outlook.com
 ([fe80::93e8:4473:e7c3:62bc%4]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 17:31:23 +0000
Message-ID: <5d4b624c-f993-49aa-95ab-5f279f7f6599@oracle.com>
Date: Mon, 2 Feb 2026 23:01:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Performance regressions introduced via Revert "cpuidle: menu:
 Avoid discarding useful information" on 5.15 LTS
To: Christian Loehle <christian.loehle@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Cc: Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, stable@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
References: <d4690be7-9b81-498e-868b-fb4f1d558e08@oracle.com>
 <39c7d882-6711-4178-bce6-c1e4fc909b84@arm.com>
 <005401dc64a4$75f1d770$61d58650$@telus.net>
 <b36a7037-ca96-49ec-9b39-6e9808d6718c@oracle.com>
 <6347bf83-545b-4e85-a5af-1d0c7ea24844@arm.com>
 <849ee0ff-e15b-4b69-84de-6503e3b3168d@oracle.com>
 <003e01dc9013$e3bc5060$ab34f120$@telus.net>
 <004e01dc90b1$4b28f9e0$e17aeda0$@telus.net>
 <002601dc916e$6acbe650$4063b2f0$@telus.net>
 <CAJZ5v0gcSb_6QPMfHkjSMJ6OOF+PaCZrUKOafYQ++tHE2jBB4w@mail.gmail.com>
 <3b0720d2-9b72-48d0-998a-1fd091cec44f@arm.com>
Content-Language: en-US
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
In-Reply-To: <3b0720d2-9b72-48d0-998a-1fd091cec44f@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0082.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26b::12) To CY5PR10MB6165.namprd10.prod.outlook.com
 (2603:10b6:930:33::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6165:EE_|DM4PR10MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: dafd0a5d-fead-4b5f-b9f4-08de6280e2d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUJCQ1dhOXF3eGVhNmxwYXIwdHNOOEpjaWozVVhTVGc1K2ZNR1Y4SG4rT0Np?=
 =?utf-8?B?NnpjZnd2QWxZaFpxM3lLWlZSN0FXRUtza0RLb2FLSDR0a3R4b0oyK2lJQ1ZD?=
 =?utf-8?B?bXRLbFB0SWNNbllIZ0M0RGxZRTRXd25hTXEzRFRjU2MvZkZJZER3aUc3VThJ?=
 =?utf-8?B?MmFmRTBPR0ZGNU9DUktzUVY3QUg1MUZ6YVAzdEVtc2JZVkEwdEVpcDJYUmN4?=
 =?utf-8?B?OVQ0MnFraWxyR3lheEpsOGxJYTlLYjJKM0NoMHFaTlhQRWk3UDBRNHFteVZj?=
 =?utf-8?B?Z2gvcFRRUFJDNU51WmpWM2xSeVVVTUVwU1pqWWpSOVdrVmpaekdDK2pRYlJv?=
 =?utf-8?B?ZGZKdnR6ZVZSdzVvQzQzY3NHTWc4d0Fra1oxZUFBNm1Wam1zZzFnb2NwVzFX?=
 =?utf-8?B?RDloWjk3Z1VRcFRoWWQ0YUlwcHY0NWJkS1ArMWZTV0IweFlkOWFYa1B1QzdH?=
 =?utf-8?B?T25Ob2Qxblg0azB6MG1Ja1g5elZ3TnJyekIybmpIbFRSN3hybE8xSndiMHJq?=
 =?utf-8?B?ZGFhTk95akxnNFJqWVJOVmNGZjRkcGdHdFljcXBVWDNlVTlnLzhRRkU3NVBz?=
 =?utf-8?B?OHJ1N0RoT09RODRvTFFrWXl6NVptbGVnMlk0SkpyL1RTMHdUbWViVmJ5Qyto?=
 =?utf-8?B?YXRXdWlFakF3citYMkNabWxuYldGd3BsU2E1SW1JOEtFNmRyaGJTVWhlQytp?=
 =?utf-8?B?czk3c1hydEgrOHhUOGdlU293UFFIeSt6U1ZYaThZd3FiVUtZV1F1Szh3MDFC?=
 =?utf-8?B?dU5YL080SWRhOTc4b00zMWlWdElhNVFNMHUwU1BIUWNnNUl4aVErNEllR0ly?=
 =?utf-8?B?blF6NTZMWlpVeHJBb2Z4MVdNbWpKbHRSTVB0TjBFc1dQSmF6WXRxMkpDUFZk?=
 =?utf-8?B?eFhsSW9rcjZxUTlKK3ZLMUFJS1IwZGNIVmZTaXJ0eFU0amZxajVMN0dVZHBQ?=
 =?utf-8?B?U29DYU5CNVJnT1NxT1hDSFNpUFRtbEtCVVAvc0djMy9YY2hhNmFyTFhzVUsv?=
 =?utf-8?B?RUZIQ2E3QkVTOGtiQTNFa2VEbUtwNmJncURaZ29jWDBMUlQ2ajFiaXBCeVpq?=
 =?utf-8?B?UC9KcG5xekM2dmZGMUE0NlloNW9ieTJpUHdEaG14L3YwWWNVWG5JTXh3Vjh2?=
 =?utf-8?B?UnFUTWFyVCtIaWFrMW92MUpYc1B6d1BwK202anVkSGZNSWNUNWdYeXZCQ1Nq?=
 =?utf-8?B?UUVsUGYveXByZ0xhSmVURUhFU1QvemRMOEtxekMrcW5wcjNSWG44SUJPZElM?=
 =?utf-8?B?aCtNRXdReWdmdUQ3TG0zSHJ5Y3dieEdLUHFwczYveTZCbGIzRVJIbGxPa0gx?=
 =?utf-8?B?Z2pCdm9mZUpxODVjNm5Qems2N1ZBSlJXRzRNVlI2VWgyYi9vcG1ETm1sQ0lt?=
 =?utf-8?B?a01kM1E4TGZtSjRDdHVXTHZWcXI0R2hyREtES2NDVDkwcWw3VEZRaWZPZjRh?=
 =?utf-8?B?M0d4MjY5bGZOWDk3MlR1YnFLMTRWYW92MkZFVHkwUkNPZ1NVaXk0aXBpWkdl?=
 =?utf-8?B?Z3M3ZWlsaWNJMk01VE51Q3NMNnREcGFBKzBGNnVyb256MnJUOHVuTHhCc0dM?=
 =?utf-8?B?Z2cxdjFzUnVRakdwMXkxNUNlZmdjci9DMTZ0ditqU1E4YktUc3NncTdtOGx0?=
 =?utf-8?B?OWRuTXJKYVNqUnc2M3FNekljSGpDZVhyYjJLa3kyMkNqK1pLTXZRNVBXN0tG?=
 =?utf-8?B?S2hydVllUTFjMDZ2Tk9XN2RteWV6Wkw5MkRVcVdXYzBJNmdOZm83bkFGSCtZ?=
 =?utf-8?B?QmNsQmg5aHBPeFpVY0hNVWpTaVVScW80c0JXKzVNM1NXVlBaNVhhVHdUVmpy?=
 =?utf-8?B?ZG9VRnBIQ3lMOXMwa0ZPWkJDQnBvaUo4Q2NxMUt1andCMENDeFEvNUkyR3JH?=
 =?utf-8?B?aTlZN2RIY1RjMEZZbCtIbHc3NzEwTDJadytTdVFSTmRiakVpaTdHK0M1aVQv?=
 =?utf-8?B?Sjd6bjB0aVVBVGZYSEVkSFl3VXNka0xLbnVyeW4zOFAyelZkUlpJNHBQQUd2?=
 =?utf-8?B?c2JRWElnWXlhYjdWUlFJNy9hZE9SZCtrSG1RUWdOdEZVTjY3UFhxTjJmTyto?=
 =?utf-8?B?aHNTSnJ3RkY0SHdTSWZzNVBwUGJ4YUNDMW5ZQzZKNlJveWhsaHJDVzlCS2Zw?=
 =?utf-8?Q?+GZI9rN4ylTx3Wvr+ojjJEZ2z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6165.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2FlbnB6WFk1RmRRamY2cjV1akNjNlY0aWlGT1NVTTRuZFlhY1ltOEhieStD?=
 =?utf-8?B?L3VKT2QzZnRpTjJPNWo0M0hiVzNadzJpOGttT0FxUWZKbDNIdE9lOG8yUHN4?=
 =?utf-8?B?YjFOd1RQYVg1dVROUmNzVTF4TkVkejJBdVVlZTFQcFZrdWVnQ2FxWmQxK1dC?=
 =?utf-8?B?ckFMMFBsWVg2S3NXazRiZFJnbHNMa3l0dXBHdG1GZEQ4UG1RVEJuT2tWWVlR?=
 =?utf-8?B?NzcxL0paNGJJdzUxZ2w5WGt2Uy8rSE40MDZ2RHduRVRvVWxIK1Jpa09rTzBp?=
 =?utf-8?B?OENuZ0RTYWVmUE1pS2pWMHVXR1l2MmhScVFZZm11K3hjM2VtT2pHdjhieFl2?=
 =?utf-8?B?M1RRR1I1RFY2VkdpeVdSaWtyVy9YQ0xiL1pOOWxETUx4Ui9qRVpkVjRvVXA4?=
 =?utf-8?B?MlAydE1Vb2crOVc3ZWo5TStFR0JQYWZTUFdWYlBqTmw0dEZNUUlYTzB0ZFhW?=
 =?utf-8?B?d2VhR2xmV2tXaTVTYjRRTE5vOC84WFM2TmN6d0pkeUQwTno2NnF0NWplMnow?=
 =?utf-8?B?M0ZBdFJLNnJSV1l5VnFxbWQ1UXYwclNHNWhnNDZaL3VzcW1OcUFtM216RFV4?=
 =?utf-8?B?WEgzWEVKc2c4T1doTUd4TFRmNzB2d0xmKzMyS3JiTkpWOUFla0kzWE1NeUt4?=
 =?utf-8?B?SEtQTDN4V0dvSGtaRXdBem94d2RrSGFMOVp0YWg1VFNLS1RCNkFjTkZmeXZB?=
 =?utf-8?B?WnRDWHlGZHhIa25lUTlXdHF3dTdibnZwb04rRjBzRGdBTXRFRmpRN3dSaW5F?=
 =?utf-8?B?VmtCdmtXek9kOFlqWnJqVnZkZm95R1lrNFlBWlhjN21Xc3FON0FFNVY0VUxw?=
 =?utf-8?B?aDExYXV2QmMzbW1NTksvc3h0WTBzc2w5aXFyb2RtR2RHeWRTTVpVcTM0Y21q?=
 =?utf-8?B?ZEZXK2Z6ZnUwM2I5NzA0UGdvcFhLUjhFMndFVmJ6dDRRQkJzZXlVMUN2WVAz?=
 =?utf-8?B?YTlxeE9hU3ROcEQyeW1BRmZJcGRDZitNcFYyTXo3dmpzMS9nYndSSXgvaFpN?=
 =?utf-8?B?SUFSK0lHV21VRnFsSlVJTm1CYUVKcFlUd1dVU05nb0N4dm0ybit5eExPNUl1?=
 =?utf-8?B?TjY3aWlPUDJGekZKWStDZm9NUkVSWCtiZW9aMmd6bU5lUGFsOTBnUmt3elZl?=
 =?utf-8?B?QWtBb2M1Z1BlL3pnWFJZbThiVFJYeTRya2VCWUFrVDhJRnYreXFEaHBKN280?=
 =?utf-8?B?NVVmWkpseHdpR3JPcnFZZnJHN1ZkQ2k3Qk1hdExYSzg1UGx2V2huT1RCYW9h?=
 =?utf-8?B?M0JiaHRsZC91aHRkSUg1a1VCUm9oQzk4ZFljNi9vd2tPOEsyZkhWUVVJeGl0?=
 =?utf-8?B?OGVrb2w2clhHSU5MOEF2eVhJaS8xTW1WWTJFYmlDMDdCWHcrNkVxNUNzbG15?=
 =?utf-8?B?MlNxanJjSjhvL1piK0pDa3VYRTJVODJ4NG5qcm1uOW1rbGZSVGxuZ05WcWsx?=
 =?utf-8?B?REFJMkticFRUc01oUmVMM2tzbkJWNndzeS90bzNsci9QbSsra2pVcnlHRTJ1?=
 =?utf-8?B?RUlkQzlZcUNBTXFqSm1KZ0Z6dVF1ZStsdE8yeWN1aisyQTJrVkx3OUdzMWFq?=
 =?utf-8?B?REdQZzZoNVR0QlVPcEtvY0xJc2xtUFU1SDJ5ZWVzT0dsUExMdHZyZWZHMS9M?=
 =?utf-8?B?QzBYdmpWWi9ONUE4OTAxYXVYcnZmb3UxdmdERnRnUXFDaEpFUUt2VmFXRlFp?=
 =?utf-8?B?NVg0M21mTmFkd2syREJXZUt4OWhwWkZIZENCSGJRRkxjYjE1SUdHeVdwV01H?=
 =?utf-8?B?NUZ6a3lqaGhHVUkxeGxsNkRLejhmUTNXWGh5V1hPc3BpWE9IbWNaWWt3UlJ6?=
 =?utf-8?B?ZUFQbHdnK2ZxSjczdXNKRVFxdGYyNS9pVkk1cjNza3ZNWURLeUI4Y3pRM1VT?=
 =?utf-8?B?WUNuSVR1cTJrWmlEd21WeEZMbmZibnh0bGhzanlZTmFBaGd5WGc1OFk4dFVw?=
 =?utf-8?B?bzRRSlIyOTA3emlhYlpKb0sxbWVWckVDNmljVlFTWkZEb1MwQXlpTUJOOS9T?=
 =?utf-8?B?U3huZUV2UFBhSUJ6SUFSdzQ4VU1ndk1MUFlHbGxxbThHaUZnUzZibkpzM1VI?=
 =?utf-8?B?TXMwb3U5Z0V3R2s4MlcyMVh0Q0hKZjZZUnBNdjdyMU1ZdUVZVysvQm9ZbGpn?=
 =?utf-8?B?U25Na0NobWFuM1h4TXdBcmVuMG0rNCtVbDFJOTRtL2czaE01eVMxeTBhK3o1?=
 =?utf-8?B?a01QT3ZmM2I2Z1hIMldDOFpFR3QvQUtxUlZTQkxBMFJPeEdMR0VxMUlCV0dV?=
 =?utf-8?B?aHNTWll2THFna2ZwNWxHMS9XU08ySTJvMktuTE9qaDBBNkVpbDhDTnRkM0tn?=
 =?utf-8?B?dkNZU0FtSUk4a0t3Znk0Z1ZFTURVb3VEUjRKNkp3UUhaRFA0d0VpUWVINk5t?=
 =?utf-8?Q?2dujAgsyuYltfk/2xCWBKUakO6KgXEX6XApvTsjgynWnK?=
X-MS-Exchange-AntiSpam-MessageData-1: 3TDGm8aFCueP1ryTcdguhkLNfVrYzGJrDaM=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qAvLKf1KTSPmAIy+lTLXYL5oVcL8iPUwQUDxkyW9Gq/NzZpuRNOjqF0r5LC0MRSEg1AZXC8uITAmUBF2zUho7oat0QUk1G21OLOSWLupb3ER81Vh5+6QoD+IN0h5qc5b4Y5Rtw/43fh/JDxjL0dZVR2uw0cy8ks1lwVa9QYenPTxy6jcz2D02AEy5USdVAb/cogh6I7nzq/25g5Kty4N+RLeYJ6UMT1xJDEVGo7md7XBQzIH6iJclfuckmw2l77KXQbqESVPhQVH2pRp6PJhJ+JNXGL6cvF5chgwkkYmSE/v52YeYhg/5I/aHc2pUVIGSFlg/Ti+LY9cLxxP61vVLUozp6tXDbreop2qn47YldqRphf3CAgyOPw1dVUyQNACp66pGV33ge3w7JZxpnr4iDx/+o4bzaXYOedlE19Da90zHpXQ6EkCDfOPsJi7Oc6h+rzEKSxAMqQMtCOvNc0G4TAHRJvozVO/yKZ4KWJQBEGR30mcDShQRBTmWVvPrl8GNIQxaBV+t/whOiPSW8RKjuHiFjeyuGENMPDkz0c3GAKQ5lPdvftLCJVXeweFZyIHVjKLQVJZXRwy3IZvAg1aOQmdtJHx0+bFU6UFoRdymUs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dafd0a5d-fead-4b5f-b9f4-08de6280e2d4
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6165.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 17:31:23.6978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UG3e8MdtOMb/s9MP+Q2cou+PERcoy0nftTvKmuPdpMEXVcQFVX8CgX6v/yydm1di7ukyBY1VOGRQicFN7W+mrKHzS3tE9rGB+p4soVLskJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7526
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_05,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602020138
X-Proofpoint-GUID: KFtQ6xTpFlYq3lNRgVxcvBF2rd4b8tUr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDEzOCBTYWx0ZWRfX+n2vK2f7Crp5
 CJXdt00+HjswYeDEPWLj8sLFsW5zk5RqFPZzveVTp83rzizTTFPPwd3fx5TDm/ZkDXWCF3w0ZOc
 qbRI1fSO/jiPKuiOkekIYaH9Em8xR2js1A0pZpv4eak+PvvDZnyTrXVwGnW7oz3X4NXEMAMosz5
 gtD4YJ766NSDP3PbmEMxPK3TwKZbubJ/mVLeVBNegdHZ7LJP9NmcUPm/tr6QzpSh7mTOug0O008
 IZE41VHQykks/rs27l2fUfncZX2t3hF4r98IQ4aRns2Rc513IiJGext1d6zRxYKjoW7Mqf6sPkl
 C1PcCMbba6eYTyS+GpCPcY7/0rajG2xSG5Ent4Fn6+mL4YiFu/z7YZcFnELvv4VRTChPuICjW6F
 tuLMAd4OeQjydpyinr/s+gnYTt96xOgsd89TPrBRvWJHblvoJZsZj62ibvSim+dJbSrXC4cg6HY
 XZ6ODDSj4+jNFPwZZQA==
X-Proofpoint-ORIG-GUID: KFtQ6xTpFlYq3lNRgVxcvBF2rd4b8tUr
X-Authority-Analysis: v=2.4 cv=IaqKmGqa c=1 sm=1 tr=0 ts=6980df71 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=aatUQebYAAAA:8 a=cBXzzHnbSGd0pcY1gxgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=7715FyvI7WU-l6oqrZBK:22
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41918-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,urldefense.com:url,oracle.onmicrosoft.com:dkim,oracle.com:mid,oracle.com:dkim];
	REDIRECTOR_URL(0.00)[urldefense.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshvardhan.j.jha@oracle.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 047C9CFA17
X-Rspamd-Action: no action


On 02/02/26 12:50 AM, Christian Loehle wrote:
> On 1/30/26 19:28, Rafael J. Wysocki wrote:
>> On Thu, Jan 29, 2026 at 11:27 PM Doug Smythies <dsmythies@telus.net> wrote:
>>> On 2026.01.28 15:53 Doug Smythies wrote:
>>>> On 2026.01.27 21:07 Doug Smythies wrote:
>>>>> On 2026.01.27 07:45 Harshvardhan Jha wrote:
>>>>>> On 08/12/25 6:17 PM, Christian Loehle wrote:
>>>>>>> On 12/8/25 11:33, Harshvardhan Jha wrote:
>>>>>>>> On 04/12/25 4:00 AM, Doug Smythies wrote:
>>>>>>>>> On 2025.12.03 08:45 Christian Loehle wrote:
>>>>>>>>>> On 12/3/25 16:18, Harshvardhan Jha wrote:
>>>> ... snip ...
>>>>
>>>>>>> It would be nice to get the idle states here, ideally how the states' usage changed
>>>>>>> from base to revert.
>>>>>>> The mentioned thread did this and should show how it can be done, but a dump of
>>>>>>> cat /sys/devices/system/cpu/cpu*/cpuidle/state*/*
>>>>>>> before and after the workload is usually fine to work with:
>>>>>>> https://urldefense.com/v3/__https://lore.kernel.org/linux-pm/8da42386-282e-4f97-af93-4715ae206361@arm.com/__;!!ACWV5N9M2RV99hQ!PEhkFcO7emFLMaNxWEoE2Gtnw3zSkpghP17iuEvZM3W6KUpmkbgKw_tr91FwGfpzm4oA5f7c5sz8PkYvKiEVwI_iLIPpMt53$
>>>>>> Apologies for the late reply, I'm attaching a tar ball which has the cpu
>>>>>> states for the test suites before and after tests. The folders with the
>>>>>> name of the test contain two folders good-kernel and bad-kernel
>>>>>> containing two files having the before and after states. Please note
>>>>>> that different machines were used for different test suites due to
>>>>>> compatibility reasons. The jbb test was run using containers.
>>>> Please provide the results of the test runs that were done for
>>>> the supplied before and after idle data.
>>>> In particular, what is the "fio" test and it results. Its idle data is not very revealing.
>>>> Is it a test I can run on my test computer?
>>> I see that I have fio installed on my test computer.
>>>
>>>>> It is a considerable amount of work to manually extract and summarize the data.
>>>>> I have only done it for the phoronix-sqlite data.
>>>> I have done the rest now, see below.
>>>> I have also attached the results, in case the formatting gets screwed up.
>>>>
>>>>> There seems to be 40 CPUs, 5 idle states, with idle state 3 defaulting to disabled.
>>>>> I remember seeing a Linux-pm email about why but couldn't find it just now.
>>>>> Summary (also attached as a PNG file, in case the formatting gets messed up):
>>>>> The total idle entries (usage)  and time seem low to me, which is why the ???.
>>>>>
>>>>> phoronix-sqlite
>>>>>      Good Kernel: Time between samples 4 seconds (estimated and ???)
>>>>>              Usage   Above   Below   Above   Below
>>>>> state 0      220     0       218     0.00%   99.09%
>>>>> state 1      70212   5213    34602   7.42%   49.28%
>>>>> state 2      30273   5237    1806    17.30%  5.97%
>>>>> state 3      0       0       0       0.00%   0.00%
>>>>> state 4      11824   2120    0       17.93%  0.00%
>>>>>
>>>>> total                112529  12570   36626   43.72%   <<< Misses %
>>>>>
>>>>>      Bad Kernel: Time between samples 3.8 seconds (estimated and ???)
>>>>>              Usage   Above   Below   Above   Below
>>>>> state 0      262     0       260     0.00%   99.24%
>>>>> state 1      62751   3985    35588   6.35%   56.71%
>>>>> state 2      24941   7896    1433    31.66%  5.75%
>>>>> state 3      0       0       0       0.00%   0.00%
>>>>> state 4      24489   11543   0       47.14%  0.00%
>>>>>
>>>>> total                112443  23424   37281   53.99%   <<< Misses %
>>>>>
>>>>> Observe 2X use of idle state 4 for the "Bad Kernel"
>>>>>
>>>>> I have a template now, and can summarize the other 40 CPU data
>>>>> faster, but I would have to rework the template for the 56 CPU data,
>>>>> and is it a 64 CPU data set at 4 idle states per CPU?
>>>> jbb: 40 CPU's; 5 idle states, with idle state 3 defaulting to disabled.
>>>> POLL, C1, C1E, C3 (disabled), C6
>>>>
>>>>       Good Kernel: Time between samples > 2 hours (estimated)
>>>>       Usage           Above           Below           Above   Below
>>>> state 0       297550          0               296084          0.00%   99.51%
>>>> state 1       8062854 341043          4962635 4.23%   61.55%
>>>> state 2       56708358        12688379        6252051 22.37%  11.02%
>>>> state 3       0               0               0               0.00%   0.00%
>>>> state 4       54624476        15868752        0               29.05%  0.00%
>>>>
>>>> total 119693238       28898174        11510770        33.76%  <<< Misses
>>>>
>>>>       Bad Kernel: Time between samples > 2 hours (estimated)
>>>>       Usage           Above           Below           Above   Below
>>>> state 0       90715           0               75134           0.00%   82.82%
>>>> state 1       8878738 312970          6082180 3.52%   68.50%
>>>> state 2       12048728        2576251 603316          21.38%  5.01%
>>>> state 3       0               0               0               0.00%   0.00%
>>>> state 4       85999424        44723273        0               52.00%  0.00%
>>>>
>>>> total 107017605       47612494        6760630 50.81%  <<< Misses
>>>>
>>>> As with the previous test, observe 1.6X use of idle state 4 for the "Bad Kernel"
>>>>
>>>> fio: 64 CPUs; 4 idle states; POLL, C1, C1E, C6.
>>>>
>>>> fio
>>>>       Good Kernel: Time between samples ~ 1 minute (estimated)
>>>>       Usage           Above   Below   Above   Below
>>>> state 0       3822            0       3818    0.00%   99.90%
>>>> state 1       148640          4406    68956   2.96%   46.39%
>>>> state 2       593455          45344   105675  7.64%   17.81%
>>>> state 3       3209648 807014  0       25.14%  0.00%
>>>>
>>>> total 3955565 856764  178449  26.17%  <<< Misses
>>>>
>>>>       Bad Kernel: Time between samples ~ 1 minute (estimated)
>>>>       Usage           Above   Below   Above   Below
>>>> state 0       916             0       756     0.00%   82.53%
>>>> state 1       80230           2028    42791   2.53%   53.34%
>>>> state 2       59231           6888    6791    11.63%  11.47%
>>>> state 3       2455784 564797  0       23.00%  0.00%
>>>>
>>>> total 2596161 573713  50338   24.04%  <<< Misses
>>>>
>>>> It is not clear why the number of idle entries differs so much
>>>> between the tests, but there is a bit of a different distribution
>>>> of the workload among the CPUs.
>>>>
>>>> rds-stress: 56 CPUs; 5 idle states, with idle state 3 defaulting to disabled.
>>>> POLL, C1, C1E, C3 (disabled), C6
>>>>
>>>> rds-stress-test
>>>>       Good Kernel: Time between samples ~70 Seconds (estimated)
>>>>       Usage   Above   Below   Above   Below
>>>> state 0       1561    0       1435    0.00%   91.93%
>>>> state 1       13855   899     2410    6.49%   17.39%
>>>> state 2       467998  139254  23679   29.76%  5.06%
>>>> state 3       0       0       0       0.00%   0.00%
>>>> state 4       213132  107417  0       50.40%  0.00%
>>>>
>>>> total 696546  247570  27524   39.49%  <<< Misses
>>>>
>>>>       Bad Kernel: Time between samples ~ 70 Seconds (estimated)
>>>>       Usage   Above   Below   Above   Below
>>>> state 0       231     0       231     0.00%   100.00%
>>>> state 1       5413    266     1186    4.91%   21.91%
>>>> state 2       54365   719     3789    1.32%   6.97%
>>>> state 3       0       0       0       0.00%   0.00%
>>>> state 4       267055  148327  0       55.54%  0.00%
>>>>
>>>> total 327064  149312  5206    47.24%  <<< Misses
>>>>
>>>> Again, differing numbers of idle entries between tests.
>>>> This time the load distribution between CPUs is more
>>>> obvious. In the "Bad" case most work is done on 2 or 3 CPU's.
>>>> In the "Good" case the work is distributed over more CPUs.
>>>> I assume without proof, that the scheduler is deciding not to migrate
>>>> the next bit of work to another CPU in the one case verses the other.
>>> The above is incorrect. The CPUs involved between the "Good"
>>> and "Bad" tests are very similar, mainly 2 CPUs with a little of
>>> a 3rd and 4th. See the attached graph for more detail / clarity.
>>>
>>> All of the tests show higher usage of shallower idle states with
>>> the "Good" verses the "Bad", which was the expectation of the
>>> original patch, as has been mentioned a few times in the emails.
>>>
>>> My input is to revert the reversion.
>> OK, noted, thanks!
>>
>> Christian, what do you think?
> I've attached readable diffs of the values provided the tldr is:
>
> +--------------------+-----------+-----------+
> | Workload           | Δ above % | Δ below % |
> +--------------------+-----------+-----------+
> | fio                |  -10.11   |  +2.36    |
> | rds-stress-test    |   -0.44   |  +2.57    |
> | jbb                |  -20.35   |  +3.30    |
> | phoronix-sqlite    |   -9.66   |  -0.61    |
> +--------------------+-----------+-----------+
>
> I think the overall trend however is clear, the commit
> 85975daeaa4d ("cpuidle: menu: Avoid discarding useful information")
> improved menu on many systems and workloads, I'd dare to say most.
>
> Even on the reported regression introduced by it, the cpuidle governor
> performed better on paper, system metrics regressed because other
> CPUs' P-states weren't available due to being in a shallower state.
> https://urldefense.com/v3/__https://lore.kernel.org/linux-pm/36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7/__;!!ACWV5N9M2RV99hQ!KSEGRBOHs7E_E4fRenT3y3MovrhDewsTY-E4lu1JCX0Py-r4GiEJefoLfcHrummpmvmeO_vp1beh-OO_MYxG9xLU0BuBunAS$ 
> (+CC Sergey)
> It could be argued that this is a limitation of a per-CPU cpuidle
> governor and a more holistic approach would be needed for that platform
> (i.e. power/thermal-budget-sharing-CPUs want to use higher P-states,
> skew towards deeper cpuidle states).
>
> I also think that the change made sense, for small residency values
> with a bit of random noise mixed in, performing the same statistical
> test doesn't seem sensible, the short intervals will look noisier.
>
> So options are:
> 1. Revert revert on mainline+stable
> 2. Revert revert on mainline only
> 3. Keep revert, miss out on the improvement for many.
> 4. Revert only when we have a good solution for the platforms like
> Sergey's.
>
> I'd lean towards 2 because 4 won't be easy, unless of course a minor
> hack like playing with the deep idle state residency values would
> be enough to mitigate.

Wouldn't it be better to choose option 1 as reverting the revert has
even more pronounced improvements on older kernels? I've tested this on
6.12, 5.15 and 5.4 stable based kernels and found massive improvements.
Since the revert has optimizations present only in Jasper Lake Systems
which is new, isn't reverting the revert more relevant on stable
kernels? It's more likely that older hardware runs older kernels than
newer hardware although not always necessary imo.

Harshvardhan

>
>

