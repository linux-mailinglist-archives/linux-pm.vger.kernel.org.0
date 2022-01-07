Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90124487508
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jan 2022 10:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346496AbiAGJwK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jan 2022 04:52:10 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:59000 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237161AbiAGJwH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jan 2022 04:52:07 -0500
X-UUID: 2a098157fe644756863124aef37dd0e1-20220107
X-UUID: 2a098157fe644756863124aef37dd0e1-20220107
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1403671878; Fri, 07 Jan 2022 17:52:03 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 7 Jan 2022 17:52:02 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 7 Jan 2022 17:52:01 +0800
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
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v21 5/8] soc: mediatek: SVS: add debug commands
Date:   Fri, 7 Jan 2022 17:51:57 +0800
Message-ID: <20220107095200.4389-6-roger.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220107095200.4389-1-roger.lu@mediatek.com>
References: <20220107095200.4389-1-roger.lu@mediatek.com>
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
 drivers/soc/mediatek/mtk-svs.c | 321 ++++++++++++++++++++++++++++++++-
 1 file changed, 318 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index 042c6e8e9069..93cdaecadd6d 100644
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
@@ -23,6 +24,7 @@
 #include <linux/pm_qos.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
+#include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/thermal.h>
@@ -68,6 +70,39 @@
 
 static DEFINE_SPINLOCK(svs_lock);
 
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
+#define svs_dentry_data(name)	{__stringify(name), &svs_##name##_debug_fops}
+
 /**
  * enum svsb_phase - svs bank phase enumeration
  * @SVSB_PHASE_ERROR: svs bank encounters unexpected condition
@@ -258,6 +293,8 @@ struct svs_platform {
  * @suspended: suspend flag of this bank
  * @phase: bank current phase
  * @volt_od: bank voltage overdrive
+ * @voffset: bank voltage offset for debug purpose
+ * @reg_data: bank register data in different phase for debug purpose
  * @pm_runtime_enabled_count: bank pm runtime enabled count
  * @mode_support: bank mode support.
  * @freq_base: reference frequency for bank init
@@ -317,6 +354,8 @@ struct svs_bank {
 	bool suspended;
 	enum svsb_phase phase;
 	s32 volt_od;
+	s32 voffset;
+	u32 reg_data[SVSB_PHASE_MAX][SVS_REG_MAX];
 	u32 pm_runtime_enabled_count;
 	u32 mode_support;
 	u32 freq_base;
@@ -444,14 +483,15 @@ static int svs_adjust_pm_opp_volts(struct svs_bank *svsb, bool force_update)
 			/* do nothing */
 			goto unlock_mutex;
 		case SVSB_PHASE_INIT02:
-			svsb_volt = max(svsb->volt[i], svsb->vmin);
+			svsb_volt = max(svsb->volt[i] + svsb->voffset,
+					svsb->vmin);
 			opp_volt = svs_bank_volt_to_opp_volt(svsb_volt,
 							     svsb->volt_step,
 							     svsb->volt_base);
 			break;
 		case SVSB_PHASE_MON:
-			svsb_volt = max(svsb->volt[i] + temp_voffset,
-					svsb->vmin);
+			svsb_volt = max(svsb->volt[i] + temp_voffset +
+					svsb->voffset, svsb->vmin);
 			opp_volt = svs_bank_volt_to_opp_volt(svsb_volt,
 							     svsb->volt_step,
 							     svsb->volt_base);
@@ -480,6 +520,257 @@ static int svs_adjust_pm_opp_volts(struct svs_bank *svsb, bool force_update)
 	return ret;
 }
 
+static int svs_dump_debug_show(struct seq_file *m, void *p)
+{
+	struct svs_platform *svsp = (struct svs_platform *)m->private;
+	struct svs_bank *svsb;
+	unsigned long svs_reg_addr;
+	u32 idx, i, j, bank_id;
+
+	for (i = 0; i < svsp->efuse_max; i++)
+		if (svsp->efuse && svsp->efuse[i])
+			seq_printf(m, "M_HW_RES%d = 0x%08x\n",
+				   i, svsp->efuse[i]);
+
+	for (i = 0; i < svsp->tefuse_max; i++)
+		if (svsp->tefuse)
+			seq_printf(m, "THERMAL_EFUSE%d = 0x%08x\n",
+				   i, svsp->tefuse[i]);
+
+	for (bank_id = 0, idx = 0; idx < svsp->bank_max; idx++, bank_id++) {
+		svsb = &svsp->banks[idx];
+
+		for (i = SVSB_PHASE_INIT01; i <= SVSB_PHASE_MON; i++) {
+			seq_printf(m, "Bank_number = %u\n", bank_id);
+
+			if (i == SVSB_PHASE_INIT01 || i == SVSB_PHASE_INIT02)
+				seq_printf(m, "mode = init%d\n", i);
+			else if (i == SVSB_PHASE_MON)
+				seq_puts(m, "mode = mon\n");
+			else
+				seq_puts(m, "mode = error\n");
+
+			for (j = DESCHAR; j < SVS_REG_MAX; j++) {
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
+static int svs_enable_debug_show(struct seq_file *m, void *v)
+{
+	struct svs_bank *svsb = (struct svs_bank *)m->private;
+
+	switch (svsb->phase) {
+	case SVSB_PHASE_ERROR:
+		seq_puts(m, "disabled\n");
+		break;
+	case SVSB_PHASE_INIT01:
+		seq_puts(m, "init1\n");
+		break;
+	case SVSB_PHASE_INIT02:
+		seq_puts(m, "init2\n");
+		break;
+	case SVSB_PHASE_MON:
+		seq_puts(m, "mon mode\n");
+		break;
+	default:
+		seq_puts(m, "unknown\n");
+		break;
+	}
+
+	return 0;
+}
+
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
+		spin_lock_irqsave(&svs_lock, flags);
+		svsp->pbank = svsb;
+		svsb->mode_support = SVSB_MODE_ALL_DISABLE;
+		svs_switch_bank(svsp);
+		svs_writel_relaxed(svsp, SVSB_EN_OFF, SVSEN);
+		svs_writel_relaxed(svsp, SVSB_INTSTS_CLEAN, INTSTS);
+		spin_unlock_irqrestore(&svs_lock, flags);
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
+static int svs_status_debug_show(struct seq_file *m, void *v)
+{
+	struct svs_bank *svsb = (struct svs_bank *)m->private;
+	struct dev_pm_opp *opp;
+	int tzone_temp = 0, ret;
+	u32 i;
+
+	ret = svs_get_zone_temperature(svsb->tzone_name, &tzone_temp);
+	if (ret)
+		seq_printf(m, "%s: temperature ignore\n", svsb->name);
+	else
+		seq_printf(m, "%s: temperature = %d\n", svsb->name, tzone_temp);
+
+	for (i = 0; i < svsb->opp_count; i++) {
+		opp = dev_pm_opp_find_freq_exact(svsb->opp_dev,
+						 svsb->opp_dfreq[i], true);
+		if (IS_ERR(opp)) {
+			seq_printf(m, "%s: cannot find freq = %u (%ld)\n",
+				   svsb->name, svsb->opp_dfreq[i],
+				   PTR_ERR(opp));
+			return PTR_ERR(opp);
+		}
+
+		seq_printf(m, "opp_freq[%02u]: %u, opp_volt[%02u]: %lu, ",
+			   i, svsb->opp_dfreq[i], i,
+			   dev_pm_opp_get_voltage(opp));
+		seq_printf(m, "svsb_volt[%02u]: 0x%x, freq_pct[%02u]: %u\n",
+			   i, svsb->volt[i], i, svsb->freq_pct[i]);
+		dev_pm_opp_put(opp);
+	}
+
+	return 0;
+}
+
+debug_fops_ro(status);
+
+static int svs_voffset_debug_show(struct seq_file *m, void *v)
+{
+	struct svs_bank *svsb = (struct svs_bank *)m->private;
+
+	seq_printf(m, "%d\n", svsb->voffset);
+
+	return 0;
+}
+
+static ssize_t svs_voffset_debug_write(struct file *filp,
+				       const char __user *buffer,
+				       size_t count, loff_t *pos)
+{
+	struct svs_bank *svsb = file_inode(filp)->i_private;
+	char *buf = NULL;
+	s32 voffset;
+
+	if (count >= PAGE_SIZE)
+		return -EINVAL;
+
+	buf = (char *)memdup_user_nul(buffer, count);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	if (!kstrtoint(buf, 10, &voffset)) {
+		svsb->voffset = voffset;
+		svs_adjust_pm_opp_volts(svsb, true);
+	}
+
+	kfree(buf);
+
+	return count;
+}
+
+debug_fops_rw(voffset);
+
+static int svs_create_debug_cmds(struct svs_platform *svsp)
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
+		svs_dentry_data(dump),
+	};
+
+	struct svs_dentry svsb_entries[] = {
+		svs_dentry_data(enable),
+		svs_dentry_data(status),
+		svs_dentry_data(voffset),
+	};
+
+	svs_dir = debugfs_create_dir("svs", NULL);
+	if (IS_ERR(svs_dir)) {
+		dev_err(svsp->dev, "cannot create %s: %ld\n",
+			d, PTR_ERR(svs_dir));
+		return PTR_ERR(svs_dir);
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
+	for (idx = 0; idx < svsp->bank_max; idx++) {
+		svsb = &svsp->banks[idx];
+
+		if (svsb->mode_support == SVSB_MODE_ALL_DISABLE)
+			continue;
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
 static u32 interpolate(u32 f0, u32 f1, u32 v0, u32 v1, u32 fx)
 {
 	u32 vx;
@@ -605,6 +896,16 @@ static void svs_set_bank_phase(struct svs_platform *svsp,
 	}
 }
 
+static inline void svs_save_bank_register_data(struct svs_platform *svsp,
+					       enum svsb_phase phase)
+{
+	struct svs_bank *svsb = svsp->pbank;
+	enum svs_reg_index rg_i;
+
+	for (rg_i = DESCHAR; rg_i < SVS_REG_MAX; rg_i++)
+		svsb->reg_data[phase][rg_i] = svs_readl_relaxed(svsp, rg_i);
+}
+
 static inline void svs_error_isr_handler(struct svs_platform *svsp)
 {
 	struct svs_bank *svsb = svsp->pbank;
@@ -619,6 +920,8 @@ static inline void svs_error_isr_handler(struct svs_platform *svsp)
 		svs_readl_relaxed(svsp, SMSTATE1));
 	dev_err(svsb->dev, "TEMP = 0x%08x\n", svs_readl_relaxed(svsp, TEMP));
 
+	svs_save_bank_register_data(svsp, SVSB_PHASE_ERROR);
+
 	svsb->mode_support = SVSB_MODE_ALL_DISABLE;
 	svsb->phase = SVSB_PHASE_ERROR;
 
@@ -635,6 +938,8 @@ static inline void svs_init01_isr_handler(struct svs_platform *svsp)
 		 svs_readl_relaxed(svsp, VDESIGN30),
 		 svs_readl_relaxed(svsp, DCVALUES));
 
+	svs_save_bank_register_data(svsp, SVSB_PHASE_INIT01);
+
 	svsb->phase = SVSB_PHASE_INIT01;
 	svsb->dc_voffset_in = ~(svs_readl_relaxed(svsp, DCVALUES) &
 				GENMASK(15, 0)) + 1;
@@ -662,6 +967,8 @@ static inline void svs_init02_isr_handler(struct svs_platform *svsp)
 		 svs_readl_relaxed(svsp, VOP30),
 		 svs_readl_relaxed(svsp, DCVALUES));
 
+	svs_save_bank_register_data(svsp, SVSB_PHASE_INIT02);
+
 	svsb->phase = SVSB_PHASE_INIT02;
 	svsb->get_volts(svsp);
 
@@ -673,6 +980,8 @@ static inline void svs_mon_mode_isr_handler(struct svs_platform *svsp)
 {
 	struct svs_bank *svsb = svsp->pbank;
 
+	svs_save_bank_register_data(svsp, SVSB_PHASE_MON);
+
 	svsb->phase = SVSB_PHASE_MON;
 	svsb->temp = svs_readl_relaxed(svsp, TEMP) & GENMASK(7, 0);
 	svsb->get_volts(svsp);
@@ -1658,6 +1967,12 @@ static int svs_probe(struct platform_device *pdev)
 		goto svs_probe_iounmap;
 	}
 
+	ret = svs_create_debug_cmds(svsp);
+	if (ret) {
+		dev_err(svsp->dev, "svs create debug cmds fail: %d\n", ret);
+		goto svs_probe_iounmap;
+	}
+
 	return 0;
 
 svs_probe_iounmap:
-- 
2.18.0

