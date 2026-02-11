Return-Path: <linux-pm+bounces-42492-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFzWKBNFjGlxkQAAu9opvQ
	(envelope-from <linux-pm+bounces-42492-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 10:00:03 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0DF1227B9
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 10:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19D22301BF46
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 08:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D87309F1D;
	Wed, 11 Feb 2026 08:59:14 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EB2342539
	for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2026 08:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770800354; cv=none; b=lMDmbqrQ2nENoAg25VvNDPEqWcoOR7ERiNmw0mG07wi5eJ6TeD+AE1oKAzvNzfjQee8CzVEgPznG86YUNHp+6Ez3k6+s2zn5Cpg9RptTYtzlEYNLHzz8Q1NtvpmGw0y0j/nJ1j6BYp2glmrv2vuNkMPNQGS7jyNVfUVrA88ktVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770800354; c=relaxed/simple;
	bh=untbHeSgClt1NbxyXv+2H3wxS2fkUX4eMkF88xDOoIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RDBixnr0Dy1T9GxHTRH/GC5iBI5ujaw/yE2s1PtE/53pMO9HXXK22iq70d6us9RHtHVXh8+FYBxChegbKp3sg5jX4Z6SsSF9uHNFwFmqKv0AwQ1pAb/lvd26Oei/spYP59IHZQWZfG7OW2h7LArJtv/FfjoB1TUTNOsNSRXNo3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-c648bc907ebso4249643a12.3
        for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2026 00:59:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770800352; x=1771405152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yK55GKsRQUKRb2pbzYX2sV3DuP8HMn2n/G9bxyEv3MY=;
        b=BGlgzCckkJ/NyWzt4dKf4OWatZkOcpeBncerUQQuoRLa+8NSFxlrboBaZKGPF3mWoR
         MhnXOiI/KTOog7n8zJ7t8A71O3NAR1z1U5hOgmuBF9Jxq1YyFt1S+uUPtA/mYeRTKgvJ
         ZJoiEm4kXpnmDavB6P7kP5q1C4j4OdLFLx8u9oZDEMxDVlmFF7tFkPwsM5vEkSGihlpJ
         t+udFXwRRsr54dvEuT/ZAuyMt+5g9CY5dvm+4FKiAFVnYwPoI/E2tDV614GNVoxMvqHx
         gEFwuPB4nNIYJySpWl3D8DJraDktpsX7B3G5pSOik+diqjIujYRJqMyO4Y7UPS2DdVkN
         wr9g==
X-Forwarded-Encrypted: i=1; AJvYcCUzLrys1qZ7wxCZSLyTpuVttBGElXjFYjZgXX54n+a6WwBOnQWDVNYLx4Yod4+h7Gg8ItynImxv0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9VocrV+OPzqccNOi6AEWC/n2zIIt9FfknJVvnTshER1L+NdKh
	j5UW8RtI8mnAJOrRrV8mHoTHW9EbZQI5v5Q8ewHx0N4HCyfImqwNcpYq
X-Gm-Gg: AZuq6aKia+MWZoSjoIgE5SHFLahSHH5+yk6kHH7wLd9Rz7egQbFfIS/oHQecHhsUC8x
	q8vwBSsqKpO77SQOpVsiuttDjjxJKw4SmyKuAnzKBoUNtFCpjFuerxdpmpnFukDrpKFlr+3QbsK
	zqfgH3fk9z2A6jhkhRQcDynTTHB2vgq0qhf6ederwRNFDi+DDLJzyjF6CrZdQlOVsKd2HyIZU9U
	ssw9hz+k6um3Yr3CFDalBl5rbvjIPM7xHcR/4gTJxNthbskU1JZNU3QElixUkUw/E2Pkma3jXAu
	6CYsyKpgN8MyviTPGtG9r5c4GptpjUeGTrHvncaWEESWdNE8cmVmJShnCNL/u0yxrf0mYXQzCvN
	GyHFHSjajbGeXf8x2Yv9EeQuq7GNUO1eieQL5VTrOlnZ+DCPg4Q4KVPceK88Nrrx9C1geKw6p0h
	JN8tHRfLbyhrUpzXnTmhoqoZ5HEPcns/no/hIyOgpS8q6V3g==
X-Received: by 2002:a17:902:ce82:b0:2a7:95d1:3c0 with SMTP id d9443c01a7336-2ab2ac070e5mr13475785ad.23.1770800351677;
        Wed, 11 Feb 2026 00:59:11 -0800 (PST)
Received: from power-ThinkBook-15-G2-ITL.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab2c522a60sm10860205ad.63.2026.02.11.00.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 00:59:11 -0800 (PST)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org
Cc: christian.loehle@arm.com,
	daniel.lezcano@linaro.org,
	dsmythies@telus.net,
	gregkh@linuxfoundation.org,
	harshvardhan.j.jha@oracle.com,
	linux-pm@vger.kernel.org,
	luoxueqin@kylinos.cn,
	sashal@kernel.org,
	senozhatsky@chromium.org,
	stable@vger.kernel.org
Subject: Performance regressions introduced via Revert "cpuidle: menu: Avoid discarding useful information" on 5.15 LTS
Date: Wed, 11 Feb 2026 16:58:55 +0800
Message-ID: <20260211085855.96448-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJZ5v0gxNdQG8O32PrBcSa3GGvQCYObrquuiUXyJ8kgPV=91Sg@mail.gmail.com>
References: <CAJZ5v0gxNdQG8O32PrBcSa3GGvQCYObrquuiUXyJ8kgPV=91Sg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42492-lists,linux-pm=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DMARC_NA(0.00)[kylinos.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_NEQ_ENVFROM(0.00)[luoxueqin@kylinos.cn,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:mid]
X-Rspamd-Queue-Id: ED0DF1227B9
X-Rspamd-Action: no action

On this platform (ZHAOXIN KaiXian KX-7000), we evaluated the impact
of commit 85975daeaa4d ("cpuidle: menu: Avoid discarding useful information")
under a screen-on idle scenario. During testing, the cpufreq driver
was acpi-cpufreq and the scaling governor was set to ondemand.

With this commit applied, measured system idle power increases by
approximately 2W compared to the revert case. In addition, battery life
testing on the same system shows a reduction of roughly 80 minutes when
this commit is present.

These results were consistently reproduced across multiple test runs
under identical conditions.

-- 
2.43.0


