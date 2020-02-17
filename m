Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8682B1617BC
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2020 17:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbgBQQUs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Feb 2020 11:20:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54976 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728543AbgBQQUr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Feb 2020 11:20:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=WOmy0+QMckhdBzIIN5N8aTIEyoanTMoTBxTpT7pGGt4=; b=huK7I9hhDe7HhUFZwPp1c1UBu2
        D0Lm6ATDem2jUeAtxLA0b89zENifzaqGIplTVQQQPIRMCcT+K2BBQJ4Y7lQNOXQf4NNlX7FKWslRY
        +3VtsowHd/VXi0l+unvLai/D8/m2lyx1PzfKn4uKXwVoCy/VsUl50MUASDDYOPeovvKhp49F90a3O
        KoPMhg1/PksC8BqRov01NEVjjUjJHEADSS4l5glw/TpqUTtaTXmnG+WKu+OK7kGdwtqB8GQ0v2xPi
        QuNNOcRb0PzZMItizAGQNxR6oZEzvqfxO/Ct2lTcR9nkd+pIDwatkn4p0S0E5y6gxRicfswo3kmDV
        5/YG6XjQ==;
Received: from ip-109-41-129-189.web.vodafone.de ([109.41.129.189] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3j8Y-00042F-8I; Mon, 17 Feb 2020 16:20:46 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j3j8W-000fpl-9P; Mon, 17 Feb 2020 17:20:44 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 15/24] docs: cpu-freq: convert amd-powernow.txt to ReST
Date:   Mon, 17 Feb 2020 17:20:33 +0100
Message-Id: <63e8b6ba6110901079916cbbfb804ca100eab46d.1581956285.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1581956285.git.mchehab+huawei@kernel.org>
References: <cover.1581956285.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

- Add a SPDX header;
- Add a document title, based on the original contents of
  cpu-freq/index.txt;
- some whitespace fixes and new line breaks;
- Add it to cpu-freq/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../cpu-freq/{amd-powernow.txt => amd-powernow.rst}  | 12 ++++++++++--
 Documentation/cpu-freq/index.rst                     |  2 ++
 2 files changed, 12 insertions(+), 2 deletions(-)
 rename Documentation/cpu-freq/{amd-powernow.txt => amd-powernow.rst} (89%)

diff --git a/Documentation/cpu-freq/amd-powernow.txt b/Documentation/cpu-freq/amd-powernow.rst
similarity index 89%
rename from Documentation/cpu-freq/amd-powernow.txt
rename to Documentation/cpu-freq/amd-powernow.rst
index 254da155fa47..4a53612b62a2 100644
--- a/Documentation/cpu-freq/amd-powernow.txt
+++ b/Documentation/cpu-freq/amd-powernow.rst
@@ -1,3 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============================
+AMD PowerNow Driver Specifics
+=============================
+
 
 PowerNow! and Cool'n'Quiet are AMD names for frequency
 management capabilities in AMD processors. As the hardware
@@ -23,16 +29,18 @@ not supply these tables.
 7th Generation: powernow-k7: Athlon, Duron, Geode.
 
 8th Generation: powernow-k8: Athlon, Athlon 64, Opteron, Sempron.
+
 Documentation on this functionality in 8th generation processors
 is available in the "BIOS and Kernel Developer's Guide", publication
-26094, in chapter 9, available for download from www.amd.com. 
+26094, in chapter 9, available for download from www.amd.com.
 
 BIOS supplied data, for powernow-k7 and for powernow-k8, may be
 from either the PSB table or from ACPI objects. The ACPI support
 is only available if the kernel config sets CONFIG_ACPI_PROCESSOR.
 The powernow-k8 driver will attempt to use ACPI if so configured,
 and fall back to PST if that fails.
+
 The powernow-k7 driver will try to use the PSB support first, and
 fall back to ACPI if the PSB support fails. A module parameter,
-acpi_force, is provided to force ACPI support to be used instead 
+acpi_force, is provided to force ACPI support to be used instead
 of PSB support.
diff --git a/Documentation/cpu-freq/index.rst b/Documentation/cpu-freq/index.rst
index 1bff3dfddd23..6f7c2a024447 100644
--- a/Documentation/cpu-freq/index.rst
+++ b/Documentation/cpu-freq/index.rst
@@ -14,6 +14,8 @@ Author: Dominik Brodowski  <linux@brodo.de>
 .. toctree::
    :maxdepth: 1
 
+   amd-powernow
+
 Mailing List
 ------------
 There is a CPU frequency changing CVS commit and general list where
-- 
2.24.1

