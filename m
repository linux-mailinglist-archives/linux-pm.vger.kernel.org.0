Return-Path: <linux-pm+bounces-31977-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBF1B1BD6F
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 01:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F5F218A6559
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 23:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1655246BCD;
	Tue,  5 Aug 2025 23:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="i421JPBd";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="dI23JXqX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gRQtyYFs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140161EEA5D;
	Tue,  5 Aug 2025 23:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754437281; cv=fail; b=cF0t72WkCDYHp+HH6oqT4FMBsoXeXh7WxBZK/RNsZZf/rlyNzJNfi5b83chkoCuqYkx7JTzFwebdap/AA/MiwKNPyhmEK7q255zdzszrutL5xJxKkfMlQj8LwciQWnmbUFYAUzL0NuQbKVT0EMa21+K2Wxa6eMD0T6NqOYkBCNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754437281; c=relaxed/simple;
	bh=SeJnGdynUesXpZbidIkY4jfworgQUMjhDkprK8GEts0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LOSjtvIU87ddx2kd+Wp8j9zBnhxxWwcIYEap3DYrSth/jTEKEXDBMB9jI1yRvw7LQDkBKxXLEVB1R4FhJhCT7ZceZjAiwbXGlXvkH+e2yWVlHyipTXncdhGAZvmPBvyZsFwJ1VyaIf1YOLuKZHt7ipH4jeYjcEuu6rpUFrmauOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=i421JPBd; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=dI23JXqX; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=gRQtyYFs reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575IAiLh001020;
	Tue, 5 Aug 2025 16:40:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=SeJnGdynUesXpZbidIkY4jfworgQUMjhDkprK8GEts0=; b=
	i421JPBdfrRqFvErqViEJATKawAG/A4ATTbTsDnyMTmiI+9g+xBrmo67GboFAcot
	oihSBUqkIGhKLTiXOHxN8DKPct0dcHrnRfklOXyyO87SZyAs/delc2HSm4tumZr5
	UCvFOb2DJEJ1u9PJ2WTiVS/yz3+B5XWX19NPIAsV1J7+vLdRVNr4YC7bfiDF1PXc
	9Va/U9cyk/yluOicS3B2rCTErrobTFkrNtMo8D7ujnlSdPiNBWMeL1mFcY49Tk79
	0wb7uh8zulv+VDI+Gy5Pk6w1zc2pAjTjSU/fMfvqK5Un119eQqp+8XVG2abkWglt
	g9OUSwmB+rJHhuZ5++iG6Q==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 48bq0r9f7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 16:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1754437251; bh=SeJnGdynUesXpZbidIkY4jfworgQUMjhDkprK8GEts0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=dI23JXqXu6T2Vd5Ak8UC5q73TPPcjIUUKjKWYS7kJNzSIe2KwY1R2bOsZ+3CzkfqQ
	 832cCjB5BLUFxXY+XK8w6KRIJrEUN5zWI6gyYPd1yAQp6Upt4PKDsui5ZANzfHqURX
	 3FmNJH3Ipj8Rtjo//e9SJd/nCb1ZK+5c/7mRexWzsPD+hG/MeoDFQhs0aHJloSxCtL
	 7pWil1J3ipN7SKlPWmQ7OVQ1bLyAgIckV/hCMk0f+EmpKrudoDncXYxYYV56S9tp/1
	 EFOswF16FE6RECotGnOx6ZEyZ0KUamUfNSPFaFkxyeH7h7f+AqAMzD054t/Q3BWFYb
	 5SxYggQrd7B+g==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B7ECC40087;
	Tue,  5 Aug 2025 23:40:49 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 5758CA00A2;
	Tue,  5 Aug 2025 23:40:49 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=gRQtyYFs;
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id DBEE340596;
	Tue,  5 Aug 2025 23:40:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rac+hWUtY+tWhZSAD6+7ts0ZMeDWFRnEtrugE+utUZdCHF5QMj4fPVuAnARPFNn6VQrInVAK3G3ckxR4ytWxpiJR1JvXr4ZRl4tB629awcsZjIg1UP3INRGbi0THwYGlEFUoMkog66LQNRZFx6/jDXzKCqFYrp2bGmy0WlUYKQGuYce7FJ+L2wsXQji0MQM5GymdCsqEVVnbr9EnpGZMsL0JiAsH5gDDzirXOqnvdo34i+YOwHIiWajsLnXIR2NpfRO613+mHm9iWseZeXYP5DKATbpcNBtoPXo9HNqWyFae7sIIQGEPUUK6LdrxK5rQ5L7K1tMqQbx3X+SPzgqkQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SeJnGdynUesXpZbidIkY4jfworgQUMjhDkprK8GEts0=;
 b=D/sWu2ptOTwUBaY8Q6igX7XURBRnsMGim7lqSfXDNklTN3h2gVSTKFCsYvevHfwt7WucQfW26+LD9bq6ziHsprlWEwSa/QV2ptBwVUXkKNNvOl3IDfJuTVYBAU9ON55UA0cuhTFkoPtltJ8VO1W+9I8Qa6dG0Cjrw+IuEbZmxH5Hzu08xsa1JJuiEHl/CfmVRPvMAulBXVd82t4SkT8ND/KEVQBpFK18pitsjJ9iMET5A/o2A7hsERT7u6s3AUc69T2kqXOSIhk902q+FHkfTs+htGR20QeVqTdt4gJDlPp+jB1eYm3ttt4tvI6Kfc2KkM2Z6SEpZMRCGKf+a/Eq3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SeJnGdynUesXpZbidIkY4jfworgQUMjhDkprK8GEts0=;
 b=gRQtyYFseWKQBcf/EosZ3TQ/hSIhtYlGyQiTDtPP+UXUs9fbBm7I3RhqUihnTlYdn6tyfGN2WImN6DVtVB6loZ1Ai8qjeSFt68Hv1DROzAtKTBf8mWS8Xt23cOsqaRGngReV5BUDf0QypSkCJRHx+dXzKiqhpuETY2Vcodp3tAk=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SA1PR12MB9516.namprd12.prod.outlook.com (2603:10b6:806:45b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 5 Aug
 2025 23:40:45 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 23:40:45 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Peng Fan <peng.fan@nxp.com>
CC: Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@kernel.org>, Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Xu Yang <xu.yang_2@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 3/3] usb: dwc3: imx8mp: Set out of band wakeup for
 i.MX95
Thread-Topic: [PATCH v2 3/3] usb: dwc3: imx8mp: Set out of band wakeup for
 i.MX95
Thread-Index: AQHcAp2uf7v8ge4llEOYVx25CxeV6bRUv30A
Date: Tue, 5 Aug 2025 23:40:45 +0000
Message-ID: <20250805234044.j75p6bqfbjidxm3b@synopsys.com>
References: <20250801-pm-v2-0-97c8fb2a433c@nxp.com>
 <20250801-pm-v2-3-97c8fb2a433c@nxp.com>
In-Reply-To: <20250801-pm-v2-3-97c8fb2a433c@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SA1PR12MB9516:EE_
x-ms-office365-filtering-correlation-id: 3cbf3151-abf7-40ea-8b00-08ddd4797fe1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UTZnb1VQdWp5cmlMOEQydzhsSnJPcUwzSkJxZ1dLSzlBRjNXSVpoNEUyVndo?=
 =?utf-8?B?c0FaZFFOZkF5a1dwQ1g4dzJUVXMrajlNWEdYMG9PY1NNWGY1TC9NbCtKdUlU?=
 =?utf-8?B?ZVlSNmlaa1JXckx3NElNeldnbW5WeHJMcHFSTkFaZHRGbGllcFdoNFpCWjlx?=
 =?utf-8?B?bGlmRVpPcEpBZWluVGFKOFJnZFZyNktSNCs0ZWNuRXlvdUxFTS9hZlhuWjBR?=
 =?utf-8?B?MXh1MlhrMFp0ekVjNHR5bS95VU5Ucm8vNzVqN3ZlNUtLU0IyRTMxU1V5SzBh?=
 =?utf-8?B?OWNqZ1QwZUpMdWwrOUZ5QjVIdDJ0eTh5V0t1UEQ2U3lBZ1I1cXdkbWNEcUJJ?=
 =?utf-8?B?VXVhNzdhcVNFSlJsSVh3MzRhNmREYzZCZUJyczdvZjMxV05WNURYWUNBeXR1?=
 =?utf-8?B?d3FLd29tU2VhZmN2eCtPZUxiMW40dEhNUVpTUGNaNEROelQvemYreGxMOHd3?=
 =?utf-8?B?RkMvNW8wNTh2bXFxRlpxVE5UY3hjQ1dRalBTMHNnZTgwaWJobWlVejhSMkpn?=
 =?utf-8?B?c1ljVFJGamU4eExMQUpEMmp3VUhkVVZzQ3dFQzA5cFlQZ0dYYnZsREliNXBB?=
 =?utf-8?B?WEdVeXZGaDdyOE9BSUd0cHRJdVgrUjZzQkJVd3NIUWo3SGpMYVIvQTFLS3Rn?=
 =?utf-8?B?UUNwMlR5NUt0Q0R4UnFKb0JZVjlvQm9KMFRCRHlrSWh3ejlOSmh3Nlp6T2h6?=
 =?utf-8?B?NVhaSk0wc2t3WGRSbWRQOEpUTS9tQ2pGZ0dGdUZ3TmFObGNRVWRKbFc1YUpX?=
 =?utf-8?B?OVdGZGI5OFBMVWhWUGRsWVhhRUhiVDM5OHVHeFB4OVFZK0ZMVStsTndmT2R3?=
 =?utf-8?B?WXFtSWRoaTk3MDg1Tmp3RGlMSUhISXFiYTBuM1VMVjlqSWQwdzIxUG5oblNQ?=
 =?utf-8?B?RlVJMC9YcW1QZ1I0YkxpY0FLeVhFNmhwR0lPY25Ed3BiQ3RKbDFhdUJsU2hp?=
 =?utf-8?B?UWJmVTNjQm1tU1Bzb2NaWlowYkkvNjAvazN0c2JpeFRHL2E2bHZuMHRFWlFm?=
 =?utf-8?B?RVpWaEcwaFBiV1FCc2lhRVp4VXJYUjRWdHRGQys5UTZuUFhMLy9nRmw5Q3JE?=
 =?utf-8?B?UlpqZUdvU2ptN0VOaXNVSTFIdkZKZVZiL0c1dTlsaFdXR0t4dlF0U3Z4YUlh?=
 =?utf-8?B?TzlCbXloOFE2OU9HVFZYSFl4QzFScDQwZEd5UFRpZjZvMk95L1dDMHl3bHpC?=
 =?utf-8?B?KzlXZ0VXemZTU1VyRU1pTlRrZ2pabzN6YWZTQ29pZEFueHNXRkMvOGxJaDJE?=
 =?utf-8?B?dnFIUi9ILzl3NnBjYm9lVHBOZDZPSEVuZlliVWVNbURWMW1McDVHcUVweWxp?=
 =?utf-8?B?ajFpdkRNNmNCVWdGcHVNMlp2NWRtYUpmYWk3V1dkNmFUM2txNUIybGw2TzB3?=
 =?utf-8?B?MWpSNHN4eEliTDhWdlNjaDd2QnpERjhHK0wrd29PZXg2Yml0RGREQ1l0YVVT?=
 =?utf-8?B?QlE2RjJHdmdSR2lPWW51Q1J6L1k0RFFOVGMyQnF1WVRXdE41RzRGVG95VlRV?=
 =?utf-8?B?dEcyajlOK21pSzkrdllwNjVNcy91RmdpZjVLVWZKYzFINnNKeTdNVkdBZTk3?=
 =?utf-8?B?azNkY0R0eG1xam51clNPSlV2cnNsNExSTUhpUXNIN0NpY1VzaFJ2ckxQT0Jm?=
 =?utf-8?B?VUdRSVVTeVFkTUM3Smw2a0Z1VTNMODQvUHo1V2hsSmZMYXBSYmxvd04xdkpu?=
 =?utf-8?B?SGNjK2wzdkk4bWlYczU2YVNtTlZyd2xVdXhFdklnemk3K3AwR3JVLytlLzVU?=
 =?utf-8?B?ck5zOTJjTlE0Nkl2bEM0c28zbyt4NGw4UXRiRE1oKytscFZYdDRRZjlSMlVF?=
 =?utf-8?B?TVI5NVFqeldhdDlFYnNZOHE2Z1dkd2svK0RMMlg4a1Vybi9pU3k5L2hZMk8v?=
 =?utf-8?B?SkVQaHJ3Mm1ITGQzVGNHcU0vK003L3hZNEh2SVlCSC9qV0k4QVU1SG53M2pr?=
 =?utf-8?B?ZEpBZ1BiZHZWdmVVVFdqUFhjeTMwbTRWUVNMcHpmN2FCbXAyZDV5MnpwRnFE?=
 =?utf-8?Q?xOchioCAG4YfQCUwiD+Fj+NbZw1rVU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WEdzN1hTNGxMZ25ERVppNlRHdmlmL3orRGYxMGx2N2U4OFJsYWhkU3phTS9S?=
 =?utf-8?B?NWhUUWwxblZDd0g2MllqWmlqblFkdEh4MFRiYS9RTnFOQllJTnpPRzNsZVRB?=
 =?utf-8?B?RTJpLzJVNk1keGtGdWUwaHEySXl0ekMzOXh6aG43MmRLeFY2TnUvOWF1MW1W?=
 =?utf-8?B?S0libnF0cjRac2xTV05QQ1lFSUk1L0YyUVpoektpMklrVWZHT0RqSkpEdDUy?=
 =?utf-8?B?ZzcyeUFwbFF2b20rbkJ5VDlkVjJ5Tm03RXZrZzBlYW9PZGxleDBNaXdINzJ1?=
 =?utf-8?B?cG1PVFNOTENZRU9tMHVTeklUZ2QvNWtYeHU2aDQyOWFRVnhKbDQ2Tk1OS1Qx?=
 =?utf-8?B?cmRkanlKckoxQW5RN2psdktPU1h1K25LbVRtSFdQb2R0TTJoUzEyeEFScFU4?=
 =?utf-8?B?WWF1TXRnQ3Y5SFR0Z0Q2djBpSXhYR0hmUkhzV1FvemZuWVhTODd0WHArS2xB?=
 =?utf-8?B?SVV0OTYwWVgwK3ZPN0ZkdHY3S3M4bXdyNlE1S0dhakJCSXZ6dXMxQWNxRVlB?=
 =?utf-8?B?Yi8zQStORGJIVElCSWxjZmJCUHBqcTMrR1hrYkZqRjZVSTYzd0xmWGU4L1RY?=
 =?utf-8?B?RjBjajI1L09aSUo5MEdxOS9ZVjY3Tzdkc0dMRmgrOFJ3MWxFRk1YRGZlYnNv?=
 =?utf-8?B?bjZhVDh0bWxZOVoyeDBPUzR6em5ueW5UQjc1WXpFRm5jVHBLYmg0QXRwOG1C?=
 =?utf-8?B?d1cySExkL0ZyLzZ5bTNMT3VnUzlaN09XRmpsY1dsbU9pRFFmMGVhZ3NEd3Fn?=
 =?utf-8?B?dnNqUEpQNHdoTDhOeHZPN2hwNlRnR3VNOTdqWGI4aTFDc1BnOWtTRGRRSDEw?=
 =?utf-8?B?Ly9tUi9tNE5yLzVZODFFeThEVlRxZ3gxUTVoYndGSjZZMDY1SEI5ak8wSVJp?=
 =?utf-8?B?Y3BybDZmZk1iaVdUUCsrMHdNNW1hR2dCdlJQQ0RnSncyUzYvZlZkaURKSWxN?=
 =?utf-8?B?cnEyRjZ2MlJQeHJjZW00R3hjRHpzM05RVDZJQnJPTk41eDRIR2tGQVFtbkQx?=
 =?utf-8?B?OGVGU2ZJV0tLRnhEQVhRRU82TWswQ3FjVWJocGlRM3NIRDY1N2daY0dCS2gx?=
 =?utf-8?B?czhUSGo0d2VVNDZ0RXRyc0prKzIyeDZHbllrcEhQZC8rNnRTNmVNQ3ZUd0pk?=
 =?utf-8?B?UTFFVjFDaTk3d1gxTk5xakNpQ1dHcXhUbzdnMy92MjhQQmF6aW5OOXNPTHh6?=
 =?utf-8?B?ck5WNkFrYnRobTZFa1VHSW9uOHRXSTJHaG5NRmxCQUNockUrbkxKeGczSzhC?=
 =?utf-8?B?ZXlTaWZ5M0J2NHJBRlpRZTdDaFlWelk3WFlQRnZyeGlhblA0aGc2UTNzYWJO?=
 =?utf-8?B?RWN3cHAyMjVPQWgybmduYkY5Yk0yRkpwc1oyMjFEaGluaHVWdHdsa3ZkdndM?=
 =?utf-8?B?UXdyMXRKcjZLN3VyRGFsYTFkaXpubFNJeitMam1oOHVXbDFwbHRKN04xbUZZ?=
 =?utf-8?B?NTN4aXVtYko1ZWtnSVptVzFGU3VURmdIUFExbjhoTTAvd3NXMWl1UFhHRzRP?=
 =?utf-8?B?bWJpcEYvd2Q3KzlyMHFNYXIwZUVXUS81NHNwZWhJUlFsZlRzakJ4RVZnenBV?=
 =?utf-8?B?TXFDSEI0d2dldlZ4bmdJcHhlMnNVQlE4eHBwdndDdkRMWHl2OW5CejRINzBj?=
 =?utf-8?B?ODBJQ28xSmNFdXpCOFYxbENJcTBKbUxjeTVKMUdNQldiUjc0R1M1NkRmTzkw?=
 =?utf-8?B?SWsyNFh2Y00vOFBwZjBNaGRla3BmblB4L1NLODRiWm9WVzN0QVJudWJZdERT?=
 =?utf-8?B?S2I3cDF4c2ROaExPQ0p1Smxyb2F6TWxmODJ0UlRSdDM1WWJuc0ZvRUZwTjlV?=
 =?utf-8?B?d3lkSEpVUXl6QmlqQXk3S0J6ZkYvdDZmTEt1M2JEejFrWVhETjBUU1dQeFF6?=
 =?utf-8?B?MElDa2t3Yk5mS3Q1N2U2WHBLOUJYMldwc1BUdi9VNkFKN0NMdERnYy8vN29J?=
 =?utf-8?B?U0JyYmJxOEVsOCtpdEM4Q2R3TnFnRjlhTlEwV09meFRuUGI5SUk4R2tva2wr?=
 =?utf-8?B?aU5saDJDL2c0eEw5ZWlZbHo2UGlzUCs3dkJlWFlBL0tqYzhyRmdaZVY1TTNu?=
 =?utf-8?B?OG9UdCtkbmppaDlLRXRSRElpZ2VLVlpoUzY3VTh2L294d0wyZzgraDhOMEln?=
 =?utf-8?Q?WWnpDE0FvDbMBWOv44cJFyfIN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <057C242C59A3C3408BDDC235592D0D73@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1l0thd3/gfL9GFAGOr46PH9N/LnQVANMeQbhl0CApMKqTQOsQOiT3y0BtI4QBYka+gEjQs1DBhPc7pOI1yUDWpgUM/32CrQ6FW5SlDBXjPX9ssEtBn6hfBwTyTDQBrL6cs468zSQ1NGoeTAPbT+tfAsej5mv9ngL++DPLKJYgpB+lnHQ/OmF8jLGTi2XyVz3mjHisXbyJexkAX6VIX0+q0/coDm/Ny7PnVTjaJlgGdxwVuUqzIARn+ACGceUdCLbZzFCj1p5Gf1WjRkIx0xWoGmUPqI9NH9wcrCRUzofvSk8DplAox94J+DgiRv1hOwW3QUH2v5drKch4oX2WR2BXC9IHPFvxHlN9Zn/Gg9Ujf7oqbJ90rDlO3DqouT/YLtebxssX/9XhpvmmtJs9NxHy2ScLEf8wzBbWr0C2A8o2FslcHLYb7aBORdjo1fhHUPu9NFgPrtMwj2NyLSWiCPMCPTz7RfvnaEnjIxKuAymOItUohp9J8BxsBNTTtsT/ga097zYdK7Qo7AmzY/8sngPHkVjQd7HxSXGBcrKyzq4SbatCHbGtifqGPH91tmwysT7evJEKMudFVzqU5nJ+IC3Ct1G7Yqdzg9uuEDoz+hOkHdjI/Y65h7/0hE4h5JKT2ipQzjhpP+sR/qd1Azl59YdmA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cbf3151-abf7-40ea-8b00-08ddd4797fe1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2025 23:40:45.7471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uv2PDX6NeqPIncJmq9iUIX8vMymhvQkqf2YEDCz+h9f0EtgvioTgdHyRIuCx0dGh5e3AgyxgiDNMzFI+9xwTTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9516
X-Proofpoint-GUID: DH-l6kEG83oQkdG3PxiYkQVr2Cz_cc-g
X-Proofpoint-ORIG-GUID: DH-l6kEG83oQkdG3PxiYkQVr2Cz_cc-g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDEyNyBTYWx0ZWRfX34gD8gt6/Va2
 vXrA09zLiMskBwC1QZN8ssZY9NTdkrhFvUwvxJPe51MA7OX7RCWNeZQWwQEsXAGEBkWV982Aqsl
 /4JFp0xXIFRNi/HNpr+uofWu4CSVyxJF1sH3kGumhKQBhIfuC5WDgaeAUUt1rJSwJzrbBRs5W+v
 DvNqntJgV3NiFr1yzPvrKvfIGHBc4TUYCkssQHq4FsuIjcuijjhznZ/JGJb0eHf/Xs1o5ZobfBy
 YphOOlDCDY1S+Ixghz/L11gLGx3Iq+eFzILraxxsq8c//9t0OisUjc3x3Oo99ia+swPuRT1q6PW
 JlRAYZQCntMLTQiFNBRTtGX1uyejLMVjVzhOFL0b6jIuSNbaBAHoD5lYWNLAS2itm1RKqOQWUiJ
 Mj8LFAzF
X-Authority-Analysis: v=2.4 cv=H+nbw/Yi c=1 sm=1 tr=0 ts=68929683 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=qPHU084jO2kA:10
 a=8AirrxEcAAAA:8 a=jIQo8A4GAAAA:8 a=SXcBeQr9A4UVe0lxy50A:9 a=QEXdDO2ut3YA:10
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 clxscore=1011 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508050127

T24gRnJpLCBBdWcgMDEsIDIwMjUsIFBlbmcgRmFuIHdyb3RlOg0KPiBpLk1YOTUgRFdDMyBpbnNp
ZGUgSFNJT01JWCBjb3VsZCBzdGlsbCB3YWtldXAgTGludXgsIGV2ZW4gaWYgSFNJT01JWA0KPiBw
b3dlciBkb21haW4oRGlnaXRhbCBsb2dpYykgaXMgb2ZmLiBUaGVyZSBpcyBzdGlsbCBhbHdheXMg
b24gbG9naWMNCj4gaGF2ZSB0aGUgd2FrZXVwIGNhcGFiaWxpdHkgd2hpY2ggaXMgb3V0IGJhbmQg
d2FrZXVwIGNhcGJpbGl0eS4NCj4gDQo+IFNvIHVzZSBkZXZpY2Vfc2V0X291dF9iYW5kX3dha2V1
cCBmb3IgaS5NWDk1IHRvIG1ha2Ugc3VyZSBEV0MzIGNvdWxkDQo+IHdha2V1cCBzeXN0ZW0gZXZl
biBpZiBIU0lPTUlYIHBvd2VyIGRvbWFpbiBpcyBpbiBvZmYgc3RhdGUuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3Vz
Yi9kd2MzL2R3YzMtaW14OG1wLmMgfCA0ICsrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2Vy
dGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtaW14OG1w
LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtaW14OG1wLmMNCj4gaW5kZXggYmNlNmFmODJmNTRj
MjQ0MjNjMWUxZmNjNDY5MTNjODQ1NmI2ZjAzNS4uZmRlMTU4ZDFmNmUzZDg5ZDI2MWVkMzY4OWEx
N2Q3MDM4NzhjN2UzNyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9kd2MzLWlteDht
cC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1pbXg4bXAuYw0KPiBAQCAtMjQ4LDYg
KzI0OCwxMCBAQCBzdGF0aWMgaW50IGR3YzNfaW14OG1wX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpDQo+ICAJfQ0KPiAgDQo+ICAJZGV2aWNlX3NldF93YWtldXBfY2FwYWJsZShk
ZXYsIHRydWUpOw0KPiArDQo+ICsJaWYgKGRldmljZV9pc19jb21wYXRpYmxlKGRldiwgImZzbCxp
bXg5NS1kd2MzIikpDQo+ICsJCWRldmljZV9zZXRfb3V0X2JhbmRfd2FrZXVwKGRldiwgdHJ1ZSk7
DQo+ICsNCj4gIAlwbV9ydW50aW1lX3B1dChkZXYpOw0KPiAgDQo+ICAJcmV0dXJuIDA7DQo+IA0K
PiAtLSANCj4gMi4zNy4xDQo+IA0KDQpBY2tlZC1ieTogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5
ZW5Ac3lub3BzeXMuY29tPg0KDQpCUiwNClRoaW5o

