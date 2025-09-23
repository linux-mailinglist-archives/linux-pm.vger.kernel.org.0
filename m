Return-Path: <linux-pm+bounces-35234-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC175B969A2
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 17:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7622118A759D
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 15:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A392C25EFBC;
	Tue, 23 Sep 2025 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="flI53IY3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C13126CE35
	for <linux-pm@vger.kernel.org>; Tue, 23 Sep 2025 15:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758641522; cv=none; b=LJLpuNCA7dhGKxNWq4cmOiuP7lnKQtDhscSeFcF9MC3DxuH/7xPttpA9xAjdFmNk4dDS3FixVEL4NsPbINN72fb6+jAWUu14bTacj7zVeXFVyv9mvPHje1vmIWTkmBH/Cdb/s/Mie82Om8EVXX4eLEkGYtK+FN6i/eklayuSjcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758641522; c=relaxed/simple;
	bh=8gD7kOk9XUvcbXPZGRTdVEh45R1zcqpPgpBi0ANs4yI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M5ySYMH5X/+qIlNuWLaucZh0IUJJ+qITsrHt9o9xo9C+R85RHppXn/Dx4xeYJSkbocvPOTNMMN3y+xEjR6/i6bjcOcFSu0xvkigD8eROOx7WQ1d+YjKwVrrQyi0Y8iIfBlEnxxRciMZP3w3ebskj0RCz+93TJhN+Y2/Znp6xxoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=flI53IY3; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8498f5194deso240167585a.1
        for <linux-pm@vger.kernel.org>; Tue, 23 Sep 2025 08:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758641518; x=1759246318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6LeiKW+348aDLti2UK6b0T6va2myl+XeyweBDEl4/Zw=;
        b=flI53IY3kycg0Hj61kNyF4Ihz6U+8YRb5g8k+dvI2mNV9uD6x/p2Zn8QTruxmjJVoF
         eqHJY6GMsSzDMdaa+4g3xE95PRdSX2FNmdJi1oCf7VZMIms7RVJ+6jIvX2PQ7DaarNxs
         ZJ4GoLJ3h9o2pYpgRFM1nu/buiE4lM/E1WijidO3OrEssYoeXjv+VVZdFN8uw0dmw+vh
         NXmIimcjMPyPv2I4V8tGaXJPyStpDslSf0Xapkkik69ksYtLqQf8iFwGVZzu7Jc5vfBW
         kKrILj81BVt/rXtMxRys2+mjJp95URJN1WZM4mz8wa130HjcJF4pos/y8owy9rzZy9cY
         l7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758641518; x=1759246318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6LeiKW+348aDLti2UK6b0T6va2myl+XeyweBDEl4/Zw=;
        b=TpYf1BL9tKYMMYNrSuqbvpjVY1RV/rPDmpLWyh53FlcMyqC1rAv2pX8AQ3oAW+BNXl
         pdcv8zTtFvkvALPiv927/wnjHjDlsO/LbgudJTtQBIdPxWOg4Wnh4eb5r8ZvQvRtc/za
         rz7bd80WJVX1FL+3hWTXrDixtxDfabFQx3z01grX7GT6Bfo7yHk49Yi5zON1T44dwPXR
         GnCbG4QS88tEgIAp3glmSo3c7VQ7RyAYcxpOfpQZ0LFOjMp3uWyXTwm9/7cFH1KPjshs
         unzg6IINAwpfjwfhhXcAvbP84/F2dN1MPHVzLgcRKbD5HgEej26nXzBvli7FDuNsGKhc
         ljrA==
X-Forwarded-Encrypted: i=1; AJvYcCUKui3znk2z7imS9NfKJCXqkFsA584e4lv0xwfw2ydsQg5HOGhDqorK0tikn+7+xV+JQY+WAs2z3w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy805U881sNYBxEUdUxoy+o/5rjDtqn4vpZ0IraOIeeVq4cmE6+
	lW4GWAdFBJyEs8G2Ed3FeW5fHJCtjuS27JVRlzvRF04H4BomoGBngPs6CgZt37lHyIs=
X-Gm-Gg: ASbGncvIgjjQDSRKJ/aMUjqtBL33j4buvtKcrRXCoWhBkZYt3VAyeSG9rWAZRjbH4j7
	FdnEyS/L0hA2RO8LC1WDsLkzrfu65v1GO/6KHJg730VWUJ8yie4ikxR+xGEnGR89rVGLEp9xApk
	mUMHfe4KEUZhgSUcIMcCoGtH/+Rmez7U65jGysTx5wdRGw+2xyabJNCNjct5ewRtH4Fzlrgc3fN
	wKGIUmJVfi5sD5cxSbIxDvf/7bg9/vxJ2KpSm0i6YW0BpywIrmnJ1kbvV8VWrc44cjILhWQ9bGp
	GzUSDcR6KbeJHA0YV1Wae46bVT8rUCVzLnbx0LjrdEzCzwk6jc2q7PxBfyL+i4srOYRm/5riIZ0
	gxxky5+H1tlhEarYNfOQTLOCnku3WQYAVOvXTUrSi
X-Google-Smtp-Source: AGHT+IEtW5XPlbWjdJ2OTuuFZ79VV3pbXaIb8pDBEvWl/VWVRf6bjizM8kYkkTD6em39TFMetUW30A==
X-Received: by 2002:a05:620a:400a:b0:82a:50c5:6138 with SMTP id af79cd13be357-8517456f8f9mr376900285a.40.1758641514217;
        Tue, 23 Sep 2025 08:31:54 -0700 (PDT)
Received: from localhost ([79.173.157.19])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-836305769ecsm1021513185a.42.2025.09.23.08.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 08:31:53 -0700 (PDT)
From: Fam Zheng <fam.zheng@bytedance.com>
To: linux-kernel@vger.kernel.org
Cc: Lukasz Luba <lukasz.luba@arm.com>,
	linyongting@bytedance.com,
	songmuchun@bytedance.com,
	satish.kumar@bytedance.com,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	yuanzhu@bytedance.com,
	Ingo Molnar <mingo@redhat.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	fam.zheng@bytedance.com,
	Zhang Rui <rui.zhang@intel.com>,
	fam@euphon.net,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	liangma@bytedance.com,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	guojinhui.liam@bytedance.com,
	linux-pm@vger.kernel.org,
	Thom Hughes <thom.hughes@bytedance.com>
Subject: [RFC 3/5] x86/parker: Introduce parker kerfs interface
Date: Tue, 23 Sep 2025 15:31:44 +0000
Message-Id: <20250923153146.365015-4-fam.zheng@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250923153146.365015-1-fam.zheng@bytedance.com>
References: <20250923153146.365015-1-fam.zheng@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thom Hughes <thom.hughes@bytedance.com>

This is the control knobs exposed to the boot kernel in order to start
the secondary kernels.

Signed-off-by: Thom Hughes <thom.hughes@bytedance.com>
Signed-off-by: Fam Zheng <fam.zheng@bytedance.com>
---
 arch/x86/Kbuild            |    3 +
 arch/x86/Kconfig           |    2 +
 arch/x86/parker/Kconfig    |    4 +
 arch/x86/parker/Makefile   |    2 +
 arch/x86/parker/internal.h |   54 ++
 arch/x86/parker/kernfs.c   | 1266 ++++++++++++++++++++++++++++++++++++
 include/linux/parker.h     |    7 +
 include/uapi/linux/magic.h |    1 +
 8 files changed, 1339 insertions(+)
 create mode 100644 arch/x86/parker/Kconfig
 create mode 100644 arch/x86/parker/Makefile
 create mode 100644 arch/x86/parker/internal.h
 create mode 100644 arch/x86/parker/kernfs.c
 create mode 100644 include/linux/parker.h

diff --git a/arch/x86/Kbuild b/arch/x86/Kbuild
index f7fb3d88c57b..e50fec2e8e5a 100644
--- a/arch/x86/Kbuild
+++ b/arch/x86/Kbuild
@@ -16,6 +16,9 @@ obj-$(CONFIG_XEN) += xen/
 
 obj-$(CONFIG_PVH) += platform/pvh/
 
+# Multi-kernel support
+obj-$(CONFIG_PARKER) += parker/
+
 # Hyper-V paravirtualization support
 obj-$(subst m,y,$(CONFIG_HYPERV)) += hyperv/
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f86e7072a5ba..490ea18cf783 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -3218,3 +3218,5 @@ config HAVE_ATOMIC_IOMAP
 source "arch/x86/kvm/Kconfig"
 
 source "arch/x86/Kconfig.assembler"
+
+source "arch/x86/parker/Kconfig"
diff --git a/arch/x86/parker/Kconfig b/arch/x86/parker/Kconfig
new file mode 100644
index 000000000000..716a2537f12c
--- /dev/null
+++ b/arch/x86/parker/Kconfig
@@ -0,0 +1,4 @@
+config PARKER
+	bool "Enable multi-kernel host support"
+	depends on X86_64 && SMP
+	select CMA
diff --git a/arch/x86/parker/Makefile b/arch/x86/parker/Makefile
new file mode 100644
index 000000000000..41c40fc64267
--- /dev/null
+++ b/arch/x86/parker/Makefile
@@ -0,0 +1,2 @@
+obj-y += kernfs.o
+$(obj)/kernfs.o: $(obj)/internal.h
diff --git a/arch/x86/parker/internal.h b/arch/x86/parker/internal.h
new file mode 100644
index 000000000000..a6150f1beb77
--- /dev/null
+++ b/arch/x86/parker/internal.h
@@ -0,0 +1,54 @@
+#ifndef _PARKER_INTERNAL_H
+#define _PARKER_INTERNAL_H
+
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/list.h>
+#include <linux/kernfs.h>
+
+/* Currently limit support for devices */
+#define PARKER_MAX_PCI_DEVICES 256
+#define PARKER_MAX_CPUS 512
+
+/* For now, limited to one page,
+ * but could have chained pages for PCI devs + APIC ids */
+struct parker_control_structure {
+	phys_addr_t start_address;
+	bool online;
+	unsigned int parker_id;
+	u32 pci_dev_ids[PARKER_MAX_PCI_DEVICES];
+	unsigned int num_pci_devs;
+	u32 apic_ids[PARKER_MAX_CPUS];
+	unsigned int num_cpus;
+};
+
+struct parker_kernel_device_entry {
+	struct list_head list_entry;
+	struct kernfs_node *kn;
+	struct device *dev;
+};
+
+struct parker_kernel_entry {
+	struct kernfs_node *kn;
+	struct mutex mutex;
+	unsigned int id;
+	bool online;
+	struct cpumask cpu_mask;
+	/* Contiguous pages from CMA for parker physical memory */
+	struct page *physical_memory_pages;
+	unsigned long physical_memory_page_count;
+	/* Control structure PAGE for now */
+	struct page *control_structure_pages;
+	/* Currently always 1 but future proofing */
+	unsigned long control_structure_page_count;
+	struct kernfs_node *kn_devices;
+	/* List of each kernfs node, get kobj from kernfs_node */
+	struct list_head list_devices;
+};
+
+/* Ensure we don't exceed 1 page, if we do. We need to rethink control structure
+ * and chain pages together. */
+static_assert(sizeof(struct parker_control_structure) < PAGE_SIZE,
+	      "struct (parker_control_structure) too large!");
+
+#endif
diff --git a/arch/x86/parker/kernfs.c b/arch/x86/parker/kernfs.c
new file mode 100644
index 000000000000..68f4b7f779b5
--- /dev/null
+++ b/arch/x86/parker/kernfs.c
@@ -0,0 +1,1266 @@
+#define pr_fmt(fmt)	"parker: " fmt
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/syscalls.h>
+#include <linux/kernel.h>
+#include <linux/cpumask.h>
+#include <linux/kexec.h>
+#include <linux/mm.h>
+#include <linux/cma.h>
+#include <linux/parker.h>
+#include <linux/magic.h>
+#include <linux/math.h>
+#include <linux/interrupt.h>
+#include <linux/irqreturn.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/delay.h>
+#include <linux/pci.h>
+#include <linux/device.h>
+#include <linux/reboot.h>
+#include <linux/debugfs.h>
+#include <linux/fs.h>
+#include <linux/fs_parser.h>
+#include <linux/sysfs.h>
+#include <linux/kernfs.h>
+#include <linux/seq_buf.h>
+#include <linux/seq_file.h>
+#include <linux/nospec.h>
+
+#include <asm/mtrr.h>
+#include <asm/realmode.h>
+#include <asm/microcode.h>
+#include <asm/apic.h>
+#include <asm/espfix.h>
+#include <asm/irqdomain.h>
+#include <asm/init.h>
+#include <asm/hw_irq.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/set_memory.h>
+
+#include "internal.h"
+
+static struct cma *parker_cma[MAX_NUMNODES];
+static unsigned long long parker_cma_size;
+static unsigned long long parker_cma_size_in_node[MAX_NUMNODES];
+static struct page *parker_active_control_structure_page;
+
+static struct transition_pagetable_data {
+	struct x86_mapping_info info;
+	pgd_t *pgd;
+	void *stack;
+} transition_pagetable;
+
+static int __init parker_early_cma(char *p)
+{
+	int nid, count = 0;
+	unsigned long long tmp;
+	char *s = p;
+
+	while (*s) {
+		if (sscanf(s, "%llu%n", &tmp, &count) != 1)
+			break;
+
+		if (s[count] == ':') {
+			if (tmp >= MAX_NUMNODES)
+				break;
+			nid = array_index_nospec(tmp, MAX_NUMNODES);
+
+			s += count + 1;
+			tmp = memparse(s, &s);
+			parker_cma_size_in_node[nid] = tmp;
+			parker_cma_size += tmp;
+
+			/*
+			 * Skip the separator if have one, otherwise
+			 * break the parsing.
+			 */
+			if (*s == ',')
+				s++;
+			else
+				break;
+		} else {
+			parker_cma_size = memparse(p, &p);
+			break;
+		}
+	}
+
+	return 0;
+}
+early_param("parker_cma", parker_early_cma);
+
+#define ORDER_1G 30
+void __init parker_cma_reserve(void)
+{
+	bool node_specific_cma_alloc = false;
+	unsigned long long size, reserved, per_node;
+	int nid;
+
+	if (!parker_cma_size)
+		return;
+
+	for (nid = 0; nid < MAX_NUMNODES; nid++) {
+		if (parker_cma_size_in_node[nid] == 0)
+			continue;
+
+		if (!node_online(nid)) {
+			pr_warn("invalid node %d specified for CMA allocation\n", nid);
+			parker_cma_size -= parker_cma_size_in_node[nid];
+			parker_cma_size_in_node[nid] = 0;
+			continue;
+		}
+
+		if (parker_cma_size_in_node[nid] < SZ_1G) {
+			pr_warn("cma area of node %d should be at least 1GiB\n", nid);
+			parker_cma_size -= parker_cma_size_in_node[nid];
+			parker_cma_size_in_node[nid] = 0;
+		} else {
+			node_specific_cma_alloc = true;
+		}
+	}
+	/* Validate the CMA size again in case some invalid nodes specified. */
+	if (!parker_cma_size)
+		return;
+
+	if (parker_cma_size < SZ_1G) {
+		pr_warn("cma area should be at least 1 GiB\n");
+		parker_cma_size = 0;
+		return;
+	}
+
+	if (!node_specific_cma_alloc) {
+		/*
+		 * If 3 GB area is requested on a machine with 4 numa nodes,
+		 * let's allocate 1 GB on first three nodes and ignore the last one.
+		 */
+		per_node = DIV_ROUND_UP(parker_cma_size, nr_online_nodes);
+		pr_info("reserve CMA %llu MiB, up to %llu MiB per node\n",
+			parker_cma_size / SZ_1M, per_node / SZ_1M);
+	}
+
+	reserved = 0;
+	for_each_online_node(nid) {
+		int res;
+		char name[CMA_MAX_NAME];
+
+		if (node_specific_cma_alloc) {
+			if (parker_cma_size_in_node[nid] == 0)
+				continue;
+
+			size = parker_cma_size_in_node[nid];
+		} else {
+			size = min(per_node, parker_cma_size - reserved);
+		}
+
+		size = round_up(size, SZ_1G);
+
+		snprintf(name, sizeof(name), "parker%d", nid);
+		/*
+		 * Note that 'order per bit' is based on smallest size that
+		 * may be returned to CMA allocator in the case of
+		 * huge page demotion.
+		 */
+		res = cma_declare_contiguous_nid(0, size, 0,
+					SZ_1G,
+					ORDER_1G - PAGE_SHIFT, false, name,
+					&parker_cma[nid], nid);
+		if (res) {
+			pr_warn("reservation failed - err %d, node %d",
+				res, nid);
+			continue;
+		}
+
+		reserved += size;
+		pr_info("reserved %llu MiB on node %d\n",
+			size / SZ_1M, nid);
+
+		if (reserved >= parker_cma_size)
+			break;
+	}
+
+	if (!reserved)
+		/*
+		 * parker_cma_size is used to determine if allocations from
+		 * cma are possible.  Set to zero if no cma regions are set up.
+		 */
+		parker_cma_size = 0;
+}
+
+/* Make sure we don't overwrite initial_code too early */
+struct semaphore cpu_kick_semaphore;
+
+__attribute__((noreturn)) static void parker_bsp_start(void)
+{
+	/* Let parker_start_kernel know we're here */
+	up(&cpu_kick_semaphore);
+
+	if (kexec_image) {
+		machine_kexec(kexec_image);
+	}
+	// never get here but?
+	for (;;) {
+	    continue;
+	}
+}
+
+__attribute__((noreturn)) static void parker_ap_wait(void)
+{
+	/* Let parker_start_kernel know we're here */
+	up(&cpu_kick_semaphore);
+
+	unsigned int cpu = smp_processor_id();
+	unsigned int apic_id = apic->cpu_present_to_apicid(cpu);
+
+	volatile struct parker_control_structure *pcs;
+	/* For now, use global active control page.
+	 * Eventually we can add lookup from CPU -> control page */
+	pcs = page_address(parker_active_control_structure_page);
+	int idx = 0;
+	while (!READ_ONCE(pcs->start_address)) {
+		idx++;
+		continue;
+	}
+	pr_debug("parker trampoline physical address %llx\n", pcs->start_address);
+	smp_mb();
+	u64 call_addr = 0;
+	/* There's no race condition on stack as we don't read the stack pointer again */
+	asm volatile (
+			"mov (%1), %0\n\t"
+			"mov %3, %%rsp\n\t"
+			"mov %4, %%esi\n\t"
+			"mov %2, %%cr3\n\t"
+			ANNOTATE_RETPOLINE_SAFE
+			"call *%0\n\t"
+			: "+r" (call_addr)
+			: "r" (&pcs->start_address),
+			  "r" (__sme_pa(transition_pagetable.pgd)),
+			  "r" (__sme_pa(transition_pagetable.stack + PAGE_SIZE)),
+			  "r" (apic_id)
+			: "esi", "rsp"
+		     );
+
+	for (;;) {
+		continue;
+	}
+}
+
+static void parker_host_ipicb(void)
+{
+	pr_info("OKK\n");
+}
+
+static void __init *alloc_pgt_page(void *dummy)
+{
+	return (void*)get_zeroed_page(GFP_ATOMIC);
+}
+
+static int __init init_transition_pgtable(pgd_t *pgd)
+{
+	pgprot_t prot = PAGE_KERNEL_EXEC_NOENC;
+	unsigned long vaddr, paddr;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+
+	vaddr = (unsigned long)parker_ap_wait;
+	pgd += pgd_index(vaddr);
+	if (!pgd_present(*pgd)) {
+		p4d = (p4d_t *)alloc_pgt_page(NULL);
+		if (!p4d)
+			return -ENOMEM;
+		set_pgd(pgd, __pgd(__pa(p4d) | _KERNPG_TABLE));
+	}
+	p4d = p4d_offset(pgd, vaddr);
+	if (!p4d_present(*p4d)) {
+		pud = (pud_t *)alloc_pgt_page(NULL);
+		if (!pud)
+			return -ENOMEM;
+		set_p4d(p4d, __p4d(__pa(pud) | _KERNPG_TABLE));
+	}
+	pud = pud_offset(p4d, vaddr);
+	if (!pud_present(*pud)) {
+		pmd = (pmd_t *)alloc_pgt_page(NULL);
+		if (!pmd)
+			return -ENOMEM;
+		set_pud(pud, __pud(__pa(pmd) | _KERNPG_TABLE));
+	}
+	pmd = pmd_offset(pud, vaddr);
+	if (!pmd_present(*pmd)) {
+		pte = (pte_t *)alloc_pgt_page(NULL);
+		if (!pte)
+			return -ENOMEM;
+		set_pmd(pmd, __pmd(__pa(pte) | _KERNPG_TABLE));
+	}
+	pte = pte_offset_kernel(pmd, vaddr);
+
+	paddr = __pa(vaddr);
+	set_pte(pte, pfn_pte(paddr >> PAGE_SHIFT, prot));
+
+	return 0;
+}
+
+/* Allocate intermediate trampoline pagetable, that has all physical memory
+ * mapped allowing us to reuse this for all parker kernel instantiations. */
+static int __init parker_host_transition_pagetable_init(void)
+{
+	struct x86_mapping_info info = {
+		.alloc_pgt_page = alloc_pgt_page,
+//		.free_pgt_page	= free_pgt_page,
+		.page_flag      = __PAGE_KERNEL_LARGE_EXEC,
+		.kernpg_flag    = _KERNPG_TABLE_NOENC,
+	};
+
+	pgd_t *pgd;
+	pgd = alloc_pgt_page(NULL);
+	void *stack = alloc_pgt_page(NULL);
+	if (!pgd)
+		return -ENOMEM;
+
+	for (int i = 0; i < nr_pfn_mapped; i++) {
+		unsigned long mstart, mend;
+
+		mstart = pfn_mapped[i].start << PAGE_SHIFT;
+		mend   = pfn_mapped[i].end << PAGE_SHIFT;
+		if (kernel_ident_mapping_init(&info, pgd, mstart, mend)) {
+			//kernel_ident_mapping_free(&info, pgd);
+			return -ENOMEM;
+		}
+	}
+
+	transition_pagetable.info = info;
+	transition_pagetable.pgd = pgd;
+	transition_pagetable.stack = stack;
+
+	return init_transition_pgtable(pgd);
+}
+static int __init parker_kernfs_init(void);
+
+/* Multi-kernel module code for Primary <-> secondary communication */
+static int __init parker_module_init(void)
+{
+	if (is_parker_instance())
+		return -ENODEV;
+	parker_kernfs_init();
+	sema_init(&cpu_kick_semaphore, 0);
+	// TODO: Device registration for sysfs interface
+	// copying resctrl interface style with folder creation
+	// and deletion to create kernels.
+	pr_info("Multikernel module loading...\n");
+	// TODO: Custom
+	if (x86_platform_ipi_callback) {
+		pr_err("Platform callback exists\n");
+		return -ENODEV;
+	}
+	x86_platform_ipi_callback = parker_host_ipicb;
+	if(parker_host_transition_pagetable_init()) {
+		pr_info("TTABLE FAILED!\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void __exit parker_module_exit(void)
+{
+	pr_info("Multikernel exiting.\n");
+	//__free_pages(parker_control_page, 0);
+}
+
+/* Ensure global parker lock is held */
+static int parker_start_kernel(struct parker_kernel_entry *pke)
+{
+	struct parker_control_structure *pcs;
+	struct list_head *dev_elem;
+	int ret;
+
+	WRITE_ONCE(parker_active_control_structure_page, pke->control_structure_pages);
+	pcs = page_address(parker_active_control_structure_page);
+
+	if (!pcs)
+		return -EINVAL;
+
+	/* Add PCI device IDs to control structure */
+	list_for_each(dev_elem, &pke->list_devices) {
+		struct parker_kernel_device_entry *pkde;
+		struct pci_dev *pdev;
+		int pci_dev_index = pcs->num_pci_devs++;
+		pkde = container_of(dev_elem,
+				    struct parker_kernel_device_entry,
+				    list_entry);
+		pdev = to_pci_dev(pkde->dev);
+		pcs->pci_dev_ids[pci_dev_index] = pci_dev_id(pdev);
+	}
+
+	int bsp_cpu, cpu, i = 0;
+	/* Partitioned kernel's AP will wait on BSP to jump to kernel's startup code */
+	for_each_cpu(cpu, &pke->cpu_mask) {
+		u32 apicid = apic->cpu_present_to_apicid(cpu);
+		pcs->apic_ids[i] = apicid;
+		++pcs->num_cpus;
+		int old = i++;
+		if (old == 0) {
+			bsp_cpu = cpu;
+			continue;
+		}
+
+		smpboot_control = cpu;
+		initial_code = (unsigned long)parker_ap_wait;
+		init_espfix_ap(cpu);
+		smp_mb();
+
+		pr_debug("parker AP %d %d\n", apicid, ret);
+		unsigned long start_ip = real_mode_header->trampoline_start;
+		ret = wakeup_secondary_cpu_via_init(apicid, start_ip);
+		/* Continue on with errors for now */
+		if (ret) {
+			pr_err("Failed to start cpu %d\n", cpu);
+			--i;
+			--pcs->num_cpus;
+			continue;
+		}
+		/* Wait for CPU to wakeup and start executing AP wait function */
+		down(&cpu_kick_semaphore);
+	}
+
+	/* Start the partitioned kernel's BSP */
+	//mtrr_save_state();
+	u32 apicid = apic->cpu_present_to_apicid(bsp_cpu);
+	smpboot_control = bsp_cpu;
+	initial_code = (unsigned long)parker_bsp_start;
+	init_espfix_ap(bsp_cpu);
+	smp_mb();
+	unsigned long start_ip = real_mode_header->trampoline_start;
+	ret = wakeup_secondary_cpu_via_init(apicid, start_ip);
+	if (ret)
+		return ret;
+	down(&cpu_kick_semaphore);
+
+	/* Wait for partitioned kernel to start */
+	while (!READ_ONCE(pcs->online))
+		cpu_relax();
+
+	return 0;
+}
+
+static bool parker_kernel_is_online(struct parker_kernel_entry *pke)
+{
+	struct parker_control_structure *pcs;
+	pcs = page_address(pke->control_structure_pages);
+	return READ_ONCE(pcs->online);
+}
+
+/*
+ *
+ * Proper implementation:
+ * /sys/fs/parker new kernelfs
+ *
+ */
+/* The filesystem can only be mounted once. */
+/* TODO: Deal with recovery of structures if unmounted */
+// Forward declarations
+static int parker_get_tree(struct fs_context *fc);
+static int parker_init_fs_context(struct fs_context *fc);
+static void parker_fs_context_free(struct fs_context *fc);
+static void parker_kill_sb(struct super_block *sb);
+static int parker_kn_set_ugid(struct kernfs_node *kn);
+
+/* Mutex to protect parker access. */
+DEFINE_MUTEX(parker_mutex);
+atomic_t parker_kernels = ATOMIC_INIT(0);
+static bool parker_mounted;
+/* All CPUs belonging to second kernel*/
+static struct cpumask parker_cpus;
+
+struct parker {
+	struct kernfs_node *kn;
+	/* TODO: control structures etc... */
+};
+
+struct parker_file_type {
+	char *name;
+	umode_t mode;
+	const struct kernfs_ops *kf_ops;
+
+	int (*seq_show)(struct kernfs_open_file *of, struct seq_file *sf, void *v);
+
+	ssize_t (*write)(struct kernfs_open_file *of, char *buf, size_t nbytes, loff_t off);
+};
+
+static int parker_add_files(struct kernfs_node *kn, struct parker_file_type *pfts, int len);
+
+static int parker_seqfile_show(struct seq_file *m, void *arg)
+{
+	struct kernfs_open_file *of = m->private;
+	struct parker_file_type *pft = of->kn->priv;
+
+	if (pft->seq_show)
+		return pft->seq_show(of, m, arg);
+
+	return 0;
+}
+
+static ssize_t parker_file_write(struct kernfs_open_file *of, char *buf,
+						   size_t nbytes, loff_t off)
+{
+	struct parker_file_type *pft = of->kn->priv;
+
+	if (pft->write)
+		return pft->write(of, buf, nbytes, off);
+
+	return -EINVAL;
+}
+
+static const struct kernfs_ops parker_kf_ops = {
+	.atomic_write_len	= PAGE_SIZE,
+	.write			= parker_file_write,
+	.seq_show		= parker_seqfile_show,
+};
+
+/* List of attributes in root - currently none */
+static struct parker_file_type root_attributes[] = {};
+
+static int parker_kernel_index_show(struct kernfs_open_file *of,
+				    struct seq_file *seq, void *v)
+{
+	struct parker_kernel_entry *pke = of->kn->parent->priv;
+	mutex_lock(&pke->mutex);
+	seq_printf(seq, "%u\n", pke->id);
+	mutex_unlock(&pke->mutex);
+	return 0;
+}
+
+static int parker_kernel_control_structure_show(struct kernfs_open_file *of,
+						struct seq_file *seq, void *v)
+{
+	struct parker_kernel_entry *pke = of->kn->parent->priv;
+	mutex_lock(&parker_mutex);
+	seq_printf(seq, "0x%llx\n", page_to_phys(pke->control_structure_pages));
+	mutex_unlock(&parker_mutex);
+	return 0;
+}
+
+
+static int parker_kernel_online_show(struct kernfs_open_file *of,
+				     struct seq_file *seq, void *v)
+{
+	struct parker_kernel_entry *pke = of->kn->parent->priv;
+	bool online;
+
+	mutex_lock(&pke->mutex);
+	online = parker_kernel_is_online(pke);
+	seq_printf(seq, "%u\n", online);
+	mutex_unlock(&pke->mutex);
+	return 0;
+}
+
+static ssize_t parker_kernel_online_write(struct kernfs_open_file *of,
+					  char *buf,
+					  size_t nbytes, loff_t off)
+{
+	int ret;
+	struct parker_kernel_entry *pke = of->kn->parent->priv;
+
+	mutex_lock(&parker_mutex);
+	mutex_lock(&pke->mutex);
+
+	ret = parker_start_kernel(pke);
+	/* Only set online if the second kernel successfully started */
+	if (!ret)
+		pke->online = true;
+
+
+	mutex_unlock(&pke->mutex);
+	mutex_unlock(&parker_mutex);
+
+	return ret ?: nbytes;
+}
+
+static int parker_kernel_cpus_show(struct kernfs_open_file *of,
+				   struct seq_file *seq, void *v)
+{
+	struct parker_kernel_entry *pke = of->kn->parent->priv;
+	mutex_lock(&pke->mutex);
+	seq_printf(seq, "%*pbl\n", cpumask_pr_args(&pke->cpu_mask));
+	mutex_unlock(&pke->mutex);
+	return 0;
+}
+
+static ssize_t parker_kernel_cpus_write(struct kernfs_open_file *of, char *buf,
+					 size_t nbytes, loff_t off)
+{
+	cpumask_var_t tmpmask, newmask;
+	struct parker_kernel_entry *pke = of->kn->parent->priv;
+	int cpu, ret;
+
+	if (!zalloc_cpumask_var(&tmpmask, GFP_KERNEL))
+		return -ENOMEM;
+
+	if (!zalloc_cpumask_var(&newmask, GFP_KERNEL)) {
+		free_cpumask_var(tmpmask);
+		return -ENOMEM;
+	}
+
+	mutex_lock(&parker_mutex);
+	mutex_lock(&pke->mutex);
+	ret = cpulist_parse(buf, newmask);
+
+	/* Check if any CPUs belong to another parker kernel */
+	cpumask_and(tmpmask, newmask, &parker_cpus);
+	if (!cpumask_empty(tmpmask)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* If CPUs are currently online, offline them */
+	cpumask_and(tmpmask, newmask, cpu_online_mask);
+	if (!cpumask_empty(tmpmask)) {
+		for_each_cpu(cpu, tmpmask)
+			remove_cpu(cpu);
+	}
+
+	cpumask_or(&parker_cpus, &parker_cpus, newmask);
+	cpumask_copy(&pke->cpu_mask, newmask);
+out:
+	free_cpumask_var(tmpmask);
+	free_cpumask_var(newmask);
+	mutex_unlock(&pke->mutex);
+	mutex_unlock(&parker_mutex);
+	return ret ?: nbytes;
+}
+
+static int parker_kernel_memory_show(struct kernfs_open_file *of,
+				     struct seq_file *seq, void *v)
+{
+	int ret;
+
+	struct parker_kernel_entry *pke = of->kn->parent->priv;
+	mutex_lock(&pke->mutex);
+	if (!pke->physical_memory_pages) {
+		ret = -EINVAL;
+		goto out;
+	}
+	phys_addr_t base = page_to_phys(pke->physical_memory_pages);
+	unsigned long long size = pke->physical_memory_page_count * PAGE_SIZE;
+	seq_printf(seq, "%llu@0x%llx\n", size, base);
+	ret = 0;
+out:
+	mutex_unlock(&pke->mutex);
+	return ret;
+}
+
+static ssize_t parker_kernel_memory_write(struct kernfs_open_file *of, char *buf,
+					  size_t nbytes, loff_t off)
+{
+	struct parker_kernel_entry *pke = of->kn->parent->priv;
+	struct page *result;
+	int ret, memory_nid = NUMA_NO_NODE;
+	char *end;
+
+	unsigned long long size;
+	unsigned long page_count;
+
+	mutex_lock(&pke->mutex);
+	if (!(size = memparse(buf, &end))) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Ensure write is fully parsed */
+	if (*end != '\0' && *end != '\n') {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* We need a CPU to determine which NUMA node to allocate memory on */
+	if (cpumask_empty(&pke->cpu_mask)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Get NUMA node for first cpu (BSP) */
+	memory_nid = cpu_to_node(cpumask_first(&pke->cpu_mask));
+
+	if (pke->physical_memory_pages) {
+		if (!cma_release(parker_cma[memory_nid],
+				 pke->physical_memory_pages,
+				 pke->physical_memory_page_count)) {
+			ret = -EBUSY;
+			goto out;
+		}
+	}
+
+	/* Assume that size is page aligned, if not second kernel loses page */
+	page_count = size >> PAGE_SHIFT;
+	result = cma_alloc(parker_cma[memory_nid], page_count, 0, false);
+
+	if (!result) {
+		ret = -ENOMEM;
+		pke->physical_memory_pages = NULL;
+		pke->physical_memory_page_count = 0;
+		goto out;
+	}
+
+	if (!cma_pages_valid(parker_cma[memory_nid], result, page_count)) {
+		ret = -EINVAL;
+		if (!cma_release(parker_cma[memory_nid], result, page_count))
+			pr_err("Failed to release invalid allocation.");
+		goto out;
+
+	}
+
+	pke->physical_memory_pages = result;
+	pke->physical_memory_page_count = page_count;
+	ret = 0;
+out:
+	mutex_unlock(&pke->mutex);
+	return ret ?: nbytes;
+}
+
+/* TODO: Consider implementation where we bind to pci-stub instead - avoid rescanning problem? */
+static ssize_t parker_kernel_bind_write(struct kernfs_open_file *of, char *buf,
+					size_t nbytes, loff_t off)
+{
+	struct parker_kernel_entry *pke = of->kn->parent->priv;
+	struct kernfs_node *dev_kn;
+	struct device *dev;
+	int ret = -ENODEV;
+
+	mutex_lock(&pke->mutex);
+	dev = bus_find_device_by_name(&pci_bus_type, NULL, buf);
+	/* Remove from bus to prevent anyone from using it */
+	if (dev) {
+		struct parker_kernel_device_entry *pkde;
+		/* If device already disabled, maybe owned by another kernel. Only claim enabled devices */
+		if (!pci_is_enabled(to_pci_dev(dev))) {
+			put_device(dev);
+			ret = -EBUSY;
+			goto out;
+		}
+
+		pkde = kzalloc(sizeof(*pkde), GFP_KERNEL);
+		pkde->dev = dev;
+		dev_kn = kernfs_create_dir(pke->kn_devices, dev_name(dev),
+					   pke->kn_devices->mode, pkde);
+		/* We use after kernfs_remove in unbind & rmdir case*/
+		kernfs_get(dev_kn);
+		pkde->kn = dev_kn;
+		list_add_tail(&pkde->list_entry, &pke->list_devices);
+		kernfs_activate(dev_kn);
+		pci_bus_type.remove(dev);
+		ret = 0;
+	}
+
+out:
+	mutex_unlock(&pke->mutex);
+	return ret ?: nbytes;
+}
+
+static ssize_t parker_kernel_unbind_write(struct kernfs_open_file *of, char *buf,
+					size_t nbytes, loff_t off)
+{
+	struct parker_kernel_entry *pke = of->kn->parent->priv;
+	struct parker_kernel_device_entry *pkde;
+	struct kernfs_node *dev_kn;
+	struct device *dev;
+	int ret = -ENODEV;
+
+	mutex_lock(&pke->mutex);
+	dev = bus_find_device_by_name(&pci_bus_type, NULL, buf);
+	/* Remove from bus to prevent anyone from using it */
+	if (dev) {
+		/* Check if device is claimed by kernel */
+		dev_kn = kernfs_find_and_get(pke->kn_devices, dev_name(dev));
+		if (!dev_kn) {
+			put_device(dev);
+			goto out;
+		}
+
+		/* Ensure PCI device isn't enabled */
+		if (pci_is_enabled(to_pci_dev(dev))) {
+			put_device(dev);
+			kernfs_put(dev_kn);
+			goto out;
+		}
+		pkde = dev_kn->priv;
+
+		ret = pci_bus_type.probe(dev);
+		put_device(dev);
+		kernfs_remove(dev_kn);
+		/* One reference from getting above, one from device subdir creation */
+		kernfs_put(dev_kn);
+		kernfs_put(dev_kn);
+		list_del(&pkde->list_entry);
+		kfree(pkde);
+	}
+
+out:
+	mutex_unlock(&pke->mutex);
+	return ret ?: nbytes;
+}
+
+/* Secondary kernel attributes */
+static struct parker_file_type per_kernel_attributes[] = {
+	/* Passed to secondary kernel to identify */
+	{
+		.name = "id",
+		.mode = 0644,
+		.kf_ops = &parker_kf_ops,
+		.seq_show = parker_kernel_index_show,
+	},
+	{
+		.name = "control_structure",
+		.mode = 0644,
+		.kf_ops = &parker_kf_ops,
+		.seq_show = parker_kernel_control_structure_show,
+	},
+	{
+		.name = "cpus",
+		.mode = 0644,
+		.kf_ops = &parker_kf_ops,
+		.seq_show = parker_kernel_cpus_show,
+		.write = parker_kernel_cpus_write,
+	},
+	/* Add per numa node memory? */
+	{
+		.name = "memory",
+		.mode = 0644,
+		.kf_ops = &parker_kf_ops,
+		.seq_show = parker_kernel_memory_show,
+		.write = parker_kernel_memory_write,
+	},
+	{
+		.name = "bind",
+		.mode = 0644,
+		.kf_ops = &parker_kf_ops,
+		.write = parker_kernel_bind_write,
+	},
+	{
+		.name = "unbind",
+		.mode = 0644,
+		.kf_ops = &parker_kf_ops,
+		.write = parker_kernel_unbind_write,
+	},
+	/* TODO: is status better? */
+	{
+		.name = "online",
+		.mode = 0644,
+		.kf_ops = &parker_kf_ops,
+		.seq_show = parker_kernel_online_show,
+		.write = parker_kernel_online_write, // todo
+	},
+};
+
+struct parker_fs_context {
+	struct kernfs_fs_context kfc;
+};
+
+static int parker_setup_root(struct parker_fs_context *ctx);
+static void parker_destroy_root(void);
+
+static struct kernfs_root *parker_root;
+struct parker parker_default;
+
+static const struct fs_context_operations parker_fs_context_ops = {
+	.free = parker_fs_context_free,
+	.get_tree = parker_get_tree,
+};
+
+static struct file_system_type parker_fs_type = {
+	.name			= "parker",
+	.init_fs_context        = parker_init_fs_context,
+	.kill_sb		= parker_kill_sb,
+};
+
+
+static int parker_kernel_entry_destroy(struct parker_kernel_entry *pke)
+{
+	int cpu, memory_nid = NUMA_NO_NODE, ret = 0;
+	struct list_head *dev_elem, *n;
+
+
+	/* Bring back parker CPUs */
+	for_each_cpu(cpu, &pke->cpu_mask) {
+		add_cpu(cpu);
+		if (memory_nid == NUMA_NO_NODE)
+			memory_nid = cpu_to_node(cpu);
+	}
+	cpumask_andnot(&parker_cpus, &parker_cpus, &pke->cpu_mask);
+
+	/* Free memory allocated */
+	if (pke->physical_memory_page_count > 0 &&
+	    !cma_release(parker_cma[memory_nid],
+			 pke->physical_memory_pages,
+			 pke->physical_memory_page_count)) {
+		ret = -EBUSY;
+	}
+
+	for (int i = 0; i < pke->control_structure_page_count; ++i) {
+		__free_pages(pke->control_structure_pages + i, 0);
+	}
+
+
+	/* Unclaim PCI devices */
+	list_for_each_safe(dev_elem, n, &pke->list_devices) {
+		struct parker_kernel_device_entry *pkde;
+		pkde = container_of(dev_elem,
+				    struct parker_kernel_device_entry,
+				    list_entry);
+		ret = pci_bus_type.probe(pkde->dev);
+		if (ret)
+			continue;
+		put_device(pkde->dev);
+		kernfs_remove(pkde->kn);
+		kernfs_put(pkde->kn);
+		kfree(pkde);
+	}
+
+	atomic_dec(&parker_kernels);
+	mutex_destroy(&pke->mutex);
+	if (pke->kn)
+		kernfs_put(pke->kn);
+	kfree(pke);
+
+	return ret;
+}
+
+static int parker_kernel_control_structure_alloc(struct parker_kernel_entry *pke)
+{
+	pke->control_structure_pages = alloc_pages(GFP_KERNEL | __GFP_ZERO, 0);
+	if (!pke->control_structure_pages)
+		return -ENOMEM;
+
+	pke->control_structure_page_count = 1;
+	return 0;
+}
+
+static int parker_kernel_entry_init(struct parker_kernel_entry *pke)
+{
+	struct kernfs_node *kn;
+	int ret;
+	// Also allocate any secondary structures?
+
+	ret = parker_kernel_control_structure_alloc(pke);
+	if (ret)
+		return ret;
+
+	atomic_inc(&parker_kernels);
+	pke->id = atomic_read(&parker_kernels);
+	pke->online = false;
+	mutex_init(&pke->mutex);
+	INIT_LIST_HEAD(&pke->list_devices);
+
+	kn = kernfs_create_dir(pke->kn, "devices", pke->kn->mode, pke);
+	if (IS_ERR(kn)) {
+		/* As no devices, can't fail */
+		parker_kernel_entry_destroy(pke);
+		return PTR_ERR(kn);
+	}
+	pke->kn_devices = kn;
+
+	return 0;
+}
+
+static int parker_mkdir(struct kernfs_node *parent_kn, const char *name, umode_t mode)
+{
+	int ret = 0;
+	struct parker_kernel_entry *pke;
+	struct kernfs_node *kn;
+
+	/* Only allow creation from within root directory */
+	if (parent_kn != parker_default.kn)
+		return -EINVAL;
+
+	if (strchr(name, '\n'))
+		return -EINVAL;
+
+	mutex_lock(&parker_mutex);
+	pke = kzalloc(sizeof(*pke), GFP_KERNEL);
+	if (!pke) {
+		ret = -ENOMEM;
+		goto out_unlock;
+	}
+
+	kn = kernfs_create_dir(parent_kn, name, mode, pke);
+	if (IS_ERR(kn)) {
+		ret = PTR_ERR(kn);
+		goto out_free_pke;
+	}
+	pke->kn = kn;
+
+	ret = parker_kernel_entry_init(pke);
+	if (ret)
+		goto out_unlock;
+
+	/* As we will use pke after kernfs_remove */
+	kernfs_get(pke->kn);
+
+	ret = parker_kn_set_ugid(kn);
+	if (ret) {
+		goto out_destroy;
+	}
+
+	ret = parker_add_files(kn, per_kernel_attributes, ARRAY_SIZE(per_kernel_attributes));
+	if (ret) {
+		goto out_destroy;
+	}
+
+	kernfs_activate(kn);
+	goto out_unlock;
+
+out_destroy:
+	kernfs_remove(pke->kn);
+	kernfs_put(pke->kn);
+out_free_pke:
+	kfree(pke);
+out_unlock:
+	mutex_unlock(&parker_mutex);
+	return ret;
+}
+
+static int parker_rmdir(struct kernfs_node *kn)
+{
+	struct parker_kernel_entry *pke = kn->priv;
+	int ret = 0;
+
+	/* Only handle rmdir of kernel */
+	if (pke->kn != kn) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	if (parker_kernel_is_online(pke)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	/* First remove, ensuring no new operations */
+	mutex_lock(&pke->mutex);
+	kernfs_remove_self(kn);
+	mutex_unlock(&pke->mutex);
+
+	ret = parker_kernel_entry_destroy(pke);
+out:
+	return ret;
+}
+
+static struct kernfs_syscall_ops parker_kf_syscall_ops = {
+	.mkdir		= parker_mkdir,
+	.rmdir		= parker_rmdir,
+};
+
+static inline struct parker_fs_context *parker_fc2context(struct fs_context *fc)
+{
+	struct kernfs_fs_context *kfc = fc->fs_private;
+
+	return container_of(kfc, struct parker_fs_context, kfc);
+}
+
+static int parker_kn_set_ugid(struct kernfs_node *kn)
+{
+	struct iattr iattr = { .ia_valid = ATTR_UID | ATTR_GID,
+				.ia_uid = current_fsuid(),
+				.ia_gid = current_fsgid(), };
+
+	if (uid_eq(iattr.ia_uid, GLOBAL_ROOT_UID) &&
+	    gid_eq(iattr.ia_gid, GLOBAL_ROOT_GID))
+		return 0;
+
+	return kernfs_setattr(kn, &iattr);
+}
+
+static int parker_add_file(struct kernfs_node *parent_kn,
+			   struct parker_file_type *pft)
+{
+	struct kernfs_node *kn;
+	int ret;
+
+	kn = __kernfs_create_file(parent_kn, pft->name, pft->mode,
+				  GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
+				  0, pft->kf_ops, pft, NULL, NULL);
+	if (IS_ERR(kn))
+		return PTR_ERR(kn);
+
+	ret = parker_kn_set_ugid(kn);
+	if (ret) {
+		kernfs_remove(kn);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int parker_add_files(struct kernfs_node *kn, struct parker_file_type *pfts, int len)
+{
+	struct parker_file_type *pft;
+	int ret;
+
+	lockdep_assert_held(&parker_mutex);
+
+	for (pft = pfts; pft < pfts + len; pft++) {
+		ret = parker_add_file(kn, pft);
+		if (ret)
+			goto error;
+	}
+
+	return 0;
+error:
+	pr_warn("Failed to add %s, err=%d\n", pft->name, ret);
+	while (--pft >= pfts) {
+		kernfs_remove_by_name(kn, pft->name);
+	}
+	return ret;
+}
+
+
+static int parker_init_fs_context(struct fs_context *fc)
+{
+	struct parker_fs_context *ctx;
+	ctx = kzalloc(sizeof(struct parker_fs_context), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->kfc.magic = PARKER_SUPER_MAGIC; // TODO: Add to include/uapi/linux/magic.h
+	fc->fs_private = &ctx->kfc;
+	fc->ops = &parker_fs_context_ops;
+	put_user_ns(fc->user_ns);
+	fc->user_ns = get_user_ns(&init_user_ns);
+	fc->global = true;
+	return 0;
+}
+
+static int parker_get_tree(struct fs_context *fc)
+{
+	struct parker_fs_context *ctx = parker_fc2context(fc);
+	int ret = 0;
+
+	mutex_lock(&parker_mutex);
+	if (parker_mounted) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	/* filesystem was unmounted but kernels weren't cleared up, reactivate last root */
+	if (parker_default.kn) {
+		ctx->kfc.root = parker_root;
+		goto activate_root;
+	}
+
+	ret = parker_setup_root(ctx);
+	if (ret)
+		goto destroy_root;
+
+	ret = parker_add_files(parker_default.kn, root_attributes, ARRAY_SIZE(root_attributes));
+	if (ret < 0)
+		goto destroy_root;
+
+activate_root:
+	kernfs_activate(parker_default.kn);
+	ret = kernfs_get_tree(fc);
+	if (ret < 0)
+		goto destroy_root;
+	parker_mounted = true;
+out:
+	mutex_unlock(&parker_mutex);
+	return ret;
+
+destroy_root:
+	parker_destroy_root();
+	return ret;
+}
+
+static void parker_fs_context_free(struct fs_context *fc)
+{
+	struct parker_fs_context *ctx = parker_fc2context(fc);
+
+	kernfs_free_fs_context(fc);
+	kfree(ctx);
+}
+
+static void parker_kill_sb(struct super_block *sb)
+{
+	mutex_lock(&parker_mutex);
+	parker_mounted = false;
+
+	/* Only destroy root if no kernels are still declared */
+	if (atomic_read(&parker_kernels) == 0) {
+		parker_destroy_root();
+	}
+
+	kernfs_kill_sb(sb);
+	mutex_unlock(&parker_mutex);
+}
+
+static void parker_destroy_root(void)
+{
+	kernfs_destroy_root(parker_root);
+	parker_default.kn = NULL;
+}
+
+static int parker_setup_root(struct parker_fs_context *ctx)
+{
+	parker_root = kernfs_create_root(
+			&parker_kf_syscall_ops,
+			KERNFS_ROOT_CREATE_DEACTIVATED | KERNFS_ROOT_EXTRA_OPEN_PERM_CHECK,
+			&parker_default);
+
+	if (IS_ERR(parker_root))
+		return PTR_ERR(parker_root);
+
+	ctx->kfc.root = parker_root;
+	parker_default.kn = kernfs_root_to_node(parker_root);
+
+	return 0;
+}
+
+/* Prevent us from onlining CPUs provisioned to parker instance */
+static int parker_cpu_offline_startup(unsigned int cpu)
+{
+	int ret;
+
+	mutex_lock(&parker_mutex);
+	ret = cpumask_test_cpu(cpu, &parker_cpus) ? -EINVAL : 0;
+	mutex_unlock(&parker_mutex);
+
+	return 0;
+}
+
+
+static int __init parker_kernfs_init(void)
+{
+	int ret = 0;
+
+	if (!parker_cma_size) {
+		pr_err("No parker CMA regions allocated, disabling parker.");
+		return -ENOENT;
+	}
+
+	ret = sysfs_create_mount_point(fs_kobj, "parker");
+	if (ret)
+		return ret;
+
+	ret = register_filesystem(&parker_fs_type);
+	if (ret)
+		goto cleanup_mountpoint;
+
+	ret = cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "parker", parker_cpu_offline_startup, NULL);
+	if (ret < 0)
+		goto cleanup_filesystem;
+
+	return ret;
+cleanup_filesystem:
+	unregister_filesystem(&parker_fs_type);
+cleanup_mountpoint:
+	sysfs_remove_mount_point(fs_kobj, "parker");
+	return ret;
+}
+
+module_init(parker_module_init);
+module_exit(parker_module_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Thom Hughes");
+MODULE_DESCRIPTION("Parker linux host module.");
+
diff --git a/include/linux/parker.h b/include/linux/parker.h
new file mode 100644
index 000000000000..4984aefcee0f
--- /dev/null
+++ b/include/linux/parker.h
@@ -0,0 +1,7 @@
+#ifndef _LINUX_PARKER_H
+#define _LINUX_PARKER_H
+#ifdef CONFIG_PARKER
+
+#endif /* CONFIG_PARKER */
+#endif /* _LINUX_PARKER_H */
+
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index bb575f3ab45e..25658054e3a7 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -38,6 +38,7 @@
 #define OVERLAYFS_SUPER_MAGIC	0x794c7630
 #define FUSE_SUPER_MAGIC	0x65735546
 #define BCACHEFS_SUPER_MAGIC	0xca451a4e
+#define PARKER_SUPER_MAGIC	0x5041524b      /* "PARK" */
 
 #define MINIX_SUPER_MAGIC	0x137F		/* minix v1 fs, 14 char names */
 #define MINIX_SUPER_MAGIC2	0x138F		/* minix v1 fs, 30 char names */
-- 
2.39.5


