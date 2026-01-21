Return-Path: <linux-pm+bounces-41207-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KSbCPwxcGkSXAAAu9opvQ
	(envelope-from <linux-pm+bounces-41207-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 02:55:08 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A5C4F673
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 02:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C58BEA0BD94
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 01:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C0E322B86;
	Wed, 21 Jan 2026 01:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YzjGKYrl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E505320CBC
	for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 01:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768960495; cv=none; b=enEZXXsPXwJAovpqdkvsGSYDaorfmEwMmZH9RilwT+jKSaTX4mWDVmcLR/Wy9rOwnnhejSFt1uBI+qsoYFOR/zeD/bzkMZkmSIsqQNW6LkbMjQynXrwJ7gIPFah72sx3orrqeTzsz2BFh9CPh4HfdSI3ilghseJJ7sSIgiXE/BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768960495; c=relaxed/simple;
	bh=k+Fl6IhMZkW4zdULsvbRzYFhAZS1AjCB/KSpAtlWRRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W7DsVS11tIsF0r4cvIvYuRw6rhLjDRw0CLwP9VcbGhsGhtXwcI+eWZpM5fMy4cwuwCUrYbU6TQ6leeKl2/0u1I5v2H+xmK1Yot9C6Re8fgimLSDoGhA69pqyLxITQxwB8nW7LYhGf+0ry2IwiWZVxoWI8VjG2c4Ty7vB2bUSfmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YzjGKYrl; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a76f90872cso6736115ad.3
        for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 17:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768960487; x=1769565287; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rbUzzdXjX7SF274De+Y10x0I1IICDRKCDKCZqXPx8V4=;
        b=YzjGKYrl/265R+bNDYwnb9BV+fsWFV8fri+6JyI5B5JIPZXK6N41w3ccTPI9XNkCEO
         YyGc0Q6jss1SrITW1SweWS1+Tr+7uhiLjWlPPuUikxz40hlSjj9M5aJ9BnXmlRDCmeyj
         BA0S39pgycdxr3bR5sbCEyRWvCvPIUqOfVo+BqIfoANogog/jLryIrBWW7X95HxZu2BX
         ctGVGUxXbfXDNGNPdsjpIWtWaRggr83RO6OT4RLvi2mnmX01SNfHGbdOje/y6aQgtFIk
         zPFQH6hfEEzLHjrSZQ3h8lbDnS/a6gJcRD+XtZ+Y6UAOzQU3XHIKrJg9OaI7Ql1tC+IC
         c7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768960487; x=1769565287;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rbUzzdXjX7SF274De+Y10x0I1IICDRKCDKCZqXPx8V4=;
        b=fhs0GXEYvOIC6RYRzVMYwpnjtZo669TlUjV29INS1qNfs7LQB17aqtwYrL3yu+9u7k
         evR93wUS4qSEx/r706UTqxu8Oew6BIU+ujOvlh2PjtAgYc4kZ4/2FlnKXFTirBnYYLZy
         lZAn+xHiRd47RMGWTmXaLtRXk7zY0aizyU6UsrtjxEtvQdFDCPw1UgTgyy5A59idpcu0
         8DuIcvYwVzd/JxV2jXSeTdRYPfVOM/xUp6xYIH5MHCqLoFtpc5WrYi0qLdQ/subUWPR3
         79RzNairfl9gtOV9hVU6P80Ls29sGuq0BE0mVWKlXKE2MVDkzngYb6ay+1waQ7hMVvYU
         7UqA==
X-Forwarded-Encrypted: i=1; AJvYcCWY/whOJRyDbolRZAoY5DmESLYFOOsjck4z6bRDXP4MDYzRjo5xNt+F0RjAjiQzMKic4OuQcRTwgA==@vger.kernel.org
X-Gm-Message-State: AOJu0YykzmOV/o/Oz5C83hFzWIkivG05pkV8Hmb4b+IRawxbbxquYpqV
	z7upkr0i/A2xil07yMot1nxqFS6U82W6wW+N7NoE8STiWlspEeF9f+hjXOjpvoZemGs=
X-Gm-Gg: AZuq6aKUlGU8JK+JuNpgnlAyUI4q9fTD2nqJ0rUieFIJ4y/oCixUE2wqi2dNi3ODCd+
	bwymF+O0qM6Ez0aSTnhk/kthiUmWwZUGDiFCRx3hZpnr4/OoMffAguZkANkyuoZn8Ocs7MDMGQs
	6V1s8pw0xBgNTMDuvRzGEhqq1Hxr3nCMqdDT6dLweYOh8hvI0dEXe4HvfsZvt7FhoYMOSJZvlyr
	l/uU+HafXCp3YUqJIISRuQfieTgRSuvKv//Qw4cF3mSZgKv/fix8z3h/SGMGddi0JqXc6C982S9
	kZWUggh+1sqcWl67aceYCybySDg9IOyWjbqxiGZuNu6pMTLMjFjNbrhwcsvBV81l322I86/JthB
	mxZqngWd/2UnZsfsC/Z76Qg1/v86lMtU3y0+Stx/fhiBF5yLrKRrfyiI4gcb9yp1WsfwFIV9FP6
	CKywdV+eCa
X-Received: by 2002:a17:903:1a67:b0:2a7:6f90:8650 with SMTP id d9443c01a7336-2a76f9086b7mr31818275ad.55.1768960487009;
        Tue, 20 Jan 2026 17:54:47 -0800 (PST)
Received: from localhost ([71.212.200.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193fbf8fsm135489625ad.78.2026.01.20.17.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 17:54:46 -0800 (PST)
From: "Kevin Hilman (TI)" <khilman@baylibre.com>
Date: Tue, 20 Jan 2026 17:54:44 -0800
Subject: [PATCH 1/2] PM / QoS: add flag to indicate latency applies
 system-wide
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-topic-lpm-pmdomain-device-constraints-v1-1-108fc4cfafce@baylibre.com>
References: <20260120-topic-lpm-pmdomain-device-constraints-v1-0-108fc4cfafce@baylibre.com>
In-Reply-To: <20260120-topic-lpm-pmdomain-device-constraints-v1-0-108fc4cfafce@baylibre.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2313; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=k+Fl6IhMZkW4zdULsvbRzYFhAZS1AjCB/KSpAtlWRRU=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBpcDHlEX4ueOIJZgbwN2tO5otIiqWKqMV9b2qfb
 N1Bouzo+OyJAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCaXAx5QAKCRBZNxia0/vG
 ZcXHD/9cHpqeANTcR/xoS8Drc0O9cMGrPVLgCAoQF4x4OHvwCYDzawxIwXt60R0JOZxlGIxfTLy
 kNnLdQbV91lWmNch5cfBoTlXqSu00FtoDsdZ1/U454KRWXpMQxG7oL95k5R23kbuui6TS6OowXi
 PU++Sy7cTRTzQcTMBR+cx/2361SvXc1MtetxVAT8zc0vWiKzsu+Zex5szs/EMDpYBMWhzY44iq6
 cTDxxklpxpaRmzWfd5zj6NvY1SOVobcaN58OmkC9QiAdvDHPbYw/SXS6eLV7If++by4FJYqPsWz
 oyf8pVosAJPJhjt6xjYAdM3kqr/unErsOulVP6Nvn909FQ/W2ly4gN24TAs//9zWnguWjP0HdEL
 FJANuu4tJluhK3xfGS8KKx5fXLPj79mnWwylOmm3TbzQAzuee5dGsia0F6rtbPgu/WSc1DrjgES
 FpXtrF82Tffd+zgeBh3Az3MsQ0W/SvhJldwHZmn3oV/LpvsAKaWRksPToc/MUOyo2V+TovBy3bV
 MKzlB06CqPo8q8txslxmFHPy4aaqdzwloC+tGZChg6XBV/pbp5fzCQs+FtqraKM52DDBPSb/lB5
 0q8F7rbLR4sGD6ktqrCcyiSDbF2VDyC7tIqTW516RdqKgWOFy4KjweAieNyEYHcbM7d3xNXKZSa
 yWrDDeL5VBAz7mw==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-41207-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCPT_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khilman@baylibre.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,baylibre-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: B4A5C4F673
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

By default, the QoS resume latency currenly only applied to runtime PM
decisions.

Add new PM_QOS_FLAG_LATENCY_SYS flag to indicate that the
resume latency QoS constraint should be applied to system-wide
PM, and *not* runtime PM.

Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
---
 drivers/base/power/sysfs.c | 27 +++++++++++++++++++++++++++
 include/linux/pm_qos.h     |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index 13b31a3adc77..9136c13c17e4 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -316,6 +316,32 @@ static ssize_t pm_qos_no_power_off_store(struct device *dev,
 
 static DEVICE_ATTR_RW(pm_qos_no_power_off);
 
+static ssize_t pm_qos_latency_sys_show(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	return sysfs_emit(buf, "%d\n", !!(dev_pm_qos_requested_flags(dev)
+					  & PM_QOS_FLAG_LATENCY_SYS));
+}
+
+static ssize_t pm_qos_latency_sys_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t n)
+{
+	int ret;
+
+	if (kstrtoint(buf, 0, &ret))
+		return -EINVAL;
+
+	if (ret != 0 && ret != 1)
+		return -EINVAL;
+
+	ret = dev_pm_qos_update_flags(dev, PM_QOS_FLAG_LATENCY_SYS, ret);
+	return ret < 0 ? ret : n;
+}
+
+static DEVICE_ATTR_RW(pm_qos_latency_sys);
+
 #ifdef CONFIG_PM_SLEEP
 static const char _enabled[] = "enabled";
 static const char _disabled[] = "disabled";
@@ -681,6 +707,7 @@ static const struct attribute_group pm_qos_latency_tolerance_attr_group = {
 
 static struct attribute *pm_qos_flags_attrs[] = {
 	&dev_attr_pm_qos_no_power_off.attr,
+	&dev_attr_pm_qos_latency_sys.attr,
 	NULL,
 };
 static const struct attribute_group pm_qos_flags_attr_group = {
diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 6cea4455f867..aededda52b6b 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -37,6 +37,8 @@ enum pm_qos_flags_status {
 #define PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT	(-1)
 
 #define PM_QOS_FLAG_NO_POWER_OFF	(1 << 0)
+/* latency value applies to system-wide suspend/s2idle */
+#define PM_QOS_FLAG_LATENCY_SYS		(2 << 0)
 
 enum pm_qos_type {
 	PM_QOS_UNITIALIZED,

-- 
2.51.0


