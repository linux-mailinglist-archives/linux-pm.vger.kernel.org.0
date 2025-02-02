Return-Path: <linux-pm+bounces-21226-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E078A24F19
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 18:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 456E31883D6F
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 17:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7FC1FAC52;
	Sun,  2 Feb 2025 17:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+HsMxgD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F751FB3
	for <linux-pm@vger.kernel.org>; Sun,  2 Feb 2025 17:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738516379; cv=none; b=kv7BbNxCGhMuIshIedYBpiOszDuQJwrViMBVAJk1nVDpwmGxBtj5ZNT+OqrM/8vo3MmaOvtDGgJBY1eGaQup0zcxitvOZnZIDVKgJOP5oF0WSToXtoMng03WU9UCHL/SCDPlZRdcVxcVy+pUVres8llLLhlozyhQoNnPw4drPSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738516379; c=relaxed/simple;
	bh=HZvtJGHwFfuZ1oAKiELf3sAagITeotaEIXsLvIJwtKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NcJmw5h+Jn2v/zGu9Zm5YTB0fn3JmVWKKYKIvJSJfCZT2BJeoMNuZOwfU1rKiMjvcUmUBAmPtlFkrJDHSvwwWzhKKdyO7cc74BrPq5LNrgyjihlQ8sAjrrCb/ZxhLa9ewTG3awdkUQPYT5X2x/XQFO4a1b4tVvIQTAMN9W/18xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+HsMxgD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFD5C4CEE0;
	Sun,  2 Feb 2025 17:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738516379;
	bh=HZvtJGHwFfuZ1oAKiELf3sAagITeotaEIXsLvIJwtKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=N+HsMxgDEj2WtIBbxXqlXelFdFLZZPnBipo+fF2QdBlNXJYd/X1TpUgz5VFo3mecK
	 WT5cXKunwSyopeOHh/067rf5evWqScfabZGqztF72tVbhSPcUWBkI1apciav9fcwQD
	 drjePHJxdKAUq8ZCpchCbY3RjehMKErVBIedpkNuom8axJvHZ60dQlS05tnlZNivwI
	 RkFwLGbnrq/FSp3tZ7V9z67v0gXBsW9WPj9ngTMSbjloJjPMzIA6RIJe6DcLRfHc0U
	 AUD4Arr7IDrhTP8dhnofBgMgEGCtSAw3B5tekSjcZjfQaLPskMWB25YLAXWlGLNvJ0
	 q4+xjFU2xab4Q==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 03/25] tools/power turbostat: update turbostat(8)
Date: Sun,  2 Feb 2025 11:09:19 -0600
Message-ID: <9e47f8adb053b69e2e8310551e6fd5156704cef4.1738515889.git.len.brown@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <e8a99af68c068865dbac7f3330e97bf8e96edf33.1738515889.git.len.brown@intel.com>
References: <e8a99af68c068865dbac7f3330e97bf8e96edf33.1738515889.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

Clarify how to get the latest version.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.8 | 28 ++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index a7f7ed01421c..59b89e6b25bf 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -516,14 +516,40 @@ that they count at TSC rate, which is true on all processors tested to date.
 Volume 3B: System Programming Guide"
 https://www.intel.com/products/processor/manuals/
 
+.SH RUN THE LATEST VERSION
+If turbostat complains that it doesn't recognize your processor,
+please try the latest version.
+
+The latest version of turbostat does not require the latest version of the Linux kernel.
+However, some features, such as perf(1) counters, do require kernel support.
+
+The latest turbostat release is available in the upstream Linux Kernel source tree.
+eg. "git pull https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git"
+and run make in tools/power/x86/turbostat/.
+
+n.b. "make install" will update your system manually, but a distro update may subsequently downgrade your turbostat to an older version.
+For this reason, manually installing to /usr/local/bin may be what you want.
+
+Note that turbostat/Makefile has a "make snapshot" target, which will create a tar file
+that can build without a local kernel source tree.
+
+If the upstream version isn't new enough, the development tree can be found here:
+"git pull https://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat"
+
+If the development tree doesn't work, please contact the author via chat,
+or via email with the word "turbostat" on the Subject line.
+
 .SH FILES
 .ta
 .nf
+/sys/bus/event_source/devices/
 /dev/cpu/*/msr
+/sys/class/intel_pmt/
+/sys/devices/system/cpu/
 .fi
 
 .SH "SEE ALSO"
-msr(4), vmstat(8)
+perf(1), msr(4), vmstat(8)
 .PP
 .SH AUTHOR
 .nf
-- 
2.43.0


