Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3633E50B2
	for <lists+linux-pm@lfdr.de>; Tue, 10 Aug 2021 03:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbhHJBpF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Aug 2021 21:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbhHJBpF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Aug 2021 21:45:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323DCC0613D3;
        Mon,  9 Aug 2021 18:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=WZjBScLSkxsej2CYjZzeF6pwIPZQKqWEzTgHASXF2KM=; b=FvprHoA9kqiaa6ghZpx071lb90
        WbbBGbJb+bizqEWTFWwbb3VsFr2pMmrET/IAxj/DChk6vvri3yaAkWdvnRMeUy98ZpODo+0SWPtvA
        zYPTIk/s0RYE5uoNO7CAQuTxlEdKGUUgmIniNXsB9YWQKZ5AD7avk3XgFjeQXcrm+ULhCz86s2CAo
        xwu0vxUAlPoihyQbZf6565gJWIueN9S0/whKbZoG9e59HJoWvA+UNE+Zrlo3psS2FlywNEBBnfonN
        JZ+2U6iMkK11Qro5WHthuoPy9YPu4pyvEMBXi5U6luBKX7XrnAD0/2nzFy2Z81GOV5T0To9anWlKv
        2meyVO/w==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDGot-002EN3-6m; Tue, 10 Aug 2021 01:44:43 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH] kernel/power: unmark 'state' functions as kernel-doc
Date:   Mon,  9 Aug 2021 18:44:42 -0700
Message-Id: <20210810014442.7446-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix kernel-doc warnings in kernel/power/main.c by unmarking the
comment block as kernel-doc notation. This eliminates the following
kernel-doc warnings:

kernel/power/main.c:593: warning: expecting prototype for state(). Prototype was for state_show() instead
kernel/power/main.c:593: warning: Function parameter or member 'kobj' not described in 'state_show'
kernel/power/main.c:593: warning: Function parameter or member 'attr' not described in 'state_show'
kernel/power/main.c:593: warning: Function parameter or member 'buf' not described in 'state_show'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: linux-pm@vger.kernel.org
---
 kernel/power/main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20210809.orig/kernel/power/main.c
+++ linux-next-20210809/kernel/power/main.c
@@ -577,7 +577,7 @@ static inline void pm_print_times_init(v
 
 struct kobject *power_kobj;
 
-/**
+/*
  * state - control system sleep states.
  *
  * show() returns available sleep state labels, which may be "mem", "standby",
