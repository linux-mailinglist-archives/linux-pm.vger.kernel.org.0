Return-Path: <linux-pm+bounces-16393-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E279AEAC5
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 17:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AE4C1C2210B
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 15:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789AF1F584D;
	Thu, 24 Oct 2024 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BEYlyY25"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2CD1EBFF9
	for <linux-pm@vger.kernel.org>; Thu, 24 Oct 2024 15:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729784484; cv=none; b=JPfhL28LVLLuDtojiUQsqmc1ePG3dcQ8x0pP/FCjL/sjCXZydNDOty05p9fza6Cc8kPowlWW/DlbcSDVIQIdNNubwpm9NvpW5xQqydah0Tph16lYPjCG3bcke1MsomQLBivTYx2FMni2fTuSFNDuBi/I+qgMSE+9djb8+PHbrQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729784484; c=relaxed/simple;
	bh=U0TAXwaw2C091NXMCj80258qYlQ0K16hZmywscTwtI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hU5C9VO8xoHvkj9iU/o1FhpAUPzwa2K5Vfw3V8kVwPHNl1cpQG4zKbHWQv4On2EHtD2oYamX4O44NG4WUpCxTRmOE/vGVmGciDQ9Gq6EKPFRDrr9GxTBvaKtQPXQpXOx5uei95In6QyDVcKxBLZk0tT8At8AmOKGlk7iYyScYH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BEYlyY25; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729784481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=++YfkOsXO2+CDpMSaSuskpa23+e1Njtxx79I5hnH+Eg=;
	b=BEYlyY25ILF6hup3CnZfg7ba8xa5Q6TTc9hXYloEs0wqjvkAAwo4IqfJUD1FZobP/ehxgH
	cLoQQl4hpkt8Ju9L5TS1wbIZmav0QAlSaAzWAuKmKD7e/8A0UDPUMIej/xL44qQU9SI5+9
	NT/FhCKcpBW0PjFn6W9XSwNbveQxYOM=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-36jW5Iq0NeKu1OJYP6tuIQ-1; Thu, 24 Oct 2024 11:41:18 -0400
X-MC-Unique: 36jW5Iq0NeKu1OJYP6tuIQ-1
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-84fee7916a9so380134241.2
        for <linux-pm@vger.kernel.org>; Thu, 24 Oct 2024 08:41:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729784478; x=1730389278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=++YfkOsXO2+CDpMSaSuskpa23+e1Njtxx79I5hnH+Eg=;
        b=ui1//l6b1lohrnlBhW79+6JkKsulhyn9dMUsHyUReDLlsYs/alZ8QxATBsCZH+xYg2
         sGx3hsash/AFFGjuURdy4wEOciW6JWjJlDeXXqlJSmomyAub3/gvtveULEAfDie0Ydnz
         CpHDX1Rr/4Ui036rdsTTUj0q9YaDq1gcmx6tNkcU+cm4B7skZnocV/FTaRK/8g75zF4+
         YMNFTwxFMpwKr1Yox5lxrtPeTiTbDx9DGjbRF80QwH6FFcF/s1ETXZUfaYurn96MObV/
         h1/cNvtGGud9IlBBXow66BKq0k3UbZnO8UMeiHuHoaXsaCvKnRd3twQ8yXFC2hC9vW8D
         WfAA==
X-Forwarded-Encrypted: i=1; AJvYcCV07RJXWXzB+CjqfvjKZltpjWpy104QpVO6JmygFKGTCgyZYyfTGOW6f+N0FdTLgWL2JIAWryhsFw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/2cZzr9SI73SjYkCFNWilKLULSbDnuXeLRkKeJD8MVgZW+1HA
	TIh7XoFjNw5y4E9ofuH5U+efO5JsaimeULflEtd05jY4OxHK1XA15JXgMPTDdFOKkeW5OoB38rb
	uJMIrRCvzGQH1Pocp4NAKlycPh9ERMWW06T+LIkzL23o0V5O0X4x/uPlt
X-Received: by 2002:a05:6122:2a41:b0:50c:eb10:9799 with SMTP id 71dfb90a1353d-50fd01c153cmr7348188e0c.1.1729784476440;
        Thu, 24 Oct 2024 08:41:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoJ6EvpnJEVgvhEDgGgh5rB3alEYEoS8ZcnaHUhBm/Xe0sAWSCfSx9iajRDJ7CmO6nqrndSg==
X-Received: by 2002:a05:6122:2a41:b0:50c:eb10:9799 with SMTP id 71dfb90a1353d-50fd01c153cmr7348162e0c.1.1729784476125;
        Thu, 24 Oct 2024 08:41:16 -0700 (PDT)
Received: from localhost.localdomain (2603-9001-3d00-5353-0000-0000-0000-14c1.inf6.spectrum.com. [2603:9001:3d00:5353::14c1])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-50e19f5fad0sm1364301e0c.40.2024.10.24.08.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 08:41:15 -0700 (PDT)
From: Jennifer Berringer <jberring@redhat.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Maxime Ripard <mripard@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Jennifer Berringer <jberring@redhat.com>
Subject: [PATCH v2 0/3] nvmem: fix out-of-bounds write
Date: Thu, 24 Oct 2024 11:40:47 -0400
Message-ID: <20241024154050.3245228-1-jberring@redhat.com>
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

---
Jennifer Berringer (3):
  nvmem: core: improve range check for nvmem_cell_write()
  nvmem: core: add nvmem_cell_write_variable_u32()
  power: reset: nvmem-reboot-mode: fix write for small cells

 drivers/nvmem/core.c                    | 31 +++++++++++++++++++++++--
 drivers/power/reset/nvmem-reboot-mode.c |  2 +-
 include/linux/nvmem-consumer.h          |  6 +++++
 3 files changed, 36 insertions(+), 3 deletions(-)


base-commit: 98f7e32f20d28ec452afb208f9cffc08448a2652
-- 
2.46.2


