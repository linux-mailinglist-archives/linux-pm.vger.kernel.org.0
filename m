Return-Path: <linux-pm+bounces-17502-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDFD9C781B
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 17:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BDF4B34C9A
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 15:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D48116DEB4;
	Wed, 13 Nov 2024 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I/9IjzET"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDB51632CF
	for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2024 15:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731512924; cv=none; b=rGFbxHs+tcZnvjOuNbjStjATgD5ANzx9g+aVzvuOEifxGgUEBMXNOpkjiZEJcxjAT3hbTRIr5l4ikU7XS9JC3Z8VFzUPD5rst6KWyaxZ4INbRMMKmtPRMvUQo8vQZBHA3+0WkuVtV4O2i0+SxdXQJ2QWHqmp2BXYIKFnOz2/lrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731512924; c=relaxed/simple;
	bh=41pV7VncXoUSjJZEldcTv760siIrrc74sU051Klt3mA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E9ZDq9cH1oiTIWAN0bLL1pIPdaxMAwmnpctcJDlei0m+Ba0F5zUyNXA6ez7Lx6u5cDo+NEK7OCBI0uf3NWu3uTVn+gHC3DY3KHpmoPEA8jwSF6N7sjJAW9H17tfNRV2WFFbWFZ5voUuZjiJkuO6DjCup0oPX5XZebVkGJR+9cpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I/9IjzET; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53da2140769so831770e87.3
        for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2024 07:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731512921; x=1732117721; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j3dh+RRnrXxpNt67AmWfO1pJdHXzaJZVVjbZ4bYTSvE=;
        b=I/9IjzET7Zt8dWUVL0xUGM7PF4bEs/eojWW2Q6XsUdFWxxbkvjIcZnk8ORlmxTEbzl
         hEUnqpmyQUHorVhV0/tx+QqVM1Ah62pwpSPPBHLRTl8Lrv7t/bQme4tNcgQLfm4cKYtZ
         1ptFaKzoinPucJqh9sejKpc8LId49u0TmrdoshY4VrIbDfKtlID7aPUBs3SpxlxS9bjd
         yTI1+lGzUa/Gtl9Nvlc8W2VUdgq6uiPSWqq99Z2axzQr5N1iuVVhgAQqVa+C4D3BgbjG
         /gHeA3PQMieo5sipvSat68idI33Fz0xODpWMLMYYR5O293xvJHUeVaQKuU58D8Bb4i2d
         865g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731512921; x=1732117721;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3dh+RRnrXxpNt67AmWfO1pJdHXzaJZVVjbZ4bYTSvE=;
        b=hL4o3irlKgLFRwZ9HFAXUCp3FmnZyA4278PryvRIRTpxyLoba2JSlm9xa+7y3AMy5R
         hpeCsGFpxWbTRL0X9RK60xX1QMduSVPgvMqbOYVjhNa0NhBQBefcu/PCeNndjrBYyEJR
         rjhBHFlRf9LA3YLxDbnSYlLDgHjyZs/OsXUsy/JEO00c7vh11mFTtwTM4RylzIfVjlrO
         Yotz2W8p/f71aE5UWtE67HZJZP8MER6hExO6HBpaeUS6RGsUX2/OAn0yFnIFNwQT7G/z
         /p/dEF7Oc1q5Yef68gChDuzIWc6N7d2bX9bNBarbuzERTeE4PK8q7UD2W73cf4R7CIhC
         ve9A==
X-Forwarded-Encrypted: i=1; AJvYcCWqfZlaUg1j/DK1xd84yYHGWwNGaXbh+N9+lCWG8fBdg8nczPaHToWMBTlUw2camNxS8rWMSCRjyg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbBQA34TYW2yKXnV6S6V1NlI4yWw/hQi3M8xVqKiX0cQJeuc89
	s1JwBcPvfG9lajGKWt4RWvDSYAP0FO2Vf4KUo21G05Wg0DXIAEMVCyuVpOjRH1w=
X-Google-Smtp-Source: AGHT+IFUI2P/RTpwjlxKEXcTmZbFs5YTWCAwQQFsVAGl1KHVLVhThqfiSlbL2cx9fRoVgKbrbjsvSA==
X-Received: by 2002:a05:6512:159b:b0:53d:a23d:37e6 with SMTP id 2adb3069b0e04-53da23d3963mr1255108e87.57.1731512920671;
        Wed, 13 Nov 2024 07:48:40 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d54f772asm28445345e9.18.2024.11.13.07.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 07:48:40 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 13 Nov 2024 16:48:29 +0100
Subject: [PATCH RFC 3/8] drm/msm: adreno: add plumbing to generate
 bandwidth vote table for GMU
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-topic-sm8x50-gpu-bw-vote-v1-3-3b8d39737a9b@linaro.org>
References: <20241113-topic-sm8x50-gpu-bw-vote-v1-0-3b8d39737a9b@linaro.org>
In-Reply-To: <20241113-topic-sm8x50-gpu-bw-vote-v1-0-3b8d39737a9b@linaro.org>
To: Akhil P Oommen <quic_akhilpo@quicinc.com>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Connor Abbott <cwabbott0@gmail.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8316;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=41pV7VncXoUSjJZEldcTv760siIrrc74sU051Klt3mA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnNMpRcWrYtzO1iYz1ZpMIIQSbIKY4y5MHVyzXS+1g
 US+0VaiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZzTKUQAKCRB33NvayMhJ0V0pD/
 0d5W6NcfH7ua6tXai7exd9EcsYbiMKWp/mmNVsj4PilWm/GqLlTW2kjVhm5Z04dK0Aa2hsB+AcDuW5
 mLHeUFkrtuRH9i8I9qdA69PT9mv0n2ZDsp49L3sAYW8pPGCvaFtcD71ijkNO2Kyb21CZ54n3/b3zt8
 iSdK9SpRsduWL8U8YAlFr8wOrgHMHZdq94VN+k9XU31SWTT4qMYZleQ7z0thwRrldE0ZxybwjIiu/R
 zRF+SjGUZ7KmZHuXds2OMGUKrK/EP5jZTFyWC0XXkVxaDJhNmPE/PME/CA2Ripkr3tG9KKMQJVLGxH
 nTXqvNdTmOqV4nGrSlWl4ZoE03rB7PI18nv2XA2wcZRV4TrIFeO/9O8ZGYGLroiYlpzsd6bcgSNOtS
 uVGfmYkn7wldonIYwNM4B09T9ebZM7RhE0r+arVuGUtN632mevjZwYNjki7X2Npp273/ieWOtHEZys
 qi1hrrce5KsI0jbCxDQYNI8Sre8GAgNBLzVFBHiQQa6MiekgqOGP/gKiWtThgv1Y3Ks4dZb/W/Tn+I
 jc3zDdQDQeYwZQjQBc5BGpz0mghZyR/OntqCmPUdEvPQSdLj8cXJvQ+kCK3fGQqrSrTUqNku/IWiL/
 +1T2aGAlypmUoGfVu6TuS3WZIN6r42EtIT3yDKOEPfx5XfGDsmcnzzNmJcHA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The Adreno GMU Management Unit (GMU) can also scale DDR Bandwidth along
the Frequency and Power Domain level, but by default we leave the
OPP core scale the interconnect ddr path.

In order to get the vote values to be used by the GPU Management
Unit (GMU), we need to parse all the possible OPP Bandwidths and
create a vote value to be send to the appropriate Bus Control
Modules (BCMs) declared in the GPU info struct.

The vote array will be used to dynamically generate the GMU bw_table
sent during the GMU power-up.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 163 ++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h |  12 +++
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h |   1 +
 3 files changed, 176 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 14db7376c712d19446b38152e480bd5a1e0a5198..504a7c5d5a9df4c787951f2ae3a69d566d205ad5 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -9,6 +9,7 @@
 #include <linux/pm_domain.h>
 #include <linux/pm_opp.h>
 #include <soc/qcom/cmd-db.h>
+#include <soc/qcom/tcs.h>
 #include <drm/drm_gem.h>
 
 #include "a6xx_gpu.h"
@@ -1287,6 +1288,119 @@ static int a6xx_gmu_memory_probe(struct a6xx_gmu *gmu)
 	return 0;
 }
 
+struct a6xx_bcm_data {
+	u32 buswidth;
+	unsigned int unit;
+	unsigned int width;
+	unsigned int vcd;
+	bool fixed;
+	unsigned int perfmode;
+	unsigned int perfmode_bw;
+};
+
+struct bcm_db {
+	__le32 unit;
+	__le16 width;
+	u8 vcd;
+	u8 reserved;
+};
+
+static int a6xx_gmu_rpmh_get_bcm_data(const struct a6xx_bcm *bcm,
+				      struct a6xx_bcm_data *bcm_data)
+{
+	const struct bcm_db *data;
+	size_t count;
+
+	data = cmd_db_read_aux_data(bcm->name, &count);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	if (!count)
+		return -EINVAL;
+
+	bcm_data->unit = le32_to_cpu(data->unit);
+	bcm_data->width = le16_to_cpu(data->width);
+	bcm_data->vcd = data->vcd;
+	bcm_data->fixed = bcm->fixed;
+	bcm_data->perfmode = bcm->perfmode;
+	bcm_data->perfmode_bw = bcm->perfmode_bw;
+	bcm_data->buswidth = bcm->buswidth;
+
+	return 0;
+}
+
+static void a6xx_gmu_rpmh_calc_bw_vote(struct a6xx_bcm_data *bcms,
+				       int count, u32 bw, u32 *data)
+{
+	int i;
+
+	for (i = 0; i < count; i++) {
+		bool valid = true;
+		bool commit = false;
+		u64 peak, y;
+
+		if (i == count - 1 || bcms[i].vcd != bcms[i + 1].vcd)
+			commit = true;
+
+		if (bcms[i].fixed) {
+			if (!bw)
+				data[i] = BCM_TCS_CMD(commit, false, 0x0, 0x0);
+			else
+				data[i] = BCM_TCS_CMD(commit, true, 0x0,
+					bw >= bcms[i].perfmode_bw ?
+						bcms[i].perfmode : 0x0);
+			continue;
+		}
+
+		/* Multiple the bandwidth by the width of the connection */
+		peak = (u64)bw * bcms[i].width;
+		do_div(peak, bcms[i].buswidth);
+
+		/* Input bandwidth value is in KBps */
+		y = peak * 1000ULL;
+		do_div(y, bcms[i].unit);
+
+		/*
+		 * If a bandwidth value was specified but the calculation ends
+		 * rounding down to zero, set a minimum level
+		 */
+		if (bw && y == 0)
+			y = 1;
+
+		y = min_t(u64, y, BCM_TCS_CMD_VOTE_MASK);
+		if (!y)
+			valid = false;
+
+		data[i] = BCM_TCS_CMD(commit, valid, y, y);
+	}
+}
+
+static int a6xx_gmu_rpmh_bw_votes_init(const struct a6xx_info *info, struct a6xx_gmu *gmu)
+{
+	struct a6xx_bcm_data bcms[3];
+	unsigned int bcm_count = 0;
+	int ret, index;
+
+	/* Retrieve BCM data from cmd-db and merge with a6xx_info bcm table */
+	for (index = 0; index < 3; index++) {
+		if (!info->bcm[index].name)
+			continue;
+
+		ret = a6xx_gmu_rpmh_get_bcm_data(&info->bcm[index], &bcms[index]);
+		if (ret)
+			return ret;
+
+		++bcm_count;
+	}
+
+	/* Generate BCM votes values for each bandwidth & bcm */
+	for (index = 0; index < gmu->nr_gpu_bws; index++)
+		a6xx_gmu_rpmh_calc_bw_vote(bcms, bcm_count, gmu->gpu_bw_table[index],
+					   gmu->gpu_bw_votes[index]);
+
+	return 0;
+}
+
 /* Return the 'arc-level' for the given frequency */
 static unsigned int a6xx_gmu_get_arc_level(struct device *dev,
 					   unsigned long freq)
@@ -1390,12 +1504,15 @@ static int a6xx_gmu_rpmh_arc_votes_init(struct device *dev, u32 *votes,
  * The GMU votes with the RPMh for itself and on behalf of the GPU but we need
  * to construct the list of votes on the CPU and send it over. Query the RPMh
  * voltage levels and build the votes
+ * The GMU can also vote for DDR interconnects, use the OPP bandwidth entries
+ * and BCM parameters to build the votes.
  */
 
 static int a6xx_gmu_rpmh_votes_init(struct a6xx_gmu *gmu)
 {
 	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
 	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
+	const struct a6xx_info *info = adreno_gpu->info->a6xx;
 	struct msm_gpu *gpu = &adreno_gpu->base;
 	int ret;
 
@@ -1407,6 +1524,10 @@ static int a6xx_gmu_rpmh_votes_init(struct a6xx_gmu *gmu)
 	ret |= a6xx_gmu_rpmh_arc_votes_init(gmu->dev, gmu->cx_arc_votes,
 		gmu->gmu_freqs, gmu->nr_gmu_freqs, "cx.lvl");
 
+	/* Build the interconnect votes */
+	if (adreno_gpu->info->quirks & ADRENO_QUIRK_GMU_BW_VOTE)
+		ret |= a6xx_gmu_rpmh_bw_votes_init(info, gmu);
+
 	return ret;
 }
 
@@ -1442,6 +1563,38 @@ static int a6xx_gmu_build_freq_table(struct device *dev, unsigned long *freqs,
 	return index;
 }
 
+static int a6xx_gmu_build_bw_table(struct device *dev, unsigned long *bandwidths,
+		u32 size)
+{
+	int count = dev_pm_opp_get_opp_count(dev);
+	struct dev_pm_opp *opp;
+	int i, index = 0;
+	unsigned int bandwidth = 1;
+
+	/*
+	 * The OPP table doesn't contain the "off" bandwidth level so we need to
+	 * add 1 to the table size to account for it
+	 */
+
+	if (WARN(count + 1 > size,
+		"The GMU bandwidth table is being truncated\n"))
+		count = size - 1;
+
+	/* Set the "off" bandwidth */
+	bandwidths[index++] = 0;
+
+	for (i = 0; i < count; i++) {
+		opp = dev_pm_opp_find_bw_ceil(dev, &bandwidth, 0);
+		if (IS_ERR(opp))
+			break;
+
+		dev_pm_opp_put(opp);
+		bandwidths[index++] = bandwidth++;
+	}
+
+	return index;
+}
+
 static int a6xx_gmu_pwrlevels_probe(struct a6xx_gmu *gmu)
 {
 	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
@@ -1472,6 +1625,16 @@ static int a6xx_gmu_pwrlevels_probe(struct a6xx_gmu *gmu)
 
 	gmu->current_perf_index = gmu->nr_gpu_freqs - 1;
 
+	/*
+	 * The GMU also handles GPU Interconnect Votes so build a list
+	 * of DDR bandwidths from the GPU OPP table
+	 */
+	if (adreno_gpu->info->quirks & ADRENO_QUIRK_GMU_BW_VOTE)
+		gmu->nr_gpu_bws = a6xx_gmu_build_bw_table(&gpu->pdev->dev,
+			gmu->gpu_bw_table, ARRAY_SIZE(gmu->gpu_bw_table));
+
+	gmu->current_perf_index = gmu->nr_gpu_freqs - 1;
+
 	/* Build the list of RPMh votes that we'll send to the GMU */
 	return a6xx_gmu_rpmh_votes_init(gmu);
 }
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
index b4a79f88ccf45cfe651c86d2a9da39541c5772b3..95c632d8987a517f067c48c61c6c06b9a4f61fc0 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
@@ -19,6 +19,14 @@ struct a6xx_gmu_bo {
 	u64 iova;
 };
 
+struct a6xx_bcm {
+	char *name;
+	unsigned int buswidth;
+	bool fixed;
+	unsigned int perfmode;
+	unsigned int perfmode_bw;
+};
+
 /*
  * These define the different GMU wake up options - these define how both the
  * CPU and the GMU bring up the hardware
@@ -82,6 +90,10 @@ struct a6xx_gmu {
 	unsigned long gpu_freqs[16];
 	u32 gx_arc_votes[16];
 
+	int nr_gpu_bws;
+	unsigned long gpu_bw_table[16];
+	u32 gpu_bw_votes[16][3];
+
 	int nr_gmu_freqs;
 	unsigned long gmu_freqs[4];
 	u32 cx_arc_votes[4];
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 4aceffb6aae89c781facc2a6e4a82b20b341b6cb..d779d700120cbd974ee87a67214739b1d85156e2 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -44,6 +44,7 @@ struct a6xx_info {
 	u32 gmu_chipid;
 	u32 gmu_cgc_mode;
 	u32 prim_fifo_threshold;
+	const struct a6xx_bcm bcm[3];
 };
 
 struct a6xx_gpu {

-- 
2.34.1


