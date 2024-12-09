Return-Path: <linux-pm+bounces-18815-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F319E923B
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 12:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 875D6164C07
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 11:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A6A21C9FC;
	Mon,  9 Dec 2024 11:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiHGBSHX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9024721B1A8;
	Mon,  9 Dec 2024 11:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733743765; cv=none; b=Y7Z0Gzw7nKuQCUhxoGcbh7LLFNFLYy3HfrcIy422PtFvSkeihLNpLCff1Uvciln+yW7trot7FZAnyAYMuvEzOz5AVtwPAJlqsVnvr5KLu1Liuo/QCY07Tod13Wo6ZQbH2DrTtl9lmhyV4L9BK+78SHvtlCq/cyaFZEpVsdU7iBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733743765; c=relaxed/simple;
	bh=RPQPYzIUrIV7KUtwuEchVeJdACROjNk9ItK/nS5eUAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QM9jfwYDl3akMvcCyVA/URYPLkl+io060AiJNppVtTcDZp0A9pwxkDXYm0hGedLIKTE2tNhDGp6aoFQhAfZhR8HvyiDrGzPmXh2nEtdVLb9SU09DCaGdHZx3iPWcOW3aAa5fDrzru0QaYSJaBRVk0wIEACAcOeq10u7a58r8tfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IiHGBSHX; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa5ec8d6f64so498432766b.2;
        Mon, 09 Dec 2024 03:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733743762; x=1734348562; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TvEYgr/6tTPCr/J7KKhyXeJ8K6wnSFjt2RRmJPjvqmw=;
        b=IiHGBSHXZeqZG5fGBYC7WnKH+k8GJI7jCJrgitd+RqEDMw+htBnUBdBxNuVLnOB2cH
         6F2FojbDkIRb+v7PQc6LYlQF3uuPWl4OcfFIkj3pfvW4EDsVvVvSDFTaHZXLXeXDAe10
         MeWatLbzNgjqpdrMeM9XtHZU1h2F5i6WPWWsmYup+VXaLf36yKcr1RZ35iuZ9cwN/aTn
         ZfMoBDcn0xdPfLFV+khWl/bvtXXNaRGoo1qDIZCA1feeukeiarMu0lLtPPoyYQLEQvzu
         0DRleTN2az+GoDQmRLxzWcMOYeZG3IYKO7O0TI8rh9tdnmQN86VU9OWI+hPZG3eRKg5w
         2wuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733743762; x=1734348562;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TvEYgr/6tTPCr/J7KKhyXeJ8K6wnSFjt2RRmJPjvqmw=;
        b=Nfs9Sy3AFCcZbIVrkV+6Vv9oE102o4Pb2yZF19Nuf8m7hbxzEpkNvV30qVuYH2mg5r
         AG292+rZS2/NW1QSTk6FW4GULkx4bIkdJwnrryKxrRcE5ShfR99SPNOm6bo7hT5qrpcn
         bzaR5Ln8Jq5NLCELQ5UazGUMthAFY6m36BzPowgaCEsv4j6tYAoIehhWAsPFMYEUOkVb
         9QfE6b1Z41Bwh/5jn4MfMjdcHRDCUujdBbzn0l2ndvg+VT5JOJvZqq9tB6ZfpnMYrd99
         7dzzfLI8XW1CNsKUygcGuCjfzFYOzx80lIs/R4NH+YXUroLUZSpi3Igg1FcgrUIgXKVH
         pPsA==
X-Forwarded-Encrypted: i=1; AJvYcCU8tZ8CFWqGuI3qGPpSxOvulJNa4x7W7oeBxHkTWkrIv0FvyABSHJVLstrNXIIjGeVFCoZGxxB0JVSSwC0=@vger.kernel.org, AJvYcCUUxQELM2hncBfzhH7SKVrSPmf1HxIQPQSnZ8O6NmUtvWhtpEtVpLLCTkxEme4oKFM2FOaoK2vLRNGXD+SE@vger.kernel.org, AJvYcCWBf9sQRT922QyY85upPAlfSo5uoUdU5R9HucRAHEs2ra1Qx5QjOthUmbd7rQ59WOQzGiDe26UWGvPeXQ==@vger.kernel.org, AJvYcCXc7IgatTIwlsSHs8DH//VszY6PrHN/rDksY4SnYkrTQQfrrTURTAh4Acq2hYmze0K1XCIs2X357f2k@vger.kernel.org
X-Gm-Message-State: AOJu0YxSah42HcR0fXtYmyAVFq83PhOyNYZ2ambk0GUSMr2W4v2qFMcP
	JbjYvhnnf6qofW4UXiOG1tA+gIsEWNXVSG5052SL1+xSLzZRDP/v9KKKSQ==
X-Gm-Gg: ASbGnctx9UoiWvgi7WNi+tdbvhXz7ROq5WKx1b5wXOjZjjibw6aKZD1bc88/1xv7ZzQ
	uxcsuG2uUvykVFsilmA8hx/cMiQTWdySabvqN1oX2CPKGZ7wN+0E2mWsKivL6nh8zK+hvkiKWQA
	spdG1CAek6SdqkwUHJDw2YU33Z1O0sKLtRTLISf5rzkHL0t/U7IK/SCqM01MFsUPqK5nqnUGURh
	UY4ftwjiMOo7MTsM3idWYdVbMW/C+H32/5i9atJ1BVChZv5PAOP
X-Google-Smtp-Source: AGHT+IE4gs5bVGF4Efd0vXCuAIwDvwPQnzP/yWs8XUJERA8YDStoszTKI/POiU6VQYHF6KvSX+AP3g==
X-Received: by 2002:a05:6402:51c6:b0:5d0:d818:559d with SMTP id 4fb4d7f45d1cf-5d4185073dcmr540205a12.11.1733743761597;
        Mon, 09 Dec 2024 03:29:21 -0800 (PST)
Received: from [127.0.1.1] ([46.53.242.72])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d14b608faesm5980350a12.44.2024.12.09.03.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 03:29:20 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Mon, 09 Dec 2024 14:26:26 +0300
Subject: [PATCH v11 2/9] dt-bindings: power: supply: max17042: add max77705
 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-starqltechn_integration_upstream-v11-2-dc0598828e01@gmail.com>
References: <20241209-starqltechn_integration_upstream-v11-0-dc0598828e01@gmail.com>
In-Reply-To: <20241209-starqltechn_integration_upstream-v11-0-dc0598828e01@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733743755; l=797;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=RPQPYzIUrIV7KUtwuEchVeJdACROjNk9ItK/nS5eUAg=;
 b=PcsZPGM5ttfml/v9I7fKER3SlrhCh2gT+ei5fBdYIpBrF4vcT9i4xPdvVO1cEOoCcWjD4Q5/E
 j40ylz4qH2RD9xk3/Rt1PWRB59aAbSmNkA0tdyOyvDH/npspORKHkaw
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add max77705 fuel gauge support.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>

---
Changes in v10:
- keep alphabetical order
---
 Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
index 085e2504d0dc..14242de7fc08 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
@@ -19,6 +19,7 @@ properties:
       - maxim,max17047
       - maxim,max17050
       - maxim,max17055
+      - maxim,max77705-battery
       - maxim,max77849-battery
 
   reg:

-- 
2.39.5


