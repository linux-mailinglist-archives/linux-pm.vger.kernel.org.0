Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1E1615C75
	for <lists+linux-pm@lfdr.de>; Wed,  2 Nov 2022 07:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiKBGuH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Nov 2022 02:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiKBGt6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Nov 2022 02:49:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7734925F6
        for <linux-pm@vger.kernel.org>; Tue,  1 Nov 2022 23:49:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4379FB820D4
        for <linux-pm@vger.kernel.org>; Wed,  2 Nov 2022 06:49:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BE5C433C1;
        Wed,  2 Nov 2022 06:49:52 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>
Cc:     loongarch@lists.linux.dev, linux-pm@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] Revert "LoongArch: Provisionally add ACPICA data structures"
Date:   Wed,  2 Nov 2022 14:47:50 +0800
Message-Id: <20221102064750.2609503-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This reverts commit af6a1cfa6859dab4a843 ("LoongArch: Provisionally add
ACPICA data structures") to fix build error for linux-next on LoongArch,
since acpica is merged to linux-pm.git now.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/acpi.h | 142 ------------------------------
 1 file changed, 142 deletions(-)

diff --git a/arch/loongarch/include/asm/acpi.h b/arch/loongarch/include/asm/acpi.h
index 17162f494b9b..825c2519b9d1 100644
--- a/arch/loongarch/include/asm/acpi.h
+++ b/arch/loongarch/include/asm/acpi.h
@@ -31,148 +31,6 @@ static inline bool acpi_has_cpu_in_madt(void)
 
 extern struct list_head acpi_wakeup_device_list;
 
-/*
- * Temporary definitions until the core ACPICA code gets updated (see
- * 1656837932-18257-1-git-send-email-lvjianmin@loongson.cn and its
- * follow-ups for the "rationale").
- *
- * Once the "legal reasons" are cleared and that the code is merged,
- * this can be dropped entierely.
- */
-#if (ACPI_CA_VERSION == 0x20220331 && !defined(LOONGARCH_ACPICA_EXT))
-
-#define LOONGARCH_ACPICA_EXT	1
-
-#define	ACPI_MADT_TYPE_CORE_PIC		17
-#define	ACPI_MADT_TYPE_LIO_PIC		18
-#define	ACPI_MADT_TYPE_HT_PIC		19
-#define	ACPI_MADT_TYPE_EIO_PIC		20
-#define	ACPI_MADT_TYPE_MSI_PIC		21
-#define	ACPI_MADT_TYPE_BIO_PIC		22
-#define	ACPI_MADT_TYPE_LPC_PIC		23
-
-/* Values for Version field above */
-
-enum acpi_madt_core_pic_version {
-	ACPI_MADT_CORE_PIC_VERSION_NONE = 0,
-	ACPI_MADT_CORE_PIC_VERSION_V1 = 1,
-	ACPI_MADT_CORE_PIC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
-};
-
-enum acpi_madt_lio_pic_version {
-	ACPI_MADT_LIO_PIC_VERSION_NONE = 0,
-	ACPI_MADT_LIO_PIC_VERSION_V1 = 1,
-	ACPI_MADT_LIO_PIC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
-};
-
-enum acpi_madt_eio_pic_version {
-	ACPI_MADT_EIO_PIC_VERSION_NONE = 0,
-	ACPI_MADT_EIO_PIC_VERSION_V1 = 1,
-	ACPI_MADT_EIO_PIC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
-};
-
-enum acpi_madt_ht_pic_version {
-	ACPI_MADT_HT_PIC_VERSION_NONE = 0,
-	ACPI_MADT_HT_PIC_VERSION_V1 = 1,
-	ACPI_MADT_HT_PIC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
-};
-
-enum acpi_madt_bio_pic_version {
-	ACPI_MADT_BIO_PIC_VERSION_NONE = 0,
-	ACPI_MADT_BIO_PIC_VERSION_V1 = 1,
-	ACPI_MADT_BIO_PIC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
-};
-
-enum acpi_madt_msi_pic_version {
-	ACPI_MADT_MSI_PIC_VERSION_NONE = 0,
-	ACPI_MADT_MSI_PIC_VERSION_V1 = 1,
-	ACPI_MADT_MSI_PIC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
-};
-
-enum acpi_madt_lpc_pic_version {
-	ACPI_MADT_LPC_PIC_VERSION_NONE = 0,
-	ACPI_MADT_LPC_PIC_VERSION_V1 = 1,
-	ACPI_MADT_LPC_PIC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
-};
-
-#pragma pack(1)
-
-/* Core Interrupt Controller */
-
-struct acpi_madt_core_pic {
-	struct acpi_subtable_header header;
-	u8 version;
-	u32 processor_id;
-	u32 core_id;
-	u32 flags;
-};
-
-/* Legacy I/O Interrupt Controller */
-
-struct acpi_madt_lio_pic {
-	struct acpi_subtable_header header;
-	u8 version;
-	u64 address;
-	u16 size;
-	u8 cascade[2];
-	u32 cascade_map[2];
-};
-
-/* Extend I/O Interrupt Controller */
-
-struct acpi_madt_eio_pic {
-	struct acpi_subtable_header header;
-	u8 version;
-	u8 cascade;
-	u8 node;
-	u64 node_map;
-};
-
-/* HT Interrupt Controller */
-
-struct acpi_madt_ht_pic {
-	struct acpi_subtable_header header;
-	u8 version;
-	u64 address;
-	u16 size;
-	u8 cascade[8];
-};
-
-/* Bridge I/O Interrupt Controller */
-
-struct acpi_madt_bio_pic {
-	struct acpi_subtable_header header;
-	u8 version;
-	u64 address;
-	u16 size;
-	u16 id;
-	u16 gsi_base;
-};
-
-/* MSI Interrupt Controller */
-
-struct acpi_madt_msi_pic {
-	struct acpi_subtable_header header;
-	u8 version;
-	u64 msg_address;
-	u32 start;
-	u32 count;
-};
-
-/* LPC Interrupt Controller */
-
-struct acpi_madt_lpc_pic {
-	struct acpi_subtable_header header;
-	u8 version;
-	u64 address;
-	u16 size;
-	u8 cascade;
-};
-
-#pragma pack()
-
-#endif
-
 #endif /* !CONFIG_ACPI */
 
 #define ACPI_TABLE_UPGRADE_MAX_PHYS ARCH_LOW_ADDRESS_LIMIT
-- 
2.31.1

