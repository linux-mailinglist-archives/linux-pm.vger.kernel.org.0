Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADAB7436055
	for <lists+linux-pm@lfdr.de>; Thu, 21 Oct 2021 13:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhJULeN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Oct 2021 07:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbhJULeN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Oct 2021 07:34:13 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30651C06161C;
        Thu, 21 Oct 2021 04:31:57 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id e19so3522302ljk.12;
        Thu, 21 Oct 2021 04:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YvcmTSFUq/94rirDKdxyS5tqXWXe39JGgAU4kdq++2E=;
        b=NDPCQNMiknuVU26HFolM7yJlxS+5HQjrLRHHfv3sKNE/3bXc4NXZecpZWJ5Kfh0Pn4
         /28eQObOTLQ8ZHvHuEDEZnUZOkLtKXg5qbd6wHr6wk3mONxBoM5ESuqxm/TYdD+JlkGS
         07Dy9e1XWAeuOA6/x7IROvb5JYzUkBphZp68wRsi7J8vrAWYDBWGyS1+mGwsBCeZo0A0
         Qi19QBOZbN6/vZZxjkMVPDdpKiPtKjBaHPhn3A+RqWDWeQZmL90AY9lcT9p2l7acGDpS
         hLaVqKlRYpSevdyrQykUx3KM1vkVS+3J3VLJfmz96wsMKMZ4Ptbqi7ZjrCZ38JRecxAG
         0DRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YvcmTSFUq/94rirDKdxyS5tqXWXe39JGgAU4kdq++2E=;
        b=1oL0WyqY0QbrpFGugaNtUHQXm9XDLQgA8CibKfRQUW9kAuUxr/762Y3AD6uB4eMvap
         /0RFznRSq35pAAQFZk7HNrLp9t2ZaM3N/9LECAj+UsW5dlIk4vERR8zaY9WTwJ9DKowq
         /D8wv/Jpiv9zq3+0m7QOERTJej53hT5L+WXx6Ggj4wY81ZJqh2bLczdfPEc/158OuWwy
         DP21F2KQ7WCZt2fCpODZcac5OnItPi/olHZetQdr+zZnpWwj+PwYxqoL6sMvCWTjm3ho
         +V6zBkyZH5x5bpkfBRNM6cA5Fy9i+JyJXlmmE8c8gOEVVtyTO+g7tb6eyY4cgoil/ws2
         VOTg==
X-Gm-Message-State: AOAM533aug8LTjiEzlSo/vNSN0FE0aCfKSQgk4dNNBatISsUVDc9+kvK
        bx+J08z0DwDcq0MrwrR0x6j386JC2jY=
X-Google-Smtp-Source: ABdhPJxc55e0WxyiQy7m53+filBf8UBAyN2X0q/RxRJzabTeFmHbe43ct0wTN3bspCqI4Md+NLaGfg==
X-Received: by 2002:a2e:9b09:: with SMTP id u9mr5376404lji.111.1634815915634;
        Thu, 21 Oct 2021 04:31:55 -0700 (PDT)
Received: from localhost.localdomain (94-29-39-10.dynamic.spd-mgts.ru. [94.29.39.10])
        by smtp.gmail.com with ESMTPSA id 195sm519677ljf.13.2021.10.21.04.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 04:31:55 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        David Heidelberg <david@ixit.cz>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v2] dt-bindings: opp: Allow opp-table postfix and multi-worded node names
Date:   Thu, 21 Oct 2021 14:30:55 +0300
Message-Id: <20211021113055.780-1-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Not all OPP table names and OPP entries consist of a single word. Not all
OPP tables start with opp-table- prefix. In particular NVIDIA Tegra OPP
tables use multi-word names and have -opp-table postfix. Allow OPP node
and OPP entry names to have multi-worded names. Allow to use the postfix
variant. This corrects DT checker warnings about the wrong naming scheme.

Reviewed-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Changelog:

v2: - In addition to a multi-wording support, support of the postfix
      *-opp-table naming scheme is added to the updated pattern.

 Documentation/devicetree/bindings/opp/opp-v2-base.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
index ae3ae4d39843..7cd9b9e780bc 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
@@ -22,7 +22,7 @@ select: false
 
 properties:
   $nodename:
-    pattern: '^opp-table(-[a-z0-9]+)?$'
+    pattern: '^([a-z0-9]+-)*opp-table|opp-table(-[a-z0-9]+)*$'
 
   opp-shared:
     description:
@@ -33,7 +33,7 @@ properties:
     type: boolean
 
 patternProperties:
-  '^opp-?[0-9]+$':
+  '^opp(-[0-9]+)*$':
     type: object
     description:
       One or more OPP nodes describing voltage-current-frequency combinations.
-- 
2.32.0

