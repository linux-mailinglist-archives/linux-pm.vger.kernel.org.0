Return-Path: <linux-pm+bounces-38553-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A220C84A1B
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 12:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ED7D134AA54
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 11:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D5F3101C9;
	Tue, 25 Nov 2025 11:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dHYp2lEF"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B5526C3B0;
	Tue, 25 Nov 2025 11:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764068816; cv=none; b=dN8QJ4AIKG7TPZNtagoDw9OkmYcDex8QLmAEernqj23vP8OqGfuGCa4QNOATMGO79U39WltbMasmb/vdDJRWq7w334zMFmuuM4+N3hEtzOIl+SmVvb0jZAmPhnhGpMfJ3vGAjoNmwommIyOE2ho2okVBIkBSNv8BUb8xTQtrWE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764068816; c=relaxed/simple;
	bh=zitmyeJM/e+uubNBjBrLCDFGnrlsT/zseaM6ZX7jwWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ktSiqPNWTRgMkrnb6otgwxy7fdezLrrdAh8GEqHk3nlPB3JqGQdidefYxqTe/MwIy2XWfALnhrBP0ZO4rkZ5H9ioz5dg/S1S2euEH4ZlBbA6gQdRiADlA0eNi+9PrB3ULrKhG7SBxTH55IsqiDG+fiHyhjlf8qjwy4lnfAKqTk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dHYp2lEF; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1764068812;
	bh=zitmyeJM/e+uubNBjBrLCDFGnrlsT/zseaM6ZX7jwWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dHYp2lEFQ5qHF5N/dLWxalTJzB09Ety5wgNNxpS9maSF9lQvM+c2xkcVaTyIu4ia3
	 4HPsAcnG8U8Fin/Pjy3ZMkwV+vAqthuFUSVgBkbP3kzETPcjMeB4IT1MnZTd7qkJ/j
	 OvUduGcYE8+wxIH1qj8Of/A9K4dY0z3WtCu7FhvUh5UA74vz5wNtVhfu+Jo4jNwMoc
	 yj/Ru2pWaMijAMO2IrGcPj3po2kes4MsZqSAcUvP2ewWRkRrVOPvHm/QbrPIiqo6g2
	 GsunTuZgxaujnYTcRS4COnW/YT1dTvxHqxD/lErpiv148z9HMPm1wBx4aXHgdzPR5A
	 /nrr+ClQbOcVA==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:657b:ae76:a0f8:4811])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9136517E12E2;
	Tue, 25 Nov 2025 12:06:50 +0100 (CET)
From: Laura Nao <laura.nao@collabora.com>
To: daniel.lezcano@linaro.org
Cc: andrew-ct.chen@mediatek.com,
	angelogioacchino.delregno@collabora.com,
	arnd@arndb.de,
	bchihi@baylibre.com,
	colin.i.king@gmail.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	frank-w@public-files.de,
	fshao@chromium.org,
	kernel@collabora.com,
	krzk+dt@kernel.org,
	lala.lin@mediatek.com,
	laura.nao@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	matthias.bgg@gmail.com,
	nfraprado@collabora.com,
	rafael@kernel.org,
	robh@kernel.org,
	rui.zhang@intel.com,
	srini@kernel.org,
	u.kleine-koenig@baylibre.com,
	wenst@chromium.org
Subject: Re: [PATCH v4 2/9] thermal/drivers/mediatek/lvts: Make number of calibration offsets configurable
Date: Tue, 25 Nov 2025 12:06:39 +0100
Message-Id: <20251125110639.23257-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <24a5bd31-a79f-4f18-a190-6a4d886a29b2@linaro.org>
References: <24a5bd31-a79f-4f18-a190-6a4d886a29b2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 11/24/25 19:25, Daniel Lezcano wrote:
> On 11/21/25 12:16, Laura Nao wrote:
>> MT8196/MT6991 use 2-byte eFuse calibration data, whereas other SoCs
>> supported by the driver rely on 3 bytes. Make the number of calibration
>> bytes per sensor configurable, enabling support for SoCs with varying
>> calibration formats.
>>
>> Reviewed-by: Fei Shao <fshao@chromium.org>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Tested-by: Frank Wunderlich <frank-w@public-files.de>
>> Signed-off-by: Laura Nao <laura.nao@collabora.com>
>> ---
>>   drivers/thermal/mediatek/lvts_thermal.c | 32 ++++++++++++++++++++++----------
>>   1 file changed, 22 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
>> index ab55b20cda47..1c54d0b75b1a 100644
>> --- a/drivers/thermal/mediatek/lvts_thermal.c
>> +++ b/drivers/thermal/mediatek/lvts_thermal.c
>> @@ -96,12 +96,14 @@
>>     #define LVTS_MINIMUM_THRESHOLD        20000
>>   +#define LVTS_MAX_CAL_OFFSETS        3 
>
> I suggest LVTS_NUM_CAL_OFFSETS then below,
>

Right - as this is SoC-specific, I can define:

#define LVTS_NUM_CAL_OFFSETS_MT7988	3
#define LVTS_NUM_CAL_OFFSETS_MT8196	2

>> +
>>   static int golden_temp = LVTS_GOLDEN_TEMP_DEFAULT;
>>   static int golden_temp_offset;
>>     struct lvts_sensor_data {
>>       int dt_id;
>> -    u8 cal_offsets[3];
>> +    u8 cal_offsets[LVTS_MAX_CAL_OFFSETS];
>>   };
>>     struct lvts_ctrl_data {
>> @@ -127,6 +129,7 @@ struct lvts_data {
>>       const struct lvts_ctrl_data *lvts_ctrl;
>>       const u32 *conn_cmd;
>>       const u32 *init_cmd;
>> +    int num_cal_offsets;
>>       int num_lvts_ctrl;
>>       int num_conn_cmd;
>>       int num_init_cmd;
>> @@ -711,7 +714,7 @@ static int lvts_calibration_init(struct device *dev, struct lvts_ctrl *lvts_ctrl
>>                       u8 *efuse_calibration,
>>                       size_t calib_len)
>>   {
>> -    int i;
>> +    int i, j;
>>       u32 gt;
>>         /* A zero value for gt means that device has invalid efuse data */
>> @@ -720,17 +723,18 @@ static int lvts_calibration_init(struct device *dev, struct lvts_ctrl *lvts_ctrl
>>       lvts_for_each_valid_sensor(i, lvts_ctrl_data) {
>>           const struct lvts_sensor_data *sensor =
>>                       &lvts_ctrl_data->lvts_sensor[i];
>> +        u32 calib = 0;
>>   -        if (sensor->cal_offsets[0] >= calib_len ||
>> -            sensor->cal_offsets[1] >= calib_len ||
>> -            sensor->cal_offsets[2] >= calib_len)
>> -            return -EINVAL;
>> +        for (j = 0; j < lvts_ctrl->lvts_data->num_cal_offsets; j++) {
>> +            u8 offset = sensor->cal_offsets[j];
>> +
>> +            if (offset >= calib_len)
>> +                return -EINVAL;
>> +            calib |= efuse_calibration[offset] << (8 * j); 
>
> May be worth for a comment here, ideally a separate function to clarify the code
>

Ack - will do.

>> +        }
>>             if (gt) {
>> -            lvts_ctrl->calibration[i] =
>> -                (efuse_calibration[sensor->cal_offsets[0]] << 0) +
>> -                (efuse_calibration[sensor->cal_offsets[1]] << 8) +
>> -                (efuse_calibration[sensor->cal_offsets[2]] << 16);
>> +            lvts_ctrl->calibration[i] = calib;
>>           } else if (lvts_ctrl->lvts_data->def_calibration) {
>>               lvts_ctrl->calibration[i] = lvts_ctrl->lvts_data->def_calibration;
>>           } else {
>> @@ -1763,6 +1767,7 @@ static const struct lvts_data mt7988_lvts_ap_data = {
>>       .temp_factor    = LVTS_COEFF_A_MT7988,
>>       .temp_offset    = LVTS_COEFF_B_MT7988,
>>       .gt_calib_bit_offset = 24,
>> +    .num_cal_offsets = 3, 
>
> LVTS_NUM_CAL_OFFSETS
>
>

I'll submit a v5 with the required changes.

Thanks!

Laura

