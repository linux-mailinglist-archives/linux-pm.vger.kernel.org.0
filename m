Return-Path: <linux-pm+bounces-10653-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C99ED928289
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 09:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80148282F61
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 07:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49A4144D00;
	Fri,  5 Jul 2024 07:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HcHFJx+7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D75B143C60
	for <linux-pm@vger.kernel.org>; Fri,  5 Jul 2024 07:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720163598; cv=none; b=nxN8cJuQb2CyuOi6cI3QVFY8sbIyQtrnLySyn9CpKqYhAfJdTAiyXrNtr/A6AFQWiY53dLzEGHKQZb980taKi6+s9fftAiuXeMMsmqdtIFuQoTKjtMAqw/flM1CPhLTuX8E4KQT6S3FPntHLO6k/NbP1IFxAUYMAUbsgkIpNspA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720163598; c=relaxed/simple;
	bh=X/Mwd6JBppsFn3Eh7Grst8vmhx2p+RhNWFlbhobvoB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWjqbYudU/MjLbye1WOIRJs963gAKrGZhJYp5/6MFiYPaL8WjQuSsWv+rvcleVTMEr5wEMEy8VrW24wrU+5NsEKtFFYfIrE6PA58FQGg7JvpZD2fUK7wYiNbzhY2ZqcyJbNpcGeikNMRtxMnAl31A+z5OzAkPLDhK+ih292OzNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HcHFJx+7; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7594c490b04so896365a12.3
        for <linux-pm@vger.kernel.org>; Fri, 05 Jul 2024 00:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720163596; x=1720768396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9UlaHnzPtyEXqtP36rKl0mEwZt/UtIO8cSjkseqQwhQ=;
        b=HcHFJx+7MSH2LVuJ4H88zTyH9Nr+NsXEE3smfTMbshxZvt7mNtSXXFzrioS0VDoSBt
         HmQ6Dmg4PTmgAxBO4eIy1hsKBsnPzDSffAe8pISLs/XxVOSZ+E3Hb5ZfhauRq7s+mpWK
         BItjlx134OzrL+UHY+K7ZSe5ZN2NfwMoam0hgejFpeaIY2woq4YU1Kf2/HHg3exbqzAZ
         /f5dhQuFHvMSRQ2wdg+AXk9UE9TnDJrQz/vNCksBH3MI+/spapI5vKe3jMHD2v6T6/yS
         2fxL6Metla5txCVKE3nu3Z8PmACn4ceLbaFNFCsUrKHWo9qhKHzm3pSBIrlX5kG2hinS
         fNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720163596; x=1720768396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UlaHnzPtyEXqtP36rKl0mEwZt/UtIO8cSjkseqQwhQ=;
        b=FPFXXcZmP8j2lrbr32kFTmmvABm50qjTK1aTpYMLjhOgjhznnn+ocx/84BgcXCO8BI
         v1M3Bc+74HVX73KyE9q8VZwWE4vcs9FTJIAdwoU96EOL6vwBlGcZBfOtFajwiKuiaMuU
         85x2IA2hYRhColRfR2ynYHkup0gIOga3eIlc5Lf/+TAH9mVqd9lvw7sWubTZC/1klL/8
         30fLhYPJtpo5Zqcjn7YXJi7cnpgguDPSChNocGR/PqsIjyyxTL/QSF2ULweuC/G4qH+3
         j28GsPSWRjzMjCopWfpF0GttAPdk7bOsRV3sTfH8v+CttsmEjQplRtEd4gCSGfNgsFZ2
         /riQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB3MaIRsGJKBcI2vcXahQtE9JYFgUiHvSP1XfQfKAS73iQqj4WMohaGfeShLA2essIVt/NENinaB9BU7/dAEVdTqxc35+DcfI=
X-Gm-Message-State: AOJu0YxJmNsaVljcAfFIgY0QeVzpbhxMsz/YEy8y0uQcAVAZ1BgwnIS1
	vBSddwbD1r2GElUOMkURwPFZIdMJcK9s6lVuaTdDJHtJqaTFTeYsqqYkjXTY8+4=
X-Google-Smtp-Source: AGHT+IH5aHOz4Xz8XpU3ZE30THlQncCFemTEtB6ZUBhrg25o2ezqr59OIP8uJxCM2R3MBsXUj7mCMg==
X-Received: by 2002:a17:90a:bb0d:b0:2c9:69ce:cd5a with SMTP id 98e67ed59e1d1-2c99c53bcf2mr2675740a91.17.1720163596332;
        Fri, 05 Jul 2024 00:13:16 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a970ce6sm2730567a91.18.2024.07.05.00.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 00:13:15 -0700 (PDT)
Date: Fri, 5 Jul 2024 12:43:13 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: Re: [PATCH V3 2/2] cpufreq: Add Loongson-3 CPUFreq driver support
Message-ID: <20240705071313.ddl6geg72t4n7j3s@vireshk-i7>
References: <20240705060650.243497-1-chenhuacai@loongson.cn>
 <20240705060650.243497-3-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705060650.243497-3-chenhuacai@loongson.cn>

On 05-07-24, 14:06, Huacai Chen wrote:
> Some of LoongArch processors (Loongson-3 series) support DVFS, their
> IOCSR.FEATURES has IOCSRF_FREQSCALE set. And they has a micro-core in
> the package called SMC (System Management Controller), which can be
> used to detect temperature, control fans, scale frequency and voltage,
> etc.
> 
> The Loongson-3 CPUFreq driver is very simple now, it communicate with
> SMC, get DVFS info, set target frequency from CPUFreq core, and so on.
> 
> There is a command list to interact with SMC, widely-used commands in
> the CPUFreq driver include:
> 
> CMD_GET_VERSION: Get SMC firmware version.
> 
> CMD_GET_FEATURE: Get enabled SMC features.
> 
> CMD_SET_FEATURE: Enable SMC features, such as basic DVFS, BOOST.
> 
> CMD_GET_FREQ_LEVEL_NUM: Get the number of all frequency levels.
> 
> CMD_GET_FREQ_BOOST_LEVEL: Get the first boost frequency level.
> 
> CMD_GET_FREQ_LEVEL_INFO: Get the detail info of a frequency level.
> 
> CMD_GET_FREQ_INFO: Get the current frequency.
> 
> CMD_SET_FREQ_INFO: Set the target frequency.
> 
> In future we will add automatic frequency scaling, which is similar to
> Intel's HWP (HardWare P-State).
> 
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  MAINTAINERS                         |   1 +
>  drivers/cpufreq/Kconfig             |  12 +
>  drivers/cpufreq/Makefile            |   1 +
>  drivers/cpufreq/loongson3_cpufreq.c | 395 ++++++++++++++++++++++++++++
>  4 files changed, 409 insertions(+)
>  create mode 100644 drivers/cpufreq/loongson3_cpufreq.c

I have made some changes while applying, can you please test these ?

diff --git a/drivers/cpufreq/loongson3_cpufreq.c b/drivers/cpufreq/loongson3_cpufreq.c
index a530e4a56b78..cd3efdeeddd9 100644
--- a/drivers/cpufreq/loongson3_cpufreq.c
+++ b/drivers/cpufreq/loongson3_cpufreq.c
@@ -31,10 +31,10 @@ union smc_message {
 };
 
 /* Command return values */
-#define CMD_OK				0  /* No error */
-#define CMD_ERROR			1  /* Regular error */
-#define CMD_NOCMD			2  /* Command does not support */
-#define CMD_INVAL			3  /* Invalid Parameter */
+#define CMD_OK				0 /* No error */
+#define CMD_ERROR			1 /* Regular error */
+#define CMD_NOCMD			2 /* Command does not support */
+#define CMD_INVAL			3 /* Invalid Parameter */
 
 /* Version commands */
 /*
@@ -173,7 +173,8 @@ static struct mutex cpufreq_mutex[MAX_PACKAGES];
 static struct cpufreq_driver loongson3_cpufreq_driver;
 static DEFINE_PER_CPU(struct loongson3_freq_data *, freq_data);
 
-static inline int do_service_request(u32 id, u32 info, u32 cmd, u32 val, u32 extra)
+static inline int
+do_service_request(u32 id, u32 info, u32 cmd, u32 val, u32 extra)
 {
 	int retries;
 	unsigned int cpu = smp_processor_id();
@@ -226,11 +227,13 @@ static unsigned int loongson3_cpufreq_get(unsigned int cpu)
 	return ret * KILO;
 }
 
-static int loongson3_cpufreq_target(struct cpufreq_policy *policy, unsigned int index)
+static int
+loongson3_cpufreq_target(struct cpufreq_policy *policy, unsigned int index)
 {
 	int ret;
 
-	ret = do_service_request(cpu_data[policy->cpu].core, FREQ_INFO_TYPE_LEVEL, CMD_SET_FREQ_INFO, index, 0);
+	ret = do_service_request(cpu_data[policy->cpu].core,
+			FREQ_INFO_TYPE_LEVEL, CMD_SET_FREQ_INFO, index, 0);
 
 	return (ret >= 0) ? 0 : ret;
 }
@@ -255,14 +258,16 @@ static int configure_freq_table(int cpu)
 	boost_level = ret;
 
 	freq_level = min(max_level, FREQ_MAX_LEVEL);
-	data = devm_kzalloc(&pdev->dev, struct_size(data, table, freq_level + 1), GFP_KERNEL);
+	data = devm_kzalloc(&pdev->dev, struct_size(data, table, freq_level + 1),
+			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
 	data->def_freq_level = boost_level - 1;
 
 	for (i = 0; i < freq_level; i++) {
-		ret = do_service_request(cpu, FREQ_INFO_TYPE_FREQ, CMD_GET_FREQ_LEVEL_INFO, i, 0);
+		ret = do_service_request(cpu, FREQ_INFO_TYPE_FREQ,
+					 CMD_GET_FREQ_LEVEL_INFO, i, 0);
 		if (ret < 0) {
 			devm_kfree(&pdev->dev, data);
 			return ret;
@@ -290,6 +295,7 @@ static int loongson3_cpufreq_cpu_init(struct cpufreq_policy *policy)
 
 	policy->cpuinfo.transition_latency = 10000;
 	policy->freq_table = per_cpu(freq_data, cpu)->table;
+
 	policy->suspend_freq = policy->freq_table[per_cpu(freq_data, cpu)->def_freq_level].frequency;
 	cpumask_copy(policy->cpus, topology_sibling_cpumask(cpu));
 
@@ -314,7 +320,8 @@ static int loongson3_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 {
 	int cpu = policy->cpu;
 
-	loongson3_cpufreq_target(policy, per_cpu(freq_data, cpu)->def_freq_level);
+	loongson3_cpufreq_target(policy, per_cpu(freq_data,
+				 cpu)->def_freq_level);
 
 	return 0;
 }
@@ -348,13 +355,14 @@ static int loongson3_cpufreq_probe(struct platform_device *pdev)
 	int i, ret;
 
 	for (i = 0; i < MAX_PACKAGES; i++)
-		mutex_init(&cpufreq_mutex[i]);
+		devm_mutex_init(&pdev->dev, &cpufreq_mutex[i]);
 
 	ret = do_service_request(0, 0, CMD_GET_VERSION, 0, 0);
 	if (ret <= 0)
 		return -EPERM;
 
-	ret =  do_service_request(FEATURE_DVFS, 0, CMD_SET_FEATURE, FEATURE_DVFS_ENABLE | FEATURE_DVFS_BOOST, 0);
+	ret = do_service_request(FEATURE_DVFS, 0, CMD_SET_FEATURE,
+				 FEATURE_DVFS_ENABLE | FEATURE_DVFS_BOOST, 0);
 	if (ret < 0)
 		return -EPERM;
 

-- 
viresh

