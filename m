Return-Path: <linux-pm+bounces-22812-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FC0A42259
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 15:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAF83165C5D
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 13:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786EC24889C;
	Mon, 24 Feb 2025 13:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="EqsiAXam"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2053.outbound.protection.outlook.com [40.92.23.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C9124888F;
	Mon, 24 Feb 2025 13:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405532; cv=fail; b=b2Us3EOSqVTE1DPs3X3ud7RFm3Yte+t39H/bCs5uzNVXC/RGPK8/QhGZ2k9srjD1k2wY4DDZkVW0DBXFB7mEBrQVNc1Vsu2HQycLK/Zi49yIRT61UmOw/ioXs2KCxzcrpgnQE9CODqz9B0NnGo+7j3rxj0l2+DCVHOX9RfXhhIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405532; c=relaxed/simple;
	bh=9N4Nw7I6jpxR/zJfbMeAgdK738ozl9jF3eQKWO/PhOc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wb4xC3m9TbrxYNCKjyiRUY24DvzOriDaUgiLCKSc6iLhf2o9mPa1dUG0fxDlJbgfJSyPQwNw1Vt8viqenE++EXulViaA37cQSjHuKlx87y+1NWjKwFNVGPcXKURNvU/2TJH0hepy0FC69dawlStcWNljzKgNQ8C6TifUu3IbSA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=EqsiAXam; arc=fail smtp.client-ip=40.92.23.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/2LXSRC+nYgb2DMnNtXCoo+Hx+o/a51imCg0+SbiQTmygNJSJp+NQIS7IpBoDAJ+kNIIXu0PffHmfyPRF6bm8AHV+Syr0u7fcd08BwsHhRAyHhnhTbFdjgTBpecAWA9KFFVpQUA9oOFgYhajQ/ONDLQXGXA2CSznXxR+nyn2q1QpvQDnfkJO408TM2zGbTFRB/ZAXOqwwo3UrP16NdCFE+fBt7z3nQfx2rpnvJner7RrSyeabZZufAHPGuOyoC+ZWHd3hyjjpzov4AFVqNVbrI5uW/UI2oNdNkI7YZvUgQQfex8K4b/MFb0KE43JzAoRymU25ab26ZlMvyry53A4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9N4Nw7I6jpxR/zJfbMeAgdK738ozl9jF3eQKWO/PhOc=;
 b=oDh+BCaWK+n4lI3w2THlK1Wo1X9us70b77Rl1mxMWnbsJQ8KYQ8djMASpahCFuaScj73lwlUPAcEKE4xGWIMgnspqE2Cr92tbgwvI4Y4rCJWr5qhXMVc9xerzNX33foecqeM/GsVtTPsS4c9PFW4pJ5bE77vpus4XP+WPhFyT50EsjeAGHJQfxeBYv5DfxFLQLPbUpmdJSJLQZmDukNm29X68oYerpFlJMhS80B2mU76pFvgIBAj5gBT/vgITacAB/Gx8n6fb3e9GLP2dhOd5Pq402Z+ekBNeq1Q+9FqlkcsguLBK0jhzne8JOVsJR72/lh8jmtM2nwdyUH9kOC10Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9N4Nw7I6jpxR/zJfbMeAgdK738ozl9jF3eQKWO/PhOc=;
 b=EqsiAXam/Y/Umr9+cU4r3/7vIjPcZ4n9yjCjLW+wbu9bhjXPrtGqO/5fcTBT0EgJuQD9gdxjSVu5JkjXs52MIUL7VRtRwefKJ1+/ah20q8lhR7/Ht6Yc8ykl1E+9MPw8Ev3FtUFccADElzE9Fhx8vA0nfTajm+vCdjRVB9LeXPnTMw7FcpbjoDd1RPBHfoLbd5SzklcVhVpVfUkyRSxMgX/v1RNDlUhEGCFjcUtHmTGaSRrbspoYANE4f6UtegyB3XveGkwNM55dpn2tfrT/Z6mFVnoASj6cFYfvtzj9UskEX1OHoAcI/j+fEbeMs3qSvl/MXt0lHhMDq1Xx280k7w==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by SJ0PR19MB4639.namprd19.prod.outlook.com (2603:10b6:a03:28a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 13:58:48 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.020; Mon, 24 Feb 2025
 13:58:48 +0000
Message-ID:
 <DS7PR19MB88839DD16140E0C883257D679DC02@DS7PR19MB8883.namprd19.prod.outlook.com>
Date: Mon, 24 Feb 2025 17:58:39 +0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/5] dt-bindings: nvmem: Add compatible for IPQ5018
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, amitk@kernel.org, thara.gopinath@gmail.com,
 robh@kernel.org, krzk+dt@kernel.org, quic_srichara@quicinc.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250224061224.3342-1-george.moussalem@outlook.com>
 <DS7PR19MB8883591F0D2E21E62025D2D69DC02@DS7PR19MB8883.namprd19.prod.outlook.com>
 <2fcb52a3-7ef2-465f-b460-2f7b565a188e@kernel.org>
 <zygiknq3pldkcdonekzamn2uprnjyc5dip57i75p7uahftekxr@2lqgo3wa6zhf>
 <739acd33-9ce8-40db-a219-26b8ca241d73@kernel.org>
Content-Language: en-US
From: George Moussalem <george.moussalem@outlook.com>
In-Reply-To: <739acd33-9ce8-40db-a219-26b8ca241d73@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DXXP273CA0019.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:2::31) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <ca80f581-0a31-46fc-87f5-b36bbce444a1@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|SJ0PR19MB4639:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f7577ee-0c94-4823-0e4a-08dd54db5c3e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|6090799003|7092599003|5072599009|15080799006|8060799006|19110799003|440099028|3412199025|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YkJQRFFEM0lFSUU5cDVFeGNsYTVkLzZpbXNoYXdXQzVBVVh4aG9RbjA5MVNj?=
 =?utf-8?B?S0xYY1NDa0Zka1p6V1Q4L1BtNFRQNllOMThQV05FMGxuOTNNREdTcE1QekdX?=
 =?utf-8?B?N0hoMHI2SmpFR1hCMU9lYjBvaC9QUGFyT1U4ZmtwdVFwb1FiYWozSWM3eWN2?=
 =?utf-8?B?aWpsc0crd1hRVXh6QjVFOE9DZk9qMENuR0FLWUpNYS9xZFhuN093WnhXRExr?=
 =?utf-8?B?aHhxV2ZHaGhiNjRpZWdVT0tGZjl4SW5aV0UxN0ZRa05WTy8yOGtoaTFOcXVL?=
 =?utf-8?B?STRRM2oxWFBQaEJNNjZCb0lVT0srZ1RzUVM3L1BlU3hzQmZhVjBLeXhsRmh6?=
 =?utf-8?B?a2ZUTHJRR3dsdk5pdUE0WTcrcCtvV1dzU0dDeUg1b3RuRkI2RGN6T3VQaVVi?=
 =?utf-8?B?cmJreGFXWlBmU1dTUXE1clZjWThsSmlQeHJJMmNaeDlvdnQxNlc0cDZacTNS?=
 =?utf-8?B?Wnl3cDdYWEFjQnpmc2xCWlRBcWlOVjJJVCs0NHFYS1BwQ3A1UWJGSnlORkdo?=
 =?utf-8?B?QWFld3NzcXZWeVE5THRtRTBoS3ZiUnc0M0lQY3NpOS92VEZoQkU2RjNMTk16?=
 =?utf-8?B?NmZDdXVHWDkzSCsrRG1zVlVCQnVoZjhHd0FRbEJjcnJxQkF1ZHFJZ3hXOXo3?=
 =?utf-8?B?UjJIMGx0dUFyTG5tTEFYVmk2bW5DUkJiY2pnL20wN0xMYmN2WlUxL0QrTE5w?=
 =?utf-8?B?cWxkemZnM2lvdXcwSkI5VHRLbzRzNE0yajBzVGxJci9MY0xJU0N2R3pDSGpt?=
 =?utf-8?B?TFNEU3duZWZVWDhueHpZODNsb08xV094NHhZUUJ4MlhRWjhUMmR1Q1RyUGV3?=
 =?utf-8?B?cTZ0TU01U0dNOEtRRFhPMDBTNlRWUUdqZmZqRGtMN3VKd2RoQ3pOcUh1Mlhv?=
 =?utf-8?B?Q2JrSFRyNUdtVVpiRmt2U0l2Q2d3bkdxUlJiVDBOTEQ5RUo0Y200SktmZHZj?=
 =?utf-8?B?UUZsRm05TVJuU1VFS011NGJVOHNQNDYxVlVyM1NDaUhxTHBhVFlaTDlXYW4w?=
 =?utf-8?B?QVJjUGZvUkxra3R5c2lYRnpYcGVYRlNZMURwMGRPNy9PQ1ZTS3ZMUlVzWnJi?=
 =?utf-8?B?MDhEWWYzVUxXRkYrUUlrTzNuZnd4UXkwcExOdm9EWjdGTnJXZCtXTWwxVzBV?=
 =?utf-8?B?NTQ3VCs3VnE3b1FhdEQrQVEwbHNMRVV1YURtdVJFRUwrY3F3VzlrclF4U3A5?=
 =?utf-8?B?V2NwMFJyQi9nQzAyeFJrd1Y4SlZYTUUwZFlDMFQzSEFjUTIxMUgyb1c4MTJL?=
 =?utf-8?B?TG9JaE1pTHNJVXZuY09pMnBGYWpjdEtSMkdGQnpma0JZdm9mMitFWHBFZHlz?=
 =?utf-8?B?QTZOYTUvT0ZrM0htTWRXUnVCdVVGSjRnUDl1bDY5YlI2bmtqRlhQOUdDRG9D?=
 =?utf-8?B?U1paMW5nKzd2a3hvRkQzMlROWkl5aHFnUC9lbmdvTXl3MjE2OFp4WnF0dWRt?=
 =?utf-8?B?ckdZcklrV1VZdEpwLzJrZWMzOVREZTBZNjF5NzE4cjVtcUtYdThhL2dUMnhM?=
 =?utf-8?B?VUozdW1QSFdLZTEzeXN1Y2E0RjdnbER2NzJwNUZPNklmNUhWY0k4Vk5WaTVs?=
 =?utf-8?B?SzJWdz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cm4wUTB1ZzRUU1dGUjZqOFl5aytiMHJGYmk3QWdZTGJrZjRkejEyaHgybE1U?=
 =?utf-8?B?MWY5eFZwOW0wblA0dlZjUmwrUm9vbDdDcWJQT1VGREQ0SlppRk1zaVR3emsz?=
 =?utf-8?B?cmwxeUhtampiaUxmM3pwMUFMN2trVU9mdzIyN05HTFUzS3N3eU0vR1QwU3BK?=
 =?utf-8?B?eUl1THV0Q3hKRjhUeVlMTnlRSDRDcUVOd3AxNEZvRVZJaG5SWmI0WGx5T0tW?=
 =?utf-8?B?Z1hNdjVNdncvaEU1dkRRLzVIdG42WHAvVDlNb2YzdVI4OTMvZUFPN3BHNkM4?=
 =?utf-8?B?QWRaa2VpY1VIRTVmYU51L3p0UFZKZnhSbjZuanpOZzk3WlVieTlRZVQ4Q09w?=
 =?utf-8?B?SjV4aEY5MnllTVNMMFNleVl2YStaSGhXZ0VzQ0tqTGdYZWQ4cFhaL2t2NS9a?=
 =?utf-8?B?WUlzc3BHUmxWKzJhSmdGOTVLc2NTNWlRME4rWmdPR2I4NHkxZURxbk9xdldw?=
 =?utf-8?B?YW1pTEJlZUl1eGladE10UThwNzh1QjlsS05qdnZ5cEtPR3hjUWxqUDRzK0xu?=
 =?utf-8?B?SGRBVG1icnBkRWxkaFVtUzNCVEh5d0hZMExBSERPeVovdUdSSEhYZHJDRGhq?=
 =?utf-8?B?Mk9ScHFwby9DNVFoM2xQdVp6YmdWQmQvSTFLcFB1K1dkVGplQ3ZmbUt3bUJv?=
 =?utf-8?B?bDdnd3V5eGdjQ3ZObzBJdTBxZERyMUJadkZsZThSNVJSZUxzYUF4VnhPdk9O?=
 =?utf-8?B?b3NzRUxCcUJqU2IwUWdwSmhGQlh6eFVvRUR0eEpvRGt6UHpHd2wwVDlIeUJD?=
 =?utf-8?B?UWNjZUVxR0R3ZlZwMW1BMUpaYzk4clZqL1FKQzBXVkNZUjhXY0pDN2NLTUNx?=
 =?utf-8?B?bjVOUWgxdVJnUkw1cWlCNmUxbGtzSTJqMThwYzNrMXhiZjlJVWc4clRsZUFm?=
 =?utf-8?B?aXhHamhsOHhlRXQrbkRZdHBKaXhJVEtDY3c4YnRhOEZ2OFJtVjM5VHdFNzhx?=
 =?utf-8?B?SDBaQXVwTHpPV1RVNFAyWDFJWWd6WjRHc2h4WnlpMkZZRVY0WGxvYlQ1SHlY?=
 =?utf-8?B?eHBrYUVKVWVMVGVPM2JHZDUwT1lXeWJJTUZOYlF1NTZ5WVlFMWo2dFE5VXM4?=
 =?utf-8?B?TDBQclAvTGRTWksrcWNCMWk4M1FkNDRvYUhiSGE3SGpLQUJUODJEZjY2TU1u?=
 =?utf-8?B?dDZNQlNYdmcxYWxkM0oxaUkrOEVVRGF2Vm1vVytQeklXOHIzeE9xMVZrWW01?=
 =?utf-8?B?Nm8reCtGcFp3UnE5am1HbVJXN2liTnlPU0IzOWpSM21oRUFIcDE0NHVla1ll?=
 =?utf-8?B?S2hTZlZyQzVGY3pjTjdyZmpKbm5YbjV1U2dnUi9vbGdzcWJXQk5DSlpkWGlM?=
 =?utf-8?B?QTMvMlNuUld3OFoyY2tMU2xwM0FHOWxXWVBMNzlwak1qcHNpMXZtT0V5amZX?=
 =?utf-8?B?dzZvRFJ1aENBWG9ZNlpFQXhQd0o2ZzR4b3E5aVl6dVJrSzR6SFNTeFplc0k5?=
 =?utf-8?B?SHFkR0I3R2ZMYkMzbjRoZHJ3TnpvOCtsMDdtQW16cUE1UldxZUMzQWlTaXlR?=
 =?utf-8?B?RHhKTzhyVXBNSE51Zi8xRC9BZ3VOcUVlbkdUOEl4bkU4akVYeFZxbUZzdWI4?=
 =?utf-8?B?Q3pMbDRHQ1lVOURwVGhKRHl5SnNIK09qSVZnMHRzRm9KaFJPUXpnZGIzdCto?=
 =?utf-8?B?MFBQOEZyTG0yL21FSzRaOHR4NzhQa0lSbm15aEgzTW9yNTNvK1FBUE9jaCtD?=
 =?utf-8?Q?PAyylE81Vp93ztqcCj3A?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f7577ee-0c94-4823-0e4a-08dd54db5c3e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 13:58:48.7298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB4639

On 2/24/25 17:49, Krzysztof Kozlowski wrote:

> On 24/02/2025 14:42, Dmitry Baryshkov wrote:
>> On Mon, Feb 24, 2025 at 10:19:35AM +0100, Krzysztof Kozlowski wrote:
>>> On 24/02/2025 07:12, George Moussalem wrote:
>>>> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>>>>
>>>> Document the QFPROM block found on IPQ5018
>>>>
>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>>>> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
>>> You can send the patches to yourself and see whether they are properly
>>> threaded.
>> I don't think outlook world understands the concept of threading.

using git send-email from an @outlook.com address. But I've figured out the issue:
git send-email --thread
this sets In-reply-to and References tags

> True, but note that outlook.com is just provider and you can use
> whatever email client with it. mutt/neomutt, Thunderbird, claws, Kmail etc.

correct, not sending from outlook, but git send-email. Was missing the --thread option

> Best regards,
> Krzysztof

Best regards,
George


