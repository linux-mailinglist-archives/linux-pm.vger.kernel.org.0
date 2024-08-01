Return-Path: <linux-pm+bounces-11813-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B24CE945107
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 18:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9AA4B24CF4
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 16:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910621B9B41;
	Thu,  1 Aug 2024 16:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="MLnbitOs"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588F91B9B40
	for <linux-pm@vger.kernel.org>; Thu,  1 Aug 2024 16:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722530521; cv=none; b=WorokvyuHuKADWK8ivqLXuN6STnPG97ucOBhv7u6FLMLTcs6lDks1W0kokeIWU8t91wThU/MbEoJ9tPPx9KAAf+rEZnVbjK71ZQNP+a2dpD46AbGc27O+iP3v1K8uoxOWdg+ezKtJ8pvu6tnVZiij05Q10Jq0vSo8ohE0zlEhRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722530521; c=relaxed/simple;
	bh=48L8m1/nqyrVllZo1zjaeI5/Whv8Q8kyuwKNl/y5GOY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QMPp/U6fMrnCbyOo5Vzn2Gx9seGCjbzmflsNejPJ6iOqRzFB2kv6/4lkXwDCvZfDYEpwMqOh787wRtU1wKBYdg8vZXim9CAaWCeDjTFYlcdstBx4++KqIp0JMKFAN7BMDMiYOxLDaPPG24/7h/ClldPgXyqvc3eowplimYVbz9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=MLnbitOs; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 94A213FE08
	for <linux-pm@vger.kernel.org>; Thu,  1 Aug 2024 16:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1722530517;
	bh=oH2IxwwaeB32KbPmmlJ7oQ67OtriazyI1RrphFPcsu4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type;
	b=MLnbitOsnDZ0GLCnZjmRHFq2kyvOYurg4hNtGpoN4Mo29hKPg7MD4k99DSL/sGErG
	 qOjtVq9J8yzRuLZRe78Unouq3xfuFOaCOBlNnLHNnRmZDg6yLn6M1xZzmzv7TvAIcr
	 oX4n1bk/Oc0AglKaqy+I4fP7Ds5z/ECQ5apeL/wW7aKCHqli+BWNksrrUieKZqQR9d
	 kYpNAjACdsEDknSMSsYtedtJXr8Up2lqNTyBoD3o8D2KJRjw6wqU0TWJ9hkrpY2iD3
	 VTt4V0FQ/vJ3XIMLT9XVSccFtbhbhYOk2kRw/kc8QuKgdiTkZSzt0f7rMRrPSsr8Ok
	 TEDb9Ga0HB6zQ==
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-7a242496838so5752021a12.3
        for <linux-pm@vger.kernel.org>; Thu, 01 Aug 2024 09:41:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722530516; x=1723135316;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oH2IxwwaeB32KbPmmlJ7oQ67OtriazyI1RrphFPcsu4=;
        b=CFnl7PQZAUizwMVhG4JI2OG03e0CMqmZODedvaRlXxIPV/s7df6GjDlD7eFbL/tZ6Z
         HSCF9kTuf25y09Wb7GcpOdmzQJUjkFrQwoWcrJslYHfWmPsdnZr3BqDeazsw7jL2Jw7i
         rlZutNspbxxjWwbnCDGkMGgV3onJACHGzrRRoDaei79W2gIXWpCdgiosSoID7eLpFd9L
         xl+jnO+PDKWeFgmaXesZ0dn54cuWDK2IrAVb+udrqO0HZRzZWkGq6wdp9oCps9BEZK5M
         nL1IDtblQnRkm+pQtciPfsYfyoYzXNn+7UBkK9Fd3XFyDjLG5jInFyHhVv27jrDfBEeh
         SS9A==
X-Gm-Message-State: AOJu0Yw58m1JKzyI2VPgmd8Zv5V1sGc6DAwN+E2l+MT6pfJhKjU1AGh1
	6uADSjyqdDfH7AlKugPgkEk67snPq6e29uAaPkt71ASiPBiT8tg1WYhdhZ1BaVy4mMd8LHUdz2e
	K/JjVp0y5I3RUbGaqWE8yP5HvmQUqyK90PgiL8IdwTIIn5//RRQz962Hr5f49O93X4eZgWK73
X-Received: by 2002:a17:90b:4b92:b0:2c9:6cf4:8453 with SMTP id 98e67ed59e1d1-2cff952d016mr973452a91.31.1722530515935;
        Thu, 01 Aug 2024 09:41:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+pG8FFdEdd9i0NyZFDUieVjshTw4yaNRddKN9NBT0wOc4Cc19sa0uEU6/WASWF9LAztSMcQ==
X-Received: by 2002:a17:90b:4b92:b0:2c9:6cf4:8453 with SMTP id 98e67ed59e1d1-2cff952d016mr973418a91.31.1722530515347;
        Thu, 01 Aug 2024 09:41:55 -0700 (PDT)
Received: from capivara ([186.250.11.100])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cffb0c681esm145461a91.25.2024.08.01.09.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 09:41:55 -0700 (PDT)
Date: Thu, 1 Aug 2024 13:41:50 -0300
From: Pedro Henrique Kopper <pedro.kopper@canonical.com>
To: rafael@kernel.org, lenb@kernel.org, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com, pedro.kopper@canonical.com
Subject: [PATCH] cpufreq: intel_pstate: Update Balance performance EPP for
 Emerald Rapids
Message-ID: <Zqu6zjVMoiXwROBI@capivara>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Intel Emerald Rapids machines, we ship the Energy Performance Preference
(EPP) default for balance_performance as 128. However, during an internal
investigation together with Intel, we have determined that 32 is a more
suitable value. This leads to significant improvements in both performance
and energy:

POV-Ray: 32% faster | 12% less energy
OpenSSL: 12% faster | energy within 1%
Build Linux Kernel: 29% faster | 18% less energy

Therefore, we should move the default EPP for balance_performance to 32.
This is in line with what has already been done for Sapphire Rapids.

Signed-off-by: Pedro Henrique Kopper <pedro.kopper@canonical.com>
---
 drivers/cpufreq/intel_pstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 392a8000b238..c0278d023cfc 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -3405,6 +3405,7 @@ static const struct x86_cpu_id intel_epp_default[] = {
 	 */
 	X86_MATCH_VFM(INTEL_ALDERLAKE_L, HWP_SET_DEF_BALANCE_PERF_EPP(102)),
 	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X, HWP_SET_DEF_BALANCE_PERF_EPP(32)),
+	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X, HWP_SET_DEF_BALANCE_PERF_EPP(32)),
 	X86_MATCH_VFM(INTEL_METEORLAKE_L, HWP_SET_EPP_VALUES(HWP_EPP_POWERSAVE,
 		      179, 64, 16)),
 	X86_MATCH_VFM(INTEL_ARROWLAKE, HWP_SET_EPP_VALUES(HWP_EPP_POWERSAVE,
-- 
2.43.0


