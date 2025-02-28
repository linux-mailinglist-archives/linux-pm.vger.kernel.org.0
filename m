Return-Path: <linux-pm+bounces-23144-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4BAA490C2
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 06:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 817DE16CCA8
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 05:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2FB1BC066;
	Fri, 28 Feb 2025 05:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="S3+6Jq48"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2040.outbound.protection.outlook.com [40.92.20.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C548632;
	Fri, 28 Feb 2025 05:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740719747; cv=fail; b=Fh6QBW1YktodQ/dveaCVI61nJvMNhyEDbRZdUOeXure7QXVJoFf2quRyAizZNGco+wl+I6FV+tv7QupRzmOgLIeLgbb4w4DkISZaGPWjBRnaFAjsxQtjqG84DwggcGkgeoXSlsQ1gUVRm97gYRXt6QtgxvayohhNN8ZixmfxB+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740719747; c=relaxed/simple;
	bh=DToZa9zVz0m2GunOjKOBmphkoitC/ibQTJlg4Le/IeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nrz+eP7L7HC4IHLRcUda6FaEDSP5E/Wt/2j94hyE5kGw8teqlhD2U4Am4UzoxumxUs9myqfmK53q/TyWituYH/vdpTNUeJA3N7MZdeue7CiFIJQysU9oc0w3odQlbHUlOHJr4prRTl0kMDmN5YsJH2FOaTScaMYyi6NfRxJvrSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=S3+6Jq48; arc=fail smtp.client-ip=40.92.20.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QL9yKQ2FUqxMQZDh5PAgGPmaaTrXYCu/OlTmTPwOzSgzbmeZWBhHRInSxco5g1ZCN4UEuJNpg956L8Hm8k20Ig8ucmLa8y9Tiwvtf5JvZjy1Sa9umanHYIEKeuhXmYhEzou3B+S0e0wLX876AxSXTXqVneV62Ryh3H+QWLRAgaJ9UkIi3z9Nq/2bfMGUZ+sQkCE9yThkq01UJLtxmQMVwcKULr+vIs8OPUiVMRYsMnd0pumRkFrAWAJIx+sbAUAXu9C596sjQSfQqQNcn8DloWAVUf/KZoHGi3HqwkQ8JIByKZVhGUy5vQP1vI8mXRrCk7Qruh8SX4R7sVCtwJ1HEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1q8ZPKVFSUZicImLgH5Wb6aLZh2u9GgthMU2Y7tEqc=;
 b=xa396F9KSob/slX1jM/B1UXh3RS6lMp/NlDpJ5909O9+HPKjaM0Xkcootbqr57PDlSTRelE+2e4aLi4TcaZ3fQHqUuUymuHOnnp3gceKrnI1CcZRV9sqRcM+Pl4docAe+Ud9jckFnpLbWWl1qVv3bvc17ffEcjZu9eXr33Qke72IZq5I/AeLGPs0O1Wu6AMD/6MI76OFrG794+xw61DR2MYHfriDoY4C3qKPW8jd7t9Kd7OhaUa/1j05dlURaAFm7+B76/sjPSOVVe3rJAsf20W7BSJrrRDVxoNFqCTpYTOy9pCYENKLIJ+qLjGvi6JtjqRNZ1gab/DDNWaviQrRjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1q8ZPKVFSUZicImLgH5Wb6aLZh2u9GgthMU2Y7tEqc=;
 b=S3+6Jq4860rPjOJYThp+3ATCOnODfngCiEDLk3RDX3FjkSpV8XTo/kbC2/r70Mu7fQX8KaktXtjF9gQFLjfPdaYkQ0/qh8n7pj25EZMV5L5tP9Nl2Ok0nFOHUcJc6sNLg3iMlrUVu1BaPbHB6HiY6QniIyovQKekCco7BcWMpaqOD8m44925F5n5tmUwUhKZkXNLRpWsIvxy8+O1pZh9TSQtQsPoa0wqGUyPV9HLJ9JBC3rRoykZLpE2lNt6WkZqtJ2cQEjHsI0pKY/72XyY38NDSy1TmV1kefFfEh6GLPtqud4FTdNB7R5H5R87IfpnhFERZgBPzwKbg9EpttOZ/Q==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by LV3PR19MB8318.namprd19.prod.outlook.com (2603:10b6:408:215::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.21; Fri, 28 Feb
 2025 05:15:42 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.020; Fri, 28 Feb 2025
 05:15:42 +0000
From: George Moussalem <george.moussalem@outlook.com>
To: linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	daniel.lezcano@linaro.org,
	rafael@kernel.org,
	amitk@kernel.org,
	thara.gopinath@gmail.com,
	dmitry.baryshkov@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	quic_srichara@quicinc.com
Cc: George Moussalem <george.moussalem@outlook.com>
Subject: [PATCH v9 0/6] Add support for IPQ5018 tsens
Date: Fri, 28 Feb 2025 09:11:33 +0400
Message-ID:
 <DS7PR19MB88836DC6965515E12D70BB2C9DCC2@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228051521.138214-1-george.moussalem@outlook.com>
References: <20250228051521.138214-1-george.moussalem@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX0P273CA0077.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5d::16) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250228051521.138214-2-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|LV3PR19MB8318:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e28edd7-b7ef-4ad0-c932-08dd57b6f2a6
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|7092599003|8060799006|5072599009|19110799003|15080799006|41001999003|1602099012|10035399004|3412199025|4302099013|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?86EWFtQuvoIWNa/14dACw4wfk68sTji6kZMcvxwhy48u4Xh0FLEb13geqv0n?=
 =?us-ascii?Q?bckll+yOJYacRVEyozT/TPua1Jt+j2IfIvkDONxUDzRF7VVMEQgSpsZ8vcgr?=
 =?us-ascii?Q?xPA6TLE63cnPb98X+Z32fVeV/K6eCdipuMt/nCasvYsDqVJG1df0SXUWD4gA?=
 =?us-ascii?Q?ZJu2o0PWr5mGwONrNxD2dcUdWYGHsd4A2ECYEG90TbBUwWTDNSl8vczCHoX2?=
 =?us-ascii?Q?fARiQ710ihfjFCJghj+Xtxi+VN3jpnjwPCdbIJtCs0KBFaGBQs8LpA/JnZti?=
 =?us-ascii?Q?Ymn0m3j84WbnXW2+VBsjnWtzY0ZSSgz29ak+A0Z7zWUEA3hki30YK8hiRdy3?=
 =?us-ascii?Q?UjEeizD0A+9oikGTPQMCk7+04rgIsqKs2tgWmTSI9qF3mctwCMJ7cOn3WtKA?=
 =?us-ascii?Q?LAyOgLFH+iiPPp5/dkSAig3dGNeBRup5NDT0vcM6i9Dgw/sbfVlytTdDrz+0?=
 =?us-ascii?Q?8QAYj47j3NgKV8NGMnrpBYilUnkXtxUJ+gkYLiH12iz5idV22CziQm0EJO41?=
 =?us-ascii?Q?PIopP8zZWxgUL80D8sfpCGkVKPM5wLPD4Xo+LknDjZQ+/voMrEg/kFeJ5hiQ?=
 =?us-ascii?Q?CBDVnVB2dBAI6ETfvMBt9L7rRNgGSwCTpxvGw2PHfkflLLdLLPyUbGWlYnWr?=
 =?us-ascii?Q?hR/Z7OZvaw8MJqIblPdUTBQ3I//p0kq7mNSoh5nYVpXOfT0lMNIZ5WSYZ2iN?=
 =?us-ascii?Q?fkrfUYDavA65VuA206cxs+eSH/ho73dsjKdloTuRENRlqmYKwBmH1lD5C/cc?=
 =?us-ascii?Q?C7xh+pmBUvc5jJb+sowNCA0q9JEmBsbOIRTJUV/bGZd2d6Buw9nZAdIIhbp5?=
 =?us-ascii?Q?ECbnDMMcgFVSx8rXBOY2AtJ6lekJqOOl4/42QK4HvQhzWLb9G5uUu767F+AC?=
 =?us-ascii?Q?/fewbrj40DNMUAcRyhc8Dlpp/E1c9J6Q5J04iei83fHudzH6Gw6SiMnVQur3?=
 =?us-ascii?Q?U+GTDkm79evhUzKD9mHO5vwpikNf4XHf/RG72to0SD+u8naRHaoPS/wlfvTG?=
 =?us-ascii?Q?5S5xWmIxkwJEnR+AWYUYu/YHytnYARHPEE24GqPE6ONBBeIbcz8Xi7eo7bgO?=
 =?us-ascii?Q?aBRmCKJyo4YAJumvMUcsXc5qtmGyqGjAM3xbsGz1mt/JinmwC0mirWTJmkSk?=
 =?us-ascii?Q?2vliLUFA312FMCtDs3jC+nasWS/YkXrLPznYc7OXUDKElwhpB9L1NMaZ6slp?=
 =?us-ascii?Q?8UCzI2A358PvLu0SIagS7puWc2jylhfPcR2ItyuzTxZ0rChbN9VLg62kh8Py?=
 =?us-ascii?Q?WNGQaV/i9l/FAq/NeBRFALoxCwxg+MU+yxU8RpZ+1nYJXmzUq4y/3KNTuXsW?=
 =?us-ascii?Q?9jIstAOay/pEjYQ0ZmN+3v5J?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tSywk98x+WKeiaX/bB76NY0G4B9yb5ytQ5mPDgnj5nbCTIwd3QAXn+XjOSIg?=
 =?us-ascii?Q?O0Iy8m6/WqauFX2pEXWPKASWz9WZZ2MbzMl7fXl2K020SRwnj/u01c7d8ps9?=
 =?us-ascii?Q?CWOPSrG8Hs1/nB/UhGJtUOfSABqtchwwrlXAOlc/brCUl7TEptDUxSjciUF7?=
 =?us-ascii?Q?5QXR8bfvA7m2ZxOz3wUBUnsXoQskuTHMAM5g3LLP6ldEDng5xe3w+/Iq4wIA?=
 =?us-ascii?Q?p1q0t5dIVz4L9kcExbZpHGA62BZQeObrIZU0jWjIXwWvDGLDqvbGvZ2Y/kil?=
 =?us-ascii?Q?Ns/ywgAKZEYNXTdEF1fVNsUmfVgDbDFE5UuLSeE0RIkpahUlJNhbYavxOyx3?=
 =?us-ascii?Q?XzToNqY9XCCmiySxWLiT+sfSXm2W4t5dvrF9RpYIyYtN8l9DOzIM10CYVaL2?=
 =?us-ascii?Q?nIND84OBeYyiUTU0fmrhtAlVu7wrTUdb+zfm91Gj3jgtJRj+QI2xbSan1UcP?=
 =?us-ascii?Q?98QJbPACb/mj+xmryVRQSRUdSg3lTxIZxvSNartg+JRyFSctS6kUdnI5flaw?=
 =?us-ascii?Q?lzKJczCLsAYhR6iFaKihYBqTSyjK1gia6aEMd3LXJ7NZc+qOU+f1A7FuDyDF?=
 =?us-ascii?Q?+eG+ebMqFcXNo5WVgjMCM2b+9uf1cr1gCD7mTxCTLZEmSVrD6m5Sfji+Cwpu?=
 =?us-ascii?Q?JuH+XQ3KHrhNq2xEyLtW2lOiE2H6q++zQ5bspBf2z4j9jTGAPXQb1pAxyjCa?=
 =?us-ascii?Q?YJ/m//86VhANfKeyOWOiGgGrpZoHaDjWTYZuR+uuPPeEBdlV4alrMJ5MiP6V?=
 =?us-ascii?Q?4SVZk+TB1Xif4kckfQWq0L6Vhj/fx8/k6mVWVNkhO/Ie1WEFebuQH0D5jfMJ?=
 =?us-ascii?Q?UesNOOZmNPBRO6UVQPlcZpLD/4MgbQseyk5SkyDSLSCvQPfbBaHE8gxUdZ2U?=
 =?us-ascii?Q?JGA+eakQiFRhj4sNFm7R69Wet33DIxQECEZAMOFsTcDZLgktO3vgeubnNtlt?=
 =?us-ascii?Q?N5C3TI59J/QNplTHbTNYjWN8XDfa+8R4lIGttf7sw1XuuEuhxUQoF5JjB3Lk?=
 =?us-ascii?Q?dMFp3y1NDWDnHnL+KewnJJctVXg9VG37ZDyQ7CwAju5octX8n5EmLIHIgkWa?=
 =?us-ascii?Q?jpw+Cv9PgVBOqXiYlLUIJEiL2tc5pnRzeCJhapp9suw2L73sbUKLOKRx9Fg6?=
 =?us-ascii?Q?xRhnpAaBbcsQk7zilqEQaZ3wzLcwoXKzQ4BEWm3Qc3dnXP3sCTSu2euQQQrK?=
 =?us-ascii?Q?JPLOdG2oJrgJ4jiigWIpkNcSR/EORyVPwwGzqxaRrRA+IjA4JUXkkaC9ueuD?=
 =?us-ascii?Q?K1M04wyDeKyxhkpKBr0i?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e28edd7-b7ef-4ad0-c932-08dd57b6f2a6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 05:15:42.7118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR19MB8318

IPQ5018 has tsens V1.0 IP with 5 sensors, of which 4 are in use,
and 1 interrupt. There is no RPM present in the soc to do tsens early
enable. Adding support for the same here.

Last patch series sent by Qualcomm dates back to Sep 22, 2023.
Since I'm working on OpenWrt support for IPQ5018 based boards (routers)
and Sricharan Ramabadhran <quic_srichara@quicinc.com> in below email
confirmed this SoC is still active, I'm continuing the efforts to send
patches upstream for Linux kernel support.
https://lore.kernel.org/all/63dc4054-b1e2-4e7a-94e7-643beb26a6f3@quicinc.com/

[v9]
	*) Updated checks in tsens to more strictly evaluate for v2+ upon enabling
	   v2 features as suggsted by Dmitry.
	*) Split patch 3 into two, one to update conditional statements as
	   mentioned above and the other to implement tsens IP v1 without RPM.
	*) Added back Dmitry's RB tag on patch 6 which wasn't carried over
	   from v7 to v8
	*) Link to v8: https://lore.kernel.org/all/DS7PR19MB88833F7A9C8F4FC484977BA69DCD2@DS7PR19MB8883.namprd19.prod.outlook.com/

[v8]
	*) Tsens V1 uses v1 interrupts and watchdog is not present (only on v2.3+).
	   As such, replaced VER_1_X with VER_1_X_NO_RPM in conditons to ensure
	   v1 interrupts are set and watchdog isn't enabled.
	*) Tested on Linksys MX2000 and SPNMX56
	*) Link to v7: https://lore.kernel.org/all/DS7PR19MB88831624F11516945C63400F9DC22@DS7PR19MB8883.namprd19.prod.outlook.com/

[v7]
	*) Updated cover letter
	*) Replaced patch 3 with a new one to add support for tsens v1.0 with
	   no RPM and removed Dmitry's 'Reviewed-by tag
	*) Refactored patch 4 and split support for IPQ5018 from support for
	   tsens v1.0 without RPM. As such, also removed Dmitry's RB tag.
	*) Depends on patch 1 and 2 from patch series to add support for
	   IQP5332 and IPQ5424 applied on Feb 11 2025:
	   https://patchwork.kernel.org/project/linux-arm-msm/cover/20250210120436.821684-1-quic_mmanikan@quicinc.com/
	*) Link to v6: https://lore.kernel.org/all/DS7PR19MB88838833C0A3BFC3C7FC481F9DC02@DS7PR19MB8883.namprd19.prod.outlook.com/

[v6]
	*) Include (this) cover letter
	*) Picked up Dmitry's Reviewed-by tag on patch 5
	*) Link to v5: https://lore.kernel.org/all/DS7PR19MB88832FDED68D3EBB0EE7E99F9DC72@DS7PR19MB8883.namprd19.prod.outlook.com/

[v5]
	*) Adjusted commit messages to indicate IPQ5018 has 5 sensors of
	   which 4 are described and in use as per downstream driver and dts.
	*) Padded addresses of tsens and qfprom nodes with leading zeros.
	*) Link to v4: https://lore.kernel.org/all/DS7PR19MB8883BE38C2B500D03213747A9DC72@DS7PR19MB8883.namprd19.prod.outlook.com/

[v4]
	*) Documented ipq5018 in qcom,qfprom bindings
	*) Constrained ipq5018-tsens to one interrupt with description
	*) Added Rob's Acked-by tag
	*) Added Dmitry's Reviewed-by tag
	*) Fixed modpost warning: added __init to init_common
	*) Sorted tsens nodes by address
	*) Sorted thermal-zones nodes by name
	*) Link to v3: https://lore.kernel.org/all/20230922115116.2748804-1-srichara@win-platform-upstream01.qualcomm.com/

[v3]
	*) Added the tsens-ipq5018 as  new binding without rpm
	*) Added Dmitry's Reviewed tag
	*) Fixed Dmitry's comments for error checks in init_ipq5018
	*) Ordered the qfprom device node properties
	*) Link to v2: https://lore.kernel.org/all/20230915121504.806672-1-quic_srichara@quicinc.com/

[v2]
	*) Sorted the compatible and removed example
	*) Fixed the name for new tsens_feature
	*) Used tsend_calibrate_common instead of legacy
	   and addressed comments from Dmitry.
	*) Squashed patch 3 & 4
	*) Fixed node names, order and added qfprom cells
            for points seprately
	*) Squashed patch 6 & 7
	*) Link to v1: https://lore.kernel.org/all/1693250307-8910-1-git-send-email-quic_srichara@quicinc.com/


George Moussalem (2):
  thermal: qcom: tsens: update conditions to strictly evaluate for IP
    v2+
  thermal: qcom: tsens: add support for tsens v1 without RPM

Sricharan Ramabadhran (4):
  dt-bindings: nvmem: Add compatible for IPQ5018
  dt-bindings: thermal: qcom-tsens: Add ipq5018 compatible
  thermal: qcom: tsens: Add support for IPQ5018 tsens
  arm64: dts: qcom: ipq5018: Add tsens node

 .../bindings/nvmem/qcom,qfprom.yaml           |   1 +
 .../bindings/thermal/qcom-tsens.yaml          |   2 +
 arch/arm64/boot/dts/qcom/ipq5018.dtsi         | 169 ++++++++++++++++++
 drivers/thermal/qcom/tsens-v1.c               |  62 +++++++
 drivers/thermal/qcom/tsens.c                  |  27 ++-
 drivers/thermal/qcom/tsens.h                  |   4 +
 6 files changed, 256 insertions(+), 9 deletions(-)

-- 
2.48.1


