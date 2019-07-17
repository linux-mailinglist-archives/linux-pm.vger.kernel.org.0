Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB1E86B694
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2019 08:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbfGQGYK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jul 2019 02:24:10 -0400
Received: from condef-02.nifty.com ([202.248.20.67]:28650 "EHLO
        condef-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfGQGYK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jul 2019 02:24:10 -0400
Received: from conuserg-10.nifty.com ([10.126.8.73])by condef-02.nifty.com with ESMTP id x6H6IpYI006390;
        Wed, 17 Jul 2019 15:18:51 +0900
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x6H6I5Oc009435;
        Wed, 17 Jul 2019 15:18:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x6H6I5Oc009435
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563344286;
        bh=MsNRvlaE02YX1DTdpyxIjkokwz0Ur1MdtPkFVwAq4b4=;
        h=From:To:Cc:Subject:Date:From;
        b=oq3djoWpo5WcGiuxcGvDlSmpHWrZr4kgViu2MjtmR1w8MEVYnSfr2mP4e04Ptg9kd
         wyFg3Ycl2l0fQvSostoJg0269KOkRZR0cGf3kw3/cH4Nn67ugenUgiHeRBrofPvLt6
         4gXYWNCsMp7iXdiLIbUxLzIpH3rZDoYOO/bRkdjJmzKepG2gRIwb1u2uVt0NmfiY7c
         wyhhDMuG7r6fQEyiYXU+XoFcdLW4hzWwjfFpkUxFBbvu7sFwifEHp08xAZpmJPJqW0
         isneZcJ3sCva4Z/DOlClTkLv/FqyqykwttLTfpbGThqEFuZ9MhOlYvxAIeFyoJSSZx
         NeHOHn3Up2Hag==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Renninger <trenn@suse.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH v3 00/12] kbuild: create *.mod with directory path and remove MODVERDIR
Date:   Wed, 17 Jul 2019 15:17:48 +0900
Message-Id: <20190717061800.10018-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


This series kills the long standing MODVERDIR.

Since MODVERDIR has a flat structure, it cannot avoid a race
condition when somebody introduces a module name conflict.

Kbuild now reads modules.order to get the list of all modules.

The post-processing/installation stages will be more robust
and simpler.



Masahiro Yamada (12):
  kbuild: do not create empty modules.order in the prepare stage
  kbuild: get rid of kernel/ prefix from in-tree modules.{order,builtin}
  kbuild: remove duplication from modules.order in sub-directories
  scsi: remove pointless $(MODVERDIR)/$(obj)/53c700.ver
  kbuild: modinst: read modules.order instead of $(MODVERDIR)/*.mod
  kbuild: modsign: read modules.order instead of $(MODVERDIR)/*.mod
  kbuild: modpost: read modules.order instead of $(MODVERDIR)/*.mod
  kbuild: export_report: read modules.order instead of
    .tmp_versions/*.mod
  kbuild: create *.mod with full directory path and remove MODVERDIR
  kbuild: remove the first line of *.mod files
  kbuild: remove 'prepare1' target
  kbuild: split out *.mod out of {single,multi}-used-m rules

 .gitignore                                 |  1 +
 Documentation/dontdiff                     |  1 +
 Makefile                                   | 36 ++++++-------------
 drivers/scsi/Makefile                      |  2 +-
 lib/Kconfig.debug                          | 12 +------
 scripts/Makefile.build                     | 40 +++++++++-------------
 scripts/Makefile.modbuiltin                |  2 +-
 scripts/Makefile.modinst                   |  5 +--
 scripts/Makefile.modpost                   | 19 +++++-----
 scripts/Makefile.modsign                   |  3 +-
 scripts/adjust_autoksyms.sh                | 14 +++-----
 scripts/export_report.pl                   | 11 +++---
 scripts/mod/sumversion.c                   | 23 +++----------
 scripts/modules-check.sh                   |  2 +-
 scripts/package/mkspec                     |  2 +-
 tools/power/cpupower/debug/kernel/Makefile |  4 +--
 16 files changed, 62 insertions(+), 115 deletions(-)

-- 
2.17.1

