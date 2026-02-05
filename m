Return-Path: <linux-pm+bounces-42167-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHVVK+vRhGk45QMAu9opvQ
	(envelope-from <linux-pm+bounces-42167-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 18:22:51 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEE5F5DAD
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 18:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD5173059F05
	for <lists+linux-pm@lfdr.de>; Thu,  5 Feb 2026 17:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784BA43C061;
	Thu,  5 Feb 2026 17:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EdpgLbQ5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S5iUt5Lo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D9030B513
	for <linux-pm@vger.kernel.org>; Thu,  5 Feb 2026 17:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770311851; cv=none; b=X5oXaVzql40uENmKC8L0FbWNqZR9vqwuINfHMhy+DkFFSKttH+Dtzvm0e82wtXoiQyVDMyfEzqD5eOvK5Az33WPBK7iZFvGwIomfDOj6DL+uR8vKg6s++YFCI9pCXrwXxO2gFeE7n3VVp31ysMi5b8kenRbZn4Z8bBveCuEVLH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770311851; c=relaxed/simple;
	bh=2qQcHSEUoKunuCBuoEcm4nmD3ZK0Z2+wvGjK1AhbyOY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=udQ6sQpcgONl5L42wNwVcSK7e0aId4NZae/z7luZMzTSPx0BwyJJ0J7DdA3o8DOXwNKq9vh3xus0As07aXAnqaWsb+koRVAK0Df6gKRzWpsLiYfdF922yfamUvrqexdsUabkUoaz0ugs5iOhUn4t0l1FkQEWGFnpmdj1UpktX28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EdpgLbQ5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S5iUt5Lo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615Blf6w4135881
	for <linux-pm@vger.kernel.org>; Thu, 5 Feb 2026 17:17:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	10u3oiFlmreOeQbKy0q5kpmymKMe85wwd48dyBzI9U4=; b=EdpgLbQ50wh8ExVJ
	ntoV0K419Z1EkTIqcKnCr/3J/3hO4/slQP0GTqi0Ne+Rbiq6ZiEV0DOJEWh/X9UO
	nHv40sSKgmDH6C3zZ4XKsvXncQApD/w+82c4tYAvKM1QiGndCiZoTDJSuwJgJdlA
	Jebzig1OZuGiN8jLKuBI4xAsiMrnQUxsL1AUOS1u0HDuG/C1zGT8qGfnDzBzMWmB
	eKGfu8ShxhLeDA1eJzVg+oFWxnnmolV6gziZDEBNUxEz86J/qXjQ6Jb0XiUEb/n3
	Gdmzi2JTbDArKvzVh8MAvnwbdtT4RTXWfvGN4k2vnfjkgLI8J7hzaAGUDDs/PTr0
	QaAq8Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c4tn413hd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 05 Feb 2026 17:17:30 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a7d7b87977so12367015ad.0
        for <linux-pm@vger.kernel.org>; Thu, 05 Feb 2026 09:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770311849; x=1770916649; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=10u3oiFlmreOeQbKy0q5kpmymKMe85wwd48dyBzI9U4=;
        b=S5iUt5LoBPfmbsCESu5Tu7EUXCILORtxUMMyL7kFoCCP02H+I5i3Z+YSo5aGNHNgOe
         f5v5yvCM0/+iAld4/xow0UW5mbwjxW8T9vh0TAqr4kQEYxhfHG80IhALTv63GlkGFpCj
         KHcMfufYhSyMKjPaqwotBOQ8BuXbyBgQS5LjrCi3UhQCpe1RAm+clTO68C4l0eFGY7PU
         tUhlvCmziP/omjBF2S+EopZ9FBQ2SgNIa7NsC+Q0DvlV8O1wYBfxcO9DfdWX2XiX8hGc
         mL9qUbHBnP7nnmzi36fyO8mMCoMv5qVqoH/3oeCJP7J5ypbvznMFOyJ03jpumbnLt+dQ
         +Tog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770311849; x=1770916649;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=10u3oiFlmreOeQbKy0q5kpmymKMe85wwd48dyBzI9U4=;
        b=AmGW+UfBsP99ZzRZ3FuI113usQtm+MfoJjxW+kEKEoh42JAhiHhn4AEDJh7JTRqFzT
         OtHpIteOSdFlrBrcyjKeHcrxW/Xn7tJrKmHDXJ1tj5kJRKXHMhD8DS0/gHapspKoMW96
         o/g5BxQhVAE5uoWl3EkEuI4COkpRm9rxoy/JDPYFdGNb+CLTkz9Ve9Ej+oKx7pG8GB0U
         ddP9N/n/gC8kbxws3wu0iKN42tkjFtRQw2hEZOzZ4Ng8BbTFm7oSfnrU3XnEoPvLYGjm
         mdGCdWvtvasueaJhwau6XjHUSa3YLGNTDJKLoXJAIioU174X2ZmP6mXgCn8XHXjfKt6X
         0JbA==
X-Forwarded-Encrypted: i=1; AJvYcCXR0lnwiZHBx/y+HkbYVKugrssYgXHna4ruBjMh2Wtqq7nD3U+ixkGbAkwZKOd+Weaj7nlcNlfs/w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3mtLmCrgNvQTKUr52qT51EFsFAj4E5KR7MkdT0/w46UEtSclb
	D68j2ZGoXdhOzrWCDrteVpsijPoRgr62EUfMwBY2Ob5bG/qfjIPdAUd23VsSgtOMjmG4AP/z1oC
	OsK9HR4YS7aLe09E8ckqJ0uwTXSD6Nt+oOOt4a/EHTZRRRIL9WOMCoVyPPt7mIw==
X-Gm-Gg: AZuq6aIinKLpNzG5ncCbXG7BduBA3WY6IF1eF2NPkrq8Gltse1lZLKjT+PkiUUmicVW
	eA+5IJlJOCsr0ysvsb5GPbQeFGho6Gwy4tU0LQBUigwRyNhMRvn0Pe41mciRo+/xnAxM4Q8EpHV
	1bYxACWLI/vR3TtKgz43FODnYkIkg6FcF7De6QCjioPxl5tONMJSX3f/2mjsM+YCuKF5aksexsS
	2TSKT6OqUw83LT/cyd/FLvojaNikrXzXMbxdXORBqwNalQULW2pyuYeXHnryOJR8Lk1GgyDOR9f
	TQU2p56u07RA8hGNiv7vcM2pMZLTlGZuVWQWZBEs4DYQfXmWUCkMh5AL8W25lEz6tb6AB8EaGRi
	ArndI0z15GSbK2pqDuRXBEbbVpC+/r63uYEembRcYCyK+Tw==
X-Received: by 2002:a17:903:191:b0:29d:f739:ff5f with SMTP id d9443c01a7336-2a93412a8c6mr83456085ad.61.1770311849487;
        Thu, 05 Feb 2026 09:17:29 -0800 (PST)
X-Received: by 2002:a17:903:191:b0:29d:f739:ff5f with SMTP id d9443c01a7336-2a93412a8c6mr83455805ad.61.1770311848860;
        Thu, 05 Feb 2026 09:17:28 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a933966f12sm55059415ad.76.2026.02.05.09.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 09:17:28 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Thu, 05 Feb 2026 22:47:14 +0530
Subject: [PATCH v23 2/2] power: reset: reboot-mode: Expose sysfs for
 registered reboot_modes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-next-15nov_expose_sysfs-v23-2-b0c5bdcc9f94@oss.qualcomm.com>
References: <20260205-next-15nov_expose_sysfs-v23-0-b0c5bdcc9f94@oss.qualcomm.com>
In-Reply-To: <20260205-next-15nov_expose_sysfs-v23-0-b0c5bdcc9f94@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>,
        Bartosz Golaszewski <bgolasze@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770311838; l=6280;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=2qQcHSEUoKunuCBuoEcm4nmD3ZK0Z2+wvGjK1AhbyOY=;
 b=Zvx00/bSIRfeBzuYgTOu4GAAyQlEv7v3chuxMe2vUzigia8CGxLTGVBiDosrhVnfXzhWmAEU6
 wEGkuVO/tjPDq5dCA2DnR9Y8kGMIsSUHiBdlZa8zmrOLJZgIeAHvHYf
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-GUID: BZ45ycad18te9pc2cIgp0tivHyd4-hF2
X-Proofpoint-ORIG-GUID: BZ45ycad18te9pc2cIgp0tivHyd4-hF2
X-Authority-Analysis: v=2.4 cv=Dfgaa/tW c=1 sm=1 tr=0 ts=6984d0aa cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=s8YR1HE3AAAA:8
 a=BT1iJhKI-cehe1MtwS8A:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDEzMSBTYWx0ZWRfXw+XzLj599jMa
 jHKYC+GMV1bRRUQ+3NtUz3WlQU+O5EszuC0MtQDnDvxGCb33KCWGBvDXd8eQALREDPjM/n6Ymxk
 1kf4bv9nPzjZI6+3Hufso7H4k6KvKv69mv/8k1pTTBNAdYh2BW1C1KoKJLIBwf8mmbMBnYgdlza
 qUBARrsqEY2bxgIse4sG80NO34ahPt7mRo5q/vMgMfBU9a5YrKDQo1yaxPhl13ULbOHq8TXSklJ
 CwaEQ+p2+7DxFpvcqn13iaVPxyqeNrCFSw42/G9svBrMCb6tvh2GlHzksZVRAaEpTjaaNsrSoUo
 xkRk7YtjQjojx4YF4khJ2S0x13NEjzi1ygRMP8HxJg3Qf7FM+jiLTs3u7KwfsNiHc+q+ABm/gr1
 CMJwiUqgW8/bDXdRBZ0VRb0u9KuEIORVG5JvnpoWLuDog/3n+RaiVL3fJNH2UNXM4s1sBwUC14N
 7ovVqSHrk8Qj8ZG+I5Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_04,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602050131
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,rock-chips.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42167-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	FROM_NEQ_ENVFROM(0.00)[shivendra.pratap@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3BEE5F5DAD
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

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/power/reset/reboot-mode.c | 151 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 148 insertions(+), 3 deletions(-)

diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index fba53f638da04655e756b5f8b7d2d666d1379535..7fdb788c8cc85f26bdd381e1cea7a936b052e8ab 100644
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
+static inline void reboot_mode_release_list(struct list_head *head)
+{
+	struct mode_info *info;
+	struct mode_info *next;
+
+	list_for_each_entry_safe(info, next, head, list) {
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
@@ -62,6 +114,52 @@ static int reboot_mode_notify(struct notifier_block *this,
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
+
+	if (IS_ERR(priv->reboot_mode_device)) {
+		ret = PTR_ERR(priv->reboot_mode_device);
+		goto error;
+	}
+
+	return 0;
+
+error:
+	reboot_mode_release_list(&priv->head);
+	kfree(priv);
+	return ret;
+}
+
 /**
  * reboot_mode_register - register a reboot mode driver
  * @reboot: reboot mode driver
@@ -113,16 +211,49 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
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
+	reboot_mode_release_list(&priv->head);
+	kfree(priv);
+}
+
 /**
  * reboot_mode_unregister - unregister a reboot mode driver
  * @reboot: reboot mode driver
@@ -132,6 +263,7 @@ int reboot_mode_unregister(struct reboot_mode_driver *reboot)
 	struct mode_info *info;
 
 	unregister_reboot_notifier(&reboot->reboot_notifier);
+	reboot_mode_unregister_device(reboot);
 
 	list_for_each_entry(info, &reboot->head, list)
 		kfree_const(info->mode);
@@ -199,6 +331,19 @@ void devm_reboot_mode_unregister(struct device *dev,
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


