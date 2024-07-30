Return-Path: <linux-pm+bounces-11670-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0729413DD
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 16:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46A13B2A267
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 14:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8629A1991A7;
	Tue, 30 Jul 2024 14:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="odhbHGPF"
X-Original-To: linux-pm@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B32086AEE;
	Tue, 30 Jul 2024 14:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348140; cv=none; b=TX8IbbKZ8uhon7h0u5q+Wby5iVXrJB2QwYKZ9J0WvjliUP03XgRE8UIpEnHknR6cTT/gqukT0Ut0QEWu6AxrYoKH0HDbYuSpOf60ICXn1odv+60Atke47pn0HA7E+DOGAm+wxfHcgydDG/4cloV5jtw414pElUl/gPTzj9rADqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348140; c=relaxed/simple;
	bh=JeHHjTTrhzncXKROXXxu6GZ9w8Qy081BGJZghN6A06E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lHto3ociyZyCN4Z/eHewONsMxYqJ2HeiehreBnROYUtgcoIdf4kcdGWxeOcYrmvKwlazhKf75gTAmW8uy9cnqVAB/+rAfEYZtRJqQzsZokdbTaz8Lj1x2MJXLch5Cw/sqeHFBXEYO9taDr/GlMzsDLmwAvuGWFlCtEgFdmIh60k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=odhbHGPF; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=cmY5y
	oofgI2j6CWP6YdehrqQxWbgt9IrysbrOo2QtH8=; b=odhbHGPFmKOFgXU0kdyDt
	6hp/zCR9x2mrBgj55BQ80FymD0QXlBGsXhKhwnZ7y0mIjtvtVz3JvfxPcAREiq3a
	Xzy29QANx62exQXzarFW86f1tEQD1CxhI1wp5XFTTwOca/hxee0Dq2HlsmPbQ6Rg
	uUcn5fyxJgiCTd+e75AIKg=
Received: from localhost.localdomain (unknown [111.35.189.52])
	by gzga-smtp-mta-g1-1 (Coremail) with SMTP id _____wD3P0oo8qhm+JwKBw--.54824S4;
	Tue, 30 Jul 2024 22:01:16 +0800 (CST)
From: David Wang <00107082@163.com>
To: perry.yuan@amd.com
Cc: Alexander.Deucher@amd.com,
	Li.Meng@amd.com,
	Mario.Limonciello@amd.com,
	Xiaojian.Du@amd.com,
	Xinmei.Huang@amd.com,
	gautham.shenoy@amd.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com,
	viresh.kumar@linaro.org,
	00107082@163.com
Subject: [Regression] 6.11.0-rc1: AMD CPU boot with error when CPPC feature disabled by BIOS
Date: Tue, 30 Jul 2024 22:01:11 +0800
Message-Id: <20240730140111.4491-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P0oo8qhm+JwKBw--.54824S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFWUtFW7JrWUur4DJr43Jrb_yoW5AF1Dpa
	95Gr1xCF4DXw4vyanxAa12qryrG3srJrZ8Wry3tw1Yqa15uFyUWrWkGa4UWa4jkr1vg34I
	gF9xJFZYkws0yFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piJ3ktUUUUU=
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiqRAsqmVOB3UJJgAAsJ

Hi,

I notice some kernel warning and errors when I update to 6.11.0-rc1:

 kernel: [    1.022739] amd_pstate: The CPPC feature is supported but currently disabled by the BIOS.
 kernel: [    1.022739] Please enable it if your BIOS has the CPPC option.
 kernel: [    1.098054] amd_pstate: min_freq(0) or max_freq(0) or nominal_freq(0) value is incorrect
 kernel: [    1.110058] amd_pstate: min_freq(0) or max_freq(0) or nominal_freq(0) value is incorrect
 kernel: [    1.122057] amd_pstate: min_freq(0) or max_freq(0) or nominal_freq(0) value is incorrect
 kernel: [    1.134062] amd_pstate: min_freq(0) or max_freq(0) or nominal_freq(0) value is incorrect
 kernel: [    1.134641] amd_pstate: min_freq(0) or max_freq(0) or nominal_freq(0) value is incorrect
 kernel: [    1.135128] amd_pstate: min_freq(0) or max_freq(0) or nominal_freq(0) value is incorrect
 kernel: [    1.135693] amd_pstate: min_freq(0) or max_freq(0) or nominal_freq(0) value is incorrect
 kernel: [    1.136371] amd_pstate: min_freq(0) or max_freq(0) or nominal_freq(0) value is incorrect
 kernel: [    1.136390] amd_pstate: failed to register with return -19
 kernel: [    1.138410] ledtrig-cpu: registered to indicate activity on CPUs


Those warning message was introduced by commit:
 bff7d13c190ad98cf4f877189b022c75df4cb383 ("cpufreq: amd-pstate: add debug message while CPPC is supported and disabled by SBIOS)
, which make sense.

Those error message was introduced by commit:
 8f8b42c1fcc939a73b547b172a9ffcb65ef4bf47 ("cpufreq: amd-pstate: optimize the initial frequency values verification")
, when CPPC is disabled by BIOS, this error message does not make sense, and the error return-code would abort the driver registeration,
but this behavior could be handled earlier when detecting CPPC feature.

I feel following changes would make a clean fix: do not register amd_pstate driver when CPPC disabled by BIOS.

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 68c616b572f2..b06faea58fd4 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1837,8 +1837,6 @@ static bool amd_cppc_supported(void)
         * If the CPPC feature is disabled in the BIOS for processors that support MSR-based CPPC,
         * the AMD Pstate driver may not function correctly.
         * Check the CPPC flag and display a warning message if the platform supports CPPC.
-        * Note: below checking code will not abort the driver registeration process because of
-        * the code is added for debugging purposes.
         */
        if (!cpu_feature_enabled(X86_FEATURE_CPPC)) {
                if (cpu_feature_enabled(X86_FEATURE_ZEN1) || cpu_feature_enabled(X86_FEATURE_ZEN2)) {
@@ -1856,6 +1854,7 @@ static bool amd_cppc_supported(void)
        if (warn)
                pr_warn_once("The CPPC feature is supported but currently disabled by the BIOS.\n"
                                        "Please enable it if your BIOS has the CPPC option.\n");
+               return false;
        return true;
 }



Thanks
David


