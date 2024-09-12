Return-Path: <linux-pm+bounces-14091-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A919769B6
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 14:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F6831F2176B
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 12:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62871A4E7A;
	Thu, 12 Sep 2024 12:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="p/Y8r8t/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E8B1E49F;
	Thu, 12 Sep 2024 12:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726145727; cv=fail; b=kndqCCvZ2pLC1eefVNWfpSbBbbQN5O7S8HsXMpB6RY+yLZC90L9HtoZCGSOWAEnfMKazpqsWJ6RWuS5bbr8E1tEpGSj5SPB3bSGUF6B9xaAd97vjItCiWmXgC16BC5ZxJLuz2LyF9qG12cCXlAv1DHpJwzEf4TeR/hApoK0CwgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726145727; c=relaxed/simple;
	bh=RgB03KDIjageZX/Vr6zrWtvvtf0ocSF/3Fdk1iuYWYM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Nbawcx+20nQtgviIfsl8C+ySAlKKSX5V5a3Qbhtfqpxtak+fRCLn11uVXYuksz72CLXmMt/nLJqvMHwaGdRc8SG4bx9BdAA13RWSQwbfREgb3FvZYxqxSukHxvcexMlz33QPUflHreIXSXH89DwmD2QVAFOhxDOr7pHV0uo9aPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=p/Y8r8t/; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48C8GVRJ022614;
	Thu, 12 Sep 2024 08:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ltEa+
	S4JKdw7lSK1yxN73Du8Z6TgtK3nNxT8uMPnQg4=; b=p/Y8r8t/lpR8aROePQ9D9
	zcWWX+9rtT+p0dCHVB9JelA919uh2LErDIc3GZIfC0cQcCRODMhMyyGd9CogrLBd
	Fa3HmC0mny1/ZRjtrbBp/VKs3GahqH+cmgFbiLKQJG5M5DGniprGLCedqm9yhYV6
	hxkAwyWhp/cQtQQYcAY9KWeQ8yaWWf147C1PWzmZqwyNahVlNMuobgycBlqC4rqW
	KVktgizF7+lLlKTG+hjcY/sPJV9pFIagMdTJquwfUY+066k0z96l41XUW5VkVcF6
	QEJi2d6edvCqIWLnfKZKSipR2wmKq6iYYY4L3KuMOs3tXIJvWokL+uUfCYrRcbDg
	g==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 41gybdv3c7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 08:55:05 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tVqr4o4Fnt3vMAm6yBi/REo3ivrVQ4PcwZvAi9m2HpeOs8RAMagJ5WlQTkREqOdmyi5QPLz5XqB5DUGrFicK41vIW9bycOLAsGr80KWQnqNGM5l9G5FfZsCUlb7/UAWczFaXnWsLqLHdlz0xUMnNfZXQt7BW0QU41cWzqcn9CryuHvj5P08DDIe+sWomCQWYBaPQ8dzHaBrzVK4fiGSFZzyf3B0uNxwML57HIaag0hsbWrmvg3QKqO9l4PZvJ8hgF/svjw8ER2ZWqJ9tl0FU+hbWcYwqoqs/UIJbolJvsm1GA1Axw1ihxNQ/fpg6aIDo5ikBHoe5GSplDKoBgzHb0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltEa+S4JKdw7lSK1yxN73Du8Z6TgtK3nNxT8uMPnQg4=;
 b=EnFpzK3m5yABf4U95QQsKYyeK+j1Zm9Z2xm3ItMmzrC40BbaNOTDTx3cdsEPifhZiiRGaPW6jwax5Dh21dv//jErK/3flD1mciJsAsYCo0zDBG/LU1Y+zskNh8RVFAmJfDqVqepHIUHON79ZYlRpHJ4/hQLRGHBr0CRsoPMEhBV0DGfjNZmVdjXHH9261e+m7hrFqYUC1OkxbRUwGA2orn1m7FLN5qUrdKJd/shaN3bi5TcdHsx7/8Y/pjf9mCgkR7wH5pbnoSVFrAvvLCWkKXHdZr5FbSs+jM+Ae2f4nT6U1aOYKDvus0KItp+QePBwr3MwoHkb+5+nzi+xkD3s/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB6512.namprd03.prod.outlook.com (2603:10b6:510:be::5)
 by SJ0PR03MB5662.namprd03.prod.outlook.com (2603:10b6:a03:285::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Thu, 12 Sep
 2024 12:55:02 +0000
Received: from PH0PR03MB6512.namprd03.prod.outlook.com
 ([fe80::c8b5:7953:eec1:cb28]) by PH0PR03MB6512.namprd03.prod.outlook.com
 ([fe80::c8b5:7953:eec1:cb28%4]) with mapi id 15.20.7939.025; Thu, 12 Sep 2024
 12:55:02 +0000
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Andrew Kreimer <algonell@gmail.com>, Sebastian Reichel <sre@kernel.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Matthew
 Wilcox <willy@infradead.org>
Subject: RE: [PATCH] power: supply: Fix a typo
Thread-Topic: [PATCH] power: supply: Fix a typo
Thread-Index: AQHbBRK78Nll7m/ShECHUJlsBwJuqLJUG7qw
Date: Thu, 12 Sep 2024 12:55:02 +0000
Message-ID:
 <PH0PR03MB6512F8C4875AB4E522DFE03D8E642@PH0PR03MB6512.namprd03.prod.outlook.com>
References: <20240912125303.44118-1-algonell@gmail.com>
In-Reply-To: <20240912125303.44118-1-algonell@gmail.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?us-ascii?Q?PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXG1o?=
 =?us-ascii?Q?ZW5uZXJpXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVl?=
 =?us-ascii?Q?ZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMzg4Mjk2MjEtNzEwNi0xMWVmLWI5?=
 =?us-ascii?Q?MzctYmNmMTcxYzQ3NjE5XGFtZS10ZXN0XDM4ODI5NjIzLTcxMDYtMTFlZi1i?=
 =?us-ascii?Q?OTM3LWJjZjE3MWM0NzYxOWJvZHkudHh0IiBzej0iMjkyNCIgdD0iMTMzNzA2?=
 =?us-ascii?Q?MTkzMDEzNzYxNjQ3IiBoPSJqUVljZHRtTzA3WjAzRFdFYlphNWtsTUdZWWs9?=
 =?us-ascii?Q?IiBpZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dV?=
 =?us-ascii?Q?QUFEZ0RBQUJ2NXRyNkVnWGJBY0tTRjRqaHZYS0Z3cElYaU9HOWNvVURBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFTZ0lBQU80QUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBRUFBUUFCQUFBQTNMaFNmZ0FBQUFBQUFBQUFBQUFBQUo0QUFB?=
 =?us-ascii?Q?QmhBR1FBYVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0JsQUdN?=
 =?us-ascii?Q?QWRBQnpBRjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFHa0FkZ0Js?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQVpBQnBBRjhBY3dC?=
 =?us-ascii?Q?bEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3QjBBR2tB?=
 =?us-ascii?Q?WlFCeUFERUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFB?=
 =?us-ascii?Q?QUFBQUNBQUFBQUFDZUFBQUFZUUJrQUdrQVh3QnpBR1VBWXdCMUFISUFaUUJm?=
 =?us-ascii?Q?QUhBQWNnQnZBR29BWlFCakFIUUFjd0JmQUhRQWFRQmxBSElBTWdBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBTzRB?=
 =?us-ascii?Q?QUFBQUFBQUFDQUFBQUFBQUFBQUlBQUFBQUFBQUFBZ0FBQUFBQUFBQXpnQUFB?=
 =?us-ascii?Q?QU1BQUFCT0FBQUFBQUFBQUdFQVpBQnBBRjhB?=
x-dg-rorf: true
x-dg-refone:
 Y3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3Qm1BR0VBYkFCekFHVUFYd0JtQUc4QWN3QnBBSFFBYVFCMkFHVUFBQUE4QUFBQUFBQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURFQUFBQThBQUFBQUFBQUFHRUFaQUJwQUY4QWN3QmxBR01BZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0IwQUdrQVpRQnlBRElBQUFBPSIvPjwvbWV0YT4=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB6512:EE_|SJ0PR03MB5662:EE_
x-ms-office365-filtering-correlation-id: 3779f028-1edd-4275-d8a7-08dcd32a1e13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?5cM1S+Mh5WAyw15nkrotf9fz4Auri3hWNa8y9Msjyt+T8Ge1pG3TM3u7wwzf?=
 =?us-ascii?Q?qqOCDxt49YhLhVI+bxQnPuTrwA4isD0An0uoiFAej+KaR5p/aYNNOc+/dKp5?=
 =?us-ascii?Q?9OHmSuqr/tqqXK3xSdw38x/Mk3+NyJKfcl17AZR/j3n3mk13F7wQ6wuKig6N?=
 =?us-ascii?Q?WVpOKQXr+TpF4IDfN+0/DYGBnoDD2tP1sqiTKHtbmCpRjlBI+JWy9Cv8ylBP?=
 =?us-ascii?Q?PW58akpvhlPKXh/uUIOaBzddopxMNnLHDjwYDgjaWWVWu9pLZnwGdFDWFLo+?=
 =?us-ascii?Q?gj45XJHe6rT8OGiLksp03AHpm55lLFYb7JJaGc2QtGr4R4IWoNg9elotF80i?=
 =?us-ascii?Q?2axFlRTKoUG1ukaXplBGwahEbjCq3S2gzpPY9gXRMJNiEaSGj3Zh3Jh5aH8V?=
 =?us-ascii?Q?Ff5HRNE0A+EliP1P6hGP0c9q8UVthoG3PrZPVOMO0TVqEXvT4Q66u9nMHQ3T?=
 =?us-ascii?Q?lsUtwUCLksg7ZPZhoS0qPCcKx2DnvhTdfKNLK0pDwvdLpuEIN1O8U+0Win2G?=
 =?us-ascii?Q?bUYlZf3eCPH+CEdgZYtvN1DZ0ACxPlrLQmm94jqEEEwZgm2y46r6XAuazIa7?=
 =?us-ascii?Q?JOql6qLPkSsLIazVCEjinMUBU5aJgN8yhLCdHjeApIqwxISiNa1PA6ZPaMRV?=
 =?us-ascii?Q?2kEfL7BCDNhxF3I8kpY+e8H16GhDJGw+m4RxBRsDUsUBxu4Sxl2uZrs6PJ+u?=
 =?us-ascii?Q?RqLd4phcJGQctRI7uhybtfHu94+9Kuy4LOJkc2eZO37lvgwlNcT/vO3BJICl?=
 =?us-ascii?Q?i3q72DY4+b426ty1XD70fD12qLpP6vhC00AYBL2l1PaYZ7Drfs6MMJnSKWTF?=
 =?us-ascii?Q?rSn7yP655D2YZZZXVKdCHzbizZrjndMWUI4t7BXVcdqJIOMR/fw3RwmIcpo4?=
 =?us-ascii?Q?3gMYVYUWZ/VlsKz6miny52FiHsonqqYQqVt/XT3UxXZ96OQlKXBSSMGSpeFQ?=
 =?us-ascii?Q?AC0tipjl46D54S0wfwXYa/TtKdRKlsMGAmUiSRFNuzEr9EA4fvtDvlgsHCrB?=
 =?us-ascii?Q?64Q93g5b9PduPIzSM3Koe3jmuQBA7ut35LHP5PR8aIWL3YFAaaPxl/he9vyG?=
 =?us-ascii?Q?EUnhKgV0lnESF1zj7xCHQbrwnkeRI8gZHGHtGBUKX4z+GlBWMgNdf/t6s7Ef?=
 =?us-ascii?Q?smAo6aUrCqD4zjF6Uqc/OefE52NAl4C4JmYoRgAc/TRadc/09iSFTAXQhsHN?=
 =?us-ascii?Q?wG+L7qpTLI1a6qkJLWsPkTE047eP4t7LpT2RM3WzezO/v4L3q3iAQiveMOpw?=
 =?us-ascii?Q?rNcrE9y3B32oltYwmyDaF34/csyMbmHkgP8chDk9VsPDlA/N3pR8TLMn5CGY?=
 =?us-ascii?Q?c2peyTGgprQdRbyWqshYk/egHzGqOyoGjXb3Ls6fd7PIjjg4cE5jSQnxxL5K?=
 =?us-ascii?Q?aUoMFUC+bVSwthvQ3UVJwlXty1QJoaH6NSHR4aTK82/c/cmcrQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6512.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0BkAV1NjvOYVPmhLlNRK8F7uUpW/jqenkqcWEJTyWDEunfV4wWE7CbyL6a0H?=
 =?us-ascii?Q?KYuaACrty2cNRTZVSIg6kk5S12v2qfZufhOusYkxepWZgP972+lkYW9o9Bvf?=
 =?us-ascii?Q?ozfMX7deTr9g9tFV3O8AvVKOAHQJdVnQ4An1J+H0WH5dxlfm0eq9Emfp/SGV?=
 =?us-ascii?Q?rpNWBUed4j5z+Qzff/jVfzfAgaVjElkgQdncKmGdHlvzT6QLnSMHLmV/oh/m?=
 =?us-ascii?Q?8aLwEnRBiMbdbWpwf5xwCXye/kSZSSlArWl273kioQNZux3kvRwT3/v5NcLO?=
 =?us-ascii?Q?p551foBSdjC+tkku4sRBKO5GwJ7D9OMJGCr2AGJ4x9USnlPhzte6JY1YfM8+?=
 =?us-ascii?Q?XAvqgTHu3ZVvHbF+0Bf0nvAw4cEATDUUMNS6tjEVMJ05HJda+X37mXf5TT1X?=
 =?us-ascii?Q?mpoH2IJ855drDygpuIAH6/voXO7k9YwSGpZDMmJtVI96zCUuMMTgC1fq8T6H?=
 =?us-ascii?Q?vHd1wLFJ8AHPRzWAMJ/GDLDP6WZ7M6jXeooSq2j224Vycgj8TUjdPOGrSgzT?=
 =?us-ascii?Q?ucoiVtMdmfenyzpAv3jfUX9VMHKmZJvp4gDmT04h8Zxvr0AxCL2+E6ELS/xA?=
 =?us-ascii?Q?QMsKtCTKFWaRxnT3KhMyMSXoZ6NNxUjjkEplQBa7lvFHgNXAi8jNPnnkEdRu?=
 =?us-ascii?Q?2odAm7M/zVuxaPGj56TTP3JCCo4FwDYS9ZHcozWkcnbLslYyygTwsB4MQAZ9?=
 =?us-ascii?Q?6oxW3MArqfW8bCz3GBggf0rUXs91OlpRnA8AukI2wNK5HMWBanCoelC/kAab?=
 =?us-ascii?Q?ZLSA5DRxcB/Z72QfcAPO4H8W0DJm4sTeH/x0zqGHEO01qSg7s3x/d2Qt+JeW?=
 =?us-ascii?Q?pbazRXETtfJcOXWlN6RmMHlh+SpDKIsFRCjY8LjXQaYmWDH8Qm5vo7fnHTMt?=
 =?us-ascii?Q?tmlBlSJl92B9HBrgemLKzZCEwwUWIf0AImEv3boYnRgFTAiMPwOMs/Hy/gJ6?=
 =?us-ascii?Q?RTgfJnEdon5pM1ow2uGX55/itQtdR84Dc1ORZg0P3O2O1sxzFKd3+QsU4mqe?=
 =?us-ascii?Q?BEHeGbtMUfx3D1quPj0/5zEx92mSecY8/gXFxSPY42vkgcGXFTf68laGYsN/?=
 =?us-ascii?Q?AAknbS+eqjXOliZkMWdia/fpn5q30IE7tqkWAzqvvr7ln2xhq/Yz/KpZvFMq?=
 =?us-ascii?Q?DwEGxO0p4EU4qQ/PjlCr2XkNsMIAhx1t06z9DPAlUcL8cnW6jRUNamlFbpE2?=
 =?us-ascii?Q?gdi/OJP98XWuROKb/yH9IYd3fmpO43NEXby/BzoL6UX/zM36clMrPvMHplxG?=
 =?us-ascii?Q?LqAMNDYJCQ1Ly/XTsvSeCYXrlVI7owkFmBRY/WMhlOa+5oj8Fru+0IKtHDE3?=
 =?us-ascii?Q?MYgvMklqBQcMt+lz/0h2lw2cQCLZJ7zH8tUjIJq/o0XdhYkAPK0LjjsD5y7T?=
 =?us-ascii?Q?5Wk3fY3g6Bqdx9NLeQIK0OSCqKF3Wz4jHIP6EPT0j+EBSOnC9x/6CuSi1fuN?=
 =?us-ascii?Q?RlsFE5VsD/fuR+qwOTwaAKCc2hFHF0gD0aDtHrrSgZykMYWlOtQGU5sYw9jQ?=
 =?us-ascii?Q?g+aSiz9u8uu0evGwwtQpIc9q/Uf4zvTld3AM+72WwKh/FnpVSH+iYXtrincT?=
 =?us-ascii?Q?jFj4GAXlRV0691UU7Fz1KUrH63DDdr60E03tHFjtLQb/b///qqgaz6QimzPy?=
 =?us-ascii?Q?3A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6512.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3779f028-1edd-4275-d8a7-08dcd32a1e13
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2024 12:55:02.5983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qOnbyzWIpvDZf2Jqez/gNajZmZb/FCQI03SsuEdcIeeAdVQ7qap50D+5yqyEL3//NWJrRSg+b7DJP8xpFyNAC/DzKdk6FNtxBBNZcuY4ilc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5662
X-Proofpoint-GUID: 6fPdp3VI6Y12xuGqldPRIPCWrGDSZYXK
X-Proofpoint-ORIG-GUID: 6fPdp3VI6Y12xuGqldPRIPCWrGDSZYXK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 mlxscore=0 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409120093



> -----Original Message-----
> From: Andrew Kreimer <algonell@gmail.com>
> Sent: Thursday, September 12, 2024 2:53 PM
> To: Hennerich, Michael <Michael.Hennerich@analog.com>; Sebastian Reichel
> <sre@kernel.org>
> Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; kernel-
> janitors@vger.kernel.org; Andrew Kreimer <algonell@gmail.com>; Matthew
> Wilcox <willy@infradead.org>
> Subject: [PATCH] power: supply: Fix a typo
>=20
> Fix a typo in comments.
>=20
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>  drivers/power/supply/adp5061.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/adp5061.c
> b/drivers/power/supply/adp5061.c index dac9875d993c..458fd3024373
> 100644
> --- a/drivers/power/supply/adp5061.c
> +++ b/drivers/power/supply/adp5061.c
> @@ -590,7 +590,7 @@ static int adp5061_get_property(struct
> power_supply *psy,
>  	case POWER_SUPPLY_PROP_VOLTAGE_AVG:
>  		/*
>  		 * This property is used to set the VWEAK threshold
> -		 * bellow this value, weak charge mode is entered
> +		 * below this value, weak charge mode is entered
>  		 * above this value, fast chargerge mode is entered
>  		 */
>  		return adp5061_get_vweak_th(st, val);
> --
> 2.46.0


