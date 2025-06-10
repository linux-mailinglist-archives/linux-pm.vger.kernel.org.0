Return-Path: <linux-pm+bounces-28389-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFB3AD3B0D
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 16:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9DF71897363
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 14:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC8429DB68;
	Tue, 10 Jun 2025 14:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dSzJq2bZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2022.outbound.protection.outlook.com [40.92.22.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D381522E406;
	Tue, 10 Jun 2025 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749565305; cv=fail; b=onVaPVgYywpnXZ4GgsaPMPkWmnVA8GjrI1nRefMTys3L4hEcQFuO3AHRb9bRZQqzpAuzeCoUTq7+4HNuXXeilcGf0VTLxZ0TrwZVJaBpJNzqpsmGbOrI6UQqW29DdMSzF5ehRp51k5gF0/laHcgfgF1D47qEI7bGalig2PKyhZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749565305; c=relaxed/simple;
	bh=xYepsnAew9dF6cUFBPOjVC7dlv74O6SRSu9bxH/Q6Fo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b9LtVqoqV5n9fStz7gqFuBQ3TnZ6JKt0VOBo83r5rXZqgj6v2KmxtGtsUxY7PX90qE+1ekeeM/ceqjXrT7keL8CbVSVfpc0cGIfSoGnlTsQlBhamas3ov4XkuFXR8Jj5NF8YMVhNmbL++liRanroj+4ACJVHDtSGfIG3PbWRhls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dSzJq2bZ; arc=fail smtp.client-ip=40.92.22.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=agFbVG8BFFnPwjhe69E/LU/xciSMy7UwTTQTPKm3a0kaBNgt8dtHybR/QiCMXghflTeIYh6NixtlLcAr6l6v6egtV7tA6ciV9MpjXUT2a+97ZTd3yZtADrlon09yXnLKt66LBoCiLRMlHqxVe4dEWQm6djzqiIC7ZxStFxsC15wDEgW637XoQhNNEnp4E3K/BcSK+YJyxWLBUzVONH6ePYCdrbdbBW8+fwRQvzyZuqh1TRlUWRUs9mS4VniHiTdw3Fkek+OPj/mvQ+7I6sWuDKDcJXScnRT7kmXEgNRjESmZNKzCkLudmXlU5uHa8M9JRlJLqSglutVf2UilktAKDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOkvkkkoaQmKhyghlS3HsPpM0aLxTxoUjfS/xX38kCE=;
 b=CzEFTikzieepWJzsiAVa5NshdevZfyeLwKofK1CpDqV2vTg3qQlqZRtze0IZbd/uqkE7OXoLobSKowZRhYU7Z32BSgMtYp+wfgKlX2vdMmWuAfj0A/D0Oc2rNHoV8YE6JQNxoupyCUwW/chmbpx4uHVmn+7aEVhFm5X07prEqSdDXZY4iU60dJyRcZTAoSPfzqotLyimJFpFJ8MpLHs/qZVzfIx4WBep3bXcX7mPlCNLL5M7lRiNF+399FqAQ+SE9yWVMdmjW14IzAZy5YDv4OEbDUqb99KKgF9e/BNgHcf+2x1NvAeqjilEQ7/27xUKZxdtJ5PmyxtA7qizeJ6jAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOkvkkkoaQmKhyghlS3HsPpM0aLxTxoUjfS/xX38kCE=;
 b=dSzJq2bZ5AWUhVP1enQxulxMDk260emQQX2Rt5zXziHP77ro4oMEf4hfi2C/v40IdTtg4nlZ+du4hpiJArO88bnLM0YzQyAWZVqobt4i1r30kK2d+96vRxkQshrS4pyG52sMsdwaH6aBMsthOTuqeSmfl0w6hIF4eh61Hzb+8kf3Ug3xrERcsquTj0wisJT32XDJ9TskAYsJUBszXiinulkT+QPHGQT9IPWa5qyeSokOOUaWqdRqsr98nBTNIlSWNbuDRgN5qztsXkohr6abyzwr4TaQ/Ta6Zk+NvSRaMwmdGVc6f1MmkNXIPfC/9A6DOrtHEV1OsvHSNzPwkaTJuQ==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by PH0PR19MB7320.namprd19.prod.outlook.com (2603:10b6:510:287::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.13; Tue, 10 Jun
 2025 14:21:40 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8835.012; Tue, 10 Jun 2025
 14:21:40 +0000
Message-ID:
 <DS7PR19MB8883150D952EC3C753211B7F9D6AA@DS7PR19MB8883.namprd19.prod.outlook.com>
Date: Tue, 10 Jun 2025 18:21:26 +0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10] arm64: dts: qcom: ipq5018: Add tsens node
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sricharan Ramabadhran <quic_srichara@quicinc.com>,
 Dmitry Baryshkov <lumag@kernel.org>
References: <20250610-ipq5018-tsens-v10-1-3a10a5a2642c@outlook.com>
 <f123294b-b944-4723-bd74-713970468d51@oss.qualcomm.com>
 <DS7PR19MB8883BEBE4168DD1682F858749D6AA@DS7PR19MB8883.namprd19.prod.outlook.com>
 <73e2881f-b899-45a4-a59e-47593283b63b@oss.qualcomm.com>
Content-Language: en-US
From: George Moussalem <george.moussalem@outlook.com>
In-Reply-To: <73e2881f-b899-45a4-a59e-47593283b63b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DX0P273CA0089.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5d::13) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <4612d0bd-f9ca-4e29-bf7f-80f0e419a45f@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|PH0PR19MB7320:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eddd1c1-fe15-4367-1ad6-08dda82a1dc1
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrM7rjyNOMJrj2U6VUnrNAgQe43QEcWqXdEcJyiKdsoBsUJTbvK5YdkmHLO4iaTNWmk7TgkY8LsdfQTCQ0D3/LbJxMU2IYKhXGWi9i8/GEzm7gcTaNwRVMIhOnA3yyJ8iXiTTg1LiAGcot1wHZ0g0NxVKdimia+xv7QXH16Cd22oq63KQyqXwEhalJpKaY6RfCsEjLZdN/xfKZvIhOc0/0thrMq8v7tu1jEHZPhPSJvMWeF7Do3cf44dLf8WyqbM11RkaB7hR2Gvewum+Ap7BgsN/7Q9m8z3+4XfI+LFljcYZuUuX8HSzc0Jgxl6NvxI/Rq0qRZJQDlWCqBYrnzBuJ8gyK29nVQV64yV00xe92xPPJyU5Uau0Vu/4ZaucQmzTyDzu5RdNDSNEBXLO6rG2XSnRekQ7TFZfG1X2nKoDlswDnoOOAfCeBaU5UQGQtkapRQWFjvCUvmeoIFN4M677Ufvz6fh9puYtxaOTEWnoFK5o37WdNB1z7osjmw9Cp69Ww5sCN/XLq9tsuonrxkPC1dgrr3ht7PMomG7q0vI9JnZU8kKHHUS+mY7RF2YC+mWNKau8PaY/SeJ+26tfLCoTSEYn5P5d8RAIMapSiqeIfZsuiwfJlJeyCoFlQBqRYnHFKbUtu9T8daT9h8y717Jgreqp+XvnyqHtDE2oXqkPd69EIMHc3+4TrA17kRNwwx0fcLomftBoeeOMvEZERqb0sPH8ymCyCnsfquXgGUfokqTmWRm/A0hYZ5ShZbzC26uneU=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799006|13031999003|7092599006|8060799009|6090799003|5072599009|15080799009|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWNQbUhseGRXQXhrRlh1ZUg3UWZoRk9NZmhielU1ajVaS2NYL0kwWWV6OUhS?=
 =?utf-8?B?T0NubHI5dGF4VjB0eG5md0h5Wkh4cFg4TVI0KzNNMmxNTnpCOWkzUzN0RzBp?=
 =?utf-8?B?bGhwSlpmL3JYV1d2djNHdG56OWRxOXlyUXhWZk1NL1JHYjh5NFQ0d3lQNHE1?=
 =?utf-8?B?dHhNQ3NMVTNGcFlnRk44OTcyL215UnRpa3c5dGpJSlFuMzlrdEhEWlAyNjVo?=
 =?utf-8?B?SER2YVV1eEp2WkduSkpPbFJxcEk3SXRqWTVYUWk1bzY3TjhhaEE2ZENHNnR1?=
 =?utf-8?B?YVBHZGtLZlRLb29HTHZPbEh3cEVHYmE0TGdzVTZGeXE0dGZNQ3kyejFBVlRE?=
 =?utf-8?B?MDNsbXlBeS9PckVMTDNzNUh1S0cvRm1iY1Z0VHp1VWduVnNqYmhBeDlwUUpF?=
 =?utf-8?B?YlMva1hEYU1QR2k4WXZnU3FuQ2RjR1VVbnYwdm5ORjl0TXo1TUFyT1pqUkE2?=
 =?utf-8?B?S05relN4MWMyaTlzamRGdllGc0NFdE94ekluZnorOW0xYkVTRnd3UG03VEhS?=
 =?utf-8?B?YzBob2Q0c0laaEFlWWRUeUpMc2o2bHNRNmdscWNtVmhHSzZTcXFGWWxtdk1T?=
 =?utf-8?B?WjJwSittMjJHa1ZYc1RxRG9CRjROV1lpMlNSTkJDbUhGanpUUmxsSUNBZjh0?=
 =?utf-8?B?QkJOOXdsTDBBLy9vNUhyaUp4ZHV1aHhneDM0SnJLMjhEdlhQRForZkdBYytZ?=
 =?utf-8?B?NTNndmlBUS8xbDk3dTFWdHc4TTdPL3AxQjlwZHkzL0NQZjRtZDVXaENYRzl3?=
 =?utf-8?B?WXpJczJpOEpwbnN2M3IyVGhSOEx4N3VhRUt2NmdLZ1o2NGVFV2h1L2w4NHVR?=
 =?utf-8?B?U1VYbmM1V3YxeXVrdVFrMHRaek93NVMzN0ZuaWJWUDdub0UzUEMwTUNHbTh6?=
 =?utf-8?B?V0xJZ1VPenVoSjNlTzlualR1VDFLSEYrVW04c1lmU204QjNmSHEvOVI4K25K?=
 =?utf-8?B?Wm9XcEhGRElxRlAyRlVKcWtoUE9hZEhxeTY0a0VlTGM4TE9naVI2aCs4R0Qx?=
 =?utf-8?B?cFVBVEpRVXBaWXVnenBUQS9mdkY4aGpRTVlKR2ZsSVBhUlJLOWtWWnF6MXZz?=
 =?utf-8?B?MGhhVk9xWEg5djIyTU00NjB2ZmJscDY3ZnRkenNyVlR3UUVLNERIUC8vWFhO?=
 =?utf-8?B?NzNYRHk1dWVXNHpXVEFHbWRDY1diOWEvbjNRTjRPVkY5emdJL1F0OHpvYng1?=
 =?utf-8?B?QXU1TzdTZjhWa3lQUHBlRHNpeTRqMkpIT0YxQ2x2c2Qya0ZoUjFyV1BZNFlr?=
 =?utf-8?B?Y2VTV3F5cVdsMEYxNnhNTUhVeVNSbVJUQzBGSUk4azBVNXVqRnBUbFRGZC83?=
 =?utf-8?B?ZUVONitjUzFtNzJxL005WUpMRWs4bFpZVTViVU52SmxLblZhRUpMTlJ0ZXNx?=
 =?utf-8?B?RmhadVNrY2o3VXVrTE9ZQXU0S1o2SDZ2MkYrYitVYmI4RUxEVDkyNWFHNktD?=
 =?utf-8?B?dTFuSG4zVHJINjdWeFZmME5OQWtyTldYa2Rhb0Vub0pEOWh2clFXMHdid05n?=
 =?utf-8?B?QVBQL0hQdWp4ZW9Wd3BBQVZnNk1xb09jakV5V2pvbWdFTStwbjVaMyt5Nzkr?=
 =?utf-8?Q?MHAxQxYVCtGuVjgsPhz6t2JQc=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0lBamZDdUN5UUlCbTRyRnd0Z2Joc0RlN0RWbmxXTnlGRXdKWGdwd1lPckFJ?=
 =?utf-8?B?T1dPOEUwbU5xV21PeGoxbGN6Qk9mQVh5WTFyUHZTSGtlSTNoc2grYXg4SkI0?=
 =?utf-8?B?R3B0MTQ0TXlRUjNnNGVMdC9LdEJjTFU0eVlFME5scjN1dmZmd0hPcU5nVXRQ?=
 =?utf-8?B?OWZVYWhCL2NQRnRrTHB1bXphNTlnV1pzR3Q4cDV1bXZkT0VLdW5qUFJ2SnVn?=
 =?utf-8?B?OVJtRnJSRVJqTmd3QUdLMzhBaHdPRUhMbWZkeEJ0UlBlMTl6VXR1bmZuVWQr?=
 =?utf-8?B?Vy8wYnJQRmdKb2ZmTkxxbDlLU0ZYQm1QTmE0V1FxWTVpNXNyVkoySkRWZkdL?=
 =?utf-8?B?VFpDeURhcmM3T0hSWWpCKzFyNHkvdDFON0FUb3ovTFg0MGxWdUJidkZ0b0JZ?=
 =?utf-8?B?VmkwVTlFV2s1T0NVYlZSWlA3U2tDdWQ3NXZiRmZzSFlrdXpISDV0L0l5blBm?=
 =?utf-8?B?QlA3MUpMZ2MrbXFnTlRTVHFiOXFRQTFsS1FzRGF1Mm8yYStDVnlrYW1VVnFN?=
 =?utf-8?B?RktvTTNNOG1vSjBzdklROXZMVVVwb0IzWHNGWWpENEZQMFNPV2RsUHdHS1ds?=
 =?utf-8?B?ZVZMNDQ0QnpKUnpsbVFTZHRqMGMyVzMvaGFwZE84UFpjNnpKbnAvVCsrWTky?=
 =?utf-8?B?azhWb3ZHbFdkLzlENEU4V1F4aXZZeFYyUnVBSmQ1SlBQT3VyeXovelBMeDFh?=
 =?utf-8?B?enNNanJTZVdyUzN4emFxd1FzOTI0MTZWTzZxYUZsSi85SXQxam0vYkhXcnJM?=
 =?utf-8?B?M09jSHJ1STJQQ2xpNFlORkx5YmZWQjlKREUwR1RNeDRKL0R1VEE2bU1weHZp?=
 =?utf-8?B?WGpxV2xOVWdpb3NDeVRJLzFmYjV6SW9IMlVtOXRWQWFMSlplY1ZiZU9rZEs1?=
 =?utf-8?B?SU5xK01aaHNkWkFJSDNGS0RwTGNJczFORmtjMTZEOHJjaW8vcTJob0JaM21n?=
 =?utf-8?B?TEtWVWVHWG5nbXRwaHIyYUp0Q3BLRFJxdXdyQUprVWdKRUJHZGNJTEo5Z0o4?=
 =?utf-8?B?QmczaWNMdm1NUm53VU5ObnZyaTBzRGxVUGdzdWFhdWxBTmNkUTc5NGs5bWdm?=
 =?utf-8?B?Q0JQMGNNOUlNNG5YUGx2UzZ5aHhXTy84VzNZNGFtTWUvSTdmZlBtcGY1Vncz?=
 =?utf-8?B?S0NYZUZtTDBvZStmS2w0TktDcUJoc05DTUUzRGxldnQzNEFRaG1oUXVsZjFv?=
 =?utf-8?B?VWZ3em1NZklMNHEzQTdVME9TRWlKNW51TFRmR0haaXRJajNJZnZweE4xWFNB?=
 =?utf-8?B?WkRreW1zN0lRSkhDd3VoMFJWenlUaUNhNTN0RHBrNHZHSjAzVGdpdGRucWdX?=
 =?utf-8?B?YzAyUG8rRk9mYkp4d3FicEhnM0VtMVZ0QlhSdEVya2Z5cWtuZitEa2N4NmFF?=
 =?utf-8?B?OG9wcE5namh3VCswZUpkd1lmVUhyN0ZESFM5YlpCRFVHMHUrWHJ3ODhwN1Z5?=
 =?utf-8?B?YUtNVlN4YWhpMThheW9RV2pGN0I1S1U3b2NQZDEvZE5NUEFvK3FQb1FQaHRa?=
 =?utf-8?B?Mk9PV294N0hXZ3VzTGxGdFNQMXZyRFBtcEhobkRJZUFhSmoxdkZhRExlWjlG?=
 =?utf-8?B?TmJDOWt5UGJJT3cyQVJzTGJTVTRvN1VsOHRhTUJlZHhDb2duVTR1R0JKaDRO?=
 =?utf-8?B?NGtMc1BrcjYrSUxFdlYxYUpJdlpyb3hab0pLWTQ1NWNmSStoUkhMa1BOY0dC?=
 =?utf-8?B?Q3ZZVmlwSFB1L0s1R3JFRG9PV0lpaG9jczJvMU11RzVaOUxmR2ozcGNUcmZB?=
 =?utf-8?Q?QTAnDTDFy3u/md9FKAPXOcKcp8dJPukfK3iKGpY?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eddd1c1-fe15-4367-1ad6-08dda82a1dc1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 14:21:40.5640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB7320



On 6/10/25 18:09, Konrad Dybcio wrote:
> On 6/10/25 4:06 PM, George Moussalem wrote:
>>
>>
>> On 6/10/25 17:08, Konrad Dybcio wrote:
>>> On 6/10/25 3:03 PM, George Moussalem via B4 Relay wrote:
>>>> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>>>>
>>>> IPQ5018 has tsens V1.0 IP with 5 sensors, though 4 are in use.
>>>> There is no RPM, so tsens has to be manually enabled. Adding the tsens
>>>> and nvmem nodes and adding 4 thermal sensors (zones). With the
>>>> critical temperature being 120'C and action is to reboot.
>>>>
>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>>>> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
>>>> ---
> 
> [...]
> 
>>>> +        gephy-thermal {
>>>> +            polling-delay-passive = <0>;
>>>> +            polling-delay = <0>;
>>>> +            thermal-sensors = <&tsens 4>;
>>>> +
>>>> +            trips {
>>>> +                gephy-critical {
>>>> +                    temperature = <120000>;
>>>
>>> I'm not sure whether there's any firmware/hardware measure to shut
>>> down these beforehand. It's better to have a software trip at 120C
>>> than to not have any at all, but you may want to try and find a
>>> case_therm or so thermistor for your devices..
>>
>> these are the temps as defined for the critical trips by qcom. IPQ8074 has the temp set at 110C, while IPQ6018 even higher at 125C.
>> They've also defined lower temp trips in the downstream DTS files.
>> Should I try and add those? I could check if the driver supports them..
> 
> you can register the CPUs as a cooling device and add some sort of a
> trip point (see e.g. ipq6018.dtsi)

great, will add and test if the driver registers them appropriately.
Will use 100C as the passive trip temp which is the next value lower 
than the critical trip defined in the downstream dtsi.

> 
> Konrad

Thanks,
George

