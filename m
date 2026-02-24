Return-Path: <linux-pm+bounces-43102-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iH2OFoxInWk7OQQAu9opvQ
	(envelope-from <linux-pm+bounces-43102-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 07:43:24 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B1518283E
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 07:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24BDE3094A11
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 06:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815F830ACE6;
	Tue, 24 Feb 2026 06:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d1hyLe7H";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gb0pnDpe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A013043C9
	for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 06:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771915363; cv=none; b=Ai7PyQaxHy4ZRBYF3xnanJidZ7dFxkk00/vfGTOlG+CFEML7jLVtvjXcWQHP/SuaSPT2w8rx4MdlMc8DTvlgHzbbI2f7aKn7JfXDu3ShgC7GjoBrwdOFypEsFlOlZicgunfjrP07QnwOLZs+ckw6+jP2Ce6Gfs2JZeicF3ZF9bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771915363; c=relaxed/simple;
	bh=LZfrAICD4KiAUYwQIZDxFx5vfdV0wiYTUoP+tPCPTyA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NW9ztK1JTdsp0mhjr/PVYIeSN0rWZOv+qClc2SamWeugcBCk0GUhkvl9Bw5TnwJKL1ZzfJ8AniljqHuOXDrxwo1A5VpToSc20psbpjXd0jvTTHgOOrTXpbsKjjD8TGs3ZdQkH3U9JXu66G1EZqUeiSn2nZzfXJtjdwRceAX3tu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d1hyLe7H; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gb0pnDpe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61O4LTuJ1460161
	for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 06:42:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yMw9Pw25Ui92t5cfDP6O5v4cNs3hM/ikaiYaCJZzbbc=; b=d1hyLe7HINJNwp3A
	R5bBsnQCCfJoU0EQNhdwDsUX1+heoivKhqIEq8CJU2wc9sUTHh17ZiMjoRrIPXN4
	Z9EXlA4Te/bqoAbFsBkAQB7u0PkDgTMWPhpok5mRwtkYZIfR0W+6P13yZi39c5I+
	y5bXiO0ldU/Zc/AgwGEXv2WCKxOWlQd6EuIrQQ2HD7hjmapxrC+Y01FLS0RHQEvq
	WHEIl8EHnTdqCtS4DTpjaf2IP3NcF30QpBH9iP/HP3mYutkPsHeYE+XvQ/cR4g40
	/f5cTjUCnduLAt9nJplwjuzS6TKF0TaQqvsxzrgZ/978Gxmi+ycgoqKkUTgbdS4T
	+hAU9g==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ch4e38d4v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 06:42:41 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c6e1d32a128so3214001a12.3
        for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 22:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771915361; x=1772520161; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yMw9Pw25Ui92t5cfDP6O5v4cNs3hM/ikaiYaCJZzbbc=;
        b=Gb0pnDpefd/MGcL9KZpoBhvpkNYNo8ZqfZR1nLq+zp63QZxGUsuXcd/oVtywrFACTj
         eRSlD5Jf4kTLrMd8FdqHa51Ffre75MKrdHvyiugx/wlH+BvSrQ44F+sffr4QzpzPx23A
         nmGnDyBkdeo6GPLlaos3xPc78zyMxwoerm1BAN7yPV9hoID90yInJwW5r8KbVfkpji6W
         TCvPIhOBHdaX+7fQXfCFjG55RlUpgzrHLg4TqMVkLs6dxJy2dbm9hKcQSiXTkbMfIpXR
         Ac6jhUVzqx+yWjR1mKU1hg4z2oeLxq9KinZsaWuRRNc7yrIOa8q8ffczxOxp1h7kVuuM
         jGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771915361; x=1772520161;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yMw9Pw25Ui92t5cfDP6O5v4cNs3hM/ikaiYaCJZzbbc=;
        b=dH4QyE+J79ZxtN7d7QtHmor56R3E388Lev4MGCHSc3pn6YObj+aeIqyyjyTG0SFpi4
         G7PWliHTYzTRGeqCXICX0cmdwukYfLq80Xw8zbe4YTbqSfQ6Oz6VYQH6l0mmkTXcIfQw
         nuk4kQ8W2eXuFGrkDbq0vTUphEa4uc7dBKaMPewJ881JOAQ1EZAuPVTg4m2sllpOq18I
         vGzpmNiP/WsfJ+wkLPH9a9ZB1dkE6RizWmte10kdqKg9zCkJzR7LObbkRN3JwG4VHcIA
         PbVOYAWh0XSaMSn6GHVfl0DUn3PxBLP4nUy4+3hDtnDIZNmnm3TmTkWsvGKB2ii73oyg
         uA/A==
X-Forwarded-Encrypted: i=1; AJvYcCWo/QmA7zi87lt7AYBO/WuM+VU6IlMR3uPGh1v3zBW3rDH2drq17FOtnt9fshxYfiHZCXUcg/ZPaA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy84xvSEdnb34Fwi/zJ6NGJBgPf+VO1hy1GC/SOTf6NyBjoLS6Q
	iGUYbE+c+X52zuxxmFFyL+GARx2wW8xR3vbM+ktxkTcXZzF0K5DadyiuxWgYUi/EJ80Q8zRIHnX
	MF7vfG1VADcCC5k4rxc8+2Xt45GKSDovXw+68yfIHZ/ykkJnbODehBgZAsTBYQA==
X-Gm-Gg: ATEYQzy2zZQubAT7fmQcvxICKQPUi2nrTI1vpG+UL1Ku1Lw1WBYh1SVYOlH1y/Z16op
	PD9PZ+u8khUW7OrDZvHW/9R6p+/OQ++fimn36Dtu8mTj8Q9i3kAiQYyBx8NY1Bk/xaG4XiMiRpf
	rMTCxctDYEqevpWLUCjF+RT2EkO1j/nHVoEiL79v5OTJ5osRMnPix9dYaBNZFmd8O1jRL2gghQL
	gjUJtvai4m2GnIUMfRKmDE/3/i9jfLdr1mgtBpMTAZGLwHEd7oBmSWespUA0KLbtk8+w5Skixlo
	NVcw7rUBvH31IUZm64U1NiVYQYAOtwcg3bihb2JlAkWZb1MQ5jYwd8Q7pouje9b7n3PSS6gN3Hv
	4tckdsJED340lvtr8ZGjC5l//Nbj6Oj9ry7Y0G9Ek46WF7cmvHGYW6O7f/Q==
X-Received: by 2002:a05:6a00:330a:b0:7f6:4922:89c4 with SMTP id d2e1a72fcca58-826daa26025mr9771272b3a.55.1771915360533;
        Mon, 23 Feb 2026 22:42:40 -0800 (PST)
X-Received: by 2002:a05:6a00:330a:b0:7f6:4922:89c4 with SMTP id d2e1a72fcca58-826daa26025mr9771249b3a.55.1771915360059;
        Mon, 23 Feb 2026 22:42:40 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd8c7535sm11857732b3a.56.2026.02.23.22.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 22:42:39 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Tue, 24 Feb 2026 12:12:27 +0530
Subject: [PATCH v24 2/2] power: reset: reboot-mode: Expose sysfs for
 registered reboot_modes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-next-15nov_expose_sysfs-v24-2-4ee5b49d5a06@oss.qualcomm.com>
References: <20260224-next-15nov_expose_sysfs-v24-0-4ee5b49d5a06@oss.qualcomm.com>
In-Reply-To: <20260224-next-15nov_expose_sysfs-v24-0-4ee5b49d5a06@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>,
        Bartosz Golaszewski <bgolasze@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771915349; l=6356;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=LZfrAICD4KiAUYwQIZDxFx5vfdV0wiYTUoP+tPCPTyA=;
 b=Dit3QqHWSvGfA+7x4H7Cb9kGjH808YTDaprXRrMsegtJCE+P3tSvGZmWbbYPxjNGW4gd1iLiJ
 DDQHTUv7kSNAwhGd1ccgwd5erBHUQ9r0D987++fx84bxN1okeFUCojZ
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Authority-Analysis: v=2.4 cv=DfIaa/tW c=1 sm=1 tr=0 ts=699d4861 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=s8YR1HE3AAAA:8 a=BT1iJhKI-cehe1MtwS8A:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-GUID: I2GC4xG6GWCSj-3cXk3chkZloA970Upl
X-Proofpoint-ORIG-GUID: I2GC4xG6GWCSj-3cXk3chkZloA970Upl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA1NiBTYWx0ZWRfX4NJaKFVYvtQg
 5ZmOkcYMORFR58UgFj6iw/0rMS8Ofqr3mhpyUG7eDZzum1jiX5DjXxNhj5WuRDlf8FiPrMwtyKv
 fcxhmyqHq4TAdYhqwMaqFz+No/cUv9Z64ccxzj96DXhfYwc4RtiK8Vu1MMgA9OgBBz3PH3lrgGg
 Pk1DOhFnsYe9bxrgsKI6aRn+J9+pAdcyD62JhgSSDfDEc9ipTzJoOXoaksP9m1tDoOkDgpvmPFd
 F4HWEuMeyFN7VvXdJgXj/woZiJKZcGDkIMNp0YzNDtSHBIe8pgoTdxzA+e1D+zYOYG/xdriZN7H
 sxG2S8jDh1hua/ZFjs5FKKH1BDOiaUxWbfeXd25NByxtYMBNDqIiJV8ZfZceb9SDG89Str4JVPl
 nXZ7YA3EqYnIlFA3wzUQa1PhUMs6CuQdV6pBn976kAUR8d+MUF6Ya/i7cY0aXtIkC/vbsNHtR+D
 jM6VLNfZC0x8ED0zOEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_06,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602240056
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rock-chips.com:email,qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43102-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	FROM_NEQ_ENVFROM(0.00)[shivendra.pratap@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 01B1518283E
X-Rspamd-Action: no action

Currently, there is no standardized mechanism for userspace to discover
supported reboot modes on a platform. This limits userspace scripts, to
rely on hardcoded assumptions about the available reboot-modes.

Create a class 'reboot-mode' and a device under it. Use the name of the
registering driver as device name. Expose a sysfs interface under this
device to show available reboot mode arguments.

 This results in the creation of:
   /sys/class/reboot-mode/<driver>/reboot_modes

This read-only sysfs file will exposes the supported reboot mode
arguments provided by the registering driver, enabling userspace to
query the list of arguments.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/power/reset/reboot-mode.c | 150 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 147 insertions(+), 3 deletions(-)

diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index fba53f638da04655e756b5f8b7d2d666d1379535..ad239e96774b6f033f2bdea9e4779403bc609c57 100644
--- a/drivers/power/reset/reboot-mode.c
+++ b/drivers/power/reset/reboot-mode.c
@@ -4,12 +4,16 @@
  */
 
 #include <linux/device.h>
+#include <linux/err.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/reboot.h>
 #include <linux/reboot-mode.h>
+#include <linux/slab.h>
+#include <linux/string.h>
 
 #define PREFIX "mode-"
 
@@ -19,6 +23,54 @@ struct mode_info {
 	struct list_head list;
 };
 
+struct reboot_mode_sysfs_data {
+	struct device *reboot_mode_device;
+	struct list_head head;
+};
+
+static inline void reboot_mode_release_list(struct reboot_mode_sysfs_data *priv)
+{
+	struct mode_info *info;
+	struct mode_info *next;
+
+	list_for_each_entry_safe(info, next, &priv->head, list) {
+		list_del(&info->list);
+		kfree_const(info->mode);
+		kfree(info);
+	}
+}
+
+static ssize_t reboot_modes_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct reboot_mode_sysfs_data *priv;
+	struct mode_info *sysfs_info;
+	ssize_t size = 0;
+
+	priv = dev_get_drvdata(dev);
+	if (!priv)
+		return -ENODATA;
+
+	list_for_each_entry(sysfs_info, &priv->head, list)
+		size += sysfs_emit_at(buf, size, "%s ", sysfs_info->mode);
+
+	if (!size)
+		return -ENODATA;
+
+	return size + sysfs_emit_at(buf, size - 1, "\n");
+}
+static DEVICE_ATTR_RO(reboot_modes);
+
+static struct attribute *reboot_mode_attrs[] = {
+	&dev_attr_reboot_modes.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(reboot_mode);
+
+static const struct class reboot_mode_class = {
+	.name = "reboot-mode",
+	.dev_groups = reboot_mode_groups,
+};
+
 static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
 					  const char *cmd)
 {
@@ -62,6 +114,51 @@ static int reboot_mode_notify(struct notifier_block *this,
 	return NOTIFY_DONE;
 }
 
+static int reboot_mode_create_device(struct reboot_mode_driver *reboot)
+{
+	struct reboot_mode_sysfs_data *priv;
+	struct mode_info *sysfs_info;
+	struct mode_info *info;
+	int ret;
+
+	priv = kzalloc_obj(*priv, GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&priv->head);
+
+	list_for_each_entry(info, &reboot->head, list) {
+		sysfs_info = kzalloc_obj(*sysfs_info, GFP_KERNEL);
+		if (!sysfs_info) {
+			ret = -ENOMEM;
+			goto error;
+		}
+
+		sysfs_info->mode = kstrdup_const(info->mode, GFP_KERNEL);
+		if (!sysfs_info->mode) {
+			kfree(sysfs_info);
+			ret = -ENOMEM;
+			goto error;
+		}
+
+		list_add_tail(&sysfs_info->list, &priv->head);
+	}
+
+	priv->reboot_mode_device = device_create(&reboot_mode_class, NULL, 0,
+						 (void *)priv, reboot->dev->driver->name);
+	if (IS_ERR(priv->reboot_mode_device)) {
+		ret = PTR_ERR(priv->reboot_mode_device);
+		goto error;
+	}
+
+	return 0;
+
+error:
+	reboot_mode_release_list(priv);
+	kfree(priv);
+	return ret;
+}
+
 /**
  * reboot_mode_register - register a reboot mode driver
  * @reboot: reboot mode driver
@@ -113,16 +210,49 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 	reboot->reboot_notifier.notifier_call = reboot_mode_notify;
 	register_reboot_notifier(&reboot->reboot_notifier);
 
+	ret = reboot_mode_create_device(reboot);
+	if (ret)
+		goto error;
+
 	return 0;
 
 error:
-	list_for_each_entry(info, &reboot->head, list)
-		kfree_const(info->mode);
-
+	reboot_mode_unregister(reboot);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(reboot_mode_register);
 
+static int reboot_mode_match_by_name(struct device *dev, const void *data)
+{
+	const char *name = data;
+
+	if (!dev || !data)
+		return 0;
+
+	return dev_name(dev) && strcmp(dev_name(dev), name) == 0;
+}
+
+static inline void reboot_mode_unregister_device(struct reboot_mode_driver *reboot)
+{
+	struct reboot_mode_sysfs_data *priv;
+	struct device *reboot_mode_device;
+
+	reboot_mode_device = class_find_device(&reboot_mode_class, NULL, reboot->dev->driver->name,
+					       reboot_mode_match_by_name);
+
+	if (!reboot_mode_device)
+		return;
+
+	priv = dev_get_drvdata(reboot_mode_device);
+	device_unregister(reboot_mode_device);
+
+	if (!priv)
+		return;
+
+	reboot_mode_release_list(priv);
+	kfree(priv);
+}
+
 /**
  * reboot_mode_unregister - unregister a reboot mode driver
  * @reboot: reboot mode driver
@@ -132,6 +262,7 @@ int reboot_mode_unregister(struct reboot_mode_driver *reboot)
 	struct mode_info *info;
 
 	unregister_reboot_notifier(&reboot->reboot_notifier);
+	reboot_mode_unregister_device(reboot);
 
 	list_for_each_entry(info, &reboot->head, list)
 		kfree_const(info->mode);
@@ -199,6 +330,19 @@ void devm_reboot_mode_unregister(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_reboot_mode_unregister);
 
+static int __init reboot_mode_init(void)
+{
+	return class_register(&reboot_mode_class);
+}
+
+static void __exit reboot_mode_exit(void)
+{
+	class_unregister(&reboot_mode_class);
+}
+
+subsys_initcall(reboot_mode_init);
+module_exit(reboot_mode_exit);
+
 MODULE_AUTHOR("Andy Yan <andy.yan@rock-chips.com>");
 MODULE_DESCRIPTION("System reboot mode core library");
 MODULE_LICENSE("GPL v2");

-- 
2.34.1


