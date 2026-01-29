Return-Path: <linux-pm+bounces-41732-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id LfJaEF7Je2kQIgIAu9opvQ
	(envelope-from <linux-pm+bounces-41732-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 21:55:58 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F6BB45D9
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 21:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF9C03012E8F
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 20:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F8135A955;
	Thu, 29 Jan 2026 20:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KT35gbTF"
X-Original-To: linux-pm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010005.outbound.protection.outlook.com [52.101.84.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4B135A945;
	Thu, 29 Jan 2026 20:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769720154; cv=fail; b=gnpMnRlNzIGWa2LlYVEgI39Uo0Ys8rXMiZ/4LKTZfqLNiH9ZqvaJtNAVBnEMGjcFvxC2pc7jQzUG5TBbLgC1H7zk4CRr5dTYeT2kU/+Ae03ZR7vhX9rTI1HMPaZeCJ4rMhHnrkMUL1qF4P70+KcPDsRx7pCkOGV6LK89j4xXP3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769720154; c=relaxed/simple;
	bh=1i7C+RHqu7TWSjKcB8MvIATAo+SyJkmzuK6h7FRSyCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h1/LL2byWvhhA+GhjchfJWlswhOLJPQZQ/12WJDB7CIm3QFrz5HJtERtlGsQY1q+LKZpe9uPDR1g6sXvw9TciYh3XFaYBtHnGt592BSsSfjgyK0jb7UvbDW4pykY3MC0Gic553Xr9hRL1eUYzhnT5JGG17pFp4M0NgMkO1T+VVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KT35gbTF; arc=fail smtp.client-ip=52.101.84.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GvKxGShBDtPuQdS0c1EwrHqxygBj/ONmLk3t20ff4YPgKpSXfux234B78NtLYlrTQBVlIaJKbatZdbaGZ+6OtkZCHo64cb8bn9W8hunCjuzQaQUjL2+HJYQSyrG9cuRNgQ+YW1tfFey8wd9xz1P0bKUO112scbnu3XUWhrd1CZDr70ES/oPvYJg6qiOWzDF85nltO1s85n7GR+/sSimjKHaONbbZ0VjBOU650TvehEOYRv4EQmWsmqLVFfBJZh16m6iUWj7MWIZkPswtN6ZBOlxr4l8sqBH3QHqo6RQyncyi6MYyM2VBKtiUIs4tT4DH7wr/degQ8bG58vLPOnc7Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=od61XGlT2a7EqMe3yIWI9RmiJG6kdrn+0AImlpqYsTU=;
 b=d/hyoFfOpD6AeAoY9CyW37I1UmfOh25NDCzR25ojc6xiyZuDpNHKgmHa5zdwfxovQpUyMEH1UuoHuFOL0Wws5K9h3WKOhmFY1vPKDjB7XqnZPbU53znVGf5tg9K2SCXVztomnQ74J+qSgCqQy0U36jyIAqgEu2aNYefF06uRzLMrSkokdzY2GfzKmWLajN0nHFnu+qcdw5Xw0fjFJPcTqWEeyHOGFx20vmUb+EVoMuHzz+ynFJyjhWKMdvG4D/m1InMcrxHxIwzZcTm/XGFpDNnnTyBV0EYpZ5V++BeScu+H3pu1wbz9RxnxhGTZOWGIVTJsQzLivTiaBncyw11afA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=od61XGlT2a7EqMe3yIWI9RmiJG6kdrn+0AImlpqYsTU=;
 b=KT35gbTFqmwiR9ivvn0UX0bzMLrfSWV5M+q9GEmosf9dHO+PJajF01dU+7jAmyGobb4bAXg7Wa9f+341grADrvig3oin112dU7xd2Bsftb1injmAaHKsCgiZCU2gqZUD++qwdE3Ij7B+xQlBAMIziNm0c4F2ciehwaB4Suhsc4Rd4USsfoEqX+u3aIr/SwaRxlon4nhSKHkcYL3nXt/6ibMALyfG7qn82qiKlsLn22gy8ekswKqCcHMKxeYeUczwvzDc5ObNgj/NINHdyTyRvXwEC5g7cR4ao8CuMucmLnUQgNz2KT9dTf9dHGsODePj34KTXJlp8OYLNQoRU8c3kA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DUZPR04MB9984.eurprd04.prod.outlook.com (2603:10a6:10:4dd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 29 Jan
 2026 20:55:49 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9520.005; Thu, 29 Jan 2026
 20:55:47 +0000
Date: Thu, 29 Jan 2026 15:55:40 -0500
From: Frank Li <Frank.li@nxp.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: alexandre.belloni@bootlin.com, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/7] i3c: master: Mark last_busy on IBI when runtime PM
 is allowed
Message-ID: <aXvJTPWhQwFfv57G@lizhi-Precision-Tower-5810>
References: <20260129181841.130864-1-adrian.hunter@intel.com>
 <20260129181841.130864-4-adrian.hunter@intel.com>
 <aXu7UduYCweVLxdK@lizhi-Precision-Tower-5810>
 <1db7b04b-ee65-4791-8db5-0dffc7befca2@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1db7b04b-ee65-4791-8db5-0dffc7befca2@intel.com>
X-ClientProxiedBy: PH0P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::11) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DUZPR04MB9984:EE_
X-MS-Office365-Filtering-Correlation-Id: 25676193-9c9c-434a-4dc2-08de5f78c6af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFo5N3gxYlVHc3NQc1Fkb0xjNEY4L3VIdXlJU0VRZ09QanN5UEIvWnhhcExm?=
 =?utf-8?B?WVMwODVaVzdUZTVXK1M2dkZ3QVlXeXlwQmwvZWZtbHZwNGlUcU9ldXhEUGN0?=
 =?utf-8?B?SUF3MkpleUw3ZFhGbWc5akNDQ3FWU3ExMGVnMitiMVR6R2w2U0xtT2FCcElI?=
 =?utf-8?B?QlBxQmt2SUpITFdZVjJNUWh6KzdacTUybUdENGdIVW1NL1ZFT3ZERk9FMlVu?=
 =?utf-8?B?WkRDVFM0NVFjcHpXaVBYMi9xSUdzYUhKM3lmVUwrUVorWUVGMGRDaTYyanlx?=
 =?utf-8?B?S2wwSXI3YzdRVTVHVS92RkwzNE80U1VjeGE5aFhsUEN5ajBuRUI2eTgyRUF1?=
 =?utf-8?B?UDBnbThlVk9YbFdwT04ydWFMTHFBOTBOVEpzRjNZWmR1QWt2TlFxakNlVjJr?=
 =?utf-8?B?QXdKVGdhSUpkU1piNXZMbmxFcmJ0T1NjeUg5di9veWNvVHF3a2x1NkE4Z3dD?=
 =?utf-8?B?VUxFTzBlRlNUR1ZHN01ZL2lUUklXOVczcS9DRXI2VEpsM0tZcWgrWjdCV3dK?=
 =?utf-8?B?T2RySll2cUVCL2R5NWQ2U0N1UFc4R2J6bnlvSElySVJKR0RuUUNoMkM1NjQw?=
 =?utf-8?B?clI5eDRXRit2VWJTbkZReWZtZE5hUE1vaWlGcHFNSnp5cVMwRFJmak10L0lT?=
 =?utf-8?B?LytvU3lVWm50NWd3Z000TFd1S1FFaU4wMzFULzZybXVIQytwbVNWN2hnbmV1?=
 =?utf-8?B?bDJxNVdBK0NsaldXNklLQ0pTNXN2NVhnNEE4cDcvRm80RnpyT09BMFErRnF2?=
 =?utf-8?B?WFlMRitHeWlPNGFEbDhleERHdGs2MWlHbUloMC9FYnVQQTZsZXpOQ1FoaWRz?=
 =?utf-8?B?QVNkWmthLzhYc1QwYW1lWkRmWFFIcGx1ZlFnaWFPNi9KbGNySHFSMVJDNWFj?=
 =?utf-8?B?enVCcjB3aWhKV2pMTDJraGtEMDlQb3BQRHEwTGFiVXNwOTVTeWZ4RVlmQnJ2?=
 =?utf-8?B?WGpEY240QkNwdXdLSEFucUs2UUlQRnRmcUM2ZUVUWEhSMXQvUjRQQzdDMzAw?=
 =?utf-8?B?TWRLTEpOTksxa2MxZWF2Q0hMbDFjMzU0VWFWb1l0N0RuTHFXbHFsd1VmSXRP?=
 =?utf-8?B?dkgydTdrdk1xNUlzZnJRMjFyNks2VUJNMWw4OTlWZ21WSTNjRzFxN1hSMThq?=
 =?utf-8?B?bUUzdDlhTUpGN0FBWlh6Yk9kSDBUVVBZckNHS3FYSnZ0eDJHMFEvOGVWMnlx?=
 =?utf-8?B?Tlk1UTZVTTNrSVZIK0pOMnpOdW02azVqd01wYWRtbitVS2ROV3ViaVM4N3RZ?=
 =?utf-8?B?eTBNT2p2azkwd3A3ME5tenhrVU84cjI5RVEzdDR2cEplbFZ5eEZOOFYwcjlu?=
 =?utf-8?B?bW9lZjlaS3JQRmNoN2s2QTZ1bkwyM3o3MFYydDhDcERGZHBVYVE4WVR2dVJC?=
 =?utf-8?B?SVJaM1RlcktXUFdEWjJWNHVrQUhVS3pvMTZ0bklvbW9zNkVObmZtK3B1b2Zk?=
 =?utf-8?B?TDcxRnh2eWo2a3VuWlVqM2t5ZkJQV0lLYWsyL1pLTnpjN3FrOTRPYVJHRkVr?=
 =?utf-8?B?ZFhhazF1dHZHNTZNQWd5WnExZGxxSzlocTNBeWFpTkUvd0x1Y1NIVVprUEZz?=
 =?utf-8?B?N0tLOU5RTC9mNlBJOVJZY2txVkdCQy9wZ1lPRlh3bDV2TVA0WDRNdFR0U3M5?=
 =?utf-8?B?UTZPaDZzT28zbm1kQnk4STdwVVIxTk5vUXBDRURNellmc0RXL21vUUJyNnVn?=
 =?utf-8?B?cTlIYzhtVlJtQUpjanFydXAxenBqV2xROGVnQ2xjMDZCSXpHZFpkTG9XSWRG?=
 =?utf-8?B?dHZjZmtNbVRDVFdackdKREY3enFYWEZnRTBLcFdMUjVJNGtVdkh0bmFDZnJQ?=
 =?utf-8?B?R3E3TzdOYmM5S1Fqd0kxYWpadGxDMkJEREthNUtRRjA3ODAwZjZQVlREa1lG?=
 =?utf-8?B?aXF3R1JjWmpmQTBmcTNZT24zUVIwRU1xcmY4QlR5V0ZBNnQrTS80R2xjdXl1?=
 =?utf-8?B?eExmNFIxVkNsMnR5aUR4R2UydUlqM09tUlNxbzhOZWI4eEpVbG91TXdhelhX?=
 =?utf-8?B?blpEck9qS0NiVGpteFJSOUE5dFZJdFAvQk1VbjRYN0M4OWFJM1dkYzE3V3Nl?=
 =?utf-8?B?QVVMbkhEVkFYUFlvcWltdjMyVTg3VVhENlVXdFlGeXFpZFRpZitIQzFpNi85?=
 =?utf-8?B?OEdLQ1dzcHVOdmtkcGdDWUFQcFlENjk1b2E1dlJJc241V3R4NUYxRUJpc3pq?=
 =?utf-8?Q?2buTOKACPugUEYBrXHTobXQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWFKM2xCT1hGSnZQdXJuOU9zSkRHQTZEREFKZVAzRm9SY2dwa0hFMXRoeDVM?=
 =?utf-8?B?REJqQXdFd2VJRlh1WU5pZ1lmY2wzMU9NU2x4RExWcTE3RC9LTU12SWVNT1RI?=
 =?utf-8?B?eFNhYUs4bHNpa0VUdlBUUGRiRWtXZXIwWkVrazd3QnJXeGFCRFN2MG1HUC82?=
 =?utf-8?B?YzkxS1ltalFTZzNMbUszQnJDemVMNjFUZDZubkxpMXUyMHNmTXlpamNoZFJO?=
 =?utf-8?B?MlZGckxMNVhJTTJYelluWCtodjhTQ1hpVWpld1EvQnBFNVUvMmNEc3ZtVVIx?=
 =?utf-8?B?RGFqZzM4WFJZSy8xOWF5OVYxR25uaVhtOHlsb3RUSkh6M1VSRkNzY0hubFRM?=
 =?utf-8?B?b0RuVjFtV0xkbkRHVnRPbDFDWi83a1hkTjdwZjdBQm9DREV5VS9BVlh4eDYr?=
 =?utf-8?B?OGFKTTF2RFBqVzAyWmtkVGhlM3YyMFB6blhMUUp5UzFudFZSZTRMbnRVRytw?=
 =?utf-8?B?dU5TWE8rZFI0N2QxbysrUHBHb0pVRUVhdUtMWTRadjNvdlhPWkFRR2pOaFV1?=
 =?utf-8?B?ZVdkSEVJTUUzOUVRYXFyN1lzeFRnV2NYUDM2cmJKd05yUlJGamROSXhySWR2?=
 =?utf-8?B?M1pTbUczNXIwdjU4LzNVWmR1SnowSTl5eFZNMGZjTVk2YUtCb1V6Z0h5eEIw?=
 =?utf-8?B?MHRGRGRLVW9lc3A4bmxjaUV5Vi81TFFTc3JHY2VHT1doVHpoRDh0ZWNyR2tw?=
 =?utf-8?B?VjVkQk5hei9iNlNNMjRmbnlmZjZCbnU3OTY4TlplRkErQ3pNYXp1a3hXVlY3?=
 =?utf-8?B?L3FieHVSdWNseXF2WjRsOXRaRkRKMzJPMmcrYkx0eFdlYllPUlNWL0VvK3lK?=
 =?utf-8?B?ZUpsRDFQUitwd0R5dWtWL05YeDJ4SEQ2aFFXSVgrWS9mbFZIemJXcmsvSldI?=
 =?utf-8?B?VnJOK0JvbkRaYkFpZGVrR2FCZjBSSzNrcE9ycXJCYjlKWmk0S3IwYUY3N0JZ?=
 =?utf-8?B?V3ljaVltMUhRSWN3cmR0UmQ0eHhRTEpoSlpuSURKYnNaTitnL0ZpUUt5NHJU?=
 =?utf-8?B?Myt5VzNOVW9ERm9IaWthQ3NVdEh2TlZVR2p3YmxrbS9TSTR4SnRUYzl4cjRa?=
 =?utf-8?B?T2FvRStYSzRTZG9NN1hnNlI1RGRlMEwxMXo1K3FjOVZ6eEJZRm9lQXUyVm5X?=
 =?utf-8?B?Ym0vdHMydkxHeHkxRVc3VlZOWnVjMzZMZU52UGJIemhYb05LZkZjdENjQTR4?=
 =?utf-8?B?TmI0dHBwTUtSTkJDVXUzUEZJbmRVTWpZOFpEWWV3NWkvT1o3QVBFdU9mZ3V4?=
 =?utf-8?B?dGJ5aUlQdmxnaE0rQndYcVUxdDRZcXNBWDNXQ3dUYWNOWktFMHR1VjJCU0V3?=
 =?utf-8?B?RVFiVzE4RDZ3LzgzeHZpLzc0bHJpdDQyOFBNZkYvcEh4YkloVHFGNGRXb0px?=
 =?utf-8?B?c3IybEhhU3BhVTVReUduZnNWT1d3Ynl5MGtWVXdNVVlOelhOMzNTeUlyM0ZZ?=
 =?utf-8?B?STBvVXBTQUZmV1pkR1hFMFpoVVlZNS8zYVMzd2c2bFlPazR6bmJOMHVWbjFk?=
 =?utf-8?B?d1kxODU4WkJYT09KRmVvMXNRY1lLK0YzOHVzZllIQm1pakpNN1d1eGN5SVZh?=
 =?utf-8?B?WG1LQ2gwdXQwUTlCbEQ3WHNodS9XdHNFd3VvOHNyVFpUZUVyWXU0TnVic0Rw?=
 =?utf-8?B?YlNUZ3JnaU5KSWhoakZXcWhvNHhhMGxXNXJmMlBUUDFPTkNNQ3ZmN2VvTDFL?=
 =?utf-8?B?Q2tLTzBObDg0T1JvTk41QWdlei9HL2pESFhhdmQ5NWl6RlIwa0RreUR3TGQ1?=
 =?utf-8?B?MERtQjNKS3NpbDRScTdqL2pKYnhDeGlTSkZsbTFKZDEzUDJFTG5ZQkhQODJK?=
 =?utf-8?B?NUptYU9YM0FBYU5HelVuMlBQY2x0d3FGeGtSZU9hNDZsZWtzWWFIUWdaN2F2?=
 =?utf-8?B?WHkxYVF5bUpQci9WQVdLVWt5Tzg3ZHBna2pWN0hBWHd5c3RMN2xSRTBLSzlI?=
 =?utf-8?B?SVU0b25Rd1JENW5hbDRLNXk3TVFvM3lxUUZqaS9ZWjRoVThubE9ZU1l2T3o0?=
 =?utf-8?B?em5RWUxjeE1vU0pIaVBlY2hCenFEMmNLTlVpVnNDTENIbW43NWZVY3pHQmFB?=
 =?utf-8?B?aVpkQjNZLzNyNWkySWJXaGl3SnlIcEdLbWhNZUJJMjErTkprRzhjRkZSV2x5?=
 =?utf-8?B?NjhhUllJZzNTbUdEQStzR3BPdCs5eWZrQ1dLMXBYSXNia0d6QnJMVEtDZWgv?=
 =?utf-8?B?ZlIxemFIN1VsL01tZUZ3QW5jNTVmWlc4QzE1L2o3TnpacDBweGQ4RmhRdXhC?=
 =?utf-8?B?NlVwalBjK1A1bnExNW8rRkVxeW1zZUcxa3BwbGU3aElxVGtHZ2w5MWc2NWIr?=
 =?utf-8?B?OUJSZGxiQUZ2L29Zdm1xdjBxNmNTeEpzaFRqSHJhWWl6akt4eStiZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25676193-9c9c-434a-4dc2-08de5f78c6af
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 20:55:47.0604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eqibXzYOsHTdh/X+PZCn1AqbxU54l7A+VDcvppF/bK1CEjV5yPV4rbbnRy8+flHycOCgYGseX0I5zf1GeT66nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9984
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41732-lists,linux-pm=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Queue-Id: 87F6BB45D9
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 10:42:32PM +0200, Adrian Hunter wrote:
> On 29/01/2026 21:56, Frank Li wrote:
> > On Thu, Jan 29, 2026 at 08:18:37PM +0200, Adrian Hunter wrote:
> >> When an IBI can be received after the controller is
> >> pm_runtime_put_autosuspend()'ed, the interrupt may occur just before the
> >> device is auto‑suspended.  In such cases, the runtime PM core may not see
> >> any recent activity and may suspend the device earlier than intended.
> >>
> >> Mark the controller as last busy whenever an IBI is queued (when
> >> rpm_ibi_allowed is set) so that the auto-suspend delay correctly reflects
> >> recent bus activity and avoids premature suspension.
> >
> > look like this can't resolve problem. pm_runtime_mark_last_busy() just
> > change dev->power.last_busy. If suspend before it, nothing happen.
>
> It should be effective.
>
> rpm_suspend() recalculates the autosuspend expiry time based on
> last_busy (see pm_runtime_autosuspend_expiration()) and restarts
> the timer is it is in the future.
>
> >
> > irq use thread irq, in irq thread call pm_runtime_resume() if needs.
> >
> > And this function call by irq handle, just put to work queue, what's impact
> > if do nothing here?
>
> Just premature runtime suspension inconsistent with autosuspend_delay.


   CPU 0            CPU 1
1. rpm_suspend()    2. pm_runtime_mark_last_busy(master->rpm_dev)

if 2 happen before 1, it can extend suspend. 2 happen after 1, it should
do nothing.

Frank
>
> >
> > Frank
> >
> >>
> >> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> >> ---
> >>  drivers/i3c/master.c | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> >> index bcc493dc9d04..dcc07ebc50a2 100644
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
> >> +		pm_runtime_mark_last_busy(master->rpm_dev);
> >> +
> >>  	atomic_inc(&dev->ibi->pending_ibis);
> >>  	queue_work(dev->ibi->wq, &slot->work);
> >>  }
> >> --
> >> 2.51.0
> >>
>

