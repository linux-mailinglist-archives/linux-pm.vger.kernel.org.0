Return-Path: <linux-pm+bounces-17376-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7729C4E4E
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 06:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B3CF1F254EE
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 05:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0CA1A76D2;
	Tue, 12 Nov 2024 05:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEFO1OiM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDCF5234;
	Tue, 12 Nov 2024 05:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731389853; cv=none; b=j5q+l9AXViHdLN5V2Ttyu+ruDfMFqfk54elG4r2/kjJVUD5FFh6xVeo22YKy1+U6pMiPCMp5i8H6fWuedOh3qnFyuMGLGGfIGmQGshBpYwZT72/nZ9712G+5YWa2cUg95SdyzSnVirEbAPwtRBmP2Pmxptb76tBit6V8ECt2EPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731389853; c=relaxed/simple;
	bh=MLY+9xebS8Qvm95utVDwqhihCYA9Q8CO8K7xwHbtC8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OnkmA1x78YCpWaNTxPq17gc28NheQPLpsKmm/zPBAW3Ustg1MxnLdMJUkvIMHzKob0rpAyaVOF0QJ+niQ3v87fwxnZtz1hbxZTzFnk6/COSCJ+zU1b1fX08bmjukEzd/2w0wJ+DeUsxLCVSCqew8krG5f3VktMfEz+iovlnQ+CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VEFO1OiM; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6eca7391be2so2379087b3.2;
        Mon, 11 Nov 2024 21:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731389851; x=1731994651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9XZgi30oLwrRNWdlSlxnL8VG6FZXwUjV9JnnrWChTo=;
        b=VEFO1OiMb+lTT6JSU9UpZjLLVy0gaMjFtuK3hWzESCqLRh1FsqR2YDMSY11ovLt90m
         GMwFXyzR24ZX73caUutRsqgNVdUxw52FfgM2Alyq11zV1o1AGV9Iqt0NcT2CfFmVbeML
         NC2eHdsiDE+MYLVeOVY0xI91klG2zDZ25f/JEiUhciB1huS15N6MBFly/JNCxTN/yNTk
         wftWiHCEn4cgcu7VdJCjt/1jKbO0ci4OGaNd1WK5vFPsfBGgKq/Qbzn2AXqNd8gsAnZw
         6tY0OlTR88oFzBX7Z+b3xhxKIg+7Um5ygTtsqOupdve5f9u/BBh0GdCq2+PyAcDldMZe
         648g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731389851; x=1731994651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R9XZgi30oLwrRNWdlSlxnL8VG6FZXwUjV9JnnrWChTo=;
        b=m24K4JvAzAuFifyA7DD8UX2hjJuQWEkQfU8n33TGY3kbdFTPw0CWARBIwCI0KFNGFs
         MBec2fnYQyKJWvztBYzGz3KO51I2ontZm0FsRWXUZMmEtV/0fWrJZlxHTXL4D/YgaYCR
         UfboGtvMXuv4CLXO05TOIRFO8Me0I4clX9QUjr3cHloDzO81W942byoF+Hwojy3r1fmG
         1OyMT5B3KqE5WCyTRHCcHavGwnpYG0tjzrug9C4apq3CiKED7Cbc1HdPBxeTvebmD3Tg
         PK3/3Krr6S4bFIDLzKrNfFisJqMMDuTdf8BtlB8eJiIYImL5QaScWqrFg6xW6a1+qTlb
         9QvQ==
X-Forwarded-Encrypted: i=1; AJvYcCULeTWKKK1ccLT39NOcwESU1Z/iOQgxdqcYYxPtS1A5HDcTyAm6pS33y+Amu5OBOWlzzNilD+BG/a8=@vger.kernel.org, AJvYcCULm/O0JQ6eLz54TuxXBTNb9YLjMhWSRfkAMGFLnPuwcr3EuoEg5LHi9D+Fqd/zWje1XSjJ1xtKsxzRGyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEtl9lxsUt2jmak1ZcDH6HvVrGtYSX8hmeG9iFe3CcTIv6sg6u
	ueQOoTeFXtifQeIIo5+BGgQX06iJRgxRQVU2eeA8RK5E2qNW54ISLBWpPw==
X-Google-Smtp-Source: AGHT+IF+U2PdLisBSYiTlo1RZaivl06vKNEzgnFjmJBmUzyIjVsTVQjXsx5LkQYIPFh+03vyRtwUwg==
X-Received: by 2002:a05:690c:7403:b0:6ea:6f5b:cdd0 with SMTP id 00721157ae682-6eadddabab5mr141580617b3.19.1731389850766;
        Mon, 11 Nov 2024 21:37:30 -0800 (PST)
Received: from lenb-Thinkpad-T16-Gen-3.mynetworksettings.com ([2600:1006:a022:33ba:a725:c031:83c7:29cf])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eaceb7b3d5sm23846457b3.119.2024.11.11.21.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 21:37:30 -0800 (PST)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: peterz@infradead.org,
	tglx@linutronix.de,
	x86@kernel.org
Cc: rafael@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 0/1 v2] x86/cpu: Add INTEL_LUNARLAKE_M to X86_BUG_MONITOR
Date: Tue, 12 Nov 2024 00:28:25 -0500
Message-ID: <20241112053722.356303-1-lenb@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241111162316.GH22801@noisy.programming.kicks-ass.net>
References: <20241111162316.GH22801@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was folly to respond to review feedback by attempting to add bits
to the kexec path to this simple patch.  So that misguided hunk is removed.

Here is the 1-line patch that addresses the problem that users see
in the field today.

If kexec proves to be an issue on LNL, that can be addressed
in a subsequent patch.

thanks,
-Len


