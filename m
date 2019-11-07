Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC14AF3A7A
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2019 22:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbfKGVYT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Nov 2019 16:24:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54966 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfKGVYS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Nov 2019 16:24:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=khHj9jfq3GGP5n5rrA0/ElXw76XcvwWYApDu5bn3TCw=; b=hdi6H/YYpUh126ASP9pjVy/MkL
        2JCEorkV0i/veQYq4c+37f0lHtmn9Dk6pAIl+GTZmB3f0bLicx9Yw4M14Td2n59v2IgY97yrSuPqB
        xpiPEOoxX3RP8I8zpAiktwy+XA52Ri65mHoLYiy+gaCGGnt0ban157wHHuu8nD5JpFsrRl+kXeTF6
        G+bbDklr4G8wunL9Vd8QscIS+15tTkU4qGv6uaKt/zv91v9YvujQCyPDrwWwFXZfery1phD7nH/DO
        +blylE4t+0Fw8rYdoYLk8rlrF8rTItm9JPGf+QsjoWamR3mjsxTZbqOYxnzX+2ujvYo6FHRy2gsoo
        4V1jkKzg==;
Received: from [2001:4bb8:184:e48:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSpGJ-0007Fe-VH; Thu, 07 Nov 2019 21:24:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH 1/2] dt-bindings: power: reset: document the QEMU RISC-V virt machine poweroff device
Date:   Thu,  7 Nov 2019 22:24:07 +0100
Message-Id: <20191107212408.11857-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191107212408.11857-1-hch@lst.de>
References: <20191107212408.11857-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the binding for the trivial Qemu RISC-V poweroff mechanism, which is
just a single MMIO register exposed through the DT.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 .../power/reset/qemu-riscv-virt-poweroff.txt     | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/qemu-riscv-virt-poweroff.txt

diff --git a/Documentation/devicetree/bindings/power/reset/qemu-riscv-virt-poweroff.txt b/Documentation/devicetree/bindings/power/reset/qemu-riscv-virt-poweroff.txt
new file mode 100644
index 000000000000..80ff6fd4e3b7
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/qemu-riscv-virt-poweroff.txt
@@ -0,0 +1,16 @@
+QEMU RISC-V virt machine poweroff device
+
+This is a device in Qemu that can signal successful or error exit
+by writing two magic numbers to a trivial mmio register.
+A Linux poweroff is implemented as successful exit.
+
+Required Properties:
+-compatible: "sifive,test0"
+-reg: Specifies the physical address of the register
+
+Example:
+
+	test@100000 {
+		compatible = "sifive,test0";
+		reg = <0x100000 0x1000>;
+	};
-- 
2.20.1

