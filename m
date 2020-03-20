Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEC7418C6C9
	for <lists+linux-pm@lfdr.de>; Fri, 20 Mar 2020 06:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgCTFXI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Mar 2020 01:23:08 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39548 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgCTFXI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Mar 2020 01:23:08 -0400
Received: by mail-qt1-f193.google.com with SMTP id f20so4001153qtq.6
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2020 22:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:reply-to:organization:content-transfer-encoding;
        bh=Csf6bpTD787DMKpbGi/HCmUvLLM5wbP7kubCge/V+JI=;
        b=GKL/21kiyH6Ijy+HiTm4FhUuL/3ZnIaPh5MRks5H6iWO236Py64ckeVtdF+zZaDYLA
         ZI0LvuyqVDxUqqbg0Hn4u4uT55LtImOKMohq2T1lkGtvJt1+CB03NtU2aYEVgG+N1lU6
         6NDbxF/pLrzsXyFFCEXrLee5pzxxvDr3e0uy5Ffjxg+0pxhE1cgxz4aokI8IsgcwyKfY
         Ohykfeuk3ER4EYVbKzyH47zKXPEpTJaT6crhqlBegm7WrrWPbJt4jeC7cXTYKomdKyCF
         LjymoWVdhk5Iv6SVRMEagj0eQguKD8A1QAAOVcgKrgsuod/pkCPbFqoMcD9qdweGlbGr
         Pn2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:reply-to:organization
         :content-transfer-encoding;
        bh=Csf6bpTD787DMKpbGi/HCmUvLLM5wbP7kubCge/V+JI=;
        b=SibYFFmFPt1mzi1KO2GBXrIqJT+ayE/tAFgfQMmSizHxp3JvBWgdyDwdT+AmE+fSCN
         Y6S3G0GsXNgX+8vKt1X26ct1WAQvxJuFT0JV0KfR4i4DhsY9RkkdpWyUyxqAqh4IPoow
         sMbc34Zhp2tAyiC4eTdrwClujfJWKmGjSnGdUCESIaJj2t36XvfdpKziDR4N3McrxVCI
         KnQu8SHcg+nGr5MoeV41ugUnwc2Hcd19f8Wg6XURBfb/k7ErlbA1eWJEkO9Wo0An3sPR
         ojfKra7TdGC5e00Tfg8DjzxlHLYEsSdyM0hFLJ08im3pxM+jXHM0zzN/2KzUdPJRYZoC
         OU2g==
X-Gm-Message-State: ANhLgQ1IsZ4ENKGu0ViR2B1rSzqZmQeF7d0Sn2GA/6OkBNDzBs0ZVpAq
        TFavQWbA1QT71axGtQWbOQkopdm6
X-Google-Smtp-Source: ADFU+vvWI00h2cWIOVdL9vO0wti4wP6c2dskA3DzARBV40AzSh7nshK/k2a+tiSIBxlzlHJehLPWBw==
X-Received: by 2002:aed:2c06:: with SMTP id f6mr6382584qtd.337.1584681786827;
        Thu, 19 Mar 2020 22:23:06 -0700 (PDT)
Received: from localhost.localdomain (h96-61-82-19.cntcnh.dsl.dynamic.tds.net. [96.61.82.19])
        by smtp.gmail.com with ESMTPSA id w134sm3273383qka.127.2020.03.19.22.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 22:23:06 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     linux-pm@vger.kernel.org
Cc:     Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>
Subject: [PATCH 06/10] tools/power turbostat: Support Elkhart Lake
Date:   Fri, 20 Mar 2020 01:22:44 -0400
Message-Id: <f6708400707fec5cb56600710a9be59266df09ad.1584679387.git.len.brown@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <081c54323b27d8d4b40df6b2375b9e1f6846d827.1584679387.git.len.brown@intel.com>
References: <081c54323b27d8d4b40df6b2375b9e1f6846d827.1584679387.git.len.brown@intel.com>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Chen Yu <yu.c.chen@intel.com>

From a turbostat point of view the Tremont-based Elkhart Lake
is very similar to Goldmont, reuse the code of Goldmont.

Elkhart Lake does not support 'group turbo limit counter'
nor C3, adjust the code accordingly.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 31 ++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index e953afb2e7a1..761146c4f9bc 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3265,6 +3265,7 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
 	case INTEL_FAM6_ATOM_GOLDMONT:	/* BXT */
 	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
 	case INTEL_FAM6_ATOM_GOLDMONT_D:	/* DNV */
+	case INTEL_FAM6_ATOM_TREMONT:	/* EHL */
 		pkg_cstate_limits = glm_pkg_cstate_limits;
 		break;
 	default:
@@ -3336,6 +3337,17 @@ int is_skx(unsigned int family, unsigned int model)
 	}
 	return 0;
 }
+int is_ehl(unsigned int family, unsigned int model)
+{
+	if (!genuine_intel)
+		return 0;
+
+	switch (model) {
+	case INTEL_FAM6_ATOM_TREMONT:
+		return 1;
+	}
+	return 0;
+}
 
 int has_turbo_ratio_limit(unsigned int family, unsigned int model)
 {
@@ -3894,6 +3906,20 @@ void rapl_probe_intel(unsigned int family, unsigned int model)
 		else
 			BIC_PRESENT(BIC_PkgWatt);
 		break;
+	case INTEL_FAM6_ATOM_TREMONT:	/* EHL */
+		do_rapl = RAPL_PKG | RAPL_CORES | RAPL_CORE_POLICY | RAPL_DRAM | RAPL_DRAM_PERF_STATUS | RAPL_PKG_PERF_STATUS | RAPL_GFX | RAPL_PKG_POWER_INFO;
+		if (rapl_joules) {
+			BIC_PRESENT(BIC_Pkg_J);
+			BIC_PRESENT(BIC_Cor_J);
+			BIC_PRESENT(BIC_RAM_J);
+			BIC_PRESENT(BIC_GFX_J);
+		} else {
+			BIC_PRESENT(BIC_PkgWatt);
+			BIC_PRESENT(BIC_CorWatt);
+			BIC_PRESENT(BIC_RAMWatt);
+			BIC_PRESENT(BIC_GFXWatt);
+		}
+		break;
 	case INTEL_FAM6_SKYLAKE_L:	/* SKL */
 	case INTEL_FAM6_CANNONLAKE_L:	/* CNL */
 		do_rapl = RAPL_PKG | RAPL_CORES | RAPL_CORE_POLICY | RAPL_DRAM | RAPL_DRAM_PERF_STATUS | RAPL_PKG_PERF_STATUS | RAPL_GFX | RAPL_PKG_POWER_INFO;
@@ -4295,6 +4321,7 @@ int has_snb_msrs(unsigned int family, unsigned int model)
 	case INTEL_FAM6_ATOM_GOLDMONT:		/* BXT */
 	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
 	case INTEL_FAM6_ATOM_GOLDMONT_D:	/* DNV */
+	case INTEL_FAM6_ATOM_TREMONT:		/* EHL */
 		return 1;
 	}
 	return 0;
@@ -4324,6 +4351,7 @@ int has_c8910_msrs(unsigned int family, unsigned int model)
 	case INTEL_FAM6_CANNONLAKE_L:	/* CNL */
 	case INTEL_FAM6_ATOM_GOLDMONT:	/* BXT */
 	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
+	case INTEL_FAM6_ATOM_TREMONT:	/* EHL */
 		return 1;
 	}
 	return 0;
@@ -4882,7 +4910,8 @@ void process_cpuid()
 	do_slm_cstates = is_slm(family, model);
 	do_knl_cstates  = is_knl(family, model);
 
-	if (do_slm_cstates || do_knl_cstates || is_cnl(family, model))
+	if (do_slm_cstates || do_knl_cstates || is_cnl(family, model) ||
+	    is_ehl(family, model))
 		BIC_NOT_PRESENT(BIC_CPU_c3);
 
 	if (!quiet)
-- 
2.20.1

