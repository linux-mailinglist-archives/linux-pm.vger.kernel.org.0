Return-Path: <linux-pm+bounces-21970-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D747BA32A35
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 16:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23EDA1881554
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 15:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2676F212B05;
	Wed, 12 Feb 2025 15:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IqUxjMSW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA9520458B
	for <linux-pm@vger.kernel.org>; Wed, 12 Feb 2025 15:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739374598; cv=fail; b=QmpUh2ckGtI2weu0RAWlElerbcTGR9HYQrz5orDFmCERbZTg8SUoIXVUnTBNBClxegipA5Du3uJjdchju+zuYlI5ww67PrQ1zOr7ItWmqJ7zxBz+e+eAvepmjxpWp5vFIH1HzpGRUlAe2VYfluboRuSMa/Lcyajj5m+rL7PxPqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739374598; c=relaxed/simple;
	bh=I3Ye/c+4/2DpR9PPag0Avs1ePbKxs090LK54ndgczqA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c1mOle1UciiK01+R8lgElwg1VFkskm9pzG2PEz2wF4f4QkiN5/s2BRO9wH+IZAJ+IF/oqfvb1eb1mfpa6EkCV0mnciBzOnlwzGgpcS0whOxPDIh/vkj7bvFK6BAiC/gLKJlMjepp62gZFXnwZXeNrbhosHx4Ff7sNm6TshDV880=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IqUxjMSW; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739374596; x=1770910596;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=I3Ye/c+4/2DpR9PPag0Avs1ePbKxs090LK54ndgczqA=;
  b=IqUxjMSWFTSRaqzFtOY1q+rn4POAVNOB0DEuZGNcmkVtYP3sTIiryN8C
   /NXzPaemMKTuTWuwpCkz4ZmePdGGyOZm/pNzaSjA+IDw79LOiYd69ILA5
   E1RwaHzbGSoX/Nl1bHO7RwSM8vmeZYWX+mfWB+l/lTEDuo5zld8TjbpK3
   2nPEkEf9B6+QTPaUSSae7i6SJkSBWyNeZO1/eAG9GBalDqzIW7SIyhfa0
   ZxnR6/MFsembpHn81x3yQBE6z7JA2naxSXSu3gPCWdGORw4SZlCrQp8jf
   X14/RiJtsND/Fr73yMcRdUIONTbk192R7dZCI8j5a1OTF49zXDXGfDEGw
   w==;
X-CSE-ConnectionGUID: OdH5FOyPQnyEPOOPgSVkFw==
X-CSE-MsgGUID: 1WqivqCbRwuV8kLWnN8W3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="39226212"
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="39226212"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 07:36:35 -0800
X-CSE-ConnectionGUID: ZJJTNpauQTqdpNtgcZq2Vw==
X-CSE-MsgGUID: qAvmLxtzSyKJmVPnkXppvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="143703914"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2025 07:36:35 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Feb 2025 07:36:34 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Feb 2025 07:36:34 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Feb 2025 07:36:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQpmZKL9qeMWBNlTUHGreqnC7/niPOrTHP4t6JoQffT/UAUnELAqfvTl6OtTFufxBguqMVW/mITKLdxTkiC110+5dgts5R8TUEEhmMeu4+pD7XzdK5cDLBE09srxRTssxOq87O+gHg6ERi6AOzXlGIox3AhqrATbxO7H30QQTgvwROtkOR5ZwddYyaSDwk7G+tPp8CHGthLnK6b4XJPR5PuXCKARpimOhMgBErb6/xF9lRVrAXPHB/UTgR1ywhKMJHEUUf1JvYnHZkUDD0Pi3UIHpAs2ljkxsc1+SG8pgocv30cvqDAGsQt36bNrCeizJnAhpDtJ0mGWc/7H2Nzxpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNt3BlhUZX1Ne4KJC4IRnTteUWDKyuFG+HLoF8izUP4=;
 b=fJrqPVTx9b/nr3gRifXUJXHHvxDszzlYUmN2MYGgotLyaquaaIDuRKIM1BoUJ2CT3nixnSoqBLc7xixeUkwhS5y2Zbx0EbtLLLyYUmzv115Oy4eU9MEDe2spOyNGxM+u4UgtoKL1SeYHKrjzZ+w2NuUw9kK8/Qu+e/SynzlUtxTFZ/qQ9dfnEISdx3HQhI+7d/qHmk8Qa7Y8U6bSB2PTSHI+LLSOgaqHw/aItettmG60gVFDWF71S1B1G6m4Bjw5U3QcH9l/yuveBbFoharjl/jpGcJULKhVjPnJrGG3ST7iiA76XKw39CjuwxEBG9eDdGtoYHJB+Wl3bo6t5N8Pag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 CO1PR11MB4979.namprd11.prod.outlook.com (2603:10b6:303:99::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.13; Wed, 12 Feb 2025 15:36:16 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%3]) with mapi id 15.20.8445.013; Wed, 12 Feb 2025
 15:36:16 +0000
From: "Chen, Yu C" <yu.c.chen@intel.com>
To: 'Jie Zhan' <zhanjie9@hisilicon.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linuxarm@huawei.com" <linuxarm@huawei.com>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "zhenglifeng1@huawei.com"
	<zhenglifeng1@huawei.com>, "lihuisong@huawei.com" <lihuisong@huawei.com>,
	"wanghuiqiang@huawei.com" <wanghuiqiang@huawei.com>, "fanghao11@huawei.com"
	<fanghao11@huawei.com>, "prime.zeng@hisilicon.com" <prime.zeng@hisilicon.com>
Subject: RE: [PATCH v2] cpufreq: governor: Fix negative 'idle_time' handling
 in dbs_update()
Thread-Topic: [PATCH v2] cpufreq: governor: Fix negative 'idle_time' handling
 in dbs_update()
Thread-Index: AQHbfSdFZtcfNadXGkeFyz7EgaymZbNDzQnQ
Date: Wed, 12 Feb 2025 15:36:16 +0000
Message-ID: <DM4PR11MB6020142F54F6CCB497ED1B9EA0FC2@DM4PR11MB6020.namprd11.prod.outlook.com>
References: <20250212081438.1294503-1-zhanjie9@hisilicon.com>
In-Reply-To: <20250212081438.1294503-1-zhanjie9@hisilicon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6020:EE_|CO1PR11MB4979:EE_
x-ms-office365-filtering-correlation-id: bcfcc257-be12-481b-e89a-08dd4b7afd14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?8OOYBYn8OpbJpVJRP3Hhyr5ZiYVfcC3cqhC88VR4VABHbT/JxKy+m2GPC64s?=
 =?us-ascii?Q?JYFt9Y/99crSn9f2Bc9wNO7xyzTBA+SlREXqe2E+yDQZzsNPS5q6yi+XSbxW?=
 =?us-ascii?Q?oF8eLbYIovIca/qtj4uSLIR6ccw3nSBpWPkpXtyEfOXfRYboQjUO+w9wpETc?=
 =?us-ascii?Q?vPcC068ecVo7BQqeM1KT4lORyLK/A3/SZWRmkntWJ4vn3bxIjre5kRz93xLp?=
 =?us-ascii?Q?wBtQvbU25H/vBJ+JLhruT4jvduqHKw5gI3d8u7IaiuyCDPPQdDiXGSNt6Nxh?=
 =?us-ascii?Q?SWEme4cKao6MBSUkzgBsu93ih82arpF7ww2s7lRA339JcA588O3NlVEQAEUX?=
 =?us-ascii?Q?MX4SVA8jaBDCYZaGMkTSbwfMAG52NNfkJnxSdphWxnNaoggf7gBLj5BGGD8l?=
 =?us-ascii?Q?tK6CJiksiPG5O7UemlycIUyZmyMd82msOAavjslp9yT4tHGdQM7ZeUCs64jY?=
 =?us-ascii?Q?z5CoAHeuh4sJriaooKi6E99YP29sDNLllV9Qlsru/f9xgdILmYc1/IIdfGV5?=
 =?us-ascii?Q?m8B9Obf+adox8InlN/0Y8ql/e26Lx6kzxUb8ysK5/VpEWUkT53KYyokd1ha7?=
 =?us-ascii?Q?9A39m2inbzGtu/iB13AHx3RvxXEbe+f7ROgICL3gHnIhCAX/4kmVSmeTXpjy?=
 =?us-ascii?Q?ASc1ndv1afcrVOYK9tCT9HlPsVOKlyrcEm4uEDBOCT51OBSOBjFBjEW3SYxW?=
 =?us-ascii?Q?IBxu58XrNXsPkJfI0rmU9pwjmzQs0OQ29Sd9uNn3ml2mucVXUCpY4Ru6wgLO?=
 =?us-ascii?Q?Tv2p9TdOdHO4ajdvv3yiH0/Gdrn7mUV1jDLpKrpaxwQ173J7WlFfoWZDDM/y?=
 =?us-ascii?Q?tdyIjbI1Vnap99UuvcSc8NUieA6PGTWDbn9YToLeb65Zs+sRWp4xNelonVxp?=
 =?us-ascii?Q?UNnoO5nXvT2FRAh7ZWf0oU+lshYERORiEkULtzeNWtHX1zSlNWRKhawSNAQQ?=
 =?us-ascii?Q?I9SHjkSv2E+1SOrXgMUJ0Qe9m1fQAFcW3gUtBkFTzDlJhR6weOinh0784osB?=
 =?us-ascii?Q?yP9AcfU1bvGJxts0u0GfFxFuKKIHR6eAZRQIPJyQgyjnR4kSgbV45YitlcjN?=
 =?us-ascii?Q?kaOZg4bcVw3A2XrR4OAAkGbCaEMzjJZBaD6AJmlRwfTaxx1sOpaXZMZwc3hs?=
 =?us-ascii?Q?EXzVbmw60o9L5TqAfwEbzL5DrkKLvK+SvylcOrO0+AiX0ao0/cvaEXZoOrvN?=
 =?us-ascii?Q?I/QHMikglMSq+HBRdy7kQlbqXfM62fQGsRSy7b3tHyVRg+FihJp1YW8smgQL?=
 =?us-ascii?Q?2O6NM2GVH5XzjmiXtQabHm8q9T/YlHIYKklJOYMk9ojdNDO9UC/uL6jirMXH?=
 =?us-ascii?Q?aZTOSiKZo0AD1O/EDUQrtwjq3f7EHEbC5a7A/lc+/1J2aUCn/S7UBZyz069f?=
 =?us-ascii?Q?38uRWdTv+KiUOx0CyUTBASmo3YXsEqdbzRm9+e3fyeYORiFHXYux3VMAFpKW?=
 =?us-ascii?Q?Bf6eji04g14WeVbEOhKtDP330tCyAz35?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tBvJDTQepgppFyUC490cImIsHRDh8YKFknVFtyIN2KtXLPQNowUVeWshdKLm?=
 =?us-ascii?Q?f7uyGUn8WVEnIfk/ihc6DTJyfM4RgQlywfCSa1yEj8HAD4bxJ1NgkG+HllA5?=
 =?us-ascii?Q?XdUIMhovNOxd1j2jVw4VUvM6WYefBLjmR5PZrX3rnD7M1V5iBqfFgT909iDo?=
 =?us-ascii?Q?07LM01v/94Tq6IFksSG1nRBSCqk++r1xH2F7c6vl9p/x7ckh8+5HKJ82LN+g?=
 =?us-ascii?Q?aHu+vdFDd58/KZF5ceNCxi390/3A8Y1oBgatdF7uTaoZVWCTT/tL64HWg77Y?=
 =?us-ascii?Q?BBHM2P9wgC/Dmaiezcu1arxVVV5Q/1nxkyhThXNHFraXJChTTy+FDzHmE9+m?=
 =?us-ascii?Q?Eu4XWKWhQ0Twni/2wesWX4ShC3F+auZrRX9bzm3sedsdo/ZWLF9Eqi7x9fv+?=
 =?us-ascii?Q?dvyigv4JZVJ8YZ4BYzAkBzWMyz17XTtt0jd0+VyoQHpOfjxRFEJ3bWFz2npp?=
 =?us-ascii?Q?NtKH8DA/3JoWlPp6dImQ8guIsdxEvU3yaBsdmI0oClw7/3vUT+2dMWnWrIQo?=
 =?us-ascii?Q?GlxYJ0UOEFViWfMP8r2H/sATgcmQgfNjtFDn/D9gWDk/yX9gu/Yja8YssnP8?=
 =?us-ascii?Q?H88oSOgLcWZo0YX+haJ9QQajp4vWIp6y2mEMqCzu/KPBJ3a5TgZ6ouK/XHYK?=
 =?us-ascii?Q?T+qAMT9s5F33LMML0gvt4SEEvId4quVQSaY1Bcd/mbDESeD7kiEv2PWeZ/+C?=
 =?us-ascii?Q?cVN4GMgtVvam5HS/wE48NoRz6vuC5zHuFJZLBp+4Tq4uCfNmre2RYPDbrmpL?=
 =?us-ascii?Q?GPVL31uyk1RYT8Aoef6ipQqg1aZySWT7YftdMYU5O/pm76Oi0LE+jKGpEc9m?=
 =?us-ascii?Q?qOAS/c6/Cu4eQT7JL6D5EWVVgPaVmygwHS0h4oQSetfQk/FU2nc0CqRhtgcg?=
 =?us-ascii?Q?m1MQ+GVLBrTXbdJbBJj6mlidzEdiBoayVJRc4q/2QXIb2ze9uDK70w6Lg/pR?=
 =?us-ascii?Q?awClnjR9w4GzUTfv4lb7ee18PwTqq5gZs41hkATUmiXzS4tw1bkKSC/yDf9t?=
 =?us-ascii?Q?CiMSi/x9s3nlzal7JBM+dOssAYRAV3qCPSz6BkaZV0kVnoAaHmnsVfSR+u3G?=
 =?us-ascii?Q?nCN4XxM/Gzzf8Km8HOdRBATEGqfEfvMBuncDPtFPpW3IFOW0syQCH1c75npp?=
 =?us-ascii?Q?qx7P6aOLGO1vMntUu7ccn2u6gW6JQXdKHqLw1yDx9u5Qla04hLjHMjMI5LDF?=
 =?us-ascii?Q?GKQ/DpYSURj/Ld47g2Wrn1P5yJjEA989WXTohdJIcUhkmp83cPEj8Go0cC1C?=
 =?us-ascii?Q?G0ySiEY9BaoldFtIR1rzXk68ZaJisDjL42aohi3pfjn6EFitFOlN6A5A2nm+?=
 =?us-ascii?Q?mhj6mxI/UpDzv1eTAJ0JTekwLyjHDGP8oFKrHLyyIKorVSOM3Kx/w8dqwovf?=
 =?us-ascii?Q?FJFTE4pyBNDe4/DKGJLUlJfi6XkcWp1oZeGVeanN8VEzKPRFUJeAJAbOqMbf?=
 =?us-ascii?Q?8vXKm7Z5TsRCa7GjoXT8vWW68tVfKFzxPYBu8qjtjK0wMkRBMBnACyf27vn1?=
 =?us-ascii?Q?nUhnxfPS3H7V4l4R5O8WacAKta4BYQOOOmt09AM/l2lJe67mTmgR9yltWXX7?=
 =?us-ascii?Q?ez1keAwd5Av7rKphIh2TOjgaaWsuZzPEufLUYo5s?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcfcc257-be12-481b-e89a-08dd4b7afd14
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 15:36:16.0431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gxlyFgrNeN1xz1IKb5N3avfZG9byAU5xDyn8ZGbgif69teVB78g5tp0ke3SwNo//i1AGPNKkw14b/pZXkcX/Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4979
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Jie Zhan <zhanjie9@hisilicon.com>
> Sent: Wednesday, February 12, 2025 4:15 PM
> To: rafael@kernel.org; viresh.kumar@linaro.org
> Cc: linux-pm@vger.kernel.org; Chen, Yu C <yu.c.chen@intel.com>;
> linuxarm@huawei.com; jonathan.cameron@huawei.com;
> zhanjie9@hisilicon.com; zhenglifeng1@huawei.com; lihuisong@huawei.com;
> wanghuiqiang@huawei.com; fanghao11@huawei.com;
> prime.zeng@hisilicon.com
> Subject: [PATCH v2] cpufreq: governor: Fix negative 'idle_time' handling =
in
> dbs_update()
>=20
> We observed an issue that the cpu frequency can't raise up with a 100% cp=
u
> load when nohz is off and the 'conservative' governor is selected.
>=20
> 'idle_time' can be negative if it's obtained from get_cpu_idle_time_jiffy=
()
> when nohz is off.  This was found and explained in commit 9485e4ca0b48
> ("cpufreq: governor: Fix handling of special cases in dbs_update()").
>=20
> However, commit 7592019634f8 ("cpufreq: governors: Fix long idle detectio=
n
> logic in load calculation") introduced a comparison between 'idle_time' a=
nd
> 'samling_rate' to detect a long idle interval.  While 'idle_time' is conv=
erted to
> int before comparison, it's actually promoted to unsigned again when
> compared with an unsigned 'sampling_rate'.  Hence, this leads to wrong id=
le
> interval detection when it's in fact 100% busy and sets policy_dbs-
> >idle_periods to a very large value.  'conservative' adjusts the frequenc=
y to
> minimum because of the large 'idle_periods', such that the frequency can'=
t
> raise up.  'Ondemand' doesn't use policy_dbs->idle_periods so it fortunat=
ely
> avoids the issue.
>=20
> Correct negative 'idle_time' to 0 before any use of it in dbs_update().
>=20
> Fixes: 7592019634f8 ("cpufreq: governors: Fix long idle detection logic i=
n load
> calculation")
> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>

Reviewed-by: Chen Yu <yu.c.chen@intel.com>


thanks,
Chenyu

