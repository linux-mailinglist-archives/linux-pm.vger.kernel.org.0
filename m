Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2C61BB485
	for <lists+linux-pm@lfdr.de>; Tue, 28 Apr 2020 05:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgD1D1v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Apr 2020 23:27:51 -0400
Received: from mx1.riseup.net ([198.252.153.129]:48912 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbgD1D1v (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Apr 2020 23:27:51 -0400
Received: from bell.riseup.net (unknown [10.0.1.178])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 49B6Xk5sdXzFcxH;
        Mon, 27 Apr 2020 20:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1588044470; bh=fyUj+NdMXFbPK+znZDmYjsevx14GaZlzNI5x1mEyTMk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R0UJBEHEzcOV37W9NEj/eu/VeNbgoDZGPx8HabVbjiiNUpq1XPuWu2BGLPm8E61L8
         IzEfJa+2bPuZqwR/BBvM2YeifezguQEKmbj6HUHw0BK0dwacaxs2woQQj5Ta2KaPdh
         NPZstrEpAdDnUxUdLJFAFB3nRwQGfhG8KMJYYbj0=
X-Riseup-User-ID: 4352315D553855E8DA00A4C141746641FBDF3A8945C526146A0F7AC13450415C
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by bell.riseup.net (Postfix) with ESMTPSA id 49B6Xk3fkqzJqbv;
        Mon, 27 Apr 2020 20:27:50 -0700 (PDT)
From:   Francisco Jerez <currojerez@riseup.net>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Pandruvada\, Srinivas" <srinivas.pandruvada@intel.com>
Cc:     linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        chris.p.wilson@intel.com,
        "Vivi\, Rodrigo" <rodrigo.vivi@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCHv2.99 03/11] OPTIONAL: drm/i915: Expose PM QoS control parameters via debugfs.
Date:   Mon, 27 Apr 2020 20:22:50 -0700
Message-Id: <20200428032258.2518-4-currojerez@riseup.net>
In-Reply-To: <20200428032258.2518-1-currojerez@riseup.net>
References: <20200428032258.2518-1-currojerez@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

v3: Rename CPU_RESPONSE_FREQUENCY to CPU_SCALING_RESPONSE (Rafael).

Signed-off-by: Francisco Jerez <currojerez@riseup.net>
---
 drivers/gpu/drm/i915/i915_debugfs.c | 69 +++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/gpu/drm/i915/i915_debugfs.c b/drivers/gpu/drm/i915/i915_debugfs.c
index aa35a59f1c7d..16a45fd2c376 100644
--- a/drivers/gpu/drm/i915/i915_debugfs.c
+++ b/drivers/gpu/drm/i915/i915_debugfs.c
@@ -1247,6 +1247,72 @@ static int i915_llc(struct seq_file *m, void *data)
 	return 0;
 }
 
+static int
+i915_sf_qos_delay_max_ns_set(void *data, u64 val)
+{
+	struct drm_i915_private *dev_priv = data;
+
+	WRITE_ONCE(dev_priv->gt.sf_qos.delay_max_ns, val);
+	return 0;
+}
+
+static int
+i915_sf_qos_delay_max_ns_get(void *data, u64 *val)
+{
+	struct drm_i915_private *dev_priv = data;
+
+	*val = READ_ONCE(dev_priv->gt.sf_qos.delay_max_ns);
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(i915_sf_qos_delay_max_ns_fops,
+			i915_sf_qos_delay_max_ns_get,
+			i915_sf_qos_delay_max_ns_set, "%llu\n");
+
+static int
+i915_sf_qos_delay_slope_shift_set(void *data, u64 val)
+{
+	struct drm_i915_private *dev_priv = data;
+
+	WRITE_ONCE(dev_priv->gt.sf_qos.delay_slope_shift, val);
+	return 0;
+}
+
+static int
+i915_sf_qos_delay_slope_shift_get(void *data, u64 *val)
+{
+	struct drm_i915_private *dev_priv = data;
+
+	*val = READ_ONCE(dev_priv->gt.sf_qos.delay_slope_shift);
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(i915_sf_qos_delay_slope_shift_fops,
+			i915_sf_qos_delay_slope_shift_get,
+			i915_sf_qos_delay_slope_shift_set, "%llu\n");
+
+static int
+i915_sf_qos_target_hz_set(void *data, u64 val)
+{
+	struct drm_i915_private *dev_priv = data;
+
+	WRITE_ONCE(dev_priv->gt.sf_qos.target_hz, val);
+	return 0;
+}
+
+static int
+i915_sf_qos_target_hz_get(void *data, u64 *val)
+{
+	struct drm_i915_private *dev_priv = data;
+
+	*val = READ_ONCE(dev_priv->gt.sf_qos.target_hz);
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(i915_sf_qos_target_hz_fops,
+			i915_sf_qos_target_hz_get,
+			i915_sf_qos_target_hz_set, "%llu\n");
+
 static int i915_runtime_pm_status(struct seq_file *m, void *unused)
 {
 	struct drm_i915_private *dev_priv = node_to_i915(m->private);
@@ -1882,6 +1948,9 @@ static const struct i915_debugfs_files {
 	{"i915_error_state", &i915_error_state_fops},
 	{"i915_gpu_info", &i915_gpu_info_fops},
 #endif
+	{"i915_sf_qos_delay_max_ns", &i915_sf_qos_delay_max_ns_fops},
+	{"i915_sf_qos_delay_slope_shift", &i915_sf_qos_delay_slope_shift_fops},
+	{"i915_sf_qos_target_hz", &i915_sf_qos_target_hz_fops}
 };
 
 void i915_debugfs_register(struct drm_i915_private *dev_priv)
-- 
2.22.1

