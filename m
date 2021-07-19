Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F2C3CCCC1
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jul 2021 05:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234412AbhGSDpu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 18 Jul 2021 23:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbhGSDpt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 18 Jul 2021 23:45:49 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91A5C061765;
        Sun, 18 Jul 2021 20:42:49 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id i16so116841pgi.9;
        Sun, 18 Jul 2021 20:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=21xAaUHWeHof2ecP/y/d30huoLiokvMxn5AYQcuGXfg=;
        b=D/8BXP3AYSUmd4JSaASlNyfM0Bl3cbjpR8eC0fxHe+FIHiX0BT6loaPC2z5syM3wQi
         aP4Ykw7YzZnqL7w1UV/qFyJTeuwQjM7fqRjP5wkg0qK3VyfYA56JVxIKSAsWOjOGLZza
         6jCIugmS1tT4wk/sKtq06twvtkr0jS81HwQsb4b4DhEQumhClbWBM/tY/GAxq16ETF/G
         1pK4s3A4Lim5UVZn/NsZ+Pfr+21O4j8qB0Lz9j+gZLLg2s4aKpOTkdHm8QkPJvxh5U0V
         IYmyWydD/KFNpbY+k7cqhlBQ0nnDyz6LakgwKQta8pAvDCEtSpHWPfbD9W2RHLbrZzxV
         8uaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=21xAaUHWeHof2ecP/y/d30huoLiokvMxn5AYQcuGXfg=;
        b=c0QTUEfBFS+3dN2F8aSWxNLK2ybyLJ6UUqplfvaVkdrYkbo5kxD0egSUX6dRbHj+mA
         3YbfC7lu+iZ3760W9os8I7wi59dGxHL2Y/wV3/RWzBh2Qd9TKroO7oYarePdoIqB4bTG
         xqWAoWb73uuO717jaQNk/SiCGZeLZoNMJgnGGpx8RNco2n1eN7iFkxTuu0x4XfKUmk/t
         RzORqQ2JL8RQNtrtMHC3cjIcDkRQG0B9MYKqLpafDJ27lI0JccLhCDzjaAsDjL+d+wpf
         E94WPxLOk916PakdOA/esw2W+B0U8+sUKw/xvLkYED6uDnb3ve/j6GIzMen8dF00GHbT
         3ODQ==
X-Gm-Message-State: AOAM532SY4MwmCgBRI2YGP/8bDYdiUhp2Z5r/8iMbosFDCRLM1NGWVdZ
        +rLlR+/xRfqrqEkp+58UmsY=
X-Google-Smtp-Source: ABdhPJxh1gCosQbN6iuToKSHRV624TaQLLlFEGQdSr/6pNsMBX731uOYH/mdQme4MO9Gp94rUFpWJw==
X-Received: by 2002:a62:dd42:0:b029:330:6bf8:b02c with SMTP id w63-20020a62dd420000b02903306bf8b02cmr23315961pff.67.1626666169333;
        Sun, 18 Jul 2021 20:42:49 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:58d:ffe9:427:42b0:88c7:1ff9])
        by smtp.gmail.com with ESMTPSA id c12sm17949448pfl.27.2021.07.18.20.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 20:42:49 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     sre@kernel.org, matthias.bgg@gmail.com,
        matti.vaittinen@fi.rohmeurope.com
Cc:     broonie@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, gene_chen@richtek.com,
        Wilma.Wu@mediatek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com, sebastian.reichel@collabora.com
Subject: [PATCH resend v6 1/3] lib: add linear range get selector within
Date:   Mon, 19 Jul 2021 11:39:12 +0800
Message-Id: <20210719033914.16990-2-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210719033914.16990-1-gene.chen.richtek@gmail.com>
References: <20210719033914.16990-1-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Add linear range get selector within for choose closest selector
between minimum and maximum selector.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 include/linux/linear_range.h |  2 ++
 lib/linear_ranges.c          | 31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/linux/linear_range.h b/include/linux/linear_range.h
index 17b5943727d5..fd3d0b358f22 100644
--- a/include/linux/linear_range.h
+++ b/include/linux/linear_range.h
@@ -41,6 +41,8 @@ int linear_range_get_selector_low(const struct linear_range *r,
 int linear_range_get_selector_high(const struct linear_range *r,
 				   unsigned int val, unsigned int *selector,
 				   bool *found);
+void linear_range_get_selector_within(const struct linear_range *r,
+				      unsigned int val, unsigned int *selector);
 int linear_range_get_selector_low_array(const struct linear_range *r,
 					int ranges, unsigned int val,
 					unsigned int *selector, bool *found);
diff --git a/lib/linear_ranges.c b/lib/linear_ranges.c
index ced5c15d3f04..a1a7dfa881de 100644
--- a/lib/linear_ranges.c
+++ b/lib/linear_ranges.c
@@ -241,5 +241,36 @@ int linear_range_get_selector_high(const struct linear_range *r,
 }
 EXPORT_SYMBOL_GPL(linear_range_get_selector_high);
 
+/**
+ * linear_range_get_selector_within - return linear range selector for value
+ * @r:		pointer to linear range where selector is looked from
+ * @val:	value for which the selector is searched
+ * @selector:	address where found selector value is updated
+ *
+ * Return selector for which range value is closest match for given
+ * input value. Value is matching if it is equal or lower than given
+ * value. But return maximum selector if given value is higher than
+ * maximum value.
+ */
+void linear_range_get_selector_within(const struct linear_range *r,
+				      unsigned int val, unsigned int *selector)
+{
+	if (r->min > val) {
+		*selector = r->min_sel;
+		return;
+	}
+
+	if (linear_range_get_max_value(r) < val) {
+		*selector = r->max_sel;
+		return;
+	}
+
+	if (r->step == 0)
+		*selector = r->min_sel;
+	else
+		*selector = (val - r->min) / r->step + r->min_sel;
+}
+EXPORT_SYMBOL_GPL(linear_range_get_selector_within);
+
 MODULE_DESCRIPTION("linear-ranges helper");
 MODULE_LICENSE("GPL");
-- 
2.25.1

