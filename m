Return-Path: <linux-pm+bounces-22535-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D15B1A3D855
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 12:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA894188DE12
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 11:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBB121147B;
	Thu, 20 Feb 2025 11:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rwDP03ag"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAD620E03E;
	Thu, 20 Feb 2025 11:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050209; cv=fail; b=JFg3jomymoJ6XwgCslPU1VTFUHGAxjrLy4d4862etbKQwJTu8t8mElJ++NsRVaUKQzz7jHmTtX7eh8vqjxO7D+6y2p9Q4cPqnD7LCyBZbAfg4jTrjX7kRuVbcDan/zidxllpNVhEpRWJ7Znz8DeWsBwZ/D+PpWe3/Aws9BflhJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050209; c=relaxed/simple;
	bh=nChxKervwSxlY8T+gnzAWgOAIaNmgOEPk7tWUqvOc54=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A3AbkPAta9ktnofRC2/XjnAMRb+VhBPgQE2tubTC2vohLUDmY5+h2j1BeN6El/lifcWvDEoOap9gIA7oQfRda/lmtdoWkDvHDmiNjTUaR/d4dwrHA7nB0bBeMvW/vn7SZt+9laaz9VVmqHCCfgzBHcl8eQMOoCJ/UA1TWApz7jA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rwDP03ag; arc=fail smtp.client-ip=40.107.92.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SFzXgGkxcQIDqUkParQ3mRjSYaWtQW89fc3gPmX8S7tuiagpCcnVfsWBk0Wrm5sYuij8YW5mAr23BE87RRaAP8T95GyNE6ufJMbSqCyGCXPW+HR6IjHM2g3yd8gqAliF/2cBb2mZjZ7CTD83vvBnTf2IBycaIftd9OT0CQwWEmIvOMqP38b7SCcINq1zF6sN5dOXQq0YREUzYReVR2JmW82+9ErYG3lwKzD3fV8aSDMX0fcrpcnQW2i0JXp9zJa2KNWnrDRVHPzLsg8D4lkKrYeihgEs+OXHleIaUFo/EKdJSg2N25a+9ZAJnUZoYo9i+e0cF8r31inCbaRy5GC7xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5KK0iKxATjG5eZFZ1ueLGLOGC2VyvhaIoL06m5b6bk=;
 b=Jszt9m4PhGcNJpr61JTBdTDTJteaK2QXyFdMaGaSzu1nXVy5Oo9skhctzlficwyYsHYqyx+6NoA41X5VrsgIAOHrBrHOBoH0DgOGrLbVUj/DaXvzwgnpotUJ4/V+WnFC1r5Vmo4xv2B69Madmj5E+SxbH7vDl89JktSOln/oHQUZU1bMhy/kX+NqcG8waNmir9DV/049Ct3DYBnoJMzwOJus5I0a7VwNW/Bh3Ry4xlqv7GbiZeE4H6ElfR8EpU8gB2XmFppvNnUvHrw5Hw2EGBf34zcoFRUMk5dosdwrW78WOWSNG0V5O4QiKpVHrzMwi2rW5dn1t2XPoGRNlVQ5xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5KK0iKxATjG5eZFZ1ueLGLOGC2VyvhaIoL06m5b6bk=;
 b=rwDP03agGjxJu8oSBXmlRMg26rT/fihhBzARnQu9FFPBNkTgzm6T+S/HiF04uReFiucMp4Bd2+lHMcX2gMd4pSsojrNfxyylT2cvT7cjfsOiM6AwdllrjNFQ7b8L6djUPKee6TCs40pT1lpl2frq2dvwwMgpfAjdq1faCoGfZU8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SJ2PR12MB8034.namprd12.prod.outlook.com (2603:10b6:a03:4cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 11:16:42 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 11:16:42 +0000
Message-ID: <5fe06447-9e5d-442b-86d5-d84b0adc5f35@amd.com>
Date: Thu, 20 Feb 2025 12:16:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: power: reset: xilinx: Make "interrupts"
 property optional
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: git@amd.com
References: <20250217095226.12606-1-shubhrajyoti.datta@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 xsFNBFFuvDEBEAC9Amu3nk79+J+4xBOuM5XmDmljuukOc6mKB5bBYOa4SrWJZTjeGRf52VMc
 howHe8Y9nSbG92obZMqsdt+d/hmRu3fgwRYiiU97YJjUkCN5paHXyBb+3IdrLNGt8I7C9RMy
 svSoH4WcApYNqvB3rcMtJIna+HUhx8xOk+XCfyKJDnrSuKgx0Svj446qgM5fe7RyFOlGX/wF
 Ae63Hs0RkFo3I/+hLLJP6kwPnOEo3lkvzm3FMMy0D9VxT9e6Y3afe1UTQuhkg8PbABxhowzj
 SEnl0ICoqpBqqROV/w1fOlPrm4WSNlZJunYV4gTEustZf8j9FWncn3QzRhnQOSuzTPFbsbH5
 WVxwDvgHLRTmBuMw1sqvCc7CofjsD1XM9bP3HOBwCxKaTyOxbPJh3D4AdD1u+cF/lj9Fj255
 Es9aATHPvoDQmOzyyRNTQzupN8UtZ+/tB4mhgxWzorpbdItaSXWgdDPDtssJIC+d5+hskys8
 B3jbv86lyM+4jh2URpnL1gqOPwnaf1zm/7sqoN3r64cml94q68jfY4lNTwjA/SnaS1DE9XXa
 XQlkhHgjSLyRjjsMsz+2A4otRLrBbumEUtSMlPfhTi8xUsj9ZfPIUz3fji8vmxZG/Da6jx/c
 a0UQdFFCL4Ay/EMSoGbQouzhC69OQLWNH3rMQbBvrRbiMJbEZwARAQABzSlNaWNoYWwgU2lt
 ZWsgKEFNRCkgPG1pY2hhbC5zaW1la0BhbWQuY29tPsLBlAQTAQgAPgIbAwULCQgHAgYVCgkI
 CwIEFgIDAQIeAQIXgBYhBGc1DJv1zO6bU2Q1ajd8fyH+PR+RBQJkK9VOBQkWf4AXAAoJEDd8
 fyH+PR+ROzEP/1IFM7J4Y58SKuvdWDddIvc7JXcal5DpUtMdpuV+ZiHSOgBQRqvwH4CVBK7p
 ktDCWQAoWCg0KhdGyBjfyVVpm+Gw4DkZovcvMGUlvY5p5w8XxTE5Xx+cj/iDnj83+gy+0Oyz
 VFU9pew9rnT5YjSRFNOmL2dsorxoT1DWuasDUyitGy9iBegj7vtyAsvEObbGiFcKYSjvurkm
 MaJ/AwuJehZouKVfWPY/i4UNsDVbQP6iwO8jgPy3pwjt4ztZrl3qs1gV1F4Zrak1k6qoDP5h
 19Q5XBVtq4VSS4uLKjofVxrw0J+sHHeTNa3Qgk9nXJEvH2s2JpX82an7U6ccJSdNLYbogQAS
 BW60bxq6hWEY/afbT+tepEsXepa0y04NjFccFsbECQ4DA3cdA34sFGupUy5h5la/eEf3/8Kd
 BYcDd+aoxWliMVmL3DudM0Fuj9Hqt7JJAaA0Kt3pwJYwzecl/noK7kFhWiKcJULXEbi3Yf/Y
 pwCf691kBfrbbP9uDmgm4ZbWIT5WUptt3ziYOWx9SSvaZP5MExlXF4z+/KfZAeJBpZ95Gwm+
 FD8WKYjJChMtTfd1VjC4oyFLDUMTvYq77ABkPeKB/WmiAoqMbGx+xQWxW113wZikDy+6WoCS
 MPXfgMPWpkIUnvTIpF+m1Nyerqf71fiA1W8l0oFmtCF5oTMkzsFNBFFuvDEBEACXqiX5h4IA
 03fJOwh+82aQWeHVAEDpjDzK5hSSJZDE55KP8br1FZrgrjvQ9Ma7thSu1mbr+ydeIqoO1/iM
 fZA+DDPpvo6kscjep11bNhVa0JpHhwnMfHNTSHDMq9OXL9ZZpku/+OXtapISzIH336p4ZUUB
 5asad8Ux70g4gmI92eLWBzFFdlyR4g1Vis511Nn481lsDO9LZhKyWelbif7FKKv4p3FRPSbB
 vEgh71V3NDCPlJJoiHiYaS8IN3uasV/S1+cxVbwz2WcUEZCpeHcY2qsQAEqp4GM7PF2G6gtz
 IOBUMk7fjku1mzlx4zP7uj87LGJTOAxQUJ1HHlx3Li+xu2oF9Vv101/fsCmptAAUMo7KiJgP
 Lu8TsP1migoOoSbGUMR0jQpUcKF2L2jaNVS6updvNjbRmFojK2y6A/Bc6WAKhtdv8/e0/Zby
 iVA7/EN5phZ1GugMJxOLHJ1eqw7DQ5CHcSQ5bOx0Yjmhg4PT6pbW3mB1w+ClAnxhAbyMsfBn
 XxvvcjWIPnBVlB2Z0YH/gizMDdM0Sa/HIz+q7JR7XkGL4MYeAM15m6O7hkCJcoFV7LMzkNKk
 OiCZ3E0JYDsMXvmh3S4EVWAG+buA+9beElCmXDcXPI4PinMPqpwmLNcEhPVMQfvAYRqQp2fg
 1vTEyK58Ms+0a9L1k5MvvbFg9QARAQABwsF8BBgBCAAmAhsMFiEEZzUMm/XM7ptTZDVqN3x/
 If49H5EFAmQr1YsFCRZ/gFoACgkQN3x/If49H5H6BQ//TqDpfCh7Fa5v227mDISwU1VgOPFK
 eo/+4fF/KNtAtU/VYmBrwT/N6clBxjJYY1i60ekFfAEsCb+vAr1W9geYYpuA+lgR3/BOkHlJ
 eHf4Ez3D71GnqROIXsObFSFfZWGEgBtHBZ694hKwFmIVCg+lqeMV9nPQKlvfx2n+/lDkspGi
 epDwFUdfJLHOYxFZMQsFtKJX4fBiY85/U4X2xSp02DxQZj/N2lc9OFrKmFJHXJi9vQCkJdIj
 S6nuJlvWj/MZKud5QhlfZQsixT9wCeOa6Vgcd4vCzZuptx8gY9FDgb27RQxh/b1ZHalO1h3z
 kXyouA6Kf54Tv6ab7M/fhNqznnmSvWvQ4EWeh8gddpzHKk8ixw9INBWkGXzqSPOztlJbFiQ3
 YPi6o9Pw/IxdQJ9UZ8eCjvIMpXb4q9cZpRLT/BkD4ttpNxma1CUVljkF4DuGydxbQNvJFBK8
 ywyA0qgv+Mu+4r/Z2iQzoOgE1SymrNSDyC7u0RzmSnyqaQnZ3uj7OzRkq0fMmMbbrIvQYDS/
 y7RkYPOpmElF2pwWI/SXKOgMUgigedGCl1QRUio7iifBmXHkRrTgNT0PWQmeGsWTmfRit2+i
 l2dpB2lxha72cQ6MTEmL65HaoeANhtfO1se2R9dej57g+urO9V2v/UglZG1wsyaP/vOrgs+3
 3i3l5DA=
In-Reply-To: <20250217095226.12606-1-shubhrajyoti.datta@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0099.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::40) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SJ2PR12MB8034:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c063c4c-d833-46fa-1f9a-08dd51a00dd5
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkxWT21ObzBQcTBxRjBGbVFMMk9IMTlMMDBwMzlyVWFhMGxGVlpZaTVRNDJB?=
 =?utf-8?B?Y0FBWnc2TWlFNlRrMmNaV1p1cU5rQ0dPR0xNNkx1cnN3NkNOeVNNK0IzUUJk?=
 =?utf-8?B?UXFGWi9UQ3JWVU1Tckw3aWFiQzlFNTltRTB1cVYzdkZ3bWVUN2REZDBzbjIx?=
 =?utf-8?B?UndhOUhwaCtKUGlDcVlSeXJvejVzekVwd1JueVBnZmpMSnlBQzBlYitQWkli?=
 =?utf-8?B?WDNkdzZLWXhjYXozbW5LWmRHd05DcXh0T2wwaEVXWk1Jd3YzbnBwVktwS0hh?=
 =?utf-8?B?bURodUFKelBBRVo1RTJEYXJyaXphV2NycFE2d09LY0Q5akdTUU9LU1VFTC9j?=
 =?utf-8?B?RGJtNnhVdUhvSDRwdEJCV1FrYy80RVV4NjBiWmlZTTlwQUR0NTJFK3VPV3dy?=
 =?utf-8?B?SzI0aWFCTFhIbnJvQmVqQWJWMTdVck1uNlpxNG9Banl2R3ZaWXJlcjlLSVA4?=
 =?utf-8?B?TWxXQmx6dUpjRHhmQjNIbUZsa2tMT3NaSlUyaUR4OCtBZ2hnTEQxVXYrTHZn?=
 =?utf-8?B?MDBQR3pNK1NURmhpU3NYR2hvRnVCMXBsVTNlczJZNXk5MzhHLytFdnJYbkZC?=
 =?utf-8?B?cCsvZEFZS2RXY2p6L2lqL1pUdFVUVXZkUEpSVzEwM3g2NnF1WkFSR0l3Sm5K?=
 =?utf-8?B?K0xaWWxXVHNLQ0RaNzA5c0FoTGEyYkVvbjVzUmVKZ0pVWE5VZHJmZTlXU2Ra?=
 =?utf-8?B?ZWZQLzR3Y1kzbnZzVVh2ZE9DY1huL1czWjk0ZnVlUFF5ajIrSU9NNmRJQy9T?=
 =?utf-8?B?THFFeS9ZaUxURW8zM0dRQzdkckdiT0xhSjhXTzFSUGh1UnpnUDRLTEMyb2VS?=
 =?utf-8?B?elpGN2E1SGhkaDUvRFJYZVRRcGNSTVVhWkg0bVcwR0x2WC9UbXdCYnV6SjRj?=
 =?utf-8?B?M1pTaU9wc2JzdUxEdXREeko5emI5YU80N3Bua2RjcnJ5QUVoU3BpT2NrMEJE?=
 =?utf-8?B?S2dBUDQxZTd2blZRejJzbmRRSm03dFQ1a3kwcGR2UnRlNkptcTlkcXhRTEM1?=
 =?utf-8?B?blh3eXRHNzFEaXJPSkNvTHhQbi9hSGRobzF0UFZGM0duOVhHNXlLZnVDbzFk?=
 =?utf-8?B?aVJKK05IV3dDamNlblNPYmZjK3ltUGVwRWFlczczNGRaV3NGTUhMOE9LNHUv?=
 =?utf-8?B?Z3d6czZ3OFBGRDdoZFBoUTY5MXcxNitLQWtQRE9zQlFhUmI4MVozQWRoTVdl?=
 =?utf-8?B?TWc4a1pZNWx4Mi9mTi9xZEtTQm1JTkk4c0FmK21INlFlWHNpRThHS25rSmFC?=
 =?utf-8?B?em9rWkFDUlJQSHFwdnErZ1BvU0RqUmJ6RFhaSE1xZXJIK1NHN2libU5Jam80?=
 =?utf-8?B?Skt2c09nTXluT2p2c1R3akVXNTg1enE5a1RacjF4eDJHdnE3NDRCTjk3U2c5?=
 =?utf-8?B?N3RoYWgvWlNPbDFhNzFaNDFJK1RpaDhLeUNvWGI3TkJCdmkzQ0w4MDcyK3A0?=
 =?utf-8?B?MC9TWDhiOWxnWG5GdFRJUVA1RzZBc0ZNRGNTR2E2OUxrMGU1NFlXZldPZTJD?=
 =?utf-8?B?b3ZtL2NCN0tMQjhKNHhKT3hnWjNBanA1QnNSdC9acFFzQzY4dnAxL1dySTFj?=
 =?utf-8?B?QU1XOVljb2pncnFNUWQzVDkycGtEKzhpV0N4K3VITzdGM1lwYUNyNGhxNUVW?=
 =?utf-8?B?dmhXMExmS2x2bmg2V2RLcGthWmxhYkorUnNLdTJGR09PK3dZLzlEZE0wQzJt?=
 =?utf-8?B?RzdKcUo1RzRZMy9nc21TLzlCdXJpT2wxQ2dzZE1HbkMyRmoxVEdiUEgxRzZE?=
 =?utf-8?B?ekptdS9OV2h2QTdESGhUN0JBMmM4cnRnTVYxODZIVFZsb29SUEVuZjBXMWlu?=
 =?utf-8?B?UzlnK2tPZ1lESkpwQzJONFpVWDZNZkk5WU1kMkFidWdVamIxRE5SbVlHQ2Vi?=
 =?utf-8?Q?EXBjy5MSaTlnW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjFZK1ZYSWVpVlVoSG1VQ3hjcHBab2J4M3NNRCtlMlprSUxzWFJBVnVYYXpW?=
 =?utf-8?B?OHd1QU1UMUpnYWU0SFBtZHJDaEo2eW0wcjROUm4yRU9zeFhRV3c0ay9vaGFq?=
 =?utf-8?B?NXhSZzRmMklLK25BelkvZk9ISUQ5SloyeDBzdjZtQkhYT1ZpM1Jmc00vZXlB?=
 =?utf-8?B?eHpHWG9KOTBWNXpYSGEvLzFTeFAvNVk0WWJ1MS9DVUZGaGo1R2lLV3RiTy96?=
 =?utf-8?B?eVF1QVNCaG10ZUs1TEhNNDkrZVVtWW9SUm1HMzRJa3dwa21Gam9wT2NrWkc3?=
 =?utf-8?B?UG9SV09pcnh1Y1pSRHFSSHFMUmNyTDFxZmhpcHVUcFNVTGtIRGJqUDBhQ0hO?=
 =?utf-8?B?Tnk1U1ZZeEd0b1JFcTU2TTQ0UmlDSjZnWUp6NGd6WTViaUFUY0hVZXY2Q2tG?=
 =?utf-8?B?ejZtUStsSDhlT2pUNlpGY3RnUUlkTG9Ia2t3S3VWcjlyVFdxU0kyb21MTStS?=
 =?utf-8?B?ZW9WRnJxT1hoY2hPT09MYk9RK210OW9BcnlGOFEvMEljRkkxbi9VeGFUR0RI?=
 =?utf-8?B?U04xVHZVeXlMdU96YzIrQVhyNDdYZXk5clZsdUdFeFdqZXVhSmRzMFdzaXJn?=
 =?utf-8?B?cHlpREhtRE12d3ZWV1BGVkFnVFpZOWlGZGZ4ejAyTWNDMGNxTHN1MEZHRjgw?=
 =?utf-8?B?MEROSkpDbmVGakR1dUpxcWptWUdSZE1nalNTRDhGR3k2NXZWeE5mcUl4dVNy?=
 =?utf-8?B?aU5HbUNKUUVKcXZHdUdDb3lIOG5VRmFxWk9lWmFCYlZBVjVOTEJsWGJic3pQ?=
 =?utf-8?B?OGZvMit3NGxMbi9wN1AvUUkvc1pZdDFZZjE4RzlFM3VsQitQK0JUbyt4VzdX?=
 =?utf-8?B?M0xvWkhZV3lrQlQrWjJhR1BZTUJGWUZkR2l3ckJHMHNwNnlEVE5tdU50TlNl?=
 =?utf-8?B?dWZzdTNBcHZJdWZLWEZGZ3V2cTArUllZY0FuQzNiU2NZc1JhSWdmRjdzaFpz?=
 =?utf-8?B?YzMxR05UcjI0U3Jla1lwUmRBcUlXR3B2NzNuMXVkWWd4L3JzUnF4MmFOQWJQ?=
 =?utf-8?B?Nm1hV0JQbUN0TnVsd3dhVVk4eDVUZDZqOGl0REhKRFpOL3htQldDdktyMkZn?=
 =?utf-8?B?TzZWSUk0R0lFMzhrSnBZT1ZHb0hPL0tHMjBZdW1oSDhYODQ1blZLaVgreG4y?=
 =?utf-8?B?SDlCN2tybkwxdzZlRWQ4bkRSLzBrNjZHS01sVHJUMkR3MnF1M1dPdWI5Y3FB?=
 =?utf-8?B?bmE0LzZkQ0JFSUIweHRBNzN2ZmNLNXVpOXU1R1BmN3d1eW5CYkhaQnlkMGNE?=
 =?utf-8?B?emVHWW50UnpUZ3FmYlg2N3RGb29ZWTBjbnRaMkpsQ1dEWThGOXg3OFMzZFBv?=
 =?utf-8?B?aHhJdTZtNlJwbmFzR2xycTZBNmNscndaaUFDaFhCVlFUcmZSSnRCbmN3bThk?=
 =?utf-8?B?TVlWR3JlK1hlU2ttZUc3akxHbFJBdWcwVHBCZXBkSVhheUlZRkpiZnk0R0s0?=
 =?utf-8?B?andGOWZEc2sreStXWStlNDFzTlpSdlZESVdyNnBpU3ZMak1VYThBRFhwaFpv?=
 =?utf-8?B?YWhOSktzTDVSRWw5VHVObVY0RXBTajhzM1dabFN1TW40SVA1WnhCSDE2allm?=
 =?utf-8?B?VllBdW9wWmRzTkY3RWhHbFJmV1kxNDhwRnpIcVJWdHJ3SCtPUW5zLzE3U1VC?=
 =?utf-8?B?T2VsRUIzZFJIWVRLanZNOXdWc3drSWRVRkR3QVZTNzFXaHJIR3FSVGcwdkwy?=
 =?utf-8?B?MEdtY3hCc3dreGhIODBpOVFTWHVZblB4NXFMamVwWXhVWXBWVSs0V0ptNCt5?=
 =?utf-8?B?MW5ZcXlGR1VhbnFPemM3RjRsMEtNV256b1VQZmdOV0RTQXhlc0JLMmVHSzU5?=
 =?utf-8?B?OUsvQTVnNTZJb3pTajhPS3Rudkt1QzFNMTJMRHkvTnk4QnJodUFqa25qWFp5?=
 =?utf-8?B?T2NMc2VOdUgvc1lVR1FoK2ZIQ1ZjWmFiS1ZTVHEwRG5tcC9QREwvWk12V2FM?=
 =?utf-8?B?Um5yNkc4L2pIZWo2TFZrbDRWcXppMkpYSzBzQmtPM1pjOEpxTGcyOW12ZEVh?=
 =?utf-8?B?bFQvSTZ3S0tEa203UHBNcU03U2ErckZqT1cyUTB2YjNrUHhMUWc2QTVmUy80?=
 =?utf-8?B?UXo1NXZvaXV1cXNNT1hLbjZTOWJadFlId2wyQndyTmJYdTdiR1JkTzdWY0l4?=
 =?utf-8?Q?LhIERlewR2XQwhS6h/EBfcpk/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c063c4c-d833-46fa-1f9a-08dd51a00dd5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 11:16:42.5958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pnUjNgP1dMdA85iA9lAi++jIRkZ99IJRcDPKtQFcSEwSQYfzVezqmiC0tGWkx3Z4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8034



On 2/17/25 10:52, Shubhrajyoti Datta wrote:
> The "interrupts" property in the ZynqMP power/reset binding was previously
> marked as required. However, there are multiple mechanisms for
> handling power/reset events, including:
> -Event management registration,
> -Mailbox (mboxes),
> -Interrupts (interrupts).
> 
> When event management support is available (default on Versal SoC), the
> "interrupts" property is not used hence not required.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> ---
> 
>   .../devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml       | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml b/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml
> index 799831636194..079ad977b907 100644
> --- a/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml
> +++ b/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml
> @@ -46,7 +46,6 @@ properties:
>   
>   required:
>     - compatible
> -  - interrupts
>   
>   additionalProperties: false
>   

Applied.
M

