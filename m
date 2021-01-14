Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88FB72F5B78
	for <lists+linux-pm@lfdr.de>; Thu, 14 Jan 2021 08:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbhANHmP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Jan 2021 02:42:15 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:57343 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727184AbhANHmO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Jan 2021 02:42:14 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 1FC7C12FF;
        Thu, 14 Jan 2021 02:30:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 14 Jan 2021 02:30:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=pl/fwFs3liZoW
        1v6PYB/hJz7Z5at8pyDDKPnWlYHs1U=; b=BI0LDD2GoxMjL26gyU+iOizKcSWr0
        1HaMutMvHBoo8RpmAmvEd5+I2mdI1LSawp3yc9Qn+jSAn83FTctDSFOhqsaAVl0+
        wpInRqcY6md7hC/95ofB3J4L/AT/f5aXAOAajvjl5z0p3KSqKLhp7A2YiuirVnm4
        GaWBE3P+oZOvdidIvuYGuB7icYBc/IajT5Uyv6FpIH8yF1iF/7olsWq6dHy1Etp8
        ovOOhvINwy0xQSqyEBdULtMqrKrXSFOiZnK2HDOFezcHB2AlUtHGfzCEA2sq1RQy
        clGDtctX30+RJGqEZhnNLy8WLzAmxLhY5FhA0/VmtQV5utucv3ZHgLNiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=pl/fwFs3liZoW1v6PYB/hJz7Z5at8pyDDKPnWlYHs1U=; b=rCg5rHjS
        9y49OLQb0JdvrwR53IPLinRqWsQ80A+Qo1v+7bfqu6yJGieWIEGYPWhYfpy6pBki
        PbgCf7Y+bMslx4BK6vdl6R1r3DHoXCBMdTYu6OyiKwR+U6SGSoumHjglySCVgS/H
        V86uDCs1OtNH6Us9/CEGA5lniHXYa84ADeRI2P9Uu5wSvMuzSNweeLCf4yXj7UHZ
        6iFr58XemHn+5SIaXGNl5R/C4DP43cExiQQQGxH/SGSACEujppYxekMzYCkK7PVv
        GcPxx5zLJeGEXpmYf63sZWTi83GtLn3XbIsjghAA7mJpHeA7x4muW89Qc6rm5Bao
        a7KmUDMn+QKzrA==
X-ME-Sender: <xms:CPP_X8DgdF0W1esa_eUxLF1m6BNRaXDvJNCt56hphkDJ_jL5bBrkWg>
    <xme:CPP_X-hNpsW0-XiCDJ0w6nROgjIwmgO5bubX0p20m0hFfyMbfudnBepH3Yo_IcD-G
    7zh32Vl_flFuVWasEE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtdeggddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhg
    sehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeehgfelvdeugeetheekge
    dvgeehhfektdetteelhfefkeeuudekvedtteffteegkeenucffohhmrghinhepkhgvrhhn
    vghlrdhorhhgnecukfhppeduudeirddvvdekrdekgedrvdenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhih
    ghhorghtrdgtohhm
X-ME-Proxy: <xmx:CPP_X_nzDYu7aSe4WcCri5SV-DXdvJ4h5YuNyXF-BdvwLgaIXJEg0Q>
    <xmx:CPP_XywDktoM2iR645hHh7G4ro15Xk4L2iy91ydtXiZIF4tJvgjTZA>
    <xmx:CPP_XxSm2I8puEZp8SWnvM65oC9hv0Wv_-Ni8GffQZO2qf_3mGjNWw>
    <xmx:CPP_X8fhwkPlkQmuKC-BR7b1xOSXYTdRjZ2M0X8NzDMyNSKQDIAAQFzI3To>
Received: from strike.U-LINK.com (unknown [116.228.84.2])
        by mail.messagingengine.com (Postfix) with ESMTPA id 13BAA108005C;
        Thu, 14 Jan 2021 02:30:13 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-acpi@vger-kernel.org
Cc:     hdegoede@redhat.com, linux-pm@vger.kernel.org, rjw@rjwysocki.net,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 1/2] ACPI: platform-profile: Drop const qualifier for cur_profile
Date:   Thu, 14 Jan 2021 15:30:03 +0800
Message-Id: <20210114073004.174502-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210114073004.174502-1-jiaxun.yang@flygoat.com>
References: <20210114073004.174502-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

All planned uses of cur_profile have their platform_profile_handler
defined as const, so just drop const qualifier here to prevent build
error.

Link: https://lore.kernel.org/linux-acpi/5e7a4d87-52ef-e487-9cc2-8e7094beaa08@redhat.com/
Suggested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 drivers/acpi/platform_profile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 91be50a32cc8..9dddf44b43d4 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -9,7 +9,7 @@
 #include <linux/platform_profile.h>
 #include <linux/sysfs.h>
 
-static const struct platform_profile_handler *cur_profile;
+static struct platform_profile_handler *cur_profile;
 static DEFINE_MUTEX(profile_lock);
 
 static const char * const profile_names[] = {
-- 
2.30.0

