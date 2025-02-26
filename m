Return-Path: <linux-pm+bounces-22992-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6996A460C2
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 14:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CADCC17A8A6
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 13:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71564220696;
	Wed, 26 Feb 2025 13:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="js2B8VC9"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2021.outbound.protection.outlook.com [40.92.22.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3611552FD;
	Wed, 26 Feb 2025 13:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740576247; cv=fail; b=TpAB1F7f5Sbo1S2pgV2S5Wl4aF+12LGilRwbzRpsV2ag+mh/ZRZgs5B+nwEFumUrplUcSMjdTtarfePAPPrzfWVWa5K3W+SW5JtsZ8nGOVw2SdiGUMBwxWB96SWDeHLrBdN0c/HT0xM4cmC8JFHWAWYWXZnYuA+TPChBrCZda40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740576247; c=relaxed/simple;
	bh=rfdVsQBZ1w4r8DV5gyVyUSbejSElONYQT9ycqJxUw9s=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=r++UdmbvNkzD1x+L0+8pWE3Sh46GkGzVXpW5FIkbCBYyAOXwno8/VIE4ZctoDvVqZghEgTOOiEfXAkpi56nk3BoJoNqlUYfJgQy+e0fALww6qfHmeSbagwrjc/TBqy2UP3S6jGT/S8kEjeTu14AqoagfnCgM2JqMi+adHLDfoDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=js2B8VC9; arc=fail smtp.client-ip=40.92.22.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=de9rv+Qi5Lcbf9/J3Fo7kl/1TjqK9ycQ6ScbG74dkvJlBVZLfYeLldfKqbYfUOjC/RSeEqucJT++jDSv7zrz2Lzd+5l6/Xtb+DogMW/52syexWF3+wjzAkEnLS5BqHl4lW9E/ZE3QKQDEZHvaBW7nequtKrggenjmBVnAjLj6g86u2dAesSi2sDG2+RXtJYjv+/Y6sWolZKICvLBZallMV0bgLq6Q9CmJpLOSbqDgxEWJxYaAOrilNAPrszEoW/rjgFxrfw33Ie/LyWstPmlPoUWR7EQNG1nDExwW/KLdiAaNO0w3ChxgDMezenWlVwwQApgwvfTMZWFM48YdB/j4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbU20fbNV9C2RXIScXBclqXALcAdCO1Yx7s9d0znSiE=;
 b=pi5zymWdsP7GncKanHltH2MItQhVR2OdD95MRbh6wtGHoymVCkoxQViGncVxgIxR9apBCRz3Ff+yN7KuqeFxQvMNgiw5WvNLkGaymf31eTvv6krmqcTLCWZZYh+ZbMSONMi9rEHtaYLLieMImPXxL/Sd4sTJO2wciArtbPX6vHy1GEAekTBL1qxKx/J9FPUtwKFhEPScDp1iJVrr7UvvevhBIhY0txBlxrAhXk90hgNITfVRWcSHtW6w5EJHQFj2uG187E/0nyD39CfMqkt+gHAZyOOQyjEIt54gYyA7R9AkSuZnbRFbOVpQRIGq+q6VZTc2x90IyEn7GSSIWay9Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbU20fbNV9C2RXIScXBclqXALcAdCO1Yx7s9d0znSiE=;
 b=js2B8VC93MEvR/qsTq6bbRJcRwQm/5HmabRG1uKBqPmxKOXPz4CaxvE79/PAHG7j+qt00A/WYD2pZLVrmzPNZ1KTLkfKVAL0yQvH+FUE2cch0vjwUBSCDA+2Uh9kVWEmkKhM6j2aCPdCivVUf4GFFxD2KpubHJxeSI58xfiDgztkKzJyOX6iUMtsT8xfnKoE2Gy8OuIP04/1XwUcyJ8UMDhACpEklI8CHu0vx7YcrvKMnsAO8qYbsDWdoGfO6vMSk26mG/G4S0bT7vcmGAOk6bqPUFh0ASP+5f3aeyu83ud5KxquFajAAz7e5q1R5ap0beqKWzjak+fdsO1MmROMpw==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by PH7PR19MB6732.namprd19.prod.outlook.com (2603:10b6:510:1b6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 13:24:02 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.020; Wed, 26 Feb 2025
 13:24:02 +0000
From: George Moussalem <george.moussalem@outlook.com>
To: linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	amitk@kernel.org,
	thara.gopinath@gmail.com,
	dmitry.baryshkov@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	quic_srichara@quicinc.com
Subject: [PATCH v7 0/5] Add support for IPQ5018 tsens
Date: Wed, 26 Feb 2025 17:23:50 +0400
Message-ID:
 <DS7PR19MB88831624F11516945C63400F9DC22@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DXXP273CA0009.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:2::21) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250226132356.9398-1-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|PH7PR19MB6732:EE_
X-MS-Office365-Filtering-Correlation-Id: ddd22832-909c-42f6-6f1d-08dd5668d5bb
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5062599005|5072599009|19110799003|8060799006|461199028|15080799006|7092599003|4302099013|3412199025|440099028|10035399004|41001999003|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iOjxRfnklqu5w83lmmrJkSwkb7hrQFEjCA+tFtB2IThVRakieKtQVWmRca2l?=
 =?us-ascii?Q?9xqkzUI2G/boduVZWJBfEsALUjgzpJMU3//Vs4Aegw7dTOUkdYwU9aOn3hp0?=
 =?us-ascii?Q?M+VP6aO/kdMg8i8EXGMofWhqmLLkGt8Fl72xbsttDRkYyTM/mgORZnjxDze+?=
 =?us-ascii?Q?48uftUsCIwGDCge5zDdoh/8X0oatvryYU2sX18rdjSL8wJepmswhmSLAiENo?=
 =?us-ascii?Q?KG96CWVK/T5IWgM/z7cnvHPy7iUD8sFZ8BRQPlA2eF1SBm4fT8pjQSmT5cVb?=
 =?us-ascii?Q?1eDfxihiE6UHXgcVdaRlJmfdeJdjD5I5rjlle02AS3DAZE6ifYxiHxHGGT5z?=
 =?us-ascii?Q?QHMD0DUKoAFUO4lk4G70FK4Jz0nqG5OFKK1kpjw7HdVL/yNgiaecm5EYDz2F?=
 =?us-ascii?Q?6/k04N27/fWZJ2krcX2mYQ8SaYB8nFmG2XzokaxVfgDNrEvezanLVW+tZKmY?=
 =?us-ascii?Q?qBYupwZOFb0fuSr8v78luc3ROjyikwRArfyt8Wfq7jI1nPNGIwNJwPvXEcMV?=
 =?us-ascii?Q?NSwRodG0Bd1m5BnvxOPW3TR2DMxs2hTSl7jztLlnrYXqSf3zsIynnZbh7hTO?=
 =?us-ascii?Q?kh75dCglKiHVzLY5+T/SFjcq3mxy+wfqfQvNXygcP7ESahiefFLmTHjW5la8?=
 =?us-ascii?Q?uZNR2Fzyxd55qo4ep46Kbngyx+rufm0fUBYlY6EqepZKOsSQitcqwS7R14kX?=
 =?us-ascii?Q?IUFWdBYJeuzh1VLgUlGHJQRBzQvCVE6HgyYJcJcD+/sH+HyRG1rcDqAL98R7?=
 =?us-ascii?Q?lgOhQ49aYjo08QeRIbM9dS2lCNDf/GvkjetGvCL/CQ3mPR6MCJ/DpD/wP+sX?=
 =?us-ascii?Q?UKUlSOJY6USYQnPFzZybQc7miAfOBTb/61O83GKHY+uqTXn/b51gvvGV+D6X?=
 =?us-ascii?Q?BHJO/hDKaRF15wgb9ZUZxcP5XTPzXm9K06RrhkmAa7ekYL71lB3wWm7dVQB2?=
 =?us-ascii?Q?Rp+SlmwhyKLpjgfOaS+cX/7KAOXFsSJkFxPwE5A4af7xEw1dwwyatzb7Q2PM?=
 =?us-ascii?Q?50NtxDvfqDWw1BozZ+O+hTk4TEz41NjmaJtmxU+XJgPlZ4VQdPtQZtRuI5jB?=
 =?us-ascii?Q?KgUIvh6jP9q7NGJMhL2F+0SfUbMZ1RtBv/9P6w7OtfQ2fCdpTncKKnU5BE1X?=
 =?us-ascii?Q?NEI2hbxWqpd4nkSq2azihQwo7YejJA53PtHFFsnIMOOkjGl2+wodSuAwjBbB?=
 =?us-ascii?Q?UqfnAqmBYTsHdtHwsR51lnobN0dl5OlsO3crD6UTq075ceCIV0LBqs6ggMgK?=
 =?us-ascii?Q?Z0r7b0zKhe46XWU5SdFF944mPZwz4dry7AcH8i9nTemv3anIXXI6eKWhEKI1?=
 =?us-ascii?Q?IEo/azGRGhooJg/qahkTlciG?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?loir3eTnOQVJVcd+/nY66+puiFmebnddj4hido3CgnTjm8aW95GLZojoiHCL?=
 =?us-ascii?Q?xgVfnZ+ySdVZAQpT3dOeCOQiC006Sg6uhnXhnBdcokATxwH4jc6UUiAyDJCy?=
 =?us-ascii?Q?aliPlZ02hl1jQRKzQ5/VQZ6nlw4vMIVGmeCeXwCxV8Aui1SnrzPAGeQz4XIl?=
 =?us-ascii?Q?fQKka7hDuvHgRcwndP6fLk4/9GiyUhFP1klVdTg2Kdhws/y5DeTQsl0PpOwv?=
 =?us-ascii?Q?lMKhOcn4WTVa7oPPSW4CY9/XN3bAwIMq1+/cidvyN1GSfxqyC8HCllUbmImD?=
 =?us-ascii?Q?JuTqroRCcuc2eJlgWdeue/6Ojr+f0LF1+3KhewMxeugzQJBFGb2EsU5nE5AX?=
 =?us-ascii?Q?Kk4/f6i4hk0vVzJuj5IAG7zZzAkX27AerivAFPCL89g9PPxbp4l3RPJ9NGJ/?=
 =?us-ascii?Q?yokaWV8rN7JU334ofhkMt5U7crNy2fjpEKnvrdNTpPXfsnMYhvQDRyHoROvX?=
 =?us-ascii?Q?u/Og2x+0Ng4CL9zggQBdHpo5HoFZ3TClSt0LRJ9PcKYYj3dnDoHP5SU9Vjd2?=
 =?us-ascii?Q?6NXoa1679O1Hwu0dAbQKmG+4zoQUeF8C45stQjyIZGtgD9Sb2cB0zRHxftW8?=
 =?us-ascii?Q?Fi2I95TOVVceI2C95LYGNg7LQj4T3+9vgPWQNKo8R53cWoI7NwAfo18Je0Fi?=
 =?us-ascii?Q?WkETPPoXzkIIreCJ7+PvtiGj+BBatJxaUP55F9p/1O/7wc8cqd2iK3Q/RRCw?=
 =?us-ascii?Q?qcAqyEUHR6EdrkdcR9+iCC+iWiaBl2GaI076dw2RojQP28Ksn2TKso8SIT4c?=
 =?us-ascii?Q?3xpoxdQGiee3RLCbxu5drtAIQXOm3QdZ8FZRsITd5ekO0HDdHxsbHqMc1dph?=
 =?us-ascii?Q?mJK5fFWrZCCMkXbqJa5JLToCdp98K+S2PdaJv0Q08gKSPoVAVom8hOb/lGe7?=
 =?us-ascii?Q?YHOs5tLVAIS3b4qq8Zt/V5RGQ0L8DwvTTeubpnXQ7vDht1wnOrotwoDOaqom?=
 =?us-ascii?Q?ajjRuvcZBJYVzsUnOZWJsZuG5tZ6plpmWte8rgMLEBUqenCZH08M3fMfoaoI?=
 =?us-ascii?Q?yI1iEMpVFj6uxiOpCRAEuN0dVBiXYyMRMI/hPIJp8hX4f0Imkp8OjIeps/+E?=
 =?us-ascii?Q?+ALc6BPifPYy2PlpJI+PMve6Xzj7YScj3vdLNTHJGbyaIlv6wY3DPDt4+2vn?=
 =?us-ascii?Q?dfnkuzWU7BlUevYL1nX1KiG/fqeVdJherkMZLHxTSh3anEXHq+ha76Q3hRvH?=
 =?us-ascii?Q?E8y/KZ+HJwQqoWMOjMPplSUVNxa0gHKqb/zdtUGER89AQGoWuzbWEQRaoatJ?=
 =?us-ascii?Q?IXhI6TPbegq9+9YvJtm3?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd22832-909c-42f6-6f1d-08dd5668d5bb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 13:24:02.7133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB6732

IPQ5018 has tsens V1.0 IP with 5 sensors, of which 4 are in use,
and 1 interrupt. There is no RPM present in the soc to do tsens early
enable. Adding support for the same here.

Last patch series sent by Qualcomm dates back to Sep 22, 2023.
Since I'm working on OpenWrt support for IPQ5018 based boards (routers)
and Sricharan Ramabadhran <quic_srichara@quicinc.com> in below email
confirmed this SoC is still active, I'm continuing the efforts to send
patches upstream for Linux kernel support.
https://lore.kernel.org/all/63dc4054-b1e2-4e7a-94e7-643beb26a6f3@quicinc.com/

[v7]
	*) Updated cover letter to include
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


George Moussalem (1):
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
 drivers/thermal/qcom/tsens.c                  |  19 +-
 drivers/thermal/qcom/tsens.h                  |   4 +
 6 files changed, 252 insertions(+), 5 deletions(-)

-- 
2.39.5



