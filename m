Return-Path: <linux-pm+bounces-28706-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF121AD9915
	for <lists+linux-pm@lfdr.de>; Sat, 14 Jun 2025 02:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 402713A805C
	for <lists+linux-pm@lfdr.de>; Sat, 14 Jun 2025 00:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7F4B640;
	Sat, 14 Jun 2025 00:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4y9B6t6Q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459764C6E
	for <linux-pm@vger.kernel.org>; Sat, 14 Jun 2025 00:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749861371; cv=none; b=itD0enx23gdfQ9BwxyXNdUrseH/mw+dGaukEHHtdVXa9rH3OjqEEzYgrH6Raq8Ju6yg4amy4nYOiONtrN7PVvkUmkz9ievTBEfVZ9AUhXPJoSrxBOcDP23GCp1oLlT8zIqxxHQVdWMin4Y8M9cZkfUR9lvXhKD1BMKpIAVL7t3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749861371; c=relaxed/simple;
	bh=V3gKkZyJoVLU65p1MmuPCnNPvMxWcutqGk8WIWwz7m8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fHacH7/44IYRZImkCIQcHtOZcpO8J2OJ5BmygT2jFf7ocAnHhtt4/lZOHTWnYjvcd/ZODR0cSKHEoST96XWHLtcoo5mnfgm+9quyScaIM+eWmPEqoT2/YbQFaaEVFVpSsda9Lulo3UjJOCOUhEVBb82aRyWtRQEJF9mhQLK8dtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pmalani.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4y9B6t6Q; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pmalani.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74841f2aee2so1538490b3a.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Jun 2025 17:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749861369; x=1750466169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LsGNwzjJybqThQOT8fD0kBJYces/xSpMR2ULC69ZMTA=;
        b=4y9B6t6Q9QRB+bX6ChsQ1onqtRetAZofIy8BLMZl4Upr6sUjmbho4FkxxSzTX8L7UV
         Pqho483hAUA2HXab6BO84FraPAPaNpox8LgvA1bdlhdZT3gTclHPcD/6jgh3NRFSTDDd
         HGUPlwMEeoMuNZTIzYNzhl7wTE9mdNKuhkBRkRyYktJ13yHM1H7im8EhWkXICGJOmHrv
         LAhh/ICS+OBtcUrKzW+Yp79IwC9wGHZlUqDzZZA/nWZgs+GJavGPhV+Gv1BipYZv4wbK
         H8dDjuEIvJuZzh8Zcf8gD/GQ1aMCZQqeWXUMn7W4jckDkSu6Oan91MB035Ll6fm11ieI
         MdAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749861369; x=1750466169;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LsGNwzjJybqThQOT8fD0kBJYces/xSpMR2ULC69ZMTA=;
        b=R0LbZZHQS7SMC/tCpQ88Oz5/4WdPrMpteUaUVeaSBj/6nVP0PgvFONxNHGPPIzBJ4H
         NypgUt04bzHCC3LDBf6adpnFUop1PblocFq+MbYSNr9LT2NmUlHCLZ4xO+V09Wpgn+3X
         sXKXmh9XyBINsNm7beBNFZYdzNl0bqxVThknwLBATSyAvBsuDUSCjowk7i3auyFawIcO
         2cJpWIEh6/pCsRj8GcdWep5nQmZ4k9UFbR2Rs41MYdMHGNeYvL2lhjvIp4fD//QY2wtQ
         cS3aHNt3kNqUa6vb5IYA+nOLom6dlI1HIs/f1G3Fe5fRx35Y217RugwdigpIZjOkJCkM
         8A9Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5gsgug0OfoNJ3mfPzdTbaALWcuzasmSMYvUgVBEJIOSU3MNeE6H9bF/Y+3jrl1Yr0hyi+oZPxkA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxSNFKtJrQkDMLwYYDvC4U2Yp4tf8VgTv7jTqa9pJiAAmpI7Zf
	DIURx02xB8AAaTl3vaocinNAdUn45uOq5yCueBi3Y9vJ6Xo0m0e+/YPWZ3HWME9HAM81UTwJBkQ
	81Vn6y7VQrA==
X-Google-Smtp-Source: AGHT+IHqLoqmlxmqsh8euk0ITwAFXpQgXFZ8FKMEePf+KFc9sgQ9UBMVfeleItXZeZXM4tzmvg+uVOzwHQRt
X-Received: from pfbef24.prod.google.com ([2002:a05:6a00:2c98:b0:746:223d:ebdc])
 (user=pmalani job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:230d:b0:742:a7e3:7c84
 with SMTP id d2e1a72fcca58-7489cf97bf8mr1624147b3a.13.1749861369622; Fri, 13
 Jun 2025 17:36:09 -0700 (PDT)
Date: Sat, 14 Jun 2025 00:35:26 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250614003601.1600784-1-pmalani@google.com>
Subject: [PATCH] cpufreq: CPPC: Dont read counters for idle CPUs
From: Prashant Malani <pmalani@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: Prashant Malani <pmalani@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

AMU performance counters tend to be inaccurate when measured on idle CPUs.
On an idle CPU which is programmed to 3.4 GHz (verified through firmware),
here is a measurement and calculation of operating frequency:

t0: ref=3D899127636, del=3D3012458473
t1: ref=3D899129626, del=3D3012466509
perf=3D40

For reference, when we measure the same CPU with stress-ng running, we have
a more accurate result:
t0: ref=3D30751756418, del=3D104490567689
t1: ref=3D30751760628, del=3D104490582296
perf=3D34

(t0 and t1 are 2 microseconds apart)

In the above, the prescribed method[1] of calculating frequency from CPPC
counters was used.

The follow-on effect is that the inaccurate frequency is stashed in the
cpufreq policy struct when the CPU is brought online. Since CPUs are mostly
idle when they are brought online, this means cpufreq has an inaccurate
view of the programmed clock rate.

Consequently, if userspace tries to actually set the frequency to the
previously erroneous rate (4 GHz in the above example), cpufreq returns
early without calling in to the CPPC driver to send the relevant PCC
command; it thinks the CPU is already at that frequency.

Update the CPPC get_rate() code to skip sampling counters if we know a CPU
is idle, and go directly to the fallback response of returning the
=E2=80=9Cdesired=E2=80=9D frequency. The code intends to do that anyway if =
the counters
happen to return an =E2=80=9Cidle=E2=80=9D reading.

[1] https://docs.kernel.org/admin-guide/acpi/cppc_sysfs.html#computing-aver=
age-delivered-performance

Signed-off-by: Prashant Malani <pmalani@google.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.=
c
index b7c688a5659c..9bc2546fb4a7 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -753,6 +753,10 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int=
 cpu)
=20
 	cpufreq_cpu_put(policy);
=20
+	/* Idle CPUs have unreliable counters, so skip to the end. */
+	if (idle_cpu(cpu))
+		goto out_invalid_counters;
+
 	ret =3D cppc_get_perf_ctrs_sample(cpu, &fb_ctrs_t0, &fb_ctrs_t1);
 	if (ret) {
 		if (ret =3D=3D -EFAULT)
--=20
2.50.0.rc1.591.g9c95f17f64-goog


