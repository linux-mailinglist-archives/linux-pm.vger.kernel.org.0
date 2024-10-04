Return-Path: <linux-pm+bounces-15153-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE079905E4
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 16:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FD05B2377B
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 14:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6D2217300;
	Fri,  4 Oct 2024 14:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjiPKyH5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34709215F5D
	for <linux-pm@vger.kernel.org>; Fri,  4 Oct 2024 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728051715; cv=none; b=P0wpsiJdztczj6exVOjS5mMI/sU73Qhhh6F6oed4Ix67TedD18iDPYvJWRLZUKB5WlhG3jFQZXGfiqEd3Jz6iWb0k9zqaCj8bnbbxYXXdhtdDgrWYExjLJlvl+Itfe7O7jrEKXnhwKMFlxT7e7sBJ9H6pFxwg89DORjCcSxSkEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728051715; c=relaxed/simple;
	bh=aGtuSNyHXHa3AiDA1LvfxTDp7x3zICWhu5Tg6wwe45k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Uxd8PTUa5pF6Cgmlm5x+2F1AX4sZIKNXva30Uiqdf33VKqNCeuuxrKTX35hjYQeMWPd3z4SP5byzYNf8nn6T5H7PsYrXACCDt4OWYEkyZOfqmYZxbz4++0NiYjddpdASbg3m28EYM7EQ2AObDeo74UY2c8Yo1toLjuHijSnasA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjiPKyH5; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-287b8443affso641412fac.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Oct 2024 07:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728051713; x=1728656513; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aGtuSNyHXHa3AiDA1LvfxTDp7x3zICWhu5Tg6wwe45k=;
        b=jjiPKyH5M1soAUSuviJBZyz/KkI4XWjbpfCJe0zmGAk3EnS8K/OEp2+5CQhH0cpuae
         BA3oYPMZ4R8viE8ZPHPV0E8f0q8nm4KfgyvfcERwQ2pQtJXutdICu5KFBJTChzGheq/w
         g5U1t6t7R+8yr0JOZdlfQYjq2ACcAjRSwKujBPEKVoATJh5fBwrT2wcFD4XZtf0gnppB
         FUwATGFoXa1AFJG3opkPZ4MPb4zfSyI9UUCT3vDYyGY8UAkYYfiWYrid1cJ6IAfDOIzi
         KQDHfVM0CHYX83Ccz+JAY5pyj8S07MLX+Bnhh3NkU6MqG/OJpaIJFvj9Lk/kS5kS2+4a
         ZmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728051713; x=1728656513;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aGtuSNyHXHa3AiDA1LvfxTDp7x3zICWhu5Tg6wwe45k=;
        b=luCpbqDxFbeMpt28ecoaj92i/DlsH+bCItZMBvtMbo9nFftvq6vsT9QOKaWs3IsbAm
         E6DwnRA7Jx3uvZVwKZxLLT7IAGFds1IlEpQmw2slKVoIKjmA3MU2PsL9Vj7PVNEPfb5l
         pxNdIEowZgHDrAspV87Jo8ajJHWEPy6Tdvl2+BEBqU56KgoPPV2wWTbl3XSZTZKl+Pu/
         Cwq6Z420BL8Yjr7CAAYtMIABUqWz0BPReC99g/lW3t6zAKqr16ltcV2OCqZbO+Qe8LHT
         WSmoVYbYps2eTTL69mNBkL5SYC8bziDkBBT9gS6UhXaCJuUm1E0NCfptWEPlSzZS1FBK
         Nodg==
X-Gm-Message-State: AOJu0YztRRb465f+DUWJrfdzBPkbr3RTFq5y3QwkLGE/TQCZmnhDfPjb
	CkYt1SEae3mpl4YEoogIy7M/ZCin+p6Jm0SyFaNKUMxuTWOZcuWuIooZW5SA1FMXrrGPsHo40pt
	fUvka0z9ety85WUJDd7OnM8VWVggVEg==
X-Google-Smtp-Source: AGHT+IGuULZKBhBCRmE3cTBM/ZpqgWYEZbWu25RKJBtWyjkIr0AzROtEzTXOghmSVDyZdOncrRlFxMLsjFQwwUih7qs=
X-Received: by 2002:a05:6870:ac29:b0:278:986:1e44 with SMTP id
 586e51a60fabf-287c1da9eafmr1909115fac.18.1728051712912; Fri, 04 Oct 2024
 07:21:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Darrion Ramos <darrionramos@gmail.com>
Date: Fri, 4 Oct 2024 10:21:41 -0400
Message-ID: <CAE=33HW51jO-9g7nLKLros9=up5ziYsYJyoUKyW+0=vF-76QNQ@mail.gmail.com>
Subject: Question on Obtaining Suspend Code Coverage After Crashes
To: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello, my group is conducting some research into the kernel power
management systems and related driver interactions. We are interested
in reproducing some of the PM bugs within the drivers such as how
interrupt handlers interfere with suspend/sleep events.

To accomplish this, we would like to identify what PM and USB/HID
driver code was last executed if the machine cannot resume from a
suspend to ram. This way we would be able to capture some information
about the context of execution.

I am assuming that during the development of the suspend features
there was some way to recover a trace of the code after a failure. Is
there any such tool that we could leverage? Or were there very
specific development setups for this?

I have looked through the provided power management documentation but
have not found any suitable tool. Additionally, note that we would
like to use a VM to preserve kernel integrity between tests. We
appreciate your time and any tools or feedback you can provide,
thanks.

