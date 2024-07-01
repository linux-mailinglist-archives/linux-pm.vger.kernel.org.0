Return-Path: <linux-pm+bounces-10292-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE5891E5B2
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 18:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B109282A47
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 16:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B6816D317;
	Mon,  1 Jul 2024 16:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZQwC2GbM"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A469A15E5DC;
	Mon,  1 Jul 2024 16:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852316; cv=fail; b=r3bn4zSskUPeJ9zFmythmOdgwqeSL4WGCMACcVQuqDckZhiUN+ZvBwRrAXMKVy0156h6svsdgRw+jeT6feFDfTSGIm2PW8UpOPV2cY6t7A/iFFdwdE1Xs2j4Z3qrH7ghN79oglQQ6D9obYFBuUXjBMHrfyZ68+zy07YE7p3bLJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852316; c=relaxed/simple;
	bh=tj58yF/2LpM1HE/VBc2eWfBajYjZgS4NRvMeEbdE4rU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hgvSQVIKzs5W1eGQ2MHPU8W+AcvyaMBRYvKxRSJAqs49lLxcsHRPrpK/VT7vykMwtT3iEBk93wk8Fz7hmJMUwYEVsLk7CRgZamO/Q3gqr5xtek2rnM3WsgAzxT4cLE6ssnLCb8zqkOM75ynX4/Sjzmf/5cGn4sPWV1LZS6Osr3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZQwC2GbM; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RaR2Auq58gdtkmFgMeXeE4QF32vycTKWWfDGBYF6JaTTzQ7+Geba+86mxtewOCO5ekNPNYVajq49zFpbQT3c6PqBkUcyiCa54ePDvDcrskMx/U4a4casT8hJf/KfWXThTXx7mzT1xyiI7tJb9EZQzx+hnUnAxbXakmDKwwhkiOGzEKkIbwwPy516u+WS6LxZg17HdkCRhJr4EvRr3xQh5NTUQVQL/ivzXbJFnXQ5Qw7OR31UU2bZAeuM1/CsOJDFe+geAmOO7DAJXpxSuGB6XyK1O73yEOQYvwRlpwx+SGKV/M0TZoBMR58P5SbeCuvOzsWgjJsr4juf3SRRCFqxrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0W7JYo54X9Q+ghfo2YMnKLL0AGli19skzkWZatda2hI=;
 b=Cwfe16EEWeMCIjx3kjU4pjHchHOJxhqj8be9kglS05i1B+YWL2/dRhMGwJINdoHBKGsI8TQ8G/cvSrAgjsxTbbz50W/x2JsR3vr3C4Sp6up4WBBfsTji90shEp9X8AyP77N9drYC+0gdf9CmgPXwmN/ONvID8VkIVom8a1V3l0gkK1c6gdWGTR2mmQ2/14jH1EdEXAjHhvIC8cm6UC9nq5eflxCy7x1eq1vEp0eoM5Lhj1rrfeqVwmy7v76EA0QEpZe7KES1rA/IvytLJG58WHHPx4AISmf9C6aKybTv73QnHB4hsFt0IDgW97CJkFYWWrW7RrhnL8BBDyFfg5K2HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0W7JYo54X9Q+ghfo2YMnKLL0AGli19skzkWZatda2hI=;
 b=ZQwC2GbMFW6a4P7FVDRiAuX8PNaDWd7fMoAnELQviL1LoUggM3nd/StmJIti6kyNZg+sfZCO2KszzVb26EKv3LIKTZJEPBp2D/f4cT1iNRV8qPl97qLUwv8X4XTkZDU94vaSAss4ckXTqSfo596PY58ZT7HkNJJudO0lfI7PSwyAes6lT49oLLKE4/LiyU44r2VYH8zBO8f/YPmkiccn5wjcraZ1Bn4wiivHCvAN4mujPkXIK/bbiRFY5lDyyRRfuHH4fVpsPVlssNnF9yqNBpz4SaKLkQillrYK+6f/kuzuz+4GWBMF3RJdcXNoDBdgggZChPvfKT2lV1qpFplbMw==
Received: from SN6PR08CA0032.namprd08.prod.outlook.com (2603:10b6:805:66::45)
 by SA1PR12MB6677.namprd12.prod.outlook.com (2603:10b6:806:250::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Mon, 1 Jul
 2024 16:45:08 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:805:66:cafe::8f) by SN6PR08CA0032.outlook.office365.com
 (2603:10b6:805:66::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33 via Frontend
 Transport; Mon, 1 Jul 2024 16:45:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.18 via Frontend Transport; Mon, 1 Jul 2024 16:45:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 1 Jul 2024
 09:44:44 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 1 Jul 2024
 09:44:39 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Petr Machata <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
	<mlxsw@nvidia.com>, <linux-pm@vger.kernel.org>, Vadim Pasternak
	<vadimp@nvidia.com>
Subject: [PATCH net-next 2/3] mlxsw: core_thermal: Report valid current state during cooling device registration
Date: Mon, 1 Jul 2024 18:41:54 +0200
Message-ID: <a9b97ecf80c722b42eceac1800f78ba57027af48.1719849427.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1719849427.git.petrm@nvidia.com>
References: <cover.1719849427.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|SA1PR12MB6677:EE_
X-MS-Office365-Filtering-Correlation-Id: ffd63175-27dc-4a72-80d0-08dc99ed2a71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pQmINz+xlWQ/lRXteYpBUmz6nhfk3TZnCLUHDe0YVBdPYQCDgcDLLsxoXB6v?=
 =?us-ascii?Q?lUU1kiHWs3lqk0hcXdMFglu7vhGlu04LaFvIKQoVeplqls/MaKy1m9OWJNC7?=
 =?us-ascii?Q?C79mYWIS0Ofu1QKJkWNCP9fjb9dNbH/iOy3EjUko6hnqO9n93TL/YCfrAJfC?=
 =?us-ascii?Q?Bl9Uf092f/3jUXUdUsgcSo0zFL/AhWgIeLrWQC6gPZ6tCnUfJ7AWJShuuPVd?=
 =?us-ascii?Q?CEpTES0Ff5tJMOX/v+9TMZSRmr1f3c/rzDUXsHq88dxIlw6TydauV7k7rENY?=
 =?us-ascii?Q?TwU6w46jcGXySxhoXcAbMni6HoEa26S2zYXWw93x3Fe8Z7RdirrIzQjDMdm0?=
 =?us-ascii?Q?0tqqP4updvwHzRNhABKbGfLkKVJuuYV+cH7gmN81SMRozkwKXgxGRs2mQx0u?=
 =?us-ascii?Q?J208I1USFIDMG079kflatNtzRbJOiNobnk0eGyp0svpfPgQyahgfFTlilxPc?=
 =?us-ascii?Q?J8PLthBBij1GXDVesU/PyWegB+ZSJMf2brl+yk6tTUKL9A74cFA+AxAYqeTm?=
 =?us-ascii?Q?i8XTLZHYfktr1FP8OueTvrj9vpBn5UU04928YJ+GNZ8bi2ELXB0ncWNKHeBt?=
 =?us-ascii?Q?AxhT2Any23P3xX0N76n0Po4Csikrv+05nDMTgXnWM394p+8zPEPfxLKmpWop?=
 =?us-ascii?Q?1JMewRzar9E1BnVzVNQoz7lSCV2P+PbEatFkksaQT/0pKxGkQitJ0KykoAhK?=
 =?us-ascii?Q?ajGsYM95TdTcapBqVH/twi1MA/JqGkO4JWNzbD4CT88KgVIOLGquo6WZORL1?=
 =?us-ascii?Q?dBr8hmbYhIMNjv8zIKQy6jvQwGjITXBI842tai8Eb8kFmhjV+OOh6+sSMxKr?=
 =?us-ascii?Q?hHTJuIwg28maouUh4+vGs0o1rhTq1VauwSsbWLCFLOFtRKNyIOurTQSsjnCf?=
 =?us-ascii?Q?WpMMLGTcQk+0CFWMYDiiaNhwC2HIjpSRdGNMAmbUgW71bEFpQKH9ITpytXmv?=
 =?us-ascii?Q?9Iya8PLx1NXTx64hR+nSd+MhFtChJY+sr261gYH3tDABcHFFGYLdMS3MR11A?=
 =?us-ascii?Q?AJvVLaX+IG4L1+lhYMZMTcvexbSFg6vVp03A3HNs+lTUjXr+kjP3aFocRIJv?=
 =?us-ascii?Q?RIrkcNXaekQQliWmY3LVu4spwfsRLPDWnxNtzlUVHMLbCxscSzKQB6S0raUF?=
 =?us-ascii?Q?CK6xM23V0Z6iYPUmW1TIPH5IOMgOQ1N+U5uyASqXsRtTB+UziXGWCtP7EPmt?=
 =?us-ascii?Q?UBmi9b1zoBkMvcS7TEc3Gw8SI44XoqDEOALCMDj0h3NcEqv8KDALrAXkKowt?=
 =?us-ascii?Q?dS3Vfxi9Tf+XQ/78Bopzj1Cw95yIInDWP0EUq3XkX4rB04X6A9vuTS4Icgtx?=
 =?us-ascii?Q?luhmbPG5Fb8rBolQFHvU2FdaRP/ItvRQshftwlpl+cAwbugsIoljWdpykAwm?=
 =?us-ascii?Q?glL/A1gW29auQlDsNR2kB02FZXdc1rSpT3XMZvS42W1JupJv7VN1o7a/dPVo?=
 =?us-ascii?Q?xNEeQF54k6mkwhdd20DYvXRFoakXHuXg?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 16:45:07.6585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd63175-27dc-4a72-80d0-08dc99ed2a71
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6677

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

Cc: linux-pm@vger.kernel.org
Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../ethernet/mellanox/mlxsw/core_thermal.c    | 50 ++++++++++---------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
index 5c511e1a8efa..eee3e37983ca 100644
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
 
@@ -824,8 +828,8 @@ int mlxsw_thermal_init(struct mlxsw_core *core,
 err_thermal_zone_device_register:
 err_thermal_cooling_device_register:
 	for (i = 0; i < MLXSW_MFCR_PWMS_MAX; i++)
-		if (thermal->cdevs[i])
-			thermal_cooling_device_unregister(thermal->cdevs[i]);
+		if (thermal->cdevs[i].cdev)
+			thermal_cooling_device_unregister(thermal->cdevs[i].cdev);
 err_reg_write:
 err_reg_query:
 	kfree(thermal);
@@ -848,10 +852,8 @@ void mlxsw_thermal_fini(struct mlxsw_thermal *thermal)
 	}
 
 	for (i = 0; i < MLXSW_MFCR_PWMS_MAX; i++) {
-		if (thermal->cdevs[i]) {
-			thermal_cooling_device_unregister(thermal->cdevs[i]);
-			thermal->cdevs[i] = NULL;
-		}
+		if (thermal->cdevs[i].cdev)
+			thermal_cooling_device_unregister(thermal->cdevs[i].cdev);
 	}
 
 	kfree(thermal);
-- 
2.45.0


