Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD7B774D6
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2019 01:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbfGZXQI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jul 2019 19:16:08 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:47987 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728581AbfGZXQI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jul 2019 19:16:08 -0400
Received: by mail-pg1-f202.google.com with SMTP id l11so12559527pgc.14
        for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2019 16:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KA0H2FQCKfPlRFALsSxO8aZCLEoa2YLftLw47C413O4=;
        b=sJDXZIgKg9OcRmohvvHtcgRd9n6H04cbduCDpZ+j2ttvA72wyN1yFoZs12chqGY8Lk
         tGQ5uUqwVG8PkUGAqlrvrJ/wj5CEAP6YEMLE+xzEzwJgBSVkd+ez7gcDk++waKbJiis2
         IVU28mJGOUEFAr8wsHcultT5x1jzeBvKq2/4LbJT6JvRAubkU3lrSB6jUyaLsSx0OhvZ
         AheGdZ+7mwa/WhYtUkWUtbFgmP4D2xwcZqzsaTTfjU1vW0hFKLc+4ZpFtkC08F8Ej3QP
         +mCdy2ufEU3VUfryLY43xGe525YhCCPwbT+hcTvEk1xciA+vco77QQTPNbMztD7R6Am0
         RKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KA0H2FQCKfPlRFALsSxO8aZCLEoa2YLftLw47C413O4=;
        b=ebfw56hwcUfueK+btdwf5LvPAhoYl4t0qcIW2ZQk2XpTVHdF6Hybdrsj2UV5ysmrmQ
         OCvfJnQ3SrWBF0zBFlKaMQJUt7EK0f2PxQm7NLSXe7tr2qaYnAkZojCakVizsWrl+IQp
         MRrGqV0fnP/3Hjqi9nqg/7hHHYKtHo+7z/VEhr/s2au3FogpCKW/F9oFl3NV9XC++fLR
         /sFaEkUeZb+josrDoonx/O7nWostvLyvNdL9Q7EeIQ4wKvlv0SeD96M0ZBS7zJH3oprt
         /VjWw67SJzzEB6PJuY5wqQiIb9feYv1u+kcrq7W0Nn5uQp5OlFh0DYC/wpWhQ8EW2yh0
         9p+Q==
X-Gm-Message-State: APjAAAVodaQIyZZMsHFcMwl350mx81xPO837+m884h7XZSxubQlWcbkL
        t6SL+9twVMIsVhsdHASQCxrOa2Cj7oOsXkE=
X-Google-Smtp-Source: APXvYqyGkZZFPN5EuIGupnn4DHO9UuijX2q5nto5Gkvcpzm3LokCNz3qgpWL2igfgyGgYQq8DTJ+LSIaiKvPEB4=
X-Received: by 2002:a63:f959:: with SMTP id q25mr93212062pgk.357.1564182967047;
 Fri, 26 Jul 2019 16:16:07 -0700 (PDT)
Date:   Fri, 26 Jul 2019 16:15:55 -0700
In-Reply-To: <20190726231558.175130-1-saravanak@google.com>
Message-Id: <20190726231558.175130-2-saravanak@google.com>
Mime-Version: 1.0
References: <20190726231558.175130-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v4 1/3] dt-bindings: opp: Introduce opp-peak-KBps and
 opp-avg-KBps bindings
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Saravana Kannan <saravanak@google.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        vincent.guittot@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, adharmap@codeaurora.org,
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
 Documentation/devicetree/bindings/opp/opp.txt     | 15 ++++++++++++---
 .../devicetree/bindings/property-units.txt        |  4 ++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index 76b6c79604a5..b1eb49d6eab0 100644
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
+  opps are required to have the opp-peak-KBps property.
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
 
diff --git a/Documentation/devicetree/bindings/property-units.txt b/Documentation/devicetree/bindings/property-units.txt
index e9b8360b3288..ef4c4a199efa 100644
--- a/Documentation/devicetree/bindings/property-units.txt
+++ b/Documentation/devicetree/bindings/property-units.txt
@@ -41,3 +41,7 @@ Temperature
 Pressure
 ----------------------------------------
 -kpascal	: kilopascal
+
+Throughput
+----------------------------------------
+-KBps		: kilobytes per second
-- 
2.22.0.709.g102302147b-goog

