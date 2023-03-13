Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BF06B84B9
	for <lists+linux-pm@lfdr.de>; Mon, 13 Mar 2023 23:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjCMW04 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Mar 2023 18:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjCMW0z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Mar 2023 18:26:55 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15A65A932
        for <linux-pm@vger.kernel.org>; Mon, 13 Mar 2023 15:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678746413; x=1710282413;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lmJa0dodVqQt4WadkYBIO7CO4lNv352IyfWSQk3Vfto=;
  b=TSbopCXNaYcWEykjsVH5siSvaG3srUFW2EJtNzzmsLoDldi32SBSiw6Y
   UfhaoJQYXWYfDfE5FPO6xGltJSgrDPiBwUybqnuYRaQ3EtGouneHkhK2y
   xOSD1W8ZFmIVRyqj5b9gLSxA2acNkn/tBUZaPjYIWksCeL03BMIK4kIwl
   F3E0wP0rRApCQwJW6Ol1U54g2/aXhqQp1CyvndnIyFD37p6kvrzoSyhw4
   57WLwPbPT64jXbwNDKrLHHi5SvxFjOZzBrfuyLnUcxmkaeHWsqXNaaoGZ
   sssR6EIl7mdapVhM6eA7bjONKeRm21MwuwqzT4xRg53CCsmLPNUtkQb/l
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="321126956"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="321126956"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 15:26:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="628799429"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="628799429"
Received: from varram-mobl2.amr.corp.intel.com (HELO technocore.fios-router.home) ([10.209.13.166])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 15:26:53 -0700
From:   Todd Brandt <todd.e.brandt@linux.intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        rjw@rjwysocki.net
Cc:     todd.e.brandt@linux.intel.com, todd.e.brandt@intel.com
Subject: [PATCH v2] pm-graph v5.10 regression fix
Date:   Mon, 13 Mar 2023 15:26:52 -0700
Message-Id: <20230313222652.402272-1-todd.e.brandt@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A regression has occurred in the hid-sensor code where a device
name string has not been initialized to 0, and ends up without
a NULL char and its printed with %s. This includes random binary
data in the device name, which makes its way into the ftrace output
and ends up crashing sleepgraph because it expects the ftrace output
to be ASCII only.

For example: "HID-SENSOR-INT-020b?.39.auto" ends up in ftrace instead
of "HID-SENSOR-INT-020b.39.auto". It causes this crash in sleepgraph:

  File "/usr/bin/sleepgraph", line 5579, in executeSuspend
    for line in fp:
  File "/usr/lib/python3.10/codecs.py", line 322, in decode
    (result, consumed) = self._buffer_decode(data, self.errors, final)
UnicodeDecodeError: 'utf-8' codec can't decode byte 0xff in position
1568: invalid start byte

The issue is in 6.3-rc1 and is decribed in full here:
https://bugzilla.kernel.org/show_bug.cgi?id=217169

I've submitted a separate fix to have this issue repaired, but
it has also exposed a larger bug in sleepgraph, since nothing should make
sleepgraph crash. Sleepgraph needs to be able to handle biary
data showing up in ftrace gracefully.

I've changed the ftrace processing code to treat it as potentially
binary and to filter out binary data and leave just the ASCII.

Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>
---
 tools/power/pm-graph/sleepgraph.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/power/pm-graph/sleepgraph.py b/tools/power/pm-graph/sleepgraph.py
index 82c09cd25cc2..bf4ac24a1c7a 100755
--- a/tools/power/pm-graph/sleepgraph.py
+++ b/tools/power/pm-graph/sleepgraph.py
@@ -5556,9 +5556,8 @@ def executeSuspend(quiet=False):
 		if not quiet:
 			pprint('CAPTURING TRACE')
 		op = sv.writeDatafileHeader(sv.ftracefile, testdata)
-		fp = open(tp+'trace', 'r')
-		for line in fp:
-			op.write(line)
+		fp = open(tp+'trace', 'rb')
+		op.write(ascii(fp.read()))
 		op.close()
 		sv.fsetVal('', 'trace')
 		sv.platforminfo(cmdafter)
-- 
2.34.1

