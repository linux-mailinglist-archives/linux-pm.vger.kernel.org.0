Return-Path: <linux-pm+bounces-18631-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0749E5C1E
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 17:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 431671882CF2
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 16:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687C722258D;
	Thu,  5 Dec 2024 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Clce7oIH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392BB221463;
	Thu,  5 Dec 2024 16:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733417449; cv=none; b=Yl+fC/QnkiN9257FRDCL3u8HEDwOV6i+OuO2l8G8wgzaMs8HfCoeJ/3vDR/355JsXJEjQhflpS43tjArVKfpGsH2aXhIXKgdV6+1akrIL5GE8sn64lsA8RnKRXwneKxoS9tM1Qqpq8YXQYutSGBoHrhzucHaG5q8+uKeTqQzWR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733417449; c=relaxed/simple;
	bh=eRPnmWYSQhSAftRfnhYQ4HXep5ZbnD5fgGUew/TmFlk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RxYnQN+a0UNOeoIc4RYsgeLgixuYspFJfOC7L4OiDhvtcO+HPF52F0jdXEPOdH3PnuDNreSjtK8ISFLxpb98yIqm5Sypv0HBiLQckIgw0qhdpb7rSXDNB5E9/nUxzprcHriw3HEOV/ZGwrz98lf0VSceDu7/n66/F4U/V1z+O4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Clce7oIH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4C7FC4CED1;
	Thu,  5 Dec 2024 16:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733417448;
	bh=eRPnmWYSQhSAftRfnhYQ4HXep5ZbnD5fgGUew/TmFlk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Clce7oIHQ8D58lkYxmHINUg+XNNoK/LhpP0LOOuhTb0Bxa44m+4NL5+0mFWvgkl2V
	 rKNJozgLbbJtE+XvoWzSx7xBW+XrMYQHUKNdT/Dqi4oi+uSCpE+tdSyml1p+CT1NLr
	 RA40iYXECF8WqKXnbLU6gQMS9x8cf7ouJA01YuhFG7FhxqomIhQu6XqheVjMfbIOMU
	 +609M9hPhPFKilP3gRd78Qzc0aNkaJEOH+9bTl/OdAdrc2a0tOa66RewpEIvl7poe6
	 c50dx9ebUyXD54lr2Jz7jLjQfQisxGkZQe7A3WV/y/Tqmf0KVoOpwJwC+lnFST61lx
	 XTeeELDtC0L9A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FF3E77170;
	Thu,  5 Dec 2024 16:50:48 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Subject: [PATCH 0/2] cpufreq: qcom: Clock provider fixes
Date: Thu, 05 Dec 2024 22:20:27 +0530
Message-Id: <20241205-qcom-cpufreq-clk-fix-v1-0-de46c82e0fe5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANPZUWcC/x2MSQqAMBDAviJzdqAWN/yKeKjtVAe3LiiC+HeLx
 wSSByIFpghd9kCgiyMfe4Iiz0DPap8I2SQGKWRZSFGh18eG2p02kEe9Lmj5RlULO1pjmrEtIaU
 uUNL/th/e9wNM/J98ZgAAAA==
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johan Hovold <johan+linaro@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1286;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=eRPnmWYSQhSAftRfnhYQ4HXep5ZbnD5fgGUew/TmFlk=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBnUdnlN4Zr7BQSl7WojL2S8I1Hp6T7Kvw8mk7HT
 09RtBftfCWJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ1HZ5QAKCRBVnxHm/pHO
 9aA/CACJ/g/EEk/bHPAxG0CiFqR6jDDHBhVCpzWWDbQv+5L+cQDLw5GmgiiZ/sYzcHS3+pXS09p
 cDdXyDqQjZaN+up+agDGQc9EPzSuaE6I1PWoNJ/eyeR3UjB5/x7eBBAwmJdVTo4chS7AdYUv18V
 ghz7NBoCQvqFXKmEf2r3RbHn/D0lI9kTpxfs7SepHAqzifg8bHYq1gw+XWbYazjgzM8OBGAKb1c
 CUnWjysjDfvL/ilLiJgONqPH00Wzh6JBeZ5jtIovE+uwW0DTHSTEBbwegIWKIUMsx3Vyxh8bR4F
 NtA+Eqgc0IEKyNYa+NAYPmAstOnOjVPV91gWFt7/jw5OuL+A
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

Hi,

This series has a couple of fixes for the Qcom CPUFreq clock provider.
Patch 1 fixes an issue where incorrect rate might be reported if LMh IRQ is not
available for a platform (issue identified based on code inspection). Patch 2
fixes a regression reported for v6.13-rc1 [1]. The regression was triggered by
commit 25f1c96a0e84 ("clk: Fix invalid execution of clk_set_rate"), which fixed
the behavior of the clk_set_rate() API. Even though the commit got reverted now,
patch 2 fixes the issue in the clock provider code.

This series is tested on Qcom RB5 development board.

[1] https://lore.kernel.org/all/20241202100621.29209-1-johan+linaro@kernel.org

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Manivannan Sadhasivam (2):
      cpufreq: qcom: Fix qcom_cpufreq_hw_recalc_rate() to query LUT if LMh IRQ is not available
      cpufreq: qcom: Implement clk_ops::determine_rate() for qcom_cpufreq* clocks

 drivers/cpufreq/qcom-cpufreq-hw.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)
---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241205-qcom-cpufreq-clk-fix-a60fbfdd7b84

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>



