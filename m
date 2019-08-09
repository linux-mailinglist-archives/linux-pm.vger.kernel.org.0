Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C271F86ECD
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 02:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405107AbfHIAV5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 20:21:57 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34209 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732796AbfHIAV4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Aug 2019 20:21:56 -0400
Received: by mail-ot1-f67.google.com with SMTP id n5so126128552otk.1;
        Thu, 08 Aug 2019 17:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IGL5DKWdJn7PBi3pvoDO2whZUNIAfJTBQdVIbDm2ils=;
        b=ZScCbWpeAMjzl0XmTuKKF8pd17I8kPcB3a/WlU1fcXRTtSba0jThQX6frIL/CsC4gf
         U4bT2fG4mp48haUjk2hNJ+P92k8Lf4Wx1uylZPiKQbzeWFOYACCtHK9aQ5QOjH/yZ2KY
         UpcQRUil/+FjYtDO9ioS3yzu5F+yXWYO57Lc6xrYCfMX9Ay5LdOw3a+mfz7j2Wr9s8XV
         fWX3U7uXdRMXlqmKPvGrMSK/EWBRMAoQhI9grQG8IkCR0po3fZaqZglhzZoVS0MseANc
         0ILdgV95rz0c6WlAGjIsZ1iTgxB7SWn4ctSS0M73QUL7ja0GrTv2o7TcE6gVcYEbmFoV
         ykXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=IGL5DKWdJn7PBi3pvoDO2whZUNIAfJTBQdVIbDm2ils=;
        b=R3tbPb1QtchVxUlBNjiRRzTSHHwp5Z1s4QC3Hcip2qh/O07Iyyf20p5WUW3bdx19cg
         tr4hS4qsQts95n/nO2UM0cLeZFOs1BzUmSlYPf7pg7/N0OY7EnFhYa9DHWlDUzzmxkjo
         E5DFj8/8D/SBbzeS13NRswGoF8Ql/rmkd3ssPnE3kQA3mZ6beFw7LhD6VpgrXKpgR0+9
         Kj5qw9BzEnjIEWn9bHRk28RXr1Tn87Uw1n/uW5pipoRG27A7u+rWb0qNdvr2Z01lfiwn
         CXd2RqN6ci6dSKDevuMiTH6xYyNpyZbX2AS0d/x/syL9qdy+/7Ows69C54bNt2F21dao
         iOyg==
X-Gm-Message-State: APjAAAU1ky3WkZSOsmPOemdB7kKOkxlLAryFwVm1/70WMqauyULEC008
        9Gb/q8h9/Dwgy9Re26KO9VU=
X-Google-Smtp-Source: APXvYqynkSKSBU8dR/EgmijfUwQOlFO0FMYaqeA49ZHZeG/SA/1Z7vAuDfRBpmHmcrDe7Nu4NJ4CwQ==
X-Received: by 2002:a6b:b804:: with SMTP id i4mr17180702iof.119.1565310115747;
        Thu, 08 Aug 2019 17:21:55 -0700 (PDT)
Received: from wandering.us.cray.com (msp-nat.cray.com. [136.162.2.1])
        by smtp.gmail.com with ESMTPSA id l7sm8426377iof.81.2019.08.08.17.21.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 17:21:55 -0700 (PDT)
From:   Shaun Tancheff <shaun@tancheff.com>
X-Google-Original-From: Shaun Tancheff <stancheff@cray.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Shaun Tancheff <stancheff@cray.com>, linux-kbuild@vger.kernel.org,
        Joe Lawrence <joe.lawrence@redhat.com>,
        "'James E . J . Bottomley'" <jejb@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "'Martin K . Petersen'" <martin.petersen@oracle.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Renninger <trenn@suse.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH 1/1] kbuild: recursive build of external kernel modules
Date:   Thu,  8 Aug 2019 19:21:04 -0500
Message-Id: <20190809002104.18599-2-stancheff@cray.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190809002104.18599-1-stancheff@cray.com>
References: <20190809002104.18599-1-stancheff@cray.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When building a tree of external modules stage 2 fails
silently as the root modules.order is empty.

Modify the modules.order location to be fixed to the
root when KBUILD_EXTMOD is specified and write all
module paths to the single modules.order file.

Signed-off-by: Shaun Tancheff <stancheff@cray.com>
---
 Makefile               | 1 +
 scripts/Makefile.build | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 23cdf1f41364..a9964492f47e 100644
--- a/Makefile
+++ b/Makefile
@@ -1622,6 +1622,7 @@ $(module-dirs): prepare $(objtree)/Module.symvers
 
 modules: $(module-dirs)
 	@$(kecho) '  Building modules, stage 2.';
+	$(Q)$rm -f $(KBUILD_EXTMOD)/modules.order
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost
 
 PHONY += modules_install
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 0d434d0afc0b..f9908b3d59e0 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -64,7 +64,13 @@ builtin-target := $(obj)/built-in.a
 endif
 
 ifeq ($(CONFIG_MODULES)$(need-modorder),y1)
+ifneq ($(KBUILD_EXTMOD),)
+modorder-target := $(KBUILD_EXTMOD)/modules.order
+modorder-add := >>
+else
 modorder-target := $(obj)/modules.order
+modorder-add := >
+endif
 endif
 
 mod-targets := $(patsubst %.o, %.mod, $(obj-m))
@@ -423,7 +429,7 @@ endif # builtin-target
 $(modorder-target): $(subdir-ym) FORCE
 	$(Q){ $(foreach m, $(modorder), \
 	$(if $(filter %/modules.order, $m), cat $m, echo $m);) :; } \
-	| $(AWK) '!x[$$0]++' - > $@
+	| $(AWK) '!x[$$0]++' - $(modorder-add) $@
 
 #
 # Rule to compile a set of .o files into one .a file (with symbol table)
-- 
2.20.1

