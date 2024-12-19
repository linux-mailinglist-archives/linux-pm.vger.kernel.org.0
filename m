Return-Path: <linux-pm+bounces-19509-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0452B9F7879
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 10:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D46E188C63E
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 09:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC83222586;
	Thu, 19 Dec 2024 09:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="PYmAm0/j"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530F822256F;
	Thu, 19 Dec 2024 09:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734600445; cv=fail; b=t37LTIpLhLBQ1bFoPMMv1FeXUaK5yfuFVydNfVBLoPA6mqDjYqsuTQ6fhDUMcO47skmg70YhZc2w+AncBBZDHwC1CrisL43Qwih36auH8e46TsqcqA3+p6QdrWjEVHjkxF10l5UuOeejCDPEB98PZPN4lPhNUslRcpaSF5qSUjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734600445; c=relaxed/simple;
	bh=437vp82fE7Az+y3sYc1zM2DrYk20eyPB4Vmm8/c2+QA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YGYu+UJjXyTl1FcM0NDF0xLYYFIUsHkbUC5jlclzAjBzV72XnSsn5pg5bx1t8IqlV430uEbFcdDZyXwTBUG88YKH6qU7Pi4iv/w/POECYOUn2ExkY7o+fllBjd0u1ZCoDznLlFZgngPgZjcE/2XSuKGScCtELqfyuZgmb3fsKuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=PYmAm0/j; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJ7NtCt023741;
	Thu, 19 Dec 2024 01:27:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=437vp82fE7Az+y3sYc1zM2DrYk20eyPB4Vmm8/c2+QA=; b=PYmAm0/jR9Ww
	SC/oHvl2CNcrqI+dyrO67tpciOmN2TJLrPhe9D9ZHdSmCfe4vhPiD1sVp5P7c2bI
	uS/1yYjQijjpw7mJKpxzupEwx0TAOEiGqgSsO2Nv+cKiM5CoRTIyp3Jyil1qbERv
	fZP43otrQB/vs9gPV029plsYRrfVQAzzqXXv30UbYKajFn/P7TFi0c4sfSyj8olM
	j8DQQX6bWs1Pwn/jVW71ujqCR8Vo/6zcjpRSyWStQFFtoMAchA9OdsGTbGc7jhcK
	OhnC31r/DAT0n7rpCER6gfAX6i9wtNLxrlmJ6Hy7eWuJL75XZAHH33GQZaCgoRIt
	QDCeUo8HEw==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43mdh1s33j-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 01:27:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xIAwcuFz+vV5+grf03zg+AswkHzBhAQCCER8USe8PtWiPlhuuPgrn2eJXwHwSXDrQw7Mn8h2Sav3vr1ltKLBRPhWTweOk5fcPjVk40PevHrHHacAySLKexhWiCi+LP8ZFAc1sioO2OUE2D6jqN/NkLlKltCENfoBln9NYPRABm5Vwer3xdVBvXF6gBNwx5xwtxpZWWA/e98LMhYr0nlQIKfknr+m8FNGbF/dKPMnFkdkrPZZ4ebEbp/dg4ZXzsSmmOgR6TecB47lCYpIyW0sLHWkCtSxnrUdGpNucT52JRQpshflIE4DjgK9DMnbarPc8pBfHri3X8RbVBn/jLS3eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=437vp82fE7Az+y3sYc1zM2DrYk20eyPB4Vmm8/c2+QA=;
 b=UBsQ/wG5T5HVJY2YWoLWkA6C8dm7uvmZfSP7F8enIOIcSeumMJ6zli84CpeYhp30y/zoaFq0GKS+t8EC1mljBTjSLOV2EnlLOFhiQWXI9DVHeuaJgFXFM2RGigNUAX3gFhHzosas3khhMDlg5+D95o90a/rJwtRp69tC/yp+8bC3zFyKj2AxkHb2a5sLygzaCYHjMxpuYchuoHxsVlHGyZcKMvE3tUcgoGkTHoWhAPYqcOttr7WhwOda1NJCy38A6wYM89I6VEF4P3m3V6qGapbfaT91raNqgBMQPKWf7VXo1p2WkHdY4VTbK56IJX92A4eyd4htnx0LP1AxEeBxGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BYAPR15MB2504.namprd15.prod.outlook.com (2603:10b6:a02:8e::12)
 by PH0PR15MB5039.namprd15.prod.outlook.com (2603:10b6:510:ce::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 09:27:19 +0000
Received: from BYAPR15MB2504.namprd15.prod.outlook.com
 ([fe80::f417:ddaf:81b6:e1cb]) by BYAPR15MB2504.namprd15.prod.outlook.com
 ([fe80::f417:ddaf:81b6:e1cb%6]) with mapi id 15.20.8251.015; Thu, 19 Dec 2024
 09:27:19 +0000
From: Matteo Croce <teknoraver@meta.com>
To: Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Matteo Croce
	<technoboy85@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Andrew Morton
	<akpm@linux-foundation.org>
CC: Daniel Lezcano <daniel.lezcano@linaro.org>,
        "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>,
        "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de"
	<kernel@pengutronix.de>
Subject: Re: [PATCH RFC] docs: ABI: replace mcroce@microsoft.com with new Meta
 address
Thread-Topic: [PATCH RFC] docs: ABI: replace mcroce@microsoft.com with new
 Meta address
Thread-Index: AQHbUercy64A5K6wm0ORFlDepcP2XbLtTC53
Date: Thu, 19 Dec 2024 09:27:19 +0000
Message-ID:
 <BYAPR15MB2504E4B02DFFB1E55871955DA1062@BYAPR15MB2504.namprd15.prod.outlook.com>
References: <20241219-fix-mcroce-mail-bounce-v1-1-4912116b6060@pengutronix.de>
In-Reply-To:
 <20241219-fix-mcroce-mail-bounce-v1-1-4912116b6060@pengutronix.de>
Accept-Language: en-US, it-IT
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR15MB2504:EE_|PH0PR15MB5039:EE_
x-ms-office365-filtering-correlation-id: 4138fb61-9e5e-495b-e2a4-08dd200f55cb
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?+5CmvsoZLj/XPxiTCOMWYtwIZPJDb9VLVeNnXbVp7AkJzxr0FhaPC8ZlK/?=
 =?iso-8859-1?Q?vm529g8dr+65M2I+uzzFZUEkvRrS4POvjRN/G9rLkTsue/rYWkAlHLBGbo?=
 =?iso-8859-1?Q?2NGE+2arg85nyeZVyewu2NuCzhAmas44M6K2M6MyJXEQ1muLIxKssWHefA?=
 =?iso-8859-1?Q?Q7iS4cqxDzEXhjRkXAi7NiDLR8AjXd6xgY4ayvOveoLyPv4D59mnkApdCn?=
 =?iso-8859-1?Q?P+HCEY6UJLHu5kfE3V7p/0tROl9pcS/2AAxpkcmOT9yd/Tby5xWQILsVML?=
 =?iso-8859-1?Q?knPWn/rhfhWG6VDPHUED/jNHaN+EiOPn7Mp02Rx6A3GK+eCfI/sXcSKJL5?=
 =?iso-8859-1?Q?wpGgmO2fyPBrvp0b8ft4xeTqAyB0sBFxUx+soYCWE5lh/NyIfFS3L64zqB?=
 =?iso-8859-1?Q?XrUMCGNukWQZwcfS6d3AGMv5Fun6KZh/X6S3rtQ8E1M/XlObCU6HZMtDVs?=
 =?iso-8859-1?Q?XtyQuyXlif6ONamn7FAgSHQdasGgzwCuXAH3cuIUhwoBW6Pxn8bHyyvRUf?=
 =?iso-8859-1?Q?k18aJ99R3pAHEO9o3y7njIw6CFC4WXFHCjWdeAX4SpaOwTZHQa8IQciglX?=
 =?iso-8859-1?Q?aO8+oUvsYH78iUovsOcvy2+n1BI0vdHIz7GyuvhPbaoVgukZBPpGxZoxKq?=
 =?iso-8859-1?Q?C13xxrP31pyh+3HnxUnsfpI5ZS/LBZrwLJCci4ipWeZ/FXTucW6Ctb6d8W?=
 =?iso-8859-1?Q?/GqVPIP3734jK319ARiD9O/FyV7bH3lBqvYpwFVwEvQLsHs+A5Fncsd/XI?=
 =?iso-8859-1?Q?x6b1SCjQF5pxuqw9IXqwXVJ7/e5TmkLj0IETje8ih0K8Xax4Ah8KGQl76w?=
 =?iso-8859-1?Q?clyitVQAKm8ZmuskYQfD8G+SeR4Li0/o/xyKaO0Cf/gZpDdV7SBZp4yX1p?=
 =?iso-8859-1?Q?TqY7uZYWaJDZl/H/euSLl6V8SSIVdiF6MOMu+esuDvCh7M23NbirG8MNZ6?=
 =?iso-8859-1?Q?OYqvgiHT5nuIUSMwDm1GO14eYosAyt4eH5q5/Ddctmc5jztxCHSgruPTiN?=
 =?iso-8859-1?Q?LbqyMjHr5wxF7UVgMaVLKnDD54z2jVsKaRYlPX7J6Gz0Bu5PlKAU9WYtqX?=
 =?iso-8859-1?Q?oLFMuJJ1o96GydZusc+1twcBhIDPv7WEP3avg9dFxL3ExsOnVG1gSdbbha?=
 =?iso-8859-1?Q?ElrPDtI3Q52UiwZmCYFDMMFn8D4Wl4n4z89ACAvWgNQGtGlrP+r6al3r5w?=
 =?iso-8859-1?Q?Ssx4l3JZ6j4aZlCD/xsvCkntZFnvACQP3Xjp1VEE/4spJ1d5ZVU1QwoHSw?=
 =?iso-8859-1?Q?TYWIDvzIFjuDU+5nrqu9Z/apKUsFpLbXjNQ6xGz+82fQuP1lr3Na/SBjIf?=
 =?iso-8859-1?Q?Zj/7ZlJkco5WG8O7CHs020JDxcY19byYxEUQIXaTJfMYCX3c6epDACfWNt?=
 =?iso-8859-1?Q?yYwVWIbOgVc11SaPC/thgPDUQEWmkaqKWb9eyRUX59464XXbiF3RGMWxH6?=
 =?iso-8859-1?Q?VSB6b3E0lEeFm5YHA+T/xl8h3LdG/dm5yLrKuIpchTlSZDbtrXhq/wQoUq?=
 =?iso-8859-1?Q?nwh3+b8JelQheFFDUWz1y6?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2504.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?EDzn1y3nutNoFCRsKUqHfZfhiXrVoSR+/4esLWi3f/KHasHzJimgxlp17Q?=
 =?iso-8859-1?Q?eJGPrzyFs9VWxiP3vPkj+VY/IjlRf08hrQcs+VVNow4wgSjAjwhBHlAZjl?=
 =?iso-8859-1?Q?ayMNVlaP8ZrfZWdm4XvEkMHaAInwbrYNhh9/F3qOfDgwq2yRmmtb8Oot6A?=
 =?iso-8859-1?Q?gvC/gAcYPZXII+3ko6lJaZzHKgk7/Y9Hi26wVy0MAchyEVRe065Eii/MN7?=
 =?iso-8859-1?Q?HSXROKenOz+JPin6nhsUWXDBmQ6goxr/YEP/Djvsz50Kp95YxbQYTjB07W?=
 =?iso-8859-1?Q?axD1mBAhNwSq+X39LmH5Pie7XqvK445Z+D7xcS+3aQWLcCaor+Z98H8FED?=
 =?iso-8859-1?Q?eeTxuVjyNdKN7yEAwPDAyAAqX68Ia24oiZOPyfJzm3riRL4lPl5TbreHwe?=
 =?iso-8859-1?Q?xVpcHT2jfyWoqukCa0V/Doj1+QU82i21azrTRniC4Yg+DYtP13w0uYAs2m?=
 =?iso-8859-1?Q?7lXlY46/GwwlB24zhVXLhR+D7EWRd+coImPPAj8dBR+Tf6PWouGsjQOIux?=
 =?iso-8859-1?Q?+zTyRQkdCnQ0eWeO48u1nnfu5fTOcU4n84nsh6G0D5g+eiLFN2pXARs0Fj?=
 =?iso-8859-1?Q?G5ykK083qSvuC7eIw09PrjrKP/V0WkOBg8/JpE9NJgWl/eI5FvBK6MVv8+?=
 =?iso-8859-1?Q?UGiTzaXW5myriW3+Zsd3dg0sopuB1WfGzJ+H9gaobtsBxLBlCRKhlBCI6C?=
 =?iso-8859-1?Q?kJiXykIncABA4cZJ57JOQO9G6Rrsfy10bLDnBnXx/HoG+Cj/N1rJWWAJ2l?=
 =?iso-8859-1?Q?OIBjP6/+si4zW71Tv+nEvx8ZLdIOlJSZ0UW2oqBS+au0tY7mZYjsq9jLJW?=
 =?iso-8859-1?Q?iUTC44nfY3KG2GFCKA/oXkPYMggemSA1q3jxm5EpceK7YULbiWN0lUUaJP?=
 =?iso-8859-1?Q?ZIv7eZv776Y/7RbmVApyOIaJ8p6EuliH6GHqM9QFnwGzBALLBx5zvb/kCl?=
 =?iso-8859-1?Q?Pjm+DJiwVKWxmU8U/HmZBslwMj6S+FPPvBHySLibvx95yc+KBPvOTToPQI?=
 =?iso-8859-1?Q?FcjIzcEN9UHieb6fCwNswjqhhGDHHA0jYSCL+JC544nYEh3bHcdEGZHqFN?=
 =?iso-8859-1?Q?zvT3A7OaLO/pJeNkghXcNnVAhtKSciHjlElxPwejos59jW6WzL/qkFgG8M?=
 =?iso-8859-1?Q?m8zeKbNfhKj+5j7XO5VNFTQLVylBKv7p3633xEi49SgHkC4BH/NdfvQWFZ?=
 =?iso-8859-1?Q?ASq05UnwDCXykjoDDeHTR3b+0J+jo0TBhQLwrSOKjz6aqBsJK7TWuSyNaw?=
 =?iso-8859-1?Q?bur7YMPUezKh3p1e+s6aONfG17rQFnsu2dANLPwh8XxPs+hKt3VYfjOs8R?=
 =?iso-8859-1?Q?2ovqCd2PwQ2uOixwPRewcw22uQT5FB52DxG4nIc5HwUsd++7NfhNp8+9GI?=
 =?iso-8859-1?Q?xTncUu0TJAbL1cZvOcpoRtbqR/TZtJrDTDAf2w4soFHRsrazKHa00EOME0?=
 =?iso-8859-1?Q?37Ei6l2a7P1SMh9bvUpqv9r+sHtY4GQWFhJY0ygxsR4JwOK1Qkp/PujvB9?=
 =?iso-8859-1?Q?i6q4ZeGq6fPEsQoF8yqxZ+bXOWbaYBWDpfUJKqIjquygimdv0RxXrvTfWB?=
 =?iso-8859-1?Q?KBqOfSPoxvKkMhF0VbfrGzzuxGs7paP1ZD9YvXjz6HQ7yFuh5Nae5/+8RU?=
 =?iso-8859-1?Q?BtMZ3n7hKRd8w=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2504.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4138fb61-9e5e-495b-e2a4-08dd200f55cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2024 09:27:19.2121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: diRzZvjnYckmLOAdodjo0FcJdPqKyyBj/N42MNQmBwQjkVKJPjTpyXlclftGGS8oHJVe1NBH4mQFhV1xEOrDJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5039
X-Proofpoint-GUID: dRQ-3EkKML_FL-K9sLOuBLo1UXOdNi3K
X-Proofpoint-ORIG-GUID: dRQ-3EkKML_FL-K9sLOuBLo1UXOdNi3K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

Hi,=0A=
=0A=
this address works just fine, go for it!=0A=
=0A=
Regards,=0A=
-- =0A=
Matteo Croce=

