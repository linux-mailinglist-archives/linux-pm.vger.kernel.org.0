Return-Path: <linux-pm+bounces-35236-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCF8B969A6
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 17:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B99B04826AF
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 15:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37DF26FA6E;
	Tue, 23 Sep 2025 15:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BYWNwon6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BBF1A9F99
	for <linux-pm@vger.kernel.org>; Tue, 23 Sep 2025 15:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758641523; cv=none; b=MgXkDeaTZGxU7omH7YvjpOLsBvrw2uOp1R7PaQr9Pbep2eBYJY0z1NvZ24KGQwByqiHJJryfz+FZSPQiR/eNoK4oPuBcRHUuZ7RzUem13V4p1IcUAIclaAS5ubIevcp2E+2I4DzOgjg+y/2j/dIQWXqgxenySH+J72FS2PwqLu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758641523; c=relaxed/simple;
	bh=1YwZpHexCtqP9eAf1fTZ1LlVtJXXtxJcq5y9B0el7Vs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UAgL6LvxUgJ8dG/VTjqY7mesnQvYRcKQkBJS5wjeQJbslN6q+Kh07FwTunD36sFKqQK7PnAwGnWKumB8oNYGf1ZLsy8RwWQRSEaQnx6VaY8JHIpS24/sRpGa2PGqVREi6W+yVZswrXCrQufSEacsPPRzzKnkQbZTVY45RezFo3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BYWNwon6; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-7970e8d1cfeso61421436d6.1
        for <linux-pm@vger.kernel.org>; Tue, 23 Sep 2025 08:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758641521; x=1759246321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ST/TiPE3UoG2aOPw0mJW/QZGPve3OqLp6tKuBIFjGhc=;
        b=BYWNwon6jAWJfaFUXukhsjTj/U055EoAAsEkT79ezCrnhy/urtfvlMapmatUiYti1B
         8jT8GZEot1DN1BroiiRe6beQcok16LWQVu4CtVoEGTJcrwW/lBc9grn4SZ9kdyP54LqV
         aebDVOQJ6FNc/8kn6Pb3M4lbuTLiInl0CbWiSZYxLFz/ziPkKpa9YX449DrURMynGvfc
         tz+Yv1FWC5WFzok1s1tQ1Cq/BosX4YacmL9HK8S7hMKy3tLCaoSv36W8KVTBdXPThfnQ
         7kwejeaT3QAjVekKSVAS4ziyzoeOnwNBedebuXKMzvQF7jah9O/1yKIVktXgvEz5i4aE
         X60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758641521; x=1759246321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ST/TiPE3UoG2aOPw0mJW/QZGPve3OqLp6tKuBIFjGhc=;
        b=V+kwxPe14htk98AmFAt3AO1fR8KmdrQz2l93HV1H18trQIj83GqPHdO0H4GHT8vTIZ
         crZqUUg/QyxjYoX6Neuyw2DHA/+NKXX6nWUs2uaVxMp0urJdKhceC38qJIc26PSQslPo
         3PiS7MIfFArQt/jHMdkp2C1iGS1DrgtNBK5xyRTTJpg1QQ5vOyK2hZf5Ra9lyL1uMNjb
         8DzKN1qmWHdd3GlROgVoB7nTDD6wR5u/Kld2fyoZCrR3eUMRJ7sGmfEOR0wQ1wQ0tAmd
         YD3MSw3NdgiuCThaSeJ4zFnAWCb4Bp2gKFUOLLRlZxCXxSdT87RwT0F+SjX1uH3xWecX
         yl9g==
X-Forwarded-Encrypted: i=1; AJvYcCVxXp/g3dD6yvCYjijSLS2JJjQCTFsR2AQzq0fgI2Q2yXw2IAn7lxahgc0DryQsUCyrotkffbrm2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEFI1caruamNxc5B/g+BWd2TcNsXsyVDXagAlwePRYFWzBdrAd
	4CvoUsNKvp6lA1JkAez0WxeNB1qo17MbbjBiSNOuvcKWSFRhq3/dW0g/pUnn4vUj9sc=
X-Gm-Gg: ASbGncuQQfoczpPApbaChgCBeEmiMpG2gJx6DH6JndbEhuindiZWnyfO+bwNWbMdydn
	vVWOON0Ntl8VDJ/l/i8eZX940tfSkW/z37cONd114W2D915wP+KF8RaMQlt0YYr+hOk1nwuQJ8U
	LibjvUUo/eUKMrNHkdf6IFuP0DYlWnwYOw/ieZxyCcB3v+qzPOjj3u5FEUTfbMSGNj3to/izx9L
	kEYHh8nu52ZUvrjcy9tqFk8GDmtzD4QqT4H9kPDNS+xXBwWMNt+qEMBtAZEmkjzam+ZLF1hggbm
	7D1mDsPAVJtCdh84XTLKKgqA+B2hzBWWtPgydNOxupLiQ9Jxf95U0b0vzNBY39095sQcqiJO4id
	ryaOlHDPXwRfOsW1obSQovsEWemcmIg==
X-Google-Smtp-Source: AGHT+IEvanVRKTjJIXXUzM6LDTiGRKMr5d0J8UNTnUv1MjeOEx7kiAqkICaVyGwRNy1LTn6CuXzPng==
X-Received: by 2002:a05:6214:202e:b0:791:c933:ad45 with SMTP id 6a1803df08f44-7e7145081f1mr33486566d6.37.1758641520758;
        Tue, 23 Sep 2025 08:32:00 -0700 (PDT)
Received: from localhost ([79.173.157.19])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7b6a2fa0c5esm50177486d6.66.2025.09.23.08.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 08:32:00 -0700 (PDT)
From: Fam Zheng <fam.zheng@bytedance.com>
To: linux-kernel@vger.kernel.org
Cc: Lukasz Luba <lukasz.luba@arm.com>,
	linyongting@bytedance.com,
	songmuchun@bytedance.com,
	satish.kumar@bytedance.com,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	yuanzhu@bytedance.com,
	Ingo Molnar <mingo@redhat.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	fam.zheng@bytedance.com,
	Zhang Rui <rui.zhang@intel.com>,
	fam@euphon.net,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	liangma@bytedance.com,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	guojinhui.liam@bytedance.com,
	linux-pm@vger.kernel.org,
	Thom Hughes <thom.hughes@bytedance.com>
Subject: [RFC 5/5] x86/apic: Make Parker instance use physical APIC
Date: Tue, 23 Sep 2025 15:31:46 +0000
Message-Id: <20250923153146.365015-6-fam.zheng@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250923153146.365015-1-fam.zheng@bytedance.com>
References: <20250923153146.365015-1-fam.zheng@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thom Hughes <thom.hughes@bytedance.com>

Signed-off-by: Thom Hughes <thom.hughes@bytedance.com>
Signed-off-by: Fam Zheng <fam.zheng@bytedance.com>
---
 arch/x86/kernel/apic/apic_flat_64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index e0308d8c4e6c..e753125a1de8 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -9,6 +9,7 @@
  * James Cleverdon.
  */
 #include <linux/export.h>
+#include <linux/parker.h>
 
 #include <asm/apic.h>
 
@@ -21,7 +22,7 @@ static u32 physflat_get_apic_id(u32 x)
 
 static int physflat_probe(void)
 {
-	return 1;
+	return is_parker_instance();
 }
 
 static int physflat_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
-- 
2.39.5


