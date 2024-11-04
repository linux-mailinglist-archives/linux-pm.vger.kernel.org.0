Return-Path: <linux-pm+bounces-16967-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9BF9BB8E6
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 16:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE7F5B24295
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 15:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044F71C07DD;
	Mon,  4 Nov 2024 15:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gp2OzF0U"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C29A1B6CF9
	for <linux-pm@vger.kernel.org>; Mon,  4 Nov 2024 15:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730733866; cv=none; b=cM2kU/isUcQkVMlk9MOArl16vsQOkksrrun2nBy1ok8xNNpAdnHAS5K6Z9l2LEHV7TMm2jxrfzcKccKXyo7JebtkCRgDyzxnPeAU0WOOo2cIWFm/zrgPRiAnlN8GE2hAAD7V01mVfJWn3dY6hsDjqUg0qt7QTR4EKuI4cvIZBmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730733866; c=relaxed/simple;
	bh=F+Rkt6DFKWyeAzf1fsIGO9wOASAOwTVg+r45q4FvosM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NVeBO5PvGG+rK7FOVlYakLb7FTn4hvwxc7nC0ujRUSEOdry0gN3elYZWcMydQbtsupYNFM/4NPz3T1PMEyneOjioqjmslhDP5AAxXTwMBTmWOg7RV5z0j9PAUlv5U9IGEBmB+TrsUM9xHgCZNiNV87jZdzJy19fkRYA44tCCMC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gp2OzF0U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730733864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ceEKqnPRXD8WryuQq49T4d3l3F+Nw1UqjWpRO1N6dKs=;
	b=Gp2OzF0UZ08vVeRxYwVTeyTo4jRkgbr6+4QKTLrDYYdHGbpnZLlh/F7jpGMMbJrryJx544
	dhwh3oupI/LxbNGfMC2kmhQTdB6Wm/5YwyZ44K2mEDfanCIIv9IAOEBrNfCQcJoNwfraJX
	7+PEptstqoPetmPQxmyjZSD3A9G9Ins=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-uftNiAsaNoCNVFZf6Cgu7w-1; Mon, 04 Nov 2024 10:24:23 -0500
X-MC-Unique: uftNiAsaNoCNVFZf6Cgu7w-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-28861cecac4so2823889fac.1
        for <linux-pm@vger.kernel.org>; Mon, 04 Nov 2024 07:24:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730733862; x=1731338662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ceEKqnPRXD8WryuQq49T4d3l3F+Nw1UqjWpRO1N6dKs=;
        b=aucgcYKIHPrcNQIMX05kfCiUC9V6OWU/CVYqKsNZ3gjd9MYea7T2+gqEIYpN6riErm
         J8kkSPNip7dHTGhIlDkiUvwNFGpNXQ6x5KpwRGR5HGtm1KAS/WiM26B6bmadlMqlIE4v
         Qc7i201xkElAXBhz0hSK0xO0Z0Nvxx7bEubwoyVtLsRd+N2mc5pSax8Wo31ZGmteWvRZ
         bDRQIoHGZhHSn8KtniRExdNSwOiIQXfVVdOK9QgMAhjQ0YO6xh5W5hQYnM5Tx0BqkTmn
         0IaPyATjCm6I5233gb19XMY72frrsShmwD7hvnB5vDmH2ve47V7+D+lpkUMxFzaQV4o0
         lpdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWIoUOkZxSrUXDYaB9R6lkVueKZ9cCqjvwu69qrwNR5K9t8Z3jrKXQALFTeulOqa5rE51AZqZLMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVx4VG9yAMXr/EGPAYhZwjpS/C4oQlaCGXrhqS/dgPRWyQXUYX
	kyDyM5/tSLO5J8b3QjUIvBwl+7OmNAGIbKinXK9UZ0+scOfVk6oK72uQt5V6VM2/3VwOhSeKriI
	8agkt71Aa5vnXO5VYOfNjV/Ax58X9azhUgAk8QRPAJL2dTH4LaYBRRU45
X-Received: by 2002:a05:6871:c707:b0:28f:329e:9f23 with SMTP id 586e51a60fabf-2949f07cb9emr10704045fac.42.1730733862286;
        Mon, 04 Nov 2024 07:24:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgILSpblRLX3xBlUuGr2b/jMwLrVJNb7cVTeCUzdn+sJSfeFxcwKwVgNsQOBNH1k8z3UQ7vA==
X-Received: by 2002:a05:6871:c707:b0:28f:329e:9f23 with SMTP id 586e51a60fabf-2949f07cb9emr10704015fac.42.1730733861968;
        Mon, 04 Nov 2024 07:24:21 -0800 (PST)
Received: from rhdev.redhat.com (2603-9001-3d00-5353-0000-0000-0000-14c1.inf6.spectrum.com. [2603:9001:3d00:5353::14c1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7189cc59b45sm1980847a34.6.2024.11.04.07.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 07:24:21 -0800 (PST)
From: Jennifer Berringer <jberring@redhat.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Maxime Ripard <mripard@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Jennifer Berringer <jberring@redhat.com>
Subject: [PATCH v3 0/3] nvmem: fix out-of-bounds reboot-mode write
Date: Mon,  4 Nov 2024 10:23:09 -0500
Message-ID: <20241104152312.3813601-1-jberring@redhat.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

These patches fix a small out-of-bounds write when using the
nvmem-reboot-mode driver on Qualcomm SA8775P, such as by executing
"reboot bootloader" in a shell. Relevant error log:

  BUG: KASAN: slab-out-of-bounds in nvmem_cell_prepare_write_buffer+0x144/0x47c
  Write of size 4 at addr ffff19dd8e1a37a0 by task systemd-shutdow/1
  Hardware name: Qualcomm SA8775P Ride (DT)
  Call trace:
  nvmem_cell_prepare_write_buffer
  nvmem_cell_write
  nvmem_reboot_mode_write
  The buggy address is located 0 bytes inside of
   allocated 1-byte region

This problem manifested because the devicetree file sa8775p-pmics.dtsi
specifies its reboot-mode cell with "reg = <0x48 0x1>" and so expects
the reboot mode write to only be 1 byte rather than 4. Other in-tree
devicetrees that seem likely affected include pmk8350 and pmk8550.

These changes add the missing bounds check to nvmem_cell_write and make
nvmem-reboot-mode able to only write as many bytes as it needs to.

v2:
- Added missing function definition for CONFIG_NVMEM=n

v3:
- Accepted suggestion for changing nvmem_cell_write bounds check

---
Jennifer Berringer (3):
  nvmem: core: improve range check for nvmem_cell_write()
  nvmem: core: add nvmem_cell_write_variable_u32()
  power: reset: nvmem-reboot-mode: fix write for small cells

 drivers/nvmem/core.c                    | 26 +++++++++++++++++++++++++
 drivers/power/reset/nvmem-reboot-mode.c |  2 +-
 include/linux/nvmem-consumer.h          |  6 ++++++
 3 files changed, 33 insertions(+), 1 deletion(-)


base-commit: 98f7e32f20d28ec452afb208f9cffc08448a2652
-- 
2.46.2


