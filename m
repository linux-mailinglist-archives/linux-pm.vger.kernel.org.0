Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A776E56C7DB
	for <lists+linux-pm@lfdr.de>; Sat,  9 Jul 2022 10:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiGIINd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 Jul 2022 04:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGIINc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 9 Jul 2022 04:13:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DD7CC5
        for <linux-pm@vger.kernel.org>; Sat,  9 Jul 2022 01:13:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 252471F993;
        Sat,  9 Jul 2022 08:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657354408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6cMDdfswH8FckaiaJwBrGCmFHR81bpxEJ1krsPxSr4Y=;
        b=biEgtYy7seNwox/Oe4dUtzXuQ+qNwIwaBhUayDHSS3qaw8lhZKLW0PeSBcxQBtlrFvZyyb
        6FMtf79obr6JsudE6ruCfVRwub4h6zKzze3CcgSj8husKIqD9KpfGljKZg7vwDwAKGHeX5
        cfLtEc9lkYD3dgA4rGeLFmvfBpjaQ7I=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C81713A7D;
        Sat,  9 Jul 2022 08:13:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hXbqAag4yWJdTQAAMHmgww
        (envelope-from <trenn@suse.com>); Sat, 09 Jul 2022 08:13:28 +0000
From:   Thomas Renninger <trenn@suse.com>
To:     linux-pm@vger.kernel.org
Cc:     skhan@linuxfoundation.org
Subject: [PATCH 0/2] Introduce powercap userspace frontend
Date:   Sat, 09 Jul 2022 10:13:27 +0200
Message-ID: <4954139.fJS9391jLT@c100>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

cpupower powercap-info
cpupower monitor -m RAPL

further development could provide:
cpupower powercap-set
to enable/disable RAPL domains, etc.

Thomas Renninger (2):
  cpupower: Introduce powercap intel-rapl library helpers and
    powercap-info command
  cpupower: rapl monitor - shows the used power consumption in uj for
    each rapl domain

 tools/power/cpupower/Makefile                 |  12 +-
 tools/power/cpupower/lib/powercap.c           | 290 ++++++++++++++++++
 tools/power/cpupower/lib/powercap.h           |  54 ++++
 .../cpupower/man/cpupower-powercap-info.1     |  25 ++
 tools/power/cpupower/utils/builtin.h          |   2 +
 tools/power/cpupower/utils/cpupower.c         |   1 +
 .../utils/idle_monitor/cpupower-monitor.c     |   7 +-
 .../utils/idle_monitor/idle_monitors.def      |   1 +
 .../utils/idle_monitor/rapl_monitor.c         | 141 +++++++++
 tools/power/cpupower/utils/powercap-info.c    | 113 +++++++
 10 files changed, 639 insertions(+), 7 deletions(-)
 create mode 100644 tools/power/cpupower/lib/powercap.c
 create mode 100644 tools/power/cpupower/lib/powercap.h
 create mode 100644 tools/power/cpupower/man/cpupower-powercap-info.1
 create mode 100644 tools/power/cpupower/utils/idle_monitor/rapl_monitor.c
 create mode 100644 tools/power/cpupower/utils/powercap-info.c

-- 
2.33.0




