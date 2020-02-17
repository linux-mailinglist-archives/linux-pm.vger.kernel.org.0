Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3CE1609B2
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2020 05:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgBQEyW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 16 Feb 2020 23:54:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42514 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbgBQEyW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 16 Feb 2020 23:54:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=k5opVoMpuRar8bobAnOBPFuQK3PPZAwrp6fhQdw1Y6E=; b=nWc35DABXLQ88LHytoOlqPLxTV
        qEOe4DCb2+3I234jrA83WFNTHaSe5wmnHW40HxJQOrxHGZabQRu4N3LU6O9nywf0lAPxX9ixYXHMb
        MpKvgFa+5S5w8X81fLPogjo2oOjR9Gtc0/MHWUSe+JChDTNm24+vdjdNSBHF+zS6QiUd+8bu24fnT
        QB0liRDEAu25mXlYvHrIkWnXMVfkrsjnVqtUiSLatOq5yX4UecUUZz3lLhuI3/zhwvle0oZcODEnu
        OWOGCgp1CW7uOGIi6xijrmcP1U0nXGrqDpoeqp5VAp0L3UJyEluYiSP7JFKwEKFw8+kTBODBI9wtK
        c+wWmG3Q==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3YQI-0005Hi-2E; Mon, 17 Feb 2020 04:54:22 +0000
To:     Linux PM list <linux-pm@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] Documentation/power: fix pm_qos_interface.rst format
 warning
Message-ID: <561e2780-111a-1939-43fb-ae32d7abce8d@infradead.org>
Date:   Sun, 16 Feb 2020 20:54:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix Sphinx warnings by indenting the bullet list (and making it
unnumbered).

Documentation/power/pm_qos_interface.rst:12: WARNING: Unexpected indentation.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/power/pm_qos_interface.rst |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200217.orig/Documentation/power/pm_qos_interface.rst
+++ linux-next-20200217/Documentation/power/pm_qos_interface.rst
@@ -7,8 +7,8 @@ performance expectations by drivers, sub
 one of the parameters.
 
 Two different PM QoS frameworks are available:
-1. CPU latency QoS.
-2. The per-device PM QoS framework provides the API to manage the
+ * CPU latency QoS.
+ * The per-device PM QoS framework provides the API to manage the
    per-device latency constraints and PM QoS flags.
 
 The latency unit used in the PM QoS framework is the microsecond (usec).

