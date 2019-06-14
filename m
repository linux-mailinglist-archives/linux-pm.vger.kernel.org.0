Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D35A045352
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 06:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfFNERw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 00:17:52 -0400
Received: from mail-oi1-f202.google.com ([209.85.167.202]:33941 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfFNERv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jun 2019 00:17:51 -0400
Received: by mail-oi1-f202.google.com with SMTP id i16so402461oie.1
        for <linux-pm@vger.kernel.org>; Thu, 13 Jun 2019 21:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yAz3k7OzPjxwzR5iBZENxEm1ewgrxin9ITMqtF0yTXk=;
        b=B7prBGnC/4Vibzh1aRMKAwrh4wPptRavvQYdcbMm4wH18w6FJ+mN2XrQWOTokqNNE1
         2YQEPr15HP9wSksf1WcGXsHnVfqqqegk1AI4eEiroIavNFnRETAd2J8oE0N+RDr4nh6n
         AmmAr7cJQDsTXFqCR3AJrrk/CmgU6adsljmLmVCSPy0Y0sYMKMcgVM3kHNlj+tUdSMD/
         BPjdbxJNKW2RflGqJzrpzuZ7sMm8HwAor8bGvpDaFEBr23p78S/TZxhHyFUjGMyT61Ng
         WGTkhSqWIQLHWc8uOIJGFcDV9ynqnhDOGqTgQwDVWczkizWy5FMQN2ha/gtdILPLq3uB
         rbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yAz3k7OzPjxwzR5iBZENxEm1ewgrxin9ITMqtF0yTXk=;
        b=fVC9G/wwYgVkfRAqO9RkLnMxV0sfF/ZpKT/gV52PqP2YmNd4YHPbX1Vm4Mt5jSGVJp
         ZCt6MoYe6Uja4rsGXRSno9P5CYCfzQwns8RTz7JPfqZ2F2R+54yXIkp7XDFR80tr6CZp
         NqOhny2QlcgfDIrLy4SZoBuHJWUiD+aAmt9oycqsEQcDwzuIm8zW8VCYCcGQy76YGNmA
         HxLeuKipWZMBDvYBG+nW+k5JO2oxx54au6y30l0mVsPH+wfAaLRRKy0bUPGE3m8RUtAh
         KgeyuNNkTQY+R+6k6/hbuWy+XTZlsaB1tzvOL30C9lPXQO3Wiq+fb232IJd6INvU84Yo
         djxw==
X-Gm-Message-State: APjAAAVGaUe2+gXRH7fN4dqHDAOthHlOUx42ylUiX0Oe9YUtT4IITIyN
        AqOxH5HnzbReRruIfFWfrm3O8VwyzEcXjLs=
X-Google-Smtp-Source: APXvYqxpQN0vGQmlYfHsDs37QAiaPht93jr4MuA/NrskO8HXbTJIyWknXV3GfSjQiUsAjTLL2awJ0YqhP7X0mIc=
X-Received: by 2002:aca:b8d7:: with SMTP id i206mr618247oif.25.1560485870342;
 Thu, 13 Jun 2019 21:17:50 -0700 (PDT)
Date:   Thu, 13 Jun 2019 21:17:26 -0700
In-Reply-To: <20190614041733.120807-1-saravanak@google.com>
Message-Id: <20190614041733.120807-5-saravanak@google.com>
Mime-Version: 1.0
References: <20190614041733.120807-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v2 04/11] dt-bindings: opp: Introduce opp-peak-KBps and
 opp-avg-KBps bindings
From:   Saravana Kannan <saravanak@google.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        vincent.guittot@linaro.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        sibis@codeaurora.org, kernel-team@android.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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
2.22.0.rc2.383.gf4fbbf30c2-goog

