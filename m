Return-Path: <linux-pm+bounces-32926-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F01B325B5
	for <lists+linux-pm@lfdr.de>; Sat, 23 Aug 2025 02:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4763C588941
	for <lists+linux-pm@lfdr.de>; Sat, 23 Aug 2025 00:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C997393DDC;
	Sat, 23 Aug 2025 00:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uJCopSYp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD27393DDA
	for <linux-pm@vger.kernel.org>; Sat, 23 Aug 2025 00:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755908386; cv=none; b=SoawSd2NBUAtXGcjRdU9d4E7qALONPwjOl7T4PFzBTfdrGYpcwsNfmXsUPMLGVuU6HfTyETjHPHHm6QDQMglySAqvWeMiYVRTW/Hu+sWe1TWsTef5Do1Im5AOl1NH+KhVBjq/LQpIZ1BW/PYKcZF6PUAnplVRXmRBIn4TfURmCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755908386; c=relaxed/simple;
	bh=IfxLvH/4djtXjG1ZbT1WQD1ylUynPTSQfpsVbSEvNF4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=F5eq8hL13Vuogz9b8PTa5bAktlARmTzBUZ+1wHaXTYeEaEQ37qla9LFmxeB8y0j14A17bZIDh7sr+Y6jCKv2JotQ27x6ILFvGSdOsrKLDLAls5msBNjcTSY5T2HX3OJShGqZ9bjlX9TgiNvmAyx15FGH6OM+Sqxxz4+Mm2smw6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pmalani.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uJCopSYp; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pmalani.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24457efb475so32070455ad.0
        for <linux-pm@vger.kernel.org>; Fri, 22 Aug 2025 17:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755908384; x=1756513184; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Dmug+OnOuHHGPSonvBlqyEYHJAEByQWWRbd7ST4yXZc=;
        b=uJCopSYpvUHOJU41z6AE9RbNBpBDbPOIz5+rg5CpxSQWO0gOsJlDJXNVMfwjysDE6C
         NxmNVzT41uiGZ3+KBIVVx6qgGToRlF+2U45cEMskIkTSjcLPZABzu+4Ca7nDUK82p8gB
         mCSFxyofUD1NHi5PTatDegJd05FlUcH43jP2NgQzcfshYB0WTaJIBGcF54EB59o4ob0M
         oWo6xUsMCPVpxcwUTgxpD3G37dGd42Iq5JjpAdRWNxXf7IT0W84bhJqUhnuLBPf5Y/bv
         loxd8SKow4Bqp3A0dyNO+xcQq7AsqnkX83XeZYRPJ/LcC3Or0iQM6YbTEkXP/xtOXUN2
         wnrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755908384; x=1756513184;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dmug+OnOuHHGPSonvBlqyEYHJAEByQWWRbd7ST4yXZc=;
        b=NKr8Nx017uDezpTXRHSC7/GiFhvj2t/LYgwA5LhgbDSM8AyqLXaTmeUVEHChy1azUg
         Yf+CwVUbaqdcY80bTIQ2GdkFTpHGPp9X9Edc7AoiIGuTUuCfx9SqR4Ii/pczPnrqckzT
         Kp6ivaHMBTz/HmDngIRtlxdhKyaNrUzpJ4V+viWEAhxz090ak1A/LvCZb+FHisMsFE5G
         lJfla62ac2Sx4VscAhzYtTRrMUSEPk6ypGI2te9jt7YoEpqgZzFq0NVRc9WCUhABfKYk
         ZFZC61SY1PoOUyvI87LsfgPuzsmKL9UE7Mk+7qcgJLRtBmL+hvdYmTqRzXOf+GSTuvyg
         7vvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdVJpVGva6IZwi/PM6RibjmQltZjIBEoicDg0q5SVtdYTtAlmQ3t48XmvM4ufdMjOhcdir5KVMHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDHQJceg8S4tBzjjcXqeSaEKowLw6DomMxTXgZr+HEmyM4ZPBd
	OAg9GGu28ddaIXanA4up128VCE0qNJJkDQMS1pzSnR7K2vLPWAxdA5FPqorTVqbFQCA4qFR5412
	y/vNeJVbHYg==
X-Google-Smtp-Source: AGHT+IHQuEttIAsZ1HbWe4GGbgzVoHgREsFjRqv+pqfupF9cALmrShqhnWckhzXHJOCAVo8bhb7rEnDQQT0B
X-Received: from pjbsx13.prod.google.com ([2002:a17:90b:2ccd:b0:323:2b2a:1de5])
 (user=pmalani job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cec4:b0:240:4d19:8797
 with SMTP id d9443c01a7336-2462ee48412mr55759115ad.22.1755908384225; Fri, 22
 Aug 2025 17:19:44 -0700 (PDT)
Date: Sat, 23 Aug 2025 00:17:46 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250823001937.2765316-1-pmalani@google.com>
Subject: [PATCH 0/2] cpufreq: CPPC: Avoid cur frequency modification on
 governor start
From: Prashant Malani <pmalani@google.com>
To: open list <linux-kernel@vger.kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Beata Michalska <beata.michalska@arm.com>, Prashant Malani <pmalani@google.com>
Content-Type: text/plain; charset="UTF-8"

This is a short series that handles an issue where, on CPPC-based systems,
the cpu frequency was getting unintentionally set to the wrong value on
governor start ( and overriding the existing policy frequency) because of
unreliable AMU/CPPC counters.

This adds a governor flag that avoids the check against the CPPC AMU-based
frequency when the governor starts. It then modifies the CPPC CPU freq
driver to opt in to using this flag.

Prashant Malani (2):
  cpufreq: Add driver flag to avoid initial frequency verification
  cpufreq: CPPC: Don't verify cur frequency on governor start

 drivers/cpufreq/cppc_cpufreq.c |  3 ++-
 drivers/cpufreq/cpufreq.c      |  3 ++-
 include/linux/cpufreq.h        | 10 ++++++++++
 3 files changed, 14 insertions(+), 2 deletions(-)

-- 
2.51.0.rc2.233.g662b1ed5c5-goog


