Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4060136D33B
	for <lists+linux-pm@lfdr.de>; Wed, 28 Apr 2021 09:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236805AbhD1Hek (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Apr 2021 03:34:40 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:52890 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236800AbhD1Hek (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Apr 2021 03:34:40 -0400
X-UUID: cca10a5813dd40b4a027922836817482-20210428
X-UUID: cca10a5813dd40b4a027922836817482-20210428
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1257777433; Wed, 28 Apr 2021 14:54:45 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 28 Apr 2021 14:54:43 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 28 Apr 2021 14:54:43 +0800
From:   Roger Lu <roger.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, Roger Lu <roger.lu@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v16 4/7] soc: mediatek: SVS: add debug commands
Date:   Wed, 28 Apr 2021 14:54:37 +0800
Message-ID: <20210428065440.3704-5-roger.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210428065440.3704-1-roger.lu@mediatek.com>
References: <20210428065440.3704-1-roger.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The purpose of SVS is to help find the suitable voltages
for DVFS. Therefore, if SVS bank voltages are concerned
to be wrong, we can adjust SVS bank voltages by this patch.

Signed-off-by: Roger Lu <roger.lu@mediatek.com>
---
 drivers/soc/mediatek/mtk-svs.c | 328 +++++++++++++++++++++++++++++++++
 1 file changed, 328 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index 2d2153c92373..8794a2d87baa 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -6,6 +6,7 @@
 #include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -24,6 +25,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
+#include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/thermal.h>
@@ -62,6 +64,39 @@
 #define SVSB_INTSTS_COMPLETE		0x1
 #define SVSB_INTSTS_CLEAN		0x00ffffff
 
+#define debug_fops_ro(name)						\
+	static int svs_##name##_debug_open(struct inode *inode,		\
+					   struct file *filp)		\
+	{								\
+		return single_open(filp, svs_##name##_debug_show,	\
+				   inode->i_private);			\
+	}								\
+	static const struct file_operations svs_##name##_debug_fops = {	\
+		.owner = THIS_MODULE,					\
+		.open = svs_##name##_debug_open,			\
+		.read = seq_read,					\
+		.llseek = seq_lseek,					\
+		.release = single_release,				\
+	}
+
+#define debug_fops_rw(name)						\
+	static int svs_##name##_debug_open(struct inode *inode,		\
+					   struct file *filp)		\
+	{								\
+		return single_open(filp, svs_##name##_debug_show,	\
+				   inode->i_private);			\
+	}								\
+	static const struct file_operations svs_##name##_debug_fops = {	\
+		.owner = THIS_MODULE,					\
+		.open = svs_##name##_debug_open,			\
+		.read = seq_read,					\
+		.write = svs_##name##_debug_write,			\
+		.llseek = seq_lseek,					\
+		.release = single_release,				\
+	}
+
+#define svs_dentry(name)	{__stringify(name), &svs_##name##_debug_fops}
+
 static DEFINE_SPINLOCK(mtk_svs_lock);
 
 /*
@@ -83,6 +118,7 @@ enum svsb_phase {
 	SVSB_PHASE_INIT01,
 	SVSB_PHASE_INIT02,
 	SVSB_PHASE_MON,
+	SVSB_PHASE_NUM,
 };
 
 enum svs_reg_index {
@@ -140,6 +176,7 @@ enum svs_reg_index {
 	SPARE2,
 	SPARE3,
 	THSLPEVEB,
+	SVS_REG_NUM,
 };
 
 static const u32 svs_regs_v2[] = {
@@ -284,6 +321,7 @@ struct svs_platform {
  * @opp_volts: signed-off voltages from default opp table
  * @freqs_pct: percent of "opp_freqs / freq_base" for bank init
  * @volts: bank voltages
+ * @reg_data: bank register data of each phase
  * @freq_base: reference frequency for bank init
  * @vboot: voltage request for bank init01 stage only
  * @volt_step: bank voltage step
@@ -302,6 +340,7 @@ struct svs_platform {
  * @opp_count: bank opp count
  * @int_st: bank interrupt identification
  * @sw_id: bank software identification
+ * @hw_id: bank hardware identification
  * @ctl0: bank thermal sensor selection
  * @cpu_id: cpu core id for SVS CPU only
  *
@@ -330,6 +369,7 @@ struct svs_bank {
 	u32 opp_volts[16];
 	u32 freqs_pct[16];
 	u32 volts[16];
+	u32 reg_data[SVSB_PHASE_NUM][SVS_REG_NUM];
 	u32 freq_base;
 	u32 vboot;
 	u32 volt_step;
@@ -367,6 +407,7 @@ struct svs_bank {
 	u32 opp_count;
 	u32 int_st;
 	u32 sw_id;
+	u32 hw_id;
 	u32 ctl0;
 	u32 cpu_id;
 };
@@ -648,11 +689,15 @@ static void svs_set_bank_phase(struct svs_platform *svsp,
 static inline void svs_init01_isr_handler(struct svs_platform *svsp)
 {
 	struct svs_bank *svsb = svsp->pbank;
+	enum svs_reg_index rg_i;
 
 	dev_info(svsb->dev, "%s: VDN74~30:0x%08x~0x%08x, DC:0x%08x\n",
 		 __func__, svs_readl(svsp, VDESIGN74),
 		 svs_readl(svsp, VDESIGN30), svs_readl(svsp, DCVALUES));
 
+	for (rg_i = DESCHAR; rg_i < SVS_REG_NUM; rg_i++)
+		svsb->reg_data[SVSB_PHASE_INIT01][rg_i] = svs_readl(svsp, rg_i);
+
 	svsb->phase = SVSB_PHASE_INIT01;
 	svsb->dc_voffset_in = ~(svs_readl(svsp, DCVALUES) & GENMASK(15, 0)) + 1;
 	if (svsb->volt_flags & SVSB_INIT01_VOLT_IGNORE ||
@@ -672,11 +717,15 @@ static inline void svs_init01_isr_handler(struct svs_platform *svsp)
 static inline void svs_init02_isr_handler(struct svs_platform *svsp)
 {
 	struct svs_bank *svsb = svsp->pbank;
+	enum svs_reg_index rg_i;
 
 	dev_info(svsb->dev, "%s: VOP74~30:0x%08x~0x%08x, DC:0x%08x\n",
 		 __func__, svs_readl(svsp, VOP74), svs_readl(svsp, VOP30),
 		 svs_readl(svsp, DCVALUES));
 
+	for (rg_i = DESCHAR; rg_i < SVS_REG_NUM; rg_i++)
+		svsb->reg_data[SVSB_PHASE_INIT02][rg_i] = svs_readl(svsp, rg_i);
+
 	svsb->phase = SVSB_PHASE_INIT02;
 	svsb->get_vops(svsp);
 
@@ -687,6 +736,10 @@ static inline void svs_init02_isr_handler(struct svs_platform *svsp)
 static inline void svs_mon_mode_isr_handler(struct svs_platform *svsp)
 {
 	struct svs_bank *svsb = svsp->pbank;
+	enum svs_reg_index rg_i;
+
+	for (rg_i = DESCHAR; rg_i < SVS_REG_NUM; rg_i++)
+		svsb->reg_data[SVSB_PHASE_MON][rg_i] = svs_readl(svsp, rg_i);
 
 	svsb->phase = SVSB_PHASE_MON;
 	svsb->temp = svs_readl(svsp, TEMP) & GENMASK(7, 0);
@@ -698,6 +751,7 @@ static inline void svs_mon_mode_isr_handler(struct svs_platform *svsp)
 static inline void svs_error_isr_handler(struct svs_platform *svsp)
 {
 	struct svs_bank *svsb = svsp->pbank;
+	enum svs_reg_index rg_i;
 
 	dev_err(svsb->dev, "%s: CORESEL = 0x%08x\n",
 		__func__, svs_readl(svsp, CORESEL));
@@ -707,6 +761,9 @@ static inline void svs_error_isr_handler(struct svs_platform *svsp)
 		svs_readl(svsp, SMSTATE0), svs_readl(svsp, SMSTATE1));
 	dev_err(svsb->dev, "TEMP = 0x%08x\n", svs_readl(svsp, TEMP));
 
+	for (rg_i = DESCHAR; rg_i < SVS_REG_NUM; rg_i++)
+		svsb->reg_data[SVSB_PHASE_ERROR][rg_i] = svs_readl(svsp, rg_i);
+
 	svsb->mode_support = SVSB_MODE_ALL_DISABLE;
 	svsb->phase = SVSB_PHASE_ERROR;
 
@@ -1416,11 +1473,273 @@ static int svs_resume(struct device *dev)
 	return 0;
 }
 
+/*
+ * svs_dump_debug_show - dump svs/thermal efuse and svs banks' registers
+ */
+static int svs_dump_debug_show(struct seq_file *m, void *p)
+{
+	struct svs_platform *svsp = (struct svs_platform *)m->private;
+	struct svs_bank *svsb;
+	unsigned long svs_reg_addr;
+	u32 idx, i, j;
+
+	for (i = 0; i < svsp->efuse_num; i++)
+		if (svsp->efuse && svsp->efuse[i])
+			seq_printf(m, "M_HW_RES%d = 0x%08x\n",
+				   i, svsp->efuse[i]);
+
+	for (i = 0; i < svsp->tefuse_num; i++)
+		if (svsp->tefuse)
+			seq_printf(m, "THERMAL_EFUSE%d = 0x%08x\n",
+				   i, svsp->tefuse[i]);
+
+	for (idx = 0; idx < svsp->bank_num; idx++) {
+		svsb = &svsp->banks[idx];
+
+		for (i = SVSB_PHASE_INIT01; i <= SVSB_PHASE_MON; i++) {
+			seq_printf(m, "Bank_number = %u\n", svsb->hw_id);
+
+			if (i == SVSB_PHASE_INIT01 || i == SVSB_PHASE_INIT02)
+				seq_printf(m, "mode = init%d\n", i);
+			else if (i == SVSB_PHASE_MON)
+				seq_puts(m, "mode = mon\n");
+			else
+				seq_puts(m, "mode = error\n");
+
+			for (j = DESCHAR; j < SVS_REG_NUM; j++) {
+				svs_reg_addr = (unsigned long)(svsp->base +
+							       svsp->regs[j]);
+				seq_printf(m, "0x%08lx = 0x%08x\n",
+					   svs_reg_addr, svsb->reg_data[i][j]);
+			}
+		}
+	}
+
+	return 0;
+}
+
+debug_fops_ro(dump);
+
+/*
+ * svs_enable_debug_show - show svs bank current enable phase
+ */
+static int svs_enable_debug_show(struct seq_file *m, void *v)
+{
+	struct svs_bank *svsb = (struct svs_bank *)m->private;
+
+	if (svsb->phase == SVSB_PHASE_INIT01)
+		seq_puts(m, "init1\n");
+	else if (svsb->phase == SVSB_PHASE_INIT02)
+		seq_puts(m, "init2\n");
+	else if (svsb->phase == SVSB_PHASE_MON)
+		seq_puts(m, "mon mode\n");
+	else if (svsb->phase == SVSB_PHASE_ERROR)
+		seq_puts(m, "disabled\n");
+	else
+		seq_puts(m, "unknown\n");
+
+	return 0;
+}
+
+/*
+ * svs_enable_debug_write - we only support svs bank disable control
+ */
+static ssize_t svs_enable_debug_write(struct file *filp,
+				      const char __user *buffer,
+				      size_t count, loff_t *pos)
+{
+	struct svs_bank *svsb = file_inode(filp)->i_private;
+	struct svs_platform *svsp = dev_get_drvdata(svsb->dev);
+	unsigned long flags;
+	int enabled, ret;
+	char *buf = NULL;
+
+	if (count >= PAGE_SIZE)
+		return -EINVAL;
+
+	buf = (char *)memdup_user_nul(buffer, count);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	ret = kstrtoint(buf, 10, &enabled);
+	if (ret)
+		return ret;
+
+	if (!enabled) {
+		spin_lock_irqsave(&mtk_svs_lock, flags);
+		svsp->pbank = svsb;
+		svsb->mode_support = SVSB_MODE_ALL_DISABLE;
+		svs_switch_bank(svsp);
+		svs_writel(svsp, SVSB_EN_OFF, SVSEN);
+		svs_writel(svsp, SVSB_INTSTS_CLEAN, INTSTS);
+		spin_unlock_irqrestore(&mtk_svs_lock, flags);
+
+		svsb->phase = SVSB_PHASE_ERROR;
+		svs_adjust_pm_opp_volts(svsb, true);
+	}
+
+	kfree(buf);
+
+	return count;
+}
+
+debug_fops_rw(enable);
+
+/*
+ * svs_status_debug_show - show svs bank's tzone_temp/voltages/freqs_pct
+ * and its corresponding opp-table's opp_freqs/opp_volts
+ */
+static int svs_status_debug_show(struct seq_file *m, void *v)
+{
+	struct svs_bank *svsb = (struct svs_bank *)m->private;
+	struct dev_pm_opp *opp;
+	int tzone_temp = 0, ret;
+	u32 i;
+
+	ret = svs_get_bank_zone_temperature(svsb->tzone_name, &tzone_temp);
+	if (ret)
+		seq_printf(m, "%s: no \"%s\" zone?\n", svsb->name,
+			   svsb->tzone_name);
+	else
+		seq_printf(m, "%s: temperature = %d\n", svsb->name, tzone_temp);
+
+	for (i = 0; i < svsb->opp_count; i++) {
+		opp = dev_pm_opp_find_freq_exact(svsb->opp_dev,
+						 svsb->opp_freqs[i], true);
+		if (IS_ERR(opp)) {
+			seq_printf(m, "%s: cannot find freq = %u (%ld)\n",
+				   svsb->name, svsb->opp_freqs[i],
+				   PTR_ERR(opp));
+			return PTR_ERR(opp);
+		}
+
+		seq_printf(m, "opp_freqs[%02u]: %u, opp_volts[%02u]: %lu, ",
+			   i, svsb->opp_freqs[i], i,
+			   dev_pm_opp_get_voltage(opp));
+		seq_printf(m, "svsb_volts[%02u]: 0x%x, freqs_pct[%02u]: %u\n",
+			   i, svsb->volts[i], i, svsb->freqs_pct[i]);
+		dev_pm_opp_put(opp);
+	}
+
+	return 0;
+}
+
+debug_fops_ro(status);
+
+/*
+ * svs_volt_offset_debug_show - show svs bank's voltage offset
+ */
+static int svs_volt_offset_debug_show(struct seq_file *m, void *v)
+{
+	struct svs_bank *svsb = (struct svs_bank *)m->private;
+
+	seq_printf(m, "%d\n", svsb->volt_offset);
+
+	return 0;
+}
+
+/*
+ * svs_volt_offset_debug_write - write svs bank's voltage offset
+ */
+static ssize_t svs_volt_offset_debug_write(struct file *filp,
+					   const char __user *buffer,
+					   size_t count, loff_t *pos)
+{
+	struct svs_bank *svsb = file_inode(filp)->i_private;
+	char *buf = NULL;
+	s32 volt_offset;
+
+	if (count >= PAGE_SIZE)
+		return -EINVAL;
+
+	buf = (char *)memdup_user_nul(buffer, count);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	if (!kstrtoint(buf, 10, &volt_offset)) {
+		svsb->volt_offset = volt_offset;
+		svs_adjust_pm_opp_volts(svsb, true);
+	}
+
+	kfree(buf);
+
+	return count;
+}
+
+debug_fops_rw(volt_offset);
+
+static int svs_create_svs_debug_cmds(struct svs_platform *svsp)
+{
+	struct svs_bank *svsb;
+	struct dentry *svs_dir, *svsb_dir, *file_entry;
+	const char *d = "/sys/kernel/debug/svs";
+	u32 i, idx;
+
+	struct svs_dentry {
+		const char *name;
+		const struct file_operations *fops;
+	};
+
+	struct svs_dentry svs_entries[] = {
+		svs_dentry(dump),
+	};
+
+	struct svs_dentry svsb_entries[] = {
+		svs_dentry(enable),
+		svs_dentry(status),
+		svs_dentry(volt_offset),
+	};
+
+	svs_dir = debugfs_create_dir("svs", NULL);
+	if (IS_ERR(svs_dir)) {
+		dev_err(svsp->dev, "cannot create %s: %ld\n",
+			d, PTR_ERR(svs_dir));
+		return 0;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(svs_entries); i++) {
+		file_entry = debugfs_create_file(svs_entries[i].name, 0664,
+						 svs_dir, svsp,
+						 svs_entries[i].fops);
+		if (IS_ERR(file_entry)) {
+			dev_err(svsp->dev, "cannot create %s/%s: %ld\n",
+				d, svs_entries[i].name, PTR_ERR(file_entry));
+			return PTR_ERR(file_entry);
+		}
+	}
+
+	for (idx = 0; idx < svsp->bank_num; idx++) {
+		svsb = &svsp->banks[idx];
+
+		svsb_dir = debugfs_create_dir(svsb->name, svs_dir);
+		if (IS_ERR(svsb_dir)) {
+			dev_err(svsp->dev, "cannot create %s/%s: %ld\n",
+				d, svsb->name, PTR_ERR(svsb_dir));
+			return PTR_ERR(svsb_dir);
+		}
+
+		for (i = 0; i < ARRAY_SIZE(svsb_entries); i++) {
+			file_entry = debugfs_create_file(svsb_entries[i].name,
+							 0664, svsb_dir, svsb,
+							 svsb_entries[i].fops);
+			if (IS_ERR(file_entry)) {
+				dev_err(svsp->dev, "no %s/%s/%s?: %ld\n",
+					d, svsb->name, svsb_entries[i].name,
+					PTR_ERR(file_entry));
+				return PTR_ERR(file_entry);
+			}
+		}
+	}
+
+	return 0;
+}
+
 static struct svs_bank svs_mt8183_banks[] = {
 	{
 		.sw_id			= SVSB_CPU_LITTLE,
 		.set_freqs_pct		= svs_set_freqs_pct_v2,
 		.get_vops		= svs_get_vops_v2,
+		.hw_id			= 0,
 		.cpu_id			= 0,
 		.tzone_name		= "tzts4",
 		.buck_name		= "proc",
@@ -1458,6 +1777,7 @@ static struct svs_bank svs_mt8183_banks[] = {
 		.sw_id			= SVSB_CPU_BIG,
 		.set_freqs_pct		= svs_set_freqs_pct_v2,
 		.get_vops		= svs_get_vops_v2,
+		.hw_id			= 1,
 		.cpu_id			= 4,
 		.tzone_name		= "tzts5",
 		.buck_name		= "proc",
@@ -1495,6 +1815,7 @@ static struct svs_bank svs_mt8183_banks[] = {
 		.sw_id			= SVSB_CCI,
 		.set_freqs_pct		= svs_set_freqs_pct_v2,
 		.get_vops		= svs_get_vops_v2,
+		.hw_id			= 2,
 		.tzone_name		= "tzts4",
 		.buck_name		= "proc",
 		.pd_req			= false,
@@ -1531,6 +1852,7 @@ static struct svs_bank svs_mt8183_banks[] = {
 		.sw_id			= SVSB_GPU,
 		.set_freqs_pct		= svs_set_freqs_pct_v2,
 		.get_vops		= svs_get_vops_v2,
+		.hw_id			= 3,
 		.tzone_name		= "tzts2",
 		.buck_name		= "mali",
 		.pd_req			= true,
@@ -1694,6 +2016,12 @@ static int svs_probe(struct platform_device *pdev)
 		goto svs_probe_iounmap;
 	}
 
+	ret = svs_create_svs_debug_cmds(svsp);
+	if (ret) {
+		dev_err(svsp->dev, "svs create debug cmds fail: %d\n", ret);
+		goto svs_probe_iounmap;
+	}
+
 	return 0;
 
 svs_probe_iounmap:
-- 
2.18.0

