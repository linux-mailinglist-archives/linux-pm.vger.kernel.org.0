Return-Path: <linux-pm+bounces-10777-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4353692A49F
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 16:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A754281018
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 14:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63EB13DBA8;
	Mon,  8 Jul 2024 14:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IoZjOxHf"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF6E13CFBD;
	Mon,  8 Jul 2024 14:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720448814; cv=fail; b=akapJV+I7RvFr3X9FajW6Sd6xx2fc6tybVEisdA+Q9oD2tXKGh/Tn2FkARnMzfFGV5tuxaiChfAnjvpK6Wn6cZKmx0zwwzYMZ2t3rQQh9OFeQ1Vq18VCehakWchufPpP+bi8kFfXeM2Wir6GUppPMeoODZKwPmbFZSJn96keWtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720448814; c=relaxed/simple;
	bh=LWHXojcV63pqtIbL/LqkpUcsf37p3TRMnS5Ao47Tgx0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h6pOG8ImUc/8psUlNIXCiQJATHQsk8/t0ss6SDT8+rh2QVHKj3Gf61cdJ2+nHrEK/5WW4h3DdnwFeUSR60MXavy8FAumrY3ECERNmjksySvp1hD/vM/JCGNdOXhstI+y53zOUUWk4AlrzX7nzir0Q7fKLNf+hHiLyhe5cbkZ79Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IoZjOxHf; arc=fail smtp.client-ip=40.107.236.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+EoHIgFsKMZumatJHJnsRxiY/aG2wAuOWZTh6TapT2ORQVlqKndD/53seGg8YDZ2UMUbf3wzsN9uKCm2ehUNcEDy9IeD0TH2ZVYSZhvQcAm+UuNY/FOV2X6MqTU2/Nl64IeeRywglrqYi0Ss8QUh196hQ9oRuHhu4VaXulwx3nPSEIVlzY+q8mdieGPVldgm971CW3nlLZxIDxsMMc7/+PGWlpyz2k2DyUp6K8PpgiDhcmoWOI5ckTCv1Sar0L0iBGx4kfRy0ZDIcsfF+c0BEn927Wp3/iPqbBNK1EYM7apymYGMi9qzEaEwuqep9ndBVAgu4yrX/P4NN2mrSkNNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sG6kwJAVtN1UIgdt39aR7MoDM7+d/jbz9ba7PJuO0z0=;
 b=GPiNq7kMDuTKYJV8JNaEPsFzIzcJmbUDZ6hnuGfMztFz6ub/8ep3LSZjUTdkzTQ8UPj/FHY03+oGUnL+Vb+BanAlNxxec4D21lzc5VfMOY3w7Jhgd3CIDgAsLmbn/OYOd10JvQPJVEMItmXvlA6WaWb06qDPhzsBe7DA2blOz/qj3dgdfxWXbwiEE4jRjuqLPinXZr+Eo82vkoCABTAuZRYl1PMuxqYXEsInJVyzjTy/62KUblzDZ2YMnDgstypqgjK8qQMtp/yT5rTq9oVjc4++Dz6XzqJ3eGubJ11zd3+uOGxnqY/L6TQiNGRvXl0mw+BNvbt53lnFm0+/x5QmZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sG6kwJAVtN1UIgdt39aR7MoDM7+d/jbz9ba7PJuO0z0=;
 b=IoZjOxHfyymFhf7EDdrQI4lAYFBiQIL8Esto8+u4m9bPLX2eMIFFA/a4hIRChdjSHvu55fNbmX7eWXBJtP2veBAHg+Yf7m+2bix1IeV+Q3+f/UTD3OJIWHiy6XkRYtimSw88atgEmqIIpFSBtLAg9KhK6me/VaYaJQFLUhXT6KEJvGu7eeMxTFh2EnOyjKkmdexWk18K4ehFHjesuRUUMxKTiRR2/iR++5tGgUytJODbyNHvQ3DUvalvEwlY33TWJInqGG/YtEywo/K0XRVeWC5maLWeqzYzsmjXByGXo7+MbRwegY+T25zhFshKukgSir9YBTXHcL8o/l5uLdS+RQ==
Received: from DM6PR06CA0029.namprd06.prod.outlook.com (2603:10b6:5:120::42)
 by MN0PR12MB5740.namprd12.prod.outlook.com (2603:10b6:208:373::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 14:26:45 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:5:120:cafe::dc) by DM6PR06CA0029.outlook.office365.com
 (2603:10b6:5:120::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Mon, 8 Jul 2024 14:26:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 14:26:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 07:26:27 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 07:26:22 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Petr Machata <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
	<mlxsw@nvidia.com>, <linux-pm@vger.kernel.org>, Vadim Pasternak
	<vadimp@nvidia.com>
Subject: [PATCH net-next v2 2/3] mlxsw: core_thermal: Report valid current state during cooling device registration
Date: Mon, 8 Jul 2024 16:23:41 +0200
Message-ID: <c823c4678b6b7afb902c35b3551c81a053afd110.1720447210.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720447210.git.petrm@nvidia.com>
References: <cover.1720447210.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|MN0PR12MB5740:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aff30be-a136-4ce2-2cc4-08dc9f59fe71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RIm8DD8ZhaSrrxJNvh80ibfpx/PTRVjKZvk8zCZS8RjrfBZMglTFfzRTMs/n?=
 =?us-ascii?Q?F8ciqLXUk9imIfAaAkTy91ATlcugPSw1TWqaRBbcywmruIkSd7+9e4F6ztCE?=
 =?us-ascii?Q?M6NTd68Im28SdOF2uO1tRo7Mt3j5Efm7kBMtxDh7zViok0dApdyo4ydiM55X?=
 =?us-ascii?Q?zGctvNKkwNJi1Voxu59v0PcXp17MuRZBcHEHbe4gyvmyP2tzdsa0i7pZXd8t?=
 =?us-ascii?Q?njNIQFx0jFLpreY5aTfilorfhWP9JeuOp+nl3pHLaQ9M0+NibrTHQq99nsgB?=
 =?us-ascii?Q?F4sjcrDIcgrNxghEdxztaC21ZTfPnPHsYj2ixc3orwvC3qfyZY55k5ItMwjk?=
 =?us-ascii?Q?s8wL+BNKFdRvIXNnJHTc6Z39zXDacYjBE8EyWkPEm3PN0ucGc5HYI3STGwMb?=
 =?us-ascii?Q?UkSHqYseosVhAsHQV5d5NqMyqUU7sXXsBOKJ2LdcsV+PMOTQUMMS6/bHQYFk?=
 =?us-ascii?Q?bYR0UkrkBGzrmiZ3Smd5Ym8MpSVcPEY1bsRmUpmeiDh/ZKwa15lhk4iu6aKF?=
 =?us-ascii?Q?Nrqkg14CkpULz4Ow9To6N24WXeZTy0MkAI1M+eCjzTzdEqUdfYVFcyhgJ7G5?=
 =?us-ascii?Q?K9H2Oap7f/i7dR1uA2zBln3JBUkrazHGXy+uo8d1OENipgionmSXThNwBtdZ?=
 =?us-ascii?Q?zUF9nFVtaXIW9dodyng8xXrDg2OBTI/VPyRIxoYY0DQ9Ptqd2NGnnSo9DWVb?=
 =?us-ascii?Q?DX8j3JQoI7f5oAVSo8GsZniemPF22Zrw7fxKragBqnPZGTe2DVTTELqcXgzC?=
 =?us-ascii?Q?cv0uiA6Z/jbWaupZFd4b0Yw4LzLxvu1JtOPcFwNbQnDpuB5lCO6NqKdLkCzd?=
 =?us-ascii?Q?Qt5jUZZEFowKw19xnyncCX3dhhPX7C642TgajqdBZkNm5rRX5VFJsriYmCuA?=
 =?us-ascii?Q?MHtWXvVGYB3LvHtjHDqUlXbhIX7ZueeOIxtHyh0YVXIx8eqBNnxWb8YhINJm?=
 =?us-ascii?Q?SesKfAfWH5URqwAjCggY/vmgACKnZGFW70/z3XYeWL7Omv6AGStX10O82BLN?=
 =?us-ascii?Q?ydaq/QLwONDMILUvpXwUySpkuPrs9cOGLqkejSduThL7W7NtIFiDo8Zyaowb?=
 =?us-ascii?Q?bGRj1R3ajbosuJSf7AxJ34+RGbDj0rYUzMEqRiwhZRpCRiz+INA2SSWmpLDY?=
 =?us-ascii?Q?jcMPZluFAbcUds1fczeSPsIaUdzvoLvbANv0nZ7GlOcKLd8pil9NXp+7uLGX?=
 =?us-ascii?Q?OkcCm/hxpeQf2F43E5xNMLpdAjhvLCNlg8LtiBwhu3s+mnV234Viet4978TI?=
 =?us-ascii?Q?t9Oh53Ne+gtGWXLV/xw6ewGrtXaUqcyWRAojQpJaAZbPenv0ed9kUIpuSWb3?=
 =?us-ascii?Q?6D0pWeh9+EsIAaatKr3sRNMGeMH6eqSJcN5oTl2P9M/uwgG1bhqxHshgdICI?=
 =?us-ascii?Q?yncroGixvW2+99vuuFU/lKmW0OMpKtSNzabpsEzK5umzo/iwhCMnT/WH6g8A?=
 =?us-ascii?Q?sDbAEM1MXsbuZiHC4/xiQBloSYX5x3vP?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 14:26:44.8097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aff30be-a136-4ce2-2cc4-08dc9f59fe71
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5740

From: Ido Schimmel <idosch@nvidia.com>

Commit 31a0fa0019b0 ("thermal/debugfs: Pass cooling device state to
thermal_debug_cdev_add()") changed the thermal core to read the current
state of the cooling device as part of the cooling device's
registration. This is incompatible with the current implementation of
the cooling device operations in mlxsw, leading to initialization
failure with errors such as:

mlxsw_spectrum 0000:01:00.0: Failed to register cooling device
mlxsw_spectrum 0000:01:00.0: cannot register bus device

The reason for the failure is that when the get current state operation
is invoked the driver tries to derive the index of the cooling device by
walking a per thermal zone array and looking for the matching cooling
device pointer. However, the pointer is returned from the registration
function and therefore only set in the array after the registration.

The issue was later fixed by commit 1af89dedc8a5 ("thermal: core: Do not
fail cdev registration because of invalid initial state") by not failing
the registration of the cooling device if it cannot report a valid
current state during registration, although drivers are responsible for
ensuring that this will not happen.

Therefore, make sure the driver is able to report a valid current state
for the cooling device during registration by passing to the
registration function a per cooling device private data that already has
the cooling device index populated.

While at it, call thermal_cooling_device_unregister() unconditionally
since the function returns immediately if the cooling device pointer is
NULL.

Cc: linux-pm@vger.kernel.org
Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---

Notes:
    v2:
    - call thermal_cooling_device_unregister() unconditionally and mention
      it in the commit message

 .../ethernet/mellanox/mlxsw/core_thermal.c    | 51 +++++++++----------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
index 5c511e1a8efa..d61478c0c632 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
@@ -100,6 +100,12 @@ static const struct mlxsw_cooling_states default_cooling_states[] = {
 
 struct mlxsw_thermal;
 
+struct mlxsw_thermal_cooling_device {
+	struct mlxsw_thermal *thermal;
+	struct thermal_cooling_device *cdev;
+	unsigned int idx;
+};
+
 struct mlxsw_thermal_module {
 	struct mlxsw_thermal *parent;
 	struct thermal_zone_device *tzdev;
@@ -123,7 +129,7 @@ struct mlxsw_thermal {
 	const struct mlxsw_bus_info *bus_info;
 	struct thermal_zone_device *tzdev;
 	int polling_delay;
-	struct thermal_cooling_device *cdevs[MLXSW_MFCR_PWMS_MAX];
+	struct mlxsw_thermal_cooling_device cdevs[MLXSW_MFCR_PWMS_MAX];
 	struct thermal_trip trips[MLXSW_THERMAL_NUM_TRIPS];
 	struct mlxsw_cooling_states cooling_states[MLXSW_THERMAL_NUM_TRIPS];
 	struct mlxsw_thermal_area line_cards[];
@@ -147,7 +153,7 @@ static int mlxsw_get_cooling_device_idx(struct mlxsw_thermal *thermal,
 	int i;
 
 	for (i = 0; i < MLXSW_MFCR_PWMS_MAX; i++)
-		if (thermal->cdevs[i] == cdev)
+		if (thermal->cdevs[i].cdev == cdev)
 			return i;
 
 	/* Allow mlxsw thermal zone binding to an external cooling device */
@@ -352,17 +358,14 @@ static int mlxsw_thermal_get_cur_state(struct thermal_cooling_device *cdev,
 				       unsigned long *p_state)
 
 {
-	struct mlxsw_thermal *thermal = cdev->devdata;
+	struct mlxsw_thermal_cooling_device *mlxsw_cdev = cdev->devdata;
+	struct mlxsw_thermal *thermal = mlxsw_cdev->thermal;
 	struct device *dev = thermal->bus_info->dev;
 	char mfsc_pl[MLXSW_REG_MFSC_LEN];
-	int err, idx;
 	u8 duty;
+	int err;
 
-	idx = mlxsw_get_cooling_device_idx(thermal, cdev);
-	if (idx < 0)
-		return idx;
-
-	mlxsw_reg_mfsc_pack(mfsc_pl, idx, 0);
+	mlxsw_reg_mfsc_pack(mfsc_pl, mlxsw_cdev->idx, 0);
 	err = mlxsw_reg_query(thermal->core, MLXSW_REG(mfsc), mfsc_pl);
 	if (err) {
 		dev_err(dev, "Failed to query PWM duty\n");
@@ -378,22 +381,19 @@ static int mlxsw_thermal_set_cur_state(struct thermal_cooling_device *cdev,
 				       unsigned long state)
 
 {
-	struct mlxsw_thermal *thermal = cdev->devdata;
+	struct mlxsw_thermal_cooling_device *mlxsw_cdev = cdev->devdata;
+	struct mlxsw_thermal *thermal = mlxsw_cdev->thermal;
 	struct device *dev = thermal->bus_info->dev;
 	char mfsc_pl[MLXSW_REG_MFSC_LEN];
-	int idx;
 	int err;
 
 	if (state > MLXSW_THERMAL_MAX_STATE)
 		return -EINVAL;
 
-	idx = mlxsw_get_cooling_device_idx(thermal, cdev);
-	if (idx < 0)
-		return idx;
-
 	/* Normalize the state to the valid speed range. */
 	state = max_t(unsigned long, MLXSW_THERMAL_MIN_STATE, state);
-	mlxsw_reg_mfsc_pack(mfsc_pl, idx, mlxsw_state_to_duty(state));
+	mlxsw_reg_mfsc_pack(mfsc_pl, mlxsw_cdev->idx,
+			    mlxsw_state_to_duty(state));
 	err = mlxsw_reg_write(thermal->core, MLXSW_REG(mfsc), mfsc_pl);
 	if (err) {
 		dev_err(dev, "Failed to write PWM duty\n");
@@ -753,17 +753,21 @@ int mlxsw_thermal_init(struct mlxsw_core *core,
 	}
 	for (i = 0; i < MLXSW_MFCR_PWMS_MAX; i++) {
 		if (pwm_active & BIT(i)) {
+			struct mlxsw_thermal_cooling_device *mlxsw_cdev;
 			struct thermal_cooling_device *cdev;
 
+			mlxsw_cdev = &thermal->cdevs[i];
+			mlxsw_cdev->thermal = thermal;
+			mlxsw_cdev->idx = i;
 			cdev = thermal_cooling_device_register("mlxsw_fan",
-							       thermal,
+							       mlxsw_cdev,
 							       &mlxsw_cooling_ops);
 			if (IS_ERR(cdev)) {
 				err = PTR_ERR(cdev);
 				dev_err(dev, "Failed to register cooling device\n");
 				goto err_thermal_cooling_device_register;
 			}
-			thermal->cdevs[i] = cdev;
+			mlxsw_cdev->cdev = cdev;
 		}
 	}
 
@@ -824,8 +828,7 @@ int mlxsw_thermal_init(struct mlxsw_core *core,
 err_thermal_zone_device_register:
 err_thermal_cooling_device_register:
 	for (i = 0; i < MLXSW_MFCR_PWMS_MAX; i++)
-		if (thermal->cdevs[i])
-			thermal_cooling_device_unregister(thermal->cdevs[i]);
+		thermal_cooling_device_unregister(thermal->cdevs[i].cdev);
 err_reg_write:
 err_reg_query:
 	kfree(thermal);
@@ -847,12 +850,8 @@ void mlxsw_thermal_fini(struct mlxsw_thermal *thermal)
 		thermal->tzdev = NULL;
 	}
 
-	for (i = 0; i < MLXSW_MFCR_PWMS_MAX; i++) {
-		if (thermal->cdevs[i]) {
-			thermal_cooling_device_unregister(thermal->cdevs[i]);
-			thermal->cdevs[i] = NULL;
-		}
-	}
+	for (i = 0; i < MLXSW_MFCR_PWMS_MAX; i++)
+		thermal_cooling_device_unregister(thermal->cdevs[i].cdev);
 
 	kfree(thermal);
 }
-- 
2.45.0


