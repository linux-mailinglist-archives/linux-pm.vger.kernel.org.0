Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19E035DA74
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2019 03:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfGCBK3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Jul 2019 21:10:29 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:44685 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbfGCBK2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jul 2019 21:10:28 -0400
Received: by mail-pf1-f201.google.com with SMTP id j22so394298pfe.11
        for <linux-pm@vger.kernel.org>; Tue, 02 Jul 2019 18:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=e9kTi24uB4qma1DS6GLfEd66OjyUuGvajWKOikD47Aw=;
        b=Gke0wMis6E54EMbeMX51d1b4DLg3NQl068tRf9JRRwoyEiiec/5boft2FQO/E182cW
         uoGbqSDHrEW0BfxIj4OxChLfIrwGIcJ/IziKnOHCXvLp36E4FOuiR10Gfrexqp83BIBG
         k2KWFMwUE5pztZQsHB5U1kpLIQ636P5rYZ+iSo+I1q4LGS+u8VlCzht1pOUpr28+RacL
         3bsNezsZYmq9SdcXbeVtcyMwZ6w5XuvSEam+c0LGKZUBTAfwag33F2ozP7CmvpZoAa3l
         8v6gShBaUpRw04xZAmgd8KpxH8XqQ+yC9ZD31FLirq2K0FjF661IsWc8zLppc9P5nWsx
         zIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=e9kTi24uB4qma1DS6GLfEd66OjyUuGvajWKOikD47Aw=;
        b=PO5+dNbjk/1v4DpFQuNDEbxAU24RLhB4SreLgwPfTFHeDbhuzkWtQjHhx64SnMX8BQ
         GjkUtrIveecF+qrd5FcRc/w9aD5HZJhpPEEhJtjAkF/+HN8of5sqp92fDVz1J244kzX3
         dCXQEBToNgjSvtPNJMQ5sJagPrk4t/qbrtCrZhzC9TpeCDkgH15MPppQVlT3cN3Qh36S
         LcnUoC14Z9MOCkHytFX816RdVyvY5WNsABN7mCW/ZdUv5f4vVhvVt7bmMBQ8P6tTSV2Y
         EwGh+bJ8iYFzn2R4Acakxc7eBgo0iyFq3/5bBmk6Y4oC6tnKnKksUrmr780V8W2sIv/I
         vBKQ==
X-Gm-Message-State: APjAAAXfRS7yRmSEbHiF1efiiSTY4yM6zlX7d2fW7yW46kD+UGNan29r
        pmL/DYrxX5Spr7RDGSBMf3EIuRmI9Cx0Uas=
X-Google-Smtp-Source: APXvYqyhZ6ewKAXFIwQJJhA1AgdyM3RtUJbdz/u8xIi1sWGVsqHDJ1zCwj5Y4C/wLIAnD3LEbng6V6B5cGYzL9Y=
X-Received: by 2002:a63:6ec4:: with SMTP id j187mr15725095pgc.420.1562116227470;
 Tue, 02 Jul 2019 18:10:27 -0700 (PDT)
Date:   Tue,  2 Jul 2019 18:10:15 -0700
In-Reply-To: <20190703011020.151615-1-saravanak@google.com>
Message-Id: <20190703011020.151615-2-saravanak@google.com>
Mime-Version: 1.0
References: <20190703011020.151615-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v3 1/6] dt-bindings: opp: Introduce opp-peak-KBps and
 opp-avg-KBps bindings
From:   Saravana Kannan <saravanak@google.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Saravana Kannan <saravanak@google.com>, vincent.guittot@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>, sibis@codeaurora.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        kernel-team@android.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Interconnects often quantify their performance points in terms of
bandwidth. So, add opp-peak-KBps (required) and opp-avg-KBps (optional) to
allow specifying Bandwidth OPP tables in DT.

opp-peak-KBps is a required property that replace opp-hz for Bandwidth OPP
tables.

opp-avg-KBps is an optional property that can be used in Bandwidth OPP
tables.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 Documentation/devicetree/bindings/opp/opp.txt | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index 76b6c79604a5..c869e87caa2a 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -83,9 +83,14 @@ properties.
 
 Required properties:
 - opp-hz: Frequency in Hz, expressed as a 64-bit big-endian integer. This is a
-  required property for all device nodes but devices like power domains. The
-  power domain nodes must have another (implementation dependent) property which
-  uniquely identifies the OPP nodes.
+  required property for all device nodes but for devices like power domains or
+  bandwidth opp tables. The power domain nodes must have another (implementation
+  dependent) property which uniquely identifies the OPP nodes. The interconnect
+  opps are required to have the opp-peak-bw property.
+
+- opp-peak-KBps: Peak bandwidth in kilobytes per second, expressed as a 32-bit
+  big-endian integer. This is a required property for all devices that don't
+  have opp-hz. For example, bandwidth OPP tables for interconnect paths.
 
 Optional properties:
 - opp-microvolt: voltage in micro Volts.
@@ -132,6 +137,10 @@ Optional properties:
 - opp-level: A value representing the performance level of the device,
   expressed as a 32-bit integer.
 
+- opp-avg-KBps: Average bandwidth in kilobytes per second, expressed as a
+  32-bit big-endian integer. This property is only meaningful in OPP tables
+  where opp-peak-KBps is present.
+
 - clock-latency-ns: Specifies the maximum possible transition latency (in
   nanoseconds) for switching to this OPP from any other OPP.
 
-- 
2.22.0.410.gd8fdbe21b5-goog

