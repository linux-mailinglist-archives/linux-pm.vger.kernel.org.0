Return-Path: <linux-pm+bounces-27757-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F440AC71FD
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 22:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E0AD166B80
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 20:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949962206B8;
	Wed, 28 May 2025 20:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qVYpWaak"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E841DE8AD
	for <linux-pm@vger.kernel.org>; Wed, 28 May 2025 20:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748462656; cv=none; b=MNV9EBtRjvCiT3Y3CrqWfyZWo68HdL3NW0rxG4RkHVRI+Bxe99aC04bCcOuZ/G0oLpPOcvumDg1PO+MpyQxQRD3MA9LOehjEFXv2girfM0tScAQOqfDJpjMxftQf8ceZ9I5CTmAyOZ+zk5miB5wuUeL6ho4W6Mix1EczkAcf8b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748462656; c=relaxed/simple;
	bh=5cQO+L78pLKPYpwYs/yL4n0lRCh2JasU1lxwZ8R8b/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QqZJzCHOCYSmDVYyDes0TzbpJ7wQCSXGkv/SqHA/NPdYOY4pB84BHfC+hVTuFeq2dhcUsTIzseLVVFWLk1HBapo/IdVDMPYlcGoIx3p75Mb2zGD5l7eyP4K2PxKP9ZXpYLsc9feYrmQKRpxV2gwzQ2u2cUuuLTeKpqWnhDLL3aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qVYpWaak; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7fd581c2bf4so195403a12.3
        for <linux-pm@vger.kernel.org>; Wed, 28 May 2025 13:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748462652; x=1749067452; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N26Hic5+yJnYiyH/0mc17rp1cTeT3TWY7aBGNxZR5uI=;
        b=qVYpWaakoxUPyD3KZe2NG2RdcHdqg60rsXKfTOdSQ2bXHzaX/s7A7vvEGpaKB7tOBd
         1/UNPN2QqSVex+Rp9yOWhftzlJeRs8MwzHe2y5R07jy+Cn2VCuB35ND2oqIOGyqM+Aiv
         dK/LxQ1f6uss5faWuRqHGSQQaX7tfzFdWhksgW/ZOTrSg4mWnPAi6dscysiJFGi0Teyk
         ON9vhuD6iOMhSKfwFsQZcn8ED4w8e8NA2569BODBBcnfduS0yq1Q5dN1CDS8iVMss3aH
         qrnfa2XVWfElcMNLmjPUnj91OQCmKxTveBhEXRS/lGsyhIM93p9AUvgywFGEojqgoONl
         W9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748462652; x=1749067452;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N26Hic5+yJnYiyH/0mc17rp1cTeT3TWY7aBGNxZR5uI=;
        b=UjWFR4Kcu5wL4wIWbqSlDSj+tBXp3OaofcO3H4OeWA5WhZvn1Z4YTApXQ7gRpFRevG
         4snbZv7hLnSwM7RQYaTXCOIuDKQwo5UG8YJ/+M9RFowaPQjzgj7cx8VxPoFxv0TONRIr
         5Q9g9D6lIHQwUKeRns/h4CxK6QVu+ajmGKtQ6QEXsC3eNHG0Weel+WR3saohJiVbHaXA
         7ZphsDClKM4dLGW5/uHmxUpTLYODDygqiV0bpPSy6RB6MMMm9a/tPao3/a8qK/aZg+jd
         CIORJ0M/f/Vv7kZ0XJqgdr0tNi6vwUQQB6zS6zQW1MXTQmhvdCRmlSYQOLDt8YNjK1rq
         kwwA==
X-Gm-Message-State: AOJu0YyihZg1BsMOKn1a9831lF7H3rBXmZkNXN2pAfLETcSRUIrppHTY
	l9uUihA40TvBnfxeHJ0wFYcQ03/zr593xopgS9xRKp3F5skOd6zWuqNLhPyIyItO0Ds=
X-Gm-Gg: ASbGnctyuNrD6dJCbUrvpDfVA9dllpniZtFiVu59ULVPZCu6+Ut42VTMDENOR/gLgvd
	seMF2SUX4p9JvuJuxt9WDWHEZhQb8/QOH1CkCEFpe9Pu8xgd2sxCvRnXfy6dyMjGCLUrFW5xTPk
	ooKi+vvXG1Pyo5YHUMRg9LB1qbzy/QEpdatUi8NxU61IjqZUJ4UHNfM2LoghyehHkSwLj5MC96X
	gu+B1zR3m+BSUHuoHen91BX4+7JxZGsHQGCpqNvbU8/aY53GkuOIXN/eXTz/Kep/l/33mAASE7s
	zv3Joagixsl6J4t6N4izpmkdB/nCFywqzIBPiYEV7Q/FURj7/Q==
X-Google-Smtp-Source: AGHT+IHl1uBTaNVAKk1dWKZ7RK+rWsbhvZBMzF0a11+N/7GdicJLFV9XxyGOLKPUxpEoTr7Cf/MDSg==
X-Received: by 2002:a17:90b:1dce:b0:311:c939:c848 with SMTP id 98e67ed59e1d1-311c939c979mr10628396a91.0.1748462652040;
        Wed, 28 May 2025 13:04:12 -0700 (PDT)
Received: from localhost ([97.126.182.119])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3121b71c6fcsm30800a91.12.2025.05.28.13.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 13:04:11 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
Date: Wed, 28 May 2025 13:03:43 -0700
Subject: [PATCH RFC] pmdomain: core: add hierarchy support for onecell
 providers
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250528-pmdomain-hierarchy-onecell-v1-1-851780700c68@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAB5sN2gC/x3MwQqDMAwA0F+RnBfQYjfZVdgHeB0eQhvXgLaSg
 kzEf7d4fJd3QGYVzvCuDlDeJEuKBc2jAhco/hjFF4Opja2t6XBdfFpIIgZhJXVhxxTZ8Twjtc+
 JfPvynbVQglV5kv+df2H49DCe5wUn5/NlcQAAAA==
X-Change-ID: 20250528-pmdomain-hierarchy-onecell-a46fad47d855
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=openpgp-sha256; l=8644; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=5cQO+L78pLKPYpwYs/yL4n0lRCh2JasU1lxwZ8R8b/Q=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBoN2w6JbEjJ8wJRjrtWWnjW0w/SYrHWc2fbit/N
 QgBbsPhyAuJAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCaDdsOgAKCRBZNxia0/vG
 ZaqWD/4phrMGZH0C5VSqI7RHowSonhUfCic/ghX8bby1CIL3dFbZB7y03GcNS8dqg7XB+ZTGCBp
 cf0+vaNkdaMH+sg7KNi36E2VtC22jExmB2PfLIqKFFYm+BHBY+qAcD89UjuMiGNEUkY8ptGOGw0
 /X+WubRNlLF6LAlSsKRhkrgxhk1eS6+ptuGLJUGoqJ5ylUVlgx2kgXwVbykn1VZbHEYwk/XhxNj
 XfGa1y9cqyD8ZQxuwS+7dPmm6+1Vvl0ij754oWFuxRaJScqrNU+KNRAyuz15y8Iw3RInWia/Lml
 2HANSV/eLQcqRGKZzWGALWUycxTu0cWlxcrGa56uDitf7rFR1BlqBmXuYitAxlg0kijK2uezV9g
 vSGSzlMPSp064CRLAtzdP8+Acn5sO9FBs3Ydxr8mLXslf/AcP92GK1pRC3sV6NLi5Upb/Lc912z
 I0+GXhgj05cmugQR7tfzH9BbLNHED4CsFmCBErmWAJijxOyu/J8OcLLHA1Lxz5EWMvP6fG2RLtM
 snuMPdVTl1e9afXShCm1n7kXni2cCgj8a/hzCil69n6MDWKM5oKl2b4cZYX1m0W1nGij74bFVII
 fdG1eFQLKV7JAQWubE2meZBxflGv8BsyerGYnMbfUOl8VQFAUMQCu+4OXTHxEzkWgha/2ek+KEH
 ILZBvp5SK6NxcBg==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665

Currently, PM domains can only support hierarchy for simple
providers (e.g. ones with #power-domain-cells = 0).

Add support for oncell providers as well by adding a new property
`power-domains-child-ids` to describe the parent/child relationship.

For example, an SCMI PM domain provider might be a subdomain of
multiple parent domains. In this example, the parent domains are
MAIN_PD and WKUP_PD:

    scmi_pds: protocol@11 {
        reg = <0x11>;
        #power-domain-cells = <1>;
        power-domains = <&MAIN_PD>, <&WKUP_PD>;
        power-domains-child-ids = <15>, <19>;
    };

With the new property, child domain 15 (scmi_pds 15) becomes a
subdomain of MAIN_PD, and child domain 19 (scmi_pds 19) becomes a
subdomain of WKUP_PD.

Note: this idea was previously discussed on the arm-scmi mailing
list[1] where this approach was proposed by Ulf.  This is my initial
attempt at implementing it for discussion.  I'm definitely a noob at
adding support new DT properties, so I got some help from an AI friend
named Claude in writing this code, so feedback on the apprach is
welcomed.

[1] https://lore.kernel.org/arm-scmi/CAPDyKFo_P129sVirHHYjOQT+QUmpymcRJme9obzKJeRgO7B-1A@mail.gmail.com/

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 Documentation/devicetree/bindings/power/power-domain.yaml |  39 ++++++++++++++++++++++++++++++++
 drivers/pmdomain/core.c                                   | 111 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 150 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/power-domain.yaml b/Documentation/devicetree/bindings/power/power-domain.yaml
index 8fdb529d560b..1db82013e407 100644
--- a/Documentation/devicetree/bindings/power/power-domain.yaml
+++ b/Documentation/devicetree/bindings/power/power-domain.yaml
@@ -68,6 +68,21 @@ properties:
       by the given provider should be subdomains of the domain specified
       by this binding.
 
+  power-domains-child-ids:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      An array of child domain IDs that correspond to the power-domains
+      property. This property is only applicable to power domain providers
+      with #power-domain-cells > 0 (i.e., providers that supply multiple
+      power domains). It specifies which of the provider's child domains
+      should be associated with each parent domain listed in the power-domains
+      property. The number of elements in this array must match the number of
+      phandles in the power-domains property. Each element specifies the child
+      domain ID (index) that should be made a subdomain of the corresponding
+      parent domain. This enables hierarchical power domain structures where
+      different child domains from the same provider can have different
+      parent domains.
+
 required:
   - "#power-domain-cells"
 
@@ -133,3 +148,27 @@ examples:
             min-residency-us = <7000>;
         };
     };
+
+  - |
+    // Example of power-domains-child-ids usage
+    MAIN_PD: main-power-controller {
+        compatible = "foo,main-power-controller";
+        #power-domain-cells = <0>;
+    };
+
+    WKUP_PD: wkup-power-controller {
+        compatible = "foo,wkup-power-controller";
+        #power-domain-cells = <0>;
+    };
+
+    scmi_pds: protocol@11 {
+        reg = <0x11>;
+        #power-domain-cells = <1>;
+        power-domains = <&MAIN_PD>, <&WKUP_PD>;
+        power-domains-child-ids = <15>, <19>;
+    };
+
+    // In the above example:
+    // - Child domain 15 (scmi_pds 15) becomes a subdomain of MAIN_PD
+    // - Child domain 19 (scmi_pds 19) becomes a subdomain of WKUP_PD
+    // - Other child domains (0-14, 16-18, 20+) have no parent relationship
diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index d6c1ddb807b2..d9ae4f1d35ca 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2441,6 +2441,9 @@ static LIST_HEAD(of_genpd_providers);
 /* Mutex to protect the list above. */
 static DEFINE_MUTEX(of_genpd_mutex);
 
+static int of_genpd_parse_child_ids(struct device_node *np,
+				    struct genpd_onecell_data *data);
+
 /**
  * genpd_xlate_simple() - Xlate function for direct node-domain mapping
  * @genpdspec: OF phandle args to map into a PM domain
@@ -2635,6 +2638,14 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 	if (ret < 0)
 		goto error;
 
+	/* Parse power-domains-child-ids property to establish parent-child relationships */
+	ret = of_genpd_parse_child_ids(np, data);
+	if (ret < 0 && ret != -ENOENT) {
+		pr_err("Failed to parse power-domains-child-ids for %pOF: %d\n", np, ret);
+		of_genpd_del_provider(np);
+		goto error;
+	}
+
 	return 0;
 
 error:
@@ -2734,6 +2745,106 @@ static struct generic_pm_domain *genpd_get_from_provider(
 	return genpd;
 }
 
+/**
+ * of_genpd_parse_child_ids() - Parse power-domains-child-ids property
+ * @np: Device node pointer associated with the PM domain provider.
+ * @data: Pointer to the onecell data associated with the PM domain provider.
+ *
+ * Parse the power-domains and power-domains-child-ids properties to establish
+ * parent-child relationships for PM domains. The power-domains property lists
+ * parent domains, and power-domains-child-ids lists which child domain IDs
+ * should be associated with each parent.
+ *
+ * Returns 0 on success, -ENOENT if properties don't exist, or negative error code.
+ */
+static int of_genpd_parse_child_ids(struct device_node *np,
+				    struct genpd_onecell_data *data)
+{
+	struct of_phandle_args parent_args;
+	struct generic_pm_domain *parent_genpd, *child_genpd;
+	u32 *child_ids;
+	int num_parents, num_child_ids, i, ret;
+
+	/* Check if both properties exist */
+	num_parents = of_count_phandle_with_args(np, "power-domains", "#power-domain-cells");
+	if (num_parents <= 0)
+		return -ENOENT;
+
+	num_child_ids = of_property_count_u32_elems(np, "power-domains-child-ids");
+	if (num_child_ids <= 0)
+		return -ENOENT;
+
+	if (num_parents != num_child_ids) {
+		pr_err("power-domains (%d) and power-domains-child-ids (%d) count mismatch for %pOF\n",
+		       num_parents, num_child_ids, np);
+		return -EINVAL;
+	}
+
+	child_ids = kcalloc(num_child_ids, sizeof(*child_ids), GFP_KERNEL);
+	if (!child_ids)
+		return -ENOMEM;
+
+	ret = of_property_read_u32_array(np, "power-domains-child-ids", child_ids, num_child_ids);
+	if (ret) {
+		pr_err("Failed to read power-domains-child-ids for %pOF: %d\n", np, ret);
+		goto out_free;
+	}
+
+	/* For each parent domain, establish parent-child relationship */
+	for (i = 0; i < num_parents; i++) {
+		ret = of_parse_phandle_with_args(np, "power-domains",
+						 "#power-domain-cells", i, &parent_args);
+		if (ret) {
+			pr_err("Failed to parse parent domain %d for %pOF: %d\n", i, np, ret);
+			goto out_free;
+		}
+
+		/* Get the parent domain */
+		parent_genpd = genpd_get_from_provider(&parent_args);
+		of_node_put(parent_args.np);
+		if (IS_ERR(parent_genpd)) {
+			pr_err("Failed to get parent domain %d for %pOF: %ld\n",
+			       i, np, PTR_ERR(parent_genpd));
+			ret = PTR_ERR(parent_genpd);
+			goto out_free;
+		}
+
+		/* Validate child ID is within bounds */
+		if (child_ids[i] >= data->num_domains) {
+			pr_err("Child ID %u out of bounds (max %u) for parent %d in %pOF\n",
+			       child_ids[i], data->num_domains - 1, i, np);
+			ret = -EINVAL;
+			goto out_free;
+		}
+
+		/* Get the child domain */
+		child_genpd = data->domains[child_ids[i]];
+		if (!child_genpd) {
+			pr_err("Child domain %u is NULL for parent %d in %pOF\n",
+			       child_ids[i], i, np);
+			ret = -EINVAL;
+			goto out_free;
+		}
+
+		/* Establish parent-child relationship */
+		ret = genpd_add_subdomain(parent_genpd, child_genpd);
+		if (ret) {
+			pr_err("Failed to add child domain %u to parent %d in %pOF: %d\n",
+			       child_ids[i], i, np, ret);
+			goto out_free;
+		}
+
+		pr_debug("Added child domain %u (%s) to parent %s for %pOF\n",
+			 child_ids[i], child_genpd->name, parent_genpd->name, np);
+	}
+
+	ret = 0;
+
+out_free:
+	kfree(child_ids);
+	return ret;
+}
+
 /**
  * of_genpd_add_device() - Add a device to an I/O PM domain
  * @genpdspec: OF phandle args to use for look-up PM domain

---
base-commit: 0ff41df1cb268fc69e703a08a57ee14ae967d0ca
change-id: 20250528-pmdomain-hierarchy-onecell-a46fad47d855

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>


