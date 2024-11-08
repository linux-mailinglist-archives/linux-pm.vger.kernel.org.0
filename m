Return-Path: <linux-pm+bounces-17206-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1299C1E8F
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 14:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F15552823BF
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 13:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4851EBA19;
	Fri,  8 Nov 2024 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOlavDiE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097721E47A2;
	Fri,  8 Nov 2024 13:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731073954; cv=none; b=YdEbrIP/bNJ9ZBiZVfoRgvcISCtteT1LvCPAZy5z4hbCAGCPNYhyNaLsnCNzCGTlt6Y2iHAtR0TsvNQn509oFqD7V05gV8BYvYJQXgkm4SyrNNi5WaH8Yx3W37wCmDLN0BESa/C1rjey1+w/8wXz5YS9V+6eWgUwUKY44NadjN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731073954; c=relaxed/simple;
	bh=49/Yb17bhSU/BLaaeQ4NgwEPpxak24lXwHVGcSiayTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P1nDDElyMHTNjEM2aCDTzgT5tNA3xESeL0IOelkhts2vK7FzIeB0CwBn3X81+5QuKSI697icRe28F4RPZTxo+ztSreMdFr3HeSjC6WzrzETnXHkI9avsAQ4lPzTsPoSX4gqhesLMC9wJgcXYtJ4yiekq2aqI76Auf14RKLevPrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOlavDiE; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b161fa1c7bso118906285a.0;
        Fri, 08 Nov 2024 05:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731073952; x=1731678752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=CNf/dIX9kLrToT9htir6KdNK1oLlzjAbFVTYrQ6ilJE=;
        b=NOlavDiE6ySHHoO5s6xWq5Ftk+vytajLvsjajQgns2ixAvyLyK+zMp7KTrUoZ3Yjjj
         Do3S13SeBu0afmQnBBZiYvfN7pa0VMm4iGnSeyFM4Nf4YOnKHtcefNKw8KOjttePBqS0
         uYU3/mwwsIEhNMsJjQHeu4IpaMO4RubfJ1ImSpIeoBlzgwjWFRCLJgz5Wfo4hs3KP7hN
         1u6wh+e/EzgP3L8LCjRwuOQRv9sMUCrsBXVN7TElK6DqCm2VwbiY9R+S7PIrdGohLlge
         aTFrRUqTnV3evTkshnIielKvRjVOOpYN8RWM27ZFiawQH8tjBtyb0Mp67oSTy7KmOg9/
         6AhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731073952; x=1731678752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNf/dIX9kLrToT9htir6KdNK1oLlzjAbFVTYrQ6ilJE=;
        b=KjnVG4/N2NDPekizgWKGEfmdN0IHZLpfeU65tQ5sbUlNoti8/leFDSTNjRX2WJvbwK
         Bq6IhpiwuBA8/vr3D0InsVmOKQ3yGOSUAuQOZpQok+Q+QFpcRlrla8FDEgWS9pt2LUp4
         nnVLew1p+Es6ZPZgZvYNSR+6OryZKeLyJHTpKdbwoKzyQ49ewvPDzdaobf5Hwzapg8Qe
         YeJYHNVSXHIlmg0V0PrJD5AvFvZc3IHLnY/0xryjfO8Toz/hE3E35Ho2LVxCLPFHBTUH
         hqiYjHj0xIr0IMesJO5Jm5Qh6pCZEUZUHIJEYyAzpOHjl2nrIbr1g0YBWzJXpZ1zwE19
         IrUA==
X-Forwarded-Encrypted: i=1; AJvYcCU/PlSaUdilOp95Q7KQk6YwQ0oorliRWIflyd34PyxSuNeYmg6eidnWzBG9KFgKywflSXpHXPcBZiKFJrg=@vger.kernel.org, AJvYcCWcUTeOOT5iwpudPmsp8zcX2zXe3Lk4kmgQjU5fGEJX0PR86mdXnY98HXhqEhnTvZmSd6k/NoEpciM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+TLktJtbwRshoQLZbYGoKHl7yHysOORRjd0RhlDq6pnRDCN/C
	Ipi8HmtT672DhxHSnFp7VhQpcUkDwD4lXMx0L8Y2l+xM7+/UqzTM
X-Google-Smtp-Source: AGHT+IF4JWJnMZ1yff0EFZJQWmW79x4urgAYvVHlweq13RS5RYAPNV2TSk/uVQCsr6A6HIbx3VJuCA==
X-Received: by 2002:a05:620a:2407:b0:7a9:b8d1:a1d with SMTP id af79cd13be357-7b331f1e4fdmr313695685a.38.1731073951884;
        Fri, 08 Nov 2024 05:52:31 -0800 (PST)
Received: from lenb-Thinkpad-T16-Gen-3.mynetworksettings.com ([2600:1006:a022:33ba:65ef:6111:c43:42a7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32ac54e5fsm160431285a.49.2024.11.08.05.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 05:52:31 -0800 (PST)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: peterz@infradead.org,
	x86@kernel.org
Cc: rafael@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCh 0/2] Add Intel Lunarlake to X86_BUG_MONITOR
Date: Fri,  8 Nov 2024 08:49:29 -0500
Message-ID: <20241108135206.435793-1-lenb@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Early adopters of Intel Lunar Lake systems have noticed
unacceptable GUI delays.  This patch addresses those systems.

[PATCH] x86/cpu: Add INTEL_LUNARLAKE_M to X86_BUG_MONITOR

	Upstream patch, also applies to 6.11

[PATCH backport to 6.10] x86/cpu: Add INTEL_FAM6_LUNARLAKE_M to X86_BUG_MONITOR

	Backport to 6.10 for old model number scheme


