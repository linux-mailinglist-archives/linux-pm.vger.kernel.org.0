Return-Path: <linux-pm+bounces-38082-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF71AC5FBC9
	for <lists+linux-pm@lfdr.de>; Sat, 15 Nov 2025 01:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 814FD4E415A
	for <lists+linux-pm@lfdr.de>; Sat, 15 Nov 2025 00:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F0D15CD74;
	Sat, 15 Nov 2025 00:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gRjueAgR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EAB1662E7
	for <linux-pm@vger.kernel.org>; Sat, 15 Nov 2025 00:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763166195; cv=none; b=lJ6hZlFQTcSIjBilFUX3Fnt7MgqPCLeenlXFw687b7ELmoXlKsunq9Pww070hSZiyhierWeU1mwp+DW4ERn8DA9UAmPpJ7pICYTLqCjAj2TJrp5feGULHeT+XnclgdXZ7lTKf38zQFDkSjgxEFkiwR7Z1AyPVYb/pSBlIFGLbl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763166195; c=relaxed/simple;
	bh=DIxjBZ2aoYO+FEvySF09p6zr1nZNMnmXb2G+/NwG0Wo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j463V1cmCNFEh0fwPuwVL99V7R58HezPIYqfjBuTVO+Ad6r40A63cfCvQujhLucfZ4PAREnkE2uLBCEku0HblhLbfHoZzOY6e4GmZtKADF7oON/oOLvf3zb33XwjHsvRyWAMTl9Jbj7o5YXrlXaLCGriAFvLVmX6DuGo0UAO9Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gRjueAgR; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-29558061c68so30521045ad.0
        for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2025 16:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763166191; x=1763770991; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1B/7EYtoj2CV5TTIMpc+9qgHFvwOgaXnLPax3zhrL7w=;
        b=gRjueAgRt8eV5bgmZVUWmG/SKnHz/95NaTUwaVP+et0WEnxHvCO6pqRQHUCXdv1wKW
         +ZlKXnv/xt7Cp89O1k7L1P2lv5Aq+TWBXUSO1YWbg+Hpbl6CN6EoJJsPOIT3RflTnnGt
         dPTQySx/k9ayhuO9no4eqyRYZhZ5VMNDbZ3EeoCin7WQZ3iruCSGEBlKRcyo1ixOTYIh
         SGrWozmtlMZbbpQ1r6V8Qgyv73w+6pyg3xfwM8KAyNAi8WkiEUDVsLEJtnjvY4HhAauq
         xRsrVi6/fSSq9CHhH3la64lHVC3nGffTx3/PbbJxNXzSh2BgK5/teLMcX0WqwdlhmzIJ
         6QGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763166191; x=1763770991;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1B/7EYtoj2CV5TTIMpc+9qgHFvwOgaXnLPax3zhrL7w=;
        b=HJln9vVTxeX+SXt8ebISoVi4cMm4SW/mN+NYXJe8ZEub+uxyXfAKgB+jL44h13dWwl
         CMxccYlsIZ0luEs+6DBlE2DaNV3FYynn6CQLc0dJjezSd8osXnGUrdB437uwKsKiQxPt
         yiDuS0GSM2RtYOIVAP+RKxvojm6iOCpnrz5LBkl/l9soa5qZ5zthCnPKjmhxm9kZ38Cx
         fRDya+tje1KgAGCaGh86i405FLbAngNAHDdzGv+WfNcR2hkIY75P11iVExyj4n73kwgA
         mOVYKPZk296EcpNgOT0PpLtMhTSh3ZKYvapZHZVsd4RPcQBW2KTM2xnfz0aL5X3NPCl5
         SbdQ==
X-Gm-Message-State: AOJu0Yymap7SDdI1jyrE5pIjEReapI/amM9kLAUSod2JmK+iLliEOfbe
	3S0iAUm5MS7hj7+f7dEAyQWQm0dTX3+ivFxQHQEJ9zD2SeZs9ec1+S2nNDKB8OtiG+c=
X-Gm-Gg: ASbGncvyvQbgaZOY6ot5uBAu0EP3LiSysku3YxytW3uDgJdpiolfqti75lctIZbhhEC
	tZhJ5BXN07Rg+wjNuckFXKVki/tRbmU3dJbQgh9FXR3lSwhW3xk48cXRtZubkwHVVUufFLlRzC0
	Z7BYe+QTuB6rhkIXUctcvDGUdqH4sjAq2scz7GugC2WIZi8wYbDj6wemmbOaBRdbnlMhm4lQauq
	NoRef++8aR6RtsloN/g6rXC2h6xQCHzukADPenZD7efLvN4fsUN9NFSGGEJ+31v97vnlT6dCCck
	dzxuatVwqMZJibj3ydrnI37CUPyDn4vmq3FNEO82nBZ2Cx72EEiFe/APb9yLqmkhTmEuEyt29Rk
	e0N3+J4igQxGkrPWB5aowN+Ui0WfH6DPbKfOlKrHdU9RDPI+3jMluhOErHLOCrKnbpFezVdL28g
	==
X-Google-Smtp-Source: AGHT+IGnUIwqBD5p2aTQOIEnwJalu8rxkmWR/0y4l7mzZmFExWWN+P3su1Chjm8xIjxy5i8LKUWgiw==
X-Received: by 2002:a17:903:384c:b0:298:68e:4057 with SMTP id d9443c01a7336-2986a759838mr62756635ad.59.1763166191152;
        Fri, 14 Nov 2025 16:23:11 -0800 (PST)
Received: from localhost ([71.212.208.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c244e13sm66297935ad.29.2025.11.14.16.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 16:23:10 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>, Pavel Machek <pavel@kernel.org>,
 Len Brown <len.brown@intel.com>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Saravana Kannan <saravanak@google.com>,
 Maulik Shah <quic_mkshah@quicinc.com>, Prasad Sodagudi
 <psodagud@quicinc.com>, Dhruva Gole <d-gole@ti.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] pmdomain: Respect the CPU system-wakeup QoS
 limit during s2idle
In-Reply-To: <CAPDyKFr1bC1=3psegT0DM0tPQaCUm1DoOxV3xBa-gVV6oSuRVA@mail.gmail.com>
References: <20251016151929.75863-1-ulf.hansson@linaro.org>
 <20251016151929.75863-3-ulf.hansson@linaro.org>
 <7h1pmik3w9.fsf@baylibre.com>
 <CAPDyKFr1bC1=3psegT0DM0tPQaCUm1DoOxV3xBa-gVV6oSuRVA@mail.gmail.com>
Date: Fri, 14 Nov 2025 16:23:09 -0800
Message-ID: <7hh5uwkutu.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On Sat, 1 Nov 2025 at 01:11, Kevin Hilman <khilman@baylibre.com> wrote:
>>
>> Ulf Hansson <ulf.hansson@linaro.org> writes:
>>
>> > A CPU system-wakeup QoS limit may have been requested by user-space. To
>> > avoid breaking this constraint when entering a low-power state during
>> > s2idle through genpd, let's extend the corresponding genpd governor for
>> > CPUs. More precisely, during s2idle let the genpd governor select a
>> > suitable low-power state, by taking into account the QoS limit.
>>
>> In addition to a QoS limit requested by userspace, shouldn't any
>> per-device QoS limits from devices in the PM domain with CPUs/clusters
>> also be considered?
>>
>> Right now, if a device is in a PM domain that also contains CPUs, any
>> per-device QoS constraints for those devices should also impact the
>> state chosen by s2idle.
>
> I am not so sure about that. The existing dev PM QoS latency is
> targeted towards runtime suspend of a device and the genpd governor
> also takes it into account for this use case.
>
> If we would start to take the same dev PM QoS latency constraint into
> account for system suspend (s2idle), it may not be what the user
> really intended. Instead, I think we should consider extending the dev
> PM QoS interface, to allow the user to set a specific latency limit
> for system wakeup. Then the genpd governor should take that into
> account for s2idle.
>>
>> I just tried a quick hack of extending you cpu_system_power_down_ok()
>> function to look for any per-device QoS constraints set all devices in
>> the PM domain (and subdomains).  It takes the min of all the per-device
>> QoS constratins, compares it to the one from userspace, and uses the min
>> of those to decide the genpd state.
>>
>> That has the effect I'm after, but curious what you think about the
>> usecase and the idea?
>
> It makes sense, but as stated above, I think we need a new QoS limit
> specific for system suspend.

OK, got it.  I understand the need to distinguish between QoS
constraints set for runtime PM and system-wide suspend/resume.

So, instead of adding a completely separate entry for system-wide
suspend, and duplicating a bunch of code/API, what about using the QoS
flags, and adding a new flag that indicates if the resume_latency
constraint applies only to runtime PM (the default) or if it *also*
applies to system-wide suspend? (RFC patch below[1])

With this, I was able to extend your new cpu_system_power_down_ok()
function to check for any devices in the domain with a resume_latency
*and* this new flag before applying it to s2idle, and that's working
great locally.

Kevin

[1]
From d25b871c2044ee0e993fd75f5f1df36a35633d1f Mon Sep 17 00:00:00 2001
From: "Kevin Hilman (TI.com)" <khilman@baylibre.com>
Date: Thu, 13 Nov 2025 17:02:38 -0800
Subject: [RFC/PATCH] PM / QoS: add flag to indicate latency applies
 system-wide

Add new PM_QOS_FLAG_LATENCY_SYS flag to indicate that the
resume_latency QoS constraint applies not just to runtime PM
transitions but also to system-wide suspend/s2idle.

Signed-off-by: Kevin Hilman (TI.com) <khilman@baylibre.com>
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
index 4a69d4af3ff8..b95f52775dfb 100644
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




