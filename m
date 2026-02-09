Return-Path: <linux-pm+bounces-42320-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gH7cH/pJiWmg5wQAu9opvQ
	(envelope-from <linux-pm+bounces-42320-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 03:44:10 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C5010B394
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 03:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA09E300822E
	for <lists+linux-pm@lfdr.de>; Mon,  9 Feb 2026 02:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180D22DAFDF;
	Mon,  9 Feb 2026 02:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="li7dUpIz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dTgXWb2n"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E59242D6C;
	Mon,  9 Feb 2026 02:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770605043; cv=fail; b=FUFeHi9eO2cWs4rj0ED2+v8n1A0k9WYSO3gcHRompKsA6EmctYyd5wCh3RXJfRn6Y1l5K1zUybc0rw6dkKMEMS7guLPli4fkISUmF2h0Rwf+gVEg8Zz644sydWeU8+csZzK12EcAtab/H9pITMMBZBeAbOBNbzviX+CylGBwJ4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770605043; c=relaxed/simple;
	bh=u+60uCMheJ+KbYqZQVYBt/6cYO8hIVO+DBKq40jJDQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZcIhF+cYBfRdtsxCR5vlHNv7mrAszTz457T+PgeCX/+A0GlkCfrEYwtpM41jWrHi5ajRpIREHebDPILqW9t+s0ev6tjLA/fkCkLczsrht7I0a2Jsss1ljc1JdKi/V7B6ny3Qo+V0GmpiFEOOkT5ZuNPf00VauP/qwSvgkibfZds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=li7dUpIz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dTgXWb2n; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6190H1ia194061;
	Mon, 9 Feb 2026 02:43:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=PN8gl00AgWSHNwVcpx/OxMd/Cw3256lLnqS10cs3nQw=; b=
	li7dUpIzkTClIYFZsOUPV7U+esNia1QHCTZH3RmzYHGHdA3SYoIKeMQVzQXAAzTn
	s3kXZt5m+hLHXuAB1QEZOxhd/9KtqMVUuINr9voKYsqV8iaoBWK65agBLMa9WSOf
	gMye+lMMJtmvMm+adF58UBUd74jYtNUfKzS/Hoc8v9A7A8siTpex+4WbgKzSFOLg
	laP0qlM1jj1uvNhymfn07yO4XT/AVtAHRpzXcFxivdMD9CbBlcPjwaZhI2DQNj6P
	N0G6fzckOI9LyNG7sCFLrGYr1F6I28dp6zveNgMqcIWKLczQSfe9dIbSeLk40gsR
	7ViIL2LH2YfNLf7NVp9zRw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xhu99tg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 02:43:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 618K12a4031636;
	Mon, 9 Feb 2026 02:32:27 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013040.outbound.protection.outlook.com [40.93.196.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c5uujf559-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 02:32:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nm5oM8Qx35GisoridZusKiDw3U3QiACnoEVvyGn+N0PUPvqXCEZCVQPOUJTiEcT3fzk2w/rqTZdIX1QWImKN0/d4nrxt41dT9O5X2Gwn7XmqUYDZQNpsgKdDq6BjS8OdcSz+bszs/ghQZZIKsSL2JOZJ8diXTnxVDI3RJvB8odQqJTgFjW3jegjB93LOFlJbkUONe9p98Fjaj50OCf68Ai++r0rnxN795WhPMytgFOfrp8egE+yHQyJFMGrQZA7rlRMja7E4tNCMSbtOvFP9aDENFtyAq/deer9cmpSVNf2ZL3heOCMOrV0yVF/V6bWFd3MP0VMe9rXGzdDX9R4CUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PN8gl00AgWSHNwVcpx/OxMd/Cw3256lLnqS10cs3nQw=;
 b=BIPr/tD5vc4SLvifKdeAfyCKsry+9TNd1dnzpZyEd2cjMVGiFL8vOpphzowubr4/oSM5E7xkqDtKpioOdNIY5iA8Hh9GysgP6bjV27TECU/5PBiO62RXaO6i54L3em7aoDobWSiz/A1nW9C3uBtWMyY1ZsH0BKhHffE5KdWssXkRuFVVLa1X/1ZIXTmjoTCNaTUOatIuPHypNpJwFEgCch+lgTKoVTCoMtrmB3X/9EGuAFEPc/7ammYq3amSQ6e+Kk5gshcE7M/ciB+ym9NmS8FhbvoEJ3Mhs/V7gea0wgNQB5r7uhDJEDXdwjlgvC3FI8+Tr3OUOFczRe58X1EJQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PN8gl00AgWSHNwVcpx/OxMd/Cw3256lLnqS10cs3nQw=;
 b=dTgXWb2n8yZUkDBrHyUNoLcKOopD3HoUT2agF3fAZineos7CuX53duW8VqoQV+PjxH8BNyTEABtFIn7AkkYpU6LyOwJxBSclIhrG2garMvX1A4WQIqiCZ5ZU2CifjU73tuHDkS4rPT0OjpoOvNdhT+g/bl+vMYkeXX99VpVNXgs=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CYXPR10MB7974.namprd10.prod.outlook.com (2603:10b6:930:da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 02:32:24 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 02:32:24 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v9 12/12] cpuidle/poll_state: Wait for need-resched via tif_need_resched_relaxed_wait()
Date: Sun,  8 Feb 2026 18:31:53 -0800
Message-Id: <20260209023153.2661784-13-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
References: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0071.namprd04.prod.outlook.com
 (2603:10b6:303:6b::16) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CYXPR10MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: fc3b373e-f2a8-4d0b-1798-08de6783755e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dYv+qx7zzfC/tkxfrHG8DZ03vp0zAS0u9Ic7jUS4yCLFafhDxfsAMmDsWr/c?=
 =?us-ascii?Q?F9nL1u/D50Fss4cAIEHYSYsW1f9FyuWmfXPhYeGxkgfxDGj0JtmVydkjLrJj?=
 =?us-ascii?Q?dsWAhYuQGY3NN8dbnBFcjG9/TC+P2Z6rZVqbcODOylozHIamruLH1ZI0D2Xx?=
 =?us-ascii?Q?euijDDkqYsmqWt9tIEtvbYWD7Fvnr0OK/4APXYhv2Wn2SYt196cNcWxKqWQJ?=
 =?us-ascii?Q?9g/9DfkptPylvHHEuX9GOJFkKqlqVodCCfem2d/bkBhrrlEQtIfYY8wwI7QJ?=
 =?us-ascii?Q?RPuTfTGImjXnx4iCICoqWYf/MWM39Sjccu3K0vC2CEHYj6z/ePHDRRWCtX2u?=
 =?us-ascii?Q?5PP0WoOJzO8LEk3o7TvP+n6OlYlUMZxyOatpmjSCpbAhz4HhJx/7H1xs0Lco?=
 =?us-ascii?Q?bwa3VgV+1/EUWz+FnBHTib3jeljpkFNgZK9aFwQnYGS0xP2TaXpk4o7m+iz7?=
 =?us-ascii?Q?kF3Y0QPYkM2TM3iJ8up0iz7uoI4sbk7wMXfL5LBxSVW3yvnjNTuLIUuN2Dfy?=
 =?us-ascii?Q?8tHpHVyMSYk+0wnrAp5BjXqTcbm+U2+JfHqCeevRtgtSIeTDDgGE4WdnScX+?=
 =?us-ascii?Q?evsy5Qi3/Ex6QNEvdn5q9LDVckHvbDVOopIqGHxF5RwG3amSHnLtDSTDv8yB?=
 =?us-ascii?Q?LurfXjVE9RO7qEmFkXycVmBWt4hMDMq3LB/BUB9LoKQFP3JWJzjmN2gPoDib?=
 =?us-ascii?Q?8UFTCvbGEapNPxOe6RaobOHmLIikFKKptCwafU+dNH9F0wBuB+mAN0PDebd3?=
 =?us-ascii?Q?wsJDdXoqbVraefJYMue4kkys1j1MMFWazY0WPkk7Z1kN5eH5UXDuZOztYNqu?=
 =?us-ascii?Q?Yc4uLD1plwMuHnhF8YAaqkXYEOacO8i6GOiMpz9Evy0PPIF2X1ckSqeOO8o5?=
 =?us-ascii?Q?gT7m3ezG4FtDV6ndlueJJsqqNmDikqx3eMSNKqE+XHkGLmeY5OZ5Kur8A50n?=
 =?us-ascii?Q?Kp/+IfpJaRzk8B6M6WYLblUdgtJDYr5BjCHAXMbLxl/hLx5XXwMUxnkVa9y/?=
 =?us-ascii?Q?YcZcwcPdEqU1tDnRrwmVi3a7uMu8ayIxYcZfh106Zt67fFX3+F7QTSwgm2h4?=
 =?us-ascii?Q?qNMvItLHG1zATqhC6kf4/bk1DkgRjPmpZV+ENu63kNf2FL1Qiv7wOPxail3A?=
 =?us-ascii?Q?dJx+KmtLo4nokpNlxkGq9B3vSgrrVzpAcb5wp2Qb/qEN7bAUVhE8C8vTmatp?=
 =?us-ascii?Q?rueIj6IzHGpIlc6URjskd29I6ih9lP4DaSEqyGlPyAZrlX/929Z/yvlBsnBE?=
 =?us-ascii?Q?Rpm14Akg7iyuvysiussYg3YIHVVpHwZ2HCcj3lIoUWVEaYB2aXooXzFU0LnL?=
 =?us-ascii?Q?hvL+F8Y8yGessxsgFi8N0+imQ/smF46vPX39vHFgY0J/Rv2J2n6USQg1Vwrb?=
 =?us-ascii?Q?Ye6OEn8vBxIQ5fBIvrwWK+JIkKwxyzS95mFK0gibRW9Jhm8sljqCWffbjpYB?=
 =?us-ascii?Q?PUB/cQygxUyZZVxhbIA1EelgH3MYgAHrWcYKF1jbv89H9N2fRaFM5zMd3p7G?=
 =?us-ascii?Q?vj6n+AmiiqYKSA9mefwvP9xxuRFgqWx+cloWsh5ryRZOCJ8z1dcH69Kt+Zm3?=
 =?us-ascii?Q?DE4ReVR3DbjSV9dXKfs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P7DvbSRbd+k90WbTMdGvSF7W6+/ZhtJuOL/x05KbWa+NpRbG8ZOHggsQHbp3?=
 =?us-ascii?Q?B6x6ZHu7opUqMTwRXW1DKkVgpmt6NsNZiuo5pLRjVaPlNAJzuQtgq4W8G5bR?=
 =?us-ascii?Q?oiZqnEJu3FDoOOTW8dbsQQY02+9FOMyRmTGfEZ8O8Hcx1Tth4n9Suz+ajsJQ?=
 =?us-ascii?Q?dI/xKgXOqKrNMlF0bg043q6yuh7j55HsyRtQhGoBkl5jrNRWBJ7+euskPUnm?=
 =?us-ascii?Q?fFAsYKZe03AwgGxcbrj1llQDHsMdrVmxD6E3dtwmnDxfPU702OynDzboYkYC?=
 =?us-ascii?Q?J8amE4TXq5hf9+sPBk1y7w7fDv5jjcf/3klFSFEH9XeJVBinGO4H45t1wKL4?=
 =?us-ascii?Q?b2hySasP3buhR9rU295Fzlfb6KGhmGCXwerpqTNAramrrs9tVwS86u8RbUuk?=
 =?us-ascii?Q?Lo/kGWyfs8leswWXaHDxfv89/od/5CMl8k4dBz919IA6Qoi70k0MXJo3mED6?=
 =?us-ascii?Q?uESeO3OrJ7KYa77tk3iwjtMohJnwAeMp5drn7F0AgPhAgxvZCfNOdWHDbgdM?=
 =?us-ascii?Q?dWENDggFJnmIrgF2vhTBJ3pn5Oo25W1gxXuwHXQ4HUgur+xcHFyDqnQMtuf2?=
 =?us-ascii?Q?5n40EmSNHhoyuiNw6VqVlyjr0LiCX1IFOauylTt+kco7Vkc4Xpl1jAuK0o78?=
 =?us-ascii?Q?Ne+0Gk6wHcLDoGqN5NZb65rzZU5JQgivav2ISZKsZ/8BDB+LCYUevUJHQIKP?=
 =?us-ascii?Q?EcmVqTYAF6r4XPTXyaGoSG6oldamu2lZDrCHauIUSHWNyicn0tdTdTpnFoPX?=
 =?us-ascii?Q?O+W4XQDMAtdmI7cqoobXVoJWwYBqP39r2IuuKXR4W1LUFAcELoO+k68xBdmq?=
 =?us-ascii?Q?LX5oHqy6RYsCV2F4XyymVi1/qsmH/uhTt+RkvW+oNqF7TcV8UHuBrXcvESwE?=
 =?us-ascii?Q?dX2KpMGrFfmviToyGja1K9ZEfaus6ph7CYNd1B7M6XAwI03FARh9zCoVpdCB?=
 =?us-ascii?Q?vFgPH38iUCtP19+t/0Hkz3t3n9BTMewQj2ZSTh+/OA7zLwWoFKUnbhyYbRqd?=
 =?us-ascii?Q?qdjVDFgGIgzDtOoeqp7dsTRMgIfsd/FMaWmr2moPwhcazwzaIpu+4LSP8tR8?=
 =?us-ascii?Q?H5RL+vcqRjeF77aJInbSDsMEZv18ZVQwFv9RvoGl7lBnfeiXMWla2wpF7Oyv?=
 =?us-ascii?Q?UnQoxGRCM+N0hpZZbpU4xAKlFV2kB0EaR14MDCFCWKECoRkZeU+N1DLa74bS?=
 =?us-ascii?Q?dLgf58fsXSqPmyJMLHqoI1uJd4sjYqSPsro/k+17zutyiJsNYgjWGHo8HG+S?=
 =?us-ascii?Q?vFx2Y3t1aUJaKeDqEK/5JWlcPHMOC0hwqqFXRGt9bOrSGU/NbQ2aYjjRBS9z?=
 =?us-ascii?Q?js10i37sKSp4abIaBImbwgOjxck8Y0Q6iSwl61dPBeav6Rrb6KBsr5viVEd8?=
 =?us-ascii?Q?eOSYXWP2/WClTgWeWX0QGDr1zrweNrNhMt1jskGIkj9nx9Z146rFUPbV36t/?=
 =?us-ascii?Q?0WbW+I97OZrrjQEKTDr0lqjZYAKNTbXS5bdcXP/uQg95ujf6Yeqpjrb9k2sM?=
 =?us-ascii?Q?0A3Zgnmc6mVrQz7qzPCjWOxD5676Cm7Ohb2dL3HkQeD7+Gca0zc0H1BzdZso?=
 =?us-ascii?Q?u3Iy9FK6BULyyTYoVy7lB3OU44pOrZnnaQUrwZJhsb9s7rPKuhkGTKn0yWMr?=
 =?us-ascii?Q?BFqNpUAeyYORIZ0IY/XL2g64tjjrB0F8haxpJaX2LnYK/GAB6Xv0geB8etYk?=
 =?us-ascii?Q?hbfGDOk/VVMcoOXtihQI/oJ766TKyvoxaafhOoaLe18LkXhhwMcMNWX5jLgo?=
 =?us-ascii?Q?/Y7gwv7PLwZfp2DrU+6LcoJ6s/jYvqk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	seOiwm8Af+scTWii2rbEO2Q8uqS1OvuYljrkGjl7VQUSUZlrRwpxV+M6ac2bv4CV3SJ9zEDMN0to6oMvmjCqCTax8fITgu0ACYRJ3wmEAJSx290yTBhgvTRE7eQKmff4oR9T5C7KLugyPv4weFs24C4xKt0BGXt2Uuw3Kt+BiOjCJiyL+3aZo5gZ6OqE4W4/dDmPuo1ZM8/X84AX5GJAc0ZhriL9ml1QYobZ/7gngJcx5+eiIdjFWM8itAy/yQVMai3oggITGgRrqAMIaaEDxYQpDDyp9q3fqkbAZGMoZKlzlGfnmp6Df0AxSBJbIsjpoGLaX30y5P+ODexGrBulmY16jfKvJfrTeiQaXV40Zog2Ej+OsHCWfq5kWquVJmDSa+kt9WgU6FU0MTYt+x0NOWx1gRSHTaXDpl/pBZOpAuMc//xCNB8awMIf7uS1CnkNC0LLw2YhOKQSHn0W9E1+39PwI4XKV4r+EUwjXB15MaWh5oVn80QqhJuYu1YBfAhNqtjTjeUyGUnxUlVS0qLieDtqfYFsoFo3xamlT42n5ivbqNByFKe8aRqjl4rxrDHL1saO0nWhai/3wGxqsS2z8CyWQgirn5ls9uh3rA4mKHc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc3b373e-f2a8-4d0b-1798-08de6783755e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 02:32:24.1538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9kFvWPlCKIoBY1HJdBj4PogsXWmqJHXTKXgk2fZFg3QC8JGEYjU/zdNoCvAUjKAdphMdPF8v/vWgXCK/oPJQim8Q5jDo2iDT5nVSPi7Vtms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7974
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602090019
X-Proofpoint-GUID: qiIAW9GDVLnW4iRWsJf3W9bpTrGJ6rEf
X-Authority-Analysis: v=2.4 cv=FIsWBuos c=1 sm=1 tr=0 ts=698949cd b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=yPCof4ZbAAAA:8
 a=7gr8-LgUhGOHEYCj_R8A:9 a=cvBusfyB2V15izCimMoJ:22 cc=ntf awl=host:12104
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDAyMSBTYWx0ZWRfX+FNE0AWD936w
 y3mAp7fEJvG1mRgUAaP2GMfxhdkbBNfp0Ucnh+cKztJ4RwE5DG0oURvpvDcJfEW+3mg8saQtMdu
 GqDG7bnYhgnCYdMie+7rupkzqAvlVyxrIFmGSuV+yalPrenizMi341GFrONN4e1Pp6tMtvRLCy1
 m791UR49qPPeCyMw5CmNW+NYK9LTfovF0fuNm3NbS79flISHD7hZmNHyXN/E25s0x+c8vuCmfxa
 XHQXOpsHH+zDR/IeCe+02RtQolnCS6tgmJfMmAMoqxFz/joMJbg+5LxknR30XXkmQNqHH3/j3uc
 2zuipjxk/fNdL/Hcsz//vy9Lj/JRKD2mLHBJ0O0qAwIEnybjSrX6lDW7Ft8Ex1j5gwaTrBIm1U0
 bfiw6KDuQU4Jl344fUFYeMcZLES2taXHUCbjnajtIhHBvmrpl8vZ4yjhCu8+SLbT05KU1Pk8M89
 oQDo5BwNbmS2/ULH155d9npgCtBbN1WOmaVlutBM=
X-Proofpoint-ORIG-GUID: qiIAW9GDVLnW4iRWsJf3W9bpTrGJ6rEf
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[arndb.de,arm.com,kernel.org,infradead.org,linux-foundation.org,amazon.com,gentwo.org,linaro.org,gmail.com,huawei.com,linux.alibaba.com,oracle.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42320-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ankur.a.arora@oracle.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:dkim,oracle.com:mid,oracle.onmicrosoft.com:dkim,linaro.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D5C5010B394
X-Rspamd-Action: no action

The inner loop in poll_idle() polls over the thread_info flags,
waiting to see if the thread has TIF_NEED_RESCHED set. The loop
exits once the condition is met, or if the poll time limit has
been exceeded.

To minimize the number of instructions executed in each iteration,
the time check is rate-limited. In addition, each loop iteration
executes cpu_relax() which on certain platforms provides a hint to
the pipeline that the loop busy-waits, allowing the processor to
reduce power consumption.

Switch over to tif_need_resched_relaxed_wait() instead, since that
provides exactly that.

However, since we want to minimize power consumption in idle, building
of cpuidle/poll_state.c continues to depend on CONFIG_ARCH_HAS_CPU_RELAX
as that serves as an indicator that the platform supports an optimized
version of tif_need_resched_relaxed_wait() (via
smp_cond_load_acquire_timeout()).

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
Suggested-by: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
Notes:
  - get rid of unnecessary variable assignments, casts etc

 drivers/cpuidle/poll_state.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
index c7524e4c522a..7443b3e971ba 100644
--- a/drivers/cpuidle/poll_state.c
+++ b/drivers/cpuidle/poll_state.c
@@ -6,41 +6,22 @@
 #include <linux/cpuidle.h>
 #include <linux/export.h>
 #include <linux/irqflags.h>
-#include <linux/sched.h>
-#include <linux/sched/clock.h>
 #include <linux/sched/idle.h>
 #include <linux/sprintf.h>
 #include <linux/types.h>
 
-#define POLL_IDLE_RELAX_COUNT	200
-
 static int __cpuidle poll_idle(struct cpuidle_device *dev,
 			       struct cpuidle_driver *drv, int index)
 {
-	u64 time_start;
-
-	time_start = local_clock_noinstr();
-
 	dev->poll_time_limit = false;
 
 	raw_local_irq_enable();
 	if (!current_set_polling_and_test()) {
-		unsigned int loop_count = 0;
 		u64 limit;
 
 		limit = cpuidle_poll_time(drv, dev);
 
-		while (!need_resched()) {
-			cpu_relax();
-			if (loop_count++ < POLL_IDLE_RELAX_COUNT)
-				continue;
-
-			loop_count = 0;
-			if (local_clock_noinstr() - time_start > limit) {
-				dev->poll_time_limit = true;
-				break;
-			}
-		}
+		dev->poll_time_limit = !tif_need_resched_relaxed_wait(limit);
 	}
 	raw_local_irq_disable();
 
-- 
2.31.1


