Return-Path: <linux-pm+bounces-39302-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B5CCAD021
	for <lists+linux-pm@lfdr.de>; Mon, 08 Dec 2025 12:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4253E302CBA1
	for <lists+linux-pm@lfdr.de>; Mon,  8 Dec 2025 11:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972632E8E16;
	Mon,  8 Dec 2025 11:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Eo7kOEPP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ap4oAdob"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67CE21FF23;
	Mon,  8 Dec 2025 11:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765193638; cv=fail; b=Bl7z0S+F4MwSFXI/EBiB/fbMMuxD39CGBAywoPtgflhfm2xQ7JphL7RpgqYtqaMKeHOtKgA+NWw7eohaxtNcNECLqr/VQGmGlCh3gEro0XeETGH79hzayjrMVKx4hyoC/Xjo0vt159q0mnTyPdOnI1xhVamQw+98b7cNKFsN6xE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765193638; c=relaxed/simple;
	bh=lHu6U61WHMcCKgWyIdeTldsmX1cXJhjutVoFQ/CU71Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dEoCplhtNAUSt+pFgakX8SRipWaeW2G7gfPgaSg+zgn8gII4SibHtoSbwYmp6OSmLj1D84nzoJEJbLp7DdLGygYBQXSwaLJ2lp+Qb0NMe+F5ml8akDApLg+vXesLyIYBx9q+kb/O8sa6DAKvMdj5Eokqzl0bDtCctc9YUkxdTJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Eo7kOEPP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ap4oAdob; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B8Aha0q2244011;
	Mon, 8 Dec 2025 11:33:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=joGvY8JTZCtPlbgy2rL+1YM04Hv6r4cp1G2v8bRqvHI=; b=
	Eo7kOEPPygtlcCxg7NidBkKN+mO1dGoJgDNYnJrLzZkFweCSwI3cFUMmAiFuWHdA
	n61Mrz6wCliTs7wamDH1TwdNaVmQR/kdmvp8khFl5/s4e/xHO8qFzZQdbQP8CrI+
	LNz8IwPJiBSRACOkTTWDm4wXREenkw65ZhPlCC1Nczqkr1fvd7yWhJeeivd+fgdu
	zHk3ScRX0sNk+l1iBAknK4fAXq6h/jUanTQ71tbfJX9hJxxJ7wPhzz1yOlY0Ej5d
	obabs5Q4zxtu2BZXvK/3IXqPZFfPIMdZrtGXc+w1L2vxG7Afod0ExXr/Ypwtncs4
	j2bDgaG5sPXiEOy3V+XC0g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aww5yr1wv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Dec 2025 11:33:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8BJnXP039909;
	Mon, 8 Dec 2025 11:33:46 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011003.outbound.protection.outlook.com [40.93.194.3])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4avaxhdabj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Dec 2025 11:33:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mL6kYHURTP4K7blOZ88NmX30LYFFk70UTJuC0OVozFaLr1O4QFsU+mlezQVV3/0PUUhIpfeRwlscOUuoPGfsEzeT7US1GjgqG8XxRest+xSy0dXINpf/6R6zCslmLWEe6f3R6SiCSVn6ehyKNxUvAJJhrba5/wjs5rSMyUl6NQTNgJ3d6WoH5AVKM7+nyb5VzNItnA7RCSS95Cc1pQ9JKNltRxl33X5sDUxVQnFPoOjLGGZbPnTJb+XhG/Bi0/DxG65cqFFOmkNXHFmv8fZ0267Vq9anBezZguR+JoAUfoDcgdHoVFJnkfx2WNSZcsEdaTcdHuWT3wIlBk/EKyD6nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joGvY8JTZCtPlbgy2rL+1YM04Hv6r4cp1G2v8bRqvHI=;
 b=nI+v8YCPaoKa3dvAUBkwm7Xi/61Mr/InYm5z4XXpLJ5CrlLrgoqmTDzIhYpYAHOqeej2+b3MMT+Qy7BSqDM+2WtKrjW5Xga/jmgkYuL/y+VTLrZPFThc0zsGYrDsWL6W4+ZPiJIs5O7VoUETuh+8eSNu4V6b8vAumXjrtnEkq8OxYEzbUJYB/AwFJy7WNV7QJRzMKQQma91OhPppYtpDehsjsDr5g7kSz14Ih5LmL5Cue9zCq+8HWZ/7oExTd4Ip0jWjmYD/p/LMYikGDoh9d4etPzMK5ggifAD4PJPti+VGFGyvtLAJB/Xfy6oS+5EuAmTOLFpgMMC+cLKEq20fyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joGvY8JTZCtPlbgy2rL+1YM04Hv6r4cp1G2v8bRqvHI=;
 b=Ap4oAdoblj29hvxD/8tWt2UUogsx2RB4oZfMLgjD8wLkeoVnYV1sowqMgzHbQCwWQOKU+1KLg+uuiH9LAXrluMuHAB4+REBulI6tdm4cxpEoHe6Hte7IDqq7HA0oYH3FB+iA3uidkNSY/w73TLIN3ZJoXw4G6eV/PgD2CIzFlBQ=
Received: from CY5PR10MB6165.namprd10.prod.outlook.com (2603:10b6:930:33::15)
 by SJ0PR10MB5670.namprd10.prod.outlook.com (2603:10b6:a03:3ed::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Mon, 8 Dec
 2025 11:33:43 +0000
Received: from CY5PR10MB6165.namprd10.prod.outlook.com
 ([fe80::93e8:4473:e7c3:62bc]) by CY5PR10MB6165.namprd10.prod.outlook.com
 ([fe80::93e8:4473:e7c3:62bc%5]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 11:33:43 +0000
Message-ID: <b36a7037-ca96-49ec-9b39-6e9808d6718c@oracle.com>
Date: Mon, 8 Dec 2025 17:03:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Performance regressions introduced via Revert "cpuidle: menu:
 Avoid discarding useful information" on 5.15 LTS
To: Doug Smythies <dsmythies@telus.net>
Cc: 'Sasha Levin' <sashal@kernel.org>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, stable@vger.kernel.org,
        'Christian Loehle' <christian.loehle@arm.com>,
        "'Rafael J. Wysocki'" <rafael@kernel.org>,
        'Daniel Lezcano' <daniel.lezcano@linaro.org>
References: <d4690be7-9b81-498e-868b-fb4f1d558e08@oracle.com>
 <39c7d882-6711-4178-bce6-c1e4fc909b84@arm.com>
 <005401dc64a4$75f1d770$61d58650$@telus.net>
Content-Language: en-US
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
In-Reply-To: <005401dc64a4$75f1d770$61d58650$@telus.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0373.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::25) To CY5PR10MB6165.namprd10.prod.outlook.com
 (2603:10b6:930:33::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6165:EE_|SJ0PR10MB5670:EE_
X-MS-Office365-Filtering-Correlation-Id: 0012db56-4fb6-446b-58dd-08de364da433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OFh2eVh0K0NZRGZHN1FveURiRFBEekZhWmsybFFuUCtNaHl4NDg3b0dDYUs1?=
 =?utf-8?B?T0VBZ2FDMS8wTFNyKzhaMDhlcTBNR2RYenVOa3BGazBlSEE5MmFpaldvVDRy?=
 =?utf-8?B?MWVTZEtwT1gyMDJoYzBnd2dPZGFzb29iVk5KRXJjUmlpbFZtN2N4c3VKdXNQ?=
 =?utf-8?B?YWZiWHd6OHNpaGVWY3h0MU9wOXVIM1Nla2s1aSt0NkdXcm1abE5zTkhJRXov?=
 =?utf-8?B?UmlZbHNRZ2Y5a0lEeThFUlhJN1RiQzRhTTdSNGQzNkVjRTJENjBvVkQwd3gx?=
 =?utf-8?B?TURvaW1jTTU3NDF1ZDZNMFZUN3ZSaVFoTjIwdzJaN3VlTUJwR3V0RXdmT2hP?=
 =?utf-8?B?TDZZUXhWTlpUekNrZWZ4T0tPWlVIZXhIRGhpM0tZYVdOVDllMEtaa2hraUZG?=
 =?utf-8?B?Nk9CR2V5T2IxREJaMDVTUG5QOHJJenh3R0N2U3NBRkxseVJ6UHdoMSs0S0lx?=
 =?utf-8?B?dXBDdzhnaWdReGZoNVlZaUdGMDhRdytHd1dlRFFHbTRhZDFYV1BucmxDNHQr?=
 =?utf-8?B?aVUxNEh2UTNpdFJBbmxPNFJYci9MQWJCTml6aEZ2dWg0WXkyZVpqUi9wdWl3?=
 =?utf-8?B?WVBjOVVSbTgrNDExZ3dhV3pHNjZpaWdMUzZ3UytEbmZ5Tm1rN01ScWk4S1RC?=
 =?utf-8?B?Qm9GS25GSy9lSlhnUnNDYWRYVmwreHBkM2NEMGhlcnBQclBwQWFySlJJeFg5?=
 =?utf-8?B?dlpnT1huU1hDMVJDRjE2NkNFbDVmaWM0L0lJekNOTGhhaUMxa2JhMWFnM0Fz?=
 =?utf-8?B?SVpnTFREMXVhZWNNYmZFQmhhTC9YM3dMdUxqNExKQUVCekUxcjByQjZ5bnZ4?=
 =?utf-8?B?RlR6bUlnc1o0cmJsMFZHWkpIQU02dnBrVURZSVBzQm5sYnBYWW1TSmtDalRv?=
 =?utf-8?B?NWw5SllTRENyRldmc0Y0a2FwVjZGZ0tHd1BoaXFTc2FYdm5ZVlVKNHFzT0hV?=
 =?utf-8?B?RnJtbWdZZjZ6UmdNY2tKcSt0YXkvUVNncS9iMCtFbmJXanBxN29ycWtMZHhJ?=
 =?utf-8?B?MkNKU0UzRFJENVllbjhJdnAyVnBTeVRoK1h6ODFqNEdKd3pIbjRXNVhkam9T?=
 =?utf-8?B?S2haMkcwWnRHMWE1aDErQ0xOZkZNVGFXMmFrU0RmaTMwMmxMVHNBUXFadlBU?=
 =?utf-8?B?MWpnQThjTTRZdGk0ZktmY0VZSFFCanQxWmozdk5hUUkxWmtUYmRyMHhxWlBU?=
 =?utf-8?B?N3JsblBwcklmaU9KaSt2NFBkL081M2RrZWpldUJZUE9ZTVVaNDE2UEdCZWJy?=
 =?utf-8?B?c1lRNHdjSC9CTkZUUFl2S0s4WFI3QzZ4cGFXSlJUNG9sMW91ekJRMEpNeVAr?=
 =?utf-8?B?MjBIbVY3S2Z0SHFMV3NDTXg5aWc5MHV6RGR3OXNLMDYvR2d3SjNiRDdXaWF5?=
 =?utf-8?B?S0QyaEt2RUExMGYrMmF5dk05bS9wNWludENvZ0E2TWJMbWs4QXFwT2FyTThw?=
 =?utf-8?B?c3lVS1RhR050dk1Xd3ZuMTNEMjVKZHdOUGdMOEJMVWJhK3VMVlpmS0loejhi?=
 =?utf-8?B?c0F6TXNtbTgydXQrc3BUbzAxbWdVVVBmMFJYSUpDTnlPNW5oUWdFbXh3R3NC?=
 =?utf-8?B?YWJPOWovYk1VazhOV3RuL2E3dngzMVc0WHEvc3A3RTdtMXVKb3ZSSnYrdVJk?=
 =?utf-8?B?dk90U0ZrYVVhcFg5UE4xZ3I2YlU3NlM0TUgyMG41TWM4RnhrUENmZXhWR2JJ?=
 =?utf-8?B?bmkxdE14b0ZXdHBxM3F4QktsMWtBbWRaWS9NNml2TENXQ091d3BVaTJURlJ0?=
 =?utf-8?B?WmU3SnhDQm9iVUd1R3JDUGM5ZDVKSzkramExLzhXSklhWjBvbGZPd092WnEz?=
 =?utf-8?B?SjdQUTREZ1Y5UjVyZmp5NEo1OEJvdE0vWlYwcDI0OFhya3NETE5QWDYzU0VF?=
 =?utf-8?B?cnBVaW9vVzBSNVJxOVA5RUY4cTdWQzFmbmpOenFQaVFVQSsvNkZrZ1pOanhC?=
 =?utf-8?B?eUFrZUhlVlh0eFdhV3UrbFk0ZDBQVS9PZ0ZORXNhMTNTVGFpUVhvYkZ2TnBj?=
 =?utf-8?B?WlhsdXJHcTd3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6165.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUNCSnN1dlZrRWNZQUtmY2UyU3c0VXFkRWRYS3grRlVRNnF6Q3E5K1BVNmI1?=
 =?utf-8?B?UWNsR0Y2Y0pwZVkrNnFFVFU2WkZLUlMzY3pyQXlvMHA2RDNaMlVwellHSzkw?=
 =?utf-8?B?aWxYeTVhVGE0aVpvMmNENWttUUxnMnJ2QWZISmV3TWlRQ2xtd1hxOVFEK1ZO?=
 =?utf-8?B?T29mc0VOcjRLV2tDekNRMnFjemlCdGQ3RzIwMWVkWFoweG9LN1MwS09YamtR?=
 =?utf-8?B?SXN1bkpiVU9iUGIxWjdRMyszdzB3VGRlanQ3WnkvVHpwUUozZnRXZzY2TC9q?=
 =?utf-8?B?RVl6MzFJVWR3aDNoUk9TYi9tZThtWmpCY09uQVZOQjVvOW81QXFsQ2RkL29H?=
 =?utf-8?B?YzNMUkgvOTFjb08vYllTalgwU2JzUDc2NkM3SkNZNUx1Ly81bUNnMnNRdHdO?=
 =?utf-8?B?dlRNTGdOM1poZWFIRkRrNUNsTEZFTDg1OVA1cWFvNTZ5TlF3em9aWjdvWFRr?=
 =?utf-8?B?QUdlbUFlNlZEdklZMlNhMTRjVzVMa3pXeTVrd0RHRTNXaHkwRElxTWgrR0Iy?=
 =?utf-8?B?R0xJR0k5Wmw0S0duZEo5aDJDYkpOTjZISnFLbkF3Qy9SeDhjVjVka3VzUHBp?=
 =?utf-8?B?ck9HZWpzY0JpUmdxbi91bHZOeEVYK0psRVBNTTArZldlRmF6dTN6Nm1RU3cz?=
 =?utf-8?B?b0h5Q0JUNVVIMVlpNmE2UmI4L2REQWxaYWdTclhBUHkva0d0aWlTcWpzVjlO?=
 =?utf-8?B?NFRuOFYxSHNMb3FXMVRDK2x2aTlBaGw0N3d0SUl1MWlhUU5reXBBd2d4NVZP?=
 =?utf-8?B?U3FzdWFHUUZrd1pkWVJFWkRFc3VuM0RnU2htUVBaMmJqWEZXT0kvNnZwZGJl?=
 =?utf-8?B?M2ZOWTVObmsyemFYMStmZklKL1ovem1wQ000a0hFd2x5Mm1QSGF3UXpFeElF?=
 =?utf-8?B?S2F3aks3NktoQ3JJVDhHem5vQ3VJRXlJdU9lYzlIS3FkbVorY2FOOXVTTGxP?=
 =?utf-8?B?Q3p2QWF1V29FTDB2cEhJY3FqaVcxb2djUFpoeFEyMmUyV1dGSTF2elpTYVpj?=
 =?utf-8?B?UEprZmw3RnM3QTNDSUovWEhxNXNGNi9XSHo3bmNuQUdxYmVHSEpiT2JlQzRG?=
 =?utf-8?B?TzBTYUJYRTB1aHZqdUNoVjVkMEhNS0JtbHJYNm9YK3hCS2dMbkxmbFZsY1c3?=
 =?utf-8?B?a2gyWnowWk5TWFR6L1VUWXZCUzAxZVFqUVl6eUx6dFdnU2I0dkJQNXJEMFdm?=
 =?utf-8?B?Z2RhYmpZRGZIVlRDUzFycjhWT3Y0RTlrYVk3d1U1MTJ0dU8yUkowQVAvckJH?=
 =?utf-8?B?Umx5bk11dG90Y2hZZEhsL0ZqTjRqSXZtL0c5UmRoNEl6ZkdSaVlVbDJhMG53?=
 =?utf-8?B?Rm5SRWU3Z1FnSFlHVEt4VGowMXQxQjRraXZaQlpnSmZKL3E0cXloejZsU0h5?=
 =?utf-8?B?TlpqNUtQU1BGd3pWYjM1NTMvV0l0OFlFMU94aHJpUitoSE1sa05TajU1OGdw?=
 =?utf-8?B?Q2J5TkFwam1TUTJ2UEt6K3JVdEdvUkZrMFYxVGlpcHBWN1k1QXEvZVNzWFJG?=
 =?utf-8?B?TUVPNVZjNWJZY2E5S2NYa1VGUXNNeXh6Nkx2S21hWStjNVhmcVNqVGNHOGY3?=
 =?utf-8?B?YXo2Y2gwTTd2SjczVndlV0FtUG1Xc0Rsa2dQWkRTZzdZVy9FRm82ZjJkbzNC?=
 =?utf-8?B?dFppWXNkckwrbUpTOWwyYnc4TmZjU1VQKzFuSGUvVFlTNUhyU0hpWU1HZmgx?=
 =?utf-8?B?V2FacG5OekNzVDlOVHJydGQzN2RnWGN4dmhLUzY1SDgvakZyVUE5Wm8wREsv?=
 =?utf-8?B?dFFqWG8xOE9Ca05zc3VGZUFVUmcrMHBpS01ML1FkWUxiUW9zN3BodzYwT3dm?=
 =?utf-8?B?UkplK1J2SGZSVDlTRDd4ZXRlMVNOWmpWK2RnN2RuSGF3VnNLU21ESjNkUUcy?=
 =?utf-8?B?cWpTdDJRaGV0N0Z1a3dUOU4wRlRzZ2p3cExPMG9pSTl4QkpMQTdtbUtzdFo0?=
 =?utf-8?B?WGZtYUgxOTMvTTh5enJkbjBVMUluY3VYeVNDUVV0VHR5akUwNEhQNFpMZ3dq?=
 =?utf-8?B?dFhPWWZVczNUZC9Dc25CVDRxa2VJSWhKSFBLR2YzUlhZRXFyV0x3M3YyZUtM?=
 =?utf-8?B?RlhXbWNCVlFZQnE5Y2I0WjFYNFBwMWV2TTYxdzNBeUwvR1dxVVhnWEs1aVhm?=
 =?utf-8?B?eHdtSGVrbmNtUC9ZL0FOall1QjRkaldVT1FuUE5RUmlWTS9xQVRMSzBNOEp2?=
 =?utf-8?Q?u25EYRIIq+gchRUf9mKB164=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5pQkkWBCR+NBW+Z6RpJ+6LzJpmepLM8nOpo6sbADRGcfeUBBaVZtdkWdAad0OtRoF7HvWUZ+MMaN3XzTY+R4jvHk15UWZQ1MEBMjDz8bYWNvfXrRZUNg/jcYtM/zMH5ngtQkc1BvvOkZeVhaPkQyw7d4wrVJRKpPo9RFc/iz4qiQBb/4BKZrHEYoHE0VDZJzBq7s8VswRqzPVDgayGSMoF0C8NQZOZ3VP3+WpLMQ8ogxo4QGTUu009YPHKeNyZjVgcepd7eoE3Vzskuo5TfzoBoIpzklVL1sIAIoBQlp30kcL54qEdFA3S0uYnlW8ySq18kWjuYMMOYZ7xubwMd54P/4nuxAYmEcXaePaTBFb2x7X56v2nhBQkksQL+JAwFCYbvfu0hhCo2WLZumrwY62SepCaPltKttLBiKZO14DgmKw8AFPgzqMuSDjEEPmDzFeBsjNqZ6CE13taENPIKmf0oslE77I1XV4G4e8K4eSShujLKDWvS8fVp/c/jpT7JoOKf1v8bXjnvLJsR1LcXzBCjiTgM0vpazhrFPRET7YHR/078wAVQylTpHP+oZ5gAPEYyIpRcc1V3R1hhk7ylX6NqiVu//D1tvNdnLi8epOOw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0012db56-4fb6-446b-58dd-08de364da433
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6165.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 11:33:43.0655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 97+YK0FdcGi1kvlX+YAXOg26YP8Czz7Rr6uQJCDU7FzPRDwIk+QiIQu5TrljjDmrIWJEEA9At0cAry71cDeakhHa8BlBepeNRtWF8mSiQDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5670
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512080097
X-Authority-Analysis: v=2.4 cv=DNOCIiNb c=1 sm=1 tr=0 ts=6936b79b b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=S4iUd2WvzuviuBE2PkMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12099
X-Proofpoint-ORIG-GUID: xTEHZkTN0kIYkRTMTcHmjOLvciAiVX1u
X-Proofpoint-GUID: xTEHZkTN0kIYkRTMTcHmjOLvciAiVX1u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA4MDA5NyBTYWx0ZWRfX+KwAn7n2aOxj
 XRPgPu7UyVVhdsH9s+88EdCtqIIEHAM09ortskq6OVEhCpuFKPYUqum33YO8eMnJqsbwpPeiLvn
 xnk+5FzRIkq7rTa6+RaCpq9DLYKlY6KUeuobliM9tYnzVRFFw7dtCS6Yvfx+Qi91yVfaLycOAz4
 XUYt4x7HdliatDFUyjQqKMlNpmOpg+t9Xtg4F9kbLvCTFqOAI+0TAqLLPb31xIKHVwuvNXkfKMS
 fxnbog7nv49Q9YAZshNi4VGIR5z/Mfr4GV4ABsIvWrqCaLQzQKbxJChb4oCNjAf3lsTwRf8O9hD
 X8mXY0awyGhvpKMm3ICeG9x1AsRDqlI6BBRdygU7SbOJ8x1We+iSVuEyi8w2J0jPW5uNCpnCyxp
 05FiiOROA4XCE2SFNB6q7A9oWckySty1iqBHYPXxsEZ741v2j8I=

Hi Doug,

On 04/12/25 4:00 AM, Doug Smythies wrote:
> On 2025.12.03 08:45 Christian Loehle wrote:
>> On 12/3/25 16:18, Harshvardhan Jha wrote:
>>> Hi there,
>>>
>>> While running performance benchmarks for the 5.15.196 LTS tags , it was
>>> observed that several regressions across different benchmarks is being
>>> introduced when compared to the previous 5.15.193 kernel tag. Running an
>>> automated bisect on both of them narrowed down the culprit commit to:
>>> - 5666bcc3c00f7 Revert "cpuidle: menu: Avoid discarding useful
>>> information" for 5.15
>>>
>>> Regressions on 5.15.196 include:
>>> -9.3% : Phoronix pts/sqlite using 2 processes on OnPrem X6-2
>>> -6.3% : Phoronix system/sqlite on OnPrem X6-2
>>> -18%  : rds-stress -M 1 (readonly rdma-mode) metrics with 1 depth & 1
>>> thread & 1M buffer size on OnPrem X6-2
>>> -4 -> -8% : rds-stress -M 2 (writeonly rdma-mode) metrics with 1 depth &
>>> 1 thread & 1M buffer size on OnPrem X6-2
>>> Up to -30% : Some Netpipe metrics on OnPrem X5-2
>>>
>>> The culprit commits' messages mention that these reverts were done due
>>> to performance regressions introduced in Intel Jasper Lake systems but
>>> this revert is causing issues in other systems unfortunately. I wanted
>>> to know the maintainers' opinion on how we should proceed in order to
>>> fix this. If we reapply it'll bring back the previous regressions on
>>> Jasper Lake systems and if we don't revert it then it's stuck with
>>> current regressions. If this problem has been reported before and a fix
>>> is in the works then please let me know I shall follow developments to
>>> that mail thread.
>> The discussion regarding this can be found here:
>> https://urldefense.com/v3/__https://lore.kernel.org/lkml/36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7/__;!!ACWV5N9M2RV99hQ!MWXEz_wRbaLyJxDign2EXci2qNzAPpCyhi8qIORMdReh0g_yIVIt-Oqov23KT23A_rGBRRxJ4bHb_e6UQA-b9PW7hw$ 
>> we explored an alternative to the full revert here:
>> https://urldefense.com/v3/__https://lore.kernel.org/lkml/4687373.LvFx2qVVIh@rafael.j.wysocki/__;!!ACWV5N9M2RV99hQ!MWXEz_wRbaLyJxDign2EXci2qNzAPpCyhi8qIORMdReh0g_yIVIt-Oqov23KT23A_rGBRRxJ4bHb_e6UQA9PSf_uMQ$ 
>> unfortunately that didn't lead anywhere useful, so Rafael went with the
>> full revert you're seeing now.
>>
>> Ultimately it seems to me that this "aggressiveness" on deep idle tradeoffs
>> will highly depend on your platform, but also your workload, Jasper Lake
>> in particular seems to favor deep idle states even when they don't seem
>> to be a 'good' choice from a purely cpuidle (governor) perspective, so
>> we're kind of stuck with that.
>>
>> For teo we've discussed a tunable knob in the past, which comes naturally with
>> the logic, for menu there's nothing obvious that would be comparable.
>> But for teo such a knob didn't generate any further interest (so far).
>>
>> That's the status, unless I missed anything?
> By reading everything in the links Chrsitian provided, you can see
> that we had difficulties repeating test results on other platforms.
>
> Of the tests listed herein, the only one that was easy to repeat on my
> test server, was the " Phoronix pts/sqlite" one. I got (summary: no difference):
>
> Kernel 6.18									Reverted			
> pts/sqlite-2.3.0			menu rc4		menu rc1		menu rc1		menu rc3	
> 				performance		performance		performance		performance	
> test	what			ave			ave			ave			ave	
> 1	T/C 1			2.147	-0.2%		2.143	0.0%		2.16	-0.8%		2.156	-0.6%
> 2	T/C 2			3.468	0.1%		3.473	0.0%		3.486	-0.4%		3.478	-0.1%
> 3	T/C 4			4.336	0.3%		4.35	0.0%		4.355	-0.1%		4.354	-0.1%
> 4	T/C 8			5.438	-0.1%		5.434	0.0%		5.456	-0.4%		5.45	-0.3%
> 5	T/C 12			6.314	-0.2%		6.299	0.0%		6.307	-0.1%		6.29	0.1%
>
> Where:
> T/C means: Threads / Copies
> performance means: intel_pstate CPU frequency scaling driver and the performance CPU frequencay scaling governor.
> Data points are in Seconds.
> Ave means the average test result. The number of runs per test was increased from the default of 3 to 10.
> The reversion was manually applied to kernel 6.18-rc1 for that test.
> The reversion was included in kernel 6.18-rc3.
> Kernel 6.18-rc4 had another code change to menu.c
>
> In case the formatting gets messed up, the table is also attached.
>
> Processor: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz, 6 cores 12 CPUs.
> HWP: Enabled.

I was able to recover performance on 5.15 and 5.4 LTS based kernels
after reapplying the revert on X6-2 systems.

Architecture:                x86_64
  CPU op-mode(s):            32-bit, 64-bit
  Address sizes:             46 bits physical, 48 bits virtual
  Byte Order:                Little Endian
CPU(s):                      56
  On-line CPU(s) list:       0-55
Vendor ID:                   GenuineIntel
  Model name:                Intel(R) Xeon(R) CPU E5-2690 v4 @ 2.60GHz
    CPU family:              6
    Model:                   79
    Thread(s) per core:      2
    Core(s) per socket:      14
    Socket(s):               2
    Stepping:                1
    CPU(s) scaling MHz:      98%
    CPU max MHz:             2600.0000
    CPU min MHz:             1200.0000
    BogoMIPS:                5188.26
    Flags:                   fpu vme de pse tsc msr pae mce cx8 apic sep
mtrr pg
                             e mca cmov pat pse36 clflush dts acpi mmx
fxsr sse 
                             sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp
lm cons
                             tant_tsc arch_perfmon pebs bts rep_good
nopl xtopol
                             ogy nonstop_tsc cpuid aperfmperf pni
pclmulqdq dtes
                             64 monitor ds_cpl vmx smx est tm2 ssse3
sdbg fma cx
                             16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic
movbe po
                             pcnt tsc_deadline_timer aes xsave avx f16c
rdrand l
                             ahf_lm abm 3dnowprefetch cpuid_fault epb
cat_l3 cdp
                             _l3 pti intel_ppin ssbd ibrs ibpb stibp
tpr_shadow 
                             flexpriority ept vpid ept_ad fsgsbase
tsc_adjust bm
                             i1 hle avx2 smep bmi2 erms invpcid rtm cqm
rdt_a rd
                             seed adx smap intel_pt xsaveopt cqm_llc
cqm_occup_l
                             lc cqm_mbm_total cqm_mbm_local dtherm arat
pln pts 
                             vnmi md_clear flush_l1d
Virtualization features:     
  Virtualization:            VT-x
Caches (sum of all):         
  L1d:                       896 KiB (28 instances)
  L1i:                       896 KiB (28 instances)
  L2:                        7 MiB (28 instances)
  L3:                        70 MiB (2 instances)
NUMA:                        
  NUMA node(s):              2
  NUMA node0 CPU(s):         0-13,28-41
  NUMA node1 CPU(s):         14-27,42-55
Vulnerabilities:             
  Gather data sampling:      Not affected
  Indirect target selection: Not affected
  Itlb multihit:             KVM: Mitigation: Split huge pages
  L1tf:                      Mitigation; PTE Inversion; VMX conditional
cache fl
                             ushes, SMT vulnerable
  Mds:                       Mitigation; Clear CPU buffers; SMT vulnerable
  Meltdown:                  Mitigation; PTI
  Mmio stale data:           Mitigation; Clear CPU buffers; SMT vulnerable
  Reg file data sampling:    Not affected
  Retbleed:                  Not affected
  Spec rstack overflow:      Not affected
  Spec store bypass:         Mitigation; Speculative Store Bypass
disabled via p
                             rctl
  Spectre v1:                Mitigation; usercopy/swapgs barriers and
__user poi
                             nter sanitization
  Spectre v2:                Mitigation; Retpolines; IBPB conditional;
IBRS_FW; 
                             STIBP conditional; RSB filling; PBRSB-eIBRS
Not aff
                             ected; BHI Not affected
  Srbds:                     Not affected
  Tsa:                       Not affected
  Tsx async abort:           Mitigation; Clear CPU buffers; SMT vulnerable
  Vmscape:                   Mitigation; IBPB before exit to userspace


Thanks & Regards,
Harshvardhan

>  
> ... Doug
>

