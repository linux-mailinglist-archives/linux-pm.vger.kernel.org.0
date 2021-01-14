Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68AC2F5B6A
	for <lists+linux-pm@lfdr.de>; Thu, 14 Jan 2021 08:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbhANHgy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Jan 2021 02:36:54 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:54017 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726819AbhANHgx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Jan 2021 02:36:53 -0500
X-Greylist: delayed 353 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Jan 2021 02:36:53 EST
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id CC3E6131F;
        Thu, 14 Jan 2021 02:30:19 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 14 Jan 2021 02:30:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=y9iRB6bWqyUOw
        TqFryU9bKwjbnx+WsNsQUdiHEf3u80=; b=iNgJixmZFXWN3EvPGIHvF4OFkbnQR
        58EZq206l/y9jZeH4mY3BV4+EX01pJQcYyE3i7xcl47E8nd5n832LNbTQ/lc7rbp
        zSNtZYXIpMOVoJcmfzP8eEjyDjHFYYzHyfHmci8vFJ0mTXkQqevUr45FxiEsCweQ
        WRCoj81DEaQeeDd+3eR0BaXM3tSgS7slS67CcuhADBbwjgvppwK8jGki+fff4iD0
        GHaax0KMnklO26zhy9jNjBxVR7aEJNauJasqQzINGFD96q6jRb73JbZwr2i+nsw4
        /WmyT3iijQQKWtwg5qPzbeMjxCP/hTUGq6q6RrhpWcmUcbYs/Ipb4pGkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=y9iRB6bWqyUOwTqFryU9bKwjbnx+WsNsQUdiHEf3u80=; b=UbQAdf7/
        leM+QG+OK0qqlkzqH/TbOL/zFg/mC2ykzjQ8nNZ/ZUPBVyRSj2Kzm2fCUKCBrngv
        kba1IAB9gXrZbLGfu9bxTCAJht/8Uz2ToEyWFG98rRIBloGIr30dPAzRH4JCKH2M
        LVqvoVwasI6svMP6QdosV6k+w7YIwhajtunwqH54qxmMJy66Ssh/vN2fwv+cCiqF
        gFvxpvGK/pxOZq7GXIi3WY3kKDt3LlAE3emXtGCNZbOY04FBtj0WRvXHgZKe+saz
        Mxeyfjigj1gCzMVH6nogRgY4IKbUKHObPOm6ToBM6ajnfOZS/sG6s/e3uYyjNVCr
        oKi3mvLlPeUVrA==
X-ME-Sender: <xms:C_P_X2cQX5wrZiJfaycSgQQqsa_ope0ewKjthe4xeRPX43i7DlbvVg>
    <xme:C_P_XwOiILaFiQmNamTFdOER71VFD7fcI4kW5Oa_h_ZPyIY9HWu4OVtkE7-IH4qPz
    Ng5pE811bbmpx42sd0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtdeggddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhg
    sehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeehgfelvdeugeetheekge
    dvgeehhfektdetteelhfefkeeuudekvedtteffteegkeenucffohhmrghinhepkhgvrhhn
    vghlrdhorhhgnecukfhppeduudeirddvvdekrdekgedrvdenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhih
    ghhorghtrdgtohhm
X-ME-Proxy: <xmx:C_P_X3gFmMm3XvGXKnKlXuZAYl3OJIZuEpPYoAF4zsp9lC_S1Ji9_w>
    <xmx:C_P_Xz-QJ8qW9EtT50kJ18fmwbVZK9pVx7waqu2uXo1C3uhr-yfBXw>
    <xmx:C_P_XyvJyHYm-aVhdH_MbPZG5QAzkNdAW64yreEb-WnYDTU1SW2gNA>
    <xmx:C_P_X76w1YnW3fpbDZIdUnRYhh-lfZfaqr6Jn3GKMoVqdRr_qcf-XG3mmH8>
Received: from strike.U-LINK.com (unknown [116.228.84.2])
        by mail.messagingengine.com (Postfix) with ESMTPA id BBDB21080064;
        Thu, 14 Jan 2021 02:30:16 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-acpi@vger-kernel.org
Cc:     hdegoede@redhat.com, linux-pm@vger.kernel.org, rjw@rjwysocki.net,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 2/2] ACPI: platform-profile: Introduce object pointers to callbacks
Date:   Thu, 14 Jan 2021 15:30:04 +0800
Message-Id: <20210114073004.174502-3-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210114073004.174502-1-jiaxun.yang@flygoat.com>
References: <20210114073004.174502-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a object pointer to handler callbacks to avoid having
global variables everywhere.

Link: https://lore.kernel.org/linux-acpi/6a29f338-d9e4-150c-81dd-2ffb54f5bc35@redhat.com/
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Suggested-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/platform_profile.c  | 4 ++--
 include/linux/platform_profile.h | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 9dddf44b43d4..6398b40e6d31 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -64,7 +64,7 @@ static ssize_t platform_profile_show(struct device *dev,
 		return -ENODEV;
 	}
 
-	err = cur_profile->profile_get(&profile);
+	err = cur_profile->profile_get(cur_profile, &profile);
 	mutex_unlock(&profile_lock);
 	if (err)
 		return err;
@@ -104,7 +104,7 @@ static ssize_t platform_profile_store(struct device *dev,
 		return -EOPNOTSUPP;
 	}
 
-	err = cur_profile->profile_set(i);
+	err = cur_profile->profile_set(cur_profile, i);
 	mutex_unlock(&profile_lock);
 	if (err)
 		return err;
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index 3623d7108421..43f4583b5259 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -28,8 +28,10 @@ enum platform_profile_option {
 
 struct platform_profile_handler {
 	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
-	int (*profile_get)(enum platform_profile_option *profile);
-	int (*profile_set)(enum platform_profile_option profile);
+	int (*profile_get)(struct platform_profile_handler *pprof,
+				enum platform_profile_option *profile);
+	int (*profile_set)(struct platform_profile_handler *pprof,
+				enum platform_profile_option profile);
 };
 
 int platform_profile_register(const struct platform_profile_handler *pprof);
-- 
2.30.0

