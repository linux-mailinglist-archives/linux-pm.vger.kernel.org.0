Return-Path: <linux-pm+bounces-29248-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78154AE3493
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 06:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A40123ADB27
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 04:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAFEA95C;
	Mon, 23 Jun 2025 04:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GnyshR/M"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501BF2FB2
	for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 04:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750654757; cv=none; b=R7rbz3DAz11rAU73ohSMIt4i25UWsXtyZ/651fo5pNakQlX2ci0Xl5u9EWYtzA57itKUNVGqomzhEeQCkWF6/kbFkhjZOLhoQk3i/rUi9EN73AmKut/8xw6j8wW5rtSke69iW/rPSvXjFEt3OZtTzwAFsLtv6hDr3Rn/pTGUfEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750654757; c=relaxed/simple;
	bh=0FyxRfB9S1amdCXYnxAVn4IdWJYOv1mIybN5IWmMqHg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=PW7tVxeJvT5NqxQk/JqJpdnjeTz/bBr+C4QybH0418URVdNcleYFw9preyArlv9cPjkxtvEXrkI+euElU1YujIW0dLdlE4RXS5k1SoluGWo7/xoQLhS1xh8oKY3DPwKzvdADPhwUreo9nCA04LgN8if/hp3eBsgk2ssz8vZffEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GnyshR/M; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=0FyxRfB9S1amdCXYnxAVn4IdWJYOv1mIybN5IWmMqHg=; b=GnyshR/MgTz01kJgg34yWaXn5X
	sWFqAO6aEZmGvL3jlTJth5bA9SkckGY+KN6MC1aNKPEbeC+Is1gNEDcEblBgY0ueaUZ0NR2AT9BPI
	yDcxcXCcE4/2EmQYe7THzE+A19GbDi6yoO9tGx6AAt6JbZuW1NRDzpT71R/VM2LRYy67C2lPRjmxO
	HxC4bqFYxTZaea37h9TlUSvFSa/LGX6P2LmKDrxPLjVufk+89DYlSRJiy5x90LENI0EAgMc9ifRc9
	CveRnMBUuX5O/2keGWA1b+yIY6vbL9A9J5MwYBgnC+vJ6eOUr450fpte2khsFc4VDtsV50rFOCxjZ
	AvHhBcGQ==;
Received: from [2a00:23ee:2978:6058:13ae:23c4:6041:a218] (helo=[IPv6:::1])
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTZGg-000000058Ys-3uLV;
	Mon, 23 Jun 2025 04:58:57 +0000
Date: Mon, 23 Jun 2025 05:58:53 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Baoquan He <bhe@redhat.com>, Mario Limonciello <superm1@kernel.org>
CC: mario.limonciello@amd.com, rafael@kernel.org, len.brown@intel.com,
 pavel@kernel.org, gregkh@linuxfoundation.org, dakr@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, christian.koenig@amd.com,
 linux-pm@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH] PM: Restrict swap use to later in the suspend sequence
User-Agent: K-9 Mail for Android
In-Reply-To: <aFjIv5OqUyiSNrRi@MiWiFi-R3L-srv>
References: <20250613214413.4127087-1-superm1@kernel.org> <aFjIv5OqUyiSNrRi@MiWiFi-R3L-srv>
Message-ID: <F68C706A-4B73-442F-B8D7-C0AF35C0294A@infradead.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

On 23 June 2025 04:23:43 BST, Baoquan He <bhe@redhat=2Ecom> wrote:
>This change is inside KEXEC_JUMP scope, let David know this because he
>ever tested and made change for KEXEC_JUMP=2E
>=2E=2E=2E=2E=2E=2E

Thanks=2E I added a selftest in https://lore=2Ekernel=2Eorg/all/2025032614=
2404=2E256980-5-dwmw2@infradead=2Eorg

