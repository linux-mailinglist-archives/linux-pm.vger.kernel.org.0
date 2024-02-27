Return-Path: <linux-pm+bounces-4423-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 294DE8687D2
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 04:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B54C81F22E4F
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 03:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23FADF55;
	Tue, 27 Feb 2024 03:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xiaomi-corp-partner-google-com.20230601.gappssmtp.com header.i=@xiaomi-corp-partner-google-com.20230601.gappssmtp.com header.b="IpBvL4Nu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307FA2260A
	for <linux-pm@vger.kernel.org>; Tue, 27 Feb 2024 03:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709005241; cv=none; b=hcEzhidTd29hggl2AC91p/y5xzxWOwJk/XnANScZ7GF8aQglRawVjcmORfhqoJGB/WJ2e7Mc6ldXy1xgjTO9uWEmpkP4hBl9wdt3Uj/9f2QX2gJqwMfH0jN+NSOGI8/WmO4206Npe0wap0B1aW/7xDLbyK5Qp7VDMvFRSkd06zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709005241; c=relaxed/simple;
	bh=zU9oD31knEalbiOB2cAkxpqg9wLWKqGXJVMMBzS6PoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fuyTwDXa5sOYQM2n6RYwKz+s/t0WDpYrxtOuR8axcpLtbtSi6RL37TM62+LBmnYESh6JXB8H9WOsh0Q+wyXwnBPit1HWmfE0ShZQt1+OUB/9bKlLdt5DCoiRb/fL5AzYfXs4PUf7i6ulFMHOSnKFttlVpN/Vwj1vbJ+NCNL0Rg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xiaomi.corp-partner.google.com; spf=pass smtp.mailfrom=xiaomi.corp-partner.google.com; dkim=pass (2048-bit key) header.d=xiaomi-corp-partner-google-com.20230601.gappssmtp.com header.i=@xiaomi-corp-partner-google-com.20230601.gappssmtp.com header.b=IpBvL4Nu; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xiaomi.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.corp-partner.google.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a095237eefso712562eaf.1
        for <linux-pm@vger.kernel.org>; Mon, 26 Feb 2024 19:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xiaomi-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1709005239; x=1709610039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zU9oD31knEalbiOB2cAkxpqg9wLWKqGXJVMMBzS6PoI=;
        b=IpBvL4NuIUUXdGKZhLgGBLl9+M1DjNkO/LSvq92v0oQT/cfvK8J4NoWQFvIRFKjChA
         1R2tJtTN6hTRtev23OAnxs3anG9WnLcD/0zN3ioVzsaEPIlfW83GInhIfsfLTJzssOvj
         o3XK0i1RccrBIvJ143j4syOOm2s1uO87TEfmAcUczqdkl2obJwCG8t9hPpbE1+S7uFKo
         LLsydil73p6rp/ONqzCXyOXnKTDdPGf6kwKQEGkU4bxOa0pWRG/PlbT2kD7xiz0UHpJ5
         8LnC2hAlKdB+6SB8LJnv1X3fJ5Wy8ueb3jboi4KaRbt25jOgtwu2yr8LV/0XOYkGxLJ9
         5Ipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709005239; x=1709610039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zU9oD31knEalbiOB2cAkxpqg9wLWKqGXJVMMBzS6PoI=;
        b=oJv6uMotIxZnVYynOIFL03/wjpnkyw+mmftH/1JQ48bJccpvE+2EwfnIsbYJDLg97w
         j72oNC2LtheCj+sRLsqLGKWX99Y3ZNjJJVI5szkCxhRKzGQoObgh46h8DoHJj05t0UIE
         gAqzL2v7VrFm6C8IQlKndXqr1YiX52Z0vxLKRF2Eq+a6HP+uqXaoaxdXTlJ5leGwaVuf
         /Voe74sfInULNl1zv+i7JRJTCioyjA6uOTV62dJ7lFmsBLfje4W9q3C7+X4oL+hxXkmP
         FXx5VZ0vzNUai5Dm4sZp4/sT4ORsZbbNa08tlG6PNtXKEEyZI/7MYT2n74ysHCjCuJ61
         p5cw==
X-Forwarded-Encrypted: i=1; AJvYcCWDHVgFOWYf8dVi5w+KtTjxlcT7LfFP9zWXfcgFK9chhv2j5j+6moW7KvJ9ClJXB8XRYYSFi96DHMoWrUmfncUm+lt7xVVcL/o=
X-Gm-Message-State: AOJu0YzlBI9tZh1gdrkLlwbwtiCVV3SMnnXa9hv3RVA0j4IC88J/iItL
	F7LwAd4tOHqapm0O6faAZJvt+oh/mxJhAxyD71A0S+TjEwDI1Fy/tsHNbzOfin8=
X-Google-Smtp-Source: AGHT+IF59cK5ZcqQAcJe1CGGsv7k5mDEoUJZ8WlzdPRcbYF0ubYhXH9QLOC3m9RGtAvBZjZrNVQptg==
X-Received: by 2002:a05:6358:59a3:b0:17b:59f4:f640 with SMTP id c35-20020a05635859a300b0017b59f4f640mr10778172rwf.1.1709005239276;
        Mon, 26 Feb 2024 19:40:39 -0800 (PST)
Received: from xuyingfeng-OptiPlex-7080.mioffice.cn ([2408:8607:1b00:8:b27b:25ff:fe2a:187f])
        by smtp.gmail.com with ESMTPSA id h22-20020aa786d6000000b006e089bb3619sm4811499pfo.112.2024.02.26.19.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 19:40:38 -0800 (PST)
From: Rumeng Wang <wangrumeng@xiaomi.corp-partner.google.com>
To: djakov@kernel.org
Cc: fengqi@xiaomi.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	tkjos@google.com,
	wangrumeng@xiaomi.corp-partner.google.com,
	xuyingfeng@xiaomi.com
Subject: [PATCH] interconnect:Replace mutex with rt_mutex for icc_bw_lock
Date: Tue, 27 Feb 2024 11:40:31 +0800
Message-ID: <20240227034031.1195-1-wangrumeng@xiaomi.corp-partner.google.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <4c3f9f52-cd56-4d20-a44d-bfca0b2e3b7e@kernel.org>
References: <4c3f9f52-cd56-4d20-a44d-bfca0b2e3b7e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello, it has been a week since the last reply. Is there any progress on this issue?
Thanks.

