Return-Path: <linux-pm+bounces-36561-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EF564BF6175
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 13:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D14654F1643
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 11:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6F332E72E;
	Tue, 21 Oct 2025 11:37:53 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE1222541C
	for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 11:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761046673; cv=none; b=qg0yvYWJtp0WuWkXXWRtAvYrqwjAI7RYbbb7L/v6bOG3FjRBEvnXc/mAG6OWv7HwFyyz/9HI/XWnYaTStKSuZEFw402nCJG1usnu6PPL6JhO4pYal5W6r0tgU3zxy/q7c4GiNfP4mmy1LKDhQXGxbjI3y2RaNK9vX5TaY2+jtq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761046673; c=relaxed/simple;
	bh=kuoE1FUvLeKFmLsCoNqOIkjJG2dB4pdTppXQYQPWGsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EJf45bCrJfxzBT+u9BXadyC5WcdFhpxvdPxG1uD59qFBv86HJ6Y0opZtMzt/F8kEptg6ARGy29EpCBDr+dhFWCpcJ4Vpc8VLYAak04xrxAMWFcNxmjiszsfh2PFfi/gMlMUMadJH/IMZdLuCLON7Aq6JygmX33Q3PrTQ0ySd8aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-b593def09e3so3649153a12.2
        for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 04:37:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761046671; x=1761651471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AKqpzOqhN5Ccg89sMbSx3T7qxxa8RixMmw1THiek4uU=;
        b=CPNjoCKhgD66CTGrr+oUzApoo3RMri7i3e+cjXuzmygAhHWp5GX+1IkUMSNmhepXIh
         94XTbJt9E4nKNClk0wELCsntZkgmi30zU/+FphnCFXnmLSmrdB36djBQAqDtb+hyONXw
         duAASpQj5Zrtqk9RZjx/RLBD4nODF7VEOhk1j87H3kV8S1KxXQIyGQISrWCg/pPKTGUE
         I2/Wi5HBvBHCV1+IDoaC5+xLKU2Gvhqu7XlrAkp933XhvBzI25pHdThWFE40hbWabFWQ
         X9Zreap4BLCHlRb0wkYKfOwzI2gbMN4Hfw0hHc7Gx6S/qNcN9gZozZZIwd4J/bgd4AHj
         uNow==
X-Forwarded-Encrypted: i=1; AJvYcCUoPGplxmLokJ+Tzm2vxfgcLq842A9eGp1B+IIliQD3LmHsMdHMpwUP+XtWmf6vGcAOvAVEiQ93tg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsnx7FkLEfZPPNGfd8MXpTCk63T7PaRTNdz39B1VpppE+m3HUU
	tXzAA/AFid/9R+OBZKSoCB0qr9F3DkC3CaE2HhHQm3fEeSdSOJdREtYwBtZfYFr9ooct5Q==
X-Gm-Gg: ASbGncs9ZN5UpwmAuXRAsWRuaBU5Rky737/ddawYRasqI8yVnx9+yKXT/ltvOe9PcA1
	slpDTH+IvWTTDzDlF/PvAUBsYaoqXSlw9SmM4zbyRHk6DQcgGjdc2FeK0dU1MMs9GfZWIVI/Qp9
	f03qeVCYb7MPNb9mjLQ8HVZlCVAxaieuJJSzZcjNsU9ZCXHmbSw2EdJqWW6p2iy40e+MHgFjNyg
	J5KMCrwTbzvJLlDt9o23Boy+Ms3qgMwtO+vXUugy8BtgvqXgE41g67d1tf3UVZnBneUeII7peAs
	g0c4joN+URS/cE0jLixX9XiIc/uSDTIzPTcphDYQNWtVdvw3Yx3OITWvQIcdEqxPGBK2ICa7iMi
	3IXWj8SvH0OEF9nA8G1coB78ABv4iy09uH4+mPJEqqOFQFNQIy8mfyzLD0N2BQ+KlyHtWqP4ixu
	pEJY9s6Z6yQCXjmBTLi1m5Cfg=
X-Google-Smtp-Source: AGHT+IH0BjuvaA5viZ+OWbEEkQERqLhKzGcP5Kn0KUqxKXxImmXjbveExVU5QFyUBAqvyYVzJR7WmA==
X-Received: by 2002:a17:902:f78b:b0:290:ab61:6a5e with SMTP id d9443c01a7336-290c9ce0ad2mr206036055ad.27.1761046671460;
        Tue, 21 Oct 2025 04:37:51 -0700 (PDT)
Received: from power-ThinkBook-15-G2-ITL.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5874sm107138825ad.54.2025.10.21.04.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 04:37:51 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	pavel@kernel.org,
	lenb@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v5 2/3] PM: hibernate: make compression threads configurable
Date: Tue, 21 Oct 2025 19:37:27 +0800
Message-ID: <f24b3ca6416e230a515a154ed4c121d72a7e05a6.1761046167.git.luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1761046167.git.luoxueqin@kylinos.cn>
References: <cover.1761046167.git.luoxueqin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The number of compression/decompression threads has a direct impact on
hibernate image generation and resume latency. Using more threads can
reduce overall resume time, but on systems with fewer CPU cores it may
also introduce contention and reduce efficiency.

Performance was evaluated on an 8-core ARM system, averaged over 10 runs:

    Threads  Hibernate(s)  Resume(s)
    --------------------------------
       3         12.14       18.86
       4         12.28       17.48
       5         11.09       16.77
       6         11.08       16.44

With 5–6 threads, resume latency improves by approximately 12% compared
to the default 3-thread configuration, with negligible impact on
hibernate time.

Introduce a new kernel parameter `hibernate_compression_threads=` that
allows users and integrators to tune the number of
compression/decompression threads at boot. This provides a way to
balance performance and CPU utilization across a wide range of hardware
without recompiling the kernel.

Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---
 .../admin-guide/kernel-parameters.txt         | 10 ++++++++
 kernel/power/swap.c                           | 25 ++++++++++++++++---
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index db84a629f7b1..fb577fb2c893 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1889,6 +1889,16 @@
 			/sys/power/pm_test). Only available when CONFIG_PM_DEBUG
 			is set. Default value is 5.
 
+	hibernate_compression_threads=
+			[HIBERNATION]
+			Set the number of threads used for compressing or decompressing
+			hibernation images.
+
+			Format: <integer>
+			Default: 3
+			Minimum: 1
+			Example: hibernate_compression_threads=4
+
 	highmem=nn[KMG]	[KNL,BOOT,EARLY] forces the highmem zone to have an exact
 			size of <nn>. This works even on boxes that have no
 			highmem otherwise. This also works to reduce highmem
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index f8c13f5672ec..aa11576e92a9 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -519,8 +519,9 @@ static int swap_writer_finish(struct swap_map_handle *handle,
 				CMP_HEADER, PAGE_SIZE)
 #define CMP_SIZE	(CMP_PAGES * PAGE_SIZE)
 
-/* Maximum number of threads for compression/decompression. */
-#define CMP_THREADS	3
+/* Default number of threads for compression/decompression. */
+#define CMP_THREADS    3
+static unsigned int hibernate_compression_threads = CMP_THREADS;
 
 /* Minimum/maximum number of pages for read buffering. */
 #define CMP_MIN_RD_PAGES	1024
@@ -741,7 +742,7 @@ static int save_compressed_image(struct swap_map_handle *handle,
 	 * footprint.
 	 */
 	nr_threads = num_online_cpus() - 1;
-	nr_threads = clamp_val(nr_threads, 1, CMP_THREADS);
+	nr_threads = clamp_val(nr_threads, 1, hibernate_compression_threads);
 
 	page = (void *)__get_free_page(GFP_NOIO | __GFP_HIGH);
 	if (!page) {
@@ -1257,7 +1258,7 @@ static int load_compressed_image(struct swap_map_handle *handle,
 	 * footprint.
 	 */
 	nr_threads = num_online_cpus() - 1;
-	nr_threads = clamp_val(nr_threads, 1, CMP_THREADS);
+	nr_threads = clamp_val(nr_threads, 1, hibernate_compression_threads);
 
 	page = vmalloc_array(CMP_MAX_RD_PAGES, sizeof(*page));
 	if (!page) {
@@ -1697,3 +1698,19 @@ static int __init swsusp_header_init(void)
 }
 
 core_initcall(swsusp_header_init);
+
+static int __init hibernate_compression_threads_setup(char *str)
+{
+	int rc = kstrtouint(str, 0, &hibernate_compression_threads);
+
+	if (rc)
+		return rc;
+
+	if (hibernate_compression_threads < 1)
+		hibernate_compression_threads = CMP_THREADS;
+
+	return 1;
+
+}
+
+__setup("hibernate_compression_threads=", hibernate_compression_threads_setup);
-- 
2.43.0


