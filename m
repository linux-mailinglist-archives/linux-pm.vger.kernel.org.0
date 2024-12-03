Return-Path: <linux-pm+bounces-18422-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4569E1587
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 09:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DB68B24AE6
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 08:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7011AC42C;
	Tue,  3 Dec 2024 08:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YVOvFGoF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29924149C7D
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 08:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733213588; cv=none; b=Gik+Mxe5IJjmHlVKXTvnEdcrYZhRvFvSQwb33ZD59oAo46baQDankfj8w57hPSDuCOiRniqKbSVCUTJLCkm4b0rCgy6jdcFH7cWcKIzYVkgWDHdUHlJcmocX4n+6DvoLDxRpOfB+OvRlkKAqTm81ygkqUu8RFJOevjDVTE/xXtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733213588; c=relaxed/simple;
	bh=syW7r3Ikrs3k9k6LGmXEqdNDCCEczUdWAzK0e9bMF6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kzTnH4XGaBELUmT66Tx3STCdJxfuG+NnN5PSNofQjrtykIx3StjuX90QgvPBbu05RBTCzmGsafgUOjo3kN9XgTNp7ipfgCKfg0uktZKCGc9wRRF3aHl+5fDfWzZXWdGUtYusUHy5lnNxRL6jG2SBIzLIktDDKTDpG3GfN/JU5U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YVOvFGoF; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385d7f19f20so2286451f8f.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Dec 2024 00:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733213584; x=1733818384; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XQBCr5idF+366q7kGe5Nr4qwyBHmQX5kBS5J7rawXFQ=;
        b=YVOvFGoFeI3oEsGnnMssi4BwLrU3H57ZRorfsuZJd8B6N0+ZvNEXZVPWtT2TAovwqv
         3t7gGiWvDXEFqmJFY0s9gSTSIzHLqCkYqG22glIfZ+cGAq6X6ehgqfBWbZTaPm2bacTE
         A1Yc4H0ybUW1ZwXmTxZFKQLRvUOlu9q+wDoBqc0vdROjbsoq7ejJN8Oldo3gIG19h/aa
         BSbYruaAoTXkMMRixNbJ3ME1Ugm6i133F+j4sXnjtkH4tnGXCkoPB23HgoRPK4/54k7G
         cJSs+CT5bQTFh/Wb545I/BgSQqaC1XXRh7phtqisB3qGlvE4lF7pUEkntvNwpPyUXHbq
         uwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733213584; x=1733818384;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQBCr5idF+366q7kGe5Nr4qwyBHmQX5kBS5J7rawXFQ=;
        b=gd7AB6m576m+qw0RMQ3fdkHrebYjo7LZ8BOQxBgpB/M7kL4hSOYM8fLreWTvNTJ1ye
         GsU9tmoKt1wZYrpkDgm0CcPlbz+6zOXMhpmvUwt+94/UV/zaSdgsN039Ao9p9fjxhF3p
         JMM0EAPmint72MZV1OVhNXEr/hco7KRScdGhE4IGnW3FdH516AY0XsAwHcrCvrQmBQV0
         192+0VhODJJ3cJoRDLyxmURNguN4YTXrLccyA3g4P3xChnZV1ZWUvbgWWi2PBbJgWar+
         l7AirXPRBhY1ib/3Fd8wGT0YST+ncAfZ9Pf12H41bTAfcTSVAvXG8MUNojY/mi/sL/3T
         Xw8g==
X-Forwarded-Encrypted: i=1; AJvYcCW8RGkcjjNf0YiMbDW23vBF+MUS/2DwiA1QTKE51Tyy0MWL1exXedO8uMnl7lbJF1vZzutq/yi1CQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc/W98pu2sEOI/wGucs7yu/tYBWsyElqA1qdRIMdMW3VQDr8WC
	gfY8ZsRiB8i+PLnzZ/ciVFEnKQI5iDXbJaO9dPlfGuvw/8dYbntYyXJT3F68Pbc=
X-Gm-Gg: ASbGncu1HlN0WTI0/nPHqlshZ082Ph9Bdyz6CCT9ljCCUe97VY8rP6ulyMQzm94zWWJ
	daU2CFImgxP9VLXsM9bcyAlgiY7na0WJTp4UFY4t8fIvPfm0j6K2Sdq5PTj/0I+/RM5l1TfLPHZ
	FiuJxlzl96aWzDIIpXLy3WlUy9SSCGLSvcdatR+NobXnOFpq2Dhj9w5CEcFCqFjxLIgsbO4FM+C
	ScBnU4CDy7qWBwsBWhB6fGtnDgF6wi/0aY+jasLUatmpZrn9yJQL3jFhithibHsWM3BntI=
X-Google-Smtp-Source: AGHT+IFQ3Jr41zuCNMLRE84EPjfraFDN5DlqYQ7F6Xrmb7+4aYpuMblLBRGltYy+wsYfCULKaWW2Aw==
X-Received: by 2002:a5d:64ab:0:b0:385:e1e5:fff3 with SMTP id ffacd0b85a97d-385fd424e01mr1328919f8f.57.1733213584345;
        Tue, 03 Dec 2024 00:13:04 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa74f2c7sm215212575e9.2.2024.12.03.00.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 00:13:03 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 03 Dec 2024 09:12:59 +0100
Subject: [PATCH v3 1/2] OPP: add index check to assert to avoid buffer
 overflow in _read_freq()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-topic-opp-fix-assert-index-check-v3-1-1d4f6f763138@linaro.org>
References: <20241203-topic-opp-fix-assert-index-check-v3-0-1d4f6f763138@linaro.org>
In-Reply-To: <20241203-topic-opp-fix-assert-index-check-v3-0-1d4f6f763138@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7009;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=syW7r3Ikrs3k9k6LGmXEqdNDCCEczUdWAzK0e9bMF6M=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnTr2NoPQnwmRnznLxHO6d1Htw98d1lZyvul3gjHEf
 D+7AH0CJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ069jQAKCRB33NvayMhJ0YgjD/
 0Tq1VjxsXB3Swg5Lvx7ny44oHXaXiXtLhNJl/C1uLsU1tHMyL8CW1fF8SkaWfTy6acdic8jTtEXJVS
 iPt/YD6ypggVW1zf6fJ4LXvwDf7DIYK0T0LiS3bxE4Zuwa0zQCFazfg+tcwP7UjNJ4OhFqt0uiv0+4
 t6xBYNNL2/dH+nUbWYTFzgXtZLsSaGedceJ/HL2OmYxNA89SRlGpmCP4EEJ2KgkmFoRVgEHT9Lb3/D
 Sbhdh1DwfQRPJyNgZM1Jx3YuSLMLo/DWc5YwHNio9JabvJNB+ksbJAfRvT0fZRTNpsX3aB6Vn81LgA
 uHTmeD5l6bt6f2tCyuXIx2EIdUOrBIUZo7tLEOh6c9TmKrJEXV/Xx9dZjmqHeqDQSRkJMZCxIy0qIY
 xjgo7RppTSGrqexTZB8nRsm7GXBq+3zSpu/4E6zjCLAlHylFQHBB20bVtYGhXzoaWyGDWNgFwS8er7
 B/RMDI6i3xZVit2VNUDFQ6CIvkuLo5uRXhxWdwNmv1BJJy1l3tzHZ/2f8tIvO/4w6qlGfEwd+ekcs0
 1H5z9qw7D1J4sl9jfCAYemfIBQmeNJkHgn94y/FHiHJGnkkRwxnHd4DT1lJ1fD1EePqPAuYStjKxIS
 myXpT4J/zXJM0VbkmFnRcamPXbY178eV9LEhJwfAwhxZZflpYQgJD82lzUQg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Pass the freq index to the assert function to make sure
we do not read a freq out of the opp->rates[] table when called
from the indexed variants:
dev_pm_opp_find_freq_exact_indexed() or
dev_pm_opp_find_freq_ceil/floor_indexed().

Add a secondary parameter to the assert function, unused
for assert_single_clk() then add assert_clk_index() which
will check for the clock index when called from the _indexed()
find functions.

Fixes: 142e17c1c2b4 ("OPP: Introduce dev_pm_opp_find_freq_{ceil/floor}_indexed() APIs")
Fixes: a5893928bb17 ("OPP: Add dev_pm_opp_find_freq_exact_indexed()")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/opp/core.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 1b4fe67dc7366dca9e8daa828d01839a20793ca6..ebe7887a27d3c1dd6c652c8bf9f5f9a285d7e74e 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -101,11 +101,21 @@ struct opp_table *_find_opp_table(struct device *dev)
  * representation in the OPP table and manage the clock configuration themselves
  * in an platform specific way.
  */
-static bool assert_single_clk(struct opp_table *opp_table)
+static bool assert_single_clk(struct opp_table *opp_table,
+			      unsigned int __always_unused index)
 {
 	return !WARN_ON(opp_table->clk_count > 1);
 }
 
+/*
+ * Returns true if clock table is large enough to contain the clock index.
+ */
+static bool assert_clk_index(struct opp_table *opp_table,
+			     unsigned int index)
+{
+	return opp_table->clk_count > index;
+}
+
 /**
  * dev_pm_opp_get_bw() - Gets the bandwidth corresponding to an opp
  * @opp:	opp for which bandwidth has to be returned for
@@ -524,12 +534,12 @@ static struct dev_pm_opp *_opp_table_find_key(struct opp_table *opp_table,
 		unsigned long (*read)(struct dev_pm_opp *opp, int index),
 		bool (*compare)(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
 				unsigned long opp_key, unsigned long key),
-		bool (*assert)(struct opp_table *opp_table))
+		bool (*assert)(struct opp_table *opp_table, unsigned int index))
 {
 	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
 
 	/* Assert that the requirement is met */
-	if (assert && !assert(opp_table))
+	if (assert && !assert(opp_table, index))
 		return ERR_PTR(-EINVAL);
 
 	mutex_lock(&opp_table->lock);
@@ -557,7 +567,7 @@ _find_key(struct device *dev, unsigned long *key, int index, bool available,
 	  unsigned long (*read)(struct dev_pm_opp *opp, int index),
 	  bool (*compare)(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
 			  unsigned long opp_key, unsigned long key),
-	  bool (*assert)(struct opp_table *opp_table))
+	  bool (*assert)(struct opp_table *opp_table, unsigned int index))
 {
 	struct opp_table *opp_table;
 	struct dev_pm_opp *opp;
@@ -580,7 +590,7 @@ _find_key(struct device *dev, unsigned long *key, int index, bool available,
 static struct dev_pm_opp *_find_key_exact(struct device *dev,
 		unsigned long key, int index, bool available,
 		unsigned long (*read)(struct dev_pm_opp *opp, int index),
-		bool (*assert)(struct opp_table *opp_table))
+		bool (*assert)(struct opp_table *opp_table, unsigned int index))
 {
 	/*
 	 * The value of key will be updated here, but will be ignored as the
@@ -593,7 +603,7 @@ static struct dev_pm_opp *_find_key_exact(struct device *dev,
 static struct dev_pm_opp *_opp_table_find_key_ceil(struct opp_table *opp_table,
 		unsigned long *key, int index, bool available,
 		unsigned long (*read)(struct dev_pm_opp *opp, int index),
-		bool (*assert)(struct opp_table *opp_table))
+		bool (*assert)(struct opp_table *opp_table, unsigned int index))
 {
 	return _opp_table_find_key(opp_table, key, index, available, read,
 				   _compare_ceil, assert);
@@ -602,7 +612,7 @@ static struct dev_pm_opp *_opp_table_find_key_ceil(struct opp_table *opp_table,
 static struct dev_pm_opp *_find_key_ceil(struct device *dev, unsigned long *key,
 		int index, bool available,
 		unsigned long (*read)(struct dev_pm_opp *opp, int index),
-		bool (*assert)(struct opp_table *opp_table))
+		bool (*assert)(struct opp_table *opp_table, unsigned int index))
 {
 	return _find_key(dev, key, index, available, read, _compare_ceil,
 			 assert);
@@ -611,7 +621,7 @@ static struct dev_pm_opp *_find_key_ceil(struct device *dev, unsigned long *key,
 static struct dev_pm_opp *_find_key_floor(struct device *dev,
 		unsigned long *key, int index, bool available,
 		unsigned long (*read)(struct dev_pm_opp *opp, int index),
-		bool (*assert)(struct opp_table *opp_table))
+		bool (*assert)(struct opp_table *opp_table, unsigned int index))
 {
 	return _find_key(dev, key, index, available, read, _compare_floor,
 			 assert);
@@ -672,7 +682,8 @@ struct dev_pm_opp *
 dev_pm_opp_find_freq_exact_indexed(struct device *dev, unsigned long freq,
 				   u32 index, bool available)
 {
-	return _find_key_exact(dev, freq, index, available, _read_freq, NULL);
+	return _find_key_exact(dev, freq, index, available, _read_freq,
+			       assert_clk_index);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_exact_indexed);
 
@@ -732,7 +743,8 @@ struct dev_pm_opp *
 dev_pm_opp_find_freq_ceil_indexed(struct device *dev, unsigned long *freq,
 				  u32 index)
 {
-	return _find_key_ceil(dev, freq, index, true, _read_freq, NULL);
+	return _find_key_ceil(dev, freq, index, true, _read_freq,
+			      assert_clk_index);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_ceil_indexed);
 
@@ -785,7 +797,7 @@ struct dev_pm_opp *
 dev_pm_opp_find_freq_floor_indexed(struct device *dev, unsigned long *freq,
 				   u32 index)
 {
-	return _find_key_floor(dev, freq, index, true, _read_freq, NULL);
+	return _find_key_floor(dev, freq, index, true, _read_freq, assert_clk_index);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor_indexed);
 
@@ -1727,7 +1739,7 @@ void dev_pm_opp_remove(struct device *dev, unsigned long freq)
 	if (IS_ERR(opp_table))
 		return;
 
-	if (!assert_single_clk(opp_table))
+	if (!assert_single_clk(opp_table, 0))
 		goto put_table;
 
 	mutex_lock(&opp_table->lock);
@@ -2079,7 +2091,7 @@ int _opp_add_v1(struct opp_table *opp_table, struct device *dev,
 	unsigned long tol, u_volt = data->u_volt;
 	int ret;
 
-	if (!assert_single_clk(opp_table))
+	if (!assert_single_clk(opp_table, 0))
 		return -EINVAL;
 
 	new_opp = _opp_allocate(opp_table);
@@ -2934,7 +2946,7 @@ static int _opp_set_availability(struct device *dev, unsigned long freq,
 		return r;
 	}
 
-	if (!assert_single_clk(opp_table)) {
+	if (!assert_single_clk(opp_table, 0)) {
 		r = -EINVAL;
 		goto put_table;
 	}
@@ -3010,7 +3022,7 @@ int dev_pm_opp_adjust_voltage(struct device *dev, unsigned long freq,
 		return r;
 	}
 
-	if (!assert_single_clk(opp_table)) {
+	if (!assert_single_clk(opp_table, 0)) {
 		r = -EINVAL;
 		goto put_table;
 	}

-- 
2.34.1


