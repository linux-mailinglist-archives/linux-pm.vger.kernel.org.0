Return-Path: <linux-pm+bounces-11485-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EA393E08B
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 20:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 696C71C20BE3
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 18:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FABF18756E;
	Sat, 27 Jul 2024 18:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkowGy8B"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49F3187349
	for <linux-pm@vger.kernel.org>; Sat, 27 Jul 2024 18:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722104823; cv=none; b=nXUyI3ChOw712N72oc647ei2DQEO6SSHI15ChrDumdBIYmexK0bIF4iaMgEoIwkEnet2/fAk6ASfIUmZnjP7kN0MaIdA0GsCJOV8c70IgU4KX5lqo45s/kB+EMl7t/FMNnY5hUdP+eznPMNxZrIDwhzpSsleQyAlMrcIKBZtQqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722104823; c=relaxed/simple;
	bh=FJRL3LAKI/9nXiob5WNC0lMnW/jrtyi/FRdes11HOkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFv+UTo5ezeOCjbOyMYmWG5n1dmtPM7Khj4T+gOaEXYXInC2ymGIFfRjzV9nCxYSBmJwjkpnujAX+2ll1skKFN4slCGvWrAYuX+2UxnKj+SducwEdJKQK3ouMxf+X99r2GH5tbbMYRKQ5ISnNuH+HJve5qvY0vfQQSM0rQQHSg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkowGy8B; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-70944dc8dc6so373427a34.3
        for <linux-pm@vger.kernel.org>; Sat, 27 Jul 2024 11:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722104821; x=1722709621; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4DuT1/HcMJIx92HYiFDWlQ5IgVJeLmwM3GZ6oGZt2ok=;
        b=nkowGy8BWrbF2E+xXas5uGvQfjJernoa7EZvg6YEIgk7bBers+J+93w9uQU0fJz1P3
         hI4kL5Bn7AKDKE8s3drdMQKuezi+QlXu52iZ6o1SoTM5xE+yLcJfJ2V4zTQbeKwAzaCh
         Ng7sRVX2HKAP5C4JUSksqEH/Ax5SC6pqDfucMWCnhIXx4tAEQRS4YYiVhyjVdG8czAAr
         puFAhR74gcIm2X/Ryzjzslhu53/YZcHmdp/r14VF6zOgWE5TobmQj4Bn21zTtVw/UkUp
         hC1eOiSVe88t82YCrb4JrmWCzYC0/UWAWTCjb4+gpYzJ61plgZ0RwdKaFSDm7Th2D3XO
         550Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722104821; x=1722709621;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4DuT1/HcMJIx92HYiFDWlQ5IgVJeLmwM3GZ6oGZt2ok=;
        b=Brv5qMrmK5zigSwlCCIOMcVXPo03GAXpQjQn89/8YiFTZB0qJhPVmdf8Exh9nex4sZ
         m2Umi+a3s4dbl3Xtq6Enk1bN/GYkrpWpyC30mdwWB/3kYeRWcOZOL3uRX5E1xujhzb8M
         dvq/2InBRx3uotwCEHCq/6o7SSAizlqIRwMjG4yO6rYi4xIdFG0gjcjNuUj3/wmQQIwh
         FzunXu0JrvTGXvLTJFjFRf3E7b9hXx0MrAk0StDUhRO2VPmiZmARl06M38Lit4vG4neK
         P+f065E84Y/JN6ZKNIWYYRNZDkMv+dWtUGTiSXd0kA+u8HF/iPY+fjw4/75eid/sguzY
         yvhQ==
X-Gm-Message-State: AOJu0YxKm/7/7aAqf/NEOXKvAsIGfLdj7kuJt+4Q4QmyI5BQx3nPM0ea
	jxEt3Wg1qTwW3RBJo8O5/jK6OmF059gIIeFGwsWyFVvjm7rmgyUDUhrajg==
X-Google-Smtp-Source: AGHT+IFhMwQVtnjJlcs81gIORAPchVxqn6Eb2zAZDrAK4trIfARU7n0+yMhc6dSRi1DBDWXL0nHscw==
X-Received: by 2002:a05:6870:e391:b0:260:f50e:9242 with SMTP id 586e51a60fabf-267d4f5806amr4386503fac.41.1722104820750;
        Sat, 27 Jul 2024 11:27:00 -0700 (PDT)
Received: from lenb-intel-nuc8i7hvkva.. (h75-100-80-185.cntcnh.broadband.dynamic.tds.net. [75.100.80.185])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7093050a35fsm1314136a34.6.2024.07.27.11.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 11:27:00 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 16/18] tools/power turbostat: Document PMT in turbostat.8
Date: Sat, 27 Jul 2024 14:23:42 -0400
Message-ID: <944264a2a99cc4dd4b10eaa9798b6aab80adf4be.1722019621.git.len.brown@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1b3bf0747d4f1a963e59c26e602868bdce195318.1722019621.git.len.brown@intel.com>
References: <1b3bf0747d4f1a963e59c26e602868bdce195318.1722019621.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>

Add a general description of the user interface for adding PMT
counters with the new --add pmt,... option.

Provide a complete example for requesting two counters.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.8 | 65 +++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index 44cbc7cb382d..067717bce1d4 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -55,6 +55,39 @@ name as necessary to disambiguate it from others is necessary.  Note that option
 		as the column header.
 .fi
 .PP
+\fB--add pmt,[attr_name=attr_value, ...]\fP add column with a PMT (Intel Platform Monitoring Technology) counter in a similar way to --add option above, but require PMT metadata to be supplied to correctly read and display the counter. The metadata can be found in the Intel PMT XML files, hosted at https://github.com/intel/Intel-PMT. For a complete example see "ADD PMT COUNTER EXAMPLE".
+.nf
+	name="name_string"
+		For column header.
+
+	type={\fBraw\fP}
+		'raw' shows the counter contents in hex.
+		default: raw
+
+	format={\fBraw\fP | \fBdelta\fP}
+		'raw' shows the counter contents in hex.
+		'delta' shows the difference in values during the measurement interval.
+		default: raw
+
+	domain={\fBcpu%u\fP | \fBcore%u\fP | \fBpackage%u\fP}
+		'cpu' per cpu/thread counter.
+		'core' per core counter.
+		'package' per package counter.
+		'%u' denotes id of the domain that the counter is associated with. For example core4 would mean that the counter is associated with core number 4.
+
+	offset=\fB%u\fP
+		'%u' offset within the PMT MMIO region.
+
+	lsb=\fB%u\fP
+		'%u' least significant bit within the 64 bit value read from 'offset'. Together with 'msb', used to form a read mask.
+
+	msb=\fB%u\fP
+		'%u' most significant bit within the 64 bit value read from 'offset'. Together with 'lsb', used to form a read mask.
+
+	guid=\fB%x\fP
+		'%x' hex identifier of the PMT MMIO region.
+.fi
+.PP
 \fB--cpu cpu-set\fP limit output to system summary plus the specified cpu-set.  If cpu-set is the string "core", then the system summary plus the first CPU in each core are printed -- eg. subsequent HT siblings are not printed.  Or if cpu-set is the string "package", then the system summary plus the first CPU in each package is printed.  Otherwise, the system summary plus the specified set of CPUs are printed.  The cpu-set is ordered from low to high, comma delimited with ".." and "-" permitted to denote a range. eg. 1,2,8,14..17,21-44
 .PP
 \fB--hide column\fP do not show the specified built-in columns.  May be invoked multiple times, or with a comma-separated list of column names.
@@ -354,6 +387,38 @@ CPU     pCPU%c1 CPU%c1
 
 .fi
 
+.SH ADD PMT COUNTER EXAMPLE
+Here we limit turbostat to showing just the CPU number 0.
+We add two counters, showing crystal clock count and the DC6 residency.
+All the parameters passed are based on the metadata found in the PMT XML files.
+
+For the crystal clock count, we
+label it with the column header, "XTAL",
+we set the type to 'raw', to read the number of clock ticks in hex,
+we set the format to 'delta', to display the difference in ticks during the measurement interval,
+we set the domain to 'package0', to collect it and associate it with the whole package number 0,
+we set the offset to '0', which is a offset of the counter within the PMT MMIO region,
+we set the lsb and msb to cover all 64 bits of the read 64 bit value,
+and finally we set the guid to '0x1a067102', that identifies the PMT MMIO region to which the 'offset' is applied to read the counter value.
+
+For the DC6 residency counter, we
+label it with the column header, "Die%c6",
+we set the type to 'txtal_time', to obtain the percent residency value
+we set the format to 'delta', to display the difference in ticks during the measurement interval,
+we set the domain to 'package0', to collect it and associate it with the whole package number 0,
+we set the offset to '0', which is a offset of the counter within the PMT MMIO region,
+we set the lsb and msb to cover all 64 bits of the read 64 bit value,
+and finally we set the guid to '0x1a067102', that identifies the PMT MMIO region to which the 'offset' is applied to read the counter value.
+
+.nf
+sudo ./turbostat --quiet --cpu 0 --show CPU --add pmt,name=XTAL,type=raw,format=delta,domain=package0,offset=0,lsb=0,msb=63,guid=0x1a067102 --add pmt,name=Die%c6,type=txtal_time,format=delta,domain=package0,offset=120,lsb=0,msb=63,guid=0x1a067102
+0.104352 sec
+CPU                   XTAL      Die%c6
+-       0x0000006d4d957ca7      0.00
+0       0x0000006d4d957ca7      0.00
+0.102448 sec
+.fi
+
 .SH INPUT
 
 For interval-mode, turbostat will immediately end the current interval
-- 
2.43.0


