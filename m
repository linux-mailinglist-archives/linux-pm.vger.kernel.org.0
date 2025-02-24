Return-Path: <linux-pm+bounces-22767-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E732A41524
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 07:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5632116E5FB
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 06:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EBC1CBEAA;
	Mon, 24 Feb 2025 06:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="eaiZBm2i"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02olkn2026.outbound.protection.outlook.com [40.92.43.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332351EB39;
	Mon, 24 Feb 2025 06:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.43.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740377565; cv=fail; b=eAIl2vEqmxVIFJncFP4ebNGdhQ7HIA0gIiGb41K8ZrdLvjmiEst3DwQ3CJNiEG/Vab5zBfPT2NOzxdcXT7BPPAlIf9sh4neGxEeMpfIet01WgdlzJ5Gwv/PEbnIK6PYCfJ13DcPnhFOk0tnWRlyRLwJ3ppAcAOSrGv+Myaz456s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740377565; c=relaxed/simple;
	bh=p+ouRBPNZCXyTVNcK4FlTBizbV2TDM0WdQfz41vzT6M=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=s6+YVBjlENn9tIhCkbZMHPibd6nfLzpCritHM055nWGBs4RQNrbBwv4CMpzhcZ4K+LR820WVnhmxBTyDleC5MyAzYh7CRg7OTRyAp8xKTeij3dcGJeCF688KXkDqOjFJWpZM58mJjBnTNG6WVBola2ht/9e30hots5M/IULprSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=eaiZBm2i; arc=fail smtp.client-ip=40.92.43.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qAZh9tzRCrI/b8YWem6UHWbgbEJwZ/L/Bx6rQbZEscncNCXvi+4UmVrVf2IlppmjUI76xag8vPvY+DCr392rBfc1plY3r4LIHFdACWwKeBmqN4Ddchp+hz9nSJTWWt+YUSNvPtzywtEuyTDD3R2E8aNBjy/fDaD4KVrpSkIC1YeCSdHJ5wsDn+Zd1/2AoDISllHdY9hxeg7l6rQ2HQ77yPXqgWk149klWTulZRjndIgG/QAujdr6bHYlj6MUIIv4NBz9QGkdsVbnhRsopKk/1C05ke2jhWmlJ/5+L7c/CjoJ5XSVwN8obbthQ3ELLGoCGS5SSwYfNe4PIpSlSrj8qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2km6C1wAH1c3sG80qzcCy7jRlA56LHUq6tmPFkpiT5g=;
 b=H8ii3wIhAybj97Xwd87rSB0OGwNVViBY9tZCk3p9BRPOqVKVD/Uf2WcBSCJjFVTE8JOYUP4oWxr+FWiahbdJu9jRyYinre/l8+USxO1KH0Mb+mJ8G+30Ep/4UAQiG6vR6Kq+DVukXc2miXPmxi2dgy4DJ3Gsk8CrI5mQ3mVTe1snS0GDNIQiiO5P6VH2xI51i6MxW1GA/NmBmVz/x42JHRLdh2LDUl8wY+avgB/+W9+XQVEV5UDFXVkoGZv2LLlZ4Bs9A0Rd8YjrjEGUhHOgdGhI633UflBGBYHZ2h+Pq//6vlxLW6ETUfb53z05xXA8fCDkk1vEfdO6D4hQzYjaLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2km6C1wAH1c3sG80qzcCy7jRlA56LHUq6tmPFkpiT5g=;
 b=eaiZBm2i+PWh/crfV5HqbFxBp9fRvGnXoEGYlqSqwln62px4Dm8nbvuv0rGOoBpuyh+ZRAj8HxHwSxVp++siPw/jDtfzlO8Lyr1LtSyvQ0brR2em5qFDBGHYUANDefbLGtnkobDiw5X9wRdnMAo8Tzhs7tWREdO7o6JKWxmTv7K+4hMTUZqQw/lm3kOU7sOUeAzIWCuXVuwyQA9dQsWwLbi9F2gVzSzw7g6algjdBfGRGH063Sf3abDL6jDYDosFfbzPQsyCQcXENvGESayApwFkMe8f+1J1rpc2HJMjGmNPgUAq605BsURZjz8ZcQATYkCwWMyT9HJmbwAc1O4bZA==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by CY8PR19MB7179.namprd19.prod.outlook.com (2603:10b6:930:92::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 06:12:42 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 06:12:41 +0000
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
Subject: [PATCH v6 0/5] Add support for IPQ5018 tsens
Date: Mon, 24 Feb 2025 10:12:19 +0400
Message-ID:
 <DS7PR19MB88838833C0A3BFC3C7FC481F9DC02@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DXXP273CA0002.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:2::14) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250224061224.3342-1-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|CY8PR19MB7179:EE_
X-MS-Office365-Filtering-Correlation-Id: 9df6b81c-4eda-45e9-609a-08dd549a3eb8
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5062599005|5072599009|19110799003|461199028|7092599003|15080799006|8060799006|4302099013|440099028|3412199025|10035399004|41001999003|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yv+7lefjqZL8Ttd4XqyHLts/BRJ/gvlou0rUGlQyqECmMKe9At2wzRoSjv3N?=
 =?us-ascii?Q?DmvOM489KVZ6BFR65/8LfzuX/4GJSlxljmIwM359yVL7YGiQaKL2Aw75lC5k?=
 =?us-ascii?Q?mEGUVMzLAXYlrBFPwWxuuv8WEd14tNXUc5GkfvCSNwxMCpytHlN3Twxb4mw/?=
 =?us-ascii?Q?9t6HPgpAqsY0tut6ZWyMmuInM7VLhkVjhLm68O3TSYBETbrKys/dN9MSsfBF?=
 =?us-ascii?Q?uCZxBtAnYCywYNOXmgD/wzaPhoNPFBK0kKcQFircd3ZICbbpywxA9PZwk+4b?=
 =?us-ascii?Q?SYohj3XbmB5eZvshKscx4x6WQbH60M9aA9fpzPDvyGmApBudtY0UrRZafcoM?=
 =?us-ascii?Q?PrftdzgwTJsDt5v10yEPQfR4woYOMq8huUlRuamgFgSj4Koaag+D65ejv9Of?=
 =?us-ascii?Q?2iL3G6G6rFtU4R1jiacmQUG3MxPMNr4IcBw0oa+jUDNsh9afL8cVyBXFm60Q?=
 =?us-ascii?Q?Rctuc7mjSzWqlwwb9m+tpWj1S6KtS5Hk9o2FjJvdzpXLu39banp2tPlgMBNb?=
 =?us-ascii?Q?fMetMDBfyL3oX/7xVjuAQwi9RSNsGfzkydKVOduwVhUZHKb6iIzMeemhnUR+?=
 =?us-ascii?Q?+LJXDyuhzrwesZy8goPXRhp3WbOkE8a73t1s6DJklicrSVmLWdXRntiuWjHe?=
 =?us-ascii?Q?jU40t2jIzUmlgeibZI9rIcBNJNFieF3y+zwQyCtbjdpP7q/VFCRAwyuXfpey?=
 =?us-ascii?Q?emVXVqn6OHNziOvIrG3i3fYeGiDc4MzjjDV6HXqD41vDXvV0xq2Bi+Pm2An0?=
 =?us-ascii?Q?J8JMzw1ujwuTHz7mqLKQIu/OarMY7U24OULy9e2sE+TcVp7SnvQRkSciUkBx?=
 =?us-ascii?Q?Fi+5/TpT9MYkTf7JgUv6nry6U2HXHvsXOnhFn2/5tuK5FvRR2Xm/ofV8aLro?=
 =?us-ascii?Q?XgQ2zBxEH9grfSA/siAwsaVu/XLUDKzUhN5T0D/c9OXahZ/xT/r6ZnWSvXuO?=
 =?us-ascii?Q?iVfNPZ/PLPkztxb626mQEnyabm5GFAybu1I1QJOGI2bS0tiW5Tshq6U7moj7?=
 =?us-ascii?Q?sKeTkSDFX0r0yagnRSbM2BgFJrAu2KKWcSLdG3d56vcVO7bYP6RsGqCBp2Bi?=
 =?us-ascii?Q?00uzMSwIxLrLLraUm8N3jyw8J6C4Ng/SAEOgYKRBDxV4Szo8XvzyH0/epzPk?=
 =?us-ascii?Q?q0ZqUyb+oHRF/DEXHl6JvtFXOZhGu4p4T8Bwd+/3Oiy08vs0QuWmiffjydyJ?=
 =?us-ascii?Q?MY9Lw7pkncPDYQkuzJ7huWxY/RJKdtF3khl9hqfWXDZpKIrT+PX8mJWilYn2?=
 =?us-ascii?Q?PjSUJM3AK+xI57T9EldAZU6wEW3hdEs3JOUVezeu9IYTPDSWvg3nTY/VWcAR?=
 =?us-ascii?Q?PpO7kxtGDsv2c9FXjs5SJH8+?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8S+1nvP6dLOt1rX6xUV26SrLvQibAu4FJ45SMhIWZufyOQnETq1rjqvkBucc?=
 =?us-ascii?Q?zlJ0dM8iLPgpnNLBFoK/0Aqw9ImhpFewqpvX/qvei9nTR74P0ZfKgLgfQy7X?=
 =?us-ascii?Q?1Aosfgl5mz0a7XfOHxcF/3oL+W2c/UYd4O5zs4EzrFRsZgy3ZwtNeoL3ambr?=
 =?us-ascii?Q?qBRD724EmblTsmTYIMQdKw0PHk+ovFeB8R+TUwc9E5XhCQkuthlK8yTLgWyq?=
 =?us-ascii?Q?BoqIT6LVVbhonIhvZbKKPCjMhon3z5aqf9DZDZrXjUJ5vlQTeZ/csDtBmxHz?=
 =?us-ascii?Q?uB04T02qWAxMxbaFS4Y+HYZy9zuhgnlymv79B67CMux/7pyBV1yEM4lFM0iW?=
 =?us-ascii?Q?fuP4pUQQdtXm0WEoHHP6htou08p+lG2+YRE8AyRR/Z869n0JkTed5Dx/FDTI?=
 =?us-ascii?Q?JW5eEWU+iBRvP5MlLWHexqW5Rl9GkA9yHLI1eJmlLuuhTskMMFi7Cl9gUP7C?=
 =?us-ascii?Q?AJoziN14oQatHabMAl/o0YA6oOeKVm6R4fiWlgE+oIc1ACJ+wF525UnBEUXd?=
 =?us-ascii?Q?BRng2ASB9jIdfwdQOplyG3CEbA08O0ZW0bfibInPC7XLi3DddDCk53Y972n3?=
 =?us-ascii?Q?Rj6X9Ho3jsMaFk/zEie8mh40MC8158oxv2D0VudplPHmGsK2/QthW3KGuPHb?=
 =?us-ascii?Q?q+NGGcVVNIh30rLgcmmzC54u/GAhK4RfcR2vWJTTjzbSP1eGmSiO2pTzq5yB?=
 =?us-ascii?Q?5Kqvp6QoiP/PGvV6ru0o/4rZe0I3VlPfV1ytMxdUGi3ofKblBioG5V9EuiwH?=
 =?us-ascii?Q?LFiST6fdrtrOhHOY/YQY3B7djVET5xPZvfXhm01PjRX9kEIG1nGVe2wR9+Ld?=
 =?us-ascii?Q?aQcate2oTBqKmuiRXj8p7Zaecokqj7Y9keUpiGz2G7/hFdc1umiWUz+8W/xF?=
 =?us-ascii?Q?vF2IKljlOHyjWtgiOnbuuPViffabx6mXO9FQcRIDBblfTow9v1Vx+KOb9YJT?=
 =?us-ascii?Q?1UjIajUI6SIJeXVpTzgRGy2bwFIeKVd53XK7HAJ+g54Te0rcqvSkyIY/Nmwk?=
 =?us-ascii?Q?3x/Lc+GPjmRrLo/JnMKKAA4oyrow5FKuaJO20lz0/EHCKOdjduVxT2g2sLdo?=
 =?us-ascii?Q?hch134vQMR5uZAljqpvH/rzICF6WC4GiECWb3d/acw990B5YNXsjNAVoaHmE?=
 =?us-ascii?Q?E4RucRCg9EAd4bHyLY8QMwARsrksGgSMZXsd+NAmU5Pq2uZsDKiNTWEzgEre?=
 =?us-ascii?Q?9zOLduRhgCSqqDL/Cgp6/JmUF0d9Xn5ar4aMZwvBOMvMsYMwct39phvkv/87?=
 =?us-ascii?Q?4JVDmSljhxPM+7Xjo5kR?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df6b81c-4eda-45e9-609a-08dd549a3eb8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 06:12:41.7020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR19MB7179

IPQ5018 has tsens V1.0 IP with 4 sensors and 1 interrupt.
There is no RPM present in the soc to do tsens early enable.
Adding support for the same here.

[v6]
	*) Include (this) cover letter
	*) Picked up Dmitry's Reviewed-by tag on patch 5

[v5]
	*) Adjusted commit messages to indicate IPQ5018 has 5 sensors of
	   which 4 are described and in use as per downstream driver and dts.
	*) Padded addresses of tsens and qfprom nodes with leading zeros.

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


Sricharan Ramabadhran (5):
  dt-bindings: nvmem: Add compatible for IPQ5018
  dt-bindings: thermal: qcom-tsens: Add ipq5018 compatible
  thermal: drivers: qcom: Add new feat for soc without rpm
  thermal: qcom: tsens: Add support for IPQ5018 tsens
  arm64: dts: qcom: ipq5018: Add tsens node

 .../bindings/nvmem/qcom,qfprom.yaml           |   1 +
 .../bindings/thermal/qcom-tsens.yaml          |   2 +
 arch/arm64/boot/dts/qcom/ipq5018.dtsi         | 169 ++++++++++++++++++
 drivers/thermal/qcom/tsens-v1.c               |  60 +++++++
 drivers/thermal/qcom/tsens.c                  |   5 +-
 drivers/thermal/qcom/tsens.h                  |   5 +-
 6 files changed, 240 insertions(+), 2 deletions(-)

-- 
2.39.5



