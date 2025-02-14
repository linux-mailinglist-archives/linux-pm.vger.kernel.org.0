Return-Path: <linux-pm+bounces-22070-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F36A35997
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 10:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C20918914BD
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 09:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DA822A7E7;
	Fri, 14 Feb 2025 09:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="f5FGc0bw"
X-Original-To: linux-pm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011046.outbound.protection.outlook.com [52.101.65.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB75822A4DE
	for <linux-pm@vger.kernel.org>; Fri, 14 Feb 2025 09:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739523704; cv=fail; b=Ks9A/KAnQS0Q7UdxRC1AltO9yDSlpvLVcHVv3pi8xpSFC1W+pD7xpvCqgO9KcHlpFAQUHEIWFTVh8riqo+eVUKuPoOqvqy7ohwde2mW0rq+bxxoKUNo+uiBZupHLo7t/KLXb9VVhe6sWU6F8u88LU3hKL5nGODozy50abczl3rQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739523704; c=relaxed/simple;
	bh=+aqCuylcoSUvuw2hmGZ8JgMyIKzCDx8AvKI7Z7ryBp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Viw2LfpD0AsiyFyslgwAf1UuR8UZLGeYVre4wngzFwA/QOVFoqiuVs/6WXwdN70J6ir4b+HSpacVd4kNCNkxdOlmQCPzerNlH87aaPkn3pXSuMFowNupI3Qpd1bsa7KFDP4AcJo2B3NwCx3ZPwzXfe66nkaXjp/xCdxo1qMGuF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=f5FGc0bw; arc=fail smtp.client-ip=52.101.65.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hAjowNzvgN5fpgZlisOhQ9ZhNl5qZQutKW4LSRTZ+qRWhQ1PxXOYP4WklaAfEwS3QchAftDUdSP9LEPPDlfmV08iyAvFKxultkR+cfnXzmkDb7/ukIGzDb9klOd0qmVzvBB45NVoWbPxxNsoUvDtpWfk5oZiVX1y5X1yTE1lEYnTRnHou/PLC2R8barQkyfS88IFYBDRPa5Crxh6QjR6w1GPyxFVtw6847CCSu6kt00btDKdjsUPTGaba7RWkON+KXjY7mV5HM9qiXM98ruUj1tQ2iK+JxlhQISBjCjsv9tpWr1FiIetjSSeWUvLV3gebDmofcyMZkSh0SXBKVXvuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YR07KdaXPi6yeg+tFEW2wQQpQ40CNr6qcqyI+hrnOY=;
 b=oz2cBuXoKOuCZqsVx26wR6KQ2u4kB6zDTuVDrhLbnEMQ+f9Rd4ZMWiyXGjp3jBYq9mZeIG3G4ws1En+5lXBM/tyQoIsstW0aD+phTzqfMuqfbFXxkwOVBcmp0KUf9VL8bmR9RUOBWM5gm8hYCWBXat9nSD3vLzLBCO7U7F/9rY/AOagA9hqLG+0KaYKCIy2JdkDM36fgQFhOGAz5j3kRIjHxofnxNvFhTXaRPxiGAcHtt7bGpRwSrPlv3mzNyES/XkiFxApprjFySuDweh0FYvTkzbDQwy5cGv7cWJZ/Zsxik52NqU4nS7oaNlb1cQm6VC0Z2VQt9Fij0NSEV6YsHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YR07KdaXPi6yeg+tFEW2wQQpQ40CNr6qcqyI+hrnOY=;
 b=f5FGc0bwauaO+0N7bCKCLwTNSjEtY10OSsUipMZhdHDcuLy7rMnpLZ8xsQHZUGpxBMSOf48o+k12fcwgByx5TWy9wtmA/cy4OBudFtgz6jPz8XJd0luwvIi8aP5u1sMUkt7dWkujp6CvBYM763rh9wH2Hwx+xjxwppJ0gh0cn46GQRWQC2XRfVMYxvhtCyRYCyr50fxt8b8VCKN5pkI+/6mStJ8MTzquzYDdThfosggc41wWbjT+h/A/nG+tW7Hp/pCINlHXjJvfKqSAnUns52jvXPUA4IteI1P3uGOly0tRCCyrjIE8yV1q7O8x9Zl+R0ExuJnnye0SPyRTdkC6Ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by VI1PR04MB7150.eurprd04.prod.outlook.com (2603:10a6:800:12a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Fri, 14 Feb
 2025 09:01:38 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%6]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 09:01:38 +0000
Date: Fri, 14 Feb 2025 16:58:19 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: len.brown@intel.com, pavel@kernel.org, gregkh@linuxfoundation.org,
	dakr@kernel.org, stern@rowland.harvard.edu,
	linux-pm@vger.kernel.org, imx@lists.linux.dev, jun.li@nxp.com
Subject: Re: [PATCH] PM: sleep: core: Set is_prepared to false before
 checking direct_complete
Message-ID: <20250214085819.3ftkjupuivdzgayq@hippo>
References: <20250211034423.833783-1-xu.yang_2@nxp.com>
 <CAJZ5v0idzf1QKf8UKp4ttepLbipZD6b1RFHX7QqgQCyJZL8dQg@mail.gmail.com>
 <20250213105306.vz2xirvffqaycz7z@hippo>
 <CAJZ5v0jEd1hdssAeLXUMqAuqFsc1Pcebm3eEUP0wrx39xG2TwA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jEd1hdssAeLXUMqAuqFsc1Pcebm3eEUP0wrx39xG2TwA@mail.gmail.com>
X-ClientProxiedBy: AM9P193CA0005.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::10) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|VI1PR04MB7150:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d903d68-d4c9-4b6f-617f-08dd4cd63092
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEQzRHhnOHhIUzFlbU5Ra0VEK0tCS3JkWlh4eGlWQmJqR1k0N0hYNWZxY2g5?=
 =?utf-8?B?NDhsbUdjK05YaHN2ODlJaVYvT2ZiVS92cDlFWE9XZnoyV1dEVE1adkl0Q1F2?=
 =?utf-8?B?WkxSWmtNREtvZVI0VERrTStQeFhiQ1dMRlNEaVFNcHBqeHkrcTlSVTFRekh3?=
 =?utf-8?B?cHdtNUJoSTdUYk5FMjk5VjFJNWZ0cU5lTmNVVkhVVm5vUGEwOVo1SG1kNmdM?=
 =?utf-8?B?MmJMb0U5OUx1WG91WE40QktZZ1l2b1V5ZDZHTnFRSkRlbHRjRFR3QUFZRThJ?=
 =?utf-8?B?bGFINUZKYUdhS29ETE4rMUdNNEhtUjdkTHZJZmFhajZ3TVBCY2prY3dqV0d1?=
 =?utf-8?B?WWhraFRaVTFoai8wSDJNUmRJbTRhd29vcy9POW01ZWhBL1ppV01lU0kveXV0?=
 =?utf-8?B?cm0remdKdndCd1U4M25GMDJ5bTdMVHY4MUptV3JmazZUSlppalkxSXlwcU1K?=
 =?utf-8?B?OWhZKzhZSUh5R1laeEhabWtCWEJnUE82Y0NTRjdQZGFqZEErZ2NLem5tU0lm?=
 =?utf-8?B?SGNLd1JoVVQ0Z1FRK2VxVWt4VTJlZFhQZVpFZXVEaFpSQ091Y3A5QTdxbTVp?=
 =?utf-8?B?VG1rcDZhcVJiOUZjWlpNbmJLNDZjdDljUU1xZVNldHdWOVc5WnB3RW9YMFVL?=
 =?utf-8?B?a3VRNUs3QVVGVDM5TVBjdTJONXl4UXZBTHE2K0huOEs4UWhXQmVpOGhtMnhw?=
 =?utf-8?B?N2U0STdaMHZkSUVvSWl4a3ZjWlNmem1GMnpxUE95SXJBeGpYdXNQQmdVRjZW?=
 =?utf-8?B?WTlRODVJQ0ozMitDNDJPOWdhR21xbVRmS3RUTXRSRjdKVEE4MVhQS3c4REVr?=
 =?utf-8?B?dHUrUU1qaXpWMVV0OS8vM3hwOElxOWhiL2t4UWtnSXRUZEVwcE53amNIQUIy?=
 =?utf-8?B?V3A3RHBEa3REOElOWG85OE1ISmFtWWtuN2dwdEk3SkNOYUdlaGZEUW1uSUtw?=
 =?utf-8?B?MWdlK005dUlVNnUwMzZ6NmQ1djR5SU5LU2RjZGhSU3lRb2xBU2FnVEpkVEs5?=
 =?utf-8?B?YmgvcGt5bHpPK0dla25xMlB3ZlIxSUU2TC9CYUkrWkVPTmVMRzBEeCtQejBr?=
 =?utf-8?B?RTdRbk5yVm1ocWcyN3N1ZzdVYWRFcmpvS1B2Ykp6OHpOWE0xUDBIYUFQUk96?=
 =?utf-8?B?VzAwcmk1NUxONVMvUmJrdW5hN0tjalVwQVZ1UjJkN3RFN01VZTR5UVhsb2M4?=
 =?utf-8?B?WnI1MHJ0Q2ZYcXBabGtZNEwyZDJXMVI5blNDdllBcU5hMnErWHdzWEJOclgr?=
 =?utf-8?B?cnR3WUo5YW5tMmNiVENSUXBWNWFRZC9GeGxCek9zdFlnYXB5c2RzNGd2TGRD?=
 =?utf-8?B?eEQxTXNpY3hyRlcwSCt3RjdSMEpBMTJoN2dmVVlwR2pjaGErTkZINVNTM1VO?=
 =?utf-8?B?Y2kwdXp6WCs0bGpDaUhGMTk1ZTUwc2x0clcvOHhMOGMxMFBnK0NOT1RGL014?=
 =?utf-8?B?R0FNd0ZSSTZITGJsajhWMnpYWXJaWjJZcU5VeUFiZEV3MVhmdVVlN05Kb2tW?=
 =?utf-8?B?eTY4Y2ZTY2tzWW91cm0zVUNmTW9VV0p5SEtwL21LK0U2a1h5YUJEejU0MGts?=
 =?utf-8?B?YzkwNVpPQThlNm9aSmp2VTBDQXJNOGh0cW5ubTFBUmRvNWhTWXVUNlBXYzM2?=
 =?utf-8?B?WG11d01hNmE2a1lPZG5jNVNKejRMaFA4MjRra0ZhQzZkM0Q5d0svTWZEeWNN?=
 =?utf-8?B?UFlabVFxbmNCY3ltWDhuU2JjcXd3NEY3K1BiUC9BSlJkeCtmY3pkOEZmSXBV?=
 =?utf-8?B?VmJUc1V4VkpyYTVCdVB0dSt1bjF1UGdhSHpJWUpoaDJSZmhCUlpXdUlZSG90?=
 =?utf-8?B?RHVwY0VlbXY1VVFGVkRrTTA3VjBaem9JWGtwWEg4YjZKODVqZlI0QyswelpK?=
 =?utf-8?B?ZUZpOEVnMHhlcFA2UTNWeWlQcllSMGJRQTFTa0ZPWFUvMWFYUmV3TklLc3pT?=
 =?utf-8?Q?RFDFTTjoVS0qgG+f4GEKE/i717rEVWKr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUtvN2Rxa0xXTmhiRFlqTDJOM3FJQzYvV3k4SjhaT2hFVzF2WU5IbHdhZ3JE?=
 =?utf-8?B?TjNBbW5Hem15aGZQYlhKYmh4ZmZ1eDBPS0ZLV0swWUtBNHdpUzQ4TTdDUXgx?=
 =?utf-8?B?OE1TTHMrY3FlcE1vTkF5clNnZWk0RXgxSVlZM0VyWmduMTJqVkpaTW5GUlFX?=
 =?utf-8?B?dVVqRlJyMkFaekgzOWlJamJUcG5UZTBMWHk0Q1ZuWHNqSm1sa3hDeFcrZzJs?=
 =?utf-8?B?YXdWSWZSOU1ZQzI5dTd3dmNadVJTMWtNK2JNRzd2RUhHSjNEOUdvbGFIbEx4?=
 =?utf-8?B?VTl2RnJWQW1QcmpJSDdKWUFuMFRSd01SSHpZNXBPT0lDV3VyQTFxKzFEMXZJ?=
 =?utf-8?B?MnFoS0J5V0s2ekkrUDlHdTBhOTIxVERUekphNVhKaERmUFlSMS9IMEVBUVN6?=
 =?utf-8?B?NDUyWktzdFB2SXBKNUJkNWVCcjlDeEtBSXNtd0V2RmhueHRkZjMzNUZNUzB4?=
 =?utf-8?B?NldlaGF3RDZrM2s2V0VPZjZpczg5QVdLM3ZJY1ZNSmJCWDc5c1QwVHFUMExL?=
 =?utf-8?B?b1RCcnlRbWYzd0VsNlFJcERyc2NSMlhVS1VzdVJ4Mm9pOGtNQU0yZWsxeE1Q?=
 =?utf-8?B?am1wZGZ5VUdxNyt3c0p0eitPcDFjU0ZwbTFNaUtGUHgxelExZi80alBRMW5q?=
 =?utf-8?B?QXhrVmJzN05UR3ZDUGZ4bmZDbnNkdXZXcmN4QUg2ak1INmFTbUc4QTdzdGNs?=
 =?utf-8?B?WFBWYldZakZLTzViV29yeU9neFE4dUhQU2NmTm5jdDc1VTB3Z1VqM3J5Y2xL?=
 =?utf-8?B?QUpHYjVnMDJ4UWMrRkg1dzNwNitOVkhPdUp2YlVrWVBtUVoydXBTQUtDZTc2?=
 =?utf-8?B?bHd4ZFJPR2EwUDlRZFIvbEl6bU1FOVJVYWZZWHZ6Z1h6czVSbVN1ZGVuZHR0?=
 =?utf-8?B?dGVBTlNiZS9JNzNrbHBXdy8ydHF5K3JPMjlLYVZ2TzlsaTNmUWVSRFFJNXV4?=
 =?utf-8?B?Unh1MWJzZWFhdmdSK2hHQ0lhWTFvSk83MDhPb0Q5ZUVISEY5L1JUaEN4U0E4?=
 =?utf-8?B?TDdYUHJjTXg0MWxpZENtU3hQM0JtcFEzWTd4eHp6S3JUTXBOcDFNRUNsMndW?=
 =?utf-8?B?YmlsQ0p1T3B3N2gwZkFHOGJibVEwUm5JZDZPcHZpRmJJTVJrdERSODBnMU5B?=
 =?utf-8?B?bVc4Z1NEYzMybkNIZnkyREFkTFQ2Q01LdXZKdEgwUS8veDVQdWhkeTVXd0li?=
 =?utf-8?B?Z1ducnJiTHptY2JqVS9lK3c4YzBwWXNoTVF5Q0JEdEJ6d1F0am1mRjFnV3pM?=
 =?utf-8?B?QjQ1RGpwMExGSFJCcXBIZHZYWnh2Ty93TnBJRHNNei9yVGJoOFJsQityZmpZ?=
 =?utf-8?B?ais0K0hHeW9lSEI2bVIvNUFwcDFQWTJKWHhRelluNGVoMVM4aml4Qm56Z1c5?=
 =?utf-8?B?ZGprclU5aSs5SEl6aWZ0VUh0U1lCb3JQRURJT0FnZ1NsTGNleS9UNXBGNjlx?=
 =?utf-8?B?cHBkM3FBaTNYcGtQZFRuUmoxV0JGdmlXeGhtTTV3YWN5Wll3cFdRR3A0cm9j?=
 =?utf-8?B?VUMyRTVYaUNxcTZOYVpPd09tWTBSdG15Ymp3MXZjNU44cXJna2VYOWpCRWM5?=
 =?utf-8?B?UjhrWTVIbTVDaTNncEQxdmdsVi9BNGE1RThUZTFJbllLWEpnTlFPRW50NGVR?=
 =?utf-8?B?bTkySUFHL1BkMTdWVks2LyswSnROa003cFNzN05lLzBmZ0VOSXdURG9ZRTRV?=
 =?utf-8?B?aEFjcjREZm1zVStuWmpQcGRGQVZHenVQa2FabmNlMGlLc3ZMZHJyVHowNGt4?=
 =?utf-8?B?d2p4d0lvbDFGUGFCL0RVSE5jSXdwQ2NyR3FTU3I3U0VDeFZPYkd1MlpoYW1o?=
 =?utf-8?B?VTB6cVQwVURiQzV2bmZrcU5HbHc1ZkorVFFoandXOEVWM3dEZmx3TGQzWFhE?=
 =?utf-8?B?bm9UMjc3aFk5NWdzRjJIN2FrZC9STldhbTRXR29UMHBMOTFFQTMzbU94TVhR?=
 =?utf-8?B?T0JEWlh0UHROeHV3THFVRFB0Skd1U0tjSW9DZmwwUFBFZ2NpVVJzdFZGTm5T?=
 =?utf-8?B?SDFvYzVCbVBiL3B3WGlNVlFROCtHL2J3QzhkZVdjNisvR1pKNHlTK1d5bkIx?=
 =?utf-8?B?cXFVWGJCSzhuOHh2SGJMS0ZIZDdNL2o1THI2c1d3M3RUcEJRb29CUlZSMnBI?=
 =?utf-8?Q?IF6s+i76oLB7LhwNBua9RT0Ce?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d903d68-d4c9-4b6f-617f-08dd4cd63092
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 09:01:38.3142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8H+05dHv3Nvk4iNFZbEmflNhBefEl1RSvmCNAMTzeDZY8qLVwzl+6b+uaTW4y2lrOjCdgiKYm/FkLhSF+HgX7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7150

Hi Rafael,

On Thu, Feb 13, 2025 at 10:20:30PM +0100, Rafael J. Wysocki wrote:
> On Thu, Feb 13, 2025 at 11:56 AM Xu Yang <xu.yang_2@nxp.com> wrote:
> >
> > On Wed, Feb 12, 2025 at 09:55:00PM +0100, Rafael J. Wysocki wrote:
> > > On Tue, Feb 11, 2025 at 4:43 AM Xu Yang <xu.yang_2@nxp.com> wrote:
> > > >
> > > > Currently, if power.no_callbacks is true for a device, device_prepare()
> > > > will also set power.direct_complete to true. When device_resume() check
> > > > power.direct_complete, setting power.is_prepared will be skipped if it
> > > > can directly complete. This will cause a warning when add new devices
> > > > during resume() stage.
> > > >
> > > > Although power.is_prepared should be cleared in complete() state, commit
> > > > (f76b168b6f11 PM: Rename dev_pm_info.in_suspend to is_prepared) allow
> > > > clear it in earlier resume() stage. However, we need set is_prepared to
> > > > false before checking direct_complete after including direct complete
> > > > support.
> > > >
> > > > Take USB as example:
> > > > The usb_interface is such a device which setting power.no_callbacks to
> > > > true. Then if the user call usb_set_interface() during resume() stage,
> > > > the kernel will print below warning since the system will create and
> > > > add ep devices.
> > > >
> > > > [  186.461414] usb 1-1: reset high-speed USB device number 3 using ci_hdrc
> > > > [  187.102681]  ep_81: PM: parent 1-1:1.1 should not be sleeping
> > > > [  187.105010] PM: resume devices took 0.936 seconds
> > > >
> > > > Fixes: aae4518b3124 ("PM / sleep: Mechanism to avoid resuming runtime-suspended devices unnecessarily")
> > > > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> > > > ---
> > > >  drivers/base/power/main.c | 12 ++++++------
> > > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > > > index 40e1d8d8a589..69d0f9ca7051 100644
> > > > --- a/drivers/base/power/main.c
> > > > +++ b/drivers/base/power/main.c
> > > > @@ -929,6 +929,12 @@ static void device_resume(struct device *dev, pm_message_t state, bool async)
> > > >         if (dev->power.syscore)
> > > >                 goto Complete;
> > > >
> > > > +       /*
> > > > +        * This is a fib.  But we'll allow new children to be added below
> > > > +        * a resumed device, even if the device hasn't been completed yet.
> > > > +        */
> > > > +       dev->power.is_prepared = false;
> > >
> > > Well, not really.
> > >
> > > This is to allow new children to be added from a resume callback, but
> > > direct_complete devices are still in suspend at this point.  You can't
> > > make this change for all of them.
> > >
> > > You can clear power.is_prepared for devices with power.no_pm_callbacks
> > > set before the dev->power.syscore check, though.
> >
> > Okay. Thanks for your suggestion.
> 
> Actually, this is more complicated than I initially thought, sorry about that.

It doesn't matter.

> 
> While it is true that is_prepared may be set early for devices without
> PM callbacks, in principle they still need to wait for their parents
> and suppliers to get ready before this happens because the new
> children may depend on the functionality provided by those devices.
> 
> However, IIRC in the USB case the new children are added by the parent
> of the device in question during the execution of its resume callback,
> so is_prepared needs to be set before that callback runs which is not
> guaranteed to happen so long as it is done in device_resume().  It
> looks like that would need to be done in device_resume_early(), which
> then would be questionable because of the above.
> 
> I need to think about this some more.

Looking forward to a better solution.

Thanks,
Xu Yang

