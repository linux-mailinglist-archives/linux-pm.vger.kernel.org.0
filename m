Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4EBB7B2FE
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 21:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfG3TNK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 15:13:10 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44006 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727621AbfG3TNK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 15:13:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id r22so2950392pgk.10
        for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2019 12:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PQpQB1xhGd1BWNwCOVPVq65dOaaamVfa0p9XxE9K8UE=;
        b=UeEkx54frGpuY2a5hI6uujVV6CP+NOOrqZjevpUoKoJ93cmYNk/k3rMiq3AadGoCKK
         4u7ZW5L9P5D/w1F6ZopTCab2PdKgv5sovzVTiDlesGwqHNwk1iQ59Z1CIqJUVPimrjCH
         2d2E01pLBsNwq9CrfIuERHJQKh4JgFunTybsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PQpQB1xhGd1BWNwCOVPVq65dOaaamVfa0p9XxE9K8UE=;
        b=dnaVaSlv7pIguLi1eWnenSQ+rpu+kqWdsCQiZtbeoIrsMFBvkL7s0rbIQdaDX+gEsp
         hbRFMSIsjxOf2uAIwKpnpP4oNsOuhm4+Z0belTynef+H7RcJaLrEQrn8TzbJFSWW911T
         8ivix/2NfbxiWlhWIKVgHlhPEtkYzrSwdkSTqxVOsQdYcV2xc+iJKGpQrWOp0gabSUeJ
         5zzuEVefPXN9hgt43Ywa6VnD7DXEe686eSlQi5H31rdnUrQtUomCo/95FjmCBVoH0CeT
         iZkEcMYvOtLV+viK5BBO4VWa7o5LdJ06IB+QpGTB4X7UcDU2EEESpjBjpfBqI2+IxRwO
         J5PA==
X-Gm-Message-State: APjAAAWVMlxEr/PXGgipQ5u+l75lwtwWR8ievo1txfEMdorItmYmyqcp
        5U1blfNPd4kThbE8HjELagyTBg==
X-Google-Smtp-Source: APXvYqwcn2k0Dv3q6ck7IZ44pYsx+KVg4rymizIuUGPzamZY74Xu3UwxOdhjJWwI8/DCuTdbmMo2qQ==
X-Received: by 2002:a63:8a49:: with SMTP id y70mr15370050pgd.271.1564513988658;
        Tue, 30 Jul 2019 12:13:08 -0700 (PDT)
Received: from skynet.sea.corp.google.com ([2620:0:1008:1100:c4b5:ec23:d87b:d6d3])
        by smtp.gmail.com with ESMTPSA id n89sm84649540pjc.0.2019.07.30.12.13.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 12:13:08 -0700 (PDT)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, keescook@chromium.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <namit@vmware.com>,
        Thomas Garnier <thgarnie@chromium.org>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Maran Wilson <maran.wilson@oracle.com>,
        Enrico Weigelt <info@metux.net>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-pm@vger.kernel.org
Subject: [PATCH v9 00/11] x86: PIE support to extend KASLR randomization
Date:   Tue, 30 Jul 2019 12:12:44 -0700
Message-Id: <20190730191303.206365-1-thgarnie@chromium.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Minor changes based on feedback and rebase from v8.

Splitting the previous serie in two. This part contains assembly code
changes required for PIE but without any direct dependencies with the
rest of the patchset.

Changes:
 - patch v9 (assembly):
   - Moved to relative reference for sync_core based on feedback.
   - x86/crypto had multiple algorithms deleted, removed PIE changes to them.
   - fix typo on comment end line.
 - patch v8 (assembly):
   - Fix issues in crypto changes (thanks to Eric Biggers).
   - Remove unnecessary jump table change.
   - Change author and signoff to chromium email address.
 - patch v7 (assembly):
   - Split patchset and reorder changes.
 - patch v6:
   - Rebase on latest changes in jump tables and crypto.
   - Fix wording on couple commits.
   - Revisit checkpatch warnings.
   - Moving to @chromium.org.
 - patch v5:
   - Adapt new crypto modules for PIE.
   - Improve per-cpu commit message.
   - Fix xen 32-bit build error with .quad.
   - Remove extra code for ftrace.
 - patch v4:
   - Simplify early boot by removing global variables.
   - Modify the mcount location script for __mcount_loc intead of the address
     read in the ftrace implementation.
   - Edit commit description to explain better where the kernel can be located.
   - Streamlined the testing done on each patch proposal. Always testing
     hibernation, suspend, ftrace and kprobe to ensure no regressions.
 - patch v3:
   - Update on message to describe longer term PIE goal.
   - Minor change on ftrace if condition.
   - Changed code using xchgq.
 - patch v2:
   - Adapt patch to work post KPTI and compiler changes
   - Redo all performance testing with latest configs and compilers
   - Simplify mov macro on PIE (MOVABS now)
   - Reduce GOT footprint
 - patch v1:
   - Simplify ftrace implementation.
   - Use gcc mstack-protector-guard-reg=%gs with PIE when possible.
 - rfc v3:
   - Use --emit-relocs instead of -pie to reduce dynamic relocation space on
     mapped memory. It also simplifies the relocation process.
   - Move the start the module section next to the kernel. Remove the need for
     -mcmodel=large on modules. Extends module space from 1 to 2G maximum.
   - Support for XEN PVH as 32-bit relocations can be ignored with
     --emit-relocs.
   - Support for GOT relocations previously done automatically with -pie.
   - Remove need for dynamic PLT in modules.
   - Support dymamic GOT for modules.
 - rfc v2:
   - Add support for global stack cookie while compiler default to fs without
     mcmodel=kernel
   - Change patch 7 to correctly jump out of the identity mapping on kexec load
     preserve.

These patches make some of the changes necessary to build the kernel as
Position Independent Executable (PIE) on x86_64. Another patchset will
add the PIE option and larger architecture changes.

The patches:
 - 1, 3-11: Change in assembly code to be PIE compliant.
 - 2: Add a new _ASM_MOVABS macro to fetch a symbol address generically.

diffstat:
 crypto/aegis128-aesni-asm.S         |    6 +-
 crypto/aesni-intel_asm.S            |    8 +--
 crypto/aesni-intel_avx-x86_64.S     |    3 -
 crypto/camellia-aesni-avx-asm_64.S  |   42 +++++++--------
 crypto/camellia-aesni-avx2-asm_64.S |   44 ++++++++--------
 crypto/camellia-x86_64-asm_64.S     |    8 +--
 crypto/cast5-avx-x86_64-asm_64.S    |   50 ++++++++++--------
 crypto/cast6-avx-x86_64-asm_64.S    |   44 +++++++++-------
 crypto/des3_ede-asm_64.S            |   96 ++++++++++++++++++++++++------------
 crypto/ghash-clmulni-intel_asm.S    |    4 -
 crypto/glue_helper-asm-avx.S        |    4 -
 crypto/glue_helper-asm-avx2.S       |    6 +-
 crypto/sha256-avx2-asm.S            |   18 ++++--
 entry/entry_64.S                    |   16 ++++--
 include/asm/alternative.h           |    6 +-
 include/asm/asm.h                   |    1 
 include/asm/paravirt_types.h        |   25 +++++++--
 include/asm/pm-trace.h              |    2 
 include/asm/processor.h             |    6 +-
 kernel/acpi/wakeup_64.S             |   31 ++++++-----
 kernel/head_64.S                    |   16 +++---
 kernel/relocate_kernel_64.S         |    2 
 power/hibernate_asm_64.S            |    4 -
 23 files changed, 261 insertions(+), 181 deletions(-)

Patchset is based on next-20190729.


