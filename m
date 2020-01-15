Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA5813B82F
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2020 04:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgAODkv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jan 2020 22:40:51 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:39135 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728879AbgAODku (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jan 2020 22:40:50 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 35B3C2213D;
        Tue, 14 Jan 2020 22:40:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 14 Jan 2020 22:40:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=RrgydXjzryvsT0baMy3pjy0e7s
        fLWEp3zx91v4rk8Kc=; b=odMM3ACvUNQ3DfAJebxF4yBz2RyD9enltEfZnL7exp
        6N6++Ti9G6+t6z0frrlEnSgR+g6zaEEzBSB+A9fhW2fd0B7OriLBST4ZlXZySWGX
        AjTkSR2M7NSSS0Wg2pBxqUhxRtbnz5t0r51xhA0Hk7ynqNPxV9yENmK8ItMHLKIS
        Cl9EQ4niTuqj77b3MsmveiesY5C95AxOcsVwqm9HfIDSaSFEZ5zi2SDSJgSpFAVz
        3D6HLpBaRkVaE/mfBk8i68Gc7vYfFuspnMPL0Ohmmof2gZnYYBlhfhgZ1WA7FmZU
        FIkIgAb0on6dzBwfMjMfCn34706l/tbiuCXIkzOqwthA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=RrgydXjzryvsT0baM
        y3pjy0e7sfLWEp3zx91v4rk8Kc=; b=FmrFlWnHD/9gvAHbizIAHNlp6PuW68wWZ
        v7TtXZCWhjf68zqGSA6dWcmT+GxHsj8kKM8zt4IlcAQkUYZ6+z4tOahAPk7MOniL
        ShyGAjIMt/ougC3kFKmhtV9QjxYC/s0qTWvLoQROP59FWd5qylb2D1m2qLmk1i/3
        ReuRY1vGVM8prrNGwEqS1B3wUNmLu6KUmg5f8PwzX/K51iXrDPbLUHtv9SYSb+Qq
        ruyztiT0LXuOVluH3bq2USj0d1/X1/4OycriNnGZGsKNxDZDQ+ZmbXhipA2HmUXn
        5zWJO5LnIaRYK6caLA+moaYAx7dQEzBDSh1v2ODZ9GqAGbhuQ24rw==
X-ME-Sender: <xms:wYkeXkuQ5UYKGE5zQz7osvQcXUz_DlKGbialkBce6iJMWwMwnG1Hhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrtddvgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghlucfj
    ohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppeejtd
    drudefhedrudegkedrudehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghl
    sehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:wYkeXnwa7xE63m_2A0v9m3INthDutYBqVYOMrbA3WeLlBwIcGiXxfA>
    <xmx:wYkeXlwkdlie93T90lFGzaQJ2kuW8T1EvOE-4HV2f8PmH9o-bQibnw>
    <xmx:wYkeXkjExHoyfk9yGp5bodHvl-Sw6bHIThkWAfvJLLe6KKALmYf4Xw>
    <xmx:wokeXkdV5GkVqne3CpotvjeXEIm0jwwNzYtGDE7ymHzgrW1rUZcodA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 700DD30607B4;
        Tue, 14 Jan 2020 22:40:49 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Oskari Lemmela <oskari@lemmela.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v4 0/4] X-Powers Power Supply Improvements
Date:   Tue, 14 Jan 2020 21:40:44 -0600
Message-Id: <20200115034048.24901-1-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series adds some improvements to the axp20x_usb_power power supply
driver to better support suspend/resume and use on mobile devices.

Patch 1 is preparation for changes in following patches.
Patch 2 allows userspace to take the power supply offline.
Patch 3 allows userspace to control the wakeup behavior.
Patch 4 avoids polling USB VBUS presence when possible.

Changes since v3:
 - Rebase on power-supply/for-next
 - Add Reviewed-by (1-2)

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

Samuel Holland (4):
  power: supply: axp20x_usb_power: Use a match structure
  power: supply: axp20x_usb_power: Allow offlining
  power: supply: axp20x_usb_power: Add wakeup control
  power: supply: axp20x_usb_power: Only poll while offline

 drivers/power/supply/axp20x_usb_power.c | 217 ++++++++++++++++++------
 1 file changed, 169 insertions(+), 48 deletions(-)

-- 
2.23.0

