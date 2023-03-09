Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071286B2811
	for <lists+linux-pm@lfdr.de>; Thu,  9 Mar 2023 16:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjCIPBm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Mar 2023 10:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbjCIPBM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Mar 2023 10:01:12 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFD97DA9
        for <linux-pm@vger.kernel.org>; Thu,  9 Mar 2023 06:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1678373876; x=1709909876;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oR/xwKtmrr5IPsApLnLyAT5487DcN9NNES2UJbh26bM=;
  b=olTSk18B89BhUPXBBt4OFO32eGefqsm1tCqcl0tb9BuMMNWUdXR/cw5g
   mGviApTXmXga0wPmHXZwvspB8uVkXVQgtsQOsU8RDqIf7YTt2PgqUydab
   YqtYyCXH1WAide+NoZHZ/GxqrTY+OCdFQ2zgdyGm0q8CFT880SUX20F2U
   KD8JkShMSc8CmmwDaAMJ8s1T2MlmYISq89w5yzhGtevrmkTEXn+BZQOEj
   lms/5qLDf8+AeuV0w5K8wGxzTHQ2Pb5x2QL4uSBA84IRN02UGHeGv8VrP
   jGTmjZDikXF5yGjM6xDXmBGXPfSrTL+xxJNbaQ/IqhJg5FJ+LQFLGwyW3
   w==;
X-IronPort-AV: E=Sophos;i="5.98,246,1673910000"; 
   d="scan'208";a="29583580"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 09 Mar 2023 15:57:54 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 09 Mar 2023 15:57:53 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 09 Mar 2023 15:57:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1678373874; x=1709909874;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oR/xwKtmrr5IPsApLnLyAT5487DcN9NNES2UJbh26bM=;
  b=K4+HtOwW6CBhLaid9JCadBxJj+lye4pvIirLiygoYBNyVWE3aeKYgBQL
   YIsmDsKOu1G49XJs1tCsXgrtaKL2ir7ODFKx1riYwg+RP0+RxWmKhWBx7
   o+LXQZs1D3IA9qPBuwmKAj9X4Gdmp5IHmXEbNejR/kXcmd0INnIaHsTSA
   X/6BSmCz37m5cs6KksoQDO6/SZbhtReEZxT44XzzMFaiXRsVmJCf20N/H
   lL5MIQBXOsBNhplWwQ8lST0QmgJQOz0tjQPXalo+aQJP5o+iD1wklkW2n
   kFQEGaIPcg3xSpq5tO+ywEFAC3PamBp7fWBByqfL6Q/Na70OsCR6ua5ya
   A==;
X-IronPort-AV: E=Sophos;i="5.98,246,1673910000"; 
   d="scan'208";a="29583579"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 09 Mar 2023 15:57:54 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 7ED5A280056;
        Thu,  9 Mar 2023 15:57:53 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: NOC (interconnect) lockup on i.MX8MP during resume
Date:   Thu, 09 Mar 2023 15:57:50 +0100
Message-ID: <2176690.usQuhbGJ8B@steina-w>
Organization: TQ-Systems GmbH
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

while debugging another issue regarding suspend/resume I noticed that the i=
mx
interconnect driver locks up the system when writing into registers. This
happens during resume of the 'g2' power domain. imx8m_blk_ctrl_power_on()
will eventually call down to imx_icc_node_set(). Using the debug diff furthe
down I get this output:

[   71.493062] imx_icc_node_set: node: VPU G2
[   71.497163] imx_icc_node_set: peak_bw: 1
[   71.501091] imx_icc_node_set: prio: 0x80000303
<freeze here>

Unfortunately there is absolutely no documentation regarding NOC in the
reference manual, so no idea whats happening here.
This is on next-20230309 using imx8mp-tqma8mpql-mba8mpxl.dts with USB
disabled (prevents suspend) and Ethernet-PHY-IRQ disabled (the issue I'm
tackling).
Is there some idea what do in order to support resume on i.MX8MP?

Best regards,
Alexander

=2D--8<---
diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/imx.c
index 979ed610f704..93ec79cc7c06 100644
=2D-- a/drivers/interconnect/imx/imx.c
+++ b/drivers/interconnect/imx/imx.c
@@ -44,13 +44,18 @@ static int imx_icc_node_set(struct icc_node *node)
        u32 prio;
        u64 freq;
=20
+       pr_info("%s: node: %s\n", __func__, node->name);
+       pr_info("%s: peak_bw: %u\n", __func__, node->peak_bw);
        if (node_data->setting && node->peak_bw) {
                base =3D node_data->setting->reg + node_data->imx_provider-=
>noc_base;
                if (node_data->setting->mode =3D=3D IMX_NOC_MODE_FIXED) {
                        prio =3D node_data->setting->prio_level;
                        prio =3D PRIORITY_COMP_MARK | (prio << 8) | prio;
+                       pr_info("%s: prio: %#x\n", __func__, prio);
                        writel(prio, base + IMX_NOC_PRIO_REG);
+                       pr_info("%s: mode: %#x\n", __func__, node_data->set=
ting->mode);
                        writel(node_data->setting->mode, base + IMX_NOC_MOD=
E_REG);
+                       pr_info("%s: ext_control: #%x\n", __func__, node_da=
ta->setting->ext_control);
                        writel(node_data->setting->ext_control, base + IMX_=
NOC_EXT_CTL_REG);
                        dev_dbg(dev, "%s: mode: 0x%x, prio: 0x%x, ext_contr=
ol: 0x%x\n",
                                node_data->desc->name, node_data->setting->=
mode, prio,
=2D--8<---

=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


