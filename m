Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45328104C1
	for <lists+linux-pm@lfdr.de>; Wed,  1 May 2019 06:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfEAEYr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 May 2019 00:24:47 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50873 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfEAEYr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2019 00:24:47 -0400
Received: by mail-it1-f194.google.com with SMTP id q14so8375549itk.0;
        Tue, 30 Apr 2019 21:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=qcB7eahk6uost1tJIP3FkNXq29ur/hHJU+gIkVwerH0=;
        b=uMor4wOx1ZLr2G3gOGF6ab7dikp6w2DgpktbI+wkIPfyzPs6HbtYlbaWKnj+fVmf0o
         XjzvO3lUS+HT1YuHxDq7O5OOBoBfJrzwgwuqA0uG+zkaB1CQOrPwSphZBzfniqtmapyC
         VcnPwMZy5cudBIOtFz+HFRmwjAUYrK/XBxpPBkT2NyTYgDvjGcH3Bddz9q8BkHT/DLgG
         z3+x/rm4UweUS7KUzOBpzfAYH0daxusXgFZdyRFl2Hoxgd9LZPOmpV6B/4z4kicdRu7K
         ZC8MQTwf5tSJwtH1DDRihBbtTpGUhG34IHiDFl/G/n68gLoSjDutVpdKCrJWPX3gxilr
         FH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=qcB7eahk6uost1tJIP3FkNXq29ur/hHJU+gIkVwerH0=;
        b=hWtSZrBYycZLGkVGj8NMr8qA2lipc+OrlczW6YoJLrjhHj2G0L83fKqDaWF5JE8iZo
         Jn/by2W7Q7NjVcY02/kEDhnHcSr4CW9+Ja1p/cd5KuGHs3Db7GajDaxWUc1Zc9DmxD+6
         Nbgtczm3iBkntLuM9LzWhg1c3y77oagxj9+qRJIpLL3XX3BWqUhvzjwuziYnxMxss5wW
         uJ1NmzWKwtzTXBGUMbi/ljtfyWSKuCMB5QhQ8/q8CPshaqNwCtmooqmARud49SpvEZAf
         NgyNgRpNEFoVqGY3SZDgBxkt84Ck+fF6U58OUAvU8hQucwInpuoChsR0e1mftSz2AS3d
         10kA==
X-Gm-Message-State: APjAAAWBMjl2YnahpKOb5BLSVWyz67XZ6AGhy/yQWDMECY2mfssmgHjT
        2osMBhLmcZPN3G1lV3/s/5o=
X-Google-Smtp-Source: APXvYqye8kYvpn5qEeWNrq2qg7L3u8FpZxzy67MpiWA9zuWYliU0Hl5E3x8sIvlGE1xBhILmbj0T4A==
X-Received: by 2002:a24:ca05:: with SMTP id k5mr7268302itg.71.1556684686115;
        Tue, 30 Apr 2019 21:24:46 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id b8sm2569728itb.20.2019.04.30.21.24.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 21:24:45 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: [PATCH 10/18] powercap/intel_rapl: Support multi-die/package
Date:   Wed,  1 May 2019 00:24:19 -0400
Message-Id: <9f6958c231347e639e322de8d8c3de6859559345.1556657368.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1556657368.git.len.brown@intel.com>
References: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1556657368.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Zhang Rui <rui.zhang@intel.com>

RAPL "package" domains are actually implemented in hardware per-die.
Thus, the new multi-die/package systems have mulitple domains
within each physical package.

Update the intel_rapl driver to be "die aware" -- exporting multiple
domains within a single package, when present.
No change on single die/package systems.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-pm@vger.kernel.org
---
 drivers/powercap/intel_rapl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 3c3c0c23180b..9202dbcef96d 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -266,7 +266,7 @@ static struct rapl_domain *platform_rapl_domain; /* Platform (PSys) domain */
 /* caller to ensure CPU hotplug lock is held */
 static struct rapl_package *rapl_find_package_domain(int cpu)
 {
-	int id = topology_physical_package_id(cpu);
+	int id = topology_logical_die_id(cpu);
 	struct rapl_package *rp;
 
 	list_for_each_entry(rp, &rapl_packages, plist) {
@@ -1459,7 +1459,7 @@ static void rapl_remove_package(struct rapl_package *rp)
 /* called from CPU hotplug notifier, hotplug lock held */
 static struct rapl_package *rapl_add_package(int cpu)
 {
-	int id = topology_physical_package_id(cpu);
+	int id = topology_logical_die_id(cpu);
 	struct rapl_package *rp;
 	int ret;
 
-- 
2.18.0-rc0

