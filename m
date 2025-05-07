Return-Path: <linux-pm+bounces-26828-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB2BAAE60B
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 18:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C66B3ADC5F
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 16:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE5828C856;
	Wed,  7 May 2025 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hbm9vQil"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939D828C860;
	Wed,  7 May 2025 16:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746633724; cv=none; b=h2wECPe4rqYLtCSYWL1tGGaOFFysSSIX0fpwPrlE/BwurzTeo8w8WH6dJKCZ7JFRmpjMFgtHKBGI3aNzgGhUn4X2L0LKhSSPQRcy08u6pinsqfvbiiQGPhYjCCALZB7L2sk+x/nk/kJmU8+c1rbudfMJFiy8cSwlQXCEFillbH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746633724; c=relaxed/simple;
	bh=cTjBmIVvQ5tleYSwTnurFm1RmNLCa4KLJfhfwkC+sdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sZw5qH+z0wxtwJPW0Eux/ful0fWddDJe3y4WZWNjEDTH4rGxEILt95laPns6gGwWqV/vkQcfjtvTiXj2/sIj6UJd4BDlfk6eUTFTy0y7bDVWSdm2E+ye5AdjR4I1Wks+K6jLDqMOS+QA0LWsZSQdhNl1IDXOcvWPlBEcgzWQvAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hbm9vQil; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-af59c920d32so4763524a12.0;
        Wed, 07 May 2025 09:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746633722; x=1747238522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RO45tkjbLYjYtv/CvK6w8KfE5OYOXfvwguuZ43NCctQ=;
        b=Hbm9vQilPEa+VlB/pvMaWXSKs+pzefdn789bdlQoPrynftgAi882rRgKvfGxzSPIzf
         YAi4MoEpR+ivUAjJhlS1I74IP/Z7vSkxVYRqmckM6p/gZ/mMwqW1fX4VlNL3rqfmx503
         8iNLLblGSG1YbD30Mra+SQDRAaK+aO9rjjGKj0u/4OcoBfqT5mvZmWQw3rbKto71ZXec
         ERv+hZD3IvnVt7ifUpr7JZF85Al9E5CrUV2BqVKSX/Nvt8iOlzdkcTiFhMzgiCWmVY21
         IK9GkjaFGaefdGkgkFEBpQwscfvzpxM1RBe+SILiadSgG8FwERpw19Sw10Ea3AIDymnP
         +DLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746633722; x=1747238522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RO45tkjbLYjYtv/CvK6w8KfE5OYOXfvwguuZ43NCctQ=;
        b=vTbZ+Cqs40syhEgEztERuCEeZ+NAR5uk9JZ+z41/FOug82xjSyLeT8D47f+kZAVtr8
         6wzLPiq61l0qMyO2K0MVcUlaefLu363TeW8ymu2NPMu14lUbA/IpgFTiV4ltPQdrnf9t
         xNI7u+5Vfsgb4F8aRhQqz+X/oicHDxUFnJDzoEK+TkGNja9s5zAnQtF/CKwozmbnDNSY
         IND6WFOSneaJSASBiuFSnb/APf8YsVbeek5bLWn80rLDdnF9AMcZGBulcrUiWkE0t1Jp
         /jFbRtNiDChmegkdPCV9U1TaSjXbPJNhNIuEz2lEf6kmzHJnfCJd8lCD+NF0ncVZLtz6
         co2g==
X-Forwarded-Encrypted: i=1; AJvYcCUp7fQQKcTqe27QihimGBdKBwbLaLOjskPWHkSjQl3Lc+pQhK3mvvk1i+C7KvOETIW0A5TCRe1148M=@vger.kernel.org, AJvYcCXFo6jtnvs89xoUG2yNXGq2iYZjwRAM1834e6m8hhiNQUyjb+dKYxmjxFLqRDSg716qHA1xl0JLd9BU2dA=@vger.kernel.org, AJvYcCXqF9zIFxhnZVKAZwvKUovw6dEbrroPyzKA385kORN+UxWgrwutGkITQj6QMpgUX0zJx8zeJlMgVVNdwTiDDncvVw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl1FowFeZvFig1ylXOccWV1EeDK/08M5U2Pf6IJY0NLlIO7pjQ
	ra+LoRTS6ggGFmAX6eqLLqUZJVsKweiFK6TU/WHlbZDNj9caxwFV
X-Gm-Gg: ASbGnctStF0o6MMH3I5iIf7NU8rosjyUKRDAAPF4mwUsv89hwjiaH9eni3yC9FWQWdg
	8aEdAo+p01OXaKWKxKhbF0AfsB9/NuReNvIBxHbHjZhUhbDJMDyHl6WnxRVSm3+bNduc7AQIZHG
	WwVefI+PSTuhgMNFAWP+SFGDQMnmLl4ywqz9Brb5LdKKaTvafYnV1EIW70zRZrDpE8Kgktf6XsS
	g9y8dPZgScvOQbn07IuWm71vk+1idlYs8G38jTgvlC6T0QL3ipxjBhAh3mV30FTysuTQ4YDOLZQ
	MLO08p4/pHNV/ERuiSd1s2Vbdn8+n0wTOwyPsg5tefihtdb+WYylQMBM5gK2JbM=
X-Google-Smtp-Source: AGHT+IEmJOhnycByNLVKMR/CtrELFdJfDJP1ErBRH92r56MtV1Kyb3oVdVNaoaxWV8fLKFKyiXWbdQ==
X-Received: by 2002:a17:90b:554e:b0:2ff:6e72:b8e9 with SMTP id 98e67ed59e1d1-30aac2837bcmr6500291a91.25.1746633721722;
        Wed, 07 May 2025 09:02:01 -0700 (PDT)
Received: from hiagof-nb.corp.toradex.com ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30ad4f82b86sm327242a91.44.2025.05.07.09.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 09:02:01 -0700 (PDT)
From: Hiago De Franco <hiagofranco@gmail.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Hiago De Franco <hiago.franco@toradex.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@oss.nxp.com>,
	daniel.baluta@nxp.com,
	iuliana.prodan@oss.nxp.com,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2 3/3] remoteproc: imx_rproc: add power mode check for remote core attachment
Date: Wed,  7 May 2025 13:00:56 -0300
Message-Id: <20250507160056.11876-4-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250507160056.11876-1-hiagofranco@gmail.com>
References: <20250507160056.11876-1-hiagofranco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hiago De Franco <hiago.franco@toradex.com>

When the remote core is started before Linux boots (e.g., by the
bootloader), the driver currently is not able to attach because it only
checks for cores running in different partitions. If the core was kicked
by the bootloader, it is in the same partition as Linux and it is
already up and running.

This adds power mode verification through the SCU interface, enabling
the driver to detect when the remote core is already running and
properly attach to it.

Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
Suggested-by: Peng Fan <peng.fan@nxp.com>
---
v2: Dropped unecessary include. Removed the imx_rproc_is_on function, as
suggested.
---
 drivers/remoteproc/imx_rproc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 627e57a88db2..9b6e9e41b7fc 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -949,6 +949,19 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
 			if (of_property_read_u32(dev->of_node, "fsl,entry-address", &priv->entry))
 				return -EINVAL;
 
+			/*
+			 * If remote core is already running (e.g. kicked by
+			 * the bootloader), attach to it.
+			 */
+			ret = imx_sc_pm_get_resource_power_mode(priv->ipc_handle,
+								priv->rsrc_id);
+			if (ret < 0)
+				dev_err(dev, "failed to get power resource %d mode, ret %d\n",
+					priv->rsrc_id, ret);
+
+			if (ret == IMX_SC_PM_PW_MODE_ON)
+				priv->rproc->state = RPROC_DETACHED;
+
 			return imx_rproc_attach_pd(priv);
 		}
 
-- 
2.39.5


