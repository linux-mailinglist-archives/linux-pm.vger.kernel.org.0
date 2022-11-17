Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C6D62D763
	for <lists+linux-pm@lfdr.de>; Thu, 17 Nov 2022 10:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbiKQJr1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Nov 2022 04:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbiKQJr0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Nov 2022 04:47:26 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7FD7615E
        for <linux-pm@vger.kernel.org>; Thu, 17 Nov 2022 01:47:25 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7337522603;
        Thu, 17 Nov 2022 09:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668678444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=XFuOIg4lcOrQyfQYZOgi3Cg4P5fkm0FfclgV7pgOsI0=;
        b=cR3wkFUqbNPbjnZ8gHpHDErBkS05bR4arKjkW+OU4d4wI7ThB7KZtvg8RVl7MZWwHfuKli
        0LWDxjid3yaKtDRTuaM8sc9b2Kxx11bysUmcKNXHtu6NVkpDFBFhU+lJcg10CY0QeC9ybc
        iWZGieCb3hJ6QrsYraDLT3Alxsy+qok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668678444;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=XFuOIg4lcOrQyfQYZOgi3Cg4P5fkm0FfclgV7pgOsI0=;
        b=YGpVquJfRnOENOto1Vfxb/JAxwiMgExibkH8lGcQVxgTdWeb92Qwl0L0FJxoCbSVGq2gBU
        hNXInaXoHT+RXVAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4DE4B13B56;
        Thu, 17 Nov 2022 09:47:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /oCOESwDdmO9EwAAMHmgww
        (envelope-from <trenn@suse.de>); Thu, 17 Nov 2022 09:47:24 +0000
From:   Thomas Renninger <trenn@suse.de>
To:     linux-pm@vger.kernel.org
Cc:     skhan@linuxfoundation.org, Zhang Rui <rui.zhang@intel.com>,
        daniel.lezcano@linaro.org
Subject: [PATCH 0/2] cpupower: Introduce powercap module
Date:   Thu, 17 Nov 2022 10:47:23 +0100
Message-ID: <3231607.VqM8IeB0Os@work>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Powercapping is an important functionality when it's about
processor power consumption.

Intel rapl driver exposes worthful information about CPU's
and related power consumption.

This patch series is a starting point to expose this information
to the user.

Thomas Renninger (2):
  cpupower: Introduce powercap intel-rapl library helpers and
    powercap-info command
  cpupower: rapl monitor - shows the used power consumption in uj for
    each rapl domain

 tools/power/cpupower/Makefile                 |  15 +-
 tools/power/cpupower/utils/builtin.h          |   2 +
 tools/power/cpupower/utils/cpupower.c         |   1 +
 .../utils/idle_monitor/cpupower-monitor.c     |   7 +-
 .../utils/idle_monitor/idle_monitors.def      |   1 +
 .../utils/idle_monitor/rapl_monitor.c         | 147 ++++++++++++++++++
 tools/power/cpupower/utils/powercap-info.c    | 113 ++++++++++++++
 7 files changed, 279 insertions(+), 7 deletions(-)
 create mode 100644 tools/power/cpupower/utils/idle_monitor/rapl_monitor.c
 create mode 100644 tools/power/cpupower/utils/powercap-info.c

-- 
2.37.1




