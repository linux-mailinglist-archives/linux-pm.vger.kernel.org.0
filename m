Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B5D49F1CA
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jan 2022 04:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345745AbiA1DZb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jan 2022 22:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345737AbiA1DZb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jan 2022 22:25:31 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFCFC06173B
        for <linux-pm@vger.kernel.org>; Thu, 27 Jan 2022 19:25:30 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id p203so9879155oih.10
        for <linux-pm@vger.kernel.org>; Thu, 27 Jan 2022 19:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YR+p+rFyNameRdcM6O13QjKJ9vZV8WKjT+NcfVNIzDk=;
        b=TeqI3HUPV3Jl3BnoYjWy/fbTJvhxGGRTTGiICuAzEYvIfPk8e7AXDes8R48EU8Ery1
         8gkrIYYbq1v4Xt/YRrsU4hI2/y5OG0jnzvLJSCAHBQr7/cjWht8hi3VTCEKCJROa+1tR
         IFLgJR0DVK7Lo+iB/WGjayto6QpT8erB5l5iEVMx4DgzbhvKpgj2nUHeJnkmAahNeoy9
         d3NpulJs3HNTqLhDVxjNfHXX+vkzB0WcRS+XWkcRCrzlad74KgB/AF49aPlblhXl7R4j
         h6BpM1aeaPoH7Jqdcco9XmP/s6/ahjoBYbNSzMpTeO7+dCxvKsu55GWeOA9YGBAhC8wL
         1wyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YR+p+rFyNameRdcM6O13QjKJ9vZV8WKjT+NcfVNIzDk=;
        b=mWL392Kip+kZOPJtS2yti208vA80qg6u/9+Um2cdNO/M9pkVGFPNLWBFyQIOsbp71M
         VqEp9B5E3QCVXqZlmXmzzbL6wL4mTIFtGP6zksbDxpuDVYHyk5AKJcXwaChygoD8hB8E
         0kHiBdiFajlCuTPzZlY/TFPTHDrFd/k6fkKiuwkR6AOHRYxVSwoWJwmaLchXrcrtLV/0
         X3hD9UMPJeEUTTlXioVOqXkFSX3sk0/l9b4vM82Uns3u8W6O+FPh0SFPXIkIzmjVeEb+
         At3pCicsSGXBuDh9G7N3bYPciPJCx/gQhmyPPBm0eleUN/7VT+JwCUnhr3v9Ms3oI4n5
         oN4g==
X-Gm-Message-State: AOAM533xCTSYeiGtNc4dt1IcF0WTBIfFpiGb56n1xxzj4e4V2riEOSXC
        o2mEXAUdViunckjePB1mua44qw==
X-Google-Smtp-Source: ABdhPJwibfMcKHWbE2gHhsX0tTGrzHohSADwkFMnqvYTQ4+Rl2ElNEBOarunj7M+9mFH3Ot/8S/CbA==
X-Received: by 2002:a05:6808:14c9:: with SMTP id f9mr3027113oiw.251.1643340330235;
        Thu, 27 Jan 2022 19:25:30 -0800 (PST)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id l63sm5447242oia.2.2022.01.27.19.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 19:25:29 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 2/2] cpufreq: qcom-hw: Delay enabling throttle_irq
Date:   Thu, 27 Jan 2022 19:25:54 -0800
Message-Id: <20220128032554.155132-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220128032554.155132-1-bjorn.andersson@linaro.org>
References: <20220128032554.155132-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In the event that the SoC is under thermal pressure while booting it's
possible for the dcvs notification to happen inbetween the cpufreq
framework calling init and it actually updating the policy's
related_cpus cpumask.

Prior to the introduction of the thermal pressure update helper an empty
cpumask would simply result in the thermal pressure of no cpus being
updated, but the new code will attempt to dereference an invalid per_cpu
variable.

Avoid this problem by using the newly reintroduced "ready" callback, to
postpone enabling the IRQ until the related_cpus cpumask is filled in.

Fixes: 0258cb19c77d ("cpufreq: qcom-cpufreq-hw: Use new thermal pressure update function")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- Switched back to applying thermal pressure on "related_cpus", as
  "policy->cpus" is adjusted based on CPU hotplug.
- Reintroduced "ready" callback (in patch 1), as the maintainers of
  topology_update_thermal_pressure() where not interested in allowing a cpumask
  of 0.

 drivers/cpufreq/qcom-cpufreq-hw.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 05f3d7876e44..effbb680b453 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -388,7 +388,7 @@ static int qcom_cpufreq_hw_lmh_init(struct cpufreq_policy *policy, int index)
 
 	snprintf(data->irq_name, sizeof(data->irq_name), "dcvsh-irq-%u", policy->cpu);
 	ret = request_threaded_irq(data->throttle_irq, NULL, qcom_lmh_dcvs_handle_irq,
-				   IRQF_ONESHOT, data->irq_name, data);
+				   IRQF_ONESHOT | IRQF_NO_AUTOEN, data->irq_name, data);
 	if (ret) {
 		dev_err(&pdev->dev, "Error registering %s: %d\n", data->irq_name, ret);
 		return 0;
@@ -542,6 +542,14 @@ static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
 	return 0;
 }
 
+static void qcom_cpufreq_ready(struct cpufreq_policy *policy)
+{
+	struct qcom_cpufreq_data *data = policy->driver_data;
+
+	if (data->throttle_irq >= 0)
+		enable_irq(data->throttle_irq);
+}
+
 static struct freq_attr *qcom_cpufreq_hw_attr[] = {
 	&cpufreq_freq_attr_scaling_available_freqs,
 	&cpufreq_freq_attr_scaling_boost_freqs,
@@ -561,6 +569,7 @@ static struct cpufreq_driver cpufreq_qcom_hw_driver = {
 	.fast_switch    = qcom_cpufreq_hw_fast_switch,
 	.name		= "qcom-cpufreq-hw",
 	.attr		= qcom_cpufreq_hw_attr,
+	.ready		= qcom_cpufreq_ready,
 };
 
 static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
-- 
2.33.1

