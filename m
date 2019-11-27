Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0867310AA49
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2019 06:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfK0Fip (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Nov 2019 00:38:45 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39164 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfK0Fip (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Nov 2019 00:38:45 -0500
Received: by mail-pl1-f194.google.com with SMTP id o9so9232497plk.6
        for <linux-pm@vger.kernel.org>; Tue, 26 Nov 2019 21:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A1crt5ZX5/o6tqZ8uQeAgWxnW6il/kNy0inAaXVelWg=;
        b=03QmaYAqqV7p+2/P0ek7syQoGHcAgOXji2fJRE13ydAmBy/qMCG4aBhnyp/RnL1MEg
         HngVDerDsYPHadSYiO2t4A6vPf3vU5YfWkQDy5yL4v1TI3qCgXvSaj4y5WRLv+tfioR3
         P6kREx5Mc4tkwL8LHBfqCxMBlBtAGowVmk05raMfkzNZVAarD7Thw/yPmXlH8TrCYhGQ
         Sw+AiR0DHihdJZk+CYuI5j4FcWDUzeS462dvKaGpvi8lRY428rEUO96BPQ1NfRBcU06h
         qQXH+ROoIhA8KeSWq5lQQAw7bgUdUd4foBxqPnL182bs9eam/JqCS9bXC3bCIaEyNcrW
         y59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A1crt5ZX5/o6tqZ8uQeAgWxnW6il/kNy0inAaXVelWg=;
        b=mqeuIM7dQrysr7J8+wkOnJdDpsgyt2hvoeJZmS/sMXowMHn5HUcoQLaW6+OUTDRuTP
         gRUjVNeIDmim9ja9BKBE2H9+qMOMTkZs2chAkX5BqPnBHfdhyQWzT3V5+D5Ff5WWmVPp
         6JAlwiz8I7ZFLtXRGj4gExfcY3ZewNyx1b95jEvLlI5IhiZJWXc8pLlvhuv/nSZLmL5V
         zqIX2PTepHg/IUXVZYUB5Uuh8qGhNrIhRwsSKCPkhE/86/U2NzmCv73/MT6Hdh+FGxly
         3ueaIE9Fm6S2CMRncCI2bF+eJCGkh8x1p9qPaewsNbq6swADlxzxsPfwQ1I3vP0fr+GM
         oj7g==
X-Gm-Message-State: APjAAAXbB8GLRrp84bsbwqyNP8y9PAmBrXAq7/m180WdzYJGgL8p/o2b
        6bmlYZNM2H+RdG+wOkA7enVRFw==
X-Google-Smtp-Source: APXvYqwaICaiIi2qlVP9oI/G9SEz3ACyQkNtE5h1JyLUsyrXggjU2y9sZVHDzZcDGoCT3MoOKaOHAw==
X-Received: by 2002:a17:902:5a04:: with SMTP id q4mr2318041pli.34.1574833124051;
        Tue, 26 Nov 2019 21:38:44 -0800 (PST)
Received: from limbo.local (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id y8sm14088008pfl.8.2019.11.26.21.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 21:38:43 -0800 (PST)
From:   Daniel Drake <drake@endlessm.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, rafael.j.wysocki@intel.com,
        linux@endlessm.com, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, mika.westerberg@linux.intel.com
Subject: [PATCH v2 2/2] PCI: increase D3 delay for AMD Ryzen5/7 XHCI controllers
Date:   Wed, 27 Nov 2019 13:38:36 +0800
Message-Id: <20191127053836.31624-2-drake@endlessm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191127053836.31624-1-drake@endlessm.com>
References: <20191127053836.31624-1-drake@endlessm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Asus UX434DA (AMD Ryzen7 3700U) and Asus X512DK (AMD Ryzen5 3500U),
the XHCI controller fails to resume from runtime suspend or s2idle,
and USB becomes unusable from that point.

xhci_hcd 0000:03:00.4: Refused to change power state, currently in D3
xhci_hcd 0000:03:00.4: enabling device (0000 -> 0002)
xhci_hcd 0000:03:00.4: WARN: xHC restore state timeout
xhci_hcd 0000:03:00.4: PCI post-resume error -110!
xhci_hcd 0000:03:00.4: HC died; cleaning up

During suspend, a transition to D3cold is attempted, however the affected
platforms do not seem to cut the power to the PCI device when in this
state, so the device stays in D3hot.

Upon resume, the D3hot-to-D0 transition is successful only if the D3 delay
is increased to 20ms. The transition failure does not appear to be
detectable as a CRS condition. Add a PCI quirk to increase the delay on the
affected hardware.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=205587
Link: http://lkml.kernel.org/r/CAD8Lp47Vh69gQjROYG69=waJgL7hs1PwnLonL9+27S_TcRhixA@mail.gmail.com
Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 drivers/pci/quirks.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

v2: split out the creation of quirk_d3hot_delay() into its own patch

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 3b4021e719530..222108f1a602e 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1889,6 +1889,22 @@ static void quirk_radeon_pm(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6741, quirk_radeon_pm);
 
+/*
+ * Ryzen5/7 XHCI controllers fail upon resume from runtime suspend or s2idle.
+ * https://bugzilla.kernel.org/show_bug.cgi?id=205587
+ *
+ * The kernel attempts to transition these devices to D3cold, but that seems
+ * to be ineffective on the platforms in question; the PCI device appears to
+ * remain on in D3hot state. The D3hot-to-D0 transition then requires an
+ * extended delay in order to succeed.
+ */
+static void quirk_ryzen_xhci_d3hot(struct pci_dev *dev)
+{
+	quirk_d3hot_delay(dev, 20);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15e0, quirk_ryzen_xhci_d3hot);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15e1, quirk_ryzen_xhci_d3hot);
+
 #ifdef CONFIG_X86_IO_APIC
 static int dmi_disable_ioapicreroute(const struct dmi_system_id *d)
 {
-- 
2.20.1

