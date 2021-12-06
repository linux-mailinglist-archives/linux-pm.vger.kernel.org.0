Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3BF8469538
	for <lists+linux-pm@lfdr.de>; Mon,  6 Dec 2021 12:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242557AbhLFLu6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Dec 2021 06:50:58 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:17380 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237397AbhLFLu5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Dec 2021 06:50:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1638791247;
    s=strato-dkim-0002; d=gerhold.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=BUs3btuz5yNH91Q/4o2jJkzLw+2KRuDsNy50W2BYDfY=;
    b=iQHes5G52TbcOx1/DLCUhTjKJSCfqwWUGDFpwrNzsmauKyLW2PbkoFXKvuAsGXdxtT
    mgIoI6AwZG7gCi635EzKtJilaC2Q4+o8uGVFKmT8SMcMcnRtaFYQ+7zoHubbtEM1U4Ut
    PRGWTe0vnmbPrYp61aAn4qRBecuVwU3vbL3wKFwUHEYqzbO2PL6qMYEP1FvVfnhxdcVG
    vRBQ7HkgB6IiE/I4r5bxqx+CY4uT7zxN3jnaYmQtqQCJbYPll5+1yKFZ4x7n06mm3jjb
    qHKWiG1YcDtc3GHFkP+lPrPrLz7wow/ynkxLrZSDjW6mLkBkNVFhCXUUcVIeD/rrviCI
    B2mw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQ7UOGqRde+a0fyL2mYw2"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.34.10 AUTH)
    with ESMTPSA id j03bcbxB6BlR8JM
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 6 Dec 2021 12:47:27 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH] interconnect: qcom: rpm: Prevent integer overflow in rate
Date:   Mon,  6 Dec 2021 12:45:42 +0100
Message-Id: <20211206114542.45325-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Using icc-rpm on ARM32 currently results in clk_set_rate() errors during
boot, e.g. "bus clk_set_rate error: -22". This is very similar to commit
7381e27b1e56 ("interconnect: qcom: msm8974: Prevent integer overflow in rate")
where the u64 is converted to a signed long during clock rate rounding,
resulting in an overflow on 32-bit platforms.

Let's fix it similarly by making sure that the rate does not exceed
LONG_MAX. Such high clock rates will surely result in the maximum
frequency of the bus anyway.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/interconnect/qcom/icc-rpm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 6b918d082ab6..58894072adce 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -240,6 +240,7 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 	rate = max(sum_bw, max_peak_bw);
 
 	do_div(rate, qn->buswidth);
+	rate = min_t(u64, rate, LONG_MAX);
 
 	if (qn->rate == rate)
 		return 0;
-- 
2.34.1

