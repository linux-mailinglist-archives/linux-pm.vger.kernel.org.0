Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB7F2F5B69
	for <lists+linux-pm@lfdr.de>; Thu, 14 Jan 2021 08:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbhANHgy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Jan 2021 02:36:54 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:58439 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727134AbhANHgx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Jan 2021 02:36:53 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 526291287;
        Thu, 14 Jan 2021 02:30:14 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 14 Jan 2021 02:30:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=11vVmhICgQaKCnjaXu8ChcmbdO
        WIh2uA9aaQxcrccQ8=; b=uYugPZPr5TY3Y5wo92jQ7fY/ktNwxpsQfl2IvMa4xy
        NychX2NQrdDnWxTkQG/32SkYUk9aQF9CGapoKE/A9nH8iOhOXpSzcamGZFBtDkZD
        97T9vF19T8s5fRLlcZmHI9PQJh0LoEpS1IQ9UQ54cveHOMB302TfdmjkzZCXb35H
        YmTQM/pMePEbAUc2GD2HkfkuqjK0pszOll5QggLRP0+zhgIgFrO51RcE7ZBIyLMI
        Jk9XVFjTT1T1feiJRx2tz1IimYJBqxESmmgYUAXsHeOSUf5xjAmfrkxKE75Usn86
        JVqtYJWU2+lSQul0C59LdvMpFJESeUY1drGxlV274wuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=11vVmhICgQaKCnjaX
        u8ChcmbdOWIh2uA9aaQxcrccQ8=; b=ekia3S8WvMiLMDcSuccOzG4Kbpfvt4iCw
        2epibDoM7SCDPs0Dbhys2YwYCS4s/VQaP12BhxB+G//Ht+CnosmiPV3gW7sa1qY3
        iHZLwKFx/DXg1RIRoFy8JXsCNLoUDNgrvRc5urV2ZoeKYE2hx9FTeL1VMU9Rnt9V
        Vn4aXJYYUOfCWWsu7QzKq6G5CYHGRvxiKfJaHSRA9RfhPwuIYw2ZfOTSIlbNk6QP
        VgL32TMhmaMgsJEsXJgzKOYybC0j4DOP0YLFmKi7q8sQc2XqZSHtBTUtq4P3YVb/
        91bMnu1mZ0KLrAJJr0XUpWB9EvVa3wrp7gxqsmmmzBrRWLFRjzApQ==
X-ME-Sender: <xms:BfP_X427NJEK1VBtxdgJDUmFT5h4_QT_nDOwwVLsRAfaaOZhYEyOig>
    <xme:BfP_XzGl5qc42QDNnUExx2IgBWcehSSkKMj9t1iC7VP42jxbJjNf4Z2EFKvR-WW8o
    x4uY1SUAloA2dgkSho>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtdeggddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehf
    lhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpefhjedtkedtueehtdeifeetke
    evffetjeetfeegkeevgefftedvudfgleeihfdtudenucfkphepudduiedrvddvkedrkeeg
    rddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjh
    hirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:BfP_Xw60KnRHPapbenhFx6xwcPOmIJWkwqIn-r8vZ0aSIvQLbxe1xw>
    <xmx:BfP_Xx2qvjn8Ra1G0x3J2Al8VXC9o0GQmJ04A_e5M0DW26vX8RX_hA>
    <xmx:BfP_X7FABBjB779Ez1ytKAEO86ZWAZt5Tgox3gisRc9sgVAN6aBiiQ>
    <xmx:BfP_XwRTGsLGBvr90KDOzZyHtd5VIB4TFSEmwhlD2ncIXojr8cvLDXAa0pw>
Received: from strike.U-LINK.com (unknown [116.228.84.2])
        by mail.messagingengine.com (Postfix) with ESMTPA id E95C0108005B;
        Thu, 14 Jan 2021 02:30:10 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-acpi@vger-kernel.org
Cc:     hdegoede@redhat.com, linux-pm@vger.kernel.org, rjw@rjwysocki.net,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/2] ACPI: platform-profile enhancements
Date:   Thu, 14 Jan 2021 15:30:02 +0800
Message-Id: <20210114073004.174502-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Replacing b417d9c7404df67b9be0104585fefb2ca8d36677 at pm/bleeding-edge.

Jiaxun Yang (2):
  ACPI: platform-profile: Drop const qualifier for cur_profile
  ACPI: platform-profile: Introduce object pointers to callbacks

 drivers/acpi/platform_profile.c  | 6 +++---
 include/linux/platform_profile.h | 6 ++++--
 2 files changed, 7 insertions(+), 5 deletions(-)

-- 
2.30.0

