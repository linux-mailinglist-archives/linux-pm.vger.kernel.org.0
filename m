Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18C6617435
	for <lists+linux-pm@lfdr.de>; Thu,  3 Nov 2022 03:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiKCC3x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Nov 2022 22:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiKCC3v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Nov 2022 22:29:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBF5CCA
        for <linux-pm@vger.kernel.org>; Wed,  2 Nov 2022 19:29:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAEDA61CE4
        for <linux-pm@vger.kernel.org>; Thu,  3 Nov 2022 02:29:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40541C433D6
        for <linux-pm@vger.kernel.org>; Thu,  3 Nov 2022 02:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667442589;
        bh=Sq9rrnqD8ccggdb87O4voEYKRkri+79IUG5ZurtLBw0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ELkh/9hOKPVdI921UsL+6dh+rB6zi46HipbiTzYZa33e5j6aBIt4WUOCjnJjObNOw
         lAstUS/AI1OwVnasQT7vD6OqbpmXmvJYJvFoMjniE9sz23ltqSCzfTxvHwRQVaapSk
         bnwkDqPXP426ULmGS0ME3nU3PO/c7vW70/dRlhCbmech2wr+rf3e1AUMO1wJ8a+1ie
         vxkAp/7iU3nFZP4axSVKZymmCJhNAetC0vP3h9rMmrp68ZBiXYYscjNML1uAJ9/xtP
         PzBWS1nSueijMbtzaZdaK8y9qvglwqX/wSm2caG14A8RRSBZougrE04dh/eYF5S0X7
         LS+AEP/gNOBUA==
Received: by mail-ej1-f52.google.com with SMTP id d26so1734379eje.10
        for <linux-pm@vger.kernel.org>; Wed, 02 Nov 2022 19:29:49 -0700 (PDT)
X-Gm-Message-State: ACrzQf09Wow9GpOubVBWNjXfE7/pVinsYdXLU7B1qi0HOY0wUiwOUSE6
        fsMQ/Q4d8Fte9a4CyFS7ScZs9r6wnxpupUYki/g=
X-Google-Smtp-Source: AMsMyM5Wul4EL1+0HB6fJSvjGNuQ/9zRaABncxYCB3vvel/ATwuEbQtpEjqmyBO25Udj0kDSMsI44W0H6B1d31dHUvI=
X-Received: by 2002:a17:907:3ea2:b0:7ad:86f9:7b15 with SMTP id
 hs34-20020a1709073ea200b007ad86f97b15mr26399709ejc.272.1667442587444; Wed, 02
 Nov 2022 19:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <20221102064750.2609503-1-chenhuacai@loongson.cn> <CAJZ5v0hLDm6Y7QR0azDKNo5eS9U6QkjZ9N-PkjnrSMLZK_07aQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0hLDm6Y7QR0azDKNo5eS9U6QkjZ9N-PkjnrSMLZK_07aQ@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 3 Nov 2022 10:29:36 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4tQEz5QQurLzRxCe0Ct8Uu4ZZD6yjaRgh=r+V_2jQMPA@mail.gmail.com>
Message-ID: <CAAhV-H4tQEz5QQurLzRxCe0Ct8Uu4ZZD6yjaRgh=r+V_2jQMPA@mail.gmail.com>
Subject: Re: [PATCH] Revert "LoongArch: Provisionally add ACPICA data structures"
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        loongarch@lists.linux.dev, linux-pm@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi, Rafael,

On Thu, Nov 3, 2022 at 3:59 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Nov 2, 2022 at 7:50 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > This reverts commit af6a1cfa6859dab4a843 ("LoongArch: Provisionally add
> > ACPICA data structures") to fix build error for linux-next on LoongArch,
> > since acpica is merged to linux-pm.git now.
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>
> Would you mind if I added this to my acpica branch?
>
> There would be no cross-tree dependencies then.
Emm, I hope this patch be merged via your acpi tree, and so does
another patch named "ACPI / table: Print CORE_PIC information when
MADT is parsed".

Huacai
>
> > ---
> >  arch/loongarch/include/asm/acpi.h | 142 ------------------------------
> >  1 file changed, 142 deletions(-)
> >
> > diff --git a/arch/loongarch/include/asm/acpi.h b/arch/loongarch/include/asm/acpi.h
> > index 17162f494b9b..825c2519b9d1 100644
> > --- a/arch/loongarch/include/asm/acpi.h
> > +++ b/arch/loongarch/include/asm/acpi.h
> > @@ -31,148 +31,6 @@ static inline bool acpi_has_cpu_in_madt(void)
> >
> >  extern struct list_head acpi_wakeup_device_list;
> >
> > -/*
> > - * Temporary definitions until the core ACPICA code gets updated (see
> > - * 1656837932-18257-1-git-send-email-lvjianmin@loongson.cn and its
> > - * follow-ups for the "rationale").
> > - *
> > - * Once the "legal reasons" are cleared and that the code is merged,
> > - * this can be dropped entierely.
> > - */
> > -#if (ACPI_CA_VERSION == 0x20220331 && !defined(LOONGARCH_ACPICA_EXT))
> > -
> > -#define LOONGARCH_ACPICA_EXT   1
> > -
> > -#define        ACPI_MADT_TYPE_CORE_PIC         17
> > -#define        ACPI_MADT_TYPE_LIO_PIC          18
> > -#define        ACPI_MADT_TYPE_HT_PIC           19
> > -#define        ACPI_MADT_TYPE_EIO_PIC          20
> > -#define        ACPI_MADT_TYPE_MSI_PIC          21
> > -#define        ACPI_MADT_TYPE_BIO_PIC          22
> > -#define        ACPI_MADT_TYPE_LPC_PIC          23
> > -
> > -/* Values for Version field above */
> > -
> > -enum acpi_madt_core_pic_version {
> > -       ACPI_MADT_CORE_PIC_VERSION_NONE = 0,
> > -       ACPI_MADT_CORE_PIC_VERSION_V1 = 1,
> > -       ACPI_MADT_CORE_PIC_VERSION_RESERVED = 2 /* 2 and greater are reserved */
> > -};
> > -
> > -enum acpi_madt_lio_pic_version {
> > -       ACPI_MADT_LIO_PIC_VERSION_NONE = 0,
> > -       ACPI_MADT_LIO_PIC_VERSION_V1 = 1,
> > -       ACPI_MADT_LIO_PIC_VERSION_RESERVED = 2  /* 2 and greater are reserved */
> > -};
> > -
> > -enum acpi_madt_eio_pic_version {
> > -       ACPI_MADT_EIO_PIC_VERSION_NONE = 0,
> > -       ACPI_MADT_EIO_PIC_VERSION_V1 = 1,
> > -       ACPI_MADT_EIO_PIC_VERSION_RESERVED = 2  /* 2 and greater are reserved */
> > -};
> > -
> > -enum acpi_madt_ht_pic_version {
> > -       ACPI_MADT_HT_PIC_VERSION_NONE = 0,
> > -       ACPI_MADT_HT_PIC_VERSION_V1 = 1,
> > -       ACPI_MADT_HT_PIC_VERSION_RESERVED = 2   /* 2 and greater are reserved */
> > -};
> > -
> > -enum acpi_madt_bio_pic_version {
> > -       ACPI_MADT_BIO_PIC_VERSION_NONE = 0,
> > -       ACPI_MADT_BIO_PIC_VERSION_V1 = 1,
> > -       ACPI_MADT_BIO_PIC_VERSION_RESERVED = 2  /* 2 and greater are reserved */
> > -};
> > -
> > -enum acpi_madt_msi_pic_version {
> > -       ACPI_MADT_MSI_PIC_VERSION_NONE = 0,
> > -       ACPI_MADT_MSI_PIC_VERSION_V1 = 1,
> > -       ACPI_MADT_MSI_PIC_VERSION_RESERVED = 2  /* 2 and greater are reserved */
> > -};
> > -
> > -enum acpi_madt_lpc_pic_version {
> > -       ACPI_MADT_LPC_PIC_VERSION_NONE = 0,
> > -       ACPI_MADT_LPC_PIC_VERSION_V1 = 1,
> > -       ACPI_MADT_LPC_PIC_VERSION_RESERVED = 2  /* 2 and greater are reserved */
> > -};
> > -
> > -#pragma pack(1)
> > -
> > -/* Core Interrupt Controller */
> > -
> > -struct acpi_madt_core_pic {
> > -       struct acpi_subtable_header header;
> > -       u8 version;
> > -       u32 processor_id;
> > -       u32 core_id;
> > -       u32 flags;
> > -};
> > -
> > -/* Legacy I/O Interrupt Controller */
> > -
> > -struct acpi_madt_lio_pic {
> > -       struct acpi_subtable_header header;
> > -       u8 version;
> > -       u64 address;
> > -       u16 size;
> > -       u8 cascade[2];
> > -       u32 cascade_map[2];
> > -};
> > -
> > -/* Extend I/O Interrupt Controller */
> > -
> > -struct acpi_madt_eio_pic {
> > -       struct acpi_subtable_header header;
> > -       u8 version;
> > -       u8 cascade;
> > -       u8 node;
> > -       u64 node_map;
> > -};
> > -
> > -/* HT Interrupt Controller */
> > -
> > -struct acpi_madt_ht_pic {
> > -       struct acpi_subtable_header header;
> > -       u8 version;
> > -       u64 address;
> > -       u16 size;
> > -       u8 cascade[8];
> > -};
> > -
> > -/* Bridge I/O Interrupt Controller */
> > -
> > -struct acpi_madt_bio_pic {
> > -       struct acpi_subtable_header header;
> > -       u8 version;
> > -       u64 address;
> > -       u16 size;
> > -       u16 id;
> > -       u16 gsi_base;
> > -};
> > -
> > -/* MSI Interrupt Controller */
> > -
> > -struct acpi_madt_msi_pic {
> > -       struct acpi_subtable_header header;
> > -       u8 version;
> > -       u64 msg_address;
> > -       u32 start;
> > -       u32 count;
> > -};
> > -
> > -/* LPC Interrupt Controller */
> > -
> > -struct acpi_madt_lpc_pic {
> > -       struct acpi_subtable_header header;
> > -       u8 version;
> > -       u64 address;
> > -       u16 size;
> > -       u8 cascade;
> > -};
> > -
> > -#pragma pack()
> > -
> > -#endif
> > -
> >  #endif /* !CONFIG_ACPI */
> >
> >  #define ACPI_TABLE_UPGRADE_MAX_PHYS ARCH_LOW_ADDRESS_LIMIT
> > --
> > 2.31.1
> >
>
