Return-Path: <linux-pm+bounces-36821-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 578C5C08B35
	for <lists+linux-pm@lfdr.de>; Sat, 25 Oct 2025 07:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F25554E2E20
	for <lists+linux-pm@lfdr.de>; Sat, 25 Oct 2025 05:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B391A2C25;
	Sat, 25 Oct 2025 05:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JU3j+7ET"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935FE288D6
	for <linux-pm@vger.kernel.org>; Sat, 25 Oct 2025 05:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761369372; cv=none; b=pbVBbKvdQe+kLqhrjpS6moK1Df6M3idgEkQStbbMFNdZC6lJb/Vmr43hup2ULj6z3SjhoHYDZrnpV2/OHtCZuPE2apTHHzElw1RCNMayFH4p3tDPp3NPmVVd9mN9ui4Ttv2puloGmwW9RE/yOM+oOKe8S8XrO5ykhHsZsN4EceA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761369372; c=relaxed/simple;
	bh=n3Y+AcN/I881f5Cyv0rcUjEkJzVPX7TxD3E/j95volA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JSt9wClqFU9hwYDmT4HGwQbDUIh+6kRrDJ6FFjHqfIzlM2pmmW3/ktiQgCCe86JGKdBD7d03LIdD3vWgZWS9K0hfbj0fbQlZvlE9ZHN1vhy2lnV0iOEYPrw09xMR8FM493LUG+4NNJXSDfcvRr2qb3BDj81lJBEOaIXa3/i1TMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JU3j+7ET; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63e11cfb4a9so5031748a12.2
        for <linux-pm@vger.kernel.org>; Fri, 24 Oct 2025 22:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761369369; x=1761974169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=apaAoIq51aRtrkFWbmPU/2WaEbN9gRF7gSr6IfYPHi8=;
        b=JU3j+7ET09LfzkDeo+C95SEee/p+pO28pfNZ1+hPVibtBMVnDRS+6URIIKLDOo1U4o
         bJm68VDzWcr6QE4WLYClWoTl+yC9JMDuXBq7EukiTXwgCQFVJSqPWEbK5KV56PDnDpGT
         YaevZgwuGHSo13Gj7aZFA+iFhHAUSKXeCjkVo3Ji/1c4h7NMNrAwBzgVcGgkZsopECa1
         qKFtPqHYo81fGICKhuC/OA4fhcrIpZXAvG+zYHw4av6xHNl8c9wh6CmAZcfP1oO3pmBy
         bvqO/gbmvSSGP/IGnvMZZ6J1Ow0EE85V6Sb91yAG6dd3kWDszEfv30TvRIPeNY+2LjHg
         Uinw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761369369; x=1761974169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=apaAoIq51aRtrkFWbmPU/2WaEbN9gRF7gSr6IfYPHi8=;
        b=ovU+IdORfPLx0qpIE0+As8S4EM74Dqh2ftSyEXCYiQWF0KHxndOGkVbTZQuUhIFJbS
         yGSoTuUHenZ3p52mabBehtnBUHZOgZPySxBRjA3NlZgLlidRgxnM6ybiE4i0P6/J5hGz
         xboeh48syf9w3hc/LYKrOQbUNjvtSkRcrAo57h3E5U18gtvRzFHZFeEz1hOxBaAlV6uh
         pxsLtXOJsyN9z3CzMnx6f3DnyWGbDCBQmRTDJndc07zHuAG2ATs5jnoSk3KWGQwYDBPn
         mVqJmj/lrxyX9ETUnEq1kc5GQ5g5hGksuD6NMihraDYGveM2lWt0ifwBY7DcNimoGBA/
         tfbg==
X-Forwarded-Encrypted: i=1; AJvYcCWYvoTG9vZEyPjLhf6+dD8EFLUvr3Jy1M9207oNaVUcmOHWHaARSkORRBE8siHsTHDASp0C1PF7Tw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEkvFndtqt1Pb7th6ZzKPVEtg7w48dcqn7AAdRCTchetTknEt5
	pX5u+AAbDxTxa58BNnEdPUK3IsDu00cSf3KupsWFjn5QwtKAAZEX2g+h
X-Gm-Gg: ASbGnctXtfl9rDlvH3IGlGo1tq3fhP+AACUA28JM287T7el/QsTKfGS0KlTYmjP2bNL
	szl71UsfIwStvYY4dA1TBd2U1kCaNN4xt91vdYhsKlpcf69U6LEqk0ywQka6kIuz2qEYYzA1iUd
	RbWvRV372LcsWC4RkABu/fZmXMag/jSrtIBcNqrsHJGT8p63lmXzNS4E0os3FsyxBz3OiF95m2Y
	lJEMLBxO9PL/6IftIOBTjQRAAVF769KHoosPxcaV2XtSMypYW5mgBpi8C3RDwClBRLKagiIpYCr
	Y5emo9vr8qFmYXHOTeEWYlg6Hnz7HZCI9q3xG2V+lPnL1X/0LgZRda4waGm++57ovi9UINX7nNh
	GMpNRvP/+/eZKWY8a0xr/4UUbj7A0MRDAGNb6l23bNSqQb8epOg125HwulxiWPeR2ddxN5wedGU
	AI
X-Google-Smtp-Source: AGHT+IHfK/YxWnxAyIXIhhMhxrwpBPWIhtUQlBAlwL0IaxEpVGMgxfc2H8XED61ydnCh6Xfhe0uFJA==
X-Received: by 2002:a05:6402:2111:b0:639:fb11:9935 with SMTP id 4fb4d7f45d1cf-63e60084063mr4098867a12.4.1761369368832;
        Fri, 24 Oct 2025 22:16:08 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-63e7efb9fa6sm826566a12.31.2025.10.24.22.16.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 22:16:08 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: safinaskar@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	andriy.shevchenko@linux.intel.com,
	chetan.kumar@mediatek.com,
	chris.feng@mediatek.com,
	hua.yang@mediatek.com,
	len.brown@intel.com,
	liang.lu@mediatek.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mario.limonciello@amd.com,
	pavel@ucw.cz,
	rafael@kernel.org,
	regressions@lists.linux.dev,
	stable@kernel.org,
	ting.wang@mediatek.com
Subject: Re: [REGRESSION][BISECTED] "Wakeup event detected during hibernation" on Dell Precision 7780 (was "[PATCH v4] PM: hibernate: Avoid missing wakeup events during hibernation")
Date: Sat, 25 Oct 2025 08:15:55 +0300
Message-ID: <20251025051555.422427-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251021125446.4384-1-safinaskar@gmail.com>
References: <20251021125446.4384-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Askar Safin <safinaskar@gmail.com>:
> This is "dmesg --level=debug+" on v6.18-rc2-with-1796f808e4bb-reverted:
> 
> https://zerobin.net/?0459f6411446622d#8i0Ifo6o68By3+UlYUr2t2KL7YLXsKEXrkfszpE77Rw=

This log contains WARNING. It is caused by unrelated bug, which is reproducible
both on real hardware and in Qemu. I reported it here:
https://lore.kernel.org/regressions/20251025050812.421905-1-safinaskar@gmail.com/

-- 
Askar Safin

