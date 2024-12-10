Return-Path: <linux-pm+bounces-18878-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 548709EA45B
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 02:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FDF4162C57
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 01:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F24170816;
	Tue, 10 Dec 2024 01:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgkwfL3P"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF52770E2;
	Tue, 10 Dec 2024 01:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733794229; cv=none; b=gfLJbx0Bk0gr4CbdifWM1XlTGL47aBS+F0XQTpL48QerdmOk5HMO+zyXzGc+3MBZLac+IRZVpjFHBPbOKKjemb2MzsGq9OX4/TU6mxdjouQ8jGwTvxBc+B2Khe0ttVZVbmRYGLxH/3eI51wX0KOLgSUtlxcuzcVLRiPzvkmNhH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733794229; c=relaxed/simple;
	bh=mR5adaxqGtsuJQzKNCMllgT2TTCrBqKnWNwUktkOtYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KqFBDRHsjQUTWX0RG4C07nyH/81dKzcTcQojYXvk4CBm8Iazj6Wj811VfjWUNWgm6CyPA1xr05uznJ2s5hLjClLWS6yguEq564pObmENmNhwRYuR14ZX0enDP/iS3fFKzvI6BCVuzDNdHydDbT+ivCwFLh01yk3ui8CpthYfYx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgkwfL3P; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6d8918ec243so50940106d6.1;
        Mon, 09 Dec 2024 17:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733794226; x=1734399026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sUmnsMlb6+J2z+CZq/V8Utz5Q8oJwF2bHLJE2t/SHA=;
        b=JgkwfL3PWX8v2dawK+h5TB03tIR6KpvPTGVGhGaca5HXaNUupFESTGqOPlr+GL/+7a
         knOdKIjGLVIrPfiiJCJSkH8/+xtlLdZK9KbPUNUyHMIOcsVIkCic/jAD7pHzD13jx9Cc
         VyXh+3ZYDpnq982o3pP0K6F3cmYE9dCplVnDJ0IwvXts1tSL74i5jSL7SgipGxNff8f8
         I/rvbcTyaeUKXhVVpO9zo4osy+S87weHP2e4ig3M2W1r1KSoJm5JE8v+ZJlce7fgGhZZ
         GHK68wTzfMiapjXKNYU6Y8hROY/kyf45jZ7IUXeleE/WldFVLvQ0k1bQyq3WEPhjbO5W
         XujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733794226; x=1734399026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5sUmnsMlb6+J2z+CZq/V8Utz5Q8oJwF2bHLJE2t/SHA=;
        b=S7LPWA/m+iXDiTY7YXRWaq1aeabemwwYDMfZm6+Ix1YhpymLbBsaQMd14DQU/5jAL9
         rmUBiaDSsyIWU24wFX5vopBSK49IBhjhQI8OjV9TqmllKj0mA8xxOc9qc8Nc14kPz+LP
         KJr+LOaLEe03CAcRbvTY3rwmUu9E2s8M7vBqzSx2b5icuO9xsvy5iqpHL7cTloVkeJd4
         HKxamYSijm5FWF/2nS17NGmqLRchQApcOD8FlKHpCxiezdVbNPY65VSZwwkyBdD7z63l
         uVfsoGawOGS5NLcssxpett1VlmPYUgD7oB+eH6mHsWItnGXx4ZHXvjh6DTykJ4aTlhaw
         cZIw==
X-Forwarded-Encrypted: i=1; AJvYcCUP30o37UxObnZ67CgPkzTp/M0XnGmuJBHSmnwrq3Vxkr6s0XzKjZaPTKli3C8WXfjXO990J2SLwni9K8Y=@vger.kernel.org, AJvYcCVXhQyu4eBvxOqkdGnpcWurDk17GQDqrdblhCBQjCup4hSs7ApR1F/UyJv4nYE4M96VbuMTrkdCScQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmFg65HtlBKs9abgZxXlqvBDn65tFI5YgTjlxLIrUmh2o2jFJM
	OsYURo2KNBCHG/GW+U148wLA626vv4ms/cT0A3nAk5Xet7aHBPSK
X-Gm-Gg: ASbGncv6cBFm6aVXl0n97uFtQYiBAje8+hnOqz8uBw8RIQyJkTLv7nmyfdm36/cW7zo
	OZyFOBqsT+Bz1i7fql11UQ/SeWsDklQJchT3xfXV1nKIt2zgNOnOS3PFQ2EhcYvLwBA113bI96z
	GLtv1E92fYVO6BFTcgBqgO5wtus5b0WqBzR0tDZosLhnL+phK7xyD/AgefVWsuxOERPXr4+Kz6p
	zXOB//gWgFtRtQf7ZsTXZ+2YxngEuiAi3eQSUjfujABYuf/KrYpSFu3sqIVDfC+dA==
X-Google-Smtp-Source: AGHT+IE1D13JutVol/zUpThGrVNHALTvBXJmh1Qc3SYE16zwA1SMBc6vR4AEEi2kPGJtGcjxoFLleg==
X-Received: by 2002:a05:6214:23c6:b0:6d8:960e:5785 with SMTP id 6a1803df08f44-6d91e314427mr51513186d6.13.1733794226579;
        Mon, 09 Dec 2024 17:30:26 -0800 (PST)
Received: from master-x64.sparksnet ([204.111.53.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8f429a79csm36834346d6.72.2024.12.09.17.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 17:30:26 -0800 (PST)
From: Peter Geis <pgwipeout@gmail.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Peter Geis <pgwipeout@gmail.com>,
	Caesar Wang <wxt@rock-chips.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Finley Xiao <finley.xiao@rock-chips.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Kevin Hilman <khilman@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH 1/6] pmdomain: rockchip: fix rockchip_pd_power error handling
Date: Tue, 10 Dec 2024 01:30:05 +0000
Message-Id: <20241210013010.81257-2-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210013010.81257-1-pgwipeout@gmail.com>
References: <20241210013010.81257-1-pgwipeout@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The calls rockchip_pd_power makes to rockchip_pmu_set_idle_request lack
any return error handling, causing device drivers to incorrectly believe
the hardware idle requests succeed when they may have failed. This leads
to software possibly accessing hardware that is powered off and the
subsequent SError panic that follows.

Add error checking and return errors to the calling function to prevent
such crashes.

gst-launch-1.0 videotestsrc num-buffers=2000 ! v4l2jpegenc ! fakesink
Setting pipeline to PAUSED ...er-x64
Pipeline is PREROLLING ...
Redistribute latency...
rockchip-pm-domain ff100000.syscon:power-controller: failed to get ack on
domain 'hevc', val=0x98260, idle = 0
SError Interrupt on CPU2, code 0x00000000bf000002 -- SError
CPU: 2 UID: 0 PID: 804 Comm: videotestsrc0:s Not tainted 6.12.0-rc5+ #54
Hardware name: Firefly roc-rk3328-cc (DT)
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : rockchip_vpu2_jpeg_enc_run+0x168/0xbc8
lr : device_run+0xb0/0x128
sp : ffff800082143a20
x29: ffff800082143a20 x28: 0000000000000140 x27: 0000000000000000
x26: ffff582c47a313e8 x25: ffff582c53e95000 x24: ffff582c53e92800
x23: ffff582c5bbe0000 x22: 0000000000000000 x21: ffff582c47a31080
x20: ffffa0d78cfa4168 x19: ffffa0d78cfa4168 x18: ffffb755b0519000
x17: 000000040044ffff x16: 00500072b5503510 x15: a7a6a5a4a3a29a99
x14: 989796959493928a x13: 0000000051eb851f x12: 00000000000000ff
x11: ffffa0d78d812880 x10: ffffa0d78d7fbca0 x9 : 000000000000003f
x8 : 0000000000000063 x7 : 000000000000003f x6 : 0000000000000040
x5 : ffff80008010d000 x4 : ffffa0d78cfa4168 x3 : ffffa0d78cfbfdd8
x2 : ffff80008010d0f4 x1 : 0000000000000020 x0 : 0000000000000140
Kernel panic - not syncing: Asynchronous SError Interrupt
CPU: 2 UID: 0 PID: 804 Comm: videotestsrc0:s Not tainted 6.12.0-rc5+ #54
Hardware name: Firefly roc-rk3328-cc (DT)
Call trace:
dump_backtrace+0xa0/0x128
show_stack+0x20/0x38
dump_stack_lvl+0xc8/0xf8
dump_stack+0x18/0x28
panic+0x3ec/0x428
nmi_panic+0x48/0xa0
arm64_serror_panic+0x6c/0x88
do_serror+0x30/0x70
el1h_64_error_handler+0x38/0x60
el1h_64_error+0x7c/0x80
rockchip_vpu2_jpeg_enc_run+0x168/0xbc8
device_run+0xb0/0x128
v4l2_m2m_try_run+0xac/0x230
v4l2_m2m_ioctl_streamon+0x70/0x90
v4l_streamon+0x2c/0x40
__video_do_ioctl+0x194/0x400
video_usercopy+0x10c/0x808
video_ioctl2+0x20/0x80
v4l2_ioctl+0x48/0x70
__arm64_sys_ioctl+0xb0/0x100
invoke_syscall+0x50/0x120
el0_svc_common.constprop.0+0x48/0xf0
do_el0_svc+0x24/0x38
el0_svc+0x38/0x100
el0t_64_sync_handler+0xc0/0xc8
el0t_64_sync+0x1a8/0x1b0
SMP: stopping secondary CPUs
Kernel Offset: 0x20d70c000000 from 0xffff800080000000
PHYS_OFFSET: 0xffffa7d3c0000000
CPU features: 0x00,00000090,00200000,0200421b
Memory Limit: none
---[ end Kernel panic - not syncing: Asynchronous SError Interrupt ]---

Fixes: 7c696693a4f5 ("soc: rockchip: power-domain: Add power domain driver")
Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---

 drivers/pmdomain/rockchip/pm-domains.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index cb0f93800138..57e8fa25d2bd 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -590,14 +590,18 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
 			rockchip_pmu_save_qos(pd);
 
 			/* if powering down, idle request to NIU first */
-			rockchip_pmu_set_idle_request(pd, true);
+			ret = rockchip_pmu_set_idle_request(pd, true);
+			if (ret < 0)
+				return ret;
 		}
 
 		rockchip_do_pmu_set_power_domain(pd, power_on);
 
 		if (power_on) {
 			/* if powering up, leave idle mode */
-			rockchip_pmu_set_idle_request(pd, false);
+			ret = rockchip_pmu_set_idle_request(pd, false);
+			if (ret < 0)
+				return ret;
 
 			rockchip_pmu_restore_qos(pd);
 		}
-- 
2.39.5


