Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D487D616E24
	for <lists+linux-pm@lfdr.de>; Wed,  2 Nov 2022 21:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiKBUAd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Nov 2022 16:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbiKBUAE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Nov 2022 16:00:04 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6531D9
        for <linux-pm@vger.kernel.org>; Wed,  2 Nov 2022 12:59:54 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id l15so9401qtv.4
        for <linux-pm@vger.kernel.org>; Wed, 02 Nov 2022 12:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fpm431bYP8QwUdLr+4n1KVOYQ+nWgckNOwD7MITmsBE=;
        b=oukJAndoOVYptwA/ko//ZA0slgnoiO9Srgx8YarCq9DZvCjxgtGU8rJvytWk5vj1Jk
         pMg7atFIm8VKEw+qvDYwm0iSaH8DmjXeiIqCvcKwCYo4Dm5wUOHBzijPt8iL+kIKyxGG
         8fc0BguikjQn7iYNpdVoAIUk9FhDo5D9ekcQWLG6fMqiv+aYt86WL6JbBXRfhJh23lq1
         sqJFX3r/zAMyASTb2YU1otXZ/KMvE2EK1EEW8lMxCW+06lx71Ok15IMEfEsYlBGNu7Ii
         DFD0ohn15k0br+ogilgufpmSwLsZvXqKccSQDaTHeah3grjzR72FWsA+oZ5c2wrIvxJU
         2idg==
X-Gm-Message-State: ACrzQf0e/cjbY+N//QI52PK46IuwXgkpxnJEj95/IBq6RLo74Dw/sdRi
        hiCvZO24sO3m+BAVFKpV84a8V0+m8zKlocFcNdI=
X-Google-Smtp-Source: AMsMyM5CEOfrOgBo214jdWKuetV1Zuve4Q+tSx4IBQUyFCxXl1Vv3UCHb8c6Y/Z6BH3YQ+/h5WlHpwWUs9a+ox5lgFo=
X-Received: by 2002:a05:622a:1a25:b0:39c:b862:7318 with SMTP id
 f37-20020a05622a1a2500b0039cb8627318mr21341919qtb.147.1667419193768; Wed, 02
 Nov 2022 12:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <20221102064750.2609503-1-chenhuacai@loongson.cn>
In-Reply-To: <20221102064750.2609503-1-chenhuacai@loongson.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 2 Nov 2022 20:59:34 +0100
Message-ID: <CAJZ5v0hLDm6Y7QR0azDKNo5eS9U6QkjZ9N-PkjnrSMLZK_07aQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "LoongArch: Provisionally add ACPICA data structures"
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        loongarch@lists.linux.dev, linux-pm@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 2, 2022 at 7:50 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> This reverts commit af6a1cfa6859dab4a843 ("LoongArch: Provisionally add
> ACPICA data structures") to fix build error for linux-next on LoongArch,
> since acpica is merged to linux-pm.git now.
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Would you mind if I added this to my acpica branch?

There would be no cross-tree dependencies then.

> ---
>  arch/loongarch/include/asm/acpi.h | 142 ------------------------------
>  1 file changed, 142 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/acpi.h b/arch/loongarch/include/asm/acpi.h
> index 17162f494b9b..825c2519b9d1 100644
> --- a/arch/loongarch/include/asm/acpi.h
> +++ b/arch/loongarch/include/asm/acpi.h
> @@ -31,148 +31,6 @@ static inline bool acpi_has_cpu_in_madt(void)
>
>  extern struct list_head acpi_wakeup_device_list;
>
> -/*
> - * Temporary definitions until the core ACPICA code gets updated (see
> - * 1656837932-18257-1-git-send-email-lvjianmin@loongson.cn and its
> - * follow-ups for the "rationale").
> - *
> - * Once the "legal reasons" are cleared and that the code is merged,
> - * this can be dropped entierely.
> - */
> -#if (ACPI_CA_VERSION == 0x20220331 && !defined(LOONGARCH_ACPICA_EXT))
> -
> -#define LOONGARCH_ACPICA_EXT   1
> -
> -#define        ACPI_MADT_TYPE_CORE_PIC         17
> -#define        ACPI_MADT_TYPE_LIO_PIC          18
> -#define        ACPI_MADT_TYPE_HT_PIC           19
> -#define        ACPI_MADT_TYPE_EIO_PIC          20
> -#define        ACPI_MADT_TYPE_MSI_PIC          21
> -#define        ACPI_MADT_TYPE_BIO_PIC          22
> -#define        ACPI_MADT_TYPE_LPC_PIC          23
> -
> -/* Values for Version field above */
> -
> -enum acpi_madt_core_pic_version {
> -       ACPI_MADT_CORE_PIC_VERSION_NONE = 0,
> -       ACPI_MADT_CORE_PIC_VERSION_V1 = 1,
> -       ACPI_MADT_CORE_PIC_VERSION_RESERVED = 2 /* 2 and greater are reserved */
> -};
> -
> -enum acpi_madt_lio_pic_version {
> -       ACPI_MADT_LIO_PIC_VERSION_NONE = 0,
> -       ACPI_MADT_LIO_PIC_VERSION_V1 = 1,
> -       ACPI_MADT_LIO_PIC_VERSION_RESERVED = 2  /* 2 and greater are reserved */
> -};
> -
> -enum acpi_madt_eio_pic_version {
> -       ACPI_MADT_EIO_PIC_VERSION_NONE = 0,
> -       ACPI_MADT_EIO_PIC_VERSION_V1 = 1,
> -       ACPI_MADT_EIO_PIC_VERSION_RESERVED = 2  /* 2 and greater are reserved */
> -};
> -
> -enum acpi_madt_ht_pic_version {
> -       ACPI_MADT_HT_PIC_VERSION_NONE = 0,
> -       ACPI_MADT_HT_PIC_VERSION_V1 = 1,
> -       ACPI_MADT_HT_PIC_VERSION_RESERVED = 2   /* 2 and greater are reserved */
> -};
> -
> -enum acpi_madt_bio_pic_version {
> -       ACPI_MADT_BIO_PIC_VERSION_NONE = 0,
> -       ACPI_MADT_BIO_PIC_VERSION_V1 = 1,
> -       ACPI_MADT_BIO_PIC_VERSION_RESERVED = 2  /* 2 and greater are reserved */
> -};
> -
> -enum acpi_madt_msi_pic_version {
> -       ACPI_MADT_MSI_PIC_VERSION_NONE = 0,
> -       ACPI_MADT_MSI_PIC_VERSION_V1 = 1,
> -       ACPI_MADT_MSI_PIC_VERSION_RESERVED = 2  /* 2 and greater are reserved */
> -};
> -
> -enum acpi_madt_lpc_pic_version {
> -       ACPI_MADT_LPC_PIC_VERSION_NONE = 0,
> -       ACPI_MADT_LPC_PIC_VERSION_V1 = 1,
> -       ACPI_MADT_LPC_PIC_VERSION_RESERVED = 2  /* 2 and greater are reserved */
> -};
> -
> -#pragma pack(1)
> -
> -/* Core Interrupt Controller */
> -
> -struct acpi_madt_core_pic {
> -       struct acpi_subtable_header header;
> -       u8 version;
> -       u32 processor_id;
> -       u32 core_id;
> -       u32 flags;
> -};
> -
> -/* Legacy I/O Interrupt Controller */
> -
> -struct acpi_madt_lio_pic {
> -       struct acpi_subtable_header header;
> -       u8 version;
> -       u64 address;
> -       u16 size;
> -       u8 cascade[2];
> -       u32 cascade_map[2];
> -};
> -
> -/* Extend I/O Interrupt Controller */
> -
> -struct acpi_madt_eio_pic {
> -       struct acpi_subtable_header header;
> -       u8 version;
> -       u8 cascade;
> -       u8 node;
> -       u64 node_map;
> -};
> -
> -/* HT Interrupt Controller */
> -
> -struct acpi_madt_ht_pic {
> -       struct acpi_subtable_header header;
> -       u8 version;
> -       u64 address;
> -       u16 size;
> -       u8 cascade[8];
> -};
> -
> -/* Bridge I/O Interrupt Controller */
> -
> -struct acpi_madt_bio_pic {
> -       struct acpi_subtable_header header;
> -       u8 version;
> -       u64 address;
> -       u16 size;
> -       u16 id;
> -       u16 gsi_base;
> -};
> -
> -/* MSI Interrupt Controller */
> -
> -struct acpi_madt_msi_pic {
> -       struct acpi_subtable_header header;
> -       u8 version;
> -       u64 msg_address;
> -       u32 start;
> -       u32 count;
> -};
> -
> -/* LPC Interrupt Controller */
> -
> -struct acpi_madt_lpc_pic {
> -       struct acpi_subtable_header header;
> -       u8 version;
> -       u64 address;
> -       u16 size;
> -       u8 cascade;
> -};
> -
> -#pragma pack()
> -
> -#endif
> -
>  #endif /* !CONFIG_ACPI */
>
>  #define ACPI_TABLE_UPGRADE_MAX_PHYS ARCH_LOW_ADDRESS_LIMIT
> --
> 2.31.1
>
