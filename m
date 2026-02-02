Return-Path: <linux-pm+bounces-41917-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDjuKhTQgGlBBwMAu9opvQ
	(envelope-from <linux-pm+bounces-41917-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 17:25:56 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D2920CEEEC
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 17:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 861B030074CC
	for <lists+linux-pm@lfdr.de>; Mon,  2 Feb 2026 16:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E3536AB77;
	Mon,  2 Feb 2026 16:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MiHPEpfd"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012060.outbound.protection.outlook.com [52.101.66.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3C837475A;
	Mon,  2 Feb 2026 16:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770049534; cv=fail; b=EA67FhEKnloeJHthhdTq8o2AWtPfPmvOXCYgAJXfO9/mFrCi3GFS6wtdzRAgAj3sf0A87+hldrXs2VyeWKw2HJekNhlXeLH14dcg86bopOkf21VUun4XztvA+y2LYkwP05P6j9cGivDV8RbDOvnakxVIiImuKGLTavQDKnt65ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770049534; c=relaxed/simple;
	bh=D2Esce/GEQrodOeVIexlvjTuxkj5wjrFmgCKHPCr3XU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AUIlJduzC99geDU8zeuIE1LEG/dALGN5R1iiT8SGh9V8x6HjQLy0R+1qheaMlgt9/PXbZAGegxx0hLPbrNuGHAGmNk5882ap4f/tlGANJgfQiKQFhe4fzBHHGPYAmfeUF+5mBJXOms5/oEPpxSm1mxZ4kxqwFwvuS9kNF+o3oRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MiHPEpfd; arc=fail smtp.client-ip=52.101.66.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oYpvQImc1jbqBnWMBwJnJVTQeRQn6pifoDfiBbVv6Edh0PNjWx7GF2pzZe5+2PhTqVrD66xlag4ktF1IfGPq9oTF6IoO6qFS4jkfE+F9K2fjyTGhPXqhIOVIJdGA9302oNnOpNAXLprrguxs7FiZ0OOGdIpuxSsnGFmUlRKomOoH0tAP0JQM4yfTVq18wtjT/U7aeUhgctoCrVQ1y/PmbSrpCpm3e9OpRIwVcNzMYYgQI8ffDD7GaWWoUMHXw5hs94Fj8XLR5zxxqJZ8QFsUBH177di6g20mQbX5qrUBFxXJtHABMBbngyu/Z7uWnsDFlenGQwW7wlDmnsx8VPs54w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cohnr5UeVkOg0mWmOhfccR2YuA2EAHol718X7/MBdPY=;
 b=qzHtIh4ZF697PfnjmNmc9QsIyYhfrXoQc5IKG/Z6j9ne9L/O+BUk7G0flDulsKSdjE1eewJn+fti0OyGEmkaamduDLEMWWrmwV1rpjjExkO/gyiG3jk9qDQpjjZum67C78TMiBrI2nR0fabE5FKJruCeoLXy0MYjygArGVT2tZkDXImSPZ0IXoKcCqusCfaSONnG/ot8B29gQNh2Uh+SJW3V0M0AnMWpOZp0SonFCVyW2978NwVk+3QE97NESklHpIPDWfoxLbZ4U7wjhIIrwukRklSlQvkzc2hp2BMi9+iuzAH/87Z0ygBQtzQ+t687vSoXs8FrA6rqG1dPqLEHaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cohnr5UeVkOg0mWmOhfccR2YuA2EAHol718X7/MBdPY=;
 b=MiHPEpfd+1ofsJRDBeR3s3yLfAe3ADDk2vxEeQ3iCQOH/wsNubq7KBkLVxbdFbJr1A7veQMxoWVELa1M2pQMlvtxjFqHNHu3rdITE585n5Jtkpdmu2QDkan40W4pc1np/bwZts+gge0De3aDo5cuos1okV8OESW7hZCRSf+H4muA/q5eakTOzMLwRxTs4L5zJ0roxZb4ZEXKY8NDzqyOCA+zja6kA41+vrkBi+xa1GDcyrgAibq0DZ5Aeluta4fKEQKEKOYyzUqEF35hW8/fHz9PwA5neoHk0aaEuZ6rBrK20NHQH2UqMWGAfeOxeMQMk7I/1pxJ5hJWgW1s+/Idtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI0PR04MB11574.eurprd04.prod.outlook.com (2603:10a6:800:302::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Mon, 2 Feb
 2026 16:25:30 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 16:25:30 +0000
Date: Mon, 2 Feb 2026 11:25:23 -0500
From: Frank Li <Frank.li@nxp.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: alexandre.belloni@bootlin.com, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 5/7] i3c: mipi-i3c-hci: Allow parent to manage runtime PM
Message-ID: <aYDP847mgleQBF5Y@lizhi-Precision-Tower-5810>
References: <20260129181841.130864-1-adrian.hunter@intel.com>
 <20260129181841.130864-6-adrian.hunter@intel.com>
 <aXu8TiFpMiIVk5Iq@lizhi-Precision-Tower-5810>
 <dd681a97-de37-436b-b09e-5173c1de2f24@intel.com>
 <aXvKZK8tTnCDGzth@lizhi-Precision-Tower-5810>
 <a8a608c8-c6ce-415b-ac02-db1246edb15e@intel.com>
 <aXzIeLLDxsmzUhI+@lizhi-Precision-Tower-5810>
 <09622627-2ff3-4fb7-80f2-686d6474e417@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09622627-2ff3-4fb7-80f2-686d6474e417@intel.com>
X-ClientProxiedBy: SJ0PR03CA0073.namprd03.prod.outlook.com
 (2603:10b6:a03:331::18) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI0PR04MB11574:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ffda632-c9c7-44d7-f15a-08de6277ae0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWp1cFo1d0ZnMFBNNGhZcCtTdWdTZkVrWlVFaWhRWndkOG9VZkwwMDVxVVpT?=
 =?utf-8?B?dHlvNnBOeTRYSFc0aXpVM09TN25YRWdtWkdhTTJaTjdqbDIzM2xZWXhmL0Yw?=
 =?utf-8?B?bkpuaDdpTXpMY1lEWVR5Wk16ZTVoSXBwOTIwZlJRN1RaWStVNHZvOGJNMFph?=
 =?utf-8?B?Q1J4am1kc2ZVTXZIUU55Tk9pSlFQNm9BK1lXRERCUWhNYVpWNW1ZVmQyU1FX?=
 =?utf-8?B?MlZzREFaTjkzcUhhUGNFbzJ1VW5CYk9COXlJOUxhUW1wSUFSY0QwdElyZzdx?=
 =?utf-8?B?SHRWQWlXcHdDZGVKb1NjU3Y4YjVqNlF1dWQ1V1ZQNkZlNVJQa3JYSUVnWU00?=
 =?utf-8?B?ZnZNNk9URkF1VFJpT1ZhdlFNZlhuZXowM2d1OFdaMnJ1QlIxUE1TUktOcjZD?=
 =?utf-8?B?ZElZUkNJdElnWmJxS21ncG1sR3doT0c1VStacjdFMXlLemhSMHFZcTRNYk93?=
 =?utf-8?B?UG1LbWlBTFp4UCtuak1jUUNCbWU3SGFkWndUcnRSWWVsQWVxM283SlNkRkQ4?=
 =?utf-8?B?RVFsTnAvcWtnSDY1YWh4elVrWGFPWnVva2NSM0Q5Z0NIZGdWNTRjVlVTK25s?=
 =?utf-8?B?Nkt2aGc4dzJXUUZ6Y3YwczdEWEJ6M2JkK3RSN2pNdklGWWc0ekFhelJlMHMw?=
 =?utf-8?B?VVJkRGdVcVpnY0ZSS1FONGZWeGZLeGhKeG84TlpKMHZseXFGeml1a21ETkdB?=
 =?utf-8?B?ZGkwbGIwN1d1RGs3SWd1MzFscVRNSW53TGNTWU8rQ3MzNkUyd2tvclh2TVlJ?=
 =?utf-8?B?TlA4SHZWMHU4VFRoRDVXTWd5cWVGby9pblh2RW5IRFNaM2huMFVhQzlheGRt?=
 =?utf-8?B?dVErYytmd3FNZWtpMmJVOGFrQ0RacFhiMFJ4SHlYak5jZjhkS3U3bVRENE5Z?=
 =?utf-8?B?R3poRUU5Q1E2VDNReWorcUYrR0d2cHlVQUZ6bWltYVZ5azN5Y3gvOVA5RmxW?=
 =?utf-8?B?Wk5uS1QrcXNWLzFTSzE1akE2bVUwVjYybm5zVndKV2loQkd3QlovUWNmVWM2?=
 =?utf-8?B?dFdoUUg5dVZ3aWpCeXZLRVFVbmljU1dKM3NUc01pczlqcjMvWTZXZlpaME5W?=
 =?utf-8?B?L2hRZ3N5V0ZtOWN1Um5zRHJWVWRVcTFoSVVXRGVYM0orczdacGZicjErK3NL?=
 =?utf-8?B?UWVwQjdhbmwwb21VNWN2cWp6bTArYzRxSUx1MTI1Uy9UeHBYMjJmcTBmWjk0?=
 =?utf-8?B?UlFwa2RiZ0t5Q0E2cmZqeGtNMjB3TjVvcWpKdm00cGhBVWk3ajFyNHZZd1Jm?=
 =?utf-8?B?cnB2aWh3dHJiMDUyZktBMHU4RzZmQzRMajlzYm1nMGNVcmhSdmNRZ3FKcnp1?=
 =?utf-8?B?UUxnV3dXWUxVcVdYVUpielJoZ3QvcC9BbVRRWm9PRFAxKzBSL1VxSnpaSXpW?=
 =?utf-8?B?bERGdGh6UXZ2enhNMXR2Q0M4UjZUdkg2bHJEVUxzZnB5YWtvNjh2MWJMMlVv?=
 =?utf-8?B?VjhEVEN4bjhVZWpTSTZNMVkxdGZtNWYzaXpadmkxVUxKSktSRWVQQmQrb1li?=
 =?utf-8?B?SFFDczFPTjNKU0pyMDRNblJMNHBwbnlPUFZsNmJTcW9GUnRORUk0enFFdFRY?=
 =?utf-8?B?cTZPNkl1YjlVMCtrM0hYZVhSeWVNeWJCSEVRcE95UlZlZE5XTG9LWDM1bnNQ?=
 =?utf-8?B?eUNvNzh1SVdvZTQwL3V3c213MEVCaHpjOGlTSlR1c0RpYW53TlVmTHZlN284?=
 =?utf-8?B?Y0FKZlNNMldxZm12V1lCam5oYlNPY3ppbm1iQklxanB0Vk5rSkF0dDJoWnU4?=
 =?utf-8?B?Y1B3TDdVMlpBRktmMFZ0VU51RlJBWlhGWjQ3eWQrRE1tMEpUdzFOWit2cjdQ?=
 =?utf-8?B?VXpRRUtKMVFPVUhsM3BlcGhSR3FrcUdvcnlHcE54WDBnWFhmdFVSVlNvWDdx?=
 =?utf-8?B?UU1pZ3A3VFVwM0szdkRRbnhDSnpsZzkzTTZtU3ZrdTJzOXp6dnlCMUZ4aEIz?=
 =?utf-8?B?UVpteHByL2pkQXR2aWVuNzhCM2pIaWJKTy9sVUZtL2FuNCtlNnJjKzNlRXlC?=
 =?utf-8?B?ZkhTbCtocHpmNkJ0b2tnMDFoRVdHTHlZL0FkUlZYOGJ0aENsQzZzdG93bWI1?=
 =?utf-8?B?TWpqNC9xK0N2dHQwL2cvY2lJLzNkdEozQW5KK1Z5dllHSFo5SU1mdEo4MEo3?=
 =?utf-8?B?YzFIUnNSWWtrd21TTlZuNW5NRmJXcXJKd0RqY0xPNkRJYlRrVWdMdmQvc21l?=
 =?utf-8?Q?JNl80B8BhFC0tH+vYvpE2Lk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzVCV0hDY3hhcHN1WGhxNDJhYy9PemEycjFZM2Y1cTgwSE15cTVCeFhpbkZu?=
 =?utf-8?B?ODZzd0NIVjZ1eHByVEl3WTgydHdxdTZ2cHdRS0l1aWxRMVZKdnFnaFZESW84?=
 =?utf-8?B?MTRtQ2oxd0ZBdmkxd1JHeWtJNmJDWloxZUtQNHdtbHZnT1NzS1ljMHdhY296?=
 =?utf-8?B?U1g0MC96dUc4TnM2ZGI0Q2JTU3FYRTZmWk5LVDFkMFUwbysvZ0tTY3VaTFE0?=
 =?utf-8?B?ZGdIQlBSTDROdXd4S2Njaytib0UvaEF5Nm5lNTN3RFJGOFIwWmZScXVNUGpi?=
 =?utf-8?B?c3hTYU9tRzFaMml3WFJNeFd1d01aMmZienBDOEZQYXU5dWpnclJ1TldqejJk?=
 =?utf-8?B?U1VrVFZualdrMUxkYjBZVVNMLzhuWHRWc2gxbm5RSk52ZTg2Z2tMY0R3b3N6?=
 =?utf-8?B?UU4vWEpMMFBpRnNERmU0blBGM2JZRCs1Z3grNGlHNjVUeHZpWnVHWmovVXNt?=
 =?utf-8?B?T1l0bVR3MDZiMW5ZbEV4QmVEZDk4aFVpbXFlMHRBUGEvMWhnNEQyVEg3NEEx?=
 =?utf-8?B?MnNleFFHV1c2SWVDcFlCaUFheEtwN3JDanNKK2lMYjlNZzFWcTg5YWJ2dVAr?=
 =?utf-8?B?TVk1TEIrRHFhb296Zy9FRnZPcU14N0N5Zm5hRUozcWNiY1hqNW1hVGtqR2s3?=
 =?utf-8?B?VGFVZTJ0US9RWUNoWXloNFVtWTYvSmRZOFd1Q2tzLzhtb0sxYU5DeDVpTGcr?=
 =?utf-8?B?NzNxZlZCN3ZtOXdPU3NzS3BtVXV2ZmV1Q2ZjNVBqL2RSekxtWjEzRytLY1h2?=
 =?utf-8?B?UW5EYmppaFpsRjI0eFI3TFRIdko1UlhzL3VpL0x3cGFvaWwzdlR3VWp4YTFF?=
 =?utf-8?B?V0ptNlNlaUxDSjJ5aUZaTEkrN1dZd2xURlBDQ25FdWsvcHo1eXAzajRGT2dM?=
 =?utf-8?B?amhTa1ZZY1hEY2JLbzNVVnNJYndocy9VRS91M2gxdnppWStockpqTlNyYnV3?=
 =?utf-8?B?bEpBR3Y3Ym16M1J6Qis3clBTbVdUcCsydG5kcW5mTjlUNkxQTm5ocDMzQ3FT?=
 =?utf-8?B?SzRud2k4c2hvOGR1VDZnS1NBeHpiTGY1OHg3bFFkTFdQUTdUMVBkRU53RElY?=
 =?utf-8?B?WEgrZThwMDFXdnB6QTlyN1Zib3c3Tkw0MjNYRXMybnBoODhKTGhHb1VXR1gz?=
 =?utf-8?B?QTYwV1I5dmJwekNGLytvQkRPNVFPRlN1L0hYU25zalVqaElvRVRiUzhSNlJw?=
 =?utf-8?B?dnlwbmJrNitML1FwditHbmVHRjh4cHVjdE0wRk8weWRvV0MwMXRFRVNUcU9L?=
 =?utf-8?B?NllESk1oeWhIenhZRHhzWnE0SGJ1N01Yak40M0h3YlR1WktVcFdQNEtDQnls?=
 =?utf-8?B?QWZxVzJ6ZTZBSlBzMlFoekZFZEcwcGRhSzBSMnhndUM3bXB6M3kxMER2STVq?=
 =?utf-8?B?dno4MDgxS2VVdU41WHhDSVJ2bTErbjd3K01sZzUrbUFFTml6aWkrV3RvaWk1?=
 =?utf-8?B?S3RDaWhvQXpPL0tqWlo4U1ViRVJ5MXgvU3lCVFMrMXdRbnl5eVBXUHI1bjAx?=
 =?utf-8?B?N214TFRzM3hGdzl2WkpVYkFVdEpleUxWRGQxSkRmUFlENm5FYkFRemppR2kw?=
 =?utf-8?B?Z2pTUVNVT0pXWkxzZ2RGOTRMSlNsUUZaZzNTZi9pZWFTVE1kdFVFbjREVnN5?=
 =?utf-8?B?TFhKaFdBK2U4ckRxMGFCS3JnbG5hR2dUbTk3SGprWUZ6Y1BqUnZZbXZrVElT?=
 =?utf-8?B?cjN6TEUzVjRROTJRS0dTZTgwMmIzeVhQNHFHUGdORy9sTXlvNzlaMytGdGFT?=
 =?utf-8?B?akhLVmpVOEZGb2kvN2pQbFJIbXFnK1VuTlpWdUhrS0xpMG9zRzRnNFBFbity?=
 =?utf-8?B?RlBrL3B5RzVORlBNV3NtNzA3N0orSEYvMHRuVXdzWjF0OUhrY2IxU3dKUzh0?=
 =?utf-8?B?dU94VGR4ajNpRVROcmZIb3RheENtUUFVOTZaWFVyQ2w4WmJvR0lnc2RGZlpi?=
 =?utf-8?B?cGhxMU1uUWZjblFPdWJGYkNycVl4bitwT3d6elpvWWRjQ2JjVUZzcDMwb0J6?=
 =?utf-8?B?aGZNWFYvODNQay9CS09HbGZZWEcxNWM1R3hKSEJpc1hJbmgwNHk1b1F2WFpz?=
 =?utf-8?B?cy9Rb1JndjIxaFJTV2tJdjZxUkFSd3hheWk4bWFqQkw3RlZoUXdIMmlEV3ds?=
 =?utf-8?B?cjRUWTNQaVZ1cDc5R0poL1NXT2c3MWZhN0xLZHkvYUpnQktReG9jR1VhZmpk?=
 =?utf-8?B?MUREU2JLaWxYQzkvMTlPVlAzcStNakxBOUdLVDFuSHZTNUlrbFVHYTFCOWVU?=
 =?utf-8?B?aGtJd2RvdU1EV09ObU1aM1hvMEtIa1dnVHIwTUZ6SklWemQxT1l1cUpoa0Zj?=
 =?utf-8?Q?N+R418yg7tJbPTniAr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ffda632-c9c7-44d7-f15a-08de6277ae0d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 16:25:29.8901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JCG2BPLZfYvFJCde4dm0AmNIzrqDyGpbmFka3tqoxWgYayNWl0C39m/wMDAzTy3CtAbJwuqAjFWVoZJVOsWeyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11574
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41917-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D2920CEEEC
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 06:34:37PM +0200, Adrian Hunter wrote:
> On 30/01/2026 17:04, Frank Li wrote:
> > On Fri, Jan 30, 2026 at 09:00:33AM +0200, Adrian Hunter wrote:
> >> On 29/01/2026 23:00, Frank Li wrote:
> >>> On Thu, Jan 29, 2026 at 10:28:14PM +0200, Adrian Hunter wrote:
> >>>> On 29/01/2026 22:00, Frank Li wrote:
> >>>>> On Thu, Jan 29, 2026 at 08:18:39PM +0200, Adrian Hunter wrote:
> >>>>>> Some platforms implement the MIPI I3C HCI Multi-Bus Instance capability,
> >>>>>> where a single parent device hosts multiple I3C controller instances.  In
> >>>>>> such designs, the parent - not the individual child instances - may need to
> >>>>>> coordinate runtime PM so that all controllers enter low-power states
> >>>>>> together, and all runtime suspend callbacks are invoked in a controlled
> >>>>>> and synchronized manner.
> >>>>>>
> >>>>>> For example, if the parent enables IBI-wakeup when transitioning into a
> >>>>>> low-power state,
> >>>>>
> >>>>> Does your hardware support recieve IBI when runtime suspend?
> >>>>
> >>>> When runtime suspended (in D3), the hardware first triggers a Power Management
> >>>> Event (PME) when the SDA line is pulled low to signal the START condition of an IBI.
> >>>> The PCI subsystem will then runtime-resume the device.  When the bus is enabled,
> >>>> the clock is started and the IBI is received.
> >>>
> >>> It align my assumption, why need complex solution.
> >>>
> >>> SDA->PME->IRQ should handle by hardware, so irq handle queue IBI to working
> >>> queue.
> >>>
> >>> IBI work will try do transfer, which will call runtime resume(), then
> >>> transfer data.
> >>>
> >>> What's issue?
> >>
> >> The PME indicates I3C START (SDA line pulled low).  The controller is
> >> in a low power state unable to operate the bus.  At this point it is not
> >> known what I3C device has pulled down the SDA line, or even if it is an
> >> IBI since it is indistinguishable from hot-join at this point.
> >>
> >> The PCI PME IRQ is not the device's IRQ.  It is handled by acpi_irq()
> >> which ultimately informs the PCI subsystem to wake the PCI device.
> >> The PCI subsystem performs pm_request_resume(), refer pci_acpi_wake_dev().
> >>
> >> When the controller is resumed, it enables the I3C bus and the IBI is
> >> finally delivered normally.
> >>
> >> However, none of that is related to this patch.
> >>
> >> This patch is because the PCI device has 2 I3C bus instances and only 1 PME
> >> wakeup.  The PME becomes active when the PCI device is put to a low
> >> power state.
> >
> > One instance 1 suspend, instance 2 running, PME is inactive, what's happen
> > if instance 1 request IBI?
>
> Nothing will happen.  Instance 1 I3C bus is not operational and there can
> be no PME when the PCI device is not in a low power state (D3hot)
>
> >
> > IBI will be missed?
>
> Possibly not if instance 1 is eventually resumed and the I3C device
> requesting the IBI has not yet given up.
>
> >
> >> Both I3C bus instances must be runtime suspended then.
> >> Similarly, upon resume the PME is no longer active, so both I3C bus instances
> >> must make their buses operational - we don't know which may have received
> >> an IBI.
> >
> > Does PME active auto by hardware or need software config?
>
> PCI devices (hardware) advertise their PME capability in terms of
> which states are capable of PMEs.  Currently the Intel LPSS I3C
> device lists only D3hot.
>
> The PCI subsystem (software) automatically enables the PME before
> runtime suspend if the target power state allows it.

Does your device Hierarchy look like

           PCI device
               |
       -----------------
      HCI1            HCI2
       |               |
     I3C M1          I3C M2


You want HCI1 and HCI2 suspened only when both HCI1 and HCI2 can enter RM
time suspend status?

Device Link can link two devices, but not sure if it can handle cyclic
case, HCI1 and HCI2 depend each other.

Or you create common power domain for HCI1 and HCI2, in power domain to
handle suspend.

It'd better ask run time pm owner to provide better suggestion.

Frank

>
> >
> > Frank
> >> And there may be further IBIs which can't be received unless the
> >> associated bus is operational.  The PCI device is no longer in a low power
> >> state, so there will be no PME in that case.
> >>
> >>>
> >>> Frank
> >>>
> >>>>
> >>>>>
> >>>>> Frank
> >>>>>
> >>>>>> every bus instance must remain able to receive IBIs up
> >>>>>> until that point.  This requires deferring the individual controllers’
> >>>>>> runtime suspend callbacks (which disable bus activity) until the parent
> >>>>>> decides it is safe for all instances to suspend together.
> >>>>>>
> >>>>>> To support this usage model:
> >>>>>>
> >>>>>>   * Export the controller's runtime PM suspend/resume callbacks so that
> >>>>>>     the parent can invoke them directly.
> >>>>>>
> >>>>>>   * Add a new quirk, HCI_QUIRK_RPM_PARENT_MANAGED, which designates the
> >>>>>>     parent device as the controller’s runtime PM device (rpm_dev).  When
> >>>>>>     used without HCI_QUIRK_RPM_ALLOWED, this also prevents the child
> >>>>>>     instance’s system-suspend callbacks from using
> >>>>>>     pm_runtime_force_suspend()/pm_runtime_force_resume(), since runtime
> >>>>>>     PM is managed entirely by the parent.
> >>>>>>
> >>>>>>   * Move DEFAULT_AUTOSUSPEND_DELAY_MS into the header so it can be shared
> >>>>>>     by parent-managed PM implementations.
> >>>>>>
> >>>>>> The new quirk allows platforms with multi-bus parent-managed PM
> >>>>>> infrastructure to correctly coordinate runtime PM across all I3C HCI
> >>>>>> instances.
> >>>>>>
> >>>>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> >>>>>> ---
> >>>>>>  drivers/i3c/master/mipi-i3c-hci/core.c | 25 ++++++++++++++++---------
> >>>>>>  drivers/i3c/master/mipi-i3c-hci/hci.h  |  6 ++++++
> >>>>>>  2 files changed, 22 insertions(+), 9 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
> >>>>>> index ec4dbe64c35e..cb974b0f9e17 100644
> >>>>>> --- a/drivers/i3c/master/mipi-i3c-hci/core.c
> >>>>>> +++ b/drivers/i3c/master/mipi-i3c-hci/core.c
> >>>>>> @@ -733,7 +733,7 @@ static int i3c_hci_reset_and_init(struct i3c_hci *hci)
> >>>>>>  	return 0;
> >>>>>>  }
> >>>>>>
> >>>>>> -static int i3c_hci_runtime_suspend(struct device *dev)
> >>>>>> +int i3c_hci_runtime_suspend(struct device *dev)
> >>>>>>  {
> >>>>>>  	struct i3c_hci *hci = dev_get_drvdata(dev);
> >>>>>>  	int ret;
> >>>>>> @@ -746,8 +746,9 @@ static int i3c_hci_runtime_suspend(struct device *dev)
> >>>>>>
> >>>>>>  	return 0;
> >>>>>>  }
> >>>>>> +EXPORT_SYMBOL_GPL(i3c_hci_runtime_suspend);
> >>>>>>
> >>>>>> -static int i3c_hci_runtime_resume(struct device *dev)
> >>>>>> +int i3c_hci_runtime_resume(struct device *dev)
> >>>>>>  {
> >>>>>>  	struct i3c_hci *hci = dev_get_drvdata(dev);
> >>>>>>  	int ret;
> >>>>>> @@ -768,6 +769,7 @@ static int i3c_hci_runtime_resume(struct device *dev)
> >>>>>>
> >>>>>>  	return 0;
> >>>>>>  }
> >>>>>> +EXPORT_SYMBOL_GPL(i3c_hci_runtime_resume);
> >>>>>>
> >>>>>>  static int i3c_hci_suspend(struct device *dev)
> >>>>>>  {
> >>>>>> @@ -784,12 +786,14 @@ static int i3c_hci_resume_common(struct device *dev, bool rstdaa)
> >>>>>>  	struct i3c_hci *hci = dev_get_drvdata(dev);
> >>>>>>  	int ret;
> >>>>>>
> >>>>>> -	if (!(hci->quirks & HCI_QUIRK_RPM_ALLOWED))
> >>>>>> -		return 0;
> >>>>>> +	if (!(hci->quirks & HCI_QUIRK_RPM_PARENT_MANAGED)) {
> >>>>>> +		if (!(hci->quirks & HCI_QUIRK_RPM_ALLOWED))
> >>>>>> +			return 0;
> >>>>>>
> >>>>>> -	ret = pm_runtime_force_resume(dev);
> >>>>>> -	if (ret)
> >>>>>> -		return ret;
> >>>>>> +		ret = pm_runtime_force_resume(dev);
> >>>>>> +		if (ret)
> >>>>>> +			return ret;
> >>>>>> +	}
> >>>>>>
> >>>>>>  	ret = i3c_master_do_daa_ext(&hci->master, rstdaa);
> >>>>>>  	if (ret)
> >>>>>> @@ -812,8 +816,6 @@ static int i3c_hci_restore(struct device *dev)
> >>>>>>  	return i3c_hci_resume_common(dev, true);
> >>>>>>  }
> >>>>>>
> >>>>>> -#define DEFAULT_AUTOSUSPEND_DELAY_MS 1000
> >>>>>> -
> >>>>>>  static void i3c_hci_rpm_enable(struct device *dev)
> >>>>>>  {
> >>>>>>  	struct i3c_hci *hci = dev_get_drvdata(dev);
> >>>>>> @@ -962,6 +964,11 @@ static int i3c_hci_probe(struct platform_device *pdev)
> >>>>>>  	if (hci->quirks & HCI_QUIRK_RPM_IBI_ALLOWED)
> >>>>>>  		hci->master.rpm_ibi_allowed = true;
> >>>>>>
> >>>>>> +	if (hci->quirks & HCI_QUIRK_RPM_PARENT_MANAGED) {
> >>>>>> +		hci->master.rpm_dev = pdev->dev.parent;
> >>>>>> +		hci->master.rpm_allowed = true;
> >>>>>> +	}
> >>>>>> +
> >>>>>>  	return i3c_master_register(&hci->master, &pdev->dev, &i3c_hci_ops, false);
> >>>>>>  }
> >>>>>>
> >>>>>> diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
> >>>>>> index 819328a85b84..d0e7ad58ac15 100644
> >>>>>> --- a/drivers/i3c/master/mipi-i3c-hci/hci.h
> >>>>>> +++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
> >>>>>> @@ -147,6 +147,7 @@ struct i3c_hci_dev_data {
> >>>>>>  #define HCI_QUIRK_RESP_BUF_THLD		BIT(4)  /* Set resp buf thld to 0 for AMD platforms */
> >>>>>>  #define HCI_QUIRK_RPM_ALLOWED		BIT(5)  /* Runtime PM allowed */
> >>>>>>  #define HCI_QUIRK_RPM_IBI_ALLOWED	BIT(6)  /* IBI and Hot-Join allowed while runtime suspended */
> >>>>>> +#define HCI_QUIRK_RPM_PARENT_MANAGED	BIT(7)  /* Runtime PM managed by parent device */
> >>>>>>
> >>>>>>  /* global functions */
> >>>>>>  void mipi_i3c_hci_resume(struct i3c_hci *hci);
> >>>>>> @@ -156,4 +157,9 @@ void amd_set_od_pp_timing(struct i3c_hci *hci);
> >>>>>>  void amd_set_resp_buf_thld(struct i3c_hci *hci);
> >>>>>>  void i3c_hci_sync_irq_inactive(struct i3c_hci *hci);
> >>>>>>
> >>>>>> +#define DEFAULT_AUTOSUSPEND_DELAY_MS 1000
> >>>>>> +
> >>>>>> +int i3c_hci_runtime_suspend(struct device *dev);
> >>>>>> +int i3c_hci_runtime_resume(struct device *dev);
> >>>>>> +
> >>>>>>  #endif
> >>>>>> --
> >>>>>> 2.51.0
> >>>>>>
> >>>>
> >>
>

