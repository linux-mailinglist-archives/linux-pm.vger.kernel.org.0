Return-Path: <linux-pm+bounces-41255-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eM0BBIBncWmaGgAAu9opvQ
	(envelope-from <linux-pm+bounces-41255-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 00:55:44 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A315FB64
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 00:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 080944E7DFF
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 23:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B63330668;
	Wed, 21 Jan 2026 23:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UqAc/n8A"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8928243637C
	for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 23:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769039738; cv=none; b=U6j6f7ToHXGLcNMHnX8xatQ1bCpwm7qfgdUNV5pDnoSjnlOZwPie3gZnq+EqZV6QW/WimBVMsw3HDxPItrw75PF9SOfvBmNK39sBJIPO/5pJj8k844D9KyydnyXuZMScIJjXOXImR5HuKosN6RCZ5wdms8tBjBWvmdRUqnLjGIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769039738; c=relaxed/simple;
	bh=wqs3ot1lzYp1uxjm9+RCV8ylRHq0mF6h93+LA8PtmTw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ngowAj0pCtZXEoh1ni6F+v6yjZObFkYPKLViTL2SthH9O8PTjgBFpEZMomhUvFyXHK7NXla2HxordO9Hq0lh7TYStzGRr1baZoyIMnRutQt+pH283G+l9aycZOvgfT84NBn0Fd4XidYQflAEUmtI76Xi0aGT+/8IhoBl5z0yBGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UqAc/n8A; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29f30233d8aso2498285ad.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 15:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769039735; x=1769644535; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PjllSAPGQe9z4wytVvsWXJp6Q+2QEqXJfq4b/O+DazI=;
        b=UqAc/n8AoHRDmZF/KIIQqbnV6wOhlWf7BQky21fuHrQMoa8G0mPnIrEk2sYfuu8jxf
         vHqcOxiI8Px4E/2qkzkkokAyAWq8W9EpNQ9+Gg+Vp9H6wsV+Q+36GCVyQpoS4yUaUkzb
         8oBmRVFwnVGQ+ZA0xrZg1Kx9mt5UoEZ1H2/NTIw5vP9gebjbSAvkEEcMXwLu/vcDub4O
         ZDhdCbTQOWOAv8lA4UOtxINXrQGyQ7IWl5lYpRerROsWu2ENHnfZ3auhxd9zzZ+ucZ9Q
         K+bmdkI1O2nIZPxitYlNWUyFYF0+B6Mfg97OKCrajV8zgq/6MKCCoWBW/oJlQErMkl8Q
         bZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769039735; x=1769644535;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjllSAPGQe9z4wytVvsWXJp6Q+2QEqXJfq4b/O+DazI=;
        b=xNy9902LbjQSOOkumfZc0y46DwbPKEgc8/L/tSkKYrD8xyGFLMJ21ZqxObLKYtbMJf
         wvuEyaiJvyEuRjekLPD/Xjaa7zPODCOv5dSFA2v1qOeLM4amTjzm5+fP8Iv2fadYzM8R
         pvEGAt7u+IFswduMqunXyE/aSRkcvgogYn+ptEQJrcTkm4NYqe/VyDQvQGAlbfiQWjc2
         CM4VA5fGef08k0D3YGira+2FDbeUkeB+9555pIU/YtbIO89qyeYG59NzbVGeiG1cRxPb
         ty60SbpTuHf6soT9CT7Psy6sJPpVRBD4Pj2HTHeM3aJD+DOKJwlnsL03rc8yA/q2fuBI
         1q8A==
X-Forwarded-Encrypted: i=1; AJvYcCVrD1WIWuOagQsUW9U2A6eZzMZcXcsQlRDYq9y/VLoSVluqy87eW5zS4RD9LbfXggWUf0tIqXLlkw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpUmgEZoHEnF7dqZQzqyiIrl3Y+7NO+xEQGJfMm7A0D1XWE9E/
	kZ/kCmLxj/or71RZk/LPQPXe1TorZzWWfkOE8LBWaL/M43610Uqsy2oExEmld/tNe6o=
X-Gm-Gg: AZuq6aKs3y+T9Mhp2/xNeiULcLm2WBZIqzPna8AiNhAz/8giUZdK1Jmuch1wjo7dZTf
	kzKx/wCHdvdmTcMzSWN0/EGNu0ANEyi3Iacz4/FxfMt+9gzPyCAasQinhUFD2X+2SCa4dz6log7
	U7Z+xecFr6ny2ikA8Y+i7f+1X0vJXeWpL/sKZ3zBQDS7pxuEcHKnraBtOoj8Ym4BzpW/PILIpdT
	F7DeYn3QeC/AOC8nFh8N98BDEg1KK7ynY6/73MMq9ZSJs1QJJk53yiQT6qgI1cFFP5NoYbyuMeV
	fZA2DdVXucbE54YUEU4ftvQV+LqMiJkxxgc+ckQ70NO7At9HpGeT5+VCbDKeaR37aIZh0o9xts8
	Qx5bTxDyXD/+xixi/TT/S9M5FH8tv3THjC5hX6j38dvKM5XmHJFTFeS7njjK79EBPPRiPuQ9f2c
	WorhrSWxkM
X-Received: by 2002:a17:902:e750:b0:2a7:7872:8f52 with SMTP id d9443c01a7336-2a77872a27bmr53983595ad.26.1769039734673;
        Wed, 21 Jan 2026 15:55:34 -0800 (PST)
Received: from localhost ([71.212.200.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190d16a8sm165990235ad.39.2026.01.21.15.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 15:55:33 -0800 (PST)
From: "Kevin Hilman (TI)" <khilman@baylibre.com>
Date: Wed, 21 Jan 2026 15:55:33 -0800
Subject: [PATCH RFC v2] of: Add of_parse_map_iter() helper for nexus node
 map iteration
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-topic-lpm-of-map-iterator-v6-18-v2-1-a40bf8e91045@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAHRncWkC/42PQQrCQAxFr1KyNtLU2qorQfAAbsXFdJpqoHXqz
 Dgo4t0N1QNIVj8//z/ygsBeOMAme4HnJEHcVUUxy8BezPXMKK1qKPJiSURrjG4Ui/04oOtwMCN
 KZG+i85gqpBWaisqyLouFaS1oy+i5k8dEOMJhv4OTLi8SNPGcqIkm629AItTp8rxetnVNZrFtz
 LOXxvPcugFO7y/U8+2u38QfuTGBUf1B4iZL1VxB3pJevz9Yh9CQAwEAAA==
X-Change-ID: 20251119-topic-lpm-of-map-iterator-v6-18-a61447423adc
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 devicetree@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=8833; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=wqs3ot1lzYp1uxjm9+RCV8ylRHq0mF6h93+LA8PtmTw=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBpcWd1WL993O8PYDXTzo62Wq4RlUwG0W/MaQPWh
 eF9IsQAKHmJAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCaXFndQAKCRBZNxia0/vG
 ZXicD/9NPuh6q7O6rUhTKer/d8KxiaMnleU+oRey6slWvjYWEV5yzUH1zc+Gho2G6bmwjz7vjMH
 OQvvJS/D4Fz3JGhdiOF0jaiSV6NmAq8WE2qqGHG7ar/rWgaOSUTl7YfUjkVyLtaVMO5Z6nlocTO
 jvQXEINNDxPvGtv6zX9heQ2h3E9Rk9Dnaxh2YIfntzvl/YApQzB5Jgts6N4FB+AI7W0Et7zDoSU
 W1k/I5wWJMk804zV27QNX2IhnNxZM0P9mW3DR24GVI4c+lpJ8lR3Oe5HncwjFWqWemdJnXhhq8Z
 Ck2WPFjm1AfrozOYp6U630WWR3RVeDCVUO9o8JqvjmNbL+BsALf85TBQBhBTBG4HZ/XgeqNVZaR
 NUmaz5UWmba2eco9kplFLd10gkGJhxfs7eTxP8JllHsnv+fssQV/LXK5JRXgy7BOrV4l1/qWaH7
 X/Xmd/+GyLCszXKAGmA7vFWLdJsiRZFeXKM12iERrujgi9pmfsyw5aY+FlofXPe7Fq46Y280pJ8
 g3BrAvqwJvnaE9lqgyTSAHKLAoFhvN5UgbSxhc6NoeidfLbO0WMmB/Jxw4oEru/XGSPSSx8A+5j
 s0FI974Yuhr28Lxp8RLfO0ez8NLnNoANEbvJnsAVm/450uvr2phJsunjHwp1ArmPjelJXb/CJIl
 kTUtz6pYUY3pfrg==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41255-lists,linux-pm=lfdr.de];
	DMARC_NA(0.00)[baylibre.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khilman@baylibre.com,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 66A315FB64
X-Rspamd-Action: no action

Add a new helper function of_parse_map_iter() to simplify parsing of
nexus node maps as defined in the DT spec, section 2.5.1.

This function provides an iterator interface for traversing map entries,
handling the complexity of variable-sized entries based on #<stem>-cells
properties. Each map entry follows the format:
  <child_specifier phandle parent_specifier>

The iterator extracts both the child specifier and parent phandle+args
for each entry, managing all the details of:
- Reading #<stem>-cells from both child and parent nodes
- Calculating variable entry sizes
- Resolving phandles
- Proper node reference management

This eliminates the need for subsystems to manually parse map properties,
reducing code duplication and potential bugs.

This code was developed in collaboration with Claude Code (model:
Sonnet 4.5), which needed some guidance to use existing OF helpers,
iterators etc.

Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
---
Changes in v2:
- Use helpers of_phandle_iterator_init() and of_phandle_iterator_next()
- add missing of_node_put() pointed out in v1
- Link to v1: https://patch.msgid.link/20251119-topic-lpm-of-map-iterator-v6-18-v1-1-1f0075d771a3@baylibre.com
---
 drivers/of/base.c  | 163 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of.h |  13 +++++++++++++
 2 files changed, 176 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 0b65039ece53..8392fe54cf60 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1641,6 +1641,169 @@ int of_parse_phandle_with_args_map(const struct device_node *np,
 }
 EXPORT_SYMBOL(of_parse_phandle_with_args_map);
 
+/**
+ * of_parse_map_iter() - Iterate through entries in a nexus node map
+ * @np:			pointer to a device tree node containing the map
+ * @stem_name:		stem of property names (e.g., "power-domain" for "power-domain-map")
+ * @index:		pointer to iteration index (set to 0 for first call)
+ * @child_args:		pointer to structure to fill with child specifier (can be NULL)
+ * @parent_args:	pointer to structure to fill with parent phandle and specifier
+ *
+ * This function iterates through a nexus node map property as defined in DT spec 2.5.1.
+ * Each map entry has the format: <child_specifier phandle parent_specifier>
+ *
+ * On each call, it extracts one map entry and fills child_args (if provided) with the
+ * child specifier and parent_args with the parent phandle and specifier.
+ * The index pointer is updated to point to the next entry for the following call.
+ *
+ * Example usage::
+ *
+ *  int index = 0;
+ *  struct of_phandle_args child_args, parent_args;
+ *
+ *  while (!of_parse_map_iter(np, "power-domain", &index, &child_args, &parent_args)) {
+ *      // Process child_args and parent_args
+ *      of_node_put(parent_args.np);
+ *  }
+ *
+ * Caller is responsible for calling of_node_put() on parent_args.np.
+ *
+ * Return: 0 on success, -ENOENT when iteration is complete, or negative error code on failure.
+ */
+int of_parse_map_iter(const struct device_node *np,
+		       const char *stem_name,
+		       int *index,
+		       struct of_phandle_args *child_args,
+		       struct of_phandle_args *parent_args)
+{
+	char *cells_name __free(kfree) = kasprintf(GFP_KERNEL, "#%s-cells", stem_name);
+	char *map_name __free(kfree) = kasprintf(GFP_KERNEL, "%s-map", stem_name);
+	char *mask_name __free(kfree) = kasprintf(GFP_KERNEL, "%s-map-mask", stem_name);
+	char *pass_name __free(kfree) = kasprintf(GFP_KERNEL, "%s-map-pass-thru", stem_name);
+	static const __be32 dummy_mask[] = { [0 ... MAX_PHANDLE_ARGS] = cpu_to_be32(~0) };
+	static const __be32 dummy_pass[] = { [0 ... MAX_PHANDLE_ARGS] = cpu_to_be32(0) };
+	struct of_phandle_iterator it;
+	const __be32 *map, *mask, *pass;
+	__be32 child_spec[MAX_PHANDLE_ARGS];
+	u32 child_cells, parent_cells;
+	int i, entry_idx, ret;
+
+	if (!np || !stem_name || !index || !parent_args)
+		return -EINVAL;
+
+	if (!cells_name || !map_name || !mask_name || !pass_name)
+		return -ENOMEM;
+
+	/* Initialize iterator to get the map property */
+	ret = of_phandle_iterator_init(&it, np, map_name, cells_name, -1);
+	if (ret)
+		return ret;
+
+	map = it.cur;
+
+	/* Get child #cells */
+	if (of_property_read_u32(np, cells_name, &child_cells))
+		return -EINVAL;
+
+	/* Get the mask property (optional) */
+	mask = of_get_property(np, mask_name, NULL);
+	if (!mask)
+		mask = dummy_mask;
+
+	/* Get the pass-thru property (optional) */
+	pass = of_get_property(np, pass_name, NULL);
+	if (!pass)
+		pass = dummy_pass;
+
+	/* Iterate through map to find the entry at the requested index */
+	entry_idx = 0;
+	while (it.cur + child_cells + 1 < it.list_end) {
+		/* If this is the entry we're looking for, extract it */
+		if (entry_idx == *index) {
+			/* Save masked child specifier for pass-thru processing */
+			for (i = 0; i < child_cells && i < MAX_PHANDLE_ARGS; i++)
+				child_spec[i] = map[i] & mask[i];
+
+			/* Extract child specifier if requested */
+			if (child_args) {
+				child_args->np = (struct device_node *)np;
+				child_args->args_count = child_cells;
+				for (i = 0; i < child_cells && i < MAX_PHANDLE_ARGS; i++)
+					child_args->args[i] = be32_to_cpu(map[i]);
+			}
+
+			/* Move past child specifier */
+			it.cur += child_cells;
+
+			/* Use iterator to read phandle and get parent node/cells */
+			it.phandle_end = it.cur;
+			ret = of_phandle_iterator_next(&it);
+			if (ret) {
+				if (it.node)
+					of_node_put(it.node);
+				return ret;
+			}
+
+			parent_args->np = it.node;
+			it.node = NULL; /* Ownership transferred to parent_args */
+			parent_cells = it.cur_count;
+			map = it.cur;
+
+			/* Check for malformed properties */
+			if (WARN_ON(parent_cells > MAX_PHANDLE_ARGS)) {
+				of_node_put(parent_args->np);
+				return -EINVAL;
+			}
+
+			/*
+			 * Copy parent specifier into the out_args structure, keeping
+			 * the bits specified in <stem>-map-pass-thru per DT spec 2.5.1
+			 */
+			parent_args->args_count = parent_cells;
+			for (i = 0; i < parent_cells; i++) {
+				__be32 val = map[i];
+
+				if (i < child_cells) {
+					val &= ~pass[i];
+					val |= child_spec[i] & pass[i];
+				}
+
+				parent_args->args[i] = be32_to_cpu(val);
+			}
+
+			/* Advance index for next iteration */
+			(*index)++;
+			return 0;
+		}
+
+		/* Skip this entry: child_cells + phandle + parent_cells */
+		it.cur += child_cells;
+
+		/* Use iterator to read phandle and skip parent cells */
+		it.phandle_end = it.cur;
+		ret = of_phandle_iterator_next(&it);
+		if (ret) {
+			if (it.node)
+				of_node_put(it.node);
+			return ret;
+		}
+
+		/* Move forward to next entry and clean up node reference */
+		it.cur = it.phandle_end;
+		map = it.cur;
+		of_node_put(it.node);
+		it.node = NULL;
+
+		entry_idx++;
+	}
+
+	/* Reached end of map without finding the requested index */
+	if (it.node)
+		of_node_put(it.node);
+	return -ENOENT;
+}
+EXPORT_SYMBOL(of_parse_map_iter);
+
 /**
  * of_count_phandle_with_args() - Find the number of phandles references in a property
  * @np:		pointer to a device tree node containing a list
diff --git a/include/linux/of.h b/include/linux/of.h
index 9bbdcf25a2b4..4908b78ac3e1 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -387,6 +387,10 @@ extern int __of_parse_phandle_with_args(const struct device_node *np,
 extern int of_parse_phandle_with_args_map(const struct device_node *np,
 	const char *list_name, const char *stem_name, int index,
 	struct of_phandle_args *out_args);
+extern int of_parse_map_iter(const struct device_node *np,
+	const char *stem_name, int *index,
+	struct of_phandle_args *child_args,
+	struct of_phandle_args *parent_args);
 extern int of_count_phandle_with_args(const struct device_node *np,
 	const char *list_name, const char *cells_name);
 
@@ -797,6 +801,15 @@ static inline int of_parse_phandle_with_args_map(const struct device_node *np,
 	return -ENOSYS;
 }
 
+static inline int of_parse_map_iter(const struct device_node *np,
+				     const char *stem_name,
+				     int *index,
+				     struct of_phandle_args *child_args,
+				     struct of_phandle_args *parent_args)
+{
+	return -ENOSYS;
+}
+
 static inline int of_count_phandle_with_args(const struct device_node *np,
 					     const char *list_name,
 					     const char *cells_name)

---
base-commit: 3e7f562e20ee87a25e104ef4fce557d39d62fa85
change-id: 20251119-topic-lpm-of-map-iterator-v6-18-a61447423adc

Best regards,
--  
Kevin Hilman (TI) <khilman@baylibre.com>


