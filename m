Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE0A618799
	for <lists+linux-pm@lfdr.de>; Thu,  3 Nov 2022 19:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiKCSfB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Nov 2022 14:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiKCSe7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Nov 2022 14:34:59 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4149CD6
        for <linux-pm@vger.kernel.org>; Thu,  3 Nov 2022 11:34:57 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id k2so1723989qkk.7
        for <linux-pm@vger.kernel.org>; Thu, 03 Nov 2022 11:34:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fme8TpX7/aX6I0wUHkOV0EjnvReL60XkORWeEGO34oM=;
        b=2kibW0+vryXErg+mDHwnqajIZjz0pPoZxsrKzyybbiUpFIo+lg2wP9Ykv6mDhbe6G9
         vxNRCLfXA9mVhxz0pw7fAZBlSdS0tZ1UpOy8dt5MJDSaoBK6qhh7l7lfeoy+Mi3WUUVJ
         uLjs5WPurIvVrnKKBGWDD/pUkPvBsvpqMyCL7Ub9Ur1Mr0J1Dg35G6poKcozlQEMO5US
         qXDkxnpxNAuAqgBs75byeh1+7RDK+FVlLAX9zOOnln7C/q+XtQCdmuy6VyyLZ5yK0iel
         1wVb9fQ78Zu6bdsgprW/nvDsLxWkJBpsu4DCDu8aIn5k0CV7FoE4l6kq/3jpu9Pw3Ilw
         0apw==
X-Gm-Message-State: ACrzQf3N5QbbSEJ228iUxcib3JivHKQYeGtunbzNKHN2xo6Oa0zwucBl
        eCjz9/3eAuBz+J8kuXnwv0qLk4pybHtBnkA/yac=
X-Google-Smtp-Source: AMsMyM7VMuMQnOTaWFYlaOGoRYgL/vknb0LyCbtSuxv/81b5hzsSHwf1rDWoR4eB7vHh+BH/EO4b2Rh5EBw4pkTzBdQ=
X-Received: by 2002:a37:65c9:0:b0:6fa:1ef8:fa10 with SMTP id
 z192-20020a3765c9000000b006fa1ef8fa10mr20190691qkb.648.1667500496799; Thu, 03
 Nov 2022 11:34:56 -0700 (PDT)
MIME-Version: 1.0
References: <20221102064838.2615669-1-chenhuacai@loongson.cn>
In-Reply-To: <20221102064838.2615669-1-chenhuacai@loongson.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 3 Nov 2022 19:34:45 +0100
Message-ID: <CAJZ5v0hi3cqjCH-2hGp9xeC4Ch5mA+V9Zb+D_mCqDViNA6Musg@mail.gmail.com>
Subject: Re: [PATCH] ACPI / table: Print CORE_PIC information when MADT is parsed
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 2, 2022 at 7:50 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> When MADT is parsed, print CORE_PIC information as below:
>
> ACPI: CORE PIC (processor_id[0x00] core_id[0x00] enabled)
> ACPI: CORE PIC (processor_id[0x01] core_id[0x01] enabled)
> ...
> ACPI: CORE PIC (processor_id[0xff] core_id[0xff] enabled)
>
> This debug information will be very helpful to bring up early systems to
> see if processor_id and core_id are matched or not as spec defined.
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/acpi/tables.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 47ec11d4c68e..23bff77b09f4 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -210,6 +210,16 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
>                 }
>                 break;
>
> +       case ACPI_MADT_TYPE_CORE_PIC:
> +               {
> +                       struct acpi_madt_core_pic *p =
> +                           (struct acpi_madt_core_pic *)header;
> +                       pr_debug("CORE PIC (processor_id[0x%02x] core_id[0x%02x] %s)\n",
> +                                p->processor_id, p->core_id,
> +                                (p->flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
> +               }
> +               break;
> +
>         default:
>                 pr_warn("Found unsupported MADT entry (type = 0x%x)\n",
>                         header->type);
> --

Applied as 6.2 material.

However, next time please CC ACPI-related patches to linux-acpi rather
than to linux-pm (or you can do both if the patch is PM-related
anyway).

Thanks!
