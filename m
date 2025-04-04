Return-Path: <linux-pm+bounces-24809-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE3DA7BD33
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 15:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CDC3179AFA
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 13:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0071E1DFE;
	Fri,  4 Apr 2025 13:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZUU6lCUY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qyJUTgwH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11231DA53;
	Fri,  4 Apr 2025 13:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743772044; cv=fail; b=P7FcNxPIoxuO13kZUs1gHTXRc9pYLC0nIFuUGqkGtbs4G0wF6xPp5yZdNx0NrEYlxpYxcgWb5XqNcREvFyDd1eAGQrkWMUL0toyIQUriInaoBbngP6otj35Gd1jZgQ5nmQh7aATpOahEzAotK/Z+y3MjwdxcRpjPqeL+iSkIT8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743772044; c=relaxed/simple;
	bh=YKc6w9BUaqyyt75WeGxcWUhVf9mBUgV8uV0oHPlrS68=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BmaSLePzrN2E3idicvihUMqlICRVIcly/x4YV09vuWqjEL/4a508MXCT/XULcNmNTKGp+fBMqR1n+XmZRrftZWHPSH2ddGuuVKMnyNOT71qy9B0pc8GlzItons39f9bBc5CnlMzI4MwsXKjuqK9+KDC/dyEX8Gs7fqakmHtJ4kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZUU6lCUY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qyJUTgwH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 534Cg0UX006784;
	Fri, 4 Apr 2025 13:07:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=HMNYQblMA2KB4b6gDVTyc/RcvLCcgjfibiExCYxn2+c=; b=
	ZUU6lCUYdFJJyhRJVA4C1dLnMVEK3DIlfFIKOFsLfM2PaJ3ewqtBrQnizgPFyXzL
	UTr/UvsHtz2SYM1gPGa6j8KoDwzsJzZVE+mKcnW2kG1X87xtTlTlhS3n0OkEGsSx
	gyJb5rkoMA7aSzlU0urqUwNCaWVy8eUxPE683Df1X8vqyr5rlr8uOkDiPOZEJjiy
	K9a750lQT1FOlqDl5XPKD+G1Qgn3hkdejQijWnd83u8tAZ0QuGAiptQYeuQor7Io
	XiZSay9uSn3vHNcvLdG2a4g9IhL5uXbeqyODWMLRq4WsWJ+6OEM3cUmf7044f6tt
	yeL06eLDPP222GyaLoYIZw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p8wcqg60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 13:07:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 534D0hHJ022443;
	Fri, 4 Apr 2025 13:07:08 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45t2ykrqar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 13:07:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HyiNeHmV/32Gnzsh8gpZVbYKgFD/cyOI7tVuxEGHUHN9HdzcAk2B3sfASE2pUmb/cQkSF2F+6tJURMqMuCt6hH8X+2ELxareBFilbmNaY4fOWgW8W0uY1mCCrUaqPcfMQe3XMmIEVKLMmc6dxN4A4E1Mm5sZjKI7zMfMLpx37YC/HLzVtbPRirImiTTB+vyKX0O+/2SmKvsXkAgPgql1EVaVXbGNLqZDV2czI7F5jtUtOmuMTXGj1yLqjRiCIhM6YMdX4jchCNWrmZLJ+QTqxYuC1oGK0aBK2YpD5o0Wmkx/sN2bc4VzSMs+2Wg9XicY4MV1HFEceOec5S+JNOO0ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMNYQblMA2KB4b6gDVTyc/RcvLCcgjfibiExCYxn2+c=;
 b=pxHcHojXYzyLuWmJ5nrVLShS16nVyY5EUUeKw5NZNoB0VUVh+KJqlz7XQ2CIIRYra4o81A46X0ykGwKe4JQsxFKHEXB+y3Q3Il5iuXtUgT3Wo/zm9jQQT1FPpgLHsLY6WxZiV0EGyCZrQCQo+ddDqWiyuAkApqn4tvgas/9FKK9DNq54UNuDU76/UojXPaNpCHd9eCpbGDrpxiNx+NyIDSQDaoHeZdRHvm31ztBZLsZpPNN648I4cclc4bJ/yA/nwSfewH/CCbTsOdwZjMCyIiWJkwcIwuUYjYSeFcFw4USzl2evw8OdwXq8uuQ5tyZXx/DiAWkd02xMU9XKwGga3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMNYQblMA2KB4b6gDVTyc/RcvLCcgjfibiExCYxn2+c=;
 b=qyJUTgwHeu/rOpHVhcVsjxCvcqOc+sMFHWM62XNKqicIMqPc305FDx8n5vMB/zRfeKLm1ar0YdnU7SBV+s6wF0EtguBZFFszzbcapDGBT1/QRuF7qy9EAEYcAFDrHP1QtNXtyQXodshxsQjF5hBKtUiA8G8Saqsd2UwTp2ztmkU=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DS0PR10MB6824.namprd10.prod.outlook.com (2603:10b6:8:11f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Fri, 4 Apr
 2025 13:07:06 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.8583.043; Fri, 4 Apr 2025
 13:07:06 +0000
Message-ID: <5cd0c507-95c5-419f-8618-71d2f44bc7c5@oracle.com>
Date: Fri, 4 Apr 2025 18:36:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: RE: Re : [PATCH v5 3/5] thermal: renesas: rzg3e: Add thermal
 driver for the Renesas RZ/G3E SoC
To: John Madieu <john.madieu.xa@bp.renesas.com>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "robh@kernel.org"
 <robh@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Cc: "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "john.madieu@gmail.com" <john.madieu@gmail.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Biju Das
 <biju.das.jz@bp.renesas.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "lukasz.luba@arm.com" <lukasz.luba@arm.com>
References: <20250330214945.185725-1-john.madieu.xa@bp.renesas.com>
 <20250330214945.185725-4-john.madieu.xa@bp.renesas.com>
 <a380c593-a2a4-40d2-8b2f-e3e1a2cdbe9e@oracle.com>
 <OSBPR01MB277527932C5570EBC3D877C7FFAC2@OSBPR01MB2775.jpnprd01.prod.outlook.com>
 <ca50f9b4-feb5-4365-927d-a2c931e268ed@oracle.com>
 <OSBPR01MB2775B41C98F595C162E8924BFFAF2@OSBPR01MB2775.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <OSBPR01MB2775B41C98F595C162E8924BFFAF2@OSBPR01MB2775.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0046.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::18) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DS0PR10MB6824:EE_
X-MS-Office365-Filtering-Correlation-Id: d66f7b85-e0e5-4e43-043a-08dd73799953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDBFZkJwaUZjV1dNM3pnbE9iRmNsTFZmNkJOd2JQYlFVU2ZxSVI3WGpzNldw?=
 =?utf-8?B?MU1yWXFrVU9MT1VUVmdDeis1TUUzKzEyeGNkelZyNG00Wk9MbEZBaW1Jd2FY?=
 =?utf-8?B?cExtUTBoQVdNZnVveEhIQjhHZVVXR3VHVFEyZWhscEpJVmZsUDJzemFpUXJz?=
 =?utf-8?B?WGRNcExDK3Vld0xkSklZTG4zTHh3MGVuTk5ycU0vRGlTYkdPdytyYzYzSXZK?=
 =?utf-8?B?czEvNk5mWXJsU1JhSks3S2hublZvUEZLYjZVbmRPaXcraU1KQVViSTMrV1RN?=
 =?utf-8?B?dUwzUDNLYU1vSnorZnNNZ2lwcFE2U09pZlZjamczS1NEWUF3OWJWSk9CcTFX?=
 =?utf-8?B?MGljQjNta215UW9hUEZldlVuQ1g5SnloenF2SmlHa2pMY1NpU2k5WU9UY0x5?=
 =?utf-8?B?MXFob0xIenFLS2FPUlVldGloQVVZRHNhelMzUVUwWTVVaGZIZE8vYWdOayt5?=
 =?utf-8?B?V0lvOUFQWjlWYmN3Wk5LTUdiNW5uUk1DVjFyMHJDUzRJMXVtK2dXUGx4TzQ1?=
 =?utf-8?B?MmlnbnRnem55b1Q0cGQ4MVN5MEIzTE5NTGZ5K2FFU1VVTFljalQ0T3pweTNw?=
 =?utf-8?B?Z1dWZlpHWWdaQXc0OXNrb2dIM1VsVDliV0NWeWtseHFrcmpYRzlZOWdhT2dI?=
 =?utf-8?B?Zm5HWmJRZHBqWGxLS3hiTDJ1dkhGWEJkQkg5Z29BbkMxWGxKc3ppcFdSbFBi?=
 =?utf-8?B?aEUrNTlEK2wwNnBmY0VPZ1I0eTltSjVDUTZTYnd5SHh6MG9ESnMrWW0wbzIz?=
 =?utf-8?B?akF0dU1hYkNhb1Rmb2FuS25QNmkwbDZoMzdQZjNORHFOamkrZ2dNRWtIdVly?=
 =?utf-8?B?SWE3am5MNG9peTBrdUY1SXd4eU1tQUVhSmgrcnpId3NnK1FzU1YvTWNNS1Jo?=
 =?utf-8?B?cW83Mm9PL3NHY3REN1J2VnJJWFVvakh3VmtobnFQMGJvVyt1bldVUFhqbHFo?=
 =?utf-8?B?NmxwVHZFbGtzYm9iVUczZDRuSExSeGpWTlQwTXhidDNBeEpiYmVpS1FURDEw?=
 =?utf-8?B?a0Mzb2Q2cmdjUlhFd3h3dkRvZjlDMGd1ZjBKdlJNWkRuYWhsMTlVTGxpMitQ?=
 =?utf-8?B?Q1UrNzFyQ093MDQwTWM4N1BOOU5ZYzJNSGwvaEpjZ1dlZUR2cGZBNzVmMG5N?=
 =?utf-8?B?VVpOUHhWNC9xRmhwV1NnWExiYkdKT2hrajY2WXFZdHNZTWdNNG5UcndlOUJn?=
 =?utf-8?B?TTdoT3B2SWFVQlBZUlg1SjJnRlIyaEpkVlRSSlpkZkVpdjZ6MzRtQzdJL2Rw?=
 =?utf-8?B?M3I5MW5jQjgwdHhyeEpyS2JaSkdyKzlIbXQ4RVlpUThYNUJzeHdWRmpGMDN2?=
 =?utf-8?B?cmdyWjREdk5JT3crNDVsOU5sd2pNT0lYTFFueERMb1REQXVtZDNtV3VEalNi?=
 =?utf-8?B?R25nN283SU1HRDlHYStYRjVITk93NVlTQ2xGVFMxQ2F4dksyZldHejZ4blVo?=
 =?utf-8?B?L1Y3RXAxU01LOEhtRHdXbnJDaDV1Y2RmWlFxWEUySHRBTFUvTGFSUjN0bThh?=
 =?utf-8?B?WDhHZWhLUDhDOVBQcjhkMnpsR2tZQkN4Y1Z1bHNQS0E1WmlRVnhTaGg4Z0dw?=
 =?utf-8?B?SDZXTElVL2VIb0psb1dqc2VjU1Zub0dWZlJ6cVdRTzRlZUVKdTNzc2RTYTM3?=
 =?utf-8?B?VDRPS1JmWXFYM3REWXNxSkNxb3Rvc201TktkS2I2OXVHVEpndWRBaEE4QjY2?=
 =?utf-8?B?YWpoaEhoODA3YTRJUjdTQVp0L2g2M1IzWU0rcHBDK2RZcWU3azVNbGtia0xT?=
 =?utf-8?B?aDNGQ3ZHTHNMY2E3N3VVK29SN29NaTU2MTY1ZXVmb0tFSU9HMHRPTjZYVmNJ?=
 =?utf-8?B?S0VQZ2RtUWhyYzExZGNtdi9Jd3JCYVpqRTUzbCtDKzl1a2h6WXI2VWJJNE1l?=
 =?utf-8?Q?2gf0Wh4dmgF4J?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkdGalBwUzNXMElQRnlhNE0xTitZTGpLMFNyMHdzNS9JYUJOblVwSVJNMUJT?=
 =?utf-8?B?Qjc5TzdqazFkL2F1R1hUUTlWSVdoajBoRWVPOUtscEZoSjlsWDU4N0NZR2Vl?=
 =?utf-8?B?Z0tHMFhpWkY3U0toQ1VSOGhQeWxxOXh5Um5CQWFmdHNoclVLbTZndTVtNDdB?=
 =?utf-8?B?dmNpaVdFbTZWQzJuL3hBZmxaUmVzdjZIdU50UXo1SDNOQmhhUVEwZlhzdm12?=
 =?utf-8?B?NHM1RmpOZnJwMjBXRDJqcEgvenBDbFVtK2dMTEVIRXZSelUrY3JRa0U5N3di?=
 =?utf-8?B?ZlkwOU1RdzVnSWNlTDRhKzY5clI5ZStuaU8wS2gyQVREWkFTVlUwL3pHRHc5?=
 =?utf-8?B?RUQ5Z2I4Q0JONUludkY1b0o4WHVLaWxUcVNHbm5rZHF3Z0k0eU1QdFhodUcw?=
 =?utf-8?B?S2lSMWlKTXpjbUsvd0czc0ZPNWw2bGJjWDBKVWxCN3MrZ2o0T0ZiZk0rT0lu?=
 =?utf-8?B?cVAxZjg2RG5RczdTdGJIVkNBREE0SS9tNkJPQXFHOFRoTVg0d1VoaTV6b3Ns?=
 =?utf-8?B?QlV1d0pXUWZpKzZjdHJsRFpJNHl0U2F5TTdYdjl1QUhZN1oyTlhzZXhzajhr?=
 =?utf-8?B?RTZGdEwwLzZOalAxTDd0bnJERzBDL3VJSk9aU0VrYitMMmhiZkVBdkFGMlpN?=
 =?utf-8?B?NnNmbzZYTE92Nk5ialFRM2xiV2JKSUp2Nk5qdWRNNllyQkh0dzNHS1hvbS92?=
 =?utf-8?B?cTdFQWFNYkxSak54cWxWc1BCVEwxSkF6UERrTGpUdEtVWnBDbmd5RnRJQmtW?=
 =?utf-8?B?dWhsUkVlMkJPYStodWc4cksrSnZrUlZza1N3ZThUQVBIRUplNnBycnlWL0th?=
 =?utf-8?B?QlNMc3lKYUZaQ0lway9XTXNzZW5NUFZMeGt2amZNVFA4MVRBdm0ycU9ZZ0th?=
 =?utf-8?B?a2dPOExyV1h2RXNoZTZiUmk5TzZ5T1Vwd0lRaWkwUjZzRU1oYS9EVnN5dGJT?=
 =?utf-8?B?NXVQV2V2NVZEdVBHTmZ0OEtQRjMvMU8wSVEvVzJmUW9oNEpOSEp3NkNrRnh3?=
 =?utf-8?B?QlFobXhURm5aUCt5aDJtdFJYcTZNV0N2Zm1VU2FVOUxsKzlmc2k4RWJ6L3A3?=
 =?utf-8?B?M2tsMUxNVjBrY0EyK0FjUG1sMEZYdE1NUGhndklhbFlKQUNlTjJCcENDUW1D?=
 =?utf-8?B?R29GOHptWUdCdjVTSHZpRC85ZmVhZW90K0QzVk1zd3hvdlpOVDBCaE1IVlh3?=
 =?utf-8?B?Y0czaThpdUZoR0FXSERkeFIyWDduNHdFZWQxRnNkZUtPbzdzTm1Hb3dndVRN?=
 =?utf-8?B?YkJMb1hGNVJkTjB5RVpkVkQ5dERLU24yVTNqeVRMVmptdi9PeldsbFhWK3hY?=
 =?utf-8?B?RlpTa2dBaGdTdlhTdmh0ZS8wNmtkMi92Z3A1V2hMUHR4VnA4N0VPZEh3d2tG?=
 =?utf-8?B?NjZXRVpvTzBZQmFObUlXVlNhWWRNdThoVlJhNkZlSmJubGVnaUhUUUxIendO?=
 =?utf-8?B?bTBsQ2xVNnNiS1BTZktSMGFOTmQ5amFOcXFpaS9rdnBWVHF5SDJyelZSa2R5?=
 =?utf-8?B?OGJyOUlvcmYzTkZTelUxT0ZleFBETHZvLytWbDBpSStsWkxVZjhOenY3U0ty?=
 =?utf-8?B?OVc3c25mMEJHZVBhL1dQVm9PQk9JcnZ6Q3Y5MzRqalhXRFRYNkpWU0M0SDlv?=
 =?utf-8?B?WkVXdkJQYTNtU0Izb1JHU01pZmpuWkpnbmYzcU9rbzV5UmlMbCtlNnlJMEZK?=
 =?utf-8?B?NHp3TjNLL21HaldSL1FwRWM0NC9wOEZ2MitjS3NHTWExeFdmR0xMa0FRbEdC?=
 =?utf-8?B?T0FFN0FoYmtqOC9VSUxCU0ZUMnZLTGgra08vSnJDVjZRNGdQOWlvREwwNERm?=
 =?utf-8?B?KzZVOW1qMXZaOVYycnBla1ovdFU0Z0Roc2lrRFMzNWVFNDBJVVU1RlFCcE5U?=
 =?utf-8?B?WFpBSWlmWVJnL0RtaUQ0dDRFVlZZeVNSNDVSMnFwdUpqMnRnWVFaQU9NbEp2?=
 =?utf-8?B?dUgzendwdWVCTFBnNzc1UG1TQ3JRLzkvYjlERi9kcy8xRFdIUUZtWEtxYnZF?=
 =?utf-8?B?RWx3MTkxUHBhdmJjVmdzUEFUbHkvb1RnNzRxZ0tDMDJVS2JCTHlScEtyRzlK?=
 =?utf-8?B?djlRQmIxbklzMFJuNUJFS2NMSkFBcHJmU0ZFdE9wMHBucWtvb1ArN0QxZmJX?=
 =?utf-8?B?OUhTWWpjcG1teWt6MWlsL2lHaGFCYlk3T1NRczI5Z2l1b3JTaWs3T0hzYUxy?=
 =?utf-8?B?aXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EdNTmFbxMbvIL6qCRmnD6/SHud0TZOzE7HST0iVu7KERENi+lcHOkh/5hlUedMtUmk6ta8g8SBAVREeRb37Cp/zcvbAuSvDa8GfhIM8TGyCsx5U+WUfg3DBHW5bCbUMkSp/XXWYOjaBJsF+54F0PLTOsUysEwDTGniPizdtqS8Hl0rZEnG0bk1ESi5KXZx8Ih9vA/qTN+jYfsPYm52kdF/aUoGKOZ046xeamz58o4Brxfwye4xnlmwpfQArwv7esBZePy8P4+TY4BK7FUvMrgIm8hx5Gnqx9T+w4kuT/lkwzIImjaVYRxX9SV8gMhGtVxJgMZr6coxITqDdH8dLtZXStvmagBD56em5Wib2CWFGpwE4H3K6JLyS2Eb97YPSO+zJXR+znTK48VohjxJDUM9l9IaKBeyX9bPQCvHXi8oG0hL8Xblxl1uUvqT4j8GgEPi1ucLn1YcxSyd/NcfeNzSJKM/o1t0IqPg2rv7dfovrZ/ZvYSZdrEG2AUuBsMfc8sGnfRODHKtTlWpNdNelHwaAloaS+ZFACaj5BC32JlRHmhrzdXgNjbQr/1MncXJERfH2g466QP4cTwiNaYtwFXuDUIFFx4LdD4L6/PfTLjqY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d66f7b85-e0e5-4e43-043a-08dd73799953
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 13:07:06.0675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TzjbSQCusp7loEmJbwWaHf6xiQehL8U+hitZhE2eN4rhDFH9b30JG4jR5rSQHar5ZJtZO6r9Y5g/0EIXA4um6uIFtehInP3KvkrgMZtuOSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6824
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_05,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504040091
X-Proofpoint-GUID: 3BJ4E51yKWE6nHoQdw3HaRryyXZyIQP0
X-Proofpoint-ORIG-GUID: 3BJ4E51yKWE6nHoQdw3HaRryyXZyIQP0

Hi John,

On 03-04-2025 00:52, John Madieu wrote:
> Hi Alok,
> 
>> -----Original Message-----
>> From: ALOK TIWARI <alok.a.tiwari@oracle.com>
>> Sent: Tuesday, April 1, 2025 8:24 PM
>> To: John Madieu <john.madieu.xa@bp.renesas.com>; geert+renesas@glider.be;
>> conor+dt@kernel.org; krzk+dt@kernel.org; robh@kernel.org;
>> rafael@kernel.org; daniel.lezcano@linaro.org
>> Subject: Re : [PATCH v5 3/5] thermal: renesas: rzg3e: Add thermal driver
>> for the Renesas RZ/G3E SoC
>>
>> Hi John,
>>
>> Thanks for your reply.
>>
>> On 01-04-2025 17:35, John Madieu wrote:
>>> Hi Alok,
>>>
>>> Thanks for your feedback.
>>>
>>>> -----Original Message-----
>>>> From: ALOK TIWARI <alok.a.tiwari@oracle.com>
>>>> Sent: Monday, March 31, 2025 8:11 PM
>>>> To: John Madieu <john.madieu.xa@bp.renesas.com>;
>>>> geert+renesas@glider.be;
>>>> conor+dt@kernel.org; krzk+dt@kernel.org; robh@kernel.org;
>>>> rafael@kernel.org; daniel.lezcano@linaro.org
>>>> Subject: Re : [PATCH v5 3/5] thermal: renesas: rzg3e: Add thermal
>>>> driver for the Renesas RZ/G3E SoC
>>>>
>>>>
>>>>
>>>> On 31-03-2025 03:19, John Madieu wrote:
>>>>> The RZ/G3E SoC integrates a Temperature Sensor Unit (TSU) block
>>
>>>>> +static int rzg3e_thermal_change_mode(struct thermal_zone_device *tz,
>>>>> +				     enum thermal_device_mode mode) {
>>>>> +	struct rzg3e_thermal_priv *priv = thermal_zone_device_priv(tz);
>>>>> +
>>>>> +	if (mode == THERMAL_DEVICE_DISABLED)
>>>>> +		rzg3e_thermal_hw_disable(priv);
>>>>> +	else
>>>>> +		rzg3e_thermal_hw_enable(priv);
>>>>> +
>>>>> +	priv->mode = mode;
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>> always return 0 here ? what, if (!priv) return -EINVAL; ?
>>>
>>> priv cannot be NULL here, guaranteed from probe().
>>> Returning 0 here is expected by the thermal framework to notify ops
>>> success.
>>>
>>
>> I agreed. priv cannot be NULL.
>> It appears that return 0 is deliberate in this case. can we add Meaningful
>> comment which help to code readability.
>>
> 
> This is a standard tzd ops, which expects 0 to be returned
> for disabling/enabling success. This is how it's implemented
> in every Thermal driver I've gone through in the -next tree.
> 
>> not sure if user call ioctl(fd, THERMAL_IOC_SET_MODE, 2) and it returns
>> 0 with thermal enable.
>> that create possibility to thermal_core call thermal_notify_tz_disable if
>> any case
>>
> Am I missing something ?
> 

That's fine. it is not supporting ioctl.
usually thermal core driver do check if(mode == THERMAL_DEVICE_ENABLED) 
condition, else part is by-default.
as it is supporting only enable/disable case from 
/sys/class/thermal/thermal_zone0/mode. it does not create any issue.
LGTM.

Thanks,
Alok
>>>>> +static const struct thermal_zone_device_ops rzg3e_tz_ops = {
>>>>> +	.get_temp = rzg3e_thermal_get_temp,
>>>>> +	.set_trips = rzg3e_thermal_set_trips,
>>>>> +	.change_mode = rzg3e_thermal_change_mode, };
>>>> other renesas driver defined as rzg2l_tz_of_ops, can be used similar
>>>> one rzg3e_tz_of_ops for consistency!
>>>
>>> Thanks for pointing it out. Makes sense. Will double check and update
>>> accordingly.
>>>
>>>>> +
>>>>> +static int rzg3e_thermal_probe(struct platform_device *pdev) {
>>>>> +	struct device *dev = &pdev->dev;
>>>>> +	struct rzg3e_thermal_priv *priv;
>>>>> +	struct reset_control *rstc;
>>>>
> Regards,
> John




