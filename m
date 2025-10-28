Return-Path: <linux-pm+bounces-36939-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E64A1C12BB6
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 04:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 20FFF4EB68C
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 03:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCB2224234;
	Tue, 28 Oct 2025 03:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lv9fGlCp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15696158874
	for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2025 03:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761621401; cv=none; b=KLcr0nljI5PSuAWtkc2gIBIbphrK+AtVzZqRIKjV8P213Pl6zoOsgdn77ZJB4UhnIoDBQqGZHatxj3oZpNtw2CdS8kB7uwvUQQnoRwanlfag6zBfLHCFJ3PYyv8cQWycvNV7UkhMjxmZmJfM+ol8oX6J32akBUPU7bb+gOW3U8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761621401; c=relaxed/simple;
	bh=cHHkD30AaxNGfUjFD9KtWlH0G5zDyjXDYQiWrVKJSIE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QPXLd+ntTmRvM4VDCK0QTS9dRqEFZA59yNWROTPkNsB+/iPoszz4dmSi5FNqLiOUimNGBCzJpTTB+txm0xO8mv5dCBFyZ3I6epy/aLWJYwMbwJpb4e4ikmW28Y+IOLEtZPeb3acq8QAnKVVxYccViOOZroXx/qb5foD+pJQg1NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lv9fGlCp; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77f67ba775aso6792932b3a.3
        for <linux-pm@vger.kernel.org>; Mon, 27 Oct 2025 20:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761621399; x=1762226199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q7Dr88n0rsMeY0SbLXIpFyJggBzx8goTlgYQ7zbZXXM=;
        b=Lv9fGlCpfXzsi6PkQ0jGtnCEf6t0rev5XwPG5y0I4hHwY/Y4ImeoGsil/3jeKiJygC
         ovZuqV4YvhZQrD3ILzoS/sMiLFwLBpjKd5Brcu6N9LJhbKXh9+O6bht+vOlRRIJ+znef
         JUR7wPR8aSUT/bbevN9Qi1Gb5PjPx81Y0UHNzXpnfEOqa/ttjrxHbVDY5qFc7ZQ9QL+Y
         zV1tWc410U4XxTdojpFIvWviPsiRIDuAC3qR+GSqOfMd23964ciyz41sI6upV07lTmDq
         xXcgEhhNLsS+id6X7A9yqhsnsOQ5GdoiKZkorcpVeDxgQ2IWQKFCZ843FlL/HlxoDH17
         AXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761621399; x=1762226199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7Dr88n0rsMeY0SbLXIpFyJggBzx8goTlgYQ7zbZXXM=;
        b=D3UTL5RWYFhO4OxGmUnDeZsn/kB82bOCAxYP/tWnQVFq/PDpKyMpfGZEFkvkIh9Vpw
         rWxJpCXlLbRYcMs53xEwSGPP4eCWfyMHu7NxYB8Bw8i8t6n6mVhR7kaiMBnFIKGsTxKP
         Fe9vF1Sy06k1bAcK+SU8jRgXy8H4oRiJumrCt1nzTB4peNpbYxzQnIF0JHbEJL5HtSCj
         DvyTvTqepLDpCeFzARi4KCogRiktLIM1cx+AijYcNPyfv08tc+9V5ZDOk6HTEbGzV15T
         MuOu/c89riFsfO8CwybwVZi7xbLGmGcMvUGdSdd4NH+j/t85/KqADIUaMkeUrJY4lLpu
         SsRA==
X-Forwarded-Encrypted: i=1; AJvYcCV+MXlQuveIrHu6i3vyfqSFtcovRvtDrRPs3KWNoiNBl5IQJ3LxHV0+pE0yunJTYiWUvbfft+N+Fg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdOpZ9OXaYf8GTDnN0BQg35UpMmUOV6J411sjnWLHq9dJWmMq4
	xoWjmTMSuv8PhBU52w08+md+M9BivcipRfyFrBqSprFmcT5SgSTkb7Aq
X-Gm-Gg: ASbGncvqDSYOKiSHtK4kv6M6mKoc7dwD5DxibdWEQhVFuaUvqOE5iYAVgDhAJ6PlHnF
	u1tf6OhIFjW03NgtHa9wIJBA0Z+tLwzNmb0OOKX9HR0W6pD6U2qY8mmcFY4Hk+k0rG1BHUP/Pfu
	hJdM60OX8kpVXGPL0NqvWsc/S+cdWB9R/+PApSc29zNQxS2TiivPRhf7ufPyl/osxCo7J1aZJ7b
	ACc61+ctngcqFPOL2baM2d4bVX+F3PQUJJszuK6ML8NgH+9dFr83+fZEq6cpOIKS5b5IPigHDvc
	M9Wy0lnfb0OTtvJ68AAZ04F1fJjbTr/hE/svFHVJ1fh21CB7GAN8kXfI8a5QVqq+pH0zuZk6eh2
	ZeJl/qeVVeFM+hm+dEfSKUWsx8Sq5KkMJGYyHuL6q4wTCFLNEeU062cNh+SX1ZDbHsEcl9N1FpB
	ehP+LfVZBl8W5upUgWPqtf1g==
X-Google-Smtp-Source: AGHT+IGeeElAGdz52QvzDON6TZ6X2VN+9KdN3tRsb9MvpzKrX+azsLuImQoCuSHnyIB4CWg/XHY7mQ==
X-Received: by 2002:a05:6a00:c8d:b0:7a2:6b48:5359 with SMTP id d2e1a72fcca58-7a441c46a7cmr2594121b3a.24.1761621399271;
        Mon, 27 Oct 2025 20:16:39 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7a41408c4dfsm9818276b3a.65.2025.10.27.20.16.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 20:16:38 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] soc: imx: gpc: fix reference count leak in imx_gpc_remove
Date: Tue, 28 Oct 2025 11:16:20 +0800
Message-Id: <20251028031623.43284-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_get_child_by_name() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: 721cabf6c660 ("soc: imx: move PGC handling to a new GPC driver")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/pmdomain/imx/gpc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
index 33991f3c6b55..a34b260274f7 100644
--- a/drivers/pmdomain/imx/gpc.c
+++ b/drivers/pmdomain/imx/gpc.c
@@ -536,6 +536,8 @@ static void imx_gpc_remove(struct platform_device *pdev)
 			return;
 		}
 	}
+
+	of_node_put(pgc_node);
 }
 
 static struct platform_driver imx_gpc_driver = {
-- 
2.39.5 (Apple Git-154)


