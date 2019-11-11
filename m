Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B328F7329
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 12:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfKKLgj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 06:36:39 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51407 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfKKLgj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2019 06:36:39 -0500
Received: by mail-wm1-f68.google.com with SMTP id q70so12946991wme.1
        for <linux-pm@vger.kernel.org>; Mon, 11 Nov 2019 03:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y0dulQXEpY4JTRjYNrgxL7H4Oc+cEpHXSad2UPEfcck=;
        b=bxHpIPb5phD5/xnyo/ChAZAMq+BdxeaAyc6U/zw8Sl83T8N5fzUKeN95dyN4AbByx4
         QNGTpquHrJxqPQO2cqiIHQ2xGmU5avPs8s2QfezmZ++a5NpQMU35u+5KyGmNEzAruCOs
         H2FSzP5CLlAOpkaoFUQyAkVvhvJ76TBZvk65gF/5pA3xvKn5rUe59p6lzZZ+Qzq18wql
         eSqtJfMIohZsY/OldoyBBzP9r4hsvs2yeIzz/2iytuuiUh1dPmeDMmiDSN3UHRakIwsV
         nFzL/cLdwv5l1flpZ5DcbGZtbEYmTbPj2AyiFTBM4xfjtF6Bk+H5L/uClwVVlRggjvb4
         1Z7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y0dulQXEpY4JTRjYNrgxL7H4Oc+cEpHXSad2UPEfcck=;
        b=ETAp+OYAHOXYLEIRYJ4CJ2DUTMgc370VP+zeCzkD4BeRVHoOgt622Qidx6mtUiBs7g
         c3k1wgDkoSupUmwo38+Tze6HCNsN4bS38xCa9zMZlXZb9kHcFW1oeKfYHM8hXSPog1r2
         V1NW4+cFm4FSqg60DJJQEKD8kKWwoM1JFxamKWDLt55kHHbAdxRFzL1YYxlMwGgiK6H1
         l9jmRltY58sE503bNyH25wUWoVxGlZKuPoZ3fnweHxpZ/xySf0Jryj9hI5taXJ4pODVu
         4D2v7bDb01snea5+tQru+idBq/AzZ6ktP1tyb6Dxj6IE+gGwqJEItIQd1ogxb+tIhsVk
         25pQ==
X-Gm-Message-State: APjAAAVSJTVyLZ9bxA20OFBP7ILUzlJ6/Tr2mUiOkANPWE8Srf597TmW
        aJ2YpiLMzenH37yuFi4XlEiUyd/3M0Y86vSsjMHEH9PxHAg=
X-Google-Smtp-Source: APXvYqzukrpx06aOA3LqbJs8I7XR+FwIaaQYKy+Gm7Tz2e7dz1DLqlFOVFvJ8DYuDBp3HPhpvJ+qTAC1ypDwtFmt5ow=
X-Received: by 2002:a1c:4c10:: with SMTP id z16mr18470654wmf.24.1573472196560;
 Mon, 11 Nov 2019 03:36:36 -0800 (PST)
MIME-Version: 1.0
References: <20191107212408.11857-1-hch@lst.de>
In-Reply-To: <20191107212408.11857-1-hch@lst.de>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 11 Nov 2019 17:06:24 +0530
Message-ID: <CAAhSdy3SGAkOFMhx320KJdPDh6c=qcKqCZ=qrXNKBGtejpZwSA@mail.gmail.com>
Subject: Re: QEMU RISC-V virt machine poweroff driver
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        devicetree@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 8, 2019 at 2:54 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi all,
>
> this patch add a driver for the test device in the Qemu RISC-V
> virt machine which allows properly shutting down the VM.
> It also is added to the riscv defconfig given that qemu-virt
> is the most popular riscv platform.

We really don't need this driver. Instead, we can simply re-use
following drivers:
mfd/syscon
power/reset/syscon-reboot
power/reset/syscon-poweroff

Just enable following to your defconfig:
CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_SYSCON=y
CONFIG_POWER_RESET_SYSCON_POWEROFF=y
CONFIG_SYSCON_REBOOT_MODE=y


Once above drivers are enabled in your defconfig, make sure
test device DT nodes are described in the following way for virt machine:

testdev: test@100000 {
    compatible = "syscon";
    reg = <0x100000 0x1000>;
};

reboot {
    compatible = "syscon-reboot";
    regmap = <&testdev>;
    offset = <0x0>;
    value = <0x7777>;
};

poweroff {
    compatible = "syscon-poweroff";
    regmap = <&testdev>;
    offset = <0x0>;
    value = <0x5555>;
};


Here's the QEMU changes I used for above DT nodes:

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d7c5d630eb..7f8206c726 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -186,7 +186,7 @@ static void create_fdt(RISCVVirtState *s, const
struct MemmapEntry *memmap,
     int cpu;
     uint32_t *cells;
     char *nodename;
-    uint32_t plic_phandle, phandle = 1;
+    uint32_t plic_phandle, test_phandle, phandle = 1;
     int i;
     hwaddr flashsize = virt_memmap[VIRT_FLASH].size / 2;
     hwaddr flashbase = virt_memmap[VIRT_FLASH].base;
@@ -357,13 +357,32 @@ static void create_fdt(RISCVVirtState *s, const
struct MemmapEntry *memmap,
     create_pcie_irq_map(fdt, nodename, plic_phandle);
     g_free(nodename);

+    test_phandle = phandle++;
     nodename = g_strdup_printf("/test@%lx",
         (long)memmap[VIRT_TEST].base);
     qemu_fdt_add_subnode(fdt, nodename);
-    qemu_fdt_setprop_string(fdt, nodename, "compatible", "sifive,test0");
+    qemu_fdt_setprop_string(fdt, nodename, "compatible", "syscon");
     qemu_fdt_setprop_cells(fdt, nodename, "reg",
         0x0, memmap[VIRT_TEST].base,
         0x0, memmap[VIRT_TEST].size);
+    qemu_fdt_setprop_cell(fdt, nodename, "phandle", test_phandle);
+    test_phandle = qemu_fdt_get_phandle(fdt, nodename);
+    g_free(nodename);
+
+    nodename = g_strdup_printf("/reboot");
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible", "syscon-reboot");
+    qemu_fdt_setprop_cell(fdt, nodename, "regmap", test_phandle);
+    qemu_fdt_setprop_cell(fdt, nodename, "offset", 0x0);
+    qemu_fdt_setprop_cell(fdt, nodename, "value", FINISHER_RESET);
+    g_free(nodename);
+
+    nodename = g_strdup_printf("/poweroff");
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible", "syscon-poweroff");
+    qemu_fdt_setprop_cell(fdt, nodename, "regmap", test_phandle);
+    qemu_fdt_setprop_cell(fdt, nodename, "offset", 0x0);
+    qemu_fdt_setprop_cell(fdt, nodename, "value", FINISHER_PASS);
     g_free(nodename);

     nodename = g_strdup_printf("/uart@%lx",


Regards,
Anup


>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
