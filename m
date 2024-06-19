Return-Path: <linux-pm+bounces-9543-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C63F390E3B3
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 08:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CD3A281A82
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 06:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6595B50280;
	Wed, 19 Jun 2024 06:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyyKF8IV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C8528EC;
	Wed, 19 Jun 2024 06:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718779636; cv=none; b=QJrWbdDP9mVrehPqZEjHLJrH6EXOchCczGgTnzclkwCC+5+1H7FyCz1i1oKEfkJHL4WWmyh9/55J5iarqqPbDkJDPGikPtVmgjb57UakR+Ta8xD/BztMPStpABziasIdd4bZGY9s5MfVUB1V2WtMcm71pw31rOMqlphVqIyJOe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718779636; c=relaxed/simple;
	bh=srGKh864x2DbhNTZC/7EyS4gUrjxJEbH7eiBgmhttPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ptQnxuf7sZWIIFw4UGPFM+f3lbss4a42pGDt3Oiwu88U8+eb+6IAXSfErvxJyv9myoOwD5J5FaNByZWJzb5YndfdVxeRuqY1CdG+GWqyas0gMdnx3SoyIwhS/Rgk/jH+sIY3HN7p11pGAwNwYlaucJPuL84doHqNZ4jm3ex0C8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyyKF8IV; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42179dafd6bso3298025e9.0;
        Tue, 18 Jun 2024 23:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718779633; x=1719384433; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8UU+lzhirtRVNhqfxK6sGBVX/W9FQtnxUGD6uQcT/9s=;
        b=iyyKF8IVAgMiUhW8e8W+hpn1faJdTuslUAckUapDy1/u+Zx/yabSEpVQTfMVCbFCdL
         Oe+kcn+kPyagJL6mjOAMFBc/ikCf41jG7pf41/Zv8drFxoFse58oZPwC/vuccqbC3uTC
         O85Ip6h+y8FtaYjWHdH4c5ztk995sBOV5daz6KxU9GJuA+uKFrcVuVtKmX/lWQhOwORQ
         r+RgJZrqpY8wYqrU8TV+Cys6I4wf7U5vk3aDA4p5zJP3iF6vC1VT2dV6kVOTtJEigpd1
         b7U9GdOzUIRdmehx14Ni/9Epk3Q6i9jpebyN5gSsKePtsOuNkZv0OJvuRFrk0XZvi1O+
         yhZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718779633; x=1719384433;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8UU+lzhirtRVNhqfxK6sGBVX/W9FQtnxUGD6uQcT/9s=;
        b=bqi1+hyKpO2n6Tc52FiiNmVS8T1mNEZkAbhy/dJzwI70yYEtxTH2+Kc6G/Fe5ExVtN
         Q5V7iWOmzLeYQoYbM3tRqTwhyT8LCGW2ncAnN5kLHS/QtgND99HmzL0OzxLbRAiVMJmI
         y75mtMYqZqpKlbOaRbcJ40f95gN+fhB2gTdMga+N7d9Iic0l8QdVtrldreAmowQRmstP
         nzndHsra/8Ajvvos+AtMcIEFTsYuvm4PXoauKuBR96BzA93npp8EmluiQ80nQFASLvXR
         6zboTLfQPexXKFwFvq4vko154rP+Mt98yOVbvWdDlfaNSZqhDTVQtEtRXfEM/PGEh9yC
         nFYA==
X-Forwarded-Encrypted: i=1; AJvYcCU+XrENSCAOP7/l0Dzv9FUVM4YvT1S1BHqHTBZLhMBbk4kedgx7ZrtptfmO+YoNt7QKMUadSYo9A3LYD9Sx0REnkwxK94E0aT3wpDq55kRNg9eM5+17dD2dYV5FF1XWiq5lNZvrYrY=
X-Gm-Message-State: AOJu0YyKnDH28IDMV7Ur+T+C5DijGiuBZgHvjPDIpSz8ND9+TMTSmqEQ
	SIh2gSu+2StrsrgcdTS6j6lVsofIk78l78u695kKl+HPnO3i9fzK
X-Google-Smtp-Source: AGHT+IH+VnKs2niwZit6OxZnp1v8e/lBe5N8NdP4NcxFWpAthlMSTTyY3qw9gpuWOLrXZLWNFQW/jw==
X-Received: by 2002:a5d:50ce:0:b0:360:866f:5083 with SMTP id ffacd0b85a97d-3630191cd24mr1743497f8f.32.1718779632852;
        Tue, 18 Jun 2024 23:47:12 -0700 (PDT)
Received: from [127.0.1.1] (31-179-0-202.dynamic.chello.pl. [31.179.0.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3609515e16dsm7480643f8f.44.2024.06.18.23.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 23:47:12 -0700 (PDT)
From: Roman Storozhenko <romeusmeister@gmail.com>
Date: Wed, 19 Jun 2024 08:47:08 +0200
Subject: [PATCH v2] cpupower: Remove absent 'v' parameter from monitor man
 page
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240619-change-mon-format-v2-1-6bcffbad2c06@gmail.com>
X-B4-Tracking: v=1; b=H4sIAOt+cmYC/32NQQ7CIBBFr9LMWgxDLRJX3sN0QXBoJ5FioCGah
 ruLjWuX7yX//Q0yJaYMl26DRIUzx6WBOnTgZrtMJPjeGJRUJ6nRiJ8NcRE+pmBX0UuJw1mjGwx
 B2z0TeX7tzdvYeOa8xvTeLwp+7b9aQYGCvFW6t4aU0dcpWH4cXQww1lo/ZYxhl7IAAAA=
To: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Roman Storozhenko <romeusmeister@gmail.com>
X-Mailer: b4 0.14.0

Remove not supported '-v' parameter from the cpupower's 'monitor'
command description.
There is a '-v' parameter described in cpupower's 'monitor' command man
page. It isn't supported at the moment, and perhaps has never been
supported. When I run the monitor with this parameter I get the
following:

$ sudo LD_LIBRARY_PATH=lib64/ bin/cpupower monitor -v
monitor: invalid option -- 'v'
invalid or unknown argument
$ sudo LD_LIBRARY_PATH=lib64/ bin/cpupower monitor -V
monitor: invalid option -- 'V'
invalid or unknown argument

Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
---
Changes in v2:
- Moved the detailed description from the cover letter to the commit
- Link to v1: https://lore.kernel.org/r/20240618-change-mon-format-v1-1-efa263a8e286@gmail.com
---
 tools/power/cpupower/man/cpupower-monitor.1 | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/power/cpupower/man/cpupower-monitor.1 b/tools/power/cpupower/man/cpupower-monitor.1
index 8ee737eefa5c..991f931cfc38 100644
--- a/tools/power/cpupower/man/cpupower-monitor.1
+++ b/tools/power/cpupower/man/cpupower-monitor.1
@@ -81,11 +81,6 @@ Measure idle and frequency characteristics of an arbitrary command/workload.
 The executable \fBcommand\fP is forked and upon its exit, statistics gathered since it was
 forked are displayed.
 .RE
-.PP
-\-v
-.RS 4
-Increase verbosity if the binary was compiled with the DEBUG option set.
-.RE
 
 .SH MONITOR DESCRIPTIONS
 .SS "Idle_Stats"

---
base-commit: 0c52056d9f77508cb6d4d68d3fc91c6c08ec71af
change-id: 20240618-change-mon-format-30015761c58e

Best regards,
-- 
Roman Storozhenko <romeusmeister@gmail.com>


