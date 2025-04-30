Return-Path: <linux-pm+bounces-26436-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 275BAAA42C3
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 07:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CF9B4C0F92
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 05:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C6E1E0E1A;
	Wed, 30 Apr 2025 05:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqFYFZSb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088847FBA2;
	Wed, 30 Apr 2025 05:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745992702; cv=none; b=SjID2dh3fWEzKHiV9Tsa8UpwEumzwtraqTWyV/SLvOW6tKACQsiKM5lYRDLkRsyvtCOYCvodysY57OylqLis9ab7EhPRf0/neO7xDtJNIUR5knjjVAs7q6Cr0WG+M4shZpnmFxc3ELqLGl/1fBeItCLNdDwY0kbFKCS81oy1imw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745992702; c=relaxed/simple;
	bh=ohfi0HqJzhAtGpVR6EnVIzSbyLCb+8C/x27UYL+bpmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dp7+4LD66C17S+I60TdL5Uqaxkz5s0lLrrvX19cE52KruHLbGaKOO86CfOjbfHqx0O4qNBRMuG//WnzVUh4E7ExZkFBlmc6KiHkm5GPTsYrIKUqG/cr7EVPSAl8v2VgZEjMKi7qD5PDLDckS12dSCCrl34gE0l0Th59707RM2qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqFYFZSb; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac339f53df9so1326902766b.1;
        Tue, 29 Apr 2025 22:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745992699; x=1746597499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5qWfhUQvd7EuaFksqXbpSrvG1yXtKPy9RHczOGQWZB0=;
        b=CqFYFZSbqeHUQArqIl8Y2ghvPTIqBzwcr7km8lSxu9TOMIaX5ITZ6EztEcl1Cixm7D
         BDelYVxi/CCj1ZtJeODMQRm93Vy/FiPX3LHKo7yDldxN5HDC8PtWLZJBahtxoEugnpZo
         ogrprPSKTFfKSqpZLG1U/CdSyete48/+4svgHA8/PvmiyZHUVrFGGttgTsLUTs9Rt9I7
         y0UaIBWXTiSX8qb7yzNdPvAvF4Vlwz0lQd1HaMk5748dqupMs7mPlpKSo+960LTTXey5
         XS5V9yh4u3z4u+UI5SQBlrMYxNirt/MRoriKrJVEIJDCFviv7QbyVLK41uUzvsfQOpsP
         X3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745992699; x=1746597499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5qWfhUQvd7EuaFksqXbpSrvG1yXtKPy9RHczOGQWZB0=;
        b=JPoHVid+KSNzVsz5qoPqv70RaEaXQNOKzMZsxEOUqUrBUe+480FPQxTkDtIkMdJj7M
         yQFwaPIjf1BIyDZy6DYumqcGEU6yyDZApC1dV9g/gGhUBtHOuN0OAbvXBkB9aEklJzsW
         XXECJbWkN1qcTft8Ld9kVt+Ulm1thNjgvUArz+gpJPIPCPZckzVOyoBfS3bkp+fkB1WE
         Sbt3LfWGq4YAWiDqyhHKReOGxQtsT+X+XQtGt4UzIwMOV8hIi69hA114vt4Dkq833WPe
         NBB7AFYWkTJ48BjMRZkmcIbZtbCpw4831Z0N1VS8nLkd949TcnsyFkQpOJ6HFnQrnXNV
         PWYg==
X-Forwarded-Encrypted: i=1; AJvYcCV3MW7hE3ByEkb1KWmJCu+jJlVtqP3hnKnR4Rnum7UzHD67DrfRwYNk4mnpRMtsf1VZfeJ07HXruahSYJZx@vger.kernel.org, AJvYcCV9g8n17dJFMj2fN3wF0E1U5+zVe3XkS/05k6DNDq1EwJK2LJ2WVzDesMTqY/FejEH3SmvZshb1N6pN@vger.kernel.org
X-Gm-Message-State: AOJu0YwKpBig7A6SvNsR8dYCbA+j4gnWvfetvtWi7rFN3q6jiC/0Jp7f
	F3RCkcc+fhBPbgYcsKJ2fYBONRx9YQtZU8p4NVkWwk07gTLrs933
X-Gm-Gg: ASbGnctqxBm78efC5W0L03bfjo07dWeavuNU0pOlfANVVZFWUgTfACyaoayu3La/INS
	ZukqTpaBGsexQ2yWX1oLiBXuMOC2ZxTv0+DrmVQvKr1ZsVkyLey55EjKHM2QR0/quD2yacrF+jB
	ZVH9P3KVJXZ4ip089qd3nRswMd2sPceAXyX/wLHMN403CINdkTHXvetwLiw7WAtpC2p6e/eBo9n
	jAtiPavFrBvvq51Qv2qnYQ+gXfCSQXuTHfKlxBWRghA64EAh6fUkjk2yGQyp2wSsop25wHo9EBJ
	QNDgFg0r8qambH/6nAcc7xGu6HASnl30
X-Google-Smtp-Source: AGHT+IEZJo2gt5oVrtm7vWQ+wxAYvFyT4LXjM3xpP0Ic2lyy+zgDLtip/AuYurxnEoSle+ios2/yrA==
X-Received: by 2002:a17:907:6d15:b0:acb:4cd7:2963 with SMTP id a640c23a62f3a-acee241c417mr132058066b.33.1745992699058;
        Tue, 29 Apr 2025 22:58:19 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e41c71csm883134066b.4.2025.04.29.22.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 22:58:18 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/1] thermal: thermal-generic-adc: add temp sensor function
Date: Wed, 30 Apr 2025 08:58:06 +0300
Message-ID: <20250430055807.11805-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To avoid duplicating sensor functionality and conversion tables, this
design allows converting an ADC IIO channel's output directly into a
temperature IIO channel. This is particularly useful for devices where
hwmon isn't suitable or where temperature data must be accessible through
IIO.

One such device is, for example, the MAX17040 fuel gauge.

---
Changes on switching from v4 to v5:
- switched back to IIO_CHAN_INFO_PROCESSED
- dropped schema commit
- applied Jonathan Cameron code improvement suggestions

Changes on switching from v3 to v4:
- switch to use of RAW and SCALED channels to provide more accurate data

Changes on switching from v2 to v3:
- rephrased commit headers

Changes on switching from v1 to v2:
- documented #iio-channel-cells property
- switched to IIO_CHAN_INFO_PROCESSED
---

Svyatoslav Ryhel (1):
  thermal: thermal-generic-adc: add temperature sensor channel

 drivers/thermal/thermal-generic-adc.c | 55 ++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

-- 
2.48.1


