Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2153138A02
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2020 04:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387525AbgAMDxN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Jan 2020 22:53:13 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:51067 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387415AbgAMDxN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Jan 2020 22:53:13 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 2F74C21C1B;
        Sun, 12 Jan 2020 22:53:12 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 12 Jan 2020 22:53:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=vCm43OVqh1tdf1g+1ymIQ+gacG
        hvIUXgumdmJE6p1gg=; b=Q8EoaAJx/buSkJA12CwUm6dqAm86cDJK632cl3DuuB
        THZMgGlFS+05Djk7Y0O+UQXBLX+CVdSzhfiwQ9qEF2ynmVc8YCAtbqdBUzO9nURb
        PItLMLayCvUwvdfL2wBPHUyYKrOjj1Pa79WtJt4aEv55cIL0lG8hAVkZ6muM9QuV
        o3JzExcqAxy9fpEA5A24XQ19Sg5y1RGiTwzc+Jf26Axb1Zf7EUcwvDGa39fEeqUT
        t5CmD1lJvKWuqJep9d5e6qKwZTJi+ZQAM8XNHmcSzYTaIWD+9bgTTeCTSscFGNW4
        eEvGu72hJTAeKlQ+P2PjNNgs3OJSPpkufP2LVy6esd4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=vCm43OVqh1tdf1g+1
        ymIQ+gacGhvIUXgumdmJE6p1gg=; b=cSEIE+rt3kDCiy3VkOFlDc3v2WI0WmA2j
        ZcLSzw248FK9dnaXqZ6owZ/L60SfMJiWcAWSfzPTebndhgkvQ9SxszbRtkXpnUJD
        1IOlFysvlWVW1xNP6DxUxTofrNDhk6549/5dTyeRog/Q3bH3nBqCd77sJW043Zl3
        9TzBGhuPEIvkawBSE1u3yzYLmIcwHldUGshS/Rn99G1MMmhAkermbbjshAspO1Aq
        DX46cQpvVoxa7sARq53u/hPCkAWfSq6JgSy/1OQfjnzJOWtLseaPkekQ+kCGP6+C
        NuZSUm1BKSv05cOiJhO9Jj5Q2ozD5zCTNc2k28kQSRujVPKJ92DFQ==
X-ME-Sender: <xms:p-kbXnqt20zVQ-jZidwpNrfPFM9A56TyueatdfMlJFpzyx3vX7YP0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdeiledgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkphepje
    dtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgv
    lhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:p-kbXvIorP9uOhhwxE-FS2-Rmli_6Dwxg1owlXvtX0IX64Ux9m06fQ>
    <xmx:p-kbXgTxoy6sIm87M0Zt_9Fnd6ANrC_qeS--boT7FpU3pZQpu8pzmw>
    <xmx:p-kbXoIeeGyILxtC5yeJXqbrwipS9GI6Q5DnIFi4zG527c0Qv42igg>
    <xmx:qOkbXmclPClu0UfSeo5TuY174vVbKkw8_Gskg1DEihtZ2nBoRjCBJQ>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 403248005C;
        Sun, 12 Jan 2020 22:53:11 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>, Sebastian Reichel <sre@kernel.org>,
        Oskari Lemmela <oskari@lemmela.net>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 0/8] X-Powers Power Supply Improvements
Date:   Sun, 12 Jan 2020 21:53:02 -0600
Message-Id: <20200113035310.18950-1-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series adds some improvements to the axp20x* power supply drivers
to better support suspend/resume and use on mobile devices.

The first two patches fix bugs I found while testing the ONLINE control
added in later patches.

Patches 3 and 7 allow userspace to take the power supplies offline.
Patches 4 and 8 allow userspace to control the wakeup behavior.

Patch 9 avoids polling USB VBUS presence when possible. While working on
the RSB driver, I was seeing ~50 transfers per second, while idle and
tracked it down to this VBUS polling (20 reads/second). The polling
often caused the CPU to clock up and back down, which triggered the
remaining transfers (changes to the CPU voltage).

Unfortunately, I don't see a way to avoid the polling when running on
battery (where it matters most), other than to move the polling back to
the USB PHY driver.

Changes since v2:
 - Patch 1 was merged
 - Only check ACIN_PATH_SEL when necessary (1)
 - Update commit message (5)
 - Avoided reordering lines until/unless necessary (5, 7)
 - Update comment and add ID check in axp20x_usb_power_set_property
   (it seemed more correct than adding another comment) (6)
 - Add Reviewed-by where there were no comments (2-4, 7-8)

Changes since v1:
 - Add patches 1-2
 - Shift value properly in calls to regmap_update_bits (3, 7)
 - Use #ifdef instead of #if to avoid -Wundef warnings (4, 8)
 - Poll once after an IRQ, instead of setting power->online in the IRQ (9)
 - Poll once on resume, in case the state changed during suspend (9)

Samuel Holland (8):
  power: supply: axp20x_ac_power: Fix reporting online status
  power: supply: axp20x_ac_power: Allow offlining
  power: supply: axp20x_ac_power: Add wakeup control
  power: supply: axp20x_usb_power: Remove unused device_node
  power: supply: axp20x_usb_power: Use a match structure
  power: supply: axp20x_usb_power: Allow offlining
  power: supply: axp20x_usb_power: Add wakeup control
  power: supply: axp20x_usb_power: Only poll while offline

 drivers/power/supply/axp20x_ac_power.c  | 131 +++++++++++---
 drivers/power/supply/axp20x_usb_power.c | 219 ++++++++++++++++++------
 2 files changed, 276 insertions(+), 74 deletions(-)

-- 
2.23.0

