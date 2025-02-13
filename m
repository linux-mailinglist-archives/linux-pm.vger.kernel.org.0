Return-Path: <linux-pm+bounces-22005-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA1EA33D11
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 11:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FB603A846E
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 10:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97346207641;
	Thu, 13 Feb 2025 10:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VNK6rHTJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10052135D6
	for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2025 10:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739444190; cv=fail; b=ON1TgDA1Cuefr+CzNzeGyUkOg+X03R4TnmcRPJuE8H4CpcA4GVcdosaXshSBiNXr30c8mpMi5O2oBvmvP57MHyFgUO+wgwJW08P1Z1FTkyZAakELEA9zOIyEa9Lq+WdT3Kd8IGiAKRi1lgIIFVDr1qqEqWEX4pJEzEE34CWyFzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739444190; c=relaxed/simple;
	bh=qGHvGC747OW5Kl8QvVZe8VzC3xBIQLI22VLIjWKJbmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eton3f6ohUlIt1JmPXPLG3HESnmnrO/z8P4IFBHYNl0HtXgJVszAJlnR3P51O1Y57Bx7jbxBBh1UTvWCGTPA7+1hMp05eI+Ed+YZf9z953JW4NUDElnrqqZvcCMGSay2Y3KrduUAK0YCdLzwI0jH4FCFNinNS051YAfD3CqhLAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VNK6rHTJ; arc=fail smtp.client-ip=40.107.22.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jg14DRNGJNYXmk2cLjsLySccso4NXUkocG+FJ1U9Zjq10QHdJFD5CTrecS+GVIVsj4ufr2TQP/G0vaQMawBHW5Djpggj/I0QK3ekc0QMNEv8pXPvdj0WxE+FnzIpTHkJ054i9JsGYmkL8LCFYtbES+HD8Hq0CNeWWN9rAlFdMV+yYLwAjn8q7FvgeGIY35NJ+pTts69fhTBk6b01oUSbzTUJ2yojoc6c9ys5NX47ywpMoqRTPDFL60fedT7dtIYzoIUHvlu+JGSjSsQ6hhbyQ3qVPGbPj1Iu9USWNBdgxSE1wKaklRsjxLQ5rFfcPSoEXOi5dcipFRzK2JTJMKilNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+BOMpjYacfuCNpWQ9i2u3VK9OvTppWperMpmznvdnk=;
 b=HmASWMk3pKHgraOmNu6/9aRbUW9b4SFlg2TGAQXGUjI63GJvfs1ib/biJgLqjRZPpOb/s8phfwTXaU3Q6n5w5AGrdEu22QSLkQ7TK6C20XNqD3AQUgTFcKpDDY8k38QdLQFMJrj7CvcSYjsd0csnwGmPkrtjmUNLaGsfRt8gGyA2Cpbf5O0D3JdIkzVX9SCSw7yuM2GNYa8GtTaKTNgVLxtntqHnPLtagfCJOq1GxfludccRGStOg9Rdq7cpQU0NIg/8ULhwyMjWRnpsZCxhvfafi/+Cu7aakNeVjaQ2owhtn49q5gMqZ6SxdLTxvRHe59A2SGRyrG6XG1oW5hkAuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+BOMpjYacfuCNpWQ9i2u3VK9OvTppWperMpmznvdnk=;
 b=VNK6rHTJ/+tXdUbKPjtGwk3qvdYlbq6DM2K585wnOYeHKNswDMTcDqy6QjSCMnULv/hUk+yEGTVjICfIEm4Ub8+Hu6Wyfe6jjvEVRBHkP1HaCOs2oueYF2nMzjy9QtmdM0gwYRZdiormi2G52QJ3G+Zq+LkyU1y88x24EDrsB6JF68evdXGqFaklor7KkiTAe+TzOf4r6QPo391TqcgTuRwsxFgwleg5dG/Rwp5tpsBQAtswZWdj9Cd75fxcZCIj/OnFy7Z5Xq8ZmpOnVg6jCGRNIEwp2EEdyob6mHsGFykhBGpgbYcWiOMXmWEktaxesADGwZstQHngYbrHrfsSBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by GVXPR04MB10779.eurprd04.prod.outlook.com (2603:10a6:150:21c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Thu, 13 Feb
 2025 10:56:24 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%6]) with mapi id 15.20.8445.015; Thu, 13 Feb 2025
 10:56:24 +0000
Date: Thu, 13 Feb 2025 18:53:06 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: len.brown@intel.com, pavel@kernel.org, gregkh@linuxfoundation.org,
	dakr@kernel.org, stern@rowland.harvard.edu,
	linux-pm@vger.kernel.org, imx@lists.linux.dev, jun.li@nxp.com
Subject: Re: [PATCH] PM: sleep: core: Set is_prepared to false before
 checking direct_complete
Message-ID: <20250213105306.vz2xirvffqaycz7z@hippo>
References: <20250211034423.833783-1-xu.yang_2@nxp.com>
 <CAJZ5v0idzf1QKf8UKp4ttepLbipZD6b1RFHX7QqgQCyJZL8dQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0idzf1QKf8UKp4ttepLbipZD6b1RFHX7QqgQCyJZL8dQg@mail.gmail.com>
X-ClientProxiedBy: SI2PR01CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::8) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|GVXPR04MB10779:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eb1b7c7-1a55-4e1f-701e-08dd4c1d0eea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eTl6S0VqYWZVcC9nRjV4NXV0aDN5TlJCMytDVUM2dDQ5azM2Y3p0Tm12clhy?=
 =?utf-8?B?cVdHQ092UGUxTFNRL0dmdE5haE1TSHdIMjBjUHg4YXU5dU1VaXcrOXp4VUhx?=
 =?utf-8?B?UnlwRlIwQjJndVR5TzJNOFl6dWtFajVNWGxqNGRTYkFEbklGeFg1a3RrSlVP?=
 =?utf-8?B?UUpQK2FDSThGeHRueDJDUE1KTXJsZTVKK3Z3c1N3ZnhhUjlKc1J1OTBnZGgx?=
 =?utf-8?B?QVpkUndyVld5ZHNXZHE3VXUvNTkrY3d3NU1pUUhtTXJmUkN1YjdCTFN3QWVl?=
 =?utf-8?B?NVJ3Z1R5NEdVekxKekRiQnFmUlFCRmVWQWphZ3pCWTU5dEdJaTdzK1VrOXBN?=
 =?utf-8?B?M0pHaW9CTk5yQjBPUGZnQlRmU1lmWitSWmRGVmYwaG9JQlBYcWZBeWZTTDJL?=
 =?utf-8?B?WmJoZkFNTkE1L21NaDZzM0JHdUVodW9xNThDdm1Cc2NISUNNd3hRSHNPbkF3?=
 =?utf-8?B?bm9DengrbEh5TEpBSE9GTHBwZTV2WDY4MnVrSzRWMlcwbnY0MTVTdFhzTk5Y?=
 =?utf-8?B?ZVI2dGthN3lEOERROGdKaDVJS1pkd3R6QlM4UGpOZElzWkxBWlJaL1ZNeUh2?=
 =?utf-8?B?cS9HK1orM2xlMGo0ZUVMZkpjb3hLY2FXcDVIRmZaQVpMcUFRZnJXWlFBUk51?=
 =?utf-8?B?ODNkK3NHTVcrWlYzZzI0NWtRVlRLZGdLaUNwZkRqaUtxMEF4WHRrdDNSSG93?=
 =?utf-8?B?QVMrVm9sd3dpYVRqZDM1MUMrZ0J2YjZOOS9WdHpiSXVXeHpzRnh5YzZZNDkx?=
 =?utf-8?B?SnR2VkcrWERrTlFicXpVRVFQbmZmV2NZN2Q1dCszNXBtdklMVm9WdzJUajVj?=
 =?utf-8?B?ckx4ZHpuQXJUcUxPR2d0aE1ldVB6TE9oRWhIelpKMURrdmFEZVMzaFpSOUtX?=
 =?utf-8?B?NnlSRUJIWDludTYwSjN3MHl5NVZabkV2UzAvYjdwWDhKcWlYRHUvcmhacHE1?=
 =?utf-8?B?cnE5eDVHbHI3c3pOZUFCYVZJSWpEZXJzOWRabkIrOFRhOFdTb2ljSHVoeHNV?=
 =?utf-8?B?MHRJQXRiTGZZQUoyM2lpL3BRMXR6enRlK2ZSaTViOUd2WVNGcjRxNWV1VFVa?=
 =?utf-8?B?NzRLUzVtOXZFbnpmV1dwTUY5aTB4SVBBWHlUWlNSTGZESjRKZTBNbUdsL3VD?=
 =?utf-8?B?MkJwRk1Lem9DcWlEYVVGekFJbzZob2tTdFVaOWxFUS9ndHZGb0dHcERZc3Fu?=
 =?utf-8?B?cngwZllqT2IzUW5QekNJVFRFQVBFb2UrdTdFVGIxMWtUeUx6aWxFWkxBWG1X?=
 =?utf-8?B?SVFpeWtuVVlRenh0eHpWMzVzRUx0Q3FIMFdQRmNvcVErZ1ZxZlZKQmllNUFS?=
 =?utf-8?B?aURTZjlSam1tbEMyUXJ6TXVscWM3QlErTDNaVXhSTTBaZlNxWkNHU05RWldx?=
 =?utf-8?B?YlZHMEVJNTNhK1JLcys2MmlBM2U5NUtzdFNwYjNQb2w2VUpNQ2kzQUxaV2x0?=
 =?utf-8?B?UWZCOVgydTZJR3hyNmxCNzVnZVFZWE4wcXErNkRlb1VqbE9OOTQ0OHhxOGFS?=
 =?utf-8?B?dnc3Z0w3c0ZWV0R0Ykl3UjdtVkN4ZUQxVU5NRXR5N1ZQbk92cFFYREw4RVo3?=
 =?utf-8?B?b1FhczNrR05CTUI0cGV0VVlJcXJaV1hrNFJsN2x4cHp2RDNlcE1INXAxaVUx?=
 =?utf-8?B?cTJqdHBVeFdWZzZFMSs1cGVUYUdxSmpVUmpTeGg2ZzFSNWE0T1NaQ2RUMmRm?=
 =?utf-8?B?dUlqeUJQM3MyYWc1S3dCdGtZM3Q1QktRcVFScGV0MlM2VlhaZFpXNTVYWHlk?=
 =?utf-8?B?aDFyZnN4K3NRNkdKamY5Mk15ZGd2YisvZk9WQ1FjSVJnaG9QVmhzNUxTV1hK?=
 =?utf-8?B?RGNoZmxmdFh2THFpRUNBOS9oNm0zNjdPaVhmdGJHVjRnSFpNN1BxSmdWVmgr?=
 =?utf-8?B?eUhPNGR2a3NHaUg4ZVo4M28vZmorU2p5d2tubzBHaTgvYm1odmFwbEFXMmRS?=
 =?utf-8?Q?j2ArtaUfJBZ6WlK76KdaUGUvF+XcrKvm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkpGbnViT0h1VTBCYXl0SEo1bSt2VVR4RlE1YkMvM3VWdWJRMndXcjkxVzY0?=
 =?utf-8?B?Y0dKbzI4dnVwbGJqdTlVRjBKM0NRY3JSc01VVUtnRDZpbzY1NDM1Rm9CNmFn?=
 =?utf-8?B?L2FBZDFvdTIzWldRZHgyenZvWFJ5R0ZaaE1Rc1BrUEF0VG4zeEJyMGxwNU5F?=
 =?utf-8?B?UXZMa3V0aExmc1NtSWExNStJSWd6cXducEw4UG8wODVDdy9iY0o1UUJPUE9p?=
 =?utf-8?B?WkJWRFVXS2RCdHk5M0ZNRVZ3OTZpZlZJT3ZSWVU3VWVDUzhpRkwyQ0x2T21J?=
 =?utf-8?B?WlI5SElwL2UyblRNVjc2T0g4dTRMNkZvYVNjRktjbUc4RUw4UFpCVkxzT0xi?=
 =?utf-8?B?eU5teUlETXhIYWEreG5jblRKVnJSN1BMZm00WWhvVFYzQmtJRENYdEt6cUhY?=
 =?utf-8?B?dXBnWGtsK25NSEtKa3dqM00zS0pDaC9HbU1jUG0vaTFxQWw4WndiQzZCVDlC?=
 =?utf-8?B?eHU1NVBIaU5DZ3c2cXdvUHR2OTlKcmhsc3VsVG1VdXdWSXNpZG9aNDErSUlE?=
 =?utf-8?B?RU03QUswdk9ZdVQ4amJVRENKbzdvNkllRS9STVBEdTl4L3YrbGYvS0RKbHRm?=
 =?utf-8?B?c3E5TDJETCs0RzEvR0pOT0ozK3Q1bEJKUE15bitnS0xQM05VdHdiUWF5dGFZ?=
 =?utf-8?B?RTU0ZUlVTHJkNE5udXczS2ZuMUsySFFVUUNaaTRJV1d5U2R2QlVDTDUyaTFN?=
 =?utf-8?B?a3FoclRpTTJtYXhDOC8ycVRYVitCVk5EWGlhelhURjQxSkpIVTYycEdRWXlI?=
 =?utf-8?B?RlNuQVFtWkNqVVE4Mi9wN2QrVzBvNVZhc0RLTzR5eDRKcmpLV0R2VVJzRE9z?=
 =?utf-8?B?R29JdlRLQ3ZvWk5MNE8wb3kvVS9Lbkt2QlI1R0FoZG1aTVV0aW9NNGpqeTBw?=
 =?utf-8?B?Wm5XUUxFSXFJRXJ4L3JIM1JqUytsSm5Gc0dVRkxaOTVRTWZVMGVPVndhY3p2?=
 =?utf-8?B?ZGxTQmdCamswN3pENVRRVDFyUkY5TVZXS2ZUako0enROZ0lxNHJROURtbm55?=
 =?utf-8?B?SUZJRXdGWU8xSGxyeFQ4Mm9ja1UycTFxU0pMbnpReGIyZk9MMzdTbXl5ak5j?=
 =?utf-8?B?dzhGb1ZzQ25xcUw4Z0psdHV5bS8xZ1BDbjlud1dGZXhOV0ZaU2Z5M1RuUmpU?=
 =?utf-8?B?djMrSEhpTTFwbk5xNXFlRDNidW44elViRk1FOWRuSXVKS2h0amo5dER1SjFl?=
 =?utf-8?B?aVVaOE5PY2czQXRoSXNNT1A1ODVNQUxzcVQzWUt6alpzYVEvNVl4ck9rb2Jm?=
 =?utf-8?B?eXgvenJRMS9YdE5pRXFaSUV1eU5tZmthQXpTcE12ci93bTVvZVlEMzRBb3dz?=
 =?utf-8?B?bGlsdWlaazRPZkptVXBOYld0cXFEdzR3K2doc0lnOEFPSWpYaUFib200NUE4?=
 =?utf-8?B?enZEcUVGS2RZOG9xL0wybWdSUTMxQlowL1BEb1JzUm5LTWhkcUs3MDR1RXB5?=
 =?utf-8?B?Um95RkJyUExEN0VIVVNlWWlHWkFKMHZ4Q0VGa0s0dWM2ekIxSnY3YjJ0UGc4?=
 =?utf-8?B?L1FWSDd5N1NjRk4vZ0NyT3M4SnRray9hbHRoTUNMclozQys5RUhpMTNmNi9D?=
 =?utf-8?B?SGZyL0RQajZ4a0k2cFNWZ0pPcEVSZWNtMG5PbTc5WUhkQXRiQXlMVS81dFFI?=
 =?utf-8?B?UHZjUEZydnFENXdGVmxUZHF1TzZRYXlGMUhuWGdHaTFLZ2NveGpwT2hZalRa?=
 =?utf-8?B?ZStrSnI5WUlpaHpjMTVKL0NMUjVqUCtlcU9BVXNTVkx2VTRaQk53V3AybUls?=
 =?utf-8?B?clFFUmYzMzVUQ2NoZ1pIYm9ObWhvZ0J1SGRHVzI5Q3l0ZVdkczUvUVM1eXBF?=
 =?utf-8?B?N1ZBQ2NITEJEVU03SDJrbS9GaGNyeWJzODkxcHluUFVxL3BRUDVyS3ZSZWl5?=
 =?utf-8?B?K1BWeU5kSFpuZ2hZTkduZmR6ck80Q0dLZWVsZjBaUDFxR0pIM2dzcmZMTkhw?=
 =?utf-8?B?L0FMQ3M4NDcvcCtUSUYwRGE0L3ovQ2twRmdCT3cvayt1QkdlM0JONHZTWlJt?=
 =?utf-8?B?VlhPRDI2Wlo3R282V24rdjUvTVFEOGNka2I0K0dkU1VMY0pERWx6eStvUjVM?=
 =?utf-8?B?RDExNEpuS3hGL2I3ZkVNcWcweWdveUxvb3N0UExwQ1VGZDBMK25EV1pQOW5J?=
 =?utf-8?Q?hGw9ujMADX8BQ8aC3bHzOGFK+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb1b7c7-1a55-4e1f-701e-08dd4c1d0eea
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 10:56:24.6516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BtVC2Gl2E6kCTmPmnJg7S+FKOrSX8D2XhrMQICHj+0CXr8ZesmBN0FmI5keeKivKrcBeWnRD8O8UgrkTctFqog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10779

On Wed, Feb 12, 2025 at 09:55:00PM +0100, Rafael J. Wysocki wrote:
> On Tue, Feb 11, 2025 at 4:43 AM Xu Yang <xu.yang_2@nxp.com> wrote:
> >
> > Currently, if power.no_callbacks is true for a device, device_prepare()
> > will also set power.direct_complete to true. When device_resume() check
> > power.direct_complete, setting power.is_prepared will be skipped if it
> > can directly complete. This will cause a warning when add new devices
> > during resume() stage.
> >
> > Although power.is_prepared should be cleared in complete() state, commit
> > (f76b168b6f11 PM: Rename dev_pm_info.in_suspend to is_prepared) allow
> > clear it in earlier resume() stage. However, we need set is_prepared to
> > false before checking direct_complete after including direct complete
> > support.
> >
> > Take USB as example:
> > The usb_interface is such a device which setting power.no_callbacks to
> > true. Then if the user call usb_set_interface() during resume() stage,
> > the kernel will print below warning since the system will create and
> > add ep devices.
> >
> > [  186.461414] usb 1-1: reset high-speed USB device number 3 using ci_hdrc
> > [  187.102681]  ep_81: PM: parent 1-1:1.1 should not be sleeping
> > [  187.105010] PM: resume devices took 0.936 seconds
> >
> > Fixes: aae4518b3124 ("PM / sleep: Mechanism to avoid resuming runtime-suspended devices unnecessarily")
> > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> > ---
> >  drivers/base/power/main.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > index 40e1d8d8a589..69d0f9ca7051 100644
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -929,6 +929,12 @@ static void device_resume(struct device *dev, pm_message_t state, bool async)
> >         if (dev->power.syscore)
> >                 goto Complete;
> >
> > +       /*
> > +        * This is a fib.  But we'll allow new children to be added below
> > +        * a resumed device, even if the device hasn't been completed yet.
> > +        */
> > +       dev->power.is_prepared = false;
> 
> Well, not really.
> 
> This is to allow new children to be added from a resume callback, but
> direct_complete devices are still in suspend at this point.  You can't
> make this change for all of them.
> 
> You can clear power.is_prepared for devices with power.no_pm_callbacks
> set before the dev->power.syscore check, though.

Okay. Thanks for your suggestion.

Thanks,
Xu Yang

> 
> > +
> >         if (dev->power.direct_complete) {
> >                 /* Match the pm_runtime_disable() in device_suspend(). */
> >                 pm_runtime_enable(dev);
> > @@ -941,12 +947,6 @@ static void device_resume(struct device *dev, pm_message_t state, bool async)
> >         dpm_watchdog_set(&wd, dev);
> >         device_lock(dev);
> >
> > -       /*
> > -        * This is a fib.  But we'll allow new children to be added below
> > -        * a resumed device, even if the device hasn't been completed yet.
> > -        */
> > -       dev->power.is_prepared = false;
> > -
> >         if (!dev->power.is_suspended)
> >                 goto Unlock;
> >
> > --

