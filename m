Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8020F7DDE0D
	for <lists+linux-pm@lfdr.de>; Wed,  1 Nov 2023 10:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbjKAJEg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Nov 2023 05:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbjKAJEe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Nov 2023 05:04:34 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7ED0DE
        for <linux-pm@vger.kernel.org>; Wed,  1 Nov 2023 02:04:26 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9d23be183c6so584654866b.0
        for <linux-pm@vger.kernel.org>; Wed, 01 Nov 2023 02:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698829465; x=1699434265; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wy1RT/8l0KHF5wsFu6GhibgFreZIXSZSGpoMQMm9nKQ=;
        b=KqiPf3MKfoqZ7kc+yN5OIXBb2QyaOjsUv5r0X0Z5KVP//hHHS3g1IAgP0CP5jD+rHc
         6w6DW70S1gc1bPYd9V526AE8OAOo11MvoZ+iQTYI0KrvPY5nlOwnSr4/ddO43Reri+O5
         /jBwzPfisXtN1GxAQZ155cHPnBnAMddb6BPong/fJofVtEIlghhCKC5ONz3ZQCzrjomG
         MCdZ3dVgHJugAHjdvO98uhIRFmv5QPjNcu/8eO9cY30hP1Nx67GVjzlIeZNTVSgZDVnc
         X9F3r9c1jy9JfrPc9qeu7wLhemqAI6gO7Vqcunt6N2LnJhDXao+qXVSsoWZ6x2zPCsmW
         iTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698829465; x=1699434265;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wy1RT/8l0KHF5wsFu6GhibgFreZIXSZSGpoMQMm9nKQ=;
        b=FaN5OOqcp9HIlvFLksFYElOEsAgrTxKLTygqTjCK7woHPAWvyNnt7RkOUzTYDUifEY
         D63yZDvjSzvJokHdkk5pqvB52KFlqE8zYI2PcBoLtW3sB0+Vp71VwbLx7EMDtLGaF/zX
         Szo/ZTc5Rx4i5El/uRrizzK0T7R9c+8bJ0V9jnGX0ilWBhYrWnyTp+nX/cG+tpezuP6q
         0UPx308xIhLG3FvYscxNCu3dKBqqKftcMsL7HSITnoJN77WJ6ZfScLqJYbmr6Fpg9+q6
         khrNsfeZCR0DHoqdnbYY41/7pX/3w+hZgPYjSuBdtrJ97PA1CpOFBy3aEoajwavsO+KO
         v0XA==
X-Gm-Message-State: AOJu0YzjVP5R4KxQjbGzIJtQKKV850d9eY/9I/2G6cZ4f1wnGyK7G7LZ
        OEHCNhdD0CORztc1pKMh4Xb8OQ==
X-Google-Smtp-Source: AGHT+IF0uQ6L63mtTK6fvz1bIka3oLMpIDS//D4L4ujaEmxmgdeLqCOWEMLFLMvYXy05/lYBAL/xdw==
X-Received: by 2002:a17:907:26c4:b0:9d4:771b:69b4 with SMTP id bp4-20020a17090726c400b009d4771b69b4mr1343872ejc.44.1698829465256;
        Wed, 01 Nov 2023 02:04:25 -0700 (PDT)
Received: from [127.0.1.1] ([86.122.213.220])
        by smtp.gmail.com with ESMTPSA id l25-20020a170906a41900b0099cd1c0cb21sm2152781ejz.129.2023.11.01.02.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 02:04:24 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
Date:   Wed, 01 Nov 2023 11:04:08 +0200
Subject: [PATCH RESEND v3 2/5] PM: domains: Add the domain HW-managed mode
 to the summary
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231101-gdsc-hwctrl-v3-2-0740ae6b2b04@linaro.org>
References: <20231101-gdsc-hwctrl-v3-0-0740ae6b2b04@linaro.org>
In-Reply-To: <20231101-gdsc-hwctrl-v3-0-0740ae6b2b04@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Taniya Das <tdas@qti.qualcomm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-media@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2157; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=mHCbi3fcCtSdQT1eVVDhxrqekocNkt9Tq7L+ASfI19c=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlQhSOhLKXMJSo21lGzR3ysdpejTLKwJBoQxkYh
 MH83w6uWJ2JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZUIUjgAKCRAbX0TJAJUV
 Vo2aD/9YiFkZJAlAo90gqui3KRk45JLMQKlpflWTNJZdCvZRVYf+wotXkWcS8jRWqYg7BIcdi7e
 2mY9aRzvMNSMdcCD6Tc4LEFFzusUyBWLDuo+R6i7eKK5//FdPYVo8aArCKXRPN/JSXxNNiZcE2m
 I7e1wNExM8MvNjWbrIf1bDeFV2xegv3IIpNXUplfttlxRyO0AKpsZ0Vrae9Rfnna7vQb0wBnc1k
 1SpTMwYJD/2I8/qsEC9A6AuE/7OjfoFmqZSmovl7IcpSKon03Xm9/cK2F1+mKdAWpdFCM9pJSZh
 51Enr+10aABCccaH6jI+MC/02CosSvTJcOhHt/5A0wgf7al3gVubTf0G82MM8JAjfLsCwhiO3pb
 x7DPW19h67/tuh9A2KOS9NaN+1ozEpGzB2dfEJxWyUpL6JLNTSOHGsUCP5NBWUI6LuV4UhhaO5K
 M/mADvROhxudpOLxFCQaMZt6ZIHwlYGxaKwdB+14TMkAN/vvlXLw1EJvSRQljAsGFp1UCm5lJJ1
 MxM4LfgooUIXcdh/muKWmqXViGAVyA1Q8TX99Rsw/y7tnsiEht+wvWThIYT6I8AB0WWWL7L9bza
 Snsrp8DkgULIWOspS+coIBw1P7wg/kKQ3jScDlPDXqbGW8HLWwNvYddd7iqvyx+DJAYEQvugZhP
 DG22z09XDbhQOrw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Now that genpd supports dynamically switching the control for an
attached device between hardware- and software-mode,  let's add this
information to the genpd summary in debugfs.

Suggested-by: Taniya Das <quic_tdas@quicinc.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 3fb1a234c7f2..7044271ec93b 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -3181,6 +3181,15 @@ static void rtpm_status_str(struct seq_file *s, struct device *dev)
 	seq_printf(s, "%-25s  ", p);
 }
 
+static void mode_status_str(struct seq_file *s, struct device *dev)
+{
+	struct generic_pm_domain_data *gpd_data;
+
+	gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
+
+	seq_printf(s, "%20s", gpd_data->hw_mode ? "HW" : "SW");
+}
+
 static void perf_status_str(struct seq_file *s, struct device *dev)
 {
 	struct generic_pm_domain_data *gpd_data;
@@ -3239,6 +3248,7 @@ static int genpd_summary_one(struct seq_file *s,
 		seq_printf(s, "\n    %-50s  ", kobj_path);
 		rtpm_status_str(s, pm_data->dev);
 		perf_status_str(s, pm_data->dev);
+		mode_status_str(s, pm_data->dev);
 		kfree(kobj_path);
 	}
 
@@ -3255,8 +3265,9 @@ static int summary_show(struct seq_file *s, void *data)
 	int ret = 0;
 
 	seq_puts(s, "domain                          status          children                           performance\n");
-	seq_puts(s, "    /device                                             runtime status\n");
-	seq_puts(s, "----------------------------------------------------------------------------------------------\n");
+	seq_puts(s, "    /device                                             runtime status                           managed by\n");
+	seq_puts(s, "------------------------------------------------------------------------------------------------------------\n");
+
 
 	ret = mutex_lock_interruptible(&gpd_list_lock);
 	if (ret)

-- 
2.34.1

